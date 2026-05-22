Instance: CompositionGlucoseFastingExample
InstanceOf: CRCompositionLaboratoryResult
Title: "Composition Laboratorio - Glucosa en Ayunas"
Description: "Ejemplo de Composition para documento clínico de resultado de laboratorio de glucosa en ayunas"
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Documento clínico de resultado de glucosa en ayunas.</p></div>"
* status = #final
* type = $loinc#11502-2
* subject = Reference(PatientLaboratoryResultExample)
* date = "2024-05-20T09:00:00-06:00"
* author[0] = Reference(OrganizationHospitalMexicoLabExample)
* title = "Reporte de laboratorio - Glucosa en ayunas"
* section[0].title = "Resultados de laboratorio"
* section[0].entry[0] = Reference(DiagnosticReportGlucoseFastingExample)
