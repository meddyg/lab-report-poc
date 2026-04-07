// ==============================================================================================================
// Profile: Specimen HbA1c para Resultados de Laboratorio
// ==============================================================================================================

Profile: CRSpecimenHbA1cLaboratoryResult
Parent: Specimen
Id: cr-specimen-hba1c-laboratory-result
Title: "Specimen HbA1c - Resultados de Laboratorio"
Description: "Perfil de muestra biológica para pruebas de HbA1c en el PoC de resultados de laboratorio."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-specimen-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #available

* type 1..1 MS
* type = $snomed#122555007 "Venous blood specimen"

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)

* collection 0..1 MS
* collection.collected[x] 0..1 MS
* collection.collected[x] only dateTime

* receivedTime 0..1 MS

* processing 0..* MS
* note 0..* MS
