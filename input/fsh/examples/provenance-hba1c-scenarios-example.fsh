// ==============================================================================================================
// Instances: Ejemplos de Provenance para Resultados de Laboratorio HbA1c
// Basado en: CRProvenanceLaboratoryResult
// Flujo cubierto: LIS/Laboratorio → Document Registry → FHIR Repository
// ==============================================================================================================

// --- Escenario 1: Tamizaje EBAIS ---
// El resultado fue generado por el laboratorio del EBAIS Goicoechea 2
// y persistido en el repositorio FHIR de Meddyg.

Instance: ProvenanceHbA1cTamizajeEBAISExample
InstanceOf: CRProvenanceLaboratoryResult
Title: "Provenance HbA1c - Tamizaje EBAIS"
Description: "Ejemplo de Provenance que documenta la cadena de custodia del resultado HbA1c de tamizaje generado en el laboratorio del EBAIS Goicoechea 2 y registrado en el repositorio FHIR."
Usage: #example
* insert VersionedExampleProfile(cr-provenance-laboratory-result)

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Provenance del resultado HbA1c de tamizaje en EBAIS Goicoechea 2.</p></div>"

* target = Reference(DiagnosticReportHbA1cTamizajeEBAISExample)
* recorded = "2026-04-08T08:25:00-06:00"

* agent[autor].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[autor].who = Reference(OrganizationEBAISGoicoechea2LabExample)

* agent[custodio].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#custodian
* agent[custodio].who = Reference(OrganizationMeddygRepositoryExample)

// --- Escenario 2: Seguimiento EBAIS ---
// El resultado fue generado por el mismo laboratorio en una consulta de seguimiento.
// El resultado fue revisado y ajustado antes de ser persistido (entity.role = revision).

Instance: ProvenanceHbA1cSeguimientoEBAISExample
InstanceOf: CRProvenanceLaboratoryResult
Title: "Provenance HbA1c - Seguimiento EBAIS"
Description: "Ejemplo de Provenance para seguimiento HbA1c donde el resultado fue revisado por el profesional antes de ser registrado en el repositorio. Incluye entidad de origen para documentar la revisión."
Usage: #example
* insert VersionedExampleProfile(cr-provenance-laboratory-result)

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Provenance del resultado HbA1c de seguimiento en EBAIS Goicoechea 2, con revisión por profesional.</p></div>"

* target = Reference(DiagnosticReportHbA1cSeguimientoEBAISExample)
* recorded = "2026-04-08T09:45:00-06:00"

* agent[autor].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[autor].who = Reference(OrganizationEBAISGoicoechea2LabExample)

* agent[custodio].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#custodian
* agent[custodio].who = Reference(OrganizationMeddygRepositoryExample)

* entity.role = #revision
* entity.what = Reference(DiagnosticReportHbA1cSeguimientoEBAISExample)

// --- Organización: Repositorio FHIR Meddyg ---
// Organización que actúa como custodio del repositorio FHIR en los ejemplos de Provenance.

Instance: OrganizationMeddygRepositoryExample
InstanceOf: Organization
Title: "Meddyg - Repositorio FHIR"
Description: "Organización Meddyg en su rol de custodio del repositorio FHIR de resultados de laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Meddyg como custodio del repositorio FHIR.</p></div>"
* name = "Meddyg - Repositorio FHIR"
* active = true
* contact[0].telecom[0].system = #url
* contact[0].telecom[0].value = "https://meddyg.com"

Instance: DetachedSignatureHbA1cLaboratoryResultExample
InstanceOf: CRDetachedSignatureProvenanceLaboratoryResult
Title: "Firma Detached HbA1c"
Description: "Ejemplo estructural de la evidencia JAdES detached para una version inmutable del Bundle document HbA1c. El valor de firma es ilustrativo y no debe usarse como evidencia criptografica."
Usage: #example
* insert VersionedExampleProfile(cr-detached-signature-provenance-laboratory-result)

* target[0].reference = "Bundle/BundleHbA1cLaboratoryResultDocumentExample/_history/1"
* recorded = "2026-04-07T09:36:00-06:00"
* agent[0].who = Reference(OrganizationHospitalMexicoLabExample)
* signature[0].type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.1
* signature[0].when = "2026-04-07T09:36:00-06:00"
* signature[0].who = Reference(PractitionerRoleHospitalMexicoLabExample)
* signature[0].targetFormat = #application/fhir+json
* signature[0].sigFormat = #application/jose+json
* signature[0].data = "ZXlKaGJHY2lPaUp1YjI1bEluMC5leUpwYzNNaU9pSnRaV1JrZVdjaUxDSnpkV0lpT2lKaWRXNWtiR1VpZlEu"
* extension[payloadHash].valueString = "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef"
* extension[canonicalization].valueString = "JCS RFC 8785"
