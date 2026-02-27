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
            showBatchModal: false,
            batchSummary: { total: 0, clean: 0, duplicate: 0, missing_vendor: 0 },
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
        if ((response?.batch_summary?.total || 0) > 1) {
            this.state.batchSummary = response.batch_summary;
            this.state.showBatchModal = true;
        }
    }

    closeBatchModal() {
        this.state.showBatchModal = false;
    }

    async createCleanOnlyDrafts() {
        await this.rpc("/prema_ai/create_drafts", {
            session_id: this.state.sessionId,
            clean_only: true,
        });
        this.state.showBatchModal = false;
        this.state.messages.push({ role: "system", content: "Created clean documents as draft bills." });
    }

    async createAllDrafts() {
        await this.rpc("/prema_ai/create_drafts", {
            session_id: this.state.sessionId,
            clean_only: false,
        });
        this.state.showBatchModal = false;
        this.state.messages.push({ role: "system", content: "Created all processed documents as draft bills." });
    }
}

PremaChat.template = "prema_ai_auditor.ChatTemplate";
registry.category("actions").add("prema_ai_chat", PremaChat);
