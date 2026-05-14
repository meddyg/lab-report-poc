// ==============================================================================================================
// NamingSystem: Cédula Nacional de Costa Rica
// ==============================================================================================================

Instance: CedulaNacionalCRNamingSystem
InstanceOf: NamingSystem
Usage: #definition

* name = "CedulaNacionalCRNamingSystem"
* title = "Cédula Nacional de Costa Rica"
* status = #active
* kind = #identifier
* date = "2026-05-14"
* publisher = "MEDDYG"
* description = "Namespace URI para los identificadores de cédula nacional emitidos por el Registro Civil de Costa Rica. Usar en Identifier.system; el tipo de identificador va en Identifier.type usando CRIdentifierTypeCodes#cedula-nacional."
* jurisdiction = urn:iso:std:iso:3166#CR
* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.meddyg.com/fhir/laboratory-results/sid/cedula-nacional"
* uniqueId[0].preferred = true
