Instance: BundleGlucoseFastingExample
InstanceOf: CRBundleLaboratoryResult
Title: "Bundle Laboratorio - Glucosa en Ayunas"
Description: "Ejemplo de Bundle document para intercambio de resultado de laboratorio de glucosa en ayunas"
Usage: #example

* type = #document
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:3b4f2e10-f4ec-4cb1-9f20-e34af2fa7a40"
* timestamp = "2024-05-20T09:00:00-06:00"

* entry[composition].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Composition/CompositionGlucoseFastingExample"
* entry[composition].resource = CompositionGlucoseFastingExample

* entry[diagnosticReport].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/DiagnosticReport/DiagnosticReportGlucoseFastingExample"
* entry[diagnosticReport].resource = DiagnosticReportGlucoseFastingExample

* entry[observation].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Observation/ObservationGlucoseFastingExample"
* entry[observation].resource = ObservationGlucoseFastingExample

* entry[specimen].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Specimen/SpecimenGlucoseFastingExample"
* entry[specimen].resource = SpecimenGlucoseFastingExample

* entry[patient].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Patient/PatientLaboratoryResultExample"
* entry[patient].resource = PatientLaboratoryResultExample

* entry[organization][0].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationHospitalMexicoLabExample"
* entry[organization][0].resource = OrganizationHospitalMexicoLabExample

* entry[organization][1].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationHospitalMexicoExample"
* entry[organization][1].resource = OrganizationHospitalMexicoExample

* entry[organization][2].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Organization/OrganizationCCSSExample"
* entry[organization][2].resource = OrganizationCCSSExample
