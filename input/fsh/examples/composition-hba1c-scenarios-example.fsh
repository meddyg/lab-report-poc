// ==============================================================================================================
// Instances: Ejemplos de Composition HbA1c por escenario
// ==============================================================================================================

Instance: CompositionHbA1cTamizajeEBAISExample
InstanceOf: CRCompositionHbA1cLaboratoryResult
Title: "Composition HbA1c - Tamizaje EBAIS"
Description: "Ejemplo de Composition para documento clínico de tamizaje HbA1c emitido desde un EBAIS de la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Documento clínico de tamizaje HbA1c emitido por EBAIS.</p></div>"
* status = #final
* type = $loinc#11502-2
* subject = Reference(PatientHbA1cTamizajeEBAISExample)
* date = "2026-04-08T08:30:00-06:00"
* author[0] = Reference(OrganizationEBAISGoicoechea2LabExample)
* author[1] = Reference(PractitionerRoleEBAISGoicoechea2LabExample)
* title = "Reporte de laboratorio HbA1c - Tamizaje en EBAIS"
* section[0].title = "Resultados de tamizaje metabólico"
* section[0].entry[0] = Reference(DiagnosticReportHbA1cTamizajeEBAISExample)

Instance: CompositionHbA1cSeguimientoEBAISExample
InstanceOf: CRCompositionHbA1cLaboratoryResult
Title: "Composition HbA1c - Seguimiento EBAIS"
Description: "Ejemplo de Composition para documento clínico de seguimiento HbA1c en primer nivel de atención."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Documento clínico de seguimiento HbA1c en primer nivel de atención.</p></div>"
* status = #final
* type = $loinc#11502-2
* subject = Reference(PatientHbA1cSeguimientoEBAISExample)
* date = "2026-04-08T09:45:00-06:00"
* author[0] = Reference(OrganizationEBAISGoicoechea2LabExample)
* author[1] = Reference(PractitionerRoleEBAISGoicoechea2LabExample)
* title = "Reporte de laboratorio HbA1c - Seguimiento en EBAIS"
* section[0].title = "Resultados de seguimiento crónico"
* section[0].entry[0] = Reference(DiagnosticReportHbA1cSeguimientoEBAISExample)

Instance: CompositionHbA1cHospitalControlExample
InstanceOf: CRCompositionHbA1cLaboratoryResult
Title: "Composition HbA1c - Control Hospitalario"
Description: "Ejemplo de Composition para documento clínico de resultado HbA1c emitido desde laboratorio hospitalario."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Documento clínico de resultado HbA1c emitido por laboratorio hospitalario.</p></div>"
* status = #final
* type = $loinc#11502-2
* subject = Reference(PatientHbA1cHospitalControlExample)
* date = "2026-04-08T10:40:00-06:00"
* author[0] = Reference(OrganizationHospitalMexicoLabExample)
* author[1] = Reference(PractitionerRoleHospitalMexicoLabExample)
* title = "Reporte de laboratorio HbA1c - Control hospitalario"
* section[0].title = "Resultados de laboratorio hospitalario"
* section[0].entry[0] = Reference(DiagnosticReportHbA1cHospitalControlExample)