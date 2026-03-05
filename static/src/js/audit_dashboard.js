/** @odoo-module **/
import { registry } from "@web/core/registry";
import { Component, useState } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

export class AuditDashboard extends Component {
    static template = "prema_audit_dashboard.AuditDashboard";

    setup() {
        this.orm = useService("orm");
        this.state = useState({
            isScanning: false, scanDone: false, results: null,
            activeFilter: "all", activeCategory: "all", errorMsg: null,
        });
    }

    async runScan() {
        this.state.isScanning = true;
        this.state.scanDone = false;
        this.state.results = null;
        this.state.errorMsg = null;

        try {
            const scanId = await this.orm.call("prema.audit.scan", "run_scan", []);
            const results = await this.orm.call("prema.audit.scan", "get_scan_results", [scanId]);
            this.state.results = results;
            this.state.scanDone = true;
        } catch (e) {
            console.error(e);
            this.state.errorMsg = "Scan failed: " + e.message;
        } finally {
            this.state.isScanning = false;
        }
    }

    get filteredIssues() {
        if (!this.state.results?.issues) return [];
        let issues = this.state.results.issues;
        if (this.state.activeFilter !== "all")
            issues = issues.filter(i => i.risk === this.state.activeFilter);
        if (this.state.activeCategory !== "all")
            issues = issues.filter(i => i.category === this.state.activeCategory);
        return issues;
    }

    get categories() {
        if (!this.state.results?.issues) return [];
        return [...new Set(this.state.results.issues.map(i => i.category))];
    }

    setFilter(risk) { this.state.activeFilter = risk; }
    setCategory(cat) { this.state.activeCategory = cat; }

    async approveFix(issueId) {
        try {
            const result = await this.orm.call("prema.audit.issue", "approve_fix", [issueId]);
            if (result.success) {
                const idx = this.state.results.issues.findIndex(i => i.id === issueId);
                if (idx >= 0) this.state.results.issues[idx].fix_state = "executed";
            } else {
                alert("Fix failed: " + (result.error || "Unknown error"));
            }
        } catch (e) {
            console.error(e);
            alert("Fix error: " + e.message);
        }
    }

    async rejectFix(issueId) {
        const reason = prompt("Reason for rejection (optional):");
        try {
            await this.orm.call("prema.audit.issue", "reject_fix", [issueId, reason || ""]);
            const idx = this.state.results.issues.findIndex(i => i.id === issueId);
            if (idx >= 0) this.state.results.issues[idx].fix_state = "rejected";
        } catch (e) {
            console.error(e);
        }
    }
}

registry.category("actions").add("prema_audit_dashboard", AuditDashboard);
