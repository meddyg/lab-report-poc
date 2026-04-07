// ==============================================================================================================
// Profile: Paciente para Resultados de Laboratorio
// Basado en: LogicalModelPatientLaboratoryResult
// ==============================================================================================================

Profile: CRPatientLaboratoryResult
Parent: Patient
Id: cr-patient-laboratory-result
Title: "Patient - Resultados de Laboratorio"
Description: "Perfil de paciente que define los datos del paciente necesarios para representar resultados de laboratorio, basado en el modelo lógico LogicalModelPatientLaboratoryResult y el perfil de paciente del CORE de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-patient-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

// Identificadores del paciente (tipoIdentificador + identificacion del modelo lógico)
* identifier 1..* MS
  * ^short = "Identificadores oficiales del paciente"
  * ^definition = "Conjunto de identificadores que permiten reconocer de manera inequívoca al paciente dentro del flujo de intercambio de resultados de laboratorio en Costa Rica. Para este PoC se espera capturar al menos un identificador oficial o institucional que permita correlacionar el resultado HbA1c con el registro clínico correcto."
  * type 1..1 MS
    * ^short = "Tipo de identificador del paciente"
    * ^definition = "Clasifica la naturaleza del identificador del paciente, por ejemplo cédula nacional u otro identificador permitido por el ecosistema de salud costarricense. Este dato ayuda a interpretar el valor del identificador y a aplicar reglas de validación o conciliación entre sistemas."
  * type from https://hl7.meddyg.com/fhir/laboratory-results/ValueSet/cr-identifier-types (required)
  * system 1..1 MS
    * ^short = "Sistema emisor del identificador"
    * ^definition = "URI o namespace que indica qué autoridad, dominio o sistema define el identificador del paciente. Debe permitir a los implementadores distinguir entre identificadores nacionales, institucionales o locales usados en Costa Rica."
  * value 1..1 MS
    * ^short = "Identificador del paciente"
    * ^definition = "Identificador único del paciente, utilizado para su identificación en el sistema de salud."

// Nombre del paciente (primerNombre, segundoNombre, primerApellido, segundoApellido del modelo lógico)
* name 1..1 MS
  * ^short = "Nombre del paciente"
  * ^definition = "Nombre humano principal del paciente utilizado para visualización, confirmación manual de identidad y presentación del resultado de laboratorio al usuario clínico o administrativo. En este PoC se documenta como el nombre oficial del paciente."
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "use"
  * ^slicing.rules = #open
  * use = #official
    * ^short = "Uso oficial del nombre"
    * ^definition = "Indica que el nombre representado corresponde al nombre oficial con el que el paciente debe ser identificado en el intercambio del resultado de HbA1c."
  * given 1..2 MS
    * ^short = "Nombres del paciente"
    * ^definition = "Primer nombre (obligatorio) y segundo nombre (opcional) del paciente."
  * family 1..1 MS
    * ^short = "Primer apellido del paciente"
    * ^definition = "Primer apellido obligatorio del paciente, mapeado de primerApellido del modelo lógico. El segundo apellido puede representarse usando la extensión SecondSurname."

// Fecha de nacimiento (fechaNacimiento del modelo lógico)
* birthDate 1..1 MS
  * ^short = "Fecha de nacimiento del paciente"
  * ^definition = "La fecha de nacimiento del paciente, utilizada para calcular la edad y otros datos demográficos."

// Sexo (sexo del modelo lógico)
* gender 1..1 MS
  * ^short = "Sexo del paciente"
  * ^definition = "Sexo administrativo del paciente según FHIR, utilizado para interoperabilidad demográfica, consistencia documental y eventual interpretación clínica complementaria del resultado."
* gender from http://hl7.org/fhir/ValueSet/administrative-gender (required)

// Elementos que no se incluyen en el perfil pero que pueden ser relevantes para resultados de laboratorio:
* deceased[x] 0..0
  * ^short = "No se registra fallecimiento"
  * ^definition = "Este PoC no requiere capturar información de fallecimiento del paciente para representar un resultado HbA1c, por lo que el elemento se excluye del perfil."
* link 0..0
  * ^short = "No se registran vínculos entre pacientes"
  * ^definition = "Este PoC no requiere gestionar enlaces entre distintos recursos Patient que representen a la misma persona, por lo que el elemento se excluye del perfil."