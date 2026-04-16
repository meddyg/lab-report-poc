// ==============================================================================================================
// Profile: Observación HbA1c para Resultados de Laboratorio
// Basado en: LogicalModelDetailResultLaboratoryResult
// ==============================================================================================================

Profile: CRObservationHbA1cLaboratoryResult
Parent: Observation
Id: cr-observation-hba1c-laboratory-result
Title: "Observation HbA1c"
Description: "Perfil de observación para representar el resultado de Hemoglobina Glicosilada (HbA1c) en el PoC de resultados de laboratorio en Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-observation-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final
* status ^short = "Estado final del resultado"
* status ^definition = "Estado clínico y operativo de la observación. En este perfil se fija como final para indicar que el resultado HbA1c ya fue completado y está listo para ser compartido, interpretado o persistido."

* category 1..1 MS
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* category ^short = "Categoría de laboratorio"
* category ^definition = "Clasificación general de la observación como resultado de laboratorio. Permite a sistemas consumidores identificar rápidamente que el recurso corresponde a un examen clínico de laboratorio."

* code 1..1 MS
* code from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-hba1c-test-code (required)
* code = $loinc#4548-4
* code ^short = "Código de la prueba HbA1c"
* code ^definition = "Código LOINC que identifica de manera unívoca la prueba de hemoglobina glicosilada (HbA1c) reportada en este PoC. Es el elemento principal para semántica clínica e interoperabilidad internacional."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
* subject ^short = "Paciente observado"
* subject ^definition = "Referencia al paciente al que corresponde el resultado HbA1c. Vincula el dato analítico con la persona correcta dentro del ecosistema clínico costarricense."

* effective[x] 1..1 MS
* effective[x] only dateTime
* effective[x] ^short = "Momento clínico del resultado"
* effective[x] ^definition = "Fecha y hora clínica a la que corresponde el resultado de HbA1c, normalmente relacionada con la toma o el procesamiento de la muestra."

* performer 1..* MS
* performer only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)
* performer ^short = "Responsables de la observación"
* performer ^definition = "Organización, profesional o rol profesional responsable de generar, validar o reportar la observación de HbA1c. Este elemento soporta la trazabilidad organizacional y asistencial del resultado."

* value[x] 1..1 MS
* value[x] only Quantity
* value[x] ^short = "Resultado cuantitativo de HbA1c"
* value[x] ^definition = "Valor principal de la observación, expresado como porcentaje de hemoglobina glicosilada. Constituye el dato clínico central del PoC."
* valueQuantity.system 1..1 MS
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.system ^short = "Sistema UCUM"
* valueQuantity.system ^definition = "Sistema de codificación UCUM utilizado para expresar formalmente la unidad de medida del resultado HbA1c."
* valueQuantity.code 1..1 MS
* valueQuantity.code = #%
* valueQuantity.code ^short = "Código UCUM de porcentaje"
* valueQuantity.code ^definition = "Código UCUM que representa que el resultado HbA1c se expresa en porcentaje."
* valueQuantity.unit 1..1 MS
* valueQuantity.unit = "%"
* valueQuantity.unit ^short = "Unidad visible del resultado"
* valueQuantity.unit ^definition = "Representación textual de la unidad con la que se presenta el valor HbA1c al usuario clínico o implementador."

* interpretation 0..* MS
* interpretation from http://hl7.org/fhir/ValueSet/observation-interpretation (extensible)
* interpretation ^short = "Interpretación clínica del resultado"
* interpretation ^definition = "Clasificación resumida del resultado HbA1c, por ejemplo alto o normal, para apoyar interpretación clínica rápida y procesamiento downstream."

* method 0..1 MS
* method from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/lab-test-method-codes (required)
* method ^short = "Método analítico utilizado"
* method ^definition = "Método o técnica de laboratorio con la que se obtuvo el resultado HbA1c. Este dato facilita comparabilidad analítica, auditoría y comprensión del contexto técnico del resultado."

* specimen 0..1 MS
* specimen only Reference(CRSpecimenHbA1cLaboratoryResult)
* specimen ^short = "Muestra asociada"
* specimen ^definition = "Referencia a la muestra biológica a partir de la cual se produjo la observación HbA1c, preservando la trazabilidad preanalítica y analítica."

* referenceRange 0..* MS
* referenceRange ^short = "Rango de referencia del resultado"
* referenceRange ^definition = "Intervalo de valores de referencia para interpretar el resultado de HbA1c, expresado en porcentaje cuando se proveen límites estructurados."
* referenceRange.low 0..1 MS
* referenceRange.low only SimpleQuantity
* referenceRange.low.system 1..1 MS
* referenceRange.low.system = "http://unitsofmeasure.org"
* referenceRange.low.code 1..1 MS
* referenceRange.low.code = #%
* referenceRange.low.unit 1..1 MS
* referenceRange.low.unit = "%"
* referenceRange.low ^short = "Límite inferior (%)"
* referenceRange.low ^definition = "Límite inferior del rango de referencia para HbA1c, representado como Quantity en UCUM porcentaje (%)."
* referenceRange.high 0..1 MS
* referenceRange.high only SimpleQuantity
* referenceRange.high.system 1..1 MS
* referenceRange.high.system = "http://unitsofmeasure.org"
* referenceRange.high.code 1..1 MS
* referenceRange.high.code = #%
* referenceRange.high.unit 1..1 MS
* referenceRange.high.unit = "%"
* referenceRange.high ^short = "Límite superior (%)"
* referenceRange.high ^definition = "Límite superior del rango de referencia para HbA1c, representado como Quantity en UCUM porcentaje (%)."
* referenceRange.text 0..1 MS
* referenceRange.text ^short = "Rango en texto libre"
* referenceRange.text ^definition = "Descripción opcional en texto del rango de referencia o de su contexto clínico para interpretación del resultado."
* note 0..* MS
* note ^short = "Notas del resultado"
* note ^definition = "Observaciones adicionales sobre la medición HbA1c, como aclaraciones del laboratorio, advertencias técnicas o comentarios clínicos relevantes para implementadores y usuarios."
