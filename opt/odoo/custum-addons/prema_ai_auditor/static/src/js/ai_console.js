/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, useState, onWillStart } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

class AIConsole extends Component {
    setup() {
        this.orm = useService("orm");

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

    async loadSessions() {
        const sessions = await this.orm.searchRead(
            "prema.ai.session",
            [],
            ["name"]
        );

        this.state.sessions = sessions;

        if (sessions.length) {
            this.state.activeSessionId = sessions[0].id;
            await this.loadMessages();
        }
    }

    async loadMessages() {
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

    async createNewSession() {
        const newSession = await this.orm.create("prema.ai.session", [{
            name: "New Chat"
        }]);

        await this.loadSessions();
        this.state.activeSessionId = newSession;
        await this.loadMessages();
    }

    async deleteSession(id) {
        await this.orm.unlink("prema.ai.session", [id]);
        await this.loadSessions();
    }

    async sendMessage() {
        if (!this.state.input.trim()) return;

        const result = await this.orm.call(
            "prema.ai.session",
            "send_user_message",
            [],
            { content: this.state.input }
        );

        this.state.messages.push(result.user);
        this.state.messages.push(result.assistant);

        this.state.input = "";
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);