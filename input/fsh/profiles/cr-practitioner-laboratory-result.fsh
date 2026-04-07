// ==============================================================================================================
// Profile: Profesional de Salud para Resultados de Laboratorio
// Basado en: LogicalModelPractitionerLaboratoryResult
// ==============================================================================================================

Profile: CRPractitionerLaboratoryResult
Parent: Practitioner
Id: cr-practitioner-laboratory-result
Title: "Practitioner - Resultados de Laboratorio"
Description: "Perfil de profesional de salud que define los datos del profesional necesarios para representar resultados de laboratorio, basado en el modelo lógico LogicalModelPractitionerLaboratoryResult y el perfil de practitioner del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-practitioner-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// Identificadores del profesional (tipoIdentificador + identificacion del modelo lógico)
* identifier 1..* MS
  * type 1..1 MS
    * ^short = "Tipo de identificador del profesional"
  * type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-identifier-types (required)
  * system 1..1 MS
  * value 1..1 MS
    * ^short = "Identificador del profesional"
    * ^definition = "Identificador único del profesional de salud, utilizado para su identificación en el sistema de salud."

// Nombre del profesional (primerNombre, segundoNombre, primerApellido, segundoApellido del modelo lógico)
* name 1..1 MS
  * ^short = "Nombre del profesional de salud"
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "use"
  * ^slicing.rules = #open
  * use = #official
  * given 1..2 MS
    * ^short = "Nombres del profesional"
    * ^definition = "Primer nombre (obligatorio) y segundo nombre (opcional) del profesional de salud."
  * family 1..1 MS
    * ^short = "Primer apellido del profesional"
    * ^definition = "Primer apellido obligatorio del profesional de salud, mapeado de primerApellido del modelo lógico. El segundo apellido puede representarse usando la extensión SecondSurname."

// Sexo (sexo del modelo lógico)
* gender 1..1 MS
  * ^short = "Sexo del profesional"
* gender from http://hl7.org/fhir/ValueSet/administrative-gender (required)
