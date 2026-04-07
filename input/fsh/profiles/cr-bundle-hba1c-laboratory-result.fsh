// ==============================================================================================================
// Profile: Bundle Documento HbA1c para Resultados de Laboratorio
// ==============================================================================================================

Invariant: CRBundleDR1
Description: "El documento debe incluir uno y solo un DiagnosticReport."
Severity: #error
Expression: "entry.resource.ofType(DiagnosticReport).count() = 1"

Invariant: CRBundleComp1
Description: "El documento debe incluir una y solo una Composition."
Severity: #error
Expression: "entry.resource.ofType(Composition).count() = 1"

Invariant: CRBundleOBS1
Description: "El documento debe incluir al menos una Observation de laboratorio."
Severity: #error
Expression: "entry.resource.ofType(Observation).exists()"

Invariant: CRBundleDROBSLink1
Description: "Debe existir al menos un DiagnosticReport con result que resuelva a una Observation del documento."
Severity: #error
Expression: "entry.resource.ofType(DiagnosticReport).where(result.resolve().ofType(Observation).exists()).exists()"

Invariant: CRBundleCompDRSubj1
Description: "Composition y DiagnosticReport deben referenciar el mismo sujeto."
Severity: #error
Expression: "entry.resource.ofType(Composition).subject = entry.resource.ofType(DiagnosticReport).subject"

Invariant: CRBundleCompDRType1
Description: "La Composition debe enlazar al menos un DiagnosticReport del documento mediante section.entry."
Severity: #error
Expression: "entry.resource.ofType(Composition).section.entry.resolve().ofType(DiagnosticReport).exists()"

Invariant: CRBundleCompFirst1
Description: "La primera entrada del documento debe ser Composition."
Severity: #error
Expression: "entry.first().resource.ofType(Composition).exists()"

Profile: CRBundleHbA1cLaboratoryResult
Parent: Bundle
Id: cr-bundle-hba1c-laboratory-result
Title: "Bundle HbA1c"
Description: "Perfil de Bundle tipo document para intercambio de resultado de laboratorio HbA1c centrado en Composition y DiagnosticReport en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-bundle-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR
* obeys CRBundleDR1 and CRBundleComp1 and CRBundleOBS1 and CRBundleDROBSLink1 and CRBundleCompDRSubj1 and CRBundleCompDRType1 and CRBundleCompFirst1

* type 1..1 MS
* type = #document

* identifier 1..1 MS
* identifier.system 1..1 MS
* identifier.value 1..1 MS

* timestamp 1..1 MS

* total 0..0
* link 0..0

* entry 5..* MS
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open
* entry contains
	composition 1..1 and
	diagnosticReport 1..1 and
	patient 1..1 and
	observation 1..* and
	organization 1..* and
	specimen 0..* and
	practitioner 0..* and
	practitionerRole 0..*
* entry[composition].resource only CRCompositionHbA1cLaboratoryResult
* entry[diagnosticReport].resource only CRDiagnosticReportHbA1cLaboratoryResult
* entry[patient].resource only CRPatientLaboratoryResult
* entry[observation].resource only CRObservationHbA1cLaboratoryResult
* entry[organization].resource only CROrganizationLaboratoryResult
* entry[specimen].resource only CRSpecimenHbA1cLaboratoryResult
* entry[practitioner].resource only CRPractitionerLaboratoryResult
* entry[practitionerRole].resource only CRPractitionerRoleLaboratoryResult
* entry.link 0..0
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.search 0..0
* entry.request 0..0
* entry.response 0..0
