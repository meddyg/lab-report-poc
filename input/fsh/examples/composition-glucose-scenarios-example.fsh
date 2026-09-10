Instance: CompositionGlucoseFastingExample
InstanceOf: CRCompositionLaboratoryResult
Title: "Composition Laboratorio - Glucosa en Ayunas"
Description: "Ejemplo de Composition para documento clínico de resultado de laboratorio de glucosa en ayunas"
Usage: #example
* insert VersionedExampleProfile(cr-composition-laboratory-result)

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Documento clínico de resultado de glucosa en ayunas.</p></div>"
* identifier.system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/documento-clinico"
* identifier.value = "DOC-GLUCOSEFASTING"
// La atestacion vive aqui y no en Signature.who: el sobre del Bundle no
// esta cubierto por la firma. Ver la pagina Alcance de la firma digital.
* attester[0].mode = http://hl7.org/fhir/composition-attestation-mode#legal
* attester[0].time = "2024-05-20T09:00:00-06:00"
* attester[0].party = Reference(OrganizationHospitalMexicoLabExample)
* status = #final
* type = $loinc#11502-2
* subject = Reference(PatientLaboratoryResultExample)
* date = "2024-05-20T09:00:00-06:00"
* author[0] = Reference(OrganizationHospitalMexicoLabExample)
* title = "Reporte de laboratorio - Glucosa en ayunas"
* section[0].title = "Resultados de laboratorio"
* section[0].entry[0] = Reference(DiagnosticReportGlucoseFastingExample)
