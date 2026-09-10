// ==============================================================================================================
// NamingSystem: Identificador de Documento Clinico
// ==============================================================================================================

Instance: DocumentoClinicoIdentifierNamingSystem
InstanceOf: NamingSystem
Usage: #definition

* name = "DocumentoClinicoIdentifierNamingSystem"
* version = "0.3.0"
* status = #active
* kind = #identifier
* date = "2026-09-09"
* publisher = "Meddyg"
* description = "URI de sistema para el identificador del documento clinico, en Composition.identifier y su copia en Bundle.identifier. Es un sistema propio y no urn:ietf:rfc:3986 porque el consecutivo que asigna el laboratorio no es un URI completo. Y no comparte el de reporte-proveedor porque un documento y el reporte que contiene son cosas distintas: el mismo reporte puede emitirse en dos documentos."

* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.meddyg.com/fhir/laboratory-results/sid/documento-clinico"
* uniqueId[0].preferred = true
