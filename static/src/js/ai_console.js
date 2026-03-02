/** @odoo-module **/

import { registry } from "@web/core/registry";
import { Component, useState, onMounted, useRef } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

export class AIConsole extends Component {
    static template = "prema_ai_console.AIConsole";

    setup() {
        this.orm = useService("orm");
        this.messagesRef = useRef("messages");

        this.state = useState({
            sessions: [],
            activeSessionId: null,
            activeSessionName: "AI Console",
            messages: [],
            input: "",
            isLoading: false,
            errorMsg: null,
        });

        onMounted(() => {
            this.loadSessions();
        });
    }

    // -------------------------------------------------------------------------
    // Session management
    // -------------------------------------------------------------------------

    async loadSessions() {
        try {
            this.state.sessions = await this.orm.call(
                "prema.ai.session",
                "list_sessions",
                []
            );
        } catch (e) {
            console.error("Failed to load sessions:", e);
        }
    }

    async createNewSession() {
        try {
            const id = await this.orm.call(
                "prema.ai.session",
                "create",
                [{ name: "New Chat" }]
            );
            await this.loadSessions();
            await this.selectSession(id, "New Chat");
        } catch (e) {
            console.error("Failed to create session:", e);
        }
    }

    async selectSession(id, name) {
        if (!id) return;
        this.state.activeSessionId = id;
        this.state.activeSessionName = name || "AI Console";
        this.state.errorMsg = null;

        try {
            this.state.messages = await this.orm.call(
                "prema.ai.message",
                "search_read",
                [[["session_id", "=", id]], ["role", "content"]],
            );
        } catch (e) {
            console.error("Failed to load messages:", e);
        }

        this._scrollToBottom();
    }

    async renameSession(id, ev) {
        if (ev) ev.stopPropagation();
        const newName = prompt("Rename chat:");
        if (!newName || !newName.trim()) return;

        try {
            await this.orm.call("prema.ai.session", "rename_session", [id, newName.trim()]);
            await this.loadSessions();
            if (this.state.activeSessionId === id) {
                this.state.activeSessionName = newName.trim();
            }
        } catch (e) {
            console.error("Failed to rename session:", e);
        }
    }

    async deleteSession(id, ev) {
        if (ev) ev.stopPropagation();
        if (!confirm("Delete this chat? This cannot be undone.")) return;

        try {
            await this.orm.call("prema.ai.session", "delete_session", [id]);
            if (this.state.activeSessionId === id) {
                this.state.activeSessionId = null;
                this.state.activeSessionName = "AI Console";
                this.state.messages = [];
            }
            await this.loadSessions();
        } catch (e) {
            console.error("Failed to delete session:", e);
        }
    }

    // -------------------------------------------------------------------------
    // Messaging
    // -------------------------------------------------------------------------

    async sendMessage() {
        const text = (this.state.input || "").trim();
        if (!text || !this.state.activeSessionId || this.state.isLoading) return;

        this.state.errorMsg = null;

        // Optimistically show user message immediately
        this.state.messages = [
            ...this.state.messages,
            { id: Date.now(), role: "user", content: text },
        ];
        this.state.input = "";
        this.state.isLoading = true;
        this._scrollToBottom();

        try {
            await this.orm.call(
                "prema.ai.session",
                "send_message",
                [this.state.activeSessionId, text]
            );

            // Reload full messages from server
            this.state.messages = await this.orm.call(
                "prema.ai.message",
                "search_read",
                [[["session_id", "=", this.state.activeSessionId]], ["role", "content"]],
            );
        } catch (e) {
            console.error("Failed to send message:", e);
            this.state.errorMsg = "Failed to send message. Check your OpenAI API key in Settings → System Parameters.";
            this.state.messages = this.state.messages.slice(0, -1);
        } finally {
            this.state.isLoading = false;
            this._scrollToBottom();
        }
    }

    handleKeyDown(ev) {
        if (ev.key === "Enter" && !ev.shiftKey) {
            ev.preventDefault();
            this.sendMessage();
        }
    }

    // -------------------------------------------------------------------------
    // Helpers
    // -------------------------------------------------------------------------

    _scrollToBottom() {
        setTimeout(() => {
            const el = this.messagesRef.el;
            if (el) el.scrollTop = el.scrollHeight;
        }, 50);
    }
}

registry.category("actions").add("prema_ai_console", AIConsole);
