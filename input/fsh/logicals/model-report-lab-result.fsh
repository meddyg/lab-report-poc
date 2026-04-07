// ==============================================================================================================
// Modelo Lógico: Datos del Detalle del Resultado de Laboratorio
// Fuente: Documentada para este caso de uso
// ==============================================================================================================

Logical: LogicalModelReportLaboratoryResult
Id: LogicalModelReportLaboratoryResult
Title: "Reporte de Resultado de Laboratorio"
Description: "Modelo lógico que define los datos necesarios para representar un reporte de resultado de laboratorio, basado en la documentación para este caso de uso."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelReportLaboratoryResult"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* identificacion 1..1 Identifier "Identificador del reporte de resultado de laboratorio."
    "Identificador único del reporte de resultado de laboratorio, utilizado para su identificación en el sistema de salud. Puede incluir números de cédula jurídica, números de registro u otros identificadores relevantes."   

* paciente 1..1 LogicalModelPatientLaboratoryResult "Datos del paciente."
    "Referencia a un recurso Patient que contiene los datos del paciente necesarios para representar resultados de laboratorio."

* organizacion 1..1 LogicalModelOrganizationLaboratoryResult "Datos de la organización."
    "Referencia a un recurso Organization que contiene los datos de la organización necesarios para representar resultados de laboratorio."

* detalleResultado 1..* LogicalModelDetailResultLaboratoryResult "Detalle del resultado de laboratorio."
    "Referencia al modelo lógico que define los datos del detalle del resultado de laboratorio necesarios para representar resultados de laboratorio. Este campo es obligatorio y puede contener uno o más detalles de resultados de laboratorio, dependiendo de la cantidad de pruebas realizadas y reportadas en el resultado de laboratorio."

* fechaReporte 1..1 dateTime "Fecha y hora del reporte de resultado de laboratorio."
    "Fecha y hora en que se generó el reporte de resultado de laboratorio, utilizada para registrar cuándo se realizó la prueba y se obtuvo el resultado. Este campo es obligatorio."

* fechaMuestra 0..1 dateTime "Fecha y hora de la toma de muestra."
    "Fecha y hora en que se tomó la muestra para la prueba de laboratorio, utilizada para registrar cuándo se realizó la toma de muestra. Este campo es opcional y puede estar vacío si no se proporciona esta información." 

* observaciones 0..* string "Observaciones adicionales sobre el resultado de laboratorio."
    "Campo opcional para incluir cualquier observación adicional relevante sobre el resultado de laboratorio, como comentarios del laboratorio, notas sobre la interpretación del resultado, o cualquier otra información que pueda ser útil para el médico o el paciente al revisar el resultado de laboratorio." 

* conclusion 0..1 string "Conclusión del resultado de laboratorio."
    "Campo opcional para incluir una conclusión general sobre el resultado de laboratorio, basada en la interpretación de los resultados individuales. Esto puede ser útil para proporcionar una visión general del estado del paciente en relación con las pruebas de laboratorio realizadas."
