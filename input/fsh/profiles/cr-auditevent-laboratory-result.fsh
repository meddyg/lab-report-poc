// ==============================================================================================================
// Profile: AuditEvent para Resultados de Laboratorio
// Cubre los eventos de auditoría generados por los actores del flujo:
//   Client FHIR → Patient Identity Source → Consent → Document Registry → FHIR Repository
//
// Responsabilidad por actor:
//   - FHIR Repository    → create (registro), read (consulta de resultado)
//   - Document Registry  → create (registro de documento), query (búsqueda de índice)
//   - Patient Identity   → query (resolución de identidad)
//   - Consent            → read (consulta de consentimiento)
//   - Client FHIR        → read (solicitud de resultado)
// ==============================================================================================================

Profile: CRAuditEventLaboratoryResult
Parent: AuditEvent
Id: cr-auditevent-laboratory-result
Title: "AuditEvent Resultado de Laboratorio"
Description: "Perfil de auditoría para registrar los eventos de acceso y modificación de resultados de laboratorio en el flujo del PoC de Costa Rica. Cada actor del flujo (FHIR Repository, Document Registry, Patient Identity Source, Consent, Client FHIR) debe generar un AuditEvent por cada acción relevante."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-auditevent-laboratory-result"
* ^version = "0.1.3"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// --- Categoría: tipo de evento ---
* category 1..1 MS
* category from http://hl7.org/fhir/ValueSet/audit-event-type (extensible)
* category ^short = "Categoría del evento (REST, DICOM, etc.)"
* category ^definition = "Categoría del evento de auditoría. Para este perfil se usa la categoría REST para todos los eventos del flujo."

// --- Código: acción específica ---
* code 1..1 MS
* code from http://hl7.org/fhir/ValueSet/audit-event-sub-type (extensible)
* code ^short = "Tipo específico de acción (read, create, query, etc.)"
* code ^definition = "Código que identifica la acción específica auditada. Los valores esperados según el actor son: 'create' para registro de recursos, 'read' para consulta, 'query' para búsqueda en índice o identidad."

// --- Acción: C R U D E ---
* action 1..1 MS
* action ^short = "Acción CRUD: C=create, R=read, U=update, D=delete, E=execute"
* action ^definition = "Acción de alto nivel realizada. Debe alinearse con el código específico: C para registro de nuevos recursos, R para consultas de resultado o consentimiento, E para búsquedas/queries."

// --- Severidad ---
* severity MS
* severity ^short = "Severidad del evento (informational para flujo normal)"

// --- Timestamp ---
* recorded 1..1 MS
* recorded ^short = "Fecha y hora del evento"
* recorded ^definition = "Instante exacto en que ocurrió el evento. El sistema que genera el AuditEvent debe usar su hora local con timezone."

// --- Resultado ---
* outcome 1..1 MS
* outcome ^short = "Resultado del evento: éxito o fallo"
* outcome ^definition = "Indica si el evento fue exitoso (0) o si ocurrió un error (4, 8, 12). En flujos normales el valor esperado es éxito."

// --- Agente: quién realizó la acción ---
* agent 1..* MS
* agent ^short = "Actor que realizó o solicitó la acción"
* agent ^slicing.discriminator.type = #value
* agent ^slicing.discriminator.path = "requestor"
* agent ^slicing.rules = #open

* agent contains
    solicitante 1..1 MS and
    receptor 0..1 MS

* agent[solicitante].requestor = true
* agent[solicitante].requestor ^short = "true: este agente inició la solicitud"
* agent[solicitante].who 1..1 MS
* agent[solicitante].who only Reference(Organization or Practitioner or PractitionerRole or Patient or Device)
* agent[solicitante].who ^short = "Sistema o persona que inició la acción"
* agent[solicitante].type MS
* agent[solicitante].type ^short = "Rol del agente solicitante (Client, Source, etc.)"

* agent[receptor].requestor = false
* agent[receptor].requestor ^short = "false: este agente recibió/procesó la solicitud"
* agent[receptor].who 1..1 MS
* agent[receptor].who only Reference(Organization or Device)
* agent[receptor].who ^short = "Sistema que recibió y procesó la solicitud"
* agent[receptor].type MS
* agent[receptor].type ^short = "Rol del agente receptor (Repository, Registry, etc.)"

// --- Fuente: sistema que genera el AuditEvent ---
* source 1..1 MS
* source.observer 1..1 MS
* source.observer only Reference(Organization or Device)
* source.observer ^short = "Sistema que genera y reporta este AuditEvent"
* source.observer ^definition = "Identifica el sistema responsable de generar este registro de auditoría. Es el actor del flujo que registra el evento (p. ej. el FHIR Repository registra los accesos a sus recursos)."

// --- Entidad: recurso afectado ---
* entity 1..* MS
* entity ^short = "Recurso FHIR sobre el que se realizó la acción"
* entity ^definition = "Referencia al recurso FHIR que fue creado, consultado o modificado. Para accesos a resultados de laboratorio, el recurso principal es el DiagnosticReport o la Observation."
* entity.what 1..1 MS
* entity.what ^short = "Referencia al recurso afectado (DiagnosticReport, Patient, Consent, etc.)"
* entity.role MS
* entity.role ^short = "Rol del recurso en el evento (object, query, etc.)"
