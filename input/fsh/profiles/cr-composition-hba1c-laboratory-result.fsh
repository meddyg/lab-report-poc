// ==============================================================================================================
// Profile: Composition HbA1c para Resultados de Laboratorio
// ==============================================================================================================

Profile: CRCompositionHbA1cLaboratoryResult
Parent: Composition
Id: cr-composition-hba1c-laboratory-result
Title: "Composition HbA1c"
Description: "Perfil de composición clínica para estructurar el documento de resultado de laboratorio HbA1c en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-composition-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final
* status ^short = "Estado final del documento"
* status ^definition = "Estado de la Composition que representa el documento clínico. Se fija como final para indicar que el documento de resultado HbA1c está completo y listo para intercambio."

* type 1..1 MS
* type = $loinc#11502-2
* type ^short = "Tipo de documento clínico"
* type ^definition = "Código LOINC que identifica el documento como un reporte de laboratorio. Es la clasificación documental principal del Bundle document."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
* subject ^short = "Paciente del documento"
* subject ^definition = "Referencia al paciente sobre el cual se documenta el resultado HbA1c en el documento clínico."

* date 1..1 MS
* date ^short = "Fecha del documento"
* date ^definition = "Fecha y hora de creación o ensamblaje del documento clínico de laboratorio que agrupa Composition, DiagnosticReport y recursos relacionados."
* author 1..* MS
* author only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)
* author ^short = "Autores del documento"
* author ^definition = "Actores responsables de la autoría formal del documento clínico de resultado HbA1c, ya sea la organización emisora, un profesional o su rol organizacional."

* title 1..1 MS
* title ^short = "Título del documento"
* title ^definition = "Título legible para humanos con el que se presenta el documento clínico de resultado HbA1c en portales, repositorios o visores."

* section 1..* MS
* section ^short = "Secciones del documento"
* section ^definition = "Bloques estructurados del documento clínico que agrupan el contenido del reporte de laboratorio. Para este PoC, una sección debe enlazar al DiagnosticReport principal."
* section.title 1..1 MS
* section.title ^short = "Título de la sección"
* section.title ^definition = "Etiqueta descriptiva de la sección del documento, útil para visores clínicos y navegación del contenido."
* section.entry 1..* MS
* section.entry only Reference(CRDiagnosticReportHbA1cLaboratoryResult)
* section.entry ^short = "Recursos clínicos referenciados por la sección"
* section.entry ^definition = "Referencias a los recursos que materializan el contenido clínico de la sección. En este PoC se espera enlazar el DiagnosticReport HbA1c."

* encounter 0..0
* encounter ^short = "Sin encuentro documentado"
* encounter ^definition = "El documento clínico del PoC no modela el encuentro asistencial asociado, ya que el alcance se limita al intercambio del resultado HbA1c."
