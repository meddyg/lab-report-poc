// ==============================================================================================================
// Instance: Ejemplo de Profesional de Salud para Resultados de Laboratorio
// Basado en: CRPractitionerLaboratoryResult
// ==============================================================================================================

Instance: PractitionerLaboratoryResultExample
InstanceOf: CRPractitionerLaboratoryResult
Title: "Profesional de Salud para Resultados de Laboratorio"
Description: "Ejemplo de un recurso Practitioner para representación de PoC resultados de laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Profesional de salud responsable de la validación y reporte de laboratorio.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-nacional "Cédula Nacional"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/CodeSystem/cr-identifier-type"
  * value = "1234567890"

* name
  * use = #official
  * given[0] = "María"          // primerNombre (obligatorio)
  * given[1] = "José"           // segundoNombre (opcional)
  * family = "Ramírez"          // primerApellido (obligatorio)
  * family.extension[SecondSurname].valueString = "López"  // segundoApellido (opcional)

* gender = #female
