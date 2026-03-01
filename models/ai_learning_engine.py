from odoo import models


class PremaAILearningEngine(models.AbstractModel):
    _name = "prema.ai.learning.engine"
    _description = "Prema AI Learning Engine"

    def suggest_account(self, vendor_id, keywords):
        domain = [("vendor_id", "=", vendor_id)]
        if keywords:
            for token in [part.strip() for part in keywords.split(",") if part.strip()]:
                domain.append(("detected_keywords", "ilike", token))

        memory = self.env["prema.ai.learning.memory"].search(
            domain,
            order="confidence_score desc, times_corrected desc, id desc",
            limit=1,
        )
        return memory.corrected_account_id if memory else self.env["account.account"]

    def record_correction(self, vendor_id, old_account_id, new_account_id, keywords):
        normalized_keywords = keywords or ""
        memory_model = self.env["prema.ai.learning.memory"]
        memory = memory_model.search(
            [
                ("vendor_id", "=", vendor_id),
                ("detected_keywords", "=", normalized_keywords),
                ("suggested_account_id", "=", old_account_id),
                ("corrected_account_id", "=", new_account_id),
            ],
            limit=1,
        )

        if memory:
            times_corrected = memory.times_corrected + 1
            confidence_score = min(1.0, 0.5 + (times_corrected * 0.1))
            memory.write({
                "times_corrected": times_corrected,
                "confidence_score": confidence_score,
            })
            return memory

        return memory_model.create({
            "vendor_id": vendor_id,
            "detected_keywords": normalized_keywords,
            "suggested_account_id": old_account_id,
            "corrected_account_id": new_account_id,
            "times_corrected": 1,
            "confidence_score": 0.6,
        })
