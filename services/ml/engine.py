"""
Prema AI - Local ML Engine
Uses scikit-learn on CPU (AMD EPYC). Trains 4 models:
  1. account_classifier   - vendor name -> account code
  2. tax_predictor        - bill features -> GST/HST code
  3. duplicate_detector   - bill fingerprint -> duplicate probability
  4. field_corrector      - extracted fields -> corrected fields

Models are persisted via joblib in /tmp/prema_ml/
Auto-retrains when correction data grows.
"""
import hashlib
import json
import logging
import os
import re

_logger = logging.getLogger(__name__)
ML_DIR = "/tmp/prema_ml"

try:
    import joblib
    import numpy as np
    from sklearn.feature_extraction.text import TfidfVectorizer
    from sklearn.linear_model import LogisticRegression
    from sklearn.pipeline import Pipeline
    from sklearn.preprocessing import LabelEncoder
    ML_AVAILABLE = True
except ImportError:
    ML_AVAILABLE = False
    _logger.warning(
        "Prema ML: scikit-learn/joblib not installed. "
        "Run: pip install scikit-learn joblib --break-system-packages"
    )


def _ensure_dir():
    os.makedirs(ML_DIR, exist_ok=True)


def _model_path(name):
    return os.path.join(ML_DIR, "{}.joblib".format(name))


# 1. ACCOUNT CLASSIFIER

def train_account_classifier(env):
    if not ML_AVAILABLE:
        return {"error": "scikit-learn not installed"}
    _ensure_dir()
    try:
        lines = env["account.move.line"].search_read(
            [("move_id.move_type", "=", "in_invoice"),
             ("move_id.state", "=", "posted"),
             ("account_id", "!=", False),
             ("name", "!=", False)],
            ["name", "partner_id", "account_id"], limit=5000)
        if len(lines) < 20:
            return {"error": "Not enough data (need 20+ posted bill lines)"}
        X, y = [], []
        for line in lines:
            vendor = line["partner_id"][1] if line["partner_id"] else ""
            desc = line["name"] or ""
            text = "{} {}".format(vendor, desc).lower().strip()
            account_code = line["account_id"][1].split(" ")[0] if line["account_id"] else ""
            if text and account_code:
                X.append(text)
                y.append(account_code)
        if len(set(y)) < 2:
            return {"error": "Need at least 2 distinct account codes in data"}
        pipeline = Pipeline([
            ("tfidf", TfidfVectorizer(ngram_range=(1, 2), max_features=5000)),
            ("clf", LogisticRegression(max_iter=500, C=1.0)),
        ])
        pipeline.fit(X, y)
        joblib.dump({"pipeline": pipeline, "classes": list(set(y))}, _model_path("account_classifier"))
        _logger.info("Prema ML: account_classifier trained on %d samples", len(X))
        return {"success": True, "samples": len(X), "classes": len(set(y))}
    except Exception as e:
        _logger.error("Prema ML account_classifier training error: %s", e)
        return {"error": str(e)}


def predict_account(vendor_name, description):
    if not ML_AVAILABLE:
        return None
    path = _model_path("account_classifier")
    if not os.path.exists(path):
        return None
    try:
        data = joblib.load(path)
        text = "{} {}".format(vendor_name or "", description or "").lower().strip()
        proba = data["pipeline"].predict_proba([text])[0]
        classes = data["pipeline"].classes_
        best_idx = int(proba.argmax())
        confidence = float(proba[best_idx])
        if confidence > 0.35:
            return {"account_code": classes[best_idx], "confidence": round(confidence, 3)}
    except Exception as e:
        _logger.warning("Prema ML predict_account error: %s", e)
    return None


# 2. TAX CODE PREDICTOR

def train_tax_predictor(env):
    if not ML_AVAILABLE:
        return {"error": "scikit-learn not installed"}
    _ensure_dir()
    try:
        moves = env["account.move"].search_read(
            [("move_type", "=", "in_invoice"), ("state", "=", "posted")],
            ["id", "partner_id", "amount_total", "currency_id"], limit=3000)
        X, y = [], []
        for move in moves:
            lines = env["account.move.line"].search_read(
                [("move_id", "=", move["id"]), ("tax_ids", "!=", False)],
                ["name", "tax_ids", "price_unit"])
            for line in lines:
                tax_names = []
                for tid in (line["tax_ids"] or []):
                    t = env["account.tax"].browse(tid)
                    tax_names.append(t.name)
                if not tax_names:
                    continue
                vendor = move["partner_id"][1] if move["partner_id"] else ""
                currency = move["currency_id"][1] if move["currency_id"] else "CAD"
                desc = (line["name"] or "").lower()
                amount = line["price_unit"] or 0
                features = "{} {} {} {}".format(
                    vendor, currency, desc, "large" if amount > 1000 else "small")
                X.append(features.lower())
                y.append(tax_names[0])
        if len(X) < 20:
            return {"error": "Not enough tax data (need 20+ bill lines with taxes)"}
        pipeline = Pipeline([
            ("tfidf", TfidfVectorizer(ngram_range=(1, 2), max_features=3000)),
            ("clf", LogisticRegression(max_iter=500)),
        ])
        pipeline.fit(X, y)
        joblib.dump({"pipeline": pipeline}, _model_path("tax_predictor"))
        _logger.info("Prema ML: tax_predictor trained on %d samples", len(X))
        return {"success": True, "samples": len(X)}
    except Exception as e:
        return {"error": str(e)}


def predict_tax(vendor_name, amount, description="", currency="CAD"):
    if not ML_AVAILABLE:
        return None
    path = _model_path("tax_predictor")
    if not os.path.exists(path):
        return None
    try:
        data = joblib.load(path)
        features = "{} {} {} {}".format(
            vendor_name or "", currency, (description or "").lower(),
            "large" if amount > 1000 else "small")
        proba = data["pipeline"].predict_proba([features])[0]
        classes = data["pipeline"].classes_
        best_idx = int(proba.argmax())
        confidence = float(proba[best_idx])
        if confidence > 0.4:
            return {"tax_name": classes[best_idx], "confidence": round(confidence, 3)}
    except Exception as e:
        _logger.warning("Prema ML predict_tax error: %s", e)
    return None


# 3. DUPLICATE DETECTOR

def compute_bill_fingerprint(partner_name, ref, amount):
    normalized_ref = re.sub(r"[^a-z0-9]", "", (ref or "").lower())
    normalized_vendor = re.sub(r"[^a-z0-9]", "", (partner_name or "").lower())
    amount_bucket = str(round(float(amount or 0), 0))
    raw = "{}|{}|{}".format(normalized_vendor, normalized_ref, amount_bucket)
    return hashlib.md5(raw.encode()).hexdigest()


def check_duplicate_fingerprint(env, partner_name, ref, amount, exclude_id=None):
    if not ref:
        return None
    fp = compute_bill_fingerprint(partner_name, ref, amount)
    existing = env["account.move"].search_read(
        [("move_type", "=", "in_invoice"), ("state", "!=", "cancel")]
        + ([("id", "!=", exclude_id)] if exclude_id else []),
        ["id", "name", "partner_id", "ref", "amount_total"], limit=200)
    for bill in existing:
        bill_fp = compute_bill_fingerprint(
            bill["partner_id"][1] if bill["partner_id"] else "",
            bill["ref"], bill["amount_total"])
        if bill_fp == fp:
            return {"duplicate_id": bill["id"], "duplicate_name": bill["name"]}
    return None


# 4. FIELD CORRECTOR

def train_field_corrector(correction_records):
    if not ML_AVAILABLE:
        return {"error": "scikit-learn not installed"}
    if len(correction_records) < 5:
        return {"error": "Need at least 5 corrections to train"}
    _ensure_dir()
    trained = []
    field_data = {}
    for rec in correction_records:
        ai_vals = rec.get("input", {})
        user_vals = rec.get("output", {})
        for field, user_val in user_vals.items():
            ai_val = ai_vals.get(field)
            if ai_val and user_val and str(ai_val) != str(user_val):
                field_data.setdefault(field, []).append((str(ai_val), str(user_val)))
    for field, pairs in field_data.items():
        if len(pairs) < 3:
            continue
        X = [p[0] for p in pairs]
        y = [p[1] for p in pairs]
        if len(set(y)) < 2:
            continue
        try:
            pipeline = Pipeline([
                ("tfidf", TfidfVectorizer(ngram_range=(1, 2), max_features=2000)),
                ("clf", LogisticRegression(max_iter=300)),
            ])
            pipeline.fit(X, y)
            joblib.dump({"pipeline": pipeline}, _model_path("field_corrector_{}".format(field)))
            trained.append(field)
        except Exception as e:
            _logger.warning("Prema ML field_corrector '%s' error: %s", field, e)
    return {"success": True, "trained_fields": trained}


def predict_field_correction(field, ai_value):
    if not ML_AVAILABLE or not ai_value:
        return None
    path = _model_path("field_corrector_{}".format(field))
    if not os.path.exists(path):
        return None
    try:
        data = joblib.load(path)
        proba = data["pipeline"].predict_proba([str(ai_value)])[0]
        classes = data["pipeline"].classes_
        best_idx = int(proba.argmax())
        confidence = float(proba[best_idx])
        predicted = classes[best_idx]
        if confidence > 0.5 and predicted != str(ai_value):
            return {"suggested_value": predicted, "confidence": round(confidence, 3)}
    except Exception as e:
        _logger.warning("Prema ML predict_field_correction error: %s", e)
    return None


# MASTER RETRAIN

def retrain_all(env):
    results = {}
    results["account_classifier"] = train_account_classifier(env)
    results["tax_predictor"] = train_tax_predictor(env)
    try:
        corrections = env["prema.ai.correction"].search_read(
            [("context_type", "in", ["bill_creation", "fix_modification"])],
            ["ai_suggestion", "user_correction"], limit=2000)
        records = []
        for c in corrections:
            try:
                inp = json.loads(c["ai_suggestion"] or "{}")
                out = json.loads(c["user_correction"] or "{}")
                records.append({"input": inp, "output": out})
            except Exception:
                pass
        if records:
            results["field_corrector"] = train_field_corrector(records)
    except Exception as e:
        results["field_corrector"] = {"error": str(e)}
    _logger.info("Prema ML retrain_all results: %s", results)
    return results
