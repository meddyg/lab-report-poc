// ==============================================================================================================
// Profile: Composition HbA1c para Resultados de Laboratorio
// ==============================================================================================================

Profile: CRCompositionHbA1cLaboratoryResult
Parent: Composition
Id: cr-composition-hba1c-laboratory-result
Title: "Composition HbA1c"
Description: "Perfil de composición clínica para estructurar el documento de resultado de laboratorio HbA1c en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-composition-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final

* type 1..1 MS
* type = $loinc#11502-2

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)

* date 1..1 MS
* author 1..* MS
* author only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)

* title 1..1 MS

* section 1..* MS
* section.title 1..1 MS
* section.entry 1..* MS
* section.entry only Reference(CRDiagnosticReportHbA1cLaboratoryResult)

* encounter 0..0
