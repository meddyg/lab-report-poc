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
    "Identificador principal del profesional de salud que participa en la emisión, validación o revisión del resultado HbA1c. Puede corresponder a cédula, licencia o identificador institucional según el escenario implementado."

* tipoIdentificador 1..1 code "Tipo de identificador del profesional de salud."
    "Tipo del identificador con el que se registra al profesional de salud. Permite a los implementadores interpretar si el valor corresponde a cédula, licencia, identificador institucional u otra credencial válida en el contexto costarricense."
* tipoIdentificador from CRIdentifierTypesSet (required)

* primerNombre 1..1 string "Primer nombre del profesional de salud."
    "Primer nombre oficial del profesional de salud, utilizado para trazabilidad clínica, auditoría y presentación del emisor o validador del resultado."

* segundoNombre 0..1 string "Segundo nombre del profesional de salud."
    "Segundo nombre del profesional cuando exista en los registros institucionales. Su inclusión mejora la identificación humana en flujos clínicos y documentales."

* primerApellido 1..1 string "Primer apellido del profesional de salud."
    "Primer apellido del profesional de salud, indispensable para identificar correctamente a la persona responsable del resultado HbA1c en el contexto costarricense."

* segundoApellido 0..1 string "Segundo apellido del profesional de salud."
    "Segundo apellido del profesional, útil para la identificación completa y la adecuada presentación del nombre en documentos clínicos del PoC."

* sexo 1..1 code "Sexo del profesional de salud."
    "Sexo administrativo del profesional de salud. Se incluye para mantener consistencia demográfica e interoperabilidad con perfiles base y sistemas externos."
* sexo from http://hl7.org/fhir/ValueSet/administrative-gender (required)