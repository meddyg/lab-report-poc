// ==============================================================================================================
// Profile: Composition para Resultados de Laboratorio
// ==============================================================================================================

Invariant: cr-composition-date-no-future
Description: "La fecha de creación del documento no puede ser futura."
Severity: #error
Expression: "$this <= now()"

Profile: CRCompositionLaboratoryResult
Parent: Composition
Id: cr-composition-laboratory-result
Title: "Composition Laboratorio"
Description: "Perfil de composición clínica para estructurar documentos de resultados de laboratorio (HbA1c y glucosa en ayunas) en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-composition-laboratory-result"
* ^version = "0.3.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// ---------------------------------------------------------------------------
// Identificador del documento
//
// Se exige porque es la unica copia firmada del identificador. Medido el
// 2026-09-09 contra el validador de produccion de GAUDI: el digest cubre los
// recursos dentro de Bundle.entry y deja fuera el sobre del Bundle, de modo que
// Bundle.identifier se puede alterar sin invalidar la firma. El invariante
// CRBundleIdentMatch1 exige que el del sobre sea copia de este.
// Ver la pagina Alcance de la firma digital.
// ---------------------------------------------------------------------------
* identifier 1..1 MS
* identifier ^short = "Identificador del documento, cubierto por la firma"
* identifier ^definition = "Identificador de negocio del documento clinico. Es la copia autoritativa del identificador: Bundle.identifier queda fuera del alcance de la firma digital y debe coincidir con este valor."
* identifier.system 1..1 MS
* identifier.value 1..1 MS

// ---------------------------------------------------------------------------
// Confidencialidad
//
// FHIR R5 elimino Composition.confidentiality, asi que meta.security es la
// unica ubicacion que da la especificacion. El meta de la raiz del Bundle no
// esta cubierto por la firma; el de esta Composition si, medido el 2026-09-09.
// Una etiqueta puesta en la raiz se puede quitar sin dejar rastro.
// ---------------------------------------------------------------------------
* meta.security MS
* meta.security ^short = "Etiqueta de confidencialidad, cubierta por la firma"
* meta.security ^definition = "Etiquetas de seguridad del documento. Deben declararse aqui y no en el meta de la raiz del Bundle: el meta de la raiz queda fuera del alcance de la firma digital y una etiqueta puesta ahi se puede remover sin invalidarla."

* status 1..1 MS
* status = #final
* status ^short = "Estado final del documento"
* status ^definition = "Estado de la Composition que representa el documento clínico. Se fija como final para indicar que el documento de resultado de laboratorio está completo y listo para intercambio."

* type 1..1 MS
* type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-laboratory-document-type-codes (required)
* type = $loinc#11502-2
* type ^short = "Tipo de documento clínico"
* type ^definition = "Código LOINC que identifica el documento como un reporte de laboratorio. Es la clasificación documental principal del Bundle document."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
* subject ^short = "Paciente del documento"
* subject ^definition = "Referencia al paciente sobre el cual se documenta el resultado de laboratorio en el documento clínico."

* date 1..1 MS
* date ^short = "Fecha del documento"
* date ^definition = "Fecha y hora de creación del documento clínico de laboratorio. Es la fecha autoritativa del documento: Bundle.timestamp registra cuándo se ensambló el Bundle y queda fuera del alcance de la firma digital, así que un consumidor no debe apoyarse en él."
* date obeys cr-composition-date-no-future

* author 1..* MS
* author only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)
* author ^short = "Autores del documento"
* author ^definition = "Actores responsables de la autoría formal del documento clínico de resultados de laboratorio, ya sea la organización emisora, un profesional o su rol organizacional."

// ---------------------------------------------------------------------------
// Atestacion: quien responde por el documento
//
// Es el cambio de mayor peso de este perfil. Signature.who, Signature.when y
// Signature.type viven dentro de Bundle.signature, o sea en el sobre del
// Bundle, que la firma no cubre: son alterables sin invalidarla. Un consumidor
// que lea Signature.who esta leyendo un campo sin respaldo criptografico.
//
// Composition.attester esta dentro de entry[] y si esta protegido, asi que es
// el unico lugar donde la declaracion de quien atesta el documento tiene valor
// probatorio a nivel de recurso FHIR. La verdad criptografica sigue siendo el
// certificado dentro de signature.data; attester la hace legible sin abrir el
// objeto JOSE.
// ---------------------------------------------------------------------------
* attester 1..* MS
* attester ^short = "Quien atesta el documento, cubierto por la firma"
* attester ^definition = "Declaracion de quien responde por el contenido del documento clinico. Se exige porque es la unica declaracion de atestacion que la firma digital protege: Signature.who queda fuera de su alcance."
* attester.mode 1..1 MS
* attester.mode ^short = "Modo de atestacion"
* attester.time 1..1 MS
* attester.time ^short = "Momento de la atestacion"
* attester.party 1..1 MS
* attester.party only Reference(CRPractitionerRoleLaboratoryResult or CRPractitionerLaboratoryResult or CROrganizationLaboratoryResult)
* attester.party ^short = "Quien atesta"

* title 1..1 MS
* title ^short = "Título del documento"
* title ^definition = "Título legible para humanos con el que se presenta el documento clínico de resultados de laboratorio en portales, repositorios o visores."

* section 1..* MS
* section ^short = "Secciones del documento"
* section ^definition = "Bloques estructurados del documento clínico que agrupan el contenido del reporte de laboratorio. Para este PoC, una sección debe enlazar al DiagnosticReport principal."
* section.title 1..1 MS
* section.title ^short = "Título de la sección"
* section.title ^definition = "Etiqueta descriptiva de la sección del documento, útil para visores clínicos y navegación del contenido."
* section.entry 1..* MS
* section.entry only Reference(CRDiagnosticReportLaboratoryResult)
* section.entry ^short = "Recursos clínicos referenciados por la sección"
* section.entry ^definition = "Referencias a los recursos que materializan el contenido clínico de la sección. En este PoC se espera enlazar el DiagnosticReport principal del resultado de laboratorio."

* encounter 0..0
* encounter ^short = "Sin encuentro documentado"
* encounter ^definition = "El documento clínico del PoC no modela el encuentro asistencial asociado, ya que el alcance se limita al intercambio del resultado de laboratorio."
