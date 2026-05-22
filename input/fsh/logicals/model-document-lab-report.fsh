// ==============================================================================================================
// Modelo Logico: Documento de Reporte de Laboratorio
// Fuente: Flujo documental del PoC (Bundle document + Composition + DiagnosticReport)
// ==============================================================================================================

Logical: LogicalModelDocumentLaboratoryReport
Id: LogicalModelDocumentLaboratoryReport
Title: "Documento de Reporte de Laboratorio"
Description: "Modelo logico que define la estructura minima de un documento clinico de reporte de laboratorio para intercambio en el PoC de Costa Rica. Integra metadatos documentales, actores, resultado diagnostico y trazabilidad."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelDocumentLaboratoryReport"
* ^version = "0.1.7"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

// --- Metadatos documentales ---
* identificadorDocumento 1..1 Identifier "Identificador de negocio del documento."
  "Identificador unico del documento de reporte de laboratorio para intercambio, almacenamiento y auditoria entre sistemas."

* estadoDocumento 1..1 code "Estado del documento."
  "Estado de ciclo de vida del documento clinico. En escenarios de publicacion e intercambio del PoC se espera un estado final."
* estadoDocumento from http://hl7.org/fhir/ValueSet/composition-status (required)

* tipoDocumento 1..1 code "Tipo de documento clinico."
  "Tipo documental del reporte de laboratorio. Para este PoC se usa la clasificacion de documento de laboratorio basada en LOINC."
* tipoDocumento from CRLaboratoryDocumentTypeCodes (required)

* fechaDocumento 1..1 dateTime "Fecha y hora de emision del documento."
  "Momento en que el documento de reporte de laboratorio se genera formalmente para intercambio."

* tituloDocumento 1..1 string "Titulo legible del documento."
  "Titulo que permite identificar el documento de forma humana en repositorios, visores y sistemas consumidores."

// --- Sujetos y actores ---
* paciente 1..1 LogicalModelPatientLaboratoryResult "Paciente sujeto del documento."
  "Datos del paciente al que pertenece el reporte de laboratorio."

* autorProfesional 0..* LogicalModelPractitionerLaboratoryResult "Profesional autor o validador."
  "Profesionales de salud que participan en la autoria, validacion o firma del contenido del reporte."

* organizacionEmisora 1..1 LogicalModelOrganizationLaboratoryResult "Organizacion emisora del documento."
  "Organizacion responsable de emitir el reporte, por ejemplo laboratorio clinico, hospital o red institucional."

// --- Contenido clinico del reporte ---
* reporteDiagnosticoId 1..1 Identifier "Identificador del reporte diagnostico principal."
  "Identificador del reporte diagnostico que resume e interpreta los resultados analiticos incluidos en el documento."

* fechaMuestra 0..1 dateTime "Fecha y hora de toma de muestra."
  "Momento de obtencion de la muestra biologica asociada al reporte."

* resultados 1..* LogicalModelDetailResultLaboratoryResult "Resultados analiticos incluidos."
  "Conjunto de resultados analiticos del reporte. En el alcance actual debe permitir representar al menos HbA1c."

* conclusion 0..1 string "Conclusion clinica del reporte."
  "Resumen interpretativo del reporte diagnostico para apoyo clinico y comunicacion entre sistemas."

* observacionesDocumento 0..* string "Observaciones adicionales del documento."
  "Comentarios administrativos, tecnicos o clinicos asociados al reporte de laboratorio."

// --- Trazabilidad y auditoria ---
* proveniencia 0..1 Identifier "Referencia de procedencia del documento."
  "Identificador de trazabilidad para vincular la procedencia (cadena de custodia) del documento en el flujo LIS/Registro/Repositorio."

* auditoriaEvento 0..* Identifier "Eventos de auditoria relacionados."
  "Identificadores de eventos de auditoria asociados al acceso, creacion o consulta del reporte de laboratorio."
