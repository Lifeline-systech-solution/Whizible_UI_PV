<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_TeamsAlertSettings.aspx.vb" Inherits="Whizible.SM_TeamsAlertSettings" %>
<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Teams Alert Settings")%>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Teams Alert Settings</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css" />
    <style type="text/css">
        body {
            font-size: 11px;
            background-color: #f8f9fa;
        }

        .graybg {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .teams-alert-page-inner {
            max-width: 720px;
            margin: 0 auto;
            width: 100%;
        }

        .content {
            padding: 0.5rem 1rem 1.25rem;
        }

        .teams-alert-content {
            padding: 0;
        }

        .alert-section {
            margin-top: 1rem;
        }

        .alert-section-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 6px;
        }

        .alert-section-title {
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            color: #9ca3af;
            white-space: nowrap;
        }

        .alert-section-line {
            flex: 1;
            height: 1px;
            background-color: #e5e7eb;
        }

        .alert-settings-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
        }

        .alert-setting-row {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
        }

        .alert-setting-row + .alert-setting-row {
            border-top: 1px solid #f0f0f0;
        }

        .alert-setting-icon {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 13px;
        }

        .alert-setting-icon.purple { background: #f5f0ff; color: #a78bfa; }
        .alert-setting-icon.blue { background: #eff6ff; color: #60a5fa; }
        .alert-setting-icon.green { background: #f0fdf4; color: #4ade80; }
        .alert-setting-icon.amber { background: #fef3e2; color: #d4a574; }
        .alert-setting-icon.orange { background: #fff7ed; color: #fb923c; }
        .alert-setting-icon.red { background: #fef2f2; color: #f87171; }
        .alert-setting-icon.pink { background: #fdf2f8; color: #f472b6; }

        .alert-setting-text {
            flex: 1;
            min-width: 0;
        }

        .alert-setting-title {
            font-size: 11px;
            font-weight: 600;
            color: #111827;
            margin: 0 0 1px;
        }

        .alert-setting-desc {
            font-size: 10px;
            color: #6b7280;
            margin: 0;
            line-height: 1.35;
        }

        .alert-setting-status {
            font-size: 10px;
            font-weight: 500;
            min-width: 50px;
            text-align: right;
        }

        .alert-setting-status.enabled {
            color: #1e40af;
        }

        .alert-setting-status.disabled {
            color: #9ca3af;
        }

        .alert-toggle-wrap {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .alert-toggle-wrap input.cmn-toggle-round-flat + label {
            width: 38px;
            height: 20px;
            padding: 2px;
            top: 0;
            background-color: #d1d5db;
        }

        .alert-toggle-wrap input.cmn-toggle-round-flat + label:before {
            top: 2px;
            left: 2px;
            bottom: 2px;
            right: 2px;
            background-color: #d1d5db;
        }

        .alert-toggle-wrap input.cmn-toggle-round-flat + label:after {
            width: 14px;
            top: 3px;
            right: 3px;
            bottom: 3px;
        }

        .alert-toggle-wrap input.cmn-toggle-round-flat:checked + label,
        .alert-toggle-wrap input.cmn-toggle-round-flat:checked + label:before {
            background-color: #1359a6;
        }

        .alert-toggle-wrap input.cmn-toggle-round-flat:checked + label:after {
            margin-right: 20px;
        }

        .alert-toggle-wrap input.cmn-toggle-round-flat:disabled + label {
            cursor: not-allowed;
            opacity: 0.55;
        }

        .page-header-icon {
            color: #1e40af;
            font-size: 1.5rem;
            margin-right: 0.75rem;
        }

        h5.pgtitle {
            margin: 0;
            font-weight: 600;
            color: #1e40af;
            font-size: 18px;
        }

        .alertify-notifier {
            z-index: 99999 !important;
        }
        /* Read-only mode — toggle greyed but row still visible */
        .alert-toggle-wrap.read-only label {
            cursor: not-allowed;
            opacity: 0.45;
        }
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <form id="form1" runat="server">
        <%If m_blnViewAccess = True Then%>
        <%If m_blnEditAccess = True Then%><span id="canEditTeamsAlertSettingsFlag" style="display:none"></span><%End If%>
        <%If m_blnAddAccess = True Then%><span id="canAddTeamsAlertSettingsFlag" style="display:none"></span><%End If%>
        <div class="bgwhite">
            <div class="pt-1 pb-1 graybg">
                <div class="col-sm-12 d-flex justify-content-between align-items-start flex-wrap gap-2">
                    <div>
                        <h5 class="pgtitle align-items-center">
                            <i class="fas fa-bell page-header-icon"></i>
                            Teams alert settings
                        </h5>
                        <p class="mb-0" style="color: #6b7280; font-size: 0.7rem;">Control which notifications your team receives.</p>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="content pt-1">
                <div class="teams-alert-page-inner">
                    <%-- Static rows removed: alert types are rendered dynamically from the API response --%>
                    <div class="teams-alert-content" id="teamsAlertSettingsContainer"></div>
                </div>
            </div>
        </div>
        <%Else %>
        <div id="ViewAccess" class="tab-pane" style="height: 448px">
            <div style="text-align: center">
                <p style="margin-top: 136px; font-weight: 700;">You are not authorized to view this page.</p>
            </div>
        </div>
        <%End If%>
    </form>

    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script src="../../General/CommonValidations.js"></script>

<script>
var strUrl            = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
var SessionEmployeeId = '<%= Session("intUserId") %>';
var SessionLoginType  = '<%= Session("LoginType") %>';

var canEditTeamsAlertSettings   = !!document.getElementById("canEditTeamsAlertSettingsFlag");
var canAddTeamsAlertSettings    = !!document.getElementById("canAddTeamsAlertSettingsFlag");
var canChangeTeamsAlertSettings = canEditTeamsAlertSettings || canAddTeamsAlertSettings;

alertify.set('notifier', 'position', 'top-right');

// ─── UI decoration map ────────────────────────────────────────────────────────
var ALERT_META = {
    'TaskAssignments':       { icon: 'fa-clipboard-list',       color: 'purple', section: 'Task & Work' },
    'TaskReminders':         { icon: 'fa-clock',                color: 'blue',   section: 'Task & Work' },
    'LeaveApprovals':        { icon: 'fa-calendar-alt',         color: 'green',  section: 'Approvals' },
    'TimesheetApprovals':    { icon: 'fa-chart-bar',            color: 'amber',  section: 'Approvals' },
    'ProjectAllocation':     { icon: 'fa-folder-open',          color: 'orange', section: 'Resource & Project' },
    'ResourceOverallocation':{ icon: 'fa-exclamation-triangle', color: 'red',    section: 'Resource & Project' },
    'TimesheetDefaulters':   { icon: 'fa-users',                color: 'green',  section: 'Timesheet Compliance' },
    'TimesheetDelay':        { icon: 'fa-hourglass-half',       color: 'pink',   section: 'Timesheet Compliance' }
};

var FALLBACK_META = { icon: 'fa-bell', color: 'blue', section: 'Other' };

var SECTION_ORDER = [
    'Task & Work',
    'Approvals',
    'Resource & Project',
    'Timesheet Compliance'
];

function getMeta(alertType) {
    return ALERT_META[alertType] || FALLBACK_META;
}

// ─── shared API helper ────────────────────────────────────────────────────────
function callApi(opts) {
    var ajaxOpts = {
        url:         opts.url,
        type:        'POST',
        async:       true,
        dataType:    'json',
        contentType: 'application/json;charset=utf-8',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization',
                'bearer ' + sessionStorage.getItem(opts.tokenKey || 'access_token_W26API'));
            if (opts.data) {
                xhr.setRequestHeader('Params', encryptString(opts.data));
            }
        },
        success: opts.onSuccess,
        error:   opts.onError || function (xhr, status, err) {
            console.error('API error', opts.url, status, err);
        }
    };
    if (opts.data) ajaxOpts.data = opts.data;
    $.ajax(ajaxOpts);
}

// ─── render ───────────────────────────────────────────────────────────────────

function buildToggleRow(item) {
    var alertType   = item.alertType   || item.AlertType   || '';
    var displayName = item.displayName || item.DisplayName || alertType;
    var description = item.description || item.Description || '';
    var isEnabled   = (item.isEnabled  !== undefined) ? item.isEnabled  : item.IsEnabled;

    var meta = getMeta(alertType);

    var toggleId  = 'toggle_' + alertType;
    var statusId  = 'status_' + alertType;
    var checked   = isEnabled ? 'checked' : '';
    var statusTxt = isEnabled ? 'Enabled' : 'Disabled';
    var statusCls = isEnabled ? 'enabled'  : 'disabled';
    var desc      = description ? escapeHtml(description) : '&nbsp;';

    var disabledAttr  = canChangeTeamsAlertSettings ? '' : ' disabled';
    var readOnlyCls   = canChangeTeamsAlertSettings ? '' : ' read-only';
    var readOnlyTitle = canChangeTeamsAlertSettings
        ? ''
        : ' title="You do not have permission to change this setting."';

    return '<div class="alert-setting-row" data-alert-key="' + escapeHtml(alertType) + '">'
        + '<div class="alert-setting-icon ' + meta.color + '">'
        +   '<i class="fas ' + meta.icon + '"></i>'
        + '</div>'
        + '<div class="alert-setting-text">'
        +   '<p class="alert-setting-title">' + escapeHtml(displayName) + '</p>'
        +   '<p class="alert-setting-desc">'  + desc + '</p>'
        + '</div>'
        + '<span class="alert-setting-status ' + statusCls + '" id="' + statusId + '">'
        +   statusTxt
        + '</span>'
        + '<div class="alert-toggle-wrap' + readOnlyCls + '"' + readOnlyTitle + '>'
        +   '<input id="' + toggleId + '"'
        +   ' class="cmn-toggle cmn-toggle-round-flat alert-toggle"'
        +   ' type="checkbox"'
        +   ' data-alert-type="' + escapeHtml(alertType) + '"'
        +   ' data-alert-name="' + escapeHtml(displayName) + '"'
        +   disabledAttr
        +   ' ' + checked + ' />'
        +   '<label for="' + toggleId + '"></label>'
        + '</div>'
        + '</div>';
}

// ← THIS WAS MISSING — root cause of the blank render
function buildSection(sectionName, items) {
    var rowsHtml   = items.map(buildToggleRow).join('');
    var sectionKey = sectionName.replace(/[^a-zA-Z0-9]/g, '');
    return '<div class="alert-section" id="section_' + sectionKey + '">'
        + '<div class="alert-section-header">'
        +   '<span class="alert-section-title">' + escapeHtml(sectionName) + '</span>'
        +   '<span class="alert-section-line"></span>'
        + '</div>'
        + '<div class="alert-settings-card">' + rowsHtml + '</div>'
        + '</div>';
}

function renderAlertSettings(alertTypes) {
    var grouped = {};
    alertTypes.forEach(function (item) {
        var alertType = item.alertType || item.AlertType || '';
        var section   = getMeta(alertType).section;
        if (!grouped[section]) grouped[section] = [];
        grouped[section].push(item);
    });

    var orderedSections = SECTION_ORDER.filter(function (s) { return grouped[s]; });
    Object.keys(grouped).forEach(function (s) {
        if (orderedSections.indexOf(s) === -1) orderedSections.push(s);
    });

    var html = orderedSections.map(function (s) {
        return buildSection(s, grouped[s]);
    }).join('');

    document.getElementById('teamsAlertSettingsContainer').innerHTML = html;

    if (canChangeTeamsAlertSettings) {
        bindToggleEvents();
    }
}

function renderError() {
    document.getElementById('teamsAlertSettingsContainer').innerHTML =
        '<div style="padding:2rem;text-align:center;color:#6b7280;font-size:11px;">'
        + '<i class="fas fa-exclamation-circle" style="font-size:1.5rem;margin-bottom:8px;display:block;color:#d1d5db;"></i>'
        + 'Could not load alert settings. Please refresh the page.'
        + '</div>';
}

function renderSkeleton() {
    var skeletonRow =
        '<div class="alert-setting-row" style="gap:10px;">'
        + '<div style="width:32px;height:32px;border-radius:8px;background:#f0f0f0;flex-shrink:0;"></div>'
        + '<div style="flex:1;">'
        +   '<div style="height:10px;width:55%;background:#f0f0f0;border-radius:4px;margin-bottom:5px;"></div>'
        +   '<div style="height:8px;width:80%;background:#f5f5f5;border-radius:4px;"></div>'
        + '</div>'
        + '<div style="width:38px;height:20px;border-radius:10px;background:#f0f0f0;"></div>'
        + '</div>';

    var skeletonSection =
        '<div class="alert-section">'
        + '<div class="alert-section-header">'
        +   '<div style="height:8px;width:80px;background:#f0f0f0;border-radius:4px;"></div>'
        +   '<span class="alert-section-line"></span>'
        + '</div>'
        + '<div class="alert-settings-card">' + skeletonRow + skeletonRow + '</div>'
        + '</div>';

    document.getElementById('teamsAlertSettingsContainer').innerHTML =
        skeletonSection + skeletonSection;
}

// ─── API calls ────────────────────────────────────────────────────────────────

function loadTeamsAlertSettings() {
    renderSkeleton();

    callApi({
        url:      encodeURI(strUrl) + 'api/TeamsAlertSettings/GetSettings',
        tokenKey: 'access_token_W26API',
        onSuccess: function (response) {
            var alertTypes = Array.isArray(response)
                ? response
                : (response && Array.isArray(response.Data) ? response.Data : []);

            if (alertTypes.length === 0) {
                document.getElementById('teamsAlertSettingsContainer').innerHTML =
                    '<div style="padding:2rem;text-align:center;color:#9ca3af;font-size:11px;">'
                    + 'No alert types configured.'
                    + '</div>';
                return;
            }
            renderAlertSettings(alertTypes);
        },
        onError: function (err) {
            console.error('Failed to load Teams alert settings:', err);
            renderError();
            alertify.error('Could not load alert settings.');
        }
    });
}

function saveAlertTypeSetting(toggle) {
    if (!canChangeTeamsAlertSettings) {
        toggle.checked = !toggle.checked;
        alertify.error('You do not have permission to change alert settings.');
        return;
    }

    var alertType = toggle.getAttribute('data-alert-type');
    var displayName = toggle.getAttribute('data-alert-name') || alertType;
    var isEnabled = toggle.checked;
    var payload   = JSON.stringify({
        AlertType:  alertType,
        IsEnabled:  isEnabled,
        ModifiedBy: SessionEmployeeId
    });

    setToggleBusy(toggle, true);

    callApi({
        url:      encodeURI(strUrl) + 'api/TeamsAlertSettings/SetAlertTypeAccess',
        data:     payload,
        tokenKey: 'access_token_W26API',
        onSuccess: function (response) {
            setToggleBusy(toggle, false);

            var succeeded = response && (
                response.Status  === 'SUCCESS'
                || response.message
                || response.Message
            );

            if (succeeded) {
                updateStatusLabel(toggle);
                alertify.success(isEnabled
                    ? displayName + ' alerts enabled.'
                    : displayName + ' alerts disabled.');
            } else {
                toggle.checked = !isEnabled;
                updateStatusLabel(toggle);
                var errMsg = (response && (response.Data || response.data || response.message || response.Message))
                    || 'Failed to update setting.';
                alertify.error(errMsg);
            }
        },
        onError: function () {
            setToggleBusy(toggle, false);
            toggle.checked = !isEnabled;
            updateStatusLabel(toggle);
            alertify.error('Could not save setting. Please try again.');
        }
    });
}

// ─── helpers ──────────────────────────────────────────────────────────────────

function updateStatusLabel(toggle) {
    var statusEl = document.getElementById('status_' + toggle.getAttribute('data-alert-type'));
    if (!statusEl) return;
    if (toggle.checked) {
        statusEl.textContent = 'Enabled';
        statusEl.className   = 'alert-setting-status enabled';
    } else {
        statusEl.textContent = 'Disabled';
        statusEl.className   = 'alert-setting-status disabled';
    }
}

function setToggleBusy(toggle, busy) {
    toggle.disabled = busy;
    var row = toggle.closest('.alert-setting-row');
    if (!row) return;
    row.style.opacity       = busy ? '0.55' : '';
    row.style.pointerEvents = busy ? 'none'  : '';
    if (!busy && !canChangeTeamsAlertSettings) toggle.disabled = true;
}

function bindToggleEvents() {
    document.querySelectorAll('.alert-toggle').forEach(function (toggle) {
        toggle.removeEventListener('change', toggle._alertChangeHandler);
        toggle._alertChangeHandler = function () { saveAlertTypeSetting(toggle); };
        toggle.addEventListener('change', toggle._alertChangeHandler);
    });
}

function escapeHtml(str) {
    if (!str) return '';
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}

// ─── init ─────────────────────────────────────────────────────────────────────

$(document).ready(function () {
    loadTeamsAlertSettings();
});
</script>
</body>
</html>
