import json
from unittest.mock import patch

from odoo.tests.common import TransactionCase


class TestLeadGenerationDedup(TransactionCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        cls.Session = cls.env["prema.ai.session"]
        cls.admin = cls.env.ref("base.user_admin")

    def _new_session(self, name="Lead Gen Dedup Test"):
        return self.Session.create({"name": name, "user_id": self.admin.id})

    def test_rank_lead_candidates_dedupes_duplicate_companies(self):
        session = self._new_session()
        candidates = [
            {
                "company_name": "Zak's Produce Plus Inc",
                "website": "https://zaksproduce.example",
                "city": "Ottawa",
                "state": "ON",
                "google_place_id": "place-1",
                "description": "Google Places match for produce wholesaler",
            },
            {
                "company_name": "Zak's Produce Plus Inc",
                "website": "https://zaksproduce.example",
                "city": "Ottawa",
                "state": "ON",
                "google_place_id": "place-1",
                "description": "Google Places match for food distribution",
            },
            {
                "company_name": "Capital Produce Depot",
                "website": "https://capitalproduce.example",
                "city": "Ottawa",
                "state": "ON",
                "google_place_id": "place-2",
                "description": "Google Places match for food distribution",
            },
        ]

        session_class = type(session)
        with patch(
                "odoo.addons.prema_ai_auditor.services.deepseek_client.get_api_key",
                return_value=""):
            ranked = session._rank_lead_candidates(
                "Generate 2 leads in Ottawa",
                candidates,
                {"count": 2},
            )

        self.assertEqual(len(ranked), 2)
        self.assertEqual(ranked[0]["pending_key"], "place-1")
        self.assertEqual(ranked[1]["pending_key"], "place-2")
        self.assertEqual(
            [lead["company_name"] for lead in ranked],
            ["Zak's Produce Plus Inc", "Capital Produce Depot"],
        )

    def test_rank_lead_candidates_skips_duplicate_rank_rows(self):
        session = self._new_session()
        candidates = [
            {
                "company_name": "Zak's Produce Plus Inc",
                "website": "https://zaksproduce.example",
                "city": "Ottawa",
                "state": "ON",
                "google_place_id": "place-1",
                "description": "Google Places match for produce wholesaler",
            },
            {
                "company_name": "Capital Produce Depot",
                "website": "https://capitalproduce.example",
                "city": "Ottawa",
                "state": "ON",
                "google_place_id": "place-2",
                "description": "Google Places match for food distribution",
            },
        ]
        ranked_payload = json.dumps([
            {"pending_key": "place-1", "score": 95, "reason": "Best produce target"},
            {"pending_key": "place-1", "score": 94, "reason": "Duplicate row should be ignored"},
            {"pending_key": "place-2", "score": 90, "reason": "Second-best freight target"},
        ])

        session_class = type(session)
        with patch(
                "odoo.addons.prema_ai_auditor.services.deepseek_client.get_api_key",
                return_value="fake-key"), patch.object(
            session_class, "_call_responses_text", return_value=ranked_payload
        ):
            ranked = session._rank_lead_candidates(
                "Generate 2 leads in Ottawa",
                candidates,
                {"count": 2},
            )

        self.assertEqual(
            [lead["company_name"] for lead in ranked[:2]],
            ["Zak's Produce Plus Inc", "Capital Produce Depot"],
        )
        self.assertEqual(
            [lead["pending_key"] for lead in ranked[:2]],
            ["place-1", "place-2"],
        )
