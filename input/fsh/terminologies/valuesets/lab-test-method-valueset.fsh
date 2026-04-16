// ==============================================================================================================
// ValueSet: Códigos SNOMED CT para Métodos de Pruebas de Laboratorio
// ==============================================================================================================

ValueSet: LabTestMethodCodesSet
Id: lab-test-method-codes
Title: "Códigos de Métodos de Pruebas de Laboratorio"
Description: "Conjunto de valores que define los códigos SNOMED CT válidos para métodos utilizados en pruebas de laboratorio clínico."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/lab-test-method-codes"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

// Incluir todos los conceptos de SNOMED CT para procedimientos de análisis
* $snomed#258066000 "Polymerase chain reaction technique"
* $snomed#70601000052104 "Real-time polymerase chain reaction technique"
* $snomed#703725008 "Culture"
* $snomed#68431000052104 "Enzyme-linked immunosorbent assay technique"
* $snomed#66691000052100 "Electrochemiluminescence immunoassay technique"
* $snomed#726449005 "Immunoassay technique"
* $snomed#1303858005 "Chromatography technique"
* $snomed#1306402001 "Mass spectrometry technique"
* $snomed#70621000052105 "Spectrophotometric technique"