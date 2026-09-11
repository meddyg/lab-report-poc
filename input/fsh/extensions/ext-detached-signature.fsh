Extension: CRDetachedSignaturePayloadHash
Id: cr-detached-signature-payload-hash
Title: "Hash del payload de firma detached"
Description: "SHA-256 en hexadecimal del Bundle de trabajo canonico que se envio a GAUDI. Permite detectar que una firma detached no corresponde al Bundle objetivo."
* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-detached-signature-payload-hash"
* ^version = "0.3.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR
* ^context[0].type = #element
* ^context[0].expression = "Provenance"
* value[x] only string
* valueString 1..1

Extension: CRDetachedSignatureCanonicalization
Id: cr-detached-signature-canonicalization
Title: "Canonicalizacion de firma detached"
Description: "Identificador del algoritmo de canonicalizacion aplicado al Bundle de trabajo antes de enviarlo a GAUDI."
* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-detached-signature-canonicalization"
* ^version = "0.3.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR
* ^context[0].type = #element
* ^context[0].expression = "Provenance"
* value[x] only string
* valueString 1..1
* valueString = "JCS RFC 8785"
