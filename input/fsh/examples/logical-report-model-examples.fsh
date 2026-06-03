// ==============================================================================================================
// Instances: Ejemplos de Modelo Logico de Reporte (sin capa documental)
// Modelo: LogicalModelReportLaboratoryResult
// ==============================================================================================================

Instance: LogicalReportLaboratoryResultHbA1cExample
InstanceOf: LogicalModelReportLaboratoryResult
Title: "Ejemplo Logico Reporte Laboratorio HbA1c"
Description: "Ejemplo de instancia del modelo logico de reporte de resultado de laboratorio para HbA1c."
Usage: #example

* identificacion.system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/reporte-proveedor"
* identificacion.value = "1951501"

* paciente.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/cedula-nacional"
* paciente.identificacion[0].type = CRIdentifierTypeCodes#cedula-nacional
* paciente.identificacion[0].value = "105480406"
* paciente.primerNombre = "Frank"
* paciente.primerApellido = "Rosich"
* paciente.fechaNacimiento = "1961-01-18"
* paciente.edad = 64
* paciente.sexo = #unknown

* organizacion.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
* organizacion.identificacion[0].value = "PENDIENTE-PROVEEDOR"
* organizacion.tipoIdentificador = #cedula-juridica
* organizacion.nombre = "Laboratorio Clinico Biometralab"

* detalleResultado[0].codigoPrueba = #4548-4
* detalleResultado[0].valor = "6.0"
* detalleResultado[0].unidadMedida = #%
* detalleResultado[0].rangoReferencia = "Diagnostico diabetes: Normal < 5.7; Prediabetes 5.7 a 6.4; Diabetes >= 6.5. Control diabetes: Buen control < 7.0"
* detalleResultado[0].nota[0] = "Resultado visible en documento fuente: Hb Glicosilada A1c (HbA1c): 6.0 %"

* fechaReporte = "2025-09-02T12:52:11-06:00"
* fechaMuestra = "2025-08-05T09:34:12-06:00"
* observaciones[0] = "Compania reportada en el documento: CORTESIAS GERENCIA CENTRAL."
* observaciones[1] = "Recolectada por: LABORATORIO."
* observaciones[2] = "Creada en sistema: 2025-08-05 09:34:12."
* observaciones[3] = "El documento tambien muestra Glucosa Media Estimada (eAG): 126 mg/dl. Ese dato no se incluye en detalleResultado porque el ValueSet actual del modelo logico solo admite pruebas de hemoglobina/HbA1c."
* conclusion = "Resultado HbA1c en rango compatible con prediabetes segun tabla de referencia impresa."

Instance: LogicalReportLaboratoryResultGlucoseExample
InstanceOf: LogicalModelReportLaboratoryResult
Title: "Ejemplo Logico Reporte Laboratorio Glucosa"
Description: "Ejemplo de instancia del modelo logico de reporte de resultado de laboratorio para glucosa en ayunas."
Usage: #example

* identificacion.system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/reporte-proveedor"
* identificacion.value = "1857046"

* paciente.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/dimex"
* paciente.identificacion[0].type = CRIdentifierTypeCodes#dimex
* paciente.identificacion[0].value = "DIMEX-99887766"
* paciente.identificacion[1].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/pasaporte"
* paciente.identificacion[1].type = CRIdentifierTypeCodes#pasaporte
* paciente.identificacion[1].value = "P-CR-55667788"
* paciente.primerNombre = "Frank"
* paciente.primerApellido = "Rosich"
* paciente.fechaNacimiento = "1961-01-18"
* paciente.edad = 62
* paciente.sexo = #unknown

* organizacion.identificacion[0].system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
* organizacion.identificacion[0].value = "PENDIENTE-PROVEEDOR"
* organizacion.tipoIdentificador = #cedula-juridica
* organizacion.nombre = "Laboratorio Clinico Biometralab"

* detalleResultado[0].codigoPrueba = #1558-6
* detalleResultado[0].valor = "85"
* detalleResultado[0].unidadMedida = #mg/dL
* detalleResultado[0].rangoReferencia = "Normal: < 100; Prediabetes: 100 a 125; Diabetes: > 126"
* detalleResultado[0].nota[0] = "Resultado visible en documento fuente: Glucosa en ayunas: 85 mg/dl"
* detalleResultado[0].nota[1] = "Advertencia: el codigo 1558-6 representa glucosa en ayunas, pero el ValueSet actual del modelo logico no lo admite. Este payload es util para pruebas de ingesta de proveedor y para evidenciar la necesidad de ampliar bindings antes de validacion estricta."

* fechaReporte = "2023-08-01T10:13:54-06:00"
* fechaMuestra = "2023-07-31T14:41:36-06:00"
* observaciones[0] = "Compania reportada en el documento: PRUEBA."
* observaciones[1] = "Recolectada por: LABORATORIO."
* observaciones[2] = "Creada en sistema: 2023-07-31 14:41:36."
* observaciones[3] = "Interpretacion textual visible: Interpretacion segun la Asociacion Americana de Diabetes (ADA)."
* conclusion = "Resultado de glucosa en ayunas dentro del rango normal segun la tabla de referencia impresa."
