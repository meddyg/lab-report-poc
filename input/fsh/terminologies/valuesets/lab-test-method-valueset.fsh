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
* include $snomed#258066000 "Técnica de reacción en cadena de la polimerasa"
* include $snomed#70601000052104 "Técnica de reacción en cadena de la polimerasa en tiempo real"
* include $snomed#703725008 "Cultivo"
* include $snomed#68431000052104 "Técnica de ensayo por inmunoabsorción ligado a enzimas"
* include $snomed#66691000052100 "Técnica de inmunoensayo de electroquimioluminiscencia"
* include $snomed#726449005 "Técnica de inmunoensayo"
* include $snomed#1303858005 "Técnica de cromatografía"
* include $snomed#1306402001 "Técnica de espectrometría de masas"
* include $snomed#70621000052105 "Técnica espectrofotométrica"