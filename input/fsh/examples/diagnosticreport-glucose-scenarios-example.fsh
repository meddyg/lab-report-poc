Instance: DiagnosticReportGlucoseFastingExample
InstanceOf: CRDiagnosticReportGlucoseLaboratoryResult
Title: "Ejemplo de DiagnosticReport de Glucosa en Ayunas"
Description: "Ejemplo de recurso DiagnosticReport para glucosa en ayunas (LOINC 1558-6)"
Usage: #example

* status = #final
* category = $v2-0074#LAB
* code = $loinc#1558-6
* subject = Reference(PatientLaboratoryResultExample)
* specimen = Reference(SpecimenGlucoseFastingExample)
* result[0] = Reference(ObservationGlucoseFastingExample)
* effectiveDateTime = "2024-05-20T08:00:00-06:00"
* issued = "2024-05-20T09:00:00-06:00"
