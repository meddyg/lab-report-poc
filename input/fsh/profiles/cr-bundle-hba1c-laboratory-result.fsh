// ==============================================================================================================
// Profile: Bundle Documento HbA1c para Resultados de Laboratorio
// ==============================================================================================================

Invariant: CRBundleDR1
Description: "El documento debe incluir uno y solo un DiagnosticReport."
Severity: #error
Expression: "entry.resource.ofType(DiagnosticReport).count() = 1"

Invariant: CRBundleComp1
Description: "El documento debe incluir una y solo una Composition."
Severity: #error
Expression: "entry.resource.ofType(Composition).count() = 1"

Invariant: CRBundleOBS1
Description: "El documento debe incluir al menos una Observation de laboratorio."
Severity: #error
Expression: "entry.resource.ofType(Observation).exists()"

Invariant: CRBundleDROBSLink1
Description: "Debe existir al menos un DiagnosticReport con result que resuelva a una Observation del documento."
Severity: #error
Expression: "entry.resource.ofType(DiagnosticReport).where(result.resolve().ofType(Observation).exists()).exists()"

Invariant: CRBundleCompDRSubj1
Description: "Composition y DiagnosticReport deben referenciar el mismo sujeto."
Severity: #error
Expression: "entry.resource.ofType(Composition).subject.reference.single() = entry.resource.ofType(DiagnosticReport).subject.reference.single()"

Invariant: CRBundleCompDRType1
Description: "La Composition debe enlazar al menos un DiagnosticReport del documento mediante section.entry."
Severity: #error
Expression: "entry.resource.ofType(Composition).section.entry.resolve().ofType(DiagnosticReport).exists()"

Invariant: CRBundleCompFirst1
Description: "La primera entrada del documento debe ser Composition."
Severity: #error
Expression: "entry.first().resource.ofType(Composition).exists()"

Profile: CRBundleHbA1cLaboratoryResult
Parent: Bundle
Id: cr-bundle-hba1c-laboratory-result
Title: "Bundle HbA1c"
Description: "Perfil de Bundle tipo document para intercambio de resultado de laboratorio HbA1c centrado en Composition y DiagnosticReport en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-bundle-hba1c-laboratory-result"
* ^version = "0.1.2"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR
* obeys CRBundleDR1 and CRBundleComp1 and CRBundleOBS1 and CRBundleDROBSLink1 and CRBundleCompDRSubj1 and CRBundleCompDRType1 and CRBundleCompFirst1

* type 1..1 MS
* type = #document
* type ^short = "Bundle document"
* type ^definition = "Indica que el recurso es un Bundle de tipo document, usado para transportar un documento clínico completo del resultado HbA1c con sus recursos enlazados."

* identifier 1..1 MS
* identifier ^short = "Identificador del documento"
* identifier ^definition = "Identificador de negocio del Bundle document que permite reconocer de forma única el documento clínico de resultado HbA1c durante intercambio, almacenamiento o auditoría."
* identifier.system 1..1 MS
* identifier.system ^short = "Sistema del identificador del documento"
* identifier.system ^definition = "Namespace o sistema que gobierna el identificador del Bundle document. Permite comprender el origen del identificador en el contexto del PoC."
* identifier.value 1..1 MS
* identifier.value ^short = "Valor del identificador del documento"
* identifier.value ^definition = "Valor único del identificador de negocio del documento clínico de laboratorio."

* timestamp 1..1 MS
* timestamp ^short = "Fecha de ensamblaje del bundle"
* timestamp ^definition = "Fecha y hora en que el documento clínico fue ensamblado como Bundle para ser compartido o publicado."

* total 0..0
* total ^short = "Sin total"
* total ^definition = "El elemento total no aplica a Bundle document y se excluye para mantener coherencia con el patrón documental del PoC."
* link 0..0
* link ^short = "Sin links globales"
* link ^definition = "No se utilizan enlaces de navegación en el Bundle document del PoC, ya que se trata de un paquete clínico cerrado y no de una respuesta de búsqueda."

* entry 5..* MS
* entry ^short = "Entradas del documento clínico"
* entry ^definition = "Conjunto de recursos incluidos dentro del Bundle document. Debe contener los recursos mínimos necesarios para representar de forma íntegra y trazable el resultado HbA1c."
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #open
* entry contains
	composition 1..1 and
	diagnosticReport 1..1 and
	patient 1..1 and
	observation 1..* and
	organization 1..* and
	specimen 0..* and
	practitioner 0..* and
	practitionerRole 0..*
* entry[composition] MS
* entry[composition] ^short = "Entrada de Composition"
* entry[composition] ^definition = "Slice que contiene la Composition principal del documento clínico. Debe existir exactamente una para estructurar el reporte HbA1c."
* entry[composition].resource only CRCompositionHbA1cLaboratoryResult
* entry[diagnosticReport] MS
* entry[diagnosticReport] ^short = "Entrada de DiagnosticReport"
* entry[diagnosticReport] ^definition = "Slice que contiene el DiagnosticReport principal del documento. Debe existir exactamente uno y representar el reporte analítico HbA1c."
* entry[diagnosticReport].resource only CRDiagnosticReportHbA1cLaboratoryResult
* entry[patient] MS
* entry[patient] ^short = "Entrada de Patient"
* entry[patient] ^definition = "Slice que contiene el paciente referido por el documento clínico y por el resto de recursos relacionados."
* entry[patient].resource only CRPatientLaboratoryResult
* entry[observation] MS
* entry[observation] ^short = "Entradas de Observation"
* entry[observation] ^definition = "Slice que contiene una o más observaciones analíticas vinculadas al DiagnosticReport. En este PoC debe incluir la observación HbA1c."
* entry[observation].resource only CRObservationHbA1cLaboratoryResult
* entry[organization] MS
* entry[organization] ^short = "Entradas de Organization"
* entry[organization] ^definition = "Slice para las organizaciones involucradas en la emisión o jerarquía organizacional del resultado, como laboratorio, hospital o CCSS."
* entry[organization].resource only CROrganizationLaboratoryResult
* entry[specimen] MS
* entry[specimen] ^short = "Entradas de Specimen"
* entry[specimen] ^definition = "Slice para las muestras biológicas relacionadas con las observaciones y reportes incluidos en el documento clínico."
* entry[specimen].resource only CRSpecimenHbA1cLaboratoryResult
* entry[practitioner] MS
* entry[practitioner] ^short = "Entradas de Practitioner"
* entry[practitioner] ^definition = "Slice para profesionales individuales involucrados en el flujo del resultado, cuando se requiera incluir su recurso explícitamente dentro del documento."
* entry[practitioner].resource only CRPractitionerLaboratoryResult
* entry[practitionerRole] MS
* entry[practitionerRole] ^short = "Entradas de PractitionerRole"
* entry[practitionerRole] ^definition = "Slice para roles profesionales que contextualizan la participación del profesional dentro de una organización clínica o de laboratorio."
* entry[practitionerRole].resource only CRPractitionerRoleLaboratoryResult
* entry.link 0..0
* entry.link ^short = "Sin links por entrada"
* entry.link ^definition = "Las entradas del Bundle document no utilizan enlaces de navegación, ya que no provienen de una búsqueda ni de una respuesta paginada."
* entry.fullUrl 1..1 MS
* entry.fullUrl ^short = "URL absoluta de la entrada"
* entry.fullUrl ^definition = "URL absoluta que identifica de forma única cada recurso dentro del documento y permite que las referencias internas del Bundle sean resolubles durante la validación y el intercambio."
* entry.resource 1..1 MS
* entry.resource ^short = "Recurso contenido en la entrada"
* entry.resource ^definition = "Recurso clínico o administrativo incluido en la entrada del Bundle document. Cada recurso aporta una parte esencial de la semántica del resultado HbA1c."
* entry.search 0..0
* entry.search ^short = "Sin metadatos de búsqueda"
* entry.search ^definition = "Los metadatos de búsqueda no aplican en Bundle document y se excluyen para reforzar el patrón documental del PoC."
* entry.request 0..0
* entry.request ^short = "Sin metadatos de request"
* entry.request ^definition = "Los detalles de request no aplican en un documento clínico persistente o intercambiado como Bundle document."
* entry.response 0..0
* entry.response ^short = "Sin metadatos de response"
* entry.response ^definition = "Los detalles de response HTTP o transaccional no forman parte del documento clínico de laboratorio y se excluyen del perfil."
