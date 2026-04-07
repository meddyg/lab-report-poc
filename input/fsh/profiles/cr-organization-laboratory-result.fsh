// ==============================================================================================================
// Profile: Organización para Resultados de Laboratorio
// Basado en: LogicalModelOrganizationLaboratoryResult
// ==============================================================================================================

Profile: CROrganizationLaboratoryResult
Parent: Organization
Id: cr-organization-laboratory-result
Title: "Organization - Resultados de Laboratorio"
Description: "Perfil de organización que define los datos de la organización necesarios para representar resultados de laboratorio, basado en el modelo lógico LogicalModelOrganizationLaboratoryResult y el perfil de organización del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-organization-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// Identificadores de la organización (tipoIdentificador + identificacion del modelo lógico)
* identifier 1..* MS
  * type 1..1 MS
    * ^short = "Tipo de identificador de la organización"
  * type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-identifier-types (required)
  * system 1..1 MS
  * value 1..1 MS
    * ^short = "Identificador de la organización"
    * ^definition = "Identificador único de la organización, utilizado para su identificación en el sistema de salud."

// Nombre de la organización (nombre del modelo lógico)
* name 1..1 MS
  * ^short = "Nombre de la organización"
  * ^definition = "Nombre oficial de la organización, utilizado para su identificación."

// Organización superior (parteDe del modelo lógico)
* partOf 0..1 MS
  * ^short = "Organización a la que pertenece"
  * ^definition = "Referencia a la organización a la que pertenece esta organización, para representar jerarquías organizacionales."

// Elementos que no se incluyen en el perfil para resultados de laboratorio:
* contact 0..0
* endpoint 0..0
