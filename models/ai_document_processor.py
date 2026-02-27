import base64

from odoo import api, models


class AIDocumentProcessor(models.AbstractModel):
    _name = "prema.ai.document.processor"
    _description = "Prema AI Document Processor"

    @api.model
    def process_document(self, document):
        document = document.sudo()
        document.status = "processing"
        name = (document.attachment_id.name or "").lower()

        if "invoice" in name or "bill" in name:
            classification = "vendor_bill"
        elif "receipt" in name:
            classification = "receipt"
        elif "bank" in name or "statement" in name:
            classification = "bank_statement"
        else:
            classification = "other"

        raw = base64.b64decode(document.attachment_id.datas or b"")
        extracted_text = f"Extracted {len(raw)} bytes from {document.attachment_id.name}"
        advice = "Advice only"
        if classification == "vendor_bill":
            advice = "Draft ready"
        elif classification == "receipt":
            advice = "Advice only"

        document.write(
            {
                "classification": classification,
                "extracted_text": extracted_text,
                "advice": advice,
                "status": "processed",
            }
        )

    @api.model
    def process_pending_documents(self, limit=20):
        documents = self.env["prema.ai.document"].sudo().search([
            ("status", "=", "pending"),
        ], limit=limit)
        for document in documents:
            self.process_document(document)

    @api.model
    def summarize_session_documents(self, session_id):
        docs = self.env["prema.ai.document"].sudo().search([
            ("session_id", "=", session_id),
        ])
        if not docs:
            return "No uploaded documents yet."

        count_map = {
            "vendor_bill": 0,
            "receipt": 0,
            "bank_statement": 0,
            "other": 0,
        }
        for doc in docs:
            count_map[doc.classification] = count_map.get(doc.classification, 0) + 1

        header = (
            f"You uploaded {count_map['vendor_bill']} Vendor Bills, "
            f"{count_map['receipt']} Receipts, and "
            f"{count_map['bank_statement']} Bank Statements."
        )
        lines = [header, ""]

        for index, doc in enumerate(docs, start=1):
            label = dict(doc._fields["classification"].selection).get(doc.classification, "Document")
            lines.append(f"{label} {index} → {doc.advice or 'Review required'}")

        lines.extend(["", "[ Create All Drafts ]", "[ Review Individually ]", "[ Advice Only ]"])
        return "\n".join(lines)

    @api.model
    def create_drafts_for_session(self, session_id):
        docs = self.env["prema.ai.document"].sudo().search([
            ("session_id", "=", session_id),
            ("status", "=", "approved"),
        ])

        for doc in docs:
            move = self.env["account.move"].sudo().create(
                {
                    "move_type": "in_invoice",
                    "state": "draft",
                    "ref": doc.attachment_id.name,
                    "invoice_line_ids": [
                        (
                            0,
                            0,
                            {
                                "name": "AI Draft Placeholder",
                                "quantity": 1,
                                "price_unit": 0.0,
                            },
                        )
                    ],
                }
            )
            doc.write({"move_id": move.id, "status": "draft_created"})
            doc.attachment_id.write({"res_model": "account.move", "res_id": move.id})


class AIDocumentProcessorCron(models.Model):
    _name = "prema.ai.document.processor.cron"
    _description = "Prema AI Document Processor Cron"

    @api.model
    def cron_process_pending_documents(self):
        self.env["prema.ai.document.processor"].process_pending_documents(limit=50)
