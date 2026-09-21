/** @odoo-module **/
import { registry } from "@web/core/registry";
import { Component, useState, onMounted, onWillUnmount, useRef, markup } from "@odoo/owl";
import { useService } from "@web/core/utils/hooks";

export class AIConsole extends Component {
    static template = "prema_ai_console.AIConsole";

    setup() {
        this.orm = useService("orm");
        this.messagesRef = useRef("messages");
        this.fileInputRef = useRef("fileInput");

        this.state = useState({
            sessions: [],
            activeSessionId: null,
            activeSessionName: "AI Console",
            messages: [],
            input: "",
            isLoading: false,
            // Seconds the current LLM request has been running (visible ticker)
            elapsed: 0,
            errorMsg: null,
            pendingFiles: [],
            sidebarOpen: false,
            isRecording: false,
            // Pending action (lead confirmation, etc.)
            pendingAction: null,
            isConfirming: false,
            // Chat mode
            chatMode: "standard",
            // Logistics Estimate truck selection
            selectedTruckId: null,
            availableTrucks: [],
            // Attachment limits (loaded from backend)
            chatLimits: {
                max_files_per_chat: 5,
                max_images_per_chat: 3,
                max_total_upload_mb: 50,
                allowed_file_types: ".pdf,.jpg,.jpeg,.png,.webp,.gif,.tiff,.xlsx,.csv,.doc,.docx",
            },
            isDragOver: false,
            // ── Cost Estimator panel ──────────────────────────────────
            estimatorOpen: false,
            estimatorTruckId: null,
            estimatorStops: [{ id: 1, type: "pickup", address: "", lat: 0, lng: 0, suggestions: [], liftgate: false, pallets: 0, stop_date: "", time_window_start: "", time_window_end: "", stop_notes: "" }],
            estimatorNextStopId: 2,
            estimatorAllowCrossBorder: false,
            estimatorAvoidTolls: true,
            estimatorLoadWeightLbs: 0,
            estimatorLoadPallets: 0,
            estimatorScheduledAt: "",
            estimatorNotes: "",
            // User-editable cost params (pre-filled from truck/config via get_defaults_rpc)
            estimatorFuelPrice: "",
            estimatorFuelUnit: "L",
            estimatorDriverRate: "",
            estimatorInsuranceMonthly: "",
            estimatorMaintenanceMonthly: "",
            estimatorMarginPct: "20",
            estimatorIsLoading: false,
            estimatorResult: null,
            estimatorError: null,
            // Route sheet upload
            estimatorRouteSheetDragOver: false,
            estimatorIsExtractingStops: false,
            estimatorExtractError: null,
            // Vehicle availability
            estimatorAvailabilityResult: null,
            estimatorIsCheckingAvailability: false,
            estimatorIsCreatingJob: false,
        });

        this._mediaRecorder = null;
        this._audioChunks = [];
        this._elapsedTimer = null;

        onMounted(async () => {
            await this.loadSessions();
            await this.loadChatLimits();
        });

        onWillUnmount(() => {
            this._stopElapsedTimer();
        });
    }

    // ── Session management ─────────────────────────────────────────

    async loadSessions() {
        try {
            this.state.sessions = await this.orm.call(
                "prema.ai.session", "list_sessions", []);
        } catch (e) { console.error(e); }
    }

    async createNewSession() {
        try {
            const id = await this.orm.call(
                "prema.ai.session", "create", [{ name: "New Chat" }]);
            await this.loadSessions();
            await this.selectSession(id, "New Chat");
            this.state.chatMode = "standard";
            this.state.sidebarOpen = false;
        } catch (e) { console.error(e); }
    }

    async selectSession(id, name) {
        if (!id) return;
        this.state.activeSessionId = id;
        this.state.activeSessionName = name || "AI Console";
        this.state.errorMsg = null;
        this.state.pendingFiles = [];
        this.state.pendingAction = null;
        this.state.sidebarOpen = false;
        try {
            this.state.messages = await this.orm.call(
                "prema.ai.message", "search_read",
                [[["session_id", "=", id]], ["role", "content"]]);
        } catch (e) { console.error(e); }
        // Restore saved chat mode for this session
        try {
            const [sessionData] = await this.orm.read(
                "prema.ai.session", [id], ["chat_mode"]);
            this.state.chatMode = sessionData.chat_mode || "standard";
        } catch (e) {
            this.state.chatMode = "standard";
        }
        try {
            this.state.pendingAction = await this.orm.call(
                "prema.ai.session", "get_pending_action", [id]
            );
        } catch (e) {
            this.state.pendingAction = null;
        }
        this.state.selectedTruckId = null;
        if (this.state.chatMode === "logistics_estimate") {
            await this.loadTrucks();
        }
        this._scrollToBottom();
    }

    async renameSession(id, ev) {
        if (ev) ev.stopPropagation();
        const newName = prompt("Rename chat:");
        if (!newName?.trim()) return;
        try {
            await this.orm.call(
                "prema.ai.session", "rename_session", [id, newName.trim()]);
            await this.loadSessions();
            if (this.state.activeSessionId === id)
                this.state.activeSessionName = newName.trim();
        } catch (e) { console.error(e); }
    }

    async deleteSession(id, ev) {
        if (ev) ev.stopPropagation();
        if (!confirm("Delete this chat?")) return;
        try {
            await this.orm.call("prema.ai.session", "delete_session", [id]);
            if (this.state.activeSessionId === id) {
                this.state.activeSessionId = null;
                this.state.messages = [];
                this.state.pendingAction = null;
            }
            await this.loadSessions();
        } catch (e) { console.error(e); }
    }

    toggleSidebar() {
        this.state.sidebarOpen = !this.state.sidebarOpen;
    }

    // ── Chat modes ─────────────────────────────────────────────────

    get chatModes() {
        return [
            { id: "standard",          label: "Standard",           icon: "fa fa-bolt" },
            { id: "deep_thinking",     label: "Deep Thinking",      icon: "fa fa-lightbulb-o" },
            { id: "web_research",      label: "Web Research",       icon: "fa fa-globe" },
            { id: "logistics_estimate",label: "Logistics Estimate", icon: "fa fa-truck" },
            { id: "lead_generation",   label: "Lead Gen",           icon: "fa fa-users" },
            { id: "document_qa",       label: "Doc Q&A",            icon: "fa fa-file-text-o" },
        ];
    }

    async setChatMode(mode) {
        this.state.chatMode = mode;
        if (mode !== "logistics_estimate") {
            this.state.selectedTruckId = null;
        }
        if (this.state.activeSessionId) {
            try {
                await this.orm.call(
                    "prema.ai.session", "set_chat_mode",
                    [this.state.activeSessionId, mode]);
            } catch (e) {
                console.error("Failed to save chat mode:", e);
            }
        }
        if (mode === "logistics_estimate") {
            await this.loadTrucks();
        }
    }

    async loadTrucks() {
        try {
            this.state.availableTrucks = await this.orm.call(
                "prema.ai.session", "get_active_trucks", []);
        } catch (e) {
            console.error("Failed to load trucks:", e);
        }
    }

    onTruckChange(ev) {
        this.state.selectedTruckId = parseInt(ev.target.value) || null;
    }

    // ── Cost Estimator ─────────────────────────────────────────────

    toggleEstimator() {
        this.state.estimatorOpen = !this.state.estimatorOpen;
        if (this.state.estimatorOpen && this.state.availableTrucks.length === 0) {
            this.loadTrucks();
        }
    }

    async onEstimatorTruckChange(ev) {
        const id = parseInt(ev.target.value) || null;
        this.state.estimatorTruckId = id;
        if (id && this.state.estimatorStops.length > 0) {
            const truck = this.state.availableTrucks.find(t => t.id === id);
            if (truck) {
                const addr = truck.x_last_location_address || truck.x_home_base_address || "";
                this.state.estimatorStops[0].address = addr;
                this.state.estimatorStops[0].lat = 0;
                this.state.estimatorStops[0].lng = 0;
            }
        }
        if (id) {
            try {
                const d = await this.orm.call(
                    "premafirm.rate.estimator", "get_defaults_rpc", [id]);
                this.state.estimatorFuelPrice = d.fuel_price_per_l
                    ? d.fuel_price_per_l.toFixed(3) : "";
                this.state.estimatorFuelUnit = "L";
                this.state.estimatorDriverRate = d.driver_rate_per_hr
                    ? d.driver_rate_per_hr.toFixed(2) : "";
                this.state.estimatorInsuranceMonthly = d.insurance_monthly > 0
                    ? d.insurance_monthly.toFixed(2) : "";
                this.state.estimatorMaintenanceMonthly = d.maintenance_monthly > 0
                    ? d.maintenance_monthly.toFixed(2) : "";
                this.state.estimatorMarginPct = d.margin_pct
                    ? d.margin_pct.toFixed(1) : "20";
            } catch (e) {
                console.warn("get_defaults_rpc failed:", e);
            }
        }
    }

    // ── Cost param inputs ──────────────────────────────────────────

    onFuelPriceInput(ev)      { this.state.estimatorFuelPrice = ev.target.value; }
    onDriverRateInput(ev)     { this.state.estimatorDriverRate = ev.target.value; }
    onInsuranceInput(ev)      { this.state.estimatorInsuranceMonthly = ev.target.value; }
    onMaintenanceInput(ev)    { this.state.estimatorMaintenanceMonthly = ev.target.value; }
    onMarginInput(ev)         { this.state.estimatorMarginPct = ev.target.value; }

    toggleFuelUnit() {
        const current = parseFloat(this.state.estimatorFuelPrice) || 0;
        if (this.state.estimatorFuelUnit === "L") {
            this.state.estimatorFuelPrice = current ? (current * 3.78541).toFixed(3) : "";
            this.state.estimatorFuelUnit = "Gal";
        } else {
            this.state.estimatorFuelPrice = current ? (current / 3.78541).toFixed(4) : "";
            this.state.estimatorFuelUnit = "L";
        }
    }

    // ── Multi-stop management ──────────────────────────────────────

    addStop() {
        if (this.state.estimatorStops.length >= 10) return;
        const id = this.state.estimatorNextStopId;
        this.state.estimatorNextStopId += 1;
        this.state.estimatorStops.push({
            id, type: "dropoff", address: "", lat: 0, lng: 0, suggestions: [],
            liftgate: false, pallets: 0,
            stop_date: "", time_window_start: "", time_window_end: "", stop_notes: "",
        });
    }

    setStopLiftgate(idx, checked) { this.state.estimatorStops[idx].liftgate = checked; }
    onStopPalletsInput(idx, ev)   { this.state.estimatorStops[idx].pallets = parseInt(ev.target.value, 10) || 0; }

    removeStop(idx) {
        if (this.state.estimatorStops.length <= 1) return;
        this.state.estimatorStops.splice(idx, 1);
    }

    moveStopUp(idx) {
        if (idx <= 0) return;
        const stops = this.state.estimatorStops;
        const tmp = stops.splice(idx, 1)[0];
        stops.splice(idx - 1, 0, tmp);
    }

    moveStopDown(idx) {
        const stops = this.state.estimatorStops;
        if (idx >= stops.length - 1) return;
        const tmp = stops.splice(idx, 1)[0];
        stops.splice(idx + 1, 0, tmp);
    }

    setStopType(idx, type) {
        this.state.estimatorStops[idx].type = type;
    }

    onStopAddressInput(idx, value) {
        // Update state immediately so OWL re-renders don't reset the input
        this.state.estimatorStops[idx].address = value;
        this.state.estimatorStops[idx].lat = 0;
        this.state.estimatorStops[idx].lng = 0;

        if (!value || value.length < 3) {
            this.state.estimatorStops[idx].suggestions = [];
            return;
        }
        if (!this._addrTimers) this._addrTimers = {};
        clearTimeout(this._addrTimers[idx]);
        this._addrTimers[idx] = setTimeout(async () => {
            try {
                const suggestions = await this.orm.call(
                    "premafirm.rate.estimator", "geocode_address_rpc", [value]);
                this.state.estimatorStops[idx].suggestions = suggestions || [];
            } catch (e) {
                console.error("Geocode error:", e);
            }
        }, 350);
    }

    selectStopSuggestion(idx, suggestion) {
        this.state.estimatorStops[idx].address = suggestion.place_name;
        this.state.estimatorStops[idx].lat = suggestion.lat;
        this.state.estimatorStops[idx].lng = suggestion.lng;
        this.state.estimatorStops[idx].suggestions = [];
    }

    onWeightInput(ev) {
        this.state.estimatorLoadWeightLbs = parseFloat(ev.target.value) || 0;
    }

    onPalletsInput(ev) {
        this.state.estimatorLoadPallets = parseInt(ev.target.value, 10) || 0;
    }

    async runEstimate() {
        if (!this.state.estimatorTruckId) {
            this.state.estimatorError = "Please select a truck first.";
            return;
        }
        const addressedStops = this.state.estimatorStops.filter(
            (s, i) => i === 0 || s.address.trim()
        );
        if (addressedStops.length < 2) {
            this.state.estimatorError = "Please enter at least a destination stop address.";
            return;
        }
        this.state.estimatorIsLoading = true;
        this.state.estimatorResult = null;
        this.state.estimatorError = null;
        try {
            const stops = this.state.estimatorStops.map(s => ({
                type:              s.type,
                address:           s.address.trim(),
                lat:               s.lat || 0,
                lng:               s.lng || 0,
                liftgate:          s.liftgate || false,
                pallets:           s.pallets  || 0,
                stop_date:         s.stop_date || "",
                time_window_start: s.time_window_start || "",
                time_window_end:   s.time_window_end || "",
                stop_notes:        s.stop_notes || "",
            }));
            // Normalise fuel price to $/L regardless of unit selection
            const rawFuelPrice = parseFloat(this.state.estimatorFuelPrice) || 0;
            const fuelPriceL = this.state.estimatorFuelUnit === "Gal"
                ? rawFuelPrice / 3.78541
                : rawFuelPrice;
            const result = await this.orm.call(
                "premafirm.rate.estimator",
                "calculate_estimate",
                [this.state.estimatorTruckId, stops],
                {
                    allow_cross_border:    this.state.estimatorAllowCrossBorder,
                    avoid_tolls:           this.state.estimatorAvoidTolls,
                    load_weight_lbs:       this.state.estimatorLoadWeightLbs || 0,
                    load_pallets:          this.state.estimatorLoadPallets || 0,
                    fuel_price_per_l:      fuelPriceL,
                    driver_rate_per_hr:    parseFloat(this.state.estimatorDriverRate) || 0,
                    insurance_monthly:     parseFloat(this.state.estimatorInsuranceMonthly) || 0,
                    maintenance_monthly:   parseFloat(this.state.estimatorMaintenanceMonthly) || 0,
                    margin_pct:            parseFloat(this.state.estimatorMarginPct) || 20,
                    scheduled_at:          this.state.estimatorScheduledAt || null,
                    notes:                 this.state.estimatorNotes || null,
                }
            );
            if (result && result.error) {
                this.state.estimatorError = result.error;
            } else {
                this.state.estimatorResult = result;
                // Persist these params so the same truck auto-loads them next time
                this.orm.call("premafirm.rate.estimator", "save_truck_prefs_rpc", [
                    this.state.estimatorTruckId,
                    {
                        driver_rate_per_hr:  parseFloat(this.state.estimatorDriverRate) || 0,
                        maintenance_monthly: parseFloat(this.state.estimatorMaintenanceMonthly) || 0,
                        insurance_monthly:   parseFloat(this.state.estimatorInsuranceMonthly) || 0,
                        fuel_price_per_l:    fuelPriceL,
                        margin_pct:          parseFloat(this.state.estimatorMarginPct) || 0,
                    }
                ]).catch(e => console.warn("save_truck_prefs_rpc failed:", e));
            }
        } catch (e) {
            this.state.estimatorError = e.message || "Calculation failed — check console for details.";
            console.error("runEstimate error:", e);
        } finally {
            this.state.estimatorIsLoading = false;
        }
    }

    // ── Route sheet upload ─────────────────────────────────────────

    onRouteSheetDragOver(ev) {
        ev.preventDefault();
        ev.dataTransfer.dropEffect = "copy";
        this.state.estimatorRouteSheetDragOver = true;
    }

    onRouteSheetDragLeave(ev) {
        if (!ev.currentTarget.contains(ev.relatedTarget)) {
            this.state.estimatorRouteSheetDragOver = false;
        }
    }

    async onRouteSheetDrop(ev) {
        ev.preventDefault();
        this.state.estimatorRouteSheetDragOver = false;
        const files = ev.dataTransfer && ev.dataTransfer.files;
        if (!files || !files.length) return;
        await this._extractStopsFromFile(files[0]);
    }

    async onRouteSheetFileChange(ev) {
        const file = ev.target.files && ev.target.files[0];
        if (!file) return;
        await this._extractStopsFromFile(file);
        ev.target.value = "";
    }

    async _extractStopsFromFile(file) {
        this.state.estimatorIsExtractingStops = true;
        this.state.estimatorExtractError = null;
        try {
            const b64 = await this._fileToBase64(file);
            const result = await this.orm.call(
                "premafirm.rate.estimator",
                "extract_stops_from_file_rpc",
                [b64, file.type, file.name, this.state.estimatorNotes || ""]
            );
            if (result && result.error) {
                this.state.estimatorExtractError = result.error;
            } else if (result && result.stops && result.stops.length > 0) {
                // Replace current stops with extracted ones
                this.state.estimatorStops = result.stops.map((s, i) => ({
                    id: this.state.estimatorNextStopId + i,
                    type: s.type || (i === 0 ? "pickup" : "dropoff"),
                    address: s.address || "",
                    lat: s.lat || 0,
                    lng: s.lng || 0,
                    suggestions: [],
                    liftgate: s.liftgate || false,
                    pallets: s.pallets || 0,
                    stop_date: s.stop_date || "",
                    time_window_start: s.time_window_start || "",
                    time_window_end: s.time_window_end || "",
                    stop_notes: s.stop_notes || "",
                }));
                this.state.estimatorNextStopId += result.stops.length;
                if (result.notes && !this.state.estimatorNotes) {
                    this.state.estimatorNotes = result.notes;
                }
            } else {
                this.state.estimatorExtractError = "No stops found in the document. Try a different file or add stops manually.";
            }
        } catch (e) {
            this.state.estimatorExtractError = e.message || "Extraction failed.";
            console.error("extractStops error:", e);
        } finally {
            this.state.estimatorIsExtractingStops = false;
        }
    }

    // ── Vehicle availability check ─────────────────────────────────

    async checkTruckAvailability() {
        // Get pickup coordinates from first stop
        const firstStop = this.state.estimatorStops[0];
        if (!firstStop) return;

        this.state.estimatorIsCheckingAvailability = true;
        this.state.estimatorAvailabilityResult = null;
        try {
            const result = await this.orm.call(
                "premafirm.rate.estimator",
                "check_truck_availability_rpc",
                [
                    firstStop.lat || 0,
                    firstStop.lng || 0,
                    this.state.estimatorScheduledAt || "",
                    8.0,  // estimated duration
                ]
            );
            if (result && result.error) {
                this.state.estimatorError = result.error;
            } else {
                this.state.estimatorAvailabilityResult = result;
                // Auto-select the nearest available truck if none selected
                if (!this.state.estimatorTruckId && result.trucks) {
                    const best = result.trucks.find(t => t.status === "available");
                    if (best) {
                        this.state.estimatorTruckId = best.id;
                        // Load defaults for auto-selected truck
                        try {
                            const d = await this.orm.call(
                                "premafirm.rate.estimator", "get_defaults_rpc", [best.id]);
                            this.state.estimatorFuelPrice = d.fuel_price_per_l ? d.fuel_price_per_l.toFixed(3) : "";
                            this.state.estimatorDriverRate = d.driver_rate_per_hr ? d.driver_rate_per_hr.toFixed(2) : "";
                            this.state.estimatorInsuranceMonthly = d.insurance_monthly > 0 ? d.insurance_monthly.toFixed(2) : "";
                            this.state.estimatorMaintenanceMonthly = d.maintenance_monthly > 0 ? d.maintenance_monthly.toFixed(2) : "";
                            this.state.estimatorMarginPct = d.margin_pct ? d.margin_pct.toFixed(1) : "20";
                        } catch (e) { /* silent */ }
                    }
                }
            }
        } catch (e) {
            this.state.estimatorError = e.message || "Availability check failed.";
        } finally {
            this.state.estimatorIsCheckingAvailability = false;
        }
    }

    selectAvailableTruck(truckId) {
        this.state.estimatorTruckId = truckId;
        this.state.estimatorAvailabilityResult = null;
        // Load truck defaults
        this.orm.call("premafirm.rate.estimator", "get_defaults_rpc", [truckId])
            .then(d => {
                if (d.fuel_price_per_l) this.state.estimatorFuelPrice = d.fuel_price_per_l.toFixed(3);
                if (d.driver_rate_per_hr) this.state.estimatorDriverRate = d.driver_rate_per_hr.toFixed(2);
                if (d.insurance_monthly > 0) this.state.estimatorInsuranceMonthly = d.insurance_monthly.toFixed(2);
                if (d.maintenance_monthly > 0) this.state.estimatorMaintenanceMonthly = d.maintenance_monthly.toFixed(2);
                if (d.margin_pct) this.state.estimatorMarginPct = d.margin_pct.toFixed(1);
                const truck = this.state.availableTrucks.find(t => t.id === truckId);
                if (truck) {
                    this.state.estimatorStops[0].address = truck.x_last_location_address || truck.x_home_base_address || "";
                    this.state.estimatorStops[0].lat = 0;
                    this.state.estimatorStops[0].lng = 0;
                }
            })
            .catch(e => console.warn("get_defaults_rpc failed:", e));
    }

    async openEstimateInChat() {
        if (!this.state.estimatorResult) return;
        const r = this.state.estimatorResult;
        const c = r.costs;
        const rt = r.route;
        const stopLines = rt.stop_count > 2 && rt.stops
            ? rt.stops.map((s, i) => `  Stop ${i + 1} (${s.type}): ${s.address}`).join("\n")
            : null;
        const lines = [
            `**Trip Cost Estimate: ${rt.origin_address} → ${rt.destination_address}**`,
            stopLines ? `Multi-stop route (${rt.stop_count} stops):\n${stopLines}` : null,
            `Route: ${rt.distance_km.toFixed(1)} km · ~${rt.duration_hrs.toFixed(1)} hrs drive`,
            ``,
            `Cost breakdown:`,
            `• Fuel:        $${c.fuel.toFixed(2)}`,
            `• Maintenance: $${c.maintenance.toFixed(2)}`,
            `• Insurance:   $${c.insurance.toFixed(2)}`,
            `• Driver:      $${c.driver.toFixed(2)}`,
            `• Total Cost:  $${c.total.toFixed(2)}`,
            `• Suggested Rate (${c.margin_pct}% margin): $${c.suggested_rate.toFixed(2)}`,
            ``,
            `Truck: ${r.truck.name}${r.truck.license_plate ? " (" + r.truck.license_plate + ")" : ""}`,
            ``,
            `Please review this estimate — should I adjust the margin, add accessorials, or compare against similar past loads?`,
        ].filter(l => l !== null).join("\n");

        this.state.estimatorOpen = false;
        await this.setChatMode("logistics_estimate");
        this.state.selectedTruckId = this.state.estimatorTruckId;
        this.state.input = lines;
    }

    async loadChatLimits() {
        try {
            const limits = await this.orm.call(
                "prema.ai.settings", "get_chat_limits", []);
            if (limits) {
                this.state.chatLimits = limits;
            }
        } catch (e) {
            console.error("Failed to load chat limits:", e);
        }
    }

    // ── File attachment ────────────────────────────────────────────

    triggerFileUpload() {
        const inp = this.fileInputRef.el;
        if (inp) {
            inp.setAttribute("multiple", "multiple");
            inp.click();
        }
    }

    async onFileSelected(ev) {
        const files = ev.target.files;
        if (!files || !files.length || !this.state.activeSessionId) return;
        await this._processFiles(files);
        ev.target.value = "";
    }

    async _processFiles(files) {
        const limits = this.state.chatLimits;
        const _isImage = (f) => f.type.startsWith("image/");
        const _sizeMb = (f) => f.size / (1024 * 1024);
        const _ext = (f) => "." + (f.name.split(".").pop() || "").toLowerCase();
        const allowedExts = (limits.allowed_file_types || "")
            .split(",").map(e => e.trim().toLowerCase()).filter(Boolean);

        let currentImages = this.state.pendingFiles.filter(f => (f.mimetype || "").startsWith("image/")).length;
        let currentSizeMb = this.state.pendingFiles.reduce((s, f) => s + (f.sizeMb || 0), 0);

        for (const file of files) {
            const ext = _ext(file);
            const sizeMb = _sizeMb(file);
            const isImg = _isImage(file);

            if (allowedExts.length && !allowedExts.includes(ext)) {
                this.state.errorMsg = `File type ${ext} is not allowed. Allowed: ${limits.allowed_file_types}`;
                continue;
            }
            if (this.state.pendingFiles.length >= (limits.max_files_per_chat || 5)) {
                this.state.errorMsg = `Maximum ${limits.max_files_per_chat} files per message.`;
                break;
            }
            if (isImg && currentImages >= (limits.max_images_per_chat || 3)) {
                this.state.errorMsg = `Maximum ${limits.max_images_per_chat} images per message.`;
                continue;
            }
            if (currentSizeMb + sizeMb > (limits.max_total_upload_mb || 50)) {
                this.state.errorMsg = `Total upload size exceeds ${limits.max_total_upload_mb} MB limit.`;
                break;
            }

            try {
                const b64 = await this._fileToBase64(file);
                this.state.pendingFiles = [
                    ...this.state.pendingFiles,
                    { name: file.name, b64, mimetype: file.type, sizeMb },
                ];
                if (isImg) currentImages++;
                currentSizeMb += sizeMb;
            } catch (e) {
                this.state.errorMsg = `Failed to read ${file.name}`;
            }
        }
    }

    removeFile(index) {
        this.state.pendingFiles = this.state.pendingFiles.filter((_, i) => i !== index);
    }

    _fileToBase64(file) {
        return new Promise((res, rej) => {
            const r = new FileReader();
            r.onload = () => res(r.result.split(",")[1]);
            r.onerror = () => rej(new Error("Read failed"));
            r.readAsDataURL(file);
        });
    }

    // ── Voice recording via Whisper ────────────────────────────────

    async toggleRecording() {
        if (this.state.isRecording) {
            this._stopRecording();
        } else {
            await this._startRecording();
        }
    }

    async _startRecording() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
            this._audioChunks = [];

            // Use mp4 if supported (better Android compat), fallback to webm
            let mimeType = "audio/webm";
            if (typeof MediaRecorder !== "undefined") {
                if (MediaRecorder.isTypeSupported("audio/mp4")) {
                    mimeType = "audio/mp4";
                } else if (MediaRecorder.isTypeSupported("audio/webm;codecs=opus")) {
                    mimeType = "audio/webm;codecs=opus";
                } else if (MediaRecorder.isTypeSupported("audio/webm")) {
                    mimeType = "audio/webm";
                }
            }

            this._mediaRecorder = new MediaRecorder(stream, { mimeType });
            this._mediaRecorder.ondataavailable = (e) => {
                if (e.data.size > 0) this._audioChunks.push(e.data);
            };
            this._mediaRecorder.onstop = () => {
                stream.getTracks().forEach(t => t.stop());
                this._processAudio(mimeType);
            };
            this._mediaRecorder.start();
            this.state.isRecording = true;
        } catch (e) {
            this.state.errorMsg = "Microphone access denied or not available.";
            console.error("Mic error:", e);
        }
    }

    _stopRecording() {
        if (this._mediaRecorder && this._mediaRecorder.state !== "inactive") {
            this._mediaRecorder.stop();
        }
        this.state.isRecording = false;
    }

    async _processAudio(mimeType) {
        if (!this._audioChunks.length) return;
        this.state.isLoading = true;
        this.state.errorMsg = null;

        try {
            const blob = new Blob(this._audioChunks, { type: mimeType });
            const b64 = await this._blobToBase64(blob);

            const result = await this.orm.call(
                "prema.ai.session", "transcribe_audio",
                [b64, mimeType]);

            if (result.error) {
                this.state.errorMsg = "Voice error: " + result.error;
            } else if (result.text) {
                this.state.input = (this.state.input || "") +
                    (this.state.input ? " " : "") + result.text;
            }
        } catch (e) {
            this.state.errorMsg = "Transcription failed: " + e.message;
        } finally {
            this.state.isLoading = false;
            this._audioChunks = [];
        }
    }

    _blobToBase64(blob) {
        return new Promise((res, rej) => {
            const r = new FileReader();
            r.onload = () => res(r.result.split(",")[1]);
            r.onerror = () => rej(new Error("Audio read failed"));
            r.readAsDataURL(blob);
        });
    }

    // ── Send message ───────────────────────────────────────────────

    _startElapsedTimer() {
        this._stopElapsedTimer();
        this._elapsedTimer = setInterval(() => {
            this.state.elapsed += 1;
        }, 1000);
    }

    _stopElapsedTimer() {
        if (this._elapsedTimer) {
            clearInterval(this._elapsedTimer);
            this._elapsedTimer = null;
        }
    }

    async sendMessage() {
        const text = (this.state.input || "").trim();
        const hasFiles = this.state.pendingFiles.length > 0;
        if (!text && !hasFiles) return;
        if (!this.state.activeSessionId || this.state.isLoading) return;

        this.state.errorMsg = null;
        // Clear any existing pending action when new message is sent
        this.state.pendingAction = null;

        let displayMsg = text || "";
        if (hasFiles) {
            const names = this.state.pendingFiles.map(f =>
                `\u{1F4CE} ${f.name}`).join("\n");
            displayMsg = (text ? text + "\n" : "") + names;
        }

        this.state.messages = [
            ...this.state.messages,
            { id: Date.now(), role: "user", content: displayMsg },
        ];

        const userText = text;
        const filesToSend = hasFiles ? [...this.state.pendingFiles] : null;
        this.state.input = "";
        this.state.pendingFiles = [];
        this.state.isLoading = true;
        this.state.elapsed = 0;
        this._startElapsedTimer();
        this._scrollToBottom();

        try {
            let attachmentData = null;
            if (filesToSend && filesToSend.length > 0) {
                attachmentData = filesToSend.map(f => ({
                    filename: f.name,
                    file_b64: f.b64,
                    mimetype: f.mimetype,
                }));
            }

            const result = await this.orm.call(
                "prema.ai.session", "send_message",
                [this.state.activeSessionId, userText || "", attachmentData],
                {
                    chat_mode: this.state.chatMode || "standard",
                    truck_id: this.state.chatMode === "logistics_estimate"
                        ? (this.state.selectedTruckId || false)
                        : false,
                });

            // Handle structured response (dict with reply + pending_action)
            if (result && typeof result === "object" && result.pending_action) {
                this.state.pendingAction = result.pending_action;
            } else {
                this.state.pendingAction = null;
            }

            // Reload messages from server (includes the new assistant reply)
            this.state.messages = await this.orm.call(
                "prema.ai.message", "search_read",
                [[["session_id", "=", this.state.activeSessionId]],
                 ["role", "content"]]);

        } catch (e) {
            console.error(e);
            this.state.errorMsg = `Failed: ${e.message || e.data?.message || "Unknown error"}`;
            // Re-sync from server — send_message persists the user message
            // before the RPC failed, so slice(0,-1) would desync the UI
            try {
                this.state.messages = await this.orm.call(
                    "prema.ai.message", "search_read",
                    [[["session_id", "=", this.state.activeSessionId]],
                     ["role", "content"]]);
            } catch (e2) {
                console.error(e2);
                this.state.messages = this.state.messages.slice(0, -1);
            }
        } finally {
            this._stopElapsedTimer();
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

    async handlePaste(ev) {
        const items = ev.clipboardData && ev.clipboardData.items;
        if (!items) return;

        const imageItems = Array.from(items).filter(i => i.type.startsWith("image/"));
        if (!imageItems.length) return;

        ev.preventDefault();

        const limits = this.state.chatLimits;
        let currentImages = this.state.pendingFiles.filter(f => (f.mimetype || "").startsWith("image/")).length;
        let currentSizeMb = this.state.pendingFiles.reduce((s, f) => s + (f.sizeMb || 0), 0);

        for (const item of imageItems) {
            if (this.state.pendingFiles.length >= (limits.max_files_per_chat || 5)) {
                this.state.errorMsg = `Maximum ${limits.max_files_per_chat} files per message.`;
                break;
            }
            if (currentImages >= (limits.max_images_per_chat || 3)) {
                this.state.errorMsg = `Maximum ${limits.max_images_per_chat} images per message.`;
                break;
            }

            const file = item.getAsFile();
            if (!file) continue;

            const sizeMb = file.size / (1024 * 1024);
            if (currentSizeMb + sizeMb > (limits.max_total_upload_mb || 50)) {
                this.state.errorMsg = `Total upload size exceeds ${limits.max_total_upload_mb} MB limit.`;
                break;
            }

            const ext = item.type.split("/")[1] || "png";
            const filename = `screenshot-${Date.now()}.${ext}`;

            try {
                const b64 = await this._fileToBase64(file);
                this.state.pendingFiles = [
                    ...this.state.pendingFiles,
                    { name: filename, b64, mimetype: item.type, sizeMb },
                ];
                currentImages++;
                currentSizeMb += sizeMb;
                this.state.errorMsg = null;
            } catch (e) {
                this.state.errorMsg = "Failed to read pasted image.";
            }
        }
    }

    // ── Drag & Drop ────────────────────────────────────────────────

    handleDragOver(ev) {
        ev.preventDefault();
        ev.dataTransfer.dropEffect = "copy";
        if (!this.state.isDragOver) this.state.isDragOver = true;
    }

    handleDragLeave(ev) {
        if (!ev.currentTarget.contains(ev.relatedTarget)) {
            this.state.isDragOver = false;
        }
    }

    async handleDrop(ev) {
        ev.preventDefault();
        this.state.isDragOver = false;
        const files = ev.dataTransfer && ev.dataTransfer.files;
        if (!files || !files.length || !this.state.activeSessionId) return;
        await this._processFiles(files);
    }

    // ── Pending action handlers ────────────────────────────────────

    async confirmCreateLeads() {
        if (!this.state.activeSessionId || this.state.isConfirming) return;
        this.state.isConfirming = true;
        this.state.errorMsg = null;

        try {
            const result = await this.orm.call(
                "prema.ai.session", "confirm_create_leads",
                [this.state.activeSessionId]);

            this.state.pendingAction = result.pending_action || null;

            if (result.error) {
                this.state.errorMsg = result.error;
            } else {
                // Reload messages to show confirmation message
                this.state.messages = await this.orm.call(
                    "prema.ai.message", "search_read",
                    [[["session_id", "=", this.state.activeSessionId]],
                     ["role", "content"]]);
                this._scrollToBottom();
            }
        } catch (e) {
            console.error(e);
            this.state.errorMsg = `Lead creation failed: ${e.message || "Unknown error"}`;
        } finally {
            this.state.isConfirming = false;
        }
    }

    async createSingleLead(pendingKey) {
        if (!this.state.activeSessionId || this.state.isConfirming) return;
        this.state.isConfirming = true;
        this.state.errorMsg = null;

        try {
            const result = await this.orm.call(
                "prema.ai.session", "confirm_create_single_lead",
                [this.state.activeSessionId, pendingKey]
            );
            if (result.error) {
                this.state.errorMsg = result.error;
            }
            this.state.pendingAction = result.pending_action || null;
            this.state.messages = await this.orm.call(
                "prema.ai.message", "search_read",
                [[["session_id", "=", this.state.activeSessionId]],
                 ["role", "content"]]
            );
            this._scrollToBottom();
        } catch (e) {
            console.error(e);
            this.state.errorMsg = `Lead import failed: ${e.message || "Unknown error"}`;
        } finally {
            this.state.isConfirming = false;
        }
    }

    async cancelPendingAction() {
        if (!this.state.activeSessionId) return;
        this.state.isConfirming = true;

        try {
            const result = await this.orm.call(
                "prema.ai.session", "cancel_pending_action",
                [this.state.activeSessionId]);

            this.state.pendingAction = result.pending_action || null;

            this.state.messages = await this.orm.call(
                "prema.ai.message", "search_read",
                [[["session_id", "=", this.state.activeSessionId]],
                 ["role", "content"]]);
            this._scrollToBottom();
        } catch (e) {
            console.error(e);
            this.state.pendingAction = null;
        } finally {
            this.state.isConfirming = false;
        }
    }

    // ── Message rendering helpers ──────────────────────────────────

    formatLeadLocation(lead) {
        if (!lead) return "";
        return [lead.city, lead.state]
            .filter((value) => value && String(value).trim())
            .join(", ");
    }

    formatMessage(content) {
        if (!content) return "";
        let s = content;

        // PHASE 1: Normalise HTML the AI might emit → Markdown/text
        s = s
            .replace(/<br\s*\/?>/gi, "\n")
            .replace(/<\/div>/gi, "\n").replace(/<div[^>]*>/gi, "")
            .replace(/<\/p>/gi, "\n").replace(/<p[^>]*>/gi, "")
            .replace(/<\/h[1-6]>/gi, "\n").replace(/<h([1-6])[^>]*>/gi, "\n## ")
            .replace(/<\/li>/gi, "\n").replace(/<li[^>]*>/gi, "- ")
            .replace(/<\/?(ul|ol)[^>]*>/gi, "\n")
            .replace(/<\/?strong[^>]*>/gi, "**").replace(/<\/?b(\s[^>]*)?>/ , "**")
            .replace(/<\/?em[^>]*>/gi, "_").replace(/<\/?i(\s[^>]*)?>/, "_")
            .replace(/<\/?code[^>]*>/gi, "`")
            .replace(/<hr[^>]*>/gi, "\n---\n")
            .replace(/<a[^>]+href="([^"]*)"[^>]*>([^<]*)<\/a>/gi, "[$2]($1)")
            .replace(/<[^>]+>/g, "");

        // PHASE 2: Decode HTML entities
        s = s
            .replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">")
            .replace(/&nbsp;/g, " ").replace(/&quot;/g, '"').replace(/&#39;/g, "'")
            .replace(/&mdash;/g, "—").replace(/&ndash;/g, "–");

        // Clean up excess blank lines
        s = s.replace(/\n{3,}/g, "\n\n").trim();

        // PHASE 3: Escape special chars to prevent injection
        s = s
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;");

        // PHASE 4: Render Markdown

        // ## / ### headings
        s = s.replace(/^#{1,3}\s+(.+)$/gm,
            '<span class="o_ai_heading">$1</span>');

        // **bold**
        s = s.replace(/\*\*([^*\n]+)\*\*/g, "<strong>$1</strong>");

        // *italic* (not adjacent to another *)
        s = s.replace(/(?<!\*)\*([^*\n]+)\*(?!\*)/g, "<em>$1</em>");
        // _italic_
        s = s.replace(/\b_([^_\n]+)_\b/g, "<em>$1</em>");

        // `inline code`
        s = s.replace(/`([^`\n]+)`/g, '<code class="o_ai_code">$1</code>');

        // --- horizontal rule
        s = s.replace(/^---$/gm, '<hr class="o_ai_hr">');

        // Numbered list items: "1. text"
        s = s.replace(/^[ \t]*(\d+)\.\s+(.+)$/gm,
            '<span class="o_ai_li"><span class="o_ai_li_num">$1.</span> $2</span>');

        // Bullet list items: "- text" / "• text" / "* text"
        s = s.replace(/^[ \t]*[-•*]\s+(.+)$/gm,
            '<span class="o_ai_li"><span class="o_ai_li_dot">&#x2022;</span> $1</span>');

        // [label](url) links
        s = s.replace(
            /\[([^\]]+)\]\((https?:\/\/[^)]+)\)/g,
            '<a href="$2" target="_blank" rel="noopener noreferrer" class="o_ai_link">$1</a>'
        );

        // Bare URLs
        s = s.replace(
            /(?<!href=")(https?:\/\/[^\s&lt;&amp;"]+)/g,
            '<a href="$1" target="_blank" rel="noopener noreferrer" class="o_ai_link">$1</a>'
        );

        // PHASE 5: Newlines → <br>
        s = s.replace(/\n\n/g, "<br><br>");
        s = s.replace(/\n/g, "<br>");

        // OWL v2: t-out only renders HTML when the value is a markup() object.
        // A plain string is always escaped. Wrap here so the template renders correctly.
        return markup(s);
    }

    _scrollToBottom() {
        setTimeout(() => {
            const el = this.messagesRef.el;
            if (el) el.scrollTop = el.scrollHeight;
        }, 50);
    }
}

registry.category("actions").add("prema_ai_console", AIConsole);
