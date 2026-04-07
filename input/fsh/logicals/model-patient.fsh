// ==============================================================================================================
// Modelo Lógico: Datos del Paciente para Resultados de Laboratorio
// Fuente: Perfil de paciente del CORE de Costa Rica (https://hl7.or.cr/fhir/core/StructureDefinition/cr-patient)
// ==============================================================================================================

Logical: LogicalModelPatientLaboratoryResult
Id: LogicalModelPatientLaboratoryResult
Title: "Datos del Paciente"
Description: "Modelo lógico que define los datos del paciente necesarios para representar resultados de laboratorio, basado en el perfil de paciente del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelPatientLaboratoryResult"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

// ─── Datos generales del Paciente ─────────────────────────────────────    

* identificacion 1..1 string "Reacción adversa"
	"Descripción de la reacción adversa. Campo requerido. Máximo 200 caracteres alfanuméricos."

* tipoIdentificador 1..1 code "Tipo de identificador del paciente."
    "Tipo de identificador utilizado para el paciente, representado mediante un concepto de SNOMED CT u otro sistema de codificación relevante. Esto ayuda a clasificar el tipo de identificador, como cédula, número de seguro social, etc."
* tipoIdentificador from CRIdentifierTypesSet (required)

* primerNombre 1..1 string "Primer nombre del paciente."
    "El primer nombre del paciente, utilizado para su identificación. Es un campo obligatorio y debe contener al menos un nombre."

* segundoNombre 0..1 string "Segundo nombre del paciente."
    "El segundo nombre del paciente, utilizado para su identificación. Es un campo opcional y puede estar vacío."

* primerApellido 1..1 string "Primer apellido del paciente."
    "El primer apellido del paciente, utilizado para su identificación. Es un campo obligatorio y debe contener al menos un apellido."

* segundoApellido 0..1 string "Segundo apellido del paciente."
    "El segundo apellido del paciente, utilizado para su identificación. Es un campo opcional y puede estar vacío."

* fechaNacimiento 1..1 date "Fecha de nacimiento del paciente."
    "La fecha de nacimiento del paciente, utilizada para calcular la edad y otros datos demográficos. Es un campo obligatorio."

* edad 1..1 positiveInt "Edad del paciente."
    "La edad del paciente en años, calculada a partir de la fecha de nacimiento. Es un campo obligatorio y debe ser un número entero."    

* sexo 1..1 code "Sexo del paciente."
    "El sexo del paciente, utilizado para fines demográficos y clínicos. Es un campo obligatorio."
* sexo from http://hl7.org/fhir/ValueSet/administrative-gender (required)
