// ==============================================================================================================
// Instances: Ejemplos de DiagnosticReport HbA1c por escenario
// ==============================================================================================================

Instance: DiagnosticReportHbA1cTamizajeEBAISExample
InstanceOf: CRDiagnosticReportHbA1cLaboratoryResult
Title: "DiagnosticReport HbA1c - Tamizaje EBAIS"
Description: "Ejemplo de DiagnosticReport para tamizaje HbA1c en primer nivel de atención de la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Reporte de HbA1c para tamizaje en EBAIS con resultado dentro de rango.</p></div>"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB
* code = $loinc#4548-4
* subject = Reference(PatientHbA1cTamizajeEBAISExample)
* effectiveDateTime = "2026-04-08T08:00:00-06:00"
* issued = "2026-04-08T08:25:00-06:00"
* performer[0] = Reference(OrganizationEBAISGoicoechea2LabExample)
* performer[1] = Reference(PractitionerRoleEBAISGoicoechea2LabExample)
* specimen[0] = Reference(SpecimenHbA1cTamizajeEBAISExample)
* result[0] = Reference(ObservationHbA1cTamizajeEBAISExample)
* conclusion = "Resultado HbA1c dentro del rango general de referencia para tamizaje."
* note.text = "El reporte corresponde a toma y procesamiento realizados en el primer nivel de atención."

Instance: DiagnosticReportHbA1cSeguimientoEBAISExample
InstanceOf: CRDiagnosticReportHbA1cLaboratoryResult
Title: "DiagnosticReport HbA1c - Seguimiento EBAIS"
Description: "Ejemplo de DiagnosticReport para seguimiento de paciente en EBAIS con resultado HbA1c alterado."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Reporte de HbA1c para seguimiento en EBAIS con resultado elevado.</p></div>"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB
* code = $loinc#4548-4
* subject = Reference(PatientHbA1cSeguimientoEBAISExample)
* effectiveDateTime = "2026-04-08T09:10:00-06:00"
* issued = "2026-04-08T09:40:00-06:00"
* performer[0] = Reference(OrganizationEBAISGoicoechea2LabExample)
* performer[1] = Reference(PractitionerRoleEBAISGoicoechea2LabExample)
* specimen[0] = Reference(SpecimenHbA1cSeguimientoEBAISExample)
* result[0] = Reference(ObservationHbA1cSeguimientoEBAISExample)
* conclusion = "Resultado HbA1c elevado respecto al rango general; requiere correlación con el plan de seguimiento ambulatorio."
* note.text = "Escenario pensado para control longitudinal en red de atención primaria CCSS."

Instance: DiagnosticReportHbA1cHospitalControlExample
InstanceOf: CRDiagnosticReportHbA1cLaboratoryResult
Title: "DiagnosticReport HbA1c - Control Hospitalario"
Description: "Ejemplo de DiagnosticReport emitido por laboratorio hospitalario para paciente con diabetes en seguimiento especializado."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Reporte de HbA1c en contexto hospitalario con control glucémico no adecuado.</p></div>"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB
* code = $loinc#4548-4
* subject = Reference(PatientHbA1cHospitalControlExample)
* effectiveDateTime = "2026-04-08T10:00:00-06:00"
* issued = "2026-04-08T10:35:00-06:00"
* performer[0] = Reference(OrganizationHospitalMexicoLabExample)
* performer[1] = Reference(PractitionerRoleHospitalMexicoLabExample)
* specimen[0] = Reference(SpecimenHbA1cHospitalControlExample)
* result[0] = Reference(ObservationHbA1cHospitalControlExample)
* conclusion = "Resultado HbA1c persistentemente elevado, compatible con control glucémico no adecuado en contexto hospitalario."
* note.text = "Ejemplo orientado a coordinación entre laboratorio hospitalario y seguimiento clínico especializado."