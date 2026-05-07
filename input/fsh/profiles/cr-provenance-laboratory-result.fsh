// ==============================================================================================================
// Profile: Procedencia del Resultado de Laboratorio
// Representa la cadena de custodia y origen de un resultado de laboratorio en el flujo:
//   LIS/Laboratorio → Document Registry → FHIR Repository
// ==============================================================================================================

Profile: CRProvenanceLaboratoryResult
Parent: Provenance
Id: cr-provenance-laboratory-result
Title: "Provenance Resultado de Laboratorio"
Description: "Perfil de trazabilidad para documentar el origen y la cadena de custodia de los resultados de laboratorio (DiagnosticReport) en el PoC de Costa Rica. Cubre el flujo desde el sistema de origen (LIS o laboratorio) hasta el repositorio FHIR."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-provenance-laboratory-result"
* ^version = "0.1.3"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// --- Target ---
* target 1..* MS
* target only Reference(DiagnosticReport)
* target ^short = "Reporte de laboratorio al que aplica esta provenance"
* target ^definition = "Referencia al DiagnosticReport cuya cadena de custodia se documenta."

// --- Recorded ---
* recorded 1..1 MS
* recorded ^short = "Fecha y hora en que se registró esta provenance"
* recorded ^definition = "Instante en que el sistema registró la provenance. No debe ser anterior al recurso target."

// --- Agente: Autor (laboratorio/LIS) ---
* agent 1..* MS
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent ^short = "Sistemas o personas que participaron en la cadena de custodia"
* agent ^definition = "Agentes involucrados en la generación, revisión o custodia del resultado de laboratorio. Se diferencian por su rol (autor, custodio) y tipo (organización, profesional)."

* agent contains
    autor 1..1 MS and
    custodio 1..1 MS

* agent[autor].type 1..1 MS
* agent[autor].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[autor].type ^short = "Rol: autor (laboratorio/LIS que generó el resultado)"
* agent[autor].type ^definition = "El agente autor es el sistema o persona que generó el resultado de laboratorio, típicamente el laboratorio clínico o el sistema LIS que procesó la muestra y produjo el resultado."

* agent[autor].who 1..1 MS
* agent[autor].who only Reference(Organization or Practitioner or PractitionerRole)
* agent[autor].who ^short = "Laboratorio u organización que generó el resultado"
* agent[autor].who ^definition = "Referencia a la organización, profesional o rol profesional que actuó como autor del resultado de laboratorio. En el contexto de este PoC, suele ser el laboratorio clínico que procesó la muestra."

* agent[custodio].type 1..1 MS
* agent[custodio].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#custodian
* agent[custodio].type ^short = "Rol: custodio (repositorio FHIR que persiste el resultado)"
* agent[custodio].type ^definition = "El agente custodio es el sistema u organización responsable de la custodia del resultado de laboratorio una vez que ha sido registrado en el repositorio FHIR. En este PoC, suele ser el repositorio FHIR que almacena el resultado para su consulta por parte de otros sistemas o profesionales."

* agent[custodio].who 1..1 MS
* agent[custodio].who only Reference(Organization)
* agent[custodio].who ^short = "Organización responsable del repositorio FHIR"
* agent[custodio].who ^definition = "Referencia a la organización que actúa como custodio del resultado de laboratorio en el repositorio FHIR. En este PoC, se utiliza una organización ficticia 'Meddyg - Repositorio FHIR' para representar este rol."

// --- Entidad de origen (opcional, para transformaciones) ---
* entity MS
* entity ^short = "Recurso fuente si el resultado fue transformado o transcrito"
* entity ^definition = "Referencia al recurso original que dio origen al resultado de laboratorio, especialmente si el resultado fue transformado, transcrito o ajustado antes de ser registrado en el repositorio FHIR. Por ejemplo, podría ser un mensaje HL7 v2 original del laboratorio o un documento fuente que se utilizó para generar el DiagnosticReport."

* entity.role MS
* entity.role ^short = "Rol de la entidad: source | derivation | revision"
* entity.role ^definition = "Rol que describe la relación de la entidad con el resultado de laboratorio. 'source' indica que la entidad es la fuente original del resultado, 'derivation' indica que el resultado fue derivado o transformado a partir de la entidad, y 'revision' indica que el resultado fue revisado o ajustado basándose en la entidad."

* entity.what MS
* entity.what ^short = "Referencia al recurso original (p. ej. mensaje HL7 v2 o documento fuente)"
* entity.what ^definition = "Referencia al recurso que sirvió como fuente o base para el resultado de laboratorio. Esto es especialmente relevante si el resultado fue transformado o revisado antes de ser registrado en el repositorio FHIR, ya que permite rastrear la procedencia hasta el recurso original."
