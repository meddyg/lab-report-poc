// ==============================================================================================================
// Profile: Rol del Profesional para Resultados de Laboratorio
// ==============================================================================================================

Profile: CRPractitionerRoleLaboratoryResult
Parent: PractitionerRole
Id: cr-practitioner-role-laboratory-result
Title: "PractitionerRole - Resultados de Laboratorio"
Description: "Perfil de PractitionerRole para representar el contexto organizacional y funcional del profesional de salud dentro del flujo de intercambio de resultados de laboratorio."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-practitioner-role-laboratory-result"
* ^version = "0.1.2"
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
* specialty ^short = "Sin especialidad en este PoC"
* specialty ^definition = "La especialidad formal del profesional no se documenta en este perfil simplificado del PoC, ya que el contexto organizacional y el rol funcional son suficientes para el intercambio del resultado HbA1c."
* contact 0..0
* contact ^short = "Sin datos de contacto en este rol"
* contact ^definition = "No se incluyen datos de contacto del rol profesional en el alcance actual del PoC, porque no son necesarios para transportar ni interpretar el resultado clínico."
* availability 0..0
* availability ^short = "Sin horarios de disponibilidad"
* availability ^definition = "La disponibilidad horaria del rol profesional no se requiere para el intercambio de resultados de laboratorio de este PoC y por ello no se modela."
* endpoint 0..0
* endpoint ^short = "Sin endpoint asociado"
* endpoint ^definition = "No se documentan endpoints técnicos ligados al rol profesional en este perfil, ya que el PoC se centra en la semántica clínica y organizacional del resultado HbA1c."
