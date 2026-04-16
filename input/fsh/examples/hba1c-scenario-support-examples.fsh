// ==============================================================================================================
// Instances: Recursos de apoyo para escenarios HbA1c en Costa Rica
// ==============================================================================================================

Instance: PractitionerRoleEBAISGoicoechea2LabExample
InstanceOf: CRPractitionerRoleLaboratoryResult
Title: "Rol Profesional Laboratorio EBAIS Goicoechea 2"
Description: "Ejemplo del rol organizacional del profesional que reporta resultados HbA1c desde un laboratorio de primer nivel de atención en la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Rol del profesional responsable del reporte de HbA1c en laboratorio EBAIS.</p></div>"
* active = true
* practitioner = Reference(PractitionerLaboratoryResultExample)
* organization = Reference(OrganizationEBAISGoicoechea2LabExample)
* code[0] = http://terminology.hl7.org/CodeSystem/practitioner-role#doctor

Instance: PatientHbA1cTamizajeEBAISExample
InstanceOf: CRPatientLaboratoryResult
Title: "Paciente HbA1c Tamizaje EBAIS"
Description: "Paciente ejemplo para escenario de tamizaje metabólico en EBAIS dentro del primer nivel de atención en Costa Rica."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Paciente en escenario de tamizaje metabólico en EBAIS.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-nacional "Cédula Nacional"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/CodeSystem/cr-identifier-type"
  * value = "201230456"

* name
  * use = #official
  * given[0] = "Laura"
  * given[1] = "María"
  * family = "Vargas"
  * family.extension[SecondSurname].valueString = "Rojas"

* birthDate = "1987-03-22"
* gender = #female

Instance: PatientHbA1cSeguimientoEBAISExample
InstanceOf: CRPatientLaboratoryResult
Title: "Paciente HbA1c Seguimiento EBAIS"
Description: "Paciente ejemplo para seguimiento longitudinal de control glucémico desde un EBAIS de la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Paciente en seguimiento longitudinal de control glucémico en EBAIS.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-nacional "Cédula Nacional"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/CodeSystem/cr-identifier-type"
  * value = "108760543"

* name
  * use = #official
  * given[0] = "Carlos"
  * given[1] = "Andrés"
  * family = "Jiménez"
  * family.extension[SecondSurname].valueString = "Solano"

* birthDate = "1975-10-09"
* gender = #male

Instance: PatientHbA1cHospitalControlExample
InstanceOf: CRPatientLaboratoryResult
Title: "Paciente HbA1c Control Hospitalario"
Description: "Paciente ejemplo para escenario hospitalario de seguimiento de diabetes con resultado HbA1c alterado."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Paciente en control hospitalario por diabetes con HbA1c alterada.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-nacional "Cédula Nacional"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/CodeSystem/cr-identifier-type"
  * value = "304560789"

* name
  * use = #official
  * given[0] = "José"
  * given[1] = "Miguel"
  * family = "Castro"
  * family.extension[SecondSurname].valueString = "Mora"

* birthDate = "1968-07-14"
* gender = #male

Instance: SpecimenHbA1cTamizajeEBAISExample
InstanceOf: CRSpecimenHbA1cLaboratoryResult
Title: "Muestra HbA1c Tamizaje EBAIS"
Description: "Muestra de sangre venosa para escenario de tamizaje HbA1c en EBAIS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Muestra de sangre venosa para tamizaje de HbA1c en EBAIS.</p></div>"
* status = #available
* type = $snomed#122555007
* subject = Reference(PatientHbA1cTamizajeEBAISExample)
* collection.collectedDateTime = "2026-04-08T07:10:00-06:00"
* receivedTime = "2026-04-08T07:35:00-06:00"

Instance: SpecimenHbA1cSeguimientoEBAISExample
InstanceOf: CRSpecimenHbA1cLaboratoryResult
Title: "Muestra HbA1c Seguimiento EBAIS"
Description: "Muestra de sangre venosa para control periódico de paciente crónico en EBAIS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Muestra de sangre venosa para seguimiento de HbA1c en EBAIS.</p></div>"
* status = #available
* type = $snomed#122555007
* subject = Reference(PatientHbA1cSeguimientoEBAISExample)
* collection.collectedDateTime = "2026-04-08T08:20:00-06:00"
* receivedTime = "2026-04-08T08:50:00-06:00"

Instance: SpecimenHbA1cHospitalControlExample
InstanceOf: CRSpecimenHbA1cLaboratoryResult
Title: "Muestra HbA1c Control Hospitalario"
Description: "Muestra de sangre venosa procesada en un laboratorio hospitalario para seguimiento de diabetes."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Muestra de sangre venosa procesada en laboratorio hospitalario para HbA1c.</p></div>"
* status = #available
* type = $snomed#122555007
* subject = Reference(PatientHbA1cHospitalControlExample)
* collection.collectedDateTime = "2026-04-08T09:05:00-06:00"
* receivedTime = "2026-04-08T09:30:00-06:00"