/* ------------------------------------------------------------------ 
 @type:         FSH-File for a FHIR® RuleSet Resource
 @about:        HL7® FHIR® CORE Costa Rica
 @created by:   National Working Group for FHIR® - Costa Rica
 @date:         2025-03-03
 @fhir version: 5.0.0
 @authors:      - Ministerio de Salud
                - Caja Costarricense de Seguro Social
                - Camara Costarricense de la Salud
                - Cámara de Tecnologías de Información y Comunicación
                - Global Life-Centered Hub
                - Instituto Nacional de Seguros
--------------------------------------------------------------------*/

/*
 @element: meta
 @concept: Metadata
 @type:    Meta
 @purpose: Metadata de la definición de la estructura
 */
RuleSet: RuleSetStatus (fmm, status, wg)

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm].valueInteger = {fmm}
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #{status}
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-wg].valueCode = #{wg}