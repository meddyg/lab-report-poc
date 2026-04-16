// ==============================================================================================================
// Modelo Lógico: Datos de la Organización para Resultados de Laboratorio
// Fuente: Perfil de organización del CORE de Costa Rica (https://hl7.or.cr/fhir/core/StructureDefinition/cr-organization)
// ==============================================================================================================

Logical: LogicalModelOrganizationLaboratoryResult
Id: LogicalModelOrganizationLaboratoryResult
Title: "Datos de la Organización"
Description: "Modelo lógico que define los datos de la organización necesarios para representar resultados de laboratorio, basado en el perfil de organización del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelOrganizationLaboratoryResult"
* ^version = "0.1.1"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* identificacion 1..* Identifier "Identificador de la organización."
    "Identificadores que permiten reconocer de forma inequívoca a la organización participante en el PoC, por ejemplo CCSS, hospital, EBAIS o laboratorio clínico. Pueden incluir cédula jurídica u otros identificadores institucionales."

* tipoIdentificador 1..1 code "Tipo de identificador de la organización."
    "Tipo del identificador organizacional utilizado para la entidad emisora o relacionada con el resultado. Permite interpretar si se trata de cédula jurídica, identificador institucional u otra clave organizacional."
* tipoIdentificador from CRIdentifierTypesSet (required)

* nombre 1..1 string "Nombre de la organización."
    "Nombre oficial de la organización involucrada en el flujo del resultado de laboratorio, tal como debe presentarse a implementadores, repositorios, visores y documentos clínicos."

* parteDe 0..1 Reference(Organization) "Organización a la que pertenece."
    "Referencia a la organización padre cuando exista una jerarquía organizacional, por ejemplo un laboratorio que depende de un hospital o un hospital que depende de la CCSS."
