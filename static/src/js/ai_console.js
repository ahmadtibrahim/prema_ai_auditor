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
            messages: [],
            input: "",
        });

        onMounted(() => {
            this.loadSessions();
        });
    }

    async loadSessions() {
        try {
            this.state.sessions = await this.orm.call(
                "prema.ai.session",
                "list_sessions",
                []
            );
        } catch (e) {
            console.error(e);
        }
    }

    async createNewSession() {
        const id = await this.orm.call(
            "prema.ai.session",
            "create",
            [{ name: "New Chat" }]
        );
        await this.loadSessions();
        await this.selectSession(id);
    }

    async selectSession(id) {
        if (!id) return;

        this.state.activeSessionId = id;

        this.state.messages = await this.orm.call(
            "prema.ai.message",
            "search_read",
            [[["session_id","=",id]], ["role","content"]],
        );
    }

    async renameSession(id) {
        const newName = prompt("Rename chat:");
        if (!newName) return;

        await this.orm.call(
            "prema.ai.session",
            "rename_session",
            [id, newName]
        );

        await this.loadSessions();
    }

    async deleteSession(id) {
        if (!confirm("Delete this chat?")) return;

        await this.orm.call(
            "prema.ai.session",
            "delete_session",
            [id]
        );

        this.state.activeSessionId = null;
        this.state.messages = [];
        await this.loadSessions();
    }

    async sendMessage() {
        if (!this.state.input || !this.state.activeSessionId) return;

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

AIConsole.template = "prema_ai_console.AIConsole";

registry.category("actions").add("prema_ai_console", AIConsole);
