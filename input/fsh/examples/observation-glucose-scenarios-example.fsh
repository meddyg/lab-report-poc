Instance: ObservationGlucoseFastingExample
InstanceOf: CRObservationLaboratoryResult
Title: "Observation Laboratorio - Glucosa en Ayunas"
Description: "Ejemplo de recurso Observation para resultado de laboratorio de glucosa en ayunas (LOINC 1558-6)"
Usage: #example

* status = #final
* category = $observation-category#laboratory
* code = $loinc#1558-6
* subject = Reference(PatientLaboratoryResultExample)
* performer[0] = Reference(OrganizationHospitalMexicoLabExample)
* effectiveDateTime = "2024-05-20T08:00:00-06:00"
* valueQuantity.value = 95
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #mg/dL
* valueQuantity.unit = "mg/dL"
* specimen = Reference(SpecimenGlucoseFastingExample)
