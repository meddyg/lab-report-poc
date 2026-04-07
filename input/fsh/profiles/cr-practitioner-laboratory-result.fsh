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
  * ^short = "Identificadores del profesional"
  * ^definition = "Identificadores que permiten reconocer al profesional de salud responsable de validar, firmar, revisar o emitir el resultado de laboratorio dentro del PoC de HbA1c en Costa Rica."
  * type 1..1 MS
    * ^short = "Tipo de identificador del profesional"
    * ^definition = "Categoriza el identificador del profesional, por ejemplo cédula, licencia o identificador institucional, permitiendo a los sistemas interoperar con claridad sobre la naturaleza de la credencial reportada."
  * type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-identifier-types (required)
  * system 1..1 MS
    * ^short = "Sistema del identificador profesional"
    * ^definition = "Namespace o URI de la autoridad emisora del identificador del profesional. Sirve para diferenciar identificadores nacionales, institucionales o locales dentro del ecosistema costarricense."
  * value 1..1 MS
    * ^short = "Identificador del profesional"
    * ^definition = "Identificador único del profesional de salud, utilizado para su identificación en el sistema de salud."

// Nombre del profesional (primerNombre, segundoNombre, primerApellido, segundoApellido del modelo lógico)
* name 1..1 MS
  * ^short = "Nombre del profesional de salud"
  * ^definition = "Nombre oficial del profesional que participa en la generación, validación o interpretación del resultado de laboratorio, utilizado para presentación clínica, trazabilidad y auditoría del PoC."
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "use"
  * ^slicing.rules = #open
  * use = #official
    * ^short = "Nombre oficial del profesional"
    * ^definition = "Indica que el nombre reportado corresponde al nombre oficial con el cual el profesional debe figurar en el documento clínico o en el intercambio del resultado."
  * given 1..2 MS
    * ^short = "Nombres del profesional"
    * ^definition = "Primer nombre (obligatorio) y segundo nombre (opcional) del profesional de salud."
  * family 1..1 MS
    * ^short = "Primer apellido del profesional"
    * ^definition = "Primer apellido obligatorio del profesional de salud, mapeado de primerApellido del modelo lógico. El segundo apellido puede representarse usando la extensión SecondSurname."

// Sexo (sexo del modelo lógico)
* gender 1..1 MS
  * ^short = "Sexo del profesional"
  * ^definition = "Sexo administrativo del profesional de salud según FHIR. Se incluye para mantener consistencia con el perfil base y apoyar interoperabilidad demográfica cuando sea requerida por sistemas consumidores."
* gender from http://hl7.org/fhir/ValueSet/administrative-gender (required)
