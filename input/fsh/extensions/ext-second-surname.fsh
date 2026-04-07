// ==============================================================================================================
// Extensión: Segundo Apellido
// Propósito: Representar el segundo apellido de manera explícita en Patient.name y Practitioner.name
// ==============================================================================================================

Extension: SecondSurname
Id: ext-second-surname
Title: "Segundo Apellido"
Description: "Extensión para capturar el segundo apellido de manera explícita, mapeando a segundoApellido de los modelos lógicos Laboratory Results."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/ext-second-surname"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^context[0].type = #element
* ^context[0].expression = "HumanName.family"

* value[x] only string
* valueString 1..1 MS
  * ^short = "Segundo apellido de la persona"
  * ^definition = "El segundo apellido de la persona, utilizado para su identificación. Mapea a segundoApellido del modelo lógico."
