// ==============================================================================================================
// Modelo Lógico: Datos del Detalle del Resultado de Laboratorio
// Fuente: Documentada para este caso de uso
// ==============================================================================================================

Logical: LogicalModelDetailResultLaboratoryResult
Id: LogicalModelDetailResultLaboratoryResult
Title: "Detalle del Resultado de Laboratorio"
Description: "Modelo lógico que define los datos del detalle del resultado de laboratorio necesarios para representar resultados de laboratorio, basado en la documentación para este caso de uso." 

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelDetailResultLaboratoryResult"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* codigoPrueba 1..1 code "Código de la prueba de laboratorio."
    "Código LOINC que identifica la prueba de hemoglobina realizada, que puede incluir hemoglobina total o hemoglobina glicosilada (HbA1c)."
* codigoPrueba from LabTestHemoglobinaCodesSet (required)

* valor 1..1 string "Valor del resultado de laboratorio."
    "Valor del resultado de la prueba de laboratorio, expresado como un número o texto según corresponda. Este campo es obligatorio y debe contener el resultado de la prueba." 

* unidadMedida 1..1 code "Unidad de medida del resultado de laboratorio."
    "Unidad de medida utilizada para expresar el valor del resultado de la prueba de laboratorio, representada mediante un código UCUM u otro sistema de codificación relevante. Este campo es obligatorio y debe contener la unidad de medida correspondiente al valor del resultado."
* unidadMedida from http://unitsofmeasure.org (required)

* metodo 0..1 code "Método utilizado para la prueba de laboratorio."
    "Método o técnica utilizada para realizar la prueba de laboratorio, representado mediante un concepto de SNOMED CT u otro sistema de codificación relevante. Este campo es opcional y puede estar vacío si no se proporciona esta información."
* metodo from LabTestMethodCodesSet (required)

* rangoReferencia 0..1 string "Rango de referencia del resultado."
    "Rango de referencia para el resultado de la prueba de laboratorio, que indica los valores considerados normales o esperados para esa prueba específica. Este campo es opcional y puede estar vacío si no se proporciona un rango de referencia."

* nota 0..* string "Notas adicionales sobre el resultado de laboratorio."
    "Campo opcional para incluir cualquier nota adicional relevante sobre el resultado de laboratorio, como comentarios del laboratorio, notas sobre la interpretación del resultado, o cualquier otra información que pueda ser útil para el médico o el paciente al revisar el resultado de laboratorio." 

