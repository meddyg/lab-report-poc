// ==============================================================================================================
// ValueSet: Códigos LOINC para Pruebas de Hemoglobina
// ==============================================================================================================

ValueSet: LabTestHemoglobinaCodesSet
Id: lab-test-hemoglobina-codes
Title: "Códigos de Pruebas de Hemoglobina"
Description: "Conjunto de valores que define los códigos LOINC válidos para pruebas de hemoglobina, incluyendo hemoglobina total y hemoglobina glicosilada (HbA1c)."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/lab-test-hemoglobina-codes"
* ^version = "0.1.2"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* $loinc#718-7 "Hemoglobin [Mass/volume] in Blood"
* $loinc#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* $loinc#17856-6 "Hemoglobin A1c/Hemoglobin.total in Blood by HPLC"
