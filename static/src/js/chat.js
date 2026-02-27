/** @odoo-module **/

import { Component, useState } from "@odoo/owl";
import { registry } from "@web/core/registry";
import { useService } from "@web/core/utils/hooks";

class PremaAIChat extends Component {
    static template = "prema_ai_auditor.PremaAIChat";

    setup() {
        this.rpc = useService("rpc");
        this.state = useState({
            input: "",
            output: "",
            loading: false,
        });
    }

    async sendMessage() {
        if (!this.state.input.trim()) {
            return;
        }
        this.state.loading = true;
        const response = await this.rpc("/prema_ai/chat", {
            message: this.state.input,
        });
        this.state.output = JSON.stringify(response);
        this.state.loading = false;
    }
}

registry.category("actions").add("prema_ai_chat_action", PremaAIChat);
