#!/usr/bin/env python3
"""
Script para validar ejemplos FHIR en HAPI FHIR R5 Server público.
Carga perfiles y ejemplos en http://hapi.fhir.org/baseR5 y ejecuta validaciones.
"""

import json
import glob
import requests
import sys
from pathlib import Path
from typing import Dict, List, Tuple, Any

HAPI_URL = "http://hapi.fhir.org/baseR5"
HEADERS = {"Content-Type": "application/fhir+json"}

# Tipos de recursos en orden de carga (perfiles primero, luego instancias)
LOAD_ORDER = [
    "StructureDefinition",
    "CodeSystem",
    "ValueSet",
    "Patient",
    "Organization",
    "Practitioner",
    "PractitionerRole",
    "Specimen",
    "Observation",
    "DiagnosticReport",
    "Composition",
    "Bundle",
]


def load_resources() -> Dict[str, List[Dict[str, Any]]]:
    """Carga todos los recursos generados agrupados por tipo."""
    resources_by_type = {}
    pattern = "fsh-generated/resources/*.json"
    
    for file_path in glob.glob(pattern):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                resource = json.load(f)
                res_type = resource.get("resourceType")
                if res_type not in resources_by_type:
                    resources_by_type[res_type] = []
                resources_by_type[res_type].append(resource)
        except json.JSONDecodeError as e:
            print(f"⚠️  Error al parsear {file_path}: {e}")
    
    return resources_by_type


def post_resource(resource: Dict[str, Any]) -> Tuple[bool, str]:
    """Carga un recurso en el servidor HAPI."""
    res_id = resource.get("id")
    res_type = resource.get("resourceType")
    
    url = f"{HAPI_URL}/{res_type}/{res_id}"
    
    try:
        response = requests.put(url, json=resource, headers=HEADERS, timeout=10)
        if response.status_code in [200, 201]:
            return True, f"Cargado: {res_type}/{res_id}"
        else:
            return False, f"Error {response.status_code}: {response.text[:100]}"
    except requests.RequestException as e:
        return False, f"Excepción: {str(e)[:100]}"


def validate_resource(resource: Dict[str, Any]) -> Tuple[bool, str, List[Dict]]:
    """Valida un recurso usando la operación $validate del servidor."""
    res_id = resource.get("id")
    res_type = resource.get("resourceType")
    
    url = f"{HAPI_URL}/{res_type}/$validate"
    
    try:
        response = requests.post(url, json=resource, headers=HEADERS, timeout=10)
        
        if response.status_code not in [200, 201]:
            return False, f"Error HTTP {response.status_code}", []
        
        body = response.json()
        
        # Buscar issues en la respuesta
        issues = body.get("issue", [])
        
        # Filtrar solo errores y warnings, no information
        errors = [i for i in issues if i.get("severity") in ["error", "fatal"]]
        warnings = [i for i in issues if i.get("severity") == "warning"]
        
        if errors:
            error_msgs = [f"{e.get('code')}: {e.get('diagnostics', '')}" for e in errors]
            return False, f"Errores: {'; '.join(error_msgs[:2])}", []
        
        if warnings:
            return True, f"⚠️  {len(warnings)} warnings", warnings
        
        return True, "Sin errores", []
        
    except requests.RequestException as e:
        return False, f"Excepción: {str(e)[:100]}"


def main():
    print("=" * 80)
    print("VALIDACIÓN EN HAPI FHIR R5 - IG Resultados de Laboratorio")
    print(f"Servidor: {HAPI_URL}")
    print("=" * 80)
    print()
    
    resources_by_type = load_resources()
    
    total_resources = sum(len(r) for r in resources_by_type.values())
    print(f"✓ {total_resources} recursos cargados desde FSH")
    print()
    
    # Contar ejemplos
    example_count = sum(
        1 for res_list in resources_by_type.values()
        for res in res_list
        if "Example" in res.get("id", "")
    )
    print(f"✓ {example_count} ejemplos identificados")
    print()
    
    # Fase 1: Cargar perfiles y recursos base
    print("FASE 1: Cargando perfiles e infraestructura...")
    print("-" * 80)
    
    load_count = 0
    load_failed = 0
    
    for res_type in LOAD_ORDER:
        resources = resources_by_type.get(res_type, [])
        if not resources:
            continue
        
        # Cargar perfiles primero, instancias después
        if res_type in ["StructureDefinition", "CodeSystem", "ValueSet"]:
            for resource in resources:
                success, msg = post_resource(resource)
                if success:
                    load_count += 1
                    print(f"  ✅ {msg}")
                else:
                    load_failed += 1
                    print(f"  ❌ {msg}")
    
    print()
    print(f"Cargados {load_count} perfiles, {load_failed} fallos")
    print()
    
    # Fase 2: Cargar instancias
    print("FASE 2: Cargando ejemplos...")
    print("-" * 80)
    
    instance_count = 0
    instance_failed = 0
    
    for res_type in LOAD_ORDER:
        resources = resources_by_type.get(res_type, [])
        if not resources or res_type in ["StructureDefinition", "CodeSystem", "ValueSet"]:
            continue
        
        for resource in resources:
            res_id = resource.get("id")
            if "Example" in res_id:
                success, msg = post_resource(resource)
                if success:
                    instance_count += 1
                    print(f"  ✅ {msg}")
                else:
                    instance_failed += 1
                    print(f"  ❌ {msg}")
    
    print()
    print(f"Cargados {instance_count} ejemplos, {instance_failed} fallos")
    print()
    
    # Fase 3: Validar ejemplos
    print("FASE 3: Validando ejemplos contra perfiles...")
    print("-" * 80)
    
    valid_count = 0
    invalid_count = 0
    
    for res_type in LOAD_ORDER:
        resources = resources_by_type.get(res_type, [])
        if not resources:
            continue
        
        for resource in resources:
            res_id = resource.get("id")
            if "Example" in res_id:
                success, msg, warnings = validate_resource(resource)
                status = "✅" if success else "❌"
                print(f"  {status} {res_type}/{res_id}: {msg}")
                # Imprimir detalles de warnings si existen
                if warnings:
                    for warning in warnings:
                        code = warning.get("code", "?")
                        diagnostics = warning.get("diagnostics", "Sin detalles")
                        location = warning.get("location", ["?"])
                        print(f"      ⚠️  [{code}] {diagnostics}")
                        if location and location != ["?"]:
                            print(f"         Location: {location}")
                if success:
                    valid_count += 1
                else:
                    invalid_count += 1
    
    print()
    print("=" * 80)
    print(f"RESUMEN: {valid_count} válidos, {invalid_count} inválidos")
    print("=" * 80)
    
    return 0 if invalid_count == 0 else 1


if __name__ == "__main__":
    try:
        # Probar conexión
        print("Probando conexión con HAPI FHIR...")
        response = requests.get(f"{HAPI_URL}/metadata", timeout=5)
        if response.status_code != 200:
            print(f"❌ No se puede conectar a {HAPI_URL}")
            print(f"    Status: {response.status_code}")
            sys.exit(1)
        print(f"✓ Conectado a {HAPI_URL}")
        print()
    except requests.RequestException as e:
        print(f"❌ Error de conexión: {e}")
        sys.exit(1)
    
    sys.exit(main())
