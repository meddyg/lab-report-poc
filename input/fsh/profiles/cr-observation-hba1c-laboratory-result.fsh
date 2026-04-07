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

* category 1..1 MS
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory "Laboratory"

* code 1..1 MS
* code = $loinc#4548-4

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)

* effective[x] 1..1 MS
* effective[x] only dateTime

* performer 1..* MS
* performer only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)

* value[x] 1..1 MS
* value[x] only Quantity
* valueQuantity.system 1..1 MS
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code 1..1 MS
* valueQuantity.code = #%
* valueQuantity.unit 1..1 MS
* valueQuantity.unit = "%"

* interpretation 0..* MS
* interpretation from http://hl7.org/fhir/ValueSet/observation-interpretation (extensible)

* method 0..1 MS
* method from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/lab-test-method-codes (required)

* specimen 0..1 MS
* specimen only Reference(CRSpecimenHbA1cLaboratoryResult)

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
