// ==============================================================================================================
// Profile: Observación Glucosa en Ayunas para Resultados de Laboratorio
// Basado en: LogicalModelDetailResultLaboratoryResult
// ==============================================================================================================


Profile: CRObservationGlucoseLaboratoryResult
Parent: Observation
Id: cr-observation-glucose-laboratory-result
Title: "Observation Glucosa en Ayunas"
Description: "Perfil de observación para representar el resultado de Glucosa en ayunas en el PoC de resultados de laboratorio en Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-observation-glucose-laboratory-result"
* ^version = "0.1.5"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final
* status ^short = "Estado final del resultado"
* status ^definition = "Estado clínico y operativo de la observación. En este perfil se fija como final para indicar que el resultado de glucosa ya fue completado y está listo para ser compartido, interpretado o persistido."

* category 1..1 MS
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* category ^short = "Categoría de laboratorio"
* category ^definition = "Clasificación general de la observación como resultado de laboratorio. Permite a sistemas consumidores identificar rápidamente que el recurso corresponde a un examen clínico de laboratorio."

* code 1..1 MS
* code = $loinc#1558-6
* code ^short = "Código de la prueba de glucosa en ayunas"
* code ^definition = "Código LOINC que identifica de manera unívoca la prueba de glucosa en ayunas reportada en este PoC. Es el elemento principal para semántica clínica e interoperabilidad internacional."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
