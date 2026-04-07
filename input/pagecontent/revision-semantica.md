Esta página permite revisar la relación semántica entre los Bundle document de ejemplo definidos en la IG y su representación humana en PDF institucional.

Cada escenario presenta dos vistas complementarias:

- El Bundle de ejemplo publicado por la IG, para revisar la estructura FHIR.
- El PDF institucional generado a partir de ese mismo bundle, para revisar cómo se expresa visualmente la semántica clínica.

### Cómo Revisar

Utilice esta página para validar que:

- los datos visibles en el PDF corresponden a los recursos y elementos del bundle;
- la relación entre Composition, DiagnosticReport, Observation, Specimen y Patient es comprensible para implementadores;
- el resultado clínico puede trazarse desde la presentación humana hacia el recurso FHIR fuente.

### Escenarios Disponibles

#### Tamizaje EBAIS

- Bundle FHIR: [Bundle HbA1c Tamizaje EBAIS](Bundle-BundleHbA1cTamizajeEBAISExample.html)
- PDF institucional: [PDF HbA1c Tamizaje EBAIS](https://raw.githubusercontent.com/meddyg/lab-report-poc/main/generated/pdf-lab-reports-ccss/BundleHbA1cTamizajeEBAISExample-CCSS.pdf)

#### Seguimiento EBAIS

- Bundle FHIR: [Bundle HbA1c Seguimiento EBAIS](Bundle-BundleHbA1cSeguimientoEBAISExample.html)
- PDF institucional: [PDF HbA1c Seguimiento EBAIS](https://raw.githubusercontent.com/meddyg/lab-report-poc/main/generated/pdf-lab-reports-ccss/BundleHbA1cSeguimientoEBAISExample-CCSS.pdf)

#### Control Hospitalario

- Bundle FHIR: [Bundle HbA1c Control Hospitalario](Bundle-BundleHbA1cHospitalControlExample.html)
- PDF institucional: [PDF HbA1c Control Hospitalario](https://raw.githubusercontent.com/meddyg/lab-report-poc/main/generated/pdf-lab-reports-ccss/BundleHbA1cHospitalControlExample-CCSS.pdf)

#### Documento de Laboratorio Base

- Bundle FHIR: [Bundle HbA1c Documento Base](Bundle-BundleHbA1cLaboratoryResultDocumentExample.html)
- PDF institucional: [PDF HbA1c Documento Base](https://raw.githubusercontent.com/meddyg/lab-report-poc/main/generated/pdf-lab-reports-ccss/BundleHbA1cLaboratoryResultDocumentExample-CCSS.pdf)

### Trazabilidad Esperada

Las relaciones principales que deben poder identificarse son:

- Composition.title hacia el título documental del informe.
- DiagnosticReport.issued hacia la fecha y hora visibles del resultado.
- Patient.identifier y Patient.name hacia la cabecera demográfica.
- Organization y PractitionerRole hacia el contexto institucional y profesional.
- Observation.code, Observation.valueQuantity, Observation.referenceRange e Observation.interpretation hacia la fila analítica del resultado.
- Specimen.collection.collectedDateTime hacia la fecha de toma de muestra.

### Uso para Implementadores

Esta sección está pensada para apoyar sesiones de implementación, validación funcional y revisión clínica, permitiendo comparar de forma directa el recurso interoperable y su representación legible para usuarios finales.