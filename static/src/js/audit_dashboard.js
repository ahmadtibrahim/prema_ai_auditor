/** @odoo-module **/
import { registry } from "@web/core/registry";
import { Component, useState, onMounted } from "@odoo/owl";
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
                this._updateIssueState(issueId, "executed", result.result);
            } else {
                alert("Fix failed: " + result.error);
            }
        } catch (e) { console.error(e); }
    }

    async rejectFix(issueId) {
        const reason = prompt("Reason for rejection (optional):");
        try {
            await this.orm.call("prema.audit.issue", "reject_fix", [issueId, reason || ""]);
            this._updateIssueState(issueId, "rejected", "Rejected");
        } catch (e) { console.error(e); }
    }

    _updateIssueState(issueId, newState, result) {
        if (!this.state.results) return;
        const issue = this.state.results.issues.find(i => i.id === issueId);
        if (issue) {
            issue.fix_state = newState;
            issue._fix_result = result;
            // Force re-render
            this.state.results = { ...this.state.results };
        }
    }
}

registry.category("actions").add("prema_audit_dashboard", AuditDashboard);
