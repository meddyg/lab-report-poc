// ==============================================================================================================
// Profile: Specimen Glucosa en Ayunas para Resultados de Laboratorio
// Basado en: LogicalModelSpecimenLaboratoryResult
// ==============================================================================================================

Profile: CRSpecimenGlucoseLaboratoryResult
Parent: Specimen
Id: cr-specimen-glucose-laboratory-result
Title: "Specimen Glucosa en Ayunas"
Description: "Perfil de Specimen para la muestra utilizada en la prueba de glucosa en ayunas en el PoC de resultados de laboratorio en Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-specimen-glucose-laboratory-result"
* ^version = "0.1.5"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* type 1..1 MS
* type = $sct#119297000 "Blood specimen"
* type ^short = "Tipo de muestra: sangre"
* type ^definition = "Tipo de muestra utilizada para la prueba de glucosa en ayunas."
