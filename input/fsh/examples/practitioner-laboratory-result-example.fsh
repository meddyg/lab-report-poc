// ==============================================================================================================
// Instance: Ejemplo de Profesional de Salud para Resultados de Laboratorio
// Basado en: CRPractitionerLaboratoryResult
// ==============================================================================================================

Instance: PractitionerLaboratoryResultExample
InstanceOf: CRPractitionerLaboratoryResult
Title: "Profesional de Salud para Resultados de Laboratorio"
Description: "Ejemplo de un recurso Practitioner para representación de PoC resultados de laboratorio."
Usage: #example

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
