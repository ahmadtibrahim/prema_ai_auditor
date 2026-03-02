/** File: prema_ai_auditor/static/src/js/ai_console.js */
/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, useState, onMounted } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

export class AIConsole extends Component {
    setup() {
        this.orm = useService("orm");
        this.notification = useService("notification");

        this.state = useState({
            sessions: [],
            activeSessionId: null,
            activeSessionName: null,
            messages: [],
            input: "",
        });

        onMounted(async () => {
            await this.loadSessions();
            // Auto-select first session if exists
            if (this.state.sessions.length && !this.state.activeSessionId) {
                await this.selectSession(this.state.sessions[0].id);
            }
        });
    }

    async loadSessions() {
        try {
            const sessions = await this.orm.call("prema.ai.session", "list_sessions", []);
            this.state.sessions = sessions || [];
        } catch (error) {
            console.error(error);
            this.notification.add(`Failed to load sessions: ${error?.message || error}`, { type: "danger" });
        }
    }

    async createNewSession() {
        try {
            // Prefer a custom server method, but this works if access rights allow create()
            const newId = await this.orm.call("prema.ai.session", "create", [{ name: "New Chat" }]);
            await this.loadSessions();
            await this.selectSession(newId);
        } catch (error) {
            console.error(error);
            this.notification.add(`Failed to create session: ${error?.message || error}`, { type: "danger" });
        }
    }

    async selectSession(id) {
        try {
            if (!id) return;

            this.state.activeSessionId = id;

            const match = (this.state.sessions || []).find((s) => s.id === id);
            this.state.activeSessionName = match ? match.name : "AI Console";

            // search_read args: domain, fields
            const messages = await this.orm.call("prema.ai.message", "search_read", [
                [["session_id", "=", id]],
                ["id", "role", "content"],
            ]);

            this.state.messages = messages || [];
        } catch (error) {
            console.error(error);
            this.notification.add(`Failed to load messages: ${error?.message || error}`, { type: "danger" });
        }
    }

    async renameSession(id) {
        try {
            if (!id) return;
            const newName = prompt("Rename chat:");
            if (!newName) return;

            await this.orm.call("prema.ai.session", "rename_session", [id, newName]);
            await this.loadSessions();

            if (this.state.activeSessionId === id) {
                this.state.activeSessionName = newName;
            }
        } catch (error) {
            console.error(error);
            this.notification.add(`Failed to rename: ${error?.message || error}`, { type: "danger" });
        }
    }

    async deleteSession(id) {
        try {
            if (!id) return;
            if (!confirm("Delete this chat?")) return;

            await this.orm.call("prema.ai.session", "delete_session", [id]);

            // If deleting the active one, clear UI and select another if available
            if (this.state.activeSessionId === id) {
                this.state.activeSessionId = null;
                this.state.activeSessionName = null;
                this.state.messages = [];
            }

            await this.loadSessions();

            if (!this.state.activeSessionId && this.state.sessions.length) {
                await this.selectSession(this.state.sessions[0].id);
            }
        } catch (error) {
            console.error(error);
            this.notification.add(`Failed to delete: ${error?.message || error}`, { type: "danger" });
        }
    }

    async sendMessage() {
        try {
            const text = (this.state.input || "").trim();
            const sessionId = this.state.activeSessionId;
            if (!text || !sessionId) return;

            await this.orm.call("prema.ai.session", "send_message", [sessionId, text]);

            this.state.input = "";
            await this.selectSession(sessionId);
        } catch (error) {
            console.error(error);
            this.notification.add(`Send failed: ${error?.message || error}`, { type: "danger" });
        }
    }

    handleKeyDown(ev) {
        if (ev.key === "Enter") {
            ev.preventDefault();
            this.sendMessage();
        }
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console", AIConsole);