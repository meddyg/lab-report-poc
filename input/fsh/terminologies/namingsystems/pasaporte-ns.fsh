// ==============================================================================================================
// NamingSystem: Pasaporte
// ==============================================================================================================

Instance: PasaporteCRNamingSystem
InstanceOf: NamingSystem
Usage: #definition

* name = "PasaporteCRNamingSystem"
* title = "Pasaporte"
* status = #active
* kind = #identifier
* date = "2026-05-14"
* publisher = "MEDDYG"
* description = "Namespace URI para los identificadores de pasaporte usados en el contexto del PoC de resultados de laboratorio de Costa Rica. Usar en Identifier.system; el tipo de identificador va en Identifier.type usando CRIdentifierTypeCodes#pasaporte."
* jurisdiction = urn:iso:std:iso:3166#CR
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.meddyg.com/fhir/laboratory-results/sid/pasaporte"
* uniqueId[0].preferred = true
