// ==============================================================================================================
// Instances: Ejemplos de AuditEvent para Resultados de Laboratorio HbA1c
// Basado en: CRAuditEventLaboratoryResult
//
// Escenarios cubiertos:
//   1. FHIR Repository registra un DiagnosticReport (create)
//   2. FHIR Repository registra consulta de resultado por Client FHIR (read)
//   3. Document Registry registra el índice del documento (create)
//   4. Patient Identity Source registra resolución de identidad (query)
//   5. Consent registra consulta del consentimiento previo (read)
// ==============================================================================================================

// --- 1. FHIR Repository: registro del DiagnosticReport (create) ---
Instance: AuditEventRepositoryCreateDiagnosticReportExample
InstanceOf: CRAuditEventLaboratoryResult
Title: "AuditEvent - FHIR Repository: Registro DiagnosticReport"
Description: "AuditEvent generado por el FHIR Repository al recibir y persistir el DiagnosticReport HbA1c proveniente del laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>AuditEvent: FHIR Repository registró DiagnosticReport HbA1c (create).</p></div>"

* category = http://terminology.hl7.org/CodeSystem/audit-event-type#rest "RESTful Operation"
* code = http://hl7.org/fhir/restful-interaction#create "create"
* action = #C
* severity = #informational
* recorded = "2026-04-08T08:25:10-06:00"
* outcome.code = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"

* agent[solicitante].requestor = true
* agent[solicitante].type = http://dicom.nema.org/resources/ontology/DCM#110153 "Source Role ID"
* agent[solicitante].who = Reference(OrganizationEBAISGoicoechea2LabExample)

* agent[receptor].requestor = false
* agent[receptor].type = http://dicom.nema.org/resources/ontology/DCM#110152 "Destination Role ID"
* agent[receptor].who = Reference(OrganizationMeddygRepositoryExample)

* source.observer = Reference(OrganizationMeddygRepositoryExample)

* entity[0].what = Reference(DiagnosticReportHbA1cTamizajeEBAISExample)
* entity[0].role = http://terminology.hl7.org/CodeSystem/object-role#4 "Domain Resource"

// --- 2. FHIR Repository: consulta de resultado por Client FHIR (read) ---
Instance: AuditEventRepositoryReadDiagnosticReportExample
InstanceOf: CRAuditEventLaboratoryResult
Title: "AuditEvent - FHIR Repository: Consulta DiagnosticReport por Client FHIR"
Description: "AuditEvent generado por el FHIR Repository cuando un Client FHIR consulta el resultado HbA1c de un paciente."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>AuditEvent: FHIR Repository procesó consulta de DiagnosticReport HbA1c por Client FHIR (read).</p></div>"

* category = http://terminology.hl7.org/CodeSystem/audit-event-type#rest "RESTful Operation"
* code = http://hl7.org/fhir/restful-interaction#read "read"
* action = #R
* severity = #informational
* recorded = "2026-04-08T10:05:00-06:00"
* outcome.code = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"

* agent[solicitante].requestor = true
* agent[solicitante].type = http://dicom.nema.org/resources/ontology/DCM#110153 "Source Role ID"
* agent[solicitante].who = Reference(OrganizationMeddygClientExample)

* agent[receptor].requestor = false
* agent[receptor].type = http://dicom.nema.org/resources/ontology/DCM#110152 "Destination Role ID"
* agent[receptor].who = Reference(OrganizationMeddygRepositoryExample)

* source.observer = Reference(OrganizationMeddygRepositoryExample)

* entity[0].what = Reference(DiagnosticReportHbA1cTamizajeEBAISExample)
* entity[0].role = http://terminology.hl7.org/CodeSystem/object-role#4 "Domain Resource"

// --- 3. Document Registry: registro del documento en índice (create) ---
Instance: AuditEventDocumentRegistryCreateExample
InstanceOf: CRAuditEventLaboratoryResult
Title: "AuditEvent - Document Registry: Registro en índice"
Description: "AuditEvent generado por el Document Registry al indexar el documento de resultado HbA1c recibido del laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>AuditEvent: Document Registry indexó documento de resultado HbA1c (create).</p></div>"

* category = http://terminology.hl7.org/CodeSystem/audit-event-type#rest "RESTful Operation"
* code = http://hl7.org/fhir/restful-interaction#create "create"
* action = #C
* severity = #informational
* recorded = "2026-04-08T08:25:05-06:00"
* outcome.code = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"

* agent[solicitante].requestor = true
* agent[solicitante].type = http://dicom.nema.org/resources/ontology/DCM#110153 "Source Role ID"
* agent[solicitante].who = Reference(OrganizationEBAISGoicoechea2LabExample)

* agent[receptor].requestor = false
* agent[receptor].type = http://dicom.nema.org/resources/ontology/DCM#110152 "Destination Role ID"
* agent[receptor].who = Reference(OrganizationDocumentRegistryExample)

* source.observer = Reference(OrganizationDocumentRegistryExample)

* entity[0].what = Reference(DiagnosticReportHbA1cTamizajeEBAISExample)
* entity[0].role = http://terminology.hl7.org/CodeSystem/object-role#4 "Domain Resource"

// --- 4. Patient Identity Source: resolución de identidad del paciente (query) ---
Instance: AuditEventPatientIdentityQueryExample
InstanceOf: CRAuditEventLaboratoryResult
Title: "AuditEvent - Patient Identity Source: Resolución de identidad"
Description: "AuditEvent generado por el Patient Identity Source al recibir una consulta de identidad del paciente desde el Client FHIR antes de acceder al resultado."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>AuditEvent: Patient Identity Source procesó consulta de identidad de paciente (query).</p></div>"

* category = http://terminology.hl7.org/CodeSystem/audit-event-type#rest "RESTful Operation"
* code = http://hl7.org/fhir/restful-interaction#search-type "search-type"
* action = #E
* severity = #informational
* recorded = "2026-04-08T10:04:50-06:00"
* outcome.code = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"

* agent[solicitante].requestor = true
* agent[solicitante].type = http://dicom.nema.org/resources/ontology/DCM#110153 "Source Role ID"
* agent[solicitante].who = Reference(OrganizationMeddygClientExample)

* agent[receptor].requestor = false
* agent[receptor].type = http://dicom.nema.org/resources/ontology/DCM#110152 "Destination Role ID"
* agent[receptor].who = Reference(OrganizationPatientIdentitySourceExample)

* source.observer = Reference(OrganizationPatientIdentitySourceExample)

* entity[0].what = Reference(PatientHbA1cTamizajeEBAISExample)
* entity[0].role = http://terminology.hl7.org/CodeSystem/object-role#1 "Patient"

// --- 5. Consent: consulta del consentimiento previo del paciente (read) ---
Instance: AuditEventConsentReadExample
InstanceOf: CRAuditEventLaboratoryResult
Title: "AuditEvent - Consent: Consulta de consentimiento previo"
Description: "AuditEvent generado por el sistema de Consent al ser consultado para verificar que el paciente autorizó el acceso al resultado HbA1c."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>AuditEvent: Sistema de Consent procesó consulta de consentimiento previo del paciente (read).</p></div>"

* category = http://terminology.hl7.org/CodeSystem/audit-event-type#rest "RESTful Operation"
* code = http://hl7.org/fhir/restful-interaction#read "read"
* action = #R
* severity = #informational
* recorded = "2026-04-08T10:04:55-06:00"
* outcome.code = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"

* agent[solicitante].requestor = true
* agent[solicitante].type = http://dicom.nema.org/resources/ontology/DCM#110153 "Source Role ID"
* agent[solicitante].who = Reference(OrganizationMeddygRepositoryExample)

* agent[receptor].requestor = false
* agent[receptor].type = http://dicom.nema.org/resources/ontology/DCM#110152 "Destination Role ID"
* agent[receptor].who = Reference(OrganizationConsentServiceExample)

* source.observer = Reference(OrganizationConsentServiceExample)

* entity[0].what.display = "Consent HbA1c Tamizaje - Paciente autorizado"
* entity[0].role = http://terminology.hl7.org/CodeSystem/object-role#4 "Domain Resource"

// ==============================================================================================================
// Organizaciones de soporte para ejemplos AuditEvent
// ==============================================================================================================

Instance: OrganizationMeddygClientExample
InstanceOf: Organization
Title: "Meddyg - Client FHIR"
Description: "Organización Meddyg en su rol de Client FHIR que solicita resultados de laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Meddyg como Client FHIR solicitante de resultados.</p></div>"
* name = "Meddyg - Client FHIR"
* active = true
* contact[0].telecom[0].system = #url
* contact[0].telecom[0].value = "https://meddyg.com"

Instance: OrganizationDocumentRegistryExample
InstanceOf: Organization
Title: "Document Registry - PoC Costa Rica"
Description: "Sistema de registro de documentos clínicos del ecosistema FHIR del PoC de Costa Rica."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Document Registry del PoC de Costa Rica.</p></div>"
* name = "Document Registry - PoC Costa Rica"
* active = true

Instance: OrganizationPatientIdentitySourceExample
InstanceOf: Organization
Title: "Patient Identity Source - PoC Costa Rica"
Description: "Sistema de identificación de pacientes del ecosistema FHIR del PoC de Costa Rica."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Patient Identity Source del PoC de Costa Rica.</p></div>"
* name = "Patient Identity Source - PoC Costa Rica"
* active = true

Instance: OrganizationConsentServiceExample
InstanceOf: Organization
Title: "Consent Service - PoC Costa Rica"
Description: "Sistema de gestión de consentimientos del ecosistema FHIR del PoC de Costa Rica."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Servicio de Consent del PoC de Costa Rica.</p></div>"
* name = "Consent Service - PoC Costa Rica"
* active = true
