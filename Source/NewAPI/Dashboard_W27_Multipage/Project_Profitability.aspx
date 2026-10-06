<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Project_Profitability.aspx.vb" Inherits="Whizible.Project_Profitability" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
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

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">

    <style type="text/css">
        body {
            background-color: #ffffff;
            background: #ffffff;
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
ul.statustext.hidden-xs {
    padding: 0;
}
.tblheadingrow td{ text-align:left!important; font-weight:500;}
tr.totalrow {
    background: #ccc;
    font-weight: 500;
}
.PPBGOUTbllist tr td:nth-child(2) {
    text-align: left;
}
     
        .lightgraybg {background: #f5f5f5;}

        /*Information table start here*/
        .informationtbl { margin-bottom:15px;}
        .informationtbl tr th {text-align: right;font-weight: 500;}
        body .informationtbl tr td {text-align: left;}
        .informationtbl th, .informationtbl td {padding: 2px 4px;}
        body .informationtbl tr td.pr-3 {padding-right: 3em;}       
        table.informationtbl {width: 100%;}
        td.Agpm {color: #eb1c24;}
        .togglerup .collapseup {display: block;}
        .togglerup .collapsedown{ display:none;}
        
        .togglerdown .collapsedown{ display:block;}
        .togglerdown .collapseup {display: none;}
        .infoToggler {margin: 5px 0 0;}
        .hideprofitabilityinfo{ position:absolute; right:10px;}
        .profitabilityinfopanel { margin-bottom: 16px; }
        .profitabilityinfopanel .panel.panel-default{padding:0px 0px 0 0; position:relative;}
        .profitabilityinfopanel .panel.lightgraybg { background: transparent; }
        .profitabilityinfopanel .panel-collapse,
        .profitabilityinfopanel .panel-body {
            background: #ffffff !important;
        }
        .profitabilityinfopanel .panel-default > .panel-heading {
            padding: 0;
            background: #e7edf0;
            cursor: pointer;
        }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title { margin: 0; font-size: 14px; }
        .profitabilityinfopanel .panel-default > .panel-heading .panel-title > a {
            display: block;
            width: 100%;
            padding: 10px 40px 10px 12px;
            color: #464a4c;
            text-decoration: none;
            position: relative;
        }
        .profitabilityinfopanel .panel-default > .panel-heading a:hover,
        .profitabilityinfopanel .panel-default > .panel-heading a:focus{ color:#464a4c; text-decoration:none;}
        .profitabilityinfopanel .panel-default > .panel-heading a span img {opacity:0.5;}
        .profitabilityinfopanel .panel-default > .panel-heading a span img:hover{opacity:1;}
        .hideprofitabilityinfo { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); margin: 0; }
        #TabGrossProfit > .table-responsive { margin-bottom: 12px; }
        /* MyAlerts-style near full-page offcanvas */
        #PPCGrossProfittmodal {
            --bs-offcanvas-width: 85% !important;
            width: 85% !important;
            max-width: 1200px !important;
        }
        #PPCGrossProfittmodal .offcanvas-body {
            padding: 0 1rem 1rem;
            background-color: #fff;
        }
        a.pp-project-link {
            color: #0d6efd;
            text-decoration: underline !important;
            cursor: pointer;
        }
        a.pp-project-link:hover {
            color: #0a58ca;
            text-decoration: underline !important;
        }
        a.pp-project-link.oc-link-active {
            color: #084298;
            text-decoration: underline !important;
            font-weight: 700;
        }
        @media (max-width: 768px) {
            #PPCGrossProfittmodal {
                --bs-offcanvas-width: 95% !important;
                width: 95% !important;
                max-width: 100% !important;
            }
        }
        /*Information table End here*/
        .informationtbl td, .informationtbl th {
            vertical-align: top !important;
            font-size: 14px;
            line-height: normal;
        }
         /* <!-- Added By Madhuri.K on 24-08-2026 --> */
        #PPCGrossProfittmodal .informationtbl {
            width: 100%;
            margin-bottom: 0;
        }
        #PPCGrossProfittmodal .informationtbl tr th,
        #PPCGrossProfittmodal .informationtbl th {
            text-align: right;
            color: #6b9bd1 !important;
            font-weight: 500;
            min-width: 140px;
            white-space: nowrap;
        }
        #PPCGrossProfittmodal .informationtbl td {
            text-align: left;
            color: #374151;
        }
        #PPCGrossProfittmodal .informationtbl th,
        #PPCGrossProfittmodal .informationtbl td {
            padding: 2px 4px;
            vertical-align: top;
            font-size: 11.5px;
            line-height: 1.4;
        }
        #PPCGrossProfittmodal .informationtbl td.colan {
            padding: 2px 6px;
            width: 10px;
            color: #6b9bd1;
        }
        #PPCGrossProfittmodal .informationtbl td.pr-3 {
            padding-right: 3em;
        }
         /*GPM_tbl*/
        .GPMtbl tr td[align="right"] {text-align: right;}
        .GPMtbl tr td[align="left"] {text-align: left;}
        .GPMtbl tr td:nth-child(2){width:150px;}
        .table .grouprow th {background: #e7edf0;}
        .grossprofitinfo {padding: 0;border-radius: 4px;font-weight: 500;overflow:hidden;}
        .grossprofitinfo p {margin: 0;font-weight: bold;padding:15px;}
        .grossprofitinfo .gpm-footer-tbl { margin: 0; width: 100%; border: 0; }
        .grossprofitinfo .gpm-footer-tbl td { border: 0; font-weight: bold; padding: 15px; vertical-align: middle; }
        .grossprofitinfo .gpm-footer-tbl td:nth-child(2) { width: 150px; text-align: right; }
        .grossprofitinfo .gpm-footer-tbl td:nth-child(3) { width: 180px; text-align: right; }
        body .informationtbl tr td.colan {
    padding: 8px 2px;
}
        tr.ttlrow {
    font-weight: bold;
}
        /*GPM_tbl*/

/*Menu style End here*/
.borderbox{ border:1px solid #ddd; margin:15px;background:#ffffff;}
.statustext{ padding-bottom:0;}

/*Added css by pradip on 21-01-2020*/
.accordion-toggle .collapsedown{display:inline-block}
.accordion-toggle .collapseup{display:none}
.accordion-toggle.in .collapsedown,
.accordion-toggle.show .collapsedown{display:none}
.accordion-toggle.in .collapseup,
.accordion-toggle.show .collapseup{display:inline-block}
.accordion-toggle td{ font-weight:bold;}
.accordion-toggle { background:#e7edf0;}
/* Added By Vyankat B. on 1st Sep 2026 - BG name on top row; group totals on bottom row */
.pp-bg-subtotal-row td {
    background: #e7edf0;
    font-weight: 700;
}
/* End of Added By Vyankat B. on 1st Sep 2026 */
 /* <!-- Added By Madhuri.K on 24-08-2026 --> */
.accordion-toggle .pp-bg-toggle {
    align-items: center;
    display: inline-flex;
    gap: 6px;
    max-width: 100%;
    white-space: nowrap;
}
.accordion-toggle .pp-bg-name {
    overflow: hidden;
    text-overflow: ellipsis;
}
.accordion-toggle .collapsicon {
    color: #166534;
    display: inline-flex;
    align-items: center;
    flex-shrink: 0;
    line-height: 1;
    margin: 0;
}
.accordion-toggle .collapsicon i {
    color: #166534;
    font-size: 11px;
}
.rowdivider td{ background:#fff;}

.PPBGOUTbllist {
    table-layout: fixed;
    width: 100%;
}

.PPBGOUTbllist thead th,
.PPBGOUTbllist tbody td {
    vertical-align: middle;
    word-wrap: break-word;
}

.PPBGOUTbllist thead th:nth-child(n+6),
.PPBGOUTbllist thead td:nth-child(n+6),
.PPBGOUTbllist tbody td:nth-child(n+6) {
    text-align: right;
}

.PPBGOUTbllist tr.hiddenRow.collapse:not(.show) {
    display: none;
}

.PPBGOUTbllist tr.hiddenRow.collapse.show {
    display: table-row;
}

.PPBGOUTbllist tr.hiddenRow.collapsing {
    display: table-row;
    overflow: hidden;
}

.PPBGOUTbllist tr.hiddenRow td {
    display: table-cell;
}

.positiveGPMrow td{ color:#37be0b;}
.positiveGPMrow td a { color: #337ab7; }
.negativeGPMrow td{ color:#eb1c24;}
.negativeGPMrow td a { color: #337ab7; }
.legend ul {
    display: inline-block;
    padding: 0;
    margin: 0;
    vertical-align: top;
}
.legend li:first-child {
    margin-left: 0;
}
.legend li {
    float: left;
    list-style-type: none;
}
.legend span {
    display: inline-block;
    width: 12px;
    height: 12px;
    margin-right: 6px;
    border: 1px solid #ddd;
}
.LdsPositiveGPM{ background:limegreen;}
.LdsNegativeGPM{ background:#eb1c24;}
.legend {
    display: inline-block;
}
.col-sm-3 .dropdown.filedownload {
    display: inline-block;
}
.nostylebtn {
    background: none;
    border: none;
}
.filedownload .dropdown-menu {
    left: auto;
    right: 0;
    min-width: 94px;
    max-width: 100px;
}
.filedownload .dropdown-menu li a img {
    margin-right: 10px;
}
.filedownload .dropdown-menu li a {
    text-decoration: none;
    padding: 5px 10px;
    margin: 0;
}

.Tblbox table{ margin-bottom:0;}
.custVal1.Tblbox{
    display:block;
    overflow: hidden;
    border: 1px solid #dee2e6;
}
/* Added By Vyankat B. on 25th Aug 2026
   Freeze table header at the top of the iframe (under the MD tabs). */
/* Previous: overflow visible let iframe body scroll; Grand Total was not fixed at bottom.
.custVal1.Tblbox.table-responsive {
    overflow: visible;
}
*/
/* Previous: sticky tfoot inside scroll area (Grand Total appeared in middle while scrolling).
.custVal1.Tblbox.table-responsive {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    max-height: calc(100vh - 260px);
    min-height: 220px;
}
.pp-profit-table-scroll {
    flex: 1 1 auto;
    min-height: 0;
    overflow: auto;
    -webkit-overflow-scrolling: touch;
}
.PPBGOUTbllist tfoot tr.grand-total-row td {
    position: -webkit-sticky;
    position: sticky;
    bottom: 0;
    z-index: 4;
    background: #e7edf0;
    font-weight: 700;
    box-shadow: 0 -1px 0 #c5ced4;
}
*/
/* Added By Vyankat B. on 1st Sep 2026 - Scroll body + fixed Grand Total footer below grid */
.custVal1.Tblbox.table-responsive {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    /* Previous: max-height: calc(100vh - 260px); - made grid too short in iframe */
    min-height: 360px;
}
.pp-profit-table-scroll {
    flex: 1 1 auto;
    min-height: 0;
    overflow: auto;
    -webkit-overflow-scrolling: touch;
}
.pp-profit-grand-total-wrap {
    flex: 0 0 auto;
    overflow-x: auto;
    overflow-y: hidden;
    background: #e7edf0;
    border-top: 1px solid #c5ced4;
}
.pp-profit-grand-total-table {
    margin-bottom: 0;
    table-layout: fixed;
    width: 100%;
}
.PPBGOUTbllist tr.grand-total-row td {
    background: #e7edf0;
    font-weight: 700;
}
/* End of Added By Vyankat B. on 1st Sep 2026 */
.PPBGOUTbllist {
    table-layout: fixed;
    width: 100%;
    border-collapse: separate !important;
    border-spacing: 0;
}
.PPBGOUTbllist thead th {
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    z-index: 5;
    background: #F8FAFC;
    box-shadow: 0 1px 0 #dee2e6;
}
/* Previous: Grand Total row was sticky below header in thead.
.PPBGOUTbllist thead tr.grand-total-row td {
    position: -webkit-sticky;
    position: sticky;
    top: var(--pp-thead-h, 38px);
    z-index: 4;
    background: #e7edf0;
    font-weight: 700;
    box-shadow: 0 1px 0 #c5ced4;
}
*/
/* Previous: Grand Total row only at end of table (scroll to bottom to see).
.PPBGOUTbllist tfoot tr.grand-total-row td {
    background: #e7edf0;
    font-weight: 700;
    box-shadow: 0 -1px 0 #c5ced4;
}
*/
/* End of Added By Vyankat B. on 25th Aug 2026 */


.gpmpositivelbl .fa-flag{ color:#9dd824;}
.gpmnegativelbl .fa-flag{ color:#eb1c24;}
.gpmalllbl .fa-flag{ color:#fbb03b;}
.GPMfiltr.mr-1{display:inline-block;float:right;background:transparent;padding:5px 10px;border:1px solid transparent;border-radius:5px}
.GPMfiltr:hover{background:#fff;padding:5px 10px;border:1px solid #ddd;border-radius:5px}
.GPMfiltr label{margin-bottom:0}
.custom_radio input[type="radio"]{display:none}
.custom_radio input[type="radio"] + label span{display:inline-block;width:15px;height:15px;background:transparent;vertical-align:middle;border:1px solid #464a4c;border-radius:50%;padding:2px;margin:0 3px}
.custom_radio input[type="radio"]:checked + label span{width:15px;height:15px;background:#464a4c;background-clip:content-box} 
    
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

        .pp-summary-cards {
            display: grid;
            gap: 12px;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            margin: 0 15px 14px;
        }

        .pp-summary-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            border-top: 3px solid #2563eb;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
            min-height: 90px;
            padding: 10px 14px;
            position: relative;
        }

        .pp-summary-card .summary-label {
            color: #7f8ea3;
            display: block;
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 0.03em;
            margin-bottom: 3px;
            text-transform: uppercase;
        }

        .pp-summary-card .summary-value {
            color: #111827;
            display: block;
            font-size: 16px;
            font-weight: 700;
            line-height: 1;
            margin-bottom: 5px;
        }

        .pp-summary-card .summary-note {
            color: #7b8797;
            display: block;
            font-size: 10px;
            line-height: 1.25;
        }

        .pp-summary-card .summary-icon {
            bottom: 11px;
            color: rgba(156, 163, 175, 0.35);
            font-size: 16px;
            position: absolute;
            right: 12px;
        }

        .pp-summary-card.card-blue {
            border-top-color: #2b6cb0;
        }

        .pp-summary-card.card-red {
            border-top-color: #d94841;
        }

        .pp-summary-card.card-yellow {
            border-top-color: #d9a324;
        }

        .pp-summary-card.card-green {
            border-top-color: #2f9e44;
        }

        @media (max-width: 767px) {
            .management-dashboard-current-page {
                align-items: flex-start;
                flex-direction: column;
                gap: 0.75rem;
            }
        }
    
        /* Plan_VS_Actual-style searchable multi-select */
        .fixed-width-combo {
            width: 250px !important;
        }
        .pp-msel-native { display: none !important; }
        .proprofitabilityFltr .msel {
            position: relative;
            width: 250px;
            max-width: 100%;
        }
        .proprofitabilityFltr .msel-btn {
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
        }
        .proprofitabilityFltr .msel-btn:hover,
        .proprofitabilityFltr .msel-btn:focus {
            border-color: #1359a6;
            outline: none;
        }
        .proprofitabilityFltr .msel-btn .msel-label {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .proprofitabilityFltr .msel-btn .count {
            flex: 0 0 auto;
            padding: 1px 7px;
            border-radius: 10px;
            background: #1359a6;
            color: #fff;
            font-size: 10px;
            font-weight: 600;
        }
        .proprofitabilityFltr .msel-btn .chev {
            flex: 0 0 auto;
            color: #6b7280;
            font-size: 10px;
            line-height: 1;
        }
        .proprofitabilityFltr .msel-panel {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            z-index: 2055;
            display: none;
            width: 100%;
            min-width: 250px;
            max-height: 280px;
            padding: 8px;
            overflow-y: auto;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: #fff;
            box-shadow: 0 8px 24px rgba(20,30,50,.14);
        }
        .proprofitabilityFltr .msel-panel.open { display: block; }
        .proprofitabilityFltr .msel-search {
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
        .proprofitabilityFltr .msel-search:focus {
            border-color: #1359a6;
            outline: none;
        }
        .proprofitabilityFltr .msel-row {
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
        .proprofitabilityFltr .msel-row:hover { background: #f1f5f9; }
        .proprofitabilityFltr .msel-row input { margin: 0; }
        .proprofitabilityFltr .msel-empty {
            padding: 10px 8px;
            color: #6b7280;
            font-size: 11.5px;
            text-align: center;
        }
        .proprofitabilityFltr .msel-actions {
            position: sticky;
            bottom: -8px;
            display: flex;
            justify-content: space-between;
            margin-top: 6px;
            padding: 4px 6px 2px;
            border-top: 1px solid #e5e7eb;
            background: #fff;
        }
        .proprofitabilityFltr .msel-actions button {
            padding: 4px;
            border: 0;
            background: none;
            color: #1359a6;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
        }

    </style> 

</head>
<body>
    <form id="form1" runat="server">
      
    <div class="bgwhite management-dashboard-page">

            <div class="management-dashboard-current-page">
                <div>
                    <h3 class="management-dashboard-current-title">
                        <i class="fas fa-chart-line" data-bs-toggle="tooltip" title="Project Profitability"></i>
                        Project Profitability
                    </h3>
                    <p class="management-dashboard-current-note">Review profitability by business group and organization unit.</p>
                </div>
            </div>
            <div class="pp-summary-cards" id="ppSummaryCards">
                <div class="pp-summary-card card-blue">
                    <span class="summary-label">Accrued Revenue</span>
                    <span class="summary-value" id="ppAccruedRevenue">INR 0</span>
                    <span class="summary-note">As on date</span>
                    <i class="fas fa-coins summary-icon" aria-hidden="true"></i>
                </div>
                <div class="pp-summary-card card-red">
                    <span class="summary-label">Accrued Cost</span>
                    <span class="summary-value" id="ppAccruedCost">INR 0</span>
                    <span class="summary-note">Total resource cost</span>
                    <i class="fas fa-file-invoice-dollar summary-icon" aria-hidden="true"></i>
                </div>
                <div class="pp-summary-card card-yellow">
                    <span class="summary-label">Accrued GPM</span>
                    <span class="summary-value" id="ppAccruedGpm">INR 0</span>
                    <span class="summary-note">Gross profit margin</span>
                    <i class="fas fa-balance-scale summary-icon" aria-hidden="true"></i>
                </div>
                <div class="pp-summary-card card-green">
                    <span class="summary-label">Invoice Revenue</span>
                    <span class="summary-value" id="ppInvoiceRevenue">INR 0</span>
                    <span class="summary-note">Invoiced to date</span>
                    <i class="fas fa-receipt summary-icon" aria-hidden="true"></i>
                </div>
            </div>



      
            
            <div class="innerpgiframe">
                <!--filter panel-->
                <div id="filterpanel" class="filterpanel collapse">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                                    <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)" data-bs-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproOne" type="checkbox" name="">
                                                    <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproOne" data-bs-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)" data-bs-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="task" class="radiotextsty">Task and milestones</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproTwo" type="checkbox" name="">
                                                    <label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" for="IssueselproTwo" data-bs-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="customradio">
                                                <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)" data-bs-original-title="" title=""> <span data-bs-toggle="tooltip" data-bs-placement="right" title="" class="checkmark" data-bs-original-title="Set Default filter"></span>
                                            </label>
                                            <label class="">
                                                <span for="groupcompany" class="radiotextsty">For group company</span>
                                            </label>

                                            <div class="issfilter_actiondropdown">
                                                <div class="custom_chckbox_markblue">
                                                    <input id="IssueselproThree" type="checkbox" name="">
                                                    <label data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" for="IssueselproThree" data-bs-original-title="Apply filter"></label>
                                                </div> <span class="edit_filter"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" data-bs-original-title="Edit filter"></span>
                                                <span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="" class="far fa-trash-alt" data-bs-original-title="Delete filter"></i></span>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="">
                                    <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                                </li>


                            </ul>
                        </div>

                        <div class="Fwrapper">
                            <div class="tab-content">
                                <div id="basicfilters" class="tab-pane">
                                    <div class="filterpanelbody">
                                        <div class="text-center hidden-xs centerbtn">
                                            <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="offcanvas" data-bs-target="#Issuesavefilter">Save and Apply</button>
                                            <button class="btn btnyellow">Apply</button>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Group</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>=</option>
                                                            <option><></option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>&nbsp;</option>
                                                            <option>Work Profile</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Parameter Value</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input class="form-control input-sm" type="text" id="Fparavalue" />
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-sm-4 form-group">
                                                <label>Order Number</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>=</option>
                                                            <option><=</option>
                                                            <option><></option>
                                                            <option>></option>
                                                            <option>>=</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <input id="FOrdrNo" type="text" class="form-control" />
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-sm-4 form-group">
                                                <label>Description</label>
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <select class="form-control input-sm selectpicker fixed-width-combo" data-live-search="true">
                                                            <option>Contains</option>
                                                            <option>End With</option>
                                                            <option>Exact Word</option>
                                                            <option>Not Contains</option>
                                                            <option>Start With</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-8 pl-0">
                                                        <textarea class="form-control">&nbsp;</textarea>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
                <!--end filter panel-->
               
                <div class="clearfix"></div>
                <div class=" container-fluid pt-1 pb-1 borderbox">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="proprofitabilityFltr">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="ppProjectGroup" class="pr-0">Project Group : </label>
                                            <select id="ppProjectGroup" multiple title="Select Project Group" class="pp-msel-native">
                                            </select>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="ppProjectSelect" class="pr-0">Project : </label>
                                            <select id="ppProjectSelect" multiple title="Select Project" class="pp-msel-native">
                                            </select>

                                        </div>
                                        <div class="col-sm-3">
                                            <label for="ppBusinessGroup" class="">Business Group : </label>
                                            <select id="ppBusinessGroup" multiple title="Select Business Group" class="pp-msel-native">
                                            </select>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="ppOrganizationUnit" class="control-label">Organization Unit : </label>
                                            <select id="ppOrganizationUnit" multiple title="Select Organization Unit" class="pp-msel-native">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="ppCurrency" class="pr-0">Currency : </label>
                                            <select id="ppCurrency" title="Currency" class="pp-msel-native">
                                            </select>
                                        </div>
                                        <div class="col-sm-3 text-start">
                                            &nbsp;
                                        </div>
                                        <div class="col-sm-1 text-start">
                                        &nbsp;
                                    </div>
                                        <div class="col-sm-5 text-end">
                                            <label>&nbsp;</label><div class="clearfix"></div>
                                            <div class="dropdown filedownload pull-right" style="margin-top:5px;">
                                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-title="Click here to Export" class="fas fa-download"></i></button>
                                                <ul class="dropdown-menu">
                                                    <li><a href="javascript:;" id="ppExportPdf"><img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                                    <li><a href="javascript:;" id="ppExportExcel"><img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Excel</a></li>
                                                </ul>
                                            </div>
                                            <div class="GPMfiltr mr-1">
                                                <!-- Added By Vyankat B. on 1st Sep 2026
                                                     Default GPM filter = All GPM (was Positive GPM). -->
                                                <div class="d-inline-block">
                                                    <div class="custom_radio d-inline-block gpmpositivelbl" data-bs-toggle="tooltip" data-bs-title="Positive GPM" data-bs-container="body">
                                                        <!-- Previous: <input id="GPMpositive" name="Rgroup1" value="GPM1" type="radio" checked="checked"> -->
                                                        <input id="GPMpositive" name="Rgroup1" value="GPM1" type="radio">
                                                        <label for="GPMpositive"><span></span> <i class="far fa-flag"></i></label>
                                                    </div>
                                                </div>
                                                <div class="d-inline-block  ml-1">
                                                    <div class="custom_radio d-inline-block gpmnegativelbl" data-bs-toggle="tooltip" data-bs-title="Negative GPM" data-bs-container="body">
                                                        <input id="GPMNegative" name="Rgroup1" value="GPM2" type="radio">
                                                        <label for="GPMNegative"><span></span> <i class="far fa-flag"></i></label>
                                                    </div>
                                                </div>
                                                <div class="d-inline-block  ml-1">
                                                    <div class="custom_radio d-inline-block gpmalllbl" data-bs-toggle="tooltip" data-bs-title="All GPM" data-bs-container="body">
                                                        <!-- Previous: <input id="GPMAll" name="Rgroup1" value="GPM3" type="radio"> -->
                                                        <input id="GPMAll" name="Rgroup1" value="GPM3" type="radio" checked="checked">
                                                        <label for="GPMAll"><span></span> <i class="far fa-flag"></i></label>
                                                    </div>
                                                </div>
                                                <!-- End of Added By Vyankat B. on 1st Sep 2026 -->

                                            </div>

                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

                <div class="content pt-0">
                    <!-- Added By Vyankat B. on 1st Sep 2026 - Scroll body + fixed Grand Total footer -->
                    <div class="custVal1 Tblbox table-responsive" id="ppProfitTableWrap">
                        <div class="pp-profit-table-scroll" id="ppProfitTableScroll">
                        <table id="PPBGOUTbl" class="table table-bordered PPBGOUTbllist mb-0" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>Business Group</th>
                                    <th>Project Name</th>
                                    <th class="">Customer</th>
                                    <th>Organization Unit</th>
                                    <th>As On Date</th>
                                    <th>Accrued Revenue</th>
                                    <th>Accrued Cost</th>
                                    <th>Accrued GPM</th>
                                    <th>Accrued GPM %</th>
                                    <th>Invoice Revenue</th>
                                </tr>
                                <!-- Previous: Grand Total row was in thead (top of table).
                                <tr class="grand-total-row" id="ppGrandTotalRow" style="display:none;"></tr>
                                -->
                            </thead>
                            <tbody id="ppProfitBody">
                                <tr>
                                    <td colspan="10" class="text-center text-muted">Loading...</td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                        <div class="pp-profit-grand-total-wrap" id="ppGrandTotalWrap" style="display:none;">
                            <table id="ppGrandTotalTable" class="table table-bordered PPBGOUTbllist pp-profit-grand-total-table mb-0">
                                <tbody>
                                    <tr class="grand-total-row" id="ppGrandTotalRow"></tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                    <!-- End of Added By Vyankat B. on 1st Sep 2026 -->
                </div>

            </div>
            <div class="clearfix"></div>
   

        <!-- Save filter Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="Issuesavefilter" aria-labelledby="IssuesavefilterLabel">
    <div class="graybg container-fluid py-1 mb-2">
        <div class="row align-items-center">
            <div class="col-sm-10"><h5 class="pgtitle mb-0" id="IssuesavefilterLabel">Save Filter As</h5></div>
            <div class="col-sm-2 text-end">
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close"></button>
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
        <!-- Project people cost Modal start here-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="PPCGrossProfittmodal" aria-labelledby="PPCGrossProfittmodalLabel" style="width: 85%; max-width: 1200px;">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-10"><h5 class="pgtitle mb-0" id="PPCGrossProfittmodalLabel">Gross Profit Margin</h5></div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Close" title="Close" aria-label="Close" onclick="$('body').removeClass('offcanvas-open');"></button>
                        </div>
                    </div>
                </div>
<div id="TabGrossProfit" class="tab-pane">
                            <!--Information table start here-->
                            <div class="panel-group profitabilityinfopanel" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default panel-horizontal lightgraybg">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a role="button" data-bs-toggle="collapse" data-bs-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
                                                <span class="hideprofitabilityinfo infoToggler togglerup pull-right ml-1">
                                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-bs-original-title="Expand">
                                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Collapse">
                                                </span>
                                                Project Details
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse show" role="tabpanel" aria-labelledby="headingThree">
                                        <div class="panel-body">
                                            <table class="informationtbl mb-0" id="tblprjdtl">
                                                <tbody>
                                                    <tr>
                                                       <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
                                                        <th>Project</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start"><span class="lmtname" id="gpmProjectName">-</span></td>
                                                        <th>Project Value</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmProjectValue">-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Commercial Type</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmCommercialType">-</td>
                                                        <th>Cost Method</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmCostMethod">-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Start Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmStartDate">-</td>
                                                        <th>End Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmEndDate">-</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Actual Start Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmActualStartDate">-</td>
                                                        <th>Actual End Date</th>
                                                        <td class="colan">:</td>
                                                        <td class="pr-3 text-start" id="gpmActualEndDate">-</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--Information table End here-->

                            <div class="table-responsive">
                                <table id="gpmDetailTbl" class="table table-bordered GPMtbl">
                                    <tbody>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted">Select a project to view GPM details.</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="grossprofitinfo graybg" id="gpmProfitInfo">
                                <p>Gross Profit Margin = Total Revenue - Total Cost</p>
                            </div>


                        </div>

                    
    </div>
</div>
    <!-- Project people cost Modal End here-->




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
    <script>
        function initDashboardSelectPicker() {
            if (!$.fn.selectpicker) return;
            $('select').not('.pp-msel-native').each(function () {
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
        });

    </script>
    <!-- Bootstrap 5.3.2 -->
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>


    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });


        $(document).ready(function () {
            updateProjectProfitabilityCards();
        });

        function updateProjectProfitabilityCards() {
            var totalRow = $('#PPBGOUTbl tbody tr').first();
            if (!totalRow.length) {
                return;
            }

            var accruedRevenue = $.trim(totalRow.find('td').eq(5).text()) || '0.00';
            var accruedCost = $.trim(totalRow.find('td').eq(6).text()) || '0.00';
            var accruedGpm = $.trim(totalRow.find('td').eq(7).text()) || '0.00';
            var invoiceRevenue = $.trim(totalRow.find('td').eq(9).text()) || '0.00';

            $('#ppAccruedRevenue').text('INR ' + accruedRevenue);
            $('#ppAccruedCost').text('INR ' + accruedCost);
            $('#ppAccruedGpm').text('INR ' + accruedGpm);
            $('#ppInvoiceRevenue').text('INR ' + invoiceRevenue);
        }


        


        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        $(document).on('show.bs.collapse', '.profitabilityinfopanel .collapse', function (e) {
            $(e.target).closest('.panel').find('.infoToggler').removeClass('togglerdown').addClass('togglerup');
        });
        $(document).on('hide.bs.collapse', '.profitabilityinfopanel .collapse', function (e) {
            $(e.target).closest('.panel').find('.infoToggler').removeClass('togglerup').addClass('togglerdown');
        });

        // Entire Project Details header bar toggles accordion
        $(document).on('click', '.profitabilityinfopanel .panel-heading', function (e) {
            if ($(e.target).closest('a[data-bs-toggle="collapse"]').length) return;
            var $toggle = $(this).find('a[data-bs-toggle="collapse"]').first();
            if ($toggle.length) $toggle.trigger('click');
        });

        function getProfitabilityAccordionToggle($row) {
            var cls = ($row.attr('class') || '').split(/\s+/).find(function (c) { return /^STrow\d+$/i.test(c); });
            if (!cls) return $();
            return $('#PPBGOUTbl tr.accordion-toggle[data-bs-target=".' + cls + '"]');
        }

        $('#PPBGOUTbl').on('show.bs.collapse', '.hiddenRow', function () {
            getProfitabilityAccordionToggle($(this)).addClass('show in');
        });

        $('#PPBGOUTbl').on('hide.bs.collapse', '.hiddenRow', function () {
            var cls = ($(this).attr('class') || '').split(/\s+/).find(function (c) { return /^STrow\d+$/i.test(c); });
            if (!cls) return;
            if (!$('#PPBGOUTbl .hiddenRow.' + cls + '.collapse.show').length) {
                getProfitabilityAccordionToggle($(this)).removeClass('show in');
            }
        });

        $('#PPBGOUTbl').on('click', '.collapsicon', function (e) {
            e.stopPropagation();
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
    </script>

    <script type="text/javascript">
      /* Added By Madhuri.K - Project Profitability APIs: /api/PM_ProjectProfDash/* (POST) */
      (function () {
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
        if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);
        var defaultEmployeeID = <%=If(Session("intUserID") Is Nothing, 61, Session("intUserID"))%>;
        var accessibleProjectIds = [];
        var gpmContext = { projectCurrency: '', baseCurrency: '' };
        var lastGpmRow = null;
        var ppProfitRows = [];

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

        function apiHeaders(param, includeJsonContentType) {
          var headers = {
            'Authorization': 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || '')
          };
          if (includeJsonContentType !== false) {
            headers['Content-Type'] = 'application/json';
          }
          if (param) {
            headers['Params'] = encryptString(isJson(param) ? param : JSON.stringify(param));
          }
          return headers;
        }

        function apiPost(path, payload) {
          return fetch(encodeURI(strUrl) + path, {
            method: 'POST',
            headers: apiHeaders(payload || {}),
            body: JSON.stringify(payload || {})
          });
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

        function unwrapPayload(json) {
          if (!json) return {};
          var d = json.data != null ? json.data : (json.Data != null ? json.Data : json);
          if (!d || typeof d !== 'object' || Array.isArray(d)) return d || {};
          var inner = d.data != null ? d.data : d.Data;
          if (inner && typeof inner === 'object' && !Array.isArray(inner) &&
              (inner.ProfDashAccessibleProjectModel != null || inner.ProfDashBusinessGroupModel != null ||
               inner.ProfDashProjectGroupModel != null || inner.ProfDashCurrencyModel != null ||
               inner.ProfDashLocationModel != null || inner.ProfDashProjectProfitByProjectGroupModel != null ||
               inner.ProjectProfitabilityGpmModel != null || inner.ProjectTaskCaseStructureModel != null ||
               apiVal(inner, 'ProfDashAccessibleProjectModel', 'ProfDashBusinessGroupModel',
                 'ProfDashProjectGroupModel', 'ProfDashCurrencyModel', 'ProfDashLocationModel',
                 'ProfDashProjectProfitByProjectGroupModel', 'ProjectProfitabilityGpmModel',
                 'ProjectTaskCaseStructureModel'))) {
            return inner;
          }
          return d;
        }

        function esc(s) {
          return String(s == null ? '' : s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function apiNum(obj) {
          var v = apiVal.apply(null, arguments);
          var n = Number(v);
          return isNaN(n) ? 0 : n;
        }

        function fmtNum(v) {
          var n = Number(v);
          if (isNaN(n)) return '0.00';
          return n.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        function fmtDate(v) {
          if (v == null || v === '') return '';
          var d = new Date(v);
          if (isNaN(d.getTime())) return String(v);
          var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          return d.getDate() + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
        }

        function fmtDateDash(v) {
          if (v == null || v === '') return '';
          var d = new Date(v);
          if (isNaN(d.getTime())) return String(v);
          var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          var day = ('0' + d.getDate()).slice(-2);
          return day + '-' + months[d.getMonth()] + '-' + d.getFullYear();
        }

        var ppOpenMultiSelectId = null;
        var ppMultiSelectSearch = {};

        function closeProfitabilityMultiSelects(exceptId) {
          $('.proprofitabilityFltr .msel-panel.open').each(function () {
            var id = $(this).closest('.msel').attr('data-select-id');
            if (!exceptId || id !== exceptId) $(this).removeClass('open');
          });
          if (!exceptId) ppOpenMultiSelectId = null;
        }

        function renderProfitabilityMultiSelect($el) {
          if (!$el || !$el.length) return;
          var selectId = $el.attr('id');
          var isMultiple = !!$el.prop('multiple');
          var placeholder = $el.attr('title') || 'Select';
          var $host = $el.next('.pp-msel-host');

          if (!$host.length) {
            $host = $('<div class="msel pp-msel-host"></div>')
              .attr('data-select-id', selectId)
              .insertAfter($el);
          }

          var selected = [];
          $el.find('option:selected').each(function () {
            selected.push({ value: String(this.value), text: $(this).text() });
          });

          var buttonText = placeholder;
          if (selected.length === 1) buttonText = selected[0].text;
          else if (selected.length > 1) buttonText = 'Selected';

          $host.empty();
          var $button = $('<button type="button" class="msel-btn"></button>');
          $('<span class="msel-label"></span>').text(buttonText).appendTo($button);
          if (isMultiple && selected.length > 1) {
            $('<span class="count"></span>').text(selected.length).appendTo($button);
          } else {
            $('<span class="chev"><i class="fas fa-chevron-down"></i></span>').appendTo($button);
          }

          var $panel = $('<div class="msel-panel"></div>');
          if (ppOpenMultiSelectId === selectId) $panel.addClass('open');
          var $search = $('<input type="text" class="msel-search" />')
            .attr('placeholder', 'Search ' + placeholder.replace(/^Select\s+/i, '') + '...')
            .val(ppMultiSelectSearch[selectId] || '');
          var $rows = $('<div class="msel-rows"></div>');
          var $empty = $('<div class="msel-empty">No matches</div>').hide();

          $el.find('option').each(function () {
            var option = this;
            var label = $(option).text();
            var $row = $('<label class="msel-row"></label>')
              .attr('data-label', label.toLowerCase());
            var $input = $('<input />')
              .attr('type', isMultiple ? 'checkbox' : 'radio')
              .attr('name', 'pp-msel-' + selectId)
              .prop('checked', option.selected);
            $input.on('change', function () {
              if (isMultiple) {
                $(option).prop('selected', this.checked);
              } else {
                $el.val(String(option.value));
              }
              ppOpenMultiSelectId = selectId;
              renderProfitabilityMultiSelect($el);
              $el.trigger('change');
            });
            $row.append($input).append($('<span></span>').text(label));
            $rows.append($row);
          });

          function applySearch() {
            var term = String($search.val() || '').trim().toLowerCase();
            var visible = 0;
            $rows.find('.msel-row').each(function () {
              var show = !term || String($(this).attr('data-label')).indexOf(term) > -1;
              $(this).toggle(show);
              if (show) visible++;
            });
            $empty.toggle(visible === 0);
          }

          $search.on('input', function () {
            ppMultiSelectSearch[selectId] = this.value;
            applySearch();
          });

          var $actions = $('<div class="msel-actions"></div>');
          $('<button type="button">Clear</button>').on('click', function () {
            if (isMultiple) {
              $el.find('option').prop('selected', false);
            } else {
              var $placeholder = $el.find('option[value="0"]').first();
              $el.val($placeholder.length ? '0' : '');
            }
            ppMultiSelectSearch[selectId] = '';
            ppOpenMultiSelectId = selectId;
            renderProfitabilityMultiSelect($el);
            $el.trigger('change');
          }).appendTo($actions);
          $('<button type="button">Close</button>').on('click', function () {
            ppOpenMultiSelectId = null;
            $panel.removeClass('open');
          }).appendTo($actions);

          $panel.append($search, $rows, $empty, $actions);
          $host.append($button, $panel);
          applySearch();

          $button.on('click', function (e) {
            e.stopPropagation();
            if (ppOpenMultiSelectId === selectId) {
              ppOpenMultiSelectId = null;
              $panel.removeClass('open');
            } else {
              ppOpenMultiSelectId = selectId;
              closeProfitabilityMultiSelects(selectId);
              $panel.addClass('open');
              $search.trigger('focus');
            }
          });
          $panel.on('click', function (e) { e.stopPropagation(); });
        }

        function refreshSelect($el) {
          if (!$el || !$el.length) return;
          if ($el.data('selectpicker') && $.fn.selectpicker) {
            try { $el.selectpicker('destroy'); } catch (e) { }
          }
          $el.removeClass('selectpicker form-control fixed-width-combo')
            .addClass('pp-msel-native');
          renderProfitabilityMultiSelect($el);
        }

        $(document).off('click.ppProfitabilityMsel').on('click.ppProfitabilityMsel', function () {
          closeProfitabilityMultiSelects();
        });

        function selectedIds(selector) {
          var value = $(selector).val();
          if (value == null || value === '') return [];
          if (!Array.isArray(value)) value = [value];
          return value.map(function (id) { return String(id); })
            .filter(function (id) { return id !== '' && id !== '0'; });
        }

        function restoreSelections($sel, previous) {
          var wanted = Array.isArray(previous) ? previous.map(String) : (previous ? [String(previous)] : []);
          var available = {};
          $sel.find('option').each(function () { available[String(this.value)] = true; });
          $sel.val(wanted.filter(function (id) { return available[id]; }));
        }

        function extractLocations(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal(data, 'ProfDashLocationModel', 'profDashLocationModel');
          if (Array.isArray(rows)) return rows;
          if (rows && typeof rows === 'object') return [rows];
          return [];
        }

        function bindOrganizationUnitDropdown(rows) {
          var $sel = $('#ppOrganizationUnit');
          var prev = $sel.val();
          var list = (rows || []).slice().sort(function (a, b) {
            var oa = Number(apiVal(a, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            var ob = Number(apiVal(b, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            if (oa !== ob) return oa - ob;
            var na = String(apiVal(a, 'location', 'Location') || '');
            var nb = String(apiVal(b, 'location', 'Location') || '');
            return na.localeCompare(nb);
          });

          var html = '';
          list.forEach(function (r) {
            var id = apiVal(r, 'locationID', 'LocationID', 'locationId', 'organizationUnitID', 'OrganizationUnitID');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'location', 'Location', 'organizationUnit', 'OrganizationUnit', 'name', 'Name') || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });

          $sel.html(html);
          restoreSelections($sel, prev);
          refreshSelect($sel);
        }

        function loadOrganizationUnits() {
          var payload = {
            UserID: defaultEmployeeID,
            LoginType: 'E'
          };
          var businessGroupIDs = selectedIds('#ppBusinessGroup');
          if (businessGroupIDs.length) {
            payload.BusinessGroupIDs = businessGroupIDs.join(',');
            payload.BusinessGroupID = parseInt(businessGroupIDs[0], 10) || 0;
          }

          return apiPost('/api/PM_ProjectProfDash/GetProfitabilityLocations', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetProfitabilityLocations failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            bindOrganizationUnitDropdown(extractLocations(data));
          })
          .catch(function (err) {
            console.error(err);
            bindOrganizationUnitDropdown([]);
          });
        }

        function extractCurrencies(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal(data, 'ProfDashCurrencyModel', 'profDashCurrencyModel');
          if (Array.isArray(rows)) return rows;
          if (rows && typeof rows === 'object') return [rows];
          return [];
        }

        function bindCurrencyDropdown(rows) {
          var $sel = $('#ppCurrency');
          var prev = $sel.val();
          // Keep API order: sort only by ordinaery, then show currencyCode as returned
          var list = (rows || []).slice().sort(function (a, b) {
            var oa = Number(apiVal(a, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            var ob = Number(apiVal(b, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            if (oa !== ob) return oa - ob;
            return 0;
          });

          var html = '';
          list.forEach(function (r) {
            var id = apiVal(r, 'currencyID', 'CurrencyID', 'currencyId');
            // Added By Vyankat B. on 26th Aug 2026
            // Currency has no "Select Currency" placeholder.
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'currencyCode', 'CurrencyCode') || id;
            var symbol = apiVal(r, 'currencySymbol', 'CurrencySymbol') || '';
            html += '<option value="' + esc(id) + '" data-symbol="' + esc(symbol) + '">' + esc(name) + '</option>';
          });

          $sel.html(html);
          // Added By Vyankat B. on 26th Aug 2026
          // Default to first real currency by ordinaery (company base / SGD), skip "Select Currency".
          var firstId = null;
          var i;
          for (i = 0; i < list.length; i++) {
            var rowId = apiVal(list[i], 'currencyID', 'CurrencyID', 'currencyId');
            if (rowId != null && rowId !== '' && String(rowId) !== '0') {
              firstId = rowId;
              break;
            }
          }
          if (prev != null && prev !== '' && String(prev) !== '0' && $sel.find('option[value="' + prev + '"]').length) {
            $sel.val(String(prev));
          } else if (firstId != null && firstId !== '') {
            $sel.val(String(firstId));
          } else {
            $sel.val($sel.find('option').first().val());
          }
          // End of Added By Vyankat B. on 26th Aug 2026
          refreshSelect($sel);
        }

        function loadCurrencies() {
          var payload = {};
          return apiPost('/api/PM_ProjectProfDash/GetProfitabilityCurrency', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetProfitabilityCurrency failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            bindCurrencyDropdown(extractCurrencies(data));
          })
          .catch(function (err) {
            console.error(err);
            bindCurrencyDropdown([]);
          });
        }

        function extractProjectGroups(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal(data, 'ProfDashProjectGroupModel', 'profDashProjectGroupModel');
          if (Array.isArray(rows)) return rows;
          if (rows && typeof rows === 'object') return [rows];
          return [];
        }

        function bindProjectGroupDropdown(rows) {
          var $sel = $('#ppProjectGroup');
          var prev = $sel.val();
          var list = (rows || []).slice().sort(function (a, b) {
            var oa = Number(apiVal(a, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            var ob = Number(apiVal(b, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            if (oa !== ob) return oa - ob;
            var na = String(apiVal(a, 'projectGroupName', 'ProjectGroupName') || '');
            var nb = String(apiVal(b, 'projectGroupName', 'ProjectGroupName') || '');
            return na.localeCompare(nb);
          });

          var html = '';
          list.forEach(function (r) {
            var id = apiVal(r, 'projectGroupID', 'ProjectGroupID', 'projectGroupId');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'projectGroupName', 'ProjectGroupName', 'name', 'Name') || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });

          $sel.html(html);
          restoreSelections($sel, prev);
          refreshSelect($sel);
        }

        function loadProjectGroups() {
          var payload = {
            LoginType: 'E'
          };
          return apiPost('/api/PM_ProjectProfDash/GetProjectGroupForProfitability', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetProjectGroupForProfitability failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            bindProjectGroupDropdown(extractProjectGroups(data));
          })
          .catch(function (err) {
            console.error(err);
            bindProjectGroupDropdown([]);
          });
        }

        function extractBusinessGroups(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal(data, 'ProfDashBusinessGroupModel', 'profDashBusinessGroupModel');
          if (Array.isArray(rows)) return rows;
          if (rows && typeof rows === 'object') return [rows];
          return [];
        }

        function bindBusinessGroupDropdown(rows) {
          var $sel = $('#ppBusinessGroup');
          var prev = $sel.val();
          var list = (rows || []).slice().sort(function (a, b) {
            var oa = Number(apiVal(a, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            var ob = Number(apiVal(b, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            if (oa !== ob) return oa - ob;
            var na = String(apiVal(a, 'businessGroup', 'BusinessGroup') || '');
            var nb = String(apiVal(b, 'businessGroup', 'BusinessGroup') || '');
            return na.localeCompare(nb);
          });

          var html = '';
          list.forEach(function (r) {
            var id = apiVal(r, 'businessGroupID', 'BusinessGroupID', 'businessGroupId');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'businessGroup', 'BusinessGroup', 'name', 'Name') || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
          });

          $sel.html(html);
          restoreSelections($sel, prev);
          refreshSelect($sel);
        }

        function loadBusinessGroups() {
          var payload = {
            UserID: defaultEmployeeID,
            LoginType: 'E'
          };
          return apiPost('/api/PM_ProjectProfDash/GetBusinessGroup', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetBusinessGroup failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            bindBusinessGroupDropdown(extractBusinessGroups(data));
          })
          .catch(function (err) {
            console.error(err);
            bindBusinessGroupDropdown([]);
          });
        }

        function extractAccessibleProjects(data) {
          if (!data) return [];
          if (Array.isArray(data)) return data;
          var rows = apiVal(data, 'ProfDashAccessibleProjectModel', 'profDashAccessibleProjectModel');
          if (Array.isArray(rows)) return rows;
          if (rows && typeof rows === 'object') return [rows];
          return [];
        }

        function bindProjectDropdown(rows) {
          var $sel = $('#ppProjectSelect');
          var prev = $sel.val();
          var list = (rows || []).slice().sort(function (a, b) {
            var oa = Number(apiVal(a, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            var ob = Number(apiVal(b, 'ordinaery', 'Ordinaery', 'ordinary', 'Ordinary') || 0);
            if (oa !== ob) return oa - ob;
            var na = String(apiVal(a, 'projectName', 'ProjectName') || '');
            var nb = String(apiVal(b, 'projectName', 'ProjectName') || '');
            return na.localeCompare(nb);
          });

          accessibleProjectIds = [];
          var html = '';
          list.forEach(function (r) {
            var id = apiVal(r, 'projectID', 'ProjectID', 'projectId', 'ProjectId');
            if (id == null || id === '' || String(id) === '0') return;
            var name = apiVal(r, 'projectName', 'ProjectName', 'name', 'Name') || id;
            html += '<option value="' + esc(id) + '">' + esc(name) + '</option>';
            if (accessibleProjectIds.indexOf(String(id)) === -1) accessibleProjectIds.push(String(id));
          });
          $sel.html(html);
          restoreSelections($sel, prev);
          refreshSelect($sel);
        }

        function buildProjectPayload() {
          var payload = {
            LoginType: 'E',
            EmployeeID: defaultEmployeeID
          };
          var projectGroupIDs = selectedIds('#ppProjectGroup');
          var businessGroupIDs = selectedIds('#ppBusinessGroup');
          var organizationUnitIDs = selectedIds('#ppOrganizationUnit');
          if (projectGroupIDs.length) {
            payload.ProjectGroupIDs = projectGroupIDs.join(',');
            payload.ProjectGroupId = parseInt(projectGroupIDs[0], 10) || 0;
          }
          if (businessGroupIDs.length) {
            payload.BusinessGroupIDs = businessGroupIDs.join(',');
            payload.BusinessGroupID = parseInt(businessGroupIDs[0], 10) || 0;
          }
          if (organizationUnitIDs.length) {
            payload.OrganizationUnitIDs = organizationUnitIDs.join(',');
            payload.OrganizationUnitID = parseInt(organizationUnitIDs[0], 10) || 0;
          }
          return payload;
        }

        function getGpmTrend() {
          if (document.getElementById('GPMpositive') && document.getElementById('GPMpositive').checked) return 1;
          if (document.getElementById('GPMNegative') && document.getElementById('GPMNegative').checked) return -1;
          return 0;
        }

        function buildProfitabilityPayload() {
          var businessGroupIDs = selectedIds('#ppBusinessGroup');
          var locationIDs = selectedIds('#ppOrganizationUnit');
          var projectIDs = selectedIds('#ppProjectSelect');
          var projectGroupIDs = selectedIds('#ppProjectGroup');
          var currencyVal = parseInt($('#ppCurrency').val(), 10);
          if (isNaN(currencyVal)) currencyVal = 0;
          var resolvedProjectIDs = projectIDs.length
            ? projectIDs.join(',')
            : ((accessibleProjectIds && accessibleProjectIds.length) ? accessibleProjectIds.join(',') : '');

          return {
            businessGroupID: businessGroupIDs.join(','),
            locationID: locationIDs.join(','),
            projectIDs: resolvedProjectIDs,
            projectID: projectIDs.length === 1 ? (parseInt(projectIDs[0], 10) || 0) : 0,
            gpmTrend: getGpmTrend(),
            projectGroupID: projectGroupIDs.join(','),
            currencyID: currencyVal
          };
        }

        function buildExportPayload() {
          return buildProfitabilityPayload();
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
            try { return decodeURIComponent(star[1].replace(/"/g, '').trim()); } catch (e) { /* ignore */ }
          }
          var m = /filename\s*=\s*("?)([^";]+)\1/i.exec(header);
          if (m && m[2]) return m[2].trim();
          return fallback;
        }

        function exportProfitability(kind) {
          var isPdf = kind === 'pdf';
          var apiPath = isPdf
            ? '/api/PM_ProjectProfDash/ExportPdf'
            : '/api/PM_ProjectProfDash/ExportExcel';
          var ext = isPdf ? 'pdf' : 'xlsx';
          var fileName = 'Project_Profitability_' + getTodayYYYYMMDD() + '.' + ext;
          var $link = $(isPdf ? '#ppExportPdf' : '#ppExportExcel');
          if ($link.data('exporting')) return;
          $link.data('exporting', true).addClass('disabled');

          apiPost(apiPath, buildExportPayload())
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
                  msg = (json && (json.message || (json.data && json.data.message))) || msg;
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
            console.error((isPdf ? 'PDF' : 'Excel') + ' export failed:', err);
            alert(err && err.message ? err.message : ('Unable to export ' + (isPdf ? 'PDF' : 'Excel') + '.'));
          })
          .then(function () {
            $link.data('exporting', false).removeClass('disabled');
          });
        }
//  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        function isProfitGrandTotalRow(r) {
          if (!r) return false;
          var flag = apiVal(r, 'isGrandTotal', 'IsGrandTotal');
          if (flag === true || flag === 1 || String(flag).toLowerCase() === 'true') return true;
          var name = String(apiVal(r, 'projectName', 'ProjectName') || '');
          return /^grand total$/i.test(name.trim());
        }

        function extractApiGrandTotals(row) {
          if (!row) return { rev: 0, cost: 0, gpm: 0, inv: 0, pct: 0, symbol: 'INR' };
          var rev = apiNum(row, 'accruedRevenue', 'AccruedRevenue');
          var gpm = apiNum(row, 'accruedGPM', 'AccruedGPM');
          var pct = apiNum(row, 'accruedGPMPercent', 'AccruedGPMPercent');
          if (!pct && rev) pct = (gpm / rev) * 100;
          return {
            rev: rev,
            cost: apiNum(row, 'accruedCost', 'AccruedCost'),
            gpm: gpm,
            inv: apiNum(row, 'invoiceRevenue', 'InvoiceRevenue'),
            pct: pct,
            symbol: apiVal(row, 'currencySymbol', 'CurrencySymbol') || 'INR'
          };
        }

        function updateSummaryCards(totals, currencySymbol) {
          var sym = currencySymbol || 'INR';
          $('#ppAccruedRevenue').text(sym + ' ' + fmtNum(totals.rev));
          $('#ppAccruedCost').text(sym + ' ' + fmtNum(totals.cost));
          $('#ppAccruedGpm').text(sym + ' ' + fmtNum(totals.gpm));
          $('#ppInvoiceRevenue').text(sym + ' ' + fmtNum(totals.inv));
        }

        function renderProjectProfitability(rows, totalsRows) {
          var $body = $('#ppProfitBody');
          var allRows = (totalsRows && totalsRows.length) ? totalsRows : (rows || []);
          //  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
          var grandRow = null;
          var projectRows = [];
          allRows.forEach(function (r) {
            if (isProfitGrandTotalRow(r)) grandRow = r;
            else projectRows.push(r);
          });
          var displayRows = (rows || []).filter(function (r) { return !isProfitGrandTotalRow(r); });

          if (!displayRows.length && !grandRow) {
            $('#ppGrandTotalRow').empty();
            $('#ppGrandTotalWrap').hide();
            $body.html('<tr><td colspan="10" class="text-center text-muted">No data found for the selected filters.</td></tr>');
            updateSummaryCards({ rev: 0, cost: 0, gpm: 0, inv: 0 }, 'INR');
            return;
          }

          var groups = {};
          var groupOrder = [];
          var grand = grandRow
            ? extractApiGrandTotals(grandRow)
            : { rev: 0, cost: 0, gpm: 0, inv: 0, pct: 0, symbol: 'INR' };
          var currencySymbol = grand.symbol || apiVal((grandRow || displayRows[0] || {}), 'currencySymbol', 'CurrencySymbol') || 'INR';

          displayRows.forEach(function (r) {
            var bg = apiVal(r, 'businessGroup', 'BusinessGroup') || 'Unknown';
            if (!groups[bg]) {
              groups[bg] = { rows: [], rev: 0, cost: 0, gpm: 0, inv: 0 };
              groupOrder.push(bg);
            }
            groups[bg].rows.push(r);
          });

          // Group subtotals from project rows. Grand Total comes only from isGrandTotal API row.
          projectRows.forEach(function (r) {
            var bg = apiVal(r, 'businessGroup', 'BusinessGroup') || 'Unknown';
            var rev = apiNum(r, 'accruedRevenue', 'AccruedRevenue');
            var cost = apiNum(r, 'accruedCost', 'AccruedCost');
            var gpm = apiNum(r, 'accruedGPM', 'AccruedGPM');
            var inv = apiNum(r, 'invoiceRevenue', 'InvoiceRevenue');
            if (groups[bg]) {
              groups[bg].rev += rev; groups[bg].cost += cost; groups[bg].gpm += gpm; groups[bg].inv += inv;
            }
            if (!grandRow) {
              grand.rev += rev; grand.cost += cost; grand.gpm += gpm; grand.inv += inv;
            }
          });
          if (!grandRow && grand.rev) grand.pct = (grand.gpm / grand.rev) * 100;

          var html = '';
          var grandHtml = '<td>Grand Total</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>';
          // Added By Vyankat B. on 26th Aug 2026
          var moneySym = getSelectedCurrencySymbol() || currencySymbol || '';
          grandHtml += '<td>' + fmtMoney(grand.rev, moneySym) + '</td>';
          grandHtml += '<td>' + fmtMoney(grand.cost, moneySym) + '</td>';
          grandHtml += '<td>' + fmtMoney(grand.gpm, moneySym) + '</td>';
          grandHtml += '<td>' + fmtNum(grand.pct) + '</td>';
          grandHtml += '<td>' + fmtMoney(grand.inv, moneySym) + '</td>';
          // End of Added By Vyankat B. on 26th Aug 2026
          $('#ppGrandTotalRow').html(grandHtml);
          $('#ppGrandTotalWrap').show();

          groupOrder.forEach(function (bg, idx) {
            var g = groups[bg];
            var rowClass = 'STrow' + (idx + 1);
            var expanded = idx === 0;

            // Added By Vyankat B. on 1st Sep 2026
            // Row 1: Business Group name at top. Row 2: projects. Row 3: group totals below.
            html += '<tr data-bs-toggle="collapse" data-bs-target=".' + rowClass + '" class="accordion-toggle pp-bg-header-row' + (expanded ? ' show' : '') + '" aria-expanded="' + expanded + '">';
            html += '<td class="bg-tbl-head text-start"><span class="pp-bg-toggle"><span class="pp-bg-name">' + esc(bg) + '</span>';
            html += '<a href="javascript:;" class="nostyle collapsicon" data-bs-toggle="collapse" data-bs-target=".' + rowClass + '" aria-expanded="' + expanded + '" title="' + (expanded ? 'Hide Details' : 'View Details') + '">';
            html += '<i class="fas fa-chevron-down collapsedown" aria-hidden="true"></i>';
            html += '<i class="fas fa-chevron-up collapseup" aria-hidden="true"></i>';
            html += '</a></span></td>';
            html += '<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>';
            html += '<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>';
            html += '</tr>';

            g.rows.forEach(function (r) {
              var gpm = apiNum(r, 'accruedGPM', 'AccruedGPM');
              var gpmClass = gpm < 0 ? 'negativeGPMrow' : 'positiveGPMrow';
              var projectId = apiVal(r, 'projectID', 'ProjectID') || 0;
              var profitId = apiVal(r, 'projectProfitabilityID', 'ProjectProfitabilityID') || '';
              html += '<tr class="' + rowClass + ' hiddenRow collapse' + (expanded ? ' show' : '') + ' ' + gpmClass + '" data-project-id="' + esc(projectId) + '" data-profit-id="' + esc(profitId) + '">';
              html += '<td></td>';
              html += '<td><a href="javascript:;" class="pp-project-link" data-project-id="' + esc(projectId) + '" data-currency="' + esc(apiVal(r, 'currencySymbol', 'CurrencySymbol') || '') + '" data-base-currency="' + esc(apiVal(r, 'baseCurrencySymbol', 'BaseCurrencySymbol') || apiVal(r, 'currencySymbol', 'CurrencySymbol') || '') + '">' + esc(apiVal(r, 'projectName', 'ProjectName') || '') + '</a></td>';
              html += '<td>' + esc(apiVal(r, 'customerName', 'CustomerName') || '') + '</td>';
              html += '<td>' + esc(apiVal(r, 'location', 'Location') || '') + '</td>';
              html += '<td>' + esc(fmtDate(apiVal(r, 'toDate', 'ToDate', 'fromDate', 'FromDate'))) + '</td>';
              html += '<td>' + fmtNum(apiNum(r, 'accruedRevenue', 'AccruedRevenue')) + '</td>';
              html += '<td>' + fmtNum(apiNum(r, 'accruedCost', 'AccruedCost')) + '</td>';
              html += '<td>' + fmtNum(gpm) + '</td>';
              html += '<td>' + fmtNum(apiNum(r, 'accruedGPMPercent', 'AccruedGPMPercent')) + '</td>';
              html += '<td>' + fmtNum(apiNum(r, 'invoiceRevenue', 'InvoiceRevenue')) + '</td>';
              html += '</tr>';
            });

            html += '<tr class="pp-bg-subtotal-row ' + rowClass + '-total">';
            html += '<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>';
            html += '<td>' + fmtMoney(g.rev, moneySym) + '</td>';
            html += '<td>' + fmtMoney(g.cost, moneySym) + '</td>';
            html += '<td>' + fmtMoney(g.gpm, moneySym) + '</td>';
            html += '<td>' + (g.rev !== 0 ? fmtNum((g.gpm / g.rev) * 100) : '0.00') + '</td>';
            html += '<td>' + fmtMoney(g.inv, moneySym) + '</td>';
            html += '</tr>';
            // Previous: Business Group name and totals were on the same row (top or bottom).
            // End of Added By Vyankat B. on 1st Sep 2026

            if (idx < groupOrder.length - 1) {
              html += '<tr class="rowdivider"><td colspan="10"></td></tr>';
            }
          });

          $body.html(html);
          updateSummaryCards(grand, currencySymbol);
          syncProfitTableLayout();
          requestAnimationFrame(function () { syncProfitTableLayout(); });
          try { $('[data-bs-toggle="tooltip"]').tooltip(); } catch (e) { }
        }

        function syncProfitStickyHeader() {
          var $head = $('#PPBGOUTbl thead tr:first');
          var h = $head.outerHeight() || 38;
          $('#PPBGOUTbl').css('--pp-thead-h', h + 'px');
        }

        // Added By Vyankat B. on 1st Sep 2026
        // Fill remaining iframe height; align fixed Grand Total footer columns with main grid.
        function syncProfitTableLayout() {
          var $wrap = $('#ppProfitTableWrap');
          if (!$wrap.length || !$wrap[0].getBoundingClientRect) return;

          var rect = $wrap[0].getBoundingClientRect();
          var vh = window.innerHeight || document.documentElement.clientHeight || 600;
          var bottomPad = 16;
          var minH = 360;
          var availableH = Math.max(minH, Math.floor(vh - rect.top - bottomPad));

          $wrap.css({
            height: availableH + 'px',
            maxHeight: availableH + 'px'
          });

          var $ths = $('#PPBGOUTbl thead tr:first th');
          var $tds = $('#ppGrandTotalRow td');
          var tableW = $('#PPBGOUTbl').outerWidth() || '100%';
          $('#ppGrandTotalTable').css('width', tableW);
          $ths.each(function (idx) {
            var w = $(this).outerWidth();
            if ($tds.eq(idx).length) {
              $tds.eq(idx).css({ width: w + 'px', minWidth: w + 'px', maxWidth: w + 'px' });
            }
          });

          syncProfitStickyHeader();
        }
        // End of Added By Vyankat B. on 1st Sep 2026

        function renderProfitabilityPage() {
          renderProjectProfitability(ppProfitRows, ppProfitRows);
        }

        function loadProjectProfitability() {
          var $body = $('#ppProfitBody');
          $('#ppGrandTotalRow').empty();
          $('#ppGrandTotalWrap').hide();
          $body.html('<tr><td colspan="10" class="text-center text-muted">Loading...</td></tr>');
          var payload = buildProfitabilityPayload();
          return apiPost('/api/PM_ProjectProfDash/GetProjectProfitability', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetProjectProfitability failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = apiVal(data, 'ProfDashProjectProfitByProjectGroupModel', 'profDashProjectProfitByProjectGroupModel') || [];
            if (!Array.isArray(rows)) rows = [];
            ppProfitRows = rows;
            renderProfitabilityPage();
          })
          .catch(function (err) {
            console.error(err);
            ppProfitRows = [];
            $body.html('<tr><td colspan="10" class="text-center text-danger">Unable to load profitability data.</td></tr>');
            updateSummaryCards({ rev: 0, cost: 0, gpm: 0, inv: 0 }, 'INR');
          });
        }

        function loadAccessibleProjects() {
          var payload = buildProjectPayload();
          return apiPost('/api/PM_ProjectProfDash/GetProfitabilityAccessibleProjects', payload)
          .then(function (res) {
            if (!res.ok) throw new Error('GetProfitabilityAccessibleProjects failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            bindProjectDropdown(extractAccessibleProjects(data));
          })
          .catch(function (err) {
            console.error(err);
            accessibleProjectIds = [];
            bindProjectDropdown([]);
          });
        }

        function reloadProjectsAndGrid() {
          return loadAccessibleProjects().then(function () {
            return loadProjectProfitability();
          });
        }

        // Added By Vyankat B. on 26th Aug 2026
        function getSelectedCurrencySymbol() {
          var $opt = $('#ppCurrency option:selected');
          if (!$opt.length) return '';
          return String($opt.attr('data-symbol') || '').trim();
        }
        // End of Added By Vyankat B. on 26th Aug 2026

        function fmtMoney(v, symbol) {
          var amt = fmtNum(v);
          var sym = String(symbol == null ? '' : symbol).trim();
          return sym ? (esc(sym) + ' ' + amt) : amt;
        }

        function isEmptyDate(v) {
          if (v == null || v === '') return true;
          var s = String(v).trim();
          if (!s) return true;
          if (s.indexOf('1900-01-01') === 0) return true;
          return false;
        }

        function resetProjectHeader() {
          $('#gpmProjectName').text('-');
          $('#gpmProjectValue').text('-');
          $('#gpmCommercialType').text('-');
          $('#gpmStartDate').text('-');
          $('#gpmEndDate').text('-');
          $('#gpmCostMethod').text('-');
          $('#gpmActualStartDate').text('-');
          $('#gpmActualEndDate').text('-');
        }

        function renderProjectHeader(row) {
          if (!row) {
            resetProjectHeader();
            return;
          }
          var currency = apiVal(row, 'currencySymbol', 'CurrencySymbol') || '';
          if (currency) gpmContext.projectCurrency = currency;
          if (lastGpmRow) renderGpmDetail(lastGpmRow);
          var contractVal = apiVal(row, 'contractValue', 'ContractValue');
          var projectValue = '-';
          if (contractVal != null && contractVal !== '') {
            projectValue = (currency ? (currency + ' ') : '') + fmtNum(contractVal);
          }

          $('#gpmProjectName').text(apiVal(row, 'projectName', 'ProjectName') || '-');
          $('#gpmProjectValue').text(projectValue);
          $('#gpmCommercialType').text(apiVal(row, 'nodeLabel', 'NodeLabel') || '-');
          var startDt = apiVal(row, 'expectedStartDate', 'ExpectedStartDate');
          var endDt = apiVal(row, 'expectedEndDate', 'ExpectedEndDate');
          $('#gpmStartDate').text(isEmptyDate(startDt) ? '-' : (String(startDt).indexOf('-') === 2 || String(startDt).match(/[A-Za-z]/) ? String(startDt) : fmtDateDash(startDt)));
          $('#gpmEndDate').text(isEmptyDate(endDt) ? '-' : (String(endDt).indexOf('-') === 2 || String(endDt).match(/[A-Za-z]/) ? String(endDt) : fmtDateDash(endDt)));
          $('#gpmCostMethod').text(apiVal(row, 'costMethod', 'CostMethod') || '-');

          var actualStart = apiVal(row, 'actualStartDate', 'ActualStartDate');
          var actualEnd = apiVal(row, 'actualEndDate', 'ActualEndDate');
          $('#gpmActualStartDate').text(isEmptyDate(actualStart) ? '-' : fmtDateDash(actualStart));
          $('#gpmActualEndDate').text(isEmptyDate(actualEnd) ? '-' : fmtDateDash(actualEnd));
        }

        function loadTaskCaseStructure(projectId) {
          var pid = parseInt(projectId, 10) || 0;
          resetProjectHeader();
          if (!pid) return;

          apiPost('/api/ProjectProfitByCustomer/GetTaskCaseStructure', { ProjectId: pid })
          .then(function (res) {
            if (!res.ok) throw new Error('GetTaskCaseStructure failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = apiVal(data, 'ProjectTaskCaseStructureModel', 'projectTaskCaseStructureModel', 'TaskCaseStructureModel') || [];
            if (!Array.isArray(rows)) {
              if (Array.isArray(data)) rows = data;
              else if (data && typeof data === 'object' && (apiVal(data, 'projectName', 'ProjectName') != null || apiVal(data, 'haveSubTaskTypes', 'HaveSubTaskTypes') != null))
                rows = [data];
              else rows = [];
            }
            renderProjectHeader(rows.length ? rows[0] : null);
          })
          .catch(function (err) {
            console.error(err);
            resetProjectHeader();
          });
        }

        function renderGpmDetail(row) {
          var $tbl = $('#gpmDetailTbl tbody');
          var $info = $('#gpmProfitInfo');
          if (!row) {
            $tbl.html('<tr><td colspan="3" class="text-center text-muted">No GPM details found.</td></tr>');
            $info.html('<p>Gross Profit Margin = Total Revenue - Total Cost</p>');
            return;
          }

          var peopleRev = apiNum(row, 'peopleRevenue', 'PeopleRevenue');
          var billExp = apiNum(row, 'accruedBillableExpenses', 'AccruedBillableExpenses', 'accuredBillableExpenses', 'AccuredBillableExpenses');
          var totalRev = apiNum(row, 'total', 'Total', 'totalRevenue', 'TotalRevenue');
          if (!totalRev && (peopleRev || billExp)) totalRev = peopleRev + billExp;

          var basePeopleRev = apiNum(row, 'basePeopleRevenue', 'BasePeopleRevenue');
          var baseBillExp = apiNum(row, 'baseAccruedBillableExpenses', 'BaseAccruedBillableExpenses', 'baseAccuredBillableExpenses', 'BaseAccuredBillableExpenses');
          var baseTotalRev = apiNum(row, 'baseTotal', 'BaseTotal', 'baseTotalRevenue', 'BaseTotalRevenue');
          if (!baseTotalRev && (basePeopleRev || baseBillExp)) baseTotalRev = basePeopleRev + baseBillExp;

          var peopleCost = apiNum(row, 'peopleCost', 'PeopleCost');
          var totalCost = apiNum(row, 'totalCost', 'TotalCost', 'cost', 'Cost');
          var basePeopleCost = apiNum(row, 'basePeopleCost', 'BasePeopleCost');
          var baseTotalCost = apiNum(row, 'baseTotalCost', 'BaseTotalCost', 'baseCost', 'BaseCost');

          var gpmSym = String(apiVal(row, 'currencySymbol', 'CurrencySymbol') || '').trim();
          var projSym = String(gpmContext.projectCurrency || '').trim();
          var baseSym = String(gpmContext.baseCurrency || apiVal(row, 'baseCurrencySymbol', 'BaseCurrencySymbol') || '').trim();
          if (!projSym) projSym = gpmSym;
          if (!baseSym && gpmSym && gpmSym !== projSym) baseSym = gpmSym;
          if (!baseSym) baseSym = gpmSym;

          var toDate = apiVal(row, 'toDate', 'ToDate', 'asOn', 'AsOn', 'fromDate', 'FromDate');
          var gpm = totalRev - totalCost;
          var gpmBase = baseTotalRev - baseTotalCost;

          var html = '';
          html += '<tr class="grouprow">';
          html += '<th align="left">Accrued Revenue</th>';
          html += '<th>Project Currency' + (projSym ? '(' + esc(projSym) + ')' : '') + '</th>';
          html += '<th class="text-end">Corporate Base Currency' + (baseSym ? '(' + esc(baseSym) + ')' : '') + '</th>';
          html += '</tr>';
          html += '<tr><td align="left">People Revenue</td><td align="right">' + fmtNum(peopleRev) + '</td><td align="right">' + fmtNum(basePeopleRev) + '</td></tr>';
          html += '<tr><td align="left">Accured Billable Expenses</td><td align="right">' + fmtNum(billExp) + '</td><td align="right">' + fmtNum(baseBillExp) + '</td></tr>';
          html += '<tr class="ttlrow"><td align="left">Total Revenue</td><td align="right">' + fmtMoney(totalRev, projSym) + '</td><td align="right">' + fmtMoney(baseTotalRev, baseSym) + '</td></tr>';
          html += '<tr class="grouprow"><th align="left">Accrued Cost</th><th>&nbsp;</th><th>&nbsp;</th></tr>';
          html += '<tr><td align="left">People Cost</td><td align="right">' + fmtNum(peopleCost) + '</td><td align="right">' + fmtNum(basePeopleCost) + '</td></tr>';
          html += '<tr class="ttlrow"><td align="left">Total Cost</td><td align="right">' + fmtMoney(totalCost, projSym) + '</td><td align="right">' + fmtMoney(baseTotalCost, baseSym) + '</td></tr>';
          $tbl.html(html);

          var asOnLabel = toDate ? fmtDateDash(toDate) : '';
          var infoHtml = '<table class="gpm-footer-tbl"><tr>';
          infoHtml += '<td>Gross Profit Margin' + (asOnLabel ? ' (as on : ' + esc(asOnLabel) + ' )' : '') + ' = Total Revenue - Total Cost</td>';
          infoHtml += '<td>' + fmtMoney(gpm, projSym) + '</td>';
          infoHtml += '<td>' + fmtMoney(gpmBase, baseSym) + '</td>';
          infoHtml += '</tr></table>';
          $info.html(infoHtml);
        }

        function loadGpmDetail(projectId) {
          var pid = parseInt(projectId, 10) || 0;
          var $tbl = $('#gpmDetailTbl tbody');
          var $info = $('#gpmProfitInfo');
          if (!pid) {
            $tbl.html('<tr><td colspan="3" class="text-center text-muted">Invalid project.</td></tr>');
            return;
          }

          $tbl.html('<tr><td colspan="3" class="text-center text-muted">Loading GPM details...</td></tr>');
          $info.html('<p>Gross Profit Margin = Total Revenue - Total Cost</p>');

          apiPost('/api/ProjectProfitByCustomer/GetGpm', { ProjectID: pid })
          .then(function (res) {
            if (!res.ok) throw new Error('GetGpm failed: ' + res.status);
            return res.json();
          })
          .then(function (json) {
            var data = unwrapPayload(json);
            var rows = apiVal(data, 'ProjectProfitabilityGpmModel', 'projectProfitabilityGpmModel') || [];
            if (!Array.isArray(rows)) rows = [];
            var row = rows.length ? rows[rows.length - 1] : null;
            lastGpmRow = row;
            renderGpmDetail(row);
          })
          .catch(function (err) {
            console.error(err);
            lastGpmRow = null;
            $tbl.html('<tr><td colspan="3" class="text-center text-danger">Unable to load GPM details.</td></tr>');
          });
        }

        function openGpmModal(projectId) {
          loadTaskCaseStructure(projectId);
          loadGpmDetail(projectId);
          var $collapse = $('#collapseThree');
          $collapse.addClass('show');
          $collapse.closest('.panel').find('.infoToggler').removeClass('togglerdown').addClass('togglerup');
          $collapse.closest('.panel').find('[data-bs-toggle="collapse"]').attr('aria-expanded', 'true');

          var modalEl = document.getElementById('PPCGrossProfittmodal');
          $('body').addClass('offcanvas-open');
          if (window.bootstrap && bootstrap.Offcanvas) {
            bootstrap.Offcanvas.getOrCreateInstance(modalEl).show();
          } else {
            $(modalEl).offcanvas('show');
          }
        }

        $(document).ready(function () {
          Promise.all([loadProjectGroups(), loadBusinessGroups(), loadCurrencies()])
            .then(function () { return loadOrganizationUnits(); })
            .then(function () { return reloadProjectsAndGrid(); });

          $('#ppBusinessGroup').on('change', function () {
            loadOrganizationUnits().then(function () {
              reloadProjectsAndGrid();
            });
          });
          $('#ppProjectGroup, #ppOrganizationUnit').on('change', function () {
            reloadProjectsAndGrid();
          });
          $('#ppProjectSelect, #ppCurrency').on('change', function () {
            loadProjectProfitability();
          });
          $('input[name="Rgroup1"]').on('change', function () {
            loadProjectProfitability();
          });
          $('#ppExportPdf').on('click', function (e) {
            e.preventDefault();
            exportProfitability('pdf');
          });
          $('#ppExportExcel').on('click', function (e) {
            e.preventDefault();
            exportProfitability('excel');
          });
          $('#ppProfitBody').on('click', '.pp-project-link', function (e) {
            e.preventDefault();
            var $link = $(this);
            $('.pp-project-link').removeClass('oc-link-active');
            $link.addClass('oc-link-active');
            gpmContext.baseCurrency = $link.attr('data-base-currency') || '';
            gpmContext.projectCurrency = $link.attr('data-currency') || '';
            openGpmModal($link.attr('data-project-id'));
          });
          $('#PPCGrossProfittmodal').on('hidden.bs.offcanvas', function () {
            $('.pp-project-link').removeClass('oc-link-active');
            $('body').removeClass('offcanvas-open');
          });

          // Added By Vyankat B. on 1st Sep 2026 - Recalc grid height on resize / filter panel toggle
          $(window).on('resize load', syncProfitTableLayout);
          $('#filterpanel').on('shown.bs.collapse hidden.bs.collapse', function () {
            setTimeout(syncProfitTableLayout, 200);
          });
          $('#PPBGOUTbl').on('shown.bs.collapse hidden.bs.collapse', function () {
            setTimeout(syncProfitTableLayout, 50);
          });
          $('#ppProfitTableScroll').on('scroll', function () {
            var sl = this.scrollLeft || 0;
            $('#ppGrandTotalWrap').scrollLeft(sl);
          });
          setTimeout(syncProfitTableLayout, 100);
          setTimeout(syncProfitTableLayout, 500);
          // End of Added By Vyankat B. on 1st Sep 2026
        });
      })();
    </script>

    </form>
</body>
</html>
