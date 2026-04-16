#!/usr/bin/env python3
"""
Script para validar todos los ejemplos contra sus respectivos perfiles FHIR.
Valida estructura JSON, conformidad de tipos y referencias entre recursos.
"""

import json
import glob
import sys
from pathlib import Path
from typing import Dict, List, Tuple, Any

# Mapeo de tipos de recursos a sus perfiles
PROFILE_MAP = {
    "Patient": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-patient-laboratory-result",
    "Organization": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-organization-laboratory-result",
    "Practitioner": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-practitioner-laboratory-result",
    "PractitionerRole": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-practitioner-role-laboratory-result",
    "Specimen": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-specimen-hba1c-laboratory-result",
    "Observation": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-observation-hba1c-laboratory-result",
    "DiagnosticReport": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-diagnostic-report-hba1c-laboratory-result",
    "Composition": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-composition-hba1c-laboratory-result",
    "Bundle": "https://hl7.meddyg.com/fhir/laboratory-results/StructureDefinition/cr-bundle-hba1c-laboratory-result",
}

REQUIRED_FIELDS = {
    "Patient": ["id", "resourceType"],
    "Organization": ["id", "resourceType"],
    "Practitioner": ["id", "resourceType"],
    "PractitionerRole": ["id", "resourceType", "active"],
    "Specimen": ["id", "resourceType", "status"],
    "Observation": ["id", "resourceType", "status", "code"],
    "DiagnosticReport": ["id", "resourceType", "status", "code"],
    "Composition": ["id", "resourceType", "status", "type"],
    "Bundle": ["id", "resourceType", "type"],
}


def load_resources() -> Dict[str, Any]:
    """Carga todos los recursos generados."""
    resources = {}
    pattern = "fsh-generated/resources/*.json"
    
    for file_path in glob.glob(pattern):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                resource = json.load(f)
                res_id = resource.get("id")
                if res_id:
                    resources[res_id] = resource
        except json.JSONDecodeError as e:
            print(f"⚠️  Error al parsear {file_path}: {e}")
    
    return resources


def validate_required_fields(resource: Dict[str, Any]) -> Tuple[bool, List[str]]:
    """Valida que un recurso tenga los campos requeridos."""
    res_type = resource.get("resourceType")
    required = REQUIRED_FIELDS.get(res_type, ["id", "resourceType"])
    
    missing = [f for f in required if f not in resource or resource[f] is None]
    return len(missing) == 0, missing


def validate_references(resource: Dict[str, Any], all_resources: Dict[str, Any]) -> Tuple[bool, List[str]]:
    """Valida que las referencias apunten a recursos existentes."""
    def extract_references(obj: Any, path: str = "") -> List[Tuple[str, str]]:
        refs = []
        if isinstance(obj, dict):
            if "reference" in obj:
                refs.append((path, obj["reference"]))
            for key, value in obj.items():
                refs.extend(extract_references(value, f"{path}.{key}" if path else key))
        elif isinstance(obj, list):
            for i, item in enumerate(obj):
                refs.extend(extract_references(item, f"{path}[{i}]"))
        return refs
    
    references = extract_references(resource)
    broken_refs = []
    
    for path, ref in references:
        ref_id = ref.split("/")[-1]
        if ref_id not in all_resources:
            broken_refs.append(f"{path}: {ref} (no encontrado)")
    
    return len(broken_refs) == 0, broken_refs


def validate_profile_conformance(resource: Dict[str, Any]) -> Tuple[bool, List[str]]:
    """Valida conformidad básica con el perfil."""
    res_type = resource.get("resourceType")
    expected_profile = PROFILE_MAP.get(res_type)
    
    issues = []
    
    # Verificar que meta.profile contiene el perfil esperado
    meta_profiles = resource.get("meta", {}).get("profile", [])
    if expected_profile:
        # La URL puede estar con o sin versión; aceptamos ambas
        has_profile = any(
            expected_profile in prof or prof.startswith(expected_profile + "|")
            for prof in meta_profiles
        )
        if not has_profile:
            issues.append(f"Perfil esperado no encontrado en meta.profile. Esperado: {expected_profile}, Encontrado: {meta_profiles}")
    
    # Checks específicos por tipo
    if res_type == "Observation" or res_type == "DiagnosticReport":
        if "status" not in resource or resource["status"] not in ["final", "preliminary"]:
            issues.append(f"status debe ser 'final' o 'preliminary', encontrado: {resource.get('status')}")
    
    if res_type == "Bundle":
        if "type" not in resource or resource["type"] != "document":
            issues.append(f"Bundle.type debe ser 'document'")
    
    if res_type == "Composition":
        if "status" not in resource or resource["status"] not in ["preliminary", "final"]:
            issues.append(f"Composition.status debe ser 'preliminary' o 'final'")
    
    if res_type == "PractitionerRole":
        if "active" not in resource:
            issues.append(f"PractitionerRole.active es requerido")
    
    return len(issues) == 0, issues


def validate_example(res_id: str, resource: Dict[str, Any], all_resources: Dict[str, Any]) -> Dict[str, Any]:
    """Valida un ejemplo completo."""
    res_type = resource.get("resourceType")
    profile = PROFILE_MAP.get(res_type, "Unknown")
    
    # Validaciones
    fields_ok, missing_fields = validate_required_fields(resource)
    refs_ok, broken_refs = validate_references(resource, all_resources)
    profile_ok, profile_issues = validate_profile_conformance(resource)
    
    all_ok = fields_ok and refs_ok and profile_ok
    
    return {
        "id": res_id,
        "type": res_type,
        "profile": profile,
        "status": "✅ VÁLIDO" if all_ok else "❌ INVÁLIDO",
        "issues": {
            "campos_requeridos": missing_fields if not fields_ok else [],
            "referencias_rotas": broken_refs if not refs_ok else [],
            "perfil": profile_issues if not profile_ok else [],
        }
    }


def main():
    print("=" * 80)
    print("VALIDACIÓN DE EJEMPLOS FHIR - IG Resultados de Laboratorio")
    print("=" * 80)
    print()
    
    resources = load_resources()
    print(f"✓ {len(resources)} recursos cargados")
    print()
    
    # Identificar ejemplos
    examples = {res_id: res for res_id, res in resources.items() if "Example" in res_id}
    print(f"✓ {len(examples)} ejemplos identificados")
    print()
    
    # Validar
    results = []
    for res_id, resource in sorted(examples.items()):
        result = validate_example(res_id, resource, resources)
        results.append(result)
    
    # Generar reporte
    print("RESULTADOS DE VALIDACIÓN")
    print("-" * 80)
    
    valid_count = 0
    invalid_count = 0
    
    for result in results:
        status = result["status"]
        print(f"\n{status} {result['id']}")
        print(f"   Tipo: {result['type']}")
        print(f"   Perfil: {result['profile']}")
        
        if "❌" in status:
            invalid_count += 1
            issues = result["issues"]
            
            if issues["campos_requeridos"]:
                print(f"   ⚠️  Campos faltantes: {', '.join(issues['campos_requeridos'])}")
            
            if issues["referencias_rotas"]:
                for ref_issue in issues["referencias_rotas"]:
                    print(f"   ⚠️  {ref_issue}")
            
            if issues["perfil"]:
                for prof_issue in issues["perfil"]:
                    print(f"   ⚠️  {prof_issue}")
        else:
            valid_count += 1
    
    print()
    print("=" * 80)
    print(f"RESUMEN: {valid_count} válidos, {invalid_count} inválidos")
    print("=" * 80)
    
    return 0 if invalid_count == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
