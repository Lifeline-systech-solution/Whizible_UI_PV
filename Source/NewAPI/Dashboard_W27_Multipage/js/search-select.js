/* Shared searchable single-select for Analytics multipage filters.
   Panels are appended to document.body with position:fixed so they are not
   clipped by .widget / .w-body / .copilot overflow:hidden.
*/
/* Shared searchable select (Supports Single & Multi-select) */
(function (global) {
    "use strict";

    var state = { openKey: null, search: {}, activePanel: null, activeBtn: null };

    function esc(s) {
        return String(s == null ? "" : s).replace(/[&<>"]/g, function (c) {
            return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c];
        });
    }

    function normalizeOptions(options) {
        return (options || []).map(function (o) {
            if (o && typeof o === "object") return { value: String(o.value), label: String(o.label != null ? o.label : o.value) };
            return { value: String(o), label: String(o) };
        });
    }

    function removeFloatingPanels() {
        document.querySelectorAll(".ss-panel.ss-floating").forEach(function (p) {
            if (p.parentNode) p.parentNode.removeChild(p);
        });
        state.activePanel = null;
        state.activeBtn = null;
    }

    function positionPanel(panel, btn) {
        if (!panel || !btn) return;
        var r = btn.getBoundingClientRect();
        var width = Math.max(r.width, 220);
        var left = r.left;
        if (left + width > window.innerWidth - 8) left = Math.max(8, window.innerWidth - width - 8);
        var top = r.bottom + 4;
        panel.style.position = "fixed"; panel.style.left = left + "px"; panel.style.top = top + "px";
        panel.style.width = width + "px"; panel.style.minWidth = width + "px"; panel.style.right = "auto";
        panel.style.zIndex = "4000";
        requestAnimationFrame(function () {
            var pr = panel.getBoundingClientRect();
            if (pr.bottom > window.innerHeight - 8 && r.top > pr.height + 8) panel.style.top = Math.max(8, r.top - pr.height - 4) + "px";
        });
    }

    function closeAll() {
        state.openKey = null;
        removeFloatingPanels();
    }

    function openPanel(key, panel, btn) {
        closeAll();
        state.openKey = key; state.activePanel = panel; state.activeBtn = btn;
        panel.classList.add("ss-floating", "open");
        document.body.appendChild(panel);
        positionPanel(panel, btn);
    }

    function render(hostId, cfg) {
        var host = typeof hostId === "string" ? document.getElementById(hostId) : hostId;
        if (!host || !cfg) return;

        var key = cfg.key || (typeof hostId === "string" ? hostId : host.id || "ss");
        var isMulti = cfg.multiple === true;
        var options = normalizeOptions(cfg.options);
        var valueStr = cfg.value == null ? "" : String(cfg.value);
        var valuesArr = valueStr === "" ? [] : valueStr.split(",");

        var placeholder = cfg.placeholder || "Select";
        var searchPh = cfg.searchPlaceholder || ("Search " + placeholder.replace(/^Select\s+/i, "") + "...");

        var btnLabel = placeholder;
        if (isMulti) {
            var selectedLabels = options.filter(function (o) { return valuesArr.indexOf(o.value) > -1; }).map(function (o) { return o.label; });
            if (selectedLabels.length === 1) btnLabel = selectedLabels[0];
            else if (selectedLabels.length > 1) btnLabel = selectedLabels.length + " selected";
        } else {
            var selected = options.find(function (o) { return o.value === valueStr; });
            if (selected) btnLabel = selected.label;
        }

        var wasOpen = state.openKey === key;
        if (wasOpen) removeFloatingPanels();

        host.innerHTML = ""; host.classList.add("ss-host");
        var wrap = document.createElement("div"); wrap.className = "ss";

        var btn = document.createElement("button");
        btn.type = "button"; btn.className = "ss-btn" + ((isMulti ? valuesArr.length > 0 : valueStr !== "") ? "" : " ss-placeholder");
        btn.setAttribute("aria-haspopup", "listbox"); btn.setAttribute("aria-expanded", wasOpen ? "true" : "false");
        btn.innerHTML = "<span class=\"ss-btn-label\">" + esc(btnLabel) + "</span><span class=\"ss-chev\"><i class=\"fas fa-chevron-down\"></i></span>";

        function buildPanel() {
            var panel = document.createElement("div"); panel.className = "ss-panel"; panel.setAttribute("role", "listbox");
            panel.addEventListener("click", function (e) { e.stopPropagation(); });

            var search = document.createElement("input"); search.type = "text"; search.className = "ss-search";
            search.placeholder = searchPh; search.value = state.search[key] || ""; panel.appendChild(search);

            var rowsWrap = document.createElement("div"); rowsWrap.className = "ss-rows"; panel.appendChild(rowsWrap);
            var empty = document.createElement("div"); empty.className = "ss-empty"; empty.textContent = "No matches";
            empty.style.display = "none"; panel.appendChild(empty);

            function applyFilter() {
                var term = search.value.trim().toLowerCase(); var any = false;
                rowsWrap.querySelectorAll(".ss-row").forEach(function (row) {
                    var match = !term || row.dataset.label.indexOf(term) > -1;
                    row.style.display = match ? "" : "none"; if (match) any = true;
                });
                empty.style.display = any ? "none" : "block";
            }

            search.addEventListener("input", function () { state.search[key] = search.value; applyFilter(); });

            function addRow(val, label) {
                var isSelected = isMulti ? valuesArr.indexOf(String(val)) > -1 : String(valueStr) === String(val);
                var row = document.createElement("div");
                row.className = "ss-row" + (isSelected ? " selected" : "");
                row.dataset.label = String(label).toLowerCase(); row.dataset.value = val; row.setAttribute("role", "option");

                if (isMulti && val !== "") {
                    row.innerHTML = "<div style='display:flex; align-items:center;'><input type='checkbox' style='margin-right:8px; pointer-events:none;' " + (isSelected ? "checked" : "") + "><span>" + esc(label) + "</span></div>";
                } else {
                    row.textContent = label;
                }

                row.addEventListener("click", function (e) {
                    if (isMulti) {
                        e.stopPropagation();
                        if (val === "") valuesArr = []; // Clear
                        else {
                            var idx = valuesArr.indexOf(String(val));
                            if (idx > -1) valuesArr.splice(idx, 1);
                            else valuesArr.push(String(val));
                        }
                        var newVal = valuesArr.join(",");
                        if (typeof cfg.onChange === "function") cfg.onChange(newVal);
                        else render(host, Object.assign({}, cfg, { value: newVal }));
                    } else {
                        state.search[key] = ""; closeAll();
                        if (typeof cfg.onChange === "function") cfg.onChange(val);
                        else render(host, Object.assign({}, cfg, { value: val }));
                    }
                });
                rowsWrap.appendChild(row);
            }

            addRow("", placeholder.indexOf("Select") === 0 ? placeholder.replace(/^Select\s+/i, "All ") : "All");
            options.forEach(function (o) { addRow(o.value, o.label); });
            applyFilter();

            var actions = document.createElement("div"); actions.className = "ss-actions";
            var clearBtn = document.createElement("button"); clearBtn.type = "button"; clearBtn.textContent = "Clear";
            clearBtn.addEventListener("click", function () {
                state.search[key] = ""; closeAll();
                if (typeof cfg.onChange === "function") cfg.onChange("");
                else render(host, Object.assign({}, cfg, { value: "" }));
            });
            var closeBtn = document.createElement("button"); closeBtn.type = "button"; closeBtn.textContent = "Close";
            closeBtn.addEventListener("click", function () { closeAll(); btn.setAttribute("aria-expanded", "false"); });
            actions.appendChild(clearBtn); actions.appendChild(closeBtn); panel.appendChild(actions);
            panel.__ssSearch = search; return panel;
        }

        btn.addEventListener("click", function (e) {
            e.stopPropagation();
            if (state.openKey === key) { closeAll(); btn.setAttribute("aria-expanded", "false"); return; }
            var panel = buildPanel(); openPanel(key, panel, btn); btn.setAttribute("aria-expanded", "true");
            setTimeout(function () { try { panel.__ssSearch && panel.__ssSearch.focus(); } catch (err) { } }, 0);
        });

        wrap.appendChild(btn); host.appendChild(wrap);
        if (wasOpen) {
            var panel = buildPanel(); openPanel(key, panel, btn);
            setTimeout(function () { try { panel.__ssSearch && panel.__ssSearch.focus(); } catch (err) { } }, 0);
        }
    }

    if (!global.__ssDocClickBound) {
        global.__ssDocClickBound = true;
        document.addEventListener("click", function () { closeAll(); });
        window.addEventListener("resize", function () { if (state.activePanel && state.activeBtn) positionPanel(state.activePanel, state.activeBtn); });
        window.addEventListener("scroll", function () { if (state.activePanel && state.activeBtn) positionPanel(state.activePanel, state.activeBtn); }, true);
    }

    global.SearchSelect = { render: render, closeAll: closeAll };
})(window);
