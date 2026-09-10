# Resultados de Laboratorio — HL7 FHIR Costa Rica (PoC Meddyg)

Guía de implementación `hl7.fhir.cr.meddyg.laboratory-results`. Define los perfiles,
extensiones, terminologías y ejemplos para el intercambio de resultados de
laboratorio clínico, con firma digital JAdES a través de GAUDÍ.

## Cómo compilar

**Siempre dentro del contenedor `igs-cr`, y de a una corrida a la vez.**

```bash
docker exec -w /ig/laboratory-result-test.git igs-cr bash _genonce.sh
```

Las dos condiciones son por experiencia, no por gusto:

- **Dentro del contenedor**, porque el IG Publisher necesita `jekyll`, `ruby`, `java`
  y `sushi`, y `igs-cr` es el único entorno de esta máquina que los tiene los cuatro.
  Corriéndolo desde el host, el publisher valida bien y muere al generar el HTML.
- **De a una**, porque `_genonce.sh` limpia `output/` y `temp/` al arrancar. Dos
  corridas simultáneas se borran los archivos entre sí mientras los escriben, y las
  dos fallan con `NoSuchFileException` sobre archivos que la otra acaba de eliminar.

Y una advertencia que vale la pena conocer antes de invocarlo: **el script no es
idempotente ante un fallo.** Limpia el `output/` anterior antes de empezar, así que
una corrida interrumpida deja el proyecto sin el build viejo y sin el nuevo. Si el
paquete anterior importa, respaldarlo primero.

Para solo regenerar los recursos FHIR, sin HTML ni validación, alcanza con SUSHI, que
sí corre en el host:

```bash
sushi .
```

## Estructura

```
input/fsh/profiles/        perfiles de Bundle, Composition, DiagnosticReport, Observation y demás
input/fsh/extensions/      extensiones propias
input/fsh/terminologies/   ValueSets, CodeSystems y NamingSystems
input/fsh/examples/        instancias de ejemplo
input/fsh/logicals/        modelos lógicos de la captura
input/pagecontent/         páginas narrativas de la guía
```

## Páginas que conviene leer antes de implementar

- **Alcance de la firma digital** (`input/pagecontent/alcance-de-la-firma.md`) —
  qué protege exactamente la firma de GAUDÍ y qué no, medido contra el validador de
  producción, y por qué el documento se perfila como se perfila. Hay campos del
  `Bundle` que parecen protegidos y no lo están.
- **Sellado y firma con GAUDÍ** (`input/pagecontent/gaudi-sealing.md`) — la
  estructura de un documento firmable.
- **Seguridad y trazabilidad** — el modelo de `Provenance` y `AuditEvent`.

## Estado del QA

Última compilación verificada: 0 errores, 7 advertencias, 1 enlace roto.

Las 7 advertencias que quedan no son defectos del contenido: cinco piden asignar OID
a los ValueSets y CodeSystems para uso con terminologías basadas en OID, como CDA, y
dos son un timeout transitorio del servidor de terminología al validar un código.

Asignar los OID requiere decidir una raíz que la organización realmente controle, así
que es una decisión de gobernanza y no un arreglo técnico. El publisher lo configura
con el parámetro `auto-oid-root`.
