# Scripts de Post-Procesamiento para la IG

## add-lang-to-xhtml.py

Agrega `lang` y `xml:lang` a las narrativas XHTML de los recursos FHIR generados.

### Cuándo usarlo

1. Después de `sushi build`
2. Después de `_genonce.sh`
3. Cuando necesites corregir narrativas en salidas ya generadas

### Directorios que procesa por defecto

1. `output/`
2. `output/es/`
3. `fsh-generated/resources/`

También puedes pasar directorios manualmente:

```bash
python3 _scripts/add-lang-to-xhtml.py output output/es
```

### Ejemplos de uso

```bash
# SUSHI + post-proceso
bash _scripts/build-ig.sh

# IG Publisher + post-proceso
bash _scripts/post-genonce.sh

# Solo post-proceso
python3 _scripts/add-lang-to-xhtml.py
```

## build-ig.sh

Ejecuta `sushi build` y luego corre `add-lang-to-xhtml.py`.

```bash
bash _scripts/build-ig.sh
bash _scripts/build-ig.sh --skip-xhtml
```

## post-genonce.sh

Ejecuta `_genonce.sh` y luego corre `add-lang-to-xhtml.py` sobre `output/` y `output/es/`.

```bash
bash _scripts/post-genonce.sh
bash _scripts/post-genonce.sh -watch
```

## Requisitos

1. Python 3
2. Java disponible para `_genonce.sh`
3. Narrativas definidas en FSH si quieres que el script tenga algo que ajustar
