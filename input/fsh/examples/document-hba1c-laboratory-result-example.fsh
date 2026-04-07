// ==============================================================================================================
// Instances: Ejemplo de Documento Clínico HbA1c
// Patrón: Composition + DiagnosticReport dentro de Bundle tipo document
// ==============================================================================================================

Instance: SpecimenHbA1cLaboratoryResultExample
InstanceOf: CRSpecimenHbA1cLaboratoryResult
Title: "Muestra HbA1c"
Description: "Ejemplo de muestra para prueba HbA1c."
Usage: #example

* status = #available
* type = $snomed#122555007 "Venous blood specimen"
* subject = Reference(PatientLaboratoryResultExample)
* collection.collectedDateTime = "2026-04-07T08:15:00-06:00"
* receivedTime = "2026-04-07T08:45:00-06:00"

Instance: PractitionerRoleHospitalMexicoLabExample
InstanceOf: CRPractitionerRoleLaboratoryResult
Title: "Rol Profesional Laboratorio Hospital México"
Description: "Ejemplo de contexto organizacional del profesional que reporta resultados de laboratorio."
Usage: #example

* active = true
* practitioner = Reference(PractitionerLaboratoryResultExample)
* organization = Reference(OrganizationHospitalMexicoLabExample)
* code[0] = http://terminology.hl7.org/CodeSystem/practitioner-role#doctor "Doctor"

Instance: ObservationHbA1cLaboratoryResultExample
InstanceOf: CRObservationHbA1cLaboratoryResult
Title: "Resultado HbA1c"
Description: "Ejemplo de observación de HbA1c en porcentaje."
Usage: #example

* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory "Laboratory"
* code = $loinc#4548-4
* subject = Reference(PatientLaboratoryResultExample)
* effectiveDateTime = "2026-04-07T09:00:00-06:00"
* performer[0] = Reference(OrganizationHospitalMexicoLabExample)
* performer[1] = Reference(PractitionerRoleHospitalMexicoLabExample)
* valueQuantity.value = 7.1
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%
* valueQuantity.unit = "%"
* interpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation#H "High"
* method = $snomed#726449005
* specimen = Reference(SpecimenHbA1cLaboratoryResultExample)
* referenceRange.text = "Rango de referencia para adulto: 4.0% - 5.6%"

Instance: DiagnosticReportHbA1cLaboratoryResultExample
InstanceOf: CRDiagnosticReportHbA1cLaboratoryResult
Title: "Reporte Diagnóstico HbA1c"
Description: "Ejemplo de DiagnosticReport para resultado de laboratorio HbA1c."
Usage: #example

* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB "Laboratory"
* code = $loinc#4548-4
* subject = Reference(PatientLaboratoryResultExample)
* effectiveDateTime = "2026-04-07T09:00:00-06:00"
* issued = "2026-04-07T09:30:00-06:00"
* performer[0] = Reference(OrganizationHospitalMexicoLabExample)
* performer[1] = Reference(PractitionerRoleHospitalMexicoLabExample)
* specimen[0] = Reference(SpecimenHbA1cLaboratoryResultExample)
* result[0] = Reference(ObservationHbA1cLaboratoryResultExample)
* conclusion = "Resultado de HbA1c por encima del rango esperado para control glucémico normal."

Instance: CompositionHbA1cLaboratoryResultExample
InstanceOf: CRCompositionHbA1cLaboratoryResult
Title: "Documento Clínico de Resultado HbA1c"
Description: "Ejemplo de Composition que centra el documento clínico de laboratorio en HbA1c."
Usage: #example

* status = #final
* type = $loinc#11502-2
* subject = Reference(PatientLaboratoryResultExample)
* date = "2026-04-07T09:35:00-06:00"
* author[0] = Reference(OrganizationHospitalMexicoLabExample)
* author[1] = Reference(PractitionerRoleHospitalMexicoLabExample)
* title = "Reporte de laboratorio HbA1c"
* section[0].title = "Resultados de laboratorio"
* section[0].entry[0] = Reference(DiagnosticReportHbA1cLaboratoryResultExample)

Instance: BundleHbA1cLaboratoryResultDocumentExample
InstanceOf: CRBundleHbA1cLaboratoryResult
Title: "Bundle Documento HbA1c"
Description: "Ejemplo de Bundle tipo document centrado en Composition y DiagnosticReport para intercambio de resultado HbA1c."
Usage: #example

* type = #document
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:1a7b4f24-6ec0-4e08-9e63-e0d7d4795bd8"
* timestamp = "2026-04-07T09:35:00-06:00"

* entry[composition].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Composition/CompositionHbA1cLaboratoryResultExample"
* entry[composition].resource = CompositionHbA1cLaboratoryResultExample

* entry[diagnosticReport].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/DiagnosticReport/DiagnosticReportHbA1cLaboratoryResultExample"
* entry[diagnosticReport].resource = DiagnosticReportHbA1cLaboratoryResultExample

* entry[observation].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Observation/ObservationHbA1cLaboratoryResultExample"
* entry[observation].resource = ObservationHbA1cLaboratoryResultExample

* entry[specimen].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Specimen/SpecimenHbA1cLaboratoryResultExample"
* entry[specimen].resource = SpecimenHbA1cLaboratoryResultExample

* entry[patient].fullUrl = "https://hl7.meddyg.com/fhir/laboratory-results/Patient/PatientLaboratoryResultExample"
* entry[patient].resource = PatientLaboratoryResultExample

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
