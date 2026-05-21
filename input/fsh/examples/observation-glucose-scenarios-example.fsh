Instance: ObservationGlucoseFastingExample
InstanceOf: CRObservationGlucoseLaboratoryResult
Title: "Ejemplo de Observación de Glucosa en Ayunas"
Description: "Ejemplo de recurso Observation para glucosa en ayunas (LOINC 1558-6)"
Usage: #example

* status = #final
* category = $observation-category#laboratory
* code = $loinc#1558-6
* subject = Reference(PatientLaboratoryResultExample)
* effectiveDateTime = "2024-05-20T08:00:00-06:00"
* valueQuantity = 95 'mg/dL'
* specimen = Reference(SpecimenGlucoseFastingExample)
