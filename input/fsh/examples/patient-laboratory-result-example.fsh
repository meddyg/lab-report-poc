// ==============================================================================================================
// Instance: Ejemplo de Paciente para Resultados de Laboratorio
// Basado en: CRPatientLaboratoryResult
// ==============================================================================================================

Instance: PatientLaboratoryResultExample
InstanceOf: CRPatientLaboratoryResult
Title: "Paciente para Resultados de Laboratorio"
Description: "Ejemplo de un recurso Patient para representación de PoC resultados de laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Paciente de referencia para ejemplos de resultados de laboratorio.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-nacional "Cédula Nacional"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/CodeSystem/cr-identifier-type"
  * value = "1234567890"

* name
  * use = #official
  * given[0] = "Esteba"         // primerNombre (obligatorio)
  * given[1] = "Francisco"      // segundoNombre (opcional)
  * family = "Alvarado"         // primerApellido (obligatorio)
  * family.extension[SecondSurname].valueString = "de la O"  // segundoApellido (opcional)

* birthDate = "1980-05-15"

* gender = #male
