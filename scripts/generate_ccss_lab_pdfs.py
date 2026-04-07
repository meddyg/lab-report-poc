#!/usr/bin/env python3
import glob
import json
import os
from datetime import datetime

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import mm
from reportlab.pdfbase.pdfmetrics import stringWidth
from reportlab.pdfgen import canvas

INPUT_GLOB = "fsh-generated/resources/Bundle-*.json"
OUTPUT_DIR = "generated/pdf-lab-reports-ccss"
LOGO_PATH = "docs/sample/Logo-CCSS-CostaRica-negro.png"


def first(lst, default=None):
    return lst[0] if isinstance(lst, list) and lst else default


def ref_value(ref):
    if isinstance(ref, dict):
        return ref.get("reference")
    return ref


def get_cc_text(cc):
    if not isinstance(cc, dict):
        return ""
    coding = first(cc.get("coding", []), {}) or {}
    display = coding.get("display")
    code = coding.get("code")
    if display and code:
        return f"{display} ({code})"
    if display:
        return display
    if code:
        return code
    return cc.get("text", "")


def patient_name(patient):
    if not patient:
        return ""
    nm = first(patient.get("name", []), {}) or {}
    given = " ".join(nm.get("given", [])) if isinstance(nm.get("given"), list) else ""
    family = nm.get("family", "")
    full = (given + " " + family).strip()
    return full or patient.get("id", "")


def identifier_value(resource):
    ident = first(resource.get("identifier", []), {}) if resource else {}
    return (ident or {}).get("value", "")


def fmt_date(iso_dt):
    if not iso_dt:
        return ""
    try:
        dt = datetime.fromisoformat(iso_dt.replace("Z", "+00:00"))
        month_map = {
            1: "ene",
            2: "feb",
            3: "mar",
            4: "abr",
            5: "may",
            6: "jun",
            7: "jul",
            8: "ago",
            9: "sep",
            10: "oct",
            11: "nov",
            12: "dic",
        }
        return f"{dt.day:02d}-{month_map[dt.month]}-{dt.year} {dt.strftime('%I:%M %p')}"
    except ValueError:
        return iso_dt


def wrap_text(text, font_name, font_size, max_w):
    words = str(text or "").split()
    if not words:
        return [""]
    lines = []
    current = words[0]
    for w in words[1:]:
        test = current + " " + w
        if stringWidth(test, font_name, font_size) <= max_w:
            current = test
        else:
            lines.append(current)
            current = w
    lines.append(current)
    return lines


def fit_text(text, font_name, font_size, max_w):
    txt = str(text or "")
    if stringWidth(txt, font_name, font_size) <= max_w:
        return txt
    ellipsis = "..."
    while txt and stringWidth(txt + ellipsis, font_name, font_size) > max_w:
        txt = txt[:-1]
    return (txt + ellipsis) if txt else ellipsis


def draw_wrapped_lines(c, lines, x, y, line_gap_mm=4.4, font_name="Helvetica", font_size=10):
    c.setFont(font_name, font_size)
    current_y = y
    for line in lines:
        c.drawString(x, current_y, line)
        current_y -= line_gap_mm * mm
    return current_y


def draw_right(c, x, y, text, font="Helvetica", size=10):
    c.setFont(font, size)
    c.drawString(x - stringWidth(text, font, size), y, text)


def draw_watermark(c, width, height):
    c.saveState()
    c.setFillColor(colors.Color(0.86, 0.86, 0.86, alpha=0.42))
    c.setFont("Helvetica-Bold", 22)
    c.translate(width * 0.76, height * 0.50)
    c.rotate(90)
    c.drawCentredString(0, 30, "CAJA COSTARRICENSE DE SEGURO SOCIAL")
    c.drawCentredString(0, -10, "CAJA COSTARRICENSE DE SEGURO SOCIAL")
    c.restoreState()


def build_index(bundle):
    idx = {}
    for entry in bundle.get("entry", []):
        res = entry.get("resource", {})
        if not res:
            continue
        rid = res.get("id")
        rtype = res.get("resourceType")
        fu = entry.get("fullUrl")
        if fu:
            idx[fu] = res
        if rtype and rid:
            idx[f"{rtype}/{rid}"] = res
    return idx


def resolve(idx, ref):
    if not ref:
        return None
    return idx.get(ref) or idx.get(ref.split("#")[0])


def pick_resources(bundle):
    resources = [e.get("resource", {}) for e in bundle.get("entry", []) if e.get("resource")]
    idx = build_index(bundle)

    comp = next((r for r in resources if r.get("resourceType") == "Composition"), None)
    dr = next((r for r in resources if r.get("resourceType") == "DiagnosticReport"), None)

    if not dr and comp:
        sec = first(comp.get("section", []), {}) or {}
        dr_ref = ref_value(first(sec.get("entry", []), {}))
        dr = resolve(idx, dr_ref)

    obs = [r for r in resources if r.get("resourceType") == "Observation"]
    if dr and dr.get("result"):
        dr_obs = []
        for rr in dr.get("result", []):
            ro = resolve(idx, ref_value(rr))
            if ro:
                dr_obs.append(ro)
        if dr_obs:
            obs = dr_obs

    patient = None
    if dr:
        patient = resolve(idx, ref_value(dr.get("subject")))
    if not patient and comp:
        subject = first(comp.get("subject", []), {})
        patient = resolve(idx, ref_value(subject))
    if not patient:
        patient = next((r for r in resources if r.get("resourceType") == "Patient"), None)

    specimen = None
    if dr and dr.get("specimen"):
        specimen = resolve(idx, ref_value(first(dr.get("specimen", []), {})))
    if not specimen and obs:
        specimen = resolve(idx, ref_value(obs[0].get("specimen")))

    practitioner_role = next((r for r in resources if r.get("resourceType") == "PractitionerRole"), None)
    practitioner = None
    if practitioner_role:
        practitioner = resolve(idx, ref_value(practitioner_role.get("practitioner")))
    if not practitioner:
        practitioner = next((r for r in resources if r.get("resourceType") == "Practitioner"), None)

    org_lab = None
    if dr and dr.get("performer"):
        for perf in dr.get("performer", []):
            r = resolve(idx, ref_value(perf))
            if r and r.get("resourceType") == "Organization":
                org_lab = r
                break
    if not org_lab and practitioner_role:
        org_lab = resolve(idx, ref_value(practitioner_role.get("organization")))

    org_hospital = None
    org_ccss = None
    if org_lab and org_lab.get("partOf"):
        org_hospital = resolve(idx, ref_value(org_lab.get("partOf")))
    if org_hospital and org_hospital.get("partOf"):
        org_ccss = resolve(idx, ref_value(org_hospital.get("partOf")))

    return comp, dr, obs, patient, specimen, practitioner, org_lab, org_hospital, org_ccss


def draw_header(c, bundle_id, dr, patient, specimen, org_lab, org_hospital, org_ccss):
    page_w, page_h = A4
    margin = 12 * mm

    header_top = page_h - margin
    header_h = 48 * mm
    header_bottom = header_top - header_h
    c.setStrokeColor(colors.black)
    c.setLineWidth(1.1)
    c.rect(margin, header_bottom, page_w - (2 * margin), header_h, stroke=1, fill=0)

    logo_x = margin + 5.5 * mm
    logo_y = header_top - 22.0 * mm
    logo_w = 13.5 * mm
    logo_h = 13.5 * mm
    if os.path.exists(LOGO_PATH):
        c.drawImage(LOGO_PATH, logo_x, logo_y, width=logo_w, height=logo_h, preserveAspectRatio=True, mask="auto")
    else:
        c.circle(logo_x + 6.75 * mm, logo_y + 6.75 * mm, 6.5 * mm, stroke=1, fill=0)
        c.setFont("Helvetica-Bold", 5)
        c.drawCentredString(logo_x + 6.75 * mm, logo_y + 5.5 * mm, "CCSS")

    c.setFont("Helvetica-Bold", 12)
    c.drawString(margin + 20 * mm, header_top - 8 * mm, org_ccss.get("name", "Caja Costarricense del Seguro Social") if org_ccss else "Caja Costarricense del Seguro Social")
    c.setFont("Helvetica", 8.5)
    left_w = (page_w - margin - 84 * mm) - (margin + 20 * mm)
    c.drawString(margin + 20 * mm, header_top - 13.5 * mm, "Sistema Integrado de Laboratorio Clinico (SILC)")
    c.drawString(
        margin + 20 * mm,
        header_top - 18.5 * mm,
        fit_text((org_hospital.get("name", "") if org_hospital else "").upper(), "Helvetica", 8.5, left_w),
    )
    c.drawString(
        margin + 20 * mm,
        header_top - 23.2 * mm,
        fit_text((org_lab.get("name", "") if org_lab else "LABORATORIO CLINICO").upper(), "Helvetica", 8.5, left_w),
    )

    c.setFillColor(colors.HexColor("#efefef"))
    c.rect(page_w - margin - 80 * mm, header_top - 31.6 * mm, 48 * mm, 12.6 * mm, stroke=0, fill=1)
    c.setFillColor(colors.black)

    right_x = page_w - margin - 6 * mm
    c.setFont("Helvetica-Bold", 12)
    draw_right(c, right_x, header_top - 8 * mm, "COPIA", "Helvetica-Bold", 12)
    draw_right(c, right_x, header_top - 14 * mm, identifier_value(patient) or bundle_id[-14:], "Helvetica-Bold", 11)
    c.setFont("Helvetica", 9)
    # Use fixed columns for label/value so both texts never overlap.
    date_y = header_top - 24.8 * mm
    date_label_x = page_w - margin - 68 * mm
    date_value_x = page_w - margin - 37 * mm
    c.drawString(date_label_x, date_y, "Fecha")
    c.drawString(date_value_x, date_y, fmt_date((dr or {}).get("issued")))

    # Split header area into upper identity and lower patient block.
    # Keep this divider low enough so it never crosses logo/date text.
    line_y = header_bottom + 20 * mm
    c.line(margin, line_y, page_w - margin, line_y)

    left_x = margin + 4 * mm
    c.setFont("Helvetica-Bold", 10.5)
    row_gap = 4.2 * mm
    c.drawString(left_x, line_y - 5.6 * mm, "Nº Identificación:")
    c.drawString(left_x, line_y - (5.6 * mm + row_gap), "Nombre:")
    c.drawString(left_x, line_y - (5.6 * mm + 2 * row_gap), "Procesa:")
    c.drawString(left_x, line_y - (5.6 * mm + 3 * row_gap), "Toma muestras:")

    c.setFont("Helvetica", 10.5)
    c.drawString(left_x + 39 * mm, line_y - 5.6 * mm, identifier_value(patient) or "")
    c.drawString(left_x + 39 * mm, line_y - (5.6 * mm + row_gap), fit_text(patient_name(patient).upper(), "Helvetica", 10.5, 93 * mm))
    c.drawString(left_x + 39 * mm, line_y - (5.6 * mm + 2 * row_gap), fit_text((org_hospital.get("name", "") if org_hospital else "").upper(), "Helvetica", 10.5, 93 * mm))
    sample_date = fmt_date((specimen or {}).get("collection", {}).get("collectedDateTime"))
    c.drawString(left_x + 39 * mm, line_y - (5.6 * mm + 3 * row_gap), sample_date.split(" ")[0] if sample_date else "")

    c.setFont("Helvetica", 10)
    draw_right(c, right_x, line_y - (5.6 * mm + 3 * row_gap), "Pagina    1      de    1", "Helvetica", 10)

    return header_bottom


def draw_results(c, y_start, dr, obs_list, practitioner, specimen):
    page_w, _ = A4
    margin = 12 * mm
    content_w = page_w - (2 * margin)

    y = y_start - 7 * mm
    c.setFont("Helvetica-Bold", 16)
    c.drawCentredString(page_w / 2.0, y, "INFORME DE RESULTADOS DE ANALISIS CLINICOS")
    y -= 10 * mm

    header_h = 7.2 * mm
    c.setFillColor(colors.HexColor("#dfdbdb"))
    c.rect(margin, y - header_h, content_w, header_h, stroke=0, fill=1)
    c.setFillColor(colors.black)
    c.setFont("Helvetica-Bold", 10.8)
    c.drawCentredString(margin + 20 * mm, y - 5.1 * mm, "PRUEBA")
    c.drawCentredString(margin + 58 * mm, y - 5.1 * mm, "RESULTADO")
    c.drawCentredString(margin + 94 * mm, y - 5.1 * mm, "REFERENCIA")
    c.drawCentredString(margin + 127 * mm, y - 5.1 * mm, "UNIDADES")
    c.drawCentredString(margin + 157 * mm, y - 5.1 * mm, "NOTA")
    y -= 9 * mm

    sec_h = 7.8 * mm
    c.setFillColor(colors.HexColor("#cbc5c5"))
    c.rect(margin, y - sec_h, content_w, sec_h, stroke=0, fill=1)
    c.setFillColor(colors.black)
    c.setFont("Helvetica-Bold", 12)
    cat = "QUIMICA"
    if dr:
        cat_code = first((first(dr.get("category", []), {}) or {}).get("coding", []), {}) or {}
        cat = (cat_code.get("display") or cat_code.get("code") or "QUIMICA").upper()
    c.drawString(margin + 1.5 * mm, y - 5.3 * mm, cat)
    validator = patient_name(practitioner) if practitioner else "Profesional no especificado"
    c.setFont("Helvetica-Bold", 9)
    c.drawString(margin + 1.5 * mm, y - 10.5 * mm, f"Validado Por: {validator} {fmt_date((dr or {}).get('issued'))[:11]}")
    y -= 13 * mm

    c.setFont("Helvetica", 10)
    for obs in obs_list:
        code = first((obs.get("code") or {}).get("coding", []), {}) or {}
        test_label = code.get("display") or obs.get("code", {}).get("text") or code.get("code") or "Prueba"
        if test_label == "4548-4":
            test_label = "Hemoglobina A1c"
        value_q = obs.get("valueQuantity", {}) or {}
        result = str(value_q.get("value", ""))
        unit = value_q.get("unit", "")

        rr = first(obs.get("referenceRange", []), {}) or {}
        ref = rr.get("text", "")
        if not ref and (rr.get("low") or rr.get("high")):
            low = (rr.get("low") or {}).get("value", "")
            high = (rr.get("high") or {}).get("value", "")
            ref = f"{low} - {high}"

        note = get_cc_text(first(obs.get("interpretation", []), {}))

        row_top = y
        col_x = [
            margin,
            margin + 42 * mm,
            margin + 77 * mm,
            margin + 111 * mm,
            margin + 141 * mm,
        ]
        col_w = [42 * mm, 35 * mm, 34 * mm, 30 * mm, 44 * mm]

        entries = [test_label, result, ref, unit, note]
        row_lines = []
        max_lines = 1
        for i, txt in enumerate(entries):
            lines = wrap_text(txt, "Helvetica", 10, col_w[i] - 2)
            row_lines.append(lines)
            max_lines = max(max_lines, len(lines))

        line_h = 4.1 * mm
        row_h = max_lines * line_h + 2
        if row_top - row_h < 24 * mm:
            break

        for i, lines in enumerate(row_lines):
            tx = col_x[i]
            ty = row_top - 4 * mm
            for ln in lines:
                c.drawString(tx, ty, ln)
                ty -= line_h

        y -= row_h

        c.setStrokeColor(colors.HexColor("#d7d7d7"))
        c.setLineWidth(0.3)
        # Draw the separator after the row is consumed so it does not cross over text.
        c.line(margin, y + 0.8 * mm, margin + content_w, y + 0.8 * mm)
        c.setStrokeColor(colors.black)
        c.setLineWidth(1)

    y -= 6 * mm
    c.setFont("Helvetica", 10)
    c.drawString(margin, y, "METODOLOGIA")
    method = get_cc_text(first(first(obs_list, {}).get("method", {}).get("coding", []), {}))
    method_lines = wrap_text(method or "No documentada", "Helvetica", 10, content_w - 46 * mm)
    c.drawString(margin + 45 * mm, y, method_lines[0])
    y -= 6 * mm
    c.drawString(margin, y, "OBSERVACIONES")
    obs_lines = wrap_text((dr or {}).get("conclusion", "Sin observaciones"), "Helvetica", 10, content_w - 46 * mm)
    c.drawString(margin + 45 * mm, y, obs_lines[0])
    next_y = y - 4.5 * mm
    for ln in obs_lines[1:3]:
        c.drawString(margin + 45 * mm, next_y, ln)
        next_y -= 4.5 * mm


def draw_semantic_mapping(c, bundle, comp, dr, obs_list, patient, specimen, practitioner, org_lab, org_hospital, org_ccss):
    page_w, page_h = A4
    margin = 14 * mm
    y = page_h - 18 * mm

    c.setFillColor(colors.white)
    c.rect(0, 0, page_w, page_h, stroke=0, fill=1)
    c.setFillColor(colors.black)

    c.setFont("Helvetica-Bold", 15)
    c.drawString(margin, y, "TRAZABILIDAD SEMANTICA DEL PDF")
    y -= 7 * mm

    c.setFont("Helvetica", 10)
    intro = (
        "Este PDF se genera directamente a partir de un Bundle document de ejemplo de la IG. "
        "El objetivo es mostrar al implementador que datos FHIR alimentan cada bloque visible del informe."
    )
    y = draw_wrapped_lines(c, wrap_text(intro, "Helvetica", 10, page_w - (2 * margin)), margin, y)
    y -= 4 * mm

    c.setFont("Helvetica-Bold", 11)
    c.drawString(margin, y, "Bundle fuente")
    y -= 5 * mm
    c.setFont("Helvetica", 10)
    bundle_lines = [
        f"Bundle.id: {bundle.get('id', '')}",
        f"Bundle.identifier.value: {(bundle.get('identifier') or {}).get('value', '')}",
        f"Bundle.type: {bundle.get('type', '')}",
        f"Bundle.timestamp: {bundle.get('timestamp', '')}",
    ]
    y = draw_wrapped_lines(c, bundle_lines, margin + 4 * mm, y, font_size=10)
    y -= 3 * mm

    mappings = [
        ("Titulo principal del PDF", f"Composition.title = {(comp or {}).get('title', '')}"),
        ("Fecha y hora del encabezado", f"DiagnosticReport.issued = {(dr or {}).get('issued', '')}"),
        ("Numero de identificacion", f"Patient.identifier[0].value = {identifier_value(patient)}"),
        ("Nombre del paciente", f"Patient.name = {patient_name(patient)}"),
        ("Procesa", f"Organization(partOf).name = {(org_hospital or {}).get('name', '')}"),
        (
            "Toma de muestras",
            f"Specimen.collection.collectedDateTime = {((specimen or {}).get('collection') or {}).get('collectedDateTime', '')}",
        ),
        ("Institucion emisora", f"Organization.name = {(org_ccss or {}).get('name', '')}"),
        (
            "Validador del resultado",
            f"Practitioner.name = {patient_name(practitioner) if practitioner else ''}",
        ),
    ]

    c.setFont("Helvetica-Bold", 11)
    c.drawString(margin, y, "Relacion entre recursos FHIR y bloques del informe")
    y -= 6 * mm

    for label, source in mappings:
        c.setFont("Helvetica-Bold", 10)
        c.drawString(margin, y, label)
        y -= 4.5 * mm
        c.setFont("Helvetica", 10)
        y = draw_wrapped_lines(c, wrap_text(source, "Helvetica", 10, page_w - (2 * margin) - 5 * mm), margin + 5 * mm, y)
        y -= 2 * mm

    c.setFont("Helvetica-Bold", 11)
    c.drawString(margin, y, "Filas de resultados")
    y -= 6 * mm

    for index, obs in enumerate(obs_list, start=1):
        code = first((obs.get("code") or {}).get("coding", []), {}) or {}
        rr = first(obs.get("referenceRange", []), {}) or {}
        value_q = obs.get("valueQuantity", {}) or {}
        interpretation = get_cc_text(first(obs.get("interpretation", []), {}))
        row_lines = [
            f"Resultado {index}: Observation/{obs.get('id', '')}",
            f"  PRUEBA <- Observation.code = {code.get('display') or code.get('code') or ''}",
            f"  RESULTADO <- Observation.valueQuantity.value = {value_q.get('value', '')}",
            f"  UNIDADES <- Observation.valueQuantity.unit = {value_q.get('unit', '')}",
            f"  REFERENCIA <- Observation.referenceRange = {rr.get('text', '')}",
            f"  NOTA <- Observation.interpretation = {interpretation}",
        ]
        c.setFont("Helvetica", 9.5)
        y = draw_wrapped_lines(c, row_lines, margin + 4 * mm, y, line_gap_mm=4.0, font_name="Helvetica", font_size=9.5)
        y -= 2 * mm

    y -= 2 * mm
    c.setFont("Helvetica-Bold", 11)
    c.drawString(margin, y, "Recursos incluidos en el bundle de ejemplo")
    y -= 6 * mm
    c.setFont("Helvetica", 9.5)
    resources = [
        f"Composition/{(comp or {}).get('id', '')}",
        f"DiagnosticReport/{(dr or {}).get('id', '')}",
        f"Patient/{(patient or {}).get('id', '')}",
        f"Specimen/{(specimen or {}).get('id', '')}",
        f"Practitioner/{(practitioner or {}).get('id', '')}",
        f"Organization/{(org_lab or {}).get('id', '')}",
        f"Organization/{(org_hospital or {}).get('id', '')}",
        f"Organization/{(org_ccss or {}).get('id', '')}",
    ]
    resources.extend([f"Observation/{obs.get('id', '')}" for obs in obs_list])
    y = draw_wrapped_lines(c, resources, margin + 4 * mm, y, line_gap_mm=4.0, font_name="Helvetica", font_size=9.5)


def build_pdf(bundle_path, out_dir):
    with open(bundle_path, "r", encoding="utf-8") as f:
        bundle = json.load(f)

    comp, dr, obs_list, patient, specimen, practitioner, org_lab, org_hospital, org_ccss = pick_resources(bundle)
    bundle_id = bundle.get("id", os.path.basename(bundle_path).replace(".json", ""))
    out_path = os.path.join(out_dir, f"{bundle_id}-CCSS.pdf")

    c = canvas.Canvas(out_path, pagesize=A4)
    page_w, page_h = A4
    c.setFillColor(colors.HexColor("#f4f4f4"))
    c.rect(0, 0, page_w, page_h, stroke=0, fill=1)
    c.setFillColor(colors.black)
    draw_watermark(c, page_w, page_h)
    header_bottom = draw_header(c, bundle_id, dr, patient, specimen, org_lab, org_hospital, org_ccss)
    draw_results(c, header_bottom, dr, obs_list, practitioner, specimen)
    c.showPage()
    draw_semantic_mapping(c, bundle, comp, dr, obs_list, patient, specimen, practitioner, org_lab, org_hospital, org_ccss)
    c.showPage()
    c.save()
    return out_path


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    bundles = sorted(glob.glob(INPUT_GLOB))
    generated = []
    for b in bundles:
        output_path = build_pdf(b, OUTPUT_DIR)
        generated.append(output_path)
    for p in generated:
        print(f"PDF institucional generado: {p}")
    print(f"TOTAL={len(generated)}")


if __name__ == "__main__":
    main()
