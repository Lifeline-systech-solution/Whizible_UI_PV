<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Resource_Utilization.aspx.vb" Inherits="Whizible.Resource_Utilization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- <script type="text/javascript">
        window.location.replace('../PM/PM_UnderConstruction.aspx');
      </script> -->
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <!-- Bootstrap 5.3.2 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">

    <style type="text/css">
        body{
            background-color: #ffffff;
            font-size: 11.5px !important;
        }
        .btn{
            font-size: 11.5px !important;
        }
.dataTables_scrollBody thead tr[role="row"] {visibility: collapse !important;}
a.clearalllink {font-weight: bold;margin: 7px 0px 0 8px;display: none;}
.filter.pull-right { margin: 2px 0 0 8px;}
table tr th{ vertical-align:middle!important;}
table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before{ margin-right:0;}
  .notebox {padding: 10px;margin-bottom: 10px;border-radius: 4px;}

.dropdown-submenu .dropdown-submenu > a:after {border-color: transparent transparent transparent #fff;    border-style: solid;border-width: 5px 0 5px 5px;content: " ";display: block;float: right;height: 0;    margin-right: 10px;margin-top: 5px;width: 0;}
.dropdown-submenu>.dropdown-submenu:hover a:after{border-color: transparent transparent transparent #464a4c;}

/*Detailpanel*/
.Resourcedetailpanel{ margin:40px 15px 0; display:none; border:1px solid #ddd; border-radius:4px;}
.pgdetailinner{ padding:10px;}
.Resourcedetailpanel .tab-pane {padding: 20px 0;}
tr.rowhiglight{ background:#c3dbff;}

.DisableContent{ pointer-events:none; opacity:0.5;}
.DisableContent:hover{ cursor:no-drop;}
.dataTables_scrollBody.DisableContent{ height:auto!important}
ul.nav.nav-tabs.detailsubtabs {background: #f5f5f5;margin: -11px -11px;padding: 10px 10px 0;border: 1px solid #ddd;border-radius: 4px 4px 0 0;}
.nav.detailsubtabs>li>a:hover, .nav.nav.detailsubtabs>li>a:active, .nav.nav.detailsubtabs>li>a:focus{ background:#fff; color:#1359ac;}

h5.pgtitle {
    margin: 6px 0 0;
    font-weight: 700;
    color: #4263c1;
    font-size: 16px;
}
.dblock{ display:block;}



/*New css end here*/
    
        .lightgraybg {background: #f5f5f5;}

        /*Information table start here*/
.informationtbl{margin-bottom:15px}
.informationtbl tr th{text-align:right;font-weight:500}
body .informationtbl tr td{text-align:left}
.informationtbl th,.informationtbl td{padding:2px 4px}
body .informationtbl tr td.pr-3{padding-right:3em}
table.informationtbl{width:100%}
td.Agpm{color:#eb1c24}
.togglerup .collapseup{display:block}
.togglerup .collapsedown{display:none}
.togglerdown .collapsedown{display:block}
.togglerdown .collapseup{display:none}
.infoToggler{margin:5px 0 0}
.hideprofitabilityinfo{position:absolute;right:10px}
.profitabilityinfopanel .panel.panel-default{padding:0;position:relative}
.profitabilityinfopanel .panel-default > .panel-heading{padding-right:35px;background:#e7edf0}
.profitabilityinfopanel .panel-default > .panel-heading a:hover,.profitabilityinfopanel .panel-default > .panel-heading a:focus{color:#464a4c}
.profitabilityinfopanel .panel-default > .panel-heading a span img{opacity:.5}
.profitabilityinfopanel .panel-default > .panel-heading a span img:hover{opacity:1}
        /*Information table End here*/
        .informationtbl td,.informationtbl th{vertical-align:top!important;font-size:14px;line-height:normal}
.informationtbl tr th{min-width:120px}
tr.totalrow{background:#ccc}
/* Added By Madhuri.K on 24-08-2026 */
        #ProRsrsDisplaySummurymodal .informationtbl,
        #ProRsrsDisplayDetailsmodal .informationtbl {
            width: 100%;
            margin-bottom: 12px;
            background: transparent;
            border: 0;
        }
        #ProRsrsDisplaySummurymodal .informationtbl tr th,
        #ProRsrsDisplayDetailsmodal .informationtbl tr th {
            text-align: right;
            color: #6b9bd1 !important;
            font-weight: 500;
            min-width: 140px;
            white-space: nowrap;
            background: transparent;
            border: 0;
        }
        #ProRsrsDisplaySummurymodal .informationtbl td,
        #ProRsrsDisplayDetailsmodal .informationtbl td {
            text-align: left;
            color: #374151;
            background: transparent;
            border: 0;
        }
        #ProRsrsDisplaySummurymodal .informationtbl th,
        #ProRsrsDisplaySummurymodal .informationtbl td,
        #ProRsrsDisplayDetailsmodal .informationtbl th,
        #ProRsrsDisplayDetailsmodal .informationtbl td {
            padding: 2px 4px;
            vertical-align: top;
            font-size: 11.5px;
            line-height: 1.4;
        }
        #ProRsrsDisplaySummurymodal .informationtbl td.colan,
        #ProRsrsDisplayDetailsmodal .informationtbl td.colan {
            padding: 2px 6px;
            width: 10px;
            color: #6b9bd1;
        }
        #ProRsrsDisplaySummurymodal .informationtbl td.pr-3,
        #ProRsrsDisplayDetailsmodal .informationtbl td.pr-3 {
            padding-right: 3em;
        }

.innerpgsection{clear:both;display:flex}
.innerpagemenu{width:55px;height:100vh;min-height:100%;background:#f7f7f7;position:relative;z-index:9}
.innersecRight{width:96%;height:100vh}

/* ScrolBar  */
.scrollbar{height:90%;width:100%;overflow-y:hidden;overflow-x:hidden}
.scrollbar:hover{height:90%;width:100%;overflow-y:scroll;overflow-x:hidden}

/* Scrollbar Style */

#style-1::-webkit-scrollbar-track{border-radius:2px}
#style-1::-webkit-scrollbar{width:5px;background-color:#F7F7F7}
#style-1::-webkit-scrollbar-thumb{border-radius:10px;-webkit-box-shadow:inset 0 0 6px rgba(0,0,0,.3);background-color:#BFBFBF}
/* Scrollbar End */

.main-menu .fa-lg{font-size:1em}
.main-menu .fa{position:relative;display:table-cell;width:55px;height:36px;text-align:center;top:12px;font-size:20px}
.main-menu:hover,nav.main-menu.expanded{width:260px;overflow:hidden;opacity:1}
.main-menu{background:#F7F7F7;position:absolute;top:0;bottom:0;height:100%;left:0;width:55px;overflow:hidden;border-right:1px solid #eee;opacity:1}
.main-menu > ul{margin:7px 0;padding:0}
.main-menu ul{padding:0}
.main-menu li{position:relative;display:block;width:250px}
.main-menu li > a{position:relative; height: 4em;width:255px;display:table;border-collapse:collapse;border-spacing:0;color:#8a8a8a;font-size:13px;text-decoration:none;-webkit-transform:translateZ(0) scale(1,1);-webkit-transition:all .14s linear;transition:all .14s linear;font-family:'Strait',sans-serif;border-top:1px solid #f2f2f2}
.main-menu .nav-icon{position:relative;display:table-cell;width:55px;height:36px;text-align:center;vertical-align:middle;font-size:18px}
.main-menu .nav-text{position:relative;display:table-cell;vertical-align:middle;width:190px}
.no-touch .scrollable.hover{overflow-y:hidden}
.no-touch .scrollable.hover:hover{overflow-y:auto;overflow:visible}
.main-menu li > a img {
    position: absolute;
    top: 12px;
    margin: auto;
    left: 10px;
    bottom: auto;
}
.main-menu li > a:hover img, .main-menu li.active > a img{ filter:invert(1);}

/*Hover Property */
.main-menu li:hover > a,nav.main-menu li.active > a,.dropdown-menu > li > a:hover,.dropdown-menu > li > a:focus,.dropdown-menu > .active > a,.dropdown-menu > .active > a:hover,.dropdown-menu > .active > a:focus,.no-touch .dashboard-page nav.dashboard-menu ul li:hover a,.dashboard-page nav.dashboard-menu ul li.active a{color:#fff;background-color:#4263c1}
.main-menu li a.active{background:#4263c1;color:#fff}
.area{float:left;background:#e2e2e2;width:100%;height:100%}
table.calviewTbl thead tr th.holiday, table.calviewTbl tbody tr td.holiday {
    background: #eeeeee;
}
/*legends*/
.legend { 
  background: #fff;
  background: rgba(255, 255, 255, 0.8); 
  padding:5px 0 0;
  border:none;
  /*border-top:1px solid #ddd;
  border-bottom:1px solid #ddd;*/
}
.legend ul {
  list-style-type: none;
  margin: 0;
  padding: 0; overflow:hidden;
}
.legend li {float:left; margin-left:10px; }
.legend li:first-child{ margin-left:0;}
.legend span {
  display: inline-block;
  width: 12px;
  height: 12px;
  margin-right: 6px;
}
.bgred{ background:#eb1c24;}
.bgyellow{ background:#f4cd0f;}
.bgblue{ background:#135a9c;}
.bggreen{ background:#9dd824;}
.bgpurple{ background:purple;}
.bgorange{ background:#fbb03b;}
.bggray{ background:#ccc;}
/*end legends*/
.dropdown-menu>li>a:hover {
    background-color: #e1e3e9;
    color: #333;
}
.table-fixed-header thead tr th, .table thead tr th{ padding-top:6px; padding-bottom:6px;}
.calviewTbl tr th:first-child{ min-width:200px;}
.modal-body{ padding:30px!important;}
.mb-1{ margin-bottom:10px;}
ul.dropdownlinks li:hover a, ul.dropdownlinks li a {padding: 5px 10px;}
span.checkmark {color: #9dd824;}

/*newcss*/
.pt-1.pb-1.borderbox {
    border: 1px solid #ddd;
    border-radius: 4px;
}
.RUReportGraph {
    background: #f7f7f7;
    border: 1px solid #ddd;
    padding: 10px;
}
.filterpanelbody > .row > div:nth-child(5n), .filterpanelbody > .row > div:nth-child(6n), .filterpanelbody > .row > div:nth-child(7n){ width:50%;}
.blnktd{ border:none!important;}
.notebox{ border:1px solid #ddd; border-radius:4px; padding:10px;}    
.notebox ul{ margin:0; padding:0;}
.notebox ul li {list-style-type: square;margin-left: 20px;font-size: 12px;}
.Divsubpages{ margin-bottom:0;}
    
        .management-dashboard-page {
            background: #ffffff;
            min-height: auto;
        }

        .management-dashboard-header {
            align-items: center;
            background: #fff;
            border-bottom: 1px solid #eef2f7;
            box-shadow: rgba(0, 0, 0, 0.06) 0 5px 5px -3px, rgba(0, 0, 0, 0.043) 0 8px 10px 1px, rgba(0, 0, 0, 0.035) 0 3px 14px 2px;
            display: flex;
            justify-content: space-between;
            padding: 1rem 1.25rem;
        }

        .management-dashboard-title {
            align-items: center;
            color: #1e40af;
            display: flex;
            font-size: 18px;
            font-weight: 600;
            gap: 0.75rem;
            margin: 0 0 0.25rem;
        }

        .management-dashboard-title i {
            color: #1e40af;
            font-size: 1.5rem;
        }

        .management-dashboard-subtitle {
            color: #6b7280;
            font-size: 0.72rem;
            margin: 0;
        }

        .management-dashboard-tabs-wrapper {
            background: #fff;
            border-bottom: 1px solid #e0e0e0;
            margin: 0 2px 15px;
            padding: 0 15px;
        }

        .management-dashboard-tabs {
            border-bottom: 0;
            gap: 5px;
            margin-bottom: 0;
            overflow: hidden;
            white-space: normal;
        }

        .management-dashboard-tabs .nav-link {
            align-items: center;
            background: transparent;
            border: 0;
            border-bottom: 2px solid transparent;
            color: #666;
            display: flex;
            font-weight: 400;
            gap: 0.4rem;
            padding: 8px 10px;
        }

        .management-dashboard-tabs .nav-link:hover {
            background: #f8fbff;
            color: #1359a6;
        }

        .management-dashboard-tabs .nav-link.active {
            background: #f0f7ff;
            border-bottom-color: #1359a6;
            color: #1359a6;
        }

        .management-dashboard-tabs .nav-link[href="project-resource-utilization.html"] {
            font-size: 11px;
        }

        .management-dashboard-tabs .nav-link[href="project-resource-utilization.html"] i {
            font-size: 11px;
        }

        .management-dashboard-tabs .nav-link.active[href="project-resource-utilization.html"] {
            font-size: 11px;
        }

        .management-dashboard-actions {
            align-items: center;
            display: flex;
            gap: 0.75rem;
        }

        .management-dashboard-actions .clearalllink {
            margin: 0;
        }

        .management-dashboard-filter-btn {
            background: #fff;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            color: #1359a6;
            padding: 6px 10px;
        }
    
        .management-dashboard-current-page {
            align-items: center;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
            display: flex;
            justify-content: space-between;
            margin: 12px 15px 14px;
            padding: 14px 16px;
        }

        .management-dashboard-current-title {
            align-items: center;
            color: #1e40af;
            display: flex;
            font-size: 16px;
            font-weight: 600;
            gap: 0.65rem;
            margin: 0 0 0.25rem;
        }

        .management-dashboard-current-title i {
            color: #1e40af;
            font-size: 1.2rem;
        }

        .management-dashboard-current-note {
            color: #6b7280;
            font-size: 0.72rem;
            margin: 0;
        }

        @media (max-width: 767px) {
            .management-dashboard-current-page {
                align-items: flex-start;
                flex-direction: column;
                gap: 0.75rem;
            }
        }
    
        /* MyProfile-style bootstrap-select */
        .fixed-width-combo {
            width: 250px !important;
        }
        .bootstrap-select.form-control:not([class*="col-"]) {
            width: 100%;
        }
        .fixed-width-combo + .dropdown-toggle {
            width: 250px !important;
            max-width: 100%;
        }

        .fixed-width-combo + .dropdown-toggle,
        .bootstrap-select.fixed-width-combo {
            width: 250px !important;
            max-width: 100%;
        }
        .bootstrap-select .dropdown-menu {
            z-index: 2000;
        }
        .bootstrap-select .dropdown-menu.show {
            display: block;
        }
        .form-inline .bootstrap-select {
            margin-right: 8px;
        }

        /* Page-load loader (same pattern as MyAlerts.aspx) */
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
        .loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
        .preloader {
            position: fixed;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
            z-index: 2100;
        }

        /* Project Health Sheet-style paging for report lists */
        .ru-footer-row {
            margin: 10px 0 0;
            align-items: center;
        }
        .ru-footer-row .spntotal {
            font-size: 12px;
            font-weight: 600;
            color: #374151;
            white-space: nowrap;
        }
        .ru-footer-row .pagination {
            margin: 0;
        }
        .ru-footer-row .page-link {
            cursor: pointer;
            color: #1359a6;
            border: 1px solid #dee2e6;
            padding: 0.25rem 0.55rem;
            font-size: 12px;
        }
        .ru-footer-row .page-item.disabled .page-link {
            color: #9ca3af;
            pointer-events: none;
            background: #f9fafb;
        }

        .black-tooltip .tooltip-inner {
            background-color: #000;
            color: #fff;
            padding: 6px 10px;
        }
        .black-tooltip.bs-tooltip-top .tooltip-arrow::before {
            border-top-color: #000;
        }
        .black-tooltip.bs-tooltip-bottom .tooltip-arrow::before {
            border-bottom-color: #000;
        }
        .black-tooltip.bs-tooltip-start .tooltip-arrow::before {
            border-left-color: #000;
        }
        .black-tooltip.bs-tooltip-end .tooltip-arrow::before {
            border-right-color: #000;
        }
        .ui-tooltip {
            background: #000 !important;
            color: #fff !important;
            border: 0 !important;
            padding: 6px 10px;
        }

        /*Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters*/
        .ru-more-filters {
            color: #4263c1;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
        }
        .ru-more-filters:hover {
            text-decoration: underline;
        }
        /*End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters*/

        /*Updated by Aditya J. on 07-09-2026: replaced the bootstrap-select "checkmark" popup for the Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-selects with a native checkbox-list popup (button + search + checkbox rows + Clear/Close footer), matching the ppc-filter-bar .msel widget used on ProjectProfitByCustomer.aspx*/
        select.ru-multiselect { display: none !important; }
        #ruMultiFilterRow .ru-msel {
            position: relative;
            width: 100%;
        }
        #ruMultiFilterRow .ru-msel-btn {
            width: 100%;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            color: #1a2536;
            font-size: 11.5px;
            text-align: left;
            cursor: pointer;
            white-space: nowrap;
            overflow: hidden;
        }
        #ruMultiFilterRow .ru-msel-btn:hover,
        #ruMultiFilterRow .ru-msel-btn:focus {
            border-color: #4263c1;
            outline: none;
        }
        #ruMultiFilterRow .ru-msel-btn .ru-msel-label {
            min-width: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        #ruMultiFilterRow .ru-msel-btn .ru-msel-count {
            flex: 0 0 auto;
            padding: 1px 7px;
            border-radius: 10px;
            background: #4263c1;
            color: #fff;
            font-size: 10px;
            font-weight: 600;
        }
        #ruMultiFilterRow .ru-msel-btn .ru-msel-chev {
            flex: 0 0 auto;
            color: #6b7280;
            font-size: 10px;
            line-height: 1;
        }
        #ruMultiFilterRow .ru-msel-btn .ru-msel-chev i { font-size: 10px; }
        #ruMultiFilterRow .ru-msel-panel {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            z-index: 2055;
            display: none;
            width: 100%;
            min-width: 220px;
            max-height: 260px;
            padding: 8px;
            overflow-y: auto;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: #fff;
            box-shadow: 0 8px 24px rgba(20,30,50,.14);
        }
        #ruMultiFilterRow .ru-msel-panel.open { display: block; }
        #ruMultiFilterRow .ru-msel-search {
            position: sticky;
            top: -8px;
            z-index: 2;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 6px;
            padding: 6px 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            font-size: 11.5px;
        }
        #ruMultiFilterRow .ru-msel-search:focus {
            border-color: #4263c1;
            outline: none;
        }
        #ruMultiFilterRow .ru-msel-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
            padding: 6px 8px;
            border-radius: 4px;
            color: #374151;
            font-size: 11.5px;
            font-weight: 400;
            cursor: pointer;
        }
        #ruMultiFilterRow .ru-msel-row:hover { background: #f1f5f9; }
        #ruMultiFilterRow .ru-msel-row input { margin: 0; }
        /*Added by Aditya J. on 09-09-2026<Style the page-level Select placeholder row in filter dropdowns>*/
        #ruMultiFilterRow .ru-msel-placeholder-row {
            padding: 4px 8px 6px;
            color: #6b7280;
            font-size: 11.5px;
            font-weight: 600;
        }
        /*End of Added by Aditya J. on 09-09-2026<Style the page-level Select placeholder row in filter dropdowns>*/
        #ruMultiFilterRow .ru-msel-empty {
            padding: 10px 8px;
            color: #6b7280;
            font-size: 11.5px;
            text-align: center;
        }
        #ruMultiFilterRow .ru-msel-actions {
            position: sticky;
            bottom: -8px;
            display: flex;
            justify-content: space-between;
            margin-top: 6px;
            padding: 4px 6px 2px;
            border-top: 1px solid #e5e7eb;
            background: #fff;
        }
        #ruMultiFilterRow .ru-msel-actions button {
            padding: 4px;
            border: 0;
            background: none;
            color: #4263c1;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
        }
        /*End of Updated by Aditya J. on 07-09-2026*/

        /*Added by Aditya J. on 09-09-2026<Reduced Resource Utilization filter section size and added Snapshot As Of Now note>*/
        #ruMultiFilterRow {
            padding-top: 0 !important;
            padding-bottom: 2px !important;
        }
        #ruMultiFilterRow .row {
            margin-bottom: 0;
        }
        #ruMultiFilterRow .form-group {
            margin-bottom: 4px !important;
        }
        #ruMultiFilterRow label.mb-1 {
            margin-bottom: 2px !important;
            font-size: 12px;
            line-height: 1.2;
        }
        #ruMultiFilterRow .ru-msel-btn {
            height: 28px;
            padding: 2px 8px;
        }
        #ruMultiFilterRow .ru-snapshot-note {
            color: #dc3545;
            font-size: 12px;
            font-weight: 600;
            margin: 2px 0 4px;
        }
        /*End of Added by Aditya J. on 09-09-2026<Reduced Resource Utilization filter section size and added Snapshot As Of Now note>*/

    </style>

</head>
<body>
    <form id="form1" runat="server">
    <%--Removed by Aditya J. on 09-09-2026<Do not check m_blnViewAccess on Resource Utilization page>--%>
        <div id="RuPagePreloader" class="preloader" aria-label="Loading"></div>
        <div class="loader-overlay" id="loaderOverlay" style="display:none;"><div class="loader"></div></div>
        
    <div id="RuPageWrapper" class="bgwhite management-dashboard-page" style="display:none;">

            <div class="management-dashboard-current-page">
                <div>
                    <h3 class="management-dashboard-current-title">
                        <i class="fas fa-user-clock" data-bs-toggle="tooltip" title="Resource Utilization"></i>
                        Resource Utilization
                    </h3>
                    <p class="management-dashboard-current-note">Track resource allocation, utilization, and reporting period summaries.</p>
                </div>
            </div>

            <!--Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters-->
            <!--Updated on 04-09-2026: Period moved to its own row directly under Business Groups; BG/OU/DU/Resource now share a 4-wide row; each control tagged .ru-multiselect so the checkbox/search/Clear/Close popup styling targets only these filters-->
            <!--Updated by Aditya J. on 07-09-2026: swapped the bootstrap-select ("checkmark") popup for a native checkbox-list popup (renderRuMultiSelect/refreshSelect in the script below), matching the ppc-filter-bar .msel widget on ProjectProfitByCustomer.aspx-->
            <div class="container-fluid pt-1 pb-1" id="ruMultiFilterRow">
                <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-3 form-group mb-2">
                        <label class="mb-1">Business Group</label>
                        <select id="ruBUID" class="ru-multiselect" multiple title="Select Business Group"></select>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-3 form-group mb-2">
                        <label class="mb-1">Organization Unit</label>
                        <select id="ruOUID" class="ru-multiselect" multiple title="Select Organization Unit"></select>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-3 form-group mb-2">
                        <label class="mb-1">Delivery Unit</label>
                        <select id="ruDUID" class="ru-multiselect" multiple title="Select Delivery Unit"></select>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-3 form-group mb-2">
                        <label class="mb-1">Resource</label>
                        <select id="ruEmployeeID" class="ru-multiselect" multiple title="Select Resource"></select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-3 form-group mb-2">
                        <label class="mb-1">Period</label>
                        <!--Updated by Aditya J. on 08-09-2026: removed the "multiple" attribute so Period renders as a single-select radio-button popup (matching PPCSelectPeriod on ProjectProfitByCustomer.aspx) instead of a multi-select checkbox popup - renderRuMultiSelect() already switches its rows between radio/checkbox based on $el.prop('multiple'), so no script changes were needed-->
                        <select id="ruDateRange" class="ru-multiselect" title="Select Period"></select>
                    </div>
                </div>
                <!--Added by Aditya J. on 09-09-2026<Added Snapshot As Of Now note below the Resource Utilization filters>-->
                <!--Updated by Aditya J. on 09-09-2026<Bind Snapshot As Of from GetResourceUtilizationDetails snapshotDate>-->
                <p class="ru-snapshot-note">Last Updated : <span id="ruSnapshotDate">-</span></p>
                <!--End of Updated by Aditya J. on 09-09-2026<Bind Snapshot As Of from GetResourceUtilizationDetails snapshotDate>-->
                <!--End of Added by Aditya J. on 09-09-2026<Added Snapshot As Of Now note below the Resource Utilization filters>-->
            </div>
            <!--End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters-->


       
            
            <div class="innerpgiframe">
                <!--filter panel-->
                <div id="filterpanel" class="filterpanel collapse">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">                                
                                <li class="">
                                    <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                                </li>
                            </ul>
                        </div>
                        <div class="Fwrapper">
                            <div class="tab-content">
                                <div id="basicfilters" class="tab-pane">
                                    <div class="filterpanelbody">                                       
                                        <br />
                                        <div class="row">
                                            <!--Removed by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters - Business Group, Organization Unit, Delivery Unit, Resource and Period moved to the always-visible multi-select filter row above (#ruMultiFilterRow) as multi-select checkbox dropdowns, reusing the same #ruBUID/#ruOUID/#ruDUID/#ruEmployeeID/#ruDateRange ids that the existing JS (buildFilterPayload/updateFilterMeta/loadDateRanges) already targets, so the ids are not duplicated on the page-->
                                            <!--End of Removed by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters-->
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Department</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                                <option>Select Department</option>
                                                                <option>Delivery And Oprations</option>
                                                                <option>Finance</option>
                                                                <option>HRMS</option>
                                                                <option>Management</option>
                                                                <option>Support</option>
                                                                <option>Technical Support</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Deployable</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <select id="ruDeployable" class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                                <option value="">Select Option</option>
                                                                <option value="Y">Yes</option>
                                                                <option value="N">No</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Resource Pool</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                                <option>Select Resource Pool</option>
                                                                <option>John</option>
                                                                <option>Abhi</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="text-center mt-1">
                                            <a href="javascript:;" class="btn borderbtn generateBtn">Generate Report</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end filter panel-->
                <div class="clearfix"></div>
                <div class=" container-fluid pt-1 pb-1">
                    <div class="row">
                        <div class="col-sm-4 form-inline">
                            <p>Resource Utilization Report (By Resource)</p>
                        </div>

                        <div class="col-sm-8 text-end">
                            <!--Added by Aditya J. on 09-09-2026<Corrected Display Summary button spelling>-->
                            <a href="javascript:;" class="btn borderbtn" id="btnRuDisplaySummary" data-bs-toggle="offcanvas" data-bs-target="#ProRsrsDisplaySummurymodal">Display Summary</a>
                            <!--End of Added by Aditya J. on 09-09-2026<Corrected Display Summary button spelling>-->
                            <a href="javascript:;" class="btn borderbtn" id="btnRuDisplayDetails" data-bs-toggle="offcanvas" data-bs-target="#ProRsrsDisplayDetailsmodal">Display Details</a>
                            <a href="javascript:;" class="btn borderbtn ruShowDeployableToggle" id="btnRuShowDeployable">Show Deployable</a>
                        </div>


                    </div>
                </div>

                <div class="content pt-0">
                    <hr style="margin:10px 0;" />
                    <div class="row">
                        <div class="col-sm-8">
                            <div class="RUReportGraph">
                                <canvas id="ResUtilizationChart" width="700" height="300"></canvas>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <table class="table table-stripped table-bordered utlizationtbl">
                                <tbody id="ruFilterMetaBody">
                                    <tr>
                                        <th>Business Group</th>
                                        <td id="ruMetaBG">-</td>
                                    </tr>
                                    <tr>
                                        <th>Organization Unit</th>
                                        <td id="ruMetaOU">-</td>
                                    </tr>
                                    <tr>
                                        <th>Delivery Unit</th>
                                        <td id="ruMetaDU">-</td>
                                    </tr>
                                    <tr>
                                        <th>Resource</th>
                                        <td id="ruMetaResource">-</td>
                                    </tr>
                                    <tr>
                                        <th>Period</th>
                                        <td id="ruMetaPeriod">-</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <br/>
                    <div class="notebox graybg">
                        <p><strong>Note : </strong></p>
                        <ul>
                            <li><strong>Available Hrs -</strong> These are are max hours for which resources can work (excluding holiday and leave hours)</li>
                            <li><strong>Planned Hrs -</strong> These are the hours for which resources are allocated to tasks on the projects</li>
                            <li><strong>Actual Hrs -</strong> These are the actual hours for which resources have filled daily activity for the tasks on the projects</li>
                            <li><strong>Billable Hrs -</strong> These are the actual hours for which resources have filled daily activity for the tasks which are billable on the projects</li>
                            <!--commented and added by Aditya J. on 10-09-2026 for Changing caption Bench Hrs % to Probable Bench Hrs %-->
                            <!--<li><strong>Bench Hrs -</strong> These are hours for which resources are not assigned to any project</li>-->
                            <!--End of commented and added by Aditya J. on 10-09-2026 for Changing caption Bench Hrs % to Probable Bench Hrs %-->
                            <!--Added by Aditya J. on 10-09-2026 for Changing caption Bench Hrs % to Probable Bench Hrs %-->
                            <!--Added by Aditya J. on 15-09-2026 for Updating Probable Bench Hrs % note-->
                            <li><strong>Probable Bench Hrs % -</strong> Allocation 0%: Bench Hours = 100%. Allocation 1–50%: Bench Hours = 50%. Allocation &gt;50%: Bench Hours = 0%. BG/OU-wise Bench Hours: Average Bench Hours % of all respective resources.</li>
                            <!--End of Added by Aditya J. on 15-09-2026 for Updating Probable Bench Hrs % note-->
                            <!--End of Added by Aditya J. on 10-09-2026 for Changing caption Bench Hrs % to Probable Bench Hrs %-->
                        </ul>
                    </div>

                    <div class="clearfix"></div>



                </div>

            </div>
            <div class="clearfix"></div>
    

        <!-- Save filter Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="Issuesavefilter" aria-labelledby="IssuesavefilterLabel">
    <div class="graybg container-fluid py-1 mb-2">
        <div class="row align-items-center">
            <div class="col-sm-10"><h5 class="pgtitle mb-0" id="IssuesavefilterLabel">Save Filter As</h5></div>
            <div class="col-sm-2 text-end">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <div class="offcanvas-body">
<div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name=""><br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                    <button data-bs-dismiss="offcanvas" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    
    </div>
</div>
        <!-- Save filter Modal End here-->
        <!-- Display Summury Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="ProRsrsDisplaySummurymodal" aria-labelledby="ProRsrsDisplaySummurymodalLabel">
    <div class="graybg container-fluid py-1 mb-2">
        <div class="row align-items-center">
            <div class="col-sm-10"><h5 class="pgtitle mb-0" id="ProRsrsDisplaySummurymodalLabel">Resource Utilization Report (By Resource)</h5></div>
            <div class="col-sm-2 text-end">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <div class="offcanvas-body">
<div class="text-end">
                            <a href="javascript:;" class="btn borderbtn ruShowDeployableToggle" data-bs-toggle="tooltip" data-bs-original-title="show deployable resource only">Show Deployable</a>
                            <!--<a href="javascript:;" class="btn borderbtn">Print</a>-->
                            <!-- Added by Aditya J. on 25-08-2026 for Resource Utilization Report -->
                            <div class="dropdown filedownload pull-right ml-1" style="margin-top:5px;">
                                <button type="button" id="ruExportSummaryBtn" class="nostylebtn ruExportPdf" data-details="2" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Download Report"><i class="fas fa-download"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="javascript:;" id="ruExportPdfSummary" class="ruExportPdf" data-details="2"><img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                </ul>
                            </div>
                            <!-- End of Added by Aditya J. on 25-08-2026 for Resource Utilization Report -->
                        </div>
                        <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
                        <table id="tblRuSummaryMeta" class="informationtbl mb-0">
                            <tbody id="ruSummaryMetaBody">
                                <tr>
                                    <th>Business Group</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruSumMetaBG">-</td>
                                    <th>Organization Unit</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruSumMetaOU">-</td>
                                </tr>
                                <tr>
                                    <th>Delivery Unit</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruSumMetaDU">-</td>
                                    <th>Resource</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruSumMetaResource">-</td>
                                </tr>
                                <tr>
                                    <th>Period</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruSumMetaPeriod">-</td>
                                    <th></th>
                                    <td class="colan"></td>
                                    <td class="pr-3 text-start"></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="table-responsive">
                            <table id="ruSummaryTable" class="table table-stripped table-bordered mb-0">
                                <thead>
                                    <tr>
                                        <th>Month</th>
                                        <th>Hrs</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                    </tr>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>Install Capacity</th>
                                        <th colspan="2">Available</th>
                                        <th colspan="2">Planned</th>
                                        <th colspan="2">Actual</th>
                                        <th colspan="2">Billable</th>
                                    </tr>
                                </thead>
                                <tbody id="ruSummaryBody">
                                    <tr><td colspan="10" class="text-center text-muted">Click Generate Report, then open Display Summary.</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <!--<div class="text-center"><a href="javascript:;" class="btn borderbtn">Print</a></div>-->

                    
    </div>
</div>
        <!-- Display Summury Modal End here-->

        <!-- Display Details Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="ProRsrsDisplayDetailsmodal" aria-labelledby="ProRsrsDisplayDetailsmodalLabel">
    <div class="graybg container-fluid py-1 mb-2">
        <div class="row align-items-center">
            <div class="col-sm-10"><h5 class="pgtitle mb-0" id="ProRsrsDisplayDetailsmodalLabel">Resource Utilization Report (By Resource)</h5></div>
            <div class="col-sm-2 text-end">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <div class="offcanvas-body">
<div class="text-end">
                            <a href="javascript:;" class="btn borderbtn ruShowDeployableToggle" data-bs-toggle="tooltip" data-bs-original-title="show deployable resource only">Show Deployable</a>
                            <!-- Added by Aditya J. on 25-08-2026 for Resource Utilization Report -->
                            <div class="dropdown filedownload pull-right ml-1" style="margin-top:5px;">
                                <button type="button" id="ruExportDetailsBtn" class="nostylebtn ruExportPdf" data-details="2" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Download Report"><i class="fas fa-download"></i></button>
                                <ul class="dropdown-menu">
                                    <li><a href="javascript:;" id="ruExportPdfDetails" class="ruExportPdf" data-details="2"><img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                </ul>
                            </div>
                            <!-- End of Added by Aditya J. on 25-08-2026 for Resource Utilization Report -->
                        </div>
                        <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
                        <table id="tblRuDetailsMeta" class="informationtbl mb-0">
                            <tbody id="ruDetailsMetaBody">
                                <tr>
                                    <th>Business Group</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruDetMetaBG">-</td>
                                    <th>Organization Unit</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruDetMetaOU">-</td>
                                </tr>
                                <tr>
                                    <th>Delivery Unit</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruDetMetaDU">-</td>
                                    <th>Resource</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruDetMetaResource">-</td>
                                </tr>
                                <tr>
                                    <th>Period</th>
                                    <td class="colan">:</td>
                                    <td class="pr-3 text-start" id="ruDetMetaPeriod">-</td>
                                    <th></th>
                                    <td class="colan"></td>
                                    <td class="pr-3 text-start"></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="table-responsive">
                            <table id="ruDetailsTable" class="table table-stripped table-bordered mb-0">
                                <thead>
                                    <tr>
                                        <th>Month</th>
                                        <th>Resource</th>
                                        <th>Hrs</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                        <th>Hrs</th>
                                        <th>%</th>
                                    </tr>
                                    <tr>
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>Install Capacity</th>
                                        <th colspan="2">Available</th>
                                        <th colspan="2">Planned</th>
                                        <th colspan="2">Actual</th>
                                        <th colspan="2">Billable</th>
                                    </tr>
                                </thead>
                                <tbody id="ruDetailsBody">
                                    <tr><td colspan="11" class="text-center text-muted">Click Generate Report, then open Display Details.</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <!--<div class="text-center"><a href="javascript:;" class="btn borderbtn">Print</a></div>-->

                    
    </div>
</div>
        <!-- Display Details Modal End here-->
        

        <div class="clearfix"></div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 3.7.1 -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- bootstrap-select (after Bootstrap) -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <script>

        document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {
            if (window.bootstrap && bootstrap.Tooltip) {
                new bootstrap.Tooltip(el, { container: 'body', customClass: 'black-tooltip' });
            }
        });

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $(".profiencyTbllist, .backbtn, .addbtn, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $(".profiencyTbllist, .backbtn, .addbtn, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });

                function initDashboardSelectPicker() {
            if (!$.fn.selectpicker) return;
            //Updated on 04-09-2026: skip .ru-multiselect (Business Groups/Organization Unit/Delivery
            //Unit/Resource/Period) here - they are initialized exclusively by refreshSelect() once their
            //options are loaded, so they get the checkbox/search/Select All/Clear/Close config instead of
            //being grabbed first (while still empty) with these plain settings.
            $('select').not('.ru-multiselect').each(function () {
                var $select = $(this);
                if ($select.data('selectpicker')) {
                    try { $select.selectpicker('refresh'); } catch (e) { }
                    return;
                }
                $select.addClass('selectpicker form-control fixed-width-combo');
                $select.attr('data-live-search', 'true');
                $select.selectpicker({
                    liveSearch: true,
                    container: 'body',
                    dropupAuto: true,
                    width: '100%'
                });
            });
        }


        $(document).ready(function () {
            initDashboardSelectPicker();

            $(".generateBtn").hide();

        });


        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });




        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
            $(".generateBtn").show();
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }

        });


 // Resource Utilization APIs - Added By Madhuri.K
      (function () {
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
        if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);
        var defaultUserID = <%=If(Session("intUserID") Is Nothing, 61, Session("intUserID"))%>;
        //Added by Aditya J. on 26-08-2026
        var ruShowDeployable = { grid: 0, summary: 0, details: 0 };
        //End of Added by Aditya J. on 26-08-2026
        var ruChart = null;
        var ruSummaryPager = { page: 1, size: 5, rows: [] };
        var ruDetailsPager = { page: 1, size: 5, rows: [] };

        function toQuery(params) {
          var parts = [];
          Object.keys(params || {}).forEach(function (k) {
            var v = params[k];
            if (v == null || v === '') return;
            parts.push(encodeURIComponent(k) + '=' + encodeURIComponent(v));
          });
          return parts.length ? ('?' + parts.join('&')) : '';
        }

        function isJson(str) {
          try { JSON.parse(str); } catch (e) { return false; }
          return true;
        }

        function encryptString(value) {
          var intStrArr = [];
          var strEncryptedString = '';
          var intEncryptNum = 1;
          var i;
          if (String(value).length > 0) {
            for (i = 0; i <= value.length - 1; i++) {
              intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
              intEncryptNum = intEncryptNum + 2;
            }
            strEncryptedString = intStrArr.join('-');
            if (String(strEncryptedString).substring(0, 1) == '-') {
              strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1);
            }
          }
          return strEncryptedString;
        }

        function apiHeaders(param) {
          var headers = {
            'Authorization': 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || '')
          };
          if (param) {
            headers['Params'] = encryptString(isJson(param) ? param : JSON.stringify(param));
          }
          return headers;
        }

        function apiVal(obj) {
          if (!obj) return undefined;
          for (var i = 1; i < arguments.length; i++) {
            var k = arguments[i];
            if (obj[k] != null && obj[k] !== '') return obj[k];
            var found = Object.keys(obj).find(function (ok) { return ok.toLowerCase() === String(k).toLowerCase(); });
            if (found != null && obj[found] != null && obj[found] !== '') return obj[found];
          }
          return undefined;
        }

        function apiNum(obj) {
          var v = apiVal.apply(null, arguments);
          //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          if (typeof v === 'string' && /^-?[\d,]+:\d{1,2}$/.test(v.trim())) {
            return parseHoursToMinutes(v) / 60;
          }
          //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          var n = Number(v);
          return isNaN(n) ? 0 : n;
        }

        //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
        function parseHoursToMinutes(v) {
          if (v == null || v === '') return 0;
          if (typeof v === 'number' && isFinite(v)) return Math.round(v * 60);
          var s = String(v).trim();
          var m = s.match(/^(-)?([\d,]+):(\d{1,2})$/);
          if (m) {
            var sign = m[1] ? -1 : 1;
            return sign * (parseInt(String(m[2]).replace(/,/g, ''), 10) * 60 + parseInt(m[3], 10));
          }
          var n = Number(s.replace(/,/g, ''));
          return isFinite(n) ? Math.round(n * 60) : 0;
        }

        //Added by Aditya J. on 31-08-2026<Add comma separators to the hours portion of HH:mm values so large hour totals like 12,852:00 display correctly>
        function ruFormatIntegerWithCommas(n) {
          var num = Number(n);
          if (isNaN(num)) num = 0;
          return num.toLocaleString('en-US');
        }
        //End of Added by Aditya J. on 31-08-2026<Add comma separators to the hours portion of HH:mm values so large hour totals like 12,852:00 display correctly>

        function minutesToHoursDisplay(totalMins) {
          var minsNum = Math.round(Number(totalMins) || 0);
          var sign = minsNum < 0 ? '-' : '';
          var abs = Math.abs(minsNum);
          var hrs = Math.floor(abs / 60);
          var mins = abs % 60;
          //Added by Aditya J. on 31-08-2026<Format the hours part of computed HH:mm totals with comma separators>
          return sign + ruFormatIntegerWithCommas(hrs) + ':' + (mins < 10 ? '0' : '') + mins;
          //End of Added by Aditya J. on 31-08-2026<Format the hours part of computed HH:mm totals with comma separators>
        }

        function formatHoursDisplay(v) {
          if (v == null || v === '') return '0:00';
          var s = String(v).trim();
          var m = s.match(/^(-)?([\d,]+):(\d{1,2})$/);
          if (m) {
            var mins = String(m[3]).length === 1 ? ('0' + m[3]) : m[3];
            //Added by Aditya J. on 31-08-2026<Re-apply comma separators to the hours portion instead of stripping them, so values like "12,852:00" display with commas>
            var hrsWithCommas = ruFormatIntegerWithCommas(String(m[2]).replace(/,/g, ''));
            return (m[1] || '') + hrsWithCommas + ':' + mins;
            //End of Added by Aditya J. on 31-08-2026<Re-apply comma separators to the hours portion instead of stripping them, so values like "12,852:00" display with commas>
          }
          return minutesToHoursDisplay(parseHoursToMinutes(v));
        }

        function apiHours(obj) {
          return formatHoursDisplay(apiVal.apply(null, arguments));
        }

        function apiHoursMinutes(obj) {
          return parseHoursToMinutes(apiVal.apply(null, arguments));
        }
        //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary

        //Added by Aditya J. on 01-09-2026 <Compute per-month subtotals across the full Display Details dataset (not just the current page) and locate each month's last row, so a "Total Work(hrs) for <Month>" row can be shown the same way the base site displays it>
        function ruBuildMonthlyDetailsTotals(rows) {
          var map = {};
          var order = [];
          (rows || []).forEach(function (r) {
            var month = apiVal(r, 'month', 'Month', 'period', 'Period') || '';
            var key = String(month);
            if (!map[key]) {
              map[key] = { label: month, capacity: 0, avail: 0, planned: 0, actual: 0, billable: 0 };
              order.push(key);
            }
            var t = map[key];
            t.capacity += apiHoursMinutes(
              r, 'installCapacityHrs', 'InstallCapacityHrs',
              'installCapacity', 'InstallCapacity',
              'installedCapacity', 'InstalledCapacity'
            );
            t.avail += apiHoursMinutes(r, 'capacityHrs', 'CapacityHrs', 'availableHrs', 'AvailableHrs');
            t.planned += apiHoursMinutes(r, 'allocatedHrs', 'AllocatedHrs', 'plannedHrs', 'PlannedHrs');
            t.actual += apiHoursMinutes(r, 'actualHrs', 'ActualHrs', 'actual', 'Actual');
            t.billable += apiHoursMinutes(r, 'billableHrs', 'BillableHrs', 'billable', 'Billable');
          });
          // Available% is against Install Capacity, and Planned/Actual/Billable% are each against
          // Available, matching the same grand-total percentage logic used elsewhere on this page.
          order.forEach(function (key) {
            var t = map[key];
            t.availPct = t.capacity ? (t.avail / t.capacity * 100) : 0;
            t.plannedPct = t.avail ? (t.planned / t.avail * 100) : 0;
            t.actualPct = t.avail ? (t.actual / t.avail * 100) : 0;
            t.billablePct = t.avail ? (t.billable / t.avail * 100) : 0;
          });
          return map;
        }

        // Returns a map of month-label -> the index (in the full rows array) of that month's LAST row,
        // so the monthly total row is only inserted once, right after the last row of that month.
        function ruBuildMonthLastIndex(rows) {
          var map = {};
          (rows || []).forEach(function (r, i) {
            var month = apiVal(r, 'month', 'Month', 'period', 'Period') || '';
            map[String(month)] = i;
          });
          return map;
        }

        // Builds the "Total Work(hrs) for <Month>" row markup, matching the base site's monthly total
        // row: same column layout as a normal Details row (Install Capacity, Available Hrs/%, Planned
        // Hrs/%, Actual Hrs/%, Billable Hrs/%), styled the same as the existing grand Total row.
        function ruRenderMonthlyDetailsTotalRow(monthTotal) {
          if (!monthTotal) return '';
          var html = '<tr class="totalrow">';
          html += '<td colspan="2">Total Work(hrs) for ' + esc(monthTotal.label) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(monthTotal.capacity)) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(monthTotal.avail)) + '</td><td>' + fmtNum(monthTotal.availPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(monthTotal.planned)) + '</td><td>' + fmtNum(monthTotal.plannedPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(monthTotal.actual)) + '</td><td>' + fmtNum(monthTotal.actualPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(monthTotal.billable)) + '</td><td>' + fmtNum(monthTotal.billablePct) + '</td>';
          html += '</tr>';
          return html;
        }
        //End of Added by Aditya J. on 01-09-2026 <Compute per-month subtotals across the full Display Details dataset (not just the current page) and locate each month's last row, so a "Total Work(hrs) for <Month>" row can be shown the same way the base site displays it>

        function unwrapPayload(json) {
          if (!json) return {};
          var d = json.data != null ? json.data : (json.Data != null ? json.Data : json);
          if (!d || typeof d !== 'object' || Array.isArray(d)) return d || {};
          var inner = d.data != null ? d.data : d.Data;
          if (inner && typeof inner === 'object' && !Array.isArray(inner) &&
              (inner.ResourceUtilizationGraphModel != null || inner.ResourceUtilizationSummaryModel != null ||
               inner.ResourceUtilizationDetailModel != null || inner.ResourceUtilizationDetailsModel != null ||
               inner.ResourceUtilizationDateRangeModel != null ||
               //Added by Aditya J. on 09-09-2026<Recognise cascading filter API payload in unwrapPayload>
               inner.ResourceUtilizationDependentFilterModel != null ||
               //End of Added by Aditya J. on 09-09-2026<Recognise cascading filter API payload in unwrapPayload>
               apiVal(inner, 'ResourceUtilizationGraphModel', 'ResourceUtilizationSummaryModel',
                 'ResourceUtilizationDetailModel', 'ResourceUtilizationDetailsModel', 'ResourceUtilizationDateRangeModel',
                 //Added by Aditya J. on 09-09-2026<Recognise cascading filter API payload in unwrapPayload>
                 'ResourceUtilizationDependentFilterModel',
                 //End of Added by Aditya J. on 09-09-2026<Recognise cascading filter API payload in unwrapPayload>
                 'DateRangeModel'))) {
            return inner;
          }
          return d;
        }

        function extractModelList(data) {
          var names = Array.prototype.slice.call(arguments, 1);
          if (!data) return [];
          if (Array.isArray(data)) return data;
          for (var i = 0; i < names.length; i++) {
            var rows = apiVal(data, names[i]);
            if (Array.isArray(rows)) return rows;
            if (rows && typeof rows === 'object') return [rows];
          }
          return [];
        }

        function fmtNum(v) {
          var n = Number(v);
          if (isNaN(n)) return '0.00';
          return n.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        //Added by Aditya J. on 10-09-2026 for Displaying Probable Bench Hrs % blank when the value is 0 or missing
        function fmtProbableBench(v) {
          if (v === null || v === undefined || v === '') return '';
          var n = Number(v);
          if (isNaN(n) || n === 0) return '';
          return n.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        function ruProbableBenchValue(r) {
          var v = apiVal(r, 'probableBenchHrsPercent', 'ProbableBenchHrsPercent', 'benchHrsPercent', 'BenchHrsPercent');
          if (v === null || v === undefined || v === '') return null;
          var n = Number(v);
          return isNaN(n) ? null : n;
        }
        //End of Added by Aditya J. on 10-09-2026 for Displaying Probable Bench Hrs % blank when the value is 0 or missing

        function esc(s) {
          return String(s == null ? '' : s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function selectedText($el) {
          if (!$el || !$el.length) return '-';
          var t = $.trim($el.find('option:selected').text() || '');
          if (!t || /^select/i.test(t)) return '-';
          return t;
        }

        //Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters
        // Returns [{id, text}, ...] for every selected option in a (possibly multi-select) dropdown.
        function ruSelectedOptions($el) {
          if (!$el || !$el.length) return [];
          var items = [];
          $el.find('option:selected').each(function () {
            var $o = $(this);
            var val = $o.val();
            if (val == null || val === '' || val === '0') return;
            items.push({ id: val, text: $.trim($o.text() || '') });
          });
          return items;
        }

        // CSV of every selected option's id - sent to the multi-value BUID/OUID/DUID/EmployeeID
        // parameters on usp_SEL_Whizible2_ResourceUtilizationByResource.
        function ruSelectedIdsCsv($el) {
          return ruSelectedOptions($el).map(function (o) { return o.id; }).join(',');
        }

        //Added by Aditya J. on 10-09-2026<CSV of selected filter labels for the PDF header>
        function ruSelectedNamesCsv($el) {
          return ruSelectedOptions($el).map(function (o) { return o.text; }).filter(function (t) { return t; }).join(', ');
        }
        //End of Added by Aditya J. on 10-09-2026<CSV of selected filter labels for the PDF header>

        // Period (@DateRange) is still a single value end-to-end, so this returns just the first
        // checked option's id - used only for #ruDateRange. BUID/OUID/DUID/EmployeeID now send every
        // checked value (see ruSelectedIdsCsv / buildFilterPayload) since the SP accepts CSV lists.
        function ruFirstSelectedId($el) {
          var opts = ruSelectedOptions($el);
          return opts.length ? (parseInt(opts[0].id, 10) || 0) : 0;
        }

        // Renders a filter-meta <td> as "-" / "v1" / "v1, v2" / "v1, v2 +3 more" (tooltip on the "+N more").
        function ruRenderMetaCell($td, items) {
          if (!$td || !$td.length) return;
          $td.empty();
          if (!items || !items.length) { $td.text('-'); return; }
          var texts = items.map(function (o) { return o.text; });
          if (texts.length <= 2) { $td.text(texts.join(', ')); return; }
          $td.append(document.createTextNode(texts.slice(0, 2).join(', ') + ' '));
          var rest = texts.slice(2);
          var $more = $('<span class="ru-more-filters" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true"></span>')
            .text('+' + rest.length + ' more')
            .attr('title', rest.map(esc).join('<br>'));
          $td.append($more);
          if (window.bootstrap && bootstrap.Tooltip) {
            new bootstrap.Tooltip($more[0], { container: 'body', customClass: 'black-tooltip' });
          }
        }
        //End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters

        //Updated by Aditya J. on 07-09-2026: replaced the bootstrap-select-based refreshSelect() with a native
        //checkbox-list popup widget (button + search + checkbox rows + Clear/Close footer), matching the
        //ppc-filter-bar .msel widget used on ProjectProfitByCustomer.aspx for the Business Groups filter -
        //renders on top of the same hidden <select multiple> elements so buildFilterPayload/updateFilterMeta/
        //ruSelectedOptions (which all read option:selected) keep working unchanged.
        var ruOpenMultiSelectId = null;
        var ruMultiSelectSearch = {};

        function closeRuMultiSelects(exceptId) {
          $('#ruMultiFilterRow .ru-msel-panel.open').each(function () {
            var id = $(this).closest('.ru-msel').attr('data-select-id');
            if (!exceptId || id !== exceptId) $(this).removeClass('open');
          });
          if (!exceptId) ruOpenMultiSelectId = null;
        }

        function renderRuMultiSelect($el) {
          if (!$el || !$el.length) return;
          var selectId = $el.attr('id');
          var isMultiple = !!$el.prop('multiple');
          var placeholder = $el.attr('title') || 'Select';
          var $host = $el.next('.ru-msel-host');

          if (!$host.length) {
            $host = $('<div class="ru-msel ru-msel-host"></div>')
              .attr('data-select-id', selectId)
              .insertAfter($el);
          }

          var selected = [];
          $el.find('option:selected').each(function () {
            if (this.value === '' && !isMultiple) return;
            selected.push({ value: String(this.value), text: $(this).text() });
          });

          var buttonText = placeholder;
          if (selected.length === 1) buttonText = selected[0].text;
          else if (selected.length > 1) buttonText = 'Selected';

          $host.empty();
          var $button = $('<button type="button" class="ru-msel-btn"></button>');
          $('<span class="ru-msel-label"></span>').text(buttonText).appendTo($button);
          if (isMultiple && selected.length > 1) {
            $('<span class="ru-msel-count"></span>').text(selected.length).appendTo($button);
          } else {
            $('<span class="ru-msel-chev"><i class="fas fa-chevron-down"></i></span>').appendTo($button);
          }

          var $panel = $('<div class="ru-msel-panel"></div>');
          if (ruOpenMultiSelectId === selectId) $panel.addClass('open');
          var $search = $('<input type="text" class="ru-msel-search" />')
            .attr('placeholder', 'Search ' + placeholder.replace(/^Select\s+/i, '') + '...')
            .val(ruMultiSelectSearch[selectId] || '');
          var $rows = $('<div class="ru-msel-rows"></div>');
          var $empty = $('<div class="ru-msel-empty">No matches</div>').hide();

          $el.find('option').each(function () {
            var option = this;
            if (!isMultiple && String(option.value) === '') return;
            var label = $(option).text();
            //Added by Aditya J. on 09-09-2026<Show page-level Select placeholder as a non-selectable first row>
            if (String(option.value) === '0' || /^select\s/i.test($.trim(label))) {
              $('<div class="ru-msel-placeholder-row"></div>').text(label).appendTo($rows);
              return;
            }
            //End of Added by Aditya J. on 09-09-2026<Show page-level Select placeholder as a non-selectable first row>
            var $row = $('<label class="ru-msel-row"></label>')
              .attr('data-label', label.toLowerCase());
            var $input = $('<input />')
              .attr('type', isMultiple ? 'checkbox' : 'radio')
              .attr('name', 'ru-msel-' + selectId)
              .prop('checked', option.selected);
            $input.on('change', function () {
              if (isMultiple) {
                $(option).prop('selected', this.checked);
              } else {
                $el.val(String(option.value));
              }
              ruOpenMultiSelectId = selectId;
              //Added by Aditya J. on 09-09-2026<Keep dropdown scroll position after selecting a filter value>
              ruSyncMultiSelectButton($el);
              //End of Added by Aditya J. on 09-09-2026<Keep dropdown scroll position after selecting a filter value>
              $el.trigger('change');
            });
            $row.append($input).append($('<span></span>').text(label));
            $rows.append($row);
          });

          function applySearch() {
            var term = String($search.val() || '').trim().toLowerCase();
            var visible = 0;
            $rows.find('.ru-msel-row').each(function () {
              var show = !term || String($(this).attr('data-label')).indexOf(term) > -1;
              $(this).toggle(show);
              if (show) visible++;
            });
            $empty.toggle(visible === 0);
          }

          $search.on('input', function () {
            ruMultiSelectSearch[selectId] = this.value;
            applySearch();
          });

          var $actions = $('<div class="ru-msel-actions"></div>');
          $('<button type="button">Clear</button>').on('click', function () {
            if (isMultiple) {
              $el.find('option').prop('selected', false);
            } else {
              $el.val('');
            }
            ruMultiSelectSearch[selectId] = '';
            ruOpenMultiSelectId = selectId;
            //Added by Aditya J. on 09-09-2026<Keep dropdown open and uncheck rows in place on Clear>
            $search.val('');
            $panel.find('.ru-msel-row input').prop('checked', false);
            $rows.find('.ru-msel-row').show();
            $empty.hide();
            ruSyncMultiSelectButton($el);
            //End of Added by Aditya J. on 09-09-2026<Keep dropdown open and uncheck rows in place on Clear>
            $el.trigger('change');
          }).appendTo($actions);
          $('<button type="button">Close</button>').on('click', function () {
            ruOpenMultiSelectId = null;
            $panel.removeClass('open');
          }).appendTo($actions);

          $panel.append($search, $rows, $empty, $actions);
          $host.append($button, $panel);
          applySearch();

          $button.on('click', function (e) {
            e.stopPropagation();
            if (ruOpenMultiSelectId === selectId) {
              ruOpenMultiSelectId = null;
              $panel.removeClass('open');
            } else {
              ruOpenMultiSelectId = selectId;
              closeRuMultiSelects(selectId);
              $panel.addClass('open');
              $search.trigger('focus');
            }
          });
          $panel.on('click', function (e) { e.stopPropagation(); });
        }

        //Added by Aditya J. on 09-09-2026<Update filter button text without rebuilding the open dropdown list>
        function ruSyncMultiSelectButton($el) {
          if (!$el || !$el.length) return;
          var $host = $el.next('.ru-msel-host');
          if (!$host.length) return;
          var isMultiple = !!$el.prop('multiple');
          var placeholder = $el.attr('title') || 'Select';
          var selected = [];
          $el.find('option:selected').each(function () {
            if (this.value === '' && !isMultiple) return;
            selected.push({ value: String(this.value), text: $(this).text() });
          });
          var buttonText = placeholder;
          if (selected.length === 1) buttonText = selected[0].text;
          else if (selected.length > 1) buttonText = 'Selected';
          $host.find('.ru-msel-label').text(buttonText);
          $host.find('.ru-msel-count, .ru-msel-chev').remove();
          var $button = $host.find('.ru-msel-btn');
          if (isMultiple && selected.length > 1) {
            $('<span class="ru-msel-count"></span>').text(selected.length).appendTo($button);
          } else {
            $('<span class="ru-msel-chev"><i class="fas fa-chevron-down"></i></span>').appendTo($button);
          }
        }
        //End of Added by Aditya J. on 09-09-2026<Update filter button text without rebuilding the open dropdown list>

        function refreshSelect($el) {
          if (!$el || !$el.length) return;
          renderRuMultiSelect($el);
        }

        $(document).off('click.ruMsel').on('click.ruMsel', function () {
          closeRuMultiSelects();
        });
        //End of Updated by Aditya J. on 07-09-2026

        function buildFilterPayload(options) {
          options = options || {};
          //Updated on 04-09-2026 - usp_SEL_Whizible2_ResourceUtilizationByResource now accepts comma-separated
          //id lists for @intBUID/@intOUID/@intDUID/@intEmployeeID, so send every checked value from each
          //multi-select dropdown instead of only the first. Period (@DateRange) stays a single value.
          var payload = {
            DateRange: ruFirstSelectedId($('#ruDateRange')),
            UserID: defaultUserID
          };
          var buid = ruSelectedIdsCsv($('#ruBUID'));
          var ouid = ruSelectedIdsCsv($('#ruOUID'));
          var duid = ruSelectedIdsCsv($('#ruDUID'));
          var empId = ruSelectedIdsCsv($('#ruEmployeeID'));
          //End of Updated on 04-09-2026
          if (buid) payload.BUID = buid;
          if (ouid) payload.OUID = ouid;
          if (duid) payload.DUID = duid;
          if (empId) payload.EmployeeID = empId;
          //Added by Aditya J. on 26-08-2026
          payload.ShowDeployableOnly = (parseInt(options.showDeployableOnly, 10) === 1) ? 1 : 0;
          if (options.details != null && options.details !== '') {
            payload.Details = parseInt(options.details, 10);
          }
          //End of Added by Aditya J. on 26-08-2026
          return payload;
        }

        function updateFilterMeta() {
          //Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters - display every selected value (not just one), truncated to 2 + "N more" with a tooltip
          var bg = ruSelectedOptions($('#ruBUID'));
          var ou = ruSelectedOptions($('#ruOUID'));
          var du = ruSelectedOptions($('#ruDUID'));
          var res = ruSelectedOptions($('#ruEmployeeID'));
          var period = ruSelectedOptions($('#ruDateRange'));
          $('#ruMetaBG, #ruSumMetaBG, #ruDetMetaBG').each(function () { ruRenderMetaCell($(this), bg); });
          $('#ruMetaOU, #ruSumMetaOU, #ruDetMetaOU').each(function () { ruRenderMetaCell($(this), ou); });
          $('#ruMetaDU, #ruSumMetaDU, #ruDetMetaDU').each(function () { ruRenderMetaCell($(this), du); });
          $('#ruMetaResource, #ruSumMetaResource, #ruDetMetaResource').each(function () { ruRenderMetaCell($(this), res); });
          $('#ruMetaPeriod, #ruSumMetaPeriod, #ruDetMetaPeriod').each(function () { ruRenderMetaCell($(this), period); });
          //End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters
        }

        //Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource multi-select filters
        //Updated by Aditya J. on 09-09-2026<Bound BG/OU/DU/Resource dropdowns to the generic cascading filter API>
        // Shared loader for the 4 lookup dropdowns - all follow the same "fetch -> build <option>s -> refresh selectpicker" shape already used by loadDateRanges() below.
        function ruLoadFilterOptions($sel, apiPath, modelNames, idKeys, nameKeys, queryPayload) {
          var prevIds = {};
          ruSelectedOptions($sel).forEach(function (o) { prevIds[String(o.id)] = true; });
          var qs = queryPayload ? toQuery(queryPayload) : '';
          return fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/' + apiPath + qs, {
            method: 'GET',
            headers: apiHeaders(queryPayload)
          })
          .then(function (res) {
            if (!res.ok) throw new Error(apiPath + ' failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = extractModelList.apply(null, [data].concat(modelNames));
            //Added by Aditya J. on 09-09-2026<Add Select placeholder on the page instead of from the dependent filter SP>
            var html = '<option value="0">' + esc($sel.attr('title') || 'Select') + '</option>';
            (rows || []).forEach(function (r) {
              var id = apiVal.apply(null, [r].concat(idKeys));
              if (id == null || id === '' || String(id) === '0') return;
              var name = apiVal.apply(null, [r].concat(nameKeys));
              if (name == null || name === '') name = id;
              if (/^select\s/i.test(String(name))) return;
              html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
            });
            //End of Added by Aditya J. on 09-09-2026<Add Select placeholder on the page instead of from the dependent filter SP>
            $sel.html(html);
            if (Object.keys(prevIds).length) {
              $sel.find('option').each(function () {
                if (prevIds[String(this.value)]) $(this).prop('selected', true);
              });
            }
            refreshSelect($sel);
          })
          .catch(function (err) {
            console.error(err);
            refreshSelect($sel);
          });
        }

        function ruDependentFilterPayload(filterType) {
          var payload = { FilterType: filterType, UserID: defaultUserID };
          var t = String(filterType || '').toUpperCase();
          if (t !== 'BG') {
            var buid = ruSelectedIdsCsv($('#ruBUID'));
            if (buid) payload.BUID = buid;
          }
          if (t === 'DU' || t === 'RES') {
            var ouid = ruSelectedIdsCsv($('#ruOUID'));
            if (ouid) payload.OUID = ouid;
          }
          if (t === 'RES') {
            var duid = ruSelectedIdsCsv($('#ruDUID'));
            if (duid) payload.DUID = duid;
          }
          return payload;
        }

        function ruLoadDependentFilter($sel, filterType) {
          return ruLoadFilterOptions(
            $sel,
            'GetResourceUtilizationDependentFilters',
            ['ResourceUtilizationDependentFilterModel', 'resourceUtilizationDependentFilterModel'],
            ['id', 'ID'],
            ['name', 'Name'],
            ruDependentFilterPayload(filterType)
          );
        }

        function loadBusinessGroups() {
          return ruLoadDependentFilter($('#ruBUID'), 'BG');
        }

        function loadOrganizationUnits() {
          return ruLoadDependentFilter($('#ruOUID'), 'OU');
        }

        function loadDeliveryUnits() {
          return ruLoadDependentFilter($('#ruDUID'), 'DU');
        }

        function loadResources() {
          return ruLoadDependentFilter($('#ruEmployeeID'), 'RES');
        }

        function ruRefreshDependentReports() {
          updateFilterMeta();
          loadGraph();
          if ($('#ProRsrsDisplaySummurymodal').hasClass('show')) loadSummary();
          if ($('#ProRsrsDisplayDetailsmodal').hasClass('show')) loadDetails();
          //Added by Aditya J. on 09-09-2026<Refresh Snapshot As Of from GetResourceUtilizationDetails when filters change>
          else loadSnapshotDate();
          //End of Added by Aditya J. on 09-09-2026<Refresh Snapshot As Of from GetResourceUtilizationDetails when filters change>
        }

        //Added by Aditya J. on 09-09-2026<Clear child filter selections when the parent dropdown is cleared>
        function ruClearFilterSelections($sels) {
          $sels.find('option').prop('selected', false);
        }

        function ruCascadeFromBusinessGroups() {
          if (!ruSelectedIdsCsv($('#ruBUID'))) {
            ruClearFilterSelections($('#ruOUID, #ruDUID, #ruEmployeeID'));
          }
          return loadOrganizationUnits()
            .then(function () { return loadDeliveryUnits(); })
            .then(function () { return loadResources(); })
            .then(function () { ruRefreshDependentReports(); });
        }

        function ruCascadeFromOrganizationUnits() {
          if (!ruSelectedIdsCsv($('#ruOUID'))) {
            ruClearFilterSelections($('#ruDUID, #ruEmployeeID'));
          }
          return loadDeliveryUnits()
            .then(function () { return loadResources(); })
            .then(function () { ruRefreshDependentReports(); });
        }

        function ruCascadeFromDeliveryUnits() {
          if (!ruSelectedIdsCsv($('#ruDUID'))) {
            ruClearFilterSelections($('#ruEmployeeID'));
          }
          return loadResources()
            .then(function () { ruRefreshDependentReports(); });
        }
        //End of Added by Aditya J. on 09-09-2026<Clear child filter selections when the parent dropdown is cleared>
        //End of Updated by Aditya J. on 09-09-2026<Bound BG/OU/DU/Resource dropdowns to the generic cascading filter API>
        //End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource multi-select filters

        function loadDateRanges() {
          var payload = {};
          //Added by Aditya J. on 03-09-2026 for adding Period multi-select filter
          var selectedPeriodIds = ruSelectedOptions($('#ruDateRange')).map(function (o) { return o.id; });
          if (selectedPeriodIds.length) payload.DateRangeID = selectedPeriodIds[0];
          //End of Added by Aditya J. on 03-09-2026 for adding Period multi-select filter

          return fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/GetResourceUtilizationDateRanges' + toQuery(payload), {
            method: 'GET',
            headers: apiHeaders(payload)
          })
          .then(function (res) {
            if (!res.ok) throw new Error('GetResourceUtilizationDateRanges failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = extractModelList(data,
              'ResourceUtilizationDateRangeModel', 'resourceUtilizationDateRangeModel',
              'DateRangeModel', 'dateRangeModel');
            var $sel = $('#ruDateRange');
            //Added by Aditya J. on 03-09-2026 for adding Period multi-select filter - no more "Select Period" placeholder <option> (the select's title attribute is the placeholder now); keep selecting the first option by default, same as before
            var html = '';
            var firstId = null;
            (rows || []).forEach(function (r) {
              var id = apiVal(r, 'dateRangeID', 'DateRangeID', 'uniqueID', 'UniqueID', 'id', 'ID');
              if (id == null || id === '' || String(id) === '0') return;
              if (firstId == null) firstId = id;
              var name = apiVal(r, 'description', 'Description', 'dateRangeName', 'DateRangeName', 'name', 'Name') || id;
              html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
            });
            $sel.html(html);
            //if (firstId != null) $sel.val([String(firstId)]);
            //End of Added by Aditya J. on 03-09-2026 for adding Period multi-select filter
            refreshSelect($sel);
          })
          .catch(function (err) {
            console.error(err);
            refreshSelect($('#ruDateRange'));
          });
        }

        function destroyChart() {
          if (ruChart) {
            try { ruChart.destroy(); } catch (e) { }
            ruChart = null;
          }
        }

        function renderRuPager(tableSelector, state, renderFn) {
          var $table = $(tableSelector);
          if (!$table.length) return;
          var total = state.rows.length;
          var totalPages = total ? Math.ceil(total / state.size) : 1;
          state.page = Math.max(1, Math.min(state.page, totalPages));
          var pagerFor = $table.attr('id');
          var $anchor = $table.parent().hasClass('table-responsive') ? $table.parent() : $table;
          var $pager = $anchor.next('.ru-footer-row[data-pager-for="' + pagerFor + '"]');
          if (!$pager.length) {
            $pager = $('<div class="row footer-row ru-footer-row" data-pager-for="' + pagerFor + '">' +
              '<div class="col-sm-6"></div>' +
              '<div class="col-sm-6 d-flex justify-content-end align-items-center">' +
              '<span class="spntotal me-3">Total Records: 0</span>' +
              '<nav aria-label="Pagination"><ul class="pagination mb-0">' +
              '<li class="page-item disabled"><a class="page-link ru-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>' +
              '<li class="page-item disabled"><a class="page-link ru-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>' +
              '</ul></nav></div></div>');
            $anchor.after($pager);
          }
          $pager.find('.spntotal').text('Total Records: ' + total);
          $pager.find('.ru-page-prev').closest('.page-item').toggleClass('disabled', state.page <= 1);
          $pager.find('.ru-page-next').closest('.page-item').toggleClass('disabled', !total || state.page >= totalPages);
          $pager.find('.ru-page-prev').off('click.ruPager').on('click.ruPager', function (e) {
            e.preventDefault();
            if (state.page <= 1) return;
            state.page -= 1;
            renderFn();
          });
          $pager.find('.ru-page-next').off('click.ruPager').on('click.ruPager', function (e) {
            e.preventDefault();
            if (!total || state.page >= totalPages) return;
            state.page += 1;
            renderFn();
          });
        }

        //Added by Aditya J. on 31-08-2026<Dynamically discover every ratio/percentage series returned by GetResourceUtilizationGraph instead of hardcoding a fixed set of fields>
        var RU_GRAPH_MONTH_KEYS = ['month', 'Month', 'period', 'Period', 'label', 'Label'];
        var RU_GRAPH_COLORS = [
          'rgba(75,192,192,0.9)',
          'rgba(77,77,255,0.75)',
          'rgba(150,150,150,0.9)',
          'rgba(112,173,69,0.9)',
          'rgba(254,194,0,0.9)',
          'rgba(90,155,211,0.9)',
          'rgba(40,68,118,0.9)',
          'rgba(236,126,49,0.9)',
          'rgba(190,74,158,0.9)',
          'rgba(0,150,136,0.9)'
        ];

        function ruIsGraphMonthKey(key) {
          var k = String(key || '').toLowerCase();
          if (RU_GRAPH_MONTH_KEYS.indexOf(key) > -1) return true;
          //Added by Aditya J. on 10-09-2026 for Keeping SnapshotDate off the graph series list
          if (k === 'snapshotdate') return true;
          //End of Added by Aditya J. on 10-09-2026 for Keeping SnapshotDate off the graph series list
          return false;
        }

        // Converts an API field name like "availableToBillableRatio" or "billableHrsPercent"
        // into a readable series/legend label like "Available To Billable Ratio" / "Billable Hrs %".
        function ruGraphFieldToLabel(key) {
          var s = String(key || '');
          s = s.replace(/([a-z0-9])([A-Z])/g, '$1 $2');
          s = s.replace(/^./, function (c) { return c.toUpperCase(); });
          //Added by Aditya J. on 01-09-2026 <Replace the word "Percent" with a "%" symbol in graph legend/tooltip labels (e.g. "Billable Hrs Percent" becomes "Billable Hrs %") instead of spelling out "Percent">
          s = s.replace(/\bPercent\b/gi, '%').replace(/\s+%/g, ' %');
          //Added by Aditya J. on 10-09-2026 for Changing caption Bench Hrs % to Probable Bench Hrs %
          var rawKey = String(key || '').toLowerCase();
          if (rawKey.indexOf('benchhrspercent') > -1 && rawKey.indexOf('probable') < 0) {
            return 'Probable Bench Hrs %';
          }
          if (/^bench hrs %$/i.test(s.trim())) s = 'Probable Bench Hrs %';
          //End of Added by Aditya J. on 10-09-2026 for Changing caption Bench Hrs % to Probable Bench Hrs %
          //End of Added by Aditya J. on 01-09-2026 <Replace the word "Percent" with a "%" symbol in graph legend/tooltip labels (e.g. "Billable Hrs Percent" becomes "Billable Hrs %") instead of spelling out "Percent">
          return s.trim();
        }

        //Added by Aditya J. on 01-09-2026 <Classify a graph series field as an hour-based metric (needs HH:MM formatting) vs a percentage/ratio metric (needs % formatting), so the tooltip shows each line's value in the correct unit>
        function ruGraphIsHourKey(key) {
          var k = String(key || '').toLowerCase();
          if (k.indexOf('percent') > -1 || k.indexOf('pct') > -1 || k.indexOf('ratio') > -1) return false;
          return k.indexOf('hrs') > -1 || k.indexOf('hour') > -1;
        }

        // Formats a graph series' hovered value using its field key: HH:MM for hour-based metrics
        // (no decimal hour value shown), and a percentage string for percentage/ratio metrics.
        function ruGraphFormatSeriesValue(key, val) {
          if (val === null || val === undefined || isNaN(val)) return 'N/A';
          if (ruGraphIsHourKey(key)) {
            return minutesToHoursDisplay(Math.round(Number(val) * 60));
          }
          return Number(val).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + '%';
        }
        //End of Added by Aditya J. on 01-09-2026 <Classify a graph series field as an hour-based metric (needs HH:MM formatting) vs a percentage/ratio metric (needs % formatting), so the tooltip shows each line's value in the correct unit>

        function ruGraphSafeNumber(raw) {
          if (raw == null || raw === '') return null;
          var n = Number(raw);
          return isNaN(n) ? null : n;
        }
        //End of Added by Aditya J. on 31-08-2026<Dynamically discover every ratio/percentage series returned by GetResourceUtilizationGraph instead of hardcoding a fixed set of fields>

        function renderGraph(rows) {
          destroyChart();
          var labels = [];

          //Added by Aditya J. on 31-08-2026<Build the list of graph series dynamically from whatever ratio/percentage fields the API actually returns, instead of a hardcoded field list>
          var seriesKeys = [];
          (rows || []).forEach(function (r) {
            if (!r || typeof r !== 'object') return;
            Object.keys(r).forEach(function (k) {
              if (ruIsGraphMonthKey(k)) return;
              if (seriesKeys.indexOf(k) === -1) seriesKeys.push(k);
            });
          });

          var seriesData = {};
          seriesKeys.forEach(function (k) { seriesData[k] = []; });

          (rows || []).forEach(function (r) {
            labels.push(apiVal(r, 'month', 'Month', 'period', 'Period', 'label', 'Label') || '');
            seriesKeys.forEach(function (k) {
              // Handle null/empty/missing values safely - push null so the line shows a gap
              // instead of a misleading zero, rather than throwing on bad data.
              seriesData[k].push(ruGraphSafeNumber(r ? r[k] : null));
            });
          });

          var ctx = document.getElementById('ResUtilizationChart');
          if (!ctx) return;

          var datasets = seriesKeys.map(function (k, idx) {
            var color = RU_GRAPH_COLORS[idx % RU_GRAPH_COLORS.length];
            return {
              label: ruGraphFieldToLabel(k),
              //Added by Aditya J. on 01-09-2026 <Carry the raw API field key on each dataset so the tooltip callback can look up its metric type (hour vs percentage/ratio) and format its value correctly>
              fieldKey: k,
              //End of Added by Aditya J. on 01-09-2026 <Carry the raw API field key on each dataset so the tooltip callback can look up its metric type (hour vs percentage/ratio) and format its value correctly>
              type: 'line',
              borderColor: color,
              backgroundColor: color,
              data: seriesData[k],
              fill: false,
              spanGaps: true,
              lineTension: 0.1
            };
          });
          //End of Added by Aditya J. on 31-08-2026<Build the list of graph series dynamically from whatever ratio/percentage fields the API actually returns, instead of a hardcoded field list>

          ruChart = new Chart(ctx, {
            type: 'line',
            data: {
              labels: labels,
              datasets: datasets
            },
            options: {
              legend: { labels: { usePointStyle: true, boxWidth: 8 } },
              //Added by Aditya J. on 31-08-2026<Show every series' value for the hovered month in the tooltip instead of only Allocation To Billable Ratio>
              tooltips: {
                mode: 'index',
                intersect: false,
                callbacks: {
                  title: function (tooltipItems, data) {
                    return (tooltipItems && tooltipItems.length) ? data.labels[tooltipItems[0].index] : '';
                  },
                  label: function (tooltipItem, data) {
                    var ds = data.datasets[tooltipItem.datasetIndex];
                    var val = tooltipItem.yLabel;
                    //Added by Aditya J. on 01-09-2026 <Format each line's hovered value using its own field key - HH:MM for hour-based metrics, % for percentage/ratio metrics - instead of always showing a plain 2-decimal number, and ensure the correct dataset's own label/value pair is used so every line shows its own metric instead of duplicating one series>
                    var display = ruGraphFormatSeriesValue(ds.fieldKey, val);
                    //End of Added by Aditya J. on 01-09-2026 <Format each line's hovered value using its own field key - HH:MM for hour-based metrics, % for percentage/ratio metrics - instead of always showing a plain 2-decimal number, and ensure the correct dataset's own label/value pair is used so every line shows its own metric instead of duplicating one series>
                    return (ds.label || '') + ': ' + display;
                  }
                }
              },
              hover: { mode: 'index', intersect: false },
              //End of Added by Aditya J. on 31-08-2026<Show every series' value for the hovered month in the tooltip instead of only Allocation To Billable Ratio>
              scales: {
                xAxes: [{ maxBarThickness: 50, barPercentage: 0.6 }],
                yAxes: [
                  { id: 'A', type: 'linear', position: 'left', gridLines: { display: false }, ticks: { min: 0 } }
                ]
              }
            }
          });
        }

        function loadGraph() {
          updateFilterMeta();
          var payload = buildFilterPayload({ showDeployableOnly: ruShowDeployable.grid });
          return fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/GetResourceUtilizationGraph' + toQuery(payload), {
            method: 'GET',
            headers: apiHeaders(payload)
          })
          .then(function (res) {
            if (!res.ok) throw new Error('GetResourceUtilizationGraph failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = extractModelList(data, 'ResourceUtilizationGraphModel', 'resourceUtilizationGraphModel');
            renderGraph(rows);
          })
          .catch(function (err) {
            console.error(err);
            destroyChart();
          });
        }

        function renderSummary(rows) {
          var $body = $('#ruSummaryBody');
          if (Array.isArray(rows)) ruSummaryPager.rows = rows;
          var allRows = ruSummaryPager.rows;
          renderRuPager('#ruSummaryTable', ruSummaryPager, function () { renderSummary(); });
          if (!allRows.length) {
            $body.html('<tr><td colspan="10" class="text-center text-muted">No summary data found.</td></tr>');
            return;
          }
          var html = '';
          var totals = { capacity: 0, avail: 0, planned: 0, actual: 0, billable: 0 };
          allRows.forEach(function (r) {
            // API variants:
            // - Your response: installCapacityHrs, capacityHrs, allocatedHrs, actualHrs, billableHrs
            // - Old/other response: InstallCapacity, availableHrs/plannedHrs, etc.
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            totals.capacity += apiHoursMinutes(r, 'installCapacityHrs', 'InstallCapacityHrs', 'installCapacity', 'InstallCapacity', 'installedCapacity', 'InstalledCapacity');
            totals.avail += apiHoursMinutes(r, 'capacityHrs', 'CapacityHrs', 'availableHrs', 'AvailableHrs', 'available', 'Available');
            totals.planned += apiHoursMinutes(r, 'allocatedHrs', 'AllocatedHrs', 'plannedHrs', 'PlannedHrs', 'planned', 'Planned');
            totals.actual += apiHoursMinutes(r, 'actualHrs', 'ActualHrs', 'actual', 'Actual');
            totals.billable += apiHoursMinutes(r, 'billableHrs', 'BillableHrs', 'billable', 'Billable');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          });
          var start = (ruSummaryPager.page - 1) * ruSummaryPager.size;
          allRows.slice(start, start + ruSummaryPager.size).forEach(function (r) {
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var capacity = apiHours(
              r, 'installCapacityHrs', 'InstallCapacityHrs',
              'installCapacity', 'InstallCapacity',
              'installedCapacity', 'InstalledCapacity'
            );
            var avail = apiHours(r, 'capacityHrs', 'CapacityHrs', 'availableHrs', 'AvailableHrs', 'available', 'Available');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var availPct = apiNum(
              r, 'capacityPercent', 'CapacityPercent',
              'availablePercent', 'AvailablePercent',
              'availablePct', 'AvailablePct',
              'capacityPct', 'CapacityPct'
            );
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var planned = apiHours(r, 'allocatedHrs', 'AllocatedHrs', 'plannedHrs', 'PlannedHrs', 'planned', 'Planned');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var plannedPct = apiNum(
              r, 'allocatedPercent', 'AllocatedPercent',
              'plannedPercent', 'PlannedPercent',
              'plannedPct', 'PlannedPct'
            );
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var actual = apiHours(r, 'actualHrs', 'ActualHrs', 'actual', 'Actual');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var actualPct = apiNum(r, 'actualPercent', 'ActualPercent', 'actualPct', 'ActualPct');
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var billable = apiHours(r, 'billableHrs', 'BillableHrs', 'billable', 'Billable');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var billablePct = apiNum(r, 'billablePercent', 'BillablePercent', 'billablePct', 'BillablePct');
            var month = apiVal(r, 'month', 'Month', 'period', 'Period') || '';
            html += '<tr>';
            html += '<td>' + esc(month) + '</td>';
            html += '<td>' + esc(capacity) + '</td>';
            html += '<td>' + esc(avail) + '</td><td>' + fmtNum(availPct) + '</td>';
            html += '<td>' + esc(planned) + '</td><td>' + fmtNum(plannedPct) + '</td>';
            html += '<td>' + esc(actual) + '</td><td>' + fmtNum(actualPct) + '</td>';
            html += '<td>' + esc(billable) + '</td><td>' + fmtNum(billablePct) + '</td>';
            html += '</tr>';
          });
          //Added by Aditya J. on 31-08-2026<Compute the % Total row on the UI since GetResourceUtilizationSummary does not return total percentages - Available% is against Install Capacity, and Planned/Actual/Billable% are each against Available, matching the legacy RM_ResourceUtilizationReport grand total logic>
          var totalAvailPct = totals.capacity ? (totals.avail / totals.capacity * 100) : 0;
          var totalPlannedPct = totals.avail ? (totals.planned / totals.avail * 100) : 0;
          var totalActualPct = totals.avail ? (totals.actual / totals.avail * 100) : 0;
          var totalBillablePct = totals.avail ? (totals.billable / totals.avail * 100) : 0;
          //End of Added by Aditya J. on 31-08-2026<Compute the % Total row on the UI since GetResourceUtilizationSummary does not return total percentages - Available% is against Install Capacity, and Planned/Actual/Billable% are each against Available, matching the legacy RM_ResourceUtilizationReport grand total logic>
          html += '<tr class="totalrow">';
          html += '<td>Total</td>';
          //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          html += '<td>' + esc(minutesToHoursDisplay(totals.capacity)) + '</td>';
          //Added by Aditya J. on 31-08-2026<Show the computed % Total values instead of leaving the Total row % columns blank>
          html += '<td>' + esc(minutesToHoursDisplay(totals.avail)) + '</td><td>' + fmtNum(totalAvailPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(totals.planned)) + '</td><td>' + fmtNum(totalPlannedPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(totals.actual)) + '</td><td>' + fmtNum(totalActualPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(totals.billable)) + '</td><td>' + fmtNum(totalBillablePct) + '</td>';
          //End of Added by Aditya J. on 31-08-2026<Show the computed % Total values instead of leaving the Total row % columns blank>
          //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          html += '</tr>';
          $body.html(html);
        }

        function loadSummary() {
          ruSummaryPager.page = 1;
          ruSummaryPager.rows = [];
          updateFilterMeta();
          var $body = $('#ruSummaryBody');
          $body.html('<tr><td colspan="10" class="text-center text-muted">Loading...</td></tr>');
          renderRuPager('#ruSummaryTable', ruSummaryPager, function () { renderSummary(); });
          //Added by Aditya J. on 26-08-2026
          var payload = buildFilterPayload({ showDeployableOnly: ruShowDeployable.summary, details: 2 });
          //End of Added by Aditya J. on 26-08-2026
          return fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/GetResourceUtilizationSummary' + toQuery(payload), {
            method: 'GET',
            headers: apiHeaders(payload)
          })
          .then(function (res) {
            if (!res.ok) throw new Error('GetResourceUtilizationSummary failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            renderSummary(extractModelList(data, 'ResourceUtilizationSummaryModel', 'resourceUtilizationSummaryModel'));
          })
          .catch(function (err) {
            console.error(err);
            ruSummaryPager.rows = [];
            renderRuPager('#ruSummaryTable', ruSummaryPager, function () { renderSummary(); });
            $body.html('<tr><td colspan="10" class="text-center text-danger">Unable to load summary.</td></tr>');
          });
        }

        function renderDetails(rows) {
          var $body = $('#ruDetailsBody');
          if (Array.isArray(rows)) ruDetailsPager.rows = rows;
          var allRows = ruDetailsPager.rows;
          renderRuPager('#ruDetailsTable', ruDetailsPager, function () { renderDetails(); });
          if (!allRows.length) {
            $body.html('<tr><td colspan="11" class="text-center text-muted">No details data found.</td></tr>');
            return;
          }
          var html = '';
          var totals = { capacity: 0, avail: 0, planned: 0, actual: 0, billable: 0 };
          allRows.forEach(function (r) {
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            totals.capacity += apiHoursMinutes(
              r, 'installCapacityHrs', 'InstallCapacityHrs',
              'installCapacity', 'InstallCapacity',
              'installedCapacity', 'InstalledCapacity'
            );
            totals.avail += apiHoursMinutes(
              r, 'capacityHrs', 'CapacityHrs',
              'availableHrs', 'AvailableHrs'
            );
            totals.planned += apiHoursMinutes(
              r, 'allocatedHrs', 'AllocatedHrs',
              'plannedHrs', 'PlannedHrs'
            );
            totals.actual += apiHoursMinutes(
              r, 'actualHrs', 'ActualHrs',
              'actual', 'Actual'
            );
            totals.billable += apiHoursMinutes(
              r, 'billableHrs', 'BillableHrs',
              'billable', 'Billable'
            );
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          });
          //Added by Aditya J. on 01-09-2026 <Precompute the per-month subtotals and each month's last row index across the full filtered dataset, so the "Total Work(hrs) for <Month>" row can be inserted at the correct place while paging>
          var ruMonthlyTotals = ruBuildMonthlyDetailsTotals(allRows);
          var ruMonthLastIndex = ruBuildMonthLastIndex(allRows);
          //End of Added by Aditya J. on 01-09-2026 <Precompute the per-month subtotals and each month's last row index across the full filtered dataset, so the "Total Work(hrs) for <Month>" row can be inserted at the correct place while paging>
          var start = (ruDetailsPager.page - 1) * ruDetailsPager.size;
          allRows.slice(start, start + ruDetailsPager.size).forEach(function (r, sliceIdx) {
            var month = apiVal(r, 'month', 'Month', 'period', 'Period') || '';
            var resource = apiVal(
              r,
              'resourceName', 'ResourceName',
              'resource', 'Resource',
              'employeeName', 'EmployeeName',
              'userName', 'UserName'
            ) || '';
            // Summary names for table headers:
            // - Available columns are based on `capacity*`
            // - Planned columns are based on `allocated*`
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var capacity = apiHours(
              r, 'installCapacityHrs', 'InstallCapacityHrs',
              'installCapacity', 'InstallCapacity',
              'installedCapacity', 'InstalledCapacity'
            );
            var avail = apiHours(
              r, 'capacityHrs', 'CapacityHrs',
              'availableHrs', 'AvailableHrs',
              'available', 'Available'
            );
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var availPct = apiNum(
              r, 'capacityPercent', 'CapacityPercent', 'capacityPct', 'CapacityPct',
              'availablePercent', 'AvailablePercent',
              'availablePct', 'AvailablePct'
            );
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var planned = apiHours(
              r, 'allocatedHrs', 'AllocatedHrs',
              'plannedHrs', 'PlannedHrs',
              'planned', 'Planned'
            );
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var plannedPct = apiNum(
              r, 'allocatedPercent', 'AllocatedPercent', 'allocatedPct', 'AllocatedPct',
              'plannedPercent', 'PlannedPercent',
              'plannedPct', 'PlannedPct'
            );
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var actual = apiHours(r, 'actualHrs', 'ActualHrs', 'actual', 'Actual');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var actualPct = apiNum(r, 'actualPercent', 'ActualPercent', 'actualPct', 'ActualPct');
            //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var billable = apiHours(r, 'billableHrs', 'BillableHrs', 'billable', 'Billable');
            //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
            var billablePct = apiNum(r, 'billablePercent', 'BillablePercent', 'billablePct', 'BillablePct');
            html += '<tr>';
            html += '<td>' + esc(month) + '</td>';
            html += '<th>' + esc(resource) + '</th>';
            html += '<td>' + esc(capacity) + '</td>';
            html += '<td>' + esc(avail) + '</td><td>' + fmtNum(availPct) + '</td>';
            html += '<td>' + esc(planned) + '</td><td>' + fmtNum(plannedPct) + '</td>';
            html += '<td>' + esc(actual) + '</td><td>' + fmtNum(actualPct) + '</td>';
            html += '<td>' + esc(billable) + '</td><td>' + fmtNum(billablePct) + '</td>';
            html += '</tr>';
            //Added by Aditya J. on 01-09-2026 <Show the base site's "Total Work(hrs) for <Month>" subtotal row right after the last row of that month, formatted the same as a normal Details row>
            var ruAbsIndex = start + sliceIdx;
            if (ruMonthLastIndex[String(month)] === ruAbsIndex) {
              html += ruRenderMonthlyDetailsTotalRow(ruMonthlyTotals[String(month)]);
            }
            //End of Added by Aditya J. on 01-09-2026 <Show the base site's "Total Work(hrs) for <Month>" subtotal row right after the last row of that month, formatted the same as a normal Details row>
          });
          //Added by Aditya J. on 31-08-2026<Compute the % Total row on the UI since GetResourceUtilizationDetails does not return total percentages - Available% is against Install Capacity, and Planned/Actual/Billable% are each against Available, matching the legacy RM_ResourceUtilizationReport grand total logic>
          var totalAvailPct = totals.capacity ? (totals.avail / totals.capacity * 100) : 0;
          var totalPlannedPct = totals.avail ? (totals.planned / totals.avail * 100) : 0;
          var totalActualPct = totals.avail ? (totals.actual / totals.avail * 100) : 0;
          var totalBillablePct = totals.avail ? (totals.billable / totals.avail * 100) : 0;
          //End of Added by Aditya J. on 31-08-2026<Compute the % Total row on the UI since GetResourceUtilizationDetails does not return total percentages - Available% is against Install Capacity, and Planned/Actual/Billable% are each against Available, matching the legacy RM_ResourceUtilizationReport grand total logic>
          html += '<tr class="totalrow">';
          html += '<td colspan="2">Total</td>';
          //Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          html += '<td>' + esc(minutesToHoursDisplay(totals.capacity)) + '</td>';
          //Added by Aditya J. on 31-08-2026<Show the computed % Total values instead of leaving the Total row % columns blank>
          html += '<td>' + esc(minutesToHoursDisplay(totals.avail)) + '</td><td>' + fmtNum(totalAvailPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(totals.planned)) + '</td><td>' + fmtNum(totalPlannedPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(totals.actual)) + '</td><td>' + fmtNum(totalActualPct) + '</td>';
          html += '<td>' + esc(minutesToHoursDisplay(totals.billable)) + '</td><td>' + fmtNum(totalBillablePct) + '</td>';
          //End of Added by Aditya J. on 31-08-2026<Show the computed % Total values instead of leaving the Total row % columns blank>
          //End of Added by Aditya J. on 26-08-2026 for displaying HH:MM hours from GetResourceUtilizationSummary
          html += '</tr>';
          $body.html(html);
        }

        function loadDetails() {
          ruDetailsPager.page = 1;
          ruDetailsPager.rows = [];
          updateFilterMeta();
          var $body = $('#ruDetailsBody');
          $body.html('<tr><td colspan="11" class="text-center text-muted">Loading...</td></tr>');
          renderRuPager('#ruDetailsTable', ruDetailsPager, function () { renderDetails(); });
          //Added by Aditya J. on 26-08-2026
          var payload = buildFilterPayload({ showDeployableOnly: ruShowDeployable.details, details: 1 });
          //End of Added by Aditya J. on 26-08-2026
          return fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/GetResourceUtilizationDetails' + toQuery(payload), {
            method: 'GET',
            headers: apiHeaders(payload)
          })
          .then(function (res) {
            if (!res.ok) throw new Error('GetResourceUtilizationDetails failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var detailRows = extractModelList(
              data,
              'ResourceUtilizationDetailModel',
              'resourceUtilizationDetailModel',
              'ResourceUtilizationDetailsModel',
              'resourceUtilizationDetailsModel'
            );
            renderDetails(detailRows);
            //Added by Aditya J. on 09-09-2026<Bind Snapshot As Of from GetResourceUtilizationDetails>
            ruBindSnapshotDate(detailRows);
            //End of Added by Aditya J. on 09-09-2026<Bind Snapshot As Of from GetResourceUtilizationDetails>
          })
          .catch(function (err) {
            console.error(err);
            ruDetailsPager.rows = [];
            renderRuPager('#ruDetailsTable', ruDetailsPager, function () { renderDetails(); });
            $body.html('<tr><td colspan="11" class="text-center text-danger">Unable to load details.</td></tr>');
          });
        }

        function generateReport() {
          updateFilterMeta();
          return loadGraph();
        }

        //Added by Aditya J. on 09-09-2026<Bind Snapshot As Of from GetResourceUtilizationDetails snapshotDate>
        function ruFormatSnapshotDate(value) {
          if (value == null || value === '') return '';
          if (typeof value === 'string' && !/^\d{4}-\d{2}-\d{2}/.test(value) && value.indexOf('T') < 0) {
            return $.trim(value);
          }
          var d = new Date(value);
          if (isNaN(d.getTime())) return $.trim(String(value));
          var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          var dd = d.getDate();
          var day = dd < 10 ? ('0' + dd) : String(dd);
          return day + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
        }

        function ruBindSnapshotDate(rows) {
          var dateText = '-';
          (rows || []).some(function (r) {
            var v = apiVal(r, 'snapshotDate', 'SnapshotDate', 'snapshotAsOf', 'SnapshotAsOf');
            if (v == null || v === '') return false;
            dateText = ruFormatSnapshotDate(v) || '-';
            return true;
          });
          $('#ruSnapshotDate').text(dateText);
        }

        function loadSnapshotDate() {
          var payload = buildFilterPayload({ showDeployableOnly: ruShowDeployable.grid, details: 1 });
          return fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/GetResourceUtilizationDetails' + toQuery(payload), {
            method: 'GET',
            headers: apiHeaders(payload)
          })
          .then(function (res) {
            if (!res.ok) throw new Error('GetResourceUtilizationDetails failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            ruBindSnapshotDate(extractModelList(
              data,
              'ResourceUtilizationDetailModel',
              'resourceUtilizationDetailModel',
              'ResourceUtilizationDetailsModel',
              'resourceUtilizationDetailsModel'
            ));
          })
          .catch(function (err) {
            console.error(err);
            $('#ruSnapshotDate').text('-');
          });
        }
        //End of Added by Aditya J. on 09-09-2026<Bind Snapshot As Of from GetResourceUtilizationDetails snapshotDate>

        //Added by Aditya J. on 25-08-2026 for Resource Utilization Report
        function buildExportPayload(details, showDeployable) {
          //Added by Aditya J. on 26-08-2026
          var deployable = (parseInt(showDeployable, 10) === 1) ? '1' : '0';
          var detailsFlag = parseInt(details, 10);
          if (isNaN(detailsFlag)) detailsFlag = 2;
          //End of Added by Aditya J. on 26-08-2026
          //Updated on 04-09-2026 - send every checked value (CSV) for BUID/OUID/DUID/EmployeeID, matching
          //buildFilterPayload, now that usp_SEL_Whizible2_ResourceUtilizationByResource accepts CSV lists.
          //Period (dateRange) stays a single value.
          //Updated by Aditya J. on 09-09-2026<Send export filter property names that bind to ResourceUtilizationRequest>
          //Updated by Aditya J. on 10-09-2026<Send selected BG/OU/DU/Resource/Period names so the PDF header matches the page>
          return {
            BUID: ruSelectedIdsCsv($('#ruBUID')),
            OUID: ruSelectedIdsCsv($('#ruOUID')),
            DUID: ruSelectedIdsCsv($('#ruDUID')),
            EmployeeID: ruSelectedIdsCsv($('#ruEmployeeID')),
            DateRange: ruFirstSelectedId($('#ruDateRange')),
            Details: detailsFlag,
            UserID: defaultUserID,
            ProjectIDs: '',
            ShowDeployableOnly: deployable,
            BusinessGroupName: ruSelectedNamesCsv($('#ruBUID')),
            OrganizationUnitName: ruSelectedNamesCsv($('#ruOUID')),
            DeliveryUnitName: ruSelectedNamesCsv($('#ruDUID')),
            ResourceName: ruSelectedNamesCsv($('#ruEmployeeID')),
            PeriodName: ruSelectedNamesCsv($('#ruDateRange'))
          };
          //End of Updated by Aditya J. on 10-09-2026<Send selected BG/OU/DU/Resource/Period names so the PDF header matches the page>
          //End of Updated by Aditya J. on 09-09-2026<Send export filter property names that bind to ResourceUtilizationRequest>
          //End of Updated on 04-09-2026
        }

        function getTodayYYYYMMDD() {
          var d = new Date();
          var yyyy = d.getFullYear();
          var mm = String(d.getMonth() + 1);
          var dd = String(d.getDate());
          if (mm.length < 2) mm = '0' + mm;
          if (dd.length < 2) dd = '0' + dd;
          return yyyy + mm + dd;
        }

        function downloadBlob(blob, fileName) {
          var url = window.URL.createObjectURL(blob);
          var a = document.createElement('a');
          a.href = url;
          a.download = fileName;
          document.body.appendChild(a);
          a.click();
          a.remove();
          setTimeout(function () { window.URL.revokeObjectURL(url); }, 1000);
        }

        function fileNameFromDisposition(header, fallback) {
          if (!header) return fallback;
          var star = /filename\*\s*=\s*UTF-8''([^;]+)/i.exec(header);
          if (star && star[1]) {
            try { return decodeURIComponent(star[1].replace(/"/g, '').trim()); } catch (e) { }
          }
          var m = /filename\s*=\s*("?)([^";]+)\1/i.exec(header);
          if (m && m[2]) return m[2].trim();
          return fallback;
        }

        function exportResourceUtilizationReport(details, triggerEl) {
          var $trigger = $(triggerEl);
          //Added by Aditya J. on 26-08-2026
          var showDep = 0;
          if ($trigger.closest('#ProRsrsDisplayDetailsmodal').length) {
            details = 1;
            showDep = ruShowDeployable.details;
          } else if ($trigger.closest('#ProRsrsDisplaySummurymodal').length) {
            details = 2;
            showDep = ruShowDeployable.summary;
          } else {
            details = (details == null || details === '') ? 2 : details;
            showDep = ruShowDeployable.grid;
          }
          var payload = buildExportPayload(details, showDep);
          //End of Added by Aditya J. on 26-08-2026
          var fileName = 'ResourceUtilizationReport_' + getTodayYYYYMMDD() + '.pdf';
          if ($trigger.data('exporting')) return;
          $trigger.data('exporting', true);
          $('#loaderOverlay').show();

          var headers = apiHeaders(payload);
          headers['Content-Type'] = 'application/json';

          fetch(encodeURI(strUrl) + '/api/ResourceUtilizationByRes/ExportResourceUtilizationReport', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify(payload)
          })
          .then(function (res) {
            var disp = res.headers.get('Content-Disposition') || res.headers.get('content-disposition');
            var name = fileNameFromDisposition(disp, fileName);
            return res.blob().then(function (blob) {
              return { ok: res.ok, status: res.status, blob: blob, fileName: name };
            });
          })
          .then(function (result) {
            var blob = result.blob;
            var ct = (blob && blob.type) ? blob.type.toLowerCase() : '';

            if (!result.ok || ct.indexOf('application/json') > -1 || ct.indexOf('text/') > -1) {
              return blob.text().then(function (text) {
                var msg = 'There are no items to show.';
                try {
                  var json = JSON.parse(text);
                  msg = (json && (json.message || json.Message || (json.data && json.data.message))) || msg;
                } catch (e) {
                  if (text && text.length < 300) msg = text;
                }
                throw new Error(msg);
              });
            }

            if (!blob || blob.size === 0) {
              throw new Error('There are no items to show.');
            }

            downloadBlob(blob, result.fileName || fileName);
          })
          .catch(function (err) {
            console.error('Resource Utilization Report export failed:', err);
            alert(err && err.message ? err.message : 'Unable to export Resource Utilization Report.');
          })
          .then(function () {
            $trigger.data('exporting', false);
            $('#loaderOverlay').hide();
          });
        }
        //End of Added by Aditya J. on 25-08-2026 for Resource Utilization Report

        function hidePagePreloader() {
          $('#RuPagePreloader').hide();
          $('#RuPageWrapper').show();
        }

        //Added by Aditya J. on 26-08-2026
        function setShowDeployableButton($btn, isOn) {
          var on = !!isOn;
          $btn.toggleClass('active', on)
            .text(on ? 'Show All' : 'Show Deployable')
            .attr('data-bs-original-title', on ? 'Show all resources.' : 'Show deployable resources only.')
            .attr('title', on ? 'Show all resources.' : 'Show deployable resources only.');
        }

        function resetOffcanvasShowDeployable($offcanvas) {
          setShowDeployableButton($offcanvas.find('.ruShowDeployableToggle'), false);
        }
        //End of Added by Aditya J. on 26-08-2026

        $(document).ready(function () {
          renderRuPager('#ruSummaryTable', ruSummaryPager, function () { renderSummary(); });
          renderRuPager('#ruDetailsTable', ruDetailsPager, function () { renderDetails(); });
          //Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource multi-select filters - populate the 4 new lookup dropdowns alongside the existing Period load, then continue exactly as before (meta + initial graph load)
          Promise.all([
            loadDateRanges(),
            loadBusinessGroups(),
            loadOrganizationUnits(),
            loadDeliveryUnits(),
            loadResources()
          ]).then(function () {
          //End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource multi-select filters
            updateFilterMeta();
            loadSnapshotDate();
            return loadGraph();
          }).then(function () {
            hidePagePreloader();
          }).catch(function () {
            hidePagePreloader();
          });
          setTimeout(hidePagePreloader, 8000);

          $('.generateBtn').on('click', function (e) {
            e.preventDefault();
            generateReport();
          });

          //Added by Aditya J. on 26-08-2026
          $(document).on('click', '.ruShowDeployableToggle', function (e) {
            e.preventDefault();
            var $btn = $(this);
            if ($btn.closest('#ProRsrsDisplaySummurymodal').length) {
              ruShowDeployable.summary = ruShowDeployable.summary === 1 ? 0 : 1;
              setShowDeployableButton($btn, ruShowDeployable.summary === 1);
              loadSummary();
              return;
            }
            if ($btn.closest('#ProRsrsDisplayDetailsmodal').length) {
              ruShowDeployable.details = ruShowDeployable.details === 1 ? 0 : 1;
              setShowDeployableButton($btn, ruShowDeployable.details === 1);
              loadDetails();
              return;
            }
            ruShowDeployable.grid = ruShowDeployable.grid === 1 ? 0 : 1;
            setShowDeployableButton($btn, ruShowDeployable.grid === 1);
            generateReport();
          });
          //End of Added by Aditya J. on 26-08-2026

          //Added by Aditya J. on 26-08-2026
          $('#ProRsrsDisplaySummurymodal').on('shown.bs.offcanvas', function () {
            ruShowDeployable.summary = 0;
            resetOffcanvasShowDeployable($(this));
            loadSummary();
          });
          $('#ProRsrsDisplayDetailsmodal').on('shown.bs.offcanvas', function () {
            ruShowDeployable.details = 0;
            resetOffcanvasShowDeployable($(this));
            loadDetails();
          });
          $('#ProRsrsDisplaySummurymodal').on('hidden.bs.offcanvas', function () {
            ruShowDeployable.summary = 0;
            resetOffcanvasShowDeployable($(this));
          });
          $('#ProRsrsDisplayDetailsmodal').on('hidden.bs.offcanvas', function () {
            ruShowDeployable.details = 0;
            resetOffcanvasShowDeployable($(this));
          });
          //End of Added by Aditya J. on 26-08-2026
          //Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters - refresh Graph, and Display Summary/Details if currently open, whenever any of the 5 filters changes (replaces the old Period-only "change" -> updateFilterMeta binding)
          //Updated by Aditya J. on 07-09-2026: these filters are now the native ru-msel checkbox widget, which triggers a plain "change" event (not bootstrap-select's "changed.bs.select")
          //Updated by Aditya J. on 09-09-2026<Wired cascading refresh of OU/DU/Resource when a parent filter changes>
          $('#ruBUID').on('change', function () {
            ruCascadeFromBusinessGroups();
          });
          $('#ruOUID').on('change', function () {
            ruCascadeFromOrganizationUnits();
          });
          $('#ruDUID').on('change', function () {
            ruCascadeFromDeliveryUnits();
          });
          $('#ruEmployeeID, #ruDateRange').on('change', function () {
            ruRefreshDependentReports();
          });
          //End of Updated by Aditya J. on 09-09-2026<Wired cascading refresh of OU/DU/Resource when a parent filter changes>
          //End of Added by Aditya J. on 03-09-2026 for adding Business Groups/Organization Unit/Delivery Unit/Resource/Period multi-select filters
          //Added by Aditya J. on 25-08-2026 for Resource Utilization Report
          $(document).on('click', '.ruExportPdf', function (e) {
            e.preventDefault();
            exportResourceUtilizationReport(2, this);
          });
          //End of Added by Aditya J. on 25-08-2026 for Resource Utilization Report
        });
      })();

 //End Resource Utilization APIs

    </script>

    <%--Removed by Aditya J. on 09-09-2026<Do not check m_blnViewAccess on Resource Utilization page>--%>
    <%--End of Removed by Aditya J. on 09-09-2026<Do not check m_blnViewAccess on Resource Utilization page>--%>

    </form>
</body>
</html>
