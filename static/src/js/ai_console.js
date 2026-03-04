/** File: /opt/odoo/custum-addons/prema_ai_auditor/static/src/js/ai_console.js */
/** @odoo-module **/

import { Component, useState, useRef, onMounted, onPatched } from "@odoo/owl";
import { registry } from "@web/core/registry";
import { useService } from "@web/core/utils/hooks";
import { rpc } from "@web/core/network/rpc";

let _keyCounter = 0;
const key = () => String(++_keyCounter);

class AiConsole extends Component {
  static template = "prema_ai_auditor.AiConsole";

  setup() {
    this.notification = useService("notification");
    this.state = useState({
      sessionId: null,
      messages: [], // {key, type:'msg'|'task', role?, content?, task_id?, state?, preview_html?, result_url?, result_summary?}
      attachments: [], // {id, name}
      loading: false,
    });

    this.msgContainer = useRef("msgContainer");
    this.msgInput = useRef("msgInput");
    this.fileInput = useRef("fileInput");

    onMounted(() => this._initSession());
    onPatched(() => this._scrollBottom());
  }

  // ── Init ─────────────────────────────────────────────────────────────────

  async _initSession() {
    try {
      const res = await rpc("/prema_ai/session", {});
      this.state.sessionId = res.session_id;

      if (res.messages && res.messages.length) {
        for (const m of res.messages) {
          this.state.messages.push({
            key: key(),
            type: "msg",
            role: m.role,
            content: m.content,
          });
        }
      } else {
        this.state.messages.push({
          key: key(),
          type: "msg",
          role: "assistant",
          content:
            "👋 Hi! I'm Prema AI — your intelligent ERP assistant.\n\n" +
            "I can:\n" +
            "📁  Find duplicate documents & organize them into folders\n" +
            "📄  Process invoice PDFs → create vendor bills\n" +
            "📊  Analyze accounting, CRM, fleet & inventory\n" +
            "🔍  Search & audit your entire Odoo system\n" +
            "✏️   Create records, update data, schedule meetings\n\n" +
            "Just tell me what you need. Examples:\n" +
            '• "Find all duplicate documents"\n' +
            '• "Put all driver files into a folder called Driver Packets"\n' +
            '• "Show me overdue invoices"\n' +
            "• Upload a PDF invoice and I'll create the vendor bill",
        });
      }
    } catch (e) {
      console.error("Prema AI init failed:", e);
    }
  }

  // ── Send Message ──────────────────────────────────────────────────────────

  async send() {
    const input = this.msgInput.el;
    const text = (input.value || "").trim();

    if (!text && !this.state.attachments.length) return;
    if (this.state.loading) return;

    const attIds = this.state.attachments.map((a) => a.id);
    const displayText =
      text ||
      `[Uploaded: ${this.state.attachments.map((a) => a.name).join(", ")}]`;

    // Show user bubble
    this.state.messages.push({
      key: key(),
      type: "msg",
      role: "user",
      content: displayText,
    });

    input.value = "";
    this.state.attachments = [];
    this.state.loading = true;

    try {
      const res = await rpc("/prema_ai/chat", {
        session_id: this.state.sessionId,
        message: text,
        attachment_ids: attIds,
      });

      // AI response text
      if (res.response) {
        this.state.messages.push({
          key: key(),
          type: "msg",
          role: "assistant",
          content: res.response,
        });
      }

      // Task preview cards
      for (const t of res.pending_tasks || []) {
        this.state.messages.push({
          key: key(),
          type: "task",
          task_id: t.task_id,
          name: t.name,
          preview_html: t.preview_html,
          state: "pending",
          result_url: null,
          result_summary: "",
        });
      }
    } catch (e) {
      this.state.messages.push({
        key: key(),
        type: "msg",
        role: "assistant",
        content: `⚠️ Error: ${e.message || "Connection failed"}`,
      });
    } finally {
      this.state.loading = false;
    }
  }

  // ── Task Approval ─────────────────────────────────────────────────────────

  async approveTask(msg) {
    msg.state = "executing";

    try {
      const res = await rpc("/prema_ai/task/approve", { task_id: msg.task_id });

      msg.state = res.state || "done";
      msg.result_url = res.result_url || null;
      msg.result_summary = res.result_summary || res.error || "";

      if (res.state === "done") {
        this.notification.add(
          "✅ " + (res.result_summary || "Action completed!"),
          { type: "success" },
        );
      } else {
        this.notification.add("❌ " + (res.error || "Execution failed"), {
          type: "danger",
        });
      }
    } catch (e) {
      msg.state = "failed";
      msg.result_summary = e.message;
      this.notification.add("Execution error: " + e.message, {
        type: "danger",
      });
    }
  }

  async rejectTask(msg) {
    try {
      await rpc("/prema_ai/task/reject", { task_id: msg.task_id });
      msg.state = "rejected";
      this.notification.add("Task rejected.", { type: "info" });
    } catch (e) {
      console.error(e);
    }
  }

  // ── File Upload ────────────────────────────────────────────────────────────

  openFilePicker() {
    this.fileInput.el.click();
  }

  async onFileChange(ev) {
    const files = ev.target.files;
    if (!files || !files.length) return;

    for (const file of files) {
      try {
        const fd = new FormData();
        fd.append("file", file);

        const resp = await fetch("/prema_ai/upload", {
          method: "POST",
          body: fd,
        });

        const data = await resp.json();

        if (data.attachment_id) {
          this.state.attachments.push({
            id: data.attachment_id,
            name: data.name || file.name,
          });

          this.notification.add(`📎 ${file.name} ready`, { type: "info" });
        } else {
          this.notification.add(`Upload failed: ${data.error}`, {
            type: "danger",
          });
        }
      } catch (e) {
        this.notification.add(`Upload error: ${e.message}`, { type: "danger" });
      }
    }

    ev.target.value = "";
  }

  removeAtt(att) {
    this.state.attachments = this.state.attachments.filter(
      (a) => a.id !== att.id,
    );
  }

  // ── UX ────────────────────────────────────────────────────────────────────

  onKey(ev) {
    if (ev.key === "Enter" && !ev.shiftKey) {
      ev.preventDefault();
      this.send();
    }

    const ta = ev.target;
    ta.style.height = "auto";
    ta.style.height = Math.min(ta.scrollHeight, 140) + "px";
  }

  _scrollBottom() {
    const el = this.msgContainer.el;
    if (el) {
      el.scrollTop = el.scrollHeight;
    }
  }
}

registry.category("actions").add("prema_ai_console", AiConsole);
