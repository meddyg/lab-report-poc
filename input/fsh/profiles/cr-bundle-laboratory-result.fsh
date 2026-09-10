// ==============================================================================================================
// Profile: Bundle Documento de Resultados de Laboratorio
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

Invariant: cr-bundle-timestamp-no-future
Description: "La fecha de ensamblaje del Bundle no puede ser futura."
Severity: #error
Expression: "$this <= now()"

Invariant: CRBundleCompFirst1
Description: "La primera entrada del documento debe ser Composition."
Severity: #error
Expression: "entry.first().resource.ofType(Composition).exists()"

Invariant: CRBundleJAdESSigFormat1
Description: "Si existe firma, sigFormat debe ser application/jose+json. GAUDI emite la serializacion JSON de JOSE; declarar application/jose hace que los validadores intenten leerla como serializacion compacta y fallen con un error que no dice nada sobre la validez de la firma."
Severity: #error
Expression: "sigFormat = 'application/jose+json'"

Invariant: CRBundleJAdESData1
Description: "Si existe firma, signature.data debe estar presente en base64Binary."
Severity: #error
Expression: "data.exists()"

// ==============================================================================================================
// Invariantes que compensan el alcance de la firma
//
// Medido el 2026-09-09 contra el validador de produccion de GAUDI: el digest cubre
// todo lo que esta dentro de Bundle.entry —cada recurso, su meta, y hasta el fullUrl
// de cada entrada— y deja fuera el sobre de la raiz: id, identifier, type, timestamp
// y meta. Alterar cualquier campo del sobre deja la firma valida.
//
// No se puede hacer que la firma cubra el sobre. Lo que si se puede es exigir que el
// sobre repita informacion que si esta firmada, de modo que alterarlo produzca una
// contradiccion detectable. Ver la pagina Alcance de la firma digital.
// ==============================================================================================================

Invariant: CRBundleIdentMatch1
Description: "Bundle.identifier debe coincidir con Composition.identifier. El identificador del sobre queda fuera del alcance de la firma, asi que se exige que sea copia del que si esta firmado: si alguien re-etiqueta el documento, la copia firmada lo desmiente."
Severity: #error
Expression: "identifier.value = entry.resource.ofType(Composition).identifier.value.single()"

Invariant: CRBundleAttester1
Description: "Un documento firmado debe declarar su atestacion en Composition.attester. Signature.who vive en el sobre y no esta cubierto por la firma, asi que no sirve como declaracion de quien responde por el documento."
Severity: #error
Expression: "signature.exists() implies entry.resource.ofType(Composition).attester.exists()"

Profile: CRBundleLaboratoryResult
Parent: Bundle
Id: cr-bundle-laboratory-result
Title: "Bundle Laboratorio"
Description: "Perfil de Bundle tipo document para intercambio de resultados de laboratorio (HbA1c y glucosa en ayunas) en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-bundle-laboratory-result"
* ^version = "0.3.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR
* obeys CRBundleDR1 and CRBundleComp1 and CRBundleOBS1 and CRBundleDROBSLink1 and CRBundleCompDRSubj1 and CRBundleCompDRType1 and CRBundleCompFirst1 and CRBundleIdentMatch1 and CRBundleAttester1

* type 1..1 MS
* type = #document
* type ^short = "Bundle document"
* type ^definition = "Indica que el recurso es un Bundle de tipo document. ADVERTENCIA: no esta cubierto por la firma digital. Un consumidor debe verificar que exista una Composition conforme al perfil documental y no confiar unicamente en este valor."

* identifier 1..1 MS
* identifier ^short = "Identificador del documento"
* identifier ^definition = "Identificador de negocio del Bundle document. ADVERTENCIA: queda fuera del alcance de la firma digital y puede alterarse sin invalidarla. El invariante CRBundleIdentMatch1 exige que coincida con Composition.identifier, que si esta firmado."
* identifier.system 1..1 MS
* identifier.system ^short = "Sistema del identificador del documento"
* identifier.system ^definition = "Namespace o sistema que gobierna el identificador del Bundle document. Permite comprender el origen del identificador en el contexto del PoC."
* identifier.value 1..1 MS
* identifier.value ^short = "Valor del identificador del documento"
* identifier.value ^definition = "Valor único del identificador de negocio del documento clínico de laboratorio."

* timestamp 1..1 MS
* timestamp ^short = "Fecha de ensamblaje del bundle"
* timestamp ^definition = "Fecha y hora en que el documento fue ensamblado como Bundle. ADVERTENCIA: no esta cubierto por la firma digital. La fecha autoritativa del documento es Composition.date."
* timestamp obeys cr-bundle-timestamp-no-future

* total 0..0
* total ^short = "Sin total"
* total ^definition = "El elemento total no aplica a Bundle document y se excluye para mantener coherencia con el patrón documental del PoC."
* link 0..0
* link ^short = "Sin links globales"
* link ^definition = "No se utilizan enlaces de navegación en el Bundle document del PoC, ya que se trata de un paquete clínico cerrado y no de una respuesta de búsqueda."

* signature 0..1 MS
* signature ^short = "Firma digital del Bundle document"
* signature ^definition = "Firma digital JAdES emitida por GAUDI. Cubre los recursos dentro de entry[] y no el sobre del Bundle. Ver la pagina Alcance de la firma digital."
* signature obeys CRBundleJAdESSigFormat1 and CRBundleJAdESData1
// signature.type, .when y .who viven dentro de Bundle.signature, o sea en el sobre,
// y NO estan cubiertos por el digest: son alterables sin invalidar la firma. Pasan de
// obligatorios a opcionales a proposito. Exigirlos invitaba a apoyarse en campos sin
// respaldo criptografico; la declaracion con valor probatorio es Composition.attester
// y la identidad verificable es el certificado dentro de signature.data.
* signature.type 0..* MS
* signature.type ^short = "Tipo de firma, informativo y NO cubierto por la firma"
* signature.type ^definition = "Tipo de firma segun codificacion estandar. Informativo: vive en el sobre del Bundle y queda fuera del alcance del digest, asi que no debe usarse como evidencia."
* signature.when 0..1 MS
* signature.when ^short = "Fecha de la firma, informativa y NO cubierta por la firma"
* signature.when ^definition = "Instante en que se aplico la firma. Informativo: la fecha con respaldo criptografico es el sello de tiempo RFC 3161 que viaja dentro de signature.data."
* signature.who 0..1 MS
* signature.who ^short = "Firmante declarado, informativo y NO cubierto por la firma"
* signature.who ^definition = "Identidad declarada del firmante. Informativo y alterable sin invalidar la firma. La declaracion con valor probatorio es Composition.attester, y la identidad verificable es el certificado dentro de signature.data."
* signature.sigFormat 1..1 MS
* signature.sigFormat ^short = "Formato de firma"
* signature.sigFormat ^definition = "Formato de la firma digital. Para este perfil se utiliza JAdES (application/jose o application/jose+json)."
* signature.data 1..1 MS
* signature.data ^short = "Firma JAdES en base64"
* signature.data ^definition = "Objeto JOSE en serializacion JSON, codificado en base64. GAUDI lo devuelve sin relleno, asi que un verificador debe usar un decodificador tolerante."

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
* entry[composition] ^definition = "Slice que contiene la Composition principal del documento clínico. Debe existir exactamente una para estructurar el reporte de laboratorio."
* entry[composition].resource only CRCompositionLaboratoryResult
* entry[diagnosticReport] MS
* entry[diagnosticReport] ^short = "Entrada de DiagnosticReport"
* entry[diagnosticReport] ^definition = "Slice que contiene el DiagnosticReport principal del documento. Debe existir exactamente uno y representar el reporte analítico de laboratorio."
* entry[diagnosticReport].resource only CRDiagnosticReportLaboratoryResult
* entry[patient] MS
* entry[patient] ^short = "Entrada de Patient"
* entry[patient] ^definition = "Slice que contiene el paciente referido por el documento clínico y por el resto de recursos relacionados."
* entry[patient].resource only CRPatientLaboratoryResult
* entry[observation] MS
* entry[observation] ^short = "Entradas de Observation"
* entry[observation] ^definition = "Slice que contiene una o más observaciones analíticas vinculadas al DiagnosticReport, como HbA1c o glucosa en ayunas."
* entry[observation].resource only CRObservationLaboratoryResult
* entry[organization] MS
* entry[organization] ^short = "Entradas de Organization"
* entry[organization] ^definition = "Slice para las organizaciones involucradas en la emisión o jerarquía organizacional del resultado, como laboratorio, hospital o CCSS."
* entry[organization].resource only CROrganizationLaboratoryResult
* entry[specimen] MS
* entry[specimen] ^short = "Entradas de Specimen"
* entry[specimen] ^definition = "Slice para las muestras biológicas relacionadas con las observaciones y reportes incluidos en el documento clínico."
* entry[specimen].resource only CRSpecimenLaboratoryResult
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
