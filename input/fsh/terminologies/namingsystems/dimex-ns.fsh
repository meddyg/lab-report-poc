// ==============================================================================================================
// NamingSystem: DIMEX - Documento de Identificación Migratorio para Extranjeros
// ==============================================================================================================

Instance: DIMEXCRNamingSystem
InstanceOf: NamingSystem
Usage: #definition

* name = "DIMEXCRNamingSystem"
* title = "DIMEX - Documento de Identificación Migratorio para Extranjeros"
* status = #active
* kind = #identifier
* date = "2026-05-14"
* publisher = "MEDDYG"
* description = "Namespace URI para los identificadores DIMEX emitidos por la Dirección General de Migración y Extranjería de Costa Rica. Usar en Identifier.system; el tipo de identificador va en Identifier.type usando CRIdentifierTypeCodes#dimex."
* jurisdiction = urn:iso:std:iso:3166#CR
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.meddyg.com/fhir/laboratory-results/sid/dimex"
* uniqueId[0].preferred = true
