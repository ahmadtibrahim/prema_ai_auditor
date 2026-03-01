/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, useState, onWillStart } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

class AIConsole extends Component {

    setup() {
        this.orm = useService("orm");
        this.notification = useService("notification");

        this.state = useState({
            sessions: [],
            activeSessionId: null,
            messages: [],
            input: "",
            uploadName: "",
            uploadData: null,
            uploadMimeType: "",
            parsedDocument: null,
            analyzedAttachmentId: null,
            documentStatus: null,
            isAnalyzing: false,
            renamingSessionIds: [],
            deletingSessionIds: [],
            savedSessionNames: {},
        });

        onWillStart(async () => {
            await this.loadSessions();
        });
    }

    // ----------------------------
    // LOAD SESSIONS
    // ----------------------------

    async loadSessions() {
        try {
            const sessions = await this.orm.searchRead(
                "prema.ai.session",
                [],
                ["name"]
            );

            this.state.sessions = sessions;
            this.state.savedSessionNames = Object.fromEntries(
                sessions.map((session) => [session.id, session.name || ""])
            );

            if (sessions.length && !this.state.activeSessionId) {
                this.state.activeSessionId = sessions[0].id;
                await this.loadMessages();
            }
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to load sessions", { type: "danger" });
        }
    }

    async loadMessages() {
        if (!this.state.activeSessionId) return;

        try {
            const messages = await this.orm.searchRead(
                "prema.ai.message",
                [["session_id", "=", this.state.activeSessionId]],
                ["role", "content"]
            );

            this.state.messages = messages;
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to load messages", { type: "danger" });
        }
    }

    async selectSession(id) {
        this.state.activeSessionId = id;
        await this.loadMessages();
    }

    // ----------------------------
    // CREATE SESSION
    // ----------------------------

    async createNewSession() {
        try {
            const createResult = await this.orm.create("prema.ai.session", [{
                name: "New Chat"
            }]);
            const id = Array.isArray(createResult) ? createResult[0] : createResult;

            await this.loadSessions();
            this.state.activeSessionId = id || null;
            await this.loadMessages();
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to create session", { type: "danger" });
        }
    }

    // ----------------------------
    // RENAME SESSION (FIXED CONTEXT)
    // ----------------------------

    async renameSession(session) {
        const newName = (session.name || "").trim();
        const oldName = (this.state.savedSessionNames[session.id] || "").trim();

        if (!newName) {
            session.name = oldName;
            this.notification.add("Session name cannot be empty", {
                type: "warning",
            });
            return;
        }

        if (newName === oldName || this.state.renamingSessionIds.includes(session.id)) {
            return;
        }

        this.state.renamingSessionIds = [...this.state.renamingSessionIds, session.id];

        try {
            await this.orm.call(
                "prema.ai.session",
                "action_rename_session",
                [[session.id], newName]
            );

            await this.loadSessions();
            this.notification.add("Session renamed", {
                type: "success",
            });
        } catch (error) {
            session.name = oldName;
            console.error("Rename error:", error);
            this.notification.add("Failed to rename session", { type: "danger" });
        } finally {
            this.state.renamingSessionIds = this.state.renamingSessionIds.filter((id) => id !== session.id);
        }
    }

    // ----------------------------
    // DELETE SESSION
    // ----------------------------

    async deleteSession(sessionId) {
        if (this.state.deletingSessionIds.includes(sessionId)) {
            return;
        }

        this.state.deletingSessionIds = [...this.state.deletingSessionIds, sessionId];

        try {
            await this.orm.call(
                "prema.ai.session",
                "action_delete_session",
                [[sessionId]]
            );

            if (this.state.activeSessionId === sessionId) {
                this.state.activeSessionId = null;
                this.state.messages = [];
            }

            await this.loadSessions();

            this.notification.add("Session deleted successfully", {
                type: "success",
            });

        } catch (error) {
            console.error(error);
            this.notification.add("Failed to delete session", {
                type: "danger",
            });
        } finally {
            this.state.deletingSessionIds = this.state.deletingSessionIds.filter((id) => id !== sessionId);
        }
    }

    // ----------------------------
    // SEND MESSAGE
    // ----------------------------

    async sendMessage() {
        if (!this.state.input.trim() || !this.state.activeSessionId) return;

        try {
            const result = await this.orm.call(
                "prema.ai.session",
                "send_user_message",
                [[this.state.activeSessionId], this.state.input]
            );

            this.state.messages.push(result.user);
            this.state.messages.push(result.assistant);
            this.state.input = "";
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to send message", { type: "danger" });
        }
    }

    async onFileSelected(ev) {
        const file = ev.target.files && ev.target.files[0];
        if (!file) {
            return;
        }
        await this._loadFile(file);
    }

    async onDrop(ev) {
        ev.preventDefault();
        const file = ev.dataTransfer?.files?.[0];
        if (!file) {
            return;
        }
        await this._loadFile(file);
    }

    onDragOver(ev) {
        ev.preventDefault();
    }

    async _loadFile(file) {
        const data = await new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onload = () => {
                const result = reader.result || "";
                const payload = String(result).split(",")[1] || null;
                resolve(payload);
            };
            reader.onerror = reject;
            reader.readAsDataURL(file);
        });

        this.state.uploadName = file.name;
        this.state.uploadData = data;
        this.state.uploadMimeType = file.type || "application/octet-stream";
    }

    async analyzeDocument() {
        if (!this.state.activeSessionId || !this.state.uploadData || this.state.isAnalyzing) {
            return;
        }

        this.state.isAnalyzing = true;
        try {
            const attachmentId = await this.orm.create("ir.attachment", [{
                name: this.state.uploadName,
                type: "binary",
                datas: this.state.uploadData,
                mimetype: this.state.uploadMimeType,
                res_model: "prema.ai.session",
                res_id: this.state.activeSessionId,
            }]);

            const result = await this.orm.call(
                "prema.ai.session",
                "analyze_uploaded_document",
                [[this.state.activeSessionId]],
                { attachment_id: attachmentId }
            );

            let parsedDocument = result.parsed_data;
            if (typeof parsedDocument === "string") {
                try {
                    parsedDocument = JSON.parse(parsedDocument);
                } catch (_error) {
                    parsedDocument = null;
                }
            }

            this.state.parsedDocument = parsedDocument || {
                vendor_name: "N/A",
                invoice_number: "N/A",
                invoice_date: "N/A",
                total: "N/A",
                line_items: [],
                suggested_action: typeof result.parsed_data === "string" ? result.parsed_data : JSON.stringify(result.parsed_data),
            };
            this.state.analyzedAttachmentId = attachmentId;
            this.state.documentStatus = result.status;
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to analyze document", { type: "danger" });
        } finally {
            this.state.isAnalyzing = false;
        }
    }

    async createDraftBill() {
        if (!this.state.activeSessionId || !this.state.parsedDocument || !this.state.analyzedAttachmentId) {
            return;
        }

        try {
            const result = await this.orm.call(
                "prema.ai.session",
                "create_draft_bill_from_ai",
                [[this.state.activeSessionId]],
                {
                    parsed_data: this.state.parsedDocument,
                    attachment_id: this.state.analyzedAttachmentId,
                }
            );

            this.state.documentStatus = "draft_created";
            this.notification.add(`Draft bill suggestion created: ${result.bill_name || "N/A"}`, { type: "success" });
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to create draft bill", { type: "danger" });
        }
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);
