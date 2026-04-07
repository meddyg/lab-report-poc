// ==============================================================================================================
// Instances: Ejemplos de Bundle document HbA1c por escenario
// ==============================================================================================================

Instance: BundleHbA1cTamizajeEBAISExample
InstanceOf: CRBundleHbA1cLaboratoryResult
Title: "Bundle HbA1c - Tamizaje EBAIS"
Description: "Ejemplo de Bundle document para intercambio de resultado HbA1c en escenario de tamizaje desde un EBAIS de la CCSS."
Usage: #example

* type = #document
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:3bc0ecdb-a8ed-4ad7-9d25-e96c308cf8c4"
* timestamp = "2026-04-08T08:30:00-06:00"

* entry[composition].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Composition/CompositionHbA1cTamizajeEBAISExample"
* entry[composition].resource = CompositionHbA1cTamizajeEBAISExample

* entry[diagnosticReport].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/DiagnosticReport/DiagnosticReportHbA1cTamizajeEBAISExample"
* entry[diagnosticReport].resource = DiagnosticReportHbA1cTamizajeEBAISExample

* entry[observation].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Observation/ObservationHbA1cTamizajeEBAISExample"
* entry[observation].resource = ObservationHbA1cTamizajeEBAISExample

* entry[specimen].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Specimen/SpecimenHbA1cTamizajeEBAISExample"
* entry[specimen].resource = SpecimenHbA1cTamizajeEBAISExample

* entry[patient].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Patient/PatientHbA1cTamizajeEBAISExample"
* entry[patient].resource = PatientHbA1cTamizajeEBAISExample

* entry[organization][0].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationEBAISGoicoechea2LabExample"
* entry[organization][0].resource = OrganizationEBAISGoicoechea2LabExample

* entry[organization][1].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationEBAISGoicoechea2Example"
* entry[organization][1].resource = OrganizationEBAISGoicoechea2Example

* entry[organization][2].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationCCSSExample"
* entry[organization][2].resource = OrganizationCCSSExample

* entry[practitioner].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Practitioner/PractitionerLaboratoryResultExample"
* entry[practitioner].resource = PractitionerLaboratoryResultExample

* entry[practitionerRole].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/PractitionerRole/PractitionerRoleEBAISGoicoechea2LabExample"
* entry[practitionerRole].resource = PractitionerRoleEBAISGoicoechea2LabExample

Instance: BundleHbA1cSeguimientoEBAISExample
InstanceOf: CRBundleHbA1cLaboratoryResult
Title: "Bundle HbA1c - Seguimiento EBAIS"
Description: "Ejemplo de Bundle document para intercambio de resultado HbA1c en seguimiento ambulatorio desde un EBAIS de la CCSS."
Usage: #example

* type = #document
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:ef194e0a-166f-4f5d-9f6f-c30167a61657"
* timestamp = "2026-04-08T09:45:00-06:00"

* entry[composition].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Composition/CompositionHbA1cSeguimientoEBAISExample"
* entry[composition].resource = CompositionHbA1cSeguimientoEBAISExample

* entry[diagnosticReport].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/DiagnosticReport/DiagnosticReportHbA1cSeguimientoEBAISExample"
* entry[diagnosticReport].resource = DiagnosticReportHbA1cSeguimientoEBAISExample

* entry[observation].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Observation/ObservationHbA1cSeguimientoEBAISExample"
* entry[observation].resource = ObservationHbA1cSeguimientoEBAISExample

* entry[specimen].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Specimen/SpecimenHbA1cSeguimientoEBAISExample"
* entry[specimen].resource = SpecimenHbA1cSeguimientoEBAISExample

* entry[patient].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Patient/PatientHbA1cSeguimientoEBAISExample"
* entry[patient].resource = PatientHbA1cSeguimientoEBAISExample

* entry[organization][0].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationEBAISGoicoechea2LabExample"
* entry[organization][0].resource = OrganizationEBAISGoicoechea2LabExample

* entry[organization][1].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationEBAISGoicoechea2Example"
* entry[organization][1].resource = OrganizationEBAISGoicoechea2Example

* entry[organization][2].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationCCSSExample"
* entry[organization][2].resource = OrganizationCCSSExample

* entry[practitioner].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Practitioner/PractitionerLaboratoryResultExample"
* entry[practitioner].resource = PractitionerLaboratoryResultExample

* entry[practitionerRole].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/PractitionerRole/PractitionerRoleEBAISGoicoechea2LabExample"
* entry[practitionerRole].resource = PractitionerRoleEBAISGoicoechea2LabExample

Instance: BundleHbA1cHospitalControlExample
InstanceOf: CRBundleHbA1cLaboratoryResult
Title: "Bundle HbA1c - Control Hospitalario"
Description: "Ejemplo de Bundle document para intercambio de resultado HbA1c emitido desde laboratorio hospitalario de la CCSS."
Usage: #example

* type = #document
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:75534dfc-7519-4201-b7f9-78bb5532c51d"
* timestamp = "2026-04-08T10:40:00-06:00"

* entry[composition].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Composition/CompositionHbA1cHospitalControlExample"
* entry[composition].resource = CompositionHbA1cHospitalControlExample

* entry[diagnosticReport].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/DiagnosticReport/DiagnosticReportHbA1cHospitalControlExample"
* entry[diagnosticReport].resource = DiagnosticReportHbA1cHospitalControlExample

* entry[observation].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Observation/ObservationHbA1cHospitalControlExample"
* entry[observation].resource = ObservationHbA1cHospitalControlExample

* entry[specimen].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Specimen/SpecimenHbA1cHospitalControlExample"
* entry[specimen].resource = SpecimenHbA1cHospitalControlExample

* entry[patient].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Patient/PatientHbA1cHospitalControlExample"
* entry[patient].resource = PatientHbA1cHospitalControlExample

* entry[organization][0].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationHospitalMexicoLabExample"
* entry[organization][0].resource = OrganizationHospitalMexicoLabExample

* entry[organization][1].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationHospitalMexicoExample"
* entry[organization][1].resource = OrganizationHospitalMexicoExample

* entry[organization][2].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationCCSSExample"
* entry[organization][2].resource = OrganizationCCSSExample

* entry[practitioner].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Practitioner/PractitionerLaboratoryResultExample"
* entry[practitioner].resource = PractitionerLaboratoryResultExample

* entry[practitionerRole].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/PractitionerRole/PractitionerRoleHospitalMexicoLabExample"
* entry[practitionerRole].resource = PractitionerRoleHospitalMexicoLabExample