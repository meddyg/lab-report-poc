// ==============================================================================================================
// Profile: Paciente para Resultados de Laboratorio
// Basado en: LogicalModelPatientLaboratoryResult
// ==============================================================================================================

Profile: CRPatientLaboratoryResult
Parent: Patient
Id: cr-patient-laboratory-result
Title: "Patient - Resultados de Laboratorio"
Description: "Perfil de paciente que define los datos del paciente necesarios para representar resultados de laboratorio, basado en el modelo lógico LogicalModelPatientLaboratoryResult y el perfil de paciente del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-patient-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// Identificadores del paciente (tipoIdentificador + identificacion del modelo lógico)
* identifier 1..* MS
  * type 1..1 MS
    * ^short = "Tipo de identificador del paciente"
  * type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-identifier-types (required)
  * system 1..1 MS
  * value 1..1 MS
    * ^short = "Identificador del paciente"
    * ^definition = "Identificador único del paciente, utilizado para su identificación en el sistema de salud."

// Nombre del paciente (primerNombre, segundoNombre, primerApellido, segundoApellido del modelo lógico)
* name 1..1 MS
  * ^short = "Nombre del paciente"
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "use"
  * ^slicing.rules = #open
  * use = #official
  * given 1..2 MS
    * ^short = "Nombres del paciente"
    * ^definition = "Primer nombre (obligatorio) y segundo nombre (opcional) del paciente."
  * family 1..1 MS
    * ^short = "Primer apellido del paciente"
    * ^definition = "Primer apellido obligatorio del paciente, mapeado de primerApellido del modelo lógico. El segundo apellido puede representarse usando la extensión SecondSurname."

// Fecha de nacimiento (fechaNacimiento del modelo lógico)
* birthDate 1..1 MS
  * ^short = "Fecha de nacimiento del paciente"
  * ^definition = "La fecha de nacimiento del paciente, utilizada para calcular la edad y otros datos demográficos."

// Sexo (sexo del modelo lógico)
* gender 1..1 MS
  * ^short = "Sexo del paciente"
* gender from http://hl7.org/fhir/ValueSet/administrative-gender (required)

// Elementos que no se incluyen en el perfil pero que pueden ser relevantes para resultados de laboratorio:
* deceased[x] 0..0
* link 0..0