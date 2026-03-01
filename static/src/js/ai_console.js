/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, useState } from "@odoo/owl";
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

        this.loadSessions();
    }

    async loadSessions() {
        this.state.sessions = await this.orm.call(
            "prema.ai.session",
            "list_sessions",
            []
        );
    }

    async createNewSession() {
        const id = await this.orm.call(
            "prema.ai.session",
            "create",
            [{ name: "New Chat" }]
        );
        await this.loadSessions();
        this.selectSession(id);
    }

    async selectSession(id) {
        this.state.activeSessionId = id;
        this.state.messages = await this.orm.call(
            "prema.ai.message",
            "search_read",
            [[["session_id", "=", id]], ["role", "content"]]
        );
    }

    async renameSession(id) {
        const newName = prompt("Rename chat:");
        if (!newName) {
            return;
        }

        await this.orm.call(
            "prema.ai.session",
            "rename_session",
            [id, newName]
        );
        await this.loadSessions();
    }

    async deleteSession(id) {
        if (!confirm("Delete this chat?")) {
            return;
        }

        await this.orm.call(
            "prema.ai.session",
            "delete_session",
            [id]
        );

        await this.loadSessions();
        this.state.activeSessionId = null;
        this.state.messages = [];
    }

    async sendMessage() {
        if (!this.state.input || !this.state.activeSessionId) {
            return;
        }

        await this.orm.call(
            "prema.ai.session",
            "send_message",
            [this.state.activeSessionId, this.state.input]
        );

        this.state.input = "";
        await this.selectSession(this.state.activeSessionId);
    }

    handleKeyDown(ev) {
        if (ev.key === "Enter") {
            ev.preventDefault();
            this.sendMessage();
        }
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);
registry.category("actions").add("prema_ai_console", AIConsole);
