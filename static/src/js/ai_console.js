/** @odoo-module **/
import { registry } from "@web/core/registry";
import { Component, useState, onMounted, useRef } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

export class AIConsole extends Component {
    static template = "prema_ai_console.AIConsole";

    setup() {
        this.orm = useService("orm");
        this.messagesRef = useRef("messages");
        this.fileInputRef = useRef("fileInput");

        this.state = useState({
            sessions: [], activeSessionId: null, activeSessionName: "AI Console",
            messages: [], input: "", isLoading: false, errorMsg: null,
            pendingAttachment: null,
        });

        onMounted(() => this.loadSessions());
    }

    async loadSessions() {
        try {
            this.state.sessions = await this.orm.call("prema.ai.session", "list_sessions", []);
        } catch (e) { console.error(e); }
    }

    async createNewSession() {
        try {
            const id = await this.orm.call("prema.ai.session", "create", [{ name: "New Chat" }]);
            await this.loadSessions();
            await this.selectSession(id, "New Chat");
        } catch (e) { console.error(e); }
    }

    async selectSession(id, name) {
        if (!id) return;
        this.state.activeSessionId = id;
        this.state.activeSessionName = name || "AI Console";
        this.state.errorMsg = null;
        try {
            this.state.messages = await this.orm.call(
                "prema.ai.message", "search_read",
                [[["session_id", "=", id]], ["role", "content"]]);
        } catch (e) { console.error(e); }
        this._scrollToBottom();
    }

    async renameSession(id, ev) {
        if (ev) ev.stopPropagation();
        const newName = prompt("Rename chat:");
        if (!newName?.trim()) return;
        try {
            await this.orm.call("prema.ai.session", "rename_session", [id, newName.trim()]);
            await this.loadSessions();
            if (this.state.activeSessionId === id) this.state.activeSessionName = newName.trim();
        } catch (e) { console.error(e); }
    }

    async deleteSession(id, ev) {
        if (ev) ev.stopPropagation();
        if (!confirm("Delete this chat?")) return;
        try {
            await this.orm.call("prema.ai.session", "delete_session", [id]);
            if (this.state.activeSessionId === id) {
                this.state.activeSessionId = null;
                this.state.activeSessionName = "AI Console";
                this.state.messages = [];
            }
            await this.loadSessions();
        } catch (e) { console.error(e); }
    }

    triggerFileUpload() {
        const inp = this.fileInputRef.el;
        if (inp) inp.click();
    }

    async onFileSelected(ev) {
        const file = ev.target.files?.[0];
        if (!file || !this.state.activeSessionId) return;

        const allowed = ["application/pdf", "image/jpeg", "image/png", "image/webp"];
        if (!allowed.includes(file.type)) {
            this.state.errorMsg = "Unsupported file type. Please upload a PDF or image (JPEG/PNG/WebP).";
            return;
        }

        this.state.isLoading = true;
        this.state.errorMsg = null;

        try {
            const b64 = await this._fileToBase64(file);
            const result = await this.orm.call(
                "prema.ai.attachment", "upload_and_extract",
                [this.state.activeSessionId, file.name, b64, file.type]);

            if (result.error) {
                this.state.errorMsg = "Extraction failed: " + result.error;
                return;
            }

            this.state.pendingAttachment = { id: result.attachment_id, extracted: result.extracted };

            const preview = this._formatExtractedData(result.extracted);
            this.state.messages = [
                ...this.state.messages,
                { id: Date.now(), role: "user", content: "\u{1F4CE} Uploaded: " + file.name },
                { id: Date.now() + 1, role: "assistant", content: preview },
            ];
        } catch (e) {
            this.state.errorMsg = "Upload failed: " + e.message;
        } finally {
            this.state.isLoading = false;
            this._scrollToBottom();
            ev.target.value = "";
        }
    }

    _formatExtractedData(data) {
        if (!data) return "Could not extract data from file.";
        const lines = [`\u{1F4C4} **Extracted Bill Data** \u2014 Review and reply 'create bill' to confirm:\n`];
        if (data.vendor_name) lines.push("\u{1F3E2} Vendor: " + data.vendor_name);
        if (data.invoice_number) lines.push("\u{1F522} Invoice #: " + data.invoice_number);
        if (data.invoice_date) lines.push("\u{1F4C5} Date: " + data.invoice_date);
        if (data.due_date) lines.push("\u23F0 Due: " + data.due_date);
        if (data.currency) lines.push("\u{1F4B1} Currency: " + data.currency);
        if (data.subtotal != null) lines.push("\u{1F4B0} Subtotal: " + data.subtotal);
        if (data.tax_amount != null) lines.push("\u{1F3DB}\uFE0F Tax: " + data.tax_amount);
        if (data.total_amount != null) lines.push("\u{1F4B5} Total: " + data.total_amount);
        if (data.ml_suggested_account) lines.push("\u{1F916} Suggested Account: " + data.ml_suggested_account.account_code + " (confidence: " + (data.ml_suggested_account.confidence * 100).toFixed(0) + "%)");
        if (data.ml_suggested_tax) lines.push("\u{1F916} Suggested Tax: " + data.ml_suggested_tax.tax_name + " (confidence: " + (data.ml_suggested_tax.confidence * 100).toFixed(0) + "%)");
        if (data.ml_duplicate_warning) lines.push("\u26A0\uFE0F POSSIBLE DUPLICATE of bill: " + data.ml_duplicate_warning.duplicate_name);
        lines.push("\nReply 'create bill' to create the draft, or tell me what to correct.");
        return lines.join("\n");
    }

    _fileToBase64(file) {
        return new Promise((res, rej) => {
            const r = new FileReader();
            r.onload = () => res(r.result.split(",")[1]);
            r.onerror = () => rej(new Error("File read failed"));
            r.readAsDataURL(file);
        });
    }

    async sendMessage() {
        const text = (this.state.input || "").trim();
        if (!text || !this.state.activeSessionId || this.state.isLoading) return;

        this.state.errorMsg = null;
        this.state.messages = [...this.state.messages, { id: Date.now(), role: "user", content: text }];
        this.state.input = "";
        this.state.isLoading = true;
        this._scrollToBottom();

        try {
            if (this.state.pendingAttachment && /create\s*(the\s*)?(draft|bill)/i.test(text)) {
                const billResult = await this.orm.call(
                    "prema.ai.attachment", "process_attachment_by_id",
                    [this.state.pendingAttachment.id, true]);
                const msg = billResult.success
                    ? `\u2705 Draft bill created.\n- Move ID: ${billResult.move_id}\n- Vendor: ${billResult.partner}\n- Amount: ${billResult.amount}`
                    : "\u274C " + (billResult.error || "Unknown error");
                this.state.messages = [...this.state.messages, { id: Date.now(), role: "assistant", content: msg }];
                this.state.pendingAttachment = null;
            } else {
                await this.orm.call("prema.ai.session", "send_message", [this.state.activeSessionId, text]);
                this.state.messages = await this.orm.call(
                    "prema.ai.message", "search_read",
                    [[["session_id", "=", this.state.activeSessionId]], ["role", "content"]]);
            }
        } catch (e) {
            console.error(e);
            this.state.errorMsg = "Failed to send. Check console for details.";
            this.state.messages = this.state.messages.slice(0, -1);
        } finally {
            this.state.isLoading = false;
            this._scrollToBottom();
        }
    }

    handleKeyDown(ev) {
        if (ev.key === "Enter" && !ev.shiftKey) { ev.preventDefault(); this.sendMessage(); }
    }

    _scrollToBottom() {
        setTimeout(() => { const el = this.messagesRef.el; if (el) el.scrollTop = el.scrollHeight; }, 50);
    }
}

registry.category("actions").add("prema_ai_console", AIConsole);
