// ==============================================================================================================
// ValueSet: Códigos LOINC para Pruebas de Laboratorio
// ==============================================================================================================

ValueSet: LabTestLaboratoryCodesSet
Id: lab-test-codes
Title: "Códigos de Pruebas de Laboratorio"
Description: "Conjunto de valores que define los códigos LOINC válidos para pruebas de laboratorio incluidas en este PoC, como hemoglobina y glucosa en ayunas."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/lab-test-codes"
* ^version = "0.1.6"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* $loinc#718-7 "Hemoglobin [Mass/volume] in Blood"
* $loinc#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* $loinc#17856-6 "Hemoglobin A1c/Hemoglobin.total in Blood by HPLC"
* $loinc#1558-6 "Glucose [Mass/volume] in Blood --Fasting"
