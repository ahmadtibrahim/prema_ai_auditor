/** @odoo-module **/

import { Component, useState } from "@odoo/owl";
import { registry } from "@web/core/registry";
import { useService } from "@web/core/utils/hooks";
import { AIChatUpload } from "../components/ai_chat_upload/ai_chat_upload";

class PremaChat extends Component {
    static components = { AIChatUpload };

    setup() {
        this.rpc = useService("rpc");
        this.bus = useService("bus_service");
        this.state = useState({
            messages: [],
            input: "",
            healthScore: 100,
            sessionId: null,
            mode: "advice_only",
        });

        this._initializeSession();
        this.bus.addChannel("prema_ai_channel");
        this.bus.addEventListener("notification", this.onNotification.bind(this));
    }

    async _initializeSession() {
        const session = await this.rpc("/prema_ai/session", {});
        this.state.sessionId = session.id;
    }

    onNotification({ detail }) {
        for (const notification of detail || []) {
            if (notification.type === "prema_ai_channel") {
                this.state.messages.push({
                    role: "system",
                    content: `Realtime Alert: ${JSON.stringify(notification.payload)}`,
                });
            }
        }
    }

    async send() {
        if (!this.state.input || !this.state.sessionId) {
            return;
        }

        const userMsg = this.state.input;
        this.state.messages.push({ role: "user", content: userMsg });
        this.state.input = "";

        const response = await this.rpc("/prema_ai/chat", {
            message: userMsg,
            session_id: this.state.sessionId,
            mode: this.state.mode,
        });

        this.state.messages.push({
            role: "assistant",
            content: response.reply,
        });

        this.state.healthScore = response.health_score;
    }

    async refreshDocumentSummary() {
        if (!this.state.sessionId) {
            return;
        }
        const response = await this.rpc("/prema_ai/document_summary", {
            session_id: this.state.sessionId,
        });
        if (response?.summary) {
            this.state.messages.push({
                role: "system",
                content: response.summary,
            });
        }
    }
}

PremaChat.template = "prema_ai_auditor.ChatTemplate";
registry.category("actions").add("prema_ai_chat", PremaChat);
