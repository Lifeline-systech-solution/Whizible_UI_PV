<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ReportUIBuilder.aspx.vb" Inherits="Whizible.PM_ReportUIBuilder" %>

<!DOCTYPE html>
<html lang="en">
    <%--added by Aditya J. on 24-03-2026--%>
    <%CommonFunctions.General.PlotPageHeadTag("Task Reports")%>
    <%--End of added by Aditya J. on 24-03-2026--%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_PageTitle") %></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <%--commented and added by Aditya J. on 24-03-2026--%>
    <!-- CSS Files -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--End of commented and added by Aditya J. on 24-03-2026--%>
    <style>
    :root{
      --bg:#f5f7fb;
      --card:#ffffff;
      --border:#e7edf6;
      --muted:#6b7280;
      --text:#111827;
      --primary:#2f6fed;
      --primary-2:#1e40af;

      --green:#16a34a;
      --green-bg:#eaf8ef;
      --green-border:#bfe8cb;

      --orange:#f59e0b;
      --orange-bg:#fff6e6;
      --orange-border:#ffe2a8;

      --blue:#2563eb;

      --shadow: 0 1px 0 rgba(15,23,42,.04);
      --radius: 12px;

      /* smaller fonts */
      --fs-12:12px;
      --fs-13:13px;
      --fs-14:14px;
      --fs-18:18px;
      --fs-22:22px;
    }

    *{ box-sizing:border-box; }

    html, body{
      background:#ffffff;
      color:var(--text);
      overflow-x: visible;
      overflow-y: auto;
    }
    .bgwhite{
        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
        font-family: "Roboto",sans-serif !important;
    }
    /* Top bar */
    .topbar{
      /*background:#e9eef5;*/
      border-bottom:1px solid var(--border);
      padding:12px 16px;
      position:sticky;
      top:0;
      z-index:1000;
      backdrop-filter: blur(4px);
    }
    .title{
      display:flex; align-items:center; gap:10px;
      font-weight:900;
      color:var(--primary-2);
      font-size:var(--fs-18);
      margin:0;
    }

    /* Chips */
    .chips-wrap{
      background:var(--card);
      border-bottom:1px solid var(--border);
      padding:10px 16px 10px;
      position:sticky;
      top:56px; /* sits under the topbar */
      z-index:900;
      box-shadow: 0 1px 0 rgba(15,23,42,.04);
    }
    .chips-label{
      font-size:var(--fs-12);
      color:var(--muted);
      font-weight:800;
      letter-spacing:.02em;
      margin-bottom:8px;
      /* text-transform:uppercase; */
    }
    .chips{
      display:flex;
      flex-wrap:wrap;
      gap:10px;
      align-items:center;
    }
    .chip{
      display:flex; align-items:center; gap:5px;
      border:1px solid var(--border);
      background:#fff;
      padding:6px 10px;
      border-radius:999px;
      /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
      font-size:11.5px;
      color:#334155;
      cursor:pointer;
      user-select:none;
      box-shadow: var(--shadow);
      white-space:nowrap;
    }
    .chip .dot{
      width:14px; height:14px;
      border-radius:50%;
      border:2px solid #9fc0ff;
      position:relative;
      background:#fff;
      flex:0 0 auto;
    }
    .chip.active{
      background:var(--primary-2);
      border-color:var(--primary-2);
      color:#fff;
    }
    .chip.active .dot{
      border-color:#cfe0ff;
      background:transparent;
    }
    .chip.active .dot:after{
      content:"";
      position:absolute;
      inset:3px;
      border-radius:50%;
      background:#fff;
    }

    /* Container */
    .container-fluid{
      padding:14px 16px 18px;
      max-width: 1600px;
    }

    .h1x{
      font-size: 16px;
    font-weight: 500;
    margin: 0;
    color: #2328ff;
    }
    .subtitle{
      color: #ffa016;
    font-size: 10.5px;
    margin-top: 1px;
    }

    /* Filters */
    /* .filters{
    display: grid;
    grid-template-columns: 1.05fr 0.95fr 0.95fr 1.15fr auto;
    gap: 15px;
    align-items: end;
    width: 100%;
    } */
    .filter-top{
    border: 1px solid #ddd;
    border-radius: 7px;
    padding: 6px;
    background: #fafafa;
     margin-top: 14px;
    }
    .Note{
          font-size: 10.7px;
    color: #f02929;
    }
    /* @media (max-width: 1200px){
      .filters{ grid-template-columns: 1fr 1fr; }
    } */

    .fblock label{
      font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
      font-weight:900;
      color:#6b7280;
      margin-bottom:6px;
      margin-Top:6px;
    }
    .form-select{
      height:38px;
      border-radius:10px;
      border:1px solid var(--border);
      box-shadow:none;
      font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
      background:#fff;
    }

    .btn-show{
      height:38px;
      border-radius:10px;
      background:var(--primary);
      border:1px solid var(--primary);
      color:#fff;
      font-weight:900;
      display:flex; align-items:center; gap:10px;
      justify-content:center;
      padding:0 14px;
      width:33%;
      font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
    }

    .export{
      display:flex;
      gap:10px;
      justify-content:flex-end;
      align-items:center;
      min-width:140px;
    }
    .btn-export{
      height:36px;
      border-radius:10px;
      padding:0 12px;
      border:1px solid var(--border);
      background:#fff;
      font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
      font-weight:600;
      display:flex; align-items:center; gap:8px;
      white-space:nowrap;
    }
    .btn-export.pdf{ color:#ef4444; background:#fff5f5; border-color:#ffd7d7; }
    .btn-export.excel{ color:#16a34a; background:#effcf3; border-color:#c9f0d4; }

    /* KPI (stays same on tab change) */
    .kpis{
      margin-top: 12px;
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 10px;
    width: 93%;
    }
    @media (max-width: 1200px){ .kpis{ grid-template-columns: repeat(4, 1fr);
    width: 74%;} }
    @media (max-width: 650px){ .kpis{ grid-template-columns: 1fr;} }

    .kpi{
      background:var(--card);
      border:1px solid var(--border);
      border-radius:var(--radius);
      padding:12px;
      display:flex;
      align-items:flex-start;
      justify-content:space-between;
      align-items:stretch;
      box-shadow: var(--shadow);
      min-height:72px;
    }
    .k-title{
        font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        font-weight:600;
        color:#6b7280;
        min-height:34px;       /* 🔥 KEY FIX */
        line-height:1.2;
        display:flex;
        align-items:center;   /* centers text inside reserved space */
    }
    .k-value{
        font-size:15px;
        font-weight:600;
        line-height:1.1;
        margin-top:2px;
    }
    .kpi > div:first-child{
        display:flex;
        flex-direction:column;
        justify-content:flex-start;
    }
    .k-value.blue{ color:var(--blue); }
    .k-value.orange{ color:var(--orange); }
    .k-value.green{ color:var(--green); }
    .kicon{
      width:30px; height:30px;
      border-radius:10px;
      display:flex; align-items:center; justify-content:center;
      border:1px solid var(--border);
      background:#f7fbff;
      color:#3b82f6;
      flex:0 0 auto;
      font-size:12px;
    }
    .kicon.orange{ background:var(--orange-bg); border-color:var(--orange-border); color:var(--orange); }
    .kicon.green{ background:var(--green-bg); border-color:var(--green-border); color:var(--green); }

    /* Main layout */
    .main{
      margin-top:12px;
      display:grid;
      grid-template-columns: 3fr 1fr;
      gap:12px;
      align-items:start;
      width:100%;
    }
    @media (max-width: 1100px){
      .main{ grid-template-columns: 3fr 1fr;
    
      }
       .main1{
           margin-top:-110px ;
       }
    }
/*    margin-top:-82px ;*/
    .cardx{
      background:var(--card);
      border:1px solid var(--border);
      border-radius:var(--radius);
      box-shadow: var(--shadow);
      margin-bottom: 10px;
      position: relative;
      overflow: visible;
      z-index: 5;
    }
    .red {
    color: #ef4444 !important;
}
    /* Table – ✅ NO horizontal scroll (page + table) */
    .table-responsive{
      overflow: visible !important;
    }
    table.table{
      width:100%;
      table-layout:fixed;
      margin:0;
    }
    .table thead th{
      background:#f6f9ff;
      border-bottom:1px solid var(--border);
      color:#6b7280;
      font-size:11.5px;
      /* Modified By Madhuri.K On 31-03-2026 */
      font-weight:600;
      padding:4px 4px;
      white-space:normal !important;
      word-break: break-word;
      text-overflow: unset !important;
      line-height: 1.2;
      vertical-align: middle;
    }
    .table td{
      /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size:11.5px;
      padding:4px 4px;
      border-bottom:1px solid var(--border);
      vertical-align:middle;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
    .table td.tooltip-cell:hover{
  overflow:visible; /* ✅ allow tooltip ONLY on hover */
}
    /* ===== TOOLTIP VISIBILITY FIX ===== */
/* Inner text wrapper for ellipsis */
.tooltip-text{
    display: block;
    max-width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.cardx{
    overflow: visible; /* allow tooltip to escape card */
}

.table-responsive{
    overflow: visible !important; /* allow tooltip to float */
}

    /* Column widths stay within 100% */
    .col-resource{ width:18%; }
    .col-task{ width:26%; }
    .col-status{ width:12%; }
    .col-start{ width:8%; }
    .col-end{ width:8%; }
    .col-astart{ width:10%; }
    .col-aend{ width:10%; }
    .col-var{ width:8%; }

    .resource{
      display:flex; align-items:center; gap:10px;
      min-width:0;
    }
    .resource strong{
      display:block;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
    }
    .avatar{
      width:28px; height:28px;
      border-radius:50%;
      background:#eef4ff;
      border:1px solid #d9e7ff;
      display:flex; align-items:center; justify-content:center;
      color:#2f6fed;
      font-size:12px;
      flex:0 0 auto;
    }
    .bg-green {
    background-color: #d4edda !important;   /* light green */
    color: #155724;              /* dark green text */
    font-weight: 600;
}

.bg-red {
    background-color: #f8d7da !important;   /* light red */
    color: #721c24;              /* dark red text */
    font-weight: 600;
}
/* Added by Aditya J. on 24-03-2026 for variance text color fix in task table */
#taskTbody td.bg-green,
#taskTbody td.bg-red {
    color: #000 !important;
}
/* End of Added by Aditya J. on 24-03-2026 for variance text color fix in task table */
   /* ===== TOOLTIP LEFT SIDE ===== */

.tooltip-cell{
    position: relative;
    cursor: pointer;
    overflow: hidden;
}

/* Tooltip bubble */
.tooltip-cell::after{
    content: attr(data-tooltip);
    position: absolute;

    left: 105%;                 /* 🔥 move to left side */
    top: 50%;                    /* vertical center */
    transform: translateY(-50%); /* center align */

    background: #000;
    color: #fff;
    padding: 8px 10px;
    font-size: 11px;
    border-radius: 6px;

    min-width: 200px;
    max-width: 420px;

    white-space: normal;
    word-break: break-word;

    opacity: 0;
    visibility: hidden;
    transition: opacity .15s ease;
    z-index: 99999;
    pointer-events: none;
}

/* Arrow (pointing right) */
.tooltip-cell::before{
    content:"";
    position:absolute;

    left: 95%;          /* slightly inside */
    top: 50%;
    transform: translateY(-50%);

    border-width:6px;
    border-style:solid;
    border-color: transparent transparent transparent #000; /* 🔥 arrow pointing right */

    opacity:0;
    visibility:hidden;
    z-index:99999;
}

.tooltip-cell:hover::after,
.tooltip-cell:hover::before{
    opacity:0.8;
    visibility:visible;
}


    .status{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding:4px 10px;
      border-radius:999px;
      font-size:12px;
      font-weight:600;
      border:1px solid var(--green-border);
      background:var(--green-bg);
      color:var(--green);
    }
    .status .s-dot{
      width:8px; height:8px; border-radius:50%;
      background:var(--green);
    }
    /* .linkdate{
      color:var(--blue);
      font-weight:900;
      text-decoration:none;
    } */
    .variance{
      color:var(--green);
      font-weight:900;
    }

    .table-footer{
      display:flex;
      justify-content:space-between;
      align-items:center;
      padding:10px 12px;
      color:var(--muted);
      font-size:12px;
      background:#fff;
    }
    .pager{ display:flex; align-items:center; gap:10px; }
    .pager-btn{
      width:28px; height:28px;
      border-radius:10px;
      border:1px solid var(--border);
      background:#fff;
      display:flex; align-items:center; justify-content:center;
      cursor:pointer;
      color:#334155;
      font-size:12px;
    }
    canvas {
        pointer-events: auto;
    }
    /* Charts (always show 3 charts on right) */
    .chart-head{
      padding:5px 9px;
      border-bottom:1px solid var(--border);
      background:#fff;
    }
    .chart-title{
      font-size:12px !important;
      font-weight:500;
      margin:0;
    }
    .chart-sub{
      font-size:12px;
      color:var(--muted);
      margin:4px 0 0;
    }
    .chart-body{ padding:10px 12px 12px; height:280px; }

    .legend{
      width:100%;
      display:grid;
      grid-template-columns: 1fr 1fr;
      gap:6px 10px;
      margin-top:6px;
      font-size:12px;
      color:#334155;
      pointer-events: none;
    }

    .l-item{ display:flex; align-items:center; gap:8px; min-width:0; }
    .swatch{ width:9px; height:9px; border-radius:50%; background:#999; flex:0 0 auto; }

    /* smaller graph size */
    .canvas-sm{ width:100% !important; height:100% !important; }
    .canvas-md{ width:100% !important; height:100% !important; }
    .card_1{background: #eff4ff}
    .card_2{background: #ffeffa}
    .card_3{background: #fff9ef}
    .card_4{background: #effff2}
  
    /* Loader overlay — matches PM_ProjectProfitability */
    .loader-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        width: 100%;
        height: 100%;
        background-color: transparent;
        z-index: 2000;
    }

    /* Centered loader GIF inside overlay */
    .loader-overlay .loader {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 100px;
        height: 100px;
        margin: -50px 0 0 -50px;
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    }
</style>
</head>
<body class="bgwhite">
     <% If Not m_blnViewAccess Then %>
    <div id="unauthorizedMessage" style="height: 448px">
    <div style="text-align:center; width:100%;">
        <p style="margin-top:136px; font-weight:700;">
            You are not authorized to view this record.
        </p>
    </div>
</div>
    <%Else %>

  <!-- TOP BAR -->
  <div class="graybg topbar">
    <h1 class="title"><i class="fas fa-file-alt"></i>Tasks Reports</h1>
  </div>
<!-- Page Loader — matches PM_ProjectProfitability style -->
<div class="loader-overlay" id="pageLoader" style="display: none;">
    <div class="loader"></div>
</div>
  <!-- spacer for fixed topbar to avoid layout jump -->
  <div id="topbar-spacer" style="display:none; height:0; width:100%;"></div>

  <!-- REPORT TYPE -->
  <div class="chips-wrap">
    <div class="chips-label">Select Report Type</div>
    <div class="chips" id="chips">
      <div class="chip active" data-type="completed"><span class="dot"></span>Completed Tasks</div>
      <div class="chip" data-type="critical"><span class="dot"></span>Critical Tasks</div>
      <div class="chip" data-type="overallocation"><span class="dot"></span>Overallocated Resources</div>
      <div class="chip" data-type="shouldStart"><span class="dot"></span>Should Have Started Tasks</div>
      <div class="chip" data-type="inProgress"><span class="dot"></span>Total Tasks In Progress</div>
      <div class="chip" data-type="todo"><span class="dot"></span>To Do List</div>
      <div class="chip" data-type="slipping"><span class="dot"></span>Slipping Tasks</div>
      <div class="chip" data-type="unstarted"><span class="dot"></span>Unstarted Tasks</div>
      <div class="chip" data-type="awd"><span class="dot"></span>Actual Work Distribution By Task Type By Resources</div>
      <div class="chip" data-type="wdw"><span class="dot"></span>Who Does What</div>
      <div class="chip" data-type="wdww"><span class="dot"></span>Who Does What When</div>
      <div class="chip" data-type="progress"><span class="dot"></span>Task Progress Report</div>
      <div class="chip" data-type="type"><span class="dot"></span>Task Type Report</div>
    </div>
  </div>

  <!-- spacer for fixed chips to avoid layout jump -->
  <div id="chips-spacer" style="display:none; height:0; width:100%;"></div>

  <div class="container-fluid">
    <!-- ✅ Header that changes on tab click -->
    <div>
      <div class="h1x" id="pageHeaderTitle">Completed Tasks</div>
      <div class="subtitle" id="pageHeaderSub">This report gives you list of all tasks whose status is marked completed for selected Period, for a project chosen by you. It gives details of each task like Start Date, End Date, Work in hours, Duration in days as well as Actual Start &amp; End Date, Actual Work in hours, Actual Duration in days and Variance for Efforts and Duration.</div>
    </div>

    <!-- FILTERS (unchanged on tab click) -->
    <div class="row filter-top" >
      <div class="col-12 col-md-12 col-lg-12">
      <div class="filters row">
<div class="fblock col-sm-3" data-filter="project">
  <label>Project</label>
  <div class="bs-wrapper">
    <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false'",,,) %>
</div>
</div>

<div class="fblock col-sm-3" data-filter="period">
  <label>Periods</label>
  <select id="cboPeriod" class="selectpicker" data-live-search="true" data-dropup-auto="false">
    <option value="0">All Periods</option>
  </select>
</div>
<div class="fblock col-sm-3" data-filter="startDate">
    <label for="txtStartDate"><%= MyBase.GetResourceString("C_StartDate") %></label>
<div class="input-group ev-date-input-wrapper">
    <% CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
    <span class="input-group-btn">
        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
    </span>
</div>
</div>
<div class="fblock col-sm-3" data-filter="endDate">
    <label for="txtEndDate"><%= MyBase.GetResourceString("C_EndDate") %></label>
<div class="input-group ev-date-input-wrapper">
    <% CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
    <span class="input-group-btn">
        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
    </span>
</div>
</div>
<div class="fblock col-sm-3" data-filter="shouldstarted">
    <label class="ev-filter-label">Should Have Started By</label>
<div class="input-group ev-date-input-wrapper">
    <% CommonFunctions.HTMLControls.DrawTextBox("txtShouldstarted", "txtShouldstarted", "form-control", , ,,,, ,,,, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
    <span class="input-group-btn">
        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
    </span>
</div>
</div>
<div class="fblock col-sm-3" data-filter="resource">
  <label>Resources</label>
  <select id="cboResource" class="selectpicker" data-live-search="true" data-dropup-auto="false">
    <option value="0">All Resources</option>
  </select>
</div>

<div class="fblock col-sm-3" data-filter="taskType">
  <label>Task Type</label>
  <select class="selectpicker">
    <option selected>All Task Types</option>
  </select>
</div>

<div class="fblock col-sm-3" data-filter="taskView">
  <label>Task View</label>
  <select class="selectpicker">
    <option selected>All Task View</option>
  </select>
</div>

<div class="fblock col-sm-3" data-filter="whichTask">
  <label>Which Task</label>
  <select class="selectpicker">
    <option selected>All Which Task</option>
  </select>
</div>

          <%--Added by Aditya J. on 17-02-2026 for Task Status dropdown--%>
          <div class="fblock col-sm-3" data-filter="TaskStatus">
              <label>Task Status</label>
              <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskStatusDrpdwn", "usp_Whizible2_Sel_TaskStatus ",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false'",,,) %>
        </div>
          <%--End of Added by Aditya J. on 17-02-2026 for Task Status dropdown--%>

          <%--Added by Aditya J. on 17-02-2026 for Show Rollup MPP Tasks checkbox--%>
          <div class="fblock col-sm-3" data-filter="ShowRollupMPPTasks">
            <label>
                <input type="checkbox" id="chkShowRollupMPPTasks" />
                Show Rollup MPP Tasks
            </label>
        </div>
          <%--End of Added by Aditya J. on 17-02-2026 for Show Rollup MPP Tasks checkbox--%>
          <div class="fblock col-sm-3" data-filter="TaskViewStatus">
              <label>Status</label>
              <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskViewStatusDrpdwn", "usp_Whizible2_Sel_TaskView_RPT_Status ",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false'",,,) %>
        </div>

          <div class="fblock col-sm-3" data-filter="TaskViewResName">
              <label>Resource Name</label>
              <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskViewResNameDrpdwn", "usp_Whizible2_Sel_TaskView_RPT_Resources " & Session("intProjectID"),,, "class='selectpicker' data-live-search='true' data-dropup-auto='false'",,,) %>
        </div>

          <div class="fblock col-sm-3" data-filter="TaskViewWhichTask">
              <label>Which Task</label>
              <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskViewWhichTaskDrpdwn", "usp_Whizible2_Sel_TaskView_RPT_WhichTask ",,, "class='selectpicker' data-live-search='true' data-dropup-auto='false'",,,) %>
        </div>
      <div class="filters row align-items-end">

  <!-- EXPORT: push to extreme right -->
  <div class="export col-sm-3 mt-3 pt-1 ms-auto d-flex justify-content-end">
    <button class="btn btn-export pdf me-2">
      <i class="fas fa-file-pdf"></i>PDF
    </button>
    <button class="btn btn-export excel">
      <i class="fas fa-file-excel"></i>EXCEL
    </button>
  </div>

</div>

       </div>
      </div>
      
      <div class="col-12 col-md-12 col-lg-12">
      <span class="Note"><i class="fas fa-info-circle"></i> Note: If period is not mentioned then Project Start Date and End Date is considered.</span>
    </div>
    </div>

    <!-- KPI (unchanged on tab click) -->
    <div class="kpis">
      <div class="kpi card_1">
        <div>
          <div class="k-title">Total Completed Tasks</div>
          <div class="k-value blue" id="kpiTotalTasks">00/00</div>
        </div>
        <div class="kicon"><i class="fas fa-check-circle"></i></div>
      </div>

      <div class="kpi card_2">
        <div>
          <div class="k-title">Average Delay (Days)</div>
          <div class="k-value blue" id="kpiAvgDelay">00</div>
        </div>
        <div class="kicon"><i class="fas fa-clock"></i></div>
      </div>

      <div class="kpi card_3">
        <div>
          <div class="k-title">Average Effort Overrun (%)</div>
          <div class="k-value" id="kpiEffortOverrun">00%</div>
        </div>
        <div class="kicon orange" id="kpiEffortIcon"><i class="fas fa-arrow-up"></i></div>
      </div>

      <div class="kpi card_4">
        <div>
          <div class="k-title">% Tasks Completed on or Before Planned End Date</div>
          <div class="k-value" id="kpiOnTime">00%</div>
        </div>
        <div class="kicon green" id="kpiOnTimeIcon"><i class="fas fa-bullseye"></i></div>
      </div>
    </div>

    <!-- MAIN -->
    <div class="main">
      <!-- TABLE (✅ only table changes on chip click) -->
      <div class="cardx">
        <div class="table-responsive">
          <table class="table align-middle" id="taskTable">
            <thead>
                <tr>
                    <th><%= MyBase.GetResourceString("C_TableHeaderResourceName") %></th>
                    <th><%= MyBase.GetResourceString("C_TableHeaderTaskName") %></th>
                    <th>Task Type</th>
                    <th><%= MyBase.GetResourceString("C_TableHeaderStartDate") %></th>
                    <th><%= MyBase.GetResourceString("C_TableHeaderEndDate") %></th>
                    <th>Work (hh:mm)</th>
                    <th><%= MyBase.GetResourceString("C_TableHeaderActualStartDate") %></th>
                    <th><%= MyBase.GetResourceString("C_TableHeaderActualEndDate") %></th>
                    <th>Actual Work (hh:mm)</th>
                    <th>% Effort Varinace</th>
                    <th>% Schedule Varinace</th>
                </tr>
            </thead>
            <tbody id="taskTbody"></tbody>
          </table>
        </div>

        <div class="table-footer">
          <div>Total: <strong id="totalRecords">0</strong> records</div>
          <div class="pager">
<div class="pager-btn" onclick="goToPreviousPage()">
    <i class="fas fa-angle-double-left"></i>
</div>

<div id="pageText">1 / 1</div>

<div class="pager-btn" onclick="goToNextPage()">
   <i class="fas fa-angle-double-right"></i>
</div>

          </div>
        </div>
      </div>

      <!-- RIGHT CHARTS (✅ always show 3 charts, Chart.js only) -->
      <div class="main1"style="">
        <div class="cardx">
          <div class="chart-head">
            <p class="chart-title">Top 5 Resources - Total vs Completed Tasks</p>
            <!-- <p class="chart-sub">Completed tasks distribution</p> -->
          </div>
          <div class="chart-body">
            <canvas id="donutChart" class="canvas-sm"></canvas>
          </div>
        </div>

        <div class="cardx mt-10">
          <div class="chart-head">
            <p class="chart-title">Top 5 Resources - Total vs Overrun Tasks</p>
            <!-- <p class="chart-sub">Overrun tasks overview</p> -->
          </div>
          <div class="chart-body">
            <canvas id="barChart" class="canvas-md"></canvas>
          </div>
        </div>

        <div class="cardx mt-10">
          <div class="chart-head">
            <p class="chart-title">Top 5 Resources - Schedule Variance</p>
            <!-- <p class="chart-sub">Variance trend</p> -->
          </div>
          <div class="chart-body">
            <canvas id="lineChart" class="canvas-md"></canvas>
          </div>
        </div>
      </div>
    </div>
  </div>
<%End If %>
  <!-- Local JS (Whizible) -->
    <%--commented by Aditya J. on 24-03-2026--%>
  <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
  <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
  <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
  <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
  <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
  <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
  <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
  <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
 <%--<script src="../../General/CommonValidations.js"></script>--%>
    <%--End of commented by Aditya J. on 24-03-2026--%>

  <script>
      var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
      var directory = '<%=System.Configuration.ConfigurationManager.AppSettings("VirtualDirectoryName").ToString%>';
      var currentPage = 1;
      var pageSize = 10;   // adjust if needed
      var totalRecords = 0;
      const tableState = {
          data: [],
          page: 1,
          size: 10
      };
      // Fallback if web.config setting is not available
      if (!strUrl || strUrl === '' || strUrl === 'undefined') {
          // Try to detect the current host and use it
          var currentHost = window.location.protocol + '//' + window.location.host;
          // If API is on a different port, you may need to adjust this
          // For development, API might be on localhost:5095 or similar
          strUrl = currentHost + '/';
      }

      // Ensure trailing slash
      if (strUrl && !strUrl.endsWith('/')) {
          strUrl += '/';
      }

      // Use W26API base URL - remove trailing slash for API calls
      var baseUrl = strUrl || window.location.origin;
      if (baseUrl.endsWith('/')) {
          baseUrl = baseUrl.slice(0, -1);
      }

      // Helper function to get authentication token
      function getAuthToken() {
          return sessionStorage.getItem("access_token_W26API") || '';
      }

      // Helper function to get AJAX headers with authentication
      function getAjaxHeaders() {
          var token = getAuthToken();
          return {
              'Content-Type': 'application/json',
              'Authorization': token ? 'bearer ' + token : ''
          };
      }

      // Helper function to get URL parameter by name
      function getURLParameter(name) {
          name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
          var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
          var results = regex.exec(location.search);
          return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
      }

      function configureAlertify() {
          if (typeof alertify !== 'undefined') {
              alertify.set('notifier', 'position', 'top-right');
              // Optional: Set delay for auto-dismiss (in seconds)
              alertify.set('notifier', 'delay', 5);

              // Suppress success messages
              alertify.success = function (message) {
                  // Suppress success messages - do nothing
                  return alertify;
              };
          } else {
              // Retry if alertify not loaded yet
              setTimeout(configureAlertify, 100);
          }
      }

      // Configure immediately if available, otherwise wait for DOM
      if (document.readyState === 'loading') {
          document.addEventListener('DOMContentLoaded', configureAlertify);
      } else {
          configureAlertify();
      }

      /* -------------------------
        1) HEADER TEXT CHANGE ON TAB CLICK
        - Only updates: Title + Subtitle + Table data
        - Does NOT change KPI/Filters/Charts
      --------------------------*/
      const headerMap = {
          completed: { title: "Completed Tasks", sub: "(This report gives you list of all tasks whose status is marked completed for selected Period, for a project chosen by you. It gives details of each task like Start Date, End Date, Work in hours, Duration in days as well as Actual Start & End Date, Actual Work in hours, Actual Duration in days and Variance for Efforts and Duration.)" },
          critical: { title: "Critical Tasks", sub: "(This report gives you list of all tasks that are marked critical, in the project chosen by you. It gives details of each task along with Start & End Date, Work in hours, Duration in days,Actual Start Date,End Date,Actual Work, Actual Duration and Variance for Duration and Effort. Note:- 1) This Report shows only MPP Tasks. 2) If period is not mentioned then Project Start Date and End Date is considered.)" },
          overallocation: { title: "Overallocated Resources", sub: "(This report gives you list of all resources that are overallocated, in the project chosen by you. In the Configuration module Administrator specifies the number of hours per day for the organisation. A resource is said to be overallocated if he/she is assigned tasks that require more hours than specified in the system per day. It gives details of all such resources and the tasks assigned to them for which they are overbooked along with Start End Date, Work in hours,Actual Duration,Capacity(OU working Hrs * Duration),Diiference between Planned Work and Capacity.)" },
          shouldStart: { title: "Should Have Started Tasks", sub: "(This report gives you all task that should have started, before the date specified by you in a project chosed by you. It gives details of all such the tasks along with Task Name & Resource name to whom the task is assigned, Start & End Date, Work in hours, Baseline Work,Baseline Start Date,End Date and Start Variance in days.)" },
          inProgress: { title: "Total Tasks In Progress", sub: "(This report gives you all task that are in progress, to date, in a project chosen by you. It gives details of all such the tasks along with Task Name & Resource name to whom the task is assigned, Start & End Date, Work in hours,Actual Start Date,Actual Work and Remaining work. Note:-If period is not mentioned then Project Start Date and End Date is considered.)" },
          todo: { title: "To Do List", sub: "This report gives you to do list for all resources (unless specific resource is selected)for a project chosen by you. You can specify the time period as well. It gives details of each task like Start & End Date, Work in hours, Duration in days , Actual Start , Actual Work in hours, Actual Duration in days. Note:- 1) This Report does not consider the General Tasks." },
          slipping: { title: "Slipping Tasks", sub: "This report gives you all task that are not on schedule for the project chosen by you.The Slipping Tasks are the tasks for which either the start is delayed or the end is delayed or the tasks those are not started or the tasks for which the actual work is greater than the baseline work. Note:This report may vary from the report obtained from Microsoft Project due to the following reasons: 1. Assigned tasks, Issue tasks, MPP tasks are considered in this report and 2. There could be a mismatch between the number of working days/hours specified in the Microsoft Project Plan and the number of working days/hours specified in Corporate Settings." },
          unstarted: { title: "Unstarted Tasks", sub: "This report gives you report of all tasks that have not started at all for a project chosen by you." },
          awd: { title: "Actual Work Distribution By Task Type By Resources", sub: "This report gives the details of efforts taken for the project chosen by you grouped by resource and task type." },
          wdw: { title: "Who Does What", sub: "The Who Does What report shows the resources and their tasks along with the start & end date and work grouped by resources and Assigned Tasks/MPP Tasks/Issue Tasks for the project and time period specified. Note:This report may vary from the report obtained from Microsoft Project due to the following reasons: 1. Assigned Tasks, Issue Tasks, MPP Tasks are considered in this report and 2. There could be a mismatch between the number of working days specified in the Microsoft Project Plan and the number of working days specified in Corporate settings." },
          wdww: { title: "Who Does What When", sub: "The report depicts the work (hrs) for the next 15 days from the date specified against each task for the resource. Note:This report may vary from the report obtained from Microsoft Project due to the following reasons: 1. Assigned Tasks, Issue Tasks, MPP Tasks are considered in this report and 2. There could be a mismatch between the number of working days specified in the Microsoft Project Plan and the number of working days specified in Corporate settings. 3. “Work” is evenly distributed over the period of Start Date to End Date." },
          progress: { title: "Task Progress Report", sub: "Note: Our recommended report format is PDF. Other formats do work in most of the reports, but in some cases output format may not be as good as PDF. This is due to inherent reporting engine problems, which are beyond our control. If you desire we can disable other output formats in your configuration." },
          type: { title: "Task Type Report", sub: "This report shows the Task variance (against baseline work) grouped by task type for all resources allocated for the Project chosen by you for the specified period.All Assigned tasks, Issue Tasks, MPP Tasks have been considered." }
      };
      var isResettingTaskStatus = false;
      const reportFilterMap = {
          completed: ["project", "period", "resource" ],
          critical: ["project", "period", "resource" ],
          overallocation: ["project", "period", "resource" ],
          shouldStart: ["project", "shouldstarted", "resource" ],
          inProgress: ["project", "period", "resource" ],
          todo: ["project", "startDate", "endDate", "resource" ],
          slipping: ["project" ],
          unstarted: ["project", "period", "resource" ],
          awd: ["project", "startDate", "endDate" ],
          wdw: ["project", "startDate", "endDate", "resource" ],
          wdww: ["project", "startDate" ],
          progress: ["project", "period", "TaskStatus", "ShowRollupMPPTasks" ],
          type: ["project", "period" ]
      };

      Chart.register({
          id: 'noDataPlugin',
          afterDraw(chart) {
              const datasets = chart.data.datasets || [];
              const hasData = datasets.some(ds =>
                  Array.isArray(ds.data) && ds.data.some(v => v > 0)
              );

              if (hasData) return;

              const { ctx, chartArea } = chart;
              if (!chartArea) return;

              ctx.save();
              ctx.textAlign = 'center';
              ctx.textBaseline = 'middle';
              ctx.font = '12px Arial';
              ctx.fillStyle = '#9ca3af';

              ctx.fillText(
                  'No data available',
                  (chartArea.left + chartArea.right) / 2,
                  (chartArea.top + chartArea.bottom) / 2
              );

              ctx.restore();
          }
      });

      var chartInstances = {
          chart1: null,
          chart2: null,
          chart3: null
      };

      var chartInitialized = false;

      function resetHiddenFilters(allowedFilters) {
          document.querySelectorAll(".fblock").forEach(block => {
              const filterName = block.dataset.filter;
              if (!allowedFilters.includes(filterName)) {
                  const select = block.querySelector('select');
                  if (select) {
                      select.selectedIndex = 0;
                      $(select).selectpicker('refresh');
                  }
              }
          });
      }

      function applyFilters(type) {
          const allowedFilters = reportFilterMap[type] || [];

          document.querySelectorAll(".fblock").forEach(block => {
              const filterName = block.dataset.filter;
              block.style.display = allowedFilters.includes(filterName)
                  ? "block"
                  : "none";
          });

          // Refresh bootstrap-select AFTER visibility change
          $('.selectpicker').selectpicker('refresh');
      }

      $('#cboProject').on('changed.bs.select', function () {
           resetTaskStatusDropdown();
           const chip = document.querySelector('.chip.active');
    if (chip) {
        const type = chip.getAttribute('data-type');
        resetPeriodByReportType(type);
    }
          ProjectonChange(true);
      });
      $('#cboPeriod').on('changed.bs.select', function () {
          ProjectonChange(false);
      });
      $('#cboResource').on('changed.bs.select', function () {
          ProjectonChange(false);
      }); 
      $(document).on('changed.bs.select', '#cboTaskStatusDrpdwn', function () {

    if (isResettingTaskStatus) return;

    ProjectonChange(false);
});
      $('#chkShowRollupMPPTasks').on('change', function () {
          ProjectonChange(false);
      });

      function refreshSelectPicker($el) {
          if (!$.fn.selectpicker) return;

          // ❌ NEVER reinitialize
          if ($el.data('selectpicker')) {
              $el.selectpicker('refresh');
          }
      }
// Loader state — mirrors PM_ProjectProfitability logic
var loaderShown = false;
var loaderStartTime = 0;

function showLoader() {
    document.getElementById('pageLoader').style.display = 'block';
    loaderShown = true;
    loaderStartTime = Date.now();
}

function hideLoader() {
    if (!loaderShown) return;
    var elapsedTime = Date.now() - loaderStartTime;
    var minDisplayTime = 1500; // Minimum 1.5 seconds
    if (elapsedTime < minDisplayTime) {
        setTimeout(function() {
            document.getElementById('pageLoader').style.display = 'none';
            loaderShown = false;
        }, minDisplayTime - elapsedTime);
    } else {
        document.getElementById('pageLoader').style.display = 'none';
        loaderShown = false;
    }
}

$(document).ajaxStart(function () {
    showLoader();
});

$(document).ajaxStop(function () {
    hideLoader();
});
      $(document).ready(function () {
          $("#txtStartDate, #txtEndDate, #txtShouldstarted").datepicker({
              dateFormat: "dd/mm/yy",
              changeMonth: true,
              changeYear: true,
              showButtonPanel: true
          });
          $("#txtStartDate, #txtEndDate, #txtShouldstarted").on("change", function () {
              ProjectonChange(false);
          });

      });
      $('.btncalendar').on('click', function () {
          $(this).closest('.input-group')
              .find('input')
              .datepicker('show');
      });
      var sessionProjectID = '<%= Session("intProjectID") %>';
      function initializeProjectDropdownForSession() {
          // ✅ Get active chip safely
          const chip = document.querySelector('.chip.active');
          if (!chip) return;

          const type = chip.getAttribute('data-type');
          setPageHeader(type);
          applyFilters(type);
          var $project = $('#cboProject');
          const projectReset = forceProjectToSession();
          if (!projectReset) {
              
              return;
          }
          loadReportData();
          loadSelectedReportData(type);
          setTimeout(ProjectonChange, 50);
      }

      function parseDMY(dateStr) {
          var parts = dateStr.split('/');
          return new Date(parts[2], parts[1] - 1, parts[0]);
      }

      function validateStartEndDates(isRequired) {

          const start = $('#txtStartDate').val();
          const end = $('#txtEndDate').val();

          if (start && !end) {
              if (isRequired) {
                  alertify.error("End Date is required when Start Date is entered");
              }
              return false;
          }

          if (start && end) {
              var startDate = parseDMY(start);
              var endDate = parseDMY(end);

              if (endDate < startDate) {
                  alertify.error("End Date cannot be smaller than Start Date");
                  return false;
              }
          }

          return true;
      }


      function loadPeriodsForProject(projectID) {
          const chip = document.querySelector('.chip.active');
          if (!chip) return;

          const type = chip.getAttribute('data-type');
          var $period = $('#cboPeriod');
          if (!projectID) return $.Deferred().resolve();

          return $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetAllFilterDropdowns',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify({
                  ProjectID: parseInt(projectID),
                  GetPeriods: true
              })
          }).done(function (res) {

              var data = res?.data?.periods || res?.periods || [];

              if(type === "type" || type === "progress"){
                // Reset Periods
                $period.empty();
                
              }else{
                $period.empty()
                .append('<option value="0">All Periods</option>');
              }
              
              data.forEach(p => {
                  $period.append(`<option value="${p.id}">${p.name}</option>`);
              });

              refreshSelectPicker($period);
          });
      }

      function loadResourcesForProject(projectID) {

          var $resource = $('#cboResource');
          if (!projectID) return $.Deferred().resolve();

          return $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetAllFilterDropdowns',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify({
                  ProjectID: parseInt(projectID),
                  GetResources: true
              })
          }).done(function (res) {

              var data = res?.data?.resources || res?.resources || [];

              $resource.empty()
                  .append('<option value="0">All Resources</option>');

              data.forEach(r => {
                  $resource.append(`<option value="${r.id}">${r.name}</option>`);
              });

              refreshSelectPicker($resource);
          });
      }

function resetTaskStatusDropdown() {

    var $taskStatus = $('#cboTaskStatusDrpdwn');
    if (!$taskStatus.length) return;

    isResettingTaskStatus = true;

    $taskStatus.selectpicker('val', '0');
    $taskStatus.selectpicker('refresh');

    isResettingTaskStatus = false;
}

      function resetDependentDropdowns() {
          const chip = document.querySelector('.chip.active');
          if (!chip) return;

          const type = chip.getAttribute('data-type');
          var $period = $('#cboPeriod');
          var $resource = $('#cboResource');
            // Reset Periods
            $period.empty()
            .append('<option value="0">All Periods</option>');
         
          refreshSelectPicker($period);

          // Reset Resources
          $resource.empty()
              .append('<option value="0">All Resources</option>');
          refreshSelectPicker($resource);
      }

      function ProjectonChange(isRequired = true) {
          var projectID = $('#cboProject').val();
          // ✅ When Select Project (0)
          if (!projectID || projectID === '0') {
              resetDependentDropdowns();
              // Optional: reset KPIs while loading
              resetKPIsToNA();

              // Load API data → calculateKPIs() is already called inside success
              loadReportData();
              var $tbody = $('#taskTbody');
              $tbody.empty();

              $tbody.append(`
              <tr>
                <td colspan="11" class="text-center">
                    <div class="col-12 text-center py-5">
<i class="fas fa-inbox fa-3x text-muted mb-3"></i>
<h6 class="text-muted">No data available</h6>
</div>
                </td>
              </tr>`);
              $('#totalRecords').text('0');
              $('#pageText').text('0 / 0');
              tableState.data = [];
              return;
          }
          const chip = document.querySelector('.chip.active');
          if (!chip) return;

          const type = chip.getAttribute('data-type');
          // ✅ Valid project
          if (isRequired) {
              loadPeriodsForProject(projectID);
              loadResourcesForProject(projectID);
          }

          // Optional: reset KPIs while loading
          resetKPIsToNA();
          
          // Load API data → calculateKPIs() is already called inside success
          loadReportData();
          if (type !== "wdww") {
              if (!validateStartEndDates(false)) return;
          }
          loadSelectedReportData(type);
      }

      function forceProjectToSession() {

          var $project = $('#cboProject');

          if (!sessionProjectID || sessionProjectID === '0') {
              setDefaultProject($project);
              return false;
          }

          // Check if dropdown contains session project
          var optionExists = $project.find("option[value='" + sessionProjectID + "']").length > 0;

          if (optionExists) {
              $project.val(sessionProjectID);

              if ($project.data('selectpicker')) {
                  $project.selectpicker('val', sessionProjectID);
              }
          } else {
              // If not exists → select default (0)
              setDefaultProject($project);
              return false;
          }

          return true;
      }

      function setDefaultProject($project) {
          $project.val('0');

          if ($project.data('selectpicker')) {
              $project.selectpicker('val', '0');
          }
      }


      function loadReportData() {
          var projectID = $('#cboProject').val();
          if (!projectID || projectID === '0') {
              // Reset KPIs
              resetKPIsToNA();

              initializeChart1();
              initializeChart2();
              initializeChart3();
              chartInitialized = true;
              updateChart1([], [], []);
              updateChart2([], [], []);
              updateChart3([], [], []);
              return;   // 🔒 HARD STOP
          }
          var requestData = {
              ReportID: 324,
              Parameters: {
                  ProjectID: parseInt(projectID)
              }
          };

          $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetCompletedTasksKPIs',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify(requestData),

              success: function (response) {

                  var dataArray = [];

                  if (!response) {
                      alertify.error('Invalid response from server');
                      return;
                  }
                  // 🔥 IMPORTANT: still render charts (empty)
                  calculateKPIs(response);
                  loadCharts(requestData);
              },

              error: function (xhr, status, error) {

                  var errorMessage = 'Error loading report data';

                  if (xhr.responseJSON) {
                      errorMessage =
                          xhr.responseJSON.message ||
                          xhr.responseJSON.error ||
                          xhr.responseJSON.Message ||
                          errorMessage;
                  }

                  alertify.error(errorMessage);

              }
          });
      }
      function validateMandatoryDates(type) {

    const start = $('#txtStartDate').val();
    const end = $('#txtEndDate').val();

    // awd & wdw → both dates required
    if (type === "awd" || type === "wdw") {

        if (!start || !end) {
            return false;
        }

        if (!validateStartEndDates(true)) return false;
    }

    // wdww → only start date required
    if (type === "wdww") {

        if (!start) {
            return false;
        }
    }

    return true;
}
      function loadSelectedReportData(type) {
          
          var projectID = $('#cboProject').val();
          if (!projectID || projectID === '0') {
              alertify.error('Please select a project');
              return;   // 🔒 HARD STOP
          }
          var reportID = 324;
          switch (type) {

              case "inProgress":
                  reportID = 325;
              break;
              case "critical":
                  reportID = 322;
                  break;
              case "todo":
                  reportID = 326;
                  break;
              case "slipping":
                  reportID = 333;
                  break;
              case "unstarted": 
                  reportID = 327;
                  break;
              case "shouldStart":
                  reportID = 332;
                  break;
              case "overallocation":
                  reportID = 328;
                  break;
              case "awd":
                  reportID = 607;
                  break;
              case "wdw":
                  reportID = 320;
                  break;
              case "wdww":
                  reportID = 336;
                  break;
              //Added by Aditya J. on 17-02-2026
              case "progress":
                  reportID = 996;
                  break;
              case "type":
                  reportID = 993;
                  break;
              //case "views":
              //    reportID =
              //        break;
              //End of Added by Aditya J. on 17-02-2026
              default: 
                  reportID = 324;
              break;
          }
          var period = $('#cboPeriod').val();
          var resourceID = $('#cboResource').val();
          var taskStatusID = $('#cboTaskStatusDrpdwn').val();
          var showRollupMPPTasks = $('#chkShowRollupMPPTasks').is(':checked');
          var requestData = {
              ReportID: reportID,
              Parameters: {
                  ProjectID: parseInt(projectID)
              }
          };
          // ✅ Add Period only if report supports it
const allowedFilters = reportFilterMap[type] || [];

if (allowedFilters.includes("period")) {

    if (period && period !== '' && period !== '0') {
        requestData.Parameters.Period = parseInt(period);
    }

    // Special case for type/progress (default period = 1)
    if ((type === "type" || type === "progress") &&
        (!period || period === '0')) {

        requestData.Parameters.Period = 1;
    }
}
if(allowedFilters.includes("resource")){
    if (resourceID && resourceID !== '' && resourceID !== '0') {
    requestData.Parameters.ResourceID = parseInt(resourceID);
}
}
          

          if (type === "todo" || type === "awd" || type === "wdw") {

              var startDate = convertToApiDate($('#txtStartDate').val());
              var endDate = convertToApiDate($('#txtEndDate').val());

              if (startDate) {
                  requestData.Parameters.dtmFrom = startDate;
              }

              if (endDate) {
                  requestData.Parameters.dtmTo = endDate;
              }
          }

          if (type === "wdww") {
              var startDate = convertToApiDate($('#txtStartDate').val());
              if (startDate) {
                  requestData.Parameters.dtmFrom = startDate;
              }
              else{
                  alertify.error("Please Enter Start Date.");
                  return;
              }
          }
          
          if (type === "shouldStart") {
              var selectedDate = $('#txtShouldstarted').datepicker("getDate");

              if (!selectedDate) {
                  selectedDate = new Date();
              }

              var formattedDate =
                  selectedDate.getFullYear() + "-" +
                  String(selectedDate.getMonth() + 1).padStart(2, '0') + "-" +
                  String(selectedDate.getDate()).padStart(2, '0');

              requestData.Parameters.dtmbydate = formattedDate;
          }

          //Added by Aditya J. on 17-02-2026
          if (type === "progress") {
              requestData.Parameters.TypeID = parseInt(taskStatusID);
              requestData.Parameters.ShowRollupMPPTasks = showRollupMPPTasks ? 1 : 0;
          }
          //End of Added by Aditya J. on 17-02-2026

          $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetReportData',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify(requestData),

              success: function (response) {

                  var dataArray = [];

                  if (!response) {
                      alertify.error('Invalid response from server');
                      return;
                  }

                  if (response.data) {
                      if (Array.isArray(response.data)) {
                          dataArray = response.data;
                      } else if (Array.isArray(response.data.Data)) {
                          dataArray = response.data.Data;
                      } else if (Array.isArray(response.data.data)) {
                          dataArray = response.data.data;
                      } else if (Array.isArray(response.data.ReportData)) {
                          dataArray = response.data.ReportData;
                      } else if (Array.isArray(response.data.slippingTaskEntity)){
                          dataArray = response.data.slippingTaskEntity;
                      }
                  } else if (Array.isArray(response.Data)) {
                      dataArray = response.Data;
                  } else if (Array.isArray(response)) {
                      dataArray = response;
                  }

                  if (!dataArray || dataArray.length === 0) {
                      tableState.data = [];
                      $('#totalRecords').text('0');
                      displayReportData(type);
                      return;
                  }

                  tableState.data = dataArray || [];
                  tableState.page = 1;

                  $('#totalRecords').text(tableState.data.length);

                  displayReportData(type);
              },

              error: function (xhr, status, error) {

                  var errorMessage = 'Error loading report data';

                  if (xhr.responseJSON) {
                      errorMessage =
                          xhr.responseJSON.message ||
                          xhr.responseJSON.error ||
                          xhr.responseJSON.Message ||
                          errorMessage;
                  }

                  alertify.error(errorMessage);

              }
          });
      }
      function convertToApiDate(dateStr) {
          if (!dateStr) return null;

          var parts = dateStr.split('/');
          if (parts.length !== 3) return null;

          return parts[2] + '-' + parts[1] + '-' + parts[0];
          // yyyy-MM-dd
      }

      function formatDate(dateVal) {
          if (!dateVal) return '-';
          var d = new Date(dateVal);
          if (isNaN(d)) return '-';
          return d.toLocaleDateString('en-GB'); // dd/mm/yyyy
      }

      function setTodayForShouldStart(resetValue = false) {

          const $input = $("#txtShouldstarted");

          if (!$input.length) return;

          const today = new Date();

          if (resetValue) {
              $input.datepicker("setDate", today);
          }
      }

      function setTodayForFromDate(resetValue = false) {

          const $input = $("#txtStartDate");
          if (!$input.length) return;

          const today = new Date();

          if (resetValue) {
              $input.datepicker("setDate", today);
          }
      }

      function setTodayForFromDateToDate(resetValue = false) {

          const $start = $("#txtStartDate");
          const $end = $("#txtEndDate");

          if (!$start.length || !$end.length) return;

          const today = new Date();

          if (resetValue) {
              $start.datepicker("setDate", today);
              $end.datepicker("setDate", today);
          }
      }

      function statusHtml(status) {
          if (!status) status = '-';

          if (status.toLowerCase() === 'completed') {
              return `
            <span class="status">
                <span class="s-dot"></span>${status}
            </span>`;
          }

          return `
        <span class="status" style="background:#f3f4f6;border-color:#e5e7eb;color:#334155;">
            <span class="s-dot" style="background:#64748b"></span>${status}
        </span>`;
      }

      function varianceStyle(val) {
          if (!val || val === 0) return '';
          if (parseFloat(val) < 0) return 'style="color:#ef4444;font-weight:900"';
          return 'class="variance"';
      }

      function displayReportData(type) {

          const reportData = tableState.data;
          const currentPage = tableState.page;
          const pageSize = tableState.size;

          var $tbody = $('#taskTbody');
          $tbody.empty();

          if (!reportData.length) {
              $tbody.append(`
            <tr>
                <td colspan="11" class="text-center">
                    <div class="col-12 text-center py-5">
<i class="fas fa-inbox fa-3x text-muted mb-3"></i>
<h6 class="text-muted">No data available</h6>
</div>
                </td>
            </tr>
          `);
              $('#pageText').text('0 / 0');
              return;
          }

          const start = (currentPage - 1) * pageSize;
          const end = Math.min(start + pageSize, reportData.length);
          const pageData = reportData.slice(start, end);
          
          pageData.forEach(task => {
              if (type === "slipping") {

                  if (!task.actualStartDate) {
                      ev = 0.00;
                      sv = 0.00;
                  } else {
                      ev = ((task.actualWork - task.work) / task.work) * 100;
                      ev = Math.round(ev * 100) / 100;

                      sv = ((task.duration - task.actualDuration) / task.duration) * 100;
                      sv = Math.round(sv * 100) / 100;
                  }

              } else {

                  if (!task.ActualStartDate) {
                      ev = 0.00;
                      sv = 0.00;
                  } else {
                      ev = ((task.ActualWork - task.Work) / task.Work) * 100;
                      ev = Math.round(ev * 100) / 100;

                      sv = ((task.Duration - task.ActualDuration) / task.Duration) * 100;
                      sv = Math.round(sv * 100) / 100;
                  }
              }
          

              var varianceClass = getVarianceBgClass(ev, sv);
              $tbody.append(
                  '<tr>' +
                  '<td class="tooltip-cell" data-tooltip="' +
                  (task.EmployeeName || task.ResourceName || task.employeeName || '-') + '">' +
                  // commented Added by Aditya J. on 24-03-2026 for resource name encoding fix
                  //'<span class="tooltip-text">👨‍💼 ' +
                  //(task.EmployeeName || task.ResourceName || task.employeeName || '-') +
                  //'</span>' +
                  '<span class="tooltip-text"><i class="fas fa-user me-1"></i>' +
                  (task.EmployeeName || task.ResourceName || task.employeeName || '-') +
                  '</span>' +
                  // End of commented and Added by Aditya J. on 24-03-2026 for resource name encoding fix
                  '</td>' +
                  '<td class="tooltip-cell" data-tooltip="' + (task.TaskName || task.taskName || '-') + '">' +
                  '<span class="tooltip-text">' + (task.TaskName || task.taskName || '-') + '</span>' +
                  '</td>' +
                  '<td class="tooltip-cell" data-tooltip="' + (task.TaskType || task.taskType || '-') + '">' +
                  '<span class="tooltip-text">' + (task.TaskType || task.taskType || '-') + '</span>' +
                  '</td>' +
                  '<td>' + formatDate(task.StartDate || task.startDate) + '</td>' +
                  '<td>' + formatDate(task.endDate ||task.EndDate) + '</td>' +
                  '<td>' + formatHoursToHHMM(task.work ||task.Work) + '</td>' +
                  '<td>' + formatDate(task.actualStartDate ||task.ActualStartDate) + '</td>' +
                  '<td>' + formatDate(task.actualEndDate ||task.ActualEndDate) + '</td>' +
                  '<td>' + formatHoursToHHMM(task.actualWork ||task.ActualWork || task.ActualHr) + '</td>' +
                  '<td class="' + varianceClass + '">' + (ev || 0) + '</td>' +
                  '<td class="' + varianceClass + '">' + (sv || 0) + '</td>' +
                  '</tr>'
              );
          });

          const totalPages = Math.ceil(reportData.length / pageSize);
          $('#pageText').text(`${currentPage} / ${totalPages}`);
      }

      function formatHoursToHHMM(hours) {
          if (!hours || isNaN(hours)) return "00:00";

          var totalMinutes = Math.round(hours * 60);  // convert decimal hours to minutes
          var hh = Math.floor(totalMinutes / 60);
          var mm = totalMinutes % 60;

          return String(hh).padStart(2, '0') + ":" +
              String(mm).padStart(2, '0');
      }

      function getVarianceBgClass(ev, sv) {
          ev = parseFloat(ev) || 0;
          sv = parseFloat(sv) || 0;

          if (ev < 0 && sv > 0) {
              return 'bg-green';
          }

          return 'bg-red';
      }

      function goToNextPage() {
          const chip = document.querySelector('.chip.active');
          if (!chip) return;

          const type = chip.getAttribute('data-type');
          const totalPages = Math.ceil(tableState.data.length / tableState.size);
          if (tableState.page < totalPages) {
              tableState.page++;
              displayReportData(type);
          }
      }

      function goToPreviousPage() {
          const chip = document.querySelector('.chip.active');
          if (!chip) return;

          const type = chip.getAttribute('data-type');
          if (tableState.page > 1) {
              tableState.page--;
              displayReportData(type);
          }
      }

      function calculateKPIs(kpiData) {

          if (!kpiData || kpiData.length === 0) {
              resetKPIsToNA();
              return;
          }

          let totalTasks = kpiData.totalTasks;
          let avgDelay = Math.round(kpiData.averageDelay * 100) / 100;
          let avgEffort = Math.round(kpiData.averageEffortOverrun * 100) / 100;
          let onTimePct =  Math.round(kpiData.percentOnTime * 100) / 100;
          /* ===== Values ===== */
          $('#kpiTotalTasks').text(totalTasks);
          $('#kpiAvgDelay').text(avgDelay);
          $('#kpiEffortOverrun').text(avgEffort + '%');
          $('#kpiOnTime').text(onTimePct + '%');
          
          /* ===== Colours ===== */

          $('#kpiEffortOverrun')
              .removeClass('green orange red')
              .addClass(
                  avgEffort > 0 ? 'red' :
                      avgEffort === 0 ? 'orange' :
                          'green'
              );

          var effortColor =
    avgEffort > 0 ? 'red' :
        avgEffort === 0 ? 'orange' :
            'green';

$('#kpiEffortIcon')
    .removeClass('green orange red')
    .addClass(effortColor);

// 🔥 Change arrow direction
var $effortIcon = $('#kpiEffortIcon i');

if (effortColor === 'red') {
    $effortIcon.removeClass().addClass('fas fa-arrow-down');
}
else if (effortColor === 'green') {
    $effortIcon.removeClass().addClass('fas fa-arrow-up');
}
else {
    $effortIcon.removeClass().addClass('fas fa-minus');
}

          $('#kpiOnTime')
              .removeClass('green orange red')
              .addClass(
                  onTimePct === 100 ? 'green' :
                      (onTimePct >= 80 && onTimePct <= 90) ? 'orange' :
                          (onTimePct < 70 ? 'red' : 'orange')
              );

          $('#kpiOnTimeIcon')
              .removeClass('green orange red')
              .addClass(
                  onTimePct === 100 ? 'green' :
                      (onTimePct >= 80 && onTimePct <= 90) ? 'orange' :
                          (onTimePct < 70 ? 'red' : 'orange')
              );

      }

      function resetKPIsToNA() {
          $('#kpiTotalTasks').text('00/00');
          $('#kpiAvgDelay').text('00');
          $('#kpiEffortOverrun').text('00%').removeClass('green orange red');
          $('#kpiOnTime').text('00%').removeClass('green orange red');
          $('#kpiEffortIcon, #kpiOnTimeIcon').removeClass('green orange red');
      }

      function resetTodoDates() {

          const startInput = document.getElementById('txtStartDate');
          const endInput = document.getElementById('txtEndDate');

          if (!startInput || !endInput) return;

          startInput.value = '';
          endInput.value = '';

          startInput.placeholder = "dd/mm/yyyy";
          endInput.placeholder = "dd/mm/yyyy";
      }

      function loadCharts(requestData) {
          // Initialize charts if they don't exist yet
          if (!chartInstances.chart1 || !chartInstances.chart2 || !chartInstances.chart3) {
              initializeChart1();
              initializeChart2();
              initializeChart3();
              chartInitialized = true;
          }

          // Load chart data from API - use same endpoints as main page
          var reportId = requestData.ReportID || 324;
          var parameters = requestData.Parameters || {};

          // Build parameters object
          var chartParameters = {};
          if (parameters.ProjectID) {
              chartParameters.ProjectID = parameters.ProjectID;
          }
          if (parameters.Period) {
              chartParameters.Period = parameters.Period;
          }
          if (parameters.ResourceID) {
              chartParameters.ResourceID = parameters.ResourceID;
          }

          // Load all 3 charts from API
          loadChart1FromAPI(reportId, chartParameters);
          loadChart2FromAPI(reportId, chartParameters);
          loadChart3FromAPI(reportId, chartParameters);
      }

      function loadChart1FromAPI(reportId, parameters) {
          // ProjectID is required
          if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
              updateChart1([], [], []);
              return;
          }

          var requestData = {
              ReportID: parseInt(reportId),
              Parameters: Object.keys(parameters).length > 0 ? parameters : null
          };

          $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetTop5ResourcesChart',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify(requestData),
              success: function (response) {
                  var chartData = null;

                  // Unwrap response
                  if (response && response.data) {
                      chartData = response.data;
                  }
                  else if (response && response.labels && response.totalTasks && response.completedTasks) {
                      chartData = response;
                  }

                  if (chartData && chartData.labels && chartData.totalTasks && chartData.completedTasks) {

                      var filteredLabels = [];
                      var filteredTotalTasks = [];
                      var filteredCompletedTasks = [];

                      for (var i = 0; i < chartData.labels.length; i++) {
                          var label = chartData.labels[i];
                          if (label &&
                              label.toString().trim() !== '' &&
                              label.toString().trim().toLowerCase() !== 'unknown') {

                              filteredLabels.push(label);
                              filteredTotalTasks.push(chartData.totalTasks[i] || 0);
                              filteredCompletedTasks.push(chartData.completedTasks[i] || 0);
                          }
                      }

                      // ✅ 1) Update donut chart
                      updateChart1(filteredLabels, filteredTotalTasks, filteredCompletedTasks);

                  } else {
                      updateChart1([], [], []);
                  }
              },
              error: function () {
                  updateChart1([], [], []);
              }
          });
      }

      function loadChart2FromAPI(reportId, parameters) {
          // ProjectID is required
          if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
              updateChart2([], [], []);
              return;
          }

          var requestData = {
              ReportID: parseInt(reportId),
              Parameters: Object.keys(parameters).length > 0 ? parameters : null
          };

          $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetTop5ResourcesOverrunChart',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify(requestData),
              success: function (response) {
                  var chartData = null;

                  if (response && response.data) {
                      chartData = response.data;
                  }
                  else if (response && response.labels && response.totalTasks && response.overrunTasks) {
                      chartData = response;
                  }

                  if (chartData && chartData.labels && chartData.totalTasks && chartData.overrunTasks) {
                      // Filter out "Unknown" resources
                      var filteredLabels = [];
                      var filteredTotalTasks = [];
                      var filteredOverrunTasks = [];

                      for (var i = 0; i < chartData.labels.length; i++) {
                          var label = chartData.labels[i];
                          if (label &&
                              label.toString().trim() !== '' &&
                              label.toString().trim().toLowerCase() !== 'unknown') {
                              filteredLabels.push(label);
                              filteredTotalTasks.push(chartData.totalTasks[i] || 0);
                              filteredOverrunTasks.push(chartData.overrunTasks[i] || 0);
                          }
                      }

                      updateChart2(filteredLabels, filteredTotalTasks, filteredOverrunTasks);
                  } else {
                      updateChart2([], [], []);
                  }
              },
              error: function (xhr, status, error) {

                  updateChart2([], [], []);
              }
          });
      }

      function loadChart3FromAPI(reportId, parameters) {
          // ProjectID is required
          if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
              updateChart3([], [], []);
              return;
          }

          var requestData = {
              ReportID: parseInt(reportId),
              Parameters: Object.keys(parameters).length > 0 ? parameters : null
          };

          $.ajax({
              url: baseUrl + '/api/ReportUIBuilder/GetTop5ResourcesScheduleVarianceChart',
              type: 'POST',
              headers: getAjaxHeaders(),
              data: JSON.stringify(requestData),
              success: function (response) {
                  var chartData = null;

                  if (response && response.data) {
                      chartData = response.data;
                  }
                  else if (response && response.labels && response.totalTasks && response.scheduleVarianceTasks) {
                      chartData = response;
                  }

                  if (chartData && chartData.labels && chartData.totalTasks && chartData.scheduleVarianceTasks) {
                      // Filter out "Unknown" resources
                      var filteredLabels = [];
                      var filteredTotalTasks = [];
                      var filteredScheduleVarianceTasks = [];

                      for (var i = 0; i < chartData.labels.length; i++) {
                          var label = chartData.labels[i];
                          if (label &&
                              label.toString().trim() !== '' &&
                              label.toString().trim().toLowerCase() !== 'unknown') {
                              filteredLabels.push(label);
                              filteredTotalTasks.push(chartData.totalTasks[i] || 0);
                              filteredScheduleVarianceTasks.push(chartData.scheduleVarianceTasks[i] || 0);
                          }
                      }

                      updateChart3(filteredLabels, filteredTotalTasks, filteredScheduleVarianceTasks);
                  } else {
                      updateChart3([], [], []);
                  }
              },
              error: function (xhr, status, error) {

                  updateChart3([], [], []);
              }
          });
      }

      function updateChart1(labels, totalTasks, completedTasks) {

          if (!chartInstances.chart1) return;

          const remainingTasks = totalTasks.map((t, i) => {
              const total = parseInt(t) || 0;
              const completed = parseInt(completedTasks[i]) || 0;
              return Math.max(0, total - completed);
          });

          chartInstances.chart1.data.labels = labels;

          // Dataset[0] → Completed
          chartInstances.chart1.data.datasets[0].data = completedTasks.map(v => parseInt(v) || 0);

          // Dataset[1] → Remaining
          chartInstances.chart1.data.datasets[1].data = remainingTasks;

          chartInstances.chart1.update();
      }

      function initializeChart1() {
          if (chartInstances.chart1) return;

          chartInstances.chart1 = new Chart(
              document.getElementById('donutChart'), // keep same canvas id
              {
                  type: 'bar',
                  data: {
                      labels: [],
                      datasets: [
                          {
                              label: 'Completed',
                              data: [],
                              backgroundColor: '#f97316', // ✅ ORANGE
                              borderRadius: 6,
                              barThickness: 14
                          },
                          {
                              label: 'Remaining',
                              data: [],
                              backgroundColor: '#2f6fed', // ✅ BLUE
                              borderRadius: 6,
                              barThickness: 14
                          }
                      ]
                  },
                  options: {
                      indexAxis: 'y',
                      responsive: true,
                      maintainAspectRatio: false,

                      layout: {
                          padding: {
                              left: 10,
                              right: 20,
                              top: 10,
                              bottom: 10
                          }
                      },

                      interaction: {
                          mode: 'nearest',
                          intersect: true
                      },

                      plugins: {
                          legend: {
                              position: 'bottom'
                          },
                          tooltip: {
                              mode: 'nearest',
                              intersect: true
                          }
                      },

                      scales: {
                          x: {
                              stacked: true,
                              beginAtZero: true
                          },
                          y: {
                              stacked: true,
                              ticks: {
                                  autoSkip: false,          // 🔥 VERY IMPORTANT
                                  font: { size: 10 },
                                  callback: function (value) {
                                      const label = this.getLabelForValue(value);
                                      return label.length > 15
                                          ? label.substring(0, 15) + '...'
                                          : label;
                                  }
                              }
                          }
                      }
                  }
              }
          );
      }

      function updateChart2(labels, totalTasks, overrunTasks) {

          if (!chartInstances.chart2) {
              initializeChart2();
          }

          if (!chartInstances.chart2) return;

          // Ensure arrays match length
          var maxLength = Math.max(labels.length, totalTasks.length, overrunTasks.length);

          var safeLabels = labels.slice(0, maxLength);
          var safeTotalTasks = totalTasks.slice(0, maxLength).map(v => parseInt(v) || 0);
          var safeOverrunTasks = overrunTasks.slice(0, maxLength).map(v => parseInt(v) || 0);

          // Update data
          chartInstances.chart2.data.labels = safeLabels;
          chartInstances.chart2.data.datasets[0].data = safeTotalTasks;
          chartInstances.chart2.data.datasets[1].data = safeOverrunTasks;

          chartInstances.chart2.data.datasets[0].label = 'Total';
          chartInstances.chart2.data.datasets[1].label = 'Overrun';

          // =========================
          // ✅ Correct axis control
          // =========================

          // Calculate max for numeric axis (X axis because horizontal chart)
          var allValues = safeTotalTasks.concat(safeOverrunTasks);
          var maxValue = allValues.length ? Math.max(...allValues) : 0;

          var calculatedMax = maxValue > 0
              ? Math.ceil((maxValue * 1.2) / 5) * 5
              : 10;

          // Apply ONLY to X axis (numeric axis)
          chartInstances.chart2.options.scales.x.min = 0;
          chartInstances.chart2.options.scales.x.max = calculatedMax;
          chartInstances.chart2.options.scales.x.ticks = {
              stepSize: 5,
              font: { size: 9 }
          };

          // Ensure Y axis is category only
          chartInstances.chart2.options.scales.y = {
              ticks: {
                  autoSkip: false,
                  font: { size: 10 }
              }
          };

          chartInstances.chart2.options.scales.x.stacked = false;
          chartInstances.chart2.options.scales.y.stacked = false;

          chartInstances.chart2.update();
      }

      function initializeChart2() {
          if (chartInstances.chart2) return;

          chartInstances.chart2 = new Chart(document.getElementById('barChart'), {
              type: 'bar',
              data: {
                  labels: [],
                  datasets: [
                      { label: 'Total', data: [], backgroundColor: '#2f6fed', borderRadius: 6 },
                      { label: 'Overrun', data: [], backgroundColor: '#f97316', borderRadius: 6 } // ✅ ORANGE
                  ]
              },
              options: {
                  indexAxis: 'y',
                  responsive: true,
                  maintainAspectRatio: false,

                  layout: {
                      padding: {
                          left: 10,
                          right: 20
                      }
                  },

                  interaction: {
                      mode: 'nearest',
                      intersect: true
                  },

                  plugins: {
                      legend: { position: 'bottom' },
                      tooltip: {
                          mode: 'nearest',
                          intersect: true
                      }
                  },

                  scales: {
                      x: {
                          beginAtZero: true
                      },
                      y: {
                          ticks: {
                              autoSkip: false,   // 🔥 THIS FIXES MISSING NAMES
                              font: { size: 10 }
                          }
                      }
                  }
              }
          });
      }

      function updateChart3(labels, totalTasks, scheduleVarianceTasks) {
          // Show/hide "No data available" message
          var hasData = labels && labels.length > 0 && totalTasks && totalTasks.length > 0;
          var $noDataMsg = $('#chart3NoData');
          if ($noDataMsg.length) {
              $noDataMsg.toggle(hasData === false);
          }

          if (!chartInstances.chart3) {
              initializeChart3();
          }

          if (!chartInstances.chart3) {
              return;
          }

          // Ensure arrays are the same length
          var maxLength = Math.max(labels.length, totalTasks.length, scheduleVarianceTasks.length);
          var safeLabels = labels.slice(0, maxLength);
          var safeTotalTasks = totalTasks.slice(0, maxLength).map(function (v) { return parseInt(v) || 0; });
          var safeScheduleVarianceTasks = scheduleVarianceTasks.slice(0, maxLength).map(function (v) { return parseInt(v) || 0; });

          // Pad arrays if needed
          if (maxLength > 0) {
              while (safeLabels.length < maxLength) safeLabels.push('');
              while (safeTotalTasks.length < maxLength) safeTotalTasks.push(0);
              while (safeScheduleVarianceTasks.length < maxLength) safeScheduleVarianceTasks.push(0);
          }

          // Ensure we have two datasets (Total Tasks and Schedule Variance)
          if (chartInstances.chart3.data.datasets.length < 2) {
              if (chartInstances.chart3.data.datasets.length === 1) {
                  chartInstances.chart3.data.datasets.push({
                      label: 'Schedule Variance',
                      data: safeScheduleVarianceTasks,
                      backgroundColor: '#f97316'
                  });
                  chartInstances.chart3.data.datasets[0].label = 'Total Tasks';
                  chartInstances.chart3.data.datasets[0].backgroundColor = '#3b82f6';
              } else if (chartInstances.chart3.data.datasets.length === 0) {
                  chartInstances.chart3.data.datasets = [
                      {
                          label: 'Total Tasks',
                          data: safeTotalTasks,
                          backgroundColor: '#3b82f6'
                      },
                      {
                          label: 'Schedule Variance',
                          data: safeScheduleVarianceTasks,
                          backgroundColor: '#f97316'
                      }
                  ];
              }
          }

          // Update chart data - both total tasks and schedule variance
          chartInstances.chart3.data.labels = safeLabels;
          chartInstances.chart3.data.datasets[0].data = safeTotalTasks;
          chartInstances.chart3.data.datasets[0].label = 'Total Tasks';
          chartInstances.chart3.data.datasets[0].backgroundColor = '#3b82f6';
          chartInstances.chart3.data.datasets[1].data = safeScheduleVarianceTasks;
          chartInstances.chart3.data.datasets[1].label = 'Schedule Variance';
          chartInstances.chart3.data.datasets[1].backgroundColor = '#f97316';

          // Update max value for Y-axis based on both datasets
          var maxTotalTasks = safeTotalTasks.length > 0 ? Math.max.apply(null, safeTotalTasks) : 0;
          var maxScheduleVariance = safeScheduleVarianceTasks.length > 0 ? Math.max.apply(null, safeScheduleVarianceTasks) : 0;
          var maxValue = Math.max(maxTotalTasks, maxScheduleVariance);

          var calculatedMax;
          if (maxValue > 0) {
              calculatedMax = Math.ceil(maxValue * 1.2);
              calculatedMax = Math.ceil(calculatedMax / 5) * 5;
          } else {
              calculatedMax = 10;
          }

          chartInstances.chart3.options.scales.y.min = 0;
          chartInstances.chart3.options.scales.y.max = calculatedMax;

          if (!chartInstances.chart3.options.scales.y.ticks) {
              chartInstances.chart3.options.scales.y.ticks = {};
          }
          if (!chartInstances.chart3.options.scales.y.ticks.font) {
              chartInstances.chart3.options.scales.y.ticks.font = {};
          }

          chartInstances.chart3.options.scales.y.ticks.stepSize = 5;
          chartInstances.chart3.options.scales.y.ticks.display = true;
          chartInstances.chart3.options.scales.y.ticks.autoSkip = true;
          chartInstances.chart3.options.scales.y.ticks.min = 0;
          chartInstances.chart3.options.scales.y.ticks.max = calculatedMax;
          var maxTicks = Math.min(Math.ceil(calculatedMax / 5) + 1, 11);
          chartInstances.chart3.options.scales.y.ticks.maxTicksLimit = maxTicks;
          chartInstances.chart3.options.scales.y.ticks.font.size = 7;

          if (!chartInstances.chart3.options.scales.x.ticks) {
              chartInstances.chart3.options.scales.x.ticks = {};
          }
          if (!chartInstances.chart3.options.scales.x.ticks.font) {
              chartInstances.chart3.options.scales.x.ticks.font = {};
          }
          chartInstances.chart3.options.scales.x.ticks.font.size = 7;
          chartInstances.chart3.options.scales.x.ticks.maxRotation = 45;
          chartInstances.chart3.options.scales.x.ticks.minRotation = 0;

          if (!chartInstances.chart3.options.plugins.legend) {
              chartInstances.chart3.options.plugins.legend = {};
          }
          if (!chartInstances.chart3.options.plugins.legend.labels) {
              chartInstances.chart3.options.plugins.legend.labels = {};
          }
          if (!chartInstances.chart3.options.plugins.legend.labels.font) {
              chartInstances.chart3.options.plugins.legend.labels.font = {};
          }
          chartInstances.chart3.options.plugins.legend.labels.font.size = 8;
          chartInstances.chart3.options.plugins.legend.labels.boxWidth = 10;
          chartInstances.chart3.options.plugins.legend.labels.padding = 5;

          chartInstances.chart3.options.scales.y.afterBuildTicks = function (scale) {
              scale.ticks = [];
              var max = (calculatedMax !== undefined && calculatedMax !== null && !isNaN(calculatedMax)) ? calculatedMax : 10;
              var step = 5;
              if (max > 0 && step > 0) {
                  for (var i = 0; i <= max; i += step) {
                      scale.ticks.push({ value: i });
                  }
              }
          };

          chartInstances.chart3.options.scales.x.stacked = false;
          chartInstances.chart3.options.scales.y.stacked = false;

          chartInstances.chart3.update('active');
      }

      function initializeChart3() {
          if (chartInstances.chart3) return;

          chartInstances.chart3 = new Chart(document.getElementById('lineChart'), {
              type: 'line',
              data: {
                  labels: [],
                  datasets: [
                      {
                          label: 'Total Tasks',
                          data: [],
                          borderColor: '#3b82f6',
                          tension: 0.35,
                          fill: false
                      },
                      {
                          label: 'Schedule Variance',
                          data: [],
                          borderColor: '#f97316',
                          tension: 0.35,
                          fill: false
                      }
                  ]
              },
              options: {
                  responsive: true,
                  maintainAspectRatio: false,
                  plugins: { legend: { position: 'bottom' } },
                  scales: {
                      x: { beginAtZero: true },
                      y: { beginAtZero: true }
                  }
              }
          });
      }

      function setPageHeader(type) {
          const h = headerMap[type] || headerMap.completed;
          document.getElementById("pageHeaderTitle").textContent = h.title;
          document.getElementById("pageHeaderSub").textContent = h.sub;
      }
      function resetPeriodByReportType(type) {

    var $period = $('#cboPeriod');
    if (!$period.length) return;

    if (type === "type" || type === "progress") {
        $period.selectpicker('val', '1');
    } else {
        $period.selectpicker('val', '0');
    }

    $period.selectpicker('refresh');
}
      // Chip click: ✅ updates ONLY header + table
      const chips = document.getElementById('chips');

      chips.addEventListener('click', function (e) {

    const chip = e.target.closest('.chip');
    if (!chip) return;

    chips.querySelectorAll('.chip').forEach(x => x.classList.remove('active'));
    chip.classList.add('active');

    const type = chip.getAttribute('data-type');

    setPageHeader(type);
    applyFilters(type);

    tableState.data = [];
    tableState.page = 1;
     resetTaskStatusDropdown();

 // ✅ FIX: Set required dates before API call
 if (type === "wdw" || type === "awd" || type === "todo") {
     setTodayForFromDateToDate(true);
 }

 if (type === "wdww") {
     setTodayForFromDate(true);
 }

 if (type === "shouldStart") {
     setTodayForShouldStart(true);
 }
    const projectReset = forceProjectToSession();
    if (!projectReset) {
        resetTaskStatusDropdown();
        return;
    }

    ProjectonChange(true);

    setTimeout(function () {
        resetPeriodByReportType(type);
    }, 100);
});


      $('.btn-export.pdf').on('click', function () {

          loadCompanyLogo(function () {

              downloadReport('pdf');

          });

      });

      $('.btn-export.excel').on('click', function () {
          loadCompanyLogo(function () {

              downloadReport('excel');

          });

      });
      let strCompanyLogo = "";

      function loadCompanyLogo(callback) {

          var fullUrl = baseUrl + "/api/PM_EarnedValueReport/GetCompanyLogo";

          $.ajax({
              url: fullUrl,
              type: "POST",
              contentType: "application/json",
              data: JSON.stringify({}),
              headers: getAjaxHeaders(),

              success: function (data) {

                  if (data && data.systemFileName) {
                      strCompanyLogo = data.systemFileName;
                  }

                  callback();
              },

              error: function () {

                  console.log("Logo load failed");

                  callback();
              }
          });
      }
      function getLogo(callback) {

          let logoName = strCompanyLogo;

          if (!logoName) {
              callback(""); // No logo
              return;
          }

          var logoUrl;

          if (directory && directory !== "null") {
              logoUrl = window.location.origin + "/" + directory + "/Images/" + logoName;
          }
          else {
              logoUrl = window.location.origin + "/Images/" + logoName;
          }

          fetch(logoUrl)
              .then(res => {

                  if (!res.ok) {
                      console.log("Logo not found");
                      callback("");
                      return null;
                  }

                  return res.blob();
              })
              .then(blob => {

                  if (!blob) return;

                  if (blob.size === 0) {
                      callback("");
                      return;
                  }

                  var reader = new FileReader();

                  reader.onloadend = function () {
                      callback(reader.result || "");
                  };

                  reader.readAsDataURL(blob);

              })
              .catch(err => {

                  console.log("Logo fetch error:", err);

                  callback("");
              });
      }

      function downloadReport(format) {

          getLogo(function (logoBase64) {
              var projectID = $('#cboProject').val();
              var period = $('#cboPeriod').val();
              var resourceID = $('#cboResource').val();
              var taskStatusID = $('#cboTaskStatusDrpdwn').val();
              var showRollupMPPTasks = $('#chkShowRollupMPPTasks').is(':checked');
              // ✅ Get active chip safely
              const chip = document.querySelector('.chip.active');
              if (!chip) return;

              const type = chip.getAttribute('data-type');

              var reportID = 324;
              switch (type) {

                  case "inProgress":
                      reportID = 325;
                      break;
                  case "critical":
                      reportID = 322;
                      break;
                  case "todo":
                      reportID = 326;
                      break;
                  case "slipping":
                      reportID = 333;
                      break;
                  case "unstarted":
                      reportID = 327;
                      break;
                  case "shouldStart":
                      reportID = 332;
                      break;
                  case "overallocation":
                      reportID = 328;
                      break;
                  case "awd":
                      reportID = 607;
                      break;
                  case "wdw":
                      reportID = 320;
                      break;
                  case "wdww":
                      reportID = 336;
                      break;
                  case "progress":
                      reportID = 996;
                      break;
                  case "type":
                      reportID = 993;
                      break;
                  default:
                      reportID = 324;
                      break;
              }
              if (!projectID || projectID === '0') {
                  alertify.error('Please select a project');
                  return;
              }

              var period = $('#cboPeriod').val();
              var resourceID = $('#cboResource').val();
              var requestData = {
                  ReportID: reportID,
                  Format: format,
                  CompanyLogo: logoBase64,
                  Parameters: {
                      ProjectID: parseInt(projectID)
                  }
              };
              // ✅ Add Period only if report supports it
              const allowedFilters = reportFilterMap[type] || [];

              if (allowedFilters.includes("period")) {

                  if (period && period !== '' && period !== '0') {
                      requestData.Parameters.Period = parseInt(period);
                  }

                  // Special case for type/progress (default period = 1)
                  if ((type === "type" || type === "progress") &&
                      (!period || period === '0')) {

                      requestData.Parameters.Period = 1;
                  }
              }

              if (allowedFilters.includes("resource")) {
                  if (resourceID && resourceID !== '' && resourceID !== '0') {
                      requestData.Parameters.ResourceID = parseInt(resourceID);
                  }
              }
              if (type !== "wdww") {
                  if (!validateStartEndDates(true)) return;
              }
              if (type === "todo" || type === "awd" || type === "wdw") {

                  var startDate = convertToApiDate($('#txtStartDate').val());
                  var endDate = convertToApiDate($('#txtEndDate').val());

                  if (startDate) {
                      requestData.Parameters.dtmFrom = startDate;
                  }

                  if (endDate) {
                      requestData.Parameters.dtmTo = endDate;
                  }
              }
              if (type === "wdww") {
                  var startDate = convertToApiDate($('#txtStartDate').val());
                  if (startDate) {
                      requestData.Parameters.dtmFrom = startDate;
                  }
                  else {
                      alertify.error("Please Enter Start Date.");
                      return;
                  }
              }
              if (type === "shouldStart") {
                  var selectedDate = $('#txtShouldstarted').datepicker("getDate");

                  if (!selectedDate) {
                      selectedDate = new Date();
                  }

                  var formattedDate =
                      selectedDate.getFullYear() + "-" +
                      String(selectedDate.getMonth() + 1).padStart(2, '0') + "-" +
                      String(selectedDate.getDate()).padStart(2, '0');

                  requestData.Parameters.dtmbydate = formattedDate;
              }

              //Added by Aditya J. on 17-02-2026
              if (type === "progress") {
                  requestData.Parameters.TypeID = parseInt(taskStatusID);
                  requestData.Parameters.ShowRollupMPPTasks = showRollupMPPTasks ? 1 : 0;
              }

              if (type === "type") {

              }
              //End of Added by Aditya J. on 17-02-2026

              $.ajax({
                  url: baseUrl + '/api/ReportUIBuilder/DownloadReport',
                  type: 'POST',
                  headers: getAjaxHeaders(),
                  data: JSON.stringify(requestData),
                  xhrFields: {
                      responseType: 'blob'   // 🔥 IMPORTANT for file download
                  },
                  success: function (blob, status, xhr) {

                      var contentType = xhr.getResponseHeader("Content-Type");
                      var fileName = "";
                      var dateTimeSuffix = formatDateTime(new Date());
                      if (format === 'pdf') {
                          fileName = "TaskReport_" + type + "_" + dateTimeSuffix + ".pdf";
                      } else {
                          fileName = "TaskReport_" + type + "_" + dateTimeSuffix + ".xlsx";
                      }

                      var link = document.createElement('a');
                      link.href = window.URL.createObjectURL(blob);
                      link.download = fileName;
                      document.body.appendChild(link);
                      link.click();
                      document.body.removeChild(link);
                  },
                  error: function (xhr) {

                      var errorMessage = 'No Data available to download.';

                      if (xhr.responseJSON) {
                          errorMessage =
                              xhr.responseJSON.message ||
                              xhr.responseJSON.error ||
                              errorMessage;
                      }

                      alertify.error(errorMessage);
                  }
              });
          });
      }

      function formatDateTime(dt) {
          var yyyy = dt.getFullYear();
          var MM = String(dt.getMonth() + 1).padStart(2, '0');
          var dd = String(dt.getDate()).padStart(2, '0');
          var HH = String(dt.getHours()).padStart(2, '0');
          var mm = String(dt.getMinutes()).padStart(2, '0');
          var ss = String(dt.getSeconds()).padStart(2, '0');

          return yyyy + MM + dd + "_" + HH + mm + ss;
      }

      $(function () {
          $('.selectpicker').selectpicker({
              dropupAuto: false
          }); // ONCE
          initializeProjectDropdownForSession();
      });
  </script>
  <script>
      (function () {
          function updateSticky() {
              var topbar = document.querySelector('.topbar');
              var chips = document.querySelector('.chips-wrap');
              var topSpacer = document.getElementById('topbar-spacer');
              var chipsSpacer = document.getElementById('chips-spacer');
              if (!topbar || !chips || !topSpacer || !chipsSpacer) return;

              var topbarRect = topbar.getBoundingClientRect();
              // When topbar would scroll off the top, fix it
              if (topbarRect.top <= 0) {
                  if (!topbar.classList.contains('fixed-topbar')) {
                      topSpacer.style.height = topbarRect.height + 'px';
                      topSpacer.style.display = 'block';
                      topbar.classList.add('fixed-topbar');
                      topbar.style.position = 'fixed';
                      topbar.style.top = '0';
                      topbar.style.left = '0';
                      topbar.style.right = '0';
                      topbar.style.zIndex = '1100';
                  }
              } else {
                  if (topbar.classList.contains('fixed-topbar')) {
                      topbar.classList.remove('fixed-topbar');
                      topbar.style.position = '';
                      topbar.style.top = '';
                      topbar.style.left = '';
                      topbar.style.right = '';
                      topbar.style.zIndex = '';
                      topSpacer.style.display = 'none';
                      topSpacer.style.height = '0';
                  }
              }

              // For chips, compute offset relative to viewport top
              var chipsRect = chips.getBoundingClientRect();
              var topbarHeight = topbar.offsetHeight || 0;
              if (chipsRect.top <= topbarHeight) {
                  if (!chips.classList.contains('fixed-chips')) {
                      chipsSpacer.style.height = chipsRect.height + 'px';
                      chipsSpacer.style.display = 'block';
                      chips.classList.add('fixed-chips');
                      chips.style.position = 'fixed';
                      chips.style.top = topbarHeight + 'px';
                      chips.style.left = '0';
                      chips.style.right = '0';
                      chips.style.zIndex = '1000';
                  }
              } else {
                  if (chips.classList.contains('fixed-chips')) {
                      chips.classList.remove('fixed-chips');
                      chips.style.position = '';
                      chips.style.top = '';
                      chips.style.left = '';
                      chips.style.right = '';
                      chips.style.zIndex = '';
                      chipsSpacer.style.display = 'none';
                      chipsSpacer.style.height = '0';
                  }
              }
          }
          window.addEventListener('scroll', updateSticky, { passive: true });
          window.addEventListener('resize', updateSticky);
      })();
  </script>
</body>
</html>
