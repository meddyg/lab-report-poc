// ==============================================================================================================
// Modelo Lógico: Datos del Paciente para Resultados de Laboratorio
// Fuente: Perfil de paciente del CORE de Costa Rica (https://hl7.or.cr/fhir/core/StructureDefinition/cr-patient)
// ==============================================================================================================

Logical: LogicalModelPatientLaboratoryResult
Id: LogicalModelPatientLaboratoryResult
Title: "Datos del Paciente"
Description: "Modelo lógico que define los datos del paciente necesarios para representar resultados de laboratorio, basado en el perfil de paciente del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelPatientLaboratoryResult"
* ^version = "0.1.8"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

// ─── Datos generales del Paciente ─────────────────────────────────────

* identificacion 1..* Identifier "Identificador(es) del paciente."
    "Conjunto de identificadores del paciente en formato Identifier. Cada identificador debe incluir system y value, y su tipo debe pertenecer al conjunto CRIdentifierTypesSet (por ejemplo cédula nacional, pasaporte o DIMEX). Permite representar uno o varios identificadores por persona según la realidad operativa del emisor."
* identificacion.type from CRIdentifierTypesSet (required)

* primerNombre 1..1 string "Primer nombre del paciente."
    "Primer nombre oficial del paciente, utilizado para identificación humana, conciliación visual y presentación del resultado HbA1c en sistemas clínicos o administrativos."

* segundoNombre 0..1 string "Segundo nombre del paciente."
    "Segundo nombre del paciente cuando exista en los registros de la institución o del ecosistema de salud costarricense. Su uso mejora la identificación humana y la calidad documental."

* primerApellido 1..1 string "Primer apellido del paciente."
    "Primer apellido del paciente según el patrón de identificación personal utilizado en Costa Rica. Es obligatorio para la adecuada identificación administrativa y clínica."

* segundoApellido 0..1 string "Segundo apellido del paciente."
    "Segundo apellido del paciente cuando aplique. En el contexto costarricense este dato suele ser relevante para la identificación completa de la persona y la correcta visualización del resultado de laboratorio."

* fechaNacimiento 1..1 date "Fecha de nacimiento del paciente."
    "Fecha de nacimiento del paciente, usada para identificación demográfica, cálculo de edad y validaciones clínicas o administrativas asociadas al resultado HbA1c."

* edad 1..1 positiveInt "Edad del paciente."
    "Edad del paciente expresada en años al momento del episodio o contexto del resultado de laboratorio. Se incluye para facilitar visualización o consumo en sistemas que aún requieren este dato de forma explícita."

* sexo 1..1 code "Sexo del paciente."
    "Sexo administrativo del paciente, utilizado para interoperabilidad demográfica y como apoyo a la correcta identificación del sujeto del resultado HbA1c."
* sexo from http://hl7.org/fhir/ValueSet/administrative-gender (required)
