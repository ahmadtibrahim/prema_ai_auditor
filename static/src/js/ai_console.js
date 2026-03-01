/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, useState, onWillStart } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";
import { session } from "@web/session";
import { rpc } from "@web/core/network/rpc";

class AIConsole extends Component {

    setup() {
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
            const sessions = await this.callKw("prema.ai.session", "search_read", [[], ["name"]]);

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
            const messages = await this.callKw(
                "prema.ai.message",
                "search_read",
                [[["session_id", "=", this.state.activeSessionId]], ["role", "content"]]
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
            const sessionId = await this.callKw(
                "prema.ai.session",
                "create",
                [[{
                    name: "New Chat",
                    user_id: session.uid,
                }]]
            );

            await this.loadSessions();
            this.state.activeSessionId = sessionId;
        } catch (error) {
            console.error("Create session error:", error);
            this.notification.add("Failed to create session.", { type: "danger" });
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
            await this.callKw("prema.ai.session", "action_rename_session", [[session.id], newName]);

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
            await this.callKw("prema.ai.session", "action_delete_session", [[sessionId]]);

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
            const result = await this.callKw("prema.ai.session", "send_user_message", [[this.state.activeSessionId], this.state.input]);

            this.state.messages.push(result.user);
            this.state.messages.push(result.assistant);
            this.state.input = "";
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to send message", { type: "danger" });
        }
    }

    onFileSelected(ev) {
        this.handleFileUpload(ev);
    }

    async onDrop(ev) {
        ev.preventDefault();
        const file = ev.dataTransfer?.files?.[0];
        if (!file) {
            return;
        }

        this.handleFileUpload({
            target: {
                files: [file],
            },
        });
    }

    onDragOver(ev) {
        ev.preventDefault();
    }

    handleFileUpload(ev) {
        const file = ev.target.files[0];

        if (!file) {
            this.state.uploadData = null;
            return;
        }

        const reader = new FileReader();

        reader.onload = (event) => {
            const result = event.target.result;

            if (!result || !result.includes(",")) {
                console.error("Invalid file reader result:", result);
                this.state.uploadData = null;
                return;
            }

            const base64 = result.split(",")[1];

            if (!base64 || base64.length < 50) {
                console.error("Base64 too small or invalid");
                this.state.uploadData = null;
                return;
            }

            this.state.uploadData = base64;
            this.state.uploadName = file.name || "document.pdf";
            this.state.uploadMimeType = file.type || "application/pdf";
        };

        reader.onerror = () => {
            console.error("File read error");
            this.state.uploadData = null;
        };

        reader.readAsDataURL(file);
    }

    async analyzeDocument() {
        if (!this.state.uploadData) {
            this.notification.add("File not properly loaded.", { type: "danger" });
            return;
        }

        try {
            const attachmentId = await this.callKw("ir.attachment", "create", [[{
                name: this.state.uploadName,
                type: "binary",
                datas: this.state.uploadData,
                mimetype: this.state.uploadMimeType || "application/pdf",
                res_model: "prema.ai.session",
                res_id: this.state.activeSessionId,
            }]]);

            const result = await this.callKw(
                "prema.ai.session",
                "analyze_uploaded_document",
                [],
                {
                    attachment_id: attachmentId,
                }
            );

            const parsedDocument = typeof result.parsed_data === "string"
                ? null
                : (result.parsed_data || null);
            this.state.parsedDocument = parsedDocument;
            this.state.analyzedAttachmentId = attachmentId;
            this.state.documentStatus = result.status || "analyzed";
            this.notification.add("Document analyzed successfully", { type: "success" });

            console.log("Analyze success:", result);
        } catch (error) {
            console.error("Analyze RPC error:", error);
            this.notification.add("Failed to analyze document.", { type: "danger" });
        }
    }

    async createDraftBill() {
        if (!this.state.activeSessionId || !this.state.parsedDocument || !this.state.analyzedAttachmentId) {
            return;
        }

        try {
            const result = await this.callKw(
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

    callKw(model, method, args = [], kwargs = {}) {
        return rpc("/web/dataset/call_kw", {
            model,
            method,
            args,
            kwargs,
        });
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);
registry.category("actions").add("prema_ai_console", AIConsole);
