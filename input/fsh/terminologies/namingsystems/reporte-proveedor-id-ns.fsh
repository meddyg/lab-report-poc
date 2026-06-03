// ==============================================================================================================
// NamingSystem: Identificador de Reporte Proveedor
// ==============================================================================================================

Instance: ReporteProveedorIdentifierNamingSystem
InstanceOf: NamingSystem
Usage: #definition

* name = "ReporteProveedorIdentifierNamingSystem"
* status = #active
* kind = #identifier
* date = "2026-05-22"
* publisher = "Meddyg"
* description = "URI de sistema para el identificador de reporte asignado por el proveedor de laboratorio."

* uniqueId[0].type = #uri
* uniqueId[0].value = "https://hl7.meddyg.com/fhir/laboratory-results/sid/reporte-proveedor"
* uniqueId[0].preferred = true
