// ==============================================================================================================
// Profile: Organización para Resultados de Laboratorio
// Basado en: LogicalModelOrganizationLaboratoryResult
// ==============================================================================================================

Profile: CROrganizationLaboratoryResult
Parent: Organization
Id: cr-organization-laboratory-result
Title: "Organization - Resultados de Laboratorio"
Description: "Perfil de organización que define los datos de la organización necesarios para representar resultados de laboratorio, basado en el modelo lógico LogicalModelOrganizationLaboratoryResult y el perfil de organización del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-organization-laboratory-result"
* ^version = "0.1.1"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// Identificadores de la organización (tipoIdentificador + identificacion del modelo lógico)
* identifier 1..* MS
  * ^short = "Identificadores de la organización"
  * ^definition = "Identificadores que permiten reconocer de forma inequívoca a la organización participante en el intercambio del resultado de laboratorio, por ejemplo la CCSS, un hospital, un EBAIS o un laboratorio clínico."
  * type 1..1 MS
    * ^short = "Tipo de identificador de la organización"
    * ^definition = "Clasifica el identificador organizacional, por ejemplo cédula jurídica o identificador institucional, para facilitar la interoperabilidad entre establecimientos y laboratorios del sistema de salud costarricense."
  * type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-identifier-types (required)
  * system 1..1 MS
    * ^short = "Sistema del identificador organizacional"
    * ^definition = "Namespace o URI del dominio que emite o gobierna el identificador de la organización. Ayuda a distinguir identificadores nacionales, institucionales o de un caso de uso particular del PoC."
  * value 1..1 MS
    * ^short = "Identificador de la organización"
    * ^definition = "Identificador único de la organización, utilizado para su identificación en el sistema de salud."

// Nombre de la organización (nombre del modelo lógico)
* name 1..1 MS
  * ^short = "Nombre de la organización"
  * ^definition = "Nombre oficial de la organización, utilizado para su identificación."

// Organización superior (parteDe del modelo lógico)
* partOf 0..1 MS
  * ^short = "Organización a la que pertenece"
  * ^definition = "Referencia a la organización a la que pertenece esta organización, para representar jerarquías organizacionales."

// Elementos que no se incluyen en el perfil para resultados de laboratorio:
* contact 0..0
  * ^short = "Sin contactos en el PoC"
  * ^definition = "La captura de contactos administrativos o asistenciales de la organización no forma parte del alcance de este PoC para resultados HbA1c y por ello se excluye del perfil."
* endpoint 0..0
  * ^short = "Sin endpoints en el perfil"
  * ^definition = "La información de endpoints técnicos de interoperabilidad de la organización no se modela en este perfil simplificado del PoC, ya que el objetivo es describir la organización clínica emisora o relacionada con el resultado."
