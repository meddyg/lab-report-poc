// ==============================================================================================================
// Profile: Specimen HbA1c para Resultados de Laboratorio
// ==============================================================================================================

Profile: CRSpecimenHbA1cLaboratoryResult
Parent: Specimen
Id: cr-specimen-hba1c-laboratory-result
Title: "Specimen HbA1c - Resultados de Laboratorio"
Description: "Perfil de muestra biológica para pruebas de HbA1c en el PoC de resultados de laboratorio."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-specimen-hba1c-laboratory-result"
* ^version = "0.1.2"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #available
* status ^short = "Estado de disponibilidad de la muestra"
* status ^definition = "Estado operativo de la muestra biológica utilizada para la prueba HbA1c. En este PoC se fija como disponible para indicar que la muestra fue obtenida y está disponible para el procesamiento o documentación del resultado."

* type 1..1 MS
* type = $snomed#122555007
* type ^short = "Tipo de muestra biológica"
* type ^definition = "Describe la naturaleza de la muestra analizada. Para el PoC de HbA1c se utiliza sangre venosa, que es la muestra base para representar el origen del resultado reportado."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
* subject ^short = "Paciente del que proviene la muestra"
* subject ^definition = "Referencia al paciente al que pertenece la muestra biológica. Es fundamental para mantener la trazabilidad entre el espécimen, la observación HbA1c y el reporte diagnóstico."

* collection 0..1 MS
* collection ^short = "Datos de toma de muestra"
* collection ^definition = "Información sobre el momento de recolección de la muestra utilizada en la prueba HbA1c. Este dato ayuda a reconstruir el flujo clínico y temporal del proceso de laboratorio."
* collection.collected[x] 0..1 MS
* collection.collected[x] only dateTime
* collection.collected[x] ^short = "Fecha y hora de recolección"
* collection.collected[x] ^definition = "Fecha y hora en que se tomó la muestra del paciente. Permite documentar el origen temporal del espécimen y correlacionarlo con el resultado emitido."

* receivedTime 0..1 MS
* receivedTime ^short = "Fecha y hora de recepción"
* receivedTime ^definition = "Fecha y hora en que la muestra fue recibida por el laboratorio o por el sistema que registra el procesamiento del análisis HbA1c."

* processing 0..* MS
* processing ^short = "Procesamiento de la muestra"
* processing ^definition = "Información sobre preparación o tratamiento de la muestra antes del análisis. Se mantiene disponible para futuros escenarios del PoC donde se requiera más detalle de laboratorio preanalítico."
* note 0..* MS
* note ^short = "Notas sobre la muestra"
* note ^definition = "Observaciones libres relacionadas con la muestra, como condiciones de recepción, particularidades del espécimen o aclaraciones relevantes para el procesamiento del resultado HbA1c."
