"""
DocumentIntelligence: AI-powered document operations inside Odoo Documents.
Capabilities:
  - Find duplicate documents (by name, size, content hash)
  - Organize documents into folders (e.g. "Driver Packets")
  - Move documents between folders
  - Tag documents
  - Process invoices → vendor bills
"""
import base64
import hashlib
import io
import json
import logging
import re
from collections import defaultdict
from odoo import models, api, fields, _

_logger = logging.getLogger(__name__)


class DocumentIntelligence(models.AbstractModel):
    _name = 'prema.ai.document.intelligence'
    _description = 'Prema AI Document Intelligence'

    # ── Duplicate Detection ───────────────────────────────────────────────────

    @api.model
    def find_duplicate_documents(self, folder_id=None):
        """
        Scan documents for duplicates by:
          1. Exact name match
          2. Same file size + same checksum
        Returns grouped duplicates with preview info.
        """
        Doc = self.env['documents.document'].sudo()
        domain = [('type', '=', 'binary')]
        if folder_id:
            domain.append(('folder_id', '=', folder_id))

        docs = Doc.search(domain, limit=2000)

        # Group by name (case-insensitive)
        by_name = defaultdict(list)
        for doc in docs:
            key = (doc.name or '').strip().lower()
            by_name[key].append(doc)

        # Group by checksum
        by_checksum = defaultdict(list)
        for doc in docs:
            if doc.checksum:
                by_checksum[doc.checksum].append(doc)

        duplicates = []

        # Name-based duplicates
        for name, group in by_name.items():
            if len(group) > 1:
                duplicates.append({
                    'reason': 'Same filename',
                    'name': group[0].name,
                    'count': len(group),
                    'documents': [{'id': d.id, 'name': d.name,
                                   'folder': d.folder_id.name if d.folder_id else 'No folder',
                                   'size': d.file_size or 0,
                                   'date': str(d.create_date)} for d in group],
                })

        # Checksum-based duplicates (exact content match)
        for checksum, group in by_checksum.items():
            if len(group) > 1:
                # Only add if not already caught by name
                names = set(d.name for d in group)
                if len(names) > 1:  # different names, same content
                    duplicates.append({
                        'reason': 'Identical file content (different names)',
                        'name': f"Content hash: {checksum[:12]}...",
                        'count': len(group),
                        'documents': [{'id': d.id, 'name': d.name,
                                       'folder': d.folder_id.name if d.folder_id else 'No folder',
                                       'size': d.file_size or 0,
                                       'date': str(d.create_date)} for d in group],
                    })

        return {
            'total_scanned': len(docs),
            'duplicate_groups': len(duplicates),
            'duplicates': duplicates[:50],  # cap output
        }

    def build_duplicate_preview_html(self, result):
        """Build HTML preview for duplicate scan results."""
        groups = result.get('duplicates', [])
        total = result.get('total_scanned', 0)

        if not groups:
            return f"<p>✅ No duplicates found. Scanned {total} documents.</p>"

        rows = ''
        for g in groups[:10]:
            doc_list = ', '.join(f"{d['name']} ({d['folder']})" for d in g['documents'][:3])
            rows += f"""
            <tr>
                <td><strong>{g['name']}</strong></td>
                <td>{g['count']}</td>
                <td><small>{g['reason']}</small></td>
                <td><small>{doc_list}</small></td>
            </tr>"""

        return f"""
        <div class='prema-preview'>
            <p>🔍 Scanned <strong>{total}</strong> documents — found 
               <strong>{len(groups)}</strong> duplicate groups.</p>
            <table class='table table-sm table-bordered'>
                <thead><tr><th>File</th><th>Copies</th><th>Reason</th><th>Locations</th></tr></thead>
                <tbody>{rows}</tbody>
            </table>
            <p class='text-muted small'>Approving will keep the newest copy and archive the rest.</p>
        </div>"""

    @api.model
    def remove_duplicates(self, duplicate_groups):
        """Keep newest document per group, archive the rest."""
        archived = 0
        Doc = self.env['documents.document'].sudo()
        for group in duplicate_groups:
            docs = Doc.browse([d['id'] for d in group['documents']]).exists()
            if len(docs) <= 1:
                continue
            # Sort by create_date desc, keep first
            sorted_docs = docs.sorted('create_date', reverse=True)
            to_archive = sorted_docs[1:]
            to_archive.write({'active': False})
            archived += len(to_archive)
        return {'success': True, 'archived': archived,
                'summary': f"Archived {archived} duplicate documents."}

    # ── Folder Organization ───────────────────────────────────────────────────

    @api.model
    def find_documents_for_folder(self, folder_name, keywords=None, model_name=None, tag_names=None):
        """
        Find documents that match criteria for grouping into a named folder.
        Matching by: filename keywords, attached model, or tags.
        """
        Doc = self.env['documents.document'].sudo()
        domain = [('type', '=', 'binary')]

        results = []

        # Keyword search in filename
        if keywords:
            for kw in keywords:
                kw_docs = Doc.search(domain + [('name', 'ilike', kw)], limit=200)
                for d in kw_docs:
                    if d.id not in [r['id'] for r in results]:
                        results.append({
                            'id': d.id,
                            'name': d.name,
                            'current_folder': d.folder_id.name if d.folder_id else 'No folder',
                            'folder_id': d.folder_id.id if d.folder_id else False,
                            'match_reason': f'Filename contains "{kw}"',
                        })

        # Model-based (e.g. all fleet documents)
        if model_name:
            model_docs = Doc.search(domain + [('res_model', '=', model_name)], limit=200)
            for d in model_docs:
                if d.id not in [r['id'] for r in results]:
                    results.append({
                        'id': d.id,
                        'name': d.name,
                        'current_folder': d.folder_id.name if d.folder_id else 'No folder',
                        'folder_id': d.folder_id.id if d.folder_id else False,
                        'match_reason': f'Linked to model {model_name}',
                    })

        # Tag-based
        if tag_names:
            Tag = self.env['documents.tag'].sudo()
            for tname in tag_names:
                tag = Tag.search([('name', 'ilike', tname)], limit=1)
                if tag:
                    tagged_docs = Doc.search(domain + [('tag_ids', 'in', tag.ids)], limit=200)
                    for d in tagged_docs:
                        if d.id not in [r['id'] for r in results]:
                            results.append({
                                'id': d.id,
                                'name': d.name,
                                'current_folder': d.folder_id.name if d.folder_id else 'No folder',
                                'folder_id': d.folder_id.id if d.folder_id else False,
                                'match_reason': f'Tagged "{tname}"',
                            })

        return {
            'proposed_folder': folder_name,
            'found': len(results),
            'documents': results[:100],
        }

    def build_organize_preview_html(self, folder_name, result):
        found = result.get('found', 0)
        docs = result.get('documents', [])
        rows = ''.join(f"<tr><td>{d['name']}</td><td>{d['current_folder']}</td>"
                       f"<td><small>{d['match_reason']}</small></td></tr>"
                       for d in docs[:15])
        more = f"<p class='text-muted small'>...and {found - 15} more</p>" if found > 15 else ''
        return f"""
        <div class='prema-preview'>
            <h5>📁 Organize into folder: <strong>{folder_name}</strong></h5>
            <p>Found <strong>{found}</strong> documents to move.</p>
            <table class='table table-sm table-bordered'>
                <thead><tr><th>Document</th><th>Current Folder</th><th>Match Reason</th></tr></thead>
                <tbody>{rows}</tbody>
            </table>
            {more}
            <p class='text-muted small'>Approving will move all matched documents into 
               "{folder_name}" (folder created if it doesn't exist).</p>
        </div>"""

    @api.model
    def organize_documents_into_folder(self, folder_name, document_ids, parent_folder_id=None):
        """
        Create folder if needed, move all specified documents into it.
        Used for 'Driver Packets', 'Vendor Invoices', etc.
        """
        Folder = self.env['documents.folder'].sudo()
        Doc = self.env['documents.document'].sudo()

        # Find or create the folder
        folder = Folder.search([('name', '=', folder_name)], limit=1)
        if not folder:
            vals = {'name': folder_name}
            if parent_folder_id:
                vals['parent_folder_id'] = parent_folder_id
            folder = Folder.create(vals)
            created_folder = True
        else:
            created_folder = False

        # Move documents
        docs = Doc.browse(document_ids).exists()
        docs.write({'folder_id': folder.id})

        return {
            'success': True,
            'record_model': 'documents.folder',
            'record_id': folder.id,
            'folder_name': folder_name,
            'folder_created': created_folder,
            'moved_count': len(docs),
            'summary': f"Moved {len(docs)} documents into '{folder_name}'."
                       + (" (Folder created)" if created_folder else ""),
        }

    # ── Move Documents ────────────────────────────────────────────────────────

    @api.model
    def move_documents(self, document_ids, target_folder_id):
        Doc = self.env['documents.document'].sudo()
        Folder = self.env['documents.folder'].sudo()
        docs = Doc.browse(document_ids).exists()
        folder = Folder.browse(target_folder_id)
        if not folder.exists():
            return {'error': f'Folder {target_folder_id} not found'}
        docs.write({'folder_id': target_folder_id})
        return {
            'success': True,
            'moved_count': len(docs),
            'folder_name': folder.name,
            'summary': f"Moved {len(docs)} documents to '{folder.name}'.",
        }

    # ── Tag Documents ─────────────────────────────────────────────────────────

    @api.model
    def tag_documents(self, document_ids, tag_names):
        """Apply tags to documents, creating tags if they don't exist."""
        Doc = self.env['documents.document'].sudo()
        Tag = self.env['documents.tag'].sudo()

        tag_ids = []
        for name in tag_names:
            tag = Tag.search([('name', '=', name)], limit=1)
            if not tag:
                tag = Tag.create({'name': name})
            tag_ids.append(tag.id)

        docs = Doc.browse(document_ids).exists()
        docs.write({'tag_ids': [(4, tid) for tid in tag_ids]})

        return {
            'success': True,
            'tagged_count': len(docs),
            'tags': tag_names,
            'summary': f"Tagged {len(docs)} documents with: {', '.join(tag_names)}.",
        }

    # ── List Folders / Documents ──────────────────────────────────────────────

    @api.model
    def list_folders(self):
        Folder = self.env['documents.folder'].sudo()
        folders = Folder.search([], order='name')
        result = []
        for f in folders:
            count = self.env['documents.document'].sudo().search_count([('folder_id', '=', f.id)])
            result.append({'id': f.id, 'name': f.name, 'document_count': count,
                           'parent': f.parent_folder_id.name if f.parent_folder_id else None})
        return result

    @api.model
    def list_documents_in_folder(self, folder_id, limit=50):
        Doc = self.env['documents.document'].sudo()
        docs = Doc.search([('folder_id', '=', folder_id)], limit=limit, order='name')
        return [{'id': d.id, 'name': d.name, 'mimetype': d.mimetype,
                 'size': d.file_size, 'date': str(d.create_date)} for d in docs]

    @api.model
    def search_documents(self, keyword, limit=50):
        Doc = self.env['documents.document'].sudo()
        docs = Doc.search([('name', 'ilike', keyword)], limit=limit, order='name')
        return [{'id': d.id, 'name': d.name,
                 'folder': d.folder_id.name if d.folder_id else 'No folder',
                 'date': str(d.create_date)} for d in docs]

    # ── Invoice / Vendor Bill Processing ─────────────────────────────────────

    @api.model
    def process_attachment_for_invoice(self, attachment_id):
        """Extract invoice data from an uploaded attachment."""
        att = self.env['ir.attachment'].sudo().browse(attachment_id)
        if not att.exists():
            return {'error': 'Attachment not found'}

        file_data = base64.b64decode(att.datas)
        text = self._extract_text(file_data, att.name or '', att.mimetype or '')
        invoice_data = self._parse_invoice(text)
        invoice_data['source_attachment_id'] = attachment_id
        invoice_data['source_name'] = att.name
        return invoice_data

    def _extract_text(self, file_data, filename, mimetype):
        text = ''
        if 'pdf' in mimetype or filename.lower().endswith('.pdf'):
            try:
                try:
                    from pypdf import PdfReader
                except ImportError:
                    from PyPDF2 import PdfReader
                reader = PdfReader(io.BytesIO(file_data))
                for page in reader.pages:
                    text += page.extract_text() or ''
            except Exception as e:
                _logger.warning("PDF read failed: %s", e)
        else:
            try:
                text = file_data.decode('utf-8', errors='ignore')
            except Exception:
                pass
        return text

    def _parse_invoice(self, text):
        data = {'vendor_name': None, 'invoice_number': None, 'invoice_date': None,
                'total_amount': None, 'currency': 'USD', 'raw_text_snippet': text[:400]}
        if not text:
            return data
        for p in [r'(?:Invoice|INV|Bill)[\s#:]*([A-Z0-9\-\/]+)',
                  r'Invoice No[.:\s]+([A-Z0-9\-\/]+)']:
            m = re.search(p, text, re.I)
            if m:
                data['invoice_number'] = m.group(1).strip(); break
        for p in [r'(?:Invoice Date|Date)[:\s]+(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})',
                  r'Date[:\s]+(\w+ \d{1,2},?\s+\d{4})']:
            m = re.search(p, text, re.I)
            if m:
                data['invoice_date'] = m.group(1).strip(); break
        for p in [r'(?:Total|Grand Total|Amount Due)[:\s$]*([0-9,]+\.?\d{0,2})',
                  r'TOTAL[:\s$€£]*([0-9,]+\.?\d{0,2})']:
            m = re.search(p, text, re.I)
            if m:
                try: data['total_amount'] = float(m.group(1).replace(',', ''))
                except: pass
                break
        if '€' in text or 'EUR' in text: data['currency'] = 'EUR'
        elif '£' in text or 'GBP' in text: data['currency'] = 'GBP'
        elif 'CAD' in text: data['currency'] = 'CAD'
        m = re.search(r'(?:From|Vendor|Supplier)[:\s]+(.+)', text, re.I)
        if m:
            data['vendor_name'] = m.group(1).strip()[:80]
        else:
            lines = [l.strip() for l in text.split('\n') if len(l.strip()) > 3]
            if lines: data['vendor_name'] = lines[0][:80]
        return data

    def build_vendor_bill_preview_html(self, invoice_data):
        vendor = invoice_data.get('vendor_name') or 'Unknown'
        inv_num = invoice_data.get('invoice_number') or 'N/A'
        inv_date = invoice_data.get('invoice_date') or 'N/A'
        total = invoice_data.get('total_amount')
        cur = invoice_data.get('currency', 'USD')
        total_str = f"{cur} {total:,.2f}" if total else 'N/A'
        return f"""
        <div class='prema-preview'>
            <h5>📄 Vendor Bill to Create</h5>
            <table class='table table-sm'>
                <tr><th>Vendor</th><td>{vendor}</td></tr>
                <tr><th>Invoice #</th><td>{inv_num}</td></tr>
                <tr><th>Date</th><td>{inv_date}</td></tr>
                <tr><th>Total</th><td><strong>{total_str}</strong></td></tr>
                <tr><th>Source</th><td>{invoice_data.get('source_name','')}</td></tr>
            </table>
            <p class='text-muted small'>Draft vendor bill will be created in Accounting. 
            Original document will be attached.</p>
        </div>"""

    @api.model
    def create_vendor_bill(self, invoice_data):
        """Create draft vendor bill from extracted invoice data."""
        vendor_name = invoice_data.get('vendor_name', 'Unknown Vendor')
        Partner = self.env['res.partner'].sudo()
        partner = Partner.search([('name', 'ilike', vendor_name)], limit=1)
        if not partner:
            partner = Partner.create({'name': vendor_name, 'supplier_rank': 1, 'is_company': True})

        currency_code = invoice_data.get('currency', 'USD')
        currency = self.env['res.currency'].sudo().search([('name', '=', currency_code)], limit=1)
        if not currency:
            currency = self.env.company.currency_id

        invoice_date = self._parse_date(invoice_data.get('invoice_date'))
        move_vals = {
            'move_type': 'in_invoice',
            'partner_id': partner.id,
            'currency_id': currency.id,
            'state': 'draft',
            'ref': invoice_data.get('invoice_number'),
            'invoice_date': invoice_date,
        }
        total = invoice_data.get('total_amount', 0.0) or 0.0
        if total:
            account = self._get_expense_account()
            move_vals['invoice_line_ids'] = [(0, 0, {
                'name': f"Invoice {invoice_data.get('invoice_number', '')}",
                'quantity': 1,
                'price_unit': total,
                'account_id': account.id if account else False,
            })]

        move = self.env['account.move'].sudo().create(move_vals)

        att_id = invoice_data.get('source_attachment_id')
        if att_id:
            att = self.env['ir.attachment'].sudo().browse(att_id)
            if att.exists():
                att.write({'res_model': 'account.move', 'res_id': move.id})

        return {
            'success': True,
            'record_model': 'account.move',
            'record_id': move.id,
            'summary': f"Created draft vendor bill {move.name} for {partner.name}.",
        }

    def _parse_date(self, date_str):
        if not date_str:
            return fields.Date.today()
        try:
            from dateutil import parser as dp
            return dp.parse(date_str, dayfirst=False).date()
        except Exception:
            return fields.Date.today()

    def _get_expense_account(self):
        return self.env['account.account'].sudo().search([
            ('account_type', '=', 'expense'),
            ('company_id', '=', self.env.company.id),
            ('deprecated', '=', False),
        ], limit=1)
