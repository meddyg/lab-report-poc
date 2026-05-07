# Resultado de Laboratorio

Esta guía de implementación tiene como finalidad servir en la prueba de concepto que el consorcio entre Meddyg, Siftia y ESICOM. El objetivo es demostrar la capacidad de interoperabilidad utilizando FHIR para compartir resultados de laboratorio entre sistemas de salud en Costa Rica y validar la viabilidad técnica de esta implementación en un entorno real.

### Descargo de responsabilidad
Esta guía de implementación se encuentra en fase de desarrollo y revisión, y solo se esta utilizando de manera temporal para el proyecto de prueba de concepto entre Meddyg, Siftia y ESICOM. No debe ser utilizada como referencia oficial para implementaciones en producción ni para la toma de decisiones clínicas o administrativas.

### Alcances
Esta guía de implementación utiliza el modelo de datos definido en las guías de implementación de Core y Terminología de HL7 FHIR Costa Rica, y se enfoca en la representación de resultados de laboratorio clínico. No aborda otros aspectos del ciclo de vida de los resultados de laboratorio, como la orden de pruebas, la recolección de muestras o la interpretación clínica.

Esta guía de implementación soporta como PoC solo el resultado de laboratorio de Hemoglobina Glicosilada (HbA1c), pero se espera que en el futuro se amplíe para incluir otros tipos de resultados de laboratorio relevantes para la atención de salud en Costa Rica.

### Seguridad y Etiquetas de Confidencialidad

Los resultados de laboratorio rutinarios representados en esta guía (como Hemoglobina Glicosilada) no requieren etiquetas de seguridad adicionales en `meta.security`. El consentimiento previo del paciente, registrado mediante el recurso `Consent`, es suficiente para gestionar la autorización de acceso a este tipo de resultados.

Para futuras versiones de la guía que incluyan resultados clínicamente sensibles (p. ej., VIH, toxicología, genética), se utilizará `meta.security` con códigos del sistema `http://terminology.hl7.org/CodeSystem/v3-Confidentiality`, de manera complementaria al registro de consentimiento.

### Autores
Esta guía de implementación ha sido desarrollada por el equipo de la HealthTech Meddyg en colaboración con Siftia y ESICOM.

| Autor                 | Rol                                   |
|-----------------------|---------------------------------------|
| Alejandro Benavides   | Coordinación, Autor y Asesor - Meddyg |
| Juan Sánchez          | Desarrollador FHIR - Meddyg           |
| Paul Fervoy           | Revisor - Siftia                      |
| Carlos Pravia         | CTO - Siftia                          |

