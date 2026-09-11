# Alcance de la firma digital

## Decisión de implementación

Esta guía adopta la firma digital **detached** para los Bundle document de
resultados de laboratorio. La decisión sigue la opción de firma detached del
perfil IHE Document Digital Signature (DSG): el contenido clínico y la evidencia
criptográfica se gestionan como artefactos separados, sin modificar el documento
original.

La referencia de IHE DSG está disponible en
https://profiles.ihe.net/ITI/TF/Volume1/ch-37.html.

## Artefactos intercambiados

Un documento firmado se compone de dos recursos FHIR relacionados:

1. Un `Bundle` document conforme a `CRBundleLaboratoryResult`, sin
   `Bundle.signature`.
2. Un `Provenance` conforme a
   `CRDetachedSignatureProvenanceLaboratoryResult`, que contiene la firma JAdES
   emitida por GAUDÍ/BCCR.

El `Provenance.target` debe referenciar una versión específica del Bundle:

```text
Bundle/{id}/_history/{versionId}
```

La referencia versionada hace inequívoca la evidencia criptográfica. Una firma
no se interpreta como aplicable a versiones posteriores ni a otro Bundle con el
mismo contenido.

## Reglas para productores y custodios

- El productor valida el Bundle contra esta IG antes de persistirlo.
- El custodio crea el Bundle como recurso clínico inmutable y conserva su versión
  inicial como objetivo de la firma.
- La firma JAdES se registra en `Provenance.signature`; no se inserta ni se
  reemplaza dentro del Bundle persistido.
- El `Provenance` declara el firmante, el propósito, el formato
  `application/jose+json`, el hash del payload de firma y la canonicalización
  requerida por la política CR.
- Una corrección clínica crea un nuevo Bundle document y, cuando corresponda, una
  nueva evidencia de firma detached. No se modifica el Bundle ya firmado.

GAUDÍ puede requerir un Bundle de trabajo para aplicar o verificar JAdES. Ese
artefacto es transitorio: se utiliza para la interacción con BCCR y no reemplaza
el Bundle clínico ni la evidencia detached almacenada por el custodio.

## Reglas para consumidores

El custodio entrega el Bundle junto con el o los `Provenance` de firma que lo
referencian. Un consumidor debe:

1. validar ambos recursos contra los perfiles CR esperados;
2. comprobar que el `Provenance.target` identifica exactamente la versión del
   Bundle recibida;
3. verificar la firma JAdES mediante el servicio de verificación autorizado;
4. usar el contenido clínico para decisiones solo cuando la verificación resulte
   satisfactoria.

`$validate` comprueba la conformidad FHIR y de la IG. La validez criptográfica
de la firma JAdES se determina mediante la verificación correspondiente de
GAUDÍ/BCCR.

## Consideraciones para perfiladores

Los mantenedores de esta IG deben conservar estas garantías al evolucionarla:

- mantener separados el perfil del Bundle clínico y el perfil de evidencia
  detached;
- conservar la referencia versionada desde `Provenance.target`;
- publicar cualquier cambio de política de firma, canonicalización o algoritmo
  con una versión nueva y documentación de migración;
- validar los perfiles y ejemplos contra el Publisher antes de publicar una nueva
  versión;
- revisar periódicamente la compatibilidad con IHE DSG, FHIR y las normas
  vigentes de GAUDÍ/BCCR.
