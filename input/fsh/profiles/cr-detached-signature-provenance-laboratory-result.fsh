Invariant: CRDetachedSignatureTargetVersion1
Description: "Cada firma detached debe apuntar a una version concreta del Bundle document."
Severity: #error
Expression: "target.all(reference.matches('^((https?://[^/]+(/[^/]+)*)/)?Bundle/[^/]+/_history/[^/]+$'))"

Profile: CRDetachedSignatureProvenanceLaboratoryResult
Parent: Provenance
Id: cr-detached-signature-provenance-laboratory-result
Title: "Provenance de Firma Detached de Resultado de Laboratorio"
Description: "Evidencia criptografica JAdES emitida por GAUDI para una version inmutable de CRBundleLaboratoryResult."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-detached-signature-provenance-laboratory-result"
* ^version = "0.3.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR
* obeys CRDetachedSignatureTargetVersion1

* target 1..* MS
* target only Reference(CRBundleLaboratoryResult)
* target ^short = "Version del Bundle document cubierta por la firma"
* target ^definition = "Referencia versionada al Bundle document inmutable que se uso para reconstruir el Bundle de trabajo enviado a GAUDI."

* recorded 1..1 MS
* recorded ^short = "Registro de la evidencia de firma"

* agent 1..* MS
* agent ^short = "Participantes de la cadena de custodia"

* signature 1..* MS
* signature ^short = "Firma JAdES detached emitida por GAUDI"
* signature ^definition = "La firma se almacena fuera del Bundle clinico. Para verificarla se reconstruye el Bundle de trabajo con el target y esta Signature, se canonicaliza y se consulta al validador de BCCR."
* signature.type 1..* MS
* signature.when 1..1 MS
* signature.who 1..1 MS
* signature.targetFormat 1..1 MS
* signature.targetFormat = #application/fhir+json
* signature.sigFormat 1..1 MS
* signature.sigFormat = #application/jose+json
* signature.data 1..1 MS

* extension contains
    CRDetachedSignaturePayloadHash named payloadHash 1..1 MS and
    CRDetachedSignatureCanonicalization named canonicalization 1..1 MS
