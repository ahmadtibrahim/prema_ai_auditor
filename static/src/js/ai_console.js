/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, onWillStart, useState } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

class AIConsole extends Component {
    setup() {
        this.orm = useService("orm");
        this.notification = useService("notification");

        this.state = useState({
            activeSessionId: null,
            messages: [],
            input: "",
        });

        onWillStart(async () => {
            await this._ensureSession();
            await this._loadMessages();
        });
    }

    async _ensureSession() {
        const sessions = await this.orm.searchRead("prema.ai.session", [], ["id"], { limit: 1, order: "id desc" });
        if (sessions.length) {
            this.state.activeSessionId = sessions[0].id;
            return;
        }
        this.state.activeSessionId = await this.orm.create("prema.ai.session", [{ name: "AI Session" }]);
    }

    async _loadMessages() {
        if (!this.state.activeSessionId) {
            return;
        }
        this.state.messages = await this.orm.searchRead(
            "prema.ai.message",
            [["session_id", "=", this.state.activeSessionId]],
            ["role", "content"],
            { order: "id asc" }
        );
    }

    async sendMessage() {
        const messageText = (this.state.input || "").trim();
        if (!messageText || !this.state.activeSessionId) {
            return;
        }

        try {
            this.sessionId = this.state.activeSessionId;
            const message = messageText;
            const reply = await this.orm.call(
                "prema.ai.session",
                "send_message",
                [this.sessionId, message]
            );
            this.state.messages.push({ role: "user", content: messageText });
            this.state.messages.push({ role: "assistant", content: reply });
            this.state.input = "";
        } catch (error) {
            console.error(error);
            this.notification.add("Failed to send message", { type: "danger" });
        }
    }
}

AIConsole.template = "prema_ai_auditor.AIConsole";
registry.category("actions").add("prema_ai_console.main", AIConsole);
registry.category("actions").add("prema_ai_console", AIConsole);
