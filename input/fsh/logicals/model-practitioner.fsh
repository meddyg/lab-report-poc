// ==============================================================================================================
// Modelo Lógico: Datos del Profesional de Salud para Resultados de Laboratorio
// Fuente: Perfil de practitioner del CORE de Costa Rica (https://hl7.or.cr/fhir/core/StructureDefinition/cr-core-practitioner)
// ==============================================================================================================

Logical: LogicalModelPractitionerLaboratoryResult
Id: LogicalModelPractitionerLaboratoryResult
Title: "Datos del Profesional de Salud"
Description: "Modelo lógico que define los datos del profesional de salud necesarios para representar resultados de laboratorio, basado en el perfil de practitioner del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelPractitionerLaboratoryResult"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* identificacion 1..1 Identifier "Identificador del profesional de salud."
    "Identificador único del profesional de salud, utilizado para su identificación en el sistema de salud. Puede incluir números de cédula, números de licencia u otros identificadores relevantes."

* tipoIdentificador 1..1 code "Tipo de identificador del profesional de salud."
    "Tipo de identificador utilizado para el profesional de salud, representado mediante un concepto de SNOMED CT u otro sistema de codificación relevante. Esto ayuda a clasificar el tipo de identificador, como cédula, número de licencia, etc."
* tipoIdentificador from CRIdentifierTypesSet (required)

* primerNombre 1..1 string "Primer nombre del profesional de salud."
    "El primer nombre del profesional de salud, utilizado para su identificación. Es un campo obligatorio y debe contener al menos un nombre."

* segundoNombre 0..1 string "Segundo nombre del profesional de salud."
    "El segundo nombre del profesional de salud, utilizado para su identificación. Es un campo opcional y puede estar vacío."

* primerApellido 1..1 string "Primer apellido del profesional de salud."
    "El primer apellido del profesional de salud, utilizado para su identificación. Es un campo obligatorio y debe contener al menos un apellido."

* segundoApellido 0..1 string "Segundo apellido del profesional de salud."
    "El segundo apellido del profesional de salud, utilizado para su identificación. Es un campo opcional y puede estar vacío."

* sexo 1..1 code "Sexo del profesional de salud."
    "El sexo del profesional de salud, utilizado para fines demográficos y clínicos. Es un campo obligatorio."
* sexo from http://hl7.org/fhir/ValueSet/administrative-gender (required)