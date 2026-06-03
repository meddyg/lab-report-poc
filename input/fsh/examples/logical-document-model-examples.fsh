// ==============================================================================================================
// Instances: Ejemplos de Modelo Logico de Documento de Reporte de Laboratorio
// Modelo: LogicalModelDocumentLaboratoryReport
// ==============================================================================================================

Instance: LogicalDocumentLaboratoryReportHbA1cExample
InstanceOf: LogicalModelDocumentLaboratoryReport
Title: "Ejemplo Logico Documento Reporte Laboratorio HbA1c"
Description: "Ejemplo de instancia del documento de reporte de laboratorio para HbA1c."
Usage: #example

* identificadorDocumento.system = "urn:ietf:rfc:3986"
* identificadorDocumento.value = "urn:uuid:1f3f3e58-4a94-4cf2-9d7b-3ff2c9f8a101"

* estadoDocumento = #final
* tipoDocumento = $loinc#11502-2
* fechaDocumento = "2026-04-07T09:35:00-06:00"
* tituloDocumento = "Reporte de laboratorio HbA1c"

* paciente.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/cedula-nacional"
* paciente.identificacion[0].type = CRIdentifierTypeCodes#cedula-nacional
* paciente.identificacion[0].value = "105480406"
* paciente.primerNombre = "Frank"
* paciente.primerApellido = "Rosich"
* paciente.fechaNacimiento = "1961-01-18"
* paciente.edad = 64
* paciente.sexo = #unknown

* autorProfesional[0].identificacion.system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/cedula-nacional"
* autorProfesional[0].identificacion.value = "1-2345-6789"
* autorProfesional[0].tipoIdentificador = #cedula-nacional
* autorProfesional[0].primerNombre = "Mariana"
* autorProfesional[0].primerApellido = "Vargas"
* autorProfesional[0].sexo = #female

* organizacionEmisora.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
* organizacionEmisora.identificacion[0].value = "HMX-001"
* organizacionEmisora.tipoIdentificador = #cedula-juridica
* organizacionEmisora.nombre = "Laboratorio Clinico Biometralab"

* reporteDiagnosticoId.system = "urn:ietf:rfc:3986"
* reporteDiagnosticoId.value = "urn:uuid:2b6b2e2a-1d7e-4f7d-9e4d-3d2f1e3a0001"

* fechaMuestra = "2026-04-07T08:15:00-06:00"

* resultados[0].codigoPrueba = #4548-4
* resultados[0].valor = "6.0"
* resultados[0].unidadMedida = #%
* resultados[0].rangoReferencia = "Normal < 5.7; Prediabetes 5.7 a 6.4; Diabetes >= 6.5"
* resultados[0].nota[0] = "HbA1c reportada en el documento fuente."

* conclusion = "Resultado compatible con prediabetes segun la tabla de referencia impresa."
* observacionesDocumento[0] = "Documento generado para intercambio entre laboratorio y sistema receptor."
* observacionesDocumento[1] = "Ejemplo documental centrado en la estructura del logical model, sin capa FHIR adicional."

* proveniencia.system = "urn:ietf:rfc:3986"
* proveniencia.value = "urn:uuid:3d4f4d1a-9f2f-4d0f-a4e0-7fd01f6a1001"

* auditoriaEvento[0].system = "urn:ietf:rfc:3986"
* auditoriaEvento[0].value = "urn:uuid:4c5a7cf1-92f5-4c19-b59b-6b99a1b20001"

Instance: LogicalDocumentLaboratoryReportGlucoseExample
InstanceOf: LogicalModelDocumentLaboratoryReport
Title: "Ejemplo Logico Documento Reporte Laboratorio Glucosa"
Description: "Ejemplo de instancia del documento de reporte de laboratorio para glucosa en ayunas."
Usage: #example

* identificadorDocumento.system = "urn:ietf:rfc:3986"
* identificadorDocumento.value = "urn:uuid:7c0a1b8f-f8d2-4dd5-9f7a-0fbb9c0a1002"

* estadoDocumento = #final
* tipoDocumento = $loinc#11502-2
* fechaDocumento = "2026-04-07T11:00:00-06:00"
* tituloDocumento = "Reporte de laboratorio glucosa en ayunas"

* paciente.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/dimex"
* paciente.identificacion[0].type = CRIdentifierTypeCodes#dimex
* paciente.identificacion[0].value = "DIMEX-99887766"
* paciente.identificacion[1].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/pasaporte"
* paciente.identificacion[1].type = CRIdentifierTypeCodes#pasaporte
* paciente.identificacion[1].value = "P-CR-55667788"
* paciente.primerNombre = "Frank"
* paciente.primerApellido = "Rosich"
* paciente.fechaNacimiento = "1961-01-18"
* paciente.edad = 64
* paciente.sexo = #unknown

* autorProfesional[0].identificacion.system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/cedula-nacional"
* autorProfesional[0].identificacion.value = "2-3456-7890"
* autorProfesional[0].tipoIdentificador = #cedula-nacional
* autorProfesional[0].primerNombre = "Carlos"
* autorProfesional[0].primerApellido = "Mora"
* autorProfesional[0].sexo = #male

* organizacionEmisora.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
* organizacionEmisora.identificacion[0].value = "LAB-002"
* organizacionEmisora.tipoIdentificador = #cedula-juridica
* organizacionEmisora.nombre = "Laboratorio Clinico Central"

* reporteDiagnosticoId.system = "urn:ietf:rfc:3986"
* reporteDiagnosticoId.value = "urn:uuid:8f2a4d29-90db-4a6f-9d41-cc8d9e9a0002"

* fechaMuestra = "2026-04-07T09:20:00-06:00"

* resultados[0].codigoPrueba = #1558-6
* resultados[0].valor = "85"
* resultados[0].unidadMedida = #mg/dL
* resultados[0].rangoReferencia = "Normal < 100; Prediabetes 100 a 125; Diabetes > 126"
* resultados[0].nota[0] = "Glucosa en ayunas reportada en el documento fuente."

* conclusion = "Resultado dentro del rango normal segun la tabla de referencia impresa."
* observacionesDocumento[0] = "Documento generado para intercambio entre laboratorio y sistema receptor."
* observacionesDocumento[1] = "Ejemplo documental centrado en la estructura del logical model, sin capa FHIR adicional."

* proveniencia.system = "urn:ietf:rfc:3986"
* proveniencia.value = "urn:uuid:9a6f8c2f-0a63-4bd4-9f0f-2c5fd9ea1002"

* auditoriaEvento[0].system = "urn:ietf:rfc:3986"
* auditoriaEvento[0].value = "urn:uuid:ab1c0b0c-11b0-4b4d-8e2f-9b7d4a0e0002"
