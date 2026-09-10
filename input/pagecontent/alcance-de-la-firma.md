# Alcance de la firma digital

Esta página documenta **qué protege exactamente la firma de GAUDÍ sobre un documento
FHIR y qué no**, cómo se estableció, y por qué esta guía perfila el documento como lo
hace.

Es la justificación normativa de varias decisiones en `CRBundleLaboratoryResult` y
`CRCompositionLaboratoryResult`. Quien vaya a firmar o a verificar documentos necesita
leerla antes de escribir código: **hay campos que parecen protegidos y no lo están.**

---

## El resultado, en una tabla

Se tomó un documento real sellado y firmado por GAUDÍ, se alteró **un solo campo cada
vez**, y se le pidió veredicto al validador de documentos del BCCR.

| Qué se alteró | Veredicto de GAUDÍ |
| --- | --- |
| Valor de una `Observation` | **0 — inválido** |
| Apellido del `Patient` | **0 — inválido** |
| Una `Observation` eliminada del documento | **0 — inválido** |
| `Composition.identifier` | **0 — inválido** |
| `meta.security` agregado a la `Composition` | **0 — inválido** |
| `entry.fullUrl` de una entrada | **0 — inválido** |
| `Bundle.identifier` | 2 — válido |
| `Bundle.type`, de `document` a `collection` | 2 — válido |
| `Bundle.timestamp` | 2 — válido |
| `Bundle.id` | 2 — válido |
| `meta.profile` de la raíz | 2 — válido |
| `meta.security` de la raíz | 2 — válido |
| `meta` de la raíz eliminado por completo | 2 — válido |

**La firma cubre todo lo que está dentro de `Bundle.entry`** — cada recurso, el `meta`
de cada recurso, y hasta el `fullUrl` de cada entrada. **No cubre el sobre del
`Bundle`**: ni `id`, ni `identifier`, ni `type`, ni `timestamp`, ni el `meta` de la raíz.

Dos consecuencias más, medidas aparte:

- **El espaciado y el orden de las claves del nivel raíz no importan.** El orden de las
  claves anidadas sí. La forma que verifica es la canónica, con las propiedades ordenadas
  alfabéticamente dentro de cada objeto — que es lo que ya define
  `http://hl7.org/fhir/canonicalization/json`.
- **Un documento firmado sobrevive el almacenamiento en un servidor FHIR.** El servidor
  reserializa y reescribe `meta.versionId` y `meta.lastUpdated`, y el documento vuelve a
  verificar si se canonicaliza antes de consultar al validador.

---

## Por qué es así

No es un defecto de GAUDÍ. Es el patrón que HL7 llama **firma de documentación**, en
contraste con la **firma de integridad**:

| Tipo de firma | Qué firma | ¿Sobrevive al movimiento? |
| --- | --- | --- |
| Integridad | todo, lo inmutable y lo mutable | No. Vale para un solo tránsito |
| Documentación | solo la información inmutable | Sí, por diseño |

Un servidor FHIR reescribe `meta.versionId` y `meta.lastUpdated` en cada guardado. Una
firma que los cubriera se rompería con solo almacenar el documento. Excluirlos no es una
omisión: **es lo que permite que la firma sobreviva.**

La especificación de FHIR define métodos de canonicalización para esto —
`http://hl7.org/fhir/canonicalization/json` y sus variantes `#data`, `#static`,
`#narrative` y `#document` — pero deja dos huecos que esta guía tiene que llenar:

1. **Ningún campo de `Signature` declara qué método se usó.** El acuerdo tiene que ser
   fuera de banda, y esta guía es ese lugar.
2. **La especificación advierte que sus métodos no sirven para firmas enveloped**, que es
   justamente el arreglo de `Bundle.signature`: *"These canonicalization algorithms do
   not work for enveloped signatures. This will be researched and addressed in a future
   release."*

El alcance de GAUDÍ está cerca de `#document`, que excluye `Bundle.id` y el `meta` de la
raíz, pero excluye además `identifier`, `type` y `timestamp`.

---

## Qué exige esta guía, y para qué

No se puede hacer que la firma cubra el sobre. Lo que sí se puede es **exigir que el
sobre repita información que sí está firmada, de modo que alterarlo produzca una
contradicción detectable.** Ese es el criterio detrás de cada regla.

### `Composition.attester` es obligatorio

`Signature.who`, `Signature.when` y `Signature.type` viven dentro de `Bundle.signature`,
o sea en el sobre: **no están cubiertos por la firma y son alterables sin invalidarla.**
Un consumidor que lea `Signature.who` está leyendo un campo sin respaldo criptográfico.

`Composition.attester` está dentro de `entry[]` y sí está protegido. Es el único lugar
donde la declaración de quién responde por el documento tiene valor probatorio a nivel de
recurso FHIR. La verdad criptográfica sigue estando en el certificado dentro de
`signature.data`; `attester` es lo que la hace legible sin abrir el objeto JOSE.

Por la misma razón, `signature.type`, `.when` y `.who` **dejaron de ser obligatorios** en
`CRBundleLaboratoryResult`. Exigirlos invitaba a apoyarse en campos sin respaldo.

### `Bundle.identifier` debe coincidir con `Composition.identifier`

Invariante **`CRBundleIdentMatch1`**. La especificación base describe `Bundle.identifier`
como un identificador que no cambia al copiarse de servidor a servidor, pero queda fuera
de la firma. Sin esta regla, un conjunto de resultados firmado se puede re-etiquetar como
otro documento sin que nada lo delate. Con ella, la copia firmada lo desmiente.

### Un documento firmado debe declarar su atestación

Invariante **`CRBundleAttester1`**: si hay `signature`, tiene que haber
`Composition.attester`.

### La fecha autoritativa es `Composition.date`

`Bundle.timestamp` se exige presente porque registra cuándo se ensambló el Bundle, pero
no está firmado. La fecha del documento es `Composition.date`. La fecha con respaldo
criptográfico del acto de firma es el sello de tiempo RFC 3161 que viaja dentro de
`signature.data`.

### La confidencialidad va en `Composition.meta.security`

FHIR R5 eliminó `Composition.confidentiality`, así que `meta.security` es la única
ubicación que da la especificación. El `meta` de la raíz del `Bundle` **no está firmado**:
una etiqueta de confidencialidad puesta ahí se puede quitar sin dejar rastro. El `meta` de
la `Composition` sí está cubierto, y es donde debe declararse.

### `sigFormat` es `application/jose+json`

Invariante **`CRBundleJAdESSigFormat1`**, que antes admitía también `application/jose`.
GAUDÍ emite la serialización JSON de JOSE. Declarar `application/jose` hace que los
validadores intenten leerla como serialización compacta y fallen con un error que no
significa nada sobre la validez de la firma.

### Un documento firmado se reenvía textual

`entry.fullUrl` está cubierto por la firma. Un sistema receptor que reapunte esas URL a
copias locales de los recursos **invalida el documento**. Si necesita republicarlo, debe
conservarlo tal cual o contrafirmar el resultado; nunca reescribirlo en silencio.

---

## Lista de comprobación

Al **producir** un documento firmado:

- [ ] La `Composition` es la primera entrada y conforma a `CRCompositionLaboratoryResult`.
- [ ] `Composition.identifier` está presente y `Bundle.identifier` es su copia.
- [ ] `Composition.attester` declara quién responde, con `mode`, `party` y `time`.
- [ ] La confidencialidad, si aplica, está en `Composition.meta.security`.
- [ ] `Composition.date` es la fecha del documento; `Bundle.timestamp`, la de ensamblado.
- [ ] `signature.sigFormat` es `application/jose+json`.
- [ ] Se conservan los bytes canónicos del documento firmado.

Al **verificar** un documento recibido:

- [ ] Se canonicaliza antes de consultar al validador, o se usan los bytes originales.
- [ ] Se comprueba que `Bundle.identifier` coincida con `Composition.identifier`.
- [ ] Se valida contra el perfil que se **espera**, no contra el que `meta.profile`
      **declara**: ese campo no está firmado.
- [ ] No se trata `Signature.who` ni `Signature.when` como evidencia.
- [ ] Un veredicto que no se pudo obtener **no** es un documento válido. Son tres
      estados: firma válida, firma inválida, y no se pudo comprobar. Tratar el tercero
      como el primero es el error más grave que se puede cometer aquí.

Lo que **no** se debe hacer:

- Reapuntar referencias o `fullUrl` de un documento firmado.
- Guardar la confidencialidad solo en el `meta` de la raíz.
- Reconstruir el payload de la firma para verificarla localmente: no es reproducible sin
  que el BCCR publique cómo lo construye.

---

## Riesgo que queda

Con todas las reglas aplicadas, `Bundle.type` y el `meta.profile` de la raíz siguen sin
firmar. `type` se detecta por cruce: si dice `collection` pero hay una `Composition`
documental adentro, algo está mal. `meta.profile` no se detecta, y por eso la regla es
validar contra el perfil esperado.

Y hay un riesgo de horizonte largo: si el BCCR cambia su canonicalización, los documentos
firmados hoy podrían dejar de verificar mañana. Conservar los bytes canónicos es el seguro
contra un cambio que no controlamos, en registros que deben durar décadas.

---

## Cómo reproducir estas mediciones

Cada fila de la primera tabla se obtuvo así:

1. Partir de un documento sellado y firmado por GAUDÍ.
2. Alterar exactamente un campo.
3. Canonicalizar el resultado con las propiedades ordenadas alfabéticamente de forma
   recursiva.
4. Enviarlo al validador de documentos del BCCR, en base64 como cuerpo JSON desnudo.
5. Leer `resumen.resultadoValidacionDelDocumentoFirmado`: 1 y 2 son aceptables, cualquier
   otro valor significa que la firma no verificó.

Las mediciones se hicieron el 2026-09-09 contra el ambiente de producción. El ambiente de
pruebas no sirve para esto: su validador responde 404.

---

## Pendientes

**Con el BCCR**, dos pedidos concretos:

- Que el conjunto inmutable incluya `Bundle.identifier` y `Bundle.type`. El primero está
  descrito por la especificación como persistente al copiarse entre servidores, así que es
  inmutable por definición y debería estar firmado.
- Que publiquen el alcance en la cabecera protegida del JOSE. JAdES define `sigD`
  exactamente para eso, y hoy el alcance solo se descubre midiendo.

**Con HL7**: que `Signature` pueda declarar qué canonicalización se usó, y que el caso
enveloped quede definido. Sin lo primero, los cinco métodos que la especificación define
no son verificables por un tercero.
