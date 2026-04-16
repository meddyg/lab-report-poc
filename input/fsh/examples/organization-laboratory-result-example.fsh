// ==============================================================================================================
// Instances: Ejemplos de Organización para Resultados de Laboratorio
// Basado en: CROrganizationLaboratoryResult
// Caso de uso: Jerarquía CCSS -> establecimientos -> laboratorios
// ==============================================================================================================

Instance: OrganizationCCSSExample
InstanceOf: CROrganizationLaboratoryResult
Title: "CCSS - Organización Madre"
Description: "Ejemplo de la Caja Costarricense de Seguro Social (CCSS) como organización principal dentro del ecosistema de resultados de laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Organización principal de la CCSS para escenarios de laboratorio.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-juridica "Cédula Jurídica"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
  * value = "4-000-042147"

* active = true
* name = "Caja Costarricense de Seguro Social (CCSS)"

Instance: OrganizationHospitalMexicoExample
InstanceOf: CROrganizationLaboratoryResult
Title: "Hospital México - Establecimiento"
Description: "Ejemplo de un hospital público perteneciente a la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Hospital público de la CCSS que participa en reportes de laboratorio.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-juridica "Cédula Jurídica"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
  * value = "3-101-000100"

* active = true
* name = "Hospital México"
* partOf = Reference(OrganizationCCSSExample)

Instance: OrganizationHospitalMexicoLabExample
InstanceOf: CROrganizationLaboratoryResult
Title: "Laboratorio Clínico Hospital México"
Description: "Ejemplo de laboratorio perteneciente a un hospital público de la CCSS para el caso de uso inicial de resultados de laboratorio."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Laboratorio clínico del Hospital México para procesamiento de HbA1c.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-juridica "Cédula Jurídica"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
  * value = "3-101-000100-LAB01"

* active = true
* name = "Laboratorio Clínico Hospital México"
* partOf = Reference(OrganizationHospitalMexicoExample)

Instance: OrganizationEBAISGoicoechea2Example
InstanceOf: CROrganizationLaboratoryResult
Title: "EBAIS Goicoechea 2 - Establecimiento"
Description: "Ejemplo de un EBAIS perteneciente a la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>EBAIS de la CCSS para atención primaria y seguimiento clínico.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-juridica "Cédula Jurídica"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
  * value = "3-101-000200"

* active = true
* name = "EBAIS Goicoechea 2"
* partOf = Reference(OrganizationCCSSExample)

Instance: OrganizationEBAISGoicoechea2LabExample
InstanceOf: CROrganizationLaboratoryResult
Title: "Laboratorio EBAIS Goicoechea 2"
Description: "Ejemplo de laboratorio de primer nivel perteneciente a un EBAIS de la CCSS."
Usage: #example

* language = #es
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml' lang='es' xml:lang='es'><p>Laboratorio de primer nivel del EBAIS Goicoechea 2.</p></div>"
* identifier
  * type = CRIdentifierTypeCodes#cedula-juridica "Cédula Jurídica"
  * system = "https://hl7.meddyg.com/fhir/laboratory-results/sid/ccss-organization-id"
  * value = "3-101-000200-LAB01"

* active = true
* name = "Laboratorio EBAIS Goicoechea 2"
* partOf = Reference(OrganizationEBAISGoicoechea2Example)
