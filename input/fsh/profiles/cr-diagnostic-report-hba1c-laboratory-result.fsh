// ==============================================================================================================
// Profile: DiagnosticReport HbA1c para Resultados de Laboratorio
// Basado en: LogicalModelReportLaboratoryResult
// ==============================================================================================================

Profile: CRDiagnosticReportHbA1cLaboratoryResult
Parent: DiagnosticReport
Id: cr-diagnostic-report-hba1c-laboratory-result
Title: "DiagnosticReport HbA1c"
Description: "Perfil de reporte diagnóstico para representar resultados de laboratorio de Hemoglobina Glicosilada (HbA1c) en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-diagnostic-report-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final

* category 1..1 MS
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB "Laboratory"

* code 1..1 MS
* code = $loinc#4548-4

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)

* effective[x] 1..1 MS
* effective[x] only dateTime

* issued 1..1 MS

* performer 1..* MS
* performer only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)

* specimen 0..* MS
* specimen only Reference(CRSpecimenHbA1cLaboratoryResult)

* result 1..* MS
* result only Reference(CRObservationHbA1cLaboratoryResult)

* conclusion 0..1 MS
* note 0..* MS

// Elementos que no se incluyen en el perfil para resultados de laboratorio:
* encounter 0..0