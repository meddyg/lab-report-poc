### Uso

```bash
# 1. Asegurate que tus ejemplos FSH incluyan narrativas XHTML:
Instance: MyExample
InstanceOf: MyProfile
* status = #final
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Mi narrativa...</div>"

# 2. Generar recursos con SUSHI
sushi build

# 3. Ejecutar el post-procesamiento
python3 _scripts/add-lang-to-xhtml.py

# O usa el wrapper (combina pasos 2-3):
bash _scripts/build-ig.sh
```

### ¿Qué hace?

Modifica archivos JSON en `fsh-generated/resources/`:

**Antes:**
```json
{
  "language": "es",
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">...</div>"
  }
}
```

**Después:**
```json
{
  "language": "es",
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"es\" xml:lang=\"es\">...</div>"
  }
}
```

### Filtros Automáticos

- ✓ Procesa: Recursos con narrativas XHTML (`text.div` con `xmlns`)
- ✓ Agrega: `lang` y `xml:lang` si falta
- ✗ Ignora: Recursos sin narrativas (perfiles, ValueSets, CodeSystems, etc.)
- 🔄 Maneja: Bundles com entries anidadas

### Requisitos

- Python 3.6+
- Familia del SO agnóstica (Windows/Mac/Linux)

### Estado Actual en la IG

**Scan de `fsh-generated/resources/`:**
- Total de recursos: 42
- Con narrativa XHTML: 0
- Razón: Tus ejemplos FSH actualmente no tienen `.text.div` definidos

**Próximos pasos:**
1. Agrega narrativas a tus ejemplos FSH (ver template arriba)
2. Ejecuta `bash _scripts/build-ig.sh` 
3. El script procesará automáticamente las nuevas narrativas

---

## build-ig.sh

Script wrapper que ejecuta `sushi build` + `python3 _scripts/add-lang-to-xhtml.py` en secuencia.

**Uso:**
```bash
bash _scripts/build-ig.sh              # Full workflow
bash _scripts/build-ig.sh --skip-xhtml # Only sushi, skip Python
```
# Scripts de Post-Procesamiento para la IG

## add-lang-to-xhtml.py

**Propósito:** Agregar atributos `lang` y `xml:lang` a todos los elementos `<div>` de narrativa XHTML en los recursos FHIR generados.

### Why?

HAPI FHIR y otros servidores FHIR requieren que la narrativa XHTML tenga el atributo `lang` que coincida con el `language` del recurso. Sin esto, recibirás advertencias:

```
Language_XHTML_Lang_Missing: Resource has a language, but the XHTML does not have an lang or an xml:lang tag
```

### Uso

```bash
# 1. Generar recursos con SUSHI
sushi build

# 2. Ejecutar el post-procesamiento
python3 _scripts/add-lang-to-xhtml.py

# O usar el wrapper:
bash _scripts/build-ig.sh
```

### Qué hace

Modifica archivos JSON en `fsh-generated/resources/`:

**Antes:**
```json
{
  "language": "es",
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">...</div>"
  }
}
```

**Después:**
```json
{
  "language": "es",
  "text": {
    "status": "generated",
    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"es\" xml:lang=\"es\">...</div>"
  }
}
```

### Filtros Automáticos

- ✓ Procesa: Examples, Bundles, Compositions, DiagnosticReports, Observations, etc.
- ✗ Ignora: Perfiles (`StructureDefinition-`), ValueSets, CodeSystems, ImplementationGuides

### Requisitos

- Python 3.6+
- Familia del SO agnostica (Windows/Mac/Linux)

---

## build-ig.sh (próximo)

Script wrapper que ejecuta `sushi build` + `python3 _scripts/add-lang-to-xhtml.py` en secuencia.
