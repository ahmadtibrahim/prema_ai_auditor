/** @odoo-module **/

import { Component, useState } from "@odoo/owl";

export class AIChatUpload extends Component {
    setup() {
        this.state = useState({
            dragging: false,
            uploading: false,
            files: [],
            done: 0,
            total: 0,
        });
    }

    onDragOver(ev) {
        ev.preventDefault();
        this.state.dragging = true;
    }

    onDragLeave(ev) {
        ev.preventDefault();
        this.state.dragging = false;
    }

    async onDrop(ev) {
        ev.preventDefault();
        this.state.dragging = false;
        const files = ev.dataTransfer.files;
        await this.uploadFiles(files);
    }

    async onFileSelect(ev) {
        const files = ev.target.files;
        await this.uploadFiles(files);
        ev.target.value = "";
    }

    onAttachClick() {
        this.refs.fileInput.click();
    }

    async uploadFiles(fileList) {
        if (!fileList || !fileList.length || !this.props.sessionId) {
            return;
        }

        this.state.uploading = true;
        this.state.total = fileList.length;
        this.state.done = 0;
        this.state.files = [];

        for (const file of fileList) {
            this.state.files.push({ name: file.name, progress: 0, status: "uploading" });
            const index = this.state.files.length - 1;

            const formData = new FormData();
            formData.append("file", file);
            formData.append("session_id", this.props.sessionId);

            await new Promise((resolve, reject) => {
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "/prema_ai/upload_multi");
                xhr.withCredentials = true;

                xhr.upload.onprogress = (event) => {
                    if (event.lengthComputable) {
                        this.state.files[index].progress = Math.round((event.loaded / event.total) * 100);
                    }
                };

                xhr.onload = () => {
                    if (xhr.status >= 200 && xhr.status < 300) {
                        this.state.files[index].progress = 100;
                        this.state.files[index].status = "done";
                        this.state.done += 1;
                        resolve();
                        return;
                    }
                    this.state.files[index].status = "error";
                    reject(new Error(xhr.responseText || "Upload failed"));
                };

                xhr.onerror = () => {
                    this.state.files[index].status = "error";
                    reject(new Error("Network error"));
                };

                xhr.send(formData);
            });
        }

        this.state.uploading = false;
        if (this.props.onUploaded) {
            this.props.onUploaded();
        }
    }
}

AIChatUpload.template = "prema_ai_auditor.AIChatUpload";
