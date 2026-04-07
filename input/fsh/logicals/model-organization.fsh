// ==============================================================================================================
// Modelo Lógico: Datos de la Organización para Resultados de Laboratorio
// Fuente: Perfil de organización del CORE de Costa Rica (https://hl7.or.cr/fhir/core/StructureDefinition/cr-organization)
// ==============================================================================================================

Logical: LogicalModelOrganizationLaboratoryResult
Id: LogicalModelOrganizationLaboratoryResult
Title: "Datos de la Organización"
Description: "Modelo lógico que define los datos de la organización necesarios para representar resultados de laboratorio, basado en el perfil de organización del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelOrganizationLaboratoryResult"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* identificacion 1..* Identifier "Identificador de la organización."
    "Identificador único de la organización, utilizado para su identificación en el sistema de salud. Puede incluir números de cédula jurídica, números de registro u otros identificadores relevantes." 

* tipoIdentificador 1..1 code "Tipo de identificador de la organización."
    "Tipo de identificador utilizado para la organización, representado mediante un concepto de SNOMED CT u otro sistema de codificación relevante. Esto ayuda a clasificar el tipo de identificador, como cédula jurídica, número de registro, etc."
* tipoIdentificador from CRIdentifierTypesSet (required)

* nombre 1..1 string "Nombre de la organización."
    "El nombre de la organización, utilizado para su identificación. Es un campo obligatorio y debe contener el nombre oficial de la organización."

* parteDe 0..1 Reference(Organization) "Organización a la que pertenece."
    "Referencia a la organización a la que pertenece esta organización, si aplica. Esto es útil para representar jerarquías organizacionales, como un laboratorio que forma parte de un hospital más grande."   
