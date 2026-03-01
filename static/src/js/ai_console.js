/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, onWillStart, useState } from "@odoo/owl";
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
            if (this.state.activeSessionId) {
                await this.loadMessages();
            }
        });
    }

    async loadSessions() {
        const sessions = await this.orm.searchRead("prema.ai.session", [], ["name"]);
        this.state.sessions = sessions;
        if (!this.state.activeSessionId && sessions.length) {
            this.state.activeSessionId = sessions[0].id;
        }
    }

    async loadMessages() {
        if (!this.state.activeSessionId) {
            this.state.messages = [];
            return;
        }
        const messages = await this.orm.searchRead(
            "prema.ai.message",
            [["session_id", "=", this.state.activeSessionId]],
            ["id", "role", "content"]
        );
        this.state.messages = messages;
    }

    async selectSession(id) {
        if (this.state.activeSessionId === id) {
            return;
        }
        this.state.activeSessionId = id;
        await this.loadMessages();
    }

    async createNewSession() {
        try {
            const newId = await this.orm.create("prema.ai.session", [{ name: "New Chat" }]);
            this.state.activeSessionId = newId[0];
            await this.loadSessions();
            await this.loadMessages();
        } catch (error) {
            this.notification.add("Failed to create session", { type: "danger" });
        }
    }

    async deleteSession(id) {
        try {
            await this.orm.unlink("prema.ai.session", [id]);
            if (this.state.activeSessionId === id) {
                this.state.activeSessionId = null;
            }
            await this.loadSessions();
            if (this.state.sessions.length) {
                this.state.activeSessionId = this.state.sessions[0].id;
                await this.loadMessages();
            } else {
                this.state.messages = [];
            }
        } catch (error) {
            this.notification.add("Failed to delete session", { type: "danger" });
        }
    }

    async renameSession(id, newName) {
        try {
            const name = (newName || "").trim();
            if (!name) {
                return;
            }
            await this.orm.write("prema.ai.session", [id], { name: name });
            await this.loadSessions();
        } catch (error) {
            this.notification.add("Failed to rename session", { type: "danger" });
        }
    }

    async sendMessage() {
        const content = (this.state.input || "").trim();
        if (!content) {
            return;
        }
        try {
            if (!this.state.activeSessionId) {
                await this.createNewSession();
            }
            const result = await this.orm.call("prema.ai.session", "send_user_message", [], { content: content });
            this.state.messages.push(result.user);
            this.state.messages.push(result.assistant);
            this.state.input = "";
        } catch (error) {
            this.notification.add("Failed to send message", { type: "danger" });
        }
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);
