<%@ Page Language="vb" EnableSessionState="true" AutoEventWireup="false" CodeBehind="Navigation.aspx.vb" Inherits="Whizible.Navigation" %>

<!DOCTYPE HTML>
<html>

<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="X-UA-Compatible" content="IE=5,8,9,11">
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
 <!-- title Added By Madhuri.K on 25-03-2026 -->
    <title>Whizible 26</title>
    <!-- Logo Added By Madhuri.K on 26-03-2026 -->
    <link rel="icon" type="image/png" href="<%= ResolveUrl("~/Whizible2.0-new/dist/img/Whizible-app-logo.png") %>?v=26" />
    <link rel="shortcut icon" type="image/png" href="<%= ResolveUrl("~/Whizible2.0-new/dist/img/Whizible-app-logo.png") %>?v=26" />
    <!-- End of Logo Added By Madhuri.K on 26-03-2026 -->   
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta charset="UTF-8">
    <%--  Added By Dipali V On 22nd Dec 2020 For Jquery Version--%>
<%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
        <%--End of Added By Dipali V On 22nd Dec 2020 For Jquery Version--%>
    		<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
    <%--<link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

    <style>
        @media only screen and (max-width: 766px) {
            .comments-container {
                width: 480px;
            }

            .comments-list .comment-box {
                width: 390px;
            }

            .reply-list .comment-box {
                width: 320px;
            }

            #MainDiv {
                display: none !important;
            }

            #page {
                display: block !important;
            }

            body.fixed-nav {
                padding-top: 0px;
            }
        }

        #frmNewVersion {
            padding-left: 10px !important;
        }
       
        /*<%--Added By Dipali V On 11th jan 2021 for check Module Access--%>*/
        #DivCheckModuleAccess {
            text-align: center !important;
            padding: 130px;
            display: none;
        }
       /*<%--Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>*/
       /* //Added By Dipali V On 1st Aug 2023 For Session Project */
        #cboSessionProject {
            display: inline-block;
            height: 26px;
            width: 210px;
            padding: 2px 28px 2px 8px;
            font-size: 12px;
            font-weight: 400;
            line-height: 1.4;
            color: #464a4c;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            vertical-align: middle;
            cursor: pointer;
            outline: none;
            /*box-shadow: inset 0 1px 2px rgba(0,0,0,.08);*/
            position: relative;
            top: -15px;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
        }
        #cboSessionProject:focus {
            border-color: #4263c1;
            box-shadow: 0 0 0 2px rgba(66,99,193,.15);
        }
        /*.cbo-session-project-select-wrap {
            display: inline-block;
            position: relative;
            vertical-align: middle;
        }
        .cbo-session-project-select-wrap::after {
            content: '';
            pointer-events: none;
            position: absolute;
            right: 9px;
            top: 50%;
            transform: translateY(-65%);
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-top: 5px solid #555;
        }*/
        #setdefaultkey {
            vertical-align: middle;
            margin-left: 4px;
            font-size: 12px;
            color: #464a4c;
            cursor: pointer;
        }
        .session-project-wrapper {
            display: inline-flex;
            /*align-items: center;*/
            gap: 6px;
            white-space: nowrap;
            padding: 0;
            font-size: 12px;
            color: #464a4c;
            font-weight: 400;
        }
        /*added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue*/
        #mainHeadingProject,
        #mainHeadingProject .session-project-wrapper,
        .navbar-static-top,
        .mainheadingtop {
            overflow: visible !important;
        }
        .navbar-static-top {
            display: flex !important;
            align-items: center !important;
            flex-wrap: nowrap !important;
            padding-top: 0 !important;
            padding-bottom: 0 !important;
        }
        .navbar-static-top > .navbar-custom-menu,
        .navbar-static-top > .filter.float-end {
            margin-left: auto !important;
            flex: 0 0 auto !important;
            width: auto !important;
        }
        /*added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue - header layout as per reference SS*/
        .navbar-heading-block {
            display: flex !important;
            flex-direction: column !important;
            justify-content: flex-start !important;
            flex: 0 0 auto !important;
            padding: 0 0 0 20px !important;
            margin: 0 !important;
            gap: 0 !important;
            overflow: visible !important;
        }
        .navbar-heading-block .mainheadingtop.col {
            position: relative !important;
            top: auto !important;
            float: none !important;
            flex: 0 0 auto !important;
            width: auto !important;
            max-width: none !important;
            padding: 0 !important;
            margin: 0 !important;
            white-space: nowrap;
            line-height: 1.2;
        }
        #mainHeadingProject.mainheadingtop {
            top: auto !important;
            display: inline-flex !important;
            align-items: center;
            padding: 0 !important;
            margin: 0 !important;
        }
        /*End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue - header layout as per reference SS*/
        .session-project-wrapper {
            align-items: center;
        }
        /*added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue - hide beats inline-flex !important on selectpicker wrapper*/
        #mainHeadingProject.session-project-hidden,
        .session-project-wrapper.session-project-hidden,
        .session-project-wrapper .bootstrap-select.session-project-hidden {
            display: none !important;
        }
        .session-project-wrapper .bootstrap-select {
            display: inline-block !important;
            width: 210px !important;
            max-width: 210px !important;
            vertical-align: middle;
            position: relative;
            top: 0;
        }
        .session-project-wrapper .bootstrap-select.show .dropdown-menu,
        .session-project-wrapper .bootstrap-select .dropdown-menu.show {
            display: block !important;
        }
        .session-project-wrapper .bootstrap-select > select#cboSessionProject {
            top: 0 !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-toggle {
            width: 210px !important;
            max-width: 210px !important;
            height: 24px !important;
            padding: 0 28px 0 8px !important;
            font-size: 12px !important;
            line-height: 1.4 !important;
            color: #464a4c !important;
            background-color: #fff !important;
            border: 1px solid #ccc !important;
            border-radius: 4px !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-toggle::after {
            border-top-color: #555 !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-toggle .filter-option-inner-inner {
            color: #464a4c !important;
            font-size: 12px !important;
        }
        .session-project-wrapper .bootstrap-select > .dropdown-menu {
            background: #fff !important;
            border: 1px solid #ccc !important;
            padding: 0 !important;
            max-height: 280px;
            min-width: 210px !important;
            z-index: 1060 !important;
            overflow: visible !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-menu:before,
        .session-project-wrapper .bootstrap-select ul.dropdown-menu.inner:before {
            display: none !important;
            content: none !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-menu > .inner,
        .session-project-wrapper .bootstrap-select .inner[role="listbox"] {
            position: static !important;
            display: block !important;
            overflow-y: auto !important;
            overflow-x: hidden !important;
            max-height: 220px !important;
            min-height: auto !important;
            padding: 0 !important;
            margin: 0 !important;
        }
        .session-project-wrapper .bootstrap-select ul.dropdown-menu.inner {
            position: static !important;
            display: block !important;
            float: none !important;
            width: 100% !important;
            min-width: 100% !important;
            border: 0 !important;
            box-shadow: none !important;
            padding: 0 !important;
            margin: 0 !important;
            background: #fff !important;
            transform: none !important;
            inset: auto !important;
            top: auto !important;
            left: auto !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-menu li {
            display: list-item !important;
            list-style: none !important;
            min-height: 24px !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-menu li a,
        .session-project-wrapper .bootstrap-select .dropdown-menu li a.dropdown-item {
            color: #464a4c !important;
            background-color: #fff !important;
            opacity: 1 !important;
            visibility: visible !important;
            display: block !important;
            width: 100% !important;
            padding: 6px 12px !important;
            font-size: 12px !important;
            line-height: 1.4 !important;
            white-space: normal !important;
            overflow: visible !important;
            text-decoration: none !important;
            cursor: pointer !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-menu li a span.text {
            color: #464a4c !important;
            opacity: 1 !important;
            visibility: visible !important;
            display: inline !important;
            font-size: 12px !important;
            line-height: 1.4 !important;
            text-decoration: none !important;
        }
        .session-project-wrapper .bootstrap-select .dropdown-menu li a:hover,
        .session-project-wrapper .bootstrap-select .dropdown-menu li a.dropdown-item:hover,
        .session-project-wrapper .bootstrap-select .dropdown-menu li a:focus,
        .session-project-wrapper .bootstrap-select .dropdown-menu li a.dropdown-item:focus,
        .session-project-wrapper .bootstrap-select .dropdown-menu li.selected a {
            background-color: #e7edf0 !important;
            color: #464a4c !important;
            text-decoration: none !important;
        }
        #mainHeadingProject .session-project-wrapper .bootstrap-select .dropdown-menu a,
        #mainHeadingProject .session-project-wrapper .bootstrap-select .dropdown-menu a:hover,
        #mainHeadingProject .session-project-wrapper .bootstrap-select .dropdown-menu a:focus {
            color: #464a4c !important;
            text-decoration: none !important;
        }
        .session-project-wrapper .bootstrap-select .bs-searchbox {
            padding: 6px 8px !important;
        }
        .session-project-wrapper .bootstrap-select .bs-searchbox .form-control {
            font-size: 12px !important;
            color: #464a4c !important;
        }
        /*End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue*/
        /* //End of Added By Dipali V On 1st Aug 2023 For Session Project */
       /*<%--End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>*/
        /*Added by pradip on 23-1-2023*/
        #myLogOut{ opacity:1;}
        .custmodal .modal-content .modal-header {
            display: block!important;
            background: #4263c1;
            border: none;
            color: #fff;
            border-radius: 10px 10px 0 0;
            padding: 10px;
            text-align: center;
        }

        .modal-title {
            margin: 0;
            font-weight: 400;
            font-size: 20px;
        }
        #myLogOut .modal-content{overflow: hidden; margin-top: 12em; border-radius: 14px; }
        #myLogOut .btnyellow{background:#fbb03b; color:#fff; border:1px solid #fbb03b;}
        /*End Added by pradip on 23-1-2023*/
        /*Modified By Madhuri.K On 28-01-2026 - Added background-color style for parent-panel container*/
        /* .parent-panel { */
            /* background-color: rgb(227, 236, 247) !important;
        } */
        /* Modified By Madhuri.K On 07-07-2026 Parent panel: show icon + name until child tree is opened */
        .parent-panel .sidebar-menu > li.parent-icon {
            width: 100%;
            list-style: none;
        }
        .parent-panel .sidebar-menu > li.parent-icon > a {
            width: 100%;
            box-sizing: border-box;
        }
        .parent-panel .sidebar-menu > li > a > span.searchText {
            display: inline !important;
            font-size: 12px;
            color: #4263c1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            line-height: 1.2;
            flex: 0 1 auto;
            min-width: 0;
            text-align: left;
        }
        body.parent-panel.child-panel-open #treeMenu > li > a > span.searchText {
            display: none !important;
        }
        /* Modified By Madhuri.K On 07-07-2026  */
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon.selected > a .searchText,
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon.active > a .searchText {
            color: #ffffff !important;
        }
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a {
            text-align: left !important;
            justify-content: flex-start !important;
            align-items: center;
            padding: 8px 10px !important;
            gap: 6px;
        }
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i {
            margin: 0 !important;
            width: 24px;
            min-width: 24px;
            flex-shrink: 0;
            justify-content: flex-start !important;
        }
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i img {
            width: 20px !important;
            height: 20px !important;
            margin: 0 !important;
        }
        body.parent-panel #treeMenu > li.parent-icon > a > span.searchText {
            margin: 0 !important;
            padding: 0 !important;
            vertical-align: middle;
            text-align: left !important;
        }
        body.parent-panel #treeMenu > li.parent-icon.treeview > a {
            padding-left: 10px !important;
            padding-right: 10px !important;
        }
        /* Override global sidebar icon width (51px) so text sits next to icon */
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > .fa,
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i.fa {
            width: 24px !important;
            min-width: 24px !important;
            max-width: 24px !important;
            text-align: left !important;
            display: flex !important;
            padding: 0 !important;
            height: auto !important;
            vertical-align: middle !important;
        }
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > span.searchText {
            display: inline !important;
            margin: 0 !important;
            padding: 0 !important;
            vertical-align: middle !important;
            font-weight: 400;
            letter-spacing: 0.3px;
        }
        body.parent-panel #treeMenu > li.treeview > a .pull-left-container,
        body.parent-panel #treeMenu .treeview-menu {
            display: none !important;
        }
        body.parent-panel:not(.child-panel-open) .freezeLi {
            padding: 8px 10px !important;
            justify-content: flex-start !important;
            min-height: 40px;
        }
        body.parent-panel.child-panel-open .freezeLi {
            padding: 5px 0 !important;
            justify-content: center !important;
            align-items: center !important;
            min-height: 34px;
            width: 100%;
            box-sizing: border-box;
            overflow: visible !important;
        }
        body.parent-panel.child-panel-open .freezeLi a.nv_ref {
            margin: 0 !important;
            flex-shrink: 0;
        }
        /* Expand toggle on border between parent icons and child panel (as per SS) */
        .parent-panel-expand-btn,
        #btnParentExpandChildPanel {
            position: fixed !important;
            top: calc(var(--nav-header-height, 50px) + 6px) !important;
            left: calc(var(--nav-sidebar-narrow, 42px) - 7px) !important;
            width: 12px !important;
            height: 26px !important;
            min-width: 12px !important;
            min-height: 26px !important;
            margin: 0 !important;
            padding: 0 !important;
            border: 2px solid #e3ecf7 !important;
            border-radius: 3px !important;
            background: #e3ecf7 !important;
            color: #5b83f9 !important;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 1005 !important;
            box-shadow: none;
            transition: background 0.2s ease, border-color 0.2s ease, color 0.2s ease;
            line-height: 1;
            visibility: visible !important;
            opacity: 1 !important;
            pointer-events: auto !important;
        }
        body.parent-panel.child-panel-open #btnParentExpandChildPanel,
        body.parent-panel.child-panel-open .parent-panel-expand-btn {
            display: inline-flex !important;
        }
        body.parent-panel:not(.child-panel-open) #btnParentExpandChildPanel,
        body.parent-panel:not(.child-panel-open) .parent-panel-expand-btn {
            display: none !important;
        }
        .parent-panel-expand-btn:hover,
        #btnParentExpandChildPanel:hover {
            background: #4263c1 !important;
            border-color: #4263c1 !important;
            color: #ffffff !important;
            box-shadow: 0 2px 6px rgba(66, 99, 193, 0.35);
        }
        .parent-panel-expand-btn:hover i,
        #btnParentExpandChildPanel:hover i {
            color: #ffffff !important;
        }
        .parent-panel-expand-btn i,
        #btnParentExpandChildPanel i {
            font-size: 8px !important;
            line-height: 1;
            color: #5b83f9 !important;
            display: inline-block !important;
            pointer-events: none;
        }
        /* Collapse toggle on wide parent sidebar right border (as per SS) */
        .parent-panel-collapse-btn,
        #btnParentCollapseSidebar {
            position: fixed !important;
            top: calc(var(--nav-header-height, 50px) + 6px) !important;
            left: calc(var(--nav-sidebar-wide, 170px) - 7px) !important;
            width: 12px !important;
            height: 26px !important;
            min-width: 12px !important;
            min-height: 26px !important;
            margin: 0 !important;
            padding: 0 !important;
            border: 2px solid #e3ecf7 !important;
            border-radius: 3px !important;
            background: #e3ecf7 !important;
            color: #5b83f9 !important;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 1005 !important;
            box-shadow: none;
            transition: background 0.2s ease, border-color 0.2s ease, color 0.2s ease;
            line-height: 1;
            visibility: visible !important;
            opacity: 1 !important;
            pointer-events: auto !important;
        }
        body.parent-panel:not(.child-panel-open) #btnParentCollapseSidebar,
        body.parent-panel:not(.child-panel-open) .parent-panel-collapse-btn {
            display: inline-flex !important;
        }
        body.parent-panel.child-panel-open #btnParentCollapseSidebar,
        body.parent-panel.child-panel-open .parent-panel-collapse-btn {
            display: none !important;
        }
        .parent-panel-collapse-btn:hover,
        #btnParentCollapseSidebar:hover {
            background: #4263c1 !important;
            border-color: #4263c1 !important;
            color: #ffffff !important;
            box-shadow: 0 2px 6px rgba(66, 99, 193, 0.35);
        }
        .parent-panel-collapse-btn:hover i,
        #btnParentCollapseSidebar:hover i {
            color: #ffffff !important;
        }
        .parent-panel-collapse-btn i,
        #btnParentCollapseSidebar i {
            font-size: 8px !important;
            line-height: 1;
            color: #5b83f9 !important;
            display: inline-block !important;
            pointer-events: none;
        }
        body.parent-panel:not(.child-panel-open) a.nv_ref {
            position: relative !important;
            top: auto !important;
            left: auto !important;
            transform: none !important;
            margin: 0 !important;
            width: 24px;
            height: 24px;
            padding: 2px;
            display: flex !important;
            align-items: center;
            justify-content: center;
        }
        body.parent-panel.child-panel-open a.nv_ref {
            position: relative !important;
            top: auto !important;
            left: auto !important;
            transform: none !important;
            margin: 0 !important;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Reduced parent icon size and aligned vertically center*/
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a {
            text-align: left !important;
            padding: 8px 10px !important;
            justify-content: flex-start !important;
            align-items: center;
            display: flex;
            transition: all 0.3s ease;
            pointer-events: auto;
            cursor: pointer;
        }
        .parent-panel .sidebar-menu > li.parent-icon > a {
            text-align: center;
            padding: 8px 5px !important; 
            justify-content: center;
            align-items: center; 
            display: flex; 
            transition: all 0.3s ease;
            pointer-events: auto; 
            cursor: pointer; 
        }
        /* Modified By Madhuri.K On 07-07-2026  */
        body.parent-panel.child-panel-open #treeMenu > li.parent-icon > a {
            text-align: center;
            justify-content: center;
            padding: 4px 2px !important;
        }
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i {
            display: flex;
            align-items: center;
            justify-content: flex-start !important;
            margin: 0 !important;
            color: #4263c1 !important;
            pointer-events: auto;
            position: relative;
        }
        .parent-panel .sidebar-menu > li.parent-icon > a > i {
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin: 0 auto;
            color: #4263c1 !important;
            pointer-events: auto;
            position: relative;
        }
        /* Modified By Madhuri.K On 07-07-2026  */
        body.parent-panel.child-panel-open #treeMenu > li.parent-icon > a > i {
            margin: 0 !important;
        }
        /*Modified By Madhuri.K On 16-01-2026 - Custom CSS tooltip with black color, positioned to avoid overflow issues*/
        .parent-panel .sidebar-menu > li.parent-icon > a > i[data-tooltip]:hover::after,
        .parent-panel .sidebar-menu > li.parent-icon > a > i[title]:hover::after {
            content: attr(data-tooltip);
            position: fixed;
            left: auto;
            right: auto;
            top: auto;
            bottom: auto;
            padding: 6px 10px;
            background-color: #000000 !important;
            color: white !important;
            border-radius: 4px;
            white-space: nowrap;
            z-index: 10000;
            font-size: 12px;
            font-weight: normal;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            pointer-events: none;
            opacity: 0;
            visibility: hidden;
        }
        .parent-panel .sidebar-menu > li.parent-icon > a > i[data-tooltip]:hover::before,
        .parent-panel .sidebar-menu > li.parent-icon > a > i[title]:hover::before {
            content: '';
            position: fixed;
            left: auto;
            right: auto;
            top: auto;
            bottom: auto;
            border: 5px solid transparent;
            border-right-color: #000000;
            z-index: 10001;
            pointer-events: none;
            opacity: 0;
            visibility: hidden;
        }
        /*Ensure parent container allows tooltip to be visible*/
        .parent-panel .sidebar-menu > li.parent-icon > a {
            overflow: visible !important;
        }
        .parent-panel .sidebar-menu > li.parent-icon {
            overflow: visible !important;
        }
        /*Hide native browser tooltip for parent icons*/
        .parent-panel .sidebar-menu > li.parent-icon > a > i[data-tooltip] {
            position: relative;
        }
        /*Modified By Madhuri.K On 16-01-2026 - JavaScript-based tooltip styling*/
        .custom-parent-tooltip {
            position: fixed;
            background-color: #000000 !important;
            color: white !important;
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: normal;
            white-space: nowrap;
            z-index: 10000;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            pointer-events: none;
            display: none;
        }
        .custom-parent-tooltip::before {
            content: '';
            position: absolute;
            left: -5px;
            top: 50%;
            transform: translateY(-50%);
            border: 5px solid transparent;
            border-right-color: #000000;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Reduced parent icon image size from 24px to 20px and aligned vertically center*/
        /* Modified By Madhuri.K On 07-07-2026  */
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i img {
            width: 20px !important;
            height: 20px !important;
            display: block;
            margin: 0 !important;
            filter: brightness(0) saturate(100%) invert(27%) sepia(100%) saturate(7500%) hue-rotate(240deg) brightness(0.9) contrast(1.2);
            pointer-events: none;
        }
        .parent-panel .sidebar-menu > li.parent-icon > a > i img {
            width: 30px !important;
            height: 20px !important;
            display: block;
            margin: 0 auto;
            filter: brightness(0) saturate(100%) invert(27%) sepia(100%) saturate(7500%) hue-rotate(240deg) brightness(0.9) contrast(1.2);
            pointer-events: none; /*Modified By Madhuri.K On 16-01-2026 - Let hover events pass through to parent <i> element for tooltip*/
        }
        /* Hover styles for parent icons - blue background with white icon and text */
        .parent-panel .sidebar-menu > li.parent-icon:not(.selected):not(.active) > a:hover {
            background-color: #4263c1 !important;
            border-radius: 8px !important;
            transition: all 0.3s ease;
        }
        /* Modified By Madhuri.K On 07-07-2026  */
        .parent-panel .sidebar-menu > li.parent-icon:not(.selected):not(.active) > a:hover > i,
        .parent-panel .sidebar-menu > li.parent-icon:not(.selected):not(.active) > a:hover > i.fa {
            color: #ffffff !important;
        }
        .parent-panel .sidebar-menu > li.parent-icon:not(.selected):not(.active) > a:hover > i img {
            filter: brightness(0) saturate(100%) invert(100%) !important;
        }
        .parent-panel .sidebar-menu > li.parent-icon:not(.selected):not(.active) > a:hover .searchText,
        body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon:not(.selected):not(.active) > a:hover .searchText {
            color: #ffffff !important;
        }
        /*Added By Madhuri.K - Highlight parent icons that have search matches with blue background (like selected state)*/
        .parent-panel .sidebar-menu > li.parent-icon.search-match-highlight > a {
            background-color: #4263c1 !important;
            border-radius: 8px !important;
            border: none !important;
            box-shadow: none !important;
            margin: 0 !important;
        }
        .parent-panel .sidebar-menu > li.parent-icon.search-match-highlight > a > i img {
            filter: brightness(0) saturate(100%) invert(100%);
        }
        .parent-panel .sidebar-menu > li.parent-icon.search-match-highlight > a .searchText {
            color: #ffffff !important;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Enhanced selected state for parent module icons*/
        .parent-panel .sidebar-menu > li.parent-icon.selected > a,
        .parent-panel .sidebar-menu > li.parent-icon.active > a {
            background-color: #4263c1 !important;
            border-radius: 8px !important; 
            /* Modified By Madhuri.K On 07-07-2026  */
            box-shadow: none !important; 
            border: none !important; 
            margin: 0 !important; 
            padding: 8px 10px !important; 
            position: relative; 
            display: flex !important; 
            align-items: center !important; 
            justify-content: flex-start !important; 
        }
        body.parent-panel.child-panel-open #treeMenu > li.parent-icon.selected > a,
        body.parent-panel.child-panel-open #treeMenu > li.parent-icon.active > a {
            justify-content: center !important; 
            padding: 4px 2px !important;
            margin: 1px 2px !important;
            min-height: 32px;
            width: calc(100% - 4px);
            box-sizing: border-box;
        }
        
        .parent-panel .sidebar-menu > li.parent-icon.selected > a > i,
        .parent-panel .sidebar-menu > li.parent-icon.active > a > i {
            color: white !important;
            transform: none;
            transition: transform 0.3s ease;
        }
        .parent-panel .sidebar-menu > li.parent-icon.selected > a > i img,
        .parent-panel .sidebar-menu > li.parent-icon.active > a > i img {
            filter: brightness(0) saturate(100%) invert(100%) !important;
            transform: none;
            transition: transform 0.3s ease;
        }
        
        .parent-panel .sidebar-menu > li.parent-icon.selected > a > i.nav-fallback-icon,
        .parent-panel .sidebar-menu > li.parent-icon.active > a > i.nav-fallback-icon {
            color: #ffffff !important;
        }
        /*Added By Madhuri.K On 10-01-2026 - Selected state for child panel items - blue background with white text, only when panel is active*/
        .child-panel.active .child-panel-content li.selected > a,
        .child-panel.active .child-panel-content li.active > a {
             background-color: #EEF2FF !important;
    color: #ffffff !important;
    padding: 4px;
    border-radius: 1px;
    border-bottom: none !important;
    border-left: 3px solid #2563EB;
        }
        /* Hide circle icon on selected/active pages (no green highlight) */
        .child-panel.active .child-panel-content li.selected > a i.page-circle-icon,
        .child-panel.active .child-panel-content li.active > a i.page-circle-icon,
        .child-panel.active .child-panel-accordion-content li.selected > a i.page-circle-icon,
        .child-panel.active .child-panel-accordion-content li.active > a i.page-circle-icon {
            display: none !important;
        }
        .child-panel.active .child-panel-accordion-header.selected,
        .child-panel.active .child-panel-accordion-header.active {
            background-color: #EEF2FF !important;
            color: #ffffff !important;
        }
        .child-panel.active .child-panel-accordion-header.selected span,
        .child-panel.active .child-panel-accordion-header.active span {
            color: #676767 !important
        }
        /*Modified By Madhuri.K On 16-01-2026 - Make images white when sub-nodes are selected*/
        /* .child-panel.active .child-panel-content li.selected > a img,
        .child-panel.active .child-panel-content li.active > a img {
            filter: brightness(0) saturate(100%) invert(100%) !important;
        } */
        /* .child-panel.active .child-panel-accordion-header.selected img,
        .child-panel.active .child-panel-accordion-header.active img {
            filter: brightness(0) saturate(100%) invert(100%) !important;
        } */
        /* Fallback icon (fa-info-circle) in accordion - white when accordion header selected */
        /* .child-panel.active .child-panel-accordion-header.active .nav-fallback-icon,
        .child-panel.active .child-panel-accordion-header.selected .nav-fallback-icon {
            color: #ffffff !important;
        } */
        .child-panel.active .child-panel-accordion-content li.selected > a img,
        .child-panel.active .child-panel-accordion-content li.active > a img {
            filter: brightness(0) saturate(100%) invert(100%) !important;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Force white background on selected items when panel is closing/closed to prevent blue color flash*/
        .child-panel:not(.active) .child-panel-content li.selected > a,
        .child-panel:not(.active) .child-panel-content li.active > a,
        .child-panel:not(.active) .child-panel-accordion-header.selected,
        .child-panel:not(.active) .child-panel-accordion-header.active {
            background-color: #ffffff !important;
            color: #747070 !important;
            transition: none !important; 
        }
        .child-panel:not(.active) .child-panel-accordion-header.selected span,
        .child-panel:not(.active) .child-panel-accordion-header.active span {
            color: #747070 !important;
            transition: none !important; 
        }
        /*Modified By Madhuri.K On 16-01-2026 - Reset image filter when panel is not active (remove white filter)*/
        .child-panel:not(.active) .child-panel-content li.selected > a img,
        .child-panel:not(.active) .child-panel-content li.active > a img,
        .child-panel:not(.active) .child-panel-accordion-header.selected img,
        .child-panel:not(.active) .child-panel-accordion-header.active img,
        .child-panel:not(.active) .child-panel-accordion-content li.selected > a img,
        .child-panel:not(.active) .child-panel-accordion-content li.active > a img {
            filter: none !important;
        }
        /*added by Aditya J. on 12-06-2026 for remove blue horizontal line below header on load and after child panel close*/
        body.parent-panel {
            background-color: #ffffff !important;
            --nav-sidebar-wide: 170px;
            --nav-sidebar-narrow: 42px;
            --nav-child-panel-width: 170px;
            --nav-sidebar-combined: calc(var(--nav-sidebar-narrow) + var(--nav-child-panel-width));
        }
        body.parent-panel.fixed .content-wrapper,
        body.parent-panel.fixed .right-side {
            padding-top: var(--nav-header-height, 50px) !important;
        }
        /*Modified By Madhuri.K On 16-01-2026 - Parent panel: wide with names initially, narrow icons when child tree is open*/
        .parent-panel .main-sidebar {
            width: var(--nav-sidebar-wide, 170px) !important;
            background-color: #F8FAFC !important;
            position: fixed !important;
            top: var(--nav-header-height, 50px) !important;
            left: 0 !important;
            padding-top: 0 !important;
            height: calc(100vh - var(--nav-header-height, 50px)) !important;
            overflow-y: auto !important;
            overflow-x: hidden !important;
            transition: width 0.3s ease;
        }
        body.parent-panel.child-panel-open .main-sidebar {
            width: var(--nav-sidebar-narrow, 42px) !important;
            overflow-y: hidden !important;
            overflow-x: visible !important;
        }
        body.parent-panel.child-panel-open .sidebar,
        body.parent-panel.child-panel-open #treeMenu {
            overflow: visible !important;
        }
        
        /* Ensure sidebar section can contain absolutely positioned toggle controls */
        .parent-panel .sidebar {
            position: relative;
        }
        .parent-panel .content-wrapper {
            margin-left: var(--nav-sidebar-wide, 170px) !important;
            transition: margin-left 0.3s ease; /* Smooth transition when child panel opens/closes */
        }
        /* Modified By Madhuri.K On 07-07-2026  */
        body.parent-panel.child-panel-open .content-wrapper {
            margin-left: var(--nav-sidebar-narrow, 42px) !important;
        }
        /* Wider content offset only when child tree panel is expanded */
        body.parent-panel.child-tree-expanded .content-wrapper,
        body.parent-panel.child-tree-expanded .right-side,
        body.parent-panel.child-tree-expanded .main-footer {
            margin-left: var(--nav-sidebar-combined, 212px) !important;
        }
        /*Added By Madhuri.K On 10-01-2026 - Changed child panel background to light color (#f8f9fa), added small custom scrollbar (6px width) with blue color (#4263c1) for better UX*/
        .child-panel {
            position: fixed;
            left: var(--nav-sidebar-narrow, 42px);
            top: var(--nav-header-height, 50px);
            width: var(--nav-child-panel-width, 170px);
            height: calc(100vh - var(--nav-header-height, 50px)); 
            background: #ffffff;
            border: 1px solid #ddd;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
            z-index: 1000;
            display: none;
            overflow: hidden;
            border-radius: 0;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            flex-direction: column;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Hide child panel immediately when not active to prevent blue color flash*/
        .child-panel:not(.active) {
            display: none !important;
        }
        .child-panel.active {
            display: flex;
        }
        /*Modified By Madhuri.K On 16-01-2026 - Ensure search section is visible when child panel is active*/
        .child-panel.active .child-panel-search {
            display: flex !important;
            visibility: visible !important;
            opacity: 1 !important;
        }
        .child-panel.active .child-panel-search input {
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Custom scrollbar for child panel content with light blue color, shown on hover for better UX*/
        /* Hide scrollbar by default */
        .child-panel-content {
            scrollbar-width: none; 
            -ms-overflow-style: none; 
        }
        .child-panel-content::-webkit-scrollbar {
            width: 0px; 
            background: transparent;
        }
        /* Show scrollbar on hover over child panel or content area */
        .child-panel:hover .child-panel-content,
        .child-panel-content:hover {
            scrollbar-width: thin; 
            scrollbar-color: #a8c4e8 #f1f1f1;
        }
        .child-panel:hover .child-panel-content::-webkit-scrollbar,
        .child-panel-content:hover::-webkit-scrollbar {
            width: 6px; 
        }
        .child-panel:hover .child-panel-content::-webkit-scrollbar-track,
        .child-panel-content:hover::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        .child-panel:hover .child-panel-content::-webkit-scrollbar-thumb,
        .child-panel-content:hover::-webkit-scrollbar-thumb {
            background: #a8c4e8;
            border-radius: 10px;
            transition: background 0.2s ease;
        }
        .child-panel:hover .child-panel-content::-webkit-scrollbar-thumb:hover,
        .child-panel-content:hover::-webkit-scrollbar-thumb:hover {
            background: #8bb0d9;
        }
        /*Modified By Madhuri.K On 16-01-2026 - Search section styling in child panel, positioned within child panel container*/
        .child-panel-search {
            padding: 6px 10px; 
            background: #ffffff;
            border-bottom: 1px solid #e0e0e0;
            flex-shrink: 0; 
            display: flex !important; 
            align-items: center;
            position: relative; 
            width: 100%; 
            box-sizing: border-box; 
            z-index: 1; 
            order: 1; 
            visibility: visible !important; 
            opacity: 1 !important; 
            min-height: 36px; 
            height: auto; 
        }
        .child-panel-search input,
        .child-panel-search input.form-control {
            width: 100% !important;
            padding: 4px 6px 4px 6px !important; 
            border: 1px solid #d0d0d0 !important;
            border-radius: 4px !important;
            font-size: 11px !important; 
            outline: none;
            transition: border-color 0.3s ease;
            height: 24px !important; 
            min-height: 24px !important; 
            display: block !important; 
            visibility: visible !important; 
            opacity: 1 !important; 
            box-sizing: border-box !important; 
            flex: 1; 
            margin-right: 19px;
            line-height: 16px !important; 
        }
        .child-panel-search input:focus {
            border-color: #4263c1;
            box-shadow: 0 0 0 2px rgba(66, 99, 193, 0.1);
        }
        /*Modified By Madhuri.K On 16-01-2026 - Styled child panel header (module name) with light blue background and improved typography, positioned within child panel container*/
        .child-panel-header {
           padding: 8px 12px;
    background: #F8FAFC;
    color: #4263c1;
    font-weight: 600;
    font-size: 12px;
    border-bottom: 1px solid #d0dde8;
    letter-spacing: 0.3px;
    flex-shrink: 0;
    display: block !important;
    position: relative;
    width: 100%;
    box-sizing: border-box;
    order: 2;
        }
        
        /*Added By Madhuri.K On 21-01-2026 - Toggle controls in top right corner of search section*/
        .child-panel-search .child-panel-toggle-controls {
            position: absolute;
            top: 58%;
            right: 4px; 
            transform: translateY(-50%);
            display: flex;
            flex-direction: row;
            gap: 4px;
            z-index: 1000;
            align-items: center;
        }
        
        .child-panel-toggle-controls {
            position: absolute;
            top: 50%;
            right: 12px; /* Increased from 8px to create gap between search input and icon */
            transform: translateY(-50%);
            display: flex;
            flex-direction: row;
            gap: 4px;
            z-index: 1000;
            align-items: center;
        }
        
        /* Always show toggle controls when child panel is active */
        .child-panel.active .child-panel-toggle-controls,
        #childPanel.active .child-panel-toggle-controls {
            display: flex !important;
        }
        
        /* Hide toggle controls when child panel is not active */
        .child-panel:not(.active) .child-panel-toggle-controls,
        #childPanel:not(.active) .child-panel-toggle-controls {
            display: none;
        }

        /* Floating expand button for parent panel (shows when child panel is closed) */
        .parent-panel-expand-btn {
            position: fixed;
            top: calc(var(--nav-header-height, 50px) + 4px);
            left: 47px;
            width: 12px;
            height: 25px;
            border-radius: 2px;
            border: 2px solid #e3ecf7;
            background: #e3ecf7;
            color: #5b83f9;
            display: none;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 1001;
            font-size: 11px;
            /* box-shadow: 0 2px 8px rgba(66, 99, 193, 0.3); */
            transition: all 0.2s ease;
            padding: 0;
        }

        .parent-panel-expand-btn:hover {
            background: #e3ecf7;
            box-shadow: 0 3px 10px rgba(66, 99, 193, 0.4);
            transform: scale(1.05);
        }

        .parent-panel-expand-btn i {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Show expand button only when child panel is not active */
        #childPanel.active ~ .parent-panel-expand-btn {
            display: none !important;
        }
        
        #childPanel:not(.active) ~ .parent-panel-expand-btn {
            display: flex !important;
        }

        .child-panel-toggle-controls .child-panel-btn {
            width: 22px;
            height: 22px;
            border-radius: 3px;
            border: 1px solid #4263c1;
            background: #ffffff;
            color: #4263c1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            padding: 0;
            font-size: 10px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.15);
            transition: all 0.2s ease;
            line-height: 1;
            margin: 0;
            position: relative; 
        }
        
        .child-panel-toggle-controls .child-panel-btn:hover {
            background: #4263c1;
            border-color: #4263c1;
            color: #ffffff;
        }
        
        .child-panel-toggle-controls .child-panel-btn i {
            font-size: 10px;
            color: #4263c1;
            display: inline-block;
            line-height: 1;
        }
        
        .child-panel-toggle-controls .child-panel-btn:hover i {
            color: #ffffff;
        }
        
        /*Added By Madhuri.K On 21-01-2026 - Custom tooltip styling for expand/collapse buttons with black text, positioned on right side*/
        .child-panel-toggle-controls .child-panel-btn[title]:hover::after {
            content: attr(title);
            position: absolute;
            left: 100%;
            top: 50%;
            margin-left: 8px;
            transform: translateY(-50%);
            padding: 4px 8px;
            background-color: #ffffff !important;
            color: #000000 !important;
            border: 1px solid #cccccc;
            border-radius: 3px;
            font-size: 11px !important;
            font-weight: normal !important;
            white-space: nowrap;
            z-index: 10000;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            pointer-events: none;
            opacity: 1 !important;
            visibility: visible !important;
            display: block !important;
        }
        
        .child-panel-toggle-controls .child-panel-btn[title]:hover::before {
            content: '';
            position: absolute;
            left: 100%;
            top: 50%;
            margin-left: 2px;
            transform: translateY(-50%);
            border: 5px solid transparent;
            border-right-color: #cccccc;
            z-index: 10001;
            pointer-events: none;
        }
        /*Modified By Madhuri.K On 16-01-2026 - Set child panel content height to fill remaining space after search and header, with scrollbar, positioned within child panel container*/
        .child-panel-content {
            padding: 3px 0; 
            overflow-y: auto;
            flex: 1;
            min-height: 0; 
            width: 100%; 
            box-sizing: border-box; 
            order: 3; 
        }
        .child-panel-content ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Set consistent font size (12px) for all child panel content items, page names, and accordion headers*/
        .child-panel-content li {
             padding: 4px 7px;
    cursor: pointer;
    font-size: 11px !important;
    line-height: 1.4;
    color: #747070 !important;
        }
        .child-panel-content li:hover {
            background: #ffffff;
        }
        .child-panel-content li a {
            color: #747070 !important;
            text-decoration: none;
            display: block;
            font-size: 11px !important; 
        }
        
        .child-panel.active .child-panel-content li.selected > a,
        .child-panel.active .child-panel-content li.active > a {
           color: #575757 !important;
        }
        /*Added By Madhuri.K On 10-01-2026 - Highlight search text in child panel items*/
        .child-panel-content mark,
        .child-panel-accordion-content mark,
        .child-panel-accordion-header mark {
            background-color: #fff3cd !important; 
            color: #856404 !important; 
            padding: 0 2px;
            font-weight: normal;
            border-radius: 2px;
        }
        /*Added By Madhuri.K On 10-01-2026 - Accordion styles for sub-modules in child panel, allows expand/collapse functionality for items with sub-modules*/
        .child-panel-accordion {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        /*Modified By Madhuri.K On 10-01-2026 - Set consistent font size (12px) for accordion headers - same as page names*/
        .child-panel-accordion-header {
            padding: 0px 4px; 
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #747070 !important;
            transition: background-color 0.3s ease;
            font-size: 12px !important; 
            line-height: 1.4; 
            font-weight: 600; 
        }
        .child-panel-accordion-header span {
            font-size: 10.5px !important; 
        }
        .child-panel-accordion-header:hover {
            background: #f5f5f5;
        }
        .child-panel-accordion-header.active {
            background: #f0f0f0;
        }
        .child-panel-accordion-toggle {
            font-size: 10px; 
            transition: transform 0.3s ease;
            color: #747070;
        }
        .child-panel-accordion-header.active .child-panel-accordion-toggle {
            transform: rotate(90deg);
        }
        .child-panel-accordion-content {
            max-height: 0;
            overflow-y: hidden; 
            overflow-x: hidden;
            transition: max-height 0.3s ease, overflow-y 0.15s ease;
            background: #fafafa;
        }
        /* Show vertical scrollbar when user hovers the content area */
        .child-panel-accordion-content:hover {
            overflow-y: auto;
        }
        .child-panel-accordion-content.active {
             overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: #a8c4e8 #f1f1f1;
    border: 1px solid #f0f0f0;
        }
        .child-panel-accordion-content .child-panel-accordion-content {
            max-height: 220px; 
            background: #ffffff;
            padding-left: 6px;
            font-size: 11px !important;
        }
        .child-panel-accordion-content .child-panel-accordion-content li {
            padding: 3px 10px;
            font-size: 11px !important;
            line-height: 1.2;
        }
        .child-panel-accordion-content::-webkit-scrollbar,
        .child-panel-accordion-content .child-panel-accordion-content::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        .child-panel-accordion-content::-webkit-scrollbar-thumb,
        .child-panel-accordion-content .child-panel-accordion-content::-webkit-scrollbar-thumb {
            background: rgba(0,0,0,0.18);
            border-radius: 3px;
        }
        .child-panel-accordion-content:hover::-webkit-scrollbar-thumb,
        .child-panel-accordion-content .child-panel-accordion-content:hover::-webkit-scrollbar-thumb {
            background: rgba(0,0,0,0.28);
        }
        .child-panel-accordion-content ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .child-panel-accordion-header img,
        .child-panel-accordion-content img {
            display: inline-block !important;
            visibility: visible !important;
            opacity: 1 !important;
        }
        /*Modified By Madhuri.K On 16-01-2026 - Make images white when nested sub-nodes are selected in accordion content*/
        .child-panel.active .child-panel-accordion-content .child-panel-accordion-content li.selected > a img,
        .child-panel.active .child-panel-accordion-content .child-panel-accordion-content li.active > a img {
            filter: brightness(0) saturate(100%) invert(100%) !important;
        }
        .child-panel-accordion-content li {
            padding: 4px 12px 4px 9px; 
            cursor: pointer;
            /* border-bottom: 1px solid #f0f0f0; */
            color: #747070 !important;
            font-size: 12px !important; 
            line-height: 1.4;   
        }
        .child-panel-accordion-content li a i.fa-circle,
        .child-panel-accordion-content li a i.far.fa-circle,
        .child-panel-accordion-content li a i.page-circle-icon,
        .child-panel-content li a i.fa-circle,
        .child-panel-content li a i.far.fa-circle,
        .child-panel-content li a i.page-circle-icon {
            font-size: 8px !important;
            margin-right: 8px;
            vertical-align: middle;
            color: #4263c1 !important;
            display: inline-block;
        }
        .child-panel-accordion-content li:hover {
            background: #f0f0f0;
        }
        .child-panel-accordion-content li a {
            color: #747070 !important;
            text-decoration: none;
            display: block;
            font-size: 11px !important; 
        }
        /*End Added By Madhuri.K On 09-01-2026*/

    </style>
    <%-- <script src="../../responsive/Scripts/jquery.
        .js.min.js" type="text/javascript"></script>    --%>
     <%If m_ProductVersion <> 3 Then%>

    <%--Commented Script by pradip on 27-1-2023--%>

        <%--<link href="../../responsive/Content/MobileCss.css" rel="stylesheet" />
    <link rel="icon" type="image/png" href="../../img/Whizible.png"/>
    <script src="../../responsive/GraphScript/jquery.jqplot.js"></script>
    <script src="../../responsive/GraphScript/jquery.jqplot.min.js"></script>
    <script src="../../responsive/GraphScript/plugins/jqplot.barRenderer.js"></script>
    <script src="../../responsive/GraphScript/plugins/jqplot.pieRenderer.js"></script>
    <script src="../../responsive/GraphScript/plugins/jqplot.donutRenderer.js"></script>
    <script src="../../responsive/GraphScript/WebForms/jqplot.categoryAxisRenderer.js"></script>
    <script src="../../responsive/GraphScript/WebForms/jqplot.categoryAxisRenderer.min.js"></script>
    <script src="../../responsive/GraphScript/jqplot.pointLabels.js"></script>
    <script src="../../responsive/GraphScript/jqplot.pointLabels.min.js"></script>
    <link href="../../responsive/GraphScript/jquery.jqplot.css" rel="stylesheet" />
    <link href="loaderStylesheet.css" rel="stylesheet" />

    <script src="../../responsive/Scripts/Pmlifeline.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/grid.locale-en.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/jquery.jqGrid.src.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/pop.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/modernizr.js" type="text/javascript"></script>
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js" type="text/javascript"></script>
    <script src="../../responsive/Scripts/jquery.mmenu.min.all.js" type="text/javascript"></script>
  
     <script src="../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css"></script>
    <link href="../../Whizible2.0-new/dist/css/editor.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/dist/css/style.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/dist/css/sb-admin.css" rel="stylesheet" />
<link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" />
    <script src="../../Script/ZTree/jquery.ztree.core.js"></script>
    <link href="../../Script/ZTree/zTreeStyle.css" rel="stylesheet" />--%>
    <%--End Commented--%>
   


    <style type="text/css">
        #Sub {
            height: 97vh;
        }

        .plotHDIcon {
            height: 32px;
            width: 32px;
            border: 1px solid white;
            border-radius: 50%;
            padding: 4px;
            text-align: center;
            margin: 0 auto;
        }

        .HelpDeskH {
            font-size: 15px;
            color: white;
            position: relative;
            left: 1px;
            cursor: pointer;
        }

        .HelpDeskD {
            font-size: 15px;
            color: white;
            position: relative;
            top: 6px;
            cursor: pointer;
        }

        .dropdown-menu:before {
            content: "";
            border-bottom: 6px solid white;
            border-left: 6px solid transparent;
            border-right: 6px solid transparent;
            position: absolute;
            right: 19px;
            top: -6px;
        }

        .comment-content .label {
            float: right;
            cursor: pointer;
            position: relative;
            bottom: 0px;
            right: 5px;
            padding: 3px;
        }

        #modalboady td {
            font-size: 12px !important;
        }

        #userImageHeader {
            height: 100px !important;
            width: 100px;
            background-size: cover;
        }
        /*#navbarResponsive {
            position: absolute;
            width: 100%;
            left: 0px;
        }
        #exampleAccordion {
            position:relative;
        }*/
        .jqplot-axis {
            font-size: 0.65em !important;
        }

        #preloader {
            left: 60% !important;
        }

        a.clsNavTab {
            font-family: 'Lucida Sans Unicode';
        }

            a.clsNavTab:hover {
                font-family: 'Lucida Sans Unicode';
            }

        body {
            border: none !important;
            margin-left: 0px !important;
            margin-right: 0px !important;
        }

        .faChart {
            padding-left: 2px !important;
            font-size: 17px !important;
            padding-bottom: 30px;
            color: #fff;
            padding-top: 2px !important;
        }

        @media only screen and (max-width:768px) {
            body:hover {
                overflow: auto !important;
            }
        }

        .clsLabel {
            color: #27408b;
        }

        .jqplot-target {
            color: black;
        }

        .pposition {
            margin-bottom: 30px;
        }

        /*#MainDiv {
            padding-left: 65px;
        }*/

        .navbar-sidenav {
            width: 95px;
        }

        #tblMain {
            width: 100%;
        }

            #tblMain > tbody > tr > td:first-child {
                width: 30%;
                white-space: nowrap;
            }

        #exampleAccordion {
            overflow: hidden;
        }

            #exampleAccordion:hover {
                overflow-y: auto;
            }

        .ulParent {
            top: auto;
            left: 50px;
            right: auto;
            min-height: 100px;
            max-height: 400px;
            overflow: auto;
            border-radius: 5px;
            background-color: #ecf2f5 !important;
            font-family: 'Roboto', Sans-serif;
            font-size: 12px;
        }

            .ulParent li {
                padding-left: 8px;
                padding-right: 8px;
                cursor: pointer;
            }

                .ulParent li:not(.clsParent):hover {
                    background-color: #aec2ce !Important;
                }

            .ulParent ul {
                padding-left: 8px;
                padding-right: 8px;
            }

        /*Modified By Madhuri.K On 10-01-2026 - Changed tree background to light color (#f8f9fa) for better visual consistency*/
        .tree {
            background-color: #f8f9fa !important;
        }

        label.tree-toggler {
            cursor: pointer;
            background-color: #f8f9fa !important;
        }

        .lblHeading {
            color: #464a4c;
            /*background-color: white;*/
            /*border-bottom: 2px solid #464a4c;*/
            color: #464a4c;
            border-radius: 0px;
            padding-top: 1px;
            padding-bottom: 1px;
            padding-left: 5px;
            padding-right: 5px;
            margin-bottom: 0px;
            margin-top: 10px;
            font-weight: 300;
            font-family: "Roboto",sans-serif !important;
            font-size: 20px;
        }

        .navbar-brand img {
            padding-top: 0px;
        }

        #mainNav .navbar-brand {
            width: 95px;
        }

        .navbar-brand img {
            max-width: 100%;
        }

        .navbar-nav > .user-menu > .dropdown-menu > li.user-header {
            height: 182px;
            padding: 10px;
            text-align: center;
            /*background-color: #003D61 !important;*/
        }

        .navbar-nav > .user-menu > .dropdown-menu {
            border-top-right-radius: 0;
            border-top-left-radius: 0;
            padding: 1px 0 0 0;
            border-top-width: 0;
            width: 280px;
            position: absolute;
            right: 0;
            left: auto;
        }

        .float-end {
            float: none !important;
            text-align: center;
        }
        
        .pull-right {
            float: none !important;
            text-align: center;
        }

        .navbar-nav > .user-menu > .dropdown-menu > .user-footer {
            border: 1px solid #adaaaa;
        }

        .navbar-nav > .user-menu > .dropdown-menu > .user-footer {
            background-color: #f9f9f9;
            padding: 10px;
        }

        #profileDropdwn {
            overflow: visible !important;
        }

        .btn-default {
            padding: 7px 11px !important;
        }

        .btn.btn-flat {
            border-radius: 0;
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
            box-shadow: none;
            border-width: 1px;
        }

        #employeeRole {
            color: white;
            cursor: pointer;
            margin: 0 0 4px;
        }

        .modal-dialog {
            width: 650px !important;
            padding-top: 30px !important;
            padding-bottom: 30px !important;
        }


        .modal-content {
            background-color: #fefefe;
            margin: 0px;
            border: 1px solid #888;
            width: 100%;
            height: 100%;
        }
    </style>

    <style>
        * {
            margin: 0;
            padding: 0;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        a {
            color: #03658c;
            text-decoration: none;
        }

        ul {
            list-style-type: none;
        }

        body {
            font-family: 'Roboto', Sans-serif;
            background: #dee1e3;
        }

        /** ====================
 * Lista de Comentarios
 =======================*/
        @media (min-width: 767px) {
            #mainNav .navbar-collapse .navbar-nav > .nav-item.dropdown > .nav-link {
                min-width: none !important;
            }
        }

        .dropdown-toggle::after {
            display: inline-block;
            width: 0;
            height: 0;
            margin-left: 0.255em;
            vertical-align: 0.255em;
            content: "";
            border-top: 0.3em solid white;
            border-right: 0.3em solid transparent;
            border-left: 0.3em solid transparent;
        }

        .comments-container {
            width: 493px;
            padding: 5px;
            overflow: hidden;
        }

            .comments-container h1 {
                font-size: 36px;
                color: #283035;
                font-weight: 400;
            }

        .nav-item .fa-bell {
            background: red;
            margin-right: 0px;
        }

        #myHeaderIcon {
            background: transparent;
        }

        .comments-container h1 a {
            font-size: 18px;
            font-weight: 700;
        }

        .comments-list {
            margin-top: 0px;
            position: relative;
            overflow: auto;
            height: 335px;
            width: 105%;
            padding-right: 3%;
        }

            .comments-list li {
                min-height: 107px;
            }
        /**
 * Lineas / Detalles
 -----------------------*/
        /*.comments-list:before {
                content: '';
                width: 2px;
                height: 100%;
                background: #c7cacb;
                position: absolute;
                left: 32px;
                top: 0;
            }*/


        .reply-list:before, .reply-list:after {
            display: none;
        }

        .reply-list li:before {
            content: '';
            width: 60px;
            height: 2px;
            background: #c7cacb;
            position: absolute;
            top: 25px;
            left: -55px;
        }


        .comments-list li {
            margin-bottom: 0px;
            display: inline-block;
            position: relative;
        }


        .reply-list {
            padding-left: 88px;
            clear: both;
            margin-top: 15px;
        }

        ul.navbar-nav.ml-auto li img {
            border-radius: 50%;
            height: 25px;
            width: 25px;
        }

        .imgEmployee {
            height: 25px !important;
            width: 25px !important;
        }
        /**
 * Avatar
 ---------------------------*/


        .comments-list .comment-avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }

        .reply-list .comment-avatar {
            width: 50px;
            height: 50px;
        }

        /**
 * Caja del Comentario
 ---------------------------*/
        .comments-list .comment-box {
            width: 390px;
            float: right;
            position: relative;
            -webkit-box-shadow: 0 1px 1px rgba(0,0,0,0.15);
            -moz-box-shadow: 0 1px 1px rgba(0,0,0,0.15);
            box-shadow: 0 1px 1px rgba(0,0,0,0.15);
            margin-bottom: 10px;
            margin-left: 10px;
        }



            .comments-list .comment-box:before {
                border-width: 11px 13px 11px 0;
                border-color: transparent rgba(0,0,0,0.05);
                left: -12px;
            }

        .reply-list .comment-box {
            width: 610px;
        }

        .comment-box .comment-head i {
            float: right;
            margin-left: 14px;
            position: relative;
            top: 2px;
            color: #A6A6A6;
            cursor: pointer;
            -webkit-transition: color 0.3s ease;
            -o-transition: color 0.3s ease;
            transition: color 0.3s ease;
        }

            .comment-box .comment-head i:hover {
                color: #03658c;
            }

        .comment-box .comment-name {
            color: #283035;
            font-size: 14px;
            font-weight: 700;
            float: left;
            margin-right: 10px;
        }

            .comment-box .comment-name a {
                color: #283035;
            }

        .comment-box .comment-head span {
            float: right;
            color: #999;
            font-size: 11px;
            position: relative;
            top: 1px;
        }

        .list-group {
            height: 335px;
            overflow: auto;
            width: 107%;
            padding-right: 5%;
        }

        /*.comment-box .comment-name.by-author, .comment-box .comment-name.by-author a {color: #03658c;}
.comment-box .comment-name.by-author:after {
	content: 'autor';
	background: #03658c;
	color: #FFF;
	font-size: 12px;
	padding: 3px 5px;
	font-weight: 700;
	margin-left: 10px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
}*/

        /** =====================
 * Responsive
 ========================*/


        .footbar {
            margin-left: 0%;
            background: #e39321 !important;
        }

        #mainNav {
            display: block;
        }

        .comments-list .comment-avatar {
            text-align: center;
        }

        .lblRequestID {
            margin-top: 2px;
        }

        #mainNav .navbar-collapse .navbar-nav > .nav-item.dropdown > .nav-link .new-indicator .number {
            left: -12px !important;
        }

        #imgLogo {
            margin-left: 12px;
            margin-top: 5px;
            height: 40px;
        }
    </style>
    <script>

        //Added by Dipali V For Remove Tool Tip
        //Modified By Madhuri.K On 16-01-2026 - Exclude parent icons from auto-dispose to allow tooltips to show on hover
        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"]:not(.parent-panel .sidebar-menu > li.parent-icon > a > i.fa):not(.session-project-wrapper .bootstrap-select button), [title]:not([data-bs-toggle="popover"]):not(.parent-panel .sidebar-menu > li.parent-icon > a > i.fa):not(.session-project-wrapper .bootstrap-select button):not(.session-project-wrapper .bootstrap-select .dropdown-toggle)',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"]:not(.parent-panel .sidebar-menu > li.parent-icon > a > i.fa):not(.session-project-wrapper .bootstrap-select button), [title]:not([data-bs-toggle="popover"]):not(.parent-panel .sidebar-menu > li.parent-icon > a > i.fa):not(.session-project-wrapper .bootstrap-select button):not(.session-project-wrapper .bootstrap-select .dropdown-toggle)', function () {
            $('[data-bs-toggle="tooltip"]:not(.parent-panel .sidebar-menu > li.parent-icon > a > i.fa):not(.session-project-wrapper .bootstrap-select button), [title]:not([data-bs-toggle="popover"]):not(.parent-panel .sidebar-menu > li.parent-icon > a > i.fa):not(.session-project-wrapper .bootstrap-select button):not(.session-project-wrapper .bootstrap-select .dropdown-toggle)').tooltip('dispose');
        });
        //End of Added by Dipali V For Remove Tool Tip

        $(document).ready(function () {
            //debugger;
            if (document.getElementById("exampleAccordion") != null) {
                document.getElementById("exampleAccordion").style.height = window.innerHeight - 60 + 'px';
                document.getElementById("frmNewVersion").style.height = window.innerHeight - 60 + 'px';
                document.getElementById("frmNewVersion").style.width = window.innerWidth - 65 + 'px';
            }
            $("#Support").tooltip();
            $(".ulParent").css("height", window.innerHeight - 60 + 'px');
            //$('label.tree-toggler').click(function () {
            //    if ($(this).parent().children('ul.tree').css("display") == "none") {
            //        $(this).parent().children('ul.tree').css("display", "block");
            //        $(this).find("i").removeClass("fa-caret-right");
            //        $(this).find("i").addClass("fa-caret-down");
            //    }
            //    else {
            //        $(this).parent().children('ul.tree').css("display", "none");
            //        $(this).find("i").addClass("fa-caret-right");
            //        $(this).find("i").removeClass("fa-caret-down");
            //    }
            //});
            //$('.nav-item').hover(function (e) {
            //    $(".ulParent", this).css("display", "block");
            //    $(".ulParent", this).css("padding", "0px");
            //    var evt = e || event;
            //    var chkTop;
            //    if ($(window).height() < 768) {
            //        chkTop = 240;
            //        $(".ulParent", this).css("height", "250px")
            //    }
            //    else {
            //        chkTop = 400;
            //        $(".ulParent", this).css("height", "400px")
            //    }
            //    if (evt.currentTarget.offsetTop < chkTop) {
            //        $(".ulParent", this).css("top", evt.currentTarget.offsetTop + 50 + 'px');
            //    }
            //    else {

            //        $(".ulParent", this).css("top", evt.currentTarget.offsetTop - (chkTop - 70) + 'px');
            //        $(".ulParent", this).css("bottom", evt.currentTarget.offsetTop + 'px');
            //    }
            //}, function () {
            //    $(".ulParent", this).css("display", "");
            //})

            $(".Module").click(function () {
                $("#lblModuleName").html($(this).attr("title"));
                //if (String($("#lblModuleName").html()).toLowerCase().trim() == "support") {
                //    $("#imgLogo").attr("src", "../../img/whiz_help_white.png");
                //    $("#imgLogo").css("height", "30px");
                //    $("#imgLogo").css("margin-top", "5px");
                //}
                //else {
                //    $("#imgLogo").attr("src", "../../img/logo.png");
                //    $("#imgLogo").css("height", "");
                //    $("#imgLogo").css("margin-top", "");
                //}
            })
            $(".Module").each(function (id, val) {
                if ($(this).attr("title").toLowerCase() == "support")
                    $(this).click();
                else {
                    if (id == 0) {
                        $(this).click();
                    }
                }
            })
            getLoginEmployeePhoto()

            if ($(window).width() < 768) {
                document.body.style.setProperty("background-color", "white", "important");
            }
            else {
                document.body.style.setProperty("background-color", "");
            }
        })

        function s(x) { return x.charCodeAt(0); }

        $(function () {
            if ($(window).width() < 720) {
                jQuery('nav#menu').mmenu();
                $("#mm-blocker").css("position", "absolute");
                //jQuery("#mm-0").before("<div style='width:100%;height:100%;background:#FDF4E8;background-image:url(img/1920/OpenVCE-Poster-Gold-Background.jpg);></div>");
                jQuery("#mm-0").before("<div style='width:100%;height:100%;background-image: url(../../img/1920/OpenVCE-Poster-Gold-Background.jpg);'> <table style='margin-left:10%'><tr><td> <img id='imgEmployee' src='../../img/1920/no-photo.png' alt='No Image' style='margin-top:20px;width:75px;height: 75px;margin-right: 9%;' align='right' /></td><td><label id='cpName' style=color='white';font-weight:100' class='cpHome'></label><br><label id='cpRole' style='font-weight:100' class='cpHome'></label> </td></tr></table> </div>")
                $("#menu").css("position", "absolute");
            }
        });


    </script>
    <%Else %>
   
    <script src="../../responsive/Scripts/modernizr.js" type="text/javascript"></script>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Theme style -->
       <%-- <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">

    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/whiz.min.css?v=2"> 
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/font.css?v=2">
    <!-- animate css -->
   <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
<%-- <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_navigation.css?v=2">--%>
    <link href="../../Whizible2.0-new/dist/css/style_custom_navigation.css" rel="stylesheet" />
    <%--/*Added By Dipali V On 17th May 2023 For Version Upgrade Responsive Issue*/--%>
      <link href="../../Whizible2.0-new/dist/css/style_custom.css" rel="stylesheet" />
   <%-- /*End of Added By Dipali V On 17th May 2023 For Version Upgrade Responsive Issue*/--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/media_queries.css?v=1.3">
    <%--Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>
    <%-- bootstrap-select 1.13.18 is not compatible with Bootstrap 5.x which is active in W27.
         The session project dropdown is styled using native select CSS instead. --%>
    <%--End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>    
    <%--<link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
    <%--added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css" />
    <%--End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue--%>
   <style>
       /** ====================
 * Lista de Comentarios
 =======================*/
       @media (min-width: 767px) {
           #mainNav .navbar-collapse .navbar-nav > .nav-item.dropdown > .nav-link {
               min-width: none !important
           }
       }

       .mainheadingtop {
           float: left;
           padding: 10px 10px 9px 20px;
           font-size: 14px;
           /* Added By Gauri On 20th Aug 2024 For Font Issue */
           font-weight: 400;
           /* End of Added By Gauri On 20th Aug 2024 For Font Issue */
           color: #464a4c;
           position: absolute;
           top: -8px;
       }
       /*Added By Madhuri.K On 21-01-2026 - Style breadcrumb hyperlinks to be visible and clickable*/
       .mainheadingtop a {
           color: #4263c1 !important;
           text-decoration: underline !important;
           cursor: pointer !important;
       }
       .mainheadingtop a:hover {
           color: #2d4a9e !important;
           text-decoration: underline !important;
       }

       .dropdown-toggle::after {
           display: inline-block;
           width: 0;
           height: 0;
           margin-left: .255em;
           vertical-align: .255em;
           content: "";
           border-top: .3em solid #fff;
           border-right: .3em solid transparent;
           border-left: .3em solid transparent
       }

       .comments-container {
           width: 94%;
           overflow: hidden
       }

           .comments-container h1 {
               font-size: 36px;
               color: #283035;
               font-weight: 400
           }

       .nav-item .fa-bell {
           background: red;
           margin-right: 0
       }

       #myHeaderIcon {
           background: transparent
       }

       .comments-container h1 a {
           font-size: 18px;
           font-weight: 700
       }

       .comments-list {
           margin-top: 0;
           position: relative;
           overflow: auto;
           height: auto;
           width: 100%;
           padding-right: 0;
           margin: 0;
           padding: 0;
           height: 260px;
       }

       #myModal2 .modal-content .modal-body {
           width: 100% !important;
           height: auto !important;
           padding-right: 0 !important;
       }

       .comments-list li {
           background: #e7edf0;
           display: block;
           border: 1px solid #ddd;
           border-radius: 4px;
           padding: 10px;
           overflow: hidden;
       }

       body .comments-list .comment-box {
           width: 100%;
           margin-top: 10px !important;
           padding: 0 !important;
           margin: 0;
       }

       .comment-head {
           display: block;
           width: 100%;
           float: left;
       }

       body {
           font-family: arial !important;
       }
       /**
 * Lineas / Detalles
 -----------------------*/



       .reply-list:before, .reply-list:after {
           display: none
       }

       .reply-list li:before {
           content: '';
           width: 60px;
           height: 2px;
           background: #c7cacb;
           position: absolute;
           top: 25px;
           left: -55px
       }

       .comments-list li {
           margin-bottom: 10px;
           position: relative
       }

       .reply-list {
           padding-left: 88px;
           clear: both;
           margin-top: 15px
       }

       ul.navbar-nav.ml-auto li img {
           border-radius: 50%;
           height: 25px;
           width: 25px
       }

       .imgEmployee {
           height: 25px !important;
           width: 25px !important
       }

       /**
 * Avatar
 ---------------------------*/


       .comments-list .comment-avatar img {
           width: 100%;
           height: 100%;
           border-radius: 50%;
           margin-right: 10px;
       }

       .reply-list .comment-avatar {
           width: 50px;
           height: 50px;
       }

       /**
 * Caja del Comentario
 ---------------------------*/
       .comments-list .comment-box:before {
           border-width: 11px 13px 11px 0;
           border-color: transparent rgba(0,0,0,0.05);
           left: -12px
       }

       .comment-box .comment-head i {
           float: right;
           margin-left: 14px;
           position: relative;
           top: 2px;
           color: #A6A6A6;
           cursor: pointer;
           -webkit-transition: color .3s ease;
           -o-transition: color .3s ease;
           transition: color .3s ease
       }

           .comment-box .comment-head i:hover {
               color: #03658c
           }

       .comment-box .comment-name {
           color: #283035;
           font-size: 14px;
           font-weight: 700;
           float: left;
           margin-right: 10px
       }

           .comment-box .comment-name a {
               color: #283035
           }

       .comment-box .comment-head span {
           float: right;
           color: #999;
           font-size: 11px;
           position: relative;
           top: 1px
       }

       .list-group {
           height: 335px;
           overflow: auto;
           width: 107%;
           padding-right: 5%
       }




       /*pradip_css_1-11-2018*/
       html > body {
           overflow-y: hidden;
       }
       /*Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
       /*.main-header .navbar .nav > li > a i {
           width: 25px;
           height: 25px;
           background: #ccc;
           line-height: 25px;
           border-radius: 100%;
           font-size: 12px !important;
           margin: 0 auto;
           color: #fff;
       }*/
       .main-header .navbar .nav > li > a i {
           width: 35px;
           height: 35px;
           background: #ccc;
           line-height: 35px;
           border-radius: 100%;
           font-size: 14px !important;
           margin: 0 auto;
           color: #fff;
       }
           /*Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes*/

           .main-header .navbar .nav > li > a i.fa-bell {
               background: red;
           }

           .main-header .navbar .nav > li > a i.fa-flag {
               background: #00d200;
           }

           .main-header .navbar .nav > li > a i.fa-comments {
               background: #33ccff;
           }

           .main-header .navbar .nav > li > a i.fa-sign-out {
               /*background: #f50057;*/
               text-align: center;
           }

       .main-header .navbar .nav > li > a > span.new-indicator {
           position: absolute;
           top: -3px;
           right: 12px;
           font-size: 12px;
       }

       .comment-content label.label.label-danger {
           padding: 8px;
           font-weight: normal;
           letter-spacing: 0.5px;
       }

       #myModal2 .btnyellow {
           border-color: #fbb03b;
       }

       .main-header .navbar .nav > li > a.dropdown-toggle::after {
           display: none;
       }

       iframe#frmNewVersion {
           width: 100% !important;
       }

       @media only screen and (max-width: 767px) {
           .Mv_mobmenu .navbar-custom-menu > .navbar-nav > li .fa {
               border-radius: 50%;
               width: 25px;
               font-size: 11px;
               height: 25px;
               line-height: 25px;
               margin-top: 5px;
               float: left;
           }

           .Mv_mobmenu .navbar-custom-menu > .navbar-nav > li span {
               color: #fff;
               /*added stryle by Pradip on 7-1-2021*/
               float: left;
               margin-left: 0px;
               margin-top: 0px;
           }

           .Mv_mobmenu .sidebar-menu li a {
               cursor: pointer;
           }
       }


       /*pradip_Css_1-1-2018_end_here*/
       /* Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
       .main-header .navbar .nav > li > a {
           cursor: pointer;
           padding: 6px 8px; display:block;
           transition: 0.4s ease-in-out 0s;
       }

           .main-header .navbar .nav > li > a:hover, .main-header .navbar .nav > li > a:focus {
               background: transparent !important;
           }

           .main-header .navbar .nav > li > a i {
               color: #464a4c;
           }

           .main-header .navbar .nav > li > a:hover i {
               color: #464a4c;
               background: rgba(60,64,67,0.08) !important;
           }

           .main-header .navbar .nav > li > a i.fa-flag {
               background: transparent;
           }

           .main-header .navbar .nav > li > a i.fa-bell {
               background: transparent;
           }

           .main-header .navbar .nav > li > a i.fa-comments {
               background: transparent;
           }

       /*.main-header .navbar .nav > li > a:hover i.fa-flag { background:rgb(235,28,36);}
           .main-header .navbar .nav > li > a:hover i.fa-bell { background:#00d200;}
           .main-header .navbar .nav > li > a:hover i.fa-comments{ background:#33ccff;}*/
       /*.sidebar-menu .dropdown-submenu li a:hover {
           background: #e7edf0;
           color: #464a4c;
       }

       .skin-blue-light .sidebar-menu > li.dropdown-submenu > a.active {
           background: #2e52a3;
       }

       .sidebar-menu .dropdown-submenu .dropdown-menu li a.active, .sidebar-menu .dropdown-submenu .dropdown-menu li a:focus {
           background: #e7edf0;
           color: #464a4c;
       }

       .sidebar-menu .dropdown-submenu > a:after {
           display: none;
       }*/
       /*added by pradip on 10-04-2020*/
       span.number {
           background: #fbb03b;
           width: 14px;
           height: 14px;
           display: block;
           text-align: center;
           line-height: 15px;
           border-radius: 50%;
           margin-top: 10px;
           color: #fff;
           font-size: 11px;
           font-weight: bold; /* padding: 2px 3px; */
       }
       /* Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
       /*dropdown menu top - added by pradip on 10-06-2020*/
       /*.sidebar-menu .dropup .dropdown-menu, .sidebar-menu .navbar-fixed-bottom .dropdown .dropdown-menu {
           top: auto;
           bottom: 0;
           margin-bottom: 0px;
       }*/

       .slimScrollDiv {
           height: auto !important;
           max-height: inherit;
       }

       .submenu_slim_scroll {
           height: auto !important;
           max-height: 250px !important;
       }
       /*Added For New Tree*/
       /*Modified By Madhuri.K On 10-01-2026 - Changed main sidebar background to light color (#f8f9fa) for better visual consistency*/
       .main-sidebar, .left-side {
           width: 230px;
           background-color: #f8f9fa !important;
       }

       .content-wrapper, .right-side, .main-footer {
           margin-left: 230px
       }

       a.sidebar-toggle {
           position: absolute;
           right: -13px;
           background: #ccc;
           padding-left: 3px;
           padding-right: 3px;
           height: 18px;
       }

       .sidebar-menu > li > a > .fa, .sidebar-menu > li > a > .glyphicon, .sidebar-menu > li > a > .ion {
           text-align: left;
           width: 51px;
           display: inline-block;
           padding: 0;
           height: 23px;
           vertical-align: middle
       }

       .sidebar-menu li > a span {
           font-weight: 600; font-family: 'Roboto', sans-serif;
           margin: 4px 0 0 10px;letter-spacing: 0.3px;
           display: inline-block;
           vertical-align: top
       }

       .makesmaller span {
           font-weight: 300 !important;
       }

       .sidebar-menu .treeview-menu > li > a {
           padding: 5px 10px 5px 5px !important;
           display: inline-block;
           font-size: 14px;
       }

       .sidebar-menu > li > a > .fa img {
           vertical-align: top
       }

       .sidebar-menu .treeview-menu > li.treeview > a {
           /*background: #006bb3;*/
           border-radius: 24px;
           margin: 0 10px 0 0;
           padding-left: 8px
       }

       .sidebar-menu li > a {
           text-align: center;
           padding: 10px 8px 5px 8px;
           font-weight: 300
       }

       /* Modified By Madhuri.K On 07-07-2026 Parent panel wide mode: icon + label left-aligned, text next to icon */
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a {
           display: flex !important;
           flex-direction: row !important;
           align-items: center !important;
           justify-content: flex-start !important;
           text-align: left !important;
           padding: 8px 10px !important;
           gap: 6px !important;
       }
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > .fa,
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i.fa {
           width: 22px !important;
           min-width: 22px !important;
           max-width: 22px !important;
           flex: 0 0 22px !important;
           margin: 0 !important;
           padding: 0 !important;
           display: flex !important;
           align-items: center !important;
           justify-content: center !important;
           text-align: center !important;
           height: auto !important;
       }
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > i img {
           width: 20px !important;
           height: 20px !important;
           margin: 0 !important;
           display: block !important;
       }
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon > a > span.searchText {
           margin: 0 !important;
           padding: 0 !important;
           flex: 0 1 auto !important;
           text-align: left !important;
           display: block !important;
           font-weight: 400;
           font-family: 'Roboto', sans-serif;
           letter-spacing: 0.3px;
           vertical-align: middle !important;
       }
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon.selected > a .searchText,
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon.active > a .searchText {
           color: #ffffff !important;
       }
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon.selected > a,
       body.parent-panel:not(.child-panel-open) #treeMenu > li.parent-icon.active > a {
           justify-content: flex-start !important;
       }

       a.sidebar-toggle i.fas.fa-angle-right {
           transform: rotate(185deg)
       }

       .sidebar-collapse a.sidebar-toggle i.fas.fa-angle-right {
           transform: rotate(360deg)
       }


       .sidebar-collapse li.freezeLi > a:first-child {
           display: none;
       }
       /*Modified By Madhuri.K On 10-01-2026 - Fixed refresh icon positioning and tooltip in collapsed state*/
       .sidebar-collapse a.nv_ref {
           top: 8px;
           left: 50%;
           transform: translateX(-50%);
           width: 32px;
           height: 32px;
           background-color: transparent !important;
           background: none !important;
           display: flex;
           align-items: center;
           justify-content: center;
       }
       .sidebar-collapse a.nv_ref:hover {
           background-color: #4263c1 !important;
           background: #4263c1 !important;
       }
       .sidebar-collapse li.freezeLi {
           height: 48px;
           display: flex;
           align-items: center;
           justify-content: center;
           position: relative;
       }
       .sidebar-collapse .nv_ref i.fa.fa-refresh,
       .sidebar-collapse .nv_ref i.fas.fa-sync-alt {
           text-align: center;
           margin: 0;
       }

       .sidebar-menu .treeview-menu {
           padding-left: 35px !important;
       }

       .sidebar-menu .treeview-menu > li > a span {
           vertical-align: middle
       }

       /*Modified By Madhuri.K On 27-01-2026 - Show regular circle icon for unselected pages and solid circle for selected pages*/
       .sidebar-menu .treeview-menu > li > a .fa-regular.fa-circle {
           margin-right: 8px;
           color: #4263c1;
           font-size: 12px;
           display: inline-block !important;
       }
       
       .sidebar-menu .treeview-menu > li > a .fa-solid.fa-circle {
           margin-right: 8px;
           color: #4263c1;
           font-size: 12px;
           display: none !important;
       }
       
       .sidebar-menu .treeview-menu > li > a.active .fa-regular.fa-circle {
           display: none !important;
       }
       
       .sidebar-menu .treeview-menu > li > a.active .fa-solid.fa-circle {
           display: inline-block !important;
       }

       .treeview-menu > li:hover > a {
           background: #2E52A3;
           display: inline-block;
           /*color:#4263c1!important;*/
           cursor: pointer;
       }

       .sidebar-menu .treeview-menu > li > a > .fa, .sidebar-menu .treeview-menu > li > a > .glyphicon, .sidebar-menu .treeview-menu > li > a > .ion {
           width: 0px !important;
       }

       .highlight {
           /*Modified By Madhuri.K On 21-01-2026 - Align highlight color with selected pill (#4263c1)*/
           background: #4263c1 !important;
           color: white !important;
           border-radius: 10px;
       }
       /*Override highlight inside child panel so selected pages keep pill style (#4263c1)*/
       .child-panel .child-panel-content li.highlight {
           background: transparent !important;
       }
       .child-panel .child-panel-content li.highlight > a {
           background-color: #4263c1 !important;
           color: #ffffff !important;
           border-radius: 1px !important;
           border-bottom: none !important;
       }

       /*Modified By Madhuri.K On 10-01-2026 - Fixed freezeLi positioning to prevent refresh icon from overriding*/
       .freezeLi {
           position: relative;
           /* background-color: #4263c1 !important; */
           z-index: 99999;
           min-height: 48px;
           display: flex;
           align-items: center;
           justify-content: center;
           padding: 8px 0;
       }

       /*Modified By Madhuri.K On 10-01-2026 - Changed sidebar menu and tree menu background to light color (#f8f9fa), added small custom scrollbar (6px width) with blue color (#4263c1) for better UX*/
       .sidebar-menu {
           padding-top: 0px;
           background-color: #f8f9fa !important;
       }
       /*Modified By Madhuri.K On 10-01-2026 - Changed parent panel background to white, ensure treeMenu background stays consistent*/
       #treeMenu {
           background-color: #ffffff !important; /* Changed to white for parent panel */
       }
       /*Modified By Madhuri.K On 10-01-2026 - Set parent panel sidebar background to light color*/
       .parent-panel .main-sidebar,
       .parent-panel .left-side,
       .parent-panel #treeMenu,
       .parent-panel .sidebar-menu,
       .parent-panel .tree {
           background-color: #F8FAFC !important;
       }
       /*Modified By Madhuri.K On 10-01-2026 - Custom scrollbar for sidebar menu with light blue color for better visibility*/
       .sidebar-menu::-webkit-scrollbar,
       #treeMenu::-webkit-scrollbar {
           width: 6px;
       }
       .sidebar-menu::-webkit-scrollbar-track,
       #treeMenu::-webkit-scrollbar-track {
           background: #f1f1f1;
           border-radius: 10px;
       }
       .sidebar-menu::-webkit-scrollbar-thumb,
       #treeMenu::-webkit-scrollbar-thumb {
           background: #a8c4e8;
           border-radius: 10px;
       }
       .sidebar-menu::-webkit-scrollbar-thumb:hover,
       #treeMenu::-webkit-scrollbar-thumb:hover {
           background: #8bb0d9;
       }
       /* Firefox scrollbar */
       .sidebar-menu,
       #treeMenu {
           scrollbar-width: thin;
           scrollbar-color: #a8c4e8 #f1f1f1;
       }
       .sidebar-menu{
        box-shadow: rgba(0, 0, 0, 0.06) 0px 5px 5px -3px, rgba(0, 0, 0, 0.043) 0px 8px 10px 1px, rgba(0, 0, 0, 0.035) 0px 3px 14px 2px;
       }
       /*.sidebar-menu .treeview-menu > li > a::selection {
       background: white!important;
           color: #2E52A3!important;
       }*/

       /*Added For New Tree*/


       /*Added css by pradip on 19-1-2021*/
       /*Modified By Madhuri.K On 10-01-2026 - Changed refresh icon color to blue (#4263c1), added hover effect with blue background and white icon, fixed to show single background color, fixed positioning and tooltip*/
       a.nv_ref {
           position: absolute !important;
           top: 10px;
           left: 50%;
           transform: translateX(-50%);
           color: #4263c1 !important;
           padding: 6px;
           border-radius: 4px;
           transition: all 0.3s ease;
           background-color: transparent !important;
           background: none !important;
           z-index: 10000;
           display: flex;
           align-items: center;
           justify-content: center;
           width: 32px;
           height: 32px;
       }
       /* Hover styles for refresh icon - blue background with white icon */
       a.nv_ref:hover {
           background-color: #4263c1 !important;
           background: #4263c1 !important;
           color: white !important;
       }
       a.nv_ref:hover i {
           color: white !important;
       }
       /* Ensure tooltip works properly */
       a.nv_ref[data-bs-toggle="tooltip"] {
           pointer-events: auto;
       }
       /* Modified By Madhuri.K On 07-07-2026 Parent panel: align refresh icon with Home icon */
       body.parent-panel:not(.child-panel-open) a.nv_ref {
           position: relative !important;
           top: auto !important;
           left: auto !important;
           transform: none !important;
           margin: 0 !important;
       }
       body.parent-panel.child-panel-open a.nv_ref {
           position: relative !important;
           top: auto !important;
           left: auto !important;
           transform: none !important;
       }
       /*End Added by pradip*/
.navbar-nav>.user-menu>.dropdown-menu>li.user-header>img{ border-radius:50%;}
.navbar-nav>.user-menu>.dropdown-menu>.user-footer .btn-default {
    color: #4263c1;
    border: 1px solid #4263c1;
}
.user-menu .btn-default:hover, .user-menu .btn-default:active, .user-menu .btn-default.hover {
    background-color: #4263c1;
    color: #fff!important;
}
.navbar-custom-menu>.navbar-nav>li.user-menu>.dropdown-menu {
    position: absolute;
    right: 0;
    left: auto;
    border: 1px solid #ddd;
    border-radius: 4px 4px 2px 2px;
}
div[data-popper-escaped] {display: none;}
.sidebar-collapse #treeMenu:hover{ overflow:hidden;}
.sidebar-collapse #treeMenu:hover {overflow: unset;}
.sidebar-collapse #treeMenu:hover ul, .sidebar-mini.sidebar-collapse .sidebar-menu>li:hover>a>span:not(.pull-right){display: none!important;}


/*Added By Dipali V On 17th May 2023 For Version Upgrade Responsive Issue*/
#Mmenu_togglebtn span:nth-child(1) {
    top: 11px!important;
}

       @media screen and (max-width: 767px) {
           .Mv_mobmenu .navbar-nav > .user-menu .user-image {
               margin-top: 6px !important;
           }
       }
       .d-none {
           display: block !important;
       }

       /*End of Added By Dipali V On 17th May 2023 For Version Upgrade Responsive Issue*/
   </style>
     <script type="text/javascript">

            //Commented & Added By Dipali V On 23rd Oct 2023 for Toggle Navigation Menus Issue
             //$(".sidebar-toggle").on("click", function () {
             //  $("body").toggleClass("sidebar-collapse");
             //  $("body").removeClass("sidebar-expanded-on-hover");
             //});
             //$(".sidebar-collapse .sidebar").on("mouseover", function () {
             //    $("body").addClass("sidebar-collapse");
             //    $("body").removeClass("sidebar-expanded-on-hover");
             //});

            ////End of Commented & Added By Dipali V On 23rd Oct 2023 for Toggle Navigation Menus Issue




         //Added By Aniruddh G ON 11/10/2018 For Web API Integration
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
         //End Added By Aniruddh G ON 11/10/2018 For Web API Integration
         $(document).ready(function () {
              //debugger;
             var EmployeeID;
             EmployeeID = '<%= Session("intUserID") %>';
             if (EmployeeID == '') {
                 alert('Your session is expired. Please login again.');
                 window.location.href = "../../Default.aspx?Message=SessionExpired";
             }

             GetEmployeeInformation();

             PlotNavigationTree();
             //Commented By Aditya on 08-Apr-2026 for Project Information Blank Screen Issue
             //$("#fixedtbl1").freezeHeader({
               //  'height': '300px'
             //});
            // $("#fixedtbl2").freezeHeader({
               //  'height': '300px'
             //});
             //End of Commented By Aditya on 08-Apr-2026 for Project Information Blank Screen Issue
             document.getElementById("frmNewVersion").style.height = window.innerHeight - 60 + 'px';
             document.getElementById("frmNewVersion").style.width = window.innerWidth - 65 + 'px';
             //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
             $("[data-bs-toggle=dropdown]").not(".session-project-wrapper .bootstrap-select [data-bs-toggle=dropdown]").click(function () {
                 $(this).parent().toggleClass("open");
             })
             //End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
            // debugger;
             //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
             if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                 AfterResponsivePlot();
             }
             //End of Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
             
             $(window).on("resize", function () {
                 if ($("body").hasClass("parent-panel") && typeof syncParentPanelHeaderHeight === "function") {
                     syncParentPanelHeaderHeight();
                 }
             });
             //End of added by Aditya J. on 12-06-2026 for remove blue horizontal line below header on load and after child panel close
             GetSessionProject();

             
             //Added By Dipali V On 8st Aug 2023 For Session Project 
             if ("<%= Request.QueryString("IsSetsession")%>" == "1") {
                 var GMasterTagId = '<%= Request.QueryString("MTG")%>';
                 var GParentTagID = '<%= Request.QueryString("MPTG")%>';
                 var GTemplateID = '<%= Request.QueryString("FromWhere")%>';
                 var GModuleTagID = '<%= Request.QueryString("MOTG")%>';
                 GIsChangeSession = 1;
                 $("#mainmenu_" + GMasterTagId).addClass("active");
                 $('#a_' + GTemplateID + GMasterTagId).addClass("active");
                 $('#a_' + GTemplateID + GModuleTagID).closest('li').addClass("active");
                 $('#a_' + GTemplateID + GParentTagID).closest('li').addClass("active");
                 $('#a_' + GTemplateID + GMasterTagId).click();
                 $("#mainHeadingTop").text(document.getElementById("header_" + GMasterTagId).value);

             }
             //End of Added By Dipali V On 8st Aug 2023 For Session Project 
             //End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27

             //Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27
             // IsSetsession
             //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
             sessionProjectRefreshSelectpicker("#cboSessionProject");
             //End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
             //added by Aditya J. on 12-06-2026 for remove blue horizontal line below header on load and after child panel close

             //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
             if ("<%= Request.QueryString("FromOld")%>" == "1258") {
                 document.getElementById("mainHeadingTop").innerHTML = 'Projects > Manage Projects';
                 document.getElementById("frmNewVersion").src = "";
                 document.getElementById("frmNewVersion").src = '../NewAPI/PM/PM_CreateProject.aspx?FromWhereProjectId=' + '<%= Request.QueryString("FromWhereProjectId")%>' + '&FromWhereData=' + '<%= Request.QueryString("FromWhereData")%>' + '&PKToken=' + '<%= Request.QueryString("PKToken")%>' + '&Mode=Edit';
                 ChangeTabs('../NewAPI/PM/PM_CreateProject.aspx', '../NewAPI/PM/PM_CreateProject.aspx?FromWhereProjectId=' + '<%= Request.QueryString("FromWhereProjectId")%>' + '&FromWhereData=' + '<%= Request.QueryString("FromWhereData")%>' + '&PKToken=' + '<%= Request.QueryString("PKToken")%>' + '&Mode=Edit', 1263, 'PM');
                
             }
             $(".selectpicker").selectpicker("refresh");

             $("#mainmenu_" + GlobalTagMaster).addClass("active");
 
            //Added By Madhuri.K On 21-01-2026 - Ensure breadcrumb links are auto-converted even if overwritten by other scripts
            // Changed By Madhuri.K on 19-08-2026 - Performance Improvement - Removed setTimeout
            // Changed By Madhuri.K on 10-07-2026 - Removed 500ms setTimeout; run immediately on ready to avoid perceived load delay
            initBreadcrumbObserver();
            ensureBreadcrumbLinksAreClickable();
         });


         // $(".sidebar-menu .dropdown-submenu li:first-child a").addClass("active");

         function submenuactive(activesub) {
             //alert($("#"+activesub));
             //    var checkElement = $(this).next();
             //$(this).removeClass('testing');
             //$(this).closest('li').addClass('testing');
             //$('#cssmenu li li .active').removeClass('active');
             //$(this).addClass('active');

             $("a").each(function () {
                 $(this).removeClass('active');
             });

             if ($(activesub).hasClass('active')) {
                 $(activesub).removeClass('active');
                 /* Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
                 $(".dropdown-submenu a").removeClass('active');
                 $(activesub).closest('.dropdown-submenu').find('a').removeClass('active');
                 /* Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
             }
             else {
                 $(activesub).addClass('active');
                 /* Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
                 $(activesub).parents('.dropdown-submenu').addClass('active');
                 /* Added By Nikhil A on 28-May-2020 for Integrating UX changes*/
             }

             //$("#"+activesub).addClass('active');
         }

         function GetEmployeeInformation() {
             var EmployeeID = '<%=Session("intLoginID")%>';
             var Parameters = {
                 EmployeeID: EmployeeID
             }

             $.ajax({
                 url: strUrl + '/api/Navigation/GetEmployeeDetails',
                 type: "POST",
                 data: JSON.stringify(Parameters),
                 dataType: "json",
                 contentType: "application/json",
                 beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                     if (Parameters) {
                         xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? employeeDetail : JSON.stringify(Parameters)));
                     }
                 },
                 success: function (data) {
                     console.log(data);

                     for (var i = 0; i < data.length; i++) {
                         var Employee = data[i];
                         var EmployeeID = Employee.EmployeeID;
                         var RoleID = Employee.RoleID;
                         var EmployeeName = Employee.EmployeeName;
                         var Role = Employee.Role;
                         var EmployeeImage = Employee.EmployeeImage;
                         //alert(EmployeeImage);
                         if (EmployeeImage == "NoImage") {
                             $(".EmployeeImage").attr("src", "../../Images/Photo/no-photo.png");
                             $("#UserImage").attr("src", "../../Images/Photo/no-photo.png");
                         }
                         else {
                             $(".EmployeeImage").attr("src", "../../Images/Photo/" + EmployeeImage);
                             $("#UserImage").attr("src", "../../Images/Photo/" + EmployeeImage);
                         }

                         $("#EmployeeName").html(EmployeeName);
                         $("#EmployeeNameRole").html(EmployeeName + "&nbsp;-&nbsp;" + Role + "");
                     }
                 },
                 error: function (err) {
                     console.log(err);
                 }
             })
         }
         var treeChildMenu;
         var ProjectID = "";
         //Added By Dipali V On 12th Feb 2021 
         var GlobalTagMaster = "";
         var GlobalDefaultModule = 0;
         var GlobalDisplayPageName = "";
         var GlobalDisplayHeader = "";
         var GlobalsDefaultModule = "";
         var GlobalTemplateID = ""
         var CheckGlobalAcess = 0;<%--Added By Dipali V On 11th jan 2021 for check Module Access--%>
        // Prevent stale async responses from overwriting refreshed navigation tree
        var navTreeRequestSeq = 0;
        // Dipali V - Dashboard module TagID vs legacy submenu ParentTagId (Project folder under 9999 in SP)
        var DASHBOARD_MODULE_TAGID = 21000;
        var DASHBOARD_LEGACY_PARENT_TAGID = 9999;
        var DASHBOARD_TEMPLATE_ID = 'DB';

        function safeNavLabel(val) {
            if (val == null || val === undefined) return '';
            return String(val);
        }

        function safeNavTextLower(val) {
            return safeNavLabel(val).toLowerCase().trim();
        }

        function getTagTemplateId(tagMaster) {
            if (!tagMaster) return '';
            return safeNavLabel(tagMaster.TemplateID || tagMaster.TemplateId || '');
        }

        function isDashboardDbTag(tagMaster) {
            return getTagTemplateId(tagMaster).toUpperCase() === DASHBOARD_TEMPLATE_ID;
        }

        function isDashboardChildPanelContext(moduleTagId) {
            var id = parseInt(moduleTagId, 10);
            return id === DASHBOARD_MODULE_TAGID || id === DASHBOARD_LEGACY_PARENT_TAGID;
        }

        function isDashboardModuleTagId(moduleTagId) {
            return isDashboardChildPanelContext(moduleTagId);
        }

        //Added By Madhuri.K On 17-08-2026 Keep Analytics parent module immediately after Dashboard in the left nav
        function reorderAnalyticsAfterDashboard(menu) {
            if (!menu || !menu.length) return menu;
            var result = [];
            var analyticsNodes = [];
            var dashboardIndex = -1;
            for (var i = 0; i < menu.length; i++) {
                var tm = menu[i];
                var parentId = parseInt(tm.ParentTagId, 10);
                var name = safeNavTextLower(tm.DisplayTagName);
                if (parentId === 0 && name === 'analytics') {
                    analyticsNodes.push(tm);
                    continue;
                }
                result.push(tm);
                if (parentId === 0 && (name === 'dashboard' || parseInt(tm.TagID, 10) === DASHBOARD_MODULE_TAGID)) {
                    dashboardIndex = result.length - 1;
                }
            }
            if (!analyticsNodes.length) return menu;
            var insertAt = dashboardIndex >= 0 ? dashboardIndex + 1 : result.length;
            for (var a = 0; a < analyticsNodes.length; a++) {
                result.splice(insertAt + a, 0, analyticsNodes[a]);
            }
            return result;
        }

        function mergeDashboardChildren(primaryList, extraList) {
            var merged = primaryList ? primaryList.slice() : [];
            if (!extraList || !extraList.length) return merged;
            var seen = {};
            var i, tid;
            for (i = 0; i < merged.length; i++) {
                tid = parseInt(merged[i].TagID, 10);
                if (!isNaN(tid)) seen[tid] = true;
            }
            for (i = 0; i < extraList.length; i++) {
                tid = parseInt(extraList[i].TagID, 10);
                if (!isNaN(tid) && !seen[tid]) {
                    seen[tid] = true;
                    merged.push(extraList[i]);
                }
            }
            return merged;
        }

        function getDashboardChildTags(parentTagId, data) {
            return GetTagMastersByParentTagID(parentTagId, data, DASHBOARD_TEMPLATE_ID);
        }

        function getChildTagsForModuleParent(moduleTagId, parentTagId, data) {
            if (isDashboardChildPanelContext(moduleTagId)) {
                return getDashboardChildTags(parentTagId, data);
            }
            return GetTagMastersByParentTagID(parentTagId, data);
        }

        function getModuleChildTags(parentTagId, data) {
            if (isDashboardChildPanelContext(parentTagId)) {
                return mergeDashboardChildren(
                    getDashboardChildTags(DASHBOARD_MODULE_TAGID, data),
                    getDashboardChildTags(DASHBOARD_LEGACY_PARENT_TAGID, data)
                );
            }
            return GetTagMastersByParentTagID(parentTagId, data);
        }

        function isNavFolderOnlyNode(tagMaster) {
            if (!tagMaster) return false;
            var isParent = tagMaster.IsParent == 1 || tagMaster.IsParent == "1";
            if (!isParent) return false;
            var page = tagMaster.DisplayPageName;
            if (page == null || page === undefined) return true;
            var p = String(page).trim().toLowerCase();
            return p === "" || p === "#";
        }

         //Added by Aditya J. on 10-06-2026 - Project module access via API
         //Replaces server-side GProjectModuleAcess variable + alert + inline show/hide.
         //Calls usp_Whizible2_sel_ProjectModuleAccess SP via GetProjectModuleAccess API.
         //Hides or shows #cboSessionProject and its wrapper based on HasProjectAccess returned by SP.
         function ApplySessionProjectVisibility() {
             var LoginID = '<%=Session("intLoginID")%>';
             var paramsData = { LoginID: encodeURI(LoginID) }
             //var encryptedParams = EncryptData(paramsData);
             $.ajax({
                 url: strUrl + '/api/Navigation/GetProjectModuleAccess',
                 type: 'POST',
                 data: JSON.stringify(paramsData),
                 contentType: 'application/json',
                 beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem('access_token'));
                     if (paramsData) {
                         xhr.setRequestHeader("Params", encryptString(isJson(paramsData) ? paramsData : JSON.stringify(paramsData)));
                     }
                 },
                 success: function (result) {
                     sessionProjectSetVisibility(result === true);
                 },
                 error: function (xhr) {
                     console.error('[GetProjectModuleAccess] Error: ' + xhr.status + ' ' + xhr.statusText);
                     sessionProjectSetVisibility(false);
                 }
             });
         }
         //End of Added by Aditya J. on 10-06-2026

         function PlotNavigationTree() {
             //debugger;
             //Added by Aditya J. on 10-06-2026 - Check project module access and apply visibility
             ApplySessionProjectVisibility();
            var currentRequestSeq = ++navTreeRequestSeq;
            // Preserve currently selected parent module during refresh
            var previousParentTagID = null;
            var expandedParentTagIDs = [];
            try {
                var selectedParentId = $('.parent-panel .sidebar-menu > li.parent-icon.selected').first().attr('id');
                if (selectedParentId && selectedParentId.indexOf('mainmenu_') === 0) {
                    previousParentTagID = parseInt(selectedParentId.replace('mainmenu_', ''), 10);
                }
                if ((isNaN(previousParentTagID) || !previousParentTagID) && $("#childPanelHeader").length) {
                    previousParentTagID = parseInt($("#childPanelHeader").attr("data-parent-tagid"), 10);
                }
                if (isNaN(previousParentTagID)) previousParentTagID = null;
                // Preserve expanded tree modules (legacy tree view)
                $("#treeMenu > li.treeview").each(function () {
                    var $li = $(this);
                    var id = $li.attr("id");
                    var isExpanded = $li.hasClass("active") || $li.children("ul.treeview-menu:visible").length > 0;
                    if (id && id.indexOf("mainmenu_") === 0 && isExpanded) {
                        var tagId = parseInt(id.replace("mainmenu_", ""), 10);
                        if (!isNaN(tagId)) expandedParentTagIDs.push(tagId);
                    }
                });
            } catch (exPrevSel) { previousParentTagID = null; }
            // Keep existing tree visible while refresh request is in-flight.
            // This prevents the parent icons from disappearing briefly and showing blank space.
            // (We only replace the tree once the new data is ready.)
             var IsTimesheetPresent = 0;
             //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
             var IsHelpdeskSupportPresent = 0;
             //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
             //Added By Dipali V On 2oth Jan 2020 For Plot tree
             if ('<%=Session("intProjectID")%>' != "") {
                 ProjectID = '<%=Session("intProjectID")%>'
             } else {
                 ProjectID = 0;
             }

             var EmployeeID = '<%=Session("intLoginID")%>';
             //commented and added by Aditya J. on 20-08-2026 for agile project related pages not getting plotted after selecting agile project
             //var Parameters = {
             //    EmployeeID: EmployeeID,
             //    ProjectID: ProjectID,
             //}
             var Parameters = {
                 EmployeeID: EmployeeID,
                 ProjectID: $("#cboSessionProject").val(),
             }
             //End of added by Aditya J. on 20-08-2026 for agile project related pages not getting plotted after selecting agile project
             
             //End of Added By Dipali V On 2oth Jan 2020 For Plot tree
             $.ajax({
                 url: strUrl + '/api/Navigation/GetTagMasters',
                 type: "POST",
                 //Added By Dipali V On 2oth Jan 2020 For Plot tree
                 data: JSON.stringify(Parameters),
                 contentType: "application/json",
                 //End of Added By Dipali V On 2oth Jan 2020 For Plot tree
                 //dataType: "json",
                 //async:false,
                 beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                     if (Parameters) {
                         xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                     }
                 },
                success: function (data) {
                   // Ignore stale response if a newer refresh call already started
                   if (currentRequestSeq !== navTreeRequestSeq) return;
                    // debugger;
                   treeChildMenu = Array.isArray(data) ? data : [];
                   // Replace tree in a single operation to reduce UI flicker.
                   $("#treeMenu").html(getChildTags(0));
                    bindNavImageFallback($("#treeMenu"));
                   // Keep child panel in sync with refreshed access tree (avoid stale nodes)
                   if ($("#childPanel").hasClass("active")) {
                       var currentParentTagId = parseInt($("#childPanelHeader").attr("data-parent-tagid"), 10);
                       if (!isNaN(currentParentTagId) && currentParentTagId > 0) {
                           var moduleTagIdForPanel = isDashboardChildPanelContext(currentParentTagId)
                               ? DASHBOARD_MODULE_TAGID : currentParentTagId;
                           var parentStillExists = treeChildMenu.some(function (n) {
                               return parseInt(n.TagID, 10) === moduleTagIdForPanel && parseInt(n.ParentTagId, 10) === 0;
                           });
                           if (parentStillExists && getModuleChildTags(currentParentTagId, treeChildMenu).length > 0) {
                               showChildPanel(moduleTagIdForPanel, true);
                           } else {
                               hideChildPanel();
                           }
                       } else {
                           hideChildPanel();
                       }
                   }
                    //Added By Madhuri.K On 09-01-2026 For Parent Panel
                    $("body").addClass("parent-panel");
                    // Modified By Madhuri.K On 07-07-2026 Wide parent sidebar on load (SS2) unless child tree is already open
                    if (!$("#childPanel").hasClass("active")) {
                        $("body").removeClass("child-panel-open child-tree-expanded has-child-selection");
                    }
                    syncParentPanelHeaderHeight();
                    //Set default header if available
                    if (GlobalDisplayHeader && GlobalDisplayHeader != "" && GlobalDisplayHeader != "undefined") {
                        document.getElementById("mainHeadingTop").innerHTML = GlobalDisplayHeader;
                    } else if (document.getElementById("mainHeadingTop").innerHTML == "" || document.getElementById("mainHeadingTop").innerHTML == "undefined") {
                        document.getElementById("mainHeadingTop").innerHTML = "";
                    }
                    //End Added By Madhuri.K On 09-01-2026
                    //return;
                     $("#treeMenu").scroll(function () {
                         $(".freezeLi").css("top", $(this).scrollTop());
                     });
                     var flag;
                     var FirstTags = 0;
                     var strHTML = "";
                     var strResponsiveHTML = "";
                     var firstResponsiveTagID = 0;
                     //var IsTimesheetLandingPage = 1;
                     var IsTimesheetLandingPage = 1;
                     //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                     var IsHelpdeskSupportLandingPage = 1;
                     //var IsHelpdeskDashbordLandingPage = 1;
                     //var IsHelpdeskConfigurationLandingPage = 1;
                     //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                     //strHTML += "<li clalert('hiii 1');
                     for (var i = 0; i < data.length; i++) {
                         // debugger;
                         var tagMaster = data[i];
                         var TagID = tagMaster.TagID;
                         var TemplateID = tagMaster.TemplateID;
                         var DisplayPageName = tagMaster.DisplayPageName;
                         var DisplayTagName = tagMaster.DisplayTagName;
                         var ParentTagId = tagMaster.ParentTagId;
                         var isParent = tagMaster.IsParent;
                         var Image = tagMaster.Image;
                         var IsDefaultPage = tagMaster.IsDefaultPage;
                         var DisplayHeader = tagMaster.DisplayHeader;
                         var AllowResponsive = tagMaster.AllowResponsive;
                         var ResponsivePageName = tagMaster.ResponsivePageName;
                         var TimesheetLandingPage = '../NewAPI/Timesheet/TMS_LandingPage.aspx';
                         //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                         var HelpDeskLandingPage = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx';
                         //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                         if (tagMaster.IsDefaultModule == 1 || tagMaster.IsDefaultModule == "1") {
                             GlobalDisplayPageName = DisplayPageName;
                             GlobalDisplayHeader = DisplayHeader;
                             GlobalTagMaster = tagMaster.TagID;
                             GlobalTemplateID = tagMaster.TemplateID;
                             GlobalDefaultModule = tagMaster.IsDefaultModule;
                         }
                         var IsLandingPage = tagMaster.IsLandingPage;

                         <%--Added By Dipali V On 11th jan 2021 for check Module Access--%>
                         if (CheckGlobalAcess == 0) {
                             if (AllowResponsive == 1) {
                                 //debugger;
                                 CheckGlobalAcess = 1;
                             }
                         }
                        // console.log(AllowResponsive, "FLAG");
                         <%--End of Added By Dipali V On 11th jan 2021 for check Module Access--%>

                         if (TagID == 10)
                             IsTimesheetPresent = 1;
                         //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                         if (TagID == 405)
                             IsHelpdeskSupportPresent = 1;
                         //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                         if (isParent == 1)
                             FirstTags = FirstTags + 1;

                         if (FirstTags <= 5)
                             flag = 1;
                         else
                             flag = 2;


                         // debugger;
                         var childTagMasters = GetTagMastersByParentTagID(TagID, data);
                         var childHTML = "";
                         for (var j = 0; j < childTagMasters.length; j++) {

                             var childDisplayPageName = childTagMasters[j].DisplayPageName;
                             var childDisplayTagName = childTagMasters[j].DisplayTagName;
                             var childTagID = childTagMasters[j].TagID;
                             var childDisplayHeader = childTagMasters[j].DisplayHeader;
                             var childParentTagId = childTagMasters[j].ParentTagId;
                             var childResponsivePageName = childTagMasters[j].ResponsivePageName;
                             var childIsLandingPage = childTagMasters[j].IsLandingPage;
                             var  childTemplateID = childTagMasters[j].TemplateID;
                             if (childIsLandingPage == 1) {

                                 if (childParentTagId == 10) {

                                     childHTML += "<li onclick=ChangeTabs('" + TimesheetLandingPage + "?TagID=" + childParentTagId + "" + "'," + childTagID + ",'" + childParentTagId + "'," + childTemplateID +",'" + childResponsivePageName + "')><input type='hidden' id='header_" + childTagID + "' value='" + childDisplayHeader + "'><a onclick='submenuactive(this)'><i class='fa-regular fa-circle'></i><i class='fa-solid fa-circle'></i>" + childDisplayTagName + "</a></li>"
                                 }
                                 //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.                                
                                 else if (childParentTagId == 405 && childTagID == 405) {
                                     childHTML += "<li onclick=ChangeTabs('" + HelpDeskLandingPage + "?TagID=" + childTagID + "" + "'," + childTagID + ",'" + childParentTagId + "'," + childTemplateID +",'" + childResponsivePageName + "')><input type='hidden' id='header_" + childTagID + "' value='" + childDisplayHeader + "'><a onclick='submenuactive(this)'><i class='fa-regular fa-circle'></i><i class='fa-solid fa-circle'></i>" + childDisplayTagName + "</a></li>"
                                 }
                                 //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                                 else {

                                     childHTML += "<li onclick=ChangeTabs('" + childDisplayPageName + "'," + childTagID + "," + childParentTagId + ",'" + childTemplateID +"','" + childResponsivePageName + "')><input type='hidden' id='header_" + childTagID + "' value='" + childDisplayHeader + "'><a onclick='submenuactive(this)'><i class='fa-regular fa-circle'></i><i class='fa-solid fa-circle'></i>" + childDisplayTagName + "</a></li>"
                                 }
                             }
                             else {
                                 if (childParentTagId == 10) { IsTimesheetLandingPage = 0; }
                                 //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                                 if (childParentTagId == 405) { IsHelpdeskSupportLandingPage = 0; }
                                 //if (childParentTagId == 1085) { IsHelpdeskDashbordLandingPage = 0; }
                                 // if (childParentTagId == 914) { IsHelpdeskConfigurationLandingPage = 0; }
                                 //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.

                                 childHTML += "<li onclick=ChangeTabs('" + childDisplayPageName + "'," + childTagID + "," + childParentTagId + ",'" + childTemplateID + "','" + childResponsivePageName + "')><input type='hidden' id='header_" + childTagID + "' value='" + childDisplayHeader + "'><a onclick='submenuactive(this)'><i class='fa-regular fa-circle'></i><i class='fa-solid fa-circle'></i>" + childDisplayTagName + "</a></li>"
                             }

                             //childHTML += "<li onclick=ChangeTabs('" + childDisplayPageName + "'," + childTagID + "," + childParentTagId + ",'" + childResponsivePageName + "')><input type='hidden' id='header_" + childTagID + "' value='" + childDisplayHeader + "'><a onclick='submenuactive(this)'>" + childDisplayTagName + "</a></li>"
                         }


                         if (childTagMasters.length > 0) {

                             if (isParent == 1) {
                                 if (childParentTagId == 305) {
                                     strHTML += '<li class="treeview" id="mainmenu_' + TagID + '" onclick=ChangeTabs("' + DisplayPageName + '",' + TagID + ',' + ParentTagId + ',"' + TemplateID + '","' + ResponsivePageName + '")><a><i class="fa"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="44px"></i> <span>' + DisplayTagName + '</span><span class="pull-left-container"><i class="fas fa-caret-right"></i></span></a>'
                                 }
                                 else {
                                     strHTML += '<li class="treeview" id="mainmenu_' + TagID + '"><a><i class="fa"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="44px"></i> <span>' + DisplayTagName + '</span><span class="pull-left-container"><i class="fas fa-caret-right"></i></span></a>'
                                 }
                                 // strHTML += '<li class="dropdown-submenu" id="mainmenu_' + flag + '" onclick=ChangeTabs("' + DisplayPageName + '",' + TagID + ',' + ParentTagId + ',"' + ResponsivePageName + '")><a><i class="fa"><img src="../../Whizible2.0/dist/img/' + Image + '"  alt="" width="44px"></i> <span>' + DisplayTagName + '</span></a>'
                                 // if (childParentTagId != 305) {
                                 //strHTML += "<ul class='dropdown-menu' role='menu'>"
                                 //strHTML += childHTML;
                                 //     strHTML += "</ul>"
                                 //     }

                                 if (childParentTagId != 305) {
                                     strHTML += "<ul class='treeview-menu' role='menu'>";
                                     //For submenu scroll Pradip
                                     //strHTML += "<div class='submenu_slim_scroll'>";
                                     //For submenu scroll Pradip
                                     strHTML += childHTML;
                                     //For submenu scroll Pradip
                                     //strHTML += "</div>";
                                     //For submenu scroll Pradip
                                     strHTML += '<li class="treeview" id="mainmenu_' + TagID + '" ><a><span>Multilevel</span><span class="pull-left-container"><i class="fas fa-caret-right"></i></span></a>'
                                     strHTML += "<ul class='treeview-menu' role='menu'>";
                                     strHTML += childHTML;
                                     strHTML += "</ul>"
                                     strHTML += "</li>";
                                     strHTML += "</ul>"
                                 }
                                 strHTML += "</li>";
                             }
                         }
                         else {
                             if (isParent == 1)

                                 strHTML += "<li class='' id='mainmenu_" + TagID + "' onclick=ChangeTabs('" + DisplayPageName + "'," + TagID + "," + ParentTagId + ",'" + TemplateID + "','" + ResponsivePageName + "')><a href='#'><input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'><i class='fa'><img src='../../Whizible2.0-new/dist/img/" + Image + "'  alt='' width='44px'></i> <span>" + DisplayTagName + "</span></a></li>"

                         }

                         //console.log(AllowResponsive, DisplayTagName);
                         if (AllowResponsive == 1) {

                             if (isParent == 1) {
                                 if (firstResponsiveTagID == 0) {
                                     firstResponsiveTagID = TagID;
                                 }

                                 strResponsiveHTML += "<li onclick='plotChildSubMenu(" + TagID + ")'><a><i class='fa'><img src='../../Whizible2.0-new/dist/img/" + Image + "'  alt='' width='44px'></i> <span>" + DisplayTagName + "</span></a></li>"

                             }
                         }
                    }
                    
                     //}
                     strResponsiveHTML += '<li class="Mmenulogo"><a href="#"><i class="fa">&nbsp;</i> <span><img src="../../Whizible2.0-new/dist/img/mobmenu/Whisible.svg" alt="" width="60px"></span></a></li>';

                     $("#responsiveMenu").html(strResponsiveHTML);


                     //Modified By Madhuri.K On 16-01-2026 - No need to hide tooltips for parent icons - using simple native browser tooltips
                     
                     $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").not(".session-project-wrapper .bootstrap-select [data-bs-toggle='dropdown']").tooltip();
                     var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='tab']")).filter(function (tooltipTriggerEl) {
                         return $(tooltipTriggerEl).closest(".session-project-wrapper .bootstrap-select").length === 0;
                     });
                     var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                         return new bootstrap.Tooltip(tooltipTriggerEl)
                     });
                     $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").not(".session-project-wrapper .bootstrap-select [data-bs-toggle='dropdown']").hover(function () {
                         $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").not(".session-project-wrapper .bootstrap-select [data-bs-toggle='dropdown']").tooltip('update');
                     });
                     //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
                     sessionProjectClearSelectpickerTooltip("#cboSessionProject");
                     //End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
                    
                    //Modified By Madhuri.K On 10-01-2026 - Re-initialize refresh icon tooltip after navigation tree is plotted
                    // Changed By Madhuri.K on 19-06-2026 - Removed 100ms setTimeout; tree HTML is already in the DOM at this point
                    var refreshIcon = document.querySelector('a.nv_ref[data-bs-toggle="tooltip"]');
                        if (refreshIcon) {
                            // Dispose existing tooltip if any
                            var existingTooltip = bootstrap.Tooltip.getInstance(refreshIcon);
                            if (existingTooltip) {
                                existingTooltip.dispose();
                            }
                            // Initialize new tooltip
                            new bootstrap.Tooltip(refreshIcon, {
                                placement: 'bottom',
                                container: 'body'
                            });
                        }
                        
                        //Modified By Madhuri.K On 16-01-2026 - Set data-tooltip and add JavaScript-based tooltip positioning
                        var parentIcons = document.querySelectorAll('.parent-panel .sidebar-menu > li.parent-icon > a > i.fa');
                        parentIcons.forEach(function(icon) {
                            // Get title from icon, parent link, or hidden input
                            var title = icon.getAttribute('title') || icon.getAttribute('data-tooltip') || icon.closest('a').getAttribute('title');
                            if (!title) {
                                var $hiddenInput = $(icon).closest('li').find('input[type="hidden"][id^="header_"]');
                                if ($hiddenInput.length > 0) {
                                    title = $hiddenInput.val();
                                }
                            }
                            // Set data-tooltip for custom CSS tooltip and remove title to hide native tooltip
                            if (title) {
                                icon.setAttribute('data-tooltip', title);
                                icon.removeAttribute('title'); // Remove title to hide native browser tooltip
                                
                                // Add hover event to position tooltip dynamically
                                var liId = icon.closest('li').id || 'li-' + Math.random().toString(36).substr(2, 9);
                                if (!icon.closest('li').id) {
                                    icon.closest('li').id = liId;
                                }
                                
                                icon.addEventListener('mouseenter', function(e) {
                                    var rect = icon.getBoundingClientRect();
                                    var tooltipText = icon.getAttribute('data-tooltip');
                                    
                                    // Create tooltip element if it doesn't exist
                                    var tooltipEl = document.getElementById('custom-tooltip-' + liId);
                                    if (!tooltipEl) {
                                        tooltipEl = document.createElement('div');
                                        tooltipEl.id = 'custom-tooltip-' + liId;
                                        tooltipEl.className = 'custom-parent-tooltip';
                                        tooltipEl.textContent = tooltipText;
                                        document.body.appendChild(tooltipEl);
                                    }
                                    
                                    // Position tooltip to the right of icon
                                    tooltipEl.style.left = (rect.right + 10) + 'px';
                                    tooltipEl.style.top = (rect.top + rect.height / 2 - tooltipEl.offsetHeight / 2) + 'px';
                                    tooltipEl.style.display = 'block';
                                });
                                
                                icon.addEventListener('mouseleave', function() {
                                    var tooltipEl = document.getElementById('custom-tooltip-' + liId);
                                    if (tooltipEl) {
                                        tooltipEl.style.display = 'none';
                                    }
                                });
                            }
                        });
                    
                     //Modified By Madhuri.K On 27-01-2026 - Set parent icon as selected after navigation tree is rendered and GlobalTagMaster is set
                     // Changed By Madhuri.K on 19-08-2026 - Removed setTimeout; tree DOM is already rendered synchronously above
                     (function() {
                        // Prefer previously selected module on refresh (if still accessible)
                        var previousStillExists = false;
                        if (previousParentTagID && treeChildMenu && treeChildMenu.length > 0) {
                            for (var p = 0; p < treeChildMenu.length; p++) {
                                if (parseInt(treeChildMenu[p].TagID, 10) === parseInt(previousParentTagID, 10) &&
                                    parseInt(treeChildMenu[p].ParentTagId, 10) === 0) {
                                    previousStillExists = true;
                                    break;
                                }
                            }
                        }
                        if (previousStillExists) {
                            setParentModuleSelected(previousParentTagID);
                        } else if (GlobalTagMaster) {
                            setParentModuleSelected(GlobalTagMaster);
                        }
                        // Also check for Helpdesk (405) or Timesheet (10) if they're the default
                        else if (IsHelpdeskSupportPresent == 1 && !GlobalTagMaster) {
                            setParentModuleSelected(405);
                        } else if (IsTimesheetPresent == 1 && !GlobalTagMaster) {
                            setParentModuleSelected(10);
                        }

                        // Restore expanded state for tree modules after refresh
                        if (expandedParentTagIDs && expandedParentTagIDs.length > 0) {
                            expandedParentTagIDs.forEach(function (tagId) {
                                var $li = $("#mainmenu_" + tagId);
                                if ($li.length > 0) {
                                    $li.addClass("active");
                                    $li.children("ul.treeview-menu").show();
                                }
                            });
                        }
                    })();

                     //debugger;
                     //added By Dipali V On 27th Jan 2021 For Menu hide issue
                     if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                         plotChildSubMenu(10);
                     }
                     //End of added By Dipali V On 27th Jan 2021 For Menu hide issue
                    
                     //For submenu scroll Pradip
                     //Script Added by pradip on 10-06-2020 for offset menu
                     function determineDropDirection() {
                         $(".sidebar-menu .dropdown-menu").each(function () {
                             // Invisibly expand the dropdown menu so its true height can be calculated
                             $(this).css({
                                 visibility: "hidden",
                                 display: "block"
                             });

                             // Necessary to remove class each time so we don't unwantedly use dropup's offset top
                             $(this).parent().removeClass("dropup");

                             // Determine whether bottom of menu will be below window at current scroll position
                             if ($(this).offset().top + $(this).outerHeight() > $(window).innerHeight() + $(window).scrollTop()) {
                                 $(this).parent().addClass("dropup");
                             }

                             // Return dropdown menu to fully hidden state
                             $(this).removeAttr("style");
                         });
                     }
                    
                     determineDropDirection();
                     $(window).scroll(determineDropDirection);
                     //End Script Added by pradip on 10-06-2020
                    
                    if ("<%= Request.QueryString("FromOld")%>" == "10") {
                        
                        //Modified By Madhuri.K On 10-01-2026 - Set parent icon as selected when Timesheet loads from query string
                        setParentModuleSelected(10);
                         if (IsTimesheetLandingPage == 0) {
                             ChangeTabs('../NewAPI/Timesheet/TimesheetEntry.aspx', 2124, 10,'DT','');
                         }
                         else {
                             ChangeTabs('../NewAPI/Timesheet/TMS_LandingPage.aspx?TagID=10', 2124, 10,'DT','');
                         }

                        
                         plotChildSubMenu(10);
                         //Added By Usha Pandit On 19.07.2019 For showing correct header name of the page currently getting shown
                         if (GlobalDefaultModule == 0 && $("#page").css('display')=='none') {
                             if (IsTimesheetLandingPage == 0) {
                                 document.getElementById("mainHeadingTop").innerHTML = document.getElementById("header_" + 2124).value;
                             }
                         }
                         //End Of Added By Usha Pandit On 19.07.2019 For showing correct header name of the page currently getting shown

                     }
                     //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                    else if ("<%= Request.QueryString("FromOld")%>" == "405" && $("#page").css('display') == 'none') {

                        //Modified By Madhuri.K On 10-01-2026 - Set parent icon as selected when Helpdesk loads from query string
                        setParentModuleSelected(405);
                        if (IsHelpdeskSupportLandingPage == 0) {
                             ChangeTabs('../HelpdeskEnhancement/Settings/HelpdeskTab.aspx', 405, 405,'CRM','');
                         }
                        else {
                             ChangeTabs('../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx?TagID=405', 405, 405,'CRM','');
                         }

                         plotChildSubMenu(405);
                         if (GlobalDefaultModule == 0 && $("#page").css('display') == 'none') {
                             if (IsHelpdeskSupportLandingPage == 0) {
                                 document.getElementById("mainHeadingTop").innerHTML = document.getElementById("header_" + 405).value;
                             }
                         }
                     }
                                      
                     //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                        //GlobalDefaultModule==0 condition added by Aditya J. on 23-02-2026
                    else if (GlobalDefaultModule == 0 || "<%= Request.QueryString("FromOld")%>" == "21000" && $("#page").css('display') == 'none') {
                        //commented and Added by Aditya J. on 23-02-2026 for showing landing page as default page                       
                        /*ChangeTabs('../NewAPI/Dashboard/Dashboard.aspx', 21000, 21000, '../NewAPI/Dashboard/Dashboard.aspx','DB','');*/
                        GlobalDisplayPageName = "../NewAPI/PM/LandingPage_New.aspx?MasterTagId=3";
                        document.getElementById("frmNewVersion").src = GlobalDisplayPageName;
                        ChangeTabs(this, GlobalDisplayPageName, GlobalTagMaster, GlobalTemplateID, GlobalDisplayPageName);
                        $('#a_' + GlobalTemplateID + GlobalTagMaster).trigger('click');
                        //End of commented and Added by Aditya J. on 23-02-2026 for showing landing page as default page    
                         plotChildSubMenu(9999);
                     }
                    else if ("<%= Request.QueryString("FromOld")%>" == "21006" && $("#page").css('display') == 'none') {

                         ChangeTabs('../NewAPI/PM/ProjectDashBoard.aspx', 21006, 21006, '../NewAPI/PM/ProjectDashBoard.aspx','DB','');
                         plotChildSubMenu(9999);
                     }
                    else if ("<%= Request.QueryString("FromOld")%>" == "405" && $("#page").css('display') == 'none') {

                         ChangeTabs('../HelpdeskEnhancement/Settings/HelpdeskTab.aspx', 405, 405,'CRM','');

                     }
                    else if ("<%= Request.QueryString("FromOld")%>" == "5" && $("#page").css('display') == 'none') {

                         ChangeTabs('../NewAPI/Issues/IssueList.aspx', 5, 5,'BTS','');

                     }
                <%--   else if ("<%= Request.QueryString("FromOld")%>" == "1038") {
                         ChangeTabs('../NewAPI/PM/PM_CreateProject.aspx', 1038, 1038);

                     }--%>
                    else {

                         //debugger;
                          //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
                         if ("<%= Request.QueryString("FromOld")%>" == "1258") {
                             IsTimesheetPresent = 0;
                             IsHelpdeskSupportPresent = 0;
                         }

                          //End of Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
                        if (IsTimesheetPresent == 1 && GlobalDefaultModule == 0 && $("#page").css('display') == 'none') {

                            //Modified By Madhuri.K On 10-01-2026 - Set parent icon as selected when Timesheet loads on page load
                            // Changed By Madhuri.K on 19-08-2026 - Removed unnecessary 500ms setTimeout; tree DOM is already rendered synchronously above (see $("#treeMenu").html(...) earlier in this same success callback), so calling immediately is safe and avoids a perceived load delay
                            setParentModuleSelected(10);

                            if (IsTimesheetLandingPage == 0) {
                                
                                 ChangeTabs('../NewAPI/Timesheet/TimesheetEntry.aspx', 2124, 10,'DT','../NewAPI/TimesheetMobile/TimesheetEntry_Mobile.aspx');
                             }
                             else {

                                 ChangeTabs('../NewAPI/Timesheet/TMS_LandingPage.aspx?TagID=10', 2124, 10,'DT','../NewAPI/TimesheetMobile/TimesheetEntry_Mobile.aspx');
                             }

                             //ChangeTabs('../NewAPI/Dashboard/Dashboard.aspx', 21000, 21000,'../NewAPI/Dashboard/Dashboard.aspx');

                             plotChildSubMenu(10);

                             //Added By Usha Pandit On 19.07.2019 For showing correct header name of the page currently getting shown
                             if (GlobalDefaultModule == 0 && $("#page").css('display') == 'none') {
                                 if (IsTimesheetLandingPage == 0) {
                                     document.getElementById("mainHeadingTop").innerHTML = document.getElementById("header_" + 2124).value;
                                 }
                             }
                             //End Of Added By Usha Pandit On 19.07.2019 For showing correct header name of the page currently getting shown
                         }
                         //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                         //Modified By Madhuri.K On 27-01-2026 - Added GlobalDefaultModule == 0 check to prevent Helpdesk selection when another module is default
                         else if (IsHelpdeskSupportPresent == 1 && GlobalDefaultModule == 0 && $("#page").css('display') == 'none') {
                             //Modified By Madhuri.K On 10-01-2026 - Set parent icon as selected when Helpdesk loads on page load
                             // Changed By Madhuri.K on 19-08-2026 - Removed unnecessary 500ms setTimeout; tree DOM is already rendered synchronously above (see $("#treeMenu").html(...) earlier in this same success callback), so calling immediately is safe and avoids a perceived load delay
                             setParentModuleSelected(405);
                             if (IsHelpdeskSupportLandingPage == 0) {
                                 ChangeTabs('../HelpdeskEnhancement/Settings/HelpdeskTab.aspx', 405, 405,'CRM','../HelpdeskEnhancement/Settings/HelpdeskTab.aspx');
                             }
                             else {
                                 ChangeTabs('../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx?TagID=405', 405, 405,'CRM','../HelpdeskEnhancement/Settings/HelpdeskTab.aspx');
                             }

                             plotChildSubMenu(405);
                             if (GlobalDefaultModule == 0 && $("#page").css('display') == 'none') {
                                 if (IsHelpdeskSupportLandingPage == 0) {
                                     document.getElementById("mainHeadingTop").innerHTML = document.getElementById("header_" + 405).value;
                                 }
                             }
                         }
                         //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                         else {
                             if ('<%=Session("intLoginID")%>' == 'E') {
                                 ChangeTabs('../General/Navigation.aspx?FromWhere=DB', 305, 305,'DB','');
                             }
                             else if ('<%=Session("LoginType")%>' == 'C') {
                                 if (TagID == 405) {
                                     ChangeTabs('../HelpdeskEnhancement/Settings/HelpdeskTab.aspx', 405, 405,'CRM','');
                                 }
                             }
                         }
                    }
                    
                     <%--Added By Dipali V On 11th jan 2021 for check Module Access--%>
                     if (CheckGlobalAcess == 0) {
                         $("#responsiveSubmenu").css("display", "none");
                         //$("#body").html("");
                         $("#frmNewResponsiveVersion").css("display", "none");
                         $("#DivCheckModuleAccess").css("display", "block");

                     }
                    
                     if ($("#page").css('display') == 'none'){
                         if (GlobalDefaultModule == 1 || GlobalDefaultModule == "1") {
                             // debugger;
                             if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                                 //if (GlobalDisplayPageName != "") { //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
                                 document.getElementById("mainHeadingTop").innerHTML = GlobalDisplayHeader;
                                 //  $("#mainmenu_" + GlobalTagMaster).addClass("active");
                                 if (GlobalTagMaster == 357 || GlobalTagMaster == "357") {
                                     GlobalDisplayPageName = "../NewAPI/Invoice/RFI_LandingPage.aspx?MasterTagId=357";
                                     //ChangeTabs('../NewAPI/Invoice/RFI_LandingPage.aspx?MasterTagId=357', 357, 357, '../NewAPI/Invoice/RFI_LandingPage.aspx');
                                 }
                                 else if (GlobalTagMaster == 405 || GlobalTagMaster == "405") {
                                     GlobalDisplayPageName = "../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx?TagID=405";
                                     //ChangeTabs('../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx?TagID=405', 405, 405, '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx');
                                 }
                                 else if (GlobalTagMaster == 654 || GlobalTagMaster == "654") {
                                     GlobalDisplayPageName = "../NewAPI/Process/process_landing.aspx?MasterTagId=654";
                                     //ChangeTabs('../NewAPI/Process/process_landing.aspx', 654, 654, '../NewAPI/Process/process_landing.aspx');

                                 }
                                 else if (GlobalTagMaster == 10 || GlobalTagMaster == "10") {

                                     GlobalDisplayPageName = "../NewAPI/Timesheet/TMS_LandingPage.aspx?MasterTagId=10";
                                     //ChangeTabs('../NewAPI/Process/process_landing.aspx', 654, 654, '../NewAPI/Process/process_landing.aspx');

                                 }
                                 
                                 //Added by Aditya J. on 23-02-2026 for showing Landing page as default page
                                 GlobalDisplayPageName = "../NewAPI/PM/LandingPage_New.aspx?MasterTagId=3";
                                 //End of Added by Aditya J. on 23-02-2026 for showing Landing page as default page
                                 document.getElementById("frmNewVersion").src = GlobalDisplayPageName;
                                 ChangeTabs(this, GlobalDisplayPageName, GlobalTagMaster, GlobalTemplateID, GlobalDisplayPageName);

                                 //  setTimeout(function () {
                                 $('#a_' + GlobalTemplateID + GlobalTagMaster).trigger('click');
                                 //}, 2000);
                             }
                         }
                     }

             <%--End of Added By Dipali V On 11th jan 2021 for check Module Access--%>

                 },
                 error: function (err) {
                     // console.log(err);
                     //alert(err.statusText);
                     // alert(err);
                     window.location.href = "../../Default.aspx?Message=SessionExpired";
                 }
             });
             //alert(CheckGlobalAcess);
             //console.log(CheckGlobalAcess);
             //Removed by Aditya J. - GIsSessionProjectChange must NOT be reset here.
             //PlotNavigationTree runs concurrently with SessionProject_Onchange's AJAX.
             //Resetting here kills the flag before the IsDefaultModule bypass can use it.
             //Flag is now reset inside SessionProject_Onchange's AJAX success callback only.
         }


         //Modified By Madhuri.K On 10-01-2026 - Enhanced search to search across all modules and their child pages, not just selected module
         //Modified By Madhuri.K On 27-01-2026 - Hide parent icons with no search results, show only those with matching content
         function SearchTags(e) {
             var searchTags = $("#searchTags").val().toLowerCase().trim();
             
             // Reset all search highlights
             $(".search").each(function (id, val) {
                 $(this).find(" > a").find(" > .searchText").html($(this).find(" > a").find(" > .searchText").attr("originalName"));
             });
             
             if (searchTags == "") {
                 // Show all parent icons/modules and treeview menus when search is cleared
                 $(".search").css("display", "");
                 // Remove all highlighting and selected state when search is cleared
                 //Added By Madhuri.K On 27-01-2026 - Remove selected and search-match-highlight when search is cleared
                 $(".parent-icon").show().removeClass("search-match-highlight selected active");
                 
                 // Clear inline styles when search is cleared
                 $(".parent-icon > a").each(function() {
                     this.style.removeProperty("background-color");
                     this.style.removeProperty("border-radius");
                     this.style.removeProperty("border");
                     this.style.removeProperty("box-shadow");
                     this.style.removeProperty("margin");
                 });
                 $(".parent-icon i img").each(function() {
                     this.style.removeProperty("filter");
                 });
                 
                 $(".treeview").removeClass("active");
                 // Show all treeview menus
                 $(".treeview-menu").show();
                 
                 //Modified By Madhuri.K On 28-01-2026 - Reset navigation tree when top search is cleared
                 // Show all tree items that were hidden by search
                 $(".treeview-menu li").show();
                 $(".treeview-menu").each(function() {
                     $(this).removeClass("active").css("max-height", "");
                 });
                 
                 // Remove all search marks from the navigation tree
                 $(".sidebar-menu mark").each(function() {
                     var $mark = $(this);
                     $mark.replaceWith($mark.text());
                 });
                 
                 return;
             }
             
             // Initialize/reset tracking which parent modules have matches (either in parent name or child pages)
             var matchingParentTagIDs = {};
             
             // First, search through all parent modules
             $(".search").each(function (id, val) {
                 $(".treeview").addClass("active");
                 var $searchItem = $(this);
                 var originalName = $searchItem.find(" > a").find(" > .searchText").attr("originalName");
                 
                 if (originalName && originalName.toLowerCase().indexOf(searchTags) > -1) {
                     // Parent module name matches
                     var startIndex = originalName.toLowerCase().indexOf(searchTags);
                     var endIndex = startIndex + searchTags.length;
                     var strToReplace = originalName.substring(startIndex, endIndex);
                     var strGenerated = originalName.replace(new RegExp(strToReplace.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'gi'), "<mark>" + strToReplace + "</mark>");
                     $searchItem.css("display", "");
                     $searchItem.parents().css("display", "");
                     $searchItem.find(" > a").find(" > .searchText:first-child").html(strGenerated);
                     
                     // Get parent TagID from the element
                     var parentTagID = $searchItem.attr("id");
                     if (parentTagID) {
                         parentTagID = parentTagID.replace("mainmenu_", "");
                         if (parentTagID) {
                             matchingParentTagIDs[parentTagID] = true;
                         }
                     }
                 }
                 else {
                     $searchItem.css("display", "none");
                 }
             });
             
             // Now search through all child pages across all modules using treeChildMenu data
             if (typeof treeChildMenu !== 'undefined' && treeChildMenu && treeChildMenu.length > 0) {
                 for (var i = 0; i < treeChildMenu.length; i++) {
                     var tagMaster = treeChildMenu[i];
                     var TagID = tagMaster.TagID;
                     var DisplayTagName = tagMaster.DisplayTagName;
                     var ParentTagId = tagMaster.ParentTagId;
                     var isParent = tagMaster.IsParent;
                     
                     // Skip parent modules (already searched above)
                     if (isParent == 1) {
                         continue;
                     }
                     
                     // Search in child page names
                     if (DisplayTagName && DisplayTagName.toLowerCase().indexOf(searchTags) > -1) {
                         // Child page matches - mark its parent module as matching
                         if (ParentTagId && ParentTagId > 0) {
                             matchingParentTagIDs[ParentTagId] = true;
                         }
                     }
                 }
             }
             
             // Hide all parent icons first and remove highlight from all
             $(".parent-icon").hide().removeClass("search-match-highlight selected active");
             $(".search.treeview").removeClass("search-match-highlight selected active");
             
             // Clear all inline styles first from both parent-icon and search.treeview elements
             $(".parent-icon > a, .search.treeview > a").each(function() {
                 this.style.removeProperty("background-color");
                 this.style.removeProperty("border-radius");
                 this.style.removeProperty("border");
                 this.style.removeProperty("box-shadow");
                 this.style.removeProperty("margin");
             });
             $(".parent-icon i img, .search.treeview i img").each(function() {
                 this.style.removeProperty("filter");
             });
             
             // Show only parent modules that have matches (either in parent name or child pages)
             for (var parentTagID in matchingParentTagIDs) {
                 if (matchingParentTagIDs.hasOwnProperty(parentTagID)) {
                     // Try to find by .parent-icon first (new style)
                     var $parentModule = $("#mainmenu_" + parentTagID);
                     
                     // If not found, look for .search.treeview (old style)
                     if ($parentModule.length === 0) {
                         $parentModule = $(".search.treeview[id='mainmenu_" + parentTagID + "']");
                     }
                     
                     if ($parentModule.length > 0) {
                         $parentModule.show(); // Show parent icon
                         $parentModule.css("display", "");
                         $parentModule.parents().css("display", "");
                         // Highlight/select the parent icon to show it has search matches
                         //Added By Madhuri.K On 27-01-2026 - Apply selected state immediately when search results found
                         //Modified By Madhuri.K On 28-01-2026 - Remove search-match-highlight class, use only selected state
                         $parentModule.addClass("selected");
                         
                         // Apply blue background styling immediately with setProperty for guaranteed application
                         var $parentLink = $parentModule.find("> a");
                         if ($parentLink.length > 0) {
                             // Use direct DOM element style.setProperty for guaranteed application with !important
                             var linkElement = $parentLink[0];
                             if (linkElement) {
                                 linkElement.style.setProperty("background-color", "#4263c1", "important");
                                 linkElement.style.setProperty("border-radius", "8px", "important");
                                 linkElement.style.setProperty("border", "2px solid #4263c1", "important");
                                 linkElement.style.setProperty("box-shadow", "0 2px 8px rgba(66, 99, 193, 0.4)", "important");
                                 linkElement.style.setProperty("margin", "2px", "important");
                             }
                             
                             // Apply white filter to icon image
                             var $iconImage = $parentLink.find("i img");
                             if ($iconImage.length > 0) {
                                 $iconImage[0].style.setProperty("filter", "brightness(0) saturate(100%) invert(100%)", "important");
                             }
                         }
                         
                         // Show the treeview menu for this parent
                         $parentModule.find(".treeview-menu").show();
                     }
                 }
             }
             
             // Hide treeview menus for modules that don't have matches
             $(".search").each(function() {
                 var $searchItem = $(this);
                 if ($searchItem.css("display") == "none") {
                     $searchItem.find(".treeview-menu").hide();
                 }
             });
         }

         //Modified By Madhuri.K On 16-01-2026 - Function to get image filename for Resources sub-modules
         //Modified By Madhuri.K On 20-01-2026 - Added image mapping for Manage Infrastructure
         function getResourcesSubModuleImage(moduleName) {
             if (!moduleName) return null;
             
             var imageMap = {
                 'Demand_Reports': 'Demand_Reports.png',
                 'Demand Reports': 'Demand_Reports.png',
                 'Leave': 'Leave.png',
                 'Manage': 'Manage.png',
                 'Manage Infrastructure': 'Manage_Infrastructure.png',
                 'Manage_Infrastructure': 'Manage_Infrastructure.png',
                 'manage infrastructure': 'Manage_Infrastructure.png',
                 'manage_infrastructure': 'Manage_Infrastructure.png',
                 'Plan': 'Plan.png',
                 'Qualification': 'Qualification.png',
                 'Reports': 'Reports.png',
                 'Resource_Demand_Management': 'Resource_Demand_Management.png',
                 'Resource Demand Management': 'Resource_Demand_Management.png',
                 'Resource_Pool': 'Resource_Pool.png',
                 'Resource Pool': 'Resource_Pool.png'
             };
             
             // Normalize module name - trim whitespace
             var normalizedName = moduleName.trim();
             
             // Try exact match first
             if (imageMap[normalizedName]) {
                 return imageMap[normalizedName];
             }
             
             // Try case-insensitive match
             for (var key in imageMap) {
                 if (key.toLowerCase() === normalizedName.toLowerCase()) {
                     return imageMap[key];
                 }
             }
             
             // Try matching by removing spaces and underscores
             var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
             for (var key in imageMap) {
                 var keyNormalized = key.replace(/\s+/g, '_').replace(/_+/g, '_');
                 if (keyNormalized.toLowerCase() === nameWithoutSpaces.toLowerCase()) {
                     return imageMap[key];
                 }
             }
             
            return null;
        }
        
        //Modified By Madhuri.K On 16-01-2026 - Function to get image filename for Configuration sub-modules
        function getConfigurationSubModuleImage(moduleName) {
            if (!moduleName) return null;
            
            // Normalize module name - trim whitespace
            var normalizedName = moduleName.trim();
            
            // Special cases for specific sub-modules with custom image names
            //Modified By Madhuri.K On 20-01-2026 - Added image mappings for Customer, Change Management, Custom Field Setting, Issue Management
            var specialCases = {
                'IR Masters': 'IR_Master.png',
                'IR_Masters': 'IR_Master.png',
                'ir masters': 'IR_Master.png',
                'IRMaster': 'IR_Master.png',
                'Group & Access': 'Group&acces.png',
                'Group &amp; Access': 'Group&acces.png',
                'Group_Access': 'Group&acces.png',
                'group & access': 'Group&acces.png',
                'Customer': 'Customer.png',
                'customer': 'Customer.png',
                'CUSTOMER': 'Customer.png',
                'Change Management': 'Change_Management.png',
                'Change_Management': 'Change_Management.png',
                'change management': 'Change_Management.png',
                'change_management': 'Change_Management.png',
                'Custom Field Setting': 'Custom_Field_Setting.png',
                'Custom_Field_Setting': 'Custom_Field_Setting.png',
                'custom field setting': 'Custom_Field_Setting.png',
                'custom_field_setting': 'Custom_Field_Setting.png',
                'Issue Management': 'Issue_Management.png',
                'Issue_Management': 'Issue_Management.png',
                'issue management': 'Issue_Management.png',
                'issue_management': 'Issue_Management.png',

            };
            
            // Check for special cases first (case-insensitive)
            for (var key in specialCases) {
                if (key.toLowerCase() === normalizedName.toLowerCase()) {
                    return specialCases[key];
                }
            }
            
            // Exclude sub-modules that are handled by other modules (to prevent duplicate icons)
            // Reports is handled by Resources module, so don't auto-convert it here
            // MIS-specific sub-modules are handled by MIS module, so don't auto-convert them here
            // MIS (as a sub-node) can be in Dashboard or MIS module, so don't auto-convert it here
            // Knowledge sub-modules (Navigation, Navigation Tree) are handled by Knowledge module, so don't auto-convert them here
            var excludedModules = ['Reports', 'reports', 'REPORTS', 
                                   'MIS', 'mis', 'MIS',
                                   'Analytics', 'analytics', 'ANALYTICS',
                                   'Cuatom_reports', 'Cuatom Reports', 'Custom_reports', 'Custom Reports',
                                   'Product_Reports', 'Product Reports',
                                   'Project_Cost_Reports', 'Project Cost Reports',
                                   'Resource_Timesheet_Reports', 'Resource Timesheet Reports',
                                   'Stakeholder_Reports', 'Stakeholder Reports',
                                   // Joining/Separation MIS are MIS-specific, so Configuration should not auto-convert them
                                   'Joining MIS', 'Joining_MIS', 'joining mis', 'joining_mis',
                                   'Separation MIS', 'Separation_MIS', 'separation mis', 'separation_mis',
                                   'Navigation', 'navigation', 'NAVIGATION',
                                   'Navigation Tree', 'Navigation_Tree', 'navigation tree', 'navigation_tree'];
            for (var i = 0; i < excludedModules.length; i++) {
                if (normalizedName.toLowerCase() === excludedModules[i].toLowerCase()) {
                    return null;
                }
            }
            
            // Also check if normalized name (with spaces/underscores normalized) matches MIS sub-modules
            var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
            var misSubModules = ['MIS', 'Analytics', 'Cuatom_reports', 'Product_Reports', 'Project_Cost_Reports', 
                                 'Resource_Timesheet_Reports', 'Stakeholder_Reports',
                                 // Treat Joining/Separation MIS as MIS sub-modules so Configuration won't claim them
                                 'Joining_MIS', 'Separation_MIS'];
            for (var j = 0; j < misSubModules.length; j++) {
                if (nameWithoutSpaces.toLowerCase() === misSubModules[j].toLowerCase()) {
                    return null; // Don't auto-convert MIS sub-modules
                }
            }
            
            // Convert sub-node name to image filename format
            // Replace spaces with underscores, handle special characters
            var imageFileName = normalizedName
                .replace(/\s+/g, '_')           // Replace spaces with underscores
                .replace(/[^a-zA-Z0-9_]/g, '')  // Remove special characters except underscores
                .replace(/_+/g, '_')            // Replace multiple underscores with single underscore
                .replace(/^_|_$/g, '');         // Remove leading/trailing underscores
            
            // Return filename with .png extension
            if (imageFileName && imageFileName.length > 0) {
                return imageFileName + '.png';
            }
            
            return null;
        }
        
        //Modified By Madhuri.K On 16-01-2026 - Function to get image filename for Dashboard sub-modules
        function getDashboardSubModuleImage(moduleName) {
            if (moduleName == null || moduleName === undefined) return null;
            
            // Normalize module name - trim whitespace
            var normalizedName = safeNavLabel(moduleName).trim();
            
            // Image mapping for Dashboard sub-modules
            var imageMap = {
                'Help Desk': 'Help Desk.png',
                'help desk': 'Help Desk.png',
                'HELP DESK': 'Help Desk.png',
                'Help_Desk': 'Help Desk.png',
                'help_desk': 'Help Desk.png',
                'HelpDesk': 'Help Desk.png',
                'helpdesk': 'Help Desk.png',
                'Invoice': 'Invoice.png',
                'invoice': 'Invoice.png',
                'INVOICE': 'Invoice.png',
                'Management': 'Management.png',
                'management': 'Management.png',
                'MANAGEMENT': 'Management.png',
                'Project': 'Project.png',
                'project': 'Project.png',
                'PROJECT': 'Project.png',
                'Resources': 'Resources.png',
                'resources': 'Resources.png',
                'RESOURCES': 'Resources.png'
            };
            
            // Try exact match first
            if (imageMap[normalizedName]) {
                return imageMap[normalizedName];
            }
            
            // Try case-insensitive match
            for (var key in imageMap) {
                if (key.toLowerCase() === normalizedName.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // Try matching by removing spaces and underscores
            var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
            for (var key in imageMap) {
                var keyNormalized = key.replace(/\s+/g, '_').replace(/_+/g, '_');
                if (keyNormalized.toLowerCase() === nameWithoutSpaces.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // Fallback: Auto-convert any Dashboard sub-module name to image filename format
            // This ensures all Dashboard sub-modules get Dashboard images, not MIS or other modules
            var imageFileName = normalizedName
                .replace(/\s+/g, '_')           // Replace spaces with underscores
                .replace(/[^a-zA-Z0-9_]/g, '')  // Remove special characters except underscores
                .replace(/_+/g, '_')            // Replace multiple underscores with single underscore
                .replace(/^_|_$/g, '');         // Remove leading/trailing underscores
            
            // Return filename with .png extension - Dashboard gets priority with auto-conversion
            if (imageFileName && imageFileName.length > 0) {
                return imageFileName + '.png';
            }
            
            return null;
        }
        
        //Modified By Madhuri.K On 16-01-2026 - Function to convert hex color to CSS filter (simplified approach)
        function getColorFilter(hexColor) {
            if (!hexColor) return 'none';
            
            // Predefined filter values for each color (more reliable than calculation)
            var filterMap = {
                '#4263c1': 'brightness(0) saturate(100%) invert(27%) sepia(98%) saturate(2000%) hue-rotate(220deg) brightness(0.9)', // Blue
                '#28a745': 'brightness(0) saturate(100%) invert(60%) sepia(98%) saturate(2000%) hue-rotate(90deg) brightness(0.9)', // Green
                '#17a2b8': 'brightness(0) saturate(100%) invert(60%) sepia(98%) saturate(2000%) hue-rotate(170deg) brightness(0.9)', // Cyan/Teal
                '#ffc107': 'brightness(0) saturate(100%) invert(85%) sepia(98%) saturate(2000%) hue-rotate(0deg) brightness(1.1)', // Yellow/Amber
                '#dc3545': 'brightness(0) saturate(100%) invert(30%) sepia(98%) saturate(2000%) hue-rotate(340deg) brightness(0.9)', // Red
                '#6f42c1': 'brightness(0) saturate(100%) invert(40%) sepia(98%) saturate(2000%) hue-rotate(250deg) brightness(0.9)', // Purple
                '#fd7e14': 'brightness(0) saturate(100%) invert(60%) sepia(98%) saturate(2000%) hue-rotate(15deg) brightness(1.0)', // Orange
                '#20c997': 'brightness(0) saturate(100%) invert(70%) sepia(98%) saturate(2000%) hue-rotate(150deg) brightness(0.9)', // Teal
                '#e83e8c': 'brightness(0) saturate(100%) invert(50%) sepia(98%) saturate(2000%) hue-rotate(300deg) brightness(0.9)' // Pink
            };
            
            // Return predefined filter if available
            if (filterMap[hexColor.toLowerCase()]) {
                return filterMap[hexColor.toLowerCase()];
            }
            
            // Fallback: try to match by removing case sensitivity
            for (var key in filterMap) {
                if (key.toLowerCase() === hexColor.toLowerCase()) {
                    return filterMap[key];
                }
            }
            
            return 'none';
        }
        
        // Added By Madhuri.K 17-08-2026 - Analytics parent/module icon under Navigation_Tree_Icons/MIS
        var ANALYTICS_MODULE_IMAGE = 'Navigation_Tree_Icons/MIS/Analytics.png';

        function resolveNavigationModuleImage(displayTagName, imageFromApi) {
            var name = (displayTagName || '').toString().trim().toLowerCase();
            if (name === 'analytics') {
                return ANALYTICS_MODULE_IMAGE;
            }
            return imageFromApi;
        }
        
        //Modified By Madhuri.K On 16-01-2026 - Function to get image filename for MIS sub-modules
        function getMISSubModuleImage(moduleName) {
            if (!moduleName) return null;
            
            // Normalize module name - trim whitespace
            var normalizedName = moduleName.trim();
            
            // Specific image mappings for MIS sub-modules
            var imageMap = {
                'Analytics': 'Analytics.png',
                'Cuatom_reports': 'Cuatom_reports.png',
                'Cuatom Reports': 'Cuatom_reports.png',
                'Custom_reports': 'Cuatom_reports.png',
                'Custom Reports': 'Cuatom_reports.png',
                'Product_Reports': 'Product_Reports.png',
                'Product Reports': 'Product_Reports.png',
                'Project_Cost_Reports': 'Project_Cost_Reports.png',
                'Project Cost Reports': 'Project_Cost_Reports.png',
                'Resource_Timesheet_Reports': 'Resource_Timesheet_Reports.png',
                'Resource Timesheet Reports': 'Resource_Timesheet_Reports.png',
                'Stakeholder_Reports': 'Stakeholder_Reports.png',
                'Stakeholder Reports': 'Stakeholder_Reports.png',
                // Added By Madhuri.K On 20-01-2026 - Images for Joining MIS and Separation MIS under MIS -> Analytics
                'Joining_MIS': 'Joining_MIS.png',
                'Joining MIS': 'Joining_MIS.png',
                'Separation_MIS': 'Separation_MIS.png',
                'Separation MIS': 'Separation_MIS.png'
            };
            
            // Try exact match first
            if (imageMap[normalizedName]) {
                return imageMap[normalizedName];
            }
            
            // Try case-insensitive match
            for (var key in imageMap) {
                if (key.toLowerCase() === normalizedName.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // Try matching by removing spaces and underscores
            var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
            for (var key in imageMap) {
                var keyNormalized = key.replace(/\s+/g, '_').replace(/_+/g, '_');
                if (keyNormalized.toLowerCase() === nameWithoutSpaces.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // If no match found, convert sub-node name to image filename format as fallback
            var imageFileName = normalizedName
                .replace(/\s+/g, '_')           // Replace spaces with underscores
                .replace(/[^a-zA-Z0-9_]/g, '')  // Remove special characters except underscores
                .replace(/_+/g, '_')            // Replace multiple underscores with single underscore
                .replace(/^_|_$/g, '');         // Remove leading/trailing underscores
            
            // Return filename with .png extension
            if (imageFileName && imageFileName.length > 0) {
                return imageFileName + '.png';
            }
            
            return null;
        }
        
     //Modified By Madhuri.K On 20-01-2026 - Show Navigation_Tree.png for all Knowledge sub-modules, removed Navigation.png option
        function getKnowledgeSubModuleImage(moduleName) {
            if (!moduleName) return null;
            
            // Normalize module name - trim whitespace
            var normalizedName = moduleName.trim();
            
            // Image mapping for Knowledge sub-modules - ALL Knowledge sub-modules use Navigation_Tree.png
            var imageMap = {
                'Article': 'Navigation_Tree.png',
                'article': 'Navigation_Tree.png',
                'ARTICLE': 'Navigation_Tree.png',
                'Categories': 'Navigation_Tree.png',
                'categories': 'Navigation_Tree.png',
                'CATEGORIES': 'Navigation_Tree.png',
                'Knowledge_Management': 'Navigation_Tree.png',
                'Knowledge Management': 'Navigation_Tree.png',
                'knowledge_management': 'Navigation_Tree.png',
                'Navigation': 'Navigation_Tree.png',
                'navigation': 'Navigation_Tree.png',
                'NAVIGATION': 'Navigation_Tree.png',
                'Navigation_Tree': 'Navigation_Tree.png',
                'Navigation Tree': 'Navigation_Tree.png',
                'navigation_tree': 'Navigation_Tree.png',
                'navigation tree': 'Navigation_Tree.png',
                'Related_Topics': 'Navigation_Tree.png',
                'Related Topics': 'Navigation_Tree.png',
                'related_topics': 'Navigation_Tree.png'
            };
            
            // Try exact match first
            if (imageMap[normalizedName]) {
                return imageMap[normalizedName];
            }
            
            // Try case-insensitive match
            for (var key in imageMap) {
                if (key.toLowerCase() === normalizedName.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // Try matching by removing spaces and underscores
            var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
            for (var key in imageMap) {
                var keyNormalized = key.replace(/\s+/g, '_').replace(/_+/g, '_');
                if (keyNormalized.toLowerCase() === nameWithoutSpaces.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // No fallback auto-conversion - only return image if it's a specific Knowledge sub-module with explicit mapping
            // This prevents Configuration and other modules from being incorrectly matched as Knowledge modules
            return null;
        }
        
        //Modified By Madhuri.K On 16-01-2026 - Function to get image filename for Help Desk sub-modules
        function getHelpDeskSubModuleImage(moduleName) {
            if (!moduleName) return null;
            
            // Normalize module name - trim whitespace
            var normalizedName = moduleName.trim();
            
            // Image mapping for Help Desk sub-modules
            var imageMap = {
                'Configuration': 'Configuration.png',
                'configuration': 'Configuration.png',
                'CONFIGURATION': 'Configuration.png',
                'Dashboard': 'Dashboard.png',
                'dashboard': 'Dashboard.png',
                'DASHBOARD': 'Dashboard.png'
            };
            
            // Try exact match first
            if (imageMap[normalizedName]) {
                return imageMap[normalizedName];
            }
            
            // Try case-insensitive match
            for (var key in imageMap) {
                if (key.toLowerCase() === normalizedName.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            return null;
        }
        
        //Modified By Madhuri.K On 16-01-2026 - Function to get image filename for Process sub-modules
        function getProcessSubModuleImage(moduleName) {
             if (!moduleName) return null;
             
             var imageMap = {
                 'Checklist': 'Checklist.png',
                 'Checklists': 'Checklist.png',
                 'checklist': 'Checklist.png',
                 'Deliverable_Execution_Templates': 'Deliverable_Execution_Templates.png',
                 'Deliverable Execution Templates': 'Deliverable_Execution_Templates.png',
                 'Documentation': 'Documentation.png',
                 'Implementation': 'Implementation.png',
                 'Measurement': 'Measurement.png',
                 'Metric': 'Metric.png',
                 'Planning': 'Planning.png',
                 'Process_Settings': 'Process_Settings.png',
                 'Process Settings': 'Process_Settings.png',
                 'Workflow': 'Workflow.png'
             };
             
             // Normalize module name - trim whitespace
             var normalizedName = moduleName.trim();
             
             // Try exact match first
             if (imageMap[normalizedName]) {
                 return imageMap[normalizedName];
             }
             
             // Try case-insensitive match
             for (var key in imageMap) {
                 if (key.toLowerCase() === normalizedName.toLowerCase()) {
                     return imageMap[key];
                 }
             }
             
             // Try matching by removing spaces and underscores
             var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
             for (var key in imageMap) {
                 var keyNormalized = key.replace(/\s+/g, '_').replace(/_+/g, '_');
                 if (keyNormalized.toLowerCase() === nameWithoutSpaces.toLowerCase()) {
                     return imageMap[key];
                 }
             }
             
             // Special handling for Checklist - check if name contains "checklist" (case-insensitive)
             if (normalizedName.toLowerCase().indexOf('checklist') >= 0) {
                 return 'Checklist.png';
             }
             
             return null;
         }
         
        //Added By Madhuri.K On 20-01-2026 - Function to get image filename for Projects sub-modules
        function getProjectSubModuleImage(moduleName) {
            if (!moduleName) return null;
            
            // Normalize module name - trim whitespace
            var normalizedName = moduleName.trim();
            
            // Image mapping for Projects sub-modules
            var imageMap = {
                'Execute': 'Execute.png',
                'execute': 'Execute.png',
                'EXECUTE': 'Execute.png',
                // Execute -> Tasks
                'Tasks': 'Tasks_Reports.png',
                'tasks': 'Tasks_Reports.png',
                'TASKS': 'Tasks_Reports.png',
                'Tasks_Reports': 'Tasks_Reports.png',
                'Tasks Reports': 'Tasks_Reports.png',
                'tasks_reports': 'Tasks_Reports.png',
                'Initiate': 'Initiate.png',
                'initiate': 'Initiate.png',
                'INITIATE': 'Initiate.png',
                'Issue_Integration': 'Issue_Integration.png',
                'Issue Integration': 'Issue_Integration.png',
                'issue_integration': 'Issue_Integration.png',
                'Monitor & Control': 'Monitor&Control.png',
                'Monitor_Control': 'Monitor&Control.png',
                'monitor & control': 'Monitor&Control.png',
                'monitor_control': 'Monitor&Control.png',
                'Monitor&Control': 'Monitor&Control.png',
                // Monitor & Control sub-modules
                'Project_Profitability': 'Project_Profitability.png',
                'Project Profitability': 'Project_Profitability.png',
                'project_profitability': 'Project_Profitability.png',
                'Deliverable_Reports': 'Deliverable_Reports.png',
                'Deliverable Reports': 'Deliverable_Reports.png',
                'deliverable_reports': 'Deliverable_Reports.png',
                'Tasks_Reports': 'Tasks_Reports.png',
                'Tasks Reports': 'Tasks_Reports.png',
                'tasks_reports': 'Tasks_Reports.png',
                'Measurement_Reports': 'Measurement_Reports.png',
                'Measurement Reports': 'Measurement_Reports.png',
                'measurement_reports': 'Measurement_Reports.png',
                'Project_Reports': 'Project_Reports.png',
                'Project Reports': 'Project_Reports.png',
                'project_reports': 'Project_Reports.png',
                'Project_Metrics': 'Project_Metrics.png',
                'Project Metrics': 'Project_Metrics.png',
                'project_metrics': 'Project_Metrics.png',
                // Project Metrics view should use same image as Project Metrics
                'Project_Metrics_view': 'Project_Metrics.png',
                'Project Metrics view': 'Project_Metrics.png',
                'project_metrics_view': 'Project_Metrics.png',
                'Project_Process': 'Project_Process.png',
                'Project Process': 'Project_Process.png',
                'project_process': 'Project_Process.png',
                'Project_Closure': 'Project_Closure.png',
                'Project Closure': 'Project_Closure.png',
                'project_closure': 'Project_Closure.png',
                'Project_Close': 'Project_Closure.png',
                'Project Close': 'Project_Closure.png',
                // Bulk Extension sub-module icon (SVG)
                'Bulk Extension': 'bulk_extension.svg',
                'bulk extension': 'bulk_extension.svg',
                'Bulk_Extension': 'bulk_extension.svg',
                'bulk_extension': 'bulk_extension.svg'
            };
            
            // Try exact match first
            if (imageMap[normalizedName]) {
                return imageMap[normalizedName];
            }
            
            // Try case-insensitive match
            for (var key in imageMap) {
                if (key.toLowerCase() === normalizedName.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            // Try matching by removing spaces and underscores
            var nameWithoutSpaces = normalizedName.replace(/\s+/g, '_').replace(/_+/g, '_');
            for (var key in imageMap) {
                var keyNormalized = key.replace(/\s+/g, '_').replace(/_+/g, '_');
                if (keyNormalized.toLowerCase() === nameWithoutSpaces.toLowerCase()) {
                    return imageMap[key];
                }
            }
            
            return null;
        }
         
         function getChildTags(parentTagId) {
             var strHTML = "";
             //Added By Madhuri.K On 16-01-2026 - Define Dashboard landing page at function scope
             var DashboardLandingPage = '../NewAPI/Dashboard/DashboardLandingPage.aspx';
             //End Added By Madhuri.K On 16-01-2026
             //Added By Madhuri.K On 27-01-2026 - Define Knowledge landing page at function scope
             var KnowledgeLandingPage = '../KM/KM_Home.aspx';
             //End Added By Madhuri.K On 27-01-2026
             //Modified By Madhuri.K On 16-01-2026 - Resources module TagID (TagID variable from outer scope contains the parent module TagID)
             // When Resources module is active, TagID will be the Resources module TagID
             if (parentTagId == 0) {
                 //strHTML = "<ul>"
                //Modified By Madhuri.K On 07-07-2026  - Removed search from parent panel header, keeping only refresh icon
                strHTML += "<li class='freezeLi'>"
                //added By Nikhil A on 18-Jan-2021 to refresh navigation tree
                strHTML += "<a class='nv_ref' href='#' onclick=PlotNavigationTree()><i class='fas fa-sync-alt' style='font-size:14px' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' data-original-title='Refresh Tree'></i></a>"
                //End of Added BY Nikhil A
                strHTML += "</li>"
             }
             else {
                 strHTML = "<ul class='treeview-menu' role='menu'>"
             }


             var FirstTags = 0;
             var flag = 0;
             //Added By Usha Pandit On 19.01.2021 For redirecting to default access module
            // var GlobalDefaultModule = 0;
            // var GlobalDisplayPageName = "";
            // var GlobalDisplayHeader = "";
             
             var GlobalTemplateID =""
             //End Of Added By Usha Pandit On 19.01.2021 For redirecting to default access module
             for (var i = 0; i < treeChildMenu.length; i++) {
                 var tagMaster = treeChildMenu[i];
                 var TagID = tagMaster.TagID;
                 var TemplateID = tagMaster.TemplateID;
                 var DisplayPageName = tagMaster.DisplayPageName;
                 var DisplayTagName = tagMaster.DisplayTagName;
                 var ParentTagId = tagMaster.ParentTagId;
                 var isParent = tagMaster.IsParent;
                 var Image = tagMaster.Image;
                 var IsDefaultPage = tagMaster.IsDefaultPage;
                 var DisplayHeader = tagMaster.DisplayHeader;
                 var AllowResponsive = tagMaster.AllowResponsive;
                 var ResponsivePageName = tagMaster.ResponsivePageName;
                 var TimesheetLandingPage = '../NewAPI/Timesheet/TMS_LandingPage.aspx';
                 //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                 var HelpDeskLandingPage = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx';
                 //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                 //Added by Madhuri.K on 27-01-2026 for Process support landing page.
                 var ProcessLandingPage = '../NewAPI/Process/process_landing.aspx';
                 //End of Added by Madhuri.K on 27-01-2026 for Process support landing page.
                 //Added by Madhuri.K on 27-01-2026 for Knowledge support landing page.
                 var KnowledgeLandingPage = '../KM/KM_Home.aspx';
                 //End of Added by Madhuri.K on 27-01-2026 for Knowledge support landing page.
                 var IsLandingPage = tagMaster.IsLandingPage;
                 var IsDefaultModule = tagMaster.IsDefaultModule
                 //GlobalsDefaultModule = IsDefaultModule;
                 //alert(GlobalsDefaultModule);
                 //debugger;
                 if (TagID == 10)
                     IsTimesheetPresent = 1;
                 //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                 if (TagID == 405)
                     IsHelpdeskSupportPresent = 1;
                 //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                 if (isParent == 1)
                     FirstTags = FirstTags + 1;

                 if (FirstTags <= 5)
                     flag = 1;
                 else
                     flag = 2;

                 //----------------Added By Nikhil A-------------------
                 if (DisplayPageName != "") {
                     if (DisplayPageName.toLowerCase().indexOf("mastertagid") == -1) {
                         if (DisplayPageName.toLowerCase().indexOf("?") == -1)
                             DisplayPageName = DisplayPageName + "?MasterTagId=" + TagID;
                         else
                             DisplayPageName = DisplayPageName + "&MasterTagId=" + TagID;
                     }
                 }
                 //----------------End Of Aded By Nikhil A------------------



                 if ('<%=Session("LoginType")%>' == 'E') {
                     if ("<%= Request.QueryString("FromOld")%>" == "10" && TagID == 10) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                     else if ("<%= Request.QueryString("FromOld")%>" == "405" && TagID == 405) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                     else if ("<%= Request.QueryString("FromOld")%>" == "21000" && TagID == 21000) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     else if ("<%= Request.QueryString("FromOld")%>" == "21006" && TagID == 21006) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     else if ("<%= Request.QueryString("FromOld")%>" == "405" && TagID == 405) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     else if ("<%= Request.QueryString("FromOld")%>" == "5" && TagID == 5) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     else if ("<%= Request.QueryString("FromOld")%>" == "22599" && TagID == 22599) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     //Commented By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
                     else if ("<%= Request.QueryString("FromOld")%>" == "1258" && TagID == 1263) {
                         //document.getElementById("mainHeadingTop").innerHTML = "";
                         document.getElementById("mainHeadingTop").innerHTML = 'Projects > Manage Projects';
                         document.getElementById("frmNewVersion").src = '../NewAPI/PM/PM_CreateProject.aspx?FromWhereProjectId=' + '<%= Request.QueryString("FromWhereProjectId")%>' + '&FromWhereData=' + '<%= Request.QueryString("FromWhereData")%>' + '&PKToken=' + '<%= Request.QueryString("PKToken")%>' + '&Mode=Edit';
                     }
                     else if ("<%= Request.QueryString("FromOld")%>" == "3936") {
                         //alert();
                         // document.getElementById("mainHeadingTop").innerHTML = "";
                         document.getElementById("mainHeadingTop").innerHTML = 'Projects > Workflow Approvals';
                         document.getElementById("frmNewVersion").src = '../DM/DM_WorkFlowApprovals.aspx?FromWhere=PM&MasterTagID=3936';

                          // ChangeTabs(this, '../DM/DM_WorkFlowApprovals.aspx?MasterTagId=3936', 3936, 'PM', '');
                         ChangeTabs('../DM/DM_WorkFlowApprovals.aspx?MasterTagId=3936', 3936, 3936,'DM','');
                               
                     }
                          //End of Added By Dipali V On 1st Feb 2021 For Session Project Issues
				   
                     else {
                        /// alert('1');
                        // alert(IsDefaultPage);
                         if ((IsDefaultModule == 1) && ("<%= Request.QueryString("FromOld")%>" != "1258") ) {
                            //alert(1);
                             document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                             document.getElementById("frmNewVersion").src = DisplayPageName;
                         }
                     }
                 }
                 else if ('<%=Session("LoginType")%>' == 'C') {
                     if (TagID == 405) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     //Added By Dipali V On 1st April 2021 For If click on project by customer login should redirected
                     else if ("<%= Request.QueryString("FromOld")%>" == "1258") {
                         document.getElementById("mainHeadingTop").innerHTML = 'Projects > Manage Projects';
                         document.getElementById("frmNewVersion").src = '../NewAPI/PM/PM_CreateProject.aspx?FromWhereProjectId=' + '<%= Request.QueryString("FromWhereProjectId")%>' + '&FromWhereData=' + '<%= Request.QueryString("FromWhereData")%>' + '&PKToken=' + '<%= Request.QueryString("PKToken")%>' + '&Mode=Edit';
                     }
                     else if ("<%= Request.QueryString("FromOld")%>" == "10" && TagID == 10) {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;
                     }
                     //End of Added By Dipali V On 1st April 2021 For If click on project by customer login should redirected
                 }
                 if (IsDefaultModule == 1) {
                     //console.log(DisplayPageName);

                     if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                         document.getElementById("mainHeadingTop").innerHTML = DisplayHeader;
                         document.getElementById("frmNewVersion").src = DisplayPageName;

                         //Added By Usha Pandit On 19.01.2021 For redirecting to default access module
                         //GlobalDefaultModule = tagMaster.IsDefaultModule;
                         //GlobalDisplayPageName = DisplayPageName;
                         //GlobalDisplayHeader = DisplayHeader;
                         ////Added By Dipali V On 12th Feb 2021 
                         //GlobalTagMaster = tagMaster.TagID;
                         //GlobalTemplateID = tagMaster.TemplateID;
                         //console.log("IsDefaultModule " + IsDefaultModule)
                         //console.log("GlobalDisplayPageName " + GlobalDisplayPageName)
                         //console.log("DisplayHeader " + DisplayHeader)
                         //console.log("GlobalTagMaster " + TagID)

                     } else {
                         document.getElementById("mainHeadingTop").innerHTML = 'Projects > Manage Projects';
                     }
                     //End Of Added By Usha Pandit On 19.01.2021 For redirecting to default access module
                 }
                if (ParentTagId == parentTagId) {
                    //Added By Madhuri.K On 09-01-2026 For Parent Panel Icons Only
                    if (parentTagId == 0) {
                        if (isParent == 1) {
                            // Check if parent is also a landing page
                            var pageUrl = DisplayPageName;
                            var isLandingPageNode = false;
                            //Modified By Madhuri.K On 16-01-2026 - Always check Dashboard first, then check IsLandingPage for others
                            if (TagID == 21000) {
                                // Dipali V - Dashboard opens child panel (Project IsParent=1 under legacy ParentTagId 9999)
                                pageUrl = DisplayPageName;
                                isLandingPageNode = false;
                            } else if (IsLandingPage == 1) {
                                isLandingPageNode = true;
                                if (TagID == 10) {
                                    pageUrl = TimesheetLandingPage + "?TagID=" + TagID;
                                } else if (TagID == 405) {
                                    //Modified By Madhuri.K On 27-01-2026 - For Helpdesk, show child panel first instead of landing page directly
                                    isLandingPageNode = false;
                                } else if (TagID == 654) {
                                    //Modified By Madhuri.K On 27-01-2026 - For Processes, navigate to landing page
                                    pageUrl = ProcessLandingPage + "?MasterTagId=" + TagID;
                                    isLandingPageNode = true;
                                } else {
                                    //Modified By Madhuri.K On 27-01-2026 - For other modules like Knowledge with IsLandingPage=1, use DisplayPageName as landing page
                                    pageUrl = DisplayPageName;
                                    isLandingPageNode = true;
                                }
                            }
                            
                            if (isLandingPageNode) {
                                // Parent panel - landing page, navigate directly
                                //Added By Madhuri.K On 09-01-2026 - Ensure DisplayHeader is not undefined
                                var headerValueForParent = DisplayHeader;
                                if (!headerValueForParent || headerValueForParent == "" || headerValueForParent == "undefined") {
                                    headerValueForParent = DisplayTagName || "";
                                }
                                //Modified By Madhuri.K On 10-01-2026 - Added selection state handling for parent icons
                                strHTML += '<li class="search parent-icon" id="mainmenu_' + TagID + '">' + 
                                    "<input type='hidden' id='header_" + TagID + "' value='" + headerValueForParent + "'>" + 
                                    // Modified By Madhuri.K On 07-07-2026 
                                    '<a id="a_' + TemplateID + TagID + '" onclick="setParentModuleSelected(' + TagID + '); ChangeTabs(this,\'' + encodeURI(pageUrl) + '\',' + TagID + ',\'' + TemplateID + '\',\'' + ResponsivePageName + '\')" style="cursor:pointer;"><i class="fa" title="' + DisplayTagName + '"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="20px"></i> <span class="searchText" originalName="' + DisplayTagName + '">' + DisplayTagName + '</span></a></li>'
                                //End Added By Madhuri.K On 09-01-2026
                            } else {
                                // Parent panel - show only icon with click handler to show child panel
                                //Modified By Madhuri.K On 27-01-2026 - For Dashboard parent icon, navigate to landing page instead of showing child panel
                                var parentClickHandler = '';
                                if (TagID == 21000) {
                                    // Dipali V - Show child panel then landing page (legacy 9999 merge in showChildPanel)
                                    parentClickHandler = 'setParentModuleSelected(' + TagID + '); showChildPanel(' + TagID + ', false); ChangeTabs(this,\'' + encodeURI(DisplayPageName) + '\',' + TagID + ',\'' + TemplateID + '\',\'' + ResponsivePageName + '\')';
                                } else {
                                    // Other parent icons - show child panel and select parent module
                                    // Modified By Madhuri.K On 29-01-2026 - Added setParentModuleSelected call to ensure Help desk parent icon gets selected when child panel opens
                                    parentClickHandler = 'setParentModuleSelected(' + TagID + '); var searchText = $(\'#childPanelSearch\').val(); var hasSearch = searchText && searchText.trim() != \'\'; showChildPanel(' + TagID + ', true); if (hasSearch) { setTimeout(function() { var currentSearch = $(\'#childPanelSearch\').val(); if (currentSearch && currentSearch.trim() != \'\') { performSearchChildPanel(); } }, 2); }';
                                }
                                strHTML += '<li class="treeview search parent-icon" id="mainmenu_' + TagID + '" data-tagid="' + TagID + '">' + 
                                    "<input type='hidden' id='header_" + TagID + "' value='" + DisplayTagName + "'>" + 
                                    // Modified By Madhuri.K On 07-07-2026 
                                    '<a onclick="' + parentClickHandler + '" style="cursor:pointer;"><i class="fa" title="' + DisplayTagName + '"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="20px"></i> <span class="searchText" originalName="' + DisplayTagName + '">' + DisplayTagName + '</span></a></li>'
                            }
                        } else {
                            //Added By Madhuri.K On 09-01-2026 - Ensure DisplayHeader is not undefined
                            var headerValueForNonParent = DisplayHeader;
                            if (!headerValueForNonParent || headerValueForNonParent == "" || headerValueForNonParent == "undefined") {
                                headerValueForNonParent = DisplayTagName || "";
                            }
                            //Modified By Madhuri.K On 16-01-2026 - Check for Dashboard landing page for non-parent nodes
                            var pageUrlForNonParent = DisplayPageName;
                            if (TagID == 21000) {
                                //Added By Madhuri.K On 16-01-2026 - Dashboard always shows landing page (use DisplayPageName from API)
                                // No need to override - DisplayPageName already contains the landing page from API response
                                pageUrlForNonParent = DisplayPageName;
                            } else if (IsLandingPage == 1) {
                                if (TagID == 10) {
                                    pageUrlForNonParent = TimesheetLandingPage + "?TagID=" + TagID;
                                } else if (TagID == 405) {
                                    pageUrlForNonParent = HelpDeskLandingPage + "?TagID=" + TagID;
                                } else if (TagID == 654) {
                                    //Modified By Madhuri.K On 27-01-2026 - For Processes, navigate to landing page
                                    pageUrlForNonParent = ProcessLandingPage + "?MasterTagId=" + TagID;
                                } else {
                                    //Modified By Madhuri.K On 27-01-2026 - For other modules like Knowledge with IsLandingPage=1, use DisplayPageName as landing page
                                    pageUrlForNonParent = DisplayPageName;
                                }
                            }
                            //Modified By Madhuri.K On 10-01-2026 - Added selection state handling for parent icons
                            strHTML += '<li class="search parent-icon" id="mainmenu_' + TagID + '">' + 
                                "<input type='hidden' id='header_" + TagID + "' value='" + headerValueForNonParent + "'>" + 
                                // Modified By Madhuri.K On 07-07-2026 
                                '<a id="a_' + TemplateID + TagID + '" onclick="setParentModuleSelected(' + TagID + '); ChangeTabs(this,\'' + encodeURI(pageUrlForNonParent) + '\',' + TagID + ',\'' + TemplateID + '\',\'' + ResponsivePageName + '\')" style="cursor:pointer;"><i class="fa" title="' + DisplayTagName + '"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="20px"></i> <span class="searchText" originalName="' + DisplayTagName + '">' + DisplayTagName + '</span></a></li>'
                            //End Added By Madhuri.K On 09-01-2026
                        }
                    }
                    else {
                        //End Added By Madhuri.K On 09-01-2026
                        if (isParent == 1) {
                            strHTML += "<li class='treeview'>"
                        }
                        else {
                            strHTML += "<li>"
                        }
                        if (isParent == 0) {
                            if (IsLandingPage == 1) {

                                if (ParentTagId == 10) {

                                    strHTML += "<li class='search makesmaller' title='" + DisplayTagName + "' data-bs-toggle='tooltip' data-bs-placement='bottom' ><input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'><a href=# onclick=ChangeTabs(this,'" + TimesheetLandingPage + "?TagID=" + ParentTagId + "" + "'," + TagID + ",'" + TemplateID + "','" + ResponsivePageName + "')><span class='searchText' originalName='" + DisplayTagName + "' >" + DisplayTagName + "</span></a></li>"
                                }
                                //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.                                
                                else if (ParentTagId == 405 && TagID == 405) {
                                    strHTML += "<li class='search makesmaller' title='" + DisplayTagName + "' data-bs-toggle='tooltip' data-bs-placement='bottom' ><input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'><a href=# onclick=ChangeTabs(this,'" + HelpDeskLandingPage + "?TagID=" + TagID + "" + "'," + TagID + ",'" + TemplateID + "','" + ResponsivePageName + "')><span class='searchText' originalName='" + DisplayTagName + "'>" + DisplayTagName + "</span></a></li>"
                                }
                                //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                                else {

                                    strHTML += "<li class='search makesmaller' title='" + DisplayTagName + "' data-bs-toggle='tooltip' data-bs-placement='bottom' ><input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'><a href=# onclick=ChangeTabs(this,'" + encodeURI(DisplayPageName) + "'," + TagID + ",'" + TemplateID + "','" + ResponsivePageName + "')><span class='searchText' originalName='" + DisplayTagName + "'>" + DisplayTagName + "</span></a></li>"
                                }

                            }
                            else {
                                if (ParentTagId == 10) { IsTimesheetLandingPage = 0; }
                                //Added by Chetan M on 7th May 2020 for Helpdesk support landing page.
                                if (ParentTagId == 405) { IsHelpdeskSupportLandingPage = 0; }
                                //if (childParentTagId == 1085) { IsHelpdeskDashbordLandingPage = 0; }
                                // if (childParentTagId == 914) { IsHelpdeskConfigurationLandingPage = 0; }
                                //End of Added by Chetan M on 7th May 2020 for Helpdesk support landing page.

                                strHTML += "<li class='search makesmaller' data-toggle='tooltip' ><input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'><a href=# id='a_" + TemplateID + TagID + "' onclick=ChangeTabs(this,'" + encodeURI(DisplayPageName) + "'," + TagID + ",'" + TemplateID + "','" + ResponsivePageName + "')><span class='searchText' originalName='" + DisplayTagName + "'>" + DisplayTagName + "</span></a></li>"
                            }
                        }
                        else {
                            if (parentTagId == 0) {
                                //if (ParentTagId == 305) {
                                //    strHTML += '<li data-toggle="tooltip" data-placement="bottom" title="' + DisplayTagName + '" class="treeview search" id="mainmenu_' + flag + '" onclick=ChangeTabs("' + DisplayPageName + '",' + TagID + ',' + ParentTagId + ',"' + ResponsivePageName + '")><a><i class="fa"><img src="../../Whizible2.0/dist/img/' + Image + '"  alt="" width="44px"></i> <span>' + DisplayTagName + '</span></a>'
                                //}
                                //else {//Need to change
                                strHTML += '<li  data-toggle="tooltip" data-placement="bottom" title="' + DisplayTagName + '" class="treeview search" id="mainmenu_' + TagID + '" >' + "<input type='hidden' id='header_" + TagID + "' value='" + DisplayTagName + "'>" + '<a id="a_' + TemplateID + TagID + '" onclick=ChangeTabs(this,"' + encodeURI(DisplayPageName) + '",' + TagID + ',"' + TemplateID + '","' + ResponsivePageName + '")><i class="fa"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="44px"></i> <span class="searchText" originalName="' + DisplayTagName + '" >' + DisplayTagName + '</span></a>'
                                // }

                            } else {

                                if (ParentTagId == 305) {
                                    strHTML += '<li data-toggle="tooltip" data-placement="bottom" title="' + DisplayTagName + '" class="treeview search" id="mainmenu_' + TagID + '" >' + "<input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'>" + '<a id="a_' + TemplateID + TagID + '" onclick=ChangeTabs(this,"' + encodeURI(DisplayPageName) + '",' + TagID + ',"' + TemplateID + '","' + ResponsivePageName + '")><span class="pull-left-container"><i class="fas fa-caret-right"></i></span><i class="fa"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="44px"></i> <span class="searchText"  originalName="' + DisplayTagName + '" >' + DisplayTagName + '</span></a>'
                                }
                                else {
                                    strHTML += '<li data-toggle="tooltip" data-placement="bottom" title="' + DisplayTagName + '" class="treeview search" id="mainmenu_' + TagID + '" >' + "<input type='hidden' id='header_" + TagID + "' value='" + DisplayHeader + "'>" + '<a id="a_' + TemplateID + TagID + '" onclick=ChangeTabs(this,"' + encodeURI(DisplayPageName) + '",' + TagID + ',"' + TemplateID + '","' + ResponsivePageName + '")><span class="pull-left-container"><i class="fas fa-caret-right"></i></span><i class="fa"><img src="../../Whizible2.0-new/dist/img/' + Image + '"  alt="" width="44px"></i> <span class="searchText"  originalName="' + DisplayTagName + '" >' + DisplayTagName + '</span></a>'
                                }
                            }
                        }
                        if (isParent == 1) {
                            strHTML += getChildTags(TagID)
                        }
                        strHTML += "</li>"
                        //Added By Madhuri.K On 09-01-2026
                    }
                    //End Added By Madhuri.K On 09-01-2026
                }

             }
           
             //Added By Usha Pandit On 19.01.2021 For redirecting to default access module
<%--             if (GlobalDefaultModule == 1) {
                 //debugger
                 //console.log(DisplayPageName + '1');
                 if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                     if (GlobalDisplayPageName != "") { //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
                         document.getElementById("mainHeadingTop").innerHTML = GlobalDisplayHeader;
                         document.getElementById("frmNewVersion").src = GlobalDisplayPageName;
                            //ChangeTabs(this, GlobalDisplayPageName,GlobalTagMaster, GlobalTemplateID)
                          //Added By Dipali V On 12th Feb 2021 
                         $("#mainmenu_" + GlobalTagMaster).addClass("active");
                        //  if (IsDefaultModule == 1) {
                            // ChangeTabs(this, GlobalDisplayPageName, GlobalTagMaster, GlobalTemplateID);
                        // }
                     }
                 }
             }--%>
             //End Of Added By Usha Pandit On 19.01.2021 For redirecting to default access module
             if (parentTagId == 0) {
                 //strHTML = "<ul>"
             }
             else {
                 strHTML += "</ul>"
             }

            return strHTML;
        }

        //Added By Madhuri.K - When any nav image fails to load, show Font Awesome info-circle icon
        function bindNavImageFallback($container) {
            if (!$container || !$container.length) return;
            $container.find('img').each(function() {
                var img = this;
                var $img = $(img);
                if ($img.data('nav-fallback-bound')) return;
                $img.data('nav-fallback-bound', true);
                img.onerror = function() {
                    var w = ($img.attr('width') || '12').toString().replace('px', '') || '12';
                    var $icon = $('<i class="fas fa-info-circle nav-fallback-icon"></i>');
                    $icon.css({ fontSize: w + 'px', color: '#4263c1', display: 'inline-block', width: w + 'px', textAlign: 'center', verticalAlign: 'middle', padding: '3px', marginRight: '4px' });
                    $img.replaceWith($icon);
                };
            });
        }
        
        //Added By Madhuri.K On 10-01-2026 - Function to handle parent module selection state
        //Added protection to prevent multiple calls and execution during search
        var setParentModuleSelectedTimeout = null;
        var isSettingParentModuleSelected = false;
        
        //Added By Madhuri.K On 20-01-2026 - Track last visited child page for each parent module
        //Structure: { [ParentTagID]: { tagID: <childTagID>, src: <url>, responsiveSrc: <responsiveUrl> } }
        var lastVisitedPagesByModule = {};
        
        function setParentModuleSelected(TagID) {
            // Modified By Madhuri.K On 28-01-2026 - Allow selection state to be set even during search to properly highlight parent icons
            // Prevent multiple simultaneous calls
            if (isSettingParentModuleSelected) {
                return;
            }
            
            // Clear any pending timeout
            if (setParentModuleSelectedTimeout) {
                clearTimeout(setParentModuleSelectedTimeout);
                setParentModuleSelectedTimeout = null;
            }
            
            isSettingParentModuleSelected = true;
            
            // Changed By Madhuri.K on 19-08-2026 - Removed setTimeout wrapper; run immediately since parent icons are already in the DOM
            try {
                    // Convert TagID to string and integer for comparison
                    var targetTagID = parseInt(TagID, 10);
                    if (isNaN(targetTagID)) {
                        return; // Exit if TagID is invalid
                    }
                    
                    // Remove selected class and inline styles from ALL parent icons
                    // so only the one we select below shows as selected (no stale blue on Home etc.)
                    $('.parent-panel .sidebar-menu > li.parent-icon').each(function() {
                        var $icon = $(this);
                        $icon.removeClass('selected active search-match-highlight');
                        var $link = $icon.find('> a');
                        if ($link.length > 0) {
                            var linkEl = $link[0];
                            if (linkEl) {
                                linkEl.style.removeProperty('background-color');
                                linkEl.style.removeProperty('border-radius');
                                linkEl.style.removeProperty('border');
                                linkEl.style.removeProperty('box-shadow');
                                linkEl.style.removeProperty('margin');
                            }
                            var $img = $link.find('i img');
                            if ($img.length > 0) {
                                $img[0].style.removeProperty('filter');
                            }
                        }
                    });
                    
                    // Add selected class to clicked parent icon - use strict ID matching
                    var $parentIcon = $('#mainmenu_' + targetTagID);
                    if ($parentIcon.length > 0) {
                        $parentIcon.addClass('selected active');
                    } else {
                        // If not found by ID, try alternative selector with data attribute
                        $parentIcon = $('.parent-panel .sidebar-menu > li.parent-icon[data-tagid="' + targetTagID + '"]');
                        if ($parentIcon.length > 0) {
                            $parentIcon.addClass('selected active');
                        } else {
                            // Try finding by checking anchor onclick parameter more carefully
                            var found = false;
                            $('.parent-panel .sidebar-menu > li.parent-icon').each(function() {
                                var $item = $(this);
                                var $anchor = $item.find('a').first();
                                var onclickAttr = $anchor.attr('onclick') || "";
                                
                                // Try to extract TagID from onclick - look for setParentModuleSelected(TagID) or showChildPanel(TagID
                                var match = onclickAttr.match(/(?:setParentModuleSelected|showChildPanel)\((\d+)/);
                                if (match && match[1]) {
                                    var extractedTagID = parseInt(match[1], 10);
                                    if (extractedTagID === targetTagID) {
                                        $item.addClass('selected active');
                                        found = true;
                                        return false; // break out of loop
                                    }
                                }
                            });
                        }
                    }
            } finally {
                isSettingParentModuleSelected = false;
            }
        }
        
        //Added By Madhuri.K On 10-01-2026 - Function to handle child page selection state
        function setChildPageSelected(TagID) {
            try {
                if (!TagID || TagID == 0 || TagID == "0" || TagID == "undefined") {
                    return;
                }
                
                // Normalize TagID to integer for comparisons
                var targetTagId = parseInt(TagID, 10);
                if (isNaN(targetTagId)) {
                    return;
                }
                
                // Modify By Madhuri.K on 24-07-2026 - Fast path: clear all highlights, select only this page (keeps Navigation responsive)
                var $content = $('#childPanelContent');
                $content.find('li').removeClass('selected active');
                $content.find('.child-panel-accordion-header').removeClass('selected active active-submodule');

                var $match = $content.find('#header_' + targetTagId).closest('li');
                if (!$match.length) {
                    $content.find('a[onclick*="ChangeTabs"]').each(function () {
                        var onclickAttr = this.getAttribute('onclick') || '';
                        var m = onclickAttr.match(/ChangeTabs\([^,]+,\s*['"][^'"]*['"],\s*(\d+)/);
                        if (m && parseInt(m[1], 10) === targetTagId) {
                            $match = $(this).closest('li');
                            return false;
                        }
                    });
                }
                if ($match.length) {
                    $match.addClass('selected active');
                    $match.parents('.child-panel-accordion-content').each(function () {
                        var $c = $(this);
                        $c.prev('.child-panel-accordion-header').addClass('active');
                        $c.addClass('active').css('max-height', '1000px');
                    });
                }
                return;

                // Remove selected class from all child panel items
                $('.child-panel-content li').removeClass('selected active');
                // Remove all styling from accordion headers - they'll be re-applied only to actual ancestors
                $('.child-panel-accordion-header').removeClass('selected active active-submodule');
                
                // Helper to extract TagID for a given list item (li) in child panel
                function getTagIdForItem($item) {
                    var tagId = null;
                    
                    // 1) Try data attribute on the item (for accordion items etc.)
                    var dataTagId = $item.data('tagid');
                    if (dataTagId) {
                        var parsedDataTag = parseInt(dataTagId, 10);
                        if (!isNaN(parsedDataTag)) {
                            tagId = parsedDataTag;
                        }
                    }
                    
                    // 2) Try anchor ID patterns (a_TemplateIDTagID or a_ParentTagIDTagID, etc.)
                    if (!tagId) {
                        var $link = $item.find('a').first();
                        if ($link.length > 0) {
                            var linkId = $link.attr('id');
                            if (linkId) {
                                // Prefer explicit numeric suffix
                                var suffixMatch = linkId.match(/(\d+)$/);
                                if (suffixMatch && suffixMatch[1]) {
                                    var parsedSuffix = parseInt(suffixMatch[1], 10);
                                    if (!isNaN(parsedSuffix)) {
                                        tagId = parsedSuffix;
                                    }
                                } else {
                                    // Fallback: if id contains "_" + TagID or ends with "_" + TagID
                                    // (kept for backward compatibility)
                                    if (linkId.indexOf('_' + targetTagId) > -1 || linkId.endsWith('_' + targetTagId) || linkId.indexOf(targetTagId + '_') > -1) {
                                        tagId = targetTagId;
                                    }
                                }
                            }
                            
                            // 3) Try parsing TagID from onclick attribute: ChangeTabs(this,'url',TagID,ParentTagID,...)
                            if (!tagId) {
                                var onclickAttr = $link.attr('onclick') || "";
                                if (onclickAttr) {
                                    var match = onclickAttr.match(/ChangeTabs\([^,]+,\s*['"][^'"]*['"],\s*(\d+)/);
                                    if (match && match[1]) {
                                        var parsedFromOnclick = parseInt(match[1], 10);
                                        if (!isNaN(parsedFromOnclick)) {
                                            tagId = parsedFromOnclick;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // 4) Try hidden input inside the item: header_TagID
                    if (!tagId) {
                        var $hidden = $item.find("input[type='hidden'][id^='header_']").first();
                        if ($hidden.length > 0) {
                            var hidId = $hidden.attr('id');
                            if (hidId) {
                                var numMatch = hidId.match(/(\d+)$/);
                                if (numMatch && numMatch[1]) {
                                    var parsedHidden = parseInt(numMatch[1], 10);
                                    if (!isNaN(parsedHidden)) {
                                        tagId = parsedHidden;
                                    }
                                }
                            }
                        }
                    }
                    
                    return tagId;
                }
                
                var anySelected = false;
                
                // Add selected class to the matching child page item(s) in new child panel
                $('.child-panel-content li').each(function () {
                    var $item = $(this);
                    var itemTagId = getTagIdForItem($item);
                    if (itemTagId && itemTagId === targetTagId) {
                        $item.addClass('selected active');
                        
                        // Build parent chain for this target page to avoid accidentally selecting siblings
                        function buildParentChain(tagId) {
                            var chain = [];
                            if (typeof treeChildMenu === "undefined" || !treeChildMenu) return chain;
                            var current = tagId;
                            var safety = 0;
                            while (current && safety < 50) {
                                safety++;
                                var node = null;
                                for (var k = 0; k < treeChildMenu.length; k++) {
                                    if (treeChildMenu[k].TagID == current) { node = treeChildMenu[k]; break; }
                                }
                                if (!node) break;
                                var pid = node.ParentTagId;
                                if (pid && pid != 0) {
                                    chain.push(pid);
                                    current = pid;
                                } else {
                                    break;
                                }
                            }
                            return chain;
                        }

                        var parentIdsForThisItem = buildParentChain(itemTagId);

                        // 1) DOM-based expansion: open ONLY ancestor accordion sections that are part of the parent chain
                        var $ancestorContents = $item.parents('.child-panel-accordion-content');
                        $ancestorContents.each(function () {
                            var $contentEl = $(this);
                            var $headerEl = $contentEl.prev('.child-panel-accordion-header');
                            if ($headerEl.length > 0) {
                                // Determine header's tag id (via closest accordion item or data attribute)
                                var headerTagId = null;
                                var $parentAccordionItem = $headerEl.closest('.child-panel-accordion-item');
                                if ($parentAccordionItem.length > 0) {
                                    headerTagId = $parentAccordionItem.data('tagid');
                                }
                                if (!headerTagId) {
                                    headerTagId = $headerEl.data('tagid') || null;
                                }

                                // Only mark header if it's in the parent chain
                                if (headerTagId && parentIdsForThisItem.indexOf(parseInt(headerTagId,10)) !== -1) {
                                    // Ancestor accordion headers get 'active' (to expand)
                                    $headerEl.addClass('active');
                                    // Ensure content is also marked as active and expanded
                                    var $ancestorContent = $headerEl.next('.child-panel-accordion-content');
                                    if ($ancestorContent.length > 0) {
                                        $ancestorContent.addClass('active').css("max-height", "1000px");
                                    }
                                }
                            }
                        });

                        // 2) Direct parent accordion header (for the immediate sub-module)
                        // IMPORTANT: Only mark the DIRECT parent accordion of this item, not all accordions in the panel
                        var $closestAccordionItem = $item.closest('.child-panel-accordion-item');
                        var $accordionHeader = null;
                        
                        if ($closestAccordionItem.length > 0) {
                            // Item is inside an accordion - find the header of that accordion
                            $accordionHeader = $closestAccordionItem.find('> .child-panel-accordion-header').first();
                        } else {
                            // Item is NOT inside an accordion (top-level item under child panel)
                            // Find header by going up to .child-panel-accordion-content and then previous sibling header
                            var $accordionContentFromItem = $item.closest('.child-panel-accordion-content');
                            if ($accordionContentFromItem.length > 0) {
                                var $siblingHeader = $accordionContentFromItem.prev('.child-panel-accordion-header');
                                if ($siblingHeader.length > 0) {
                                    $accordionHeader = $siblingHeader;
                                }
                            }
                        }

                        if ($accordionHeader && $accordionHeader.length > 0) {
                            // Verify this is the DIRECT parent by checking parent chain
                            var hdrTagId = null;
                            var $hdrParentItem = $accordionHeader.closest('.child-panel-accordion-item');
                            if ($hdrParentItem.length > 0) hdrTagId = $hdrParentItem.data('tagid');
                            if (!hdrTagId) hdrTagId = $accordionHeader.data('tagid') || null;

                            // Only mark if header is the direct parent (not a sibling or unrelated accordion)
                            if (!hdrTagId || parentIdsForThisItem.indexOf(parseInt(hdrTagId,10)) !== -1) {
                                // Direct parent accordion header gets 'active' (to expand), not 'selected'
                                $accordionHeader.addClass('active');

                                // Ensure the immediate accordion section is opened/expanded
                                var $accordionContent = $accordionHeader.next('.child-panel-accordion-content');
                                if ($accordionContent.length > 0) {
                                    $accordionHeader.addClass('active');
                                    $accordionContent.addClass('active')
                                                     .css("max-height", "1000px"); // Match toggleAccordion behavior
                                }
                            }
                        }

                        // Additionally, recursively find and mark ALL parent sub-modules as selected and open
                        // This handles nested accordions (e.g., Monitor & Control > User Tasks Reports > Overallocated Resources)
                        // BUT ONLY mark accordion headers that are actual ancestors of the selected item in the DOM tree
                        try {
                            if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                                var currentParentId = null;
                                
                                // Find the immediate parent of the selected page
                                for (var smi = 0; smi < treeChildMenu.length; smi++) {
                                    if (treeChildMenu[smi].TagID == targetTagId) {
                                        // If this page has a non‑zero ParentTagId, that's its sub‑module
                                        if (treeChildMenu[smi].ParentTagId && treeChildMenu[smi].ParentTagId != 0) {
                                            currentParentId = treeChildMenu[smi].ParentTagId;
                                        }
                                        break;
                                    }
                                }
                                
                                // Recursively traverse up the parent chain to find ALL sub-module parents
                                var parentIdsToProcess = [];
                                var tempParentId = currentParentId;
                                
                                while (tempParentId && tempParentId != 0) {
                                    parentIdsToProcess.push(tempParentId);
                                    
                                    // Find the parent of this sub-module
                                    var foundParent = false;
                                    for (var pmi = 0; pmi < treeChildMenu.length; pmi++) {
                                        if (treeChildMenu[pmi].TagID == tempParentId) {
                                            // Check if this parent itself has a parent (meaning it's a nested sub-module)
                                            if (treeChildMenu[pmi].ParentTagId && treeChildMenu[pmi].ParentTagId != 0) {
                                                tempParentId = treeChildMenu[pmi].ParentTagId;
                                                foundParent = true;
                                                break;
                                            } else {
                                                // This is a top-level sub-module, stop here
                                                tempParentId = null;
                                                foundParent = true;
                                                break;
                                            }
                                        }
                                    }
                                    if (!foundParent) {
                                        break;
                                    }
                                }
                                
                                // Mark all found parent sub-modules as open (in reverse order: top-level first)
                                // Reverse so we process top-level accordions first, ensuring they're open before nested ones
                                // IMPORTANT: Only mark headers that are actual DOM ancestors of the selected item
                                // Direct parent gets only 'active' (handled above), nested ancestors get 'active-submodule'
                                for (var pidIdx = parentIdsToProcess.length - 1; pidIdx >= 0; pidIdx--) {
                                    var parentSubModuleId = parentIdsToProcess[pidIdx];
                                    
                                    // Skip the immediate parent (currentParentId) - it's already handled above
                                    if (parentSubModuleId == currentParentId) {
                                        continue;
                                    }
                                    
                                    var $subModuleItem = $(".child-panel-accordion-item[data-tagid='" + parentSubModuleId + "']");
                                    
                                    // Extra validation: ensure this accordion item is an actual ancestor of our selected item
                                    var isActualAncestor = false;
                                    if ($subModuleItem.length > 0) {
                                        // Check if the selected item ($item) is inside this accordion item
                                        if ($item.closest($subModuleItem).length > 0) {
                                            isActualAncestor = true;
                                        }
                                    }
                                    
                                    if (isActualAncestor && $subModuleItem.length > 0) {
                                        var $subHeader = $subModuleItem.find("> .child-panel-accordion-header").first();
                                        if ($subHeader.length > 0) {
                                            // Nested sub-module headers get 'active-submodule' + 'active' (to expand), NOT 'selected'
                                            // This distinguishes them from actual selected page items
                                            $subHeader.addClass("active-submodule active");
                                            
                                            // Also ensure this accordion is opened/expanded
                                            var $subContent = $subHeader.next('.child-panel-accordion-content');
                                            if ($subContent.length > 0) {
                                                $subHeader.addClass('active');
                                                $subContent.addClass('active').css("max-height", "1000px");
                                            }
                                        }
                                    }
                                }
                            }
                        } catch (subModuleSelEx) {
                            // Ignore errors while trying to select sub-module headers
                        }

                        anySelected = true;
                    }
                });
                
                // Fallback: if nothing selected by TagID, try matching by page name (caption)
                if (!anySelected) {
                    var currentHeaderText = "";
                    var headerEl = document.getElementById("mainHeadingTop");
                    if (headerEl && headerEl.innerHTML) {
                        currentHeaderText = headerEl.innerHTML;
                    }
                    
                    // Extract page name from "Module > Page" if present
                    var pageNameFromHeader = "";
                    if (currentHeaderText && currentHeaderText.indexOf(">") > -1) {
                        var parts = currentHeaderText.split(">");
                        pageNameFromHeader = parts[parts.length - 1].trim();
                    } else {
                        pageNameFromHeader = currentHeaderText;
                    }
                    
                    if (pageNameFromHeader && pageNameFromHeader !== "" && pageNameFromHeader !== "undefined") {
                        $('.child-panel-content li').each(function () {
                            var $item = $(this);
                            var $link = $item.find("a").first();
                            if ($link.length > 0) {
                                var linkText = $.trim($link.text() || "");
                                // Case-insensitive comparison, allow header to contain full caption
                                if (linkText.toLowerCase() === pageNameFromHeader.toLowerCase()) {
                                    $item.addClass("selected active");
                                    // For fallback: find direct parent accordion and mark it as active (to expand)
                                    var $fallbackAccordionItem = $item.closest(".child-panel-accordion-item");
                                    if ($fallbackAccordionItem.length > 0) {
                                        var $fallbackHeader = $fallbackAccordionItem.find('> .child-panel-accordion-header').first();
                                        if ($fallbackHeader.length > 0) {
                                            // Parent accordion gets 'active' only, not 'selected'
                                            $fallbackHeader.addClass("active");
                                            var $fallbackContent = $fallbackHeader.next('.child-panel-accordion-content');
                                            if ($fallbackContent.length > 0) {
                                                $fallbackContent.addClass('active').css("max-height", "1000px");
                                            }
                                        }
                                    }
                                    anySelected = true;
                                }
                            }
                        });
                    }
                }
                
                // Also highlight matching item in legacy left navigation tree (treeMenu)
                try {
                    $('#treeMenu li').removeClass('selected active');
                    
                    $('#treeMenu li').each(function () {
                        var $item = $(this);
                        var itemTagId = getTagIdForItem($item);
                        if (itemTagId && itemTagId === targetTagId) {
                            $item.addClass('selected active');
                        }
                    });
                } catch (legacyEx) {
                    // Ignore errors from legacy menu highlighting
                }

                // Ensure the top-level parent (left sidebar parent icon) is selected
                try {
                    if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                        // Find the root/top-level parent for the selected TagID by walking up the ParentTagId chain
                        var rootParentId = null;
                        var curId = targetTagId;
                        var safetyCounter = 0;
                        while (curId && safetyCounter < 50) {
                            safetyCounter++;
                            var foundNode = null;
                            for (var ti = 0; ti < treeChildMenu.length; ti++) {
                                if (treeChildMenu[ti].TagID == curId) {
                                    foundNode = treeChildMenu[ti];
                                    break;
                                }
                            }
                            if (!foundNode) {
                                break;
                            }
                            var parentId = foundNode.ParentTagId;
                            if (parentId && parentId != 0) {
                                // move up to parent
                                curId = parentId;
                                continue;
                            } else {
                                // found top-level module (no further parent)
                                rootParentId = foundNode.TagID;
                                break;
                            }
                        }

                        // Fallback: if we didn't find a root, try the child panel header attribute
                        if (!rootParentId) {
                            try {
                                var hdr = $("#childPanelHeader").attr("data-parent-tagid");
                                if (hdr && hdr != "" && hdr != "0") {
                                    rootParentId = hdr;
                                }
                            } catch (hdrEx) {
                                // ignore
                            }
                        }

                        if (rootParentId) {
                            // Use existing helper to set the parent module selected (this clears others)
                            try {
                                setParentModuleSelected(rootParentId);
                            } catch (spEx) {
                                console && console.log && console.log('Error calling setParentModuleSelected:', spEx);
                            }
                        }
                    }
                } catch (selEx) {
                    console && console.log && console.log('Error selecting top-level parent:', selEx);
                }
            } catch (ex) {
                // Fail silently to avoid breaking navigation if something goes wrong
                console && console.log && console.log('Error in setChildPageSelected:', ex);
            }
        }
        
        //Added By Madhuri.K On 09-01-2026 For Child Panel
        //Modified By Madhuri.K On 10-01-2026 - Added accordion functionality for sub-modules in child panel, items with sub-modules now display in expandable/collapsible accordion format
        function showChildPanel(TagID, preserveSearch) {
            // Dipali V - Legacy dashboard submenu uses ParentTagId 9999; normalize to 21000 for filters/ChangeTabs
            var isDashboardPanel = isDashboardChildPanelContext(TagID);
            if (isDashboardPanel) {
                TagID = DASHBOARD_MODULE_TAGID;
            }
            //Added By Madhuri.K On 10-01-2026 - Set parent module as selected when showing child panel
            // Only set selection if not preserving search (to avoid flickering during search)
            if (!preserveSearch) {
                setParentModuleSelected(TagID);
            }
            //Modified By Madhuri.K On 10-01-2026 - Preserve search text when opening panel from search
            preserveSearch = preserveSearch || false;
            
            // Added By Madhuri.K On 29-01-2026 - Get TagName early so it can be used in error handler
            var TagName = "";
            if (treeChildMenu && treeChildMenu.length > 0) {
                for (var i = 0; i < treeChildMenu.length; i++) {
                    if (treeChildMenu[i].TagID == TagID && treeChildMenu[i].ParentTagId == 0) {
                        TagName = treeChildMenu[i].DisplayTagName;
                        break;
                    }
                }
            }
            
            // If not found, try to get from parent icon's hidden input field
            if (!TagName || TagName == "" || TagName == "undefined") {
                var parentIcon = document.querySelector('#mainmenu_' + TagID + ' input[type="hidden"][id^="header_"]');
                if (parentIcon && parentIcon.value) {
                    TagName = parentIcon.value;
                } else {
                    // Try to get from parent icon's title attribute
                    var parentIconLink = document.querySelector('#mainmenu_' + TagID + ' a[title]');
                    if (parentIconLink && parentIconLink.getAttribute('title')) {
                        TagName = parentIconLink.getAttribute('title');
                    }
                }
            }
            
            // Final fallback: search in all treeChildMenu items for this TagID
            if (!TagName || TagName == "" || TagName == "undefined") {
                if (treeChildMenu && treeChildMenu.length > 0) {
                    for (var i = 0; i < treeChildMenu.length; i++) {
                        if (treeChildMenu[i].TagID == TagID) {
                            TagName = treeChildMenu[i].DisplayTagName;
                            break;
                        }
                    }
                }
            }
            
            if (!preserveSearch) {
                $("#childPanelSearch").val("");
            }

            // Added By Madhuri.K On 29-01-2026 - Add error handling and debugging for child panel
            try {
            var childTagMasters = isDashboardPanel || parseInt(TagID, 10) === DASHBOARD_MODULE_TAGID
                ? getModuleChildTags(DASHBOARD_MODULE_TAGID, treeChildMenu)
                : GetTagMastersByParentTagID(TagID, treeChildMenu);
            if (!childTagMasters) {
                childTagMasters = [];
            }
            var childHTML = "<ul>";
            var overviewPageUrl = "";
            var overviewTagID = 0;
            var overviewTemplateID = "";
            var overviewResponsivePageName = "";
            var overviewHeader = "";
            
            // Get parent tag name and find Overview page
            //Modified By Madhuri.K On 10-01-2026 - Get parent module name from treeChildMenu, also try to get from parent icon element
            // NOTE: TagName is now retrieved before try block to ensure it's available for error handler
            
            // Find Landing/Overview page - first look for IsLandingPage, then IsDefaultPage, then "Overview" in name, else use first child
            //Added By Madhuri.K On 09-01-2026 - Prioritize Landing Page
            for (var k = 0; k < childTagMasters.length; k++) {
                if (isNavFolderOnlyNode(childTagMasters[k])) continue;
                var childIsLandingPage = childTagMasters[k].IsLandingPage;
                var childIsDefaultPage = childTagMasters[k].IsDefaultPage;
                var childDisplayTagName = childTagMasters[k].DisplayTagName;
                
                // First priority: Landing Page
                if (childIsLandingPage == 1) {
                    overviewPageUrl = childTagMasters[k].DisplayPageName;
                    overviewTagID = childTagMasters[k].TagID;
                    overviewTemplateID = childTagMasters[k].TemplateID;
                    overviewResponsivePageName = childTagMasters[k].ResponsivePageName;
                    overviewHeader = childTagMasters[k].DisplayHeader;
                    
                    var TimesheetLandingPage = '../NewAPI/Timesheet/TMS_LandingPage.aspx';
                    var HelpDeskLandingPage = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx';
                    
                    if (childTagMasters[k].ParentTagId == 10) {
                        overviewPageUrl = TimesheetLandingPage + "?TagID=" + childTagMasters[k].ParentTagId;
                    } else if (childTagMasters[k].ParentTagId == 405 && overviewTagID == 405) {
                        overviewPageUrl = HelpDeskLandingPage + "?TagID=" + overviewTagID;
                    }
                    break;
                }
            }
            
            // Second priority: Default Page or Overview
            if (overviewPageUrl == "") {
                for (var k = 0; k < childTagMasters.length; k++) {
                    if (isNavFolderOnlyNode(childTagMasters[k])) continue;
                    var childIsDefaultPage = childTagMasters[k].IsDefaultPage;
                    var childDisplayTagName = childTagMasters[k].DisplayTagName;
                    
                    if (childIsDefaultPage == 1 || (childDisplayTagName && childDisplayTagName.toLowerCase().indexOf("overview") >= 0)) {
                        overviewPageUrl = childTagMasters[k].DisplayPageName;
                        overviewTagID = childTagMasters[k].TagID;
                        overviewTemplateID = childTagMasters[k].TemplateID;
                        overviewResponsivePageName = childTagMasters[k].ResponsivePageName;
                        overviewHeader = childTagMasters[k].DisplayHeader;
                        
                        var childIsLandingPage = childTagMasters[k].IsLandingPage;
                        var TimesheetLandingPage = '../NewAPI/Timesheet/TMS_LandingPage.aspx';
                        var HelpDeskLandingPage = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx';
                        
                        if (childIsLandingPage == 1) {
                            if (childTagMasters[k].ParentTagId == 10) {
                                overviewPageUrl = TimesheetLandingPage + "?TagID=" + childTagMasters[k].ParentTagId;
                            } else if (childTagMasters[k].ParentTagId == 405 && overviewTagID == 405) {
                                overviewPageUrl = HelpDeskLandingPage + "?TagID=" + overviewTagID;
                            }
                        }
                        break;
                    }
                }
            }
            //End Added By Madhuri.K On 09-01-2026
            
            // If no Overview found, use first navigable child (skip Project folder -9002 IsParent=1)
            if (overviewPageUrl == "" && childTagMasters.length > 0) {
                for (var fc = 0; fc < childTagMasters.length; fc++) {
                    if (isNavFolderOnlyNode(childTagMasters[fc])) continue;
                    overviewPageUrl = childTagMasters[fc].DisplayPageName;
                    overviewTagID = childTagMasters[fc].TagID;
                    overviewTemplateID = childTagMasters[fc].TemplateID;
                    overviewResponsivePageName = childTagMasters[fc].ResponsivePageName;
                    overviewHeader = childTagMasters[fc].DisplayHeader;
                    var childIsLandingPage = childTagMasters[fc].IsLandingPage;
                    var TimesheetLandingPage = '../NewAPI/Timesheet/TMS_LandingPage.aspx';
                    var HelpDeskLandingPage = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx';
                    if (childIsLandingPage == 1) {
                        if (childTagMasters[fc].ParentTagId == 10) {
                            overviewPageUrl = TimesheetLandingPage + "?TagID=" + childTagMasters[fc].ParentTagId;
                        } else if (childTagMasters[fc].ParentTagId == 405 && overviewTagID == 405) {
                            overviewPageUrl = HelpDeskLandingPage + "?TagID=" + overviewTagID;
                        }
                    }
                    break;
                }
            }
            
            // Decide which page to navigate to:
            // 1) If user has already visited a page within this module, navigate to that page
            // 2) Otherwise, navigate to the Overview/Landing page
            var navigateUrl = overviewPageUrl;
            var navigateTagID = overviewTagID;
            var navigateResponsivePageName = overviewResponsivePageName;
            var usedLastVisitedForNavigation = false;
            
            //Added By Madhuri.K On 20-01-2026 - Use last visited page for the module after first visit
            if (lastVisitedPagesByModule && lastVisitedPagesByModule[TagID]) {
                var lastVisited = lastVisitedPagesByModule[TagID];
                if (lastVisited && lastVisited.tagID && lastVisited.src) {
                    navigateUrl = lastVisited.src;
                    navigateTagID = lastVisited.tagID;
                    // Use stored responsive src if available, else fallback to overview responsive page
                    navigateResponsivePageName = lastVisited.responsiveSrc || navigateResponsivePageName;
                    usedLastVisitedForNavigation = true;
                }
            }

            if (navigateUrl != "" && navigateTagID > 0 && treeChildMenu && treeChildMenu.length > 0) {
                for (var nd = 0; nd < treeChildMenu.length; nd++) {
                    if (treeChildMenu[nd].TagID == navigateTagID && isNavFolderOnlyNode(treeChildMenu[nd])) {
                        navigateUrl = "";
                        navigateTagID = 0;
                        break;
                    }
                }
            }
            
            // Navigate after child panel HTML is rendered (prevents "Loading menu items..." if ChangeTabs throws)
            var deferredChildPanelNav = (navigateUrl != "" && navigateTagID > 0) ? {
                navigateUrl: navigateUrl,
                navigateTagID: navigateTagID,
                navigateResponsivePageName: navigateResponsivePageName,
                usedLastVisitedForNavigation: usedLastVisitedForNavigation,
                overviewHeader: overviewHeader
            } : null;

            // Navigate to target page (Overview/Landing or last visited) - Added By Madhuri.K On 09-01-2026
             //Modified By Madhuri.K On 21-01-2026 - When reopening a module and using last visited page, show full breadcrumb "Module > Page"
            function runDeferredChildPanelNavigation() {
            if (!deferredChildPanelNav) return;
            var navigateUrl = deferredChildPanelNav.navigateUrl;
            var navigateTagID = deferredChildPanelNav.navigateTagID;
            var navigateResponsivePageName = deferredChildPanelNav.navigateResponsivePageName;
            var usedLastVisitedForNavigation = deferredChildPanelNav.usedLastVisitedForNavigation;
            var overviewHeader = deferredChildPanelNav.overviewHeader;
                try {
                // Default header = module name, will be overridden with full breadcrumb when using last visited page
                var headerToSet = TagName || "";
                if (!headerToSet || headerToSet == "" || headerToSet == "undefined") {
                    // If no tag name found, use overview header as fallback
                    headerToSet = overviewHeader || "";
                }
                
                // If we're navigating to a previously visited page within this module,
                if (usedLastVisitedForNavigation) {
                    // Prefer stored names from lastVisitedPagesByModule populated in ChangeTabs
                    var lastVisitedInfoForHeader = lastVisitedPagesByModule ? lastVisitedPagesByModule[TagID] : null;
                    var moduleNameForLastNav = (lastVisitedInfoForHeader && lastVisitedInfoForHeader.moduleName) ? lastVisitedInfoForHeader.moduleName : (TagName || "");
                    var pageNameForLastNav = (lastVisitedInfoForHeader && lastVisitedInfoForHeader.pageName) ? lastVisitedInfoForHeader.pageName : "";
                    
                    // If names are still missing, fall back to treeChildMenu lookup
                    if ((!moduleNameForLastNav || !pageNameForLastNav) &&
                        typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                        try {
                            var tagIdNumericForLastNav = parseInt(navigateTagID, 10);
                            for (var lvi = 0; lvi < treeChildMenu.length; lvi++) {
                                var tmNav = treeChildMenu[lvi];
                                if (!moduleNameForLastNav && tmNav.TagID == TagID && tmNav.ParentTagId == 0) {
                                    moduleNameForLastNav = tmNav.DisplayTagName || moduleNameForLastNav;
                                }
                                if (!pageNameForLastNav && tmNav.TagID == tagIdNumericForLastNav) {
                                    pageNameForLastNav = tmNav.DisplayTagName || pageNameForLastNav;
                                }
                            }
                        } catch (exLastNav) {
                            // Ignore errors while composing breadcrumb; fall back to headerToSet
                        }
                    }
                    
                    if (moduleNameForLastNav && pageNameForLastNav) {
                        headerToSet = moduleNameForLastNav + " > " + pageNameForLastNav;
                    }
                }
                
                // Set the main heading:
                // - For regular first-time navigation: just module name
                // - For last-visited navigation: clickable breadcrumb "Module > Page"
                if (headerToSet && headerToSet != "" && headerToSet != "undefined") {
                    var headingElement = document.getElementById("mainHeadingTop");
                    if (headingElement) {
                        if (usedLastVisitedForNavigation &&
                            headerToSet.indexOf(">") > -1 &&
                            typeof updateBreadcrumbContext === "function" &&
                            typeof setClickableBreadcrumb === "function") {
                            
                            // Save context and render clickable breadcrumb links
                            updateBreadcrumbContext(TagID, navigateTagID, headerToSet);
                            setClickableBreadcrumb(headerToSet, navigateTagID, TagID);
                            if (typeof initBreadcrumbObserver === "function") {
                                initBreadcrumbObserver();
                            }
                        } else {
                            // Simple module-only header
                            headingElement.innerHTML = headerToSet;
                        }
                    }
                }
                
                // Create a wrapper div to hold both anchor and header so ChangeTabs can find the header
                // ChangeTabs looks for header using: $("#a_" + ParentTagID + TagID).parent().find("#header_" + TagID)
                var wrapperDiv = document.createElement('div');
                wrapperDiv.style.display = 'none';
                
                // Create anchor with ID format that ChangeTabs expects: a_ + ParentTagID + TagID
                // When calling ChangeTabs: TagID = navigateTagID, ParentTagID = TagID (parent)
                var tempAnchor = document.createElement('a');
                tempAnchor.id = 'a_' + TagID + navigateTagID; // Format: a_ + ParentTagID + TagID
                wrapperDiv.appendChild(tempAnchor);
                
                // Add header input to wrapper so ChangeTabs can find it via parent().find()
                //Modified By Madhuri.K On 10-01-2026 - Always use module name (TagName) for header input, not Overview
                var moduleHeaderForInput = TagName || headerToSet || "";
                if (moduleHeaderForInput && moduleHeaderForInput != "" && moduleHeaderForInput != "undefined") {
                    var headerInWrapper = document.createElement('input');
                    headerInWrapper.type = 'hidden';
                    headerInWrapper.id = 'header_' + navigateTagID; // Format: header_ + TagID
                    headerInWrapper.value = moduleHeaderForInput; // Use module name, not Overview
                    wrapperDiv.appendChild(headerInWrapper);
                }
                document.body.appendChild(wrapperDiv);
                
                // Also ensure header exists globally for getElementById lookup - use module name
                if (moduleHeaderForInput && moduleHeaderForInput != "" && moduleHeaderForInput != "undefined") {
                    var existingHeader = document.getElementById('header_' + navigateTagID);
                    if (!existingHeader) {
                        var headerInput = document.createElement('input');
                        headerInput.type = 'hidden';
                        headerInput.id = 'header_' + navigateTagID;
                        headerInput.value = moduleHeaderForInput; // Use module name, not Overview
                        document.body.appendChild(headerInput);
                    } else {
                        existingHeader.value = moduleHeaderForInput; // Use module name, not Overview
                    }
                }
                
                // Navigate to overview/landing page or last visited page
                ChangeTabs(tempAnchor, navigateUrl, navigateTagID, TagID, navigateResponsivePageName);
                
                // If we are using last visited page, ensure that page is selected in the child panel.
                // Otherwise, ensure module name is visible even if ChangeTabs temporarily changes it.
                // Changed By Madhuri.K on 19-08-2026 - Removed 2/250/300/500/800ms setTimeouts; child panel DOM is already rendered before this runs
                var moduleHeader = TagName || "";
                if (usedLastVisitedForNavigation) {
                    // Highlight the last visited page inside the child panel menu
                    if (typeof setChildPageSelected === "function") {
                        setChildPageSelected(navigateTagID);
                    }
                    // Ensure parent module icon is visually selected again when revisiting
                    if (typeof setParentModuleSelected === "function") {
                        setParentModuleSelected(TagID);
                    }
                    // Re-apply clickable breadcrumb after any overrides from ChangeTabs or legacy code
                    var lastVisitedInfoForBreadcrumb = lastVisitedPagesByModule ? lastVisitedPagesByModule[TagID] : null;
                    var moduleNameForBreadcrumb = lastVisitedInfoForBreadcrumb && lastVisitedInfoForBreadcrumb.moduleName ? lastVisitedInfoForBreadcrumb.moduleName : (TagName || "");
                    var pageNameForBreadcrumb = lastVisitedInfoForBreadcrumb && lastVisitedInfoForBreadcrumb.pageName ? lastVisitedInfoForBreadcrumb.pageName : "";
                    if (moduleNameForBreadcrumb && pageNameForBreadcrumb &&
                        typeof updateBreadcrumbContext === "function" &&
                        typeof setClickableBreadcrumb === "function") {
                        var breadcrumbHeader = moduleNameForBreadcrumb + " > " + pageNameForBreadcrumb;
                        updateBreadcrumbContext(TagID, navigateTagID, breadcrumbHeader);
                        setClickableBreadcrumb(breadcrumbHeader, navigateTagID, TagID);
                        if (typeof initBreadcrumbObserver === "function") {
                            initBreadcrumbObserver();
                        }
                    }
                } else {
                    // Set immediately before/after ChangeTabs
                    if (moduleHeader && moduleHeader != "" && moduleHeader != "undefined") {
                        if (document.getElementById("mainHeadingTop")) {
                            document.getElementById("mainHeadingTop").innerHTML = moduleHeader;
                        }
                    }
                    
                    // Highlight the Overview/Landing page inside the child panel menu
                    if (typeof setChildPageSelected === "function" && navigateTagID > 0) {
                        setChildPageSelected(navigateTagID);
                    }
                    
                    if (moduleHeader && moduleHeader != "" && moduleHeader != "undefined") {
                        if (document.getElementById("mainHeadingTop")) {
                            var currentHeader = document.getElementById("mainHeadingTop").innerHTML;
                            if (!currentHeader || currentHeader == "" || currentHeader == "undefined" || 
                                currentHeader.toLowerCase().indexOf("overview") >= 0 || 
                                currentHeader == overviewHeader || currentHeader.trim() == "Overview") {
                                document.getElementById("mainHeadingTop").innerHTML = moduleHeader;
                            }
                        }
                    }
                }
                
                // Changed By Madhuri.K on 10-07-2026 - Clean up wrapper div immediately after ChangeTabs (removed 500ms delay)
                if (wrapperDiv && wrapperDiv.parentNode) {
                    wrapperDiv.parentNode.removeChild(wrapperDiv);
                }
                
                // Changed By Madhuri.K on 19-08-2026 - Final header check with no delay (removed 800ms setTimeout)
                if (moduleHeader && moduleHeader != "" && moduleHeader != "undefined") {
                    if (document.getElementById("mainHeadingTop")) {
                        var currentHeader = document.getElementById("mainHeadingTop").innerHTML;
                        // Force set if it's still "Overview"
                        if (currentHeader && (currentHeader.toLowerCase().indexOf("overview") >= 0 || currentHeader.trim() == "Overview")) {
                            document.getElementById("mainHeadingTop").innerHTML = moduleHeader;
                        }
                    }
                }
                } catch (exNavToPage) {
                    console.error("showChildPanel navigation skipped for TagID " + TagID + ":", exNavToPage);
                }
            }
            //End Added By Madhuri.K On 09-01-2026
            
            //Added By Madhuri.K On 10-01-2026 - Build child panel HTML with accordion for sub-modules, items with sub-modules display in expandable accordion format
           if (TagID == 10) {
                // Define the order for Timesheet module pages
               //"My Timesheets" added in the array by Aditya J. on 05-02-2026 to plot My Timesheets above Timesheet Approval
               var timesheetOrder = ["Timesheet Entry", "My Timesheets","Timesheet Approval", "Overview", "Timesheet Excel Upload"];
                
                // Sort childTagMasters array based on the specified order
                childTagMasters.sort(function(a, b) {
                    var aIndex = timesheetOrder.indexOf(a.DisplayTagName);
                    var bIndex = timesheetOrder.indexOf(b.DisplayTagName);
                    
                    // If not found in order array, put at the end
                    if (aIndex === -1) aIndex = 999;
                    if (bIndex === -1) bIndex = 999;
                    
                    return aIndex - bIndex;
                });
            }
            
                for (var j = 0; j < childTagMasters.length; j++) {
                try {
                if (isDashboardModuleTagId(TagID) && !isDashboardDbTag(childTagMasters[j])) {
                    continue;
                }
                var childDisplayPageName = childTagMasters[j].DisplayPageName;
                var childDisplayTagName = childTagMasters[j].DisplayTagName;
                var childTagID = childTagMasters[j].TagID;
                var childDisplayHeader = childTagMasters[j].DisplayHeader;
                var childParentTagId = childTagMasters[j].ParentTagId;
                var childTemplateID = childTagMasters[j].TemplateID;
                var childResponsivePageName = childTagMasters[j].ResponsivePageName;
                var childIsLandingPage = childTagMasters[j].IsLandingPage;
                var childIsDefaultPage = childTagMasters[j].IsDefaultPage;
                var TimesheetLandingPage = '../NewAPI/Timesheet/TMS_LandingPage.aspx';
                var HelpDeskLandingPage = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx';
                
                //Modified By User On 02-02-2026 - Show Overview/Landing pages in child panel list for all modules
                // Overview pages are now displayed in the child panel instead of being skipped
                
                var pageUrl = childDisplayPageName;
                if (childIsLandingPage == 1) {
                    if (childParentTagId == 10) {
                        pageUrl = TimesheetLandingPage + "?TagID=" + childParentTagId;
                    } else if (childParentTagId == 405 && childTagID == 405) {
                        pageUrl = HelpDeskLandingPage + "?TagID=" + childTagID;
                    }
                }
                
                //Modified By Madhuri.K On 10-01-2026 - For Timesheet module (TagID == 10), show all pages as flat list without accordion, in specific order
                if (TagID == 10) {
                    // For Timesheet module, show all pages as regular list items (no accordion)
                     //Modified By Madhuri.K On 27-01-2026 - Added circle icon for Timesheet child panel items
                    childHTML += '<li><input type="hidden" id="header_' + childTagID + '" value="' + childDisplayHeader + '"><a id="a_' + childTemplateID + childTagID + '" onclick="ChangeTabs(this, \'' + encodeURI(pageUrl) + '\',' + childTagID + ',' + TagID + ',\'' + childTemplateID + '\',\'' + childResponsivePageName + '\');" style="cursor: pointer;"><i class="fas fa-circle page-circle-icon" style="font-size: 8px; margin-right: 8px; vertical-align: middle;"></i>' + childDisplayTagName + '</a></li>';
                } else {
                    //Added By Madhuri.K On 10-01-2026 - Check if this child has sub-modules, if yes create accordion structure
                    var subModules = getChildTagsForModuleParent(TagID, childTagID, treeChildMenu);
                    
                    // Check if this is a Resources, Configuration, MIS, or Dashboard sub-node with an image (should show as accordion)
                    //Modified By Madhuri.K On 16-01-2026 - Pages should never be accordions, only sub-nodes can be accordions
                    var shouldShowAsAccordion = false;
                    
                    // Overview/Landing pages should never be accordions, always show as regular list items
                    var isOverviewPage = (safeNavTextLower(childDisplayTagName) === "overview") ||
                                        childIsLandingPage == 1;
                    
                    // Pages that should never be accordions even if they have children (like Issue List)
                    var childTagLower = safeNavTextLower(childDisplayTagName);
                    var isPageThatShouldNotBeAccordion = childTagLower === "issue list" || childTagLower === "issue";
                    
                    var childIsFolderParent = childTagMasters[j].IsParent == 1 || childTagMasters[j].IsParent == "1";
                    if (isDashboardModuleTagId(TagID)) {
                        // Dashboard: only DB folder nodes (Project, Invoice, etc.) expand; PM/SEPG dashboards are always leaf links
                        shouldShowAsAccordion = !isOverviewPage && !isPageThatShouldNotBeAccordion &&
                            childIsFolderParent && isDashboardDbTag(childTagMasters[j]);
                    } else if (!isOverviewPage && !isPageThatShouldNotBeAccordion && (subModules.length > 0 || childIsFolderParent)) {
                        // Sub-modules or folder parent (Project -9002, children ParentTagId -9002)
                        shouldShowAsAccordion = true;
                    } else {
                        // Item has no sub-modules - this is a PAGE, not a sub-node
                        if (TagID == 21000) {
                            var checkDashboardImage = getDashboardSubModuleImage(childDisplayTagName);
                            if (checkDashboardImage && childIsFolderParent) {
                                shouldShowAsAccordion = true;
                            }
                        }
                    }
                    
                    if (shouldShowAsAccordion) {
                        // Create accordion structure for items with sub-modules
                        childHTML += '<li class="child-panel-accordion-item" data-tagid="' + childTagID + '">';
                        childHTML += '<input type="hidden" id="header_' + childTagID + '" value="' + childDisplayHeader + '">';
                        //Modified By Madhuri.K On 20-01-2026 - Add Projects module image support
                        // Check modules in priority order: Process (TagID 654) -> Projects -> Dashboard (TagID 21000) -> Help Desk (TagID 405) -> Resources -> Knowledge -> Configuration -> MIS
                        var subModuleImage = '';
                        var subModuleImagePath = '';
                        
                        // 1. Check Process module (TagID == 654)
                        if (TagID == 654) {
                            var processImageName = getProcessSubModuleImage(childDisplayTagName);
                            if (processImageName) {
                                subModuleImage = processImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Processes_Module/';
                            }
                        }
                        
                        // 2. Check Projects module (TagID needs to be determined - typically the main Projects module TagID)
                        //Modified By Madhuri.K On 20-01-2026 - Add Projects module image support with proper image mapping
                        if (!subModuleImage && TagID != 654 && TagID != 21000 && TagID != 405) {
                            var projectImageName = getProjectSubModuleImage(childDisplayTagName);
                            if (projectImageName) {
                                subModuleImage = projectImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Projects/';
                            }
                        }
                        
                        // 3. Check Dashboard module (TagID == 21000)
                        if (!subModuleImage && TagID == 21000) {
                            var dashboardImageName = getDashboardSubModuleImage(childDisplayTagName);
                            if (dashboardImageName) {
                                subModuleImage = dashboardImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Dashboard/';
                            }
                        }
                        
                        // 3a. Check Help Desk module (TagID == 405)
                        //Modified By Madhuri.K On 16-01-2026 - Add Help Desk module image support
                        if (!subModuleImage && TagID == 405) {
                            var helpDeskImageName = getHelpDeskSubModuleImage(childDisplayTagName);
                            if (helpDeskImageName) {
                                subModuleImage = helpDeskImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Help_Desk_Module/';
                            }
                        }
                        
                        // 4. Check Resources module (if Dashboard and Help Desk didn't match)
                        //Modified By Madhuri.K On 16-01-2026 - Check Resources module for all modules, not just when Dashboard didn't match
                        if (!subModuleImage) {
                            var resourcesImageName = getResourcesSubModuleImage(childDisplayTagName);
                            if (resourcesImageName) {
                                subModuleImage = resourcesImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Resources/';
                            }
                        }
                        
                        // 5. Check Knowledge module (before Configuration to prevent false matches)
                        //Modified By Madhuri.K On 16-01-2026 - Check Knowledge module before Configuration to ensure correct path
                        if (!subModuleImage) {
                            var knowledgeImageName = getKnowledgeSubModuleImage(childDisplayTagName);
                            if (knowledgeImageName) {
                                subModuleImage = knowledgeImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Knownalge/';
                            }
                        }
                        
                        // 6. Check Configuration module (if Knowledge didn't match and not Dashboard module)
                        if (!subModuleImage && TagID != 21000) {
                            var configurationImageName = getConfigurationSubModuleImage(childDisplayTagName);
                            if (configurationImageName) {
                                subModuleImage = configurationImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Configuration_Module/';
                            }
                        }
                        
                        // 7. Check MIS module (if Configuration didn't match)
                        if (!subModuleImage) {
                            var misImageName = getMISSubModuleImage(childDisplayTagName);
                            if (misImageName) {
                                subModuleImage = misImageName;
                                subModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/MIS/';
                            }
                        }
                        
                        // Build image HTML if image found
                        var accordionImageHTML = '';
                        if (subModuleImage && subModuleImagePath) {
                            //Modified By Madhuri.K On 16-01-2026 - Apply blue color filter for all modules to match parent icon color
                            var imageStyle = 'width: 17px; height: 25px; margin-right: 1px; vertical-align: middle; display: inline-block; object-fit: contain;';
                            
                            // Apply blue color filter for all modules to match parent icon color
                            var blueFilter = getColorFilter('#4263c1');
                            if (blueFilter && blueFilter !== 'none') {
                                imageStyle += ' filter: ' + blueFilter + ';';
                            }
                            
                            accordionImageHTML = '<img src="' + subModuleImagePath + subModuleImage + '" alt="" style="' + imageStyle + '">';
                        }
                        
                        childHTML += '<div class="child-panel-accordion-header" onclick="toggleAccordion(this)">';
                        childHTML += '<span style="flex: 1; cursor: pointer; display: flex; align-items: center;">' + accordionImageHTML + '<span>' + childDisplayTagName + '</span></span>';
                        childHTML += '<span class="child-panel-accordion-toggle"><i class="fas fa-chevron-right"></i></span>';
                        childHTML += '</div>';
                        childHTML += '<div class="child-panel-accordion-content">';
                        childHTML += '<ul>';
                        
                        //Modified By Madhuri.K On 10-01-2026 - Removed parent link (Overview) item from accordion as per user request - sub-module name should not show in accordion
                        
                        // Add sub-modules inside accordion content
                        //Modified By Madhuri.K On 16-01-2026 - Always loop through subModules if they exist, even if accordion was forced to show
                        if (!subModules || subModules.length === 0) {
                            subModules = getChildTagsForModuleParent(TagID, childTagID, treeChildMenu);
                        }
                        if (subModules && subModules.length > 0) {
                        for (var k = 0; k < subModules.length; k++) {
                            if (isDashboardModuleTagId(TagID) && !isDashboardDbTag(subModules[k])) {
                                continue;
                            }
                            var subDisplayPageName = subModules[k].DisplayPageName;
                            var subDisplayTagName = subModules[k].DisplayTagName;
                            var subTagID = subModules[k].TagID;
                            var subDisplayHeader = subModules[k].DisplayHeader;
                            var subTemplateID = subModules[k].TemplateID;
                            var subResponsivePageName = subModules[k].ResponsivePageName;
                            var subIsLandingPage = subModules[k].IsLandingPage;
                            var subIsFolderParent = subModules[k].IsParent == 1 || subModules[k].IsParent == "1";
                            
                            //Modified By Madhuri.K On 10-01-2026 - Skip "Overview" items from accordion content - Overview is a separate page and should not appear in accordion section
                            // Check by name (case-insensitive) and also by TagID if it matches the overview page
                            if ((subDisplayTagName && subDisplayTagName.toLowerCase().trim() === "overview") || 
                                (subTagID == overviewTagID && overviewTagID > 0)) {
                                continue;
                            }
                           //Modified By Madhuri.K On 16-01-2026 - Pages inside accordions should be regular list items unless they have actual nested sub-modules
                            var nestedSubModules = getChildTagsForModuleParent(TagID, subTagID, treeChildMenu);
                            
                            // Only create nested accordion if there are actual nested sub-modules (pages should be regular list items)
                            // Filter out any items that are just regular pages (not sub-nodes with children)
                            var validNestedSubModules = [];
                            if (nestedSubModules && nestedSubModules.length > 0) {
                                for (var m = 0; m < nestedSubModules.length; m++) {
                                    if (isDashboardModuleTagId(TagID) && !isDashboardDbTag(nestedSubModules[m])) {
                                        continue;
                                    }
                                    // Skip Overview items
                                    if ((nestedSubModules[m].DisplayTagName && nestedSubModules[m].DisplayTagName.toLowerCase().trim() === "overview") || 
                                        (nestedSubModules[m].TagID == overviewTagID && overviewTagID > 0)) {
                                        continue;
                                    }
                                    validNestedSubModules.push(nestedSubModules[m]);
                                }
                            }
                            
                            // Dashboard leaf pages (PM Dashboard TagID=1) must not expand SM/other-module children with same ParentTagId
                            var allowNestedDashboardAccordion = validNestedSubModules && validNestedSubModules.length > 0;
                            if (isDashboardChildPanelContext(TagID)) {
                                allowNestedDashboardAccordion = subIsFolderParent && isDashboardDbTag(subModules[k]) && allowNestedDashboardAccordion;
                            }
                            if (isDashboardChildPanelContext(TagID) && isDashboardDbTag(subModules[k]) && !subIsFolderParent) {
                                allowNestedDashboardAccordion = false;
                            }
                            
                            // Only create nested accordion if there are valid nested sub-modules
                            if (allowNestedDashboardAccordion) {
                                // This sub-module has nested sub-modules - create nested accordion
                                //Modified By Madhuri.K On 16-01-2026 - Add images for Process, Dashboard, Help Desk, Resources, Knowledge, Configuration, and MIS nested sub-modules in accordion headers
                             // Check modules in priority order: Process (TagID 654) -> Projects -> Dashboard (TagID 21000) -> Help Desk (TagID 405) -> Resources -> Knowledge -> Configuration -> MIS
                                var nestedSubModuleImage = '';
                                var nestedSubModuleImagePath = '';
                                
                                // 1. Check Process module (TagID == 654)
                                if (TagID == 654) {
                                    var processNestedImageName = getProcessSubModuleImage(subDisplayTagName);
                                    if (processNestedImageName) {
                                        nestedSubModuleImage = processNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Processes_Module/';
                                    }
                                }
                                
                                // 2. Check Projects module (TagID needs to be determined - typically the main Projects module TagID)
                                //Modified By Madhuri.K On 20-01-2026 - Add Projects module image support for nested accordions
                                if (!nestedSubModuleImage && TagID != 654 && TagID != 21000 && TagID != 405) {
                                    var projectNestedImageName = getProjectSubModuleImage(subDisplayTagName);
                                    if (projectNestedImageName) {
                                        nestedSubModuleImage = projectNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Projects/';
                                    }
                                }
                                
                                // 3. Check Dashboard module (TagID == 21000)
                                if (!nestedSubModuleImage && TagID == 21000) {
                                    var dashboardNestedImageName = getDashboardSubModuleImage(subDisplayTagName);
                                    if (dashboardNestedImageName) {
                                        nestedSubModuleImage = dashboardNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Dashboard/';
                                    }
                                }
                                
                                // 3a. Check Help Desk module (TagID == 405)
                                //Modified By Madhuri.K On 16-01-2026 - Add Help Desk module image support for nested accordions
                                if (!nestedSubModuleImage && TagID == 405) {
                                    var helpDeskNestedImageName = getHelpDeskSubModuleImage(subDisplayTagName);
                                    if (helpDeskNestedImageName) {
                                        nestedSubModuleImage = helpDeskNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Help_Desk_Module/';
                                    }
                                }
                                
                                // 4. Check Resources module (if Dashboard and Help Desk didn't match)
                                if (!nestedSubModuleImage) {
                                    var resourcesNestedImageName = getResourcesSubModuleImage(subDisplayTagName);
                                    if (resourcesNestedImageName) {
                                        nestedSubModuleImage = resourcesNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Resources/';
                                    }
                                }
                                
                                // 5. Check Knowledge module (before Configuration to prevent false matches)
                                //Modified By Madhuri.K On 16-01-2026 - Check Knowledge module before Configuration to ensure correct path for nested accordions
                                if (!nestedSubModuleImage) {
                                    var knowledgeNestedImageName = getKnowledgeSubModuleImage(subDisplayTagName);
                                    if (knowledgeNestedImageName) {
                                        nestedSubModuleImage = knowledgeNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Knownalge/';
                                    }
                                }
                                
                                // 6. Check Configuration module (if Knowledge didn't match and not Dashboard module)
                                if (!nestedSubModuleImage && TagID != 21000) {
                                    var configurationNestedImageName = getConfigurationSubModuleImage(subDisplayTagName);
                                    if (configurationNestedImageName) {
                                        nestedSubModuleImage = configurationNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/Configuration_Module/';
                                    }
                                }
                                
                                // 7. Check MIS module (if Configuration didn't match)
                                if (!nestedSubModuleImage) {
                                    var misNestedImageName = getMISSubModuleImage(subDisplayTagName);
                                    if (misNestedImageName) {
                                        nestedSubModuleImage = misNestedImageName;
                                        nestedSubModuleImagePath = '../../Whizible2.0-new/dist/img/Navigation_Tree_Icons/MIS/';
                                    }
                                }
                                
                                // Build image HTML if image found
                                var nestedAccordionImageHTML = '';
                                if (nestedSubModuleImage && nestedSubModuleImagePath) {
                                    //Modified By Madhuri.K On 16-01-2026 - Apply blue color filter for all modules to match parent icon color
                                    var nestedImageStyle = 'width: 17px; height: 25px; margin-right: 1px; vertical-align: middle; display: inline-block; object-fit: contain;';
                                    
                                    // Apply blue color filter for all modules to match parent icon color
                                    var nestedBlueFilter = getColorFilter('#4263c1');
                                    if (nestedBlueFilter && nestedBlueFilter !== 'none') {
                                        nestedImageStyle += ' filter: ' + nestedBlueFilter + ';';
                                    }
                                    
                                    nestedAccordionImageHTML = '<img src="' + nestedSubModuleImagePath + nestedSubModuleImage + '" alt="" style="' + nestedImageStyle + '">';
                                }
                                
                                childHTML += '<li class="child-panel-accordion-item" data-tagid="' + subTagID + '">';
                                childHTML += '<input type="hidden" id="header_' + subTagID + '" value="' + subDisplayHeader + '">';
                                childHTML += '<div class="child-panel-accordion-header" onclick="toggleAccordion(this)">';
                                childHTML += '<span style="flex: 1; cursor: pointer; display: flex; align-items: center;">' + nestedAccordionImageHTML + '<span>' + subDisplayTagName + '</span></span>';
                                childHTML += '<span class="child-panel-accordion-toggle"><i class="fas fa-chevron-right"></i></span>';
                                childHTML += '</div>';
                                childHTML += '<div class="child-panel-accordion-content">';
                                childHTML += '<ul>';
                                
                                // Add nested sub-modules
                                for (var n = 0; n < validNestedSubModules.length; n++) {
                                    if (isDashboardChildPanelContext(TagID) && !isDashboardDbTag(validNestedSubModules[n])) {
                                        continue;
                                    }
                                    var nestedDisplayPageName = validNestedSubModules[n].DisplayPageName;
                                    var nestedDisplayTagName = validNestedSubModules[n].DisplayTagName;
                                    var nestedTagID = validNestedSubModules[n].TagID;
                                    var nestedDisplayHeader = validNestedSubModules[n].DisplayHeader;
                                    var nestedTemplateID = validNestedSubModules[n].TemplateID;
                                    var nestedResponsivePageName = validNestedSubModules[n].ResponsivePageName;
                                    var nestedIsLandingPage = validNestedSubModules[n].IsLandingPage;
                                    
                                    // Skip "Overview" items
                                    if ((nestedDisplayTagName && nestedDisplayTagName.toLowerCase().trim() === "overview") || 
                                        (nestedTagID == overviewTagID && overviewTagID > 0)) {
                                        continue;
                                    }
                                    
                                    var nestedPageUrl = nestedDisplayPageName;
                                    if (nestedIsLandingPage == 1) {
                                        if (subTagID == 10) {
                                            nestedPageUrl = TimesheetLandingPage + "?TagID=" + subTagID;
                                        } else if (subTagID == 405 && nestedTagID == 405) {
                                            nestedPageUrl = HelpDeskLandingPage + "?TagID=" + nestedTagID;
                                        }
                                    }
                                    
                                    //Modified By Madhuri.K On 16-01-2026 - Add Font Awesome circle icon for pages inside accordion content
                                 childHTML += '<li><input type="hidden" id="header_' + nestedTagID + '" value="' + nestedDisplayHeader + '"><a id="a_' + nestedTemplateID + nestedTagID + '" onclick="ChangeTabs(this, \'' + encodeURI(nestedPageUrl) + '\',' + nestedTagID + ',' + TagID + ',\'' + nestedTemplateID + '\',\'' + nestedResponsivePageName + '\');" style="cursor: pointer;"><i class="far fa-circle page-circle-icon" style="font-size: 8px; margin-right: 8px; vertical-align: middle;"></i>' + nestedDisplayTagName + '</a></li>';
                                }
                                
                                childHTML += '</ul>';
                                childHTML += '</div>';
                                childHTML += '</li>';
                            } else {
                                // Regular sub-module without nested sub-modules
                                var subPageUrl = subDisplayPageName;
                                if (subIsLandingPage == 1) {
                                    if (childTagID == 10) {
                                        subPageUrl = TimesheetLandingPage + "?TagID=" + childTagID;
                                    } else if (childTagID == 405 && subTagID == 405) {
                                        subPageUrl = HelpDeskLandingPage + "?TagID=" + subTagID;
                                    }
                                }
                                
                                //Modified By Madhuri.K On 16-01-2026 - Add Font Awesome circle icon for pages inside accordion content
                                childHTML += '<li><input type="hidden" id="header_' + subTagID + '" value="' + subDisplayHeader + '"><a id="a_' + subTemplateID + subTagID + '" onclick="ChangeTabs(this, \'' + encodeURI(subPageUrl) + '\',' + subTagID + ',' + TagID + ',\'' + subTemplateID + '\',\'' + subResponsivePageName + '\');" style="cursor: pointer;"><i class="far fa-circle page-circle-icon" style="font-size: 8px; margin-right: 8px; vertical-align: middle;"></i>' + subDisplayTagName + '</a></li>';
                            }
                        }
                        }
                        //Modified By Madhuri.K On 16-01-2026 - Close accordion structure even if no sub-modules (for Resources, Configuration, MIS, Dashboard sub-nodes with images)
                        
                        childHTML += '</ul>';
                        childHTML += '</div>';
                        childHTML += '</li>';
                    } else {
                        // Regular list item for items without sub-modules (pages, not sub-nodes)
                      //Modified By Madhuri.K On 21-01-2026 - Remove hardcoded text color so selected state can turn text white via CSS
                        childHTML += '<li><input type="hidden" id="header_' + childTagID + '" value="' + childDisplayHeader + '"><a id="a_' + childTemplateID + childTagID + '" onclick="ChangeTabs(this, \'' + encodeURI(pageUrl) + '\',' + childTagID + ',' + TagID + ',\'' + childTemplateID + '\',\'' + childResponsivePageName + '\');" style="cursor: pointer;"><i class="fas fa-circle page-circle-icon" style="font-size: 8px; margin-right: 8px; vertical-align: middle;"></i>' + childDisplayTagName + '</a></li>';
                    }
                }
                } catch (exChildPanelItem) {
                    console.error("showChildPanel skipped item TagID " + (childTagMasters[j] ? childTagMasters[j].TagID : j) + ":", exChildPanelItem);
                }
            }
            
            childHTML += "</ul>";
            
            $("#childPanelHeader").text(TagName);
            //Modified By Madhuri.K On 10-01-2026 - Store parent TagID in child panel header for cross-module search functionality
            $("#childPanelHeader").attr("data-parent-tagid", TagID);
            $("#childPanelContent").html("");
            $("#childPanelContent").html(childHTML);
            bindNavImageFallback($("#childPanelContent"));
            setTimeout(runDeferredChildPanelNavigation, 0);
            //Modified By Madhuri.K On 10-01-2026 - Preserve search text when clicking parent icons - only clear when user manually clears it
            var existingSearchText = $("#childPanelSearch").val();
            // Don't clear search text - always preserve it so user can see what they searched
            // Search text will only be cleared when user manually removes it from the input field
            $("#childPanel").addClass("active");
            //Added By Madhuri.K On 10-01-2026 - Add class to body to adjust page content when child panel is open
            // Modified By Madhuri.K On 07-07-2026 
            $("body").addClass("child-panel-open has-child-selection child-tree-expanded");
            //Added By Madhuri.K On 21-01-2026 - Ensure floating toggle shows collapse icon when panel is open
            setChildPanelToggleState(true);
            // Explicitly show toggle controls
            var $toggleControls = $("#childPanelToggleControls");
            if ($toggleControls.length > 0) {
                $toggleControls.css({
                    "display": "flex",
                    "visibility": "visible",
                    "opacity": "1"
                });
            }
            
            //Modified By Madhuri.K On 10-01-2026 - If search text exists, re-apply search filter after panel opens
            if (preserveSearch && existingSearchText && safeNavLabel(existingSearchText).trim() != "") {
                setTimeout(function() {
                    // Re-run search to filter the newly opened child panel
                    // Use performSearchChildPanel directly to avoid debounce and recursive call issues
                    if (!isSearchChildPanelExecuting) {
                        isSearchChildPanelExecuting = true;
                        try {
                            performSearchChildPanel();
                        } finally {
                            setTimeout(function() {
                                isSearchChildPanelExecuting = false;
                            }, 2);
                        }
                    }
                }, 2);
            }
            } catch (errorShowChildPanel) {
                // Added By Madhuri.K On 29-01-2026 - Error handling to ensure child panel shows even if there's an error
                console.error("Error in showChildPanel for TagID " + TagID + ":", errorShowChildPanel);
                var headerText = TagName && TagName != "" && TagName != "undefined" ? TagName : "Menu";
                $("#childPanelHeader").text(headerText);
                $("#childPanelHeader").attr("data-parent-tagid", TagID);
                var fallbackHtml = "<ul>";
                try {
                    var fallbackTags = parseInt(TagID, 10) === DASHBOARD_MODULE_TAGID
                        ? getModuleChildTags(DASHBOARD_MODULE_TAGID, treeChildMenu)
                        : GetTagMastersByParentTagID(TagID, treeChildMenu);
                    if (fallbackTags && fallbackTags.length > 0) {
                        for (var fb = 0; fb < fallbackTags.length; fb++) {
                            var fbName = safeNavLabel(fallbackTags[fb].DisplayTagName) || ("Item " + fallbackTags[fb].TagID);
                            fallbackHtml += "<li style='padding: 6px 10px;'>" + fbName + "</li>";
                        }
                    } else {
                        fallbackHtml += "<li style='padding: 10px; color: #999;'>No menu items available.</li>";
                    }
                } catch (exFallback) {
                    fallbackHtml += "<li style='padding: 10px; color: #999;'>Unable to load menu items.</li>";
                }
                fallbackHtml += "</ul>";
                $("#childPanelContent").html(fallbackHtml);
                $("#childPanel").addClass("active");
                // Modified By Madhuri.K On 07-07-2026 
                $("body").addClass("child-panel-open has-child-selection child-tree-expanded");
                // Try to show toggle controls
                var $toggleControlsError = $("#childPanelToggleControls");
                if ($toggleControlsError.length > 0) {
                    $toggleControlsError.css({
                        "display": "flex",
                        "visibility": "visible",
                        "opacity": "1"
                    });
                }
            }
        }
        
        //added by Aditya J. on 12-06-2026 for remove blue horizontal line below header on load and after child panel close
        function syncParentPanelHeaderHeight() {
            try {
                var header = document.querySelector(".main-header");
                if (!header) return;
                var headerHeight = header.offsetHeight;
                if (headerHeight > 0) {
                    document.documentElement.style.setProperty("--nav-header-height", headerHeight + "px");
                }
            } catch (e) { }
        }

        // Modified By Madhuri.K On 07-07-2026 
        function hideChildPanel(keepParentIconsNarrow) {
            keepParentIconsNarrow = keepParentIconsNarrow === true;
            //Added By Madhuri.K On 10-01-2026 - Immediately remove blue color from selected items and set white background before closing panel
            // FIRST: Immediately set white background on selected items using setProperty with important flag (do this BEFORE removing active class)
            $(".child-panel-content li.selected > a, .child-panel-content li.active > a").each(function() {
                this.style.setProperty("background-color", "#ffffff", "important");
                this.style.setProperty("color", "#747070", "important");
            });
            $(".child-panel-accordion-header.selected, .child-panel-accordion-header.active").each(function() {
                this.style.setProperty("background-color", "#ffffff", "important");
                this.style.setProperty("color", "#747070", "important");
                $(this).find("span").each(function() {
                    this.style.setProperty("color", "#747070", "important");
                });
            });
            
            // SECOND: Remove selected/active classes immediately to remove blue highlighting
            $(".child-panel-content li").removeClass("selected active");
            $(".child-panel-accordion-header").removeClass("selected active");
            
            // THIRD: Remove active class to trigger closing (this happens after white background is set)
            $("#childPanel").removeClass("active");
            //Added By Madhuri.K On 21-01-2026 - Update toggle state to show expand icon when panel is closed
            setChildPanelToggleState(false);
           // Search text will only be cleared when user manually removes it from the input field
        //    Modified By Madhuri.K On 07-07-2026 
           if (keepParentIconsNarrow) {
                // Collapse child tree only — keep narrow parent icon column
                $("body").addClass("child-panel-open has-child-selection");
                $("body").removeClass("child-tree-expanded");
            } else {
                // Full close — restore wide parent sidebar with icon + text
                $("body").removeClass("child-panel-open child-tree-expanded has-child-selection");
            }
            //Added By Madhuri.K On 10-01-2026 - Ensure navigation tree background stays consistent when closing child panel
            $(".sidebar-menu li").removeClass("hover active");
            $(".treeview-menu li").removeClass("hover active");
            $("#treeMenu, .parent-panel .sidebar-menu, .parent-panel .main-sidebar").each(function() {
                this.style.removeProperty("background-color");
            });
            syncParentPanelHeaderHeight();

            //Added By Madhuri.K On 21-01-2026 - When panel is closed (by any means), show only expand icon
            setChildPanelToggleState(false);
        }

        //Added By Madhuri.K On 21-01-2026 - Helper to toggle floating expand/collapse controls for child panel
        function setChildPanelToggleState(isOpen) {
            try {
                var btnCollapse = document.getElementById("btnCollapseChildPanel");
                var btnExpand = document.getElementById("btnExpandChildPanel");
                var toggleControls = document.getElementById("childPanelToggleControls");
                
                if (!btnCollapse || !btnExpand || !toggleControls) {
                    // Fallback to querySelector if IDs not found
                    var panelToggle = document.querySelector(".child-panel-toggle-controls");
                    if (!panelToggle) return;
                    var btns = panelToggle.querySelectorAll(".child-panel-btn");
                    if (!btns || btns.length < 2) return;
                    btnCollapse = btns[0];
                    btnExpand = btns[1];
                }

                if (isOpen) {
                    // Show collapse, hide expand
                    if (btnCollapse) btnCollapse.style.display = "inline-flex";
                    if (btnExpand) btnExpand.style.display = "none";
                    if (toggleControls) toggleControls.style.display = "flex";
                } else {
                    // Show expand, hide collapse
                    if (btnCollapse) btnCollapse.style.display = "none";
                    if (btnExpand) btnExpand.style.display = "inline-flex";
                    if (toggleControls) toggleControls.style.display = "flex";
                }
            } catch (exToggle) {
                console && console.log && console.log("Error in setChildPanelToggleState:", exToggle);
            }
        }
        // Modified By Madhuri.K On 07-07-2026 
        function expandParentSidebarWide() {
            try {
                hideChildPanel(false);
            } catch (exWide) {
                console && console.log && console.log("Error in expandParentSidebarWide:", exWide);
            }
        }

        function collapseParentSidebarNarrow() {
            try {
                hideChildPanel(true);
                setChildPanelToggleState(false);
            } catch (exNarrow) {
                console && console.log && console.log("Error in collapseParentSidebarNarrow:", exNarrow);
            }
        }

        //Added By Madhuri.K On 21-01-2026 - Header icons to collapse/expand child panel without losing selection
        function collapseChildPanel() {
            try {
                // Modified By Madhuri.K On 07-07-2026 
                // Close child tree but keep narrow parent icons visible (SS2)
                hideChildPanel(true);
                setChildPanelToggleState(false);
            } catch (exCollapse) {
                console && console.log && console.log("Error in collapseChildPanel:", exCollapse);
            }
        }

        function expandChildPanel() {
            try {
                var $childPanel = $("#childPanel");
                if ($childPanel.length > 0) {
                    // Re-open the panel and restore the selected parent's child content
                    $childPanel.addClass("active");
                    // Modified By Madhuri.K On 07-07-2026 
                    $("body").addClass("child-panel-open has-child-selection child-tree-expanded");

                    // Toggle control buttons: open state
                    setChildPanelToggleState(true);
                    
                    // Re-display the selected parent's child panel content
                    // Find the currently selected parent icon and refresh its child panel
                    var $selectedParent = $('.parent-panel .sidebar-menu > li.parent-icon.selected');
                    if ($selectedParent && $selectedParent.length > 0) {
                        var parentTagId = $selectedParent.data('tagid') || $selectedParent.attr('id').replace('mainmenu_', '');
                        if (parentTagId && typeof showChildPanel === 'function') {
                            // Re-show the child panel for the selected parent (preserve search if any)
                            var existingSearchText = $("#childPanelSearch").val();
                            var preserveSearch = existingSearchText && existingSearchText.trim() != '';
                            showChildPanel(parentTagId, preserveSearch);
                        }
                    }
                }
            } catch (exExpand) {
                console && console.log && console.log("Error in expandChildPanel:", exExpand);
            }
        }
        
        //Added By Madhuri.K On 10-01-2026 - Toggle accordion for sub-modules in child panel, allows expand/collapse functionality with smooth animations
        //Added flag to prevent multiple simultaneous accordion toggles
        var isTogglingAccordion = false;
        
        function toggleAccordion(element) {
            // Prevent multiple simultaneous toggles
            if (isTogglingAccordion) {
                return;
            }
            
            isTogglingAccordion = true;
            
            try {
                var $header = $(element);
                var $content = $header.next('.child-panel-accordion-content');
                var $item = $header.closest('.child-panel-accordion-item');
                
                // Check current state to prevent unnecessary toggles
                var isCurrentlyOpen = $header.hasClass('active') && $content.hasClass('active');
                
                // Modified By Madhuri.K On 10-01-2026 - Only close sibling accordions at the same level, not parent or nested accordions
                // Find the direct parent container (ul) that contains this accordion item
                var $parentContainer = $item.parent();
                
                // Only close sibling accordion items within the same parent container (same level)
                // This ensures parent accordions stay open and only siblings at the same level close
                $parentContainer.find('.child-panel-accordion-item').not($item).each(function() {
                    $(this).find('.child-panel-accordion-header').removeClass('active');
                    $(this).find('.child-panel-accordion-content').removeClass('active').css("max-height", "0");
                });
                
                // Toggle current accordion only if state needs to change
                if (isCurrentlyOpen) {
                    $header.removeClass('active');
                    $content.removeClass('active').css("max-height", "0");
                } else {
                    $header.addClass('active');
                    $content.addClass('active').css("max-height", "1000px"); // Increased from 500px to show all items
                }
            } finally {
                // Reset flag after a short delay
                setTimeout(function() {
                    isTogglingAccordion = false;
                }, 100);
            }
        }
        
        //Modified By Madhuri.K On 10-01-2026 - Enhanced search to search across all modules and their child pages, not just selected module
        //Added debounce and recursive call prevention to fix continuous console calls issue
        var searchChildPanelTimeout = null;
        var isSearchChildPanelExecuting = false;
        
        function SearchChildPanel(e) {
            // Prevent event propagation if event object exists
            if (e && e.preventDefault) {
                e.preventDefault();
            }
            
            // Clear any pending timeout
            if (searchChildPanelTimeout) {
                clearTimeout(searchChildPanelTimeout);
                searchChildPanelTimeout = null;
            }
            
            // Debounce the search - wait 300ms after user stops typing
            searchChildPanelTimeout = setTimeout(function() {
                // Prevent recursive calls
                if (isSearchChildPanelExecuting) {
                    return;
                }
                
                isSearchChildPanelExecuting = true;
                
                try {
                    performSearchChildPanel();
                } finally {
                    // Reset flag after a short delay to allow DOM updates
                    setTimeout(function() {
                        isSearchChildPanelExecuting = false;
                    }, 100);
                }
            }, 300);
        }
        
        function performSearchChildPanel() {
            var rawSearchVal = $("#childPanelSearch").val();
            var searchText = rawSearchVal ? safeNavLabel(rawSearchVal).toLowerCase().trim() : "";
            var $content = $("#childPanelContent");
            var currentParentTagID = $("#childPanelHeader").attr("data-parent-tagid");             // Modified By Madhuri.K On 28-01-2026 - Get module name from the top header to identify selected module
            var selectedModuleFromHeader = "";
            var headerElement = document.getElementById("mainHeadingTop");
            if (headerElement) {
                // Try to get text content first (cleaner than innerHTML)
                var headerText = headerElement.textContent || headerElement.innerText;
                if (!headerText && headerElement.innerHTML) {
                    headerText = headerElement.innerHTML;
                }
                
                if (headerText) {
                    headerText = headerText.trim();
                    // Extract module name from "Selected Module : ConfigurationModule > Page" format
                    // First remove "Selected Module :" prefix if it exists
                    if (headerText.indexOf("Selected Module") > -1) {
                        headerText = headerText.replace(/Selected Module\s*:\s*/i, "").trim();
                    }
                    
                    // Extract module name from "Module > Page" format
                    if (headerText.indexOf(">") > -1) {
                        selectedModuleFromHeader = headerText.split(">")[0].trim();
                    } else {
                        selectedModuleFromHeader = headerText;
                    }
                }
            }
            
            // Remove any previous "no results" messages
            $content.find(".search-no-results-message").remove();
            
            if (searchText == "") {
                //Modified By Madhuri.K On 27-01-2026 - When search is cleared, show all items and all parent icons
                // Show all items when search is empty
                $content.find("li").show();
                $content.find(".child-panel-accordion-item").show();
                $content.find(".child-panel-accordion-header").show();
                // Reset accordion states
                $content.find(".child-panel-accordion-content").removeClass("active").css("max-height", "0");
                $content.find(".child-panel-accordion-header").removeClass("active");
                
                // Remove all search highlights when search is cleared
                $content.find("mark").each(function() {
                    var $mark = $(this);
                    $mark.replaceWith($mark.text());
                });
                
                //Modified By Madhuri.K On 28-01-2026 - Remove search-match-highlight from current parent icon when search is cleared
                if (currentParentTagID) {
                    var $currentParentIcon = $("#mainmenu_" + currentParentTagID);
                    if ($currentParentIcon.length > 0) {
                        //Modified By Madhuri.K On 28-01-2026 - Remove search-match-highlight class if present
                        $currentParentIcon.removeClass("search-match-highlight");
                        // Clear inline styles from current parent icon
                        var $parentLink = $currentParentIcon.find("> a");
                        if ($parentLink.length > 0) {
                            var linkElement = $parentLink[0];
                            if (linkElement) {
                                linkElement.style.removeProperty("background-color");
                                linkElement.style.removeProperty("border-radius");
                                linkElement.style.removeProperty("border");
                                linkElement.style.removeProperty("box-shadow");
                                linkElement.style.removeProperty("margin");
                            }
                            // Reset icon filter
                            var $iconImage = $parentLink.find("i img");
                            if ($iconImage.length > 0) {
                                $iconImage[0].style.removeProperty("filter");
                            }
                        }
                    }
                }
                
                //Modified By Madhuri.K On 28-01-2026 - Reset parent and child panels when search is cleared
                // Show all parent icons that were hidden during search
                $(".parent-panel .sidebar-menu > li.parent-icon").show();
                
                // Reapply selected state styling to the currently selected module
                // First, try to match using the header module name for most accurate identification
                var moduleTagIDToSelect = currentParentTagID;
                
                // Modified By Madhuri.K On 29-01-2026 - Try to find module by name from header
                if (selectedModuleFromHeader && selectedModuleFromHeader.length > 0) {
                    // Search through parent icons to find one that matches the module name
                    var found = false;
                    var headerModuleLower = selectedModuleFromHeader.toLowerCase();
                    
                    $(".parent-panel .sidebar-menu > li.parent-icon").each(function() {
                        var $parentIcon = $(this);
                        
                        // Try multiple ways to extract the module name
                        var parentText = $parentIcon.text().trim().toLowerCase();
                        
                        // Get direct text from the link element (first anchor)
                        var $link = $parentIcon.find("> a");
                        var linkText = "";
                        if ($link.length > 0) {
                            // Get text content and remove whitespace
                            linkText = $link.text().trim().toLowerCase();
                        }
                        
                        // Check for exact match or if header module starts with parent text
                        if (parentText === headerModuleLower || 
                            linkText === headerModuleLower ||
                            headerModuleLower.indexOf(parentText) === 0 ||
                            parentText.indexOf(headerModuleLower) === 0) {
                            
                            moduleTagIDToSelect = $parentIcon.attr("data-tagid");
                            found = true;
                            return false; // Break the loop
                        }
                    });
                    
                    // Debug: Log if match found
                    if (!found) {
                        console.log("Module match failed. Header: " + selectedModuleFromHeader + ", Parent TagID: " + currentParentTagID);
                    }
                }
                
                // Clear selected state from all parent icons first
                $(".parent-panel .sidebar-menu > li.parent-icon").each(function() {
                    var $icon = $(this);
                    $icon.removeClass("selected active");
                    var $link = $icon.find("> a");
                    if ($link.length > 0) {
                        var linkElement = $link[0];
                        if (linkElement) {
                            linkElement.style.removeProperty("background-color");
                            linkElement.style.removeProperty("border-radius");
                            linkElement.style.removeProperty("border");
                            linkElement.style.removeProperty("box-shadow");
                            linkElement.style.removeProperty("margin");
                        }
                        // Reset icon filter
                        var $iconImage = $link.find("i img");
                        if ($iconImage.length > 0) {
                            $iconImage[0].style.removeProperty("filter");
                        }
                    }
                });
                
                // Apply selected styling to the identified module
                if (moduleTagIDToSelect) {
                    var $currentParentIcon = $("#mainmenu_" + moduleTagIDToSelect);
                    if ($currentParentIcon.length > 0) {
                        // Ensure the selected/active classes are applied
                        $currentParentIcon.addClass("selected active");
                        
                        // Reapply the blue background styling for selected state
                        var $parentLink = $currentParentIcon.find("> a");
                        if ($parentLink.length > 0) {
                            var linkElement = $parentLink[0];
                            if (linkElement) {
                                linkElement.style.setProperty("background-color", "#4263c1", "important");
                                linkElement.style.setProperty("border-radius", "8px", "important");
                                linkElement.style.setProperty("border", "2px solid #4263c1", "important");
                                linkElement.style.setProperty("box-shadow", "0 2px 8px rgba(66, 99, 193, 0.4)", "important");
                                linkElement.style.setProperty("margin", "2px", "important");
                            }
                            // Apply white filter to icon image for selected state
                            var $iconImage = $parentLink.find("i img");
                            if ($iconImage.length > 0) {
                                $iconImage[0].style.setProperty("filter", "brightness(0) saturate(100%) invert(100%)", "important");
                            }
                        }
                    }
                }
                
                //Modified By Madhuri.K On 28-01-2026 - Keep child panel open when search is cleared, don't collapse it
                // Child panel will remain open showing all items
                
                return;
            }
            
            //Modified By Madhuri.K On 28-01-2026 - Search only within the current module, not globally across all modules
            // Get the currently selected module ID from the child panel header
            var currentModuleTagID = $("#childPanelHeader").attr("data-parent-tagid");
            
            // Don't modify parent icons - only search within current module's child panel
            // Hide all items in child panel first
            $content.find("li").hide();
            $content.find(".child-panel-accordion-item").hide();
            $content.find(".child-panel-accordion-header").hide();
            
            var hasMatches = false;
            
            // Robust search: evaluate TEXT at the <li> level so that
            // deeper nested links (sub module of sub module pages) are also included.
            // Text sources (combined):
            //   - hidden header_<TagID> values inside the li
            //   - all link texts inside the li
            $content.find("li").each(function () {
                var $item = $(this);
                
                // Only consider real menu items that have at least one link
                var $links = $item.find("a");
                if ($links.length === 0) {
                    return;
                }
                
                // Build searchable text for this li
                var headerText = "";
                var $hiddenHeader = $item.find("input[type='hidden'][id^='header_']").first();
                if ($hiddenHeader.length > 0) {
                    headerText = $hiddenHeader.val() || "";
                }
                
                var linksText = "";
                $links.each(function () {
                    var $lnk = $(this);
                    var $span = $lnk.find(".child-link-text").first();
                    var spanOriginal = ($span.length && $span.attr("data-original-text"))
                        ? $span.attr("data-original-text")
                        : "";
                    var txt = spanOriginal || $lnk.text() || "";
                    if (txt) {
                        linksText += " " + txt;
                    }
                });
                
                var combinedRaw = (headerText + " " + linksText);
                
                // Normalize both item text and search text for robust matching
                var text = (combinedRaw || "")
                    .replace(/<[^>]*>/g, "")   // strip any HTML that might have slipped in
                    .replace(/\s+/g, " ")      // collapse whitespace
                    .toLowerCase()
                    .trim();
                var normalizedSearch = (searchText || "")
                    .replace(/\s+/g, " ")
                    .toLowerCase()
                    .trim();
                
                if (!text || !normalizedSearch) {
                    return;
                }
                
                // 1) Direct substring match (e.g. 'effort' in 'effort distribution weekly views')
                var isMatch = text.indexOf(normalizedSearch) !== -1;
                
                // 2) Fallback: all search words must appear somewhere in the item text
                if (!isMatch) {
                    var words = normalizedSearch.split(/\s+/).filter(function (w) { return w.length > 0; });
                    if (words.length > 0) {
                        isMatch = words.every(function (w) {
                            return text.indexOf(w) !== -1;
                        });
                    }
                }
                
                if (!isMatch) {
                    return;
                }
                
                hasMatches = true;
                
                // Show the li itself
                $item.show();
                
                // If this li is inside accordion content, make sure its parent
                // accordion item and header are visible and expanded
                var $accordionContent = $item.closest(".child-panel-accordion-content");
                if ($accordionContent.length > 0) {
                    var $accordionItem = $accordionContent.closest(".child-panel-accordion-item");
                    var $accordionHeader = $accordionItem.find(".child-panel-accordion-header");
                    
                    if ($accordionItem.length > 0) {
                        $accordionItem.show();
                    }
                    if ($accordionHeader.length > 0) {
                        $accordionHeader.show();
                        $accordionHeader.addClass("active");
                    }
                    
                    $accordionContent.addClass("active").css("max-height", "1000px");
                }
                
                // If this li itself is an accordion item with header, ensure header is visible
                var $ownHeader = $item.children(".child-panel-accordion-header");
                if ($ownHeader.length > 0) {
                    $ownHeader.show();
                }
                
                // Apply search highlight to the first link in this li
                var $firstLink = $links.first();
                highlightChildPanelLink($firstLink, searchText);
            });
            
            // Show "no results" message if nothing matched in current panel
            if (!hasMatches) {
                var messageHTML = '<div class="search-no-results-message" style="padding: 6px; text-align: center; color: #ff5f5f; font-size: 12px;">' +
                    '<i class="fas fa-info-circle" style="margin-right: 8px;"></i>' +
                    'No results found in this module</div>';
                $content.append(messageHTML);
            }
        }
        
        //Added By Madhuri.K On 10-01-2026 - Helper function to filter child panel content by search text
        //Added flag to prevent multiple simultaneous executions
        var isFilteringChildPanel = false;
        
        //Added By Madhuri.K On 10-01-2026 - Function to highlight search text in HTML elements
        function highlightSearchText(text, searchText) {
            if (!searchText || searchText.trim() === "" || !text) {
                return text;
            }
            
            // Escape special regex characters in search text
            var escapedSearchText = searchText.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
            // Create case-insensitive regex
            var regex = new RegExp('(' + escapedSearchText + ')', 'gi');
            // Replace matching text with highlighted version
            return text.replace(regex, '<mark>$1</mark>');
        }

        //Added By Madhuri.K On 29-01-2026 - Preserve child-panel link HTML (icons) when highlighting search text
        // This prevents losing bullet icons and spacing for pages inside nested sub-modules.
        function ensureChildPanelLinkTextSpan($link) {
            if (!$link || $link.length === 0) return;
            if ($link.find(".child-link-text").length > 0) return;

            var $icon = $link.children("i").first();
            var iconNode = $icon.length > 0 ? $icon[0] : null;

            // Snapshot nodes BEFORE inserting the span (includes text nodes)
            var nodes = [];
            $link.contents().each(function() { nodes.push(this); });

            var $span = $("<span class='child-link-text'></span>");
            if (iconNode) {
                $span.insertAfter($icon);
            } else {
                $link.prepend($span);
            }

            // Move all non-icon nodes into the span (preserves text + whitespace)
            // Only move text nodes and inline elements into the span.
            // This preserves nested lists/accordions (UL/LI) so deeper sub-modules remain searchable and structurally intact.
            for (var i = 0; i < nodes.length; i++) {
                var node = nodes[i];
                if (!node) continue;
                if (iconNode && node === iconNode) continue;
                if (node === $span[0]) continue;

                if (node.nodeType === 3) {
                    // Text node
                    $span.append(node);
                } else if (node.nodeType === 1) {
                    var tag = node.tagName ? node.tagName.toUpperCase() : "";
                    // Block/list/container tags should be left in place
                        var blockTags = { 'UL':1,'OL':1,'LI':1,'DIV':1,'SECTION':1,'NAV':1,'TABLE':1,'TD':1,'TR':1,'TBODY':1,'INPUT':1 };
                    if (!blockTags[tag]) {
                        // Inline element - move into span
                        $span.append(node);
                    } else {
                        // Leave block/list nodes where they are so nested pages are preserved
                    }
                }
            }
        }

        function highlightChildPanelLink($link, searchText) {
            if (!$link || $link.length === 0) return;
            ensureChildPanelLinkTextSpan($link);
            var $textSpan = $link.find(".child-link-text").first();
            if ($textSpan.length === 0) return;

            // Cache original text once so repeated searches can restore correctly
            if (!$textSpan.attr("data-original-text")) {
                $textSpan.attr("data-original-text", $textSpan.text());
            }

            var originalText = $textSpan.attr("data-original-text") || "";
            if (!searchText || searchText.trim() === "") {
                $textSpan.text(originalText);
                return;
            }

            var lowerSearch = searchText.toLowerCase();

            // If this link's text contains the search, highlight it
            if (originalText.toLowerCase().indexOf(lowerSearch) > -1) {
                $textSpan.html(highlightSearchText(originalText, searchText));
                return;
            }

            // Otherwise, try to find a deeper/descendant <a> within the same li whose text matches
            var $closestLi = $link.closest('li');
            if ($closestLi && $closestLi.length > 0) {
                var $matchingDescendantLink = $closestLi.find('a').filter(function() {
                    var txt = $(this).text() || '';
                    return txt.toLowerCase().indexOf(lowerSearch) > -1;
                }).first();

                if ($matchingDescendantLink && $matchingDescendantLink.length > 0) {
                    ensureChildPanelLinkTextSpan($matchingDescendantLink);
                    var $dSpan = $matchingDescendantLink.find('.child-link-text').first();
                    if ($dSpan.length > 0) {
                        if (!$dSpan.attr('data-original-text')) {
                            $dSpan.attr('data-original-text', $dSpan.text());
                        }
                        var dOriginal = $dSpan.attr('data-original-text') || '';
                        $dSpan.html(highlightSearchText(dOriginal, searchText));
                        return;
                    }
                }
            }

            // Fallback - restore original text if nothing matched
            $textSpan.text(originalText);
        }
        
        //Added By Madhuri.K On 10-01-2026 - Function to remove search highlights from elements
        function removeSearchHighlights($element) {
            $element.find('mark').each(function() {
                var $mark = $(this);
                $mark.replaceWith($mark.text());
            });
        }
        
        function filterChildPanelBySearch(searchText, parentTagID, matchingChildPages) {
            // Prevent multiple simultaneous executions
            if (isFilteringChildPanel) {
                return false; // Return false if already filtering
            }
            
            isFilteringChildPanel = true;
            
            try {
                var $content = $("#childPanelContent");
                
                // Remove any "no results" messages immediately
                $content.find(".search-no-results-message").remove();
                
                // Remove existing highlights before applying new ones
                if (searchText && searchText.trim() !== "") {
                    $content.find("mark").each(function() {
                        var $mark = $(this);
                        $mark.replaceWith($mark.text());
                    });
                }
                
                // Remove existing highlights before applying new ones
                if (searchText && searchText.trim() !== "") {
                    $content.find("mark").each(function() {
                        var $mark = $(this);
                        $mark.replaceWith($mark.text());
                    });
                }
                
                // Track which accordions need to be opened
                var accordionsToOpen = {};
                
                // Collect all items to show/hide first (batch DOM operations)
                var itemsToShow = [];
                var itemsToHide = [];
                var accordionsToShow = [];
                var accordionsToHide = [];
                
                // Get list of matching child TagIDs for this parent
                var matchingChildTagIDs = matchingChildPages[parentTagID] || [];
                var hasMatches = false; // Track if we found any matches
                
                // If we have matching child TagIDs, we definitely have matches
                if (matchingChildTagIDs && matchingChildTagIDs.length > 0) {
                    hasMatches = true;
                }
                
                // First, collect all items to hide
                $content.find("li").each(function() {
                    itemsToHide.push($(this));
                });
                $content.find(".child-panel-accordion-item").each(function() {
                    accordionsToHide.push($(this));
                });
                $content.find(".child-panel-accordion-header").each(function() {
                    accordionsToHide.push($(this));
                });
                
                // Track which items we've already added to avoid duplicates
                var itemsAdded = {};
                
                // First, if we have matchingChildTagIDs, try to match items by TagID directly
                // This is more reliable than text matching when we know the TagIDs
                if (matchingChildTagIDs && matchingChildTagIDs.length > 0) {
                    $content.find("li").each(function() {
                        var $item = $(this);
                        
                        // Skip if this is not a menu item (skip accordion headers)
                        if ($item.closest(".child-panel-accordion-header").length > 0) {
                            return;
                        }
                        
                        var $link = $item.find("a");
                        if ($link.length === 0) {
                            return;
                        }
                        
                        var itemTagID = null;
                        var itemKey = $link.attr("id") || "link_" + $item.index();
                        
                        // Try to extract TagID from onclick attribute (most reliable)
                        var onclickAttr = $link.attr("onclick") || "";
                        if (onclickAttr) {
                            // Extract TagID from onclick: ChangeTabs(this, 'url', TagID, ParentTagID, ...)
                            // TagID is the third parameter
                            var match = onclickAttr.match(/ChangeTabs\([^,]+,\s*[^,]+,\s*(\d+)/);
                            if (match && match[1]) {
                                itemTagID = parseInt(match[1]);
                            }
                        }
                        
                        // Fallback: try to extract from link ID (format: a_TemplateIDTagID)
                        if (!itemTagID) {
                            var linkId = $link.attr("id");
                            if (linkId) {
                                // Try to extract numbers from the end
                                var numMatch = linkId.match(/(\d+)$/);
                                if (numMatch && numMatch[1]) {
                                    itemTagID = parseInt(numMatch[1]);
                                }
                            }
                        }
                        
                        // Fallback: try to extract from hidden input ID (format: header_TagID)
                        if (!itemTagID) {
                            var $hiddenInput = $item.find("input[type='hidden'][id^='header_']");
                            if ($hiddenInput.length > 0) {
                                var hiddenId = $hiddenInput.attr("id");
                                if (hiddenId) {
                                    var hiddenMatch = hiddenId.match(/header_(\d+)/);
                                    if (hiddenMatch && hiddenMatch[1]) {
                                        itemTagID = parseInt(hiddenMatch[1]);
                                    }
                                }
                            }
                        }
                        
                        // If this item's TagID matches, show it
                        if (itemTagID && matchingChildTagIDs.indexOf(itemTagID) > -1) {
                            if (!itemsAdded[itemKey]) {
                                itemsToShow.push($item);
                                itemsAdded[itemKey] = true;
                                hasMatches = true;
                                
                                // Check if this item is inside an accordion content
                                var $accordionContent = $item.closest(".child-panel-accordion-content");
                                if ($accordionContent.length > 0) {
                                    var $accordionItem = $accordionContent.closest(".child-panel-accordion-item");
                                    if ($accordionItem.length > 0) {
                                        accordionsToShow.push($accordionItem);
                                        accordionsToShow.push($accordionItem.find(".child-panel-accordion-header"));
                                        
                                        var accordionId = $accordionItem.data("tagid");
                                        if (!accordionId) {
                                            accordionId = "accordion_" + $accordionItem.index();
                                        }
                                        accordionsToOpen[accordionId] = $accordionItem;
                                    }
                                }
                            }
                        }
                    });
                }
                
                // Also search through ALL list items by text - this is a secondary matching method
                // This helps catch items that might not have been matched by TagID
                $content.find("li").each(function() {
                    var $item = $(this);
                    
                    // Skip if this is not a menu item (skip accordion headers)
                    if ($item.closest(".child-panel-accordion-header").length > 0) {
                        return;
                    }
                    
                    var $link = $item.find("a");
                    var itemKey = null;
                    var itemText = "";
                    
                    // Get item key for duplicate tracking
                    if ($link.length > 0) {
                        var linkId = $link.attr("id");
                        itemKey = linkId || "link_" + $item.index();
                        
                        // Skip if already added by TagID matching
                        if (itemsAdded[itemKey]) {
                            return;
                        }
                        
                        // Get text from link - this is the most reliable source
                        itemText = $link.text() || $link.html() || "";
                        itemText = itemText.replace(/<[^>]*>/g, ''); // Remove HTML tags if any
                        itemText = itemText.toLowerCase().trim();
                    } else {
                        itemKey = "item_" + $item.index();
                        itemText = $item.text() || $item.html() || "";
                        itemText = itemText.replace(/<[^>]*>/g, ''); // Remove HTML tags if any
                        itemText = itemText.toLowerCase().trim();
                    }
                    
                    // Clean up the text - normalize whitespace
                    itemText = itemText.replace(/\s+/g, ' ').replace(/\s*-\s*overview\s*/gi, '').trim();
                    
                    // If text is still empty, try getting from entire item
                    if (!itemText || itemText.length === 0) {
                        var fullItemText = $item.text() || $item.html() || "";
                        fullItemText = fullItemText.replace(/<[^>]*>/g, ''); // Remove HTML tags
                        fullItemText = fullItemText.replace(/\s+/g, ' ').trim().toLowerCase();
                        if (fullItemText) {
                            itemText = fullItemText;
                        }
                    }
                    
                    // Check if search text matches - this is the primary matching logic
                    var isMatch = false;
                    if (itemText && searchText && itemText.length > 0 && searchText.length > 0) {
                        // Normalize both texts for comparison (remove extra spaces, special chars)
                        var normalizedItemText = itemText.replace(/\s+/g, ' ').trim();
                        var normalizedSearchText = searchText.replace(/\s+/g, ' ').trim();
                        isMatch = normalizedItemText.indexOf(normalizedSearchText) > -1;
                        
                        // Also try reverse match (search text might contain item text)
                        if (!isMatch) {
                            isMatch = normalizedSearchText.indexOf(normalizedItemText) > -1;
                        }
                        
                        // If we have matchingChildTagIDs but still no match, try word-by-word matching
                        // This handles cases where text might be slightly different (e.g., "Project Management" vs "Project Management - Overview")
                        if (!isMatch && matchingChildTagIDs && matchingChildTagIDs.length > 0) {
                            var searchWords = normalizedSearchText.split(/\s+/).filter(function(w) { return w.length > 0; });
                            var itemWords = normalizedItemText.split(/\s+/).filter(function(w) { return w.length > 0; });
                            
                            // If any search word matches any item word, consider it a match
                            for (var sw = 0; sw < searchWords.length; sw++) {
                                for (var iw = 0; iw < itemWords.length; iw++) {
                                    if (itemWords[iw].indexOf(searchWords[sw]) > -1 || searchWords[sw].indexOf(itemWords[iw]) > -1) {
                                        isMatch = true;
                                        break;
                                    }
                                }
                                if (isMatch) break;
                            }
                        }
                    }
                    
                    // If text matches, show the item
                    if (isMatch) {
                        if (!itemsAdded[itemKey]) {
                            itemsToShow.push($item);
                            itemsAdded[itemKey] = true;
                            hasMatches = true; // Mark that we found at least one match
                            
                            // Check if this item is inside an accordion content
                            var $accordionContent = $item.closest(".child-panel-accordion-content");
                            if ($accordionContent.length > 0) {
                                var $accordionItem = $accordionContent.closest(".child-panel-accordion-item");
                                if ($accordionItem.length > 0) {
                                    accordionsToShow.push($accordionItem);
                                    accordionsToShow.push($accordionItem.find(".child-panel-accordion-header"));
                                    
                                    var accordionId = $accordionItem.data("tagid");
                                    if (!accordionId) {
                                        accordionId = "accordion_" + $accordionItem.index();
                                    }
                                    accordionsToOpen[accordionId] = $accordionItem;
                                }
                            }
                        }
                    }
                });
                
                // Search through accordion headers
                $content.find(".child-panel-accordion-header").each(function() {
                    var $header = $(this);
                    var headerText = "";
                    
                    // Get text from the first span (which contains the accordion title)
                    var $span = $header.find("span").first();
                    if ($span.length > 0) {
                        headerText = $span.text() || $span.html() || "";
                        headerText = headerText.replace(/<[^>]*>/g, ''); // Remove HTML tags if any
                        headerText = headerText.toLowerCase().trim();
                    } else {
                        headerText = $header.text() || $header.html() || "";
                        headerText = headerText.replace(/<[^>]*>/g, ''); // Remove HTML tags if any
                        headerText = headerText.toLowerCase().trim();
                    }
                    
                    // Clean up the text - normalize whitespace
                    headerText = headerText.replace(/\s+/g, ' ').trim();
                    
                    // Check if search text matches
                    if (headerText && searchText && headerText.indexOf(searchText) > -1) {
                        var $accordionItem = $header.closest(".child-panel-accordion-item");
                        accordionsToShow.push($accordionItem);
                        accordionsToShow.push($header);
                        hasMatches = true; // Mark that we found at least one match
                        
                        var accordionId = $accordionItem.data("tagid");
                        if (!accordionId) {
                            accordionId = "accordion_" + $accordionItem.index();
                        }
                        accordionsToOpen[accordionId] = $accordionItem;
                    }
                });
                
                // If we have matchingChildTagIDs, we definitely have matches
                // Set hasMatches to true even if we didn't find items by text (text matching might have failed)
                if (matchingChildTagIDs && matchingChildTagIDs.length > 0) {
                    hasMatches = true;
                }
                
                
                // Remove message immediately if we have items to show or matching TagIDs
                // This ensures message is removed before DOM operations
                if (hasMatches || itemsToShow.length > 0 || accordionsToShow.length > 0 || (matchingChildTagIDs && matchingChildTagIDs.length > 0)) {
                    $content.find(".search-no-results-message").remove();
                }
                
                // Batch all DOM operations in a single requestAnimationFrame to prevent flickering
                requestAnimationFrame(function() {
                    // Hide all items first
                    itemsToHide.forEach(function($item) {
                        $item.hide();
                    });
                    accordionsToHide.forEach(function($accordion) {
                        $accordion.hide();
                    });
                    
                    // Then show matching items and apply search highlighting
                    itemsToShow.forEach(function($item) {
                        $item.show();
                        
                        // Apply search text highlighting to matching items
                        if (searchText && searchText.trim() !== "") {
                            var $link = $item.find("a").first();
                            highlightChildPanelLink($link, searchText);
                        }
                    });
                    
                    accordionsToShow.forEach(function($accordion) {
                        $accordion.show();
                        
                        // Apply search text highlighting to accordion headers
                        if (searchText && searchText.trim() !== "" && $accordion.hasClass("child-panel-accordion-header")) {
                            var $headerSpan = $accordion.find("span").first();
                            if ($headerSpan.length > 0) {
                                // Get original text (remove any existing highlights first)
                                var headerText = $headerSpan.text();
                                if (headerText && headerText.toLowerCase().indexOf(searchText.toLowerCase()) > -1) {
                                    var highlightedText = highlightSearchText(headerText, searchText);
                                    $headerSpan.html(highlightedText);
                                }
                            }
                        }
                    });
                    
                    // Open all accordions that have matches (only if not already open to prevent flickering)
                    for (var key in accordionsToOpen) {
                        if (accordionsToOpen.hasOwnProperty(key)) {
                            var $accordionItem = accordionsToOpen[key];
                            var $accordionContent = $accordionItem.find(".child-panel-accordion-content");
                            var $accordionHeader = $accordionItem.find(".child-panel-accordion-header");
                            
                            // Only toggle if not already in the desired state
                            var isAlreadyOpen = $accordionHeader.hasClass("active") && $accordionContent.hasClass("active");
                            
                            if (!isAlreadyOpen) {
                                $accordionHeader.addClass("active");
                                $accordionContent.addClass("active").css("max-height", "1000px"); // Increased from 500px to show all items
                            }
                            // Do NOT force-show all <li> during search; matching items are shown above.
                        }
                    }
                    
                    // Check if any items are actually visible after DOM update
                    // Use a small delay to ensure DOM has updated
                    setTimeout(function() {
                        // Check for visible items - exclude the message itself and any hidden inputs
                        var visibleItems = $content.find("li:visible").filter(function() {
                            var $item = $(this);
                            // Skip accordion headers (they're divs, not li, but check anyway)
                            if ($item.closest(".child-panel-accordion-header").length > 0) {
                                return false;
                            }
                            // Only count items with links (actual menu items)
                            return $item.find("a").length > 0;
                        }).length;
                        var visibleAccordions = $content.find(".child-panel-accordion-item:visible").length;
                        var visibleAccordionHeaders = $content.find(".child-panel-accordion-header:visible").length;
                        var hasVisibleContent = visibleItems > 0 || visibleAccordions > 0 || visibleAccordionHeaders > 0;
                        
                        // Also check if itemsToShow or accordionsToShow have items (meaning matches were found)
                        var hasItemsToShow = itemsToShow.length > 0 || accordionsToShow.length > 0;
                        
                        // Check if we have matching TagIDs (this means data exists even if not yet visible in DOM)
                        var hasMatchingTagIDs = matchingChildTagIDs && matchingChildTagIDs.length > 0;
                        
                        // Remove message immediately if we have any matches, items to show, visible content, or matching TagIDs
                        if (hasMatches || hasItemsToShow || hasVisibleContent || hasMatchingTagIDs) {
                            $content.find(".search-no-results-message").remove();
                            return; // Exit early if we have matches
                        }
                        
                        // Only show message if absolutely nothing was found
                        // Double-check: no matches flag, no items to show, nothing visible, and no matching TagIDs
                        if (!hasMatches && !hasItemsToShow && !hasVisibleContent && !hasMatchingTagIDs) {
                            var $existingMessage = $content.find(".search-no-results-message");
                            if ($existingMessage.length === 0) {
                                var messageHTML = '<div class="search-no-results-message" style="padding: 20px; text-align: center; color: #666; font-size: 14px;">' +
                                    '<i class="fas fa-info-circle" style="margin-right: 8px;"></i>' +
                                    'No results found in current module. Click highlighted parent icons to see matching results.</div>';
                                $content.append(messageHTML);
                            }
                        } else {
                            // Make sure message is removed if we have any indication of matches
                            $content.find(".search-no-results-message").remove();
                        }
                    }, 2); // Minimal delay for DOM updates
                });
                
                return hasMatches; // Return whether matches were found
            } finally {
                // Reset flag after a short delay
                setTimeout(function() {
                    isFilteringChildPanel = false;
                }, 50);
            }
        }
        
        //Hide child panel only when user clicks collapse menu icon, not when clicking outside
        //Modified By Madhuri.K On 27-01-2026 - Removed automatic closing on document click; only close via collapse button
        $(document).on('click', function(e) {
            // Child panel will only close when user clicks the collapse button (.sidebar-toggle)
            // This handler is kept for future reference but doesn't automatically close panel on outside clicks
        });
        //End Added By Madhuri.K On 09-01-2026

        function ChangeResponsiveTabs(src, TagID, obj, ParentTagID, PageHeader) {
             //debugger;
             var EmployeeID;
             EmployeeID = '<%= Session("intUserID") %>';
             if (EmployeeID == '') {
                 alert('Your session is expired. Please login again.');
                 // window.location.href = "../../Default.aspx?Message=SessionExpired";
                 window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError";
             } else {
                 // debugger;
                 $("#responsiveSubmenu .active").removeClass("active");
                 if (ParentTagID == 305 && TagID == 22179) {

                     document.getElementById("frmNewResponsiveVersion").src = src + "?TagID=305&PageHeader=" + PageHeader + "";
                 }
                 else {

                     document.getElementById("frmNewResponsiveVersion").src = src;
                 }

                 $(obj).addClass("active");
                 if (TagID != undefined) {
                     if (document.getElementById("header_" + TagID) != null)
                         document.getElementById("mainHeadingTop").innerHTML = document.getElementById("header_" + TagID).value;
                 }


                 // $('body').toggleClass('Mv_mobmenushow');
                 //$('#Mmenu_togglebtn').click(function () {
                 //   // alert();
                 //    $(this).toggleClass('open');
                 //    $('.Mv_mobmenu').toggleClass('Mv_mobmenu_open animated SlideInUp');
                 //    $('body').toggleClass('Mv_mobmenushow');


                 //});

             }
         }

         function GetTagMastersByParentTagID(parentTagID, data, templateFilter) {
             var childTagMasters = [];
             var templateFilterUpper = templateFilter ? safeNavLabel(templateFilter).toUpperCase() : '';
             for (var i = 0; i < data.length; i++) {
                 var tagMaster = data[i];
                 var ParentTagId = tagMaster.ParentTagId;

                 if (ParentTagId == parentTagID) {
                     if (!templateFilterUpper || getTagTemplateId(tagMaster).toUpperCase() === templateFilterUpper) {
                         childTagMasters.push(tagMaster);
                     }
                 }
             }
             return childTagMasters;
         }

         function plotChildSubMenu(TagID) {
             // debugger;
             //     $("li.panel1").show();
             //$("li.panel2").hide();
             //$("#prev").hide();
             // });
             // $("#next").click(function(){ 
             //     //
             //     $("li.panel1").hide();
             //     $("li.panel2").show();
             //     $("#prev").show();
             //     $("#next").hide();
             //  });
             //  $("#prev").click(function(){ 
             //     $("li.panel1").show();
             //     $("li.panel2").hide();
             //       $("#prev").hide();
             //     $("#next").show();
             //  });
             var childTagMasters = GetTagMastersByParentTagID(TagID, treeChildMenu);
             var childHTML = "";

             if (childTagMasters.length != 0) {
                 childHTML += "<li>"
             }
             else {
                 childHTML += "<li style='height:50px;'>"
             }
             //childHTML += '<a href="javascript:;" class="Mmenu_toggle" id="Mmenu_togglebtn">'
             childHTML += '<a class="Mmenu_toggle" id="Mmenu_togglebtn">'
             childHTML += '<span></span>'
             childHTML += '<span></span>'
             childHTML += '<span></span>'
             childHTML += '<span></span>'
             childHTML += '</a>'
             childHTML += '</li>'

             var defaultPageName = "";
             var defaultTagID = 0;
             var flag = 1;

             for (var j = 0; j < childTagMasters.length; j++) {
                 var childDisplayPageName = childTagMasters[j].DisplayPageName;
                 var childDisplayTagName = childTagMasters[j].DisplayTagName;
                 var childTagID = childTagMasters[j].TagID;
                 var childDisplayHeader = childTagMasters[j].DisplayHeader;
                 var childParentTagId = childTagMasters[j].ParentTagId;
                 var AllowResponsive = childTagMasters[j].AllowResponsive;
                 var ResponsivePageName = childTagMasters[j].ResponsivePageName;
                 var NonActiveResponsiveImage = childTagMasters[j].NonActiveResponsiveImage;
                 var ActiveResponsiveImage = childTagMasters[j].ActiveResponsiveImage;

                 if (AllowResponsive == 1) {
                     if (j < 3) {
                         flag = 1;
                         //Added By Dipali V On 8th Jan 2020 For Onclick timesheet get open
                         //defaultPageName = ResponsivePageName;
                         //defaultTagID = childTagID;
                         //End of Added By Dipali V On 8th Jan 2020 For Onclick timesheet get open
                     } else { flag = 2; }
                     //if (j == 1) {
                     if (j == 1) {
                         defaultPageName = ResponsivePageName;
                         defaultTagID = childTagID;
                     }
                     if (flag == 1) {

                         childHTML += '  <li id="Panel_' + flag + '"' + (j == 1 ? "class='active'" : '') + ' style="height:52px;" onclick=ChangeResponsiveTabs("' + ResponsivePageName + '",' + childTagID + ',this,' + childParentTagId + ',"' + childDisplayTagName.replace(" ", "%20").replace(" ", "%20") + '")>';
                     }
                     else {
                         childHTML += '  <li style="display:none" id="Panel_' + flag + '"' + (j == 1 ? "class='active'" : '') + ' style="height:52px;" onclick=ChangeResponsiveTabs("' + ResponsivePageName + '",' + childTagID + ',this,' + childParentTagId + ',"' + childDisplayTagName.replace(" ", "%20") + '")>';
                         // childHTML += "  <li  id='Panel_"+ flag +"' " + (j == 0 ? 'class="active"' : "") + " onclick='ChangeResponsiveTabs('" + ResponsivePageName + "'," + childTagID + ",this,"+ childParentTagId +",'"+ childDisplayTagName +"')'>"
                     }

                     childHTML += '     <a style="height: 54px;">'
                     childHTML += '         <img class="nonactivemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/' + ActiveResponsiveImage + '" width="30px">'
                     childHTML += '         <img class="activemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/' + NonActiveResponsiveImage + '" width="30px">'
                     childHTML += '     </a>'
                     childHTML += ' </li>'


                 }


                 //childHTML += "<li onclick=ChangeTabs('" + childDisplayPageName + "'," + childTagID + "," + childParentTagId + ")><input type='hidden' id='header_" + childTagID + "' value='" + childDisplayHeader + "'><a href='#'>" + childDisplayTagName + "</a></li>"
             }
             //if (childTagMasters.length > 3) {
             if (childTagMasters.length > 3) {
                 childHTML += '<li id="next" >';
                 childHTML += ' <a onclick="next()"><i class="fa fa-chevron-right" aria-hidden="true"></i></a>';
                 childHTML += '</li>';
                 childHTML += '<li id="prev"  style="display:none">';
                 childHTML += '  <a onclick="prev()"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>';
                 childHTML += '</li>';

             }
             $("#responsiveSubmenu").html(childHTML);

             //debugger;
             if (childTagMasters.length != 0) {
                 //alert(defaultPageName);
                 //alert('responsive');
                 //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
                 if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                     ChangeResponsiveTabs(defaultPageName, defaultTagID, $("#responsiveSubmenu .active"), 0, '');
                 }
                 //End of Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
             }

             else {
                 $("#responsiveSubmenu .active").removeClass("active");
                 //document.getElementById("frmNewResponsiveVersion").src = "../NewAPI/TimesheetMobile/UnderConstruction.aspx";
             }
             //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
             if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                 AfterResponsivePlot();
             }
             //Added By Dipali V On for open timesheet entry page
             $(".Mv_bottommainsubmenu ul li:nth-child(2)").click();
            //End of Added By Dipali V On for open timesheet entry page
             //End of Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
         }




         $('#Mmenu_togglebtn').click(function () {
             $(this).toggleClass('open');
             $('.Mv_mobmenu').toggleClass('Mv_mobmenu_open animated SlideInUp');
             $('body').toggleClass('Mv_mobmenushow');


         });

         function next() {

             $("li#Panel_1").hide();
             $("li#Panel_2").show();
             $("#prev").show();
             $("#next").hide();
         }
         function prev() {
             $("li#Panel_1").show();
             $("li#Panel_2").hide();
             $("#prev").hide();
             $("#next").show();
         }
     </script>

    <%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   <script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

    <%--<script src="../../Whizible2.0-new/dist/js/custom.js?v=1"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/custom_mobile.js"></script>

    <%--<script src="../../Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>--%>
    
   <%--<script language='javascript' src='../../Source/General/CommonFunctions.js'></script> 
    <script src="../../Whizible2.0-new/dist/js/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/app.min.js?Date=<%=DateTime.Now %>"></script>
    <%--Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>
    <%-- bootstrap-select 1.13.18 JS removed: incompatible with Bootstrap 5.x active in W27.
         Native <select> with custom CSS is used for the session project dropdown. --%>
    <%--End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>
   <%--<script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <%--added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue--%>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <%--End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue--%>
    <%--<script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <%End If %>
</head>

<% MyBase.InitializeResources("Resources.Navigation", "Resources")%>
<!--</TITLE>
		    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
            <meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
            <meta name='vs_defaultClientScript' content='JavaScript'>
            <meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
            <meta http-equiv="Cache-Control" CONTENT="no-cache">
            <meta http-equiv="Pragma" CONTENT="no-cache">
            <link rel='stylesheet' type='text/css' href='../General/StyleSheetChanakya.css'/>
            <link id='lnkWhizStyleSheetImgDir' type='text/plain' href='../../images/cssImages/'/>
            <script language='javascript' src='../General/CommonFunctions.js'></script>
            <script language='javascript' src='../General/CommonValidations.js'></script>
	    </HEAD>	-->
    <%If m_ProductVersion <> 3 Then%>
<% CommonFunctions.General.PlotPageHeadTag([strTitle])%>
    <%End If %>
<% 'Added By Ninad on 15 May 2008, WAF3_PB_64 Show Navigation Alert%>
    
  
<script language="javascript">
    var blnNavigate = null;
    function Logout(strLogoutPage) {
       
        window.open("../../Default.aspx?Message=LOGOUT", "_top");
    }
    
    //commented and added by Aditya J. on 09-06-2026 to show alert when set default project
    //function SetDefaultProject() {
    //    debugger
    //    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
    //    $.get("Links.aspx?Mode=SetDefaultProject", function (str) {
    //    });
    //}

    function SetDefaultProject() {
        
        if ($("#cboSessionProject").val() == "0" || $("#cboSessionProject").val() == "" || $("#cboSessionProject").val() == '' || $("#cboSessionProject").val() == "undefined" || $("#cboSessionProject").val() == null) {
            alertify.set("notifier", "position", "top-right");
            alertify.error("Please select Project.");
            return;
        }

        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/SetDefaultProject',
            success: function (response) {
                var result = response.d;
                if (result === "1") {
                    alertify.set("notifier", "position", "top-right");
                    alertify.success("Default project set successfully.");
                } else if (result === "2") {
                    alertify.set("notifier", "position", "top-right");
                    alertify.success("Default project set successfully.");
                } else {
                    alertify.set("notifier", "position", "top-right");
                    alertify.error("Failed to set default project. Please try again.");
                }
            },
            error: function () {
                alertify.set("notifier", "position", "top-right");
                alertify.error("Something went wrong. Please try again.");
            }
        });
    }
    //End of commented and added by Aditya J. on 09-06-2026 to show alert when set default project

    <%--Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>
    //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
    function sessionProjectClearSelectpickerTooltip(selector) {
        var $ddl = $(selector);
        if ($ddl.length === 0) return;
        var $btn = $ddl.closest(".bootstrap-select").find("button.dropdown-toggle");
        if ($btn.length === 0) return;

        $btn.removeAttr("title").removeAttr("data-original-title").removeAttr("data-bs-original-title");
        try { $btn.tooltip("dispose"); } catch (ex) { }
        if (typeof bootstrap !== "undefined" && bootstrap.Tooltip) {
            var existingTip = bootstrap.Tooltip.getInstance($btn[0]);
            if (existingTip) existingTip.dispose();
        }

        $ddl.off("show.bs.select.sessionProject shown.bs.select.sessionProject hide.bs.select.sessionProject changed.bs.select.sessionProject");
        $ddl.on("show.bs.select.sessionProject hide.bs.select.sessionProject changed.bs.select.sessionProject", function () {
            try { $btn.tooltip("dispose"); } catch (ex) { }
            if (typeof bootstrap !== "undefined" && bootstrap.Tooltip) {
                var tip = bootstrap.Tooltip.getInstance($btn[0]);
                if (tip) tip.hide();
            }
            $(".tooltip").remove();
        });
        $ddl.on("shown.bs.select.sessionProject", function () {
            var $wrap = $ddl.closest(".bootstrap-select");
            $wrap.find("> .dropdown-menu, .inner, ul.dropdown-menu.inner, li, a.dropdown-item, span.text").each(function () {
                this.style.removeProperty("display");
                this.style.removeProperty("visibility");
                this.style.removeProperty("opacity");
            });
            $wrap.find("> .dropdown-menu, .inner, ul.dropdown-menu.inner").show();
        });
    }

    //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue - hide bootstrap-select UI, not only native select
    var sessionProjectAccessVisible = null;

    function sessionProjectSetVisibility(visible) {
        sessionProjectAccessVisible = !!visible;
        var $heading = $("#mainHeadingProject");
        var $wrap = $(".session-project-wrapper");
        var $ddl = $("#cboSessionProject");
        var $picker = $ddl.closest(".bootstrap-select");

        if ($picker.length === 0 && $ddl.length > 0) {
            $picker = $ddl.parent(".bootstrap-select");
        }

        if (visible) {
            $heading.removeClass("session-project-hidden");
            $wrap.removeClass("session-project-hidden");
            $picker.removeClass("session-project-hidden");
        } else {
            if ($ddl.length && $ddl.parent().hasClass("bootstrap-select") && $ddl.parent().hasClass("show")) {
                try { $ddl.selectpicker("toggle"); } catch (ex) { }
            }
            $heading.addClass("session-project-hidden");
            $wrap.addClass("session-project-hidden");
            $picker.addClass("session-project-hidden");
        }

        if (typeof syncParentPanelHeaderHeight === "function") {
            setTimeout(syncParentPanelHeaderHeight, 0);
        }
    }

    function sessionProjectRefreshSelectpicker(selector) {
        if (!$.fn.selectpicker) return;
        var $ddl = $(selector);
        if ($ddl.length === 0) return;

        if ($ddl.parent().hasClass("bootstrap-select")) {
            $ddl.selectpicker("destroy");
        }

        $ddl.selectpicker();
        $ddl.selectpicker("refresh");
        sessionProjectClearSelectpickerTooltip(selector);
        if (sessionProjectAccessVisible === false) {
            sessionProjectSetVisibility(false);
        }
        if (typeof syncParentPanelHeaderHeight === "function") {
            setTimeout(syncParentPanelHeaderHeight, 0);
        }
    }
    //End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
    //Added By Dipali V On 1st Aug 2023 For Session Project 
    function GetSessionProject() {
        //debugger
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/GetSessionProject',
            data: JSON.stringify({ UserID: "<%=Session("intUserID")%>", LoginType: "<%=HttpContext.Current.Session("LoginType")%>" }),
            success: function (Result) {
                //debugger;
                if (Result != "") {
                    var strArray = String(Result.d).split("|")
                    objSessionProject = document.getElementById("cboSessionProject");
                    var i = 0;
                    objSessionProject.innerHTML = "";

                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        var objOption = document.createElement("OPTION");
                        objSessionProject.options.add(objOption);
                        objOption.text = obj.ProjectName;
                        objOption.value = obj.ProjectID;

                    });
                }
                //$("#cboSessionProject").val('<%=Session("intProjectID")%>');
                
                var projectId = $("#cboSessionProject").val();
                var sessionProjectId = '<%=Session("intProjectID")%>';

                if ((projectId == null ||
                    projectId == "" ||
                    projectId == "0" ||
                    projectId == "undefined") &&
                    (sessionProjectId == null ||
                        sessionProjectId == "" ||
                        sessionProjectId == "0")) {
                    $("#cboSessionProject").val("0");
                }
                else {
                    $("#cboSessionProject").val(sessionProjectId);
                }
                //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
                sessionProjectRefreshSelectpicker("#cboSessionProject");
                //End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
                
            },
            error: function (xhr) {
                console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

            }
        });
        //$(".selectpicker").selectpicker("refresh");
    }

    var GModuleTagID = "";
    var GParentTagID = "";
    var GTemplateID = "";
   
    var GMasterTagId = 0;
    var GModuleID = 0;
    function SessionProject_Onchange(obj) {

        var SelectedProjectID = obj.value;
        frmNewVersion = document.getElementById("frmNewVersion").src;
        //frmNewVersion = SelectedPage
        if (frmNewVersion.indexOf('Source') != -1) {
            frmNewVersion_New = frmNewVersion.split('Source/')
            frmNewVersion_New = frmNewVersion_New[1].split('?')
        }
        
        params = getParams();
        GMasterTagId = unescape(params["MasterTagId"]);
        if (GMasterTagId == "undefined") {
            GMasterTagId = unescape(params["MasterTagID"]);
            if (GMasterTagId == "undefined") {
                GMasterTagId = "0";
            }
        }
        var SelectedProjectName = $("#cboSessionProject option:selected").text();
        
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/SetSessionProject',
            data: JSON.stringify({ ProjectID: SelectedProjectID, ProjectName: SelectedProjectName, MasterTagId: GMasterTagId }),
            success: function (Result) {
                //debugger;
                if (GMasterTagId != "0") {
                    GIsChangeSession = 1;
                    if (Result != "") {
                        var strArray = Result.d.split("|")
                        GModuleTagID = strArray[0];
                        GParentTagID = strArray[2];
                        GTemplateID = strArray[1];
                        GModuleID = strArray[3];
                    }
                    GlobalDisplayPageName = frmNewVersion;
                    GlobalTemplateID = GTemplateID;
                    GlobalTagMaster = GMasterTagId;
                    //commented and added by Aditya J. on 10-06-2026 for when project is changed from dropdown it should remain in same module
                    //Added By Dipali V On 8st Aug 2023 For Session Project 
                    /*window.location = "../General/Navigation.aspx?FromWhere=" + GTemplateID + "&IsSetsession=1&MTG=" + GMasterTagId + "&MPTG=" + GParentTagID + "&MOTG=" + GModuleTagID + "";*/
                    ChangeTabs(this, GlobalDisplayPageName, GlobalTagMaster, GlobalTemplateID, GlobalDisplayPageName);
                    //End of Added By Dipali V On 8st Aug 2023 For Session Project 
                    //End of commented and added by Aditya J. on 10-06-2026 for when project is changed from dropdown it should remain in same module
                    //GetSessionProject();
                    //added by Aditya J. on 20-08-2026 for agile project related pages not getting plotted after selecting agile project
                    PlotNavigationTree();
                    //End of added by Aditya J. on 20-08-2026 for agile project related pages not getting plotted after selecting agile project

                    
                } else {
                    //No Project Set as Session Project
                    window.open("../General/Navigation.aspx?FromWhere=PM&FromOld=1258&ProjectID_PK=" + SelectedProjectID + "&FromWhereProjectId=" + SelectedProjectID + "&FromWhereData=C&Mode=Edit", "_top");
                }
                
            }
        });
        //$('#cboSessionProject').selectpicker('refresh');
    }

    function getParams() {
        var params = {},
            pairs = frmNewVersion.split('?')
                .pop()
                .split('&');
        for (var i = 0, p; i < pairs.length; i++) {
            p = pairs[i].split('=');
            params[p[0]] = p[1];
        }
        return params;
    }

    //End of Added By Dipali V On 1st Aug 2023 For Session Project 
    <%--End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>
    
</script>
<%'Added By Ninad on 15 May 2008, WAF3_PB_64 Show Navigation Alert%>
   
    <%If m_ProductVersion = 3 Then%>
    <body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <%ElseIf m_ProductVersion = 2 Then%>
    <body class="fixed-nav sticky-footer bg-dark">
    <%Else%>
    <body>
    <%End If%>
    <form id="frmNvaigation" method="post" runat="server">
    </form>
    <%If m_blnDefaultNavigation = False Then
            PlotNavigationBody()
        Else%>
    <% If strShowUI = "1" Then%>
    <!--added by aniruddhad for jump to record functionality-->
    <input type="hidden" id="strJumpURL" name="strJumpURL" value="<%=strJumpURL%>" />
    <!-- end addition by aniruddhad-->
         <%If m_ProductVersion = 3 Then%>

        <div class="wrapper" id="MainDiv">
        <!-- Main Header -->
        <header class="main-header">
            <!-- Logo -->
            <a href="#" class="logo hidden-xs">
                <!-- mini logo for sidebar mini 50x50 pixels -->
                <!--<span class="logo-mini"><b>A</b>LT</span>-->
                <!-- Logo Added By Madhuri.K on 26-03-2026 -->
                <span class="logo-mini" style="display:block;">
                    <img type="image/png"
                         src="<%= ResolveUrl("~/Whizible2.0-new/dist/img/Whizible-app-logo.png") %>"
                         alt="Whizible"
                         width="60px"
                         onerror="this.onerror=null;this.src='../../Whizible2.0-new/dist/img/mobmenu/Whisible.svg';" />
                </span>
                <!-- End of Logo Added By Madhuri.K on 26-03-2026 -->
                <!-- logo for regular state and mobile devices -->
                <!--<span class="logo-lg"><b>Your</b>LOGO</span>-->
            </a>
            <!-- Header Navbar -->
            <nav class="navbar navbar-expand-lg navbar-static-top" role="navigation">
                <%--Commented & Added By Dipali V On 19th Sep 2025 For Navigation tree changes--%>
                <%--<div class="mainheadingtop col" id ="mainHeadingTop"></div>--%>
                <%--added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue - header layout as per reference SS--%>
                <div class="navbar-heading-block">
                <div class="mainheadingtop col"> <span style="font-size:10px">Selected Module </span>: <span id ="mainHeadingTop"></span></div>
                <div class="mainheadingtop col" id ="mainHeadingProject">
                    <%--End of Commented & Added By Dipali V On 19th Sep 2025 For Navigation tree changes--%>
                    
                    <%--Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>
                    <%--Added By Dipali V On 1st Aug 2023 For Session Project --%>
                    <%If GProjectModuleAcess = 1 Then%>
                    <div class="session-project-wrapper">
                        <span>Project :</span>
                    <%--<div class="cbo-session-project-select-wrap">
                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSessionProject", "Select '' ",,, "Onchange='SessionProject_Onchange(this)'class=' form-control input-sm  '",,, ) %>
                    </div>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSessionProject", "Select '' ",,, "Onchange='SessionProject_Onchange(this)'class='form-control selectpicker' data-live-search='true'",,, ) %>

                        <i class="fa fa-key" id="setdefaultkey" onclick="SetDefaultProject()" title="Set as default project"></i>
                    </div>
                    <%End If %>
                    <%--End of Added By Dipali V On 1st Aug 2023 For Session Project --%>
                    <%--End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27--%>

                </div>
                </div>
                <%--End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue - header layout as per reference SS--%>
                <!--filterpanel mobile view-->
                <div class="filter col float-end hidden-desktop">
                    <button title="Advanced Filter" data-bs-toggle="collapse" data-bs-target="#Mvfilterpanel" class="collapsed" aria-expanded="false"><i class="fas fa-filter"></i></button>
                </div>
                <!--end filter panel mobile view-->

                <!-- Navbar Right Menu -->
                <div class="col navbar-custom-menu d-flex justify-content-end hidden-xs">
                    <ul class="nav navbar-nav">
                        <!-- commented By Nikhil A on 28-May-2020 for Integrating UX changes -->
                       <%-- <li class="dropdown user user-menu" title="Logged User" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            <!-- Menu Toggle Button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                <span class="hidden-xs" id="EmployeeName">

                                </span>
                                <!-- The user image in the navbar-->
                                <img class="EmployeeImage user-image" alt="User Image" onerror="this.src='../../Images/Photo/no-photo.png'">
                            </a>
                            <ul class="dropdown-menu">
                                <!-- The user image in the menu -->
                                <li class="user-header">
                                    <img class="EmployeeImage img-circle"  alt="User Image" onerror="this.src='../../Images/Photo/no-photo.png'">
                                    <p id="EmployeeNameRole">
                                      
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="text-center">
                                        <a onclick="ChangeTabs('../HelpdeskEnhancement/MyProfile/MyProfile.aspx?FromWhere=1',1085,1085)" class="btn btn-default btn-block">Profile</a>
                                    </div>
                                </li>
                            </ul>
                        </li>--%>
                        <!-- By Nikhil A on 28-May-2020 for Integrating UX changes -->
                        <%If Session("LoginType") <> "C" Then%>
                             <%If Convert.ToInt32(m_strAlertCount) > 0 Then%>
                            <li class="nav-item dropdown" id="flagLink" value='Alert' title="Alerts" data-bs-toggle="tooltip" data-bs-placement="bottom">
                             <%Else%>
                            <li class="nav-item dropdown" value='Alert' title="Alerts" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            <%End If%>
                                <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-fw fa-bell clickIcon" ></i>
                                    <span class="new-indicator text-warning d-none d-lg-block">
                                        <span class="number" id="alertCount"><%=m_strAlertCount %></span>
                                    </span>
                                </a>

                            </li>
                           
                            <%If Convert.ToInt32(m_strNotificationCount) > 0 Then%>
                            <li class="nav-item dropdown" id="notifyLink" value='Notification' data-bs-toggle="tooltip" data-bs-placement="bottom"  title="Notifications">
                             <%Else%>
                            <li class="nav-item dropdown" value='Notification'  data-bs-toggle="tooltip" data-bs-placement="bottom" title="Notifications">
                            <%End If%>
                                <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-fw fa-flag clickIcon"></i>
                                    <span class="new-indicator text-warning d-none d-lg-block">
                                        <span class="number" id="NotificationCount"><%=m_strNotificationCount%></span>
                                    </span>
                                </a>

                            </li>
                        <%End If%>
                        <%If Convert.ToInt32(m_strDiscussionCount) > 0 Then%>
                        <li class="nav-item dropdown" id="msgLink" value='Discussions' title="Helpdesk Discussions" data-bs-toggle="tooltip" data-bs-placement="bottom" >
                        <%Else%>
                        <li class="nav-item dropdown" value='Discussions' title="Helpdesk Discussion"  data-bs-toggle="tooltip" data-bs-placement="bottom" >
                        <%End If%>
                            <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-fw fa-comments clickIcon"></i>
                                <span class="new-indicator text-warning d-none d-lg-block">
                                    <span class="number" id="DiscussionCount"><%=m_strDiscussionCount%></span>
                                </span>
                            </a>
                        </li>
                        <%--<!-- search Menu -->
                        <li class="dropdown search-menu">
                            <!-- Menu toggle button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="weeklycalender_icon" src="../../Whizible2.0-new/dist/img/Search.svg" alt="" width="20px">
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">Please search here</li>
                                <li>
                                    <div class="input-group">
                                        <input type="text" class="form-control">
                                        <span class="input-group-btn">
                              <button class="btn btnyellow btn-flat" type="button">Search</button>
                              </span>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- setting Menu -->
                        <li class="dropdown setting-menu">
                            <!-- Menu toggle button -->
                            <a href="#" data-bs-toggle="control-sidebar" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="weeklycalender_icon" src="../../Whizible2.0-new/dist/img/Setting.svg" alt="" width="20px">
                            </a>
                        </li>
                        <!-- Notifications Menu -->
                        <li class="dropdown notifications-menu">
                            <!-- Menu toggle button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="far fa-bell"></i>
                                <span class="label label-warning">10</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 10 notifications</li>
                                <li>
                                    <!-- Inner Menu: contains the notifications -->
                                    <ul class="menu">
                                        <li>
                                            <!-- start notification -->
                                            <a href="#">
                                                <i class="fa fa-users text-aqua"></i> 5 new members joined today
                                            </a>
                                        </li>
                                        <!-- end notification -->
                                    </ul>
                                </li>
                                <li class="footer"><a href="#">View all</a></li>
                            </ul>
                        </li>--%>
                         <!-- Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes -->
                        <li class="dropdown user user-menu" title="Logged User" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            <!-- Menu Toggle Button -->
                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown" onclick="OpenLodoutDIV()">                                
                                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                <span class="hidden-xs" id="EmployeeName">

                                </span>
                                <!-- The user image in the navbar-->
                                <%--<img class="EmployeeImage user-image" alt="User Image" onerror="this.src='../../Images/Photo/no-photo.png'">--%>
                                <img class="EmployeeImage user-image" src="../../Images/Photo/no-photo.png" onerror="this.onerror=null;this.src='../../Images/Photo/no-photo.png';">
                            </a>
                            <ul class="dropdown-menu" id="Ulmenu">
                                <!-- The user image in the menu -->
                                <li class="user-header">
                                    <img class="EmployeeImage img-circle" src="../../Images/Photo/no-photo.png"  alt="User Image" onerror="this.onerror=null;this.src='../../Images/Photo/no-photo.png'">
                                    <p id="EmployeeNameRole">
                                      
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="text-center">
                                      <%-- Commented by Dipali V On 9th Dce 2020 For Remove Profile Link--%>
                                        <%--<a onclick="ChangeTabs('../HelpdeskEnhancement/MyProfile/MyProfile.aspx?FromWhere=1',1085,1085)" class="btn btn-default btn-block" data-bs-toggle="tooltip" title="Profile" data-bs-container="body"  data-bs-placement="bottom">Profile</a>
                                       --%> 
                                        <a href="javascript:;" id="logout" class="btn btn-default btn-block" onclick="ClickofLogOut()" title="Logout"  data-bs-placement="bottom"> Log Out</a>
                                    <%--End of  Commented by Dipali V On 9th Dce 2020 For Remove Profile Link--%>
                                    </div>
                                </li>

                            </ul>
                        </li>
                        <%If System.Configuration.ConfigurationManager.AppSettings("AllowNavigateToOldUI").ToString = "1" Then%>
                            <li onclick="ChangeToOldVersion()">
                              <a href="#" class="text-center">
                                    <i class="fas fa-sign-out-alt" style="cursor:pointer"  title="Go To Old UI" aria-hidden="true"></i>
                              </a>
                          </li>
                        <%End If %>
                       
                          
                    </ul>
                </div>
            </nav>

        </header>
       
            <aside class="main-sidebar">
            <!-- sidebar: style can be found in sidebar.less -->
                <!-- <a href="#" class="sidebar-toggle" data-bs-toggle="offcanvas" role="button">
               <i class="fas fa-angle-right"></i>
            </a> -->
            <section class="sidebar">
                <!-- Sidebar Menu -->
                <ul class="sidebar-menu" id="treeMenu">
                </ul>
                <!--Added By Madhuri.K On 09-01-2026 For Child Panel-->
                <!--Modified By Madhuri.K On 10-01-2026 - Added search section above module header in child panel-->
                <div id="childPanel" class="child-panel">
                    <div class="child-panel-search">
                        <input type="text" id="childPanelSearch" class="form-control" placeholder="Search in selected module..." onkeyup="SearchChildPanel(event)" />
                        <!-- Toggle controls in top right corner of search section -->
                        <div class="child-panel-toggle-controls" id="childPanelToggleControls">
                            <!-- Collapse / close child panel -->
                            <button type="button" class="child-panel-btn" id="btnCollapseChildPanel" title="Collapse menu" onclick="collapseChildPanel();" style="display:inline-flex;">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <!-- Expand / reopen child panel -->
                            <button type="button" class="child-panel-btn" id="btnExpandChildPanel" title="Expand menu" onclick="expandChildPanel();" style="display:none;">  
                                <i class="fas fa-chevron-right"></i>
                            </button>
                    </div>
                    </div>
                    <div class="child-panel-header" id="childPanelHeader">
                        <span id="childPanelHeaderText">Menu</span>
                    </div>
                    <div class="child-panel-content" id="childPanelContent"></div>
                </div>

                <!-- Modified By Madhuri.K On 07-07-2026  -->
                <!-- Collapse wide parent menu to icon-only column -->
                <button type="button" class="parent-panel-collapse-btn" id="btnParentCollapseSidebar" title="Collapse parent menu" onclick="collapseParentSidebarNarrow();">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <!-- Expand parent menu at narrow column edge -->
                <button type="button" class="parent-panel-expand-btn" id="btnParentExpandChildPanel" title="Expand parent menu" onclick="expandParentSidebarWide();">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <!--End Added By Madhuri.K On 09-01-2026-->
            </section>
            <!-- /.sidebar -->
        </aside>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <iframe name="frmNewVersion" id="frmNewVersion" scrolling="auto" class="frmNewVersion"  style="margin-top:0; margin-bottom:0; border:0; margin-left:0; margin-right:0" ></iframe>  

        </div>
                 

  

    </div>
    <%ElseIf m_ProductVersion = 2 Then%>
        <div id="MainDiv" style="display:none">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
        <table id="tblMain">
            <tr class="clsNewTheme">
                <td>
                    <a class="navbar-brand" href="#">
                        <img id="imgLogo" src="../../img/whiz_help_white.png">
                       
                    </a>
                    <label id="lblModuleName" class="lblHeading" onclick="RefreshPage()">Support</label>
                </td>
                <td>
                     
                </td>
                <td>

                    <div class="collapse navbar-collapse shoW" id="navbarResponsive">
                        <ul class="navbar-nav ml-auto">
                               <%If Session("LoginType") <> "C" Then%>
                             <%If Convert.ToInt32(m_strAlertCount) > 0 Then%>
                            <li class="nav-item dropdown" id="flagLink" value='Alert' data-bs-toggle="tooltip" data-bs-placement="bottom"  title="Alerts" >
                             <%Else%>
                            <li class="nav-item dropdown" value='Alert' data-bs-toggle="tooltip" data-bs-placement="bottom" title="Alerts">
                            <%End If%>
                                <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-fw fa-bell clickIcon" ></i>
                                    <span class="new-indicator text-warning d-none d-lg-block">
                                        <span class="number" id="alertCount"><%=m_strAlertCount %></span>
                                    </span>
                                </a>

                            </li>
                           
                            <%If Convert.ToInt32(m_strNotificationCount) > 0 Then%>
                            <li class="nav-item dropdown" id="notifyLink" value='Notification'  title="Notifications" data-bs-toggle="tooltip" data-bs-placement="bottom">
                             <%Else%>
                            <li class="nav-item dropdown" value='Notification'  title="Notifications" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            <%End If%>
                                <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-fw fa-flag clickIcon"  style="background:#00d200" ></i>
                                    <span class="new-indicator text-warning d-none d-lg-block">
                                        <span class="number" id="NotificationCount"><%=m_strNotificationCount%></span>
                                    </span>
                                </a>

                            </li>
                            <%End If%>
                            <%If Convert.ToInt32(m_strDiscussionCount) > 0 Then%>
                            <li class="nav-item dropdown" id="msgLink" value='Discussions' title="Helpdesk Discussions" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            <%Else%>
                            <li class="nav-item dropdown" value='Discussions' title="Helpdesk Discussion" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            <%End If%>
                                <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-fw fa-comments clickIcon"  style="background:#33ccff" ></i>
                                    <span class="new-indicator text-warning d-none d-lg-block">
                                        <span class="number" id="DiscussionCount"><%=m_strDiscussionCount%></span>
                                    </span>
                                </a>
                            </li>
                            
                          
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">                                
                                    <img class="user-image" alt="User Image" src="../../Images/Photo/no-photo.png" onerror="this.onerror=null;this.src='../../Images/Photo/no-photo.png';">
                                <span id="spanUserName"><%=Session("strUserName") %></span>
                                </a>
                                <ul id="profileDropdwn" class="dropdown-menu">
                                    <!-- User image -->
                                    <li class="user-header">
                                        <img id="userImageHeader" class="img-circle" src="../../Images/Photo/no-photo.png" alt="User Image" onerror="this.onerror=null;this.src='../../Images/Photo/no-photo.png'">
                                        <%Dim objAccess As New WebPages.Template.AccessRights%>
                                        <%Dim objGlobal As New WebPages.Template.WhizGlobal(Session("strUserName").ToString, "1085", CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long), CType(Session("intUserID"), Integer), CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0))%>
                                        <%objAccess.GetAccess(objGlobal)%>
                                        <% If objAccess.View Then%>
                                        <p id="employeeRole" title="Click here to view profile" onclick="GotoMyProfile()">
                                        </p>
                                        <p id="employeeRole" title="Click here to view profile" onclick="GotoMyProfile()">My Profile&nbsp;&nbsp;<i class='fa fa-pencil' style="background-color:#3161ea;"></i>
                                        </p>
                                         <%Else%>
                                         <p id="employeeRole" title="You do not have access to view profile">
                                        </p>
                                        <p id="employeeRole" title="You do not have access to view profile">My Profile&nbsp;&nbsp;<i class='fa fa-pencil' style="cursor:no-drop;background-color:#3161ea;"></i>
                                        </p>
                                        <%End If%>
                                    </li>
                                    <style>
                                        #ulUserThemes li a {
                                            width: 100%;
                                            display: block;
                                            cursor: pointer;
                                            padding-left: 5px;
                                        }
                                    </style>
                                <li style="padding-top:0px;">
                                    <div class="bg-dark" data-bs-toggle="collapse" data-bs-target="#ulUserThemes" title="Change Theme" aria-hidden="true" style="text-align:center;padding-bottom:6px;color:white;cursor:pointer;" >
                                        Set Theme <i class="fa fa-paint-brush" style="background-color:#3161ea;"></i>
                                   </div>
                                    <ul id="ulUserThemes" class="collapse" style="right:0px;left:auto;padding-left:5px;width:100%;">
                                       <%PlotThemes()%>
                                    </ul>
                                </li> 
                                    <!-- Menu Body -->

                                    <!-- Menu Footer-->
                                    <li class="user-footer">

                                        <div class="float-end">
                                            <a href="#" class="btn btn-default btn-flat btnBorder" data-bs-toggle="modal" data-bs-target="#myLogOut">Logout</a>
                                        </div>  
                                    </li>
                                </ul>   
                                </li>
                            <%--Commented By Aniruddh Gujar on 04-Dec-2018 Purpose::To remove change version link                  
                            <li >
                                <% If Session("LoginType") <> "C" Then%>
                                <i class="fa fa-sign-out" style="cursor:pointer" onclick="toggleToOldVersion(1)" title="Change Version" data-bs-toggle="tooltip" data-bs-placement="left"></i>
                                <%Else%>
                                <i class="fa fa-sign-out" style="cursor:pointer" title="Access Restricted." aria-hidden="true"></i>
                                <%End If%>
                            </li> 
                            End of Commented By Aniruddh Gujar on 04-Dec-2018 Purpose::To remove change version link--%>            
                        </ul>
                    </div>

                </td>



            </tr>
            <tr>
                <td colspan="3">
                    <ul class="navbar-nav navbar-sidenav clsNewTheme" id="exampleAccordion" style="margin-top:10px;">


                        <%CommonFunctions.General.WriteHTML(GetLeftTree())%>

                    </ul>

                    
                    <iframe name="frmNewVersion" id="frmNewVersion" scrolling="no" class="frmNewVersion"  margin-top:"0" margin-bottom:"0" border:"0"  target:"_self" margin-left:"0" margin-right:"0" ></iframe> 
                </td>
            </tr>
        </table>
    </nav>
            </div>
    <%ElseIf m_ProductVersion = 1 Then%>
                    <div id="MainDiv">

                        <%-- Commented By Vaijat K ON 10/06/2017 For Plotting New Tree And Header Section --%>
                        <iframe name="link" id="link" scrolling="no" class="iframeLinks" src ="Links.aspx?FromWhere=<%=strFromWhere%>" margin-top:"0" margin-bottom:"0" border:"0"  target:"_self" margin-left:"0" margin-right:"0"></iframe>
                        <%-- End of Commented By Vaijat K ON 10/06/2017 For Plotting New Tree And Header Section --%>

                        <%If strMainPage <> "" Then%>
                        <div id="frmDown" style="float: left; width: 100%; display: block;">
                            <!--Added And Commented By VijayD On 13 August 2009
		      PURPOSE : To hide Old navigation from the list-->
                            <!-- dhanashri -->
                            <iframe id="Main" style="display: none; width: 0px" class="iframeTreeMain" src="<%=strMainPage%>?FromWhere=<%=strFromWhere%><%=strBTSMainString%>" scrolling="no" name="Main" target="Sub"></iframe>
                            <!--<frame id="Main" BORDERCOLOR="yellow" name="Main"  target="Sub" style="display:none;width:0px" >-->
                            <!-- End Addtion and Comment By VijayD -->
                            <%If InStr(1, strSubPage, "?") > 0 Then%>
                            <%If InStr(1, strSubPage, "FromWhere") = 0 Then%>
                            <%If strFromWhere <> "DB" Then%>
                            <!-- dhanashri -->
                            <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>&FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="no" name="Sub" style="width: 100%; border: none"></iframe>
                            <%Else%>
                            <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>&FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="Yes" name="Sub" style="width: 100%; border: none"></iframe>
                            <%End If%>
                            <%Else%>
                            <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>&<%=strBTSSubString%><%=strKMSubString%>" scrolling="no" name="Sub" style="width: 100%; border: none"></iframe>
                            <%End If%>
                            <%Else%>
                            <%If strFromWhere <> "DB" Then%>
                            <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>?FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="no" name="Sub" style="width: 100%; border: none"></iframe>
                            <%Else%>
                            <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>?FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="Yes" name="Sub" style="width: 100%; border: none"></iframe>
                            <%End If%>
                            <%End If%>
                        </div>
                        <!--Integrated by MrugajaB on 19th Dec 2005-->
                        <%Else%>
                        <%If InStr(1, strSubPage, "?") > 0 Then%>
                        <%If InStr(1, strSubPage, "FromWhere") = 0 Then%>
                        <%If strFromWhere <> "DB" Then%>
                        <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>&FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="no" name="Sub" style="width: 100%; border: none"></iframe>
                        <%Else%>
                        <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>&FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="Yes" name="Sub" style="width: 100%; border: none"></iframe>
                        <%End If%>
                        <%Else%>
                        <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>&<%=strBTSSubString%><%=strKMSubString%>" scrolling="no" name="Sub" style="width: 100%; border: none"></iframe>
                        <%End If%>
                        <%Else%>
                        <%If strFromWhere <> "DB" Then%>
                        <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>?FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="no" name="Sub" style="width: 100%; border: none"></iframe>
                        <%Else%>
                        <iframe id="Sub" class="iframeSub" src="<%=strSubPage%>?FromWhere=<%=strFromWhere%><%=strBTSSubString%><%=strKMSubString%>" scrolling="Yes" name="Sub" style="width: 100%; border: none"></iframe>
                        <%End If%>
                        <%End If%>
                        <%End If%>
                    </div>
                
    <!--Added by swapnil aswale on 2-Dec-2015 for[ Mobile Responsive Code]-->
        <%End If%>
    <div id="page" style="display: none">
        <%If m_ProductVersion = 1 Then%>
        <div class="menu-header">

            <a id="mobilemenu" href="#menu"></a>
            <%--  <center>Lifeline Systech Solutions Pvt.Ltd.</center>--%>
            <label id="mobileHomePage" style="margin-left: 20px">Home</label>

            <img id="imgAllCount" src="../../img/1920/notificationIcon.png" style="height: 30px; width: 30px; position: absolute; right: 41px; top: 6px" />
            <div id="divNotification"></div>

            <img id="imgEmployeeHome" src="../../img/1920/no-photo.png" alt="No Image" style="margin-top: 4px; width: 17px; height: 25px; top: 2px; position: absolute; right: 1px;" align="right" />

            <!--<label id='cpNameHome' style="color:white;font-weight:100" class='cpHomePage'></label>-->


        </div>

        <div class="MenuContent">

            <div id="header">

                <div class="leftheader">

                    <div class="btn-group button-margin">
                        <asp:Label ID="lbl_user" runat="server" Style="display: none"></asp:Label>
                    </div>
                    <div style="margin-top: 6%; float: left;">
                        <button class="btn" type="button" onclick="logout();" style="display: none">Log Out</button>
                    </div>
                </div>
            </div>

            <%--<div class="master">
                <div class="master-Menus">
                    <div id="con" class="boxcontainer">
                        <a href="Navigation.aspx" class="menu-link">
                            <div class="box" id="home">
                                <img src="../../responsive/images/home.gif" alt="Home" class="slider-image" /><br />
                                Home
                            </div>
                        </a>
                      
                        <a href="Projects.aspx" class="menu-link">
                            <div class="box" id="project">
                                <img src="../../responsive/images/Project%20.gif" alt="Project" class="slider-image" /><br />
                                Project
                            </div>
                        </a>
                       
                        <a href="../PM/PM_DailyActivityMobile.aspx" class="menu-link">
                            <div class="box" id="timesheet">
                                <img src="../../responsive/images/time.gif" alt="TimeSheet Entry" class="slider-image" /><br />
                                TimeSheet Entry
                            </div>
                        </a>
                        
                    </div>
                 
                </div>
            </div>--%>



            <div class="content-page">
                <%--   <div>
                 <table style="width:100%;margin:10px">
                     <tr>
                         <td>
                           <label style="color:#27408B;font-weight:bold;">Name:</label><label id="cpName" style="font-weight:100" class="cpHome"></label>
                         </td>
                         <td rowspan="3">
                             <img id="imgEmployee" alt="No Image" style="width:75px;height: 75px;margin-right: 9%;" align="right" />
                         </td>
                     </tr>
                     <tr>
                         <td>
                           <label style="color:#27408B;font-weight:bold;"/>Role:<label id="cpRole" style="font-weight:100" class="cpHome"></label> 
                         </td>
                     </tr>
                     <tr>
                         <td>
                           <label style="color:#27408B;font-weight:bold;"/>Emp Code:<label id="cpEmpCode" style="font-weight:100" class="cpHome"></label> 
                         </td>
                     </tr>
                 </table>
             </div>--%>
                <div id="DivGraphInfo">
                    <div id="Div1" style="height: 350px;">
                        <div id="InstructNote">
                            Click on bar to see other overall pendings
                        <p style="color: red; font-size: 11px; display: inline-block; right: 0px; position: absolute;">Limited features*</p>
                        </div>
                        <table class="shadow" style="background-color: white; border: 0px white; vertical-align: top; width: 100%;">
                            <tr>
                                <td>
                                    <table id="tblAllApprovalGraph" style="background-color: transparent; border: 0px white;">
                                        <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="GraphHeaderApproval" style="width: 100%">Overall Pending</p>
                                                <div id="divNoAllApprovalGraph" style="width: 100%; display: inline-block"></div>
                                                <div id="AllApprovalGraph" style="white-space: nowrap; height: 250px; width: 185px;">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <%--<td width="50%" style="color: #27408B">--%>
                                <%--<label id="LeaveCount"></label>
                                <br />
                                <label id="ExpenseCount"></label>
                                <br />
                                <label id="TimeSheetCount"></label>
                                <br />
                                <label id="EntityCount"></label>--%>
                                <%--</td>--%>
                                <td id="tblleaveGraph1">


                                    <table style="background-color: transparent; border: 0px white;">
                                        <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="GraphHeaderLeave" style="width: 100%">Leave</p>
                                                <div id="divNoLeaveGraph" style="width: 100%; display: inline-block"></div>
                                                <div id="leaveGraph1" class="pposition" style="white-space: nowrap; height: 225px; width: 150px;">
                                                </div>
                                            </td>
                                        </tr>

                                    </table>

                                </td>
                                <td id="tblEntityGraph">

                                    <table style="background-color: transparent; border: 0px white;">
                                        <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="GraphHeaderEntity" style="width: 100%">Entity</p>
                                                <div id="divNoEntityGraph" style="width: 100%; display: inline-block"></div>
                                                <div id="EntityGraph" style="white-space: nowrap; height: 300px; width: 150px;">
                                                </div>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                                <td id="tblExpenseGraph">
                                    <table style="background-color: transparent; border: 0px white;">
                                        <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="GraphHeaderExpense" style="width: 100%">Expense</p>
                                                <div id="divNoExpense" style="width: 100%; display: inline-block"></div>
                                                <div id="ExpenseGraph" class="pposition" style="white-space: nowrap; height: 225px; width: 150px;">
                                                </div>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                                <td id="tblTimesheetGraph">
                                    <table style="background-color: transparent; border: 0px white;">
                                        <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="GraphHeaderTimesheet" style="width: 100%;">Timesheet</p>
                                                <div id="divNoTimesheet" style="width: 100%; display: inline-block"></div>
                                                <div id="TimesheetGraph" class="pposition" style="white-space: nowrap; height: 225px; width: 150px;">
                                                </div>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                                <%-- Added By Vaijat K ON 25/04/2016 For HelpDesk Graph --%>
                                <td id="tblHelpDesk">
                                    <table style="background-color: transparent; border: 0px white;">
                                        <tr>
                                            <td>
                                                <p class="Leaveflip pheading" id="P1" style="width: 100%;">HelpDesk</p>
                                                <div id="divNoHelpDesk" style="width: 100%; display: inline-block"></div>
                                                <div id="divHelpDesk" class="pposition" style="white-space: nowrap; height: 225px; width: 150px;">
                                                </div>
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>
                        </table>



                    </div>

                    <p class="flip" style="cursor: pointer">My Leave</p>
                    <table class="panel shadow" style="background-color: transparent; border: 0px white; width: 100%;">
                        <tr>
                            <td>
                                <div id="leaveGraph" style="white-space: nowrap; width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td width="50%" style="color: #27408B">
                                <label id="entitlementId"></label>
                                <br />
                                <label id="BalanceId"></label>
                            </td>
                        </tr>

                    </table>

                    <p class="approvalflip" style="cursor: pointer">My Approval</p>
                    <table class="approvalPanel shadow" style="background-color: transparent; border: 0px white; width: 100%">

                        <tr>
                            <td colspan="2" style="width: 100%">
                                <label id="lblProjectHeading"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="approvalGraph" style="width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td style="white-space: nowrap; color: #27408B; width: 50%">
                                <label id="ProjectApprovedId"></label>
                                <br />
                                <label id="ProjectPendingID"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <hr size="2" />
                                <label id="lblMilestoneHeading"></label>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <div id="approvalGraphMilestone" style="width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td width="50%" style="white-space: nowrap; color: #27408B">
                                <label id="MilestoneApprovedId"></label>
                                <br />
                                <label id="MilestonePendingId"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <hr size="2" />
                                <label id="lblModuleHeading"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="approvalGraphModule" style="width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td width="50%" style="white-space: nowrap; color: #27408B">
                                <label id="ModuleApprovedId"></label>
                                <br />
                                <label id="ModulePendingId"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <hr size="2" />
                                <label id="lblSubHeading"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="approvalGraphSub" style="width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td width="50%" style="white-space: nowrap; color: #27408B">
                                <label id="SubProjectApprovedId"></label>
                                <br />
                                <label id="SubProjectPendingId"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <hr size="2" />
                                <label id="lblDelHeading"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="approvalGraphDeliverable" style="width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td width="50%" style="white-space: nowrap; color: #27408B">
                                <label id="DeliverableApprovedId"></label>
                                <br />
                                <label id="DeliverablePendingId"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <hr size="2" />
                                <label id="lvlChangeHeading"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="approvalGraphChangeRequest" style="width: 150px; height: 275px;">
                                </div>
                            </td>
                            <td width="50%" style="white-space: nowrap; color: #27408B">
                                <label id="ChangeApprovedId"></label>
                                <br />
                                <label id="ChangePendingId"></label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="footbar">Lifeline Systech Solutions Pvt.Ltd.</div>

            <nav id="menu">
                <ul>

                    <li><a href="Navigation.aspx?FromWhere=DB" id="Hhome">
                        <img src="../../responsive/images/home.gif" style="width: 10; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Home</a></li>
                    <li><a href="../PM/MyApproval.aspx" id="A1">
                        <img src="../../responsive/images/Project .gif" style="width: 20px; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;My Approval </a></li>
                    <%-- <li><a href="Projects.aspx" id="Hproject">
                <img src="../../responsive/images/Project .gif" style="width: 20; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Project </a></li>
            <li><a href="UnderContructionPage.aspx">
                <img src="../../responsive/images/res_utilazation.jpg" style="width: 20; height: 11px" />&nbsp;&nbsp;&nbsp;&nbsp;Resource Utilization</a></li>--%>
                    <li><a href="../PM/PM_DailyActivityMobile.aspx">
                        <img src="../../responsive/images/time.gif" style="width: 20; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;TimeSheet Entry</a></li>

                    <%--              <li>
                &nbsp;&nbsp;&nbsp;&nbsp;Settings</li>--%>
                    <li><a href="">
                       <%-- //../NewAPI/TimesheetMobile/TimesheetApproval_Mobile.aspx--%>
                        <img src="../../responsive/images/time.gif" style="width: 20; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;TimeSheet Approval</a></li>
                    <li><a href="<%= ResolveUrl("../../default.aspx?Message=LOGOUT")%>"><%--onclick="logout();"--%>
                        <img src="../../responsive/images/Button-Log-Off.png" style="width: 20; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Log Out</a></li>

                    <%--<li><a href="UnderContructionPage.aspx">
                <img src="../../responsive/images/Cal.gif" style="width: 20; height: 20px" />&nbsp;&nbsp;&nbsp;&nbsp;Calendar</a></li>--%>
                </ul>
            </nav>
        </div>
        <div id="Authorize" style="margin-top: 10%; text-align: center; font-weight: bold; display: none">You are not authorize to view on this resolution</div>
        <%Else %>
         <iframe name="frmNewResponsiveVersion" id="frmNewResponsiveVersion" scrolling="auto" class="frmNewVersion"  margin-top:"0" margin-bottom:"0" border:"0"  target:"_self" margin-left:"0" margin-right:"0" ></iframe>  
        <%--Added By Dipali V On 11th jan 2021 for check Module Access--%>
        <div id="DivCheckModuleAccess">You are not authorized to view this page </div>
        <%--End of Added By Dipali V On 11th jan 2021 for check Module Access--%>
         <div class="Mv_mobmenu hidden-desktop">

              <div class="navbar-custom-menu">
                <ul class="nav navbar-nav" style="display:inline-block!important;float: left !important;margin-left: 1px !important;">
                    <li class="user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs" id="EmployeeName"></span>
                            <!-- The user image in the navbar-->
                            <img id="UserImage" src="../../Images/Photo/no-photo.png" onerror="this.src='../../Images/Photo/no-photo.png'" class="user-image" alt="User Image">
                        </a>
                       
                    </li>
                    <%If Convert.ToInt32(m_strAlertCount) > 0 Then%>
                    <li class="nav-item" id="flagLink" value='Alert' data-bs-toggle="tooltip" data-bs-placement="bottom"  title="Alerts" >
                    <%Else%>
                    <li class="nav-item" value='Alert' data-bs-toggle="tooltip" data-bs-placement="bottom" title="Alerts">
                    <%End If%>
                            <i class="fa fa-fw fa-bell clickIcon" ></i>
                            <span class="new-indicator text-warning d-none d-lg-block">
                                <span class="number" id="alertCount"><%=m_strAlertCount %></span>
                            </span>
                    </li>
                           
                    <%If Convert.ToInt32(m_strNotificationCount) > 0 Then%>
                    <li class="nav-item" id="notifyLink" value='Notification'  title="Notifications" data-bs-toggle="tooltip" data-bs-placement="bottom">
                    <%Else%>
                    <li class="nav-item" value='Notification'  title="Notifications" data-bs-toggle="tooltip" data-bs-placement="bottom">
                    <%End If%>
                            <i class="fa fa-fw fa-flag clickIcon"  style="background:#00d200" ></i>
                            <span class="new-indicator text-warning d-none d-lg-block">
                                <span class="number" id="NotificationCount"><%=m_strNotificationCount%></span>
                            </span>
                    </li>
                    <%If Convert.ToInt32(m_strDiscussionCount) > 0 Then%>
                    <li class="nav-item" id="msgLink" value='Discussions' title="Helpdesk Discussions" data-bs-toggle="tooltip" data-bs-placement="bottom">
                    <%Else%>
                    <li class="nav-item" value='Discussions' title="Helpdesk Discussion" data-bs-toggle="tooltip" data-bs-placement="bottom">
                    <%End If%>
                            <i class="fa fa-fw fa-comments clickIcon"  style="background:#33ccff" ></i>
                            <span class="new-indicator text-warning d-none d-lg-block">
                                <span class="number" id="DiscussionCount"><%=m_strDiscussionCount%></span>
                            </span>
                    </li>
                    <li>
                        <a href="#">
                            <img class="weeklycalender_icon" onclick="logout()" src="../../Whizible2.0-new/dist/img/logout-white.svg" alt="" width="20px"></a>
                    </li>
                </ul>
            </div>
           <div class="clearfix"></div>
             <%--Commented sidebar menu by pradip on 25-1-2023--%>
            <ul class="sidebar-menu" id="responsiveMenu">   
                <%-- Uncommneted By Dipali V On 18th May 2023 For Responsive issue--%>
                <%--<li><a href="#"><i class="fa">
                    <img src="../../Whizible2.0-new/dist/img/Home.png" alt="" width="44px"></i> <span>Dashboard</span></a></li>
                <li><a href="#"><i class="fa">
                    <img src="../../Whizible2.0-new/dist/img/Projects.png" alt="" width="44px"></i> <span>Projects</span></a></li>
                <li class="active"><a href="#"><i class="fa">
                    <img src="../../Whizible2.0-new/dist/img/Timesheet.png" alt="" width="44px"></i><span>Timesheet</span></a></li>
                <li><a href="#"><i class="fa">
                    <img src="../../Whizible2.0-new/dist/img/issues.png" alt="" width="44px"></i> <span>Issues</span></a></li>
                <li><a href="#"><i class="fa">
                    <img src="../../Whizible2.0-new/dist/img/MIS.png" alt="" width="44px"></i> <span>MIS</span></a></li>
                <li><a href="#"><i class="fa">
                    <img src="../../Whizible2.0-new/dist/img/Help-desk.png" alt="" width="44px"></i> <span>Help desk</span></a></li>
                <li class="Mmenulogo"><a href="/"><i class="fa">&;nbsp</i> <span>
                    <img src="../../Whizible2.0-new/dist/img/mobmenu/Whisible.png" alt="" width="60px"></span></a></li>--%>
                 <%--End of  Uncommneted By Dipali V On 18th May 2023 For Responsive issue--%>
            </ul>

 </div>
        <div class="Mv_bottommainsubmenu hidden-desktop">

            <ul class="mainsubmenu" id="responsiveSubmenu">
                <li>
                    <!-- Sidebar toggle button-->
                    <a class="Mmenu_toggle" id="Mmenu_togglebtn">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </a>
                </li>
                <li class="active">
                    <%-- Commented & Added By Dipali V On 5th Jan 2021 for Responsive page not get display--%>
                    <a href="">
                        <%--../NewAPI/TimesheetMobile/TimesheetEntry_Mobile.aspx--%>
                        <%--<a href="../TimesheetMobile/TimesheetEntry_Mobile.aspx">--%>
                        <%-- End of Commented & Added By Dipali V On 5th Jan 2021 for Responsive page not get display--%>
                        <img class="nonactivemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/timesheet-entry.svg" width="30px">
                        <img class="activemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/timesheet-entry-active.svg" width="30px">
                    </a>
                </li>
                <li>
                    <%-- Commented & Added By Dipali V On 5th Jan 2021 for Responsive page not get display--%>
                    <a href="">
                        <%--../NewAPI/TimesheetMobile/MyTimesheet_Mobile.aspx--%>
                       <%-- <a href="../TimesheetMobile/MyTimesheet_Mobile.aspx">--%>
                        <%-- End of Commented & Added By Dipali V On 5th Jan 2021 for Responsive page not get display--%>
                        <img class="nonactivemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/my-timesheet.svg" width="30px">
                        <img class="activemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/my-timesheet-active.svg" width="30px">
                    </a>
                </li>
                <li>
                   <%-- Commented & Added By Dipali V On 5th Jan 2021 for Responsive page not get display--%>
                   <%-- <a href="../TimesheetMobile/TimesheetApproval_Mobile.aspx">--%>
                    <a href="../NewAPI/TimesheetMobile/TimesheetApproval_Mobile.aspx">
                        <%-- End of Commented & Added By Dipali V On 5th Jan 2021 for Responsive page not get display--%>
                        <img class="nonactivemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/timesheet-approval.svg" width="30px">
                        <img class="activemenuimg" src="../../Whizible2.0-new/dist/img/mobmenu/timesheet-approval-active.svg" width="30px">
                    </a>
                </li>
            </ul>
        </div>

            
        <%End If%>
    </div>
    <%End If%>
        <div class="modal fade custmodal in" id="myModal2" style="overflow-y:hidden;outline:none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" >
            <div class="modal-content" style="overflow:hidden">
              <div class="modal-header">
               <%--<button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true" style="width: 32px;height: 32px"><i class="fa fa-times"></i></button>--%>
            <i class="fa fa-file-text-o" id="myHeaderIcon" aria-hidden="true"></i> 
                  <strong><span class="modal-title" id="myModalLabel" title="Unseen Count"></span></strong>  
                   </div>
              <div class="modal-body" id='modalboady'style="height: 350px;outline:none; width:103%">        
      
              </div>
             <div class="modal-footer">            
          
                 <a href="#" style="float:left;display:none; font-family:'Roboto', Sans-serif; font-size:12px;" id="lnkLoadalreadyViewed">Load More...</a>
                 <button type="button" id="btnMarkAllRead" class="btn btn-default btnyellow save" onclick="MarkAllDiscussionAsRead()">Mark All As Read</button>
                 <button type="button" id="btnCloseModel" class="btn borderbtn" data-bs-dismiss="modal">Close</button>
              </div>
            </div>
       </div>
    </div> 

    <div class="modal custmodal fade" id="myLogOut" style="overflow-y:hidden;outline:none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" >
            <div class="modal-content" style="overflow:hidden">
              <div class="modal-header">
                  <%--Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes--%>
                 <%--Logout--%>
                  <%--End of Commented and Added By Nikhil A on 28-May-2020 for Integrating UX changes--%>
                  <h4 class="modal-title">Logout</h4>
                   </div>
              <div class="modal-body"style="outline:none; width:103%">        
                  Are you sure want to Logout?
              </div>
             <div class="modal-footer">            
                 <button type="button" id="btnLogout" class="btn btn-default btnyellow save" onclick="logout()">Logout</button>
                <!-- Removed class by Gauri on 24th Sep 2024 for Button background color -->
                 <button type="button" class="btn borderbtn save" data-bs-dismiss="modal" onclick="Close_Div()">Close</button>
              </div>
            </div>
       </div>
    </div> 

        <script src="../../Whizible2.0-new/dist/js/custom_mobile.js"></script>
<script>


</script>

</body>
<!--End Mobile Responsive Code-->
<%--<script src="../../responsive/Scripts/borderMenu.js" type="text/javascript"></script>
<script src="../../responsive/Scripts/classie.js" type="text/javascript"></script>--%>
<%End If%>
</html>
 <script
    type="text/javascript"
    src="../../Whizible2.0-new/AzureAD/msal-browserv2.13.1.js"
    integrity=""
    crossorigin="anonymous"></script>
<script type="text/javascript">
    //Added By Pradip P on 20 Jan 2021 For close user window
    $(document).on("click", function (event) {
        var $trigger = $(".dropdown");
        if ($trigger !== event.target && !$trigger.has(event.target).length) {
            //added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
            $(".dropdown-menu").not(".bootstrap-select .dropdown-menu").slideUp("fast");
            //End of added by Aditya J. on 12-06-2026 for sesison dropdown selectpicker issue
        }
    });
    //End of Added By Pradip P on 20 Jan 2021 For close user window

    /*Added By DipaliV 12th Jan 2020 for Logout pop Up changes */
    function OpenLodoutDIV() {
        //alert();
        //Commented and Added By Reshma Chavan on 21 Jan 2021 For close user window
        //$("#Ulmenu").show();
        if ($("#Ulmenu").css("display") == 'block') {
            $("#Ulmenu").hide();
        } else {
            $("#Ulmenu").show();
        }
        //End of Commented and Added By Reshma Chavan on 21 Jan 2021 For close user window
    }

    function ClickofLogOut() {

        $("#Ulmenu").hide();
        $("#myLogOut").show('modal');
        $("#myLogOut").addClass('in');
    }

    function Close_Div() {
        $("#myLogOut").hide('modal');
    }
    /*End of Added By DipaliV 12th Jan 2020 for Logout pop Up changes */
    function logout() {
        //Modified By Nikhil Adkar for Azure AD Integration 
        var AzureAD = '<%=System.Configuration.ConfigurationManager.AppSettings("AzureAD").ToString%>';
        if (AzureAD == '1') {
           
            const config = {
                auth: {
                    clientId: "<%=System.Configuration.ConfigurationManager.AppSettings("ClientID").ToString%>",
                    <%--redirectUri: "<%=System.Configuration.ConfigurationManager.AppSettings("redirectUri").ToString%>",--%> //defaults to application start page
                    <%--postLogoutRedirectUri: "<%=System.Configuration.ConfigurationManager.AppSettings("postLogoutRedirectUri").ToString%>",--%>
                },
            };

            const myMsal = new msal.PublicClientApplication(config);
            
            // you can select which account application should sign out
            const logoutRequest = {
                account: myMsal.getAccountByHomeId('<%=Session("AD")%>'),
            };

            myMsal.logoutRedirect(logoutRequest);
            window.close();
        }
        else {
            //if (confirm("Are you sure want to logout?"))
            //Added By Nikhil A for Back Refresh Attack
            window.history.replaceState("Navigation.aspx", null, "ErrorPage.aspx")

            var path = 'ErrorPage.aspx'; //write here name of your page
            history.pushState(null, null, path + window.location.search);
            window.addEventListener('popstate', function (event) {
                history.pushState(null, null, path + window.location.search);
            });
            //Added By Nikhil A for Back Refresh Attack
            window.location = '<%= ResolveUrl("../../default.aspx?Message=LOGOUT")%>';
        }
       <%-- window.history.replaceState("Navigation.aspx", null, "ErrorPage.aspx")

        var path = 'ErrorPage.aspx'; //write here name of your page
        history.pushState(null, null, path + window.location.search);
        window.addEventListener('popstate', function (event) {
            history.pushState(null, null, path + window.location.search);
        });
        //Added By Nikhil A for Back Refresh Attack
        window.location = '<%= ResolveUrl("../../default.aspx?Message=LOGOUT")%>';--%>
        //End of modified By Nikhil Adkar
       
    }

    //Add By Dipali Vekhande On 16th Aug 2016 for Close Login Window After Session Out
    //function doUnload() {
    //    // console.log(document.getElementById("closehidden").value)

    //    if (document.getElementById("closehidden").value == 1) {
    //        $.ajax({
    //            type: 'GET',
    //            async: false,
    //            url: '../../Default.aspx?Message=LOGOUT'
    //        });
    //    }

    //}
    //End Of Addition By Dipali V On 16th Aug 2016 for Close Login Window After Session Out
</script>
<script type="text/javascript">
    //Added by swapnil A for ChangeUser [single sign on] on 20-12-2015
    var objLeaveRoleAccess;
    var objExpenseRoleAccess;
    var objTimesheetRoleAccess;
    var objEntityRoleAccess;
    var objHelpdeskRoleAccess;
    var objResourceTimesheetAccess;
    var objProjectTimesheetAccess;
    function changeUser() {

        window.open("../../Default.aspx?Message=CU", "_top");
    }
    function toggleToOldVersion(flag) {

        $.ajax({
            url: "Navigation.aspx/ChangeVersion",
            data: JSON.stringify({ VersionID: "1" }),
            dataType: "json",
            contentType: "application/json",
            type: "POST",
            success: function (result) {
                var strFromWhere = '<%=Session("strActiveModule")%>';
                window.open("Navigation.aspx?FromWhere=" + strFromWhere, "_self")
            }
        })
    }
    function GetAllCount() {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/GetAllCount',
            data: JSON.stringify({ intUserID: "<%=Session("intUserID")%>" }),
            success: function (Result) {
                if (document.getElementById("divNotification") != null) {
                    document.getElementById("divNotification").innerHTML = Result.d;
                    document.getElementById("divNotification").style.cursor = "pointer";
                }
            },
        });
    }
    $("#divNotification").click(function () {
        window.location.href = "../PM/MyApproval.aspx";
    })
    //Ended by swapnil A for ChangeUser [single sign on] on 20-12-2015
    $(document).ready(function () {
        //Added   By Dipali V On 23rd Oct 2023 for Toggle Navigation Menus Issue
        //Modified By Madhuri.K On 16-01-2026 - Re-initialize parent icon tooltips when sidebar is toggled to ensure they always show
        $(".sidebar-toggle").on("click", function () {
            $("body").toggleClass("sidebar-collapse");
            $("body").removeClass("sidebar-expanded-on-hover");
            
            //Added By Madhuri.K On 27-01-2026 - Close child panel when user clicks collapse menu icon
            hideChildPanel();
            
            //Modified By Madhuri.K On 16-01-2026 - Set data-tooltip and add JavaScript-based tooltip positioning
            // Changed By Madhuri.K on 10-07-2026 - Removed 100ms delay; icons already exist when sidebar is toggled
            var parentIcons = document.querySelectorAll('.parent-panel .sidebar-menu > li.parent-icon > a > i.fa');
                parentIcons.forEach(function(icon) {
                    // Get title from icon, parent link, or hidden input
                    var title = icon.getAttribute('title') || icon.getAttribute('data-tooltip') || icon.closest('a').getAttribute('title');
                    if (!title) {
                        var $hiddenInput = $(icon).closest('li').find('input[type="hidden"][id^="header_"]');
                        if ($hiddenInput.length > 0) {
                            title = $hiddenInput.val();
                        }
                    }
                    // Set data-tooltip for custom CSS tooltip and remove title to hide native tooltip
                    if (title) {
                        icon.setAttribute('data-tooltip', title);
                        icon.removeAttribute('title'); // Remove title to hide native browser tooltip
                        
                        // Add hover event to position tooltip dynamically
                        var liId = icon.closest('li').id || 'li-' + Math.random().toString(36).substr(2, 9);
                        if (!icon.closest('li').id) {
                            icon.closest('li').id = liId;
                        }
                        
                        icon.addEventListener('mouseenter', function(e) {
                            var rect = icon.getBoundingClientRect();
                            var tooltipText = icon.getAttribute('data-tooltip');
                            
                            // Create tooltip element if it doesn't exist
                            var tooltipEl = document.getElementById('custom-tooltip-' + liId);
                            if (!tooltipEl) {
                                tooltipEl = document.createElement('div');
                                tooltipEl.id = 'custom-tooltip-' + liId;
                                tooltipEl.className = 'custom-parent-tooltip';
                                tooltipEl.textContent = tooltipText;
                                document.body.appendChild(tooltipEl);
                            }
                            
                            // Position tooltip to the right of icon
                            tooltipEl.style.left = (rect.right + 10) + 'px';
                            tooltipEl.style.top = (rect.top + rect.height / 2 - tooltipEl.offsetHeight / 2) + 'px';
                            tooltipEl.style.display = 'block';
                        });
                        
                        icon.addEventListener('mouseleave', function() {
                            var tooltipEl = document.getElementById('custom-tooltip-' + liId);
                            if (tooltipEl) {
                                tooltipEl.style.display = 'none';
                            }
                        });
                    }
            });
        });
        

        //Modified By Madhuri.K On 16-01-2026 - Set data-tooltip and add JavaScript-based tooltip positioning
        // Changed By Madhuri.K on 19-08-2026 - Removed artificial delay; tree tooltips are also set in PlotNavigationTree success
        (function() {
            var parentIcons = document.querySelectorAll('.parent-panel .sidebar-menu > li.parent-icon > a > i.fa');
            parentIcons.forEach(function(icon) {
                // Get title from icon, parent link, or hidden input
                var title = icon.getAttribute('title') || icon.getAttribute('data-tooltip') || icon.closest('a').getAttribute('title');
                if (!title) {
                    var $hiddenInput = $(icon).closest('li').find('input[type="hidden"][id^="header_"]');
                    if ($hiddenInput.length > 0) {
                        title = $hiddenInput.val();
                    }
                }
                // Set data-tooltip for custom CSS tooltip and remove title to hide native tooltip
                if (title) {
                    icon.setAttribute('data-tooltip', title);
                    icon.removeAttribute('title'); // Remove title to hide native browser tooltip
                    
                    // Add hover event to position tooltip dynamically
                    var liId = icon.closest('li').id || 'li-' + Math.random().toString(36).substr(2, 9);
                    if (!icon.closest('li').id) {
                        icon.closest('li').id = liId;
                    }
                    
                    icon.addEventListener('mouseenter', function(e) {
                        var rect = icon.getBoundingClientRect();
                        var tooltipText = icon.getAttribute('data-tooltip');
                        
                        // Create tooltip element if it doesn't exist
                        var tooltipEl = document.getElementById('custom-tooltip-' + liId);
                        if (!tooltipEl) {
                            tooltipEl = document.createElement('div');
                            tooltipEl.id = 'custom-tooltip-' + liId;
                            tooltipEl.className = 'custom-parent-tooltip';
                            tooltipEl.textContent = tooltipText;
                            document.body.appendChild(tooltipEl);
                        }
                        
                        // Position tooltip to the right of icon
                        tooltipEl.style.left = (rect.right + 10) + 'px';
                        tooltipEl.style.top = (rect.top + rect.height / 2 - tooltipEl.offsetHeight / 2) + 'px';
                        tooltipEl.style.display = 'block';
                    });
                    
                    icon.addEventListener('mouseleave', function() {
                        var tooltipEl = document.getElementById('custom-tooltip-' + liId);
                        if (tooltipEl) {
                            tooltipEl.style.display = 'none';
                        }
                    });
                }
            });
        })();
        
        $(".bg-dark").tooltip();
        $(".employeeRole").tooltip();
        $("#logout").tooltip();
        //$(document).click(function () {
        //    $(".tooltip").removeClass("in");
        //});
        $("[data-bs-toggle=dropdown]").click(function () {
            $(this).parent().toggleClass("open");
        })
        //Add by Dipali V On 16th Aug 2016 for Close Login Window After Session Out
        $(document).on('click', '#profileDropdwn', function (e) {
            e.stopPropagation();
        });
        $("HTML").append("<input type='hidden'  id='closehidden'/>");
        document.getElementById("closehidden").value = 1;

        //End Of Addition by Dipali V On 16th Aug 2016 for Close Login Window After Session Out
        if ($(window).width() <= 720) {
            setFrameLoader();

            //Added by Vyankat B on 21/07/2026: hide loader when responsive iframe finishes loading,
            //because parent window.onload may never fire while the iframe keeps re-navigating
            $("#frmNewResponsiveVersion").on("load", function () { RemoveFrameLoader(); });
            //Safety net in case the iframe load event never fires (slow network / 404 resources)
            setTimeout(RemoveFrameLoader, 15000);
            //End of Added by Vyankat B on 21/07/2026

            document.body.style.height = window.innerHeight - 3 + 'px';
            $("#menu").css("height", window.innerHeight - 3 + 'px');


            GetAllCount();
            //$('#lbl_user').text('<%=Session("strUserName")%>' + "(" + '<%=m_RoleDesc%>' + ")");

            if ('<%=Session("LoginType")%>' == 'C') {
                document.getElementsByClassName('MenuContent')[0].style.display = 'none';
                document.getElementById('Authorize').style.display = 'block';
                document.getElementById('mobilemenu').style.display = 'none';
                document.getElementById('mobileHomePage').style.display = 'none';
            }


            $('#cpName').text('<%=Session("strUserName")%>');
            $('#cpRole').text('<%=Session("RoleDesc")%>');
            $('#cpNameHome').text('<%=Session("strUserName")%>');
            $('#cpRoleHome').text('<%=Session("RoleDesc")%>');
            $('#cpEmpCode').text('<%=Session("EmployeeCode")%>');
            var intDivHeight = document.getElementById('DivGraphInfo')
            if (intDivHeight != null)
                intDivHeight.style.height = window.innerHeight - intDivHeight.offsetTop - 23 + "px";


            if ("<%=strAuthenticationType%>" == "M" && "<%=m_blnIsWindowsAuthenticated%>" == "True") {
                if (document.getElementById("m_Logoutlink") != null)
                    document.getElementById("m_Logoutlink").style.display = "none";
                if (document.getElementById("m_changeUserlink") != null)
                    document.getElementById("m_changeUserlink").style.display = "block";

            }
            $(".flip").click(function () {
                DrawPieChartForLeaveAction();

                $(".panel").fadeToggle(1000);
            });
            $(".approvalflip").click(function () {
                ajaxcallfun();

                $(".approvalPanel").fadeToggle(1000);
            });
            /*********************    My Leave  ********************************************************/
            /***********************************************************************************/
            /* Added 8th Jan 206  swapnil aswale 
            /***********************************************************************************/
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/GetEmployeeImagePath',
                data: JSON.stringify({ intEmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    if (String(Result.d) != "") {
                        if (document.getElementById("imgEmployee") != null) {
                            document.getElementById("imgEmployee").src = Result.d;
                            document.getElementById("imgEmployeeHome").src = Result.d;
                        }
                    }
                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }
        function GraphClick() {
            $('#AllApprovalGraph').bind('jqplotDataClick',
                function (ev, seriesIndex, pointIndex, data) {

                    // $('#info1').html('series: ' + seriesIndex + ', point: ' + pointIndex + ', data: ' + data);
                    $("#tblleaveGraph1").css("display", "none");
                    $("#tblEntityGraph").css("display", "none");
                    $("#tblExpenseGraph").css("display", "none");
                    $("#tblTimesheetGraph").css("display", "none");
                    $("#tblHelpDesk").css("display", "none");
                    var mode = String(data);

                    mode = mode.split(",")
                    //if (mode[0] == 1) {

                    //    $("#tblleaveGraph1").css("display", "block");
                    //    .rdocument.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                    //    DrawPieChartForLeaveApprovalAction();
                    //}
                    //if (mode[0] == 2) {
                    //    $("#tblExpenseGraph").css("display", "block");
                    //    document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                    //    DrawPieChartForExpenseApprovalAction();
                    //}
                    //if (mode[0] == 3) {
                    //    $("#tblTimesheetGraph").css("display", "block");
                    //    document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                    //    DrawPieChartForTimesheetApprovalAction();
                    //}
                    //if (mode[0] == 4) {
                    //    $("#tblEntityGraph").css("display", "block");
                    //    document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                    //    DrawPieChartForEntityApprovalAction();
                    //}
                    //if (mode[0] == 5) {
                    //    $("#tblHelpDesk").css("display", "block");
                    //    document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                    //    DrawPieChartForHelpDeskApprovalAction();
                    //}
                    document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                    if (mode[0] == 1) {
                        // $("#tblleaveGraph").css("display", "block");
                        //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                        //DrawPieChartForLeaveApprovalAction();
                        if (arr[0] == 'Leave') {
                            $("#tblleaveGraph1").css("display", "block");
                            DrawPieChartForLeaveApprovalAction();
                        }
                        else if (arr[0] == 'Expense') {
                            $("#tblExpenseGraph").css("display", "block");
                            DrawPieChartForExpenseApprovalAction();
                        }
                        else if (arr[0] == 'Timesheet') {
                            $("#tblTimesheetGraph").css("display", "block");
                            DrawPieChartForTimesheetApprovalAction();
                        }
                        else if (arr[0] == 'Entity') {
                            $("#tblEntityGraph").css("display", "block");
                            DrawPieChartForEntityApprovalAction();
                            document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        }
                        else if (arr[0] == 'HelpDesk') {
                            $("#tblHelpDesk").css("display", "block");
                            DrawPieChartForHelpDeskApprovalAction();
                        }

                        //document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
                        //document.getElementById("P1").style.marginLeft = "32%"
                        // document.getElementById("GraphHeaderLeave").style.left = intPosition + "px";
                    }
                    if (mode[0] == 2) {
                        // $("#tblExpenseGraph").css("display", "block");
                        //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                        ////DrawPieChartForExpenseApprovalAction();
                        //DrawPieChartForExpenseApprovalAction();
                        //modeForAge = 2;
                        //// document.getElementById("GraphHeaderExpense").style.left = intPosition + "px";
                        ////document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
                        ////document.getElementById("P1").style.marginLeft = "32%"
                        //DrawApprovalAgeingGraph('Expense');
                        if (arr[1] == 'Leave') {
                            $("#tblleaveGraph1").css("display", "block");
                            DrawPieChartForLeaveApprovalAction();
                        }
                        else if (arr[1] == 'Expense') {
                            $("#tblExpenseGraph").css("display", "block");
                            DrawPieChartForExpenseApprovalAction();
                        }
                        else if (arr[1] == 'Timesheet') {
                            $("#tblTimesheetGraph").css("display", "block");
                            DrawPieChartForTimesheetApprovalAction();
                        }
                        else if (arr[1] == 'Entity') {
                            $("#tblEntityGraph").css("display", "block");
                            DrawPieChartForEntityApprovalAction();
                            document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        }
                        else if (arr[1] == 'HelpDesk') {
                            $("#tblHelpDesk").css("display", "block");
                            DrawPieChartForHelpDeskApprovalAction();
                        }
                    }
                    if (mode[0] == 3) {
                        // $("#tblTimesheetGraph").css("display", "block");
                        //document.getElementById("tblAllApprovalGraph").style.marginBottom = "0%"
                        //DrawPieChartForTimesheetApprovalAction();
                        //DrawPieChartForTimesheetApprovalAction();
                        //modeForAge = 3;
                        ////document.getElementById("GraphHeaderTimesheet").style.left = intPosition + "px";
                        ////document.getElementById("DivApprovalAgeing").style.marginLeft = "20%"
                        ////document.getElementById("P1").style.marginLeft = "22%"
                        //DrawApprovalAgeingGraph('Timesheet');
                        if (arr[2] == 'Leave') {
                            $("#tblleaveGraph1").css("display", "block");
                            DrawPieChartForLeaveApprovalAction();
                        }
                        else if (arr[2] == 'Expense') {
                            $("#tblExpenseGraph").css("display", "block");
                            DrawPieChartForExpenseApprovalAction();
                        }
                        else if (arr[2] == 'Timesheet') {
                            $("#tblTimesheetGraph").css("display", "block");
                            DrawPieChartForTimesheetApprovalAction();
                        }
                        else if (arr[2] == 'Entity') {
                            $("#tblEntityGraph").css("display", "block");
                            DrawPieChartForEntityApprovalAction();
                            document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        }
                        else if (arr[2] == 'HelpDesk') {
                            $("#tblHelpDesk").css("display", "block");
                            DrawPieChartForHelpDeskApprovalAction();
                        }

                    }
                    if (mode[0] == 4) {
                        //$("#tblEntityGraph").css("display", "block");
                        //document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        //DrawPieChartForEntityApprovalAction();
                        //DrawPieChartForEntityApprovalAction();
                        //// document.getElementById("GraphHeaderEntity").style.left = intPosition + "px";
                        ////document.getElementById("DivApprovalAgeing").style.marginLeft = "10px"
                        ////document.getElementById("P1").style.marginLeft = "26px"
                        //DrawApprovalAgeingGraph('Entity');
                        //modeForAge = 4;
                        if (arr[3] == 'Leave') {
                            $("#tblleaveGraph1").css("display", "block");
                            DrawPieChartForLeaveApprovalAction();
                        }
                        else if (arr[3] == 'Expense') {
                            $("#tblExpenseGraph").css("display", "block");
                            DrawPieChartForExpenseApprovalAction();
                        }
                        else if (arr[3] == 'Timesheet') {
                            $("#tblTimesheetGraph").css("display", "block");
                            DrawPieChartForTimesheetApprovalAction();
                        }
                        else if (arr[3] == 'Entity') {
                            $("#tblEntityGraph").css("display", "block");
                            DrawPieChartForEntityApprovalAction();
                            document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        }
                        else if (arr[3] == 'HelpDesk') {
                            $("#tblHelpDesk").css("display", "block");
                            DrawPieChartForHelpDeskApprovalAction();
                        }
                    }
                    if (mode[0] == 5) {
                        // $("#tblEntityGraph").css("display", "block");
                        //document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        //DrawPieChartForEntityApprovalAction();
                        //DrawPieChartForHelpDeskApprovalAction();
                        //modeForAge = 5
                        ////document.getElementById("GraphHeaderEntity").style.left = intPosition + "px";
                        ////document.getElementById("DivApprovalAgeing").style.marginLeft = "30%"
                        ////document.getElementById("P1").style.marginLeft = "32%"
                        //DrawApprovalAgeingGraph('HelpDesk');
                        if (arr[4] == 'Leave') {
                            $("#tblleaveGraph1").css("display", "block");
                            DrawPieChartForLeaveApprovalAction();
                        }
                        else if (arr[4] == 'Expense') {
                            $("#tblExpenseGraph").css("display", "block");
                            DrawPieChartForExpenseApprovalAction();
                        }
                        else if (arr[4] == 'Timesheet') {
                            $("#tblTimesheetGraph").css("display", "block");
                            DrawPieChartForTimesheetApprovalAction();
                        }
                        else if (arr[4] == 'Entity') {
                            $("#tblEntityGraph").css("display", "block");
                            DrawPieChartForEntityApprovalAction();
                            document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
                        }
                        else if (arr[4] == 'HelpDesk') {
                            $("#tblHelpDesk").css("display", "block");
                            DrawPieChartForHelpDeskApprovalAction();
                        }
                    }
                }
            );
        }
        var arr = [];
        function DrawRoleAccessAllApprovalGraph() {

            $.ajax({
                type: 'POST',
                url: '../PM/MyApproval_Home.aspx/DrawChartForOverallPendingRequest',
                dataType: 'json',
                data: JSON.stringify({ EmployeeID: '<%=Session("intUserID")%>' }),
                contentType: 'application/json;charset-utf=8',
                async: false,
                success: function (Result) {
                    try {


                        $.each(JSON.parse(Result.d), function (id, obj) {
                            objLeaveRoleAccess = obj.LeaveRoleAccess
                            objExpenseRoleAccess = obj.ExpenseRoleAccess
                            objTimesheetRoleAccess = obj.TimesheetRoleAccess
                            objEntityRoleAccess = obj.EntityRoleAccess
                            objHelpdeskRoleAccess = obj.HelpdeskRoleAccess
                            objResourceTimesheetAccess = obj.ResourceTimesheetAccess;
                            objProjectTimesheetAccess = obj.ProjectTimesheetAccess;
                            if (objLeaveRoleAccess == 1) {
                                arr.push(["Leave"]);

                            }
                            if (objExpenseRoleAccess == 1) {
                                arr.push(["Expense"]);

                            }
                            if (objTimesheetRoleAccess == 1) {
                                arr.push(["Timesheet"]);

                            }
                            if (objEntityRoleAccess == 1) {
                                arr.push(["Entity"]);

                            }
                            if (objHelpdeskRoleAccess == 1) {
                                arr.push(["HelpDesk"]);

                            }

                        });
                    } catch (e) {

                    }
                }
            });
        }
        function DrawPieChartForLeaveAction() {

            //var ProjectID = $("#ddlProjectChange").val();
            //GraphType = $("#ddlGraphTypeChange").val();
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawPieLeaveForMobile',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    //  alert(Result.d)
                    try {
                        var isRecord = 0;
                        $.each(JSON.parse(Result.d), function (id, obj) {
                            if (obj.LeavesEntitlementAndLeaveBalance == null) {
                                obj.LeavesEntitlementAndLeaveBalance = 0
                            }
                            if (obj.LeavesEntitlementAndLeaveBalance != 0) {
                                isRecord = 1;
                            }
                        });

                        if (isRecord == 1) {
                            DrawPieChartForLeave(Result.d);
                        }
                        else {

                            document.getElementById("leaveGraph").innerHTML = "No data to preview."
                            document.getElementById("leaveGraph").style.color = "#27408b"
                            document.getElementById("leaveGraph").style.height = "auto";
                            document.getElementById("leaveGraph").style.textAlign = "center"
                            document.getElementById("leaveGraph").style.width = "100%";
                        }
                        //alert(GraphType)
                        //if (GraphType == 1)
                        //    DreawPieChart(Result.d);
                        //else if (GraphType == 2)
                        //    DreawBarChart(Result.d);
                        //else
                        //    DreawDongutChart(Result.d);
                    } catch (e) {
                        if (arr.length > 0) {

                        }
                        else {
                            document.getElementById("leaveGraph").innerHTML = "You Do Not Have Access."
                            document.getElementById("leaveGraph").style.color = "#27408b"
                            document.getElementById("leaveGraph").style.height = "auto";
                            document.getElementById("leaveGraph").style.textAlign = "center"
                            document.getElementById("leaveGraph").style.width = "100%";
                        }
                    }
                },
                error: function (xhr) {

                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }
        function DrawPieChartForLeave(Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Entitlement";
            title[1] = "Balanced";


            $.each(JSON.parse(Result), function (id, obj) {

                dataSlices.push([title[id], obj.LeavesEntitlementAndLeaveBalance]);
                if (obj.LeavesEntitlementAndLeaveBalance == null) {
                    obj.LeavesEntitlementAndLeaveBalance = 0
                }
                if (id == 0) {
                    $("#entitlementId").text(title[id] + " : " + obj.LeavesEntitlementAndLeaveBalance)

                }
                else {
                    $("#BalanceId").text(title[id] + " : " + obj.LeavesEntitlementAndLeaveBalance)

                }
                //dataLabels = dataLabels + obj.TimePerc;                
            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: { padding: 8, showDataLabels: true }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#009900", "#ff0000"],
                highlightColors: ["white", "white"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',

                }
            }

            var plot = $.jqplot('leaveGraph', [dataSlices], options);


            dataSlices = [];
            dataLabels = "";



        };

        function DrawPieChartForAllApprovalAction() {
            $("#AllApprovalGraph").html('');
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawChartForAllApproval',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    try {
                        var jsonData = JSON.parse(Result.d);
                        $.each(jsonData, function (id, obj) {
                            DrawPieChartForAllApproval(Result.d);
                            if (obj.LeaveCount != 0 || obj.ExpenseCount != 0 || obj.TimeSheetCount != 0 || obj.EntityCount != 0 || obj.HelpDeskPending != 0) {

                                document.getElementById("AllApprovalGraph").style.visibility = "visible";
                                document.getElementById("divNoAllApprovalGraph").style.display = "none"
                            }
                            else {
                                if (document.getElementById("AllApprovalGraph") != null) {
                                    document.getElementById("AllApprovalGraph").style.visibility = "hidden";
                                    document.getElementById("divNoAllApprovalGraph").innerHTML = "No data to preview."
                                    document.getElementById("divNoAllApprovalGraph").style.color = "#27408b"
                                    document.getElementById("divNoAllApprovalGraph").style.height = "auto";
                                    document.getElementById("divNoAllApprovalGraph").style.textAlign = "center"
                                    document.getElementById("divNoAllApprovalGraph").style.width = "100%";
                                    document.getElementById("divNoAllApprovalGraph").style.display = "inline-block"
                                    document.getElementById("divNoAllApprovalGraph").style.position = "absolute";
                                    document.getElementById("divNoAllApprovalGraph").style.top = "210px";
                                    document.getElementById("divNoAllApprovalGraph").style.left = "-71px";
                                }
                            }
                        });
                    } catch (e) {
                        if (arr.length > 0) { }
                        else {
                            if (document.getElementById("AllApprovalGraph") != null) {
                                document.getElementById("AllApprovalGraph").style.visibility = "hidden";
                                document.getElementById("divNoAllApprovalGraph").innerHTML = "You Do Not Have Access"
                                document.getElementById("divNoAllApprovalGraph").style.color = "#27408b"
                                document.getElementById("divNoAllApprovalGraph").style.height = "auto";
                                document.getElementById("divNoAllApprovalGraph").style.textAlign = "center"
                                document.getElementById("divNoAllApprovalGraph").style.width = "100%";
                                document.getElementById("divNoAllApprovalGraph").style.display = "inline-block"
                                document.getElementById("divNoAllApprovalGraph").style.position = "absolute";
                                document.getElementById("divNoAllApprovalGraph").style.top = "210px";
                                document.getElementById("divNoAllApprovalGraph").style.left = "-71px";
                            }
                        }
                    }
                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }


        function DrawPieChartForAllApproval(Result) {
            var dataSlices = [];
            var s1 = [];
            var dataLabels = "";
            var title = [];
            title[0] = "Leave";
            title[1] = "Expense";
            title[2] = "Timesheet";
            title[3] = "Entity";
            var ticks = [];
            $.each(JSON.parse(Result), function (id, obj) {

                dataSlices.push([title[0], obj.LeaveCount], [title[1], obj.ExpenseCount], [title[2], obj.TimeSheetCount], [title[3], obj.EntityCount]);

                $("#LeaveCount").text(title[0] + " : " + obj.LeaveCount)
                $("#ExpenseCount").text(title[1] + " : " + obj.ExpenseCount)
                $("#TimeSheetCount").text(title[2] + " : " + obj.TimeSheetCount)
                $("#EntityCount").text(title[3] + " : " + obj.EntityCount)
                //$("#EntityCount").text(title[3] + " : " + obj.EntityCount)
                //s1.push(obj.LeaveCount, obj.ExpenseCount, obj.TimeSheetCount, obj.EntityCount, obj.HelpDeskPending)
                if (objLeaveRoleAccess == 1) {
                    s1.push(obj.LeaveCount)
                }
                if (objExpenseRoleAccess == 1) {
                    s1.push(obj.ExpenseCount)
                }
                if (objTimesheetRoleAccess == 1) {
                    s1.push(obj.TimeSheetCount)
                }
                if (objEntityRoleAccess == 1) {
                    s1.push(obj.EntityCount)
                }
                if (objHelpdeskRoleAccess == 1) {
                    s1.push(obj.HelpDeskPending)
                }

                //dataLabels = dataLabels + obj.TimePerc;                
            });
            $.jqplot.config.enablePlugins = true;

            //var s1 = [2, 6, 7];
            //var ticks = ['Leave', 'Expense', 'TimeSheet', 'Entity','HelpDesk'];
            if (objLeaveRoleAccess == 1) {
                ticks.push('Leave')
            }
            if (objExpenseRoleAccess == 1) {
                ticks.push('Expense')
            }
            if (objTimesheetRoleAccess == 1) {
                ticks.push('TimeSheet')
            }
            if (objEntityRoleAccess == 1) {
                ticks.push('Entity')
            }
            if (objHelpdeskRoleAccess == 1) {
                ticks.push('HelpDesk')
            }

            plot1 = $.jqplot('AllApprovalGraph', [s1], {
                // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
                animate: !$.jqplot.use_excanvas,

                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer,

                    pointLabels: { show: true },
                    rendererOptions: { barWidth: 15 }
                },

                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer,
                        ticks: ticks
                    }
                },

            });
        }

        /**********Leave Approval Graph**********/

        function DrawPieChartForLeaveApprovalAction() {

            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawChartForLeaveApproval',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    try {


                        var jsonData = JSON.parse(Result.d)
                        $.each(jsonData, function (id, obj) {
                            DrawPieChartForLeaveApproval(Result.d);
                            if (obj.LeaveCountSubmitted != 0 || obj.LeaveCountApproved != 0) {

                                document.getElementById("leaveGraph1").style.visibility = "visible";
                                document.getElementById("divNoLeaveGraph").style.display = "none"
                            }
                            else {
                                document.getElementById("leaveGraph1").style.visibility = "hidden";
                                document.getElementById("divNoLeaveGraph").innerHTML = "No data to preview."
                                document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                                document.getElementById("divNoLeaveGraph").style.height = "auto";
                                document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                                document.getElementById("divNoLeaveGraph").style.width = "100%";
                                document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                                document.getElementById("divNoLeaveGraph").style.position = "absolute";
                                document.getElementById("divNoLeaveGraph").style.top = "210px";
                                document.getElementById("divNoLeaveGraph").style.left = "103px";
                            }
                        });
                    } catch (e) {
                        if (arr.length > 0) { }
                        else {
                            document.getElementById("leaveGraph1").style.visibility = "hidden";
                            document.getElementById("divNoLeaveGraph").innerHTML = "You Do Not Have Access"
                            document.getElementById("divNoLeaveGraph").style.color = "#27408b"
                            document.getElementById("divNoLeaveGraph").style.height = "auto";
                            document.getElementById("divNoLeaveGraph").style.textAlign = "center"
                            document.getElementById("divNoLeaveGraph").style.width = "100%";
                            document.getElementById("divNoLeaveGraph").style.display = "inline-block"
                            document.getElementById("divNoLeaveGraph").style.position = "absolute";
                            document.getElementById("divNoLeaveGraph").style.top = "210px";
                            document.getElementById("divNoLeaveGraph").style.left = "103px";
                        }
                    }
                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }

        function DrawPieChartForLeaveApproval(Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Pending";
            title[1] = "Approved";


            $.each(JSON.parse(Result), function (id, obj) {
                dataSlices.push([title[0], obj.LeaveCountSubmitted], [title[1], obj.LeaveCountApproved]);

                //$("#LeaveCount").text(title[0] + " : " + obj.LeaveCount)       
                //$("#ExpenseCount").text(title[1] + " : " + obj.ExpenseCount)
                //$("#TimeSheetCount").text(title[2] + " : " + obj.TimeSheetCount)
                //$("#EntityCount").text(title[3] + " : " + obj.EntityCount)
                //dataLabels = dataLabels + obj.TimePerc;                
            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: {
                        padding: 8, showDataLabels: true,
                        dataLabels: 'value',
                        dataLabelFormatString: '%.0f'
                    }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#ff0000", "#009900"],
                highlightColors: ["white", "white"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',
                }
            }
            var plot = $.jqplot('leaveGraph1', [dataSlices], options);

            dataSlices = [];
            dataLabels = "";
        };

        /**********Entity Approval Graph**********/

        function DrawPieChartForEntityApprovalAction() {

            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawChartForEntityApproval',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    try {

                        var jsonData = JSON.parse(Result.d)
                        DrawPieChartForEntityApproval(Result.d);
                        if (obj.ProjectCount != 0 || obj.SubProjectCount != 0 || obj.MileStoneCount != 0 || obj.ModuleCount != 0 || obj.DeliverableCount != 0 || obj.ChangeRequestCount != 0) {

                            document.getElementById("EntityGraph").style.visibility = "visible";
                            document.getElementById("divNoEntityGraph").style.display = "none"
                        }
                        else {
                            document.getElementById("EntityGraph").style.visibility = "hidden";
                            document.getElementById("divNoEntityGraph").innerHTML = "No data to preview."
                            document.getElementById("divNoEntityGraph").style.color = "#27408b"
                            document.getElementById("divNoEntityGraph").style.height = "auto";
                            document.getElementById("divNoEntityGraph").style.textAlign = "center"
                            document.getElementById("divNoEntityGraph").style.width = "100%";
                            document.getElementById("divNoEntityGraph").style.display = "inline-block"
                            document.getElementById("divNoEntityGraph").style.position = "absolute";
                            document.getElementById("divNoEntityGraph").style.top = "210px";
                            document.getElementById("divNoEntityGraph").style.left = "103px";
                        }
                    }
                    catch (e) {
                        if (arr.length > 0) { }
                        else {
                            document.getElementById("EntityGraph").style.visibility = "hidden";
                            document.getElementById("divNoEntityGraph").innerHTML = "You Do Not Have Access"
                            document.getElementById("divNoEntityGraph").style.color = "#27408b"
                            document.getElementById("divNoEntityGraph").style.height = "auto";
                            document.getElementById("divNoEntityGraph").style.textAlign = "center"
                            document.getElementById("divNoEntityGraph").style.width = "100%";
                            document.getElementById("divNoEntityGraph").style.display = "inline-block"
                            document.getElementById("divNoEntityGraph").style.position = "absolute";
                            document.getElementById("divNoEntityGraph").style.top = "210px";
                            document.getElementById("divNoEntityGraph").style.left = "103px";
                        }
                    }
                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }

        function DrawPieChartForEntityApproval(Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Project";
            title[1] = "SubProject";
            title[2] = "Milestone";
            title[3] = "Module";
            title[4] = "Deliverable";
            title[5] = "Change Request";


            $.each(JSON.parse(Result), function (id, obj) {

                dataSlices.push([title[0], obj.ProjectCount], [title[1], obj.SubProjectCount], [title[2], obj.MileStoneCount], [title[3], obj.ModuleCount], [title[4], obj.DeliverableCount], [title[5], obj.ChangeRequestCount]);

            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: {
                        padding: 8, showDataLabels: true,
                        dataLabels: 'value',
                        dataLabelFormatString: '%.0f'
                    }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#009900", "#ff0000", "#ffff99", "#3384ff", "#ffad33", "#661aff"],
                highlightColors: ["white", "white"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',
                }
            }
            var plot = $.jqplot('EntityGraph', [dataSlices], options);

            dataSlices = [];
            dataLabels = "";
        };


        /**********Expense Approval Graph**********/

        function DrawPieChartForExpenseApprovalAction() {

            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawChartForExpenseApproval',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {

                    try {
                        var jsonData = JSON.parse(Result.d)
                        $.each(jsonData, function (id, obj) {
                            DrawPieChartForExpenseApproval(Result.d);

                            if (obj.ExpensePending != 0 || obj.ExpenseApproved != 0) {

                                document.getElementById("ExpenseGraph").style.visibility = "visible";
                                document.getElementById("divNoExpense").style.display = "none"
                            }
                            else {
                                document.getElementById("ExpenseGraph").style.visibility = "hidden";
                                document.getElementById("divNoExpense").innerHTML = "No data to preview."
                                document.getElementById("divNoExpense").style.color = "#27408b"
                                document.getElementById("divNoExpense").style.height = "auto";
                                document.getElementById("divNoExpense").style.textAlign = "center"
                                document.getElementById("divNoExpense").style.width = "100%";
                                document.getElementById("divNoExpense").style.display = "inline-block"
                                document.getElementById("divNoExpense").style.position = "absolute";
                                document.getElementById("divNoExpense").style.top = "210px";
                                document.getElementById("divNoExpense").style.left = "103px";
                            }
                        })
                    } catch (e) {
                        if (arr.length > 0) {

                        }
                        else {

                            document.getElementById("ExpenseGraph").style.visibility = "hidden";
                            document.getElementById("divNoExpense").innerHTML = "You Do Not Have Access"
                            document.getElementById("divNoExpense").style.color = "#27408b"
                            document.getElementById("divNoExpense").style.height = "auto";
                            document.getElementById("divNoExpense").style.textAlign = "center"
                            document.getElementById("divNoExpense").style.width = "100%";
                            document.getElementById("divNoExpense").style.display = "inline-block"
                            document.getElementById("divNoExpense").style.position = "absolute";
                            document.getElementById("divNoExpense").style.top = "210px";
                            document.getElementById("divNoExpense").style.left = "103px";
                        }
                    }


                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }

        function DrawPieChartForExpenseApproval(Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Approved";
            title[1] = "Pending";


            $.each(JSON.parse(Result), function (id, obj) {

                dataSlices.push([title[1], obj.ExpensePending], [title[0], obj.ExpenseApproved]);

            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: {
                        padding: 8, showDataLabels: true,
                        dataLabels: 'value',
                        dataLabelFormatString: '%.0f'
                    }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#ff0000", "#009900"],
                highlightColors: ["white", "white"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',
                }
            }
            var plot = $.jqplot('ExpenseGraph', [dataSlices], options);

            dataSlices = [];
            dataLabels = "";
        };


        /**********Timesheet Approval Graph**********/

        function DrawPieChartForTimesheetApprovalAction() {

            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawChartForTimesheetApproval',
                data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    try {
                        var jsonData = JSON.parse(Result.d)
                        $.each(jsonData, function (id, obj) {
                            DrawPieChartForTimesheetApproval(Result.d);
                            if (obj.ResourceTimeSheetCount == null || objResourceTimesheetAccess != 1) {
                                obj.ResourceTimeSheetCount = 0;
                            }
                            if (obj.ProjectTimeSheetCount == null || objProjectTimesheetAccess != 1) {
                                obj.ProjectTimeSheetCount = 0;
                            }
                            if (obj.ResourceTimeSheetCount != 0 || obj.ProjectTimeSheetCount != 0) {

                                document.getElementById("TimesheetGraph").style.visibility = "visible";
                                document.getElementById("divNoTimesheet").style.display = "none"
                            }
                            else {
                                document.getElementById("TimesheetGraph").style.visibility = "hidden";
                                document.getElementById("divNoTimesheet").innerHTML = "No data to preview."
                                document.getElementById("divNoTimesheet").style.color = "#27408b"
                                document.getElementById("divNoTimesheet").style.height = "auto";
                                document.getElementById("divNoTimesheet").style.textAlign = "center"
                                document.getElementById("divNoTimesheet").style.width = "100%";
                                document.getElementById("divNoTimesheet").style.display = "inline-block"
                                document.getElementById("divNoTimesheet").style.position = "absolute";
                                document.getElementById("divNoTimesheet").style.top = "210px";
                                document.getElementById("divNoTimesheet").style.left = "103px";
                            }
                        })
                    } catch (e) {
                        if (arr.length > 0) {

                        }
                        else {
                            document.getElementById("TimesheetGraph").style.visibility = "hidden";
                            document.getElementById("divNoTimesheet").innerHTML = "You Do Not Have Access"
                            document.getElementById("divNoTimesheet").style.color = "#27408b"
                            document.getElementById("divNoTimesheet").style.height = "auto";
                            document.getElementById("divNoTimesheet").style.textAlign = "center"
                            document.getElementById("divNoTimesheet").style.width = "100%";
                            document.getElementById("divNoTimesheet").style.display = "inline-block"
                            document.getElementById("divNoTimesheet").style.position = "absolute";
                            document.getElementById("divNoTimesheet").style.top = "210px";
                            document.getElementById("divNoTimesheet").style.left = "103px";
                        }
                    }

                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });
        }

        function DrawPieChartForTimesheetApproval(Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Resource TimeSheet";
            title[1] = "Project TimeSheet";


            $.each(JSON.parse(Result), function (id, obj) {

                if (obj.ResourceTimeSheetCount == null) {
                    obj.ResourceTimeSheetCount = 0;
                }
                if (obj.ProjectTimeSheetCount == null) {
                    obj.ProjectTimeSheetCount = 0;
                }

                if (objResourceTimesheetAccess == 1)
                    dataSlices.push([title[0], obj.ResourceTimeSheetCount]);
                if (objProjectTimesheetAccess == 1)
                    dataSlices.push([title[1], obj.ProjectTimeSheetCount]);

            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: {
                        padding: 8, showDataLabels: true,
                        dataLabels: 'value',
                        dataLabelFormatString: '%.0f'
                    }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#009900", "#ff0000"],
                highlightColors: ["white", "white"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',
                }
            }
            var plot = $.jqplot('TimesheetGraph', [dataSlices], options);

            dataSlices = [];
            dataLabels = "";
        };

        function DrawPieChartForHelpDeskApprovalAction() {

            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/GetHeplDeskApprovalDataCount',
                data: JSON.stringify({ intUserID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    try {
                        var jsonData = JSON.parse(Result.d)
                        $.each(jsonData, function (id, obj) {
                            //document.getElementById("leaveGraph").style.width = "297px"
                            DrawPieChartForHelpDeskApproval(Result.d);
                            if (obj.HelpDeskPending != 0 || obj.HelpDeskApproved != 0) {

                                document.getElementById("divHelpDesk").style.visibility = "visible";
                                document.getElementById("divNoHelpDesk").style.display = "none"

                            }
                            else {
                                document.getElementById("divHelpDesk").style.visibility = "hidden";
                                document.getElementById("divNoHelpDesk").innerHTML = "No data to preview."
                                document.getElementById("divNoHelpDesk").style.color = "#27408b"
                                document.getElementById("divNoHelpDesk").style.height = "auto";
                                document.getElementById("divNoHelpDesk").style.textAlign = "center"
                                document.getElementById("divNoHelpDesk").style.width = "100%";
                                document.getElementById("divNoHelpDesk").style.display = "inline-block"
                                document.getElementById("divNoHelpDesk").style.position = "relative";
                                document.getElementById("divNoHelpDesk").style.top = "150px";
                            }
                        });


                    } catch (e) {
                        if (arr.length > 0) { }
                        else {
                            document.getElementById("divHelpDesk").style.visibility = "hidden";
                            document.getElementById("divNoHelpDesk").innerHTML = "You Do Not Have Access"
                            document.getElementById("divNoHelpDesk").style.color = "#27408b"
                            document.getElementById("divNoHelpDesk").style.height = "auto";
                            document.getElementById("divNoHelpDesk").style.textAlign = "center"
                            document.getElementById("divNoHelpDesk").style.width = "100%";
                            document.getElementById("divNoHelpDesk").style.display = "inline-block"
                            document.getElementById("divNoHelpDesk").style.position = "relative";
                            document.getElementById("divNoHelpDesk").style.top = "150px";
                        }
                    }
                    var display = $("#GraphHeaderLeave");
                    display.text("Helpdesk");
                },
                error: function () {
                    //  alert("Error")
                }
            });
        }

        function DrawPieChartForHelpDeskApproval(Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Approved";
            title[1] = "Pending";


            $.each(JSON.parse(Result), function (id, obj) {
                if (obj.HelpDeskApproved == null) {
                    obj.HelpDeskApproved = 0;
                }
                if (obj.HelpDeskPending == null) {
                    obj.HelpDeskPending = 0;
                }
                dataSlices.push([title[0], obj.HelpDeskApproved], [title[1], obj.HelpDeskPending]);

            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: {
                        padding: 0, showDataLabels: true,
                        dataLabels: 'value',
                        dataLabelFormatString: '%.0f',
                        dataLabelThreshold: 1
                    }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#009900", "#ff0000"],
                highlightColors: ["white", "white"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',
                }
            }
            document.getElementById("divHelpDesk").innerHTML = "";
            //var plot = $.jqplot('TimesheetGraph', [dataSlices], options);
            var plot = $.jqplot('divHelpDesk', [dataSlices], options);

            //dataSlices = [];
            //dataLabels = "";

            ////$("#TimesheetGraph .jqplot-table-legend").css("right", "9px");
            ////$("#TimesheetGraph canvas").each(function (id, val) {
            ////    if (id == 2) {
            ////        $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            ////        $(this).css("background-size", "421px,342px");
            ////        $(this).css("background-repeat", " no-repeat");
            ////    }
            ////});
            //$("#leaveGraph .jqplot-table-legend").css("right", "9px");
            //$("#leaveGraph canvas").each(function (id, val) {
            //    if (id == 2) {
            //        //if ($("#leaveGraph").height() == 300) {
            //        //    //$(this).height(286);
            //        //    this.height = "268";
            //        //}
            //        //else if ($("#leaveGraph").height() == 210) {
            //        //    //$(this).height(200);
            //        //    this.height = "187";
            //        //}
            //        //else if ($("#leaveGraph").height() == 190)
            //        //{
            //        //    this.height = "168";
            //        //    //$(this).height(179);
            //        //}
            //        $(this).height("86%");
            //        $(this).width("100%");
            //        $(this).css("background-image", "url(../../img/1920/GraphLine.png)");
            //        $(this).css("background-size", "100%,100%");
            //        $(this).css("background-repeat", " no-repeat");
            //    }
            //});
        };
        /*********************    My Approval[ Project  ] ********************************************************/
        /***********************************************************************************/
        /* Added 8th Jan 206  swapnil aswale 
        /***********************************************************************************/
        var PDiv = ["approvalGraph", "approvalGraphMilestone", "approvalGraphModule", "approvalGraphSub", "approvalGraphDeliverable", "approvalGraphChangeRequest"];
        var Ptype = ["Project", "Milestone", "Module", "Sub Project", "Deliverable", "Change Request"];
        var pApproved = ["ProjectApprovedId", "MilestoneApprovedId", "ModuleApprovedId", "SubProjectApprovedId", "DeliverableApprovedId", "ChangeApprovedId"];
        var pBalanced = ["ProjectPendingID", "MilestonePendingId", "ModulePendingId", "SubProjectPendingId", "DeliverablePendingId", "ChangePendingId"];
        var pHeading = ["lblProjectHeading", "lblMilestoneHeading", "lblModuleHeading", "lblSubHeading", "lblDelHeading", "lvlChangeHeading"];
        function ajaxcallfun() {


            for (var i = 0; i < Ptype.length; i++) {

                DrawPieChartForMyApprovalAction(i)
            }
        }

        function DrawPieChartForMyApprovalAction(num) {
            //var ProjectID = $("#ddlProjectChange").val();
            //GraphType = $("#ddlGraphTypeChange").val();

            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'Navigation.aspx/DrawPieChartForMyApprovalMobile',
                data: JSON.stringify({ Entity: Ptype[num], EmployeeID: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    var jsonData = JSON.parse(Result.d);
                    //alert(jsonData);
                    $.each(jsonData, function (id, obj) {
                        document.getElementById(pHeading[num]).innerHTML = Ptype[num] + " : ";
                        document.getElementById(pHeading[num]).className = "clsLabel";
                        if (obj.Approved != 0 || obj.Balanced != 0) {

                            DrawPieChartForMyApproval(num, Result.d);
                        }
                        else {
                            document.getElementById(PDiv[num]).innerHTML = "No data to preview."
                            document.getElementById(PDiv[num]).style.color = "#27408b"
                            document.getElementById(PDiv[num]).style.height = "auto";
                            document.getElementById(PDiv[num]).style.textAlign = "center"
                            document.getElementById(PDiv[num]).style.width = "100%";
                        }
                    });
                    //alert(GraphType)
                    //if (GraphType == 1)
                    //    DreawPieChart(Result.d);
                    //else if (GraphType == 2)
                    //    DreawBarChart(Result.d);
                    //else
                    //    DreawDongutChart(Result.d);
                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                }
            });



        }
        function DrawPieChartForMyApproval(inta, Result) {
            var dataSlices = [];

            var dataLabels = "";
            var title = [];
            title[0] = "Approved";
            title[1] = "Pending";


            $.each(JSON.parse(Result), function (id, obj) {



                $("#" + pApproved[inta]).text(title[0] + " : " + obj.Approved)

                $("#" + pBalanced[inta]).text(title[1] + " : " + obj.Balanced)

                dataSlices.push([title[0], obj.Approved]);
                dataSlices.push([title[1], obj.Balanced]);

                //dataLabels = dataLabels + obj.TimePerc;                
            });

            options = {
                gridPadding: { top: 0, bottom: 58, left: 0, right: 20 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,
                    trendline: { show: false },
                    rendererOptions: { padding: 8, showDataLabels: true }
                },
                grid: {
                    drawBorder: false,
                    drawGridlines: false,
                    background: '#ffffff',
                    shadow: false
                },
                seriesColors: ["#009900", "#ff0000"],
                legend: {
                    show: true,
                    //placement: 'outside',
                    rendereroptions: {
                        numberrows: 1
                    },
                    location: 's',

                }
            }

            var plot = $.jqplot(PDiv[inta], [dataSlices], options);


            dataSlices = [];
            dataLabels = "";



        };


        var hideWidth = '-200px'; //width that will be hidden

        var collapsibleEl = $('.collapsible'); //collapsible element
        var buttonEl = $(".collapsible button"); //button inside element

        collapsibleEl.css({ 'margin-left': hideWidth }); //on page load we'll move and hide part of elements

        $(buttonEl).click(function () {
            var curwidth = $(this).parent().offset(); //get offset value of the element
            if (curwidth.left > 0) //compare margin-left value
            {
                //animate margin-left value to -490px
                $(this).parent().animate({ marginLeft: hideWidth }, 300);
                $(this).html('&raquo;'); //change text of button
            } else {
                //animate margin-left value 0px
                $(this).parent().animate({ marginLeft: "0" }, 300);
                $(this).html('&laquo;'); //change text of button
            }
        });
        //   Browser Dependent Date Control Dinamic html5 Controll Attached
        Modernizr.load({
            test: Modernizr.inputtypes.date,
            nope: "../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js",
            callback: function () {
                $("input[type=date]").datepicker();
            }
        });
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-check device is tablet or not
        // Description:if device is not tablet then set width on document ready
        // By Whom: Miiint
        // When: 13/02/2015
        /*---------------------------------------------------------*/

        if (!(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))) {

            if ($(window).width() < 992) {
                //Commented and Added by Dhanashri S on 13 Mar 2015
                //$('#Sub').css('width', '80%');
                $('#Sub').css('width', '100%');
                //End of Addition
            }

        }


        var linkFrame = $('.iframeLinks').outerHeight();
        var iframeHeight = $(window).height() - linkFrame;
        var iframeWin = parent.document.getElementById("Sub");
        var divHeight = $('#divHeader').height();
        if (iframeWin != null)
            iframeWin.height = (iframeHeight - divHeight) + 'px';

        if ($(window).width() < 991) {
            $('.iframeLinks').addClass('ipadLinksFrame');

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Calculate Height for iframes
        /*---------------------------------------------------------*/
        //DrawRoleAccessAllApprovalGraph();
        //DrawPieChartForAllApprovalAction();
        //DrawPieChartForLeaveApprovalAction();
        $("#tblleaveGraph1").css("display", "none");
        $("#tblEntityGraph").css("display", "none");
        $("#tblExpenseGraph").css("display", "none");
        $("#tblTimesheetGraph").css("display", "none");
        $("#tblHelpDesk").css("display", "none");
        if (arr[0] == 'Leave') {
            $("#tblleaveGraph1").css("display", "block");
            DrawPieChartForLeaveApprovalAction();
        }
        else if (arr[0] == 'Expense') {
            $("#tblExpenseGraph").css("display", "block");
            DrawPieChartForExpenseApprovalAction();
        }
        else if (arr[0] == 'Timesheet') {
            $("#tblTimesheetGraph").css("display", "block");
            DrawPieChartForTimesheetApprovalAction();
        }
        else if (arr[0] == 'Entity') {
            $("#tblEntityGraph").css("display", "block");
            DrawPieChartForEntityApprovalAction();
            document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%"
        }
        else if (arr[0] == 'HelpDesk') {
            $("#tblHelpDesk").css("display", "block");
            DrawPieChartForHelpDeskApprovalAction();
        }

        GraphClick()


        window.onresize = function () {

            if ($(window).width() < 720) {

                //DrawPieChartForAllApprovalAction();
                //DrawPieChartForLeaveApprovalAction();
                $("#tblleaveGraph1").css("display", "none");
                $("#tblEntityGraph").css("display", "none");
                $("#tblExpenseGraph").css("display", "none");
                $("#tblTimesheetGraph").css("display", "none");
                $("#tblHelpDesk").css("display", "none");
                if (arr[0] == 'Leave') {

                    $("#tblleaveGraph1").css("display", "block");
                    DrawPieChartForLeaveApprovalAction();
                }
                else if (arr[0] == 'Expense') {

                    $("#tblExpenseGraph").css("display", "block");
                    DrawPieChartForExpenseApprovalAction();
                }
                else if (arr[0] == 'Timesheet') {

                    $("#tblTimesheetGraph").css("display", "block");
                    DrawPieChartForTimesheetApprovalAction();
                }
                else if (arr[0] == 'Entity') {

                    $("#tblEntityGraph").css("display", "block");
                    DrawPieChartForEntityApprovalAction();

                    document.getElementById("tblAllApprovalGraph").style.marginBottom = "31%";
                }
                else if (arr[0] == 'HelpDesk') {

                    $("#tblHelpDesk").css("display", "block");
                    DrawPieChartForHelpDeskApprovalAction();
                }

            }
            if ($(window).width() < 768) {
                document.body.style.setProperty("background-color", "white", "important");
            }
            else {
                document.body.style.setProperty("background-color", "");
            }
        }
    });
    window.onload = function () {
        RemoveFrameLoader();
        if (document.getElementById("frmNewResponsiveVersion") != null) {
            document.getElementById("frmNewResponsiveVersion").style.width = window.innerWidth + 'px';
            document.getElementById("frmNewResponsiveVersion").style.height = window.innerHeight - 50 + 'px';
        }
        if (document.getElementById("frmNewVersion"))
            document.getElementById("frmNewVersion").style.height = window.innerHeight - 60 + 'px';

        if (document.getElementById("treeMenu"))
            document.getElementById("treeMenu").style.height = window.innerHeight - 40 + 'px';
    };
    $(window).resize(function () {

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-check device is tablet or not
        // Description:if device is not tablet then set width on Window Resize
        // By Whom: Miiint
        // When: 13/02/2015
        /*---------------------------------------------------------*/

        if (!(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))) {
            if ($(window).width() < 992) {
                //Commented and Added by Dhanashri S on 13 Mar 2015
                //$('#Sub').css('width', '80%');
                $('#Sub').css('width', '100%');
                //End of Addition
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-check device is tablet or not
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Calculate Height for iframes
        // Description:Giving height to each iframe with respect to window height on Window Resize
        // By Whom: Miiint
        // When:
        /*---------------------------------------------------------*/

        //var linkFrame=$('.iframeLinks').outerHeight();
        //var iframeHeight=$(window).height()-linkFrame;
        //var iframeWin = parent.document.getElementById("Sub");
        //iframeWin.height = iframeHeight ;

        var linkFrame = $('.iframeLinks').outerHeight();
        var iframeHeight = $(window).height() - linkFrame;
        var iframeWin = parent.document.getElementById("Sub");
        if (iframeWin != null)
            iframeWin.height = iframeHeight;


        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Calculate Height for iframes
        /*---------------------------------------------------------*/
        if ($(window).width() < 720)
            document.body.style.height = window.innerHeight - 11 + 'px';

        if (document.getElementById("frmNewResponsiveVersion") != null) {
            document.getElementById("frmNewResponsiveVersion").style.width = window.innerWidth + 'px';
            document.getElementById("frmNewResponsiveVersion").style.height = window.innerHeight - 50 + 'px';
        }
        $("#menu").css("height", window.innerHeight - 11 + 'px');
        if (document.getElementById("exampleAccordion") != null) {
            document.getElementById("exampleAccordion").style.height = window.innerHeight - 60 + 'px';
            document.getElementById("frmNewVersion").style.height = window.innerHeight - 60 + 'px';
            document.getElementById("frmNewVersion").style.width = window.innerWidth - 90 + 'px';
        }
    });


    //Added By Vaijat K ON 14/12/2017 For Alerts Flags Discussion And Theme
    $(".nav-item").click(function () {

        var myTypeId = $(this).attr('id');
        if (myTypeId == "msgLink" || myTypeId == "notifyLink" || myTypeId == "flagLink") {
            intFlag = 0
            var myTypeVal = $(this).attr('value');
            var empid = "<%=Session("intUserID")%>";
            $("#myModal2 #TypeId").val(myTypeId);


            var jsonstring = { type: myTypeVal, EmployeeId: empid, ViewFlag: 0, RecordFlag: intFlag };
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                async: false,
                url: 'Navigation.aspx/Get_AlertType',
                data: JSON.stringify(jsonstring),
                success: function (Result) {
                    var strData = Result.d.split("$$$");
                    //var strModalData = Result.d;
                    var strModalData = strData[0];
                    var cntUnseenAlert = strModalData.substring(strModalData.lastIndexOf(">") + 1);
                    strModalData = strModalData.substring(0, strModalData.lastIndexOf(">") + 1);
                    var strShowLoadLink = strData[1]
                    if (strShowLoadLink == "1") {
                        $("#lnkLoadalreadyViewed").css("display", "block")
                    }
                    else {
                        $("#lnkLoadalreadyViewed").css("display", "none")
                    }


                    $("#myModal2 .modal-body").html(strModalData);
                    $("[data-bs-toggle='tooltip']").tooltip();

                    $("#myModal2 #myModalLabel").text(" " + myTypeVal + " (" + cntUnseenAlert + ")")
                    if (myTypeId == "msgLink") {
                        $("#myHeaderIcon").attr('class', 'fa fa-comments');
                    }
                    if (myTypeId == "notifyLink") {
                        $("#myHeaderIcon").attr('class', 'fa fa-flag');
                    }
                    if (myTypeId == "flagLink") {
                        $("#myHeaderIcon").attr('class', 'fa fa-bell');
                    }
                    $("#myModal2").modal("show");
                    //Added by Yogesh Jalamkar to hide scroll                          
                    var hasVerticalScrollbar = $("#modalboady > #EmployeeList").height() > $("#modalboady").height();
                    if (hasVerticalScrollbar) {
                        $("#modalboady").css("padding-right", "3%")
                    }
                    else {
                        $("#modalboady").css("padding-right", "6%")
                    }
                    //Added by Usha Pandit On 11.12.2020 To hide More Details in Notification section
                    $(".comment-content").find("label").css("cssText", "display: none !important;");
                    //End Of Added by Usha Pandit On 11.12.2020 To hide More Details in Notification section
                    //End of addition by Yogesh Jalamkar
                },
                error: function (response) {
                    console.log(response.responseText);
                }
            });


        }
    });
    $("#lnkLoadalreadyViewed").click(function () {

        var myTypeVal = $("#myModal2 #myModalLabel").text();
        intFlag = intFlag + 1;
        myTypeVal = myTypeVal.trim();
        myTypeVal = myTypeVal.substring(0, myTypeVal.indexOf(" "));
        var empid = "<%=Session("intUserID")%>";
        var jsonstring = { type: myTypeVal, EmployeeId: empid, ViewFlag: 0, RecordFlag: intFlag };



        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/Get_AlertType',
            data: JSON.stringify(jsonstring),
            async: false,
            success: function (Result) {

                var strData = Result.d.split("$$$");
                //var strModalData = Result.d;
                var strModalData = strData[0];
                var strShowLoadLink = strData[1]

                var cntUnseenAlert = strModalData.substring(strModalData.lastIndexOf(">") + 1);
                strModalData = strModalData.substring(0, strModalData.lastIndexOf(">") + 1);

                $("#myModal2 .modal-body").html(strModalData);
                if (strShowLoadLink == "1") {
                    $("#lnkLoadalreadyViewed").css("display", "block")
                }
                else {
                    $("#lnkLoadalreadyViewed").css("display", "none")
                }
                $("#myModal2").modal("show");
                //Added by Yogesh Jalamkar to hide scroll                  
                var hasVerticalScrollbar = $("#modalboady > #EmployeeList").height() > $("#modalboady").height();
                if (hasVerticalScrollbar) {
                    $("#modalboady").css("padding-right", "3%")
                }
                else {
                    $("#modalboady").css("padding-right", "6%")
                }
                //End of addition by Yogesh Jalamkar

            },
            error: function (response) {
                console.log(response.responseText);
            }
        });



    });

    function getLoginEmployeePhoto() {

        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/GetEmployeeImagePathAndUserName',
            data: JSON.stringify({ intEmployeeID: "<%=Session("intUserID")%>", strLoginType: "<%=HttpContext.Current.Session("LoginType")%>" }),
            success: function (Result) {

                if (String(Result.d) != "") {

                    var arrEmployeeDetails = String(Result.d).split("|")
                    if (arrEmployeeDetails[0] == "NoImage") {
                        $('.user-image').attr("src", "../../Images/Photo/no-photo.png")
                        $('#userImageHeader').attr("src", "../../Images/Photo/no-photo.png")
                    }
                    else {
                        $('.user-image').attr("src", arrEmployeeDetails[0])
                        $('#userImageHeader').attr("src", arrEmployeeDetails[0])
                    }

                    $('#spanUserName').html(arrEmployeeDetails[2])

                    /*Added by Usha Pandit on 31 JAN 2018 for UI issue in sign out page my profile*/
                    if (arrEmployeeDetails[1] != "" && arrEmployeeDetails[2] != "") {
                        var totalLength = arrEmployeeDetails[1].length + arrEmployeeDetails[2].length;
                        if (totalLength > 50) {
                            $(".user-header").css({ 'height': '200px' });
                        }
                    }
                    /*End of Added by Usha Pandit on 31 JAN 2018 for UI issue in sign out page my profile*/

                    $('#employeeRole').append(arrEmployeeDetails[2] + "&nbsp;-&nbsp;" + arrEmployeeDetails[1] + "");

                }
            },
            error: function (xhr) {
                console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

            }
        });
    }

    //Added By Madhuri.K On 21-01-2026 - Track current breadcrumb context (so we can rebuild links even if other code overwrites header)
    //Structure: { moduleTagID: <number|string>, pageTagID: <number|string>, text: <string> }
    var currentBreadcrumbContext = { moduleTagID: null, pageTagID: null, text: "" };
    
    function updateBreadcrumbContext(moduleTagID, pageTagID, text) {
        try {
            currentBreadcrumbContext.moduleTagID = moduleTagID;
            currentBreadcrumbContext.pageTagID = pageTagID;
            currentBreadcrumbContext.text = text || "";
        } catch (e) { }
    }
    
    //Added By Madhuri.K On 21-01-2026 - Observe breadcrumb text changes and re-apply clickable links if any code overwrites it
    function initBreadcrumbObserver() {
        try {
            var mainHeadingEl = document.getElementById("mainHeadingTop");
            if (!mainHeadingEl) return;
            if (mainHeadingEl.__breadcrumbObserverAttached) return;
            mainHeadingEl.__breadcrumbObserverAttached = true;
            
            // Initial attempt
            setTimeout(function () { ensureBreadcrumbLinksAreClickable(); }, 2);
            
            var observer = new MutationObserver(function () {
                // Debounce slightly to let the last write win
                setTimeout(function () { ensureBreadcrumbLinksAreClickable(); }, 2);
            });
            
            observer.observe(mainHeadingEl, { childList: true, subtree: true, characterData: true });
        } catch (ex) {
            // ignore
        }
    }
    
    //Added By Madhuri.K On 21-01-2026 - Function to convert existing header text to clickable links if it looks like breadcrumb
    function ensureBreadcrumbLinksAreClickable() {
        try {
            var mainHeadingEl = document.getElementById("mainHeadingTop");
            if (!mainHeadingEl) {
                return;
            }
            
            // Prefer innerText so we don't get confused by existing HTML
            var visibleText = (mainHeadingEl.innerText || "").trim();
            if (!visibleText) return;
            
            // If already contains anchor tags, nothing to do
            if ((mainHeadingEl.innerHTML || "").indexOf("<a ") > -1) return;
            
            // Normalize breadcrumb separator (handle "A>B", "A >B", "A> B", etc.)
            var normalizedText = visibleText.replace(/\s*>\s*/g, " > ");
            
            // If we have current context (set by ChangeTabs), use it (most reliable)
            if (currentBreadcrumbContext && currentBreadcrumbContext.moduleTagID && currentBreadcrumbContext.pageTagID) {
                var moduleIdNum = parseInt(currentBreadcrumbContext.moduleTagID, 10);
                var pageIdNum = parseInt(currentBreadcrumbContext.pageTagID, 10);
                if (!isNaN(moduleIdNum) && !isNaN(pageIdNum)) {
                    setClickableBreadcrumb(normalizedText, pageIdNum, moduleIdNum);
                    return;
                }
            }
            
            // Fallback: attempt to infer TagIDs from text
            if (normalizedText.indexOf(" > ") > -1) {
                var parts = normalizedText.split(" > ");
                if (parts.length >= 2) {
                    var moduleName = (parts[0] || "").trim();
                    var pageName = parts.slice(1).join(" > ").trim();
                    
                    var moduleTagID = null;
                    var pageTagID = null;
                    
                    if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                        for (var i = 0; i < treeChildMenu.length; i++) {
                            var tm = treeChildMenu[i];
                            if (!moduleTagID && tm.DisplayTagName && (tm.DisplayTagName + "").trim().toLowerCase() === moduleName.toLowerCase() && tm.ParentTagId == 0) {
                                moduleTagID = tm.TagID;
                            }
                            if (!pageTagID && tm.DisplayTagName && (tm.DisplayTagName + "").trim().toLowerCase() === pageName.toLowerCase()) {
                                pageTagID = tm.TagID;
                            }
                            if (moduleTagID && pageTagID) break;
                        }
                    }
                    
                    // Also try current selected parent icon
                    if (!moduleTagID && typeof $ !== "undefined") {
                        var $selectedParent = $('.parent-panel .sidebar-menu > li.parent-icon.selected');
                        if ($selectedParent.length > 0) {
                            var iconId = $selectedParent.attr('id');
                            if (iconId) moduleTagID = iconId.replace('mainmenu_', '');
                        }
                    }
                    
                    if (moduleTagID && pageTagID) {
                        setClickableBreadcrumb(normalizedText, pageTagID, moduleTagID);
                    }
                }
            }
        } catch (ex) {
            if (console && console.log) {
                console.log("Error in ensureBreadcrumbLinksAreClickable:", ex);
            }
        }
    }
    
    //Added By Madhuri.K On 21-01-2026 - Helper function to set breadcrumb/header text (non-clickable)
    function setClickableBreadcrumb(headerText, pageTagID, parentModuleTagID) {
        
        try {
            if (!headerText || headerText === "" || headerText === "undefined") {
                return "";
            }
            
            var mainHeadingEl = document.getElementById("mainHeadingTop");
            if (!mainHeadingEl) {
                return "";
            }
            
            // Always show plain text breadcrumb (no hyperlinks)
            // Strip any existing HTML tags from headerText to avoid nested anchors
            var tempDiv = document.createElement("div");
            tempDiv.innerHTML = headerText;
            var normalizedText = (tempDiv.textContent || tempDiv.innerText || "").trim();
            mainHeadingEl.innerHTML = normalizedText;
            
            return mainHeadingEl.innerHTML;
        } catch (ex) {
            if (console && console.log) {
                console.log("Error in setClickableBreadcrumb:", ex);
            }
            // Fallback to plain text
            var mainHeadingEl = document.getElementById("mainHeadingTop");
            if (mainHeadingEl) {
                mainHeadingEl.innerHTML = headerText || "";
            }
            return "";
        }
    }
    
    //Added By Madhuri.K On 21-01-2026 - Handle clicks on module name in breadcrumb (opens child panel for that module)
    function navigateToModuleFromBreadcrumb(moduleTagID) {
        try {
            if (!moduleTagID || moduleTagID == 0 || moduleTagID == "0" || moduleTagID == "undefined") {
                return;
            }
            
            // Open child panel for this module
            if (typeof showChildPanel === "function") {
                showChildPanel(moduleTagID, false);
            }
            
            // Also ensure parent icon is selected
            if (typeof setParentModuleSelected === "function") {
                setParentModuleSelected(moduleTagID);
            }
        } catch (ex) {
            if (console && console.log) {
                console.log("Error in navigateToModuleFromBreadcrumb:", ex);
            }
        }
    }
    
    //Added By Madhuri.K On 21-01-2026 - Handle clicks on page name in breadcrumb (opens child panel, navigates to page, and selects it)
    function navigateToPageFromBreadcrumb(pageTagID, parentModuleTagID) {
        try {
            if (!pageTagID || pageTagID == 0 || pageTagID == "0" || pageTagID == "undefined") {
                return;
            }
            
            // First, open child panel for the parent module to ensure it's visible
            if (parentModuleTagID && typeof showChildPanel === "function") {
                showChildPanel(parentModuleTagID, false);
            }
            
            // Find the page details from treeChildMenu
            var pageUrl = "";
            var pageResponsiveUrl = "";
            var pageTemplateID = "";
            
            if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                for (var i = 0; i < treeChildMenu.length; i++) {
                    var tm = treeChildMenu[i];
                    if (tm.TagID == pageTagID) {
                        pageUrl = tm.DisplayPageName || "";
                        pageResponsiveUrl = tm.ResponsivePageName || "";
                        pageTemplateID = tm.TemplateID || "";
                        
                        // Handle landing pages for Timesheet and Helpdesk
                        if (tm.IsLandingPage == 1) {
                            if (tm.ParentTagId == 10) {
                                pageUrl = '../NewAPI/Timesheet/TMS_LandingPage.aspx?TagID=' + tm.ParentTagId;
                            } else if (tm.ParentTagId == 405 && tm.TagID == 405) {
                                pageUrl = '../HelpdeskEnhancement/Settings/CRM_LandingPage.aspx?TagID=' + tm.TagID;
                            }
                        }
                        break;
                    }
                }
            }
            
            if (pageUrl && pageUrl !== "" && pageUrl !== "undefined") {
                // Changed By Madhuri.K on 10-07-2026 - Removed 300ms delay; run after showChildPanel deferred nav (setTimeout 0) so this page wins
                setTimeout(function() {
                    // Create a temporary anchor element for ChangeTabs
                    var tempAnchor = document.createElement('a');
                    tempAnchor.id = 'a_' + (pageTemplateID || parentModuleTagID) + pageTagID;
                    
                    // Ensure header input exists for this page
                    var headerId = 'header_' + pageTagID;
                    var $existingHeader = $('#' + headerId);
                    if ($existingHeader.length === 0) {
                        // Try to find page name from treeChildMenu
                        var pageName = "";
                        if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                            for (var j = 0; j < treeChildMenu.length; j++) {
                                if (treeChildMenu[j].TagID == pageTagID) {
                                    pageName = treeChildMenu[j].DisplayTagName || "";
                                    break;
                                }
                            }
                        }
                        
                        if (pageName && pageName !== "") {
                            var headerInput = document.createElement('input');
                            headerInput.type = 'hidden';
                            headerInput.id = headerId;
                            headerInput.value = pageName;
                            document.body.appendChild(headerInput);
                        }
                    }
                    
                    // Call ChangeTabs to navigate to the page - this will also set the page as selected
                    if (typeof ChangeTabs === "function") {
                        ChangeTabs(tempAnchor, pageUrl, pageTagID, parentModuleTagID || pageTemplateID, pageResponsiveUrl);
                    }
                }, 0);
            } else {
                // If page URL not found, just ensure child panel is open
                // The panel should already be open from above, but ensure selection is set
                if (parentModuleTagID && typeof setChildPageSelected === "function") {
                    setChildPageSelected(pageTagID);
                }
            }
        } catch (ex) {
            if (console && console.log) {
                console.log("Error in navigateToPageFromBreadcrumb:", ex);
            }
        }
    }

    function ChangeTabs(obj, src, TagID, ParentTagID, TemplateID, responsivesrc) {
        //debugger
        //Added By Madhuri.K On 10-01-2026 - Set parent module as selected when navigating
        //Modified By Madhuri.K On 10-01-2026 - Ensure parent module stays selected when child page is clicked

        //Added by Aditya J.on 12-03-2026 for If click on other node and if again click on Helpdesk Overview then Helpdesk overview not getting opened
        if (TagID == "405" && ParentTagID == "405") {
            ParentTagID = "0";
        }
        if (TagID == "5" && ParentTagID == "5") {
            ParentTagID = "0";
        }
        //End of Added by Aditya J.on 12-03-2026 for If click on other node and if again click on Helpdesk Overview then Helpdesk overview not getting opened

        //commented and added by Aditya J. on 10-06-2026 for Please select project alert not coming issuex`
        <%--if ('<%=CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "")%>' == '')--%>
        if ($("#cboSessionProject").val() == "0" || $("#cboSessionProject").val() == "" || $("#cboSessionProject").val() == '' || $("#cboSessionProject").val() == "undefined" || $("#cboSessionProject").val() == null) {
            //End of commented and added by Aditya J. on 10-06-2026 for Please select project alert not coming issue
            // Projects module: check by TemplateID 'PM' (old menu) or by parent module TagID 305 (new child panel)
            // var isProjectsModule = (ParentTagID == 'PM');
            var isProjectsModule = (TemplateID == 'PM');

            if (isProjectsModule) {
                var tagIdNum = parseInt(TagID, 10);
                //Added by Vishal Mane on 04/03/2026 To  exclude TagIDs (36127, 36128, 36129, 36130) for Bulk Extension Pages
                var excludeTagIds = [32, 3936, 22593, 1263, 36127, 36128, 36129, 36130];
                //End of Added by Vishal Mane on 04/03/2026 To exclude TagIDs (36127, 36128, 36129, 36130) for Bulk Extension Pages
                var isExcluded = (excludeTagIds.indexOf(tagIdNum) !== -1);
                if (!isExcluded) {
                    alert("Please select project.");
                    return;

                }
            } 
        }
        var parentTagIdToSelect = null;
        if (ParentTagID && ParentTagID != 0 && ParentTagID != "" && ParentTagID != "undefined") {
            // ParentTagID is provided - check if it's a number (TagID) or string (TemplateID like 'CRM', 'PM')
            if (typeof ParentTagID === 'string' && isNaN(ParentTagID)) {
                // It's a TemplateID string, need to find the actual parent TagID
                // Try to find parent from currently selected parent icon
                var $selectedParent = $('.parent-panel .sidebar-menu > li.parent-icon.selected');
                if ($selectedParent.length > 0) {
                    var iconId = $selectedParent.attr('id');
                    if (iconId) {
                        parentTagIdToSelect = iconId.replace('mainmenu_', '');
                    }
                }
            } else {
                // It's a numeric TagID, use it directly
                parentTagIdToSelect = ParentTagID;
            }
        }
        
        //Added By Madhuri.K On 20-01-2026 - When clicking on parent icon again, open last visited page within that module instead of landing page
        //This should happen only after user has visited at least one child page (so lastVisitedPagesByModule[Parent] has a different TagID than the parent itself)
        //Modified By Madhuri.K On 27-01-2026 - Exclude Dashboard (21000) from last visited logic to always show landing page
        if (parentTagIdToSelect && parentTagIdToSelect != 21000 && typeof lastVisitedPagesByModule !== "undefined" && lastVisitedPagesByModule[parentTagIdToSelect]) {
            var lastVisitedForParent = lastVisitedPagesByModule[parentTagIdToSelect];
            if (lastVisitedForParent && lastVisitedForParent.tagID && lastVisitedForParent.src) {
                // Scenario: call is coming from parent icon (TagID == parentTagIdToSelect)
                // and last visited page is a different child page than the module itself
                if (TagID == parentTagIdToSelect && lastVisitedForParent.tagID != parentTagIdToSelect) {
                    src = lastVisitedForParent.src;
                    TagID = lastVisitedForParent.tagID;
                    if (lastVisitedForParent.responsiveSrc) {
                        responsivesrc = lastVisitedForParent.responsiveSrc;
                    }
                    
                    // Also ensure Selected Module path reflects the visited page, not just the module
                    // Example: "Resources > Visa Type Master" when reopening Resources module
                    try {
                        
                        if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                            var moduleNameForLast = "";
                            var pageNameForLast = "";
                            var parentIdNum = parseInt(parentTagIdToSelect, 10);
                            var childIdNum = parseInt(lastVisitedForParent.tagID, 10);
                            
                            for (var li = 0; li < treeChildMenu.length; li++) {
                                var tmLast = treeChildMenu[li];
                                if (parentIdNum && tmLast.TagID == parentIdNum && tmLast.ParentTagId == 0) {
                                    moduleNameForLast = tmLast.DisplayTagName || moduleNameForLast;
                                }
                                if (tmLast.TagID == childIdNum) {
                                    pageNameForLast = tmLast.DisplayTagName || pageNameForLast;
                                }
                            }
                            
                            var headerForLast = "";
                            if (moduleNameForLast && pageNameForLast) {
                                headerForLast = moduleNameForLast + " > " + pageNameForLast;
                            } else if (moduleNameForLast) {
                                headerForLast = moduleNameForLast;
                            }
                            
                            if (headerForLast && headerForLast !== "" && headerForLast !== "undefined") {
                                var headingEl = document.getElementById("mainHeadingTop");
                                if (headingEl) {
                                    // Show plain text breadcrumb (no hyperlinks)
                                        headingEl.innerHTML = headerForLast;
                                }
                            }
                        }
                    } catch (lastVisitedHeaderEx) {
                        // Ignore header errors, don't block navigation
                    }
                }
            }
        }
        
        // If we still don't have a parent TagID, try to find it
        if (!parentTagIdToSelect) {
            var $clickedElement = $(obj);
            var $parentIcon = $clickedElement.closest('.parent-icon');
            if ($parentIcon.length > 0) {
                var iconId = $parentIcon.attr('id');
                if (iconId) {
                    parentTagIdToSelect = iconId.replace('mainmenu_', '');
                }
            } else {
                // Try to find parent from child panel - look for the parent module that opened this child panel
                var $childPanel = $('#childPanel');
                if ($childPanel.length > 0 && $childPanel.hasClass('active')) {
                    // Find which parent icon was clicked to open this child panel
                    $('.parent-panel .sidebar-menu > li.parent-icon.selected').each(function() {
                        var $icon = $(this);
                        var iconId = $icon.attr('id');
                        if (iconId) {
                            var iconTagId = iconId.replace('mainmenu_', '');
                            // Verify this is the correct parent by checking if TagID is a child of this parent
                            if (treeChildMenu && treeChildMenu.length > 0) {
                                var childTagMasters = GetTagMastersByParentTagID(iconTagId, treeChildMenu);
                                for (var i = 0; i < childTagMasters.length; i++) {
                                    if (childTagMasters[i].TagID == TagID) {
                                        parentTagIdToSelect = iconTagId;
                                        return false; // break loop
                                    }
                                }
                            }
                        }
                    });
                }
            }
        }
       
        // Set parent module as selected if we found one
        // Only set selection if search is not active to prevent flickering
        if (parentTagIdToSelect) {
            var searchText = $("#childPanelSearch").val();
            if (!searchText || searchText.trim() == "") {
                setParentModuleSelected(parentTagIdToSelect);
            }
        }

        //Added By Madhuri.K On 10-01-2026 - Set child page as selected when navigating
        if (TagID) {
            setChildPageSelected(TagID); // Modify By Madhuri.K on 24-07-2026 - Restored fast selection clear+highlight
            
            //Added By Madhuri.K On 20-01-2026 - Track last visited child page for each parent module
            //Use resolved parentTagIdToSelect to map child page to its parent module
            if (parentTagIdToSelect) {
                var moduleNameForLastVisit = "";
                var pageNameForLastVisit = "";
                
                // Derive module/page names from treeChildMenu for reliability
                try {
                    if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                        var parentIdNumForLastVisit = parseInt(parentTagIdToSelect, 10);
                        var childIdNumForLastVisit = parseInt(TagID, 10);
                        for (var lvi2 = 0; lvi2 < treeChildMenu.length; lvi2++) {
                            var tmLastVisit = treeChildMenu[lvi2];
                            if (parentIdNumForLastVisit && tmLastVisit.TagID == parentIdNumForLastVisit && tmLastVisit.ParentTagId == 0) {
                                moduleNameForLastVisit = tmLastVisit.DisplayTagName || moduleNameForLastVisit;
                            }
                            if (tmLastVisit.TagID == childIdNumForLastVisit) {
                                pageNameForLastVisit = tmLastVisit.DisplayTagName || pageNameForLastVisit;
                            }
                        }
                    }
                } catch (exHeaderLastVisit) {
                    // Ignore errors while deriving names; names will just remain blank
                }
                
                lastVisitedPagesByModule[parentTagIdToSelect] = {
                    tagID: TagID,
                    src: src,
                    responsiveSrc: responsivesrc,
                    moduleName: moduleNameForLastVisit,
                    pageName: pageNameForLastVisit
                };
            }
            
            //Added From Old Logic - Set main heading (breadcrumb) based on header_TagID value
            //Modified By Madhuri.K On 20-01-2026 - Build full path as "Module > Page" using treeChildMenu
            try {
                var headerElementId = "header_" + TagID;
                var headerValue = null;
                
                // Prefer jQuery val() when element exists
                if (typeof $ !== "undefined") {
                    var $headerInput = $("#" + headerElementId);
                    if ((!$headerInput || $headerInput.length === 0) && obj) {
                        // Try to find header input relative to clicked element
                        var $clicked = $(obj);
                        $headerInput = $clicked.parent().find("#" + headerElementId);
                    }
                    if ($headerInput && $headerInput.length > 0) {
                        headerValue = $headerInput.val();
                    }
                }
                
                // Fallback to plain DOM lookup
                if ((!headerValue || headerValue === "" || headerValue === "undefined") && document.getElementById(headerElementId) != null) {
                    headerValue = document.getElementById(headerElementId).value;
                }
                
                // Build full breadcrumb from treeChildMenu if available: "<Module> > <Page>"
                // IMPORTANT: If headerValue ALREADY contains a "Module > Page" path, do NOT rebuild it.
                // This preserves correctly formatted headers like "Resources > Visa Type Master"
                try {
                    var headerLooksLikeFullPath = headerValue && headerValue.indexOf(">") > -1;
                    if (!headerLooksLikeFullPath &&
                        typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                        
                        var moduleName = "";
                        var pageName = "";
                        var parentIdNumeric = parseInt(parentTagIdToSelect || ParentTagID || 0, 10);
                        var tagIdNumeric = parseInt(TagID, 10);
                        
                        // Find parent module name
                        for (var i = 0; i < treeChildMenu.length; i++) {
                            var tm = treeChildMenu[i];
                            if (parentIdNumeric && tm.TagID == parentIdNumeric && tm.ParentTagId == 0) {
                                moduleName = tm.DisplayTagName || moduleName;
                            }
                            if (tm.TagID == tagIdNumeric) {
                                pageName = tm.DisplayTagName || pageName;
                            }
                        }
                        
                        // Fallbacks if module/page names are missing
                        if (!pageName || pageName === "" || pageName === "undefined") {
                            // Try to derive from existing header value (often just page caption)
                            if (headerValue && headerValue !== "" && headerValue !== "undefined") {
                                pageName = headerValue;
                            }
                        }
                        if (!moduleName || moduleName === "" || moduleName === "undefined") {
                            // Try to read selected parent icon text
                            var $selParent = $('.parent-panel .sidebar-menu > li.parent-icon.selected a .searchText');
                            if ($selParent && $selParent.length > 0) {
                                moduleName = $selParent.first().attr("originalname") || $selParent.first().text() || moduleName;
                            }
                        }
                        
                        // Compose breadcrumb
                        if (moduleName && pageName) {
                            headerValue = moduleName + " > " + pageName;
                        } else if (moduleName && (!pageName || pageName === "")) {
                            headerValue = moduleName;
                        } else if ((!headerValue || headerValue === "" || headerValue === "undefined") && pageName) {
                            headerValue = pageName;
                        }
                    }
                } catch (innerEx) {
                    // Ignore breadcrumb composition errors, fall back to headerValue if any
                }
                
                // Finally, set main heading if we have a value
                //Modified By Madhuri.K On 21-01-2026 - Make breadcrumb clickable with hyperlinks
                if (headerValue && headerValue !== "" && headerValue !== "undefined") {
                    // Save context so we can rebuild clickable links even if some other code overwrites the header text
                    updateBreadcrumbContext(parentTagIdToSelect, TagID, headerValue);
                    // Render as clickable breadcrumb links
                    setClickableBreadcrumb(headerValue, TagID, parentTagIdToSelect);
                    // Attach observer to auto-reapply links if overwritten
                    initBreadcrumbObserver();
                }
                
                //Explicit override for Create Project page to ensure correct breadcrumb
                //If URL contains PM_CreateProject.aspx, always show "Projects > Create Project" as clickable links
                try {
                    if (src && typeof src === "string" && src.toLowerCase().indexOf("pm_createproject.aspx") > -1) {
                        var mainHeadingElOverride = document.getElementById("mainHeadingTop");
                        if (mainHeadingElOverride) {
                            // Find Projects module TagID from treeChildMenu
                            var projectsModuleTagId = null;
                            if (typeof treeChildMenu !== "undefined" && treeChildMenu && treeChildMenu.length > 0) {
                                for (var pi = 0; pi < treeChildMenu.length; pi++) {
                                    if (treeChildMenu[pi].DisplayTagName && treeChildMenu[pi].DisplayTagName.toLowerCase().indexOf("project") > -1 && treeChildMenu[pi].ParentTagId == 0) {
                                        projectsModuleTagId = treeChildMenu[pi].TagID;
                                        break;
                                    }
                                }
                            }
                            // Use parentTagIdToSelect if found, otherwise fallback to projectsModuleTagId
                            var moduleTagIdForLink = parentTagIdToSelect || projectsModuleTagId || "";
                            // Find Create Project page TagID (typically 1263 for PM_CreateProject)
                            var createProjectTagId = TagID || 1263;
                            
                            // Show plain text breadcrumb override (no hyperlinks)
                            mainHeadingElOverride.innerHTML = "Projects > Create Project";
                        }
                    }
                } catch (overrideEx) {
                    // Ignore override errors
                }
                
                //Removed clickable breadcrumb enforcement - header should remain plain text
            } catch (e) {
                // Swallow errors to avoid breaking navigation
                if (console && console.log) {
                    console.log("Error while setting mainHeadingTop:", e);
                }
            }
        }
        
        //Added By Dipali V On 8th Jan 2020 For Multiple Login
        $.ajax({
            url: "../Home/MultipleLogin.aspx", success: function (result) {

            }
        });
        //End of Added By Dipali V On 8th Jan 2020 For Multi Login
        if (src == "") {
            return;
        }
        
       <%-- if ('<%=CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "")%>' == '') {
            // Projects module: check by TemplateID 'PM' (old menu) or by parent module TagID 305 (new child panel)
            var isProjectsModule = (ParentTagID == 'PM');
            if (isProjectsModule) {
                var tagIdNum = parseInt(TagID, 10);
                var excludeTagIds = [32, 3936, 22593, 1263];
                var isExcluded = (excludeTagIds.indexOf(tagIdNum) !== -1);
                if (!isExcluded) {
                    alert("Please select project.");
                    return;
                }
            }
        }--%>

        $(".highlight").removeClass("highlight");
       
        var EmployeeID;
        EmployeeID = '<%= Session("intUserID") %>';
        // alert(EmployeeID);
        if (EmployeeID == '') {
            alert('Your session is expired. Please login again.');
            window.location.href = "../../Default.aspx?Message=SessionExpired";
        }
        // 
        //if (ParentTagID == 10 || ParentTagID == 405 || ParentTagID == 1085 || TagID == 21000 || TagID == 21002 || TagID == 5 || TagID == 1263 || TagID == 22597 || TagID == 22599 || TagID == 2104 || TagID == 1018 || TagID == 22600 || TagID == 1019 || TagID == 22601 || TagID == 468 || TagID == 2191 || TagID == 32 || TagID == 538 || TagID == 22603 || TagID == 2252 || TagID == 21006 || TagID == 22234 || TagID == 27 || TagID == 2056 || TagID == 2075 || TagID == 2059 || TagID == 2057 || TagID == 2055 || TagID == 3900 || TagID == 719 || TagID == 461 || TagID == 1262 || TagID == 22615 || TagID == 22611 || TagID == 22612 || TagID == 3857 || TagID == 418 || TagID == 22613 || TagID == 22614 || TagID == 562) {
        //if (TagID != 305) {
       

        document.getElementById("frmNewVersion").src == "";
        if (src.toLowerCase != undefined) {
            if (src.toLowerCase().indexOf("mastertagid") == -1) {
                if (src.toLowerCase().indexOf("?") == -1)
                    document.getElementById("frmNewVersion").src = src + "?MasterTagId=" + TagID;
                else
                    document.getElementById("frmNewVersion").src = src + "&MasterTagId=" + TagID;
            }
            else {
                document.getElementById("frmNewVersion").src = src //+ "&MasterTagId=" + TagID;
            }
        }
        
        //Added By Madhuri.K On 21-01-2026 - Final check to ensure breadcrumb links are clickable after all operations
        setTimeout(function() {
            ensureBreadcrumbLinksAreClickable();
        }, 2);

        //Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue
        if ("<%= Request.QueryString("FromOld")%>" != "") {
            if ("<%= Request.QueryString("FromOld")%>" != "1258") {
                if (document.getElementById("header_" + TagID) != null) {
                    document.getElementById("mainHeadingTop").innerHTML = $(obj).parent().find("#header_" + TagID).val();//document.getElementById("header_" + TagID).value;
                }
            } else {

                document.getElementById("mainHeadingTop").innerHTML = 'Projects > Manage Projects';
            }

            //Added By Madhuri.K On 09-01-2026 - Fix undefined header issue
            if (document.getElementById("header_" + TagID) != null) {
                var headerValue = $(obj).parent().find("#header_" + TagID).val();
                // If header not found via jQuery, try getElementById
                if (!headerValue || headerValue == "" || headerValue == "undefined") {
                    var headerElement = document.getElementById("header_" + TagID);
                    if (headerElement && headerElement.value) {
                        headerValue = headerElement.value;
                    }
                }
                // Only set if header value is valid
                if (headerValue && headerValue != "" && headerValue != "undefined") {
                    document.getElementById("mainHeadingTop").innerHTML = headerValue;
                }
            }
            //End Added By Madhuri.K On 09-01-2026
        }

        //Added By dipali V On 20th april 2023 For Nagivation Header 
        if (document.getElementById("frmNewResponsiveVersion").length == undefined) {
            if (ParentTagID == "CRM" && src == "../HelpdeskEnhancement/Settings/HelpdeskTab.aspx?MasterTagId=405") {
                document.getElementById("mainHeadingTop").innerHTML = "Help-Desk > Support";
            }
            else if (ParentTagID == "BTS" && src == "../NewAPI/Issues/IssueList.aspx?MasterTagId=5") {
                document.getElementById("mainHeadingTop").innerHTML = "Issues > Issue List";
            } else {
                //Added By Madhuri.K On 09-01-2026 - Fix undefined header issue
                var headerValue = $("#a_" + ParentTagID + TagID).parent().find("#header_" + TagID).val();
                // If header not found via jQuery, try getElementById
                if (!headerValue || headerValue == "" || headerValue == "undefined") {
                    var headerElement = document.getElementById("header_" + TagID);
                    if (headerElement && headerElement.value) {
                        headerValue = headerElement.value;
                    }
                }
                // If still no header, don't set undefined
                if (headerValue && headerValue != "" && headerValue != "undefined") {
                    document.getElementById("mainHeadingTop").innerHTML = headerValue;
                }
                //End Added By Madhuri.K On 09-01-2026
            }
        }

        //End of Added By dipali V On 20th april 2023 For Nagivation Header 
        //Added By Madhuri.K On 09-01-2026 - Ensure header is set even if ChangeTabs couldn't find it
        
        var headerFromChangeTabs = $("#a_" + ParentTagID + TagID).parent().find("#header_" + TagID).val();
        console.log(headerFromChangeTabs);
        // If header is still undefined or empty, try to get it from global header input
        if (!headerFromChangeTabs || headerFromChangeTabs == "" || headerFromChangeTabs == "undefined") {
            var globalHeaderElement = document.getElementById("header_" + TagID);
            if (globalHeaderElement && globalHeaderElement.value && globalHeaderElement.value != "" && globalHeaderElement.value != "undefined") {
                if (document.getElementById("mainHeadingTop")) {
                    document.getElementById("mainHeadingTop").innerHTML = globalHeaderElement.value;
                }
            }
        }
        //End Added By Madhuri.K On 09-01-2026

        //// Remove highlight from all menu items first
        //const allMenuItems = document.querySelectorAll('.treeview, .makesmaller');
        //allMenuItems.forEach(item => {
        //    item.classList.remove('highlight', 'active');
        //});

        // Highlight selected tree link as active/highlighted (guard for calls without DOM element)
        try {
            if (obj && obj.nodeType === 1) {
                //Commented By Dipali V On 19th Sep 2025 For Navigation Tree Issue
               // $(".menu-open sidebar-menu .highlight").removeClass("highlight active");

                $(obj).closest("li").addClass("highlight active");
                //End of Commented By Dipali V On 19th Sep 2025 For Navigation Tree Issue
            }
        } catch (e) { }

       
        //End of Added By Dipali V On 31st Dec 2021 For Manage PRoject  List Issue

         //Added By Dipali V On 31st Dec 2021 For Javascript Issue
        if (responsivesrc == "") {
            responsivesrc = undefined;
        }
         //End of Added By Dipali V On 31st Dec 2021 For Javascript Issue
        if (responsivesrc != undefined) {
            //alert(responsivesrc);
            document.getElementById("frmNewResponsiveVersion").src = responsivesrc;
        }

    }

    function ChangeToOldVersion() {
        $.ajax({
            url: "Navigation.aspx/ChangeVersion",
            data: JSON.stringify({ VersionID: "1" }),
            dataType: "json",
            contentType: "application/json",
            type: "POST",
            success: function (result) {
                //  alert(result);
                var strFromWhere = '<%=Session("strActiveModule")%>';
                window.open("Navigation.aspx?FromWhere=" + strFromWhere, "_self")
            }
        })
    }

    function GotoRequestDetail(QueryID) {
        ChangeTabs('../HelpdeskEnhancement/Settings/HelpdeskTab.aspx?QueryID=' + QueryID, 405, 405);
        $("#myModal2").modal('hide');
    }

    function ChangeTheme(ThemeID) {
        $.ajax({
            url: "Navigation.aspx/ChangeTheme",
            type: "POST",
            dataType: "json",
            data: JSON.stringify({ id: ThemeID }),
            contentType: "application/json",
            success: function (result) {
                var strFromWhere = '<%=Session("strActiveModule")%>';
                window.open("Navigation.aspx?FromWhere=" + strFromWhere, "_self")
            },
            error: function (xhr) { console.log(xhr); }
        })
    }

    function GotoMyProfile() {
        document.getElementById("frmNewVersion").src = '../HelpdeskEnhancement/MyProfile/ProfileTab.aspx';
    }
    function RefreshPage() {
        if (window.location.href.indexOf("FromWhere") > 0) {
            window.location.reload();
        }
        else {
            window.location.href = window.location.href + "?FromWhere=SM"
        }

    }
    function MarkAllDiscussionAsRead() {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            contentType: 'application/json',
            url: 'Navigation.aspx/MarkAllDiscussionAsRead',
            data: JSON.stringify({ UserID: "<%=Session("intUserID")%>", LoginType: "<%=HttpContext.Current.Session("LoginType")%>" }),
            success: function (Result) {
                var strFromWhere = '<%=Session("strActiveModule")%>';
                window.open("Navigation.aspx?FromWhere=" + strFromWhere, "_self")
            },
            error: function (xhr) {
                console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

            }
        });
    }
        //End Added By Vaijat K ON 14/12/2017 For Alerts Flags Discussion And Theme
  
    $(".sidebar-menu").on('scroll', function () {
        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip('update');
        $('.tooltip').remove();
    });
    $(".search.makesmaller").on('hover', function () {
        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip('update');
        //$('.tooltip').remove();
        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip('disable') // Disable tooltips
        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip('enable')
        alert();
        $(".treeview.search[data-bs-toggle='tooltip']").tooltip('hide');
    });
    
</script>

 