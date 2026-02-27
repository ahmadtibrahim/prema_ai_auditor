import base64

from odoo import http
from odoo.http import request


class AIUploadController(http.Controller):
    @http.route(
        "/prema_ai/upload_multi",
        type="http",
        auth="user",
        methods=["POST"],
        csrf=False,
    )
    def upload_multi(self, **kwargs):
        upload_file = kwargs.get("file")
        session_id = int(kwargs.get("session_id"))

        attachment = request.env["ir.attachment"].sudo().create(
            {
                "name": upload_file.filename,
                "datas": base64.b64encode(upload_file.read()),
                "res_model": "prema.ai.session",
                "res_id": session_id,
                "type": "binary",
            }
        )

        request.env["prema.ai.document"].sudo().create(
            {
                "session_id": session_id,
                "attachment_id": attachment.id,
            }
        )

        return request.make_response("OK", headers=[("Content-Type", "text/plain")])
