// ==============================================================================================================
// Instances: Ejemplos de Observation HbA1c por escenario
// ==============================================================================================================

Instance: ObservationHbA1cTamizajeEBAISExample
InstanceOf: CRObservationHbA1cLaboratoryResult
Title: "Observation HbA1c - Tamizaje EBAIS"
Description: "Ejemplo de observación HbA1c para tamizaje metabólico en primer nivel de atención de la CCSS con resultado dentro de rango esperado."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Resultado de HbA1c para tamizaje en EBAIS: 5.4%.</p></div>"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = $loinc#4548-4
* subject = Reference(PatientHbA1cTamizajeEBAISExample)
* effectiveDateTime = "2026-04-08T08:00:00-06:00"
* performer[0] = Reference(OrganizationEBAISGoicoechea2LabExample)
* performer[1] = Reference(PractitionerRoleEBAISGoicoechea2LabExample)
* valueQuantity.value = 5.4
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%
* valueQuantity.unit = "%"
* interpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation#N
* method = $snomed#726449005
* specimen = Reference(SpecimenHbA1cTamizajeEBAISExample)
* referenceRange.low.value = 4.0
* referenceRange.low.system = "http://unitsofmeasure.org"
* referenceRange.low.code = #%
* referenceRange.low.unit = "%"
* referenceRange.high.value = 5.6
* referenceRange.high.system = "http://unitsofmeasure.org"
* referenceRange.high.code = #%
* referenceRange.high.unit = "%"
* referenceRange.text = "Tamizaje ambulatorio: rango de referencia general 4.0% - 5.6%."
* note.text = "Escenario de tamizaje preventivo en EBAIS para persona sin antecedente documentado de diabetes."

Instance: ObservationHbA1cSeguimientoEBAISExample
InstanceOf: CRObservationHbA1cLaboratoryResult
Title: "Observation HbA1c - Seguimiento EBAIS"
Description: "Ejemplo de observación HbA1c para seguimiento ambulatorio en EBAIS con resultado elevado compatible con control subóptimo o prediabetes/diabetes según contexto clínico."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Resultado de HbA1c en seguimiento ambulatorio en EBAIS: 6.3%.</p></div>"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = $loinc#4548-4
* subject = Reference(PatientHbA1cSeguimientoEBAISExample)
* effectiveDateTime = "2026-04-08T09:10:00-06:00"
* performer[0] = Reference(OrganizationEBAISGoicoechea2LabExample)
* performer[1] = Reference(PractitionerRoleEBAISGoicoechea2LabExample)
* valueQuantity.value = 6.3
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%
* valueQuantity.unit = "%"
* interpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation#H
* method = $snomed#726449005
* specimen = Reference(SpecimenHbA1cSeguimientoEBAISExample)
* referenceRange.low.value = 4.0
* referenceRange.low.system = "http://unitsofmeasure.org"
* referenceRange.low.code = #%
* referenceRange.low.unit = "%"
* referenceRange.high.value = 5.6
* referenceRange.high.system = "http://unitsofmeasure.org"
* referenceRange.high.code = #%
* referenceRange.high.unit = "%"
* referenceRange.text = "Resultado por encima del rango general de referencia; correlacionar con contexto clínico y seguimiento en primer nivel."
* note.text = "Escenario de control ambulatorio de paciente en seguimiento por alteración glucémica en red CCSS."

Instance: ObservationHbA1cHospitalControlExample
InstanceOf: CRObservationHbA1cLaboratoryResult
Title: "Observation HbA1c - Control Hospitalario"
Description: "Ejemplo de observación HbA1c para paciente en seguimiento hospitalario con mal control metabólico."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Resultado de HbA1c en control hospitalario: 9.2%.</p></div>"
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code = $loinc#4548-4
* subject = Reference(PatientHbA1cHospitalControlExample)
* effectiveDateTime = "2026-04-08T10:00:00-06:00"
* performer[0] = Reference(OrganizationHospitalMexicoLabExample)
* performer[1] = Reference(PractitionerRoleHospitalMexicoLabExample)
* valueQuantity.value = 9.2
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%
* valueQuantity.unit = "%"
* interpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation#H
* method = $snomed#726449005
* specimen = Reference(SpecimenHbA1cHospitalControlExample)
* referenceRange.low.value = 4.0
* referenceRange.low.system = "http://unitsofmeasure.org"
* referenceRange.low.code = #%
* referenceRange.low.unit = "%"
* referenceRange.high.value = 5.6
* referenceRange.high.system = "http://unitsofmeasure.org"
* referenceRange.high.code = #%
* referenceRange.high.unit = "%"
* referenceRange.text = "Resultado marcadamente elevado respecto al rango de referencia general."
* note.text = "Escenario hospitalario de seguimiento de paciente con diabetes y control glucémico no satisfactorio."