#!/usr/bin/env python3
"""
Script: Agregar atributos lang y xml:lang a XHTML narrativos
========================================================================
Propósito: Modificar todos los recursos JSON generados por SUSHI para que los
           elementos <div> narrativos tengan los atributos lang y xml:lang
           correspondientes al field 'language' del recurso.

Ejecución: python3 _scripts/add-lang-to-xhtml.py
           (Ejecutar después de: sushi build)

Cambios:
  <div xmlns="http://www.w3.org/1999/xhtml">
  
  A:
  <div xmlns="http://www.w3.org/1999/xhtml" lang="es" xml:lang="es">
========================================================================
"""

import json
import re
import sys
from pathlib import Path


def add_lang_to_resource(resource, lang):
    """
    Agrega lang attributes a <div> si el recurso tiene language definido.
    
    Args:
        resource: Dict del recurso FHIR
        lang: Código de idioma (ej: "es")
    
    Returns:
        bool: True si se realizó modificación
    """
    if not isinstance(resource, dict):
        return False
    
    # Verificar si tiene language y text.div
    if not resource.get('language') or not resource.get('text', {}).get('div'):
        return False
    
    div = resource['text']['div']
    
    # Si ya tiene lang attributes, saltar
    if f'lang="{lang}"' in div or f"lang='{lang}'" in div:
        return False
    
    # Reemplazar el opening tag del div
    # Buscar: <div xmlns="http://www.w3.org/1999/xhtml">
    pattern = r'<div xmlns="http://www\.w3\.org/1999/xhtml">'
    replacement = f'<div xmlns="http://www.w3.org/1999/xhtml" lang="{lang}" xml:lang="{lang}">'
    
    new_div = re.sub(pattern, replacement, div, count=1)
    if new_div != div:
        resource['text']['div'] = new_div
        return True
    
    return False


def process_fhir_resources(fsh_generated_dir="fsh-generated/resources"):
    """
    Procesa todos los archivos JSON en el directorio de recursos generados.
    
    Args:
        fsh_generated_dir: Path al directorio de recursos FSH generados
    
    Returns:
        tuple: (total procesados, total actualizados)
    """
    res_path = Path(fsh_generated_dir)
    
    if not res_path.exists():
        print(f"❌ Error: Directorio no encontrado: {res_path.absolute()}")
        return 0, 0
    
    files = sorted(res_path.glob("*.json"))
    
    # Filtrar: solo ejemplos y recursos clínicos (excluir perfiles/definiciones)
    ignore_prefixes = (
        'StructureDefinition-',
        'ValueSet-',
        'CodeSystem-',
        'ImplementationGuide-',
        'NamingSystem-'
    )
    
    example_files = [
        f for f in files 
        if not f.name.startswith(ignore_prefixes)
    ]
    
    updated_count = 0
    total_count = len(example_files)
    
    for filepath in example_files:
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            file_modified = False
            
            # Procesar recurso principal
            if data.get('language'):
                lang = data['language']
                if add_lang_to_resource(data, lang):
                    file_modified = True
            
            # Procesar recursos dentro de Bundle.entry[]
            if data.get('resourceType') == 'Bundle' and data.get('entry'):
                for entry in data['entry']:
                    if entry.get('resource'):
                        resource = entry['resource']
                        if resource.get('language'):
                            lang = resource['language']
                            if add_lang_to_resource(resource, lang):
                                file_modified = True
            
            # Guardar si hubo cambios
            if file_modified:
                with open(filepath, 'w', encoding='utf-8') as f:
                    json.dump(data, f, indent=2, ensure_ascii=False)
                updated_count += 1
                print(f"✓ {filepath.name}")
        
        except json.JSONDecodeError as e:
            print(f"⚠ JSON Error en {filepath.name}: {e}")
        except Exception as e:
            print(f"⚠ Error procesando {filepath.name}: {e}")
    
    return total_count, updated_count


def main():
    """Punto de entrada principal."""
    print("\n" + "="*70)
    print("SCRIPT: Agregar lang attributes a XHTML narrativos")
    print("="*70 + "\n")
    
    # Detectar directorio PWD
    cwd = Path.cwd()
    fsh_gen_dir = cwd / "fsh-generated" / "resources"
    
    if not fsh_gen_dir.exists():
        print(f"❌ Error: No se encontró {fsh_gen_dir.relative_to(cwd)}")
        print("   Asegúrate de ejecutar: sushi build")
        print("   Y luego: python3 _scripts/add-lang-to-xhtml.py")
        return 1
    
    total, updated = process_fhir_resources(str(fsh_gen_dir))
    
    print("\n" + "="*70)
    print("RESUMEN")
    print("="*70)
    print(f"Total archivos procesados:  {total}")
    print(f"Archivos actualizados:      {updated}")
    print(f"Tasa de actualización:      {100*updated/total if total > 0 else 0:.1f}%")
    print("="*70 + "\n")
    
    # Sin cambios tambien es un resultado valido para CI/CD.
    return 0


if __name__ == '__main__':
    sys.exit(main())
