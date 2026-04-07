// ==============================================================================================================
// Profile: Rol del Profesional para Resultados de Laboratorio
// ==============================================================================================================

Profile: CRPractitionerRoleLaboratoryResult
Parent: PractitionerRole
Id: cr-practitioner-role-laboratory-result
Title: "PractitionerRole - Resultados de Laboratorio"
Description: "Perfil de PractitionerRole para representar el contexto organizacional y funcional del profesional de salud dentro del flujo de intercambio de resultados de laboratorio."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-practitioner-role-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* practitioner 1..1 MS
* practitioner only Reference(CRPractitionerLaboratoryResult)
* practitioner ^short = "Profesional responsable"
* practitioner ^definition = "Referencia al profesional de salud que desempeña este rol dentro del flujo de resultados de laboratorio."

* organization 1..1 MS
* organization only Reference(CROrganizationLaboratoryResult)
* organization ^short = "Organización del rol"
* organization ^definition = "Referencia a la organización en la que el profesional ejerce su rol para la emisión o validación de resultados de laboratorio."

* active 1..1 MS
* active ^short = "Rol activo"
* active ^definition = "Indica si el rol del profesional se encuentra vigente para participar en el intercambio de resultados de laboratorio."

* code 0..* MS
* code from http://hl7.org/fhir/ValueSet/practitioner-role 
* code ^short = "Tipo de rol profesional"
* code ^definition = "Clasificación funcional del rol del profesional dentro del contexto organizacional del laboratorio."

* specialty 0..0
* contact 0..0
* availability 0..0
* endpoint 0..0
