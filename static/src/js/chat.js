/** @odoo-module **/

import { Component, useState } from "@odoo/owl";
import { registry } from "@web/core/registry";
import { useService } from "@web/core/utils/hooks";

class PremaChat extends Component {
    setup() {
        this.rpc = useService("rpc");
        this.state = useState({
            messages: [],
            input: "",
            healthScore: 100,
        });
    }

    async send() {
        if (!this.state.input) {
            return;
        }

        const userMsg = this.state.input;
        this.state.messages.push({ role: "user", content: userMsg });
        this.state.input = "";

        const response = await this.rpc("/prema_ai/chat", {
            message: userMsg,
        });

        this.state.messages.push({
            role: "assistant",
            content: response.reply,
        });

        this.state.healthScore = response.health_score;
    }
}

PremaChat.template = "prema_ai_auditor.ChatTemplate";
registry.category("actions").add("prema_ai_chat", PremaChat);
