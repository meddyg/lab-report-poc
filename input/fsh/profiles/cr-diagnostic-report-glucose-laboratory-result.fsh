// ==============================================================================================================
// Profile: DiagnosticReport Glucosa en Ayunas para Resultados de Laboratorio
// Basado en: LogicalModelReportLaboratoryResult
// ==============================================================================================================


Profile: CRDiagnosticReportGlucoseLaboratoryResult
Parent: DiagnosticReport
Id: cr-diagnostic-report-glucose-laboratory-result
Title: "DiagnosticReport Glucosa en Ayunas"
Description: "Perfil de reporte diagnóstico para representar resultados de laboratorio de Glucosa en ayunas en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-diagnostic-report-glucose-laboratory-result"
* ^version = "0.1.5"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final
* status ^short = "Estado final del reporte"
* status ^definition = "Estado del DiagnosticReport. En este perfil se fija como final para indicar que el reporte de glucosa ya fue emitido formalmente por el laboratorio o sistema emisor."

* category 1..1 MS
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB
* category ^short = "Categoría del reporte"
* category ^definition = "Clasificación general del reporte como reporte de laboratorio, permitiendo a los sistemas consumidores reconocer el tipo documental y aplicar procesamiento específico."

* code 1..1 MS
* code = $loinc#1558-6
* code ^short = "Código de la prueba de glucosa en ayunas"
* code ^definition = "Código LOINC que identifica de manera unívoca la prueba de glucosa en ayunas reportada en este PoC. Es el elemento principal para semántica clínica e interoperabilidad internacional."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
