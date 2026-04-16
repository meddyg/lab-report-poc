// ==============================================================================================================
// Modelo Lógico: Datos del Detalle del Resultado de Laboratorio
// Fuente: Documentada para este caso de uso
// ==============================================================================================================

Logical: LogicalModelReportLaboratoryResult
Id: LogicalModelReportLaboratoryResult
Title: "Reporte de Resultado de Laboratorio"
Description: "Modelo lógico que define los datos necesarios para representar un reporte de resultado de laboratorio, basado en la documentación para este caso de uso."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/LogicalModelReportLaboratoryResult"
* ^version = "0.1.1"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"

* identificacion 1..1 Identifier "Identificador del reporte de resultado de laboratorio."
    "Identificador único del reporte de resultado de laboratorio. Permite rastrear el documento o paquete clínico del resultado HbA1c a través de sistemas emisores, repositorios o consumidores."

* paciente 1..1 LogicalModelPatientLaboratoryResult "Datos del paciente."
    "Datos del paciente al que corresponde el resultado reportado. Este bloque reúne la información mínima necesaria para identificar al sujeto del estudio dentro del PoC costarricense."

* organizacion 1..1 LogicalModelOrganizationLaboratoryResult "Datos de la organización."
    "Datos de la organización responsable o participante en la emisión del resultado, como laboratorio clínico, hospital o estructura organizacional superior."

* detalleResultado 1..* LogicalModelDetailResultLaboratoryResult "Detalle del resultado de laboratorio."
    "Detalle estructurado de los resultados analíticos incluidos en el reporte. En el PoC actual debe permitir representar el resultado HbA1c y queda abierto a ampliación futura para más determinaciones."

* fechaReporte 1..1 dateTime "Fecha y hora del reporte de resultado de laboratorio."
    "Fecha y hora en que el reporte fue emitido o generado como resultado formal del proceso de laboratorio. Es clave para trazabilidad temporal y para intercambio documental."

* fechaMuestra 0..1 dateTime "Fecha y hora de la toma de muestra."
    "Fecha y hora en que se obtuvo la muestra utilizada para el análisis. Aporta contexto temporal clínico y preanalítico al reporte de laboratorio."

* observaciones 0..* string "Observaciones adicionales sobre el resultado de laboratorio."
    "Observaciones generales del reporte, incluyendo comentarios técnicos, administrativos o clínicos relevantes para la lectura e intercambio del resultado."

* conclusion 0..1 string "Conclusión del resultado de laboratorio."
    "Conclusión resumida del reporte de laboratorio, orientada a ofrecer una interpretación de alto nivel del resultado HbA1c o del conjunto de observaciones incluidas."
