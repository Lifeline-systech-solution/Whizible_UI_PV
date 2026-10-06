<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_AnalyticsCXO_Dashboard.aspx.vb" Inherits="Whizible.PM_AnalyticsCXO_Dashboard" %>

<!DOCTYPE html>
<%CommonFunctions.General.PlotPageHeadTag("Whizible - CXO Dashboard")%>
<html lang="en" data-theme="light">
<head runat="server">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Whizible - CXO Dashboard</title>


<script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/v4-shims.min.css">
<!-- Added By Madhuri.K On 24-09-2026 -->
<link rel="stylesheet" href="css/styles.css?v=53">
<link rel="stylesheet" href="css/cxo-pva.css?v=92">
<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
<style type="text/css">
  /* Full-page white loader — hide UI until data is fully bound */
  body.analytics-pva .loader-overlay{
    position:fixed; top:0; left:0; right:0; bottom:0;
    width:100%; height:100%;
    background-color:#fff;
    z-index:3000;
    display:none;
  }
    .exec-base-note {
        white-space: normal !important;
    }
  body.analytics-pva .loader-overlay .loader{
    position:absolute; top:50%; left:50%; width:100px; height:100px;
    margin:-50px 0 0 -50px;
    background:url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
  }
  body.analytics-pva .preloader{
    position:fixed; top:0; left:0; right:0; bottom:0;
    width:100%; height:100%;
    margin:0;
    background-color:#fff;
    background-image:url(../../../Whizible2.0-new/dist/img/loading.gif);
    background-repeat:no-repeat;
    background-position:center center;
    z-index:3100;
  }
  /* Added by Aditya J. on 21-09-2026 Cost & budget variance by project */
  body.analytics-pva .cxo-budget-legend{display:flex;justify-content:center;align-items:center;gap:6px;font-size:12px;color:#697589;margin:0 0 6px;}
  body.analytics-pva .cxo-budget-legend-dot{width:12px;height:12px;border-radius:50%;background:#139f98;display:inline-block;}
  body.analytics-pva .cxo-budget-note{font-size:11px;color:#7a8699;padding:6px 2px 0;}
  body.analytics-pva #wVar .chartbox{position:relative;}
  /* Added by Vikas T on 23-09-2026 — extra drill columns get a horizontal scrollbar */
  body.analytics-pva .overlay .m-body .grid-scroll,
  body.analytics-pva .overlay .m-body .scroll-x{
    overflow-x:auto;
    overflow-y:auto;
    max-width:100%;
  }
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl{
    width:max-content;
    min-width:100%;
  }
  /* Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects column spacing */
  body.analytics-pva .overlay .m-body .grid-scroll.tbl-fill,
  body.analytics-pva .overlay .m-body .scroll-x.tbl-fill{
    width:100%;
    display:block;
    box-sizing:border-box;
    overflow-x:hidden;
    border:1px solid #e5e7eb;
    border-radius:6px;
    background:#fff;
  }
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols{
    width:100%;
    min-width:100%;
    table-layout:fixed;
    border-collapse:collapse;
    background:#fff;
  }
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols thead,
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols thead tr,
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols thead th{
    background:#f8f9fa;
    border-bottom:1px solid #e5e7eb;
  }
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols td{
    overflow:hidden;
    text-overflow:ellipsis;
    border-bottom:1px solid #eef1f4;
  }
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols th.drill-col-num,
  body.analytics-pva .overlay .m-body .grid-scroll table.tbl.tbl-cols td.drill-col-num{
    text-align:center;
  }
  /* End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects column spacing */
  /* Commented and Added By Vyankat b. on 24th Sep 2026 for CSAT drill star rating */
  body.analytics-pva .csat-stars{
    display:inline-flex;
    align-items:center;
    gap:1px;
    font-size:13px;
    line-height:1;
    color:#D1D5DB;
    letter-spacing:0;
    white-space:nowrap;
  }
  body.analytics-pva .csat-stars .on{ color:#CA8A04; }
  body.analytics-pva .csat-stars-na{
    color:#8A8886;
    font-size:12px;
  }
  /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for CSAT drill star rating */
  /* Commented and Added By Vyankat b. on 28th Sep 2026 for Helpdesk SLA Status drill */
  body.analytics-pva .csat-sla-remain{
    color:#c62828;
    font-weight:600;
    white-space:nowrap;
  }
  body.analytics-pva .csat-sla-link{
    color:#1e40af;
    font-weight:600;
    text-decoration:underline;
    cursor:pointer;
  }
  /* End of Commented and Added By Vyankat b. on 28th Sep 2026 for Helpdesk SLA Status drill */
</style>
</head>
<body data-page="exec" class="analytics-pva">
<form id="form1" runat="server">
<div id="AnalyticsPreloader" class="preloader" aria-label="Loading"></div>
<div class="loader-overlay" id="loaderOverlay" style="display:none;"><div class="loader"></div></div>
<div class="bgwhite" id="AnalyticsWrapper" style="display:none;">
  <!-- Page header aligned with Plan_VS_Actual_Dashboard.aspx / exec.html -->
  <div class="page-header-section" style="background:white;">
    <div class="graybg" style="padding:0.4rem 1rem; margin-left:0;">
      <h2 style="color:#1e40af; font-weight:600; font-size:18px; margin:0 0 0.25rem 0; display:flex; align-items:center;">
        <i class="fas fa-chart-pie" style="color:#1e40af; font-size:1.5rem; margin-right:0.75rem;"></i>
        CXO Dashboard
      </h2>
      <p style="color:#6b7280; margin:0;">Executive Overview &middot; Revenue, Margin, Utilization &amp; Portfolio Health</p>
    </div>
  </div>

  <div class="app no-sidebar">
    <div class="main">
      <!-- Global filters — same markup as exec.html (app.js Save View / role depend on these ids) -->
      <div class="filterbar" id="filterbar">
        <div class="filterbar-date">
          <button class="datebtn" id="dateBtn" type="button">
            <i class="far fa-calendar-alt"></i>
            <span id="dateLabel">Current Quarter</span>
            <small id="dateRangeTxt">Loading...</small>
            <i class="fas fa-chevron-down" style="font-size:10px;margin-left:4px;"></i>
          </button>
          <span class="compare-tag" id="compareTag">vs previous period</span>
          <span class="filterbar-spacer"></span>
        <%--  <div class="exec-role-wrap">
            <button type="button" class="role-pill exec-role-pill" id="execRoleBtn" title="Switch persona">
              <span id="roleLabel">Role</span>
              <i class="fas fa-chevron-down"></i>
            </button>
            <select id="roleSel" hidden aria-hidden="true" tabindex="-1"></select>
          </div>--%>
        </div>
        <div class="filterbar-row">
          <span id="chips"></span>
          <%-- exec.html: More filters hidden. Keep id so bindTopFilterClear still works. --%>
          <button class="chipbtn" type="button" id="btnMoreFilters" title="More dimensions" style="display:none;" hidden>
            <i class="fas fa-plus"></i> More filters
          </button>
          <button class="filter-clear" id="clearFilters" type="button">Reset all</button>
          <span class="filterbar-spacer"></span>
          <button class="ghostbtn" type="button" id="execSaveViewBtn" title="Save the current filters as a view">
            <i class="far fa-save"></i> Save View
          </button>
          <button class="ghostbtn" type="button" id="execMyViewsBtn" title="Open your saved views">
            <i class="fas fa-star"></i> My Views
          </button>
        </div>
      </div>

      <main>
        <section class="content active" id="page-exec"></section>
      </main>
    </div>
  </div>
</div>

<!-- Drill modal -->
<div class="overlay" id="overlay">
  <div class="modal" role="dialog" aria-modal="true">
    <div class="m-hd">
      <div style="flex:1">
        <h3 id="mTitle">Drill-down</h3>
        <div class="m-crumbs" id="mCrumbs"></div>
      </div>
      <button class="icon-btn" type="button" id="btnDrillExport" onclick="exportDrillMenu(event)" title="Export / Share"><i class="fas fa-share-alt"></i></button>
      <button class="icon-btn" type="button" onclick="closeModal()" title="Close"><i class="fas fa-times"></i></button>
    </div>
    <div class="m-filtered-by" id="mFilters" hidden aria-label="Filtered by"></div>
    <div class="m-body" id="mBody"></div>
  </div>
</div>

<!-- AI Copilot -->
<aside class="copilot" id="copilot" aria-label="AI Copilot">
  <div class="cp-hd">
    <div class="logo-mark"><img src="../../../Whizible2.0-new/dist/img/Whizkidlogo.png" alt="Whizkid"></div>
    <div style="flex:1">
      <b style="font-size:13px">Whizible Copilot</b>
      <div style="font-size:11px;color:var(--muted)">Grounded in your filtered data</div>
    </div>
    <button class="icon-btn" type="button" onclick="document.getElementById('copilot').classList.remove('open')"><i class="fas fa-times"></i></button>
  </div>
  <div class="cp-log" id="cpLog"></div>
  <div class="cp-quick">
    <button type="button" onclick="askCopilot('Why did profitability drop this quarter?')">Why did profitability drop?</button>
    <button type="button" onclick="askCopilot('Show projects at risk in the Banking portfolio')">At-risk in Banking</button>
    <button type="button" onclick="askCopilot('Where is my bench and what should I do with it?')">Bench strategy</button>
    <button type="button" onclick="askCopilot('Forecast revenue for next quarter')">Revenue forecast</button>
  </div>
  <div class="cp-in">
    <input id="cpInput" placeholder="Ask in natural language...">
    <button type="button" onclick="sendCopilot()">Send</button>
  </div>
</aside>

<!-- Save View modal (from exec.html) -->
<div class="exec-save-modal-wrap" id="execSaveModal" hidden>
  <div class="exec-save-modal" role="dialog" aria-modal="true" aria-labelledby="execSaveModalTitle">
    <div class="exec-oc-hd">
      <h5 class="exec-oc-title" id="execSaveModalTitle">Save View</h5>
      <button type="button" class="btn-close" id="execSaveModalClose" aria-label="Close" title="Close"></button>
    </div>
    <div class="exec-save-modal-body">
      <label class="exec-oc-label" for="execViewName">Filter View Name</label>
      <input type="text" class="form-control exec-oc-input" id="execViewName" maxlength="80" placeholder="Enter a name for this view" autocomplete="off">
      <div class="exec-applied" id="execAppliedFilters"></div>
      <label class="exec-oc-check" for="execViewSetDefault">
        <input type="checkbox" id="execViewSetDefault">
        <span>Set as Default</span>
      </label>
      <div class="exec-oc-actions">
        <button type="button" class="ghostbtn exec-oc-primary" id="execViewSaveBtn">Save</button>
        <button type="button" class="ghostbtn" id="execSaveModalCancel">Cancel</button>
      </div>
    </div>
  </div>
</div>

<!-- Delete saved filter confirm — DipalI v On 10th sep 2026 -->
<div class="exec-save-modal-wrap" id="execDeleteFilterModal" hidden>
  <div class="exec-save-modal exec-confirm-modal" role="dialog" aria-modal="true" aria-labelledby="execDeleteFilterTitle">
    <div class="exec-oc-hd">
      <h5 class="exec-oc-title" id="execDeleteFilterTitle">Delete filter</h5>
      <button type="button" class="btn-close" id="execDeleteFilterClose" aria-label="Close" title="Close"></button>
    </div>
    <div class="exec-save-modal-body">
      <p class="exec-confirm-msg" id="execDeleteFilterMsg">Do you want to delete this filter?</p>
      <div class="exec-oc-actions">
        <button type="button" class="ghostbtn exec-oc-primary" id="execDeleteFilterYes">Yes</button>
        <button type="button" class="ghostbtn" id="execDeleteFilterNo">No</button>
      </div>
    </div>
  </div>
</div>

<!-- My Views list (from exec.html) -->
<div class="offcanvas offcanvas-end exec-view-offcanvas" tabindex="-1" id="execSavedViewsOffcanvas" aria-labelledby="execSavedViewsOffcanvasLabel">
  <div class="exec-oc-hd">
    <div>
      <h5 class="exec-oc-title" id="execSavedViewsOffcanvasLabel">My Views</h5>
      <p class="exec-oc-sub">CXO Dashboard</p>
    </div>
    <button type="button" class="btn-close" data-exec-oc-close="execSavedViewsOffcanvas" aria-label="Close" title="Close"></button>
  </div>
  <div class="offcanvas-body exec-oc-body">
    <p class="exec-oc-hint">Your views are private to this login. Click a name to apply, or Edit in this list.</p>
    <div id="execSavedViewsList"></div>
  </div>
</div>
<div class="exec-oc-backdrop" id="execViewBackdrop" hidden></div>

<div class="toasts" id="toasts"></div>
<script>
    /* DipalI v On 9th sep 2026 — Dashboard filter API */
    var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
  if (strUrl && strUrl.charAt(strUrl.length - 1) === '/') strUrl = strUrl.slice(0, -1);
  var DASHBOARD_ID = 21036;
  var DEFAULT_DATE_OPTION = 'Current Quarter';
  var SessionEmployeeID = '<%=If(Session("intUserID") Is Nothing, "", Session("intUserID").ToString())%>';
  window.strUrl = strUrl;
  window.DASHBOARD_ID = DASHBOARD_ID;
  window.SessionEmployeeID = SessionEmployeeID;
  window.DEFAULT_DATE_OPTION = DEFAULT_DATE_OPTION;
  /* Same controller as Resource_Timesheet_Dash — app.js calendar / filter APIs. */
  window.FILTER_API_CONTROLLER = 'PM_AnalyticsCXO_Dashboard';
</script>
<!-- Charts / greeting / Save View / calendar (DateFilter) from app.js. CXO owns shell boot (SKIP_APP_JS_BOOT). -->
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script>window.SKIP_APP_JS_BOOT = true; window.ALLOW_DATE_FILTER_CUSTOM = true; window.ALLOW_DATE_FILTER_COMPARE = true;</script>
<script src="js/app.js?v=105"></script>
<script>
    /* =====================================================================
       Date filter options + KPI bag — PM_AnalyticsCXO_Dashboard.aspx
       DipalI v On 9th sep 2026
       Calendar UI lives in js/app.js only (openDatePicker / DateFilter).
       Added by Dipali V. on 01-10-2026 — aspx calendar block removed; shared window.DateFilter.
       ===================================================================== */

    var DateFilter = window.DateFilter;
    if (!DateFilter) {
        DateFilter = {
            dateOptions: [],
            comparisonOptions: [],
            filterOptionsLoaded: false,
            dateRangeCache: {},
            compareRangeCache: {},
            selectedFilterId: null,
            selectedFilterName: DEFAULT_DATE_OPTION,
            selectedComparisonId: null,
            selectedComparisonName: '',
            compare: false,
            startDate: null,
            endDate: null,
            previousStart: null,
            previousEnd: null,
            lastRange: null
        };
        window.DateFilter = DateFilter;
    }
    DateFilter.selectedFilterName = DateFilter.selectedFilterName || DEFAULT_DATE_OPTION;

    if (typeof toast !== 'function') {
        window.toast = function (msg) {
            var host = document.getElementById('toasts');
            if (!host) return;
            var t = document.createElement('div');
            t.className = 'toast';
            t.textContent = msg || '';
            host.appendChild(t);
            setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 3000);
        };
    }

    /* Purpose: Whizible Copilot — same panel + chat as exec.html / js/app.js. */
    function copilotKpiPlain(flag) {
        var i, def, card, html;
        def = null;
        for (i = 0; i < KPI_CARD_DEFS.length; i++) {
            if (String(KPI_CARD_DEFS[i].flag).toLowerCase() === String(flag || '').toLowerCase()) {
                def = KPI_CARD_DEFS[i];
                break;
            }
        }
        card = (typeof findKpiCardByFlagOrLabel === 'function' ? findKpiCardByFlagOrLabel(flag) : null) || {};
        html = typeof formatKpiCardValue === 'function'
            ? formatKpiCardValue(card, def && def.unit)
            : '';
        return String(html || '\u2014').replace(/<[^>]*>/g, '');
    }

    function copilotPeriodLabel() {
        return DateFilter.selectedFilterName || DEFAULT_DATE_OPTION || 'current period';
    }

    function cpMsg(txt, who) {
        var log = document.getElementById('cpLog');
        var d;
        if (!log) return;
        d = document.createElement('div');
        d.className = 'msg ' + (who || 'a');
        d.innerHTML = txt;
        log.appendChild(d);
        log.scrollTop = 1e9;
    }

    function openCopilot(seed) {
        var cp = document.getElementById('copilot');
        if (cp) cp.classList.add('open');
        if (seed) askCopilot(seed);
    }
    window.openCopilot = openCopilot;

    function sendCopilot() {
        var inp = document.getElementById('cpInput');
        var v = inp ? String(inp.value || '').trim() : '';
        if (!v) return;
        if (inp) inp.value = '';
        askCopilot(v);
    }
    window.sendCopilot = sendCopilot;

    function askCopilot(q) {
        cpMsg(escHtml(q), 'u');
        setTimeout(function () {
            cpMsg(copilotAnswer(String(q || '').toLowerCase()), 'a');
        }, 420);
    }
    window.askCopilot = askCopilot;

    function copilotAnswer(q) {
        var n = getGreetingProjectCount();
        var pf = getGreetingPortfolioCount();
        var cu = getGreetingCustomerCount();
        var rev = copilotKpiPlain('Revenue');
        var gp = copilotKpiPlain('GrossProfit');
        var margin = copilotKpiPlain('GrossMargin');
        var util = copilotKpiPlain('Utilization');
        var delayed = copilotKpiPlain('DelayedProjects');
        var bench = copilotKpiPlain('Bench');
        var csat = copilotKpiPlain('CSAT');
        var period = escHtml(copilotPeriodLabel());
        var scope = '<b>' + period + '</b> \u00B7 <b>' + n + '</b> projects, <b>' + pf + '</b> portfolios, <b>' + cu + '</b> customers';
        var snapshot = 'revenue <b>' + escHtml(rev) + '</b>, gross profit <b>' + escHtml(gp) +
            '</b>, gross margin <b>' + escHtml(margin) + '</b>, utilization <b>' + escHtml(util) +
            '</b>, delayed projects <b>' + escHtml(delayed) + '</b>, bench <b>' + escHtml(bench) + '</b>';
        if (q.indexOf('profit') >= 0 || q.indexOf('margin') >= 0 || (q.indexOf('drop') >= 0 && q.indexOf('why') >= 0)) {
            return '<b>Profitability (current filters)</b>\n' + scope + '\n\nGross profit <b>' +
                escHtml(gp) + '</b> \u00B7 Gross margin <b>' + escHtml(margin) +
                '</b>.\n\nNo additional root-cause narrative is available beyond the live KPI values on screen.';
        }
        if (q.indexOf('risk') >= 0 || q.indexOf('delay') >= 0) {
            return '<b>Delivery risk (current filters)</b>\n' + scope +
                '\n\nDelayed projects: <b>' + escHtml(delayed) + '</b> \u00B7 Customer CSAT: <b>' +
                escHtml(csat) + '</b>.\n\nOpen the Delayed Projects or Budget Variance card to drill into live rows.';
        }
        if (q.indexOf('bench') >= 0 || q.indexOf('util') >= 0) {
            return '<b>Utilization &amp; bench (current filters)</b>\nUtilization <b>' + escHtml(util) +
                '</b> \u00B7 Bench <b>' + escHtml(bench) +
                '</b>.\n\nOpen the Utilization or Bench card to drill into live resource rows.';
        }
        if (q.indexOf('forecast') >= 0 || q.indexOf('revenue') >= 0) {
            return '<b>Revenue (current filters)</b>\n' + scope +
                '\n\nRevenue on screen: <b>' + escHtml(rev) + '</b> \u00B7 Gross margin: <b>' +
                escHtml(margin) + '</b>.\n\nNo pipeline or named-deal forecast is loaded. Use Drill revenue for live rows.';
        }
        if (q.indexOf('simulate') >= 0 || q.indexOf('moving') >= 0 || q.indexOf('what-if') >= 0 || q.indexOf('what if') >= 0) {
            return '<b>Scenario</b>\nLive baseline: ' + snapshot +
                '.\n\nNo simulated staffing or named-project scenario is applied. Adjust filters or use the live KPI cards.';
        }
        return 'Here\'s what I can see in the ' + scope + ' scope: ' + snapshot +
            '.\n\nTry: <i>"Why did profitability drop?"</i>, <i>"Show delayed projects"</i>, or <i>"Forecast revenue for next quarter"</i>.';
    }

    function bindCopilotChrome() {
        var inp = document.getElementById('cpInput');
        var log = document.getElementById('cpLog');
        if (inp && !inp._copilotBound) {
            inp._copilotBound = true;
            inp.addEventListener('keydown', function (e) {
                if (e.key === 'Enter') sendCopilot();
            });
        }
        if (log && !log.childNodes.length) {
            setTimeout(function () {
                if (log.childNodes.length) return;
                cpMsg('<b>Copilot ready.</b>\nI\'m grounded in the data currently on screen \u2014 filters, period and persona included. Ask me anything, or start with a quick prompt below.', 'a');
            }, 300);
        }
    }

    /* Purpose: Export / Share menu — same items and icons as exec.html shareMenu. */
    function shareMenu(e) {
        var m, r, btn, mw, mh, left, top;
        if (e && e.stopPropagation) e.stopPropagation();
        closeTopFilterPop();
        document.querySelectorAll('.menu.menu-share').forEach(function (x) {
            if (x.parentNode) x.parentNode.removeChild(x);
        });
        m = document.createElement('div');
        m.className = 'menu menu-share';
        m.innerHTML =
            '<div class="mhd">Export dashboard to</div>' +
            '<button type="button" data-act="ppt">\uD83D\uDCFD Microsoft PowerPoint</button>' +
            '<button type="button" data-act="html">\uD83C\uDF10 HTML report</button>' +
            '<button type="button" data-act="excel">\uD83D\uDCCA Excel</button>' +
            '<button type="button" data-act="csv">\u2B07 CSV</button>' +
            '<button type="button" data-act="print">\uD83D\uDDA8 Print</button>' +
            '<div class="mhd">Share</div>' +
            '<button type="button" data-act="link">\uD83D\uDD17 Copy secure link</button>' +
            '<button type="button" data-act="teams">\uD83D\uDCAC Share to Teams</button>' +
            '<button type="button" data-act="email">\u2709 Email report</button>' +
            '<div class="mhd">Schedule</div>' +
            '<button type="button" data-act="weekly">\u23F0 Schedule weekly</button>' +
            '<button type="button" data-act="fortnightly">\u23F0 Schedule fortnightly</button>' +
            '<button type="button" data-act="monthly">\u23F0 Schedule monthly</button>' +
            '<button type="button" data-act="quarterly">\u23F0 Schedule quarterly</button>';
        document.body.appendChild(m);
        btn = e && (e.currentTarget || (e.target && e.target.closest ? e.target.closest('button') : null));
        r = btn ? btn.getBoundingClientRect() : { bottom: 80, left: 40, right: 220, top: 50 };
        mw = m.offsetWidth || 240;
        mh = m.offsetHeight || 48;
        left = r.right - mw;
        if (left < 8) left = 8;
        if (left + mw > window.innerWidth - 8) left = Math.max(8, window.innerWidth - mw - 8);
        top = r.bottom + 6;
        if (top + mh > window.innerHeight - 8) top = Math.max(8, r.top - mh - 6);
        m.style.position = 'fixed';
        m.style.top = top + 'px';
        m.style.left = left + 'px';
        m.style.zIndex = '3300';
        m.addEventListener('click', function (ev) { ev.stopPropagation(); });
        m.querySelectorAll('[data-act]').forEach(function (b) {
            b.onclick = function () {
                var act = b.getAttribute('data-act');
                if (m.parentNode) m.parentNode.removeChild(m);
                if (act === 'print') { window.print(); return; }
                if (act === 'link') { showComingSoon('link'); return; }
                if (act === 'teams') { showComingSoon('teams'); return; }
                if (act === 'email') { toast('Emailed to your default report group (4 recipients)'); return; }
                if (act === 'weekly') { toast('Scheduled weekly: every Monday 8:00 AM IST'); return; }
                if (act === 'fortnightly') { toast('Scheduled fortnightly: alternate Mondays 8:00 AM IST'); return; }
                if (act === 'monthly') { toast('Scheduled monthly: 1st working day, 8:00 AM IST'); return; }
                if (act === 'quarterly') { toast('Scheduled quarterly: with QBR pack, first Monday of quarter'); return; }
                if (act === 'excel') { toast('Dashboard exported to Excel'); return; }
                if (act === 'csv') { toast('Dashboard downloaded as CSV'); return; }
                if (act === 'html') { toast('Downloaded HTML report'); return; }
                if (act === 'ppt') { toast('Dashboard exported to Microsoft PowerPoint'); return; }
                toast('Export / share: ' + act);
            };
        });
        setTimeout(function () {
            var onDoc = function (ev) {
                if (m.contains(ev.target)) return;
                if (m.parentNode) m.parentNode.removeChild(m);
                document.removeEventListener('mousedown', onDoc, true);
            };
            document.addEventListener('mousedown', onDoc, true);
        }, 0);
    }
    window.shareMenu = shareMenu;

    function comingSoonEsc(e) { if (e.key === 'Escape') closeComingSoon(); }
    function closeComingSoon() {
        document.removeEventListener('keydown', comingSoonEsc);
        var el = document.getElementById('comingSoonModal');
        if (el && el.parentNode) el.parentNode.removeChild(el);
    }
    window.closeComingSoon = closeComingSoon;
    function showComingSoon(kind) {
        var isTeams = kind === 'teams';
        var wrap = document.createElement('div');
        closeComingSoon();
        wrap.id = 'comingSoonModal';
        wrap.className = 'coming-soon-wrap';
        wrap.setAttribute('role', 'dialog');
        wrap.setAttribute('aria-modal', 'true');
        wrap.setAttribute('aria-labelledby', 'comingSoonTitle');
        wrap.innerHTML =
            '<div class="coming-soon-card">' +
            '<button type="button" class="coming-soon-close" onclick="closeComingSoon()" aria-label="Close" title="Close"><i class="fas fa-times"></i></button>' +
            '<div class="coming-soon-icon" aria-hidden="true">' +
            '<span class="coming-soon-orb"></span>' +
            '<i class="fas fa-rocket"></i>' +
            '<span class="coming-soon-spark coming-soon-spark-1">✦</span>' +
            '<span class="coming-soon-spark coming-soon-spark-2">✧</span>' +
            '<span class="coming-soon-spark coming-soon-spark-3">✦</span>' +
            '</div>' +
            '<div class="coming-soon-badge">Coming Soon</div>' +
            '<h3 id="comingSoonTitle">' + (isTeams ? 'Share to Teams' : 'Copy secure link') + '</h3>' +
            '</div>';
        wrap.addEventListener('click', function (ev) { if (ev.target === wrap) closeComingSoon(); });
        document.body.appendChild(wrap);
        document.addEventListener('keydown', comingSoonEsc);
    }
    window.showComingSoon = showComingSoon;

    /* Purpose: Encrypt Params header for ValidateHeadersAttribute. */
    function encryptString(value) {
        var arr = [], out = '', n = 1, i;
        if (String(value).length > 0) {
            for (i = 0; i <= value.length - 1; i++) {
                arr[i] = String(String(String(value[i])).charCodeAt(0) + n);
                n = n + 2;
            }
            out = arr.join('-');
            if (out.charAt(0) === '-') out = out.substring(1, out.length - 1);
        }
        return out;
    }

    /* Purpose: Read PascalCase or camelCase API field (0 is a valid value). */
    function getApiField(row) {
        if (!row) return undefined;
        var i, key, found, val;
        for (i = 1; i < arguments.length; i++) {
            key = arguments[i];
            if (Object.prototype.hasOwnProperty.call(row, key)) {
                val = row[key];
                if (val !== undefined && val !== null && val !== '') return val;
                if (val === 0 || val === false || val === '0') return val;
            }
            found = Object.keys(row).find(function (k) { return String(k).toLowerCase() === String(key).toLowerCase(); });
            if (found != null) {
                val = row[found];
                if (val !== undefined && val !== null && val !== '') return val;
                if (val === 0 || val === false || val === '0') return val;
            }
        }
        return undefined;
    }

    /* Purpose: Unwrap { message, data: [rows] } or nested model name. */
    function getApiRows(json, modelName) {
        function walk(node, depth) {
            if (node == null || depth > 6) return [];
            if (Array.isArray(node)) return node;
            if (typeof node !== 'object') return [];
            var names = modelName ? [modelName, modelName.charAt(0).toLowerCase() + modelName.slice(1)] : [];
            var i, rows, k, nested;
            for (i = 0; i < names.length; i++) {
                rows = getApiField(node, names[i]);
                if (Array.isArray(rows)) return rows;
            }
            nested = node.data != null ? node.data : node.Data;
            if (nested != null && nested !== node) {
                rows = walk(nested, depth + 1);
                if (rows.length) return rows;
            }
            for (k in node) {
                if (Object.prototype.hasOwnProperty.call(node, k) && Array.isArray(node[k])) return node[k];
            }
            return [];
        }
        return walk(json, 0);
    }
    window.getApiRows = getApiRows;

    function parseFilterDate(value) {
        if (!value) return null;
        if (value instanceof Date && !isNaN(value.getTime())) {
            return new Date(value.getFullYear(), value.getMonth(), value.getDate());
        }
        var m = String(value).match(/^(\d{4})-(\d{2})-(\d{2})/);
        if (m) return new Date(Number(m[1]), Number(m[2]) - 1, Number(m[3]));
        var d = new Date(value);
        return isNaN(d.getTime()) ? null : new Date(d.getFullYear(), d.getMonth(), d.getDate());
    }

    function formatFilterDate(d) {
        return d ? d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : '-';
    }

    function formatApiDate(d) {
        if (!d) return '';
        var m = d.getMonth() + 1, day = d.getDate();
        return d.getFullYear() + '-' + (m < 10 ? '0' : '') + m + '-' + (day < 10 ? '0' : '') + day;
    }

    function formatFilterRange(s, e) {
        if (!s || !e) return '';
        if (s.toDateString() === e.toDateString()) return formatFilterDate(s);
        return s.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }) + ' - ' + formatFilterDate(e);
    }

    function getTodayDate() {
        var n = new Date();
        return new Date(n.getFullYear(), n.getMonth(), n.getDate());
    }

    function isSameDay(a, b) {
        return a && b && a.toDateString() === b.toDateString();
    }

    function isComparisonRow(row) {
        var v = getApiField(row, 'IsComparison');
        return v === true || v === 1 || v === '1' || String(v).toLowerCase() === 'true';
    }

    /* Purpose: Full-page white loader until data is bound (avoids piecemeal UI). */
    var PageLoaderDepth = 0;
    var loaderShown = false;
    var loaderStartTime = 0;
    var PageBootComplete = false;

    function showLoader() {
        var el = document.getElementById('loaderOverlay');
        if (!el) return;
        PageLoaderDepth += 1;
        el.style.display = 'block';
        loaderShown = true;
        loaderStartTime = Date.now();
    }

    function hideLoader(force) {
        var el = document.getElementById('loaderOverlay');
        if (force) PageLoaderDepth = 0;
        else PageLoaderDepth = Math.max(0, PageLoaderDepth - 1);
        if (PageLoaderDepth > 0 || !el) return;

        var elapsed = Date.now() - (loaderStartTime || Date.now());
        var minDisplay = PageBootComplete ? 400 : 0;
        function hideNow() {
            el.style.display = 'none';
            loaderShown = false;
        }
        if (loaderShown && minDisplay > 0 && elapsed < minDisplay) {
            setTimeout(hideNow, minDisplay - elapsed);
        } else {
            hideNow();
        }
    }

    function ShowPageLoader() { showLoader(); }
    function HidePageLoader() { hideLoader(); }

    /* Purpose: Dispose Bootstrap tooltip instances under root (before re-render). */
    function DisposeCxoTooltips(root) {
        var scope = root || document;
        var nodes, i, tip;
        if (!window.bootstrap || !bootstrap.Tooltip) return;
        nodes = scope.querySelectorAll('[data-bs-toggle="tooltip"], [data-cxo-tip]');
        for (i = 0; i < nodes.length; i++) {
            tip = bootstrap.Tooltip.getInstance(nodes[i]);
            if (tip) tip.dispose();
        }
    }

    /* Purpose: Hide any open black tooltips (scroll / click / modal). */
    function HideCxoTooltips() {
        var tips, i;
        try {
            tips = document.querySelectorAll('body > .tooltip');
            for (i = 0; i < tips.length; i++) {
                if (tips[i].parentNode) tips[i].parentNode.removeChild(tips[i]);
            }
        } catch (e) { /* ignore */ }
    }

    /*
      Purpose: Full-page black tooltips (replace native white title tips).
      Uses Bootstrap Tooltip + .cxo-black-tooltip CSS.
    */
    function InitCxoBlackTooltips(root) {
        var scope = root || document;
        var nodes, i, el, text, existing;
        if (!window.bootstrap || !bootstrap.Tooltip) return;

        /* Single element passed (e.g. button) */
        if (scope.nodeType === 1 && !scope.querySelectorAll) {
            scope = scope.parentNode || document;
        }

        nodes = (scope === document || scope.querySelectorAll)
            ? scope.querySelectorAll('[title], [data-bs-original-title], [data-cxo-tip]')
            : [];
        /* Also include the root itself when it is an element with a title */
        if (root && root.nodeType === 1) {
            nodes = Array.prototype.slice.call(nodes);
            if (root.getAttribute('title') || root.getAttribute('data-cxo-tip') || root.getAttribute('data-bs-original-title')) {
                nodes.unshift(root);
            }
        }

        for (i = 0; i < nodes.length; i++) {
            el = nodes[i];
            text = el.getAttribute('title')
                || el.getAttribute('data-cxo-tip')
                || el.getAttribute('data-bs-original-title')
                || '';
            text = String(text).trim();
            if (!text) continue;
            if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA' || el.tagName === 'SELECT') continue;

            existing = bootstrap.Tooltip.getInstance(el);
            if (existing) existing.dispose();

            el.setAttribute('data-cxo-tip', text);
            el.setAttribute('data-bs-toggle', 'tooltip');
            el.setAttribute('data-bs-title', text);
            el.removeAttribute('title');

            new bootstrap.Tooltip(el, {
                container: 'body',
                customClass: 'cxo-black-tooltip',
                trigger: 'hover focus',
                placement: el.getAttribute('data-bs-placement') || 'top',
                animation: true
            });
        }
    }

    /* Purpose: Wire once — hide tips on scroll/click so they never stick. */
    function BindCxoTooltipDismiss() {
        if (BindCxoTooltipDismiss._done) return;
        BindCxoTooltipDismiss._done = true;
        document.addEventListener('scroll', HideCxoTooltips, true);
        document.addEventListener('mousedown', HideCxoTooltips, true);
        document.addEventListener('touchstart', HideCxoTooltips, true);
    }

    /* Purpose: Reveal dashboard only after bind — hides preloader + overlay together. */
    function showDashboardPage() {
        var pre = document.getElementById('AnalyticsPreloader');
        var wrap = document.getElementById('AnalyticsWrapper');
        var ov = document.getElementById('loaderOverlay');
        if (pre) pre.style.display = 'none';
        if (ov) {
            ov.style.display = 'none';
            PageLoaderDepth = 0;
            loaderShown = false;
        }
        if (wrap) wrap.style.display = '';
        PageBootComplete = true;
    }

    /* Purpose: Generic POST — bearer token + Params (ValidateHeaders). */
    function callDashboardApi(actionName, requestBody, onSuccess, onError) {
        var payload = requestBody || {};
        var bodyText = JSON.stringify(payload);
        fetch(encodeURI(strUrl) + '/api/PM_AnalyticsCXO_Dashboard/' + actionName, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'Authorization': 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || ''),
                'Params': encryptString(bodyText)
            },
            body: bodyText
        })
            .then(function (res) {
                if (!res.ok) throw new Error(actionName + ' failed: ' + res.status);
                return res.json().catch(function () { return {}; });
            })
            .then(function (json) { if (onSuccess) onSuccess(json); })
            .catch(function (err) {
                console.error(actionName, err);
                if (onError) onError(err);
            });
    }
    window.callDashboardApi = callDashboardApi;

    /* Purpose: One SP call — date flags + comparison flags. Split client-side; Compare only show/hides. */
    function GetFilterOption(onDone) {
        if (DateFilter.filterOptionsLoaded) {
            if (onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
            return;
        }
        callDashboardApi('GetPageGenericfilters', { DashboardID: DASHBOARD_ID }, function (json) {
            var rows = getApiRows(json, 'PageGenericFilterModel');
            var dateOptions = [], comparisonOptions = [], i;
            for (i = 0; i < rows.length; i++) {
                if (isComparisonRow(rows[i])) comparisonOptions.push(rows[i]);
                else dateOptions.push(rows[i]);
            }
            DateFilter.dateOptions = dateOptions;
            DateFilter.comparisonOptions = comparisonOptions;
            DateFilter.filterOptionsLoaded = true;
            if (onDone) onDone(dateOptions, comparisonOptions);
        }, function () {
            DateFilter.dateOptions = [];
            DateFilter.comparisonOptions = [];
            DateFilter.filterOptionsLoaded = false;
            if (onDone) onDone([], []);
        });
    }

    /* Purpose: Current / previous dates for a date flag. Cached so the same flag is not fetched again. */
    function GetFilterDateRange(flag, startDate, endDate, onDone) {
        var key = String(flag) + '|' + (startDate || '') + '|' + (endDate || '');
        if (!startDate && DateFilter.dateRangeCache[key]) {
            if (onDone) onDone(DateFilter.dateRangeCache[key]);
            return;
        }
        var body = { DashboardID: DASHBOARD_ID, Flag: String(flag) };
        if (startDate) body.StartDate = startDate;
        if (endDate) body.EndDate = endDate;
        callDashboardApi('GetAnalyticsDBFilterDateRange', body, function (json) {
            var row = getApiRows(json, 'AnalyticsDBFilterDateRangeModel')[0] || null;
            if (row && !startDate) DateFilter.dateRangeCache[key] = row;
            if (onDone) onDone(row);
        }, function () { if (onDone) onDone(null); });
    }

    /* Purpose: Compare start/end from updated SP. Pass current flag + Start/End textbox dates + comparison flag. */
    function GetFilterCompareDateRange(filterId, comparisonId, startDate, endDate, onDone) {
        if (!comparisonId || !startDate || !endDate) {
            if (onDone) onDone(null);
            return;
        }
        var body = {
            DashboardID: DASHBOARD_ID,
            FilterID: Number(filterId) || 0,
            IsComparison: true,
            ComparisonID: Number(comparisonId),
            CustomCompStartDate: formatApiDate(startDate),
            CustomCompEndDate: formatApiDate(endDate)
        };
        var key = body.FilterID + '|' + body.ComparisonID + '|' + body.CustomCompStartDate + '|' + body.CustomCompEndDate;
        if (DateFilter.compareRangeCache[key]) {
            if (onDone) onDone(DateFilter.compareRangeCache[key]);
            return;
        }
        callDashboardApi('GetAnalyticsDBFilterDateRangeUpdated', body, function (json) {
            var row = getApiRows(json, 'AnalyticsDBFilterDateRangeModel')[0] || null;
            if (row) DateFilter.compareRangeCache[key] = row;
            if (onDone) onDone(row);
        }, function () { if (onDone) onDone(null); });
    }

    function findFilterOption(name, list) {
        var i, n;
        list = list || [];
        for (i = 0; i < list.length; i++) {
            n = String(getApiField(list[i], 'FilterName') || '');
            if (n.toLowerCase() === String(name || '').toLowerCase()) return list[i];
        }
        return null;
    }

    function getDefaultDateOption(list) {
        var i, n, rows = list || [];
        for (i = 0; i < rows.length; i++) {
            n = String(getApiField(rows[i], 'FilterName') || '');
            if (n.toLowerCase() === DEFAULT_DATE_OPTION.toLowerCase()) return rows[i];
        }
        for (i = 0; i < rows.length; i++) {
            n = String(getApiField(rows[i], 'FilterName') || '');
            if (n.toLowerCase() !== 'custom') return rows[i];
        }
        return rows[0] || null;
    }

    /* Purpose: Header label + range. Chip stays visible like exec.html; Compare toggle stays off until user turns it on. */
    function updateFilterHeader() {
        var lbl = document.getElementById('dateLabel');
        var rng = document.getElementById('dateRangeTxt');
        var tag = document.getElementById('compareTag');
        var rangeText = formatFilterRange(DateFilter.startDate, DateFilter.endDate);
        if (lbl) lbl.textContent = DateFilter.selectedFilterName || DEFAULT_DATE_OPTION;
        if (rng) rng.textContent = rangeText;
        if (tag) {
            tag.style.display = '';
            tag.hidden = false;
            tag.textContent = 'vs previous period';
        }
        if (typeof state !== 'undefined' && state.date) {
            var s = DateFilter.startDate, e = DateFilter.endDate;
            var days = (s && e) ? Math.round((e - s) / 864e5) + 1 : 1;
            state.date.label = DateFilter.selectedFilterName;
            state.date.range = rangeText;
            state.date.s = s;
            state.date.e = e;
            state.date.compare = DateFilter.compare;
            state.date.filterId = DateFilter.selectedFilterId;
            state.date.comparisonId = DateFilter.selectedComparisonId;
            state.date.months = Math.max(days / 30.42, 0.1);
            state.date.previousStart = DateFilter.previousStart;
            state.date.previousEnd = DateFilter.previousEnd;
        }
    }

    /* Purpose: Bind SP current start/end to textboxes + calendar highlight. */
    function applyFilterDateRange(row, filterName) {
        if (!row) return false;
        var s = parseFilterDate(getApiField(row, 'CurrentStartDate'));
        var e = parseFilterDate(getApiField(row, 'CurrentEndDate'));
        if (!s || !e) return false;
        var filterId = Number(getApiField(row, 'FilterID'));
        var name = filterName || getApiField(row, 'FilterName') || DEFAULT_DATE_OPTION;
        var customPrev;
        DateFilter.selectedFilterId = isNaN(filterId) ? DateFilter.selectedFilterId : filterId;
        DateFilter.selectedFilterName = name;
        DateFilter.lastRange = row;
        DateFilter.startDate = s;
        DateFilter.endDate = e;
        if (isCustomPeriodFlag(name)) {
            customPrev = computePreviousPeriodEqualLength(s, e);
            DateFilter.previousStart = customPrev.start;
            DateFilter.previousEnd = customPrev.end;
        } else {
            DateFilter.previousStart = parseFilterDate(getApiField(row, 'PreviousStartDate'));
            DateFilter.previousEnd = parseFilterDate(getApiField(row, 'PreviousEndDate'));
        }
        /* Compare stays off until user enables it in the date picker */
        updateFilterHeader();
        return true;
    }

    /* Purpose: Detect Custom Comparison comparison flag (DB FilterName). */
    function isCustomComparisonFlag(name) {
        var n = String(name || '').replace(/\s+/g, '').toLowerCase();
        return n === 'customcomparison';
    }

    /* Purpose: Default compare flag — previous window already on GetFilterDateRange. */
    function isAlignedPreviousPeriodComparison(name) {
        return String(name || '').trim().toLowerCase() === 'previous period';
    }

    /* Purpose: Copy PreviousStart/End from the same date-range row as current (same as-of). */
    function applyPreviousDatesFromRangeRow(ds, row) {
        var cs, ce;
        if (!ds || !row) return false;
        cs = parseFilterDate(getApiField(row, 'PreviousStartDate'));
        ce = parseFilterDate(getApiField(row, 'PreviousEndDate'));
        if (!cs || !ce) return false;
        ds.cs = cs;
        ds.ce = ce;
        return true;
    }

    /* Purpose: Inclusive day count (1 Sep–10 Sep = 10). */
    function inclusiveDayCount(startDate, endDate) {
        if (!startDate || !endDate) return 0;
        return Math.round((endDate - startDate) / 864e5) + 1;
    }

    /*
      Purpose: Previous period of equal length immediately before current.
      Custom Jul 1–Jul 31 → Jun 1–Jun 30.
    */
    function computePreviousPeriodEqualLength(startDate, endDate) {
        var s, e, days, prevEnd, prevStart;
        if (!startDate || !endDate) return { start: null, end: null };
        s = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());
        e = new Date(endDate.getFullYear(), endDate.getMonth(), endDate.getDate());
        if (e < s) return { start: null, end: null };
        days = inclusiveDayCount(s, e);
        prevEnd = new Date(s.getFullYear(), s.getMonth(), s.getDate() - 1);
        prevStart = new Date(prevEnd.getFullYear(), prevEnd.getMonth(), prevEnd.getDate() - (days - 1));
        return { start: prevStart, end: prevEnd };
    }

    /* Purpose: True when period flag is Custom. */
    function isCustomPeriodFlag(name) {
        return String(name || '').trim().toLowerCase() === 'custom';
    }

    /* Calendar UI is owned by js/app.js (window.openDatePicker / window.closeDatePicker).
       Added by Dipali V. on 01-10-2026 — do not reintroduce openDatePicker here. */
    function bindDatePickerButton() {
        var btn = document.getElementById('dateBtn');
        if (!btn) return;
        btn.onclick = function (e) {
            e.preventDefault();
            e.stopPropagation();
            /* Calendar UI in app.js only — Added by Dipali V. on 01-10-2026 */
            if (typeof window.openDatePicker === 'function') {
                window.openDatePicker(e);
            }
        };
    }

    /* =====================================================================
       Top section chips — DipalI v On 10th sep 2026
       GetTopFilterOption: one API call (Flag omitted) → all chip lists.
       Multi-select pop keeps existing .chipbtn / .pop / .cnt CSS.
       Count on chip is dynamic from selected length only.
       ===================================================================== */

    /* Purpose: Chip label (UI) ↔ Flag (SP / API). PascalCase matches FlagWise / Dependent API keys.
       Do not reuse app.js camelCase flags — openTopFilterPop reads data-flag first. */
    var TOP_FILTER_CHIPS = [
        { label: 'Portfolio', flag: 'Portfolio' },
        { label: 'Customer', flag: 'Customer' },
        { label: 'Project Manager', flag: 'ProjectManager' },
        { label: 'Health', flag: 'Health' },
        { label: 'Organization Unit', flag: 'Region' },
        { label: 'Billing Type', flag: 'BillingType' }
    ];
    window.TOP_FILTER_CHIPS = TOP_FILTER_CHIPS;

    /* Added by Vikas T on 30-09-2026 - Chip by UI label or API flag (Organization Unit ↔ Region). */
    function findTopFilterChip(flagOrLabel) {
        var i, chip, a, b;
        if (!flagOrLabel) return null;
        a = String(flagOrLabel).replace(/\s/g, '').toLowerCase();
        if (a === 'organizationunit' || a === 'location' || a === 'ou') a = 'region';
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            chip = TOP_FILTER_CHIPS[i];
            b = String(chip.flag || '').replace(/\s/g, '').toLowerCase();
            if (chip.label === flagOrLabel || chip.flag === flagOrLabel) return chip;
            if (String(chip.label).replace(/\s/g, '').toLowerCase() === a || b === a) return chip;
        }
        return null;
    }
    window.findTopFilterChip = findTopFilterChip;

    /* Added by Vikas T on 30-09-2026 - Keep selection under both chip label and flag. */
    function writeTopFilterSelected(labelOrFlag, arr) {
        var chip = findTopFilterChip(labelOrFlag);
        arr = arr || [];
        if (!chip) {
            TopFilter.selected[labelOrFlag] = arr;
            return;
        }
        TopFilter.selected[chip.label] = arr;
        TopFilter.selected[chip.flag] = arr;
    }
    window.writeTopFilterSelected = writeTopFilterSelected;

    /* Added by Vikas T on 30-09-2026 - Filter bag key lookup with Organization Unit aliases. */
    function findFilterBagKey(bag, flag) {
        var aliases, i, found;
        if (!bag || !flag) return null;
        aliases = [flag];
        if (String(flag).replace(/\s/g, '').toLowerCase() === 'region') {
            aliases.push('OrganizationUnit', 'Organization Unit', 'Location', 'OU');
        }
        for (i = 0; i < aliases.length; i++) {
            found = Object.keys(bag).find(function (k) {
                return String(k).replace(/\s/g, '').toLowerCase() === String(aliases[i]).replace(/\s/g, '').toLowerCase();
            });
            if (found) return found;
        }
        return null;
    }
    window.findFilterBagKey = findFilterBagKey;

    /* Share one TopFilter with app.js cascade (same pattern as DateFilter). */
    var TopFilter = window.TopFilter;
    if (!TopFilter) {
        TopFilter = {
            options: {},
            selected: {},
            loaded: false,
            /* Added by Dipali */
            dependentLoading: false,
            dependentRequestSeq: 0
        };
    }
    window.TopFilter = TopFilter;

    /* Purpose: Greeting counts from drill L1/L2 scope SP. */
    var GreetingProjectCount = {
        value: 0,
        portfolioCount: 0,
        customerCount: 0,
        loading: false,
        loaded: false,
        requestSeq: 0
    };

    function escHtml(s) {
        return String(s == null ? '' : s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }

    /* Purpose: Unwrap { message, data: { Portfolio: [...], ... } } from ResponseHelper. */
    function getApiDataBag(json) {
        var node = json;
        var depth = 0;
        while (node && typeof node === 'object' && !Array.isArray(node) && depth < 5) {
            /* Updated by Vikas T on 30-09-2026 - also accept OrganizationUnit key. */
            if (node.Portfolio || node.Customer || node.Health || node.Region || node.BillingType || node.ProjectManager || node.OrganizationUnit) {
                return node;
            }
            if (node.data != null && typeof node.data === 'object' && !Array.isArray(node.data)) {
                node = node.data;
                depth++;
                continue;
            }
            if (node.Data != null && typeof node.Data === 'object' && !Array.isArray(node.Data)) {
                node = node.Data;
                depth++;
                continue;
            }
            break;
        }
        return node && typeof node === 'object' && !Array.isArray(node) ? node : null;
    }
    window.getApiDataBag = getApiDataBag;

    function normalizeTopFilterRows(rows) {
        var list = [], i, id, name;
        rows = rows || [];
        for (i = 0; i < rows.length; i++) {
            /* Updated by Vikas T on 30-09-2026 - Organization Unit rows may come as LocationID / LocationName. */
            id = getApiField(rows[i], 'ID', 'Id', 'LocationID', 'OrganizationUnitID');
            name = getApiField(rows[i], 'Name', 'LocationName', 'OrganizationUnitName', 'OrganizationUnit');
            if (id == null || name == null || name === '') continue;
            list.push({ id: String(id), name: String(name) });
        }
        return list;
    }
    window.normalizeTopFilterRows = normalizeTopFilterRows;

    /* Purpose: One server call — all chip masters for multi-select bind.
       Added by Dipali - also bind HighLevelRole from the same bag and cascade dependent chips. */
    function GetTopFilterOption(onDone) {
        if (TopFilter.loaded) {
            if (onDone) onDone(TopFilter.options);
            return;
        }
        callDashboardApi('GetAnalyticsDBFilterFlagWise', { DashboardID: DASHBOARD_ID }, function (json) {
            var bag = getApiDataBag(json) || {};
            var options = {}, i, chip, key, rows;
            for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
                chip = TOP_FILTER_CHIPS[i];
                /* Updated by Vikas T on 30-09-2026 - alias-aware key + selection stored under label and flag. */
                key = findFilterBagKey(bag, chip.flag);
                rows = key ? bag[key] : [];
                if (!Array.isArray(rows)) rows = getApiRows(rows);
                options[chip.flag] = normalizeTopFilterRows(rows);
                options[chip.label] = options[chip.flag];
                if (!TopFilter.selected[chip.label]) writeTopFilterSelected(chip.label, []);
            }
            TopFilter.options = options;
            TopFilter.loaded = true;
            /* Added by Dipali - Same FlagWise bag — avoid second GetAnalyticsDBFilterFlagWise for roles */
            applyHighLevelRolesFromBag(bag);
            LoadGreetingProjectCount();
            /* Do not block page boot / preloader on cascade — finish chips first, then scope dependents. */
            if (onDone) onDone(TopFilter.options);
            if (typeof window.AppLoadDependentTopFilters === 'function') {
                window.AppLoadDependentTopFilters(joinSelectedIds('Portfolio'), function () {
                    if (typeof syncTopFilterChipBadges === 'function') syncTopFilterChipBadges();
                    if (typeof RenderTopFilterChips === 'function') RenderTopFilterChips();
                });
            }
        }, function () {
            TopFilter.options = {};
            TopFilter.loaded = false;
            if (onDone) onDone({});
        });
    }

    /* Updated by Vikas T on 30-09-2026 - read selection by chip label or flag (Organization Unit ↔ Region). */
    function getTopFilterSelectedCount(label) {
        var chip = findTopFilterChip(label);
        var arr = TopFilter.selected[label] || (chip && TopFilter.selected[chip.label]) || (chip && TopFilter.selected[chip.flag]) || [];
        return arr.length;
    }

    function isTopFilterSelected(label, id) {
        var chip = findTopFilterChip(label);
        var arr = TopFilter.selected[label] || (chip && TopFilter.selected[chip.label]) || (chip && TopFilter.selected[chip.flag]) || [];
        var i;
        for (i = 0; i < arr.length; i++) {
            if (String(arr[i].id) === String(id)) return true;
        }
        return false;
    }

    function toggleTopFilterSelection(label, item) {
        var chip = findTopFilterChip(label);
        var key = chip ? chip.label : label;
        var arr = TopFilter.selected[key] || (chip && TopFilter.selected[chip.flag]) || [];
        var i, found = -1;
        for (i = 0; i < arr.length; i++) {
            if (String(arr[i].id) === String(item.id)) { found = i; break; }
        }
        if (found >= 0) arr.splice(found, 1);
        else arr.push({ id: item.id, name: item.name });
        writeTopFilterSelected(key, arr);
        syncTopFilterToAppState();
    }

    /* Purpose: Keep app.js state.filters as selected Names so demo pages still filter. */
    function syncTopFilterToAppState() {
        if (typeof state === 'undefined' || !state.filters) return;
        var i, chip, arr;
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            chip = TOP_FILTER_CHIPS[i];
            arr = TopFilter.selected[chip.label] || [];
            state.filters[chip.label] = arr.map(function (x) { return x.name; });
        }
    }
    window.syncTopFilterToAppState = syncTopFilterToAppState;

    /* Purpose: Count badge when selected; chevron when empty.
       Do not embed ▾ in aspx source — IIS often serves this page as Windows-1252 (â-¾). */
    function topFilterChipSuffix(n) {
        if (n) return ' <span class="cnt">' + n + '</span>';
        return ' <i class="fas fa-chevron-down" aria-hidden="true"></i>';
    }

    /* Purpose: Update chip count badges without destroying open pop anchor. */
    function syncTopFilterChipBadges() {
        var host = document.getElementById('chips');
        if (!host) return;
        host.querySelectorAll('[data-chip]').forEach(function (btn) {
            var label = btn.getAttribute('data-chip');
            var n = getTopFilterSelectedCount(label);
            btn.classList.toggle('on', !!n);
            btn.innerHTML = escHtml(label) + topFilterChipSuffix(n);
        });
    }
    window.syncTopFilterChipBadges = syncTopFilterChipBadges;

    /* Purpose: Render chips; count badge is dynamic from selection length only. */
    function RenderTopFilterChips() {
        var host = document.getElementById('chips');
        var html = '', i, chip, n;
        if (!host) return;
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            chip = TOP_FILTER_CHIPS[i];
            n = getTopFilterSelectedCount(chip.label);
            html += '<button type="button" class="chipbtn' + (n ? ' on' : '') + '" data-chip="' + escHtml(chip.label) + '" data-flag="' + escHtml(chip.flag) + '">' +
                escHtml(chip.label) +
                topFilterChipSuffix(n) +
                '</button>';
        }
        host.innerHTML = html;
        host.querySelectorAll('[data-chip]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                openTopFilterPop(e, btn.getAttribute('data-chip'), btn.getAttribute('data-flag'));
            };
        });
        InitCxoBlackTooltips(host);
    }

    function closeTopFilterPop() {
        var pops = document.querySelectorAll('.pop:not(.ga-pop)'), i;
        for (i = 0; i < pops.length; i++) {
            if (pops[i]._onDocClose) document.removeEventListener('mousedown', pops[i]._onDocClose, true);
            if (pops[i].parentNode) pops[i].parentNode.removeChild(pops[i]);
        }
    }

    /* Updated by Vikas T on 30-09-2026 - selection stored under chip label and flag. */
    function setTopFilterChecked(label, item, checked) {
        var chip = findTopFilterChip(label);
        var key = chip ? chip.label : label;
        var arr = TopFilter.selected[key] || (chip && TopFilter.selected[chip.flag]) || [];
        var i, found = -1;
        for (i = 0; i < arr.length; i++) {
            if (String(arr[i].id) === String(item.id)) { found = i; break; }
        }
        if (checked && found < 0) arr.push({ id: item.id, name: item.name });
        if (!checked && found >= 0) arr.splice(found, 1);
        writeTopFilterSelected(key, arr);
        syncTopFilterToAppState();
    }

    function applyTopFilterPopChange(label) {
        syncTopFilterChipBadges();
        if (typeof persistState === 'function') persistState();
        if (String(label) === 'Portfolio') {
            if (typeof window.AppOnPortfolioFilterChanged === 'function') {
                window.AppOnPortfolioFilterChanged(true);
            } else {
                RefreshKpiDashboard();
            }
            return;
        }
        RefreshKpiDashboard();
    }

    /* Purpose: Chip dropdown inside list matches Plan_VS_Actual_DB.aspx (checkbox + search + Clear/Close).
       Outer pop border stays the existing CXO dropdown chrome. */
    function openTopFilterPop(evt, label, flag) {
        closeTopFilterPop();
        if (typeof closeMenus === 'function') {
            try { closeMenus(); } catch (err) { /* ignore */ }
        }
        /* Updated by Vikas T on 30-09-2026 - fall back to label key (Organization Unit). */
        var opts = TopFilter.options[flag] || TopFilter.options[label] || [];
        var pop = document.createElement('div');
        var html = '', i, item, sel, anchor, r, searchEl, emptyEl, clearBtn, closeBtn;
        pop.className = 'pop chip-pop';
        html += '<input type="text" class="msel-search" placeholder="Search ' + escHtml(label) + '..." autocomplete="off">';
        html += '<div class="msel-rows">';
        for (i = 0; i < opts.length; i++) {
            item = opts[i];
            sel = isTopFilterSelected(label, item.id);
            html += '<label class="msel-row" data-id="' + escHtml(item.id) + '" data-name="' + escHtml(item.name) + '">' +
                '<input type="checkbox"' + (sel ? ' checked' : '') + '>' +
                '<span>' + escHtml(item.name) + '</span>' +
                '</label>';
        }
        html += '</div>';
        html += '<div class="msel-empty"' + (opts.length ? ' hidden' : '') + '>No matches</div>';
        html += '<div class="msel-actions">' +
            '<button type="button" data-msel="clear">Clear</button>' +
            '<button type="button" data-msel="close">Close</button>' +
            '</div>';
        pop.innerHTML = html;
        document.body.appendChild(pop);
        anchor = evt.currentTarget || evt.target;
        r = anchor.getBoundingClientRect();
        pop.style.position = 'fixed';
        pop.style.top = (r.bottom + 6) + 'px';
        pop.style.left = Math.min(r.left, window.innerWidth - 250) + 'px';
        pop.style.zIndex = '3000';
        pop.addEventListener('click', function (ev) { ev.stopPropagation(); });
        pop.addEventListener('mousedown', function (ev) { ev.stopPropagation(); });

        searchEl = pop.querySelector('.msel-search');
        emptyEl = pop.querySelector('.msel-empty');
        function applyChipSearch() {
            var q = searchEl ? String(searchEl.value || '').trim().toLowerCase() : '';
            var any = false;
            pop.querySelectorAll('.msel-row').forEach(function (row) {
                var name = String(row.getAttribute('data-name') || '').toLowerCase();
                var match = !q || name.indexOf(q) >= 0;
                row.style.display = match ? '' : 'none';
                if (match) any = true;
            });
            if (emptyEl) {
                if (any) emptyEl.setAttribute('hidden', '');
                else emptyEl.removeAttribute('hidden');
            }
        }
        if (searchEl) {
            searchEl.oninput = applyChipSearch;
            setTimeout(function () { try { searchEl.focus(); } catch (err) { /* ignore */ } }, 0);
        }

        pop.querySelectorAll('.msel-row input[type="checkbox"]').forEach(function (cb) {
            cb.addEventListener('change', function () {
                var row = cb.closest('.msel-row');
                if (!row) return;
                setTopFilterChecked(label, {
                    id: row.getAttribute('data-id'),
                    name: row.getAttribute('data-name')
                }, cb.checked);
                applyTopFilterPopChange(label);
            });
        });

        clearBtn = pop.querySelector('[data-msel="clear"]');
        if (clearBtn) {
            clearBtn.onclick = function (ev) {
                ev.preventDefault();
                /* Updated by Vikas T on 30-09-2026 */
                writeTopFilterSelected(label, []);
                syncTopFilterToAppState();
                pop.querySelectorAll('.msel-row input[type="checkbox"]').forEach(function (cb) { cb.checked = false; });
                if (searchEl) searchEl.value = '';
                applyChipSearch();
                applyTopFilterPopChange(label);
            };
        }
        closeBtn = pop.querySelector('[data-msel="close"]');
        if (closeBtn) {
            closeBtn.onclick = function (ev) {
                ev.preventDefault();
                closeTopFilterPop();
            };
        }

        setTimeout(function () {
            var onDoc = function (ev) {
                if (pop.contains(ev.target)) return;
                if (anchor && anchor.isConnected && anchor.contains(ev.target)) return;
                if (ev.target && ev.target.closest) {
                    var chipBtn = ev.target.closest('[data-chip="' + label + '"]');
                    if (chipBtn) return;
                }
                closeTopFilterPop();
            };
            document.addEventListener('mousedown', onDoc, true);
            pop._onDocClose = onDoc;
        }, 0);
    }

    function clearTopFilters() {
        var i, chip;
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            chip = TOP_FILTER_CHIPS[i];
            /* Updated by Vikas T on 30-09-2026 */
            writeTopFilterSelected(chip.label, []);
        }
        if (typeof window !== 'undefined') window.AppliedUserFilterId = null;
        syncTopFilterToAppState();
        RenderTopFilterChips();
        if (typeof persistState === 'function') persistState();
        /* Restore full dependent chip masters after clear — js/app.js */
        if (typeof window.AppLoadDependentTopFilters === 'function') {
            window.AppLoadDependentTopFilters('', function () {
                RefreshKpiDashboard();
                toast('All filters cleared');
            });
        } else {
            RefreshKpiDashboard();
            toast('All filters cleared');
        }
    }

    function bindTopFilterClear() {
        var btn = document.getElementById('clearFilters');
        var more = document.getElementById('btnMoreFilters');
        if (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                clearTopFilters();
            };
        }
        if (more) {
            more.onclick = function (e) {
                e.preventDefault();
                toast('27 more dimensions available: Program, BU, Practice, Skill, Contract Type, Vendor, Currency...');
            };
        }
    }

    /* Purpose: Load chip options once, paint chips, override app.js static renderChips. */
    function InitTopFilter(onDone) {
        bindTopFilterClear();
        if (typeof window.renderChips === 'function') {
            window.renderChips = RenderTopFilterChips;
        }
        GetTopFilterOption(function () {
            RenderTopFilterChips();
            syncTopFilterToAppState();
            if (onDone) onDone();
        });
    }

    /* =====================================================================
       KPI cards — plotted in aspx (no app.js static HTML)
       DipalI v On 10th sep 2026
       GetAnalyticsDBKPICards: calendar dates + multi-select chip IDs.
       Money unit (aspx): < 1,00,00,000 → Lakhs (₹X.XX L); ≥ → Crores (₹X.XX Cr).
       ===================================================================== */

    var KpiCards = {
        list: [],
        loaded: false
    };

    /* Purpose: Card order / labels for shell plot (Flag matches API registry).
       Added by Vikas T on 16-09-2026 - Utilization / Bench / ActiveProjects bind via
       GetAnalyticsDBKPICards → usp_Whizible2_Sel_AnalyticsDBKPI_{Flag} @DrillLevel=0. */
    var KPI_CARD_DEFS = [
        { flag: 'Revenue', label: 'Revenue', unit: 'Cr' },
        { flag: 'GrossProfit', label: 'Gross Profit', unit: 'Cr' },
        { flag: 'GrossMargin', label: 'Gross Margin', unit: 'Pct' },
        { flag: 'EBIT', label: 'EBIT', unit: 'Cr' },
        { flag: 'NetProfit', label: 'Net Profit', unit: 'Cr' },
        /* Added by Vikas T on 16-09-2026 - Resource Utilization card (Pct from UtilizationPct) */
        { flag: 'Utilization', label: 'Resource Utilization', unit: 'Pct' },
        /* Added by Vikas T on 16-09-2026 - Bench card (FTE from BenchFTE; decrease = favourable) */
        { flag: 'Bench', label: 'Bench', unit: 'FTE' },
        /* Added by Vikas T on 16-09-2026 - Active Projects card (Count from ActiveProjectsCount) */
        { flag: 'ActiveProjects', label: 'Active Projects', unit: 'Count' },
        { flag: 'DelayedProjects', label: 'Delayed Projects', unit: 'Count' },
        { flag: 'BudgetVariance', label: 'Budget Variance', unit: 'Pct' },
        { flag: 'CSAT', label: 'Customer CSAT', unit: 'Score' }
        /* AI Portfolio Health card hidden — removed from KPI_CARD_DEFS */
    ];

    /* Purpose: Chip IDs for KPI/drill. Flag or UI label both work.
       Added by Vikas T on 30-09-2026 - Organization Unit chip stores selection under
       'Organization Unit'; KPI used to read 'Region' so RegionIDs stayed blank. */
    function joinSelectedIds(flagOrLabel) {
        var i, chip, keys, key, arr, seen, out, id;
        if (!flagOrLabel) return '';
        chip = findTopFilterChip(flagOrLabel);
        keys = [flagOrLabel];
        if (chip) keys.push(chip.label, chip.flag);
        if (flagOrLabel === 'Region' || flagOrLabel === 'Organization Unit' ||
            (chip && (chip.flag === 'Region' || chip.label === 'Organization Unit'))) {
            keys.push('Organization Unit', 'Region', 'OrganizationUnit', 'Location');
        }
        out = [];
        seen = {};
        for (i = 0; i < keys.length; i++) {
            key = keys[i];
            arr = (TopFilter.selected && TopFilter.selected[key]) || [];
            if (!arr || !arr.length) continue;
            arr.forEach(function (x) {
                id = x && x.id != null && String(x.id).trim() !== '' ? String(x.id).trim() : '';
                if (!id || seen[id]) return;
                seen[id] = true;
                out.push(id);
            });
        }
        return out.join(',');
    }
    window.joinSelectedIds = joinSelectedIds;

    /* Purpose: Build shared filter bag — dates + checked chip IDs for every KPI SP. */
    function buildKpiCardsRequest(flag) {
        var prevS = DateFilter.previousStart;
        var prevE = DateFilter.previousEnd;
        var customPrev;
        /* Custom period: never reuse stale lastRange previous dates */
        if (isCustomPeriodFlag(DateFilter.selectedFilterName) && DateFilter.startDate && DateFilter.endDate) {
            if (!(DateFilter.compare && isCustomComparisonFlag(DateFilter.selectedComparisonName) && prevS && prevE)) {
                customPrev = computePreviousPeriodEqualLength(DateFilter.startDate, DateFilter.endDate);
                prevS = customPrev.start;
                prevE = customPrev.end;
                DateFilter.previousStart = prevS;
                DateFilter.previousEnd = prevE;
            }
        } else {
            if (!prevS && DateFilter.lastRange) {
                prevS = parseFilterDate(getApiField(DateFilter.lastRange, 'PreviousStartDate'));
            }
            if (!prevE && DateFilter.lastRange) {
                prevE = parseFilterDate(getApiField(DateFilter.lastRange, 'PreviousEndDate'));
            }
            /* Last month + Previous period: never send a compare window from a different as-of
               (Updated SP GETDATE) than the current Last month row (as-of 1 Oct). */
            if (DateFilter.lastRange &&
                (!DateFilter.selectedComparisonName ||
                    isAlignedPreviousPeriodComparison(DateFilter.selectedComparisonName))) {
                var alignedS = parseFilterDate(getApiField(DateFilter.lastRange, 'PreviousStartDate'));
                var alignedE = parseFilterDate(getApiField(DateFilter.lastRange, 'PreviousEndDate'));
                var rangeS = parseFilterDate(getApiField(DateFilter.lastRange, 'CurrentStartDate'));
                var rangeE = parseFilterDate(getApiField(DateFilter.lastRange, 'CurrentEndDate'));
                if (alignedS && alignedE && rangeS && rangeE &&
                    DateFilter.startDate && DateFilter.endDate &&
                    isSameDay(rangeS, DateFilter.startDate) && isSameDay(rangeE, DateFilter.endDate)) {
                    prevS = alignedS;
                    prevE = alignedE;
                    DateFilter.previousStart = prevS;
                    DateFilter.previousEnd = prevE;
                }
            }
        }
        if (!prevS) prevS = DateFilter.startDate;
        if (!prevE) prevE = DateFilter.endDate;
        var body = {
            DashboardID: DASHBOARD_ID,
            CurrentFromDate: formatApiDate(DateFilter.startDate),
            CurrentToDate: formatApiDate(DateFilter.endDate),
            PreviousFromDate: formatApiDate(prevS),
            PreviousToDate: formatApiDate(prevE),
            PortfolioIDs: joinSelectedIds('Portfolio'),
            CustomerIDs: joinSelectedIds('Customer'),
            ProjectManagerIDs: joinSelectedIds('Project Manager'),
            /* Updated by Vikas T on 30-09-2026 - Organization Unit chip → RegionIDs (Utilization / Bench). */
            RegionIDs: joinSelectedIds('Organization Unit'),
            BillingTypeIDs: joinSelectedIds('Billing Type'),
            HealthIDs: joinSelectedIds('Health'),
            RoleID: RoleFilter.selectedId ? parseInt(RoleFilter.selectedId, 10) || null : null,
            UserID: SessionEmployeeID || ''
        };
        if (flag) body.Flag = flag;
        return body;
    }

    /* Purpose: Parse KPI numerics from number/string (commas, currency junk safe). */
    function parseKpiNumeric(raw) {
        var s, m, n;
        if (raw == null || raw === '') return NaN;
        if (typeof raw === 'number') return isFinite(raw) ? raw : NaN;
        if (typeof raw === 'boolean') return NaN;
        s = String(raw).trim();
        if (!s) return NaN;
        /* Plain number / scientific */
        s = s.replace(/,/g, '');
        n = Number(s);
        if (!isNaN(n) && isFinite(n)) return n;
        /* e.g. "S$196560.00", "₹ 1.97 L", "196560.0000 Cr" → first numeric token */
        m = s.match(/-?\d+(\.\d+)?([eE][+-]?\d+)?/);
        if (m) {
            n = Number(m[0]);
            if (!isNaN(n) && isFinite(n)) return n;
        }
        return NaN;
    }

    function getKpiNumber(card) {
        var i, n, raw;
        for (i = 1; i < arguments.length; i++) {
            raw = getApiField(card, arguments[i]);
            if (raw == null || raw === '') continue;
            n = parseKpiNumeric(raw);
            if (!isNaN(n)) return n;
        }
        return 0;
    }

    /* Purpose: Currency from API BaseCurrencyCode / CurrencyCode — display as returned (e.g. USD). */
    function getKpiCurrencySymbol(card) {
        var code = String(getApiField(card, 'BaseCurrencyCode', 'CurrencyCode') || '').trim();
        if (!code) return '\u20B9';
        return code;
    }

    /* Purpose: Prefer API Unit even when blank (0.00 clears Unit at controller). */
    function getCardUnitRaw(card, fallbackUnit) {
        var key, val;
        if (!card || typeof card !== 'object') return String(fallbackUnit || '');
        if (Object.prototype.hasOwnProperty.call(card, 'Unit')) {
            return String(card.Unit == null ? '' : card.Unit).trim();
        }
        key = Object.keys(card).find(function (k) { return String(k).toLowerCase() === 'unit'; });
        if (key != null) {
            val = card[key];
            return String(val == null ? '' : val).trim();
        }
        return String(fallbackUnit || '');
    }

    /* Purpose: Money Units from SP only (k / L / Cr / M / Abs) — UI never re-scales or forces M/Cr. */
    function isMoneyKpiUnit(unit) {
        return /^(k|L|Cr|M|Abs)$/i.test(String(unit || '').trim());
    }

    function isMoneyKpiFlag(flag) {
        return /^(revenue|grossprofit|ebit|netprofit)$/i.test(String(flag || '').trim());
    }

    /* Purpose: Dipali V. 22-09-2026 — BaseCurrencyCode + SP CurrentValue + SP Unit; blank Unit when 0.00. */
    function formatMoneyKpiValue(value, currencySymbol, cardOrCode) {
        var v = parseKpiNumeric(value);
        var sym = currencySymbol || '\u20B9';
        var unit = '';
        if (cardOrCode && typeof cardOrCode === 'object') {
            unit = getCardUnitRaw(cardOrCode, '');
        }
        if (isNaN(v)) v = 0;
        if (Math.abs(v) < 0.005) {
            return escHtml(sym) + ' 0.00';
        }
        if (/^Abs$/i.test(unit) || !unit) {
            return escHtml(sym) + ' ' + v.toFixed(2);
        }
        return escHtml(sym) + ' ' + v.toFixed(2) + ' ' + unit;
    }

    /* Added by Vikas T on 06-10-2026 - card note money is USD 32.48 K (space after the code and before K). */
    function spaceCurrencyInNote(note) {
        var s = String(note || '');
        s = s.replace(/([A-Za-z]{2,4})(\d)/g, '$1 $2');
        s = s.replace(/(\d(?:\.\d+)?)(K|M|L|Cr)\b/gi, '$1 $2');
        return s.replace(/[ ]{2,}/g, ' ');
    }

    /* Purpose: Format card primary value — money uses SP Unit as-is; 0.00 hides Score /5 /100. */
    function formatKpiCardValue(card, fallbackUnit) {
        var unit = getCardUnitRaw(card, fallbackUnit);
        var flag = String(getApiField(card, 'Flag') || '').toLowerCase();
        var rawMoney, v;
        if (isMoneyKpiUnit(unit) || unit === 'Cr' || isMoneyKpiFlag(flag)) {
            rawMoney = getApiField(card, 'CurrentValue', 'CurrentRevenue');
            if (rawMoney != null && /(?:\s|)(Cr|L|M|k)\s*$/i.test(String(rawMoney).trim())) {
                return escHtml(String(rawMoney).trim());
            }
            v = getKpiNumber(card, 'CurrentValue', 'CurrentRevenue');
            return formatMoneyKpiValue(v, getKpiCurrencySymbol(card), card);
        }
        v = getKpiNumber(card, 'CurrentValue', 'CurrentRevenue', 'UtilizationPct', 'BenchFTE', 'ActiveProjectsCount');
        if (unit === 'Pct') return v.toFixed(1) + '%';
        if (unit === 'FTE') return v.toFixed(1) + ' <small>FTE</small>';
        if (unit === 'Count') return String(Math.round(v));
        if (unit === 'Score') {
            if (Math.abs(v) < 0.005) return '0.00';
            if (flag === 'csat') return v.toFixed(2) + ' <small>/ 5</small>';
            return Math.round(v) + ' <small>/ 100</small>';
        }
        if (!unit && Math.abs(v) < 0.005) {
            return (flag === 'csat' || flag === 'portfoliohealth') ? '0.00' : String(Math.round(v));
        }
        return String(Math.round(v));
    }

    /* Purpose: Bind PercentageChange + TrendDirection + TrendColorCode (0% / FLAT → grey). */
    function formatKpiDeltaHtml(card) {
        var delta = getKpiNumber(card, 'DeltaPct', 'PercentageChange');
        var trend = String(getApiField(card, 'Trend', 'TrendDirection') || 'FLAT').toUpperCase();
        var color = String(getApiField(card, 'TrendColorCode') || '').trim();
        var goodUp = getApiField(card, 'GoodUp');
        var arrow, cls, style;
        var flag = String(getApiField(card, 'Flag') || '').toLowerCase();
        var prevVal, nowVal, wentUp, wentDown;
        goodUp = !(goodUp === false || goodUp === 'false' || goodUp === 0);
        /* Added by Vikas T on 30-09-2026 - Util / Bench / Active:
           previous 0 → show 0% (no icon), not 100%. 0% vs prev has no icon.
           Same as previous (now = prev, 100% from SP) still shows the teal caret. */
        if (flag === 'utilization' || flag === 'bench' || flag === 'activeprojects') {
            prevVal = getKpiNumber(card, 'PreviousValue', 'PreviousUtilizationPct', 'PreviousBenchFTE', 'PreviousActiveProjectsCount');
            nowVal = getKpiNumber(card, 'CurrentValue', 'UtilizationPct', 'BenchFTE', 'ActiveProjectsCount');
            if (isNaN(prevVal) || Math.abs(prevVal) < 0.0005) delta = 0;
            wentUp = !isNaN(nowVal) && !isNaN(prevVal) && nowVal > prevVal;
            wentDown = !isNaN(nowVal) && !isNaN(prevVal) && nowVal < prevVal;
            /* Added by Vikas T on 30-09-2026 - vs prev never above 100% (now > prev → 100% with UP caret).
               prev > 0 and now 0 → 0% with DOWN caret (not a flat 0%). */
            if (isNaN(delta)) delta = 0;
            if (Math.abs(delta) > 100) delta = 100;
            if (Math.abs(delta) < 0.05 && !(wentDown && prevVal > 0)) {
                arrow = '';
                cls = 'flat';
                color = '';
            } else if (wentDown) {
                arrow = '<i class="fas fa-caret-down" aria-hidden="true"></i>';
                cls = goodUp ? 'down' : 'up';
            } else if (wentUp) {
                arrow = '<i class="fas fa-caret-up" aria-hidden="true"></i>';
                cls = goodUp ? 'up' : 'down';
            } else {
                arrow = '<i class="fas fa-caret-up" aria-hidden="true"></i>';
                cls = 'up';
                color = '#0D9488';
            }
            if (!color && cls === 'up') color = '#0D9488';
            if (!color && cls === 'down') color = '#E11D48';
            style = color
                ? ' style="color:' + color + ';background-color:' + color + '1f"'
                : '';
            return '<span class="kpi-delta ' + cls + '"' + style + '>' +
                (arrow ? arrow + ' ' : '') + Math.abs(delta).toFixed(1) + '%</span>';
        }
        /* ASCII-safe glyphs — IIS often serves this aspx as Windows-1252, which garbles ▲ ▼ —. */
        if (Math.abs(delta) < 0.05 || trend === 'FLAT' || trend === 'NONE' || !trend) {
            arrow = '<i class="fas fa-minus" aria-hidden="true"></i>';
            cls = 'flat';
            color = '';
        } else if (trend === 'UP') {
            arrow = '<i class="fas fa-caret-up" aria-hidden="true"></i>';
            cls = goodUp ? 'up' : 'down';
        } else if (trend === 'DOWN') {
            arrow = '<i class="fas fa-caret-down" aria-hidden="true"></i>';
            cls = goodUp ? 'down' : 'up';
        } else {
            arrow = '<i class="fas fa-minus" aria-hidden="true"></i>';
            cls = 'flat';
            color = '';
        }
        if (!color && cls === 'up') color = '#0D9488';
        if (!color && cls === 'down') color = '#E11D48';
        style = color
            ? ' style="color:' + color + ';background-color:' + color + '1f"'
            : '';
        return '<span class="kpi-delta ' + cls + '"' + style + '>' +
            arrow + ' ' + Math.abs(delta).toFixed(1) + '%</span>';
    }

    /* Purpose: Resolve delta trend class (up/down/flat) for sparkline color. */
    function getKpiDeltaTrendClass(card) {
        var delta = getKpiNumber(card, 'DeltaPct', 'PercentageChange');
        var trend = String(getApiField(card, 'Trend', 'TrendDirection') || 'FLAT').toUpperCase();
        var goodUp = getApiField(card, 'GoodUp');
        goodUp = !(goodUp === false || goodUp === 'false' || goodUp === 0);
        if (Math.abs(delta) < 0.05 || trend === 'FLAT' || trend === 'NONE' || !trend) return 'flat';
        if (trend === 'UP') return goodUp ? 'up' : 'down';
        if (trend === 'DOWN') return goodUp ? 'down' : 'up';
        return 'flat';
    }

    /*
      Purpose: Mini trend line on drillable money KPI cards.
      Green % → green line sloping up; Red % → red line sloping down; flat → grey.
      Spark not shown on Utilization / Bench / Active Projects.
    */
    /* Purpose: Revenue family — opens GetAnalyticsDBRevenueDrillDown. */
    function isMoneyKpiDrillFlag(flag) {
        var f = String(flag || '').toLowerCase();
        return f === 'revenue' || f === 'grossprofit' || f === 'grossmargin' ||
            f === 'ebit' || f === 'netprofit';
    }

    /* Added by Vikas T on 16-09-2026 - Util / Bench / Active open GetAnalyticsDBKPIDrillDown. */
    function isOpsKpiDrillFlag(flag) {
        var f = String(flag || '').toLowerCase();
        return f === 'utilization' || f === 'bench' || f === 'activeprojects';
    }

    function isKpiDrillableFlag(flag) {
        var f = String(flag || '').toLowerCase();
        return isMoneyKpiDrillFlag(flag) || isOpsKpiDrillFlag(flag) ||
            /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
            f === 'delayedprojects' ||
            /* Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through */
            f === 'budgetvariance' ||
            /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
            f === 'csat';
    }

    /* Purpose: Non-zero CurrentValue (money / % / count) — used for drill cursor. */
    function hasKpiDrillValue(card) {
        /* Added by Dipali V. on 01-10-2026 — treat 0 / 0.0 / 0.00 / 0.0% as empty (no pointer). */
        var n = getKpiNumber(card || {}, 'CurrentValue', 'CurrentRevenue', 'UtilizationPct', 'BenchFTE', 'ActiveProjectsCount');
        return !isNaN(n) && Math.abs(n) > 0;
    }

    /* Purpose: Flag is drillable. Ops KPIs stay clickable at 0 (empty-state modal). */
    function canOpenKpiDrill(flag, card) {
        if (isOpsKpiDrillFlag(flag)) return true;
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for CSAT empty-state drill */
        if (String(flag || '').toLowerCase() === 'csat') return true;
        return isKpiDrillableFlag(flag) && hasKpiDrillValue(card);
    }

    function buildKpiSparkHtml(card, def) {
        var cls, color, data, w = 76, h = 26, mn, mx, rg, pts;
        /* Same as exec.html kpiCard: hide spark/trend graph on CXO cards. Keep API Trend for % delta. */
        return '';
        if (!def || !isKpiDrillableFlag(def.flag) || isOpsKpiDrillFlag(def.flag)) return '';
        cls = getKpiDeltaTrendClass(card || {});
        /* Added by Vikas T on 16-09-2026 - match exec.html design spark (wavy, not a straight slope) */
        if (cls === 'up') {
            color = '#0D9488';
            data = [84, 86, 85, 88, 87, 90];
        } else if (cls === 'down') {
            color = '#E11D48';
            data = [90, 87, 88, 85, 86, 84];
        } else {
            color = '#8A8886';
            data = [86, 85, 87, 86, 85, 86];
        }
        mn = Math.min.apply(null, data);
        mx = Math.max.apply(null, data);
        rg = mx - mn || 1;
        pts = data.map(function (v, idx) {
            return ((idx / (data.length - 1)) * w) + ',' + (h - ((v - mn) / rg) * (h - 4) - 2);
        }).join(' ');
        return '<svg class="spark kpi-spark" width="' + w + '" height="' + h + '" aria-hidden="true">' +
            '<polyline points="' + pts + '" fill="none" stroke="' + color +
            '" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    }

    function findKpiCardByFlagOrLabel(flagOrLabel) {
        var i, list = KpiCards.list || [], name, flag, needle;
        needle = String(flagOrLabel || '').trim().toLowerCase();
        for (i = 0; i < list.length; i++) {
            name = String(getApiField(list[i], 'Label') || '').trim().toLowerCase();
            flag = String(getApiField(list[i], 'Flag') || '').trim().toLowerCase();
            if (name === needle || flag === needle) return list[i];
        }
        return null;
    }

    /* Purpose: Default empty card still shows 0 + currency (not em dash). */
    function buildZeroKpiCard(def, currencySymbol) {
        var card = {
            Flag: def.flag,
            Label: def.label,
            Unit: def.unit,
            CurrentValue: 0,
            DeltaPct: 0,
            PercentageChange: 0,
            Trend: 'FLAT',
            GoodUp: true,
            BaseCurrencyCode: currencySymbol || '\u20B9',
            IsImplemented: true
        };
        return buildKpiCardHtml(def, card);
    }

    /* =====================================================================
       HighLevelRole pill + greeting — DipalI v On 10th sep 2026
       FlagWise Flag=HighLevelRole (single select). On select → greeting API
       with RoleID + UserID (SessionEmployeeID). Time-based Good morning/afternoon/evening/night.
       ===================================================================== */
    var RoleFilter = {
        options: [],
        selectedId: null,
        selectedName: '',
        employeeName: '',
        loaded: false
    };

    /* Purpose: Time-of-day greeting prefix from client clock. */
    function getTimeOfDayGreeting() {
        var h = new Date().getHours();
        if (h >= 5 && h < 12) return 'Good morning';
        if (h >= 12 && h < 17) return 'Good afternoon';
        if (h >= 17 && h < 21) return 'Good evening';
        return 'Good night';
    }

    /* Purpose: Headline — Good morning, {EmployeeName} 👋 */
    function buildGreetingHeadline() {
        var name = String(RoleFilter.employeeName || '').trim();
        var prefix = getTimeOfDayGreeting();
        if (name) return prefix + ', ' + name + ' \uD83D\uDC4B';
        return prefix;
    }

    /* Purpose: Chip count for greeting — selected length, else all options (no filter = all). */
    function getGreetingChipCount(label) {
        var selected = TopFilter.selected[label] || [];
        var chip, opts, i;
        if (selected.length > 0) return selected.length;
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            if (TOP_FILTER_CHIPS[i].label === label) {
                chip = TOP_FILTER_CHIPS[i];
                break;
            }
        }
        opts = (chip && TopFilter.options && TopFilter.options[chip.flag]) || [];
        return opts.length || 0;
    }

    /* Purpose: Comma IDs for SP — selected chips, else all option IDs for that chip. */
    function joinGreetingChipIds(label) {
        var selected = TopFilter.selected[label] || [];
        var chip, opts, i;
        if (selected.length > 0) {
            return selected.map(function (x) { return x.id; }).filter(Boolean).join(',');
        }
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            if (TOP_FILTER_CHIPS[i].label === label) {
                chip = TOP_FILTER_CHIPS[i];
                break;
            }
        }
        opts = (chip && TopFilter.options && TopFilter.options[chip.flag]) || [];
        return opts.map(function (x) { return x.id; }).filter(Boolean).join(',');
    }

    /* Purpose: Project count from SP (Revenue drill L1 project scope). */
    function getGreetingProjectCount() {
        return Math.max(0, Number(GreetingProjectCount.value) || 0);
    }

    /* Purpose: Portfolio count from SP (Revenue drill L1 portfolio rows). */
    function getGreetingPortfolioCount() {
        return Math.max(0, Number(GreetingProjectCount.portfolioCount) || 0);
    }

    /* Purpose: Customer count from SP (distinct customers of L2 projects). */
    function getGreetingCustomerCount() {
        return Math.max(0, Number(GreetingProjectCount.customerCount) || 0);
    }

    /* Purpose: Load consolidated counts — same period + chips as Revenue drill L1/L2. */
    function LoadGreetingProjectCount(onDone) {
        var seq, body;
        if (!TopFilter.loaded) {
            if (onDone) onDone(0);
            return;
        }
        if (!DateFilter.startDate || !DateFilter.endDate) {
            GreetingProjectCount.value = 0;
            GreetingProjectCount.portfolioCount = 0;
            GreetingProjectCount.customerCount = 0;
            GreetingProjectCount.loaded = false;
            ApplyGreetingToDom();
            if (onDone) onDone(0);
            return;
        }
        seq = ++GreetingProjectCount.requestSeq;
        GreetingProjectCount.loading = true;
        /* Same filter bag as buildRevenueDrillRequest:
           not selected → null; selected → comma IDs only (SP treats null as no filter). */
        var emptyToNull = function (s) {
            s = s == null ? '' : String(s).trim();
            return s ? s : null;
        };
        body = {
            DashboardID: DASHBOARD_ID,
            CurrentFromDate: formatApiDate(DateFilter.startDate),
            CurrentToDate: formatApiDate(DateFilter.endDate),
            PortfolioIDs: emptyToNull(joinSelectedIds('Portfolio')),
            CustomerIDs: emptyToNull(joinSelectedIds('Customer')),
            ProjectManagerIDs: emptyToNull(joinSelectedIds('Project Manager')),
            RegionIDs: emptyToNull(joinSelectedIds('Region')),
            BillingTypeIDs: emptyToNull(joinSelectedIds('Billing Type')),
            HealthIDs: emptyToNull(joinSelectedIds('Health'))
        };
        callDashboardApi('GetAnalyticsDBConsolidatedProjectCount', body, function (json) {
            var rows, row, nProj, nPf, nCust, node, depth;
            if (seq !== GreetingProjectCount.requestSeq) return;
            rows = getApiRows(json, 'AnalyticsDBConsolidatedProjectCountModel');
            if (!rows.length) rows = getApiRows(json);
            row = rows[0] || null;
            if (!row) {
                node = json;
                depth = 0;
                while (node && typeof node === 'object' && !Array.isArray(node) && depth < 6) {
                    if (getApiField(node, 'ProjectCount') != null || getApiField(node, 'PortfolioCount') != null) {
                        row = node;
                        break;
                    }
                    if (node.data != null && typeof node.data === 'object') { node = node.data; depth++; continue; }
                    if (node.Data != null && typeof node.Data === 'object') { node = node.Data; depth++; continue; }
                    break;
                }
            }
            nProj = Number(getApiField(row, 'ProjectCount'));
            nPf = Number(getApiField(row, 'PortfolioCount'));
            nCust = Number(getApiField(row, 'CustomerCount'));
            if (isNaN(nProj)) nProj = 0;
            if (isNaN(nPf)) nPf = 0;
            if (isNaN(nCust)) nCust = 0;
            GreetingProjectCount.value = Math.max(0, Math.round(nProj));
            GreetingProjectCount.portfolioCount = Math.max(0, Math.round(nPf));
            GreetingProjectCount.customerCount = Math.max(0, Math.round(nCust));
            GreetingProjectCount.loaded = true;
            GreetingProjectCount.loading = false;
            ApplyGreetingToDom();
            if (onDone) onDone(GreetingProjectCount.value);
        }, function () {
            if (seq !== GreetingProjectCount.requestSeq) return;
            GreetingProjectCount.loading = false;
            if (onDone) onDone(GreetingProjectCount.value);
        });
    }

    /* Purpose: Plain-text subline (fallback). */
    function buildGreetingSubline() {
        var period = DateFilter.selectedFilterName || DEFAULT_DATE_OPTION;
        var projects = getGreetingProjectCount();
        var portfolios = getGreetingPortfolioCount();
        var customers = getGreetingCustomerCount();
        return 'CXO Dashboard' + chartDotSep() + period +
            chartDotSep() + 'consolidated across ' + portfolios + ' Portfolios ' +
            customers + ' Customers  ' + projects + ' Projects';
    }

    /* Purpose: HTML subline — Portfolios >> Customers >> Projects. */
    function buildGreetingSublineHtml() {
        var period = escHtml(DateFilter.selectedFilterName || DEFAULT_DATE_OPTION);
        var projects = getGreetingProjectCount();
        var portfolios = getGreetingPortfolioCount();
        var customers = getGreetingCustomerCount();
        return 'CXO Dashboard' + chartDotSep() + period +
            chartDotSep() + 'consolidated across <b>' + portfolios + '</b> Portfolios  ' +
            '<b>' + customers + '</b> Customers  <b>' + projects + '</b> Projects';
    }

    function greetingBaseCurrencyNoteHtml() {
        return '<div class="exec-base-note" role="note">' +
            '<i class="fas fa-exclamation-triangle" aria-hidden="true"></i>' +
            '<span><b class="note-label">Note</b> All dashboard values are displayed in the configured <b>Base Currency</b>. Revenue, Gross Profit, Gross Margin, EBIT, and Net Profit are based on the <b>latest available Profitability snapshot</b>. If any mismatch is observed, please generate the latest Profitability snapshot and verify the dashboard values.</span>' +
            '</div>';
    }

    /* Purpose: Update greeting DOM without wiping KPI grid when possible. */
    function ApplyGreetingToDom() {
        var host = document.getElementById('page-exec');
        var h1, p;
        if (!host) return;
        h1 = host.querySelector('.exec-greet h1');
        p = host.querySelector('.exec-greet p');
        if (h1) h1.textContent = buildGreetingHeadline();
        if (p) p.innerHTML = buildGreetingSublineHtml();
    }

    /* Added by Dipali - Bind HighLevelRole pill from FlagWise bag (no extra API call). */
    function applyHighLevelRolesFromBag(bag) {
        var key, rows;
        bag = bag || {};
        key = Object.keys(bag).find(function (k) {
            return String(k).replace(/\s/g, '').toLowerCase() === 'highlevelrole';
        });
        rows = key ? bag[key] : [];
        if (!Array.isArray(rows)) rows = getApiRows(rows);
        if (!rows.length) return false;
        RoleFilter.options = normalizeTopFilterRows(rows);
        RoleFilter.loaded = true;
        if (!RoleFilter.selectedId && RoleFilter.options.length) {
            RoleFilter.selectedId = RoleFilter.options[0].id;
            RoleFilter.selectedName = RoleFilter.options[0].name;
        }
        syncRolePillLabel();
        return true;
    }

    /* Purpose: Load HighLevelRole list into RoleFilter (single-select pill).
       Added by Dipali - reuse FlagWise bag when possible. */
    function GetHighLevelRoles(onDone) {
        if (RoleFilter.loaded) {
            if (onDone) onDone(RoleFilter.options);
            return;
        }
        callDashboardApi('GetAnalyticsDBFilterFlagWise', {
            DashboardID: DASHBOARD_ID,
            Flag: 'HighLevelRole'
        }, function (json) {
            applyHighLevelRolesFromBag(getApiDataBag(json) || {});
            if (!RoleFilter.loaded) {
                RoleFilter.options = [];
                RoleFilter.loaded = true;
            }
            if (onDone) onDone(RoleFilter.options);
        }, function () {
            RoleFilter.options = [];
            RoleFilter.loaded = false;
            if (onDone) onDone([]);
        });
    }

    function syncRolePillLabel() {
        var lbl = document.getElementById('roleLabel');
        var sel = document.getElementById('roleSel');
        if (lbl) lbl.textContent = RoleFilter.selectedName || 'Role';
        if (sel) {
            sel.innerHTML = '';
            RoleFilter.options.forEach(function (o) {
                var opt = document.createElement('option');
                opt.value = o.id;
                opt.textContent = o.name;
                if (String(o.id) === String(RoleFilter.selectedId)) opt.selected = true;
                sel.appendChild(opt);
            });
        }
    }

    /* Purpose: Call greeting SP — RoleID + Session UserID → Top 1 EmployeeName. */
    function LoadRoleGreeting(onDone) {
        var roleId = parseInt(RoleFilter.selectedId, 10);
        if (!roleId || roleId <= 0) {
            RoleFilter.employeeName = '';
            ApplyGreetingToDom();
            if (onDone) onDone(null);
            return;
        }
        callDashboardApi('GetAnalyticsDBRoleGreeting', {
            DashboardID: DASHBOARD_ID,
            RoleID: roleId,
            UserID: SessionEmployeeID || ''
        }, function (json) {
            var row = unwrapRoleGreetingRow(json);
            RoleFilter.employeeName = row
                ? String(getApiField(row, 'EmployeeName') || '').trim()
                : '';
            ApplyGreetingToDom();
            if (onDone) onDone(row);
        }, function () {
            RoleFilter.employeeName = '';
            ApplyGreetingToDom();
            if (onDone) onDone(null);
        });
    }

    /* Purpose: Unwrap Success { data: { data: { EmployeeName } } } or array. */
    function unwrapRoleGreetingRow(json) {
        var rows = getApiRows(json);
        var node, depth;
        if (rows && rows.length) return rows[0];
        node = json;
        depth = 0;
        while (node && typeof node === 'object' && !Array.isArray(node) && depth < 6) {
            if (getApiField(node, 'EmployeeName')) return node;
            if (node.data != null && typeof node.data === 'object') { node = node.data; depth++; continue; }
            if (node.Data != null && typeof node.Data === 'object') { node = node.Data; depth++; continue; }
            break;
        }
        return null;
    }

    function selectHighLevelRole(id, name) {
        RoleFilter.selectedId = id;
        RoleFilter.selectedName = name || '';
        syncRolePillLabel();
        LoadRoleGreeting(function () {
            RefreshKpiDashboard();
        });
    }

    /* Purpose: Single-select pop for HighLevelRole (same .pop CSS as chips). */
    function openHighLevelRolePop(e) {
        e.preventDefault();
        e.stopPropagation();
        closeTopFilterPop();
        var opts = RoleFilter.options || [];
        var pop = document.createElement('div');
        var html = '', i, item, sel, anchor, r, current;
        current = String(RoleFilter.selectedId || '');
        pop.className = 'pop';
        html += '<input class="search" placeholder="Search role\u2026">';
        html += '<div class="pop-hd">Role' + chartDotSep() + 'select one</div>';
        if (!opts.length) {
            html += '<div class="pop-item" style="color:var(--muted);cursor:default">No roles</div>';
        }
        for (i = 0; i < opts.length; i++) {
            item = opts[i];
            sel = String(item.id) === current;
            html += '<button type="button" class="pop-item' + (sel ? ' sel' : '') + '" data-id="' + escHtml(item.id) + '" data-name="' + escHtml(item.name) + '">' +
                '<span class="box">' + (sel ? '\u2713' : '') + '</span>' +
                escHtml(item.name) +
                '</button>';
        }
        pop.innerHTML = html;
        document.body.appendChild(pop);
        anchor = e.currentTarget || e.target;
        r = anchor.getBoundingClientRect();
        pop.style.position = 'fixed';
        pop.style.top = (r.bottom + 6) + 'px';
        pop.style.left = Math.min(r.left, window.innerWidth - 250) + 'px';
        pop.style.zIndex = '3000';
        pop.addEventListener('click', function (ev) { ev.stopPropagation(); });
        pop.addEventListener('mousedown', function (ev) { ev.stopPropagation(); });

        var search = pop.querySelector('.search');
        if (search) {
            search.oninput = search.onkeyup = function (ev) {
                var q = String(ev.target.value || '').trim().toLowerCase();
                pop.querySelectorAll('.pop-item[data-id]').forEach(function (it) {
                    var name = (it.getAttribute('data-name') || it.textContent || '').toLowerCase();
                    var match = !q || name.indexOf(q) >= 0;
                    it.classList.toggle('pop-item-hide', !match);
                    it.hidden = !match;
                });
            };
        }

        pop.querySelectorAll('.pop-item[data-id]').forEach(function (it) {
            it.onclick = function () {
                selectHighLevelRole(it.getAttribute('data-id'), it.getAttribute('data-name'));
                closeTopFilterPop();
                if (pop.parentNode) pop.parentNode.removeChild(pop);
            };
        });

        setTimeout(function () {
            var onDoc = function (ev) {
                if (pop.contains(ev.target) || (anchor && anchor.contains(ev.target))) return;
                if (pop.parentNode) pop.parentNode.removeChild(pop);
                document.removeEventListener('mousedown', onDoc, true);
            };
            document.addEventListener('mousedown', onDoc, true);
            pop._onDocClose = onDoc;
        }, 0);
    }

    function bindHighLevelRolePill() {
        var btn = document.getElementById('execRoleBtn');
        if (!btn) return;
        btn.onclick = openHighLevelRolePop;
    }

    /* Purpose: Same toolbar as exec.html — Drill revenue / Export / Share / Copilot. */
    function buildCxoToolbarActionsHtml() {
        return '<div class="hd-actions">' +
            '<button class="ghostbtn" type="button" id="btnDrillRevenue" title="Drill Revenue / Gross Profit / Gross Margin / EBIT / Net Profit">' +
            '<i class="fas fa-level-down-alt"></i> Drill revenue</button>' +
            '<button class="ghostbtn" type="button" id="btnExportShare" title="Export / share / schedule">' +
            '<i class="fas fa-share-alt"></i> Export / Share</button>' +
            '<button class="ghostbtn" type="button" id="btnOpenCopilot" title="Open Copilot">' +
            '<img class="copilot-btn-icon" src="../../../Whizible2.0-new/dist/img/Whizkidlogo.png" alt=""> Copilot</button>' +
            '</div>';
    }

    function bindCxoToolbarActions() {
        var drillBtn = document.getElementById('btnDrillRevenue');
        var shareBtn = document.getElementById('btnExportShare');
        var copilotBtn = document.getElementById('btnOpenCopilot');
        if (drillBtn) {
            drillBtn.onclick = function (e) {
                e.preventDefault();
                if (typeof openRevenueDrill === 'function') openRevenueDrill('Revenue', true);
            };
        }
        if (shareBtn) {
            shareBtn.onclick = function (e) {
                e.preventDefault();
                if (typeof shareMenu === 'function') shareMenu(e);
            };
        }
        if (copilotBtn) {
            copilotBtn.onclick = function (e) {
                e.preventDefault();
                openCopilot();
            };
        }
    }

    /* Purpose: Greeting + kpi-grid with zero placeholders (works without app.js). */
    function RenderKpiShell() {
        var host = document.getElementById('page-exec');
        var html, i, def;
        if (!host) return;
        html = '<div class="cxo-toolbar">' +
            '<div class="exec-greet">' +
            '<h1>' + escHtml(buildGreetingHeadline()) + '</h1>' +
            '<p>' + buildGreetingSublineHtml() + '</p>' +
            '</div>' +
            buildCxoToolbarActionsHtml() +
            '</div>' +
            greetingBaseCurrencyNoteHtml() +
            '<div class="grid kpi-grid" id="kpiGrid">';
        for (i = 0; i < KPI_CARD_DEFS.length; i++) {
            def = KPI_CARD_DEFS[i];
            html += buildZeroKpiCard(def, '\u20B9');
        }
        html += '</div>';
        /* Full exec.html body: Rev+Mix, AI Insights+Budget variance */
        html += buildExecBodyExtrasHtml();
        host.innerHTML = html;
        bindCxoToolbarActions();
        bindKpiDrillClicks();
        InitCxoBlackTooltips(host);
        bindExecBodyExtrasActions();
        plotExecCompanionCharts();
        if (typeof LoadPortfolioRevenueMix === 'function') LoadPortfolioRevenueMix();
    }

    /* Purpose: One HTML card from API row — always bind value / % / currency (0 if empty). */
    function buildKpiCardHtml(def, card) {
        var valueHtml, deltaHtml, note, noteHtml, badge, unit, sparkHtml, canDrill, hasValue;
        card = card || {};
        /* Keep blank Unit from API (0.00) — do not fall back to registry Cr */
        unit = getCardUnitRaw(card, def.unit);
        if (!Object.prototype.hasOwnProperty.call(card, 'Unit')
            && !Object.keys(card).some(function (k) { return String(k).toLowerCase() === 'unit'; })) {
            card.Unit = unit;
        }
        if (!getApiField(card, 'BaseCurrencyCode') && (unit === 'Cr' || isMoneyKpiFlag(def.flag))) {
            card.BaseCurrencyCode = '\u20B9';
        }
        if (getApiField(card, 'CurrentValue') == null && getApiField(card, 'CurrentRevenue') == null) {
            card.CurrentValue = 0;
        }
        if (getApiField(card, 'DeltaPct') == null && getApiField(card, 'PercentageChange') == null) {
            card.DeltaPct = 0;
        }
        if (!getApiField(card, 'Trend') && !getApiField(card, 'TrendDirection')) {
            card.Trend = 'FLAT';
        }
        hasValue = hasKpiDrillValue(card);
        canDrill = canOpenKpiDrill(def.flag, card);
        valueHtml = formatKpiCardValue(card, def.unit);
        deltaHtml = formatKpiDeltaHtml(card);
        sparkHtml = ''; /* Trend spark hidden — same as exec.html */
        /* Note only on value cards (e.g. Revenue / Gross Profit). Never bind on % cards (Gross Margin, etc.). */
        note = '';
        noteHtml = '';
        if (String(unit).toLowerCase() !== 'pct' &&
            String(def.flag || '').toLowerCase() !== 'grossmargin') {
            note = spaceCurrencyInNote(String(getApiField(card, 'Note', 'Insight') || '').trim());
            if (note) {
                noteHtml = '<div class="kpi-ai"><span class="sp">\u2726</span><span>' + escHtml(note) + '</span></div>';
            }
        }
        badge = String(getApiField(card, 'Badge') || '');
        /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects watch badge */
        if (String(def.flag || '').toLowerCase() === 'delayedprojects') {
            badge = Number(getApiField(card, 'CurrentValue') || 0) > 0
                ? '<span class="badge b-risk">watch</span>'
                : '';
        }
        /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects watch badge */
        /* Added By Vyankat b. on 24th Sep 2026 for the CSAT Goal Below badge */
        if (String(def.flag || '').toLowerCase() === 'csat' && badge) {
            var csatBand = badge.toLowerCase();
            var csatCls = 'b-warn';
            if (csatBand.indexOf('above') >= 0) csatCls = 'b-good';
            else if (csatBand.indexOf('goal below') >= 0 || csatBand.indexOf('recovery') >= 0) csatCls = 'b-risk';
            badge = '<span class="badge ' + csatCls + '">' + escHtml(badge) + '</span>';
        }
        /* End of Added By Vyankat b. on 24th Sep 2026 for the CSAT Goal Below badge */
        /* Added by Dipali V. on 01-10-2026 — kpi-zero = 0.00 / 0.0% → no pointer cursor. */
        return '<div class="kpi' + (canDrill ? ' kpi-drill' : '') + (hasValue ? '' : ' kpi-zero') + '" data-kpi-flag="' + escHtml(def.flag) + '"' +
            (canDrill ? ' data-kpi-drill="1" role="button" tabindex="0" title="Click to drill down"' : ' data-kpi-drill="0"') +
            ' data-kpi-zero="' + (hasValue ? '0' : '1') + '">' +
            '<div class="kpi-top"><span class="kpi-label">' + escHtml(def.label) + '</span>' + badge + '</div>' +
            '<div class="kpi-val">' + valueHtml + '</div>' +
            '<div>' + deltaHtml + '<span class="kpi-vs">vs prev period</span></div>' +
            noteHtml +
            sparkHtml +
            '</div>';
    }

    /* Purpose: Plot all KPI cards into #page-exec from API list (aspx-owned markup). */
    function PlotKpiCards() {
        var host = document.getElementById('page-exec');
        var html, i, def, card, currencyHint = '\u20B9';
        if (!host) return;

        /* Prefer BaseCurrencyCode from Revenue (or any money card) for zero stubs */
        for (i = 0; i < (KpiCards.list || []).length; i++) {
            if (getApiField(KpiCards.list[i], 'BaseCurrencyCode')) {
                currencyHint = String(getApiField(KpiCards.list[i], 'BaseCurrencyCode'));
                break;
            }
        }

        html = '<div class="cxo-toolbar">' +
            '<div class="exec-greet">' +
            '<h1>' + escHtml(buildGreetingHeadline()) + '</h1>' +
            '<p>' + buildGreetingSublineHtml() + '</p>' +
            '</div>' +
            buildCxoToolbarActionsHtml() +
            '</div>' +
            greetingBaseCurrencyNoteHtml() +
            '<div class="grid kpi-grid" id="kpiGrid">';
        for (i = 0; i < KPI_CARD_DEFS.length; i++) {
            def = KPI_CARD_DEFS[i];
            card = findKpiCardByFlagOrLabel(def.flag) || findKpiCardByFlagOrLabel(def.label);
            if (!card) {
                html += buildZeroKpiCard(def, currencyHint);
            } else {
                if (!getApiField(card, 'BaseCurrencyCode') && def.unit === 'Cr') {
                    card.BaseCurrencyCode = currencyHint;
                }
                html += buildKpiCardHtml(def, card);
            }
        }
        html += '</div>';
        /* Full exec.html body: Rev+Mix, AI Insights+Budget variance */
        html += buildExecBodyExtrasHtml();
        host.innerHTML = html;
        bindCxoToolbarActions();
        bindKpiDrillClicks();
        InitCxoBlackTooltips(host);
        bindExecBodyExtrasActions();
        plotExecCompanionCharts();
        LoadRevenueCostTrend();
        if (typeof LoadPortfolioRevenueMix === 'function') LoadPortfolioRevenueMix();
    }

    /* Purpose: Keep patch path for partial updates (after PlotKpiCards). */
    function ApplyKpiCardsToDom() {
        PlotKpiCards();
    }

    /* Purpose: Fetch KPI cards, plot, then reveal page (boot) or hide white overlay (refresh).
       Added by Vikas T on 16-09-2026 - same GetAnalyticsDBKPICards response binds
       Resource Utilization, Bench, Active Projects (Flags already in KPI_CARD_DEFS). */
    function GetKpiCards(onDone) {
        function finish(list) {
            if (!PageBootComplete) showDashboardPage();
            else hideLoader();
            if (onDone) onDone(list);
        }
        LoadGreetingProjectCount();
        if (!DateFilter.startDate || !DateFilter.endDate) {
            RenderKpiShell();
            finish([]);
            return;
        }
        callDashboardApi('GetAnalyticsDBKPICards', buildKpiCardsRequest(null), function (json) {
            var rows = getApiRows(json, 'AnalyticsDBKPICardModel');
            if (!rows.length) rows = getApiRows(json);
            KpiCards.list = rows || [];
            KpiCards.loaded = true;
            PlotKpiCards();
            finish(KpiCards.list);
        }, function () {
            RenderKpiShell();
            finish(KpiCards.list || []);
        });
    }

    /* Purpose: Refresh after filter change — white loader covers UI until KPIs rebound. */
    function RefreshKpiDashboard(onDone) {
        if (PageBootComplete) showLoader();
        GetKpiCards(onDone);
    }
    window.RefreshKpiDashboard = RefreshKpiDashboard;

    /* Purpose: Page content refresh without app.js renderPage. */
    function renderPage() {
        RefreshKpiDashboard();
    }

    function bindKpiRenderHook() {
        window.renderPage = renderPage;
    }

    /* =====================================================================
       Revenue vs Cost — trend & forecast chart (SRS §4.1.2)
       Added by Vikas T on 17-09-2026
       API: GetAnalyticsDBRevenueCostTrend → usp_Whizible2_Sel_AnalyticsDB_RevenueCostTrend
       (inline Revenue/Cost logic in SP — no nested EXEC of KPI SPs)
       ===================================================================== */

    var RevenueCostTrend = {
        chart: null,
        meta: null,
        months: [],
        scale: null
    };

    function cssVar(name, fallback) {
        var v = '';
        try {
            v = getComputedStyle(document.documentElement).getPropertyValue(name).trim();
        } catch (e) { v = ''; }
        return v || fallback || '';
    }

    /* Purpose: Widget tools per design — 1 Drill · 2 Refresh · 3 Export/Share · 4 Fullscreen. */
    function buildExecWidgetHtml(id, title, sub, bodyHtml, opts) {
        opts = opts || {};
        return '<div class="widget" id="' + id + '">' +
            '<div class="w-hd"><div>' +
            '<div class="w-title">' + title + '</div>' +
            (sub ? '<div class="w-sub"' + (opts.subId ? ' id="' + opts.subId + '"' : '') + '>' + sub + '</div>' : '') +
            '</div>' +
            '<div class="w-tools">' +
            '<button type="button" class="w-tool" title="Drill down" data-exec-drill="' +
            escHtml(String(opts.drill || 'revenue')) + '" data-exec-widget="' + id + '">' +
            '<i class="fas fa-level-down-alt" aria-hidden="true"></i></button>' +
            '<button type="button" class="w-tool" title="Refresh" data-exec-refresh="' + id + '">' +
            '<i class="fas fa-sync-alt" aria-hidden="true"></i></button>' +
            '<button type="button" class="w-tool" title="Export / share" data-exec-share="' + id + '">' +
            '<i class="fas fa-share-alt" aria-hidden="true"></i></button>' +
            '<button type="button" class="w-tool w-tool-fs" title="Expand to full screen" data-exec-fs="' + id + '">' +
            '<i class="fas fa-expand" aria-hidden="true"></i></button>' +
            '</div></div>' +
            '<div class="w-body">' + bodyHtml + '</div></div>';
    }
 /* Added By Madhuri.K On 24-09-2026*/
    /* Purpose: AI Insights slides — insight list, then the animated Under Construction hold. */
    function execAiInsightsSlidesHtml() {
        return '<div class="ai-uc-deck">' +
            '<div class="ai-uc-track">' +
            '<div class="ai-uc-slide ai-uc-slide-content">' +
            '<div class="ai-item"><div class="ai-ic b-risk"><i class="fas fa-exclamation"></i></div><div><b>Delay prediction:</b> Core Banking Modernization has an <b>81% probability</b> of missing the Sep-20 go-live. Driver: UAT defect inflow 2.3x plan. <div class="conf">Confidence 81% · features: velocity, defect arrival rate, dependency slippage</div></div></div>' +
            '<div class="ai-item"><div class="ai-ic b-warn"><i class="fas fa-rupee-sign"></i></div><div><b>Budget overrun:</b> Wealth Advisory Platform will exceed budget by <b>Rs 64 L (11.4%)</b> at current burn. Suggest converting CR-118 to billable scope. <div class="conf">Confidence 88% · Monte-Carlo P70 on burn rate</div></div></div>' +
            '<div class="ai-item"><div class="ai-ic b-good"><i class="fas fa-magic"></i></div><div><b>Intelligent staffing:</b> Redeploying Farhan Q. and Sameer J. from bench to Fraud Analytics lifts Q2 utilization to <b>89.4%</b> and adds <b>Rs 38 L</b> revenue.</div></div>' +
            '<div class="ai-item"><div class="ai-ic b-info"><i class="fas fa-info"></i></div><div><b>Anomaly:</b> UrbanKart non-billable hours spiked <b>+34%</b> in Jun - 68% logged against &quot;solutioning&quot;. Pattern resembles pre-sales leakage.</div></div>' +
            '<div class="ai-item"><div class="ai-ic b-warn"><i class="fas fa-user-clock"></i></div><div><b>Attrition risk:</b> 3 resources on Payments Switch show elevated attrition signals (overtime + skipped leave + comp band). Backfill lead time ~7 weeks.</div></div>' +
            '<div class="ai-item"><div class="ai-ic b-good"><i class="fas fa-chart-line"></i></div><div><b>Revenue forecast:</b> Q2 FY27 projected at P50. Upside tied to Vega MES Phase-2 (Rs 2.1 Cr, 74% win probability).</div></div>' +
            '</div>' +
            '<div class="ai-uc-slide ai-uc-slide-hold">' +
            '<div class="ai-under-construction" role="status">' +
            '<div class="ai-uc-mascot" aria-hidden="true">' +
            '<div class="ai-uc-hat"></div>' +
            '<div class="ai-uc-face">' +
            '<div class="ai-uc-eye"><span class="ai-uc-lid"></span><span class="ai-uc-pupil"></span></div>' +
            '<div class="ai-uc-eye"><span class="ai-uc-lid"></span><span class="ai-uc-pupil"></span></div>' +
            '</div>' +
            '</div>' +
            '<div class="ai-uc-title">Under Construction</div>' +
            '<div class="ai-uc-sub">This section will be available shortly.</div>' +
            '<div class="ai-uc-tape" aria-hidden="true"></div>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '<div class="ai-uc-dots" aria-hidden="true"><span></span><span></span></div>' +
            '</div>';
    }

    /* Purpose: Full exec.html sections under KPI grid (Rev+Mix, AI+Var). */
    function buildExecBodyExtrasHtml() {
        var revCard = findKpiCardByFlagOrLabel('Revenue') || {};
        var revN = parseKpiNumeric(getApiField(revCard, 'CurrentValue', 'CurrentRevenue'));
        var cur = String(getApiField(revCard, 'BaseCurrencyCode') || '\u20B9');

        return '<div class="grid g2 mt" id="cxoChartRow">' +
            buildExecWidgetHtml(
                'wRevCost',
                'Revenue vs Cost - trend &amp; forecast',
                'Actuals to \u2014' + chartDotSep() + 'dotted = trend-based forecast' + chartDotSep() + 'shaded = compare period',
                '<div class="chartbox chartbox-rev"><canvas id="chRev" aria-label="Revenue vs Cost trend chart"></canvas></div>',
                { subId: 'chRevSub', drill: 'revenue' }
            ) +
            buildExecWidgetHtml(
                'wMix',
                'Portfolio revenue mix',
                'Click a slice to drill into that portfolio',
                '<div class="chartbox doughnut-box chartbox-mix">' +
                '<canvas id="chMix" aria-label="Portfolio revenue mix chart"></canvas>' +
                '<div class="doughnut-center" id="chMixCenter">' +
                '<span class="doughnut-center-label">Total</span>' +
                '<span class="doughnut-center-value"></span>' +
                '</div>' +
                '<div class="mix-no-data" id="chMixNoData">No Data Available</div>' +
                '</div>',
                { drill: 'mix' }
            ) +
            '</div>' +
            '<div class="grid g2 mt" id="cxoAiVarRow">' +
            '<div class="ai-panel" id="aiInsightsExec">' +
            '<div class="ai-hd">' +
            '<span class="pulse"></span>' +
            '<span class="ai-hd-title">AI Insights &amp; Recommended Actions</span>' +
            '<span class="badge b-info" style="margin-left:auto">6 new</span>' +
            '</div>' +
            '<div class="ai-panel-body" id="aiInsightsBody">' +
            execAiInsightsSlidesHtml() +
            '</div>' +
            '</div>' +
            buildExecWidgetHtml(
                'wVar',
                'Cost &amp; budget variance by project',
                'Bars beyond 100% burn are flagged · click to drill to spend...',
                '<div class="cxo-budget-legend"><span class="cxo-budget-legend-dot"></span><span>Budget burn %</span></div>' +
                '<div class="chartbox chartbox-lg">' +
                  '<canvas id="chVar" aria-label="Cost and budget variance by project"></canvas>' +
                  '<div class="mix-no-data" id="chVarNoData">No Data Available</div>' +
                '</div>' +
                '<div class="cxo-budget-note">Projects above 100% are highlighted as over budget.</div>',
                { drill: 'budget' }
            ) +
            '</div>';
    }

    function buildRevenueCostChartShellHtml() {
        return buildExecBodyExtrasHtml();
    }

    function syncWidgetFsButton(el, open) {
        var btn = el && el.querySelector('.w-tool-fs, [data-exec-fs]');
        var icon;
        if (!btn) return;
        btn.title = open ? 'Close' : 'Expand to full screen';
        btn.setAttribute('aria-label', btn.title);
        icon = btn.querySelector('i');
        if (icon) icon.className = open ? 'fas fa-times' : 'fas fa-expand';
    }

    /* Purpose: Match exec.html toggleFS — clone + dimmed backdrop (dashboard stays visible behind). */
    function closeWidgetFullscreen() {
        document.querySelectorAll('.widget-fs-clone').forEach(function (x) {
            if (x.parentNode) x.parentNode.removeChild(x);
        });
        var backdrop = document.getElementById('widgetFsBackdrop');
        if (backdrop && backdrop.parentNode) backdrop.parentNode.removeChild(backdrop);
        document.body.classList.remove('widget-fs-open');
         /* Added By Madhuri.K On 24-09-2026*/
        CxoFsHover.canvas = null;
        CxoFsHover.chart = null;
        cxoHideAllChartTips();
        document.querySelectorAll('.widget.fs').forEach(function (el) {
            el.classList.remove('fs');
            syncWidgetFsButton(el, false);
        });
    }

    function copyWidgetCanvases(src, clone) {
        var from = src.querySelectorAll('canvas');
        var to = clone.querySelectorAll('canvas');
        var i, c, d, box;
        for (i = 0; i < from.length; i++) {
            c = from[i];
            d = to[i];
            if (!d) continue;
            try {
                d.width = c.width;
                d.height = c.height;
                d.getContext('2d').drawImage(c, 0, 0);
                box = d.closest('.doughnut-box, .chartbox-mix');
                if (box) {
                    d.style.width = 'auto';
                    d.style.height = '100%';
                    d.style.maxWidth = '100%';
                    d.style.aspectRatio = '1 / 1';
                    d.style.objectFit = 'contain';
                    d.style.display = 'block';
                    d.style.margin = '0 auto';
                }
            } catch (err) { /* ignore */ }
        }
    }
 /* Added By Madhuri.K On 24-09-2026*/
    var CxoFsHover = { canvas: null, chart: null };

    function cxoHideAllChartTips() {
        ['cxoRevCostTooltip', 'cxoBudgetVarTooltip', 'cxoMixTooltip'].forEach(function (id) {
            var tip = document.getElementById(id);
            if (tip) {
                tip.classList.remove('open');
                tip.classList.remove('cxo-tip-dark');
            }
        });
        [RevenueCostTrend && RevenueCostTrend.chart,
            BudgetVarianceChart && BudgetVarianceChart.instance,
            MixChart && MixChart.instance].forEach(function (chart) {
            if (!chart || !chart.tooltip) return;
            try {
                chart.tooltip.setActiveElements([], { x: 0, y: 0 });
                if (typeof chart.setActiveElements === 'function') chart.setActiveElements([]);
                chart.update('none');
            } catch (err) { /* ignore */ }
        });
    }

    function cxoIsExpandedView() {
        return document.body.classList.contains('widget-fs-open') ||
            document.body.classList.contains('mix-fs-open') ||
            !!document.getElementById('portfolioMixFullscreenOverlay');
    }

    function cxoPrepareExternalTip(tip, tipId, chart) {
        var expanded = cxoIsExpandedView();
        if (!tip) return false;
        /* Expanded mix uses the live Chart.js black tip — hide the HTML card. */
        if (document.body.classList.contains('mix-fs-open') ||
            document.getElementById('portfolioMixFullscreenOverlay')) {
            tip.classList.remove('open');
            return false;
        }
        /* While a widget is expanded, only the forwarded clone hover may show a tip. */
        if (document.body.classList.contains('widget-fs-open')) {
            if (!CxoFsHover.canvas || CxoFsHover.chart !== chart) {
                tip.classList.remove('open');
                return false;
            }
        }
        ['cxoRevCostTooltip', 'cxoBudgetVarTooltip', 'cxoMixTooltip'].forEach(function (id) {
            if (id === tipId) return;
            var other = document.getElementById(id);
            if (other) other.classList.remove('open');
        });
        tip.classList.toggle('cxo-tip-dark', !!expanded);
        return true;
    }

    function cxoChartForWidget(srcId) {
        if (srcId === 'wRevCost') return RevenueCostTrend && RevenueCostTrend.chart;
        if (srcId === 'wVar') return BudgetVarianceChart && BudgetVarianceChart.instance;
        if (srcId === 'wMix') return MixChart && MixChart.instance;
        return null;
    }

    function clonePointToChartEvent(cloneCanvas, chart, evt) {
        var cr = cloneCanvas.getBoundingClientRect();
        var rx = cr.width ? (evt.clientX - cr.left) / cr.width : 0;
        var ry = cr.height ? (evt.clientY - cr.top) / cr.height : 0;
        if (rx < 0) rx = 0;
        if (rx > 1) rx = 1;
        if (ry < 0) ry = 0;
        if (ry > 1) ry = 1;
        /* Chart.js: when `native` is on the event, x/y must be chart-pixel coords (not clientX/Y). */
        return {
            type: evt.type,
            native: evt,
            x: rx * chart.width,
            y: ry * chart.height
        };
    }
    

    function forwardChartHover(chart, cloneCanvas, evt) {
        var fake, elements, mode, pos, intersect;
        if (!chart || typeof chart.getElementsAtEventForMode !== 'function' || !chart.tooltip) return;
        CxoFsHover.canvas = cloneCanvas;
        CxoFsHover.chart = chart;
        fake = clonePointToChartEvent(cloneCanvas, chart, evt);
        mode = (chart.options && chart.options.interaction && chart.options.interaction.mode) || 'nearest';
        intersect = (chart.options && chart.options.interaction && typeof chart.options.interaction.intersect === 'boolean')
            ? chart.options.interaction.intersect
            : (mode !== 'index');
        elements = chart.getElementsAtEventForMode(fake, mode, { intersect: intersect }, false);
        pos = { x: fake.x, y: fake.y };
        chart.tooltip.setActiveElements(elements, pos);
        if (typeof chart.setActiveElements === 'function') chart.setActiveElements(elements);
        chart.update('none');
    }

    function clearChartHover(chart) {
        CxoFsHover.canvas = null;
        CxoFsHover.chart = null;
        if (!chart || !chart.tooltip) return;
        chart.tooltip.setActiveElements([], { x: 0, y: 0 });
        if (typeof chart.setActiveElements === 'function') chart.setActiveElements([]);
        chart.update('none');
    }

    function forwardChartClick(chart, cloneCanvas, evt) {
        var fake, elements, mode, intersect;
        if (!chart || !chart.options || typeof chart.options.onClick !== 'function') return;
        fake = clonePointToChartEvent(cloneCanvas, chart, evt);
        mode = (chart.options.interaction && chart.options.interaction.mode) || 'nearest';
        intersect = (chart.options.interaction && typeof chart.options.interaction.intersect === 'boolean')
            ? chart.options.interaction.intersect
            : (mode !== 'index');
        elements = chart.getElementsAtEventForMode(fake, mode, { intersect: intersect }, false);
        if (!elements || !elements.length) return;
        closeWidgetFullscreen();
        chart.options.onClick.call(chart, fake, elements, chart);
    }

    function bindFullscreenChartHover(clone, srcId) {
        if (!clone) return;
        clone.querySelectorAll('canvas').forEach(function (canvas) {
            if (canvas.getAttribute('data-fs-hover') === '1') return;
            canvas.setAttribute('data-fs-hover', '1');
            canvas.style.cursor = 'pointer';
            canvas.addEventListener('mousemove', function (evt) {
                var chart = cxoChartForWidget(srcId);
                if (chart) forwardChartHover(chart, canvas, evt);
            });
            canvas.addEventListener('mouseleave', function () {
                var chart = cxoChartForWidget(srcId);
                if (chart) clearChartHover(chart);
            });
            canvas.addEventListener('click', function (evt) {
                var chart = cxoChartForWidget(srcId);
                if (chart) forwardChartClick(chart, canvas, evt);
            });
        });
    }

    function placeCxoExternalTip(tip, chart, tooltipModel) {
        var anchor = chart.canvas;
        var caretX = tooltipModel.caretX;
        var caretY = tooltipModel.caretY;
        var canvasRect, left, top, tw, th, box;
        if (CxoFsHover.canvas && CxoFsHover.chart === chart && chart.width && chart.height) {
            anchor = CxoFsHover.canvas;
            box = anchor.getBoundingClientRect();
            caretX = caretX * (box.width / chart.width);
            caretY = caretY * (box.height / chart.height);
        }
        canvasRect = anchor.getBoundingClientRect();
        left = canvasRect.left + window.pageXOffset + caretX + 10;
        top = canvasRect.top + window.pageYOffset + caretY - 8;
        tw = tip.offsetWidth || 160;
        th = tip.offsetHeight || 70;
        if (left + tw > window.pageXOffset + window.innerWidth - 8) {
            left = canvasRect.left + window.pageXOffset + caretX - tw - 10;
        }
        if (top + th > window.pageYOffset + window.innerHeight - 8) {
            top = window.pageYOffset + window.innerHeight - th - 8;
        }
        if (top < window.pageYOffset + 8) top = window.pageYOffset + 8;
        tip.style.left = left + 'px';
        tip.style.top = top + 'px';
    }

    function bindWidgetFsCloneActions(clone, srcId) {
        if (!clone) return;
        clone.querySelectorAll('[data-exec-fs]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                closeWidgetFullscreen();
            };
        });
        clone.querySelectorAll('[data-exec-drill]').forEach(function (btn) {
            btn.onclick = function (e) {
                var kind;
                e.preventDefault();
                e.stopPropagation();
                kind = String(btn.getAttribute('data-exec-drill') || 'revenue').toLowerCase();
                closeWidgetFullscreen();
                //Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill button uses the mix drill-down
                if (kind === 'mix' || srcId === 'wMix') {
                    closeWidgetFullscreen();
                    openMixRevenueDrillAll();
                    return;
                }
                //End of Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill button uses the mix drill-down
                /* Revenue vs Cost drill button — never Mix SP */
                if (srcId === 'wRevCost' || kind === 'revenue') {
                    if (typeof openRevenueDrill === 'function') openRevenueDrill('Revenue', true);
                    return;
                }
                if (kind === 'budget' || srcId === 'wVar') {
                    closeWidgetFullscreen();
                    if (typeof openBudgetVarianceDrill === 'function') openBudgetVarianceDrill(true);
                    return;
                }
                if (kind === 'projects' || kind === 'activeprojects') {
                    closeWidgetFullscreen();
                    if (typeof openOpsKpiDrill === 'function') openOpsKpiDrill('ActiveProjects');
                }
            };
        });
        clone.querySelectorAll('[data-exec-refresh]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                if (btn.getAttribute('data-exec-refresh') === 'wRevCost' || srcId === 'wRevCost') {
                    LoadRevenueCostTrend();
                } else if (btn.getAttribute('data-exec-refresh') === 'wMix' || srcId === 'wMix') {
                    LoadPortfolioRevenueMix();
                } else if (btn.getAttribute('data-exec-refresh') === 'wVar' || srcId === 'wVar') {
                    LoadCostBudgetVarianceByProject();
                } else {
                    plotExecCompanionCharts();
                }
                toast('Widget refreshed');
                /* Recopy after chart redraw */
                setTimeout(function () {
                    var src = document.getElementById(srcId);
                    var live = document.querySelector('.widget-fs-clone[data-fs-src="' + srcId + '"]');
                    if (src && live) copyWidgetCanvases(src, live);
                }, 400);
            };
        });
        clone.querySelectorAll('[data-exec-share]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                openWidgetExportMenu(e, srcId);
            };
        });
    }

    function toggleWidgetFullscreen(id) {
        var src = document.getElementById(id);
        var openClone = document.querySelector('.widget-fs-clone');
        var backdrop, clone, host;
        if (openClone) {
            var wasSame = openClone.getAttribute('data-fs-src') === id;
            closeWidgetFullscreen();
            if (wasSame || !src) return;
        }
        if (!src) return;

        /* Host = body (same as exec.html). Keep outside transformed ancestors so fixed + dim cover the iframe. */
        host = document.body;

        backdrop = document.getElementById('widgetFsBackdrop');
        if (!backdrop) {
            backdrop = document.createElement('div');
            backdrop.id = 'widgetFsBackdrop';
            backdrop.className = 'widget-fs-backdrop';
            backdrop.setAttribute('aria-hidden', 'true');
            backdrop.onclick = function () { closeWidgetFullscreen(); };
        }
        if (backdrop.parentNode !== host) host.appendChild(backdrop);

        clone = src.cloneNode(true);
        clone.classList.add('fs', 'widget-fs-clone');
        clone.setAttribute('data-fs-src', id);
        clone.setAttribute('role', 'dialog');
        clone.setAttribute('aria-modal', 'true');
        clone.id = id + '-fsclone';
        clone.querySelectorAll('[id]').forEach(function (n) {
            if (n !== clone && n.id) n.id = n.id + '-fsclone';
        });
        syncWidgetFsButton(clone, true);
        host.appendChild(clone);
        document.body.classList.add('widget-fs-open');
        cxoHideAllChartTips();
        bindWidgetFsCloneActions(clone, id);
        bindFullscreenChartHover(clone, id);

        requestAnimationFrame(function () {
            copyWidgetCanvases(src, clone);
            requestAnimationFrame(function () { copyWidgetCanvases(src, clone); });
        });
    }

    function toggleRevenueCostFullscreen() {
        toggleWidgetFullscreen('wRevCost');
    }

    /* Added by Aditya J. on 15-09-2026 — Portfolio Revenue Mix (ported from Aditya page). */
    var MixChart = {
        instance: null,
        fullscreenInstance: null,
        items: [],
        colors: ['#479EF5', '#54B054', '#EAA300', '#9373C0', '#DC626D', '#4DB1D3', '#EA580C', '#0D9488']
    };

    function exportPortfolioMixExcel() {
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        var total = getPortfolioMixTotal(MixChart.items || []);
        if (total <= 0) {
            if (typeof alertify !== 'undefined') {
                try { alertify.set('notifier', 'position', 'top-right'); } catch (e) { /* ignore */ }
                alertify.error('There are no records to show.');
            } else {
                showAlertError('There are no records to show.');
            }
            return;
        }
        downloadDashboardExcel(
            'ExportAnalyticsDBPortfolioRevenueMixExcel',
            buildKpiCardsRequest(null),
            'Portfolio-Revenue-Mix.xls'
        );
    }

    function LoadPortfolioRevenueMix() {
        var canvas = document.getElementById('chMix');
        if (!canvas) return;
        if (!DateFilter.startDate || !DateFilter.endDate) {
            MixChart.items = [];
            drawPortfolioMixChart([]);
            return;
        }
        MixChart.items = [];
        callDashboardApi('GetAnalyticsDBPortfolioRevenueMix', buildKpiCardsRequest(null), function (json) {
            var rows = getApiRows(json, 'AnalyticsDBPortfolioRevenueMixItemModel');
            if (!rows.length) rows = getApiRows(json);
            MixChart.items = rows || [];
            loadPortfolioMixProjectCounts(MixChart.items, function () {
                drawPortfolioMixChart(MixChart.items);
            });
        }, function () {
            MixChart.items = [];
            drawPortfolioMixChart([]);
        });
    }

    function getPortfolioMixTotal(data) {
        var total = 0, i, raw;
        data = data || [];
        for (i = 0; i < data.length; i++) {
            raw = Number(getApiField(data[i], 'Revenue'));
            if (!isNaN(raw)) total += raw;
        }
        return total;
    }

    //Added by Aditya J. on 01-10-2026 Level 1 drill share uses the same percent as the doughnut hover
    function portfolioMixHoverSharePct(portfolioId, portfolioName) {
        var items = (typeof MixChart !== 'undefined' && MixChart.items) ? MixChart.items : [];
        var total = getPortfolioMixTotal(items);
        var i, row, id, name, revenue, wantName;
        if (!(total > 0) || !items.length) return null;
        wantName = String(portfolioName || '').trim().toLowerCase();
        for (i = 0; i < items.length; i++) {
            row = items[i];
            id = getApiField(row, 'PortfolioID');
            name = String(getApiField(row, 'PortfolioName') || '').trim().toLowerCase();
            revenue = Number(getApiField(row, 'Revenue'));
            if (isNaN(revenue)) revenue = 0;
            if (portfolioId != null && !isNaN(portfolioId) && id != null && String(id) !== '' && Number(id) === Number(portfolioId)) {
                return (revenue / total) * 100;
            }
            if (wantName && name === wantName) return (revenue / total) * 100;
        }
        return null;
    }
    //End of Added by Aditya J. on 01-10-2026 Level 1 drill share uses the same percent as the doughnut hover

    function isPortfolioMixDollarCurrency(symbol) {
        var s = String(symbol || '').trim().toUpperCase();
        return s === '$' || s === 'USD' || s.indexOf('USD') >= 0 || s.indexOf('$') >= 0;
    }

    function getPortfolioMixCurrency(data) {
        var i, value;
        data = data || [];
        for (i = 0; i < data.length; i++) {
            value = getApiField(data[i], 'BaseCurrencyCode');
            //Added by Aditya J. on 29-09-2026 Show $ for USD the same way as the Revenue card
            if (value != null && String(value).trim() !== '') return getKpiCurrencySymbol({ BaseCurrencyCode: String(value) });
            //End of Added by Aditya J. on 29-09-2026 Show $ for USD the same way as the Revenue card
        }
        return '\u20B9';
    }

    function updatePortfolioMixTotal(data) {
        var center = document.getElementById('chMixCenter');
        var valueEl = center ? center.querySelector('.doughnut-center-value') : null;
        var noDataEl = document.getElementById('chMixNoData');
        var total = getPortfolioMixTotal(data);
        var symbol = getPortfolioMixCurrency(data);
        if (total <= 0) {
            if (center) center.style.display = 'none';
            if (noDataEl) {
                noDataEl.textContent = 'No Data Available';
                noDataEl.style.display = 'flex';
            }
            if (valueEl) valueEl.textContent = '';
            return 0;
        }
        if (center) center.style.display = 'flex';
        if (noDataEl) noDataEl.style.display = 'none';
        if (valueEl) valueEl.textContent = formatPortfolioMixMoney(total, symbol);
        return total;
    }

    function formatPortfolioMixMoney(value, symbol) {
        var n = Number(value) || 0;
        var unit = '';
        var i, formatted, match, explicit;
        var data = (typeof MixChart !== 'undefined' && MixChart.items) ? MixChart.items : [];
        for (i = 0; i < data.length; i++) {
            explicit = getApiField(data[i], 'Unit');
            if (explicit != null && String(explicit).trim() !== '' && !/^Abs$/i.test(String(explicit).trim())) {
                unit = String(explicit).trim();
                break;
            }
            formatted = getApiField(data[i], 'RevenueFormatted');
            if (formatted == null) continue;
            match = String(formatted).trim().match(/(?:^|\s)(k|L|Cr|M)\s*$/i);
            if (match) {
                unit = match[1];
                break;
            }
        }
        //Added by Aditya J. on 01-10-2026 Space between the currency symbol and the value
        return String(symbol || '\u20B9') + ' ' +
            n.toLocaleString('en-IN', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }) + (unit ? ' ' + unit : '');
        //End of Added by Aditya J. on 01-10-2026 Space between the currency symbol and the value
    }

    function formatPortfolioMixRevenue(value, symbol) {
        return formatPortfolioMixMoney(value, symbol);
    }

    function getPortfolioMixProjectCount(row) {
        var keys = ['ProjectCount', 'Projects', 'Project', 'MappedProjectCount', 'NoOfProjects', 'ProjectCountMapped'];
        var i, v, n;
        if (!row) return 0;
        for (i = 0; i < keys.length; i++) {
            v = getApiField(row, keys[i]);
            if (v != null && String(v).trim() !== '') {
                n = Number(v);
                if (!isNaN(n)) return Math.max(0, Math.round(n));
            }
        }
        return 0;
    }

    function loadPortfolioMixProjectCounts(items, done) {
        var request, existingMap = {}, i, pid;
        items = items || [];
        done = done || function () { };
        if (!items.length) {
            done();
            return;
        }
        for (i = 0; i < items.length; i++) {
            pid = getApiField(items[i], 'PortfolioID');
            if (pid != null && pid !== '') existingMap[String(pid)] = getPortfolioMixProjectCount(items[i]);
        }
        request = buildRevenueDrillRequest({
            level: 1,
            portfolioId: null,
            projectId: null,
            invoiceId: null
        });
        callDashboardApi(
            'GetAnalyticsDBPortfolioRevenueMixDrillDown',
            request,
            function (json) {
                var payload = unwrapDrillPayload(json);
                var rows = payload.Rows || payload.rows || [];
                var r, id, count;
                if (!Array.isArray(rows)) rows = [];
                for (i = 0; i < rows.length; i++) {
                    r = rows[i];
                    id = getApiField(r, 'PortfolioID');
                    if (id == null || id === '') id = getApiField(r, 'ProjectGroupID');
                    if (id == null || id === '') continue;
                    count = getPortfolioMixProjectCount(r);
                    //Added by Aditya J. on 28-09-2026 Keep the mix slice project count when this level has no project total
                    if (count > 0 || !(existingMap[String(id)] > 0)) existingMap[String(id)] = count;
                    //End of Added by Aditya J. on 28-09-2026 Keep the mix slice project count when this level has no project total
                }
                for (i = 0; i < items.length; i++) {
                    pid = getApiField(items[i], 'PortfolioID');
                    if (pid != null && existingMap[String(pid)] != null) {
                        items[i]._projectCount = existingMap[String(pid)];
                    }
                }
                done();
            },
            function () {
                for (i = 0; i < items.length; i++) {
                    if (items[i]._projectCount == null) items[i]._projectCount = getPortfolioMixProjectCount(items[i]);
                }
                done();
            }
        );
    }
 /* Added By Madhuri.K On 24-09-2026*/
    /* Place Total in the doughnut hole, below the legend, so the label stays centered. */
    function alignDoughnutCenterLabel(chart, centerId) {
        var center = document.getElementById(centerId);
        var area;
        if (!center || !chart || !chart.chartArea) return;
        area = chart.chartArea;
        center.style.position = 'absolute';
        center.style.inset = 'auto';
        center.style.transform = 'none';
        center.style.margin = '0';
        center.style.top = area.top + 'px';
        center.style.left = area.left + 'px';
        center.style.width = Math.max(0, area.right - area.left) + 'px';
        center.style.height = Math.max(0, area.bottom - area.top) + 'px';
        center.style.right = 'auto';
        center.style.bottom = 'auto';
        center.style.display = 'flex';
        center.style.flexDirection = 'column';
        center.style.alignItems = 'center';
        center.style.justifyContent = 'center';
        center.style.textAlign = 'center';
    }

    /* Added by Aditya J. on 29-09-2026 Long portfolio names stay short on the legend and full on hover */
    function mixLegendLabels(chart) {
        var gen = null;
        var items, i, full, maxChars;
        if (typeof Chart !== 'undefined' && Chart.overrides && Chart.overrides.doughnut &&
            Chart.overrides.doughnut.plugins && Chart.overrides.doughnut.plugins.legend &&
            Chart.overrides.doughnut.plugins.legend.labels) {
            gen = Chart.overrides.doughnut.plugins.legend.labels.generateLabels;
        }
        if (!gen && typeof Chart !== 'undefined' && Chart.defaults && Chart.defaults.plugins &&
            Chart.defaults.plugins.legend && Chart.defaults.plugins.legend.labels) {
            gen = Chart.defaults.plugins.legend.labels.generateLabels;
        }
        if (gen) {
            items = gen(chart);
        } else {
            items = ((chart && chart.data && chart.data.labels) || []).map(function (text, index) {
                var colors = chart.data.datasets && chart.data.datasets[0] ? chart.data.datasets[0].backgroundColor : [];
                return {
                    text: String(text || ''),
                    fillStyle: colors[index],
                    strokeStyle: colors[index],
                    hidden: false,
                    index: index,
                    datasetIndex: 0
                };
            });
        }
        maxChars = (chart && chart.width && chart.width < 480) ? 16 : 24;
        //Added by Aditya J. on 01-10-2026 Share sits outside the doughnut; a long portfolio name shows its first half
        var mixValues = (chart && chart.data && chart.data.datasets && chart.data.datasets[0] && chart.data.datasets[0].data) || [];
        var mixTotal = 0;
        var mixIndex;
        for (mixIndex = 0; mixIndex < mixValues.length; mixIndex++) mixTotal += Number(mixValues[mixIndex]) || 0;
        //End of Added by Aditya J. on 01-10-2026 Share sits outside the doughnut; a long portfolio name shows its first half
        for (i = 0; i < items.length; i++) {
            full = String((chart.data.labels && chart.data.labels[items[i].index]) || items[i].text || '');
            //Added by Aditya J. on 01-10-2026 Share sits outside the doughnut; a long portfolio name shows its first half
            var shownName = full;
            var sliceValue = Number(mixValues[items[i].index]) || 0;
            var shareText = (mixTotal > 0 ? (sliceValue / mixTotal) * 100 : 0).toFixed(1) + '%';
            if (full.length > maxChars) shownName = full.slice(0, Math.ceil(full.length / 2));
            items[i].text = shownName + '  ' + shareText;
            //End of Added by Aditya J. on 01-10-2026 Share sits outside the doughnut; a long portfolio name shows its first half
        }
        return items;
    }

    function mixChartLegendPlugin(visible) {
        return {
            display: visible !== false,
            labels: {
                boxWidth: 10,
                boxHeight: 10,
                usePointStyle: true,
                font: { size: 11 },
                generateLabels: function (chart) { return mixLegendLabels(chart); }
            },
            onHover: function (e, legendItem, legend) {
                var chart = legend && legend.chart;
                var nativeEvt = e && (e.native || e);
                if (nativeEvt && nativeEvt.target) nativeEvt.target.style.cursor = 'pointer';
                openMixSliceTooltip(chart, legendItem ? legendItem.index : -1, nativeEvt);
            },
            onLeave: function (e) {
                var nativeEvt = e && (e.native || e);
                var tip = document.getElementById('cxoMixTooltip');
                if (nativeEvt && nativeEvt.target) nativeEvt.target.style.cursor = '';
                if (tip) tip.classList.remove('open');
            }
        };
    }

    function ensureMixTip() {
        var tip = document.getElementById('cxoMixTooltip');
        if (!tip) {
            tip = document.createElement('div');
            tip.id = 'cxoMixTooltip';
            tip.className = 'cxo-revcost-tooltip';
            document.body.appendChild(tip);
        }
        return tip;
    }

    function paintMixSliceTip(tip, dataIndex, fallbackLabel) {
        var row = getPortfolioMixVisibleRow(dataIndex);
        var total = getPortfolioMixTotal(MixChart.items || []);
        var symbol = getPortfolioMixCurrency(MixChart.items || []);
        var revenue = row ? Number(getApiField(row, 'Revenue')) : 0;
        var pct, projects, title, rowsHtml;
        if (isNaN(revenue)) revenue = 0;
        pct = total > 0 ? (revenue / total) * 100 : 0;
        projects = row && row._projectCount != null ? row._projectCount : getPortfolioMixProjectCount(row);
        title = row ? String(getApiField(row, 'PortfolioName') || '') : String(fallbackLabel || '');
        title = (typeof escHtml === 'function') ? escHtml(title) : title;
        rowsHtml =
            '<div class="tip-row"><span>Revenue</span><span class="tip-val">' + formatPortfolioMixRevenue(revenue, symbol) + '</span></div>' +
            '<div class="tip-row"><span>Share</span><span class="tip-val">' + pct.toFixed(1) + '%</span></div>' +
            '<div class="tip-row"><span>No. of Projects</span><span class="tip-val">' + projects + '</span></div>';
        tip.innerHTML = '<div class="tip-head" style="white-space:normal;overflow-wrap:anywhere;">' + title + '</div><div class="tip-body">' + rowsHtml + '</div>';
    }

    function openMixSliceTooltip(chart, dataIndex, nativeEvt) {
        var tip = ensureMixTip();
        var left, top, tw;
        if (dataIndex == null || dataIndex < 0) {
            tip.classList.remove('open');
            return;
        }
        paintMixSliceTip(tip, dataIndex, chart && chart.data && chart.data.labels ? chart.data.labels[dataIndex] : '');
        tip.classList.add('open');
        if (nativeEvt && nativeEvt.clientX != null) {
            left = nativeEvt.clientX + window.pageXOffset + 14;
            top = nativeEvt.clientY + window.pageYOffset + 14;
            tw = tip.offsetWidth || 180;
            if (left + tw > window.pageXOffset + window.innerWidth - 8) {
                left = nativeEvt.clientX + window.pageXOffset - tw - 14;
            }
            tip.style.left = left + 'px';
            tip.style.top = top + 'px';
        }
    }
    /* End of Added by Aditya J. on 29-09-2026 Long portfolio names stay short on the legend and full on hover */

    /* Same hover card as Revenue vs Cost. Keeps Revenue, Share, and Projects. */
    function cxoMixExternalTooltip(context) {
        var tooltipModel = context.tooltip;
        var chart = context.chart;
        var tip = document.getElementById('cxoMixTooltip');
        var dp, idx, row, title, revenue, pct, projects, total, symbol, rowsHtml;

        if (!tip) {
            tip = document.createElement('div');
            tip.id = 'cxoMixTooltip';
            tip.className = 'cxo-revcost-tooltip';
            document.body.appendChild(tip);
        }
        if (!tooltipModel || tooltipModel.opacity === 0 || !tooltipModel.dataPoints || !tooltipModel.dataPoints.length) {
            tip.classList.remove('open');
            return;
        }
        if (!cxoPrepareExternalTip(tip, 'cxoMixTooltip', chart)) return;
        dp = tooltipModel.dataPoints[0];
        idx = dp.dataIndex;
        row = getPortfolioMixVisibleRow(idx);
        total = getPortfolioMixTotal(MixChart.items || []);
        symbol = getPortfolioMixCurrency(MixChart.items || []);
        revenue = row ? Number(getApiField(row, 'Revenue')) : Number(dp.raw || 0);
        if (isNaN(revenue)) revenue = 0;
        pct = total > 0 ? (revenue / total) * 100 : 0;
        projects = row && row._projectCount != null ? row._projectCount : getPortfolioMixProjectCount(row);
        title = row ? String(getApiField(row, 'PortfolioName') || '') : String(dp.label || '');
        title = (typeof escHtml === 'function') ? escHtml(title) : title;
        rowsHtml =
            '<div class="tip-row"><span>Revenue</span><span class="tip-val">' + formatPortfolioMixRevenue(revenue, symbol) + '</span></div>' +
            '<div class="tip-row"><span>Share</span><span class="tip-val">' + pct.toFixed(1) + '%</span></div>' +
            '<div class="tip-row"><span>No. of Projects</span><span class="tip-val">' + projects + '</span></div>';
        tip.innerHTML = '<div class="tip-head" style="white-space:normal;overflow-wrap:anywhere;">' + title + '</div><div class="tip-body">' + rowsHtml + '</div>';
        tip.classList.add('open');
        placeCxoExternalTip(tip, chart, tooltipModel);
    }

    function drawPortfolioMixChart(items) {
        var canvas = document.getElementById('chMix');
        var labels = [], data = [], colors = [], i, name, rev, total, symbol;
        if (!canvas || typeof Chart === 'undefined') return;
        items = items || [];
        MixChart.items = items;
        if (MixChart.instance) {
            try { MixChart.instance.destroy(); } catch (ex) { /* ignore */ }
            MixChart.instance = null;
        }
        total = getPortfolioMixTotal(items);
        symbol = getPortfolioMixCurrency(items);
        updatePortfolioMixTotal(items);
        if (total <= 0) {
            canvas.style.display = 'none';
            syncPortfolioMixFullscreen();
            return;
        }
        canvas.style.display = 'block';
        for (i = 0; i < items.length; i++) {
            name = String(getApiField(items[i], 'PortfolioName') || '\u2014');
            rev = Number(getApiField(items[i], 'Revenue'));
            if (isNaN(rev)) rev = 0;
            if (rev <= 0) continue;
            items[i]._mixColor = MixChart.colors[i % MixChart.colors.length];
            labels.push(name);
            data.push(rev);
            colors.push(items[i]._mixColor);
        }
        if (!data.length) {
            canvas.style.display = 'none';
            syncPortfolioMixFullscreen();
            return;
        }
        MixChart.instance = new Chart(canvas, {
            type: 'doughnut',
            plugins: [{
                id: 'mixCenterAlign',
                afterLayout: function (chart) { alignDoughnutCenterLabel(chart, 'chMixCenter'); }
            }],
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors,
                    borderWidth: 0,
                    hoverOffset: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '68%',
                plugins: {
                    //Added by Aditya J. on 01-10-2026 Share sits outside the doughnut, including a single slice
                    legend: mixChartLegendPlugin(labels.length > 0),
                    //End of Added by Aditya J. on 01-10-2026 Share sits outside the doughnut, including a single slice
                    tooltip: {
                        enabled: false,
                        external: cxoMixExternalTooltip
                    }
                },
                onClick: function (evt, els) {
                    var idx, row, pid;
                    if (!els || !els.length) return;
                    idx = els[0].index;
                    row = getPortfolioMixVisibleRow(idx);
                    if (!row) return;
                    pid = getApiField(row, 'PortfolioID');
                    if (pid == null || pid === '') return;
                    openMixRevenueDrill(Number(pid), getApiField(row, 'PortfolioName'));
                }
            }
        });
        syncPortfolioMixFullscreen();
    }

    function getPortfolioMixVisibleRows() {
        var rows = [];
        var items = MixChart.items || [];
        var i, rev;
        for (i = 0; i < items.length; i++) {
            rev = Number(getApiField(items[i], 'Revenue'));
            if (!isNaN(rev) && rev > 0) rows.push(items[i]);
        }
        return rows;
    }

    function getPortfolioMixVisibleRow(index) {
        var rows = getPortfolioMixVisibleRows();
        return rows[index] || null;
    }

    function ensurePortfolioMixFullscreenStyles() {
        if (document.getElementById('portfolioMixFullscreenStyles')) return;
        var style = document.createElement('style');
        style.id = 'portfolioMixFullscreenStyles';
        style.textContent =
            '.mix-fullscreen-overlay{position:fixed;inset:0;background:rgba(15,23,42,.55);display:flex;align-items:center;justify-content:center;z-index:99990;padding:24px;box-sizing:border-box;}' +
            '.mix-fullscreen-card{width:min(720px,calc(100vw - 48px));height:min(500px,calc(100vh - 48px));background:#fff;border-radius:12px;box-shadow:0 18px 55px rgba(0,0,0,.25);overflow:hidden;display:flex;flex-direction:column;}' +
            '.mix-fullscreen-head{height:66px;flex:0 0 66px;padding:0 18px;display:flex;align-items:center;justify-content:space-between;border-bottom:1px solid #e5e7eb;box-sizing:border-box;}' +
            '.mix-fullscreen-title{font-size:16px;font-weight:600;color:#1d4ed8;}' +
            '.mix-fullscreen-sub{font-size:12px;color:#6b7280;margin-top:3px;}' +
            '.mix-fullscreen-actions{display:flex;gap:6px;flex:none;}' +
            '.mix-fullscreen-actions button{width:32px;height:32px;border:1px solid #e5e7eb;background:#fff;border-radius:8px;cursor:pointer;color:#475569;display:grid;place-items:center;}' +
            '.mix-fullscreen-body{position:relative;flex:1;min-height:0;padding:16px 24px 24px;box-sizing:border-box;display:flex;align-items:center;justify-content:center;}' +
            '.mix-fullscreen-chartbox{position:relative;width:min(520px,90%);height:min(370px,82%);}' +
            '.mix-fullscreen-chartbox canvas{width:100%!important;height:100%!important;}' +
            '.mix-fullscreen-center{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);text-align:center;pointer-events:none;display:flex;flex-direction:column;align-items:center;}' +
            '.mix-fullscreen-center-label{display:block;width:100%;text-align:center;font-size:12px;color:#6b7280;}' +
            '.mix-fullscreen-center-value{font-size:20px;font-weight:700;color:#111827;margin-top:3px;white-space:nowrap;}' +
            '.mix-no-data{position:absolute;inset:0;display:none;align-items:center;justify-content:center;font-size:16px;font-weight:500;color:#6b7280;}' +
            '.mix-fullscreen-no-data{position:absolute;inset:0;display:none;align-items:center;justify-content:center;font-size:16px;font-weight:500;color:#6b7280;}';
        document.head.appendChild(style);
    }

    function openPortfolioMixFullscreen() {
        var existing = document.getElementById('portfolioMixFullscreenOverlay');
        var items = MixChart.items || [];
        var total = getPortfolioMixTotal(items);
        var symbol = getPortfolioMixCurrency(items);
        ensurePortfolioMixFullscreenStyles();
        if (existing && existing.parentNode) existing.parentNode.removeChild(existing);
        document.body.classList.add('mix-fs-open');
        cxoHideAllChartTips();
        var overlay = document.createElement('div');
        overlay.id = 'portfolioMixFullscreenOverlay';
        overlay.className = 'mix-fullscreen-overlay';
        overlay.innerHTML =
            '<div class="mix-fullscreen-card" role="dialog" aria-modal="true" aria-label="Portfolio revenue mix">' +
            '<div class="mix-fullscreen-head">' +
            '<div>' +
            '<div class="mix-fullscreen-title">Portfolio revenue mix</div>' +
            '<div class="mix-fullscreen-sub">Click a slice to drill into that portfolio</div>' +
            '</div>' +
            '<div class="mix-fullscreen-actions">' +
            '<button type="button" id="mixFsDrillBtn" title="Drill down"><i class="fas fa-level-down-alt" aria-hidden="true"></i></button>' +
            '<button type="button" id="mixFsRefreshBtn" title="Refresh"><i class="fas fa-sync-alt" aria-hidden="true"></i></button>' +
            '<button type="button" id="mixFsShareBtn" title="Export / share"><i class="fas fa-share-alt" aria-hidden="true"></i></button>' +
            '<button type="button" id="mixFsCloseBtn" title="Close"><i class="fas fa-times" aria-hidden="true"></i></button>' +
            '</div>' +
            '</div>' +
            '<div class="mix-fullscreen-body">' +
            '<div class="mix-fullscreen-chartbox">' +
            '<canvas id="chMixFullscreen"></canvas>' +
            '<div class="mix-fullscreen-center" id="chMixFullscreenCenter">' +
            '<span class="mix-fullscreen-center-label">Total</span>' +
            '<span class="mix-fullscreen-center-value">' + formatPortfolioMixMoney(total, symbol) + '</span>' +
            '</div>' +
            '<div class="mix-fullscreen-no-data" id="chMixFullscreenNoData">No Data Available</div>' +
            '</div>' +
            '</div>' +
            '</div>';
        document.body.appendChild(overlay);
        if (total <= 0) {
            var fsCanvas = document.getElementById('chMixFullscreen');
            var fsCenter = document.getElementById('chMixFullscreenCenter');
            var fsNoData = document.getElementById('chMixFullscreenNoData');
            if (fsCanvas) fsCanvas.style.display = 'none';
            if (fsCenter) fsCenter.style.display = 'none';
            if (fsNoData) fsNoData.style.display = 'flex';
        }
        overlay.addEventListener('click', function (e) {
            if (e.target === overlay) closePortfolioMixFullscreen();
        });
        var closeBtn = document.getElementById('mixFsCloseBtn');
        if (closeBtn) closeBtn.onclick = closePortfolioMixFullscreen;
         /* Added By Madhuri.K On 24-09-2026*/
        var drillBtn = document.getElementById('mixFsDrillBtn');
        if (drillBtn) {
            drillBtn.onclick = function (e) {
                e.preventDefault();
                closePortfolioMixFullscreen();
                openMixRevenueDrillAll();
            };
        }
        var shareBtn = document.getElementById('mixFsShareBtn');
        if (shareBtn) {
            shareBtn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                openWidgetExportMenu(e, 'wMix');
            };
        }
        var refreshBtn = document.getElementById('mixFsRefreshBtn');
        if (refreshBtn) {
            refreshBtn.onclick = function (e) {
                if (e && e.preventDefault) e.preventDefault();
                LoadPortfolioRevenueMix();
                if (typeof toast === 'function') toast('Widget refreshed');
            };
        }
        drawPortfolioMixFullscreenChart(items);
        document.addEventListener('keydown', portfolioMixFullscreenKeyHandler, true);
    }

    function portfolioMixFullscreenKeyHandler(e) {
        if (e.key === 'Escape') closePortfolioMixFullscreen();
    }
 /* Added By Madhuri.K On 24-09-2026*/
    /* Keep the expanded mix chart open and redraw it after Refresh, same as Revenue vs Cost. */
    function syncPortfolioMixFullscreen() {
        var overlay = document.getElementById('portfolioMixFullscreenOverlay');
        var center, centerVal, noData, canvas, total, symbol;
        if (!overlay) return;
        total = getPortfolioMixTotal(MixChart.items || []);
        symbol = getPortfolioMixCurrency(MixChart.items || []);
        center = document.getElementById('chMixFullscreenCenter');
        centerVal = center ? center.querySelector('.mix-fullscreen-center-value') : null;
        noData = document.getElementById('chMixFullscreenNoData');
        canvas = document.getElementById('chMixFullscreen');
        if (centerVal) centerVal.textContent = total > 0 ? formatPortfolioMixMoney(total, symbol) : '';
        if (total <= 0) {
            if (MixChart.fullscreenInstance) {
                try { MixChart.fullscreenInstance.destroy(); } catch (e) { /* ignore */ }
                MixChart.fullscreenInstance = null;
            }
            if (canvas) canvas.style.display = 'none';
            if (center) center.style.display = 'none';
            if (noData) noData.style.display = 'flex';
            return;
        }
        if (canvas) canvas.style.display = 'block';
        if (center) center.style.display = 'flex';
        if (noData) noData.style.display = 'none';
        drawPortfolioMixFullscreenChart(MixChart.items || []);
    }

    function closePortfolioMixFullscreen() {
        var overlay = document.getElementById('portfolioMixFullscreenOverlay');
        if (MixChart.fullscreenInstance) {
            try { MixChart.fullscreenInstance.destroy(); } catch (e) { /* ignore */ }
            MixChart.fullscreenInstance = null;
        }
        if (overlay && overlay.parentNode) overlay.parentNode.removeChild(overlay);
        /* Added By Madhuri.K On 24-09-2026*/
        document.body.classList.remove('mix-fs-open');
        cxoHideAllChartTips();
        document.removeEventListener('keydown', portfolioMixFullscreenKeyHandler, true);
    }

    function drawPortfolioMixFullscreenChart(items) {
        var canvas = document.getElementById('chMixFullscreen');
        var total = getPortfolioMixTotal(items);
        var symbol = getPortfolioMixCurrency(items);
        var visibleRows = getPortfolioMixVisibleRows();
        var labels = [], data = [], colors = [], i;
        if (!canvas || typeof Chart === 'undefined' || total <= 0) return;
        if (MixChart.fullscreenInstance) {
            try { MixChart.fullscreenInstance.destroy(); } catch (e) { /* ignore */ }
            MixChart.fullscreenInstance = null;
        }
        for (i = 0; i < visibleRows.length; i++) {
            labels.push(String(getApiField(visibleRows[i], 'PortfolioName') || '\u2014'));
            data.push(Number(getApiField(visibleRows[i], 'Revenue')) || 0);
            colors.push(visibleRows[i]._mixColor || MixChart.colors[i % MixChart.colors.length]);
        }
        MixChart.fullscreenInstance = new Chart(canvas, {
            type: 'doughnut',
             /* Added By Madhuri.K On 24-09-2026*/
            plugins: [{
                id: 'mixFsCenterAlign',
                afterLayout: function (chart) { alignDoughnutCenterLabel(chart, 'chMixFullscreenCenter'); }
            }],
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors,
                    borderWidth: 0,
                    hoverOffset: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '68%',
                plugins: {
                    //Added by Aditya J. on 01-10-2026 Share sits outside the doughnut, including a single slice
                    legend: (function () {
                        var legend = mixChartLegendPlugin(labels.length > 0);
                        legend.position = 'top';
                        return legend;
                    })(),
                    //End of Added by Aditya J. on 01-10-2026 Share sits outside the doughnut, including a single slice
                    tooltip: {
                        enabled: true,
                        backgroundColor: 'rgba(0,0,0,0.88)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderWidth: 0,
                        displayColors: true,
                        padding: 10,
                        callbacks: {
                            title: function (ctx) {
                                var row = ctx && ctx.length ? visibleRows[ctx[0].dataIndex] : null;
                                var full = row ? String(getApiField(row, 'PortfolioName') || '') : '';
                                return full || (ctx && ctx.length ? String(ctx[0].label || '') : '');
                            },
                            label: function (ctx) {
                                var row = visibleRows[ctx.dataIndex];
                                var revenue = row ? Number(getApiField(row, 'Revenue')) || 0 : 0;
                                var pct = total > 0 ? (revenue / total) * 100 : 0;
                                var projects = row && row._projectCount != null
                                    ? row._projectCount
                                    : getPortfolioMixProjectCount(row);
                                return [
                                    'Revenue: ' + formatPortfolioMixRevenue(revenue, symbol),
                                    'Share: ' + pct.toFixed(1) + '%',
                                    'No. of Projects: ' + projects
                                ];
                            }
                        }
                    }
                },
                onClick: function (evt, els) {
                    if (!els || !els.length) return;
                    var row = visibleRows[els[0].index];
                    if (!row) return;
                    closePortfolioMixFullscreen();
                    var pid = getApiField(row, 'PortfolioID');
                    if (pid != null && pid !== '') {
                        openMixRevenueDrill(Number(pid), getApiField(row, 'PortfolioName'));
                    }
                }
            }
        });
    }

    function openMixRevenueDrillAll() {
        if (typeof openRevenueDrill === 'function') {
            openRevenueDrill('Revenue', true, {
                apiAction: 'GetAnalyticsDBPortfolioRevenueMixDrillDown'
            });
        }
    }

    function openMixRevenueDrill(portfolioId, portfolioName) {
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        if (portfolioId == null || isNaN(portfolioId) || portfolioId < 0) {
            showAlertError('Portfolio is required for mix drill-down.');
            return;
        }
        openRevenueDrill('Revenue', true, {
            apiAction: 'GetAnalyticsDBPortfolioRevenueMixDrillDown',
            //Added by Aditya J. on 28-09-2026 Start at level 1 for the clicked portfolio so each drill level opens only after the previous row is clicked
            stack: [
                { level: 1, label: 'Portfolio', portfolioId: Number(portfolioId), projectId: null, invoiceId: null }
            ]
            //End of Added by Aditya J. on 28-09-2026 Start at level 1 for the clicked portfolio so each drill level opens only after the previous row is clicked
        });
    }

    function downloadDashboardExcel(actionName, requestBody, fallbackName) {
        var bodyText = JSON.stringify(requestBody || {});
        fetch(encodeURI(strUrl) + '/api/PM_AnalyticsCXO_Dashboard/' + actionName, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'Authorization': 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || ''),
                'Params': encryptString(bodyText)
            },
            body: bodyText
        }).then(function (res) {
            if (!res.ok) {
                return res.text().then(function (text) {
                    var msg = 'Export failed: ' + res.status;
                    try {
                        var json = JSON.parse(text);
                        msg = (json && (json.message || (json.Data && json.Data.message))) || msg;
                    } catch (ignore) { /* ignore */ }
                    throw new Error(msg);
                });
            }
            var disposition = res.headers.get('Content-Disposition') || '';
            var match = disposition.match(/filename\*?=(?:UTF-8''|")?([^;"]+)/i);
            var filename = match ? decodeURIComponent(match[1].replace(/"/g, '').trim()) : (fallbackName || 'export.xls');
            return res.blob().then(function (blob) { return { blob: blob, filename: filename }; });
        }).then(function (result) {
            var a = document.createElement('a');
            var url = URL.createObjectURL(result.blob);
            a.href = url;
            a.download = result.filename;
            document.body.appendChild(a);
            a.click();
            setTimeout(function () {
                URL.revokeObjectURL(url);
                if (a.parentNode) a.parentNode.removeChild(a);
            }, 0);
            toast('Microsoft Excel downloaded');
        }).catch(function (err) {
            console.error(actionName, err);
            showAlertError(err && err.message ? err.message : 'Unable to export to Microsoft Excel.');
        });
    }

    var ExecCompanionCharts = { mix: null, varChart: null };

    /* Added by Aditya J. on 21-09-2026 Cost & budget variance by project
       API: GetAnalyticsDBCostBudgetVarianceByProject */
    var BudgetVarianceChart = { instance: null, items: [] };

    function isBudgetVarianceOverBudget(row) {
        var flag = getApiField(row, 'IsOverBudget');
        var burn = Number(getApiField(row, 'BudgetBurnPercentage'));
        if (flag === true || flag === 1 || flag === '1' || String(flag).toLowerCase() === 'true') return true;
        return !isNaN(burn) && burn > 100;
    }

    function showBudgetVarianceNoData(show) {
        var noDataEl = document.getElementById('chVarNoData');
        var canvas = document.getElementById('chVar');
        if (noDataEl) noDataEl.style.display = show ? 'flex' : 'none';
        if (canvas) canvas.style.visibility = show ? 'hidden' : 'visible';
    }

    function LoadCostBudgetVarianceByProject() {
        var canvas = document.getElementById('chVar');
        if (!canvas) return;

        if (!DateFilter.startDate || !DateFilter.endDate) {
            BudgetVarianceChart.items = [];
            drawBudgetVarianceChart([]);
            return;
        }

        BudgetVarianceChart.items = [];
        callDashboardApi('GetAnalyticsDBCostBudgetVarianceByProject', buildKpiCardsRequest(null), function (json) {
            var rows = getApiRows(json, 'AnalyticsDBCostBudgetVarianceByProjectItemModel');
            if (!rows.length) rows = getApiRows(json);
            BudgetVarianceChart.items = rows || [];
            drawBudgetVarianceChart(BudgetVarianceChart.items);
        }, function () {
            BudgetVarianceChart.items = [];
            drawBudgetVarianceChart([]);
        });
    }
 /* Added By Madhuri.K On 24-09-2026*/
    function budgetVarianceAxisLabels(fullLabels) {
        var n = fullLabels.length;
        var maxAxisLen = n > 50 ? 10 : (n > 30 ? 12 : (n > 18 ? 14 : (n > 12 ? 16 : 26)));
        var skip = n > 18 ? Math.ceil(n / 12) : 1;
        var sidePad = 8;
        var chartLabels = fullLabels.map(function (l) {
            var s = String(l || '');
            if (s.length > maxAxisLen) return s.slice(0, Math.max(6, maxAxisLen - 2)) + '...';
            return s;
        });
        var ticks = {
            color: '#687589',
            font: { size: 10 },
            autoSkip: n > 18,
            autoSkipPadding: n > 18 ? 10 : 0,
            maxRotation: n > 3 ? 45 : 0,
            minRotation: n > 3 ? 45 : 0,
            padding: n > 3 ? 2 : 0
        };
        if (n <= 1) sidePad = 110;
        else if (n === 2) sidePad = 70;
        else if (n <= 4) sidePad = 36;
        else if (n <= 6) sidePad = 18;
        if (skip > 1) {
            ticks.callback = function (val, idx) {
                var label;
                if ((idx % skip) !== 0) return '';
                if (this && typeof this.getLabelForValue === 'function') label = this.getLabelForValue(val);
                else label = chartLabels[idx];
                return label == null ? '' : label;
            };
        }
        return { chartLabels: chartLabels, ticks: ticks, sidePad: sidePad, barThickness: n <= 3 ? 48 : 24 };
    }

    /* Keep a readable % scale. One extreme burn must not flatten every other bar. */
    function budgetVarianceYScale(values, maxBurn) {
        var sorted, typical, display, step, yMax;
        if (!(maxBurn > 100)) return { max: 120, step: 20 };
        display = maxBurn;
        if (values.length > 8 && maxBurn > 200) {
            sorted = values.slice().sort(function (a, b) { return a - b; });
            typical = sorted[Math.min(sorted.length - 1, Math.floor((sorted.length - 1) * 0.9))];
            if (typical > 0 && maxBurn > typical * 2.5) display = Math.max(200, typical * 1.2);
        }
        if (display <= 200) step = 20;
        else if (display <= 500) step = 50;
        else if (display <= 1200) step = 100;
        else {
            step = Math.pow(10, Math.floor(Math.log10(Math.max(display / 6, 1))));
            step = Math.ceil((display / 6) / step) * step;
        }
        yMax = Math.max(120, Math.ceil(display / step) * step);
        return { max: yMax, step: step };
    }

    function formatBudgetAxisPct(v) {
        var n = Number(v);
        if (!isFinite(n)) n = 0;
        return n.toLocaleString('en-IN', { maximumFractionDigits: 0 }) + '%';
    }

    /* Hover card matches Revenue vs Cost. Keeps Burn, Variance, Planned, and Actual. */
    function cxoBudgetVarExternalTooltip(context) {
        var tooltipModel = context.tooltip;
        var chart = context.chart;
        var tip = document.getElementById('cxoBudgetVarTooltip');
        var dp, idx, item, title, rowsHtml, canvasRect, left, top, tw, th;
        var burnPct, varPct, planned, actual, rows, fullLabels;

        if (!tip) {
            tip = document.createElement('div');
            tip.id = 'cxoBudgetVarTooltip';
            tip.className = 'cxo-revcost-tooltip';
            document.body.appendChild(tip);
        }
        if (!tooltipModel || tooltipModel.opacity === 0 || !tooltipModel.dataPoints || !tooltipModel.dataPoints.length) {
            tip.classList.remove('open');
            return;
        }
        if (!cxoPrepareExternalTip(tip, 'cxoBudgetVarTooltip', chart)) return;

        dp = tooltipModel.dataPoints[0];
        idx = dp.dataIndex;
        rows = (BudgetVarianceChart && BudgetVarianceChart.items) || [];
        fullLabels = (BudgetVarianceChart && BudgetVarianceChart.fullLabels) || [];
        item = rows[idx] || {};
        title = fullLabels[idx] || ((tooltipModel.title && tooltipModel.title.length) ? String(tooltipModel.title[0]) : '');
        title = (typeof escHtml === 'function') ? escHtml(title) : title;
        burnPct = Number(getApiField(item, 'BudgetBurnPercentage'));
        varPct = Number(getApiField(item, 'BudgetVariancePercentage'));
        planned = Number(getApiField(item, 'PlannedBudget'));
        actual = Number(getApiField(item, 'ActualCost'));
        rowsHtml =
            '<div class="tip-row"><span>Burn</span><span class="tip-val">' +
            (isNaN(burnPct) ? 0 : burnPct).toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + '%</span></div>' +
            '<div class="tip-row"><span>Variance</span><span class="tip-val">' +
            (isNaN(varPct) ? 0 : varPct).toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + '%</span></div>' +
            '<div class="tip-row"><span>Planned</span><span class="tip-val">' +
            (isNaN(planned) ? 0 : planned).toLocaleString('en-IN') + '</span></div>' +
            '<div class="tip-row"><span>Actual</span><span class="tip-val">' +
            (isNaN(actual) ? 0 : actual).toLocaleString('en-IN') + '</span></div>';

        tip.innerHTML =
            '<div class="tip-head">' + title + '</div>' +
            '<div class="tip-body">' + rowsHtml + '</div>';
        tip.classList.add('open');

        placeCxoExternalTip(tip, chart, tooltipModel);
    }

    function drawBudgetVarianceChart(data) {
        var canvas = document.getElementById('chVar');
        var labels = [];
        var values = [];
        var overFlags = [];
        var maxBurn = 0;
        var axis, yScale, chartLabels, barMax;
        var i, row, burn, normal, flagged;
        if (!canvas || typeof Chart === 'undefined') return;
        data = data || BudgetVarianceChart.items || [];

        for (i = 0; i < data.length; i++) {
            row = data[i];
            labels.push(String(getApiField(row, 'ProjectName') || getApiField(row, 'ProjectID') || ''));
            burn = Number(getApiField(row, 'BudgetBurnPercentage'));
            if (isNaN(burn)) burn = 0;
            values.push(burn);
            overFlags.push(isBudgetVarianceOverBudget(row));
            if (burn > maxBurn) maxBurn = burn;
        }

        if (BudgetVarianceChart.instance) {
            try { BudgetVarianceChart.instance.destroy(); } catch (e) { /* ignore */ }
            BudgetVarianceChart.instance = null;
        }
        ExecCompanionCharts.varChart = null;

        if (!labels.length) {
            showBudgetVarianceNoData(true);
            return;
        }

        showBudgetVarianceNoData(false);
        BudgetVarianceChart.fullLabels = labels.slice();
        axis = budgetVarianceAxisLabels(labels);
        yScale = budgetVarianceYScale(values, maxBurn);
        chartLabels = axis.chartLabels;
        barMax = axis.barThickness;
        normal = values.map(function (v, idx) { return overFlags[idx] ? null : v; });
        flagged = values.map(function (v, idx) { return overFlags[idx] ? v : null; });
        BudgetVarianceChart.instance = new Chart(canvas.getContext('2d'), {
            type: 'bar',
            data: {
                labels: chartLabels,
                datasets: [
                    { label: 'Budget burn %', data: normal, backgroundColor: '#139f98', borderRadius: 7, borderSkipped: false, barPercentage: .72, categoryPercentage: .82, maxBarThickness: barMax },
                    { label: 'Over budget', data: flagged, backgroundColor: '#d94841', borderRadius: 7, borderSkipped: false, barPercentage: .72, categoryPercentage: .82, maxBarThickness: barMax }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: { mode: 'index', intersect: false },
                layout: { padding: { left: axis.sidePad, right: axis.sidePad, bottom: labels.length > 3 ? 6 : 0 } },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        enabled: false,
                        external: cxoBudgetVarExternalTooltip
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: yScale.max,
                        ticks: {
                            stepSize: yScale.step,
                            color: '#687589',
                            callback: function (v) { return formatBudgetAxisPct(v); }
                        },
                        grid: { color: '#e7ebf0' }
                    },
                    x: { offset: true, ticks: axis.ticks, grid: { display: false } }
                },
                onClick: function (evt, elements) {
                    if (!elements || !elements.length) return;
                    if (typeof openBudgetVarianceDrill === 'function') openBudgetVarianceDrill(true);
                }
            }
        });
        ExecCompanionCharts.varChart = BudgetVarianceChart.instance;
        setTimeout(function () {
            var src = document.getElementById('wVar');
            var live = document.querySelector('.widget-fs-clone[data-fs-src="wVar"]');
            if (src && live && typeof copyWidgetCanvases === 'function') copyWidgetCanvases(src, live);
        }, 50);
    }

    function destroyExecCompanionCharts() {
        var tip = document.getElementById('cxoBudgetVarTooltip');
        if (BudgetVarianceChart.instance && typeof BudgetVarianceChart.instance.destroy === 'function') {
            try { BudgetVarianceChart.instance.destroy(); } catch (e) { /* ignore */ }
        }
        BudgetVarianceChart.instance = null;
        ExecCompanionCharts.varChart = null;
        if (tip) tip.classList.remove('open');
    }

    function plotExecCompanionCharts() {
        LoadCostBudgetVarianceByProject();
    }
    /* End of Added by Aditya J. on 21-09-2026 Cost & budget variance by project */

    function bindExecBodyExtrasActions() {
        var root = document.getElementById('page-exec');
        var aiExport, aiToggle, aiBody, aiIcon;
        if (!root) return;

        root.querySelectorAll('[data-exec-fs]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                if (btn.getAttribute('data-exec-fs') === 'wMix') {
                    openPortfolioMixFullscreen();
                    return;
                }
                toggleWidgetFullscreen(btn.getAttribute('data-exec-fs'));
            };
        });
        root.querySelectorAll('[data-exec-share]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                /* Design: 3rd tool = Export / Share → EXPORT TO Microsoft Excel */
                openWidgetExportMenu(e, btn.getAttribute('data-exec-share'));
            };
        });
        root.querySelectorAll('[data-exec-refresh]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                if (btn.getAttribute('data-exec-refresh') === 'wRevCost') {
                    LoadRevenueCostTrend();
                } else if (btn.getAttribute('data-exec-refresh') === 'wMix') {
                    LoadPortfolioRevenueMix();
                } else if (btn.getAttribute('data-exec-refresh') === 'wVar') {
                    LoadCostBudgetVarianceByProject();
                } else {
                    plotExecCompanionCharts();
                }
                toast('Widget refreshed');
            };
        });
        root.querySelectorAll('[data-exec-drill]').forEach(function (btn) {
            btn.onclick = function (e) {
                var kind, widgetId;
                e.preventDefault();
                e.stopPropagation();
                kind = String(btn.getAttribute('data-exec-drill') || 'revenue').toLowerCase();
                widgetId = String(btn.getAttribute('data-exec-widget') || '').toLowerCase();
                //Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill button uses the mix drill-down
                if (kind === 'mix' || widgetId === 'wmix') {
                    openMixRevenueDrillAll();
                    return;
                }
                //End of Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill button uses the mix drill-down
                /* Circled drill on Revenue vs Cost — same as Revenue KPI card, never Mix */
                if (widgetId === 'wrevcost' || kind === 'revenue') {
                    if (typeof openRevenueDrill === 'function') openRevenueDrill('Revenue', true);
                    return;
                }
                if (kind === 'budget' || widgetId === 'wvar') {
                    if (typeof openBudgetVarianceDrill === 'function') openBudgetVarianceDrill(true);
                    return;
                }
                if (kind === 'projects' || kind === 'activeprojects') {
                    if (typeof openOpsKpiDrill === 'function') openOpsKpiDrill('ActiveProjects');
                    return;
                }
                if (typeof openRevenueDrill === 'function') openRevenueDrill('Revenue', true);
            };
        });
        root.querySelectorAll('[data-ai-toast]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                toast(btn.getAttribute('data-ai-toast') || 'Done');
            };
        });
        root.querySelectorAll('[data-ai-copilot]').forEach(function (btn) {
            btn.onclick = function (e) {
                e.preventDefault();
                openCopilot(btn.getAttribute('data-ai-copilot'));
            };
        });
        aiExport = document.getElementById('btnAiExport');
        if (aiExport) {
            aiExport.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                if (typeof shareMenu === 'function') shareMenu(e);
            };
        }
        aiToggle = document.getElementById('btnAiToggle');
        aiBody = document.getElementById('aiInsightsBody');
        if (aiToggle && aiBody) {
            aiToggle.onclick = function (e) {
                e.preventDefault();
                e.stopPropagation();
                aiBody.classList.toggle('collapsed');
                aiIcon = aiToggle.querySelector('i');
                if (aiIcon) {
                    aiIcon.className = aiBody.classList.contains('collapsed')
                        ? 'fas fa-chevron-up'
                        : 'fas fa-chevron-down';
                }
                aiToggle.title = aiBody.classList.contains('collapsed') ? 'Expand' : 'Collapse';
            };
        }
    }

    function bindRevenueCostChartShellActions() {
        bindExecBodyExtrasActions();
    }

    document.addEventListener('keydown', function (e) {
        if (e.key !== 'Escape') return;
        if (document.body.classList.contains('widget-fs-open') ||
            document.querySelector('.widget-fs-clone')) {
            closeWidgetFullscreen();
            return;
        }
        var cp = document.getElementById('copilot');
        if (cp && cp.classList.contains('open')) cp.classList.remove('open');
    });
 /* Added By Madhuri.K On 24-09-2026*/
    /* Purpose: Official Excel logo used on every Export / Share row. */
    function excelIconHtml() {
        return '<span class="xls-ico" aria-hidden="true">' +
            '<svg viewBox="0 0 32 32" width="18" height="18" focusable="false">' +
            '<rect x="10" y="3" width="19" height="26" rx="3" fill="#fff" stroke="#c5c9ce"/>' +
            '<rect x="15.2" y="18.2" width="2.3" height="6.3" rx="0.4" fill="#4a86e8"/>' +
            '<rect x="18.4" y="14.4" width="2.3" height="10.1" rx="0.4" fill="#ed7d31"/>' +
            '<rect x="21.6" y="11.2" width="2.3" height="13.3" rx="0.4" fill="#70ad47"/>' +
            '<rect x="24.8" y="8.4" width="2.3" height="16.1" rx="0.4" fill="#ffc000"/>' +
            '<path d="M3.5 8.5h13.2v15H3.5z" fill="#185c37"/>' +
            '<path d="M7.1 11.6l2.5 4 2.5-4h2.2l-3.6 5.4 3.7 5.6h-2.3l-2.5-4.1-2.5 4.1H5l3.7-5.6-3.6-5.4h2z" fill="#fff"/>' +
            '</svg>' +
            '</span>';
    }

    /* Purpose: Upper Export tool — design menu "EXPORT TO → Microsoft Excel". */
    function closeWidgetMenus() {
        document.querySelectorAll('.menu.menu-widget-export').forEach(function (x) {
            if (x.parentNode) x.parentNode.removeChild(x);
        });
    }

    function openWidgetExportMenu(e, widgetId) {
        var m, r, btn, excelBtn;
        if (e && e.stopPropagation) e.stopPropagation();
        closeWidgetMenus();
        closeTopFilterPop();
        document.querySelectorAll('.menu.menu-share').forEach(function (x) {
            if (x.parentNode) x.parentNode.removeChild(x);
        });
        m = document.createElement('div');
        m.className = 'menu menu-widget-export';
        m.innerHTML =
            '<div class="mhd">Export to</div>' +
            '<button type="button" class="menu-excel-btn" data-act="excel">' +
            excelIconHtml() +
            '<span>Microsoft Excel</span>' +
            '</button>';
        document.body.appendChild(m);
        btn = e && (e.currentTarget || (e.target && e.target.closest ? e.target.closest('button') : null));
        r = btn ? btn.getBoundingClientRect() : { bottom: 80, left: 40, right: 230 };
        m.style.position = 'fixed';
        m.style.top = (r.bottom + 6) + 'px';
        /* Added By Madhuri.K On 24-09-2026*/
        /* .menu uses z-index:3300 !important, which sits under the mix overlay (99990). */
        m.style.setProperty('z-index', '100020', 'important');
        (function placeExportMenu() {
            var width = m.offsetWidth || 210;
            var left = r.left;
            var card = document.querySelector('#portfolioMixFullscreenOverlay .mix-fullscreen-card');
            var fs = document.querySelector('.widget-fs-clone');
            var box = card || fs;
            var rightLimit = window.innerWidth - 8;
            var leftLimit = 8;
            var br;
            if (box) {
                br = box.getBoundingClientRect();
                rightLimit = Math.min(rightLimit, br.right - 8);
                leftLimit = Math.max(leftLimit, br.left + 8);
            }
            if (left + width > rightLimit) left = rightLimit - width;
            if (left < leftLimit) left = leftLimit;
            m.style.left = left + 'px';
        })();
        m.addEventListener('click', function (ev) { ev.stopPropagation(); });
        excelBtn = m.querySelector('[data-act="excel"]');
        if (excelBtn) {
            excelBtn.onclick = function (ev) {
                ev.preventDefault();
                if (m.parentNode) m.parentNode.removeChild(m);
                exportWidgetToExcel(widgetId);
            };
        }
        setTimeout(function () {
            var onDoc = function (ev) {
                if (m.contains(ev.target)) return;
                if (m.parentNode) m.parentNode.removeChild(m);
                document.removeEventListener('mousedown', onDoc, true);
            };
            document.addEventListener('mousedown', onDoc, true);
        }, 0);
    }

    /* Purpose: Excel export for Cost & budget variance widget (live API rows).
       Added by Aditya J. on 21-09-2026 — kept from latest teammate page. */
    function buildBudgetVarianceExcelHtml() {
        var rows = BudgetVarianceChart.items || [];
        var i, row, html;
        var cellSt = 'border:1px solid #bfbfbf;padding:4px 8px;';
        if (!rows.length) return '';
        html =
            '<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;font-family:Calibri,Arial,sans-serif;font-size:11pt">' +
            '<tr>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;">Project</th>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;text-align:right">Planned budget</th>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;text-align:right">Actual cost</th>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;text-align:right">Variance</th>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;text-align:right">Budget burn %</th>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;text-align:right">Budget variance %</th>' +
              '<th style="' + cellSt + 'background:#f3f4f6;font-weight:700;">Over budget</th>' +
            '</tr>';
        for (i = 0; i < rows.length; i++) {
            row = rows[i] || {};
            html += '<tr>' +
              '<td style="' + cellSt + '">' + escHtml(String(getApiField(row, 'ProjectName') || '')) + '</td>' +
              '<td style="' + cellSt + 'text-align:right">' + escHtml(String(getApiField(row, 'PlannedBudget') == null ? '' : getApiField(row, 'PlannedBudget'))) + '</td>' +
              '<td style="' + cellSt + 'text-align:right">' + escHtml(String(getApiField(row, 'ActualCost') == null ? '' : getApiField(row, 'ActualCost'))) + '</td>' +
              '<td style="' + cellSt + 'text-align:right">' + escHtml(String(getApiField(row, 'VarianceAmount') == null ? '' : getApiField(row, 'VarianceAmount'))) + '</td>' +
              '<td style="' + cellSt + 'text-align:right">' + escHtml(String(getApiField(row, 'BudgetBurnPercentage') == null ? '' : getApiField(row, 'BudgetBurnPercentage'))) + '</td>' +
              '<td style="' + cellSt + 'text-align:right">' + escHtml(String(getApiField(row, 'BudgetVariancePercentage') == null ? '' : getApiField(row, 'BudgetVariancePercentage'))) + '</td>' +
              '<td style="' + cellSt + '">' + (isBudgetVarianceOverBudget(row) ? 'Yes' : 'No') + '</td>' +
              '</tr>';
        }
        html += '</table>';
        return html;
    }

    /* Purpose: Excel export for chart widgets (CSV-compatible .xls download).
       Added by Vikas T — Revenue vs Cost widget export stays off the page (standalone Excel only). */
    function exportWidgetToExcel(widgetId) {
        var id = String(widgetId || '');
        var a, html, name;
        if (id === 'wRevCost') {
            return;
        } else if (id === 'wMix') {
            exportPortfolioMixExcel();
            return;
        } else if (id === 'wVar') {
            html = buildBudgetVarianceExcelHtml();
            if (!html) {
                toast('No chart data to export');
                return;
            }
            name = 'Cost and budget variance by project.xls';
        } else {
            html = '<table border="1"><tr><th>Widget</th><th>Exported</th></tr><tr><td>' +
                escHtml(id) + '</td><td>yes</td></tr></table>';
            name = 'whizible-export.xls';
        }
        a = document.createElement('a');
        a.href = URL.createObjectURL(new Blob(
            ['\ufeff<html><head><meta charset="utf-8"></head><body>' + html + '</body></html>'],
            { type: 'application/vnd.ms-excel' }
        ));
        a.download = name;
        a.click();
        toast('Exported to Microsoft Excel');
    }

    /* Purpose: Export month series as CSV (design Export tool). */
    function exportRevenueCostCsv() {
        var rows = RevenueCostTrend.months || [];
        var lines = ['MonthLabel,IsForecast,Revenue,Cost,PrevRevenue,GrossProfit'];
        var i, r, isFc;
        if (!rows.length) {
            toast('No chart data to export');
            return;
        }
        for (i = 0; i < rows.length; i++) {
            r = rows[i] || {};
            isFc = parseTrendFlag(getApiField(r, 'IsForecast')) ? '1' : '0';
            lines.push([
                '"' + String(getApiField(r, 'MonthLabel') || '').replace(/"/g, '""') + '"',
                isFc,
                getApiField(r, 'Revenue') == null ? '' : getApiField(r, 'Revenue'),
                getApiField(r, 'Cost') == null ? '' : getApiField(r, 'Cost'),
                getApiField(r, 'PrevRevenue') == null ? '' : getApiField(r, 'PrevRevenue'),
                getApiField(r, 'GrossProfit') == null ? '' : getApiField(r, 'GrossProfit')
            ].join(','));
        }
        (function download(text, name) {
            var a = document.createElement('a');
            a.href = URL.createObjectURL(new Blob([text], { type: 'text/csv;charset=utf-8' }));
            a.download = name;
            a.click();
        })(lines.join('\n'), 'cxo-revenue-cost-trend.csv');
        toast('Chart CSV downloaded');
    }

    /* Purpose: Same filter bag as KPI cards for the chart SP. */
    function buildRevenueCostTrendRequest() {
        return buildKpiCardsRequest(null);
    }

    function getRevenueCostTrendPayload(json) {
        var node = json;
        var depth = 0;
        while (node && typeof node === 'object' && !Array.isArray(node) && depth < 6) {
            if (getApiField(node, 'Months') != null || getApiField(node, 'Meta') != null) return node;
            if (node.data != null && typeof node.data === 'object') { node = node.data; depth++; continue; }
            if (node.Data != null && typeof node.Data === 'object') { node = node.Data; depth++; continue; }
            break;
        }
        return node && typeof node === 'object' ? node : null;
    }

    function parseTrendFlag(raw) {
        if (raw === true || raw === 1 || raw === '1') return true;
        if (raw === false || raw === 0 || raw === '0') return false;
        var s = String(raw == null ? '' : raw).trim().toLowerCase();
        return s === 'true' || s === 'yes';
    }

    /* Purpose: Chart Unit = Revenue KPI SP Unit (Meta.Unit from udf_Whizible2_GetAnalyticsDBMoneyScale).
       Added by Vikas T on 23-09-2026 — do not force Cr when the card is L / k / M. */
    function getRevCostMoneyUnit(meta) {
        var u = String(getApiField(meta, 'Unit') || '').trim();
        var cards, i, card, flag;
        if (u && !/^Abs$/i.test(u)) return u;
        cards = (typeof KpiCards !== 'undefined' && KpiCards.list) ? KpiCards.list : [];
        for (i = 0; i < cards.length; i++) {
            card = cards[i] || {};
            flag = String(getApiField(card, 'Flag') || '').trim();
            if (!/^Revenue$/i.test(flag)) continue;
            u = getCardUnitRaw(card, '');
            if (u && !/^Abs$/i.test(u)) return u;
            break;
        }
        return String(getApiField(meta, 'Unit') || '').trim();
    }

    /* Purpose: SP already divided by udf divisor — UI never re-scales. */
    function pickChartMoneyScale(values, meta) {
        var unit = getRevCostMoneyUnit(meta);
        return { divisor: 1, unit: unit ? (' ' + unit) : '' };
    }

    /* Purpose: Same as Revenue KPI card — symbol + SP value + SP Unit (L / Cr / k / M). */
    function formatChartMoney(value, meta) {
        var n = parseKpiNumeric(value);
        var sym = getKpiCurrencySymbol(meta || {});
        var unit = getRevCostMoneyUnit(meta || {});
        if (isNaN(n)) n = 0;
        if (!unit || /^Abs$/i.test(unit)) return String(sym) + n.toFixed(2);
        return String(sym) + n.toFixed(2) + ' ' + unit;
    }

    function chartDotSep() {
        return ' \u00B7 ';
    }

    function shortChartTipLabel(label) {
        var s = String(label || '');
        if (/ai forecast|trend forecast|trend-based/i.test(s)) return 'Trend forecast';
        if (/prev/i.test(s)) return 'Prev period';
        if (/cost/i.test(s)) return 'Cost';
        if (/revenue/i.test(s)) return 'Revenue';
        return s;
    }

    /* Purpose: Legend names match exec.html — Previous period (match day of week). */
    function getPrevPeriodLegendLabel() {
        return 'Previous period (match day of week)';
    }

    function destroyRevenueCostChart() {
        var tip = document.getElementById('cxoRevCostTooltip');
        if (RevenueCostTrend.chart && typeof RevenueCostTrend.chart.destroy === 'function') {
            try { RevenueCostTrend.chart.destroy(); } catch (e) { /* ignore */ }
        }
        RevenueCostTrend.chart = null;
        if (tip) tip.classList.remove('open');
    }

    /* Purpose: Hover tip like design — month + Revenue/Cost/Prev period/Trend forecast. No Gross profit. */
    function cxoRevCostExternalTooltip(context) {
        var tooltipModel = context.tooltip;
        var chart = context.chart;
        var tip = document.getElementById('cxoRevCostTooltip');
        var i, dp, ds, lbl, rawY, title, rowsHtml, canvasRect, left, top, tw, th, meta;

        if (!tip) {
            tip = document.createElement('div');
            tip.id = 'cxoRevCostTooltip';
            tip.className = 'cxo-revcost-tooltip';
            document.body.appendChild(tip);
        }

        if (!tooltipModel || tooltipModel.opacity === 0 || !tooltipModel.dataPoints || !tooltipModel.dataPoints.length) {
            tip.classList.remove('open');
            return;
        }
         /* Added By Madhuri.K On 24-09-2026*/
        if (!cxoPrepareExternalTip(tip, 'cxoRevCostTooltip', chart)) return;

        meta = (RevenueCostTrend && RevenueCostTrend.meta) || {};
        title = (tooltipModel.title && tooltipModel.title.length) ? String(tooltipModel.title[0]) : '';
        rowsHtml = '';
        for (i = 0; i < tooltipModel.dataPoints.length; i++) {
            dp = tooltipModel.dataPoints[i];
            ds = dp.dataset || {};
            rawY = (dp.parsed && dp.parsed.y != null) ? dp.parsed.y : dp.raw;
            if (rawY == null || isNaN(rawY)) continue;
            lbl = shortChartTipLabel(ds.label);
            if (/gross profit/i.test(lbl)) continue;
            rowsHtml +=
                '<div class="tip-row">' + lbl + ': <span class="tip-val">' +
                formatChartMoney(rawY, meta) +
                '</span></div>';
        }
        if (!rowsHtml) {
            tip.classList.remove('open');
            return;
        }

        tip.innerHTML =
            '<div class="tip-head">' + title + '</div>' +
            '<div class="tip-body">' + rowsHtml + '</div>';
        tip.classList.add('open');

        placeCxoExternalTip(tip, chart, tooltipModel);
    }

    /* Purpose: Bind Chart.js line series from SP Meta + Months — SRS §4.1.2. */
    function plotRevenueCostTrendChart(meta, months) {
        var canvas = document.getElementById('chRev');
        var subEl = document.getElementById('chRevSub');
        var labels = [];
        var rev = [];
        var cost = [];
        var prev = [];
        var forecast = [];
        var revPointRadius = [];
        var costPointRadius = [];
        var prevPointRadius = [];
        var fcPointRadius = [];
        var scaleValues = [];
        var i, row, isFc, revN, costN, prevN, lastActualRev = null, lastActualIdx = -1;
        var acc, risk, good, mut, ChartCtor, lastActualLabel, scale, prevLabel;

        if (!canvas) return;
        if (typeof Chart === 'undefined') {
            if (subEl) subEl.textContent = 'Chart.js not loaded';
            return;
        }
        ChartCtor = Chart;

        meta = meta || {};
        months = months || [];
        if (!months.length) {
            destroyRevenueCostChart();
            if (subEl) subEl.textContent = 'No Revenue vs Cost data for the selected period';
            return;
        }
        lastActualLabel = '';
        prevLabel = getPrevPeriodLegendLabel();

        for (i = 0; i < months.length; i++) {
            row = months[i] || {};
            isFc = parseTrendFlag(getApiField(row, 'IsForecast'));
            labels.push(String(getApiField(row, 'MonthLabel') || ''));
            revN = parseKpiNumeric(getApiField(row, 'Revenue'));
            costN = parseKpiNumeric(getApiField(row, 'Cost'));
            prevN = parseKpiNumeric(getApiField(row, 'PrevRevenue'));

            if (isFc) {
                rev.push(null);
                cost.push(null);
                prev.push(null);
                revPointRadius.push(0);
                costPointRadius.push(0);
                prevPointRadius.push(0);
                fcPointRadius.push(0);
                forecast.push(isNaN(revN) ? null : revN);
                if (!isNaN(revN)) scaleValues.push(revN);
            } else {
                rev.push(isNaN(revN) ? 0 : revN);
                cost.push(isNaN(costN) ? 0 : costN);
                prev.push(isNaN(prevN) ? 0 : prevN);
                if (!isNaN(revN)) scaleValues.push(revN);
                if (!isNaN(costN)) scaleValues.push(costN);
                if (!isNaN(prevN)) scaleValues.push(prevN);
                revPointRadius.push(2);
                costPointRadius.push(0);
                prevPointRadius.push(0);
                fcPointRadius.push(0);
                lastActualIdx = i;
                lastActualRev = isNaN(revN) ? lastActualRev : revN;
                lastActualLabel = String(getApiField(row, 'MonthLabel') || lastActualLabel);
                forecast.push(null);
            }
        }
        scale = pickChartMoneyScale(scaleValues, meta);
        RevenueCostTrend.scale = scale;

        if (subEl) {
            var apiSub = String(getApiField(meta, 'ChartSubtitle') || '').trim();
            if (apiSub) {
                subEl.textContent = apiSub.replace(/\s+-\s+/g, chartDotSep()).replace(/\u00C2\u00B7/g, '\u00B7');
            } else if (lastActualLabel) {
                subEl.textContent = 'Actuals to ' + lastActualLabel +
                    chartDotSep() + 'dotted = trend-based forecast' + chartDotSep() + 'shaded = compare period';
            } else {
                subEl.textContent = 'Actuals' + chartDotSep() + 'dotted = trend-based forecast' +
                    chartDotSep() + 'shaded = compare period';
            }
        }

        /* Connect forecast dashed line from last actual through F(m+1)/F(m+2) */
        for (i = 0; i < months.length; i++) {
            if (!parseTrendFlag(getApiField(months[i], 'IsForecast'))) continue;
            if (lastActualRev != null && i > 0 && forecast[i - 1] == null) {
                forecast[i - 1] = lastActualRev;
            }
            break;
        }

        /* exec.html last-actual markers: blue / red / grey / green dots together */
        if (lastActualIdx >= 0) {
            revPointRadius[lastActualIdx] = 4;
            costPointRadius[lastActualIdx] = 4;
            prevPointRadius[lastActualIdx] = 4;
            fcPointRadius[lastActualIdx] = 4;
        }

        /* Design colours match exec.html */
        acc = '#479EF5';
        risk = '#DC626D';
        good = '#54B054';
        mut = '#8E8C8A';

        destroyRevenueCostChart();
        var revCostDatasets = [
            {
                label: 'Revenue',
                data: rev,
                yAxisID: 'y',
                borderColor: acc,
                backgroundColor: 'rgba(71,158,245,.14)',
                fill: true,
                tension: 0.4,
                pointRadius: revPointRadius,
                pointHoverRadius: 5,
                pointStyle: 'circle',
                borderWidth: 2.4,
                spanGaps: false
            },
            {
                label: 'Cost',
                data: cost,
                yAxisID: 'y',
                borderColor: risk,
                backgroundColor: 'transparent',
                fill: false,
                tension: 0.4,
                pointRadius: costPointRadius,
                pointHoverRadius: 5,
                pointStyle: 'circle',
                borderWidth: 1.6,
                spanGaps: false
            },
            {
                label: prevLabel,
                data: prev,
                yAxisID: 'y',
                borderColor: mut,
                backgroundColor: 'transparent',
                borderDash: [3, 4],
                pointRadius: prevPointRadius,
                pointHoverRadius: 5,
                pointStyle: 'circle',
                tension: 0.4,
                borderWidth: 1.2,
                spanGaps: false
            },
            {
                label: 'Trend forecast',
                data: forecast,
                yAxisID: 'y',
                borderColor: good,
                backgroundColor: 'transparent',
                borderDash: [6, 5],
                pointRadius: fcPointRadius,
                pointHoverRadius: 5,
                pointStyle: 'circle',
                tension: 0.4,
                borderWidth: 2.2,
                spanGaps: false
            }
        ];

        RevenueCostTrend.chart = new ChartCtor(canvas, {
            type: 'line',
            data: {
                labels: labels,
                datasets: revCostDatasets
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: { mode: 'index', intersect: false },
                layout: { padding: { top: 2, right: 8, bottom: 2, left: 2 } },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                        align: 'center',
                        labels: {
                            color: '#6b7280',
                            boxWidth: 10,
                            boxHeight: 10,
                            usePointStyle: true,
                            pointStyle: 'circle',
                            padding: 16,
                            font: { size: 12 },
                            generateLabels: function (chart) {
                                var ds = (chart && chart.data && chart.data.datasets) || [];
                                var i;
                                var item;
                                var out = [];
                                for (i = 0; i < ds.length; i++) {
                                    item = ds[i] || {};
                                    out.push({
                                        text: String(item.label || ''),
                                        fillStyle: '#ffffff',
                                        strokeStyle: item.borderColor,
                                        lineWidth: 2,
                                        fontColor: '#6b7280',
                                        hidden: chart.getDatasetMeta(i).hidden,
                                        datasetIndex: i,
                                        pointStyle: 'circle'
                                    });
                                }
                                return out;
                            }
                        }
                    },
                    tooltip: {
                        enabled: false,
                        external: cxoRevCostExternalTooltip
                    }
                },
                scales: {
                    x: {
                        ticks: {
                            color: mut,
                            font: { size: 10.5 },
                            autoSkip: false,
                            maxRotation: 0,
                            minRotation: 0
                        },
                        grid: { color: 'transparent', drawBorder: false }
                    },
                    y: {
                        position: 'left',
                        beginAtZero: true,
                        grace: '6%',
                        ticks: {
                            color: mut,
                            font: { size: 10.5 },
                            callback: function (v) {
                                var n = Number(v);
                                if (isNaN(n)) return '';
                                return formatChartMoney(n, meta);
                            }
                        },
                        grid: { color: cssVar('--grid-line', 'rgba(0,0,0,.06)') || 'rgba(0,0,0,.06)' }
                    }
                },
                onClick: function (evt, elements) {
                    var idx = (elements && elements.length) ? elements[0].index : null;
                    openRevenueDrillFromChartPoint(idx);
                }
            }
        });
    }

    /* Purpose: SRS — every chart point opens Revenue drill at Group level for that month. */
    function openRevenueDrillFromChartPoint(monthIndex) {
        var row = null;
        var ms, me;
        RevenueDrill.monthFilter = null;
        if (monthIndex != null && !isNaN(monthIndex) && RevenueCostTrend.months && RevenueCostTrend.months[monthIndex]) {
            row = RevenueCostTrend.months[monthIndex];
            ms = parseFilterDate(getApiField(row, 'MonthStart'));
            me = parseFilterDate(getApiField(row, 'MonthEnd'));
            if (!ms && me) ms = new Date(me.getFullYear(), me.getMonth(), 1);
            if (!me && ms) me = new Date(ms.getFullYear(), ms.getMonth() + 1, 0);
            if (ms && me) {
                RevenueDrill.monthFilter = {
                    start: ms,
                    end: me,
                    label: String(getApiField(row, 'MonthLabel') || '')
                };
            }
        }
        if (typeof openRevenueDrill === 'function') {
            openRevenueDrill('Revenue', true, {
                keepMonthFilter: true
            });
        }
    }

    /* Purpose: Fetch chart series for current date + chip filters. */
    function LoadRevenueCostTrend() {
        var subEl = document.getElementById('chRevSub');
        if (!DateFilter.startDate || !DateFilter.endDate) {
            if (subEl) subEl.textContent = 'Select a date range to load the chart';
            destroyRevenueCostChart();
            return;
        }
        if (subEl) subEl.textContent = 'Loading chart\u2026';
        callDashboardApi('GetAnalyticsDBRevenueCostTrend', buildRevenueCostTrendRequest(), function (json) {
            var payload = getRevenueCostTrendPayload(json) || {};
            var meta = getApiField(payload, 'Meta') || {};
            var months = getApiField(payload, 'Months') || [];
            if (!Array.isArray(months)) months = getApiRows(months);
            RevenueCostTrend.meta = meta;
            RevenueCostTrend.months = months;
            plotRevenueCostTrendChart(meta, months);
            /* Keep Drill / Refresh / Share / FS tools wired after chart redraw */
            if (typeof bindExecBodyExtrasActions === 'function') bindExecBodyExtrasActions();
            /* If fullscreen clone is open, refresh painted canvas from live chart */
            setTimeout(function () {
                var src = document.getElementById('wRevCost');
                var live = document.querySelector('.widget-fs-clone[data-fs-src="wRevCost"]');
                if (src && live && typeof copyWidgetCanvases === 'function') copyWidgetCanvases(src, live);
            }, 80);
        }, function () {
            if (subEl) subEl.textContent = 'Unable to load Revenue vs Cost chart';
            destroyRevenueCostChart();
        });
    }

    /* =====================================================================
       Revenue drill-through — same modal UX as exec.html / app.js
       Levels: Portfolios › Portfolio › Project › Invoice › Timesheets › Audit
       SP: usp_Whizible2_Sel_AnalyticsDB_RevenueDrillDown via GetAnalyticsDBRevenueDrillDown
       Revenue KPI card value: usp_Whizible2_Sel_AnalyticsDBKPI_Revenue
       Revenue vs Cost Drill / chart point: same RevenueDrillDown as the Revenue KPI card
       Mix doughnut Drill: usp_Whizible2_Sel_AnalyticsDB_PortfolioRevenueMixDrillDown
       DipalI v On 11th sep 2026
       ===================================================================== */

    var RevenueDrill = {
        stack: [],
        lastRows: null,
        sourceFlag: 'Revenue',
        /* Revenue KPI card + Revenue vs Cost chart both use RevenueDrillDown */
        apiAction: 'GetAnalyticsDBRevenueDrillDown',
        /* SRS §4.1.2 — chart point click scopes drill to that month */
        monthFilter: null,
        levelLabels: ['Portfolio', 'Projects', 'Invoices', 'Invoice lines'],
        /* Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill stops at invoice lines */
        mixLevelLabels: ['Portfolio', 'Projects', 'Invoices', 'Invoice lines'],
        /* End of Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill stops at invoice lines */
        pfColors: ['#1359a6', '#0D9488', '#EA580C', '#7C3AED', '#DB2777', '#0891B2', '#65A30D', '#CA8A04']
    };

    /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
    var DelayedDrill = {
        stack: [],
        lastRows: null,
        levelLabels: ['Delayed projects', 'Milestones', 'Tasks']
    };
    /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */

    /* Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through */
    var BudgetVarianceDrill = {
        stack: [],
        lastRows: null,
        levelLabels: ['Projects', 'Milestones', 'Work items']
    };
    /* End of Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through */

    /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
    var CsatDrill = {
        active: false,
        stack: [],
        lastRows: null,
        levelLabels: ['Tickets', 'SLA Status']
    };
    /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */

    function isMixRevCostDrill() {
        return String(RevenueDrill.apiAction || '').indexOf('PortfolioRevenueMix') >= 0;
    }

    function revenueDrillLevelLabels() {
        return isMixRevCostDrill() ? RevenueDrill.mixLevelLabels : RevenueDrill.levelLabels;
    }

    function revenueDrillLevelCount() {
        return revenueDrillLevelLabels().length;
    }

    /* Added by Vikas T on 16-09-2026 - Utilization / Bench / Active Projects drill modal state
       API: GetAnalyticsDBKPIDrillDown → usp_Whizible2_Sel_AnalyticsDBKPI_{Flag} */
    var OpsKpiDrill = {
        active: false,
        flag: '',
        stack: [],
        lastRows: null,
        titles: {
            /* Added by Vikas T after changes 22-09-2026 - Util/Bench trail matches design HTML */
            /* Added by Vikas T on 30-09-2026 - Trail is Portfolio → Project → Resources → Entries (Title Case). */
            Utilization: 'Utilization Drill-Through \u00B7 Portfolio \u2192 Project \u2192 Resources \u2192 Entries',
            Bench: 'Bench Drill-Through \u00B7 Portfolio \u2192 Project \u2192 Resources \u2192 Entries',
            /* Added by Vikas T on 06-10-2026 - Level 4 removed. */
            ActiveProjects: 'Project Drill-Through \u00B7 Portfolio \u2192 Task Name'
        },
        levelLabels: {
            /* Added by Vikas T on 30-09-2026 - Util / Bench L1 tab = Portfolio; People → Resources (Title Case). */
            Utilization: ['Portfolio', 'Projects', 'Resources', 'Entries'],
            Bench: ['Portfolio', 'Projects', 'Resources', 'Entries'],
            /* Added by Vikas T on 06-10-2026 - three levels only (no Activity Log). */
            ActiveProjects: ['Projects', 'Milestones', 'Task Names']
        },
        emptyMsg: {
            Utilization: 'No data for the selected filters',
            /* Added by Vikas T on 30-09-2026 - People → Resources. */
            Bench: 'No bench resources for the selected filters',
            ActiveProjects: 'No active projects for the selected filters'
        },
        /* Added by Vikas T on 17-09-2026 - level-specific empty copy for Active drill */
        emptyMsgByLevel: {
            ActiveProjects: {
                1: 'No active projects for the selected filters',
                2: 'No milestones for this project',
                3: 'No tasks for this milestone'
            }
        }
    };

    /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through
       L1 DelayedProjectsList ? L2 Milestones ? L3 Tasks ? L4 Activity
       API: GetAnalyticsDBDelayedProjectsDrillDown
    */

    function openDelayedProjectsDrill() {
        var card;
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        card = findKpiCardByFlagOrLabel('DelayedProjects');
        if (!hasKpiDrillValue(card)) return;
        HideCxoTooltips();
        if (typeof closeWidgetFullscreen === 'function') closeWidgetFullscreen();
        OpsKpiDrill.active = false;
        OpsKpiDrill.flag = '';
        OpsKpiDrill.stack = [];
        RevenueDrill.stack = [];
        RevenueDrill.lastRows = null;
        BudgetVarianceDrill.stack = [];
        BudgetVarianceDrill.lastRows = null;
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        CsatDrill.active = false;
        CsatDrill.stack = [];
        CsatDrill.lastRows = null;
        /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        DelayedDrill.stack = [{
            level: 1,
            label: 'Delayed projects',
            projectId: null,
            itemId: null,
            itemType: null,
            taskId: null
        }];
        renderDelayedProjectsDrill();
        InitCxoBlackTooltips(document.getElementById('modal'));
    }

    function buildDelayedDrillRequest(node) {
        /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through
           Same chip rule as GetAnalyticsDBKPICards: empty = no filter.
           Do not send all greeting chip IDs (that dropped projects and returned rows: []). */
        var prevS = DateFilter.previousStart || DateFilter.startDate;
        var prevE = DateFilter.previousEnd || DateFilter.endDate;
        var body = {
            DashboardID: DASHBOARD_ID,
            Level: node.level,
            CurrentFromDate: formatApiDate(DateFilter.startDate),
            CurrentToDate: formatApiDate(DateFilter.endDate),
            PreviousFromDate: formatApiDate(prevS),
            PreviousToDate: formatApiDate(prevE),
            PortfolioIDs: joinSelectedIds('Portfolio'),
            CustomerIDs: joinSelectedIds('Customer'),
            ProjectManagerIDs: joinSelectedIds('Project Manager'),
            RegionIDs: joinSelectedIds('Region'),
            BillingTypeIDs: joinSelectedIds('Billing Type'),
            HealthIDs: joinSelectedIds('Health')
        };
        if (node.level >= 2 && node.projectId) body.ProjectID = node.projectId;
        if (node.level >= 3 && node.itemId) {
            body.ItemID = node.itemId;
            body.ItemType = node.itemType || 'Milestone';
        }
        if (node.level >= 4 && node.taskId) body.TaskID = node.taskId;
        return body;
        /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
    }

    function delayedStatusBadgeHtml(s) {
        var v = String(s || '').trim();
        var cls = 'info';
        /* Added by Vikas T on 06-10-2026 - product milestone statuses ('Milestone closed', 'Analysis completed') shown green. */
        if (/on track|done|closed|completed/i.test(v)) cls = 'good';
        else if (/slipped|red|critical/i.test(v)) cls = 'risk';
        else if (/at risk|amber|watch|review|in progress/i.test(v)) cls = 'warn';
        if (!v) return '-';
        return '<span class="badge b-' + cls + '"><i class="st-dot" aria-hidden="true"></i>' + escHtml(v) + '</span>';
    }

    // Commented and Added By Vyankat b. on 28th Sep 2026 for the ProjectCode under Project Name
    function drillProjectNameWithCodeHtml(row, name) {
        var code = String(getApiField(row, 'ProjectCode') || '').trim();
        return '<b>' + escHtml(name) + '</b>' +
            (code ? '<div style="font-size:10px;color:var(--faint)">' + escHtml(code) + '</div>' : '');
    }
    // End of Commented and Added By Vyankat b. on 28th Sep 2026 for the ProjectCode under Project Name

    function renderDelayedDrillTable(level, rows) {
        var head, bodyRows, name, top;
        rows = rows || [];
        top = DelayedDrill.stack[DelayedDrill.stack.length - 1] || {};

        if (level === 1) {
            // Commented and Added By Vyankat b. on 1st Oct 2026 for the CPI from latest snapshot CumulativeEV
            // head = ['Project', 'Customer', 'Health', 'SPI', 'Delay', 'Milestones'];
            // Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects Portfolio column
            // head = ['Project', 'Customer', 'Health', 'SPI', 'CPI', 'Delay', 'Milestones'];
            head = ['Project', 'Portfolio', 'Health', 'SPI', 'CPI', 'Delay', 'Milestones'];
            // End of Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects Portfolio column
            // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the CPI from latest snapshot CumulativeEV
            bodyRows = rows.map(function (row) {
                name = getApiField(row, 'ProjectName', 'Project') || '-';
                return {
                    next: Number(getApiField(row, 'ProjectID'))
                        ? {
                            level: 2,
                            label: name,
                            projectId: Number(getApiField(row, 'ProjectID')),
                            itemId: null,
                            itemType: null,
                            taskId: null
                        }
                        : null,
                    cells: [
                        drillProjectNameWithCodeHtml(row, name),
                        // Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects Portfolio column
                        // escHtml(getApiField(row, 'CustomerName', 'Customer') || '-'),
                        escHtml(getApiField(row, 'Portfolio', 'PortfolioName') || '-'),
                        // End of Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects Portfolio column
                        healthBadgeHtml(getApiField(row, 'Health')),
                        escHtml(getApiField(row, 'SPI') != null ? getApiField(row, 'SPI') : '-'),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the CPI from latest snapshot CumulativeEV
                        escHtml(getApiField(row, 'CPI') != null ? getApiField(row, 'CPI') : '-'),
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the CPI from latest snapshot CumulativeEV
                        escHtml(getApiField(row, 'Delay') != null ? getApiField(row, 'Delay') : '-'),
                        escHtml(getApiField(row, 'Milestones') != null ? getApiField(row, 'Milestones') : '0')
                    ],
                    exportCells: [
                        name,
                        // Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects Portfolio column
                        // getApiField(row, 'CustomerName', 'Customer'),
                        getApiField(row, 'Portfolio', 'PortfolioName'),
                        // End of Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects Portfolio column
                        getApiField(row, 'Health'),
                        getApiField(row, 'SPI'),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the CPI from latest snapshot CumulativeEV
                        getApiField(row, 'CPI'),
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the CPI from latest snapshot CumulativeEV
                        getApiField(row, 'Delay'),
                        getApiField(row, 'Milestones')
                    ]
                };
            });
        } else if (level === 2) {
            // Commented and Added By Vyankat b. on 1st Oct 2026 for the milestone delay status
            // head = ['Milestone', 'Due Date', 'Status', 'Resource Name'];
            head = ['Milestone', 'Due Date', 'Status', 'Responsible Person'];
            // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the milestone delay status
            bodyRows = rows.map(function (row) {
                name = getApiField(row, 'Milestone') || '-';
                return {
                    next: Number(getApiField(row, 'ItemID'))
                        ? {
                            level: 3,
                            label: name,
                            projectId: Number(getApiField(row, 'ProjectID')) || top.projectId,
                            itemId: Number(getApiField(row, 'ItemID')),
                            itemType: getApiField(row, 'ItemType') || 'Milestone',
                            taskId: null
                        }
                        : null,
                    cells: [
                        '<b>' + escHtml(name) + '</b>',
                        // Commented and Added By Vyankat b. on 30th Sep 2026 for the Date format like 01 Feb 2026
                        // escHtml(getApiField(row, 'Due', 'DueDate') || '-'),
                        escHtml(formatCxoCardDate(getApiField(row, 'Due', 'DueDate'))),
                        // End of Commented and Added By Vyankat b. on 30th Sep 2026 for the Date format like 01 Feb 2026
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the milestone delay status
                        // delayedStatusBadgeHtml(getApiField(row, 'ItemStatus')),
                        // escHtml(getApiField(row, 'Owner') || '-')
                        delayedStatusBadgeHtml(getApiField(row, 'Status', 'ItemStatus')),
                        escHtml(getApiField(row, 'ResponsiblePerson', 'Owner') || '')
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the milestone delay status
                    ],
                    exportCells: [
                        name,
                        // Commented and Added By Vyankat b. on 30th Sep 2026 for the Date format like 01 Feb 2026
                        // getApiField(row, 'Due', 'DueDate'),
                        formatCxoCardDate(getApiField(row, 'Due', 'DueDate')),
                        // End of Commented and Added By Vyankat b. on 30th Sep 2026 for the Date format like 01 Feb 2026
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the milestone delay status
                        // getApiField(row, 'ItemStatus'),
                        // getApiField(row, 'Owner')
                        getApiField(row, 'Status', 'ItemStatus'),
                        getApiField(row, 'ResponsiblePerson', 'Owner') || ''
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the milestone delay status
                    ]
                };
            });
        } else if (level === 3) {
            // Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
            // head = ['Work item', 'Assignee', 'Est / actual (h)', 'State'];
            // head = ['Work item', 'Assignee', 'Estimated h', 'Actual h', 'Effort variance', 'State'];
            // head = ['Task name', 'Assignee', 'Estimated h', 'Actual h', 'Effort variance', 'Status'];
            head = ['Task name', 'Assignee', 'Estimate Hrs.', 'Actual Hrs.', 'Effort variance', 'Status'];
            // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
            bodyRows = rows.map(function (row) {
                var est, act;
                // Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects child task name only
                // name = getApiField(row, 'WorkItem', 'TaskName') || '-';
                name = getApiField(row, 'TaskName') || '-';
                // End of Commented and Added By Vyankat b. on 5th Oct 2026 for the Delayed Projects child task name only
                // Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
                est = getApiField(row, 'EstHours', 'Estimated h', 'EstimatedH');
                act = getApiField(row, 'ActualHours', 'Actual h', 'ActualH');
                // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
                return {
                    // Commented and Added By Vyankat b. on 1st Oct 2026 for removing Delayed Projects Level 4
                    // next: Number(getApiField(row, 'TaskID'))
                    //     ? {
                    //         level: 4,
                    //         label: name,
                    //         projectId: Number(getApiField(row, 'ProjectID')) || top.projectId,
                    //         itemId: top.itemId,
                    //         itemType: top.itemType,
                    //         taskId: Number(getApiField(row, 'TaskID'))
                    //     }
                    //     : null,
                    next: null,
                    // End of Commented and Added By Vyankat b. on 1st Oct 2026 for removing Delayed Projects Level 4
                    cells: [
                        '<b>' + escHtml(name) + '</b>',
                        escHtml(getApiField(row, 'Assignee') || '-'),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
                        // escHtml(getApiField(row, 'EstActualHours') || '-'),
                        escHtml(est != null && String(est).trim() !== '' ? String(est).replace(/\.0$/, '') : '-'),
                        escHtml(act != null && String(act).trim() !== '' ? String(act).replace(/\.0$/, '') : '-'),
                        // effortVarianceBadge(est, act),
                        effortVarianceSpBadge(getApiField(row, 'EffortVariance', 'Effort variance')),
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
                        delayedStatusBadgeHtml(getApiField(row, 'Status', 'State'))
                    ],
                    exportCells: [
                        name,
                        getApiField(row, 'Assignee'),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
                        // getApiField(row, 'EstActualHours'),
                        est,
                        act,
                        // effortVarianceText(est, act),
                        getApiField(row, 'EffortVariance', 'Effort variance'),
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects task hours columns
                        getApiField(row, 'Status', 'State')
                    ]
                };
            });
        } else {
            head = ['Timestamp', 'Actor', 'Activity'];
            bodyRows = rows.map(function (row) {
                return {
                    next: null,
                    cells: [
                        escHtml(getApiField(row, 'Timestamp') || '-'),
                        escHtml(getApiField(row, 'Actor') || '-'),
                        escHtml(getApiField(row, 'Activity') || '-')
                    ],
                    exportCells: [
                        getApiField(row, 'Timestamp'),
                        getApiField(row, 'Actor'),
                        getApiField(row, 'Activity')
                    ]
                };
            });
        }

        DelayedDrill.lastRows = [head].concat(bodyRows.map(function (x) { return x.exportCells; }));

        if (!bodyRows.length) {
            return {
                html: '<div class="m-note">No rows for this level in the selected period.</div>',
                bodyRows: []
            };
        }

        return {
            bodyRows: bodyRows,
            html: renderDrillTableHtml(head, bodyRows, level === 1 ? {
                colWidths: ['18%', '17%', '12%', '13%', '13%', '12%', '15%']
            } : null)
        };
    }

    // Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects export on Level 1 only

    function renderDelayedProjectsDrill() {
        var ov = document.getElementById('overlay');
        var title = document.getElementById('mTitle');
        var crumbs = document.getElementById('mCrumbs');
        var body = document.getElementById('mBody');
        var top, i, html;
        if (!ov || !body) return;
        top = DelayedDrill.stack[DelayedDrill.stack.length - 1];
        // Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects export on Level 1 only
        syncDrillExportVisibility(top && top.level);
        // End of Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects export on Level 1 only
        ov.classList.add('open');
        // Commented and Added By Vyankat b. on 1st Oct 2026 for removing Delayed Projects Level 4
        // if (title) title.textContent = 'Delayed Projects Drill-Through \u2192 Project \u2192 Activity';
        if (title) title.textContent = 'Delayed Projects Drill-Through \u2192 Project \u2192 Task';
        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for removing Delayed Projects Level 4
        renderRevenueDrillFilterBar();
        if (crumbs) {
            html = '';
            for (i = 0; i < DelayedDrill.stack.length; i++) {
                if (i) html += '<span>&gt;</span>';
                html += '<button type="button" data-crumb-i="' + i + '">' + escHtml(DelayedDrill.stack[i].label) + '</button>';
            }
            crumbs.innerHTML = html;
            crumbs.querySelectorAll('[data-crumb-i]').forEach(function (btn) {
                btn.onclick = function () {
                    var idx = Number(btn.getAttribute('data-crumb-i'));
                    DelayedDrill.stack = DelayedDrill.stack.slice(0, idx + 1);
                    renderDelayedProjectsDrill();
                };
            });
        }

        body.innerHTML = '<div class="m-note">Level ' + top.level + ' of 3 - ' +
            escHtml(DelayedDrill.levelLabels[top.level - 1] || top.label) +
            ' - Period ' + escHtml(revenueDrillPeriodNote()) +
            (top.level >= 3 ? '. End of drill-down.' : '. Click a row to go deeper.') +
            '</div><div class="m-note" style="padding-top:0">Loading...</div>';

        callDashboardApi('GetAnalyticsDBDelayedProjectsDrillDown', buildDelayedDrillRequest(top), function (json) {
            var payload = unwrapDrillPayload(json);
            var rows = payload.Rows || payload.rows || [];
            var painted;
            if (!Array.isArray(rows)) rows = [];
            painted = renderDelayedDrillTable(top.level, rows);
            body.innerHTML = '<div class="m-note">Level ' + top.level + ' of 3 - ' +
                escHtml(getApiField(payload, 'LevelLabel') || top.label || DelayedDrill.levelLabels[top.level - 1] || '') +
                ' - Period ' + escHtml(revenueDrillPeriodNote()) +
                (top.level >= 3
                    ? '. End of drill-down.'
                    : '. Click a row to go deeper.') +
                '</div>' + painted.html;

            body.querySelectorAll('tr[data-drill-i]').forEach(function (tr) {
                var idx = Number(tr.getAttribute('data-drill-i'));
                var rowMeta = painted.bodyRows[idx];
                var next = rowMeta && rowMeta.next;
                if (!next) return;
                tr.onclick = function () {
                    DelayedDrill.stack.push(next);
                    renderDelayedProjectsDrill();
                };
            });
            InitCxoBlackTooltips(document.getElementById('modal'));
        }, function () {
            body.innerHTML = '<div class="m-note">Unable to load delayed projects drill-down. Please try again.</div>';
            showAlertError('Unable to load delayed projects drill-down.');
        });
    }
    /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */

    /* Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through
       Same 4-level project trail as the CXO HTML prototype:
       Projects ? Milestones ? Work items ? Activity log
       API: GetAnalyticsDBBudgetVarianceDrillDown
    */
    function openBudgetVarianceDrill(forceOpen) {
        var card;
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        /* KPI card with 0 value stays non-drillable; chart Drill tool always opens (forceOpen). */
        if (!forceOpen) {
            card = findKpiCardByFlagOrLabel('BudgetVariance');
            if (!hasKpiDrillValue(card)) return;
        }
        HideCxoTooltips();
        if (typeof closeWidgetFullscreen === 'function') closeWidgetFullscreen();
        OpsKpiDrill.active = false;
        OpsKpiDrill.flag = '';
        OpsKpiDrill.stack = [];
        RevenueDrill.stack = [];
        RevenueDrill.lastRows = null;
        DelayedDrill.stack = [];
        DelayedDrill.lastRows = null;
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        CsatDrill.active = false;
        CsatDrill.stack = [];
        CsatDrill.lastRows = null;
        /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        BudgetVarianceDrill.stack = [{
            level: 1,
            label: 'Projects',
            projectId: null,
            groupName: null,
            itemId: null,
            itemType: null,
            taskId: null
        }];
        renderBudgetVarianceDrill();
        InitCxoBlackTooltips(document.getElementById('modal'));
    }

    function buildBudgetVarianceDrillRequest(node) {
        var prevS = DateFilter.previousStart || DateFilter.startDate;
        var prevE = DateFilter.previousEnd || DateFilter.endDate;
        var body = {
            DashboardID: DASHBOARD_ID,
            Level: node.level,
            CurrentFromDate: formatApiDate(DateFilter.startDate),
            CurrentToDate: formatApiDate(DateFilter.endDate),
            PreviousFromDate: formatApiDate(prevS),
            PreviousToDate: formatApiDate(prevE),
            PortfolioIDs: joinSelectedIds('Portfolio'),
            CustomerIDs: joinSelectedIds('Customer'),
            ProjectManagerIDs: joinSelectedIds('Project Manager'),
            RegionIDs: joinSelectedIds('Region'),
            BillingTypeIDs: joinSelectedIds('Billing Type'),
            HealthIDs: joinSelectedIds('Health')
        };
        if (node.level >= 2 && node.projectId) body.ProjectID = node.projectId;
        if (node.level >= 3 && node.itemId) {
            body.ItemID = node.itemId;
            body.ItemType = node.itemType || 'Milestone';
        }
        if (node.level >= 4 && node.taskId) body.TaskID = node.taskId;
        return body;
    }

    function bvIndexBadge(v) {
        var n = Number(v);
        if (v == null || v === '' || isNaN(n)) return '-';
        var cls = n < 1 ? 'risk' : 'good';
        return '<span class="badge b-' + cls + '">' + n.toFixed(2) + '</span>';
    }

    function effortVarianceBadge(est, act) {
        var e = Number(est);
        var a = Number(act);
        var v, cls;
        /* Added By Vyankat b. on 22th Sep 2026 for the Effort variance when Estimated h is 0 */
        if (!e || isNaN(e)) {
            if (a && !isNaN(a) && a > 0) {
                return '<span class="badge b-warn">No estimate</span>';
            }
            return '-';
        }
        v = ((a - e) / e) * 100;
        cls = v > 50 ? 'risk' : v > 25 ? 'warn' : 'good';
        return '<span class="badge b-' + cls + '">' + (v > 0 ? '+' : '') + v.toFixed(1) + '%</span>';
    }

    function effortVarianceSpBadge(text) {
        var s = String(text == null ? '' : text).trim();
        var n, cls;
        if (!s || s === '-') return '-';
        if (/no estimate/i.test(s)) return '<span class="badge b-warn">' + escHtml(s) + '</span>';
        n = parseFloat(s);
        if (isNaN(n)) return escHtml(s);
        cls = n > 50 ? 'risk' : n > 25 ? 'warn' : 'good';
        return '<span class="badge b-' + cls + '">' + escHtml(s) + '</span>';
    }
    // End of Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects Effort variance from the SP

    function effortVarianceText(est, act) {
        var e = Number(est);
        var a = Number(act);
        var v;
        if (!e || isNaN(e)) {
            if (a && !isNaN(a) && a > 0) return 'No estimate';
            return '-';
        }
        v = ((a - e) / e) * 100;
        return (v > 0 ? '+' : '') + v.toFixed(1) + '%';
    }
   // End of Added By Vyankat B. on 30th Sim 2026 for Excel export Effort variance same as screen (plain text, no badge html)

    function parseDelayDays(v) {
        var m = String(v == null ? '' : v).match(/(\d+)/);
        return m ? Number(m[1]) : 0;
    }

    function formatDrillPrettyDate(v) {
        var s, d, months, day;
        if (v == null || v === '') return '-';
        s = String(v).trim();
        if (/^[A-Za-z]{3}\s+\d{1,2},\s+\d{4}$/.test(s)) return s;
        d = new Date(s);
        if (isNaN(d.getTime())) return s;
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        day = d.getDate();
        return months[d.getMonth()] + ' ' + (day < 10 ? '0' + day : day) + ', ' + d.getFullYear();
    }

    // Commented and Added By Vyankat b. on 30th Sep 2026 for the Date format like 01 Feb 2026
    function formatCxoCardDate(v) {
        var s, d, months, day;
        if (v == null || v === '') return '-';
        s = String(v).trim();
        if (/^\d{2}\s+[A-Za-z]{3}\s+\d{4}$/.test(s)) return s;
        d = new Date(s);
        if (isNaN(d.getTime())) return s;
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        day = d.getDate();
        return (day < 10 ? '0' + day : day) + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
    }
    // End of Commented and Added By Vyankat b. on 30th Sep 2026 for the Date format like 01 Feb 2026

    function budgetVarianceGlobalFilterNote() {
        var labels = ['Portfolio', 'Customer', 'Project Manager', 'Health', 'Region', 'Billing Type'];
        var used = [];
        labels.forEach(function (l) {
            if (joinSelectedIds(l)) used.push(l);
        });
        return 'rows respect the global filters (' +
            (used.length ? used.join(', ') : 'No filters (whole organisation)') +
            ') and the Period ' + revenueDrillPeriodNote();
    }

    function budgetVarianceCtxBar() {
        /* Filtered by chips render once in #mFilters — avoid duplicate "Filtered by" bar. */
        return '';
    }

    function renderBudgetVarianceDrillTable(level, rows) {
        var head, bodyRows, name, top, est, act, delay, burn, pctComplete;
        rows = rows || [];
        top = BudgetVarianceDrill.stack[BudgetVarianceDrill.stack.length - 1] || {};
        if (level === 2) {
            rows = rows.filter(function (row) {
                return getApiField(row, 'Milestone', 'ItemID') && !getApiField(row, 'EmployeeName');
            });
        }

        if (level === 1) {
            // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance Portfolio header
            // head = ['Project', 'Group', 'Health', 'SPI', 'CPI', withPctCaption('% complete'), withPctCaption('Budget burn'), 'Delay', 'Milestones'];
            head = ['Project', 'Portfolio', 'Health', 'SPI', 'CPI', withPctCaption('% complete'), withPctCaption('Budget burn'), 'Delay', 'Milestones'];
            // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance Portfolio header
            bodyRows = rows.map(function (row) {
                name = getApiField(row, 'ProjectName', 'Project') || '-';
                delay = getApiField(row, 'Delay');
                burn = getApiField(row, 'BudgetBurnPct');
                pctComplete = getApiField(row, 'PctComplete');
                return {
                    next: Number(getApiField(row, 'ProjectID'))
                        ? {
                            level: 2,
                            label: name,
                            projectId: Number(getApiField(row, 'ProjectID')),
                            // Commented and Added By Vyankat b. on 30th Sep 2026 for the Portfolio column instead of Group
                            // groupName: getApiField(row, 'GroupName', 'Group') || '',
                            groupName: getApiField(row, 'Portfolio', 'PortfolioName') || '',
                            // End of Commented and Added By Vyankat b. on 30th Sep 2026 for the Portfolio column instead of Group
                            delayDays: parseDelayDays(getApiField(row, 'Delay')),
                            itemId: null,
                            itemType: null,
                            taskId: null
                        }
                        : null,
                    cells: [
                        drillProjectNameWithCodeHtml(row, name),
                        // Commented and Added By Vyankat b. on 30th Sep 2026 for the Portfolio column instead of Group
                        // escHtml(getApiField(row, 'GroupName', 'Group') || '-'),
                        escHtml(getApiField(row, 'Portfolio', 'PortfolioName') || '-'),
                        // End of Commented and Added By Vyankat b. on 30th Sep 2026 for the Portfolio column instead of Group
                        healthBadgeHtml(getApiField(row, 'Health')),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance SPI CPI without color
                        // bvIndexBadge(getApiField(row, 'SPI')),
                        // bvIndexBadge(getApiField(row, 'CPI')),
                        escHtml(getApiField(row, 'SPI') != null && getApiField(row, 'SPI') !== '' ? getApiField(row, 'SPI') : '-'),
                        escHtml(getApiField(row, 'CPI') != null && getApiField(row, 'CPI') !== '' ? getApiField(row, 'CPI') : '-'),
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance SPI CPI without color
                        '<span class="num">' + (pctComplete != null && pctComplete !== ''
                            ? Number(pctComplete).toFixed(1) + '%' : '-') + '</span>',
                        '<span class="num">' + (burn != null && burn !== ''
                            ? Number(burn).toFixed(1) + '%' : '-') + '</span>',
                        escHtml(delay != null && String(delay).trim() !== '' ? delay : '-'),
                        escHtml(getApiField(row, 'Milestones') != null ? getApiField(row, 'Milestones') : '0')
                    ],
                    exportCells: [
                        name,
                        getApiField(row, 'Portfolio', 'PortfolioName'),
                        getApiField(row, 'Health'),
                        // Commented and Added By Vyankat B. on 30th Sep 2026 for Excel export SPI/CPI 2 decimals and % values with 1 decimal
                        // getApiField(row, 'SPI'),
                        // getApiField(row, 'CPI'),
                        // pctComplete,
                        // burn,
                        (getApiField(row, 'SPI') != null && getApiField(row, 'SPI') !== '' && !isNaN(Number(getApiField(row, 'SPI')))) ? Number(getApiField(row, 'SPI')).toFixed(2) : '-',
                        (getApiField(row, 'CPI') != null && getApiField(row, 'CPI') !== '' && !isNaN(Number(getApiField(row, 'CPI')))) ? Number(getApiField(row, 'CPI')).toFixed(2) : '-',
                        (pctComplete != null && pctComplete !== '') ? Number(pctComplete).toFixed(1) + '%' : '-',
                        (burn != null && burn !== '') ? Number(burn).toFixed(1) + '%' : '-',
                        // End of Commented and Added By Vyankat B. on 30th Sep 2026 for Excel export SPI/CPI 2 decimals and % values with 1 decimal
                        delay,
                        getApiField(row, 'Milestones')
                    ]
                };
            });
        } else if (level === 2) {
            // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L2 same as Delayed Projects
            // head = ['Milestone', 'Baseline date', 'Status', 'Owner', 'Predecessor risk'];
            head = ['Milestone', 'Due Date', 'Status', 'Responsible Person'];
            // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L2 same as Delayed Projects
            bodyRows = rows.map(function (row) {
                name = getApiField(row, 'Milestone') || '-';
                var status = getApiField(row, 'Status', 'ItemStatus') || '';
                return {
                    next: Number(getApiField(row, 'ItemID'))
                        ? {
                            level: 3,
                            label: name,
                            projectId: Number(getApiField(row, 'ProjectID')) || top.projectId,
                            groupName: top.groupName,
                            delayDays: top.delayDays,
                            itemId: Number(getApiField(row, 'ItemID')),
                            itemType: getApiField(row, 'ItemType') || 'Milestone',
                            taskId: null
                        }
                        : null,
                    cells: [
                        '<b>' + escHtml(name) + '</b>',
                        escHtml(formatCxoCardDate(getApiField(row, 'Due', 'DueDate', 'BaselineDate'))),
                        delayedStatusBadgeHtml(status),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L2 same as Delayed Projects
                        // escHtml(getApiField(row, 'Owner') || '-'),
                        // escHtml(pred)
                        escHtml(getApiField(row, 'ResponsiblePerson', 'Owner') || '')
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L2 same as Delayed Projects
                    ],
                    exportCells: [
                        name,
                        getApiField(row, 'Due', 'DueDate', 'BaselineDate'),
                        status,
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L2 same as Delayed Projects
                        // getApiField(row, 'Owner'),
                        // pred
                        getApiField(row, 'ResponsiblePerson', 'Owner') || ''
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L2 same as Delayed Projects
                    ]
                };
            });
        } else if (level === 3) {
            // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L3 same as Delayed Projects
            // head = ['Work item', 'Assignee', 'Estimated h', 'Actual h', 'Effort variance', 'State'];
            head = ['Task name', 'Assignee', 'Estimate Hrs.', 'Actual Hrs.', 'Effort variance', 'Status'];
            // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L3 same as Delayed Projects
            bodyRows = rows.map(function (row) {
                name = getApiField(row, 'WorkItem', 'TaskName') || '-';
                est = getApiField(row, 'EstHours');
                act = getApiField(row, 'ActualHours');
                return {
                    // Commented and Added By Vyankat b. on 1st Oct 2026 for removing Budget Variance Level 4
                    // next: Number(getApiField(row, 'TaskID'))
                    //     ? {
                    //         level: 4,
                    //         label: name,
                    //         projectId: Number(getApiField(row, 'ProjectID')) || top.projectId,
                    //         groupName: top.groupName,
                    //         delayDays: top.delayDays,
                    //         itemId: top.itemId,
                    //         itemType: top.itemType,
                    //         taskId: Number(getApiField(row, 'TaskID'))
                    //     }
                    //     : null,
                    next: null,
                    // End of Commented and Added By Vyankat b. on 1st Oct 2026 for removing Budget Variance Level 4
                    cells: [
                        '<b>' + escHtml(name) + '</b>',
                        escHtml(getApiField(row, 'Assignee') || '-'),
                        escHtml(est != null && String(est).trim() !== '' ? String(est).replace(/\.0$/, '') : '-'),
                        escHtml(act != null && String(act).trim() !== '' ? String(act).replace(/\.0$/, '') : '-'),
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L3 same as Delayed Projects
                        // effortVarianceBadge(est, act),
                        // delayedStatusBadgeHtml(getApiField(row, 'State'))
                        effortVarianceSpBadge(getApiField(row, 'EffortVariance', 'Effort variance')),
                        delayedStatusBadgeHtml(getApiField(row, 'Status', 'State'))
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L3 same as Delayed Projects
                    ],
                    exportCells: [
                        name,
                        getApiField(row, 'Assignee'),
                        est,
                        act,
                        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L3 same as Delayed Projects
                        // effortVarianceText(est, act),
                        // getApiField(row, 'State')
                        getApiField(row, 'EffortVariance', 'Effort variance'),
                        getApiField(row, 'Status', 'State')
                        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance L3 same as Delayed Projects
                    ]
                };
            });
        } else {
            head = ['Timestamp', 'Actor', 'Activity'];
            bodyRows = rows.map(function (row) {
                return {
                    next: null,
                    cells: [
                        escHtml(getApiField(row, 'Timestamp') || '-'),
                        escHtml(getApiField(row, 'Actor') || '-'),
                        escHtml(getApiField(row, 'Activity') || '-')
                    ],
                    exportCells: [
                        getApiField(row, 'Timestamp'),
                        getApiField(row, 'Actor'),
                        getApiField(row, 'Activity')
                    ]
                };
            });
        }

        BudgetVarianceDrill.lastRows = [head].concat(bodyRows.map(function (x) { return x.exportCells; }));

        if (!bodyRows.length) {
            return {
                html: '<div class="m-note">' +
                    (level === 2
                        ? 'No milestones on this project.'
                        : 'No rows for this level in the selected period.') +
                    '</div>',
                bodyRows: []
            };
        }

        return {
            bodyRows: bodyRows,
            html: renderDrillTableHtml(head, bodyRows)
        };
    }


    // Added By Vyankat B. on 30th Sep 2026 for Excel export Effort variance same as screen (plain text, no badge html)

    function renderBudgetVarianceDrill() {
        var ov = document.getElementById('overlay');
        var title = document.getElementById('mTitle');
        var crumbs = document.getElementById('mCrumbs');
        var body = document.getElementById('mBody');
        var top, i, html;
        if (!ov || !body) return;
        top = BudgetVarianceDrill.stack[BudgetVarianceDrill.stack.length - 1];
        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance export on Level 1 only
        // syncDrillExportVisibility(1);
        syncDrillExportVisibility(top && top.level);
        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance export on Level 1 only
        ov.classList.add('open');
        // Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance drill title
        // if (title) title.textContent = 'Project Drill-Through \u2192 Portfolio \u2192 Work Item \u2192 Activity';
        if (title) title.textContent = 'Budget Variance Projects Drill-Through';
        // End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Budget Variance drill title
        renderRevenueDrillFilterBar();
        if (crumbs) {
            html = '';
            for (i = 0; i < BudgetVarianceDrill.stack.length; i++) {
                if (i) html += '<span>&gt;</span>';
                html += '<button type="button" data-crumb-i="' + i + '">' +
                    escHtml(BudgetVarianceDrill.stack[i].label) + '</button>';
            }
            crumbs.innerHTML = html;
            crumbs.querySelectorAll('[data-crumb-i]').forEach(function (btn) {
                btn.onclick = function () {
                    var idx = Number(btn.getAttribute('data-crumb-i'));
                    BudgetVarianceDrill.stack = BudgetVarianceDrill.stack.slice(0, idx + 1);
                    renderBudgetVarianceDrill();
                };
            });
        }

        body.innerHTML = (top.level >= 2 ? budgetVarianceCtxBar() : '') +
            '<div class="m-note">Level ' + top.level + ' of 3 - <b>' +
            escHtml(BudgetVarianceDrill.levelLabels[top.level - 1] || top.label) +
            '</b> - ' + escHtml(budgetVarianceGlobalFilterNote()) +
            '.</div><div class="m-note" style="padding-top:0">Loading...</div>';

        callDashboardApi('GetAnalyticsDBBudgetVarianceDrillDown', buildBudgetVarianceDrillRequest(top), function (json) {
            var payload = unwrapDrillPayload(json);
            var rows = payload.Rows || payload.rows || [];
            var painted;
            var proj;
            var mile;
            if (!Array.isArray(rows)) rows = [];
            painted = renderBudgetVarianceDrillTable(top.level, rows);
            body.innerHTML = (top.level >= 2 ? budgetVarianceCtxBar() : '') +
                '<div class="m-note">Level ' + top.level + ' of 3 - <b>' +
                escHtml(BudgetVarianceDrill.levelLabels[top.level - 1] || '') +
                '</b> - ' + escHtml(budgetVarianceGlobalFilterNote()) +
                '.</div>' + painted.html;

            body.querySelectorAll('tr[data-drill-i]').forEach(function (tr) {
                var idx = Number(tr.getAttribute('data-drill-i'));
                var rowMeta = painted.bodyRows[idx];
                var next = rowMeta && rowMeta.next;
                if (!next) return;
                tr.onclick = function () {
                    BudgetVarianceDrill.stack.push(next);
                    renderBudgetVarianceDrill();
                };
            });
            InitCxoBlackTooltips(document.getElementById('modal'));
        }, function () {
            body.innerHTML = '<div class="m-note">Unable to load budget variance drill-down. Please try again.</div>';
            showAlertError('Unable to load budget variance drill-down.');
        });
    }
    /* End of Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through */

    /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
    function csatRatingStarsHtml(rating) {
        var n = Number(rating);
        var i, html;
        if (isNaN(n) || n <= 0) {
            return '<span class="csat-stars-na">Not rated</span>';
        }
        n = Math.max(0, Math.min(5, Math.round(n)));
        html = '<span class="csat-stars" title="' + n + ' / 5">';
        for (i = 1; i <= 5; i++) {
            html += '<span class="' + (i <= n ? 'on' : '') + '">&#9733;</span>';
        }
        html += '</span>';
        return html;
    }

    function buildCsatDrillRequest(node) {
        var prevS = DateFilter.previousStart || DateFilter.startDate;
        var prevE = DateFilter.previousEnd || DateFilter.endDate;
        var top = node || (CsatDrill.stack[CsatDrill.stack.length - 1] || {});
        var body = {
            DashboardID: DASHBOARD_ID,
            Level: top.level || 1,
            CurrentFromDate: formatApiDate(DateFilter.startDate),
            CurrentToDate: formatApiDate(DateFilter.endDate),
            PreviousFromDate: formatApiDate(prevS),
            PreviousToDate: formatApiDate(prevE),
            /* Commented and Added By Vyankat b. on 28th Sep 2026 for CSAT drill Customer chip only */
            PortfolioIDs: '',
            CustomerIDs: joinSelectedIds('Customer'),
            ProjectManagerIDs: '',
            RegionIDs: '',
            BillingTypeIDs: '',
            HealthIDs: ''
            /* End of Commented and Added By Vyankat b. on 28th Sep 2026 for CSAT drill Customer chip only */
        };
        if ((top.level || 1) >= 2 && top.queryId) body.QueryID = top.queryId;
        return body;
    }

    function csatSlaMetHtml(metText) {
        var v = String(metText || '').trim();
        if (v === '0') v = 'Not Met';
        else if (v === '1') v = 'Met';
        else if (v === '2') v = 'Not Occured';
        else if (v === '3') v = 'Not Acknowledged';
        if (!v) return '-';
        return escHtml(v);
    }

    function csatTruncateWithTip(text, maxLen) {
        var full = String(text == null ? '' : text).replace(/\s+/g, ' ').trim();
        var limit = maxLen || 20;
        if (!full || full === '-') return '-';
        if (full.length <= limit) return escHtml(full);
        return '<span title="' + escHtml(full) + '" data-cxo-tip="' + escHtml(full) + '">' +
            escHtml(full.slice(0, limit)) + '...</span>';
    }
    // End of Added By Vyankat B. on 30th Sep 2026 for CSAT drill Ticket Summary - show first 20 chars + tooltip with full text

    function renderCsatDrillTable(level, rows) {
        var head, bodyRows, summary, queryId;
        rows = rows || [];

        if (level === 2) {
            head = ['SLA', 'Norm', 'Actual', 'Remaining', 'Met/Not Met'];
            bodyRows = rows.map(function (row) {
                var slaName = getApiField(row, 'SLAName', 'SLA') || '-';
                var norm = getApiField(row, 'strNorm', 'Norm') || '-';
                var actual = getApiField(row, 'strActualDuration', 'ActualDuration');
                var remain = getApiField(row, 'RemainingHrsMin');
                var met = getApiField(row, 'MetApplicable') || getApiField(row, 'Met') || '-';
                if (actual == null || String(actual).trim() === '') actual = '-';
                if (remain == null || String(remain).trim() === '') remain = '-';
                return {
                    next: null,
                    cells: [
                        '<b>' + escHtml(slaName) + '</b>',
                        escHtml(norm),
                        escHtml(actual),
                        remain !== '-'
                            ? '<span class="csat-sla-remain">' + escHtml(remain) + '</span>'
                            : '-',
                        csatSlaMetHtml(met)
                    ],
                    exportCells: [slaName, norm, actual, remain, met]
                };
            });
        } else {
            head = [
                'Ticket Summary',
                'Submitted Date',
                'Customer',
                'Department',
                'Rating',
                'Aging'
                // Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA Details column
                // 'SLA Details'
                // End of Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA Details column

            ];
            bodyRows = rows.map(function (row) {
                summary = getApiField(row, 'TicketSummary') || '-';
                queryId = Number(getApiField(row, 'QueryID'));
                var customer = getApiField(row, 'CustomerName', 'Customer') || '-';
                var submitted = getApiField(row, 'SubmittedDate') || '-';
                var rating = getApiField(row, 'Rating');
                var dept = getApiField(row, 'Department') || '-';
                var aging = getApiField(row, 'AgingDays');
                var agingNum = Number(aging);
                /* Commented and Added By Vyankat b. on 28th Sep 2026 for Aging 0 → "-" */
                var agingTxt = (aging == null || aging === '' || isNaN(agingNum) || agingNum <= 0)
                    ? '-'
                    : (String(agingNum) + (agingNum === 1 ? ' day' : ' days'));
                /* End of Commented and Added By Vyankat b. on 28th Sep 2026 for Aging 0 → "-" */
                var ratingTxt = (rating == null || rating === '') ? 'Not rated' : String(rating);
                // Commented and Added By Vyankat b. on 28th Sep 2026 for "-" when Helpdesk SLA is not present
                var hasSlaRaw = getApiField(row, 'HasSLA');
                var slaDetails = String(getApiField(row, 'SLADetails') || '').trim();
                var hasSla = hasSlaRaw === true || hasSlaRaw === 1 || hasSlaRaw === '1'
                    || String(hasSlaRaw || '').toLowerCase() === 'true'
                    || slaDetails.toLowerCase() === 'view sla';
                var slaCell = hasSla
                    ? '<span class="csat-sla-link">View SLA</span>'
                    : '-';
                var slaExport = hasSla ? 'View SLA' : '-';
                // End of Commented and Added By Vyankat b. on 28th Sep 2026 for "-" when Helpdesk SLA is not present
                return {
                    next: (queryId && hasSla)
                        ? {
                            level: 2,
                            label: summary,
                            queryId: queryId
                        }
                        : null,
                    cells: [
                        // Commented and Added By Vyankat B. on 1st Oct 2026 for SLA badge on clickable rows
                        // '<b>' + csatTruncateWithTip(summary, 20) + '</b>',
                        '<b>' + csatTruncateWithTip(summary, 20) + '</b>' +
                        //(hasSla ? ' <span class="badge b-info" style="margin-left:6px;font-size:10px">SLA</span>' : ''),
                        '<b>' + csatTruncateWithTip(summary, 20) + '</b>',
                        // End of Commented and Added By Vyankat B. on 1st Oct 2026 for SLA badge on clickable rows
                        escHtml(submitted),
                        escHtml(customer),
                        escHtml(dept),
                        csatRatingStarsHtml(rating),
                        escHtml(agingTxt)
                        // Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA Details column
                        // ,slaCell
                        // End of Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA Details column
                    ],
                    // Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA Details column
                    // exportCells: [summary, submitted, customer, dept, ratingTxt, agingTxt, slaExport]
                    exportCells: [summary, submitted, customer, dept, ratingTxt, agingTxt]
// End of Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA Details column
                };
            });
        }

        CsatDrill.lastRows = [head].concat(bodyRows.map(function (x) { return x.exportCells; }));

        if (!bodyRows.length) {
            return {
                html: '<div class="m-note">' +
                    (level === 2
                        ? 'No SLA Status rows for this ticket.'
                        : 'No closed customer tickets in the selected period.') +
                    '</div>',
                bodyRows: []
            };
        }

        var tableHtml = '<div class="scroll-x grid-scroll"><table class="tbl"><thead><tr>' +
            head.map(function (h) { return '<th>' + escHtml(h) + '</th>'; }).join('') +
            '</tr></thead><tbody>' +
            bodyRows.map(function (row, idx) {
                // Commented and Added By Vyankat B. on 30th Sep 2026 for no click / pointer / drill tooltip when SLA Details is not present
                // var trClass = row.next ? ' class="drill-row"' : '';
                // return '<tr data-drill-i="' + idx + '"' + trClass + '>' +
                var trAttr = row.next
                    ? (' data-drill-i="' + idx + '" class="drill-row"')
                    : ' style="cursor:default"';
                return '<tr' + trAttr + '>' +
                // End of Commented and Added By Vyankat B. on 30th Sep 2026 for no click / pointer / drill tooltip when SLA Details is not present
                    row.cells.map(function (c) { return '<td>' + c + '</td>'; }).join('') +
                    '</tr>';
            }).join('') +
            '</tbody></table></div>';

        return {
            bodyRows: bodyRows,
            // Added By Vyankat B. on 1st Oct 2026 for the SLA note
            hasClickable: bodyRows.some(function (x) { return !!x.next; }),
    // End of Added By Vyankat B. on 1st Oct 2026 for the SLA note
            html: tableHtml
        };
    }

    function openCsatDrill() {
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        HideCxoTooltips();
        if (typeof closeWidgetFullscreen === 'function') closeWidgetFullscreen();
        OpsKpiDrill.active = false;
        OpsKpiDrill.flag = '';
        OpsKpiDrill.stack = [];
        RevenueDrill.stack = [];
        RevenueDrill.lastRows = null;
        DelayedDrill.stack = [];
        DelayedDrill.lastRows = null;
        BudgetVarianceDrill.stack = [];
        BudgetVarianceDrill.lastRows = null;
        CsatDrill.active = true;
        CsatDrill.lastRows = null;
        CsatDrill.stack = [{
            level: 1,
            label: 'Tickets'
        }];
        renderCsatDrill();
        InitCxoBlackTooltips(document.getElementById('modal'));
    }

    function renderCsatDrill() {
        var ov = document.getElementById('overlay');
        var title = document.getElementById('mTitle');
        var crumbs = document.getElementById('mCrumbs');
        var body = document.getElementById('mBody');
        var top, i, html;
        if (!ov || !body) return;
        top = CsatDrill.stack[CsatDrill.stack.length - 1] || { level: 1, label: 'Tickets' };
        syncDrillExportVisibility(1);
        ov.classList.add('open');
        if (title) title.textContent = 'Customer CSAT drill-through - Ticket > SLA Status';
        renderRevenueDrillFilterBar();
        if (crumbs) {
            html = '';
            for (i = 0; i < CsatDrill.stack.length; i++) {
                if (i) html += '<span>&gt;</span>';
                html += '<button type="button" data-crumb-i="' + i + '">' +
                    escHtml(CsatDrill.stack[i].label) + '</button>';
            }
            crumbs.innerHTML = html;
            crumbs.querySelectorAll('[data-crumb-i]').forEach(function (btn) {
                btn.onclick = function () {
                    var idx = Number(btn.getAttribute('data-crumb-i'));
                    CsatDrill.stack = CsatDrill.stack.slice(0, idx + 1);
                    renderCsatDrill();
                };
            });
        }

        body.innerHTML = '<div class="m-note">Level ' + top.level + ' of 2 - ' +
            escHtml(CsatDrill.levelLabels[top.level - 1] || top.label) +
            ' - Period ' + escHtml(revenueDrillPeriodNote()) +
            (top.level >= 2
                ? '. End of drill-down.'
                : '. Click a row to go deeper.') +
            '</div><div class="m-note" style="padding-top:0">Loading...</div>';

        callDashboardApi('GetAnalyticsDBCSATDrillDown', buildCsatDrillRequest(top), function (json) {
            var payload = unwrapDrillPayload(json);
            var rows = payload.Rows || payload.rows || [];
            var painted;
            if (!Array.isArray(rows)) rows = [];
            painted = renderCsatDrillTable(top.level, rows);
            // Commented and Added By Vyankat B. on 1st Oct 2026 for the SLA note on clickable rows
            // body.innerHTML = '<div class="m-note">Level ' + top.level + ' of 2 - ' + ... + '</div>' + painted.html;
            var csatShowSlaNote = (top.level === 1 && painted.hasClickable);
            body.innerHTML = '<div class="m-note"' +
                (csatShowSlaNote ? ' style="display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap"' : '') + '>' +
                '<span>Level ' + top.level + ' of 2 - ' +
                escHtml(getApiField(payload, 'LevelLabel') || top.label || CsatDrill.levelLabels[top.level - 1] || '') +
                ' - Period ' + escHtml(revenueDrillPeriodNote()) +
                (top.level >= 2
                    ? '. End of drill-down.'
                    : '. Click a row to go deeper.') +
                '</span>' +
                (csatShowSlaNote
                    ? '<span style="background:#eef4ff;color:#1e40af;border:1px solid #c7d7fe;border-radius:999px;padding:3px 10px;font-size:11px;">' +
                    // Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA badge wording
                    // '<b>Note:</b> Rows with the <b>SLA</b> badge are clickable - click to view the SLA Status.</span>'
                    '<b>Note:</b> Rows with SLA present are clickable - click a row to view the SLA Status.</span>'
                    // End of Commented and Added By Vyankat B. on 1st Oct 2026 for removing SLA badge wording
                    : '') +
                '</div>' + painted.html;
            // End of Commented and Added By Vyankat B. on 1st Oct 2026 for the SLA note on clickable rows
            body.querySelectorAll('tr[data-drill-i]').forEach(function (tr) {
                var idx = Number(tr.getAttribute('data-drill-i'));
                var rowMeta = painted.bodyRows[idx];
                var next = rowMeta && rowMeta.next;
                if (!next) return;
                tr.onclick = function () {
                    CsatDrill.stack.push(next);
                    renderCsatDrill();
                };
            });
            InitCxoBlackTooltips(document.getElementById('modal'));
        }, function () {
            body.innerHTML = '<div class="m-note">Unable to load Customer CSAT drill-down. Please try again.</div>';
            showAlertError('Unable to load Customer CSAT drill-down.');
        });
    }
    /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */

    function closeModal() {
        var ov = document.getElementById('overlay');
        var bar = document.getElementById('mFilters');
        /* Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects export on Level 1 only */
        syncDrillExportVisibility(1);
        /* End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects export on Level 1 only */
        if (ov) ov.classList.remove('open');
        if (bar) {
            bar.hidden = true;
            bar.innerHTML = '';
        }
        /* Added by Vikas T on 16-09-2026 - clear ops drill state when modal closes */
        OpsKpiDrill.active = false;
        OpsKpiDrill.flag = '';
        OpsKpiDrill.stack = [];
        /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        DelayedDrill.stack = [];
        DelayedDrill.lastRows = null;
        BudgetVarianceDrill.stack = [];
        BudgetVarianceDrill.lastRows = null;
        /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        CsatDrill.active = false;
        CsatDrill.stack = [];
        CsatDrill.lastRows = null;
        /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
    }
    window.closeModal = closeModal;

    function exportDrill() {
        /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        var rows = (CsatDrill.active && CsatDrill.lastRows && CsatDrill.lastRows.length)
            ? CsatDrill.lastRows
            : ((BudgetVarianceDrill.lastRows && BudgetVarianceDrill.lastRows.length)
                ? BudgetVarianceDrill.lastRows
                : ((DelayedDrill.lastRows && DelayedDrill.lastRows.length)
                    ? DelayedDrill.lastRows
                    : ((OpsKpiDrill.active && OpsKpiDrill.lastRows && OpsKpiDrill.lastRows.length)
                        ? OpsKpiDrill.lastRows
                        : RevenueDrill.lastRows)));
        /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        if (!rows || !rows.length) {
            toast('Nothing to export');
            return;
        }
        var csv = rows.map(function (r) {
            return r.map(function (c) {
                return '"' + String(c == null ? '' : c).replace(/"/g, '""') + '"';
            }).join(',');
        }).join('\n');
        var a = document.createElement('a');
        a.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }));
        a.download = CsatDrill.active
            ? 'whizible-customer-csat-drilldown.csv'
            : ((BudgetVarianceDrill.stack && BudgetVarianceDrill.stack.length)
                ? 'whizible-budget-variance-drilldown.csv'
                : ((DelayedDrill.stack && DelayedDrill.stack.length)
                    ? 'whizible-delayed-projects-drilldown.csv'
                    : (OpsKpiDrill.active
                        ? ('whizible-' + String(OpsKpiDrill.flag || 'kpi').toLowerCase() + '-drilldown.csv')
                        : 'whizible-revenue-drilldown.csv')));
        a.click();
        toast('CSV downloaded');
    }

    /* Purpose: Drill Share menu — design: EXPORT TO → Microsoft Excel. */
    function exportDrillToExcel() {
        var rows = (CsatDrill.active && CsatDrill.lastRows && CsatDrill.lastRows.length)
            ? CsatDrill.lastRows
            : ((BudgetVarianceDrill.lastRows && BudgetVarianceDrill.lastRows.length)
                ? BudgetVarianceDrill.lastRows
                : ((DelayedDrill.lastRows && DelayedDrill.lastRows.length)
                    ? DelayedDrill.lastRows
                    : ((OpsKpiDrill.active && OpsKpiDrill.lastRows && OpsKpiDrill.lastRows.length)
                        ? OpsKpiDrill.lastRows
                        : RevenueDrill.lastRows)));
        var html, i, j, cell, a, name;
        if (!rows || !rows.length) {
            toast('Nothing to export');
            return;
        }
        html = '<table border="1">';
        for (i = 0; i < rows.length; i++) {
            html += '<tr>';
            for (j = 0; j < rows[i].length; j++) {
                cell = String(rows[i][j] == null ? '' : rows[i][j]).replace(/<[^>]*>/g, '');
                html += (i === 0 ? '<th>' : '<td>') + escHtml(cell) + (i === 0 ? '</th>' : '</td>');
            }
            html += '</tr>';
        }
        html += '</table>';
        name = CsatDrill.active
            ? 'whizible-customer-csat-drilldown.xls'
            : ((BudgetVarianceDrill.stack && BudgetVarianceDrill.stack.length)
                ? 'whizible-budget-variance-drilldown.xls'
                : ((DelayedDrill.stack && DelayedDrill.stack.length)
                    ? 'whizible-delayed-projects-drilldown.xls'
                    : (OpsKpiDrill.active
                        ? ('whizible-' + String(OpsKpiDrill.flag || 'kpi').toLowerCase() + '-drilldown.xls')
                        : 'whizible-revenue-drilldown.xls')));
        a = document.createElement('a');
        a.href = URL.createObjectURL(new Blob(
            ['\ufeff<html><head><meta charset="utf-8"></head><body>' + html + '</body></html>'],
            { type: 'application/vnd.ms-excel' }
        ));
        a.download = name;
        a.click();
        toast('Exported to Microsoft Excel');
    }

    /* Purpose: Drill Export / Share — Level 1 only (hidden from Level 2+). */
    var DrillExportLevel = 1;
    function syncDrillExportVisibility(level) {
        var btn = document.getElementById('btnDrillExport');
        DrillExportLevel = level != null ? Number(level) : 1;
        if (!btn) return;
        btn.style.display = (DrillExportLevel === 1) ? '' : 'none';
    }

    function exportDrillMenu(e) {
        var m, r, btn, excelBtn;
        if (DrillExportLevel !== 1) return;
        if (e && e.stopPropagation) e.stopPropagation();
        closeTopFilterPop();
        closeWidgetMenus();
        document.querySelectorAll('.menu.menu-share, .menu.menu-drill-export').forEach(function (x) {
            if (x.parentNode) x.parentNode.removeChild(x);
        });
        m = document.createElement('div');
        m.className = 'menu menu-widget-export menu-drill-export';
        m.innerHTML =
            '<div class="mhd">Export to</div>' +
            '<button type="button" class="menu-excel-btn" data-act="excel">' +
            excelIconHtml() +
            '<span>Microsoft Excel</span>' +
            '</button>';
        document.body.appendChild(m);
        btn = e && (e.currentTarget || (e.target && e.target.closest ? e.target.closest('button') : null));
        r = btn ? btn.getBoundingClientRect() : { bottom: 80, left: 40 };
        m.style.position = 'fixed';
        m.style.top = (r.bottom + 6) + 'px';
        m.style.left = Math.min(r.left, window.innerWidth - 220) + 'px';
        m.style.zIndex = '3600';
        m.addEventListener('click', function (ev) { ev.stopPropagation(); });
        excelBtn = m.querySelector('[data-act="excel"]');
        if (excelBtn) {
            excelBtn.onclick = function (ev) {
                ev.preventDefault();
                if (m.parentNode) m.parentNode.removeChild(m);
                exportDrillToExcel();
            };
        }
        setTimeout(function () {
            var onDoc = function (ev) {
                if (m.contains(ev.target)) return;
                if (m.parentNode) m.parentNode.removeChild(m);
                document.removeEventListener('mousedown', onDoc, true);
            };
            document.addEventListener('mousedown', onDoc, true);
        }, 0);
    }
    window.exportDrillMenu = exportDrillMenu;

    function bindKpiDrillClicks() {
        document.querySelectorAll('.kpi[data-kpi-flag]').forEach(function (el) {
            var flag = el.getAttribute('data-kpi-flag') || '';
            var canDrill = el.getAttribute('data-kpi-drill') === '1' && isKpiDrillableFlag(flag);
            el.onclick = null;
            el.onkeydown = null;
            if (!canDrill) return;
            /* Added by Vikas T on 16-09-2026 - route Util/Bench/Active to ops drill, money to Revenue drill */
            if (isOpsKpiDrillFlag(flag)) {
                el.onclick = function () { openOpsKpiDrill(flag); };
                el.onkeydown = function (e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        openOpsKpiDrill(flag);
                    }
                };
                return;
            }
            /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
            if (String(flag).toLowerCase() === 'delayedprojects') {
                el.onclick = function () { openDelayedProjectsDrill(); };
                el.onkeydown = function (e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        openDelayedProjectsDrill();
                    }
                };
                return;
            }
            /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
            /* Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through */
            if (String(flag).toLowerCase() === 'budgetvariance') {
                el.onclick = function () { openBudgetVarianceDrill(); };
                el.onkeydown = function (e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        openBudgetVarianceDrill();
                    }
                };
                return;
            }
            /* End of Added By Vyankat B. on 21th Sep 2026 for the Budget Variance KPI drill-through */
            /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
            if (String(flag).toLowerCase() === 'csat') {
                el.onclick = function () { openCsatDrill(); };
                el.onkeydown = function (e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        openCsatDrill();
                    }
                };
                return;
            }
            /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
            el.onclick = function () { openRevenueDrill(flag); };
            el.onkeydown = function (e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    openRevenueDrill(flag);
                }
            };
        });
    }

    function openRevenueDrill(sourceFlag, forceOpen, opts) {
        var src = String(sourceFlag || 'Revenue');
        var card;
        opts = opts || {};
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        /* KPI card with 0 value stays non-drillable; chart Drill tool always opens (forceOpen). */
        if (!forceOpen && isMoneyKpiDrillFlag(src)) {
            card = findKpiCardByFlagOrLabel(src);
            if (!hasKpiDrillValue(card)) return;
        }
        HideCxoTooltips();
        /* Exit chart fullscreen so drill modal is visible (exec.html parity) */
        if (typeof closeWidgetFullscreen === 'function') closeWidgetFullscreen();
        OpsKpiDrill.active = false;
        OpsKpiDrill.flag = '';
        OpsKpiDrill.stack = [];
        /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        DelayedDrill.stack = [];
        DelayedDrill.lastRows = null;
        BudgetVarianceDrill.stack = [];
        BudgetVarianceDrill.lastRows = null;
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        CsatDrill.active = false;
        CsatDrill.stack = [];
        CsatDrill.lastRows = null;
        /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        RevenueDrill.sourceFlag = src;
        RevenueDrill.apiAction = opts.apiAction || 'GetAnalyticsDBRevenueDrillDown';
        /* Tool / KPI open → whole period; chart point sets monthFilter beforehand */
        if (!opts.keepMonthFilter) RevenueDrill.monthFilter = null;
        if (opts.stack && opts.stack.length) {
            RevenueDrill.stack = opts.stack;
        } else {
            RevenueDrill.stack = [{
                level: 1,
                label: 'Portfolio',
                portfolioId: null,
                projectId: null,
                invoiceId: null
            }];
        }
        renderRevenueDrill();
        InitCxoBlackTooltips(document.getElementById('modal'));
    }

    function revenueDrillPeriodNote() {
        if (RevenueDrill.monthFilter && RevenueDrill.monthFilter.label) {
            return String(RevenueDrill.monthFilter.label) + ' (chart month)';
        }
        if (RevenueDrill.monthFilter && RevenueDrill.monthFilter.start && RevenueDrill.monthFilter.end) {
            return formatFilterRange(RevenueDrill.monthFilter.start, RevenueDrill.monthFilter.end);
        }
        return DateFilter.selectedFilterName || formatFilterRange(DateFilter.startDate, DateFilter.endDate) || '';
    }

    function revenueDrillPfColor(name) {
        var s = String(name || ''), i, h = 0;
        for (i = 0; i < s.length; i++) h = ((h << 5) - h) + s.charCodeAt(i);
        return RevenueDrill.pfColors[Math.abs(h) % RevenueDrill.pfColors.length];
    }

    /* Purpose: Mini polyline like exec.html spark() — not class=spark (that is position:absolute on KPI cards). */
    function revenueDrillSparkSvg(data, color, w, h) {
        var i, mn, mx, rg, pts, x, y;
        w = w || 60;
        h = h || 20;
        data = data && data.length ? data : [0, 0];
        if (data.length === 1) data = [data[0], data[0]];
        mn = Math.min.apply(null, data);
        mx = Math.max.apply(null, data);
        rg = mx - mn || 1;
        pts = [];
        for (i = 0; i < data.length; i++) {
            x = (i / (data.length - 1)) * w;
            y = h - ((data[i] - mn) / rg) * (h - 4) - 2;
            pts.push(x.toFixed(1) + ',' + y.toFixed(1));
        }
        return '<svg class="drill-spark" width="' + w + '" height="' + h + '" viewBox="0 0 ' + w + ' ' + h + '" aria-hidden="true">' +
            '<polyline points="' + pts.join(' ') + '" fill="none" stroke="' + escHtml(color) +
            '" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    }

    function parseDrillTrendPoints(raw) {
        var i, n, out = [], parts;
        if (raw == null || raw === '') return [];
        if (Array.isArray(raw)) {
            for (i = 0; i < raw.length; i++) {
                n = parseKpiNumeric(raw[i]);
                if (!isNaN(n)) out.push(n);
            }
            return out;
        }
        parts = String(raw).split(/[,|;]/);
        for (i = 0; i < parts.length; i++) {
            n = parseKpiNumeric(parts[i]);
            if (!isNaN(n)) out.push(n);
        }
        return out.length > 1 ? out : [];
    }

    function drillTrendPointsFromChart(row) {
        var months = (RevenueCostTrend && RevenueCostTrend.months) || [];
        var pts = [], i, v, tot = 0, rowRev, share;
        for (i = 0; i < months.length; i++) {
            if (typeof parseTrendFlag === 'function' && parseTrendFlag(getApiField(months[i], 'IsForecast'))) continue;
            v = parseKpiNumeric(getApiField(months[i], 'Revenue', 'TotalRevenue'));
            if (isNaN(v)) v = 0;
            pts.push(v);
            tot += v;
        }
        rowRev = parseKpiNumeric(getApiField(row, 'TotalRevenue', 'Revenue'));
        if (pts.length && tot > 0 && !isNaN(rowRev)) {
            share = rowRev / tot;
            for (i = 0; i < pts.length; i++) pts[i] = pts[i] * share;
        } else if (!pts.length && !isNaN(rowRev)) {
            pts = [rowRev, rowRev];
        }
        return pts;
    }

    function revenueDrillTrendHtml(row, color) {
        var pts = parseDrillTrendPoints(getApiField(row, 'Trend', 'Spark', 'TrendPoints', 'MonthlyRevenue'));
        if (!pts.length) pts = drillTrendPointsFromChart(row);
        return revenueDrillSparkSvg(pts, color);
    }

    function formatDrillCr(value) {
        /* Legacy — SP returns raw amounts + *Formatted. Prefer drillSpMoney. */
        return formatDrillMoneyRaw(value);
    }

    /* Purpose: Prefer SP *Formatted text; else format raw amount (absolute currency).
       Always re-apply comma money format so SP strings like "$10000.00" become "$10,000.00". */
    function drillSpMoney(row, formattedKeys, rawKeys) {
        var i, f, raw;
        formattedKeys = formattedKeys || [];
        rawKeys = rawKeys || [];
        for (i = 0; i < formattedKeys.length; i++) {
            f = getApiField(row, formattedKeys[i]);
            if (f != null && String(f).trim() !== '') {
                return '<span class="num">' + formatDrillMoneyPlain(f, drillCorporateCurrencySymbol(row)) + '</span>';
            }
        }
        raw = getApiField.apply(null, [row].concat(rawKeys));
        return '<span class="num">' + formatDrillMoneyPlain(raw, drillCorporateCurrencySymbol(row)) + '</span>';
    }

    /* Purpose: Same money format as UI for Excel export (e.g. "USD 2,325.00") — plain text, no HTML. */
    function drillSpMoneyExport(row, formattedKeys, rawKeys) {
        var i, f, raw;
        formattedKeys = formattedKeys || [];
        rawKeys = rawKeys || [];
        for (i = 0; i < formattedKeys.length; i++) {
            f = getApiField(row, formattedKeys[i]);
            if (f != null && String(f).trim() !== '') {
                return formatDrillMoneyExport(f, drillCorporateCurrencySymbol(row));
            }
        }
        raw = getApiField.apply(null, [row].concat(rawKeys));
        return formatDrillMoneyExport(raw, drillCorporateCurrencySymbol(row));
    }

    /* Purpose: Corporate / base currency symbol from drill row (same as Revenue/Cost). */
    function drillCorporateCurrencySymbol(row) {
        var sym = String(getApiField(row, 'CorporateCurrencySymbol', 'CurrencySymbol') || '').trim();
        var f, m, card;
        if (sym) return sym;
        f = getApiField(row, 'RevenueFormatted', 'CostFormatted', 'GrossProfitFormatted');
        if (f != null && String(f).trim() !== '') {
            m = String(f).trim().match(/^([^\d\-\.,\s]+)/);
            if (m) return m[1];
        }
        card = findKpiCardByFlagOrLabel('Revenue') || (KpiCards.list && KpiCards.list[0]) || {};
        return getKpiCurrencySymbol(card) || '';
    }

    function drillSpPct(row, formattedKey, rawKey) {
        var f = getApiField(row, formattedKey);
        if (f != null && String(f).trim() !== '') return escHtml(String(f));
        return formatDrillPct(getApiField(row, rawKey));
    }

    function drillNum(row, keys) {
        var i, v, n;
        keys = keys || [];
        for (i = 0; i < keys.length; i++) {
            v = getApiField(row, keys[i]);
            if (v == null || v === '') continue;
            n = Number(String(v).replace(/[^0-9.\-]/g, ''));
            if (!isNaN(n)) return n;
        }
        return 0;
    }

    /* Purpose: Captions / table headers / card labels — Title Case (no UPPERCASE). */
    function toCamelCaption(s) {
        var t = String(s == null ? '' : s).replace(/[_]+/g, ' ').replace(/\s+/g, ' ').trim();
        if (!t) return '';
        /* Keep symbols / amount units like Amount($) / Amount(USD) intact; title-case word parts.
           Added by Dipali V. on 01-10-2026 — keep ID uppercase so "IR ID" stays "IR ID" (not "IR Id").
           Currency codes from API (USD, INR, …) must stay uppercase — not "Usd". */
        return t.replace(/[A-Za-z][A-Za-z']*/g, function (w) {
            if (/^[A-Z]{2,4}$/.test(w)) return w;
            if (/^(IR|ID|PO|SPI|CPI|EBIT|CSAT|FTE|KPI|PM|GL|USD|EUR|INR|GBP|JPY|AUD|CAD|CHF|CNY|SGD|AED|NZD|HKD|SAR|QAR|KWD|BHD|OMR)$/i.test(w)) {
                return w.toUpperCase();
            }
            return w.charAt(0).toUpperCase() + w.slice(1).toLowerCase();
        });
    }

    /* Purpose: Drill-through modal titles — sentence case / lowercase (keep acronyms).
       e.g. "Gross profit drill-through · KPI → general ledger" */
    function toDrillThroughCaption(s) {
        var t = String(s == null ? '' : s).replace(/[_]+/g, ' ').replace(/\s+/g, ' ').trim();
        var firstWord = true;
        if (!t) return '';
        return t.replace(/[A-Za-z][A-Za-z']*/g, function (w) {
            /* Added by Dipali V. on 01-10-2026 — keep ID uppercase with other CXO acronyms. */
            if (/^(IR|ID|PO|SPI|CPI|EBIT|CSAT|FTE|KPI|PM|GL)$/i.test(w)) {
                firstWord = false;
                return w.toUpperCase();
            }
            var out = w.toLowerCase();
            if (firstWord) {
                out = out.charAt(0).toUpperCase() + out.slice(1);
                firstWord = false;
            }
            return out;
        });
    }

    /* Purpose: Numeric / amount / % / Status columns → center; text (e.g. Project) → left. */
    function isDrillNumericHeader(h) {
        var s = String(h || '').toLowerCase().replace(/\s+/g, ' ').trim();
        if (!s) return false;
        if (/\(%\)\s*$/.test(s) || /%\s*$/.test(s)) return true;
        if (/^amount\s*\(/i.test(s)) return true;
        /* Project count only — not the Project name column. */
        if (/^(no\.?\s*of\s+)?projects$/.test(s)) return true;
        if (/^status$/.test(s)) return true;
        if (/^source currency$/.test(s)) return true;
        if (/^(revenue|cost|gross profit|share|margin|gross margin|spi|cpi|fte|utilization|delay|milestones|logged h|billable|non-billable|estimated h|actual h|effort variance|budget burn|qty|rate|hours|score)$/i.test(s)) return true;
        if (/billable h|utilization|complete|burn|variance|exposure/i.test(s)) return true;
        /* Added by Vikas T on 30-09-2026 - Util / Bench L3 % columns. */
        if (/^(6-week average|this week)$/i.test(s)) return true;
        return false;
    }

    function drillAlignClass(h) {
        return isDrillNumericHeader(h) ? 'drill-col-num' : 'drill-col-text';
    }

    function withPctCaption(label) {
        var s = String(label == null ? '' : label).trim();
        var rest;
        if (!s) return s;
        if (/\(%\)\s*$/.test(s) || /%\s*$/.test(s)) return s;
        if (/^%\s*/.test(s)) {
            rest = s.replace(/^%\s*/, '').trim();
            return rest ? (rest + ' (%)') : s;
        }
        return s + ' (%)';
    }

    function drillTableHeadHtml(head) {
        return (head || []).map(function (h) {
            return '<th class="' + drillAlignClass(h) + '">' + escHtml(toCamelCaption(h)) + '</th>';
        }).join('');
    }

    /* Purpose: Truncate long drill text; full value on tooltip (title / data-cxo-tip).
       Project name + ProjectCode → 10 chars + ".." each; tooltip shows full string.
       Other text cols (e.g. Customer) → 15 chars + "...".
       Skips money / numeric / badge / spark cells. */
    function applyDrillTextTruncation(html, header) {
        var wrap, nodes, i, textNode, raw, full, parent, shown, headerNorm, isProjectCol, maxLen, ellipsis;
        if (html == null || html === '') return html;
        if (isDrillNumericHeader(header)) return html;
        if (/class="(?:badge|num|pbar|heat)\b/i.test(String(html))) return html;
        if (/<(?:svg|canvas|button|input|img)\b/i.test(String(html))) return html;
        if (typeof document === 'undefined' || !document.createElement) return html;

        headerNorm = String(header || '').replace(/<[^>]+>/g, '').replace(/\s+/g, ' ').trim();
        isProjectCol = /^project$/i.test(headerNorm);
        maxLen = isProjectCol ? 10 : 15;
        ellipsis = isProjectCol ? '..' : '...';

        wrap = document.createElement('div');
        wrap.innerHTML = String(html);
        nodes = [];
        (function walk(node) {
            var child;
            if (!node) return;
            if (node.nodeType === 3) {
                nodes.push(node);
                return;
            }
            if (node.nodeType !== 1) return;
            if (/^(SCRIPT|STYLE)$/i.test(node.tagName)) return;
            for (child = node.firstChild; child; child = child.nextSibling) walk(child);
        })(wrap);

        for (i = 0; i < nodes.length; i++) {
            textNode = nodes[i];
            raw = textNode.nodeValue;
            if (raw == null) continue;
            full = String(raw).replace(/\s+/g, ' ').trim();
            if (!full || full.length <= maxLen) continue;
            /* Keep pure numerics / % intact — do not skip names that merely end with a digit. */
            if (/^[\d\.,\-]+%?$/.test(full)) continue;
            if (/^\$[\d\.,\-]+%?$/.test(full)) continue;
            parent = textNode.parentNode;
            if (!parent || parent.nodeType !== 1) continue;
            /* Project col: truncate bold name and ProjectCode line (both tip full string). */
            if (isProjectCol && !/^B$/i.test(parent.tagName) && !/^DIV$/i.test(parent.tagName)) continue;
            //Added by Aditya J. on 01-10-2026 Long portfolio names show the first half, with the full name on hover
            shown = /^portfolio$/i.test(headerNorm)
                ? full.slice(0, Math.ceil(full.length / 2))
                : (full.slice(0, maxLen) + ellipsis);
            //End of Added by Aditya J. on 01-10-2026 Long portfolio names show the first half, with the full name on hover
            /* Plain text cells: parent is the temp wrap — move into a titled span so tip survives. */
            if (parent === wrap) {
                parent = document.createElement('span');
                textNode.parentNode.replaceChild(parent, textNode);
                parent.appendChild(textNode);
            }
            textNode.nodeValue = String(raw).indexOf(full) >= 0
                ? String(raw).replace(full, shown)
                : shown;
            if (!parent.getAttribute('title') && !parent.getAttribute('data-cxo-tip')) {
                parent.setAttribute('title', full);
                parent.setAttribute('data-cxo-tip', full);
            }
        }
        return wrap.innerHTML;
    }

    function renderDrillTableHtml(head, bodyRows, opts) {
        var colgroup, tableClass;
        opts = opts || {};
        colgroup = '';
        tableClass = 'tbl';
        /* Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects column spacing */
        if (opts.colWidths && opts.colWidths.length) {
            tableClass += ' tbl-cols';
            colgroup = '<colgroup>' + opts.colWidths.map(function (w) {
                return '<col style="width:' + w + '">';
            }).join('') + '</colgroup>';
        }
        /* End of Commented and Added By Vyankat b. on 1st Oct 2026 for the Delayed Projects column spacing */
        return '<div class="scroll-x grid-scroll' + (colgroup ? ' tbl-fill' : '') + '"><table class="' + tableClass + '">' + colgroup + '<thead><tr>' +
            drillTableHeadHtml(head) +
            '</tr></thead><tbody>' +
            (bodyRows || []).map(function (row, idx) {
                var trClass = '';
                var style = '';
                var open;
                if (row.next && row.linkOnly) trClass = ' class="drill-row-linkonly"';
                else if (row.next) trClass = ' class="drill-row"';
                if (opts.opsStyle) {
                    if (row.next) style = 'cursor:pointer';
                    if (row.highlight) style += (style ? ';' : '') + 'background:#eef6ff';
                    open = '<tr' + (row.next ? ' data-drill-i="' + idx + '"' : '') +
                        (style ? ' style="' + style + '"' : '') + '>';
                } else {
                    /* Only rows with next get data-drill-i / drill-row (IsDataPresentNextLevel=0 → no click). */
                    open = '<tr' + (row.next ? ' data-drill-i="' + idx + '"' : '') + trClass +
                        ' data-next-ok="' + (row.next ? '1' : '0') + '"' +
                        (row.next ? '' : ' style="cursor:default"') + '>';
                }
                return open +
                    (row.cells || []).map(function (c, ci) {
                        return '<td class="' + drillAlignClass(head[ci]) + '">' +
                            applyDrillTextTruncation(c, head[ci]) + '</td>';
                    }).join('') +
                    '</tr>';
            }).join('') +
            '</tbody></table></div>' + (opts.footHtml || '');
    }

    function drillAgeingText(row) {
        var age = getApiField(row, 'Ageing', 'Aging', 'Age');
        var status;
        if (age != null && String(age).trim() !== '') return String(age);
        status = String(getApiField(row, 'Status') || '');
        if (/overdue/i.test(status)) return 'past due';
        if (/paid/i.test(status)) return 'settled';
        return 'within terms';
    }

    /* Updated by Vikas T on 30-09-2026 - also accept "85.0%" / "1,234.5" strings from Util / Bench SP. */
    function formatDrillPct(value) {
        var n;
        if (value == null || value === '') return '\u2014';
        n = typeof value === 'number' ? value : Number(String(value).replace(/%/g, '').replace(/,/g, '').trim());
        if (isNaN(n)) return '\u2014';
        return n.toFixed(1) + '%';
    }

    /* Added by Vikas T on 30-09-2026 - HH:MM like Plan vs Actual for screen and Excel export. */
    function formatDrillHours(value) {
        var s, m, hrs, mins, n, totalMins, sign, abs;
        if (value == null || value === '' || value === '-' || value === '\u2014') return '0:00';
        if (typeof value === 'number' && isFinite(value)) {
            totalMins = Math.round(value * 60);
        } else {
            s = String(value).trim();
            m = s.match(/^(-)?([\d,]+):(\d{1,2})$/);
            if (m) {
                hrs = parseInt(String(m[2]).replace(/,/g, ''), 10);
                mins = parseInt(m[3], 10);
                if (isNaN(hrs) || isNaN(mins)) return '0:00';
                return (m[1] || '') + Number(hrs).toLocaleString('en-US') + ':' + (mins < 10 ? '0' : '') + mins;
            }
            n = Number(s.replace(/,/g, ''));
            if (isNaN(n)) return '0:00';
            totalMins = Math.round(n * 60);
        }
        sign = totalMins < 0 ? '-' : '';
        abs = Math.abs(totalMins);
        hrs = Math.floor(abs / 60);
        mins = abs % 60;
        return sign + Number(hrs).toLocaleString('en-US') + ':' + (mins < 10 ? '0' : '') + mins;
    }

    /* Added by Vikas T after changes 22-09-2026 - FTE display: whole number or 1 decimal (SP 0.5 / 1.0 rule) */
    function formatDrillFte(value) {
        var n = Number(value);
        if (value == null || value === '' || isNaN(n)) return '0';
        if (Math.abs(n - Math.round(n)) < 0.05) return String(Math.round(n));
        return n.toFixed(1);
    }

    /* Added by Vikas T on 30-09-2026 - Util % is plain text (no colour dot) for Util / Bench / Active. */
    function utilPctHtml(value) {
        var n;
        if (value == null || value === '') return '\u2014';
        n = typeof value === 'number' ? value : Number(String(value).replace(/%/g, '').replace(/,/g, '').trim());
        if (isNaN(n)) return '\u2014';
        return n.toFixed(1) + '%';
    }

    /* Added by Vikas T after changes 22-09-2026 - Bench exposure label: No exposure grey, watch red, else amber */
    function utilBenchHtml(label) {
        var v = String(label || '').trim();
        var low = v.toLowerCase();
        if (!v || v === '-' || v === '\u2014') return '\u2014';
        if (/no exposure/i.test(v)) {
            return '<span style="color:#64748b">' + escHtml(v) + '</span>';
        }
        if (/watch/i.test(low)) {
            return '<span class="badge b-risk">' + escHtml(v) + '</span>';
        }
        return '<span class="badge b-warn">' + escHtml(v) + '</span>';
    }

    function healthBadgeHtml(h) {
        var v = String(h || '').trim();
        var cls = 'info';
        if (/green/i.test(v)) cls = 'good';
        else if (/amber|yellow|orange/i.test(v)) cls = 'warn';
        else if (/red|critical/i.test(v)) cls = 'risk';
        if (!v || v === '\u2014' || v === '-' || v === '\u2014') return '-';
        /* Added by Vikas T on 30-09-2026 - Health badge without colour dot. */
        return '<span class="badge b-' + cls + '">' + escHtml(v) + '</span>';
    }

    function statusBadgeHtml(s) {
        var v = String(s || '').trim();
        var cls = 'info';
        /* Added by Vikas T on 17-09-2026 - Active/Util status badges aligned to design */
        if (/paid|approved|done|healthy|on track/i.test(v)) cls = 'good';
        else if (/overdue|reject|bench|at risk|slipped/i.test(v)) cls = 'risk';
        else if (/sent|pending|review|partial|soft|in progress|at risk/i.test(v)) cls = 'warn';
        /* Added by Vikas T on 30-09-2026 - Util L4 "Not Submitted" timesheet = amber. */
        else if (/not submitted/i.test(v)) cls = 'warn';
        else if (/submitted|not started/i.test(v)) cls = 'info';
        if (/at risk/i.test(v)) cls = 'warn';
        if (!v || v === '\u2014' || v === '\u2014') v = '-';
        if (v === '-') return '-';
        return '<span class="badge b-' + cls + '">' + escHtml(v) + '</span>';
    }

    /* Added by Vikas T on 17-09-2026 - Util L3 Allocation: % = teal, Bench = red badge */
    function allocationBadgeHtml(a) {
        var v = String(a == null ? '' : a).trim();
        if (!v || v === '\u2014') return '\u2014';
        if (/^bench$/i.test(v)) {
            return '<span class="badge b-risk">' + escHtml('Bench') + '</span>';
        }
        if (/%\s*$/.test(v) || /^\d+(\.\d+)?%?$/.test(v)) {
            var shown = /%/.test(v) ? v : (v + '%');
            return '<span class="badge b-good">' + escHtml(shown) + '</span>';
        }
        return '<span class="badge b-good">' + escHtml(v) + '</span>';
    }

    /* Purpose: Pick L4 mapped source for @InvoiceItemIDs (one mapping per IR item). */
    function pickInvoiceItemSource(ids) {
        var n;
        ids = ids || {};
        n = Number(ids.projectTimesheetId);
        if (!isNaN(n) && n > 0) return { id: String(n), type: 'Timesheet', label: 'Timesheets' };
        n = Number(ids.milestoneId);
        if (!isNaN(n) && n > 0) return { id: String(n), type: 'Milestone', label: 'Milestone' };
        n = Number(ids.deliverableId);
        if (!isNaN(n) && n > 0) return { id: String(n), type: 'Deliverable', label: 'Deliverable' };
        n = Number(ids.expensesEntryId);
        if (!isNaN(n) && n > 0) return { id: String(n), type: 'Expense', label: 'Expenses' };
        n = Number(ids.employeeId);
        if (!isNaN(n) && n > 0) return { id: String(n), type: 'Employee', label: 'Employee' };
        return null;
    }

    function pickInvoiceItemId(ids) {
        var src = pickInvoiceItemSource(ids);
        return src ? src.id : null;
    }

    function mixLineSourceIds(row) {
        return {
            projectTimesheetId: getApiField(row, 'ProjectTimesheetID'),
            expensesEntryId: getApiField(row, 'ExpensesEntryID'),
            deliverableId: getApiField(row, 'DeliverableID'),
            milestoneId: getApiField(row, 'MilestoneID'),
            employeeId: getApiField(row, 'EmployeeID')
        };
    }

    function mixLineSourceText(row) {
        var src = pickInvoiceItemSource(mixLineSourceIds(row));
        if (!src) return '\u2014';
        if (src.type === 'Timesheet') return 'Timesheets (approved)';
        if (src.type === 'Expense') return 'Expense ledger';
        return src.label;
    }

    function ensureRevenueDrillFilterBar() {
        var el = document.getElementById('mFilters');
        var hd;
        if (el) return el;
        hd = document.querySelector('#overlay .m-hd');
        if (!hd || !hd.parentNode) return null;
        el = document.createElement('div');
        el.id = 'mFilters';
        el.className = 'm-filtered-by';
        el.setAttribute('aria-label', 'Filtered by');
        el.hidden = true;
        if (hd.nextSibling) hd.parentNode.insertBefore(el, hd.nextSibling);
        else hd.parentNode.appendChild(el);
        return el;
    }

    function revenueDrillChipKind(levelLabel) {
        var map = {
            Portfolios: 'Portfolio',
            Portfolio: 'Portfolio',
            Groups: 'Portfolio',
            Group: 'Portfolio',
            Projects: 'Project',
            Project: 'Project',
            Invoices: 'Invoice',
            Invoice: 'Invoice',
            'Invoice lines': 'Line',
            'Timesheet entries': 'Timesheet',
            Timesheets: 'Timesheet',
            Resources: 'Resource',
            Roles: 'Role',
            People: 'Resource',
            Milestones: 'Milestone',
            Milestone: 'Milestone',
            Tasks: 'Task',
            'Tasks & work items': 'Task',
            'Work items': 'Work item',
            'Delayed projects': 'Project',
            'Activity log': 'Activity',
            Activity: 'Activity',
            'Audit trail': 'Audit'
        };
        if (map[levelLabel]) return map[levelLabel];
        return String(levelLabel || 'Filter').replace(/s$/i, '');
    }

    function drillGlobalFilterChips() {
        var chips = [];
        var i, chip, arr, j, name;
        for (i = 0; i < TOP_FILTER_CHIPS.length; i++) {
            chip = TOP_FILTER_CHIPS[i];
            arr = (TopFilter.selected && TopFilter.selected[chip.label]) || [];
            for (j = 0; j < arr.length; j++) {
                name = arr[j] && arr[j].name;
                if (name) chips.push({ kind: chip.label, value: name });
            }
        }
        return chips;
    }

    function drillStackFilterChips(stack, labels) {
        var chips = [];
        var seen = {};
        var i, prevLabel, value, key, kind, node;
        stack = stack || [];
        labels = labels || [];
        function pushDrillChip(chipKind, val) {
            if (!val) return;
            //Added by Aditya J. on 28-09-2026 Keep one Filtered by chip when the clicked portfolio is already in the path
            key = String(chipKind || '').replace(/\s+/g, ' ').trim().toLowerCase()
                + '|'
                + String(val).replace(/\s+/g, ' ').trim().toLowerCase();
            if (seen[key]) return;
            seen[key] = 1;
            chips.push({ kind: chipKind, value: String(val).replace(/\s+/g, ' ').trim() });
            //End of Added by Aditya J. on 28-09-2026 Keep one Filtered by chip when the clicked portfolio is already in the path
        }
        for (i = 1; i < stack.length; i++) {
            node = stack[i];
            value = node && node.label;
            if (!value) continue;
            prevLabel = labels[(stack[i - 1].level || i) - 1] || stack[i - 1].label;
            kind = revenueDrillChipKind(prevLabel);
            /* Added by Dipali V. on 05-10-2026 — IsIRConsiderForRevenue drives L3→L4 chip label */
            if (node.isIrConsiderForRevenue === 0 || node.isIrConsiderForRevenue === '0') {
                kind = 'Timesheet No';
            } else if (node.isIrConsiderForRevenue === 1 || node.isIrConsiderForRevenue === '1') {
                kind = 'Invoice/IR';
            }
            pushDrillChip(kind, value);
        }
        return chips;
    }

    function activeDrillStackMeta() {
        var labels;
        if (OpsKpiDrill.active) {
            labels = OpsKpiDrill.levelLabels[OpsKpiDrill.flag] || [];
            return { stack: OpsKpiDrill.stack || [], labels: labels };
        }
        if (DelayedDrill.stack && DelayedDrill.stack.length) {
            return { stack: DelayedDrill.stack, labels: DelayedDrill.levelLabels || [] };
        }
        if (BudgetVarianceDrill.stack && BudgetVarianceDrill.stack.length) {
            return { stack: BudgetVarianceDrill.stack, labels: BudgetVarianceDrill.levelLabels || [] };
        }
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        if (CsatDrill.active && CsatDrill.stack && CsatDrill.stack.length) {
            return { stack: CsatDrill.stack, labels: CsatDrill.levelLabels || [] };
        }
        /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        return {
            stack: RevenueDrill.stack || [],
            labels: (typeof revenueDrillLevelLabels === 'function' ? revenueDrillLevelLabels() : RevenueDrill.levelLabels) || []
        };
    }

    function renderRevenueDrillFilterBar() {
        var bar = ensureRevenueDrillFilterBar();
        var chips = [];
        var meta;
        var seen = {};
        var unique = [];
        var i, c, key;
        if (!bar) return;
        meta = activeDrillStackMeta();
        /* Commented and Added By Vyankat b. on 28th Sep 2026 for CSAT drill Customer filter only */
        if (CsatDrill.active) {
            chips = drillGlobalFilterChips().filter(function (chip) {
                return chip.kind === 'Customer';
            }).concat(drillStackFilterChips(meta.stack, meta.labels));
        } else {
            /* Navigation path only — not global top-filter chips (those are not drill path). */
            chips = drillStackFilterChips(meta.stack, meta.labels);
        }
        /* End of Commented and Added By Vyankat b. on 28th Sep 2026 for CSAT drill Customer filter only */
        for (i = 0; i < chips.length; i++) {
            c = chips[i];
            if (!c || !c.value) continue;
            //Added by Aditya J. on 28-09-2026 Show each Filtered by chip once when the clicked portfolio is already selected
            key = String(c.kind || '').replace(/\s+/g, ' ').trim().toLowerCase()
                + '|'
                + String(c.value).replace(/\s+/g, ' ').trim().toLowerCase();
            if (seen[key]) continue;
            seen[key] = 1;
            unique.push({ kind: toCamelCaption(c.kind || 'Filter'), value: String(c.value).replace(/\s+/g, ' ').trim() });
            //End of Added by Aditya J. on 28-09-2026 Show each Filtered by chip once when the clicked portfolio is already selected
        }
        if (!unique.length) {
            bar.hidden = true;
            bar.innerHTML = '';
            return;
        }
        bar.hidden = false;
        bar.innerHTML = '<span class="m-filtered-label">Filtered By:</span>' +
            unique.map(function (chip) {
                return '<span class="m-filter-chip"><span class="m-filter-kind">' + escHtml(chip.kind) +
                    '</span> <span class="m-filter-val">' + escHtml(chip.value) + '</span></span>';
            }).join('');
    }

    /* Purpose: Detect L5 result shape (Timesheet / Milestone / Deliverable). */
    function detectRevenueDrillL5Type(top, rows) {
        var src, row0;
        if (top && top.invoiceItemType) return top.invoiceItemType;
        if (top && Number(top.projectTimesheetId) > 0) return 'Timesheet';
        if (top && Number(top.milestoneId) > 0) return 'Milestone';
        if (top && Number(top.deliverableId) > 0) return 'Deliverable';
        row0 = rows && rows.length ? rows[0] : null;
        if (!row0) return 'Timesheet';
        src = String(getApiField(row0, 'SourceType') || '').trim();
        if (src) return src;
        if (getApiField(row0, 'MileStone', 'Milestone') != null) return 'Milestone';
        if (getApiField(row0, 'Title') != null && getApiField(row0, 'ScheduleID') != null) return 'Deliverable';
        return 'Timesheet';
    }

    /* Purpose: Chart / Mix drill dates (chart month, else toolbar period). */
    function revenueDrillWindowDates() {
        var fromDt = DateFilter.startDate;
        var toDt = DateFilter.endDate;
        if (RevenueDrill.monthFilter && RevenueDrill.monthFilter.start && RevenueDrill.monthFilter.end) {
            fromDt = RevenueDrill.monthFilter.start;
            toDt = RevenueDrill.monthFilter.end;
        }
        return { from: parseFilterDate(fromDt), to: parseFilterDate(toDt) };
    }

    /* Purpose: SP L3 has no InvoiceDate filter — keep Mix invoices inside the drill window. */
    function invoiceDateInDrillWindow(row) {
        var win = revenueDrillWindowDates();
        var d = parseFilterDate(getApiField(row, 'RawInvoiceDate', 'Invoice Date', 'InvoiceDate'));
        if (!d) return true;
        if (win.from && d < win.from) return false;
        if (win.to && d > win.to) return false;
        return true;
    }

    function mixInvoiceStatusHtml(row) {
        var v = String(getApiField(row, 'Status') || '').trim();
        if (!v || /^na$/i.test(v) || v === '-' || v === '\u2014') return '\u2014';
        return statusBadgeHtml(v);
    }

    function revenueDrillApiAction(node) {
        var level = Number(node && node.level) || 1;
        if (!isMixRevCostDrill()) {
            return RevenueDrill.apiAction || 'GetAnalyticsDBRevenueDrillDown';
        }
        //Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill-down stays on the mix procedure at every level
        if (level >= 1) return 'GetAnalyticsDBPortfolioRevenueMixDrillDown';
        if (node && (node.portfolioId === 0 || node.portfolioId === '0')) {
            return 'GetAnalyticsDBPortfolioRevenueMixDrillDown';
        }
        return 'GetAnalyticsDBPortfolioRevenueMixDrillDown';
        //End of Added by Aditya J. on 29-09-2026 Portfolio revenue mix drill-down stays on the mix procedure at every level
    }

    /* Purpose: Same dates + chip filters as KPI cards / Revenue vs Cost chart (API docs). */
    function buildRevenueDrillRequest(node) {
        var itemIds = node.invoiceItemIds || pickInvoiceItemId(node);
        var emptyToNull = function (s) {
            s = s == null ? '' : String(s).trim();
            return s ? s : null;
        };
        var fromDt = DateFilter.startDate;
        var toDt = DateFilter.endDate;
        var pfId = null;
        /* Chart point click → scope L1 Groups to that month (SRS §4.1.2) */
        if (RevenueDrill.monthFilter && RevenueDrill.monthFilter.start && RevenueDrill.monthFilter.end) {
            fromDt = RevenueDrill.monthFilter.start;
            toDt = RevenueDrill.monthFilter.end;
        }
        if (node.portfolioId === 0 || node.portfolioId === '0') pfId = 0;
        else if (node.portfolioId != null && node.portfolioId !== '') {
            pfId = Number(node.portfolioId);
            if (isNaN(pfId)) pfId = null;
        }
        return {
            DashboardID: DASHBOARD_ID,
            Level: Number(node.level) || 1,
            CurrentFromDate: formatApiDate(fromDt),
            CurrentToDate: formatApiDate(toDt),
            PortfolioID: pfId,
            ProjectID: node.projectId || null,
            InvoiceID: node.invoiceId || null,
            InvoiceItemIDs: itemIds || null,
            PortfolioIDs: emptyToNull(joinSelectedIds('Portfolio')),
            CustomerIDs: emptyToNull(joinSelectedIds('Customer')),
            ProjectManagerIDs: emptyToNull(joinSelectedIds('Project Manager')),
            RegionIDs: emptyToNull(joinSelectedIds('Region')),
            BillingTypeIDs: emptyToNull(joinSelectedIds('Billing Type')),
            HealthIDs: emptyToNull(joinSelectedIds('Health'))
        };
    }

    function unwrapDrillPayload(json) {
        var node = json, depth = 0, rows, level, label;
        while (node && typeof node === 'object' && !Array.isArray(node) && depth < 6) {
            rows = node.Rows || node.rows;
            if (Array.isArray(rows)) {
                level = node.Level != null ? node.Level : node.level;
                label = node.LevelLabel || node.levelLabel || 'Portfolios';
                return { Level: level != null ? level : 1, LevelLabel: label, Rows: rows };
            }
            if (node.data != null && typeof node.data === 'object') { node = node.data; depth++; continue; }
            if (node.Data != null && typeof node.Data === 'object') { node = node.Data; depth++; continue; }
            break;
        }
        rows = getApiRows(json);
        return { Level: 1, LevelLabel: 'Portfolios', Rows: rows };
    }

    /*
    Bind table cells to SP columns per Level:
    L1: PortfolioID, Portfolio, Projects, TotalRevenue, TotalCost, RevenueFormatted, CostFormatted, GrossMarginPct, GrossMarginFormatted
    L2: ProjectID, Project, ProjectCode, Customer, PM, Billing, Revenue, RevenueFormatted, Margin, MarginFormatted, Health
    L3: Invoice / IR columns when IsIRConsiderForRevenue=1 (current);
        TimeSheetNo, Amount(proj), Amount(base), TimesheetStatus when IsIRConsiderForRevenue=0
            → UI header: Timesheet No; Filtered By chip: Timesheet No
        when IsIRConsiderForRevenue=1 → Filtered By chip: Invoice/IR
    L4: Line items when IsIRConsiderForRevenue=1 (current);
        Employee Name, Role, Billing Rate, Amount(proj), Amount(base) when IsIRConsiderForRevenue=0
    L5: by IR mapping — Timesheet (TimeshetDate…) OR Milestone (MileStone…) OR Deliverable (Title…)
    Drill: no Cr/M — Project vs Corporate amounts; symbols in headers.
    */
    /* Purpose: Read flag raw (keep "0"/0 — never treat as empty/missing). */
    function readRevenueDrillRowFlag(row, flagName) {
        var want, k, val;
        if (!row || typeof row !== 'object') return undefined;
        want = String(flagName || '').toLowerCase().replace(/[^a-z0-9]/g, '');
        if (!want) return undefined;
        try {
            if (Object.prototype.hasOwnProperty.call(row, flagName) && row[flagName] !== undefined) {
                return row[flagName];
            }
            for (k in row) {
                if (!Object.prototype.hasOwnProperty.call(row, k)) continue;
                if (String(k).toLowerCase().replace(/[^a-z0-9]/g, '') === want) {
                    val = row[k];
                    if (val !== undefined) return val;
                }
            }
        } catch (e) { /* ignore */ }
        return undefined;
    }

    /* Purpose: IsDataPresentNextLevel — ONLY explicit 1 allows next click. "0"/0/false always block.
       Missing flag → allow (legacy / mix payloads without the column). */
    function isRevenueDrillNextLevelPresent(row) {
        var v = readRevenueDrillRowFlag(row, 'IsDataPresentNextLevel');
        var n, s;
        if (v === undefined || v === null || v === '') return true;
        /* Never use truthiness — string "0" is truthy in JS and would wrongly allow. */
        if (v === 0 || v === false || v === '0') return false;
        s = String(v).trim().toLowerCase();
        if (s === '' || s === '0' || s === 'false' || s === 'no' || s === 'n') return false;
        n = Number(s);
        if (!isNaN(n)) return n === 1;
        return s === '1' || s === 'true' || s === 'yes' || s === 'y';
    }

    /* Purpose: GetAnalyticsDBRevenueDrillDown.IsIR — 1 = IR ID + amounts + IR Status + date (no PO Ref). */
    function isRevenueDrillIsIr(row) {
        var v = getApiField(row, 'IsIR');
        if (v == null || v === '') return false;
        var n = Number(v);
        if (!isNaN(n)) return n === 1;
        var s = String(v).trim().toLowerCase();
        return s === 'true' || s === 'yes' || s === 'y';
    }

    /* Purpose: IsIRConsiderForRevenue — 0 = timesheet L3/L4 columns; 1/missing = current invoice/IR columns.
       Added by Dipali V. on 05-10-2026 — SP returns flag; UI only switches headers/cells. */
    function isRevenueDrillTimesheetLayout(row) {
        var v = readRevenueDrillRowFlag(row, 'IsIRConsiderForRevenue');
        var n, s;
        if (v === undefined || v === null || v === '') return false;
        if (v === 0 || v === false || v === '0') return true;
        s = String(v).trim().toLowerCase();
        if (s === '' || s === '0' || s === 'false' || s === 'no' || s === 'n') return true;
        n = Number(s);
        if (!isNaN(n)) return n === 0;
        return false;
    }

    function renderRevenueDrillTable(level, rows) {
        var head, bodyRows, color, inv, invId, name, top, desc;
        rows = rows || [];
        top = RevenueDrill.stack[RevenueDrill.stack.length - 1] || {};

        if (level === 1) {
            var totRev = 0;
            rows.forEach(function (row) {
                totRev += drillNum(row, ['TotalRevenue', 'Revenue', 'RevenueCr']);
            });
            if (!totRev) totRev = 1;
            head = ['Portfolio', 'No. of Projects', 'Revenue', 'Cost', 'Gross Profit', withPctCaption('Gross Margin'), withPctCaption('Share')];
            bodyRows = rows.map(function (row) {
                name = getApiField(row, 'Portfolio', 'PortfolioName') || '-';
                var pfRaw = getApiField(row, 'PortfolioID');
                var pfId = pfRaw == null || pfRaw === '' ? NaN : Number(pfRaw);
                var revN = drillNum(row, ['TotalRevenue', 'Revenue', 'RevenueCr']);
                var costN = drillNum(row, ['TotalCost', 'Cost', 'CostCr']);
                var gpN = drillNum(row, ['GrossProfit', 'Gross profit']) || (revN - costN);
                var shareN = revN / totRev * 100;
                //Added by Aditya J. on 01-10-2026 Level 1 drill share uses the same percent as the doughnut hover
                if (isMixRevCostDrill()) {
                    var chartShare = portfolioMixHoverSharePct(pfId, name);
                    if (chartShare != null) shareN = chartShare;
                }
                //End of Added by Aditya J. on 01-10-2026 Level 1 drill share uses the same percent as the doughnut hover
                var nextOk = isRevenueDrillNextLevelPresent(row) === true;
                var nextNode = null;
                if (!isNaN(pfId) && nextOk) {
                    nextNode = { level: 2, label: name, portfolioId: pfId, projectId: null, invoiceId: null };
                }
                return {
                    next: nextNode,
                    nextOk: nextOk,
                    cells: [
                        '<b>' + escHtml(name) + '</b>',
                        escHtml(getApiField(row, 'Projects') != null ? getApiField(row, 'Projects') : '0'),
                        drillSpMoney(row, ['RevenueFormatted'], ['TotalRevenue', 'Revenue', 'RevenueCr']),
                        drillSpMoney(row, ['CostFormatted'], ['TotalCost', 'Cost', 'CostCr']),
                        getApiField(row, 'GrossProfitFormatted')
                            ? '<span class="num">' + formatDrillMoneyPlain(getApiField(row, 'GrossProfitFormatted'), drillCorporateCurrencySymbol(row)) + '</span>'
                            : '<span class="num">' + formatDrillMoneyPlain(gpN, drillCorporateCurrencySymbol(row)) + '</span>',
                        drillSpPct(row, 'GrossMarginFormatted', 'GrossMarginPct'),
                        '<span class="num">' + formatDrillPct(shareN) + '</span>'
                    ],
                    exportCells: [
                        name,
                        getApiField(row, 'Projects'),
                        drillSpMoneyExport(row, ['RevenueFormatted'], ['TotalRevenue', 'Revenue', 'RevenueCr']),
                        drillSpMoneyExport(row, ['CostFormatted'], ['TotalCost', 'Cost', 'CostCr']),
                        formatDrillMoneyExport(
                            getApiField(row, 'GrossProfitFormatted') || gpN,
                            drillCorporateCurrencySymbol(row)
                        ),
                        getApiField(row, 'GrossMarginFormatted', 'GrossMarginPct'),
                        formatDrillPct(shareN)
                    ]
                };
            });
        } else if (Number(level) === 2) {
            head = ['Project', 'Customer', 'PM', 'Billing', 'Project Currency', 'Revenue', 'Cost', withPctCaption('Gross Margin'), 'Health'];
            bodyRows = rows.map(function (row) {
                var pid, nextOk, nextNode;
                name = drillTextOrDash(getApiField(row, 'Project', 'ProjectName'));
                var cur = drillTextOrDash(getApiField(row, 'SourceCurrency', 'CurrencyCode', 'Currency', 'CurrencySymbol'));
                var pm = drillCell(row, 'PM', 'PMFull', 'ProjectManager');
                pid = Number(getApiField(row, 'ProjectID'));
                nextOk = isRevenueDrillNextLevelPresent(row) === true;
                nextNode = null;
                /* IsDataPresentNextLevel=0 → do not open Level 3 */
                if (!isNaN(pid) && pid > 0 && nextOk) {
                    nextNode = {
                        level: 3,
                        label: name,
                        portfolioId: top.portfolioId,
                        projectId: pid,
                        invoiceId: null
                    };
                }
                return {
                    next: nextNode,
                    nextOk: nextOk,
                    cells: [
                        '<b>' + escHtml(name) + '</b>' +
                        (getApiField(row, 'ProjectCode') ? '<div style="font-size:10px;color:var(--faint)">' + escHtml(getApiField(row, 'ProjectCode')) + '</div>' : ''),
                        escHtml(drillCell(row, 'Customer')),
                        escHtml(pm),
                        escHtml(drillCell(row, 'Billing')),
                        escHtml(cur),
                        drillSpMoney(row, ['RevenueFormatted'], ['Revenue', 'TotalRevenue', 'RevenueCr']),
                        drillSpMoney(row, ['CostFormatted'], ['Cost', 'TotalCost', 'CostCr']),
                        drillSpPct(row, 'MarginFormatted', 'Margin'),
                        healthBadgeHtml(getApiField(row, 'Health'))
                    ],
                    exportCells: [
                        name,
                        drillCell(row, 'Customer'),
                        pm,
                        drillCell(row, 'Billing'),
                        cur,
                        drillSpMoneyExport(row, ['RevenueFormatted'], ['Revenue', 'TotalRevenue', 'RevenueCr']),
                        drillSpMoneyExport(row, ['CostFormatted'], ['Cost', 'TotalCost', 'CostCr']),
                        getApiField(row, 'MarginFormatted', 'Margin'),
                        getApiField(row, 'Health')
                    ]
                };
            });
        } else if (Number(level) === 3) {
            /* Mix graph: Invoice / Amount / Status / Date / PO ref (exec.html sequence).
               KPI revenue drill keeps project + corporate amount columns.
               IsIRConsiderForRevenue=0 → TimeSheetNo + Amount(proj/base) + TimesheetStatus.
               IsIR=1 → IR ID + amounts + IR Status + Generated Date (no PO Reference).
               IsIR=0 → current IR columns. */
            var l3ProjSym = '', l3CorpSym = '';
            var mixL3 = isMixRevCostDrill();
            var l3IsIr = false;
            var l3TsLayout = false;
            if (mixL3) {
                rows = (rows || []).filter(invoiceDateInDrillWindow);
            }
            if (rows.length) {
                l3ProjSym = String(getApiField(rows[0], 'ProjectCurrencySymbol') || '').trim();
                l3CorpSym = String(
                    getApiField(rows[0], 'CorporateCurrencySymbol', 'CurrencySymbol') || ''
                ).trim();
                l3TsLayout = isRevenueDrillTimesheetLayout(rows[0]);
                l3IsIr = !l3TsLayout && isRevenueDrillIsIr(rows[0]);
            }
            if (!l3CorpSym) {
                l3CorpSym = getKpiCurrencySymbol(findKpiCardByFlagOrLabel('Revenue') || {}) || '';
            }
            if (l3TsLayout) {
                /* Added by Dipali V. on 05-10-2026 — IsIRConsiderForRevenue=0 timesheet columns */
                head = [
                    'Timesheet No',
                    'Amount(' + (l3ProjSym || '-') + ')',
                    'Amount(' + (l3CorpSym || '-') + ')',
                    'Timesheet Status'
                ];
            } else if (l3IsIr) {
                head = mixL3
                    ? ['IR ID', 'Amount', 'IR Status', 'Generated Date']
                    : [
                        'IR ID',
                        'Amount(' + (l3ProjSym || '-') + ')',
                        'Amount(' + (l3CorpSym || '-') + ')',
                        'IR Status',
                        'Generated Date'
                    ];
            } else {
                head = mixL3
                    ? ['IR', 'Amount', 'Invoice Status', 'Generated Date', 'PO Reference']
                    : [
                        'IR',
                        'Amount(' + (l3ProjSym || '-') + ')',
                        'Amount(' + (l3CorpSym || '-') + ')',
                        'Invoice Status',
                        'Generated Date',
                        'PO Reference'
                    ];
            }
            bodyRows = rows.map(function (row) {
                var projAmt, corpAmt, amtHtml, dateTxt, rowIsIr, tsNo, tsStatus;
                inv = String(getApiField(row, 'Invoice Number', 'InvoiceNumber', 'Invoice') || '');
                invId = String(getApiField(row, 'InvoiceID') || '');
                tsNo = String(
                    getApiField(row, 'TimeSheetNo', 'TimesheetNo') || invId || ''
                );
                tsStatus = getApiField(row, 'TimesheetStatus', 'Status');
                projAmt = getApiField(row, 'ProjectAmount', 'Amount');
                corpAmt = getApiField(row, 'CorporateAmount', 'BaseCurrencyAmount', 'RawInvoiceAmount');
                dateTxt =
                    getApiField(row, 'Invoice Date', 'InvoiceDate') ||
                    formatDrillDate(getApiField(row, 'RawInvoiceDate', 'Date')) ||
                    '-';
                amtHtml = mixL3
                    ? drillSpMoney(row, ['Amount', 'RevenueFormatted'], ['ProjectAmount', 'CorporateAmount', 'RawInvoiceAmount', 'Amount'])
                    : null;
                rowIsIr = l3IsIr;
                var l3NextOk = isRevenueDrillNextLevelPresent(row) === true;
                var l3Next = null;
                var l3DrillId = invId || tsNo;
                if (l3DrillId && l3NextOk) {
                    l3Next = {
                        level: 4,
                        label: l3TsLayout
                            ? (tsNo || l3DrillId)
                            : (rowIsIr ? (invId || inv) : (inv || ('INV-' + invId))),
                        portfolioId: top.portfolioId,
                        projectId: top.projectId,
                        invoiceId: l3DrillId,
                        /* Added by Dipali V. on 05-10-2026 — Filtered By chip: Timesheet No vs Invoice/IR */
                        isIrConsiderForRevenue: l3TsLayout ? 0 : 1
                    };
                }
                if (l3TsLayout) {
                    return {
                        next: l3Next,
                        nextOk: l3NextOk,
                        cells: [
                            '<b>' + escHtml(drillTextOrDash(tsNo)) + '</b>',
                            '<span class="num">' + formatDrillMoneyPlain(projAmt, '') + '</span>',
                            '<span class="num">' + formatDrillMoneyPlain(corpAmt, '') + '</span>',
                            statusBadgeHtml(tsStatus)
                        ],
                        exportCells: [
                            tsNo || '-',
                            formatDrillMoneyExport(projAmt, ''),
                            formatDrillMoneyExport(corpAmt, ''),
                            tsStatus
                        ]
                    };
                }
                return {
                    next: l3Next,
                    nextOk: l3NextOk,
                    cells: rowIsIr
                        ? (mixL3
                            ? [
                                '<b>' + escHtml(drillTextOrDash(invId)) + '</b>',
                                amtHtml,
                                mixInvoiceStatusHtml(row),
                                escHtml(dateTxt)
                            ]
                            : [
                                '<b>' + escHtml(drillTextOrDash(invId)) + '</b>',
                                '<span class="num">' + formatDrillMoneyPlain(projAmt, '') + '</span>',
                                '<span class="num">' + formatDrillMoneyPlain(corpAmt, '') + '</span>',
                                statusBadgeHtml(getApiField(row, 'Status')),
                                escHtml(dateTxt)
                            ])
                        : (mixL3
                            ? [
                                '<b>' + escHtml(inv || '-') + '</b>',
                                amtHtml,
                                mixInvoiceStatusHtml(row),
                                escHtml(dateTxt),
                                escHtml(drillTextOrDash(getApiField(row, 'PO Ref', 'PORef', 'PO reference', 'PO ref')))
                            ]
                            : [
                                '<b>' + escHtml(inv || '-') + '</b>',
                                '<span class="num">' + formatDrillMoneyPlain(projAmt, '') + '</span>',
                                '<span class="num">' + formatDrillMoneyPlain(corpAmt, '') + '</span>',
                                statusBadgeHtml(getApiField(row, 'Status')),
                                escHtml(dateTxt),
                                escHtml(drillTextOrDash(getApiField(row, 'PO Ref', 'PORef', 'PO reference', 'PO ref')))
                            ]),
                    exportCells: rowIsIr
                        ? (mixL3
                            ? [
                                invId || '-',
                                drillSpMoneyExport(row, ['Amount', 'RevenueFormatted'], ['ProjectAmount', 'CorporateAmount', 'RawInvoiceAmount', 'Amount']),
                                getApiField(row, 'Status'),
                                dateTxt
                            ]
                            : [
                                invId || '-',
                                formatDrillMoneyExport(projAmt, ''),
                                formatDrillMoneyExport(corpAmt, ''),
                                getApiField(row, 'Status'),
                                dateTxt
                            ])
                        : (mixL3
                            ? [
                                inv || invId,
                                drillSpMoneyExport(row, ['Amount', 'RevenueFormatted'], ['ProjectAmount', 'CorporateAmount', 'RawInvoiceAmount', 'Amount']),
                                getApiField(row, 'Status'),
                                getApiField(row, 'Invoice Date', 'RawInvoiceDate'),
                                drillTextOrDash(getApiField(row, 'PO Ref', 'PORef'))
                            ]
                            : [
                                inv || invId,
                                formatDrillMoneyExport(projAmt, ''),
                                formatDrillMoneyExport(corpAmt, ''),
                                getApiField(row, 'Status'),
                                getApiField(row, 'Invoice Date', 'RawInvoiceDate'),
                                drillTextOrDash(getApiField(row, 'PO Ref', 'PORef'))
                            ])
                };
            });
        } else if (level === 4) {
            /* Mix graph: Line / Description / Qty / Rate / Amount / Source → L5.
               KPI revenue drill: dual amount columns, last level.
               IsIRConsiderForRevenue=0 → Employee Name / Role / Billing Rate / Amount(proj/base). */
            var currencySym = '', projectSym = '';
            var mixL4 = isMixRevCostDrill();
            var l4TsLayout = false;
            if (rows.length) {
                currencySym = String(
                    getApiField(rows[0], 'CurrencySymbol', 'CorporateCurrencySymbol') || ''
                ).trim();
                projectSym = String(getApiField(rows[0], 'ProjectCurrencySymbol') || '').trim();
                l4TsLayout = isRevenueDrillTimesheetLayout(rows[0]);
            }
            if (!currencySym) {
                currencySym = getKpiCurrencySymbol(findKpiCardByFlagOrLabel('Revenue') || {}) || '';
            }
            if (l4TsLayout) {
                /* Added by Dipali V. on 05-10-2026 — IsIRConsiderForRevenue=0 timesheet L4 columns */
                head = [
                    'Employee Name',
                    'Role',
                    'Billing Rate',
                    'Amount(' + (projectSym || '\u2014') + ')',
                    'Amount(' + (currencySym || '\u2014') + ')'
                ];
            } else {
                head = mixL4
                    ? ['Line', 'Description', 'Quantity', 'Rate', 'Amount', 'Source']
                    : [
                        'Line',
                        'Description',
                        'Quantity',
                        'Rate',
                        'Amount(' + (projectSym || '\u2014') + ')',
                        'Amount(' + (currencySym || '\u2014') + ')'
                    ];
            }
            bodyRows = rows.map(function (row) {
                var baseDisp, amtDisp, descHtml, lineSym, rateDisp;
                var empName, roleName, billRate;
                if (l4TsLayout) {
                    empName = getApiField(row, 'Employee Name', 'EmployeeName', 'Employee') || '\u2014';
                    roleName = getApiField(row, 'Role', 'RoleName', 'RoleDescription') || '\u2014';
                    billRate = getApiField(row, 'Billing Rate', 'BillingRate', 'Rate');
                    amtDisp = formatDrillMoneyPlain(getApiField(row, 'Amount', 'ProjectAmount'), '');
                    baseDisp = formatDrillMoneyPlain(
                        getApiField(row, 'BaseCurrencyAmount', 'CorporateAmount'),
                        ''
                    );
                    return {
                        linkOnly: false,
                        next: null,
                        cells: [
                            '<b>' + escHtml(empName) + '</b>',
                            escHtml(roleName),
                            escHtml(billRate != null && billRate !== '' ? billRate : '\u2014'),
                            '<span class="num">' + (amtDisp || '\u2014') + '</span>',
                            '<span class="num">' + (baseDisp || '\u2014') + '</span>'
                        ],
                        exportCells: [
                            empName,
                            roleName,
                            billRate,
                            formatDrillMoneyExport(getApiField(row, 'Amount', 'ProjectAmount'), ''),
                            formatDrillMoneyExport(
                                getApiField(row, 'BaseCurrencyAmount', 'CorporateAmount'),
                                ''
                            )
                        ]
                    };
                }
                desc = getApiField(row, 'ItemDescription', 'Description') || '\u2014';
                /* Added by Aditya J. on 29-09-2026 Show the currency symbol on mix invoice lines */
                lineSym = mixL4 ? mixLineCurrencySymbol(row, currencySym, projectSym) : '';
                amtDisp = formatDrillMoneyPlain(getApiField(row, 'Amount'), lineSym);
                rateDisp = mixL4
                    ? formatDrillMoneyPlain(getApiField(row, 'Rate'), lineSym)
                    : (getApiField(row, 'Rate') != null ? String(getApiField(row, 'Rate')) : '\u2014');
                /* End of Added by Aditya J. on 29-09-2026 Show the currency symbol on mix invoice lines */
                baseDisp = formatDrillMoneyPlain(getApiField(row, 'BaseCurrencyAmount'), lineSym);
                descHtml = escHtml(desc);
                return {
                    linkOnly: false,
                    /* Added by Aditya J. on 29-09-2026 Mix drill stops at invoice lines */
                    next: null,
                    /* End of Added by Aditya J. on 29-09-2026 Mix drill stops at invoice lines */
                    cells: mixL4
                        ? [
                            escHtml(getApiField(row, 'Line', 'LineNumber', 'RFIItemID') || '\u2014'),
                            descHtml,
                            escHtml(getApiField(row, 'Qty (h)', 'QtyHours', 'Quantity') != null ? getApiField(row, 'Qty (h)', 'QtyHours', 'Quantity') : '\u2014'),
                            '<span class="num">' + (rateDisp || '\u2014') + '</span>',
                            '<span class="num">' + (amtDisp || '\u2014') + '</span>',
                            escHtml(mixLineSourceText(row))
                        ]
                        : [
                            escHtml(getApiField(row, 'Line', 'LineNumber', 'RFIItemID') || '\u2014'),
                            descHtml,
                            escHtml(getApiField(row, 'Qty (h)', 'QtyHours', 'Quantity') != null ? getApiField(row, 'Qty (h)', 'QtyHours', 'Quantity') : '\u2014'),
                            escHtml(getApiField(row, 'Rate') != null ? getApiField(row, 'Rate') : '\u2014'),
                            '<span class="num">' + (amtDisp || '\u2014') + '</span>',
                            '<span class="num">' + (baseDisp || '\u2014') + '</span>'
                        ],
                    exportCells: mixL4
                        ? [
                            getApiField(row, 'Line'),
                            desc,
                            getApiField(row, 'Qty (h)', 'QtyHours', 'Quantity'),
                            getApiField(row, 'Rate'),
                            formatDrillMoneyExport(getApiField(row, 'Amount'), ''),
                            mixLineSourceText(row)
                        ]
                        : [
                            getApiField(row, 'Line'),
                            desc,
                            getApiField(row, 'Qty (h)', 'QtyHours', 'Quantity'),
                            getApiField(row, 'Rate'),
                            formatDrillMoneyExport(getApiField(row, 'Amount'), ''),
                            formatDrillMoneyExport(getApiField(row, 'BaseCurrencyAmount'), '')
                        ]
                };
            });
        } else if (level === 5) {
            /* SP L5: Timesheet OR Milestone OR Deliverable columns based on IR item mapping. */
            var l5Type = detectRevenueDrillL5Type(top, rows);
            if (l5Type === 'Milestone') {
                head = ['Milestone', 'Bill amount', 'Actual completion', withPctCaption('Completion'), 'Revenue status date'];
                bodyRows = rows.map(function (row) {
                    return {
                        next: (!isMixRevCostDrill() && isRevenueDrillNextLevelPresent(row)) ? {
                            level: 6, label: 'Audit trail',
                            portfolioId: top.portfolioId,
                            projectId: top.projectId,
                            invoiceId: top.invoiceId,
                            invoiceItemIds: top.invoiceItemIds || pickInvoiceItemId(top),
                            invoiceItemType: 'Milestone'
                        } : null,
                        cells: [
                            '<b>' + escHtml(getApiField(row, 'MileStone', 'Milestone') || '\u2014') + '</b>',
                            '<span class="num">' + formatDrillMoneyPlain(getApiField(row, 'BillAmount'), '') + '</span>',
                            escHtml(getApiField(row, 'ActualCompletionDate') || '\u2014'),
                            escHtml(getApiField(row, 'CompletionPercentage') != null ? getApiField(row, 'CompletionPercentage') : '\u2014'),
                            escHtml(getApiField(row, 'RevenueStatusChangeDate') || '\u2014')
                        ],
                        exportCells: [
                            getApiField(row, 'MileStone', 'Milestone'),
                            formatDrillMoneyExport(getApiField(row, 'BillAmount'), ''),
                            getApiField(row, 'ActualCompletionDate'),
                            getApiField(row, 'CompletionPercentage'),
                            getApiField(row, 'RevenueStatusChangeDate')
                        ]
                    };
                });
            } else if (l5Type === 'Deliverable') {
                head = ['Title', 'Schedule ID', 'Billable amount', withPctCaption('Complete')];
                bodyRows = rows.map(function (row) {
                    return {
                        next: (!isMixRevCostDrill() && isRevenueDrillNextLevelPresent(row)) ? {
                            level: 6, label: 'Audit trail',
                            portfolioId: top.portfolioId,
                            projectId: top.projectId,
                            invoiceId: top.invoiceId,
                            invoiceItemIds: top.invoiceItemIds || pickInvoiceItemId(top),
                            invoiceItemType: 'Deliverable'
                        } : null,
                        cells: [
                            '<b>' + escHtml(getApiField(row, 'Title') || '\u2014') + '</b>',
                            escHtml(getApiField(row, 'ScheduleID') != null ? getApiField(row, 'ScheduleID') : '\u2014'),
                            '<span class="num">' + formatDrillMoneyPlain(getApiField(row, 'BillableAmount'), '') + '</span>',
                            escHtml(getApiField(row, 'PercentageComplete') != null ? getApiField(row, 'PercentageComplete') : '\u2014')
                        ],
                        exportCells: [
                            getApiField(row, 'Title'),
                            getApiField(row, 'ScheduleID'),
                            formatDrillMoneyExport(getApiField(row, 'BillableAmount'), ''),
                            getApiField(row, 'PercentageComplete')
                        ]
                    };
                });
            } else {
                /* Timesheet (default). Mix graph: Date / Employee / Task / Hours / Billable / Approved by */
                var mixL5 = isMixRevCostDrill();
                head = mixL5
                    ? ['Date', 'Employee', 'Task', 'Hours', 'Billable', 'Approved by']
                    : ['Timesheet date', 'Employee', 'Task', 'Duration', 'Billable'];
                bodyRows = rows.map(function (row) {
                    var bill = getApiField(row, 'Billable', 'IsBillable');
                    var billHtml = (String(bill) === '1' || /true|yes|\u2714/i.test(String(bill || '')))
                        ? '\u2714'
                        : escHtml(bill != null && String(bill) !== '' ? String(bill) : '\u2014');
                    var dateTxt = getApiField(row, 'TimeshetDate', 'TimesheetDate', 'Date', 'EntryDate') || '\u2014';
                    var hoursTxt = getApiField(row, 'Duration', 'Hours') != null ? getApiField(row, 'Duration', 'Hours') : '\u2014';
                    var approver = getApiField(row, 'ApprovedBy', 'Approved by', 'Approver', 'ApprovedByName') || '\u2014';
                    return {
                        next: (!mixL5 && isRevenueDrillNextLevelPresent(row)) ? {
                            level: 6, label: 'Audit trail',
                            portfolioId: top.portfolioId,
                            projectId: top.projectId,
                            invoiceId: top.invoiceId,
                            invoiceItemIds: top.invoiceItemIds || pickInvoiceItemId(top),
                            invoiceItemType: top.invoiceItemType || 'Timesheet'
                        } : null,
                        cells: mixL5
                            ? [
                                escHtml(dateTxt),
                                escHtml(getApiField(row, 'EmployeeName', 'Employee') || '\u2014'),
                                escHtml(getApiField(row, 'Task', 'TaskDescription') || '\u2014'),
                                escHtml(hoursTxt),
                                billHtml,
                                escHtml(approver)
                            ]
                            : [
                                escHtml(dateTxt),
                                escHtml(getApiField(row, 'EmployeeName', 'Employee') || '\u2014'),
                                escHtml(getApiField(row, 'Task', 'TaskDescription') || '\u2014'),
                                escHtml(hoursTxt),
                                billHtml
                            ],
                        exportCells: mixL5
                            ? [dateTxt, getApiField(row, 'EmployeeName', 'Employee'), getApiField(row, 'Task'), hoursTxt, getApiField(row, 'Billable'), approver]
                            : [dateTxt, getApiField(row, 'EmployeeName', 'Employee'), getApiField(row, 'Task'), hoursTxt, getApiField(row, 'Billable')]
                    };
                });
            }
        } else {
            head = ['Timestamp (IST)', 'Actor', 'Event', 'Detail'];
            bodyRows = rows.map(function (row) {
                return {
                    next: null,
                    cells: [
                        escHtml(formatDrillDate(getApiField(row, 'Timestamp (IST)', 'TimestampIST'))),
                        escHtml(getApiField(row, 'Actor') || '\u2014'),
                        escHtml(getApiField(row, 'Event') || '\u2014'),
                        escHtml(getApiField(row, 'Detail') || '\u2014')
                    ],
                    exportCells: [getApiField(row, 'Timestamp (IST)'), getApiField(row, 'Actor'), getApiField(row, 'Event'), getApiField(row, 'Detail')]
                };
            });
        }

        RevenueDrill.lastRows = [head].concat(bodyRows.map(function (x) { return x.exportCells; }));

        if (!bodyRows.length) {
            return {
                html: '<div class="m-note">No rows for this level in the selected period' +
                    (level === 6 ? ' (SP level not implemented yet or no data).' : '.') +
                    '</div>',
                bodyRows: []
            };
        }

        return {
            bodyRows: bodyRows,
            html: renderDrillTableHtml(head, bodyRows)
        };
    }

    function formatDrillDate(v) {
        var d;
        if (v == null || v === '' || isDrillBlankPlaceholder(v)) return '-';
        d = parseFilterDate(v);
        if (d) return formatFilterDate(d);
        return String(v);
    }

    /* Added by Aditya J. on 29-09-2026 Level 4 invoice lines use the row currency symbol */
    function mixLineCurrencySymbol(row, corporateSym, projectSym) {
        var sym = String(getApiField(row, 'ProjectCurrencySymbol') || '').trim();
        if (!sym) sym = String(projectSym || '').trim();
        if (!sym) sym = String(getApiField(row, 'CurrencySymbol') || '').trim();
        if (!sym) sym = String(corporateSym || '').trim();
        return sym;
    }
    /* End of Added by Aditya J. on 29-09-2026 Level 4 invoice lines use the row currency symbol */

    /* Purpose: Drill amounts — absolute value + symbol, comma-separated (money fields only). */
    function formatDrillMoneyPlain(v, currencySymbol) {
        var n = parseKpiNumeric(v);
        var sym = currencySymbol != null ? String(currencySymbol) : '';
        var s, m;
        if (v == null || v === '' || isNaN(n)) return '-';
        /* Prefer explicit symbol; else keep symbol embedded in SP *Formatted text (e.g. "USD10000.00"). */
        if (!sym) {
            s = String(v).trim();
            m = s.match(/^([^\d\-\.,\s]+)\s*/);
            if (m) sym = m[1];
            else {
                m = s.match(/\s*([^\d\-\.,\s]+)$/);
                if (m) sym = m[1];
            }
        }
        /* Drilldown: show CorporateCurrencySymbol from API as-is (e.g. USD), do not map to $. */
        return (sym ? (escHtml(sym) + ' ') : '') +
            n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }

    /* Purpose: Excel export money text matching UI (space after currency code + thousands commas). */
    function formatDrillMoneyExport(v, currencySymbol) {
        var n = parseKpiNumeric(v);
        var sym = currencySymbol != null ? String(currencySymbol) : '';
        var s, m;
        if (v == null || v === '' || isNaN(n)) return '-';
        if (!sym) {
            s = String(v).trim();
            m = s.match(/^([^\d\-\.,\s]+)\s*/);
            if (m) sym = m[1];
            else {
                m = s.match(/\s*([^\d\-\.,\s]+)$/);
                if (m) sym = m[1];
            }
        }
        return (sym ? (sym + ' ') : '') +
            n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }

    function formatDrillMoneyRaw(v) {
        var card, sym;
        card = findKpiCardByFlagOrLabel('Revenue') || (KpiCards.list && KpiCards.list[0]) || {};
        sym = getKpiCurrencySymbol(card);
        return formatDrillMoneyPlain(v, sym);
    }

    function renderRevenueDrill() {
        var ov = document.getElementById('overlay');
        var title = document.getElementById('mTitle');
        var crumbs = document.getElementById('mCrumbs');
        var body = document.getElementById('mBody');
        var top, i, html;
        if (!ov || !body) return;
        top = RevenueDrill.stack[RevenueDrill.stack.length - 1];
        ov.classList.add('open');
        syncDrillExportVisibility(top && top.level);
        if (title) {
            var srcLabel = 'Revenue';
            var src = String(RevenueDrill.sourceFlag || '').toLowerCase();
            if (src === 'grossprofit') srcLabel = 'Gross Profit';
            else if (src === 'grossmargin') srcLabel = 'Gross Margin';
            else if (src === 'ebit') srcLabel = 'EBIT';
            else if (src === 'netprofit') srcLabel = 'Net Profit';
            title.textContent = isMixRevCostDrill()
                ? 'Revenue vs Cost Drill-Through \u2192 Timesheet'
                : (srcLabel + ' Drill-Through \u2192 General Ledger');
        }
        renderRevenueDrillFilterBar();
        if (crumbs) {
            html = '';
            for (i = 0; i < RevenueDrill.stack.length; i++) {
                if (i) html += '<span>\u203A</span>';
                html += '<button type="button" data-crumb-i="' + i + '">' + escHtml(RevenueDrill.stack[i].label) + '</button>';
            }
            crumbs.innerHTML = html;
            crumbs.querySelectorAll('[data-crumb-i]').forEach(function (btn) {
                btn.onclick = function () {
                    var idx = Number(btn.getAttribute('data-crumb-i'));
                    RevenueDrill.stack = RevenueDrill.stack.slice(0, idx + 1);
                    renderRevenueDrill();
                };
            });
        }

        var lvlCount = revenueDrillLevelCount();
        body.innerHTML = '<div class="m-note">Level ' + top.level + ' of ' + lvlCount +
            '</div><div class="m-note" style="padding-top:0">Loading\u2026</div>';

        callDashboardApi(revenueDrillApiAction(top), buildRevenueDrillRequest(top), function (json) {
            var payload = unwrapDrillPayload(json);
            var rows = payload.Rows || payload.rows || [];
            var painted;
            var apiMsg = '';
            if (!Array.isArray(rows)) rows = [];
            //Added by Aditya J. on 29-09-2026 Main mix drill button shows the same slices as the doughnut when level 1 has no rows
            if (isMixRevCostDrill() && Number(top.level) === 1 && !rows.length && MixChart && MixChart.items && MixChart.items.length) {
                rows = MixChart.items.map(function (item) {
                    var rev = Number(getApiField(item, 'Revenue'));
                    if (isNaN(rev)) rev = 0;
                    return {
                        PortfolioID: getApiField(item, 'PortfolioID'),
                        Portfolio: getApiField(item, 'PortfolioName', 'Portfolio'),
                        Projects: item._projectCount != null ? item._projectCount : getPortfolioMixProjectCount(item),
                        TotalRevenue: rev,
                        Revenue: rev,
                        RevenueFormatted: getApiField(item, 'RevenueFormatted')
                    };
                }).filter(function (item) {
                    return Number(item.TotalRevenue) > 0;
                });
            }
            //End of Added by Aditya J. on 29-09-2026 Main mix drill button shows the same slices as the doughnut when level 1 has no rows
            /* Surface API failure payloads that still return HTTP 200 */
            if (!rows.length) {
                apiMsg = String(
                    getApiField(json, 'message', 'Message') ||
                    getApiField(json && json.data, 'message', 'Message') ||
                    ''
                ).trim();
                if (/required|fail|error|invalid/i.test(apiMsg)) {
                    body.innerHTML = '<div class="m-note">' + escHtml(apiMsg) + '</div>';
                    return;
                }
            }
            painted = renderRevenueDrillTable(top.level, rows);
            body.innerHTML = '<div class="m-note">Level ' + top.level + ' of ' + revenueDrillLevelCount() +
                '</div>' + painted.html;

            body.querySelectorAll('tr[data-drill-i]').forEach(function (tr) {
                var idx = Number(tr.getAttribute('data-drill-i'));
                var rowMeta = painted.bodyRows[idx];
                var next = rowMeta && rowMeta.next;
                var link;
                /* Guard: IsDataPresentNextLevel=0 must never navigate */
                if (!next || rowMeta.nextOk === false) return;
                if (rowMeta.linkOnly) {
                    link = tr.querySelector('.drill-desc-link');
                    if (!link) return;
                    link.onclick = function (ev) {
                        ev.preventDefault();
                        ev.stopPropagation();
                        if (rowMeta.nextOk === false) return;
                        RevenueDrill.stack.push(next);
                        renderRevenueDrill();
                    };
                    return;
                }
                tr.onclick = function () {
                    if (rowMeta.nextOk === false) return;
                    RevenueDrill.stack.push(next);
                    renderRevenueDrill();
                };
            });
            InitCxoBlackTooltips(document.getElementById('modal'));
        }, function () {
            body.innerHTML = '<div class="m-note">Unable to load revenue drill-down. Please try again.</div>';
            showAlertError('Unable to load revenue drill-down.');
        });
    }

    (function bindRevenueDrillOverlay() {
        var ov = document.getElementById('overlay');
        if (!ov || ov._revenueDrillBound) return;
        ov._revenueDrillBound = true;
        ov.addEventListener('click', function (e) {
            if (e.target && e.target.id === 'overlay') closeModal();
        });
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeModal();
        });
    })();

    /* =====================================================================
       Added by Vikas T on 16-09-2026
       Utilization / Bench / Active Projects drill — GetAnalyticsDBKPIDrillDown
       (BaseAPIDashborad) → usp_Whizible2_Sel_AnalyticsDBKPI_{Flag} @DrillLevel 1–4
       ===================================================================== */

    function opsKpiDrillRootLabel(flag) {
        var labels = OpsKpiDrill.levelLabels[flag] || OpsKpiDrill.levelLabels.Utilization;
        return labels[0] || 'Level 1';
    }

    function openOpsKpiDrill(flag) {
        var f = String(flag || '');
        var norm = f.toLowerCase() === 'activeprojects' ? 'ActiveProjects'
            : (f.toLowerCase() === 'bench' ? 'Bench'
                : (f.toLowerCase() === 'utilization' ? 'Utilization' : f));
        if (!isOpsKpiDrillFlag(norm)) return;
        if (!DateFilter.startDate || !DateFilter.endDate) {
            showAlertError('Select a date range first.');
            return;
        }
        HideCxoTooltips();
        if (typeof closeWidgetFullscreen === 'function') closeWidgetFullscreen();
        /* Added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        DelayedDrill.stack = [];
        DelayedDrill.lastRows = null;
        BudgetVarianceDrill.stack = [];
        BudgetVarianceDrill.lastRows = null;
        /* Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        CsatDrill.active = false;
        CsatDrill.stack = [];
        CsatDrill.lastRows = null;
        /* End of Commented and Added By Vyankat b. on 24th Sep 2026 for the Customer CSAT KPI drill-through */
        /* End of added By Vyankat B. on the 16th sep 2026 for the Delayed Projects KPI drill-through */
        OpsKpiDrill.active = true;
        OpsKpiDrill.flag = norm;
        OpsKpiDrill.lastRows = null;
        OpsKpiDrill.stack = [{
            level: 1,
            label: opsKpiDrillRootLabel(norm),
            portfolioId: null,
            projectId: null,
            employeeId: null,
            roleId: null,
            milestoneId: null,
            taskId: null
        }];
        renderOpsKpiDrill();
        InitCxoBlackTooltips(document.getElementById('modal'));
    }

    function buildOpsKpiDrillRequest(node) {
        /* Added by Vikas T on 16-09-2026 - same chip/date bag as KPI cards (not greeting "all IDs").
           joinGreetingChipIds was narrowing L1 and making Avg util ~2–3% while the card stayed ~34%. */
        var body = buildKpiCardsRequest(null);
        body.Flag = OpsKpiDrill.flag;
        body.Level = node.level;
        /* Added by Vikas T on 17-09-2026 - PortfolioID 0 = Unallocated (Bench); do not treat as falsy */
        if (node.portfolioId === 0 || node.portfolioId === '0') {
            body.PortfolioID = 0;
        } else {
            body.PortfolioID = node.portfolioId || null;
        }
        /* Added by Vikas T after changes 22-09-2026 - ProjectID 0 = Unallocated (Bench L3+); do not treat as falsy */
        if (node.projectId === 0 || node.projectId === '0') {
            body.ProjectID = 0;
        } else {
            body.ProjectID = node.projectId || null;
        }
        body.EmployeeID = node.employeeId || null;
        /*
          Added by Vikas T on 17-09-2026 - CRITICAL:
          buildKpiCardsRequest puts greeting HighLevelRole into RoleID.
          That made Bench open as if Level 2 (people for that role) — L1 Portfolios/Roles skipped.
          Drill RoleID must come ONLY from drill stack, never from RoleFilter.
          Bench L3+ now uses ProjectID, so RoleID is not sent.
        */
        delete body.RoleID;
        if (String(OpsKpiDrill.flag) === 'Bench') {
            /* Added by Vikas T after changes 22-09-2026 - live API still requires RoleID for Bench L3+.
               Send RoleID=projectId so old IIS accepts; SP maps @RoleID → @ProjectID when @ProjectID is null. */
            if (node.level >= 3) {
                if (node.projectId === 0 || node.projectId === '0') {
                    body.RoleID = 0;
                } else if (node.projectId != null && node.projectId !== '') {
                    body.RoleID = Number(node.projectId);
                } else {
                    body.RoleID = 0;
                }
            } else {
                body.RoleID = 0;
            }
        } else if (node.roleId === 0 || node.roleId === '0') {
            body.RoleID = 0;
        } else if (node.roleId != null && node.roleId !== '') {
            body.RoleID = Number(node.roleId);
        }
        /* Added by Vikas T on 17-09-2026 - MilestoneID 0 = project tasks with no milestone */
        if (node.milestoneId === 0 || node.milestoneId === '0') {
            body.MilestoneID = 0;
        } else {
            body.MilestoneID = node.milestoneId || null;
        }
        body.TaskID = node.taskId || null;
        body.PageNumber = 1;
        body.PageSize = 500;
        return body;
    }

    function drillCell(row) {
        var keys = Array.prototype.slice.call(arguments, 1);
        var v = getApiField.apply(null, [row].concat(keys));
        return drillTextOrDash(v);
    }

    /* Purpose: Blank / em-dash / Windows-1252 mojibake (e.g. â€~) → ASCII "-". */
    function isDrillBlankPlaceholder(v) {
        var s = v == null ? '' : String(v).trim();
        if (!s) return true;
        if (s === '?' || s === '-' || s === '\u2014' || s === '\u2013' ||
            s === '\u2012' || s === '\u2015' || s === '\u2212' || s === '\uFFFD' ||
            s === 'â€"' || s === 'â€“' || s === 'â€”' || s === 'â€˜' || s === 'â€™' ||
            s === 'â€~' || s === 'â?' || s === 'N/A' || /^n\/?a$/i.test(s)) {
            return true;
        }
        if (/^[\?\-\u2012\u2013\u2014\u2015\u2212\uFFFD]+$/.test(s)) return true;
        /* UTF-8 dash/quote bytes misread as Windows-1252 (â€ + one char). */
        if (/^â€.?$/.test(s)) return true;
        return false;
    }

    /* Purpose: Text cells in Revenue / other drills — never show "?" or garbled dash for blank. */
    function drillTextOrDash(v) {
        return isDrillBlankPlaceholder(v) ? '-' : String(v).trim();
    }

    /* Added by Vikas T on 17-09-2026 - Active Projects columns match design mock screens */
    function formatActiveSpiCpi(v) {
        if (v == null || String(v).trim() === '' || String(v).trim() === '-' || String(v).trim() === '\u2014') return '-';
        var n = Number(v);
        if (isNaN(n)) return String(v);
        return n.toFixed(2);
    }

    /* Added by Vikas T on 23-09-2026 - SPI/CPI coloured pill like CXO design (green >= 1, amber < 1) */
    function activeSpiCpiBadge(v, kind) {
        var n = Number(v);
        var cls, tip;
        if (v == null || String(v).trim() === '' || String(v).trim() === '-' || String(v).trim() === '\u2014' || isNaN(n)) {
            return '-';
        }
        cls = n < 1 ? 'warn' : 'good';
        tip = String(kind || '').toUpperCase() === 'CPI'
            ? 'CPI = EV \u00F7 AC'
            : 'SPI = EV \u00F7 PV';
        /* Updated by Vikas T on 30-09-2026 - SPI / CPI pill without colour dot. */
        return '<span class="badge b-' + cls + '" title="' + tip + '">' + n.toFixed(2) + '</span>';
    }

    function formatActiveDelay(row) {
        var days = Number(getApiField(row, 'DelayDays'));
        var delay;
        if (!isNaN(days) && days > 0) return String(days) + ' d';
        delay = String(getApiField(row, 'Delay') || '').trim();
        if (/^\d+\s*d$/i.test(delay)) return delay.replace(/d$/i, ' d').replace(/\s+/g, ' ');
        if (/^\d+$/.test(delay) && Number(delay) > 0) return delay + ' d';
        return '-';
    }

    function formatActivePct(v) {
        var n = Number(v);
        if (v == null || String(v).trim() === '' || isNaN(n)) return '-';
        return n.toFixed(1) + '%';
    }

    function formatActiveDate(v, withTime) {
        if (v == null || String(v).trim() === '' || String(v).trim() === '-' || String(v).trim() === '\u2014') return '-';
        var d = new Date(v);
        if (isNaN(d.getTime())) {
            var m = String(v).match(/^(\d{4})-(\d{2})-(\d{2})/);
            if (m) d = new Date(Number(m[1]), Number(m[2]) - 1, Number(m[3]));
        }
        if (isNaN(d.getTime())) return String(v);
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        var out = months[d.getMonth()] + ' ' + (d.getDate() < 10 ? '0' : '') + d.getDate() + ', ' + d.getFullYear();
        if (withTime) {
            var hh = (d.getHours() < 10 ? '0' : '') + d.getHours();
            var mm = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
            if (!(hh === '00' && mm === '00')) out = months[d.getMonth()] + ' ' + d.getDate() + ', ' + hh + ':' + mm;
            else out = months[d.getMonth()] + ' ' + d.getDate();
        }
        return out;
    }

    function formatActiveEstActual(v) {
        var s = String(v == null ? '' : v).trim();
        if (!s || s === '-') return '-';
        return s.replace(/(\d+)\.0\b/g, '$1').replace(/\s*\/\s*/, ' / ');
    }

    function activeProjectNameHtml(row) {
        var name = drillCell(row, 'Project');
        var cust = String(getApiField(row, 'Customer') || '').trim();
        if (!cust || cust === '-' || cust === '\u2014') {
            return '<b>' + escHtml(name) + '</b>';
        }
        return '<div><b>' + escHtml(name) + '</b><div style="color:#6b7280;font-size:12px;line-height:1.35;margin-top:2px">' +
            escHtml(cust) + '</div></div>';
    }

    function renderOpsKpiDrillTable(flag, level, rows) {
        var head = [];
        var bodyRows = [];
        var footHtml = '';
        var top = OpsKpiDrill.stack[OpsKpiDrill.stack.length - 1] || {};
        rows = rows || [];
        var emptyNote = (OpsKpiDrill.emptyMsgByLevel[flag] && OpsKpiDrill.emptyMsgByLevel[flag][level])
            || OpsKpiDrill.emptyMsg[flag]
            || 'No rows for this level.';

        if (flag === 'Utilization') {
            /* Added by Vikas T after changes 22-09-2026 - Util columns match design HTML (Group → project → person → weeks) */
            /* Added by Vikas T on 30-09-2026 - L1 Portfolio / FTE / Utilization / Billable H (HH:MM) / Bench Exposure;
               reads new SP columns 'Utilization (%)' and 'Billable H'. */
            if (level === 1) {
                head = ['Portfolio', 'FTE', 'Utilization', 'Billable H', 'Bench Exposure'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Portfolio', 'Group');
                    var pid = Number(getApiField(row, 'ProjectGroupID', 'PortfolioID'));
                    var selectedPf = String(joinSelectedIds('Portfolio') || '');
                    var benchLbl = String(getApiField(row, 'Bench exposure') || '').trim();
                    var fte = getApiField(row, 'FTE');
                    var util = getApiField(row, 'Utilization (%)', 'UtilizationPct', 'Avg utilization', 'AvgUtilizationPct', 'Utilization (FTE-weighted)');
                    var billable = getApiField(row, 'Billable H', 'BillableHours', 'Billable h (wk)', 'Billable h / week');
                    return {
                        next: (!isNaN(pid) && pid > 0)
                            ? { level: 2, label: name, portfolioId: pid, projectId: null, employeeId: null }
                            : null,
                        highlight: selectedPf && !isNaN(pid) && (',' + selectedPf + ',').indexOf(',' + String(pid) + ',') >= 0,
                        cells: [
                            '<b style="color:#111827">' + escHtml(name) + '</b>',
                            escHtml(formatDrillFte(fte)),
                            utilPctHtml(util),
                            escHtml(formatDrillHours(billable)),
                            utilBenchHtml(benchLbl)
                        ],
                        exportCells: [
                            name, fte, formatDrillPct(util), formatDrillHours(billable), benchLbl
                        ]
                    };
                });
            } else if (level === 2) {
                head = ['Project', 'PM', 'Utilization', 'FTE', 'Status'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Project');
                    var pid = Number(getApiField(row, 'ProjectID'));
                    return {
                        next: (!isNaN(pid) && pid > 0)
                            ? {
                                level: 3, label: name,
                                portfolioId: top.portfolioId, projectId: pid, employeeId: null
                            }
                            : null,
                        cells: [
                            '<b>' + escHtml(name) + '</b>',
                            escHtml(drillCell(row, 'PM')),
                            utilPctHtml(getApiField(row, 'Utilization', 'UtilizationPct')),
                            escHtml(formatDrillFte(getApiField(row, 'FTE'))),
                            statusBadgeHtml(drillCell(row, 'Status'))
                        ],
                        exportCells: [
                            name, getApiField(row, 'PM'), formatDrillPct(getApiField(row, 'Utilization', 'UtilizationPct')),
                            getApiField(row, 'FTE'), getApiField(row, 'Status')
                        ]
                    };
                });
            } else if (level === 3) {
                /* Added by Vikas T on 30-09-2026 - L3 last column is Timesheet Details (not Allocation). */
                head = ['Resource', 'Role', '6-Week Average', 'This Week', 'Timesheet Details'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Resource');
                    var eid = Number(getApiField(row, 'EmployeeID'));
                    var role = drillCell(row, 'Role');
                    var tsId = drillCell(row, 'Timesheet details', 'TimesheetDetails', 'TimesheetID', 'Allocation');
                    return {
                        next: (!isNaN(eid) && eid > 0)
                            ? {
                                level: 4, label: name,
                                portfolioId: top.portfolioId, projectId: top.projectId, employeeId: eid,
                                role: role
                            }
                            : null,
                        cells: [
                            '<b>' + escHtml(name) + '</b>',
                            escHtml(role),
                            utilPctHtml(getApiField(row, '6-wk avg', 'SixWkAvgPct', '6-week average')),
                            utilPctHtml(getApiField(row, 'This week', 'ThisWeekPct')),
                            escHtml(tsId)
                        ],
                        exportCells: [
                            name, role,
                            formatDrillPct(getApiField(row, '6-wk avg', 'SixWkAvgPct')),
                            formatDrillPct(getApiField(row, 'This week', 'ThisWeekPct')),
                            tsId
                        ]
                    };
                });
            } else {
                /* Added by Vikas T on 30-09-2026 - L4 adds Utilization; hours HH:MM on screen and export. */
                head = ['Week', 'Utilization', 'Logged H', 'Billable %', 'Billable H', 'Non-Billable H', 'Status'];
                bodyRows = rows.map(function (row) {
                    var week = drillCell(row, 'Week', 'Date');
                    var util = getApiField(row, 'Utilization', 'UtilizationPct');
                    var logged = getApiField(row, 'Logged H', 'Hours');
                    var billPct = getApiField(row, 'Billable %');
                    var billH = getApiField(row, 'Billable H');
                    var nonH = getApiField(row, 'Non-billable H');
                    var st = drillCell(row, 'Status');
                    return {
                        next: null,
                        cells: [
                            escHtml(week),
                            utilPctHtml(util),
                            escHtml(formatDrillHours(logged)),
                            escHtml(formatDrillPct(billPct)),
                            escHtml(formatDrillHours(billH)),
                            escHtml(formatDrillHours(nonH)),
                            statusBadgeHtml(st)
                        ],
                        exportCells: [week, formatDrillPct(util), formatDrillHours(logged), formatDrillPct(billPct), formatDrillHours(billH), formatDrillHours(nonH), st]
                    };
                });
            }
        } else if (flag === 'Bench') {
            /* Added by Vikas T after changes 22-09-2026 - Bench drill HTML matches Utilization columns. FTE stays Bench FTE. */
            /* Added by Vikas T on 30-09-2026 - Bench L1 same columns as Utilization; hours HH:MM. */
            if (level === 1) {
                head = ['Portfolio', 'FTE', 'Utilization', 'Billable H', 'Bench Exposure'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Portfolio', 'Group');
                    var pidRaw = getApiField(row, 'ProjectGroupID', 'PortfolioID');
                    var pid = pidRaw == null || pidRaw === '' ? NaN : Number(pidRaw);
                    var fte = getApiField(row, 'FTE', 'BenchFTE');
                    var util = getApiField(row, 'Utilization (%)', 'UtilizationPct', 'Avg utilization', 'AvgUtilizationPct', 'Utilization (FTE-weighted)');
                    var billable = getApiField(row, 'Billable H', 'BillableHours', 'Billable h (wk)', 'Billable h / week');
                    var benchLbl = String(getApiField(row, 'Bench exposure') || '').trim();
                    return {
                        next: (!isNaN(pid) && pid >= 0)
                            ? { level: 2, label: name, portfolioId: pid, projectId: null, employeeId: null }
                            : null,
                        cells: [
                            '<b style="color:#111827">' + escHtml(name) + '</b>',
                            escHtml(formatDrillFte(fte)),
                            utilPctHtml(util),
                            escHtml(formatDrillHours(billable)),
                            utilBenchHtml(benchLbl)
                        ],
                        exportCells: [name, fte, formatDrillPct(util), formatDrillHours(billable), benchLbl]
                    };
                });
            } else if (level === 2) {
                head = ['Project', 'PM', 'Utilization', 'FTE', 'Status'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Project');
                    var pidRaw = getApiField(row, 'ProjectID');
                    var pid = pidRaw == null || pidRaw === '' ? NaN : Number(pidRaw);
                    return {
                        next: (!isNaN(pid) && pid >= 0)
                            ? {
                                level: 3, label: name,
                                portfolioId: top.portfolioId, projectId: pid, employeeId: null
                            }
                            : null,
                        cells: [
                            '<b>' + escHtml(name) + '</b>',
                            escHtml(drillCell(row, 'PM')),
                            utilPctHtml(getApiField(row, 'Utilization', 'UtilizationPct')),
                            escHtml(formatDrillFte(getApiField(row, 'FTE', 'BenchFTE'))),
                            statusBadgeHtml(drillCell(row, 'Status'))
                        ],
                        exportCells: [
                            name, getApiField(row, 'PM'), formatDrillPct(getApiField(row, 'Utilization', 'UtilizationPct')),
                            getApiField(row, 'FTE', 'BenchFTE'), getApiField(row, 'Status')
                        ]
                    };
                });
            } else if (level === 3) {
                /* Added by Vikas T on 30-09-2026 - Bench L3 same as Utilization (Timesheet Details, no Practice/Allocation). */
                head = ['Resource', 'Role', '6-Week Average', 'This Week', 'Timesheet Details'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Resource');
                    var eid = Number(getApiField(row, 'EmployeeID'));
                    var role = drillCell(row, 'Role');
                    var tsId = drillCell(row, 'Timesheet details', 'TimesheetDetails', 'TimesheetID', 'Allocation');
                    return {
                        next: (!isNaN(eid) && eid > 0)
                            ? {
                                level: 4, label: name,
                                portfolioId: top.portfolioId, projectId: top.projectId, employeeId: eid,
                                role: role
                            }
                            : null,
                        cells: [
                            '<b>' + escHtml(name) + '</b>',
                            escHtml(role),
                            utilPctHtml(getApiField(row, '6-wk avg', 'SixWkAvgPct', '6-week average')),
                            utilPctHtml(getApiField(row, 'This week', 'ThisWeekPct')),
                            escHtml(tsId)
                        ],
                        exportCells: [
                            name, role,
                            formatDrillPct(getApiField(row, '6-wk avg', 'SixWkAvgPct')),
                            formatDrillPct(getApiField(row, 'This week', 'ThisWeekPct')),
                            tsId
                        ]
                    };
                });
            } else {
                /* Added by Vikas T on 30-09-2026 - Bench L4 Utilization column same as Utilization; hours HH:MM. */
                head = ['Week', 'Utilization', 'Logged H', 'Billable %', 'Billable H', 'Non-Billable H', 'Status'];
                bodyRows = rows.map(function (row) {
                    var week = drillCell(row, 'Week', 'Date');
                    var util = getApiField(row, 'Utilization', 'UtilizationPct');
                    var logged = getApiField(row, 'Logged H', 'Hours');
                    var billPct = getApiField(row, 'Billable %');
                    var billH = getApiField(row, 'Billable H');
                    var nonH = getApiField(row, 'Non-billable H');
                    var st = drillCell(row, 'Status');
                    return {
                        next: null,
                        cells: [
                            escHtml(week),
                            utilPctHtml(util),
                            escHtml(formatDrillHours(logged)),
                            escHtml(formatDrillPct(billPct)),
                            escHtml(formatDrillHours(billH)),
                            escHtml(formatDrillHours(nonH)),
                            statusBadgeHtml(st)
                        ],
                        exportCells: [week, formatDrillPct(util), formatDrillHours(logged), formatDrillPct(billPct), formatDrillHours(billH), formatDrillHours(nonH), st]
                    };
                });
            }
        } else {
            /* Added by Vikas T on 06-10-2026 - Active Projects drill matches the CXO screen:
               L1 Project, Portfolio, Health, SPI, CPI, Delay, Milestones.
               Blank portfolio is Unmapped. SPI and CPI are plain numbers.
               L2 Milestone, Due Date, Status, Responsible Person.
               Unmapped keeps due, status and responsible person as '-'.
               L3 Task Name, Assignee, Estimated H, Actual H, Effort Variance, Status.
               Level 4 is removed. */
            if (level === 1) {
                head = ['Project', 'Portfolio', 'Health', 'SPI', 'CPI', 'Delay', 'Milestones'];
                bodyRows = rows.map(function (row) {
                    var name = drillCell(row, 'Project');
                    var pid = Number(getApiField(row, 'ProjectID'));
                    var spi = formatActiveSpiCpi(getApiField(row, 'SPI'));
                    var cpi = formatActiveSpiCpi(getApiField(row, 'CPI'));
                    var delay = drillCell(row, 'Delay');
                    var ms = drillCell(row, 'Milestones', 'MilestoneCount');
                    var portfolio = drillCell(row, 'Group', 'GroupName', 'Portfolio');
                    /* Added by Vikas T on 06-10-2026 - no portfolio name shows Unmapped. */
                    if (!portfolio || portfolio === '-') portfolio = 'Unmapped';
                    var health = drillCell(row, 'Health');
                    return {
                        next: (!isNaN(pid) && pid > 0)
                            ? {
                                level: 2, label: name, projectId: pid, milestoneId: null, taskId: null,
                                groupName: portfolio,
                                delayDays: parseDelayDays(delay)
                            }
                            : null,
                        cells: [
                            '<b>' + escHtml(name) + '</b>',
                            escHtml(portfolio),
                            healthBadgeHtml(health),
                            escHtml(spi),
                            escHtml(cpi),
                            escHtml(delay),
                            escHtml(ms)
                        ],
                        exportCells: [
                            name, portfolio, getApiField(row, 'Health'),
                            spi, cpi, delay, ms
                        ]
                    };
                });
            } else if (level === 2) {
                /* Added by Vikas T on 06-10-2026 - Due Date from the API; Owner header is Responsible Person. */
                head = ['Milestone', 'Due Date', 'Status', 'Responsible Person'];
                /* Added by Vikas T on 06-10-2026 - Unmapped stays in the list when a real milestone is also present. */
                bodyRows = rows.filter(function (row) {
                    return true;
                }).map(function (row) {
                    var name = drillCell(row, 'Milestone');
                    var midRaw = getApiField(row, 'MilestoneID');
                    var mid = (midRaw === null || midRaw === undefined || midRaw === '') ? NaN : Number(midRaw);
                    /* Added by Vikas T on 06-10-2026 - MilestoneID 0 is the Unmapped row. */
                    if (mid === 0 && (!name || name === '-')) name = 'Unmapped';
                    /* Added by Vikas T on 06-10-2026 - Unmapped has no due date, status, or responsible person. */
                    var isUnmapped = mid === 0;
                    var due = isUnmapped ? '-' : formatDrillPrettyDate(getApiField(row, 'Due', 'DueDate'));
                    var status = isUnmapped ? '-' : drillCell(row, 'Status');
                    var owner = isUnmapped ? '-' : drillCell(row, 'Owner', 'Responsible Person');
                    return {
                        next: (!isNaN(mid) && mid >= 0)
                            ? {
                                level: 3, label: name,
                                projectId: top.projectId, milestoneId: mid, taskId: null,
                                groupName: top.groupName, delayDays: top.delayDays
                            }
                            : null,
                        cells: [
                            '<b>' + escHtml(name) + '</b>',
                            escHtml(due),
                            isUnmapped ? escHtml('-') : delayedStatusBadgeHtml(status),
                            escHtml(owner)
                        ],
                        exportCells: [
                            name, due, isUnmapped ? '-' : getApiField(row, 'Status'), owner
                        ]
                    };
                });
            } else if (level === 3) {
                /* Added by Vikas T on 06-10-2026 - State renamed to Status. Level 4 removed. */
                head = ['Task Name', 'Assignee', 'Estimated H', 'Actual H', 'Effort Variance', 'Status'];
                var hhmmToDecimal = function (v) {
                    var m = String(v == null ? '' : v).trim().match(/^(\d+):(\d{1,2})$/);
                    return m ? Number(m[1]) + Number(m[2]) / 60 : v;
                };
                bodyRows = rows.map(function (row) {
                    var taskName = drillCell(row, 'Task Name', 'Work item', 'WorkItem');
                    var tid = Number(getApiField(row, 'TaskID'));
                    var workLabel = (!isNaN(tid) && tid > 0) ? ('WZ-' + tid + ' ' + taskName) : taskName;
                    var est = getApiField(row, 'EstHours', 'Estimated h', 'EstimatedH');
                    var act = getApiField(row, 'ActualHours', 'Actual h', 'ActualH');
                    if ((est == null || est === '') && (act == null || act === '')) {
                        var combined = String(getApiField(row, 'Est / actual (h)') || '');
                        var parts = combined.split(/\s*\/\s*/);
                        if (parts.length === 2) {
                            est = hhmmToDecimal(parts[0]);
                            act = hhmmToDecimal(parts[1]);
                        }
                    }
                    /* Added by Vikas T on 06-10-2026 - Estimated and Actual hours in HH:MM. */
                    var estHm = formatDrillHours(est);
                    var actHm = formatDrillHours(act);
                    var varianceHtml = effortVarianceBadge(est, act);
                    return {
                        next: null,
                        cells: [
                            '<b>' + escHtml(workLabel) + '</b>',
                            escHtml(drillCell(row, 'Assignee')),
                            escHtml(estHm),
                            escHtml(actHm),
                            varianceHtml,
                            delayedStatusBadgeHtml(drillCell(row, 'State', 'Status'))
                        ],
                        exportCells: [
                            workLabel, getApiField(row, 'Assignee'), estHm, actHm,
                            varianceHtml.replace(/<[^>]*>/g, ''), getApiField(row, 'State', 'Status')
                        ]
                    };
                });
            }
        }

        /* Updated by Vikas T on 30-09-2026 - export headers Title Case like the screen. */
        OpsKpiDrill.lastRows = [head.map(function (h) { return toCamelCaption(h); })].concat(bodyRows.map(function (x) { return x.exportCells; }));

        if (!bodyRows.length) {
            return {
                html: '<div class="m-note">' + escHtml(emptyNote) + '</div>',
                bodyRows: []
            };
        }

        return {
            html: renderDrillTableHtml(head, bodyRows, { opsStyle: true, footHtml: footHtml || '' }),
            bodyRows: bodyRows
        };
    }

    /* Purpose: Drill subtitle — level only (e.g. "Level 1 of 4"). */
    function opsKpiDrillLevelNote(flag, level, maxLevel, labels, top) {
        return 'Level ' + level + ' of ' + maxLevel;
    }

    function renderOpsKpiDrill() {
        var ov = document.getElementById('overlay');
        var title = document.getElementById('mTitle');
        var crumbs = document.getElementById('mCrumbs');
        var body = document.getElementById('mBody');
        var flag = OpsKpiDrill.flag;
        var labels = OpsKpiDrill.levelLabels[flag] || [];
        var top, i, html, maxLevel;
        if (!ov || !body || !flag) return;
        top = OpsKpiDrill.stack[OpsKpiDrill.stack.length - 1];
        maxLevel = labels.length || 4;
        ov.classList.add('open');
        syncDrillExportVisibility(top && top.level);
        /* Updated by Vikas T on 30-09-2026 - Title Case drill title. */
        if (title) title.textContent = toCamelCaption(OpsKpiDrill.titles[flag] || (flag + ' Drill-Through'));
        renderRevenueDrillFilterBar();
        if (crumbs) {
            html = '';
            for (i = 0; i < OpsKpiDrill.stack.length; i++) {
                if (i) html += '<span>\u203A</span>';
                html += '<button type="button" data-crumb-i="' + i + '">' + escHtml(OpsKpiDrill.stack[i].label) + '</button>';
            }
            crumbs.innerHTML = html;
            crumbs.querySelectorAll('[data-crumb-i]').forEach(function (btn) {
                btn.onclick = function () {
                    var idx = Number(btn.getAttribute('data-crumb-i'));
                    OpsKpiDrill.stack = OpsKpiDrill.stack.slice(0, idx + 1);
                    renderOpsKpiDrill();
                };
            });
        }

        body.innerHTML = '<div class="m-note">' + opsKpiDrillLevelNote(flag, top.level, maxLevel, labels, top) +
            '</div><div class="m-note" style="padding-top:0">Loading\u2026</div>';

        callDashboardApi('GetAnalyticsDBKPIDrillDown', buildOpsKpiDrillRequest(top), function (json) {
            var payload = unwrapDrillPayload(json);
            var rows = payload.Rows || payload.rows || [];
            var painted;
            if (!Array.isArray(rows)) rows = [];
            painted = renderOpsKpiDrillTable(flag, top.level, rows);
            body.innerHTML = '<div class="m-note">' +
                opsKpiDrillLevelNote(flag, top.level, maxLevel, labels, top) +
                '</div>' + painted.html;

            body.querySelectorAll('tr[data-drill-i]').forEach(function (tr) {
                var idx = Number(tr.getAttribute('data-drill-i'));
                var rowMeta = painted.bodyRows[idx];
                var next = rowMeta && rowMeta.next;
                if (!next) return;
                tr.onclick = function () {
                    OpsKpiDrill.stack.push(next);
                    renderOpsKpiDrill();
                };
            });
            InitCxoBlackTooltips(document.getElementById('modal'));
        }, function () {
            body.innerHTML = '<div class="m-note">Unable to load ' + escHtml(flag) + ' drill-down. Please try again.</div>';
            showAlertError('Unable to load ' + flag + ' drill-down.');
        });
    }

    /* =====================================================================
       Save View / My Views / Edit / Delete / Set Default — owned by js/app.js
       ASPX only wires boot; do not reimplement view APIs here.
       ===================================================================== */

    /* Purpose: Alertify helpers used by CXO drills / KPI (shared, not view-owned). */
    function showAlertError(msg) {
        if (typeof alertify !== 'undefined') {
            try { alertify.set('notifier', 'position', 'top-right'); } catch (e) { }
            alertify.error(msg || 'Something went wrong');
        } else if (typeof toast === 'function') {
            toast(msg);
        }
    }

    /* Purpose: Alertify green success (fallback toast). */
    function showAlertSuccess(msg) {
        if (typeof alertify !== 'undefined') {
            try { alertify.set('notifier', 'position', 'top-right'); } catch (e) { }
            alertify.success(msg || 'Done');
        } else if (typeof toast === 'function') {
            toast(msg);
        }
    }

    /* Purpose: Wire Save / My / Edit / Delete / Default from js/app.js only. */
    function InitUserSavedViews() {
        if (typeof window.execInitSavedViews === 'function') {
            window.execInitSavedViews();
            return;
        }
        if (typeof window.InitApiUserSavedViews === 'function') {
            window.InitApiUserSavedViews();
            return;
        }
        showAlertError('Save View is not available. Please refresh the page.');
    }

    /* Purpose: Page load — keep white preloader until date + chips + role + default view + KPIs are bound. */
    function InitDateFilter() {
        /* Do NOT reveal AnalyticsWrapper yet — preloader stays until finish. */
        bindDatePickerButton();
        bindHighLevelRolePill();
        bindKpiRenderHook();
        InitUserSavedViews();
        BindCxoTooltipDismiss();
        InitCxoBlackTooltips(document);
        RenderKpiShell();
        bindCopilotChrome();

        var dateReady = false;
        var chipsReady = false;
        var roleReady = false;
        var defaultReady = false;
        var bootStarted = false;

        function tryFinishBoot() {
            if (bootStarted) return;
            if (!dateReady || !chipsReady || !roleReady || !defaultReady) return;
            bootStarted = true;
            if (typeof persistState === 'function') persistState();
            /* Bind KPIs behind preloader, then showDashboardPage() inside GetKpiCards. */
            GetKpiCards();
        }

        GetFilterOption(function (dateOptions) {
            var def = getDefaultDateOption(dateOptions);
            if (!def) {
                updateFilterHeader();
                dateReady = true;
                tryFinishBoot();
                return;
            }
            GetFilterDateRange(String(getApiField(def, 'FilterID')), null, null, function (row) {
                applyFilterDateRange(row, getApiField(def, 'FilterName'));
                dateReady = true;
                tryFinishBoot();
            });
        });

        InitTopFilter(function () {
            chipsReady = true;
            /* Default saved view — js/app.js only (do not use aspx copy). */
            if (typeof window.LoadDefaultUserView === 'function') {
                window.LoadDefaultUserView(function () {
                    defaultReady = true;
                    tryFinishBoot();
                });
            } else {
                defaultReady = true;
                tryFinishBoot();
            }
        });

        GetHighLevelRoles(function () {
            LoadRoleGreeting(function () {
                roleReady = true;
                tryFinishBoot();
            });
        });

        /* Safety: never leave the white preloader stuck if one bind path hangs. */
        setTimeout(function () {
            if (PageBootComplete) return;
            dateReady = true;
            chipsReady = true;
            roleReady = true;
            defaultReady = true;
            tryFinishBoot();
            if (!PageBootComplete) showDashboardPage();
        }, 20000);
    }

    InitDateFilter();
</script>
</form>
</body>
</html>
