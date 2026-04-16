// ==============================================================================================================
// Profile: DiagnosticReport HbA1c para Resultados de Laboratorio
// Basado en: LogicalModelReportLaboratoryResult
// ==============================================================================================================

Profile: CRDiagnosticReportHbA1cLaboratoryResult
Parent: DiagnosticReport
Id: cr-diagnostic-report-hba1c-laboratory-result
Title: "DiagnosticReport HbA1c"
Description: "Perfil de reporte diagnóstico para representar resultados de laboratorio de Hemoglobina Glicosilada (HbA1c) en el PoC de Costa Rica."

* ^url = "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-diagnostic-report-hba1c-laboratory-result"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^publisher = "MEDDYG"
* ^jurisdiction = urn:iso:std:iso:3166#CR

* status 1..1 MS
* status = #final
* status ^short = "Estado final del reporte"
* status ^definition = "Estado del DiagnosticReport. En este perfil se fija como final para indicar que el reporte HbA1c ya fue emitido formalmente por el laboratorio o sistema emisor."

* category 1..1 MS
* category = http://terminology.hl7.org/CodeSystem/v2-0074#LAB "Laboratory"
* category ^short = "Categoría del reporte"
* category ^definition = "Clasificación general del reporte como reporte de laboratorio, permitiendo a los sistemas consumidores reconocer el tipo documental y aplicar procesamiento específico."

* code 1..1 MS
* code = $loinc#4548-4
* code ^short = "Código principal del reporte"
* code ^definition = "Código clínico que identifica que el reporte se refiere al resultado HbA1c del PoC. Sirve como resumen semántico del contenido principal del DiagnosticReport."

* subject 1..1 MS
* subject only Reference(CRPatientLaboratoryResult)
* subject ^short = "Paciente del reporte"
* subject ^definition = "Referencia al paciente cuyo resultado HbA1c está siendo reportado. Es el vínculo central entre el documento clínico y la persona atendida."

* effective[x] 1..1 MS
* effective[x] only dateTime
* effective[x] ^short = "Momento clínico del estudio"
* effective[x] ^definition = "Fecha y hora clínica a la que corresponde el estudio o resultado HbA1c contenido en el reporte."

* issued 1..1 MS
* issued ^short = "Fecha y hora de emisión"
* issued ^definition = "Fecha y hora en que el DiagnosticReport fue oficialmente emitido, publicado o puesto a disposición para intercambio entre sistemas."

* performer 1..* MS
* performer only Reference(CROrganizationLaboratoryResult or CRPractitionerLaboratoryResult or CRPractitionerRoleLaboratoryResult)
* performer ^short = "Emisores del reporte"
* performer ^definition = "Actores organizacionales o profesionales responsables de generar, validar o emitir el reporte diagnóstico de HbA1c."

* specimen 0..* MS
* specimen only Reference(CRSpecimenHbA1cLaboratoryResult)
* specimen ^short = "Muestras asociadas al reporte"
* specimen ^definition = "Referencias a las muestras que sustentan el contenido analítico del reporte HbA1c. Permiten mantener trazabilidad entre muestra, observación y documento clínico."

* result 1..* MS
* result only Reference(CRObservationHbA1cLaboratoryResult)
* result ^short = "Observaciones incluidas en el reporte"
* result ^definition = "Referencias a las observaciones de laboratorio que constituyen el contenido analítico del reporte. Para este PoC deben incluir al menos la observación HbA1c."

* conclusion 0..1 MS
* conclusion ^short = "Conclusión clínica resumida"
* conclusion ^definition = "Síntesis interpretativa opcional del resultado HbA1c, pensada para ofrecer una lectura general del hallazgo sin reemplazar la observación estructurada."
* note 0..* MS
* note ^short = "Notas del reporte"
* note ^definition = "Comentarios adicionales del laboratorio o del sistema emisor sobre el reporte HbA1c, incluyendo aclaraciones técnicas, administrativas o clínicas."

// Elementos que no se incluyen en el perfil para resultados de laboratorio:
* encounter 0..0
* encounter ^short = "Sin encuentro en el PoC"
* encounter ^definition = "El PoC actual no modela explícitamente el encuentro asistencial asociado al resultado HbA1c, por lo que este elemento se excluye del perfil."