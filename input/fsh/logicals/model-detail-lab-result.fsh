// ==============================================================================================================
// Modelo Lógico: Datos del Detalle del Resultado de Laboratorio
// Fuente: Documentada para este caso de uso
// ==============================================================================================================

Logical: LogicalModelDetailResultLaboratoryResult
Id: LogicalModelDetailResultLaboratoryResult
Title: "Detalle del Resultado de Laboratorio"
Description: "Modelo lógico que define los datos del detalle del resultado de laboratorio necesarios para representar resultados de laboratorio, basado en la documentación para este caso de uso." 

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelDetailResultLaboratoryResult"
* ^version = "0.1.1"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* codigoPrueba 1..1 code "Código de la prueba de laboratorio."
    "Código LOINC que identifica la determinación analítica reportada. En el alcance actual del PoC se utiliza principalmente para representar la prueba de hemoglobina glicosilada HbA1c."
* codigoPrueba from LabTestHemoglobinaCodesSet (required)

* valor 1..1 string "Valor del resultado de laboratorio."
    "Valor observado del resultado de laboratorio. En el caso de HbA1c normalmente corresponderá a un valor numérico expresado en porcentaje, aunque el modelo lógico conserva flexibilidad para otras representaciones."

* unidadMedida 1..1 code "Unidad de medida del resultado de laboratorio."
    "Unidad de medida utilizada para expresar el resultado. Para HbA1c en este PoC se espera típicamente porcentaje, codificado formalmente para garantizar interoperabilidad entre sistemas."
* unidadMedida from http://unitsofmeasure.org (required)

* metodo 0..1 code "Método utilizado para la prueba de laboratorio."
    "Método o técnica analítica empleada para obtener el resultado, por ejemplo inmunoensayo u otro método validado. Este dato aporta contexto técnico útil para comparabilidad y auditoría."
* metodo from LabTestMethodCodesSet (required)

* rangoReferencia 0..1 string "Rango de referencia del resultado."
    "Rango de referencia aplicable al resultado analítico, útil para contextualizar la interpretación clínica de la prueba HbA1c según el entorno o política del laboratorio."

* nota 0..* string "Notas adicionales sobre el resultado de laboratorio."
    "Comentarios u observaciones adicionales sobre el resultado analítico, incluyendo aclaraciones del laboratorio, observaciones de calidad o contexto clínico relevante para el consumidor del resultado."

