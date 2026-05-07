# Seguridad y Trazabilidad

Esta página describe el modelo de seguridad y trazabilidad aplicado en el flujo de resultados de laboratorio del PoC de Costa Rica, cubriendo los recursos FHIR `Provenance` y `AuditEvent`.

---

## Flujo de actores

El flujo de intercambio de resultados de laboratorio involucra los siguientes actores:

```
Client FHIR → Patient Identity Source → Consent → Document Registry → FHIR Repository
```

Cada actor tiene responsabilidades específicas de trazabilidad, diferenciadas entre **cadena de custodia del dato** (`Provenance`) y **registro de eventos de acceso** (`AuditEvent`).

---

## Provenance — Cadena de Custodia

El recurso `Provenance` documenta **el origen y la historia del resultado de laboratorio**: quién lo generó, quién lo transformó y quién lo custodia.

### ¿Quién genera Provenance?

El **FHIR Repository** genera el `Provenance` en el momento en que registra un nuevo `DiagnosticReport`, documentando los agentes participantes.

### Estructura mínima

| Campo | Valor esperado |
|---|---|
| `target` | Referencia al `DiagnosticReport` |
| `recorded` | Timestamp del registro |
| `agent[autor]` | Laboratorio/LIS que generó el resultado |
| `agent[custodio]` | Organización responsable del repositorio FHIR |
| `entity` *(opcional)* | Recurso fuente si el resultado fue transformado o transcrito |

### Cuándo incluir `entity`

Incluir `entity` cuando el resultado pasó por una transformación antes de ser registrado (por ejemplo, transcripción desde HL7 v2 o revisión por un profesional). El campo `entity.role` indica el tipo de transformación:

- `source` — el recurso es la fuente original sin cambios
- `derivation` — el resultado fue derivado o transformado
- `revision` — el resultado fue revisado y ajustado

---

## AuditEvent — Registro de Eventos de Acceso

El recurso `AuditEvent` registra **quién hizo qué, sobre qué recurso y cuándo**. A diferencia de `Provenance`, que describe el origen del dato, `AuditEvent` describe las interacciones con el sistema.

### Responsabilidad por actor

Cada actor del flujo **genera su propio `AuditEvent`** para las acciones que él procesa (principio: el sistema que recibe la solicitud es responsable de registrarla).

| Actor | Acción que registra | `action` FHIR | Recurso afectado |
|---|---|---|---|
| **FHIR Repository** | Registro de nuevo resultado | `C` (create) | `DiagnosticReport` |
| **FHIR Repository** | Consulta de resultado por Client | `R` (read) | `DiagnosticReport` |
| **Document Registry** | Indexación del documento | `C` (create) | `DiagnosticReport` |
| **Document Registry** | Búsqueda en índice | `E` (execute/query) | Parámetros de búsqueda |
| **Patient Identity Source** | Resolución de identidad | `E` (execute/query) | `Patient` |
| **Consent** | Consulta de consentimiento previo | `R` (read) | `Consent` |
| **Client FHIR** | Solicitud de resultado *(recomendado)* | `R` (read) | `DiagnosticReport` |

> **Nota:** El Client FHIR puede también registrar AuditEvents de forma local para sus propios fines de auditoría, aunque no es obligatorio en este PoC.

### Estructura mínima

| Campo | Valor esperado |
|---|---|
| `category` | `rest` (operación RESTful) |
| `code` | Interacción específica: `create`, `read`, `search-type` |
| `action` | `C`, `R`, `U`, `D`, `E` |
| `recorded` | Timestamp del evento con timezone |
| `outcome` | `0` (éxito) o código de error |
| `agent[solicitante]` | Sistema o persona que inició la acción (`requestor = true`) |
| `agent[receptor]` | Sistema que recibió y procesó la solicitud (`requestor = false`) |
| `source.observer` | Sistema que genera este AuditEvent |
| `entity[0].what` | Recurso FHIR afectado |

---

## Relación entre Provenance y AuditEvent

Ambos recursos son complementarios y no se reemplazan:

| Aspecto | Provenance | AuditEvent |
|---|---|---|
| **¿Qué documenta?** | Origen y custodia del dato | Quién accedió y cuándo |
| **¿Cuándo se genera?** | Al crear/transformar el recurso | En cada interacción con el sistema |
| **¿Quién lo genera?** | FHIR Repository (al registrar) | Cada actor del flujo (al procesar) |
| **¿Está en el recurso?** | Sí, como recurso separado vinculado | Sí, como recurso separado |
| **Propósito principal** | Trazabilidad clínica del dato | Auditoría de seguridad y acceso |
