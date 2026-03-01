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
        });

        onWillStart(async () => {
            await this.loadSessions();
        });
    }

    // ----------------------------
    // LOAD SESSIONS
    // ----------------------------

    async loadSessions() {
        const sessions = await this.orm.searchRead(
            "prema.ai.session",
            [],
            ["name"]
        );

        this.state.sessions = sessions;

        if (sessions.length && !this.state.activeSessionId) {
            this.state.activeSessionId = sessions[0].id;
            await this.loadMessages();
        }
    }

    async loadMessages() {
        if (!this.state.activeSessionId) return;

        const messages = await this.orm.searchRead(
            "prema.ai.message",
            [["session_id", "=", this.state.activeSessionId]],
            ["role", "content"]
        );

        this.state.messages = messages;
    }

    async selectSession(id) {
        this.state.activeSessionId = id;
        await this.loadMessages();
    }

    // ----------------------------
    // CREATE SESSION
    // ----------------------------

    async createNewSession() {
        const id = await this.orm.create("prema.ai.session", [{
            name: "New Chat"
        }]);

        await this.loadSessions();
        this.state.activeSessionId = id;
        await this.loadMessages();
    }

    // ----------------------------
    // RENAME SESSION (FIXED CONTEXT)
    // ----------------------------

    async renameSession(session) {
        try {
            if (!session.name || !session.name.trim()) {
                this.notification.add("Session name cannot be empty", {
                    type: "warning",
                });
                return;
            }

            await this.orm.write(
                "prema.ai.session",
                [session.id],
                { name: session.name }
            );

            this.notification.add("Session renamed", {
                type: "success",
            });

            await this.loadSessions();

        } catch (error) {
            console.error("Rename error:", error);
        }
    }

    // ----------------------------
    // DELETE SESSION
    // ----------------------------

    async deleteSession(id) {
        try {
            await this.orm.unlink("prema.ai.session", [id]);

            if (this.state.activeSessionId === id) {
                this.state.activeSessionId = null;
                this.state.messages = [];
            }

            await this.loadSessions();

            this.notification.add("Session deleted", {
                type: "info",
            });

        } catch (error) {
            console.error("Delete error:", error);
        }
    }

    // ----------------------------
    // SEND MESSAGE
    // ----------------------------

    async sendMessage() {
        if (!this.state.input.trim() || !this.state.activeSessionId) return;

        const result = await this.orm.call(
            "prema.ai.session",
            "send_user_message",
            [this.state.activeSessionId],
            { content: this.state.input }
        );

        this.state.messages.push(result.user);
        this.state.messages.push(result.assistant);

        this.state.input = "";
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);