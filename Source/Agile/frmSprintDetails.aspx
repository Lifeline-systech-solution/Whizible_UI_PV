<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmSprintDetails.aspx.vb" Inherits="PbNIT.frmSprintDetails" %>

<!DOCTYPE html>

<html>
            <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">

<%--   
     <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css" />
    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

    <script src="assets/js/dragdrop.js"></script>

<%--    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>

    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../DB/DateFormat.js"></script>

<%--    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
  <%--  <link href="../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />--%>

<%--    <link href="../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />--%>
   
    <script src="js/jquery.nicescroll.min.js"></script>
    <!-- Date picker css files-->


    
 <%--   <script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
 
    <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    
     <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
 
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
<link href="../../Whizible2.0-new/dist/css/editor.css" rel="stylesheet" />
<script src="../../Whizible2.0-new/dist/js/editor.js"></script>

    <script src="js/CommonJS.js?v=1.1"></script>


<%--    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />

    <!-- Latest compiled and minified JavaScript -->

    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>

    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>

    <title>Sprint Details</title>

    <style type="text/css">
        #divdetails .form-control[readonly] {
            cursor: auto !important;
        }

        canvas {
            width: 70% !important;
        }

        #uldropdown li {
            list-style: none;
            cursor: pointer;
            float: left;
            width: 100%;
            padding: 0px 7px !important;
            font-weight: normal;
            margin-top: 10px;
        }

        #filter-dropdown {
            top: auto;
            max-height: 420px !important;
            width: 300px;
            padding: 0px;
            background-color: #fff;
            /*left: auto !important;*/
            height: 350px !important;
        }

        #uldropdown {
            background-color: #fff;
        }

        ui-datepicker-div {
            background-color: rgb(128, 139, 150);
        }

        #tblAdvHeader p {
            margin: 8px 0 10px !important;
            font-size: 14px;
            margin-left: 8px;
        }

        .grey-text {
            color: #888888e0;
            font-weight: normal;
        }

        #tblAdvHeader .fa, #tblAdvHeader .fas {
            margin: 8px 12px 10px !important;
        }
        /*#divsprintUL {
          height: 253px;
     left: 0;
    right: unset;
    margin-left: 15px;
    width:90%;
      margin-top: -257px;
     border: 1px solid white !important; 
    }*/
        #SprintlistUL {
            height: 253px;
            left: 0;
            right: unset;
            margin-left: 15px;
            width: 90%;
            margin-top: -8px;
            border: 1px solid white !important;
            overflow: auto;
            -ms-overflow-style: none;
        }

        #dropdown-content {
            padding: 8px !important;
        }

        .btn-info {
            text-transform: capitalize !important;
            color: rgb(255, 255, 255) !important;
            background-color: rgb(1, 87, 155) !important;
            box-shadow: rgba(0, 188, 212, 0.14) 0px 2px 2px 0px, rgba(0, 188, 212, 0.2) 0px 3px 1px -2px, rgba(0, 188, 212, 0.12) 0px 1px 5px 0px !important;
        }

        img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
        }

        .card {
            box-shadow: 0 1px 4px 0 rgba(0,0,0,.14);
        }

        .card {
            border: 0;
            margin-bottom: 30px;
            margin-top: 30px;
            border-radius: 6px;
            color: #333;
            background: #fff;
            width: 100%;
            box-shadow: 0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid #eee;
            border-radius: .25rem;
        }

        .card {
            font-size: .875rem;
        }

        .card-stats .card-header.card-header-icon, .card-stats .card-header.card-header-text {
            text-align: right;
        }

        .card [class*=card-header-] {
            margin: 0 15px;
            padding: 0;
            position: relative;
        }

        .card .card-header {
            z-index: 3 !important;
        }

        .card [class*=card-header-] .card-icon, .card [class*=card-header-] .card-text {
            border-radius: 3px;
            background-color: #999;
            padding: 15px;
            margin-top: -20px;
            margin-right: 15px;
            float: left;
        }

        .card .card-header-warning .card-icon {
            box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 10px -5px rgba(255,152,0,.4);
        }

        .card .card-header-warning .card-icon {
            background: linear-gradient(60deg,#ffa726,#fb8c00);
        }

        .card .card-header-success .card-icon {
            box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 10px -5px rgba(76,175,80,.4);
        }

        .card .card-header-danger .card-icon {
            box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 10px -5px rgba(244,67,54,.4);
        }

        .card .card-header-danger .card-icon {
            background: linear-gradient(60deg,#ef5350,#e53935);
        }

        .card .card-header-success .card-icon {
            background: linear-gradient(60deg,#66bb6a,#43a047);
        }

        .card .card-header-info .card-icon {
            box-shadow: 0 4px 20px 0 rgba(0,0,0,.14), 0 7px 10px -5px rgba(0,188,212,.4);
            background: linear-gradient(60deg,#26c6da,#00acc1);
        }

        .card-stats .card-header.card-header-icon i {
            font-size: 36px;
            line-height: 56px;
            width: 56px;
            height: 56px;
            text-align: center;
        }

        .material-icons {
            font-family: 'Material Icons';
            font-weight: normal;
            font-style: normal;
            font-size: 24px;
            line-height: 1;
            letter-spacing: normal;
            text-transform: none;
            display: inline-block;
            white-space: nowrap;
            word-wrap: normal;
            direction: ltr;
            -webkit-font-feature-settings: 'liga';
            -webkit-font-smoothing: antialiased;
        }

        .card-stats .card-header .card-category:not([class*=text-]) {
            color: #999;
            font-size: 14px;
        }

        icon .card-title, .card .card-header.card-header-text .card-title {
            margin-top: 15px;
            color: #3c4858;
        }

        .small, small {
            font-size: 80%;
            font-weight: 400;
        }

        .card-stats .card-header + .card-footer {
            border-top: 1px solid #eee;
            margin-top: 14px;
        }

        .card .card-footer {
            padding: 0;
            padding-top: 10px;
            margin: 0 15px 10px;
            border-radius: 0;
            justify-content: space-between;
            align-items: center;
        }

        .card .card-footer {
            display: flex;
            align-items: center;
            background-color: transparent;
            border: 0;
        }

            .card .card-footer .stats {
                color: #999;
                font-size: 12px;
                line-height: 22px;
            }

                .card .card-footer .stats .material-icons {
                    position: relative;
                    top: 4px;
                    font-size: 16px;
                }

                .card .card-footer .stats .material-icons {
                    position: relative;
                    top: -10px;
                    margin-right: 3px;
                    margin-left: 3px;
                    font-size: 18px;
                }

        .nowrap {
            white-space: nowrap;
        }

        .progress {
            height: 5px !important;
        }

        .nav-tabs > li > a.active, .nav-tabs > li > a:focus, .nav-tabs > li > a:hover {
            color: #fff!important;
            cursor: default;
            background-color: rgb(1, 87, 155) !important;
            border: 1px solid #ddd;
            border-bottom-color: transparent;
        }

        .nav-tabs {
            border-bottom: 3px solid #0288D1 !important;
        }

            .nav-tabs > li > a {
                font-size: 14px !important;
                /* Modified By Madhuri.K On 01-04-2026 */
            }
        /*.nav-tabs>li>{
    font-size: 16px!important;
    color: grey!important;
   }*/
        .form-control {
            display: block;
            width: 100%;
            /*height: 25px;
    margin-bottom: 22px;
    padding: 4px 12px;*/
            /*height: 34px !important;*/
            height: auto;
            margin-bottom: 10px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: transparent !important;
            background-image: none;
            border-top: 0px !important;
            border-right: 0px !important;
            border-left: 0px !important;
            border-bottom: 1px solid #ccc !important;
            border-radius: 0px !important;
            box-shadow: none !important;
        }

        *:not(.fa):not(small) {
            font-family: helvetica;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 01-04-2026 */
        }

        .control-label {
            color: grey !important;
        }

        .required {
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: red !important;
        }

        .clsDiscussion {
            color: grey;
            /* height: 25px;
    border-bottom: 2px solid rgb(60, 141, 188) !important;
    line-height: 1;*/
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            /*  padding-bottom: 4%;*/
        }

        .team_cards {
            padding: 9px;
            text-align: left;
            background-color: #fff;
            box-shadow: 0 6px 8px 0 rgba(0,0,0,0.07), 0 6px 18px 0 rgba(0,0,0,0.19);
            margin: 9px;
        }

        .ResourcePercentage {
            color: #f0ad4e;
            /* text-align: left; */
            font-weight: 700;
        }

        .ClsRole {
            color: #3c7dcf !important;
        }

        #countDown {
            font-size: 11.5px;
            font-weight: 500;
            color: grey;
            float: right;
        }

        .demo-droppable {
            /* background: #08c; */
            color: white !important;
            padding: 25px 0;
            text-align: center;
            border: 1px dotted #22af81;
        }

        .btn.btn-info {
            text-transform: Capitalize !important;
            color: #fff !important;
            background-color: #01579B !important;
            border-color: #01579B !important;
            -webkit-box-shadow: 0 2px 2px 0 rgba(0,188,212,.14), 0 3px 1px -2px rgba(0,188,212,.2), 0 1px 5px 0 rgba(0,188,212,.12) !important;
            box-shadow: 0 2px 2px 0 rgba(0,188,212,.14), 0 3px 1px -2px rgba(0,188,212,.2), 0 1px 5px 0 rgba(0,188,212,.12) !important;
        }

        .demo-droppable p {
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-weight: 600;
            color: rgba(158, 158, 158, 1) !important;
        }

        .activity-row {
            margin-bottom: 1em;
            padding-bottom: 1em;
        }

        .activity-row {
            margin-bottom: 1.5em;
            padding-bottom: 1.5em;
            border-bottom: 1px solid #EEE;
        }

        .activity-row, .activity-row1 {
            padding: 5px;
            text-align: left;
            background-color: #fff;
            box-shadow: 0 6px 8px 0 rgba(0,0,0,0.07), 0 6px 18px 0 rgba(0,0,0,0.19);
            margin: 1px;
        }

        .activity-desc h5 {
            color: #00BCD4;
            font-size: 1em;
            font-weight: 400;
            margin-bottom: 5px;
        }

        .activity-desc h5 {
            font-size: 0.85em;
        }

            .activity-desc h5 a {
                color: #00BCD4;
            }

        .activity-desc p {
                font-size: 11.5px;
        }

        .activity-desc p {
            color: #999;
            font-size: 0.85em;
            line-height: 1.5em;
        }

        .activity-desc1 h6 {
            color: #000000ab;
            font-size: 11.5px;
            margin: 1em 0 0 0;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden !important;
            text-overflow: ellipsis;
        }

        .upload-header {
            color: gray !important;
            font-size: 15px !important;
            font-weight: 500 !important;
        }

        .attach-details {
            /*color: #8080809e!important;*/
            font-size: 14px !important;
            word-break: break-all;
        }

        .feed-element {
            border-bottom: 2px solid #e7eaec;
        }

        .feed-element {
            margin-top: 15px;
        }

        .feed-element {
            padding-bottom: 15px;
        }

            .feed-element > .float-start {
                margin-right: 10px;
            }

        .text-navy {
            font-size: 11.5px !important;
            font-weight: 500;
            color: #1ab394 !important;
        }

        .right .date-time {
            float: left;
        }

        .date-time {
            font-size: 10px;
            display: block;
            float: right;
            color: #999;
            margin-top: 3px;
        }

        .right .name {
            text-align: right;
        }

        .name {
            display: block;
        }

        .right .image {
            float: right;
        }

            .right .image + .message {
                margin-right: 75px;
                margin-left: 0;
            }

        .message {
            padding: 1px 100px;
            font-size: 11.5px;
            position: relative;
            /*background: #fff;*/
            border-radius: 14px;
            width: 113%;
        }

        .right > .float-end {
            margin-right: 10px;
        }

        ::placeholder {
            color: #8080809e !important;
            font-size: 14px !important;
        }

        .fa-trash-o {
            color: red;
        }

        @media only screen and (max-width: 1219px) {
            .nav-tabs > li > a {
                padding: 15px 16px;
            }
        }

        @media only screen and (max-width: 1150px) {
            .nav-tabs > li > a {
                padding: 15px 15px;
            }
        }

        @media only screen and (max-width: 480px) {
            .nav-tabs > li > a {
                width: 100%;
            }
        }

        @media only screen and (max-width: 990px) {
            .nav-tabs > li > a {
                padding: 15px 5px;
            }
        }

        /*Added By Ankush T on 22-06-2018 Data Table css*/
        .dataTables_filter {
            display: none;
        }

        .dataTables_length {
            display: none;
        }

        #tblShowSubUserStory_paginate {
            float: right;
        }

        #tblTaskDetails_paginate {
            float: right;
        }

        #tblIssueDetails_paginate {
            float: right;
        }

        #tblReviewList_paginate {
            float: right;
        }

        #tblHistoryList_paginate {
            float: right;
        }

        .morecontent span {
            display: none;
        }

        #tblShowSubUserStory tr th {
            font-weight: 600 !important;
            text-align: center !important;
        }

        #tblTaskDetails tr th {
            font-weight: 600 !important;
            text-align: center !important;
        }

        #tblReviewList tr th {
            font-weight: 600 !important;
            text-align: center !important;
        }

        #tblIssueDetails tr th {
            font-weight: 600 !important;
            text-align: center !important;
        }

        #tblHistoryList tr th {
            font-weight: 600 !important;
            text-align: center !important;
        }

        #BurnDownGraph {
            width: 788px !important;
            height: 443px !important;
        }

        #BurnUpGraph {
            width: 788px !important;
            height: 443px !important;
        }

        #BurnupGraphStoryPoints {
            width: 788px !important;
            height: 443px !important;
        }

        #BurnupGraphEfforts {
            width: 788px !important;
            height: 443px !important;
        }

        #VelocitySToryPoints {
            width: 788px !important;
            height: 443px !important;
        }

        #VelocityEffortBar {
            width: 788px !important;
            height: 443px !important;
        }

        .dataTables_empty {
            text-align: center !important;
        }

        ::-webkit-scrollbar {
            display: none;
        }

        html, body {
            -ms-overflow-style: none;
            overflow: hidden;
        }

        #tblSprintDetails_paginate {
            float: right;
        }

        /*#divSprintdetails table tr td:nth-child(1) {
            width: 35% !important;
            word-break:break-all;
        }*/

        #divSprintdetails {
            /*height: 217px;
            margin-top: -229px;*/
            /*-ms-overflow-style: none;
          overflow: auto;*/
        }

        /*.clsHeaderFixedCells {
    position: relative;
    left: 0px;
    padding: 5px;
    z-index: 999;
    background-color: #f7e6cc !important;
}*/

        /*.clsFixedCells {
    position: relative;
    left: 0px;
    padding: 5px;
    z-index: 999;*/
        /*background-color: #f7e6cc !important;*/
        /*}*/


        /*.clsTREvenRow th {
    padding: 5px !important; 
    position: relative;
    top: 0px;
    background-clip: padding-box;
    font-weight: 100;
    color: #c2c2c2; 
}*/

        #trsprintdetails .dataTables_empty {
            display: none;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            left: 0;
            z-index: 1000;
            display: none;
            float: left;
            min-width: 160px;
            padding: 5px 0;
            margin: 2px 0 0;
            font-size: 14px;
            text-align: left;
            list-style: none;
            background-color: #fff;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            border: 1px solid #ddd !important;
            /*border: 0px solid rgba(0,0,0,.15)!important;*/
            border-radius: 0px !important;
            -webkit-box-shadow: 0 0px 0px rgba(0,0,0,.175) !important;
            box-shadow: 0 0px 0px rgba(0,0,0,.175) !important;
            /*height: 350px;*/
        }

        #tblShowSubUserStory table tr td {
            table-layout: fixed;
            overflow-wrap: break-word;
            word-wrap: break-word; /* IE */
        }

        #DivAttachments {
            /*height: 460px;*/
            margin-left: -1px;
            /* overflow: auto; */
            -ms-overflow-style: none;
            overflow: auto;
            overflow-x: hidden;
            width: 106%;
        }

        #mainDivAttachments {
            width: 97.5%;
            margin-left: -14px;
        }

        #divBurnupdown {
            -ms-overflow-style: none;
            overflow: auto;
            /*width: 96%;*/
        }

        #divcontainerBurn {
            /*-ms-overflow-style: none;
            overflow: auto;*/
            width: 106%;
        }

        #mainDivDisscussion {
            /*height: 489px;*/
        }

        #MainDiscussions {
            width: 106%;
            -ms-overflow-style: none;
            overflow: -moz-scrollbars-none;
            /*overflow: -moz-hidden-unscrollable*/
            overflow: auto;
            overflow-x: hidden;
        }

        #divuserstoryList table thead tr th:nth-child(1) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divuserstoryList table thead tr th:nth-child(2) {
            /*text-align:center !important;*/
            width: 30% !important;
        }

        #divuserstoryList table thead tr th:nth-child(3) {
            /*text-align:center !important;*/
            width: 35% !important;
        }

        #divuserstoryList table thead tr th:nth-child(4) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divuserstoryList table thead tr th:nth-child(5) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divuserstoryList table tbody tr td {
            /*text-align:center !important;*/
            word-break: break-all !important;
        }

        #divTaskList table thead tr th:nth-child(1) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divTaskList table thead tr th:nth-child(2) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divTaskList table thead tr th:nth-child(3) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divTaskList table thead tr th:nth-child(4) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divTaskList table thead tr th:nth-child(5) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divTaskList table tbody tr td {
            /*text-align:center !important;*/
            word-break: break-all !important;
        }

        #divIssueList table thead tr th:nth-child(1) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divIssueList table thead tr th:nth-child(2) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divIssueList table thead tr th:nth-child(3) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divIssueList table thead tr th:nth-child(4) {
            /*text-align:center !important;*/
            width: 15% !important;
        }

        #divIssueList table thead tr th:nth-child(5) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divIssueList table thead tr th:nth-child(6) {
            /*text-align:center !important;*/
            width: 50% !important;
        }

        #divIssueList table tbody tr td {
            /*text-align:center !important;*/
            word-break: break-all !important;
        }


        #divHistoryList table thead tr th:nth-child(1) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divHistoryList table thead tr th:nth-child(2) {
            /*text-align:center !important;*/
            width: 15% !important;
        }

        #divHistoryList table thead tr th:nth-child(3) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divHistoryList table thead tr th:nth-child(4) {
            /*text-align:center !important;*/
            width: 30% !important;
        }

        #divHistoryList table thead tr th:nth-child(5) {
            /*text-align:center !important;*/
            width: 30% !important;
        }


        #divHistoryList table tbody tr td {
            /*text-align:center !important;*/
            word-break: break-all !important;
        }


        #divReviewList table thead tr th:nth-child(1) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divReviewList table thead tr th:nth-child(2) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divReviewList table thead tr th:nth-child(3) {
            /*text-align:center !important;*/
            width: 10% !important;
        }

        #divReviewList table thead tr th:nth-child(4) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divReviewList table thead tr th:nth-child(5) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divReviewList table thead tr th:nth-child(6) {
            /*text-align:center !important;*/
            width: 20% !important;
        }

        #divReviewList table tbody tr td {
            /*text-align:center !important;*/
            word-break: break-all !important;
        }

        #divuserstory {
            /*height: 500px;*/
            -ms-overflow-style: none;
            overflow: auto;
            overflow-x: hidden;
            width: 106%;
        }

        #divuserstoryList {
            width: 96%;
        }

        #divTask {
            /*height: 500px;*/
            -ms-overflow-style: none;
            overflow: auto;
            overflow-x: hidden;
            width: 106%;
        }

        #divTaskList {
            width: 96%;
        }

        #mainDivTeams {
            /*height: 500px;*/
            -ms-overflow-style: none;
            overflow: auto;
            overflow-x: hidden;
            width: 106%;
        }

        #divReview {
            /*height: 500px;*/
            -ms-overflow-style: none;
            overflow: auto;
            overflow-x: hidden;
            width: 106%;
        }

        #divReviewList {
            width: 96%;
        }

        #divHistory {
            /*height: 550px;*/
            -ms-overflow-style: none;
            overflow: auto;
            overflow-x: hidden;
            width: 106%;
        }

        #divHistoryList {
            width: 96%;
        }

        #divIssue {
            /*height: 500px;*/
            overflow: auto;
            -ms-overflow-style: none;
            overflow-x: hidden;
            width: 106%;
        }

        #divIssueList {
            width: 96%;
        }

        body {
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 11.5px;
            line-height: 1.42857143;
            color: #333;
            background-color: #fff !important;
            overflow-x: hidden;
        }

        .tabcontentChart {
            float: left;
            padding: 0px 12px;
            /* border: 1px solid #ccc; */
            width: 81%;
            border-left: none;
            /*height: 300px;*/
            /* border-radius: 4px; */
            margin-top: 2%;
        }

        .divLineGraph {
            padding: 5px;
            border-top: 2px solid #3c8dbc !important;
            border-right: none;
            border-left: none;
            border-bottom: none;
            height: 100%;
            width: 126% !important;
        }

        .ClsHeaderGraph {
            margin-top: 0%;
            margin-left: 2%;
        }

        .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
            cursor: not-allowed;
            /*background-color: #eee;*/
            opacity: 1;
        }

        .dropdown-menu > li > a {
            display: block;
            padding: 3px 20px;
            clear: both;
            font-weight: 400;
            line-height: 1.42857143;
            color: #333;
            /* white-space: nowrap; */
            white-space: pre-wrap !important;
            word-wrap: break-word !important;
        }

        .nowrap + .tooltip > tooltip.inner {
            background-color: #000 !important;
            color: #fff !important;
        }

        #divdetails {
            /*height:535px;*/
            -ms-overflow-style: none;
            overflow: auto;
            width: 105%;
        }


        /*.ui-tooltip {
	        padding: 4px!important;
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
        }

        .ui-tooltip-content::after, .ui-tooltip-content::before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
}

.bottom .ui-tooltip-content::after {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.bottom .ui-tooltip-content::before {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.top .ui-tooltip-content::after {
    top: -6px;
    left: 50%;
    border-bottom-color: #000;
    
    border-width: 0 6px 6px;
    margin-left: -6px;
}

.top .ui-tooltip-content::before {
     border-color: rgba(118, 118, 118, 0);
     border-bottom-color: #000;
     top: -6px;
     left: 50%;
     border-width: 0 6px 6px;
     margin-left: -6px;
 }*/



        .ui-tooltip {
            padding: 1px !important;
            position: absolute;
            z-index: 999;
            background: #000 !important;
            color: #fff !important;
            -webkit-box-shadow: 0 !important;
            box-shadow: 0 !important;
            border: none !important;
            font-size: 5px !important;
        }

        .ui-tooltip-content {
            position: relative;
            padding: 2px;
            font-size: 11.5px !important;
        }

            .ui-tooltip-content::after, .ui-tooltip-content::before {
                top: 100%;
                border: solid transparent;
                content: " ";
                height: 0;
                width: 0;
                position: absolute;
            }

        .bottom .ui-tooltip-content::after {
            border-color: rgba(118, 118, 118, 0);
            border-top-color: #000;
            border-width: 6px;
            left: 50%;
            margin-left: -6px;
        }

        .bottom .ui-tooltip-content::before {
            border-color: rgba(118, 118, 118, 0);
            border-top-color: #000;
            border-width: 6px;
            left: 50%;
            margin-left: -6px;
        }

        .top .ui-tooltip-content::after {
            top: -6px;
            left: 50%;
            border-bottom-color: #000;
            border-width: 0 6px 6px;
            margin-left: -6px;
        }

        .top .ui-tooltip-content::before {
            border-color: rgba(118, 118, 118, 0);
            border-bottom-color: #000;
            top: -6px;
            left: 50%;
            border-width: 0 6px 6px;
            margin-left: -6px;
        }

        /* Added Ankush On 25/07/2018 In Pagination*/

        .pagination > li > a, .pagination > li > span {
            text-decoration: none;
            border: none !important;
            border-radius: 20px;
            color: #1bb4c7 !important;
        }

        .pagination > .active > a {
            background-color: #1bb4c7 !important;
            color: #fff !important;
        }

        .pagination > li > a:hover {
            color: #fff !important;
            text-decoration: none;
            background-color: #1bb4c7 !important;
            border: none !important;
            border-radius: 20px;
        }

        #tblShowSubUserStory_previous {
            display: none !important;
        }

        #tblShowSubUserStory_next {
            display: none !important;
        }

        #tblTaskDetails_previous {
            display: none !important;
        }

        #tblTaskDetails_next {
            display: none !important;
        }

        #tblIssueDetails_previous {
            display: none !important;
        }

        #tblIssueDetails_next {
            display: none !important;
        }

        #tblReviewList_previous {
            display: none !important;
        }

        #tblReviewList_next {
            display: none !important;
        }

        #tblHistoryList_previous {
            display: none !important;
        }

        #tblHistoryList_next {
            display: none !important;
        }


        .pagination-sm .page-item:first-child .page-link {
            border-top-left-radius: .2rem;
            border-bottom-left-radius: .2rem;
        }

        .pagination-sm .page-item:last-child .page-link {
            border-top-right-radius: .2rem;
            border-bottom-right-radius: .2rem;
        }

        #myTab {
            padding-left: 24px !important;
            /*background-color: #0288D1 !important;*/
            width: auto;
            padding-bottom: 1px !important;
            padding-top: 0px;
            margin-left: 0PX !important;
            margin-right: -2PX !important;
        }

            #myTab li {
                /*padding-left: 9px !important;*/
                float: left !important;
            }

        /*@media screen and (min-device-width: 662px) and (max-device-width: 1366px) { 
  
     .container {
            width: 1421px !important;
        }
}*/
        .input-group-btn:last-child > .btn, .input-group-btn:last-child > .btn-group {
            z-index: 0 !important;
            margin-left: -1px;
        }

        .btn.btn-info {
            margin-right: 7px;
        }

        #spnissue + .ui-tooltip {
            margin-left: 100px !important;
        }

        /*.tooltip > span {
            left: 20px !important;
        }*/
        #txtSRDescription {
            resize: none;
        }

        #divdetails .form-group{display:flex}
        .media-body{display:flow-root}
        .nav-pills>li>a.active, .nav-pills>li>a:focus, .nav-pills>li>a:hover {
    color: #fff;
    background-color: #337ab7;
}
        .nav-pills>li>a {
    border-radius: 4px;
}
        .nav>li>a {
    position: relative;
    display: block;
    /* padding: 10px 15px; */
    padding: 10px;
    text-decoration:none
}
        .nav>li>a:focus, .nav>li>a:hover {
    text-decoration: none;
    background-color: #eee;
    color: #337ab7;
}
        .clsDiscussion{margin-top:20px}
    
        #SprintlistUL{display:contents!important}
        #divSprintdetails {
    overflow: auto;
    height: 220px;
}
        * {
    font-family: 'helvetica !important';
}
        .fa, .fas {
    font-family: 'Font Awesome 5 Free'!important;
    font-weight: 900;
}
/* Added By Gauri On 02nd Sep 2024 For Alignment Issue */
.form-row {
    display: block;
}
@media only screen and (min-width: 992px) and (max-width: 1240px){
    #search_table, #SearchTask, #searchIssue, #Search_Review, #Search_History{
        margin-top: 0;
    }
    .btn-search {
        padding: 8px;
    }
}
.form-control{
    padding: 4px 12px !important;
}
a.nav-link{
    color: #0d6efd !important;
}
/* End of Added By Gauri On 02nd Sep 2024 For Alignment Issue */

/* Added By Gauri On 04th Sep 2024 For Alignment Issue */
.ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next,
.ui-datepicker .ui-datepicker-prev:hover, .ui-datepicker .ui-datepicker-next:hover {
    top: unset;
    bottom: 5px;
}
.ui-datepicker table {
    border-collapse: separate;
}
.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
    border: 1px solid rgb(197, 197, 197) !important;
    background: rgb(246, 246, 246);
    font-weight: normal;
    color: rgb(69, 69, 69);
}
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
    border: 1px solid rgb(0, 62, 255);
    background: rgb(0, 127, 255) !important;
    color: rgb(255, 255, 255);
}
@media (min-width: 992px){
    .container {
        max-width: 1000px;
    }
}
/* End of Added By Gauri On 04th Sep 2024 For Alignment Issue */

    </style>
</head>
<body>
    <form id="frmSprintDetails" runat="server">
        <div>
            <div class="container" style="margin-top: 10px;">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="first-row">
                            <div class="row">
                            <div class=" col-lg-1 col-md-1  col-sm-1  ">
                                <div class="dropdown">
                                    <div data-bs-toggle="dropdown" aria-expanded="true">
                                        <i title="Select Sprint" style="font-size: 14px!important; color: grey; cursor: pointer; margin-left: 15px;" class="fa fa-bars"></i>
                                        <div class="tooltip fade bottom in" role="tooltip" id="tooltip431875" style="top: 17px; left: -17.6406px; display: block;">
                                            <!-- 	<div class="tooltip-arrow" style="left: 50%;"></div> -->
                                            <!-- 		<div class="tooltip-inner">Select Sprint</div> -->
                                        </div>
                                    </div>

                                    <div class="dropdown-menu" id="filter-dropdown" role="menu">
                                        <div id="tblAdvHeader">
                                            <div class="row">
                                                <div class="col-sm-10">
                                                    <p class="grey-text" style="float: left; margin-left: 5%!important">Select Sprint</p>


                                                </div>
                                                <div class="col-sm-2">
                                                    <i class="fas fa-times" style="font-size: 14px!important; color: grey!important; cursor: pointer" onclick="clear_onclick()"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="dropdown-content">
                                            <p style="float: right; font-size: 12px; margin-top: -15px;"><i class=' fa fa-star current-release-icon' aria-hidden=' true' style='color: #ff8c00; margin-right: 4px;' data-bs-original-title='' title=''></i>Current Sprint </p>
                                            <input type="text" name="txtSprint" id="txtSprint" class="form-control" style="text-align: Left" value="" onkeyup="filterFunction()" onblur="clear_onclick()" data-bs-toggle="dropdown" placeholder="Search" />
                                            <div class="row">
                                                <div class="col-md-12" id="divSprintdetails">
                                                    <%-- <div id="divsprintUL">	--%>
                                                    <ul id="SprintlistUL" class="dropdown-menu" role="menu" style="display: block">

                                                        <%-- <li class="clsAssignedListItem dropdown-item" name="d"><a href="#" id="5850" name="d" onclick="AssignToListClick(this)">d</a></li>
                                                             <li class="clsAssignedListItem dropdown-item" name="dd"><a href="#" id="A8" name="dd" onclick="AssignToListClick(this)">dd</a></li>
                                                             <li class="clsAssignedListItem dropdown-item" name="dd"><a href="#" id="5865" name="dd" onclick="AssignToListClick(this)">dd</a></li>--%>
                                                    </ul>
                                                    <%--</div> --%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="  col-lg-6  col-md-6  col-sm-6 ">
                                <div class="sprint-header">
                                    <label id="lblSprintName" title="Sprint name" class="sprint-name" style="font-size: 14px; font-weight: 100; white-space: pre-wrap !important; word-wrap: break-word !important;"></label>
                                </div>
                            </div>
                    <div class="col-sm-5" style="display: inline-flex; float: right; margin-right: -12px;margin-left:auto;justify-content:end">
                        <div class=" ">
                            <%-- margin-left: 45px;"--%>
                            <input type="button" class="btn btn-info" onclick="Back_click()" name="Back" style="margin-left: 20px;" value="Back" title="Go To Previous Page" />
                        </div>
                        <div class="  " style="">
                            <%--style="margin-left: -28px;"--%>

                            <div class="dropdown">
                                <div class="btn btn-info" data-bs-toggle='dropdown'>Export&nbsp;<i class="fa fa-download" title="Export"></i> | <i class='fa fa-sort-down' title="Export"></i></div>
                                <div class="tooltip fade bottom in" role="tooltip" id="tooltip378543" style="top: 34px; left: 510.18px; display: block;">
                                    <div class="tooltip-arrow" style="left: 50%;">
                                    </div>

                                    <div class="tooltip-inner">Export</div>

                                </div>
                                <ul class="dropdown-menu" id="uldropdown">
                                    <li><a onclick="Export_ExcelClick() ">Excel</a></li>
                                    <li><a onclick="Export_PDFClick()">PDF</a></li>
                                </ul>

                            </div>

                        </div>
                        <div class="  " style="">
                            <%--float:right;margin-right: 17px;"--%>

                            <div class="btn btn-info" id="divsprintstatus"><span id="divstatus" style="text-align: right"></span>&nbsp;</div>
                            <%--style="margin-left:15px;" <i class="fa fa-spinner"></i>--%>
                        </div>
                    </div>
                                </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-5">
                    <%--<section class="main">--%>
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="row">
                            <div class="col-md-3">
                                <label id="lblstartdate" style="color: rgb(38, 152, 226); white-space: nowrap!important; font-weight: 100; margin-left: -13px; margin-top: 9px;" title="Start Date"></label>
                                -
     <label id="lblenddate" style="color: rgb(38, 152, 226); white-space: nowrap!important; font-weight: 100;" title="End Date"></label>
                            </div>
                            <div class="col-md-2" style="margin-left: -141px;">
                                <label id="lblstorypoints" style="color: #f2620f; margin-left: 57px; font-size: 16px; font-weight: 100 !important; margin-top: -5px;" title="Story points"></label>
                            </div>
                            <div class="col-md-1" id="divefforts" style="margin-left: -55px;">

                                <%--<p style="white-space:nowrap!important;" > 
<label id="planefforts" class="" style="background-color: blue;
    color: white;
    padding: 3px;
    font-size: 14px;
    font-weight: 600;
    padding-left: -20px;"
     data-bs-toggle='tooltip' data-bs-placement="bottom"
     title="Plan Efforts"></label>
  <label id="actualefforts" class="" style="padding: 3px;
    margin-left: -4px;
    background-color: red;
    color: white;
    font-weight: 600;
    font-size: 14px;"
       data-bs-toggle='tooltip' data-bs-placement="bottom"
     title="Actual Efforts"></label>
    </p>--%>
                            </div>
                            <%-- Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes --%>
                            <%--  <div class="col-md-2" style="margin-left: 25px;">--%>
                            <div class="col-md-2" style="margin-left: 10%;">
                                <%-- End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes --%>
                                <p>
                                    <label id="taskcount" class="nowrap" style="color: crimson; font-size: 22px; font-weight: 100; margin-top: -7px;" title="Task Not in control"></label>
                                    <label style="font-size: 11px; font-weight: 100; width: 50px;">Task not in control</label>
                                </p>
                            </div>
                            <div class="col-md-2" style="margin-left: -70px;">
                                <p>
                                    <label id="issuecount" class="nowrap" style="color: black; font-size: 22px; font-weight: 100; margin-top: -7px;" title="Issues"></label>
                                    <label style="font-size: 11px; font-weight: 100; vertical-align: 8px;">Issues</label>
                                </p>
                            </div>
                            <div class="col-md-2" style="margin-left: -97px;">
                                <p>
                                    <label id="issuedone" class="nowrap" style="color: #00a65a; font-size: 22px; font-weight: 100; margin-top: -7px;" title="Issues Done"></label>
                                    <label style="font-size: 11px; font-weight: 100; width: 50px;">Issues Done</label>
                                </p>
                            </div>
                            <div class="col-md-2" style="margin-left: -82px;">
                                <p>
                                    <label id="issueinprogress" class="nowrap" style="color: #FFCA28; font-size: 22px; font-weight: 100; margin-top: -7px;" title="Issues In Progress"></label>
                                    <label style="font-size: 11px; font-weight: 100; width: 50px;">Issues In Progress</label>
                                </p>
                            </div>
                            <div class="col-md-5" style="margin-right: -537px; margin-left: -75px;">
                                <p>
                                    <label id="issuetodo" class="nowrap" style="color: rgb(38, 152, 226); font-size: 22px; font-weight: 100; margin-top: -7px;" title="Issues To-do"></label>
                                    <label style="font-size: 11px; font-weight: 100; width: 30px;">Issues To-do</label>

                                    <label id="lblNoOfDays" style="font-size: 14px; color: black; font-weight: 100; white-space: nowrap; margin-left: 15px" title="Remaining Days"></label>
                              <%-- Commented And added By Usha Pandit On 02.07.2019 For not showing days remaining --%>
                                    <%--<label style="font-size: 9px; font-weight: 100; width: 69px; vertical-align: 2px;">days remaining</label>--%>
                                    <label style="font-size: 9px; font-weight: 100; width: 69px; vertical-align: 2px;">Day(s) </label>
                                   <%-- End Of Added By Usha Pandit On 02.07.2019 For not showing days remaining --%>
                                </p>


                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-11" id="progressbar">
                        <%--<div class="progress active" >
   <div id="progressDays" class="progress-bar bg-success progress-bar-striped" style="width:70%;background-color: rgb(31, 191, 38);">
     
    </div>
    <div id="progressDayss"  class="progress-bar bg-warning progress-bar-striped" style="width:30%;background-color: #337ab7;">
    
    </div>
    
     </div>--%>
                    </div>
                    <div class="col-md-1" id="Days" style="margin-top: -20px;">
                        <%--<span id="spnNoOfDays" class=" btn btn-success"  style="font-size: 14px; color:#fff; font-weight: 600;white-space:nowrap;" data-bs-toggle='tooltip' data-bs-placement="bottom" title="Days left"></span>--%>
                    </div>
                </div>

                <div class="row">
                    <%--style="height: 800px;"--%>
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#SprintDetails" role="tab" aria-controls="home" aria-selected="true">Details</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#Charts" role="tab" aria-controls="profile" aria-selected="false">Charts</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#UserStories" role="tab" aria-controls="contact" aria-selected="false">User Stories</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A1" data-bs-toggle="tab" href="#Teams" role="tab" aria-controls="contact" aria-selected="false">Teams</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A2" data-bs-toggle="tab" href="#Tasks" role="tab" aria-controls="contact" aria-selected="false">Tasks</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A3" data-bs-toggle="tab" href="#Issues" role="tab" aria-controls="contact" aria-selected="false">Issues</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A4" data-bs-toggle="tab" href="#Discussions" role="tab" aria-controls="contact" aria-selected="false">Discussions</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A5" data-bs-toggle="tab" href="#Reviews" role="tab" aria-controls="contact" aria-selected="false">Reviews</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A6" data-bs-toggle="tab" href="#History" role="tab" aria-controls="contact" aria-selected="false">History</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="A7" data-bs-toggle="tab" href="#Attachments" role="tab" aria-controls="contact" aria-selected="false">Attachments</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">

                       <%-- Added & Commented By Dipali V On 28th Jan 2023 For Details should display by default--%>
                        <%--<div class="tab-pane fade active in" id="SprintDetails" role="tabpanel" aria-labelledby="home-tab">--%>
                        <div class="tab-pane fade active show" id="SprintDetails" role="tabpanel" aria-labelledby="home-tab">
                            <%-- End of Added & Commented By Dipali V On 28th Jan 2023 For Details should display by default--%>
                            <div id="divdetails">
                                <div class="detail" style="width: 95%;">
                                    <div id="div_details" class="activecls">
                                        <h2 class=" clsDiscussion clsDiscussion_border_bottom">Sprint Details</h2>
                                        <div class="form-row">
                                            <div class="">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 4px;">Sprint Name<span class="required"> *</span></label>
                                                    <div class="col-md-10">
                                                        <%-- <input type="text" name="txtSRName" id="txtSRName" class="form-control textbox" style=" text-align:Left ; BACKGROUND-COLOR:""; maxlength="100";  onkeyup="ClearSpan('txtSRName','spanSRName')"/>--%>
                                                        <%CommonFunctions.HTMLControls.DrawTextBox("txtSRName", "txtSRName", "form-control", , 100, IterationName, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSRName','spanSRName')", , , , , , , )%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="">
                                                <div class="form-group">
                                                    <label class="col-md-2 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 5px;">Description</label>
                                                    <div class="col-md-10">
                                                        <%--  <textarea wrap="Soft" name="txtSRDescription" id="txtSRDescription" class="form-control" style="height: auto !important"  onkeyup="javascript:AutoGrowTextArea();" onchange="ClearSpan('txtSRDescription','spanSRDescription')" rows="5"></textarea>--%>
                                                        <% CommonFunctions.HTMLControls.DrawTextArea("txtSRDescription", "txtSRDescription", , "form-control", , , , , , , , Description, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup='javascript:limitText(this,countDown,1000)' maxLength=1000 onchange='javascript:ClearSpan(&quot;txtSRDescription&quot;,&quot;spanSRDescription&quot;)' data-autoresize ", , )%>
                                                        <p id="countDown"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class="col-md-4 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 8px;" data-bs-original-title="Start Date">Start Date<span class="required" data-bs-original-title=""> *</span></label>
                                                <div class="col-md-8">
                                                    <%--  <input type="text" name="txtSRStartDate" id="txtSRStartDate" class="form-control textbox hasDatepicker" style="  text-align:Left ; BACKGROUND-COLOR: "  maxlength="100" onkeyup="ClearSpan('txtSRStartDate','spanStartDate')"/> --%>
                                                 <%--Commented and Added by Usha Pandit on 30.04.2019 for setting Output Date Format for Sprint Start Date--%>
                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtSRStartDate", "txtSRStartDate", "form-control", , 100, SprintStartDate, , "margin-top: 4px;", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSRStartDate','spanSRName')", , , , , , , )%>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSRStartDate", "txtSRStartDate", "form-control", , 100, CommonFunctions.Dates.CGetDate(CType(SprintStartDate, Date)), , "margin-top: 4px;", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSRStartDate','spanSRName')", , , , , , , )%>
                                                   <%--End of Added by Usha Pandit on 30.04.2019 for setting Output Date Format for Sprint Start Date--%>
                                                    <i class="far fa-calendar-check" aria-hidden="true" style="font-size: 14px; margin-top: -41px; float: right; color: #0099CC;" id="SRdpd1"></i>
                                                </div>
                                            </div>
                                                </div>
                                            <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class="col-md-4 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 8px;">End Date<span class="required" data-bs-original-title=""> *</span></label>
                                                <div class="col-md-8">
                                                    <%-- <input type="text" name="txtSREndDate" id="txtSREndDate" class="form-control textbox hasDatepicker" style="text-align:Left ; BACKGROUND-COLOR: "maxlength="100" onkeyup="ClearSpan('txtSREndDate','spanEndDate')"/> --%>
                                                   <%--Commented and Added by Usha Pandit on 30.04.2019 for setting Output Date Format for Sprint End Date--%>
                                                    <% 'CommonFunctions.HTMLControls.DrawTextBox("txtSREndDate", "txtSREndDate", "form-control", , 100, SprintEndDate, , "margin-top: 4px;", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSREndDate','spanSRName')", , , , , , , )%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSREndDate", "txtSREndDate", "form-control", , 100, CommonFunctions.Dates.CGetDate(CType(SprintEndDate, Date)), , "margin-top: 4px;", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSREndDate','spanSRName')", , , , , , , )%>
                                                   <%--End of Added by Usha Pandit on 30.04.2019 for setting Output Date Format for Sprint End Date--%>
                                                    <i class="far fa-calendar-check" aria-hidden="true" style="font-size: 14px; margin-top: -41px; float: right; color: #0099CC;" id="SRdpd2"></i>
                                                </div>
                                            </div>
                                                </div>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="">
                                            
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class="col-md-4 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 5px;" data-bs-original-title="Calendar Day">Calendar Day's Duration</label>
                                                <div class="col-md-8">
                                                    <%--<input type="text" name="txtSRCalendersDuration" id="txtSRCalendersDuration" class="form-control textbox" style=" text-align:Left ; BACKGROUND-COLOR:"";maxlength="100" onkeyup="ClearSpan('txtSRCalendersDuration','spanCalenderDuration')"/>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSRCalendersDuration", "txtSRCalendersDuration", "form-control", , 100, SprintDuration, , "", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSRCalendersDuration','spanSRName')", , , , , , , )%>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            
                                            <div class="form-group">
                                                <label class="col-md-4 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 5px;" data-bs-original-title="Business Day">Business Day's Duration</label>
                                                <div class="col-md-8">
                                                    <%--<input type="text" name="txtSRBusinessDuration" id="txtSRBusinessDuration" class="form-control textbox" style="text-align:Left ; BACKGROUND-COLOR:""; maxlength="100" onkeyup="ClearSpan('txtSRBusinessDuration','spanBusinessDuration')"/>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSRBusinessDuration", "txtSRBusinessDuration", "form-control", , 100, BusinessDuration, , "", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSRBusinessDuration','spanSRName')", , , , , , , )%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class="col-md-4 control-label" style="white-space: nowrap; font-weight: 100; margin-top: 5px;">Efforts<span class="required" data-bs-original-title="" title=""> *</span></label>
                                                <div class="col-md-6">
                                                    <%--<input type="text" name="txtSREfforts" id="txtSREfforts" class="form-control textbox" style=" text-align:Left ; BACKGROUND-COLOR:""; maxlength="100"  onkeyup="ClearSpan('txtSREfforts','spanSREfforts')"/>--%>

                                                    <%--Commented and Added by Usha Pandit on 01-March-2019 Purpose::Whizible 2 Work field change--%>
                                                    <%--CommonFunctions.HTMLControls.DrawTextBox("txtSREfforts", "txtSREfforts", "form-control", , 100, SprintVelocity, , " margin-left: 5px;", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSREfforts','spanSRName')", , , , , , , )--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSREfforts", "txtSREfforts", "form-control", , 100, HMSprintVelocity, , " ", , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup = ClearSpan('txtSREfforts','spanSRName')", , , , , , , )%>
                                                    <%--End of Added by Usha Pandit on 01-March-2019 Purpose::Whizible 2 Work field change--%>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                    <div class="col-md-1 float-end" id="btnupdSprint">

                                        <%--  <button type="button" class="btn btn-info" onclick="Update_OnClick()" data-bs-toggle="tooltip" data-bs-placement="bottom" id="updateSprintRelease" data-bs-original-title="" title="Update">Update</button>--%>
                                    </div>
                                        </div>
                                    </div>
                                    <br />

                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="Charts" role="tabpanel" aria-labelledby="profile-tab">
                            <h3 class="clsDiscussion">Charts</h3>
                            <div class="container" id="divcontainerBurn">
                                <div class="row">
                                <nav class='col-sm-2 col-sm-2' id='myScrollspy' style='width: 16%!important;'>
                                    <ul class="nav nav-pills nav-stacked">
                                        <li><a href="#BurnDown" class="active">Burn Down</a></li>
                                        <li><a href="#BurnUp">Burn Up</a></li>
                                        <%-- <li><a href="#Velocity">Velocity</a></li>--%>
                                    </ul>
                                </nav>
                                <div class="col-md-10 scrollspy-example" id="divBurnupdown" data-spy="scroll" data-bs-target="#myScrollspy" data-offset="5">

                                    <div id="BurnDown" class="tabcontentChart">

                                        <h4 class="ClsHeaderGraph">Burn Down</h4>
                                        <div class='divLineGraph' style='width: 100% !important; height: 547px'>
                                            <canvas id="BurnDownGraph" width="400" height="250"></canvas>
                                        </div>
                                    </div>
                                    <div class="tabcontentChart ">

                                        <h4 class="ClsHeaderGraph">Burn Down</h4>
                                        <div class='divLineGraph' style='width: 100% !important; height: 547px'>
                                            <canvas id="BurnUpGraph" width="400" height="250"></canvas>
                                        </div>
                                    </div>


                                    <div id="BurnUp" class="tabcontentChart">

                                        <h4 class="ClsHeaderGraph">Burn Up</h4>
                                        <div class='divLineGraph' style='width: 100% !important; height: 547px'>
                                            <canvas id="BurnupGraphEfforts" width="800" height="450"></canvas>
                                        </div>
                                    </div>
                                    <div class="tabcontentChart ">
                                        <%-- tab-pane--%>
                                        <h4 class="ClsHeaderGraph">Burn Up</h4>
                                        <div class='divLineGraph' style='width: 100% !important; height: 547px'>
                                            <canvas id="BurnupGraphStoryPoints" width="400" height="250"></canvas>
                                        </div>
                                    </div>


                                    <%--<div id="Velocity" class="tabcontentChart">
                                         <h4 class="ClsHeaderGraph">Velocity Efforts</h4>
                                        <div class='divLineGraph' style='width: 100% !important; height: 547px'>
                                            <canvas id="VelocityEffortBar" width="800" height="450"></canvas>
                                        </div>
                                      
                                    </div>
                                    <div class="tabcontentChart ">
                                       
                                       

                                          <h4 class="ClsHeaderGraph">Velocity Story points</h4>
                                        <div class='divLineGraph' style='width: 100% !important; height: 547px'>
                                            <canvas id="VelocitySToryPoints" width="400" height="250"></canvas>
                                        </div>
                                    </div>--%>
                                </div>
                                    </div>
                            </div>


                        </div>


                        <div class="tab-pane fade" id="UserStories" role="tabpanel" aria-labelledby="contact-tab">
                            <h3 class="clsDiscussion">User stories Details</h3>
                            <div id="divuserstory">
                                <div id="divuserstoryList">
                                    <div class="row">
                                        <div class="col-md-9">
                                        </div>
                                        <div class="col-md-3" style="margin-left: -8px;">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="search_table" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important; height: 34px !important;" onblur="clear_click()" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-search btn-info" type="button" style="color: white; height: auto;">Go!</button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <table id="tblShowSubUserStory" class="table table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>User Story</th>
                                                <th>Description</th>
                                                <th>Story Points</th>
                                                <th>Status</th>

                                            </tr>
                                        </thead>
                                        <%-- <tbody>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
         <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
           <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
              
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            
          
        </tbody>--%>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <div class="tab-pane fade" id="Teams" role="tabpanel" aria-labelledby="contact-tab">

                            <h3 class="clsDiscussion">Sprint Teams</h3>
                            <div class="row" id="mainDivTeams">
                                <%--<div class="col-md-6">
<div class="col-sm-11 col-sm-11 sprint_card team_cards"><div class=""><div class="col-md-2 col-sm-2 col-sm-12 discussionbox"><span class="chat-img float-start" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Employee Image"><img alt="User Avatar" class="img-circle"  style="height:50px;width:50px;" src="no-photo.png"></span></div><div class="col-md-10 col-sm-10 col-sm-12"><p class="ClsTeamDetails"><span data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Employee Name"> Mahajan</span> | <label class="ClsRole" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" data-bs-original-title="PROJECT CO-ORDINATOR">PROJECT CO... </label></p><p class="ResourcePercentage"><span data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Resource Percentage">11 % Allocation</span> </p><div class="progress" style="width:80%;"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0.00" aria-valuemin="0" aria-valuemax="100" style="width:0.00%"></div></div><span class="label label-primary" style="float: right;margin-top: -38px;margin-right: 3px;border-radius:10px;" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Task Completion Percentage">0.00%</span><br></div></div></div>
</div>
                                    <div class="col-md-6">
<div class="col-sm-11 col-sm-11 sprint_card team_cards"><div class=""><div class="col-md-2 col-sm-2 col-sm-12 discussionbox"><span class="chat-img float-start" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Employee Image"><img alt="User Avatar" class="img-circle" onerror="this.src='../../Images/Photo/no-photo.png'" style="height:50px;width:50px;" src="../../Images/Photo/no-photo.png"></span></div><div class="col-md-10 col-sm-10 col-sm-12"><p class="ClsTeamDetails"><span data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Employee Name"> Mahajan</span> | <label class="ClsRole" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" data-bs-original-title="PROJECT CO-ORDINATOR">PROJECT CO... </label></p><p class="ResourcePercentage"><span data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Resource Percentage">11 % Allocation</span> </p><div class="progress" style="width:80%;"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0.00" aria-valuemin="0" aria-valuemax="100" style="width:0.00%"></div></div><span class="label label-primary" style="float: right;margin-top: -38px;margin-right: 3px;border-radius:10px;" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Task Completion Percentage">0.00%</span><br></div></div></div>
                                      </div>--%>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="Tasks" role="tabpanel" aria-labelledby="contact-tab">


                            <h3 class="clsDiscussion">Tasks Details</h3>
                            <div id="divTask">
                                <div id="divTaskList">
                                    <div class="row">
                                        <div class="col-md-9">
                                        </div>
                                        <div class="col-md-3" style="margin-left: -8px;">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="SearchTask" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important; height: 34px !important;" onblur="clear_click()" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-search btn-info" type="button" style="color: white; height: auto;">Go!</button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <table id="tblTaskDetails" class="table table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>Task Name</th>
                                                <th>Assigned To</th>
                                                <th>Planned/Actual</th>
                                                <th>Status</th>
                                                <th>User Story</th>
                                            </tr>

                                        </thead>

                                        <%--        <tbody>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
         <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
           <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            
          
        </tbody>--%>
                                    </table>

                                </div>
                            </div>


                        </div>
                        <div class="tab-pane fade" id="Issues" role="tabpanel" aria-labelledby="contact-tab">

                            <h3 class="clsDiscussion">Issues Details</h3>
                            <div id="divIssue">
                                <div id="divIssueList">
                                    <div class="row">
                                        <div class="col-md-9">
                                        </div>
                                        <div class="col-md-3" style="margin-left: -8px;">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="searchIssue" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important; height: 34px !important;" onblur="clear_click()" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-search btn-info" type="button" style="color: white; height: auto;">Go!</button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <table id="tblIssueDetails" class="table table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>Flag</th>
                                                <th>Issue ID</th>
                                                <th>Reported Date</th>
                                                <th>Type</th>
                                                <th>User Story</th>
                                                <th>Summary</th>
                                            </tr>
                                        </thead>
                                        <%--     <tbody>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                 <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
                 <td>
                  
                Description
                </td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
                 <td>
                  
                Description
                </td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
         <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
                 <td>
                  
                Description
                </td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
                 <td>
                  
                Description
                </td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
           <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
                 <td>
                  
                Description
                </td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
                 <td>
                  
                Description
                </td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            
          
        </tbody>--%>
                                    </table>

                                </div>
                            </div>


                        </div>
                        <div class="tab-pane fade" id="Discussions" role="tabpanel" aria-labelledby="contact-tab">

                            <h2 class="clsDiscussion">Discussions</h2>
                            <div class="row" id="MainDiscussions">
                                <div class="col-md-5" id="mainDivDisscussion">
                                    <%--   <div class="feed-element">
                                                    <a href="profile.html" class="float-start">
                                                       <img src="../../Images/Photo/05774f3a.jpg" onerror="this.src='../../Images/Photo/no-photo.png'" data-bs-toggle="tooltip" title="" data-bs-original-title="Sa - SOFTWARE ENGINEER TEAM MEMBER" aria-describedby="tooltip753350">
                                                    </a>
                                                    <div class="media-body ">
                                                        <small class="float-end text-navy">1m ago</small>
                                                        <strong>Mark Johnson</strong>
                                                      <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been </p>
                                                     <p id="more_data" style="display: none">Here is some text that I want added to the HTML file</p>

                                                        <a id="seeMore" onclick="toggleSeeMore()" href="javascript:void(0);">See More</a>
                                                    <p></p>
                                                        <small class="text-muted">Today 2:10 pm - 12.06.2014</small>
                                                            <a class="btn btn-xs btn-white" onclick=" Placeholder()" style="font-size: 12px;"><i class="fa fa-reply"></i> Reply </a>
                                                       
                                                    </div>
                                                </div>
                                       <div class="feed-element">
                                      <div class="right">
									<span class="date-time">5m ago</span>
								
									<a href="javascript:;" class="image float-end"> <img alt="User Avatar" class="img-circle" onerror="this.src='../../Images/Photo/no-photo.png'"  src="../../Images/Photo/7f400d80.JPG"></a>
									<strong class="name">John Smith&nbsp;&nbsp;</strong>
                                          <div class="message">
									Lorem Ipsum is simply dummy text of the printing.
									</div>  <div class="row">
                                             <div class="col-md-4">  </div>
                                  <div class="col-md-6">
                                        <small class="text-muted">Today 2:10 pm - 12.06.2014</small>
                                          <a class="btn btn-xs btn-white" onclick=" Placeholder()"style="font-size: 12px;"><i class="fa fa-reply"></i> Reply </a>
                                  
                                          	<div class="clearfix"> </div>	           </div>    </div>  

								</div></div>

                                        <div class="feed-element">
                                                    <a href="profile.html" class="float-start">
                                                       <img src="../../Images/Photo/05774f3a.jpg" onerror="this.src='../../Images/Photo/no-photo.png'" data-bs-toggle="tooltip" title="" data-bs-original-title="Sa - SOFTWARE ENGINEER TEAM MEMBER" aria-describedby="tooltip753350">
                                                    </a>
                                                    <div class="media-body ">
                                                        <small class="float-end">2h ago</small>
                                                        <strong>Mark Johnson</strong>
                                                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been. </p>
                                                     
                                                        <small class="text-muted">Today 2:10 pm - 12.06.2014</small>
                                                            <a class="btn btn-xs btn-white" onclick=" Placeholder()" style="font-size: 12px;"><i class="fa fa-reply"></i> Reply </a>
                                                        
                                                    </div>
                                                </div>--%>
                                </div>


                                <div class="col-md-6">
                                    <div class="widget-area no-padding blank" style="margin-top: 83px;">
                                        <div class="status-upload">
                                            <%-- Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478 --%>
                                            <%--<textarea placeholder="Post New Discussion" id="DiscussionTextArea" style="padding: 20px; border: 2px solid #ddd; width: 100%; height: 80px; overflow: auto; color: gray; resize: none;"></textarea>--%>
                                            <textarea placeholder="Post New Discussion" id="DiscussionTextArea" maxlength="2000" style="padding: 20px; border: 2px solid #ddd; width: 100%; height: 80px; overflow: auto; color: gray; resize: none;"></textarea>
                                            <%-- //End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478 --%>
                                            <form class="form-inline">

                                                <!-- Added By Gauri On 02nd Sep 2024 For Alignment Issue -->
                                                <!-- <button class="btn btn-primary float-end" onclick="AddNewDiscussion()" id="post_discuss" type="button" style="background-color: #22af81; border-color: #22af81; font-weight: 600; margin-top: 5px" title="Post">Post</button> -->
                                                <!-- End of Added By Gauri On 02nd Sep 2024 For Alignment Issue -->
                                                <button class="btn text-light float-end" onclick="AddNewDiscussion()" id="post_discuss" type="button" style="background-color: #22af81; border-color: #22af81; font-weight: 600; margin-top: 5px" title="Post">Post</button>
                                            </form>

                                        </div>
                                    </div>


                                </div>
                            </div>


                        </div>
                        <div class="tab-pane fade" id="Reviews" role="tabpanel" aria-labelledby="contact-tab">


                            <h3 class="clsDiscussion">Reviews Details</h3>
                            <div id="divReview">
                                <div id="divReviewList">
                                    <div class="row">
                                        <div class="col-md-9">
                                        </div>
                                        <div class="col-md-3" style="margin-left: -8px;">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="Search_Review" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important; height: 34px !important;" onblur="clear_click()" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-search btn-info" type="button" style="color: white; height: auto;">Go!</button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <table id="tblReviewList" class="table table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>Review Date</th>
                                                <th>User Story</th>
                                                <th>Status</th>
                                                <th>Review Title</th>
                                                <%--Commented and Added by Usha Pandit on 22.04.2019 for caption change--%>
                                                <%--<th>Review By</th>--%>
                                                <th>Reviewer</th>
                                                <%--End of Added by Usha Pandit on 22.04.2019 for caption change--%>
                                                <th>Reviewee</th>
                                            </tr>
                                        </thead>
                                        <%--<tbody>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
         <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
           <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            
          
        </tbody>--%>
                                    </table>


                                </div>
                            </div>


                        </div>
                        <div class="tab-pane fade" id="History" role="tabpanel" aria-labelledby="contact-tab">

                            <h3 class="clsDiscussion">History Details</h3>
                            <div id="divHistory">
                                <div id="divHistoryList">
                                    <div class="row">
                                        <div class="col-md-9">
                                        </div>
                                        <div class="col-md-3" style="margin-left: -8px;">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="Search_History" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important; height: 34px !important;" onblur="clear_click()" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-search btn-info" type="button" style="color: white; height: auto;">Go!</button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <table id="tblHistoryList" class="table table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Modified By</th>
                                                <th>Field Name</th>
                                                <th>Old Value</th>
                                                <th>New Value</th>
                                            </tr>
                                        </thead>
                                        <%--<tbody>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
         <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
           <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            <tr>
                <td>6/1/2018 10:45:21 AM</td>
                <td>Vaishnavi.Gujar504</td>
               <td>
                  
                Description
                </td>
                <td>
                  
                Description
                </td>
                <td>Description Description Description</td>
                  </tr>
            
          
        </tbody>--%>
                                    </table>


                                </div>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="Attachments" role="tabpanel" aria-labelledby="contact-tab">
                            <h3 class="clsDiscussion">Attachments</h3>

                            <div id="Attachmentus">
                                <div class="row">
                                    <div class="col-md-8" id="divDropZone">

                                          <div class="demo-droppable"  id="">
                                  <p >Drop files here Or click to upload.</p>
                                  <input type="file" multiple="multiple"  style="display: none;"/>
                                  </div>
                                    </div>
                                    <div class="col-md-4" style="margin-top: 28px;">
                                        <a class="btn btn-info d-flex align-items-center" onclick="Upload_Click()" title="Upload File" style="width: 30%; height: 38px;"><i class="fa fa-upload"></i>Upload</a>
                                        <div id="listattachment"></div>
                                    </div>
                                </div>


                            </div>
                            <br />
                            <div class="row" id="DivAttachments">
                                <div class="col-md-12" id="mainDivAttachments">

                                    <%--       <div class="activity-row" id="Div5" 853="" style="">
             <div class="row">
                  <div class="col-md-3">
             <div class="form-group">
      <p  class="upload-header">Document Name(latest)</p>
      <p class="attach-details" style="text-decoration:underline;">Agile Issues(Upload)</p>
  </div>  </div>
                    <div class="col-md-3">
             <div class="form-group">
     <p  class="upload-header">Upload Date</p>
     <p class="attach-details">07-june-2018</p>
  </div> </div>
                    <div class="col-md-3">
             <div class="form-group">
    <p  class="upload-header">Size(KB)</p>
       <p  class="attach-details">2</p>
  </div>  </div>

                           <div class="col-md-2">
             <div class="form-group">
     <p  class="upload-header">Upload By</p>
      <div> <img src="../../Images/Photo/05774f3a.jpg" onerror="this.src='../../Images/Photo/no-photo.png'" data-bs-toggle="tooltip" title="" data-bs-original-title="Sa - SOFTWARE ENGINEER TEAM MEMBER"></div>

  </div>  </div>
                               <div class="col-md-1">
             <div class="form-group">
   
     <i class="fa fa-trash-o" aria-hidden="true" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" onclick="Delete_UserStory(8514,'')" data-bs-original-title="Delete Attachment"></i>
  </div>  </div>
                   </div>

  
    	<div class="clearfix"> </div>	</div>


        
        <div class="activity-row" id="Div6" 853="" style="">
             <div class="row">
                  <div class="col-md-3">
             <div class="form-group">
      <p  class="upload-header">Document Name(latest)</p>
      <p  class="attach-details" style="text-decoration:underline;">Agile Issues(Upload)</p>
  </div>  </div>
                    <div class="col-md-3">
             <div class="form-group">
     <p  class="upload-header">Upload Date</p>
     <p class="attach-details">07-june-2018</p>
  </div> </div>
                    <div class="col-md-3">
             <div class="form-group">
    <p  class="upload-header">Size(KB)</p>
       <p class="attach-details">2</p>
  </div>  </div>

                           <div class="col-md-2">
             <div class="form-group">
     <p  class="upload-header">Upload By</p>
      <div> <img src="../../Images/Photo/05774f3a.jpg" onerror="this.src='../../Images/Photo/no-photo.png'" data-bs-toggle="tooltip" title="" data-bs-original-title="Sa - SOFTWARE ENGINEER TEAM MEMBER"></div>

  </div>  </div>
                               <div class="col-md-1">
             <div class="form-group">
   
     <i class="fa fa-trash-o" aria-hidden="true" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" onclick="Delete_UserStory(8514,'')" data-bs-original-title="Delete Attachment"></i>
  </div>  </div>
                   </div>

    	<div class="clearfix"> </div>	</div>

     
        <div class="activity-row" id="Div7" 853="" style="">
             <div class="row">
                  <div class="col-md-3">
             <div class="form-group">
      <p  class="upload-header">Document Name(latest)</p>
      <p  class="attach-details" style="text-decoration:underline;">Agile Issues(Upload)</p>
  </div>  </div>
                    <div class="col-md-3">
             <div class="form-group">
     <p  class="upload-header">Upload Date</p>
     <p class="attach-details">07-june-2018</p>
  </div> </div>
                    <div class="col-md-3">
             <div class="form-group">
    <p  class="upload-header">Size(KB)</p>
       <p class="attach-details">2</p>
  </div>  </div>

                           <div class="col-md-2">
             <div class="form-group">
     <p  class="upload-header">Upload By</p>
      <div> <img src="../../Images/Photo/05774f3a.jpg" onerror="this.src='../../Images/Photo/no-photo.png'" data-bs-toggle="tooltip" title="" data-bs-original-title="Sa - SOFTWARE ENGINEER TEAM MEMBER"></div>

  </div>  </div>
                               <div class="col-md-1">
             <div class="form-group">
   
     <i class="fa fa-trash-o" aria-hidden="true" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" onclick="Delete_UserStory(8514,'')" data-bs-original-title="Delete Attachment"></i>
  </div>  </div>
                   </div>


    	<div class="clearfix"> </div>	</div>


        <div class="activity-row" id="Div8" 853="" style="">
             <div class="row">
                  <div class="col-md-3">
             <div class="form-group">
      <p  class="upload-header">Document Name(latest)</p>
      <p class="attach-details" style="text-decoration:underline;">Agile Issues(Upload)</p>
  </div>  </div>
                    <div class="col-md-3">
             <div class="form-group">
     <p  class="upload-header">Upload Date</p>
     <p class="attach-details">07-june-2018</p>
  </div> </div>
                    <div class="col-md-3">
             <div class="form-group">
    <p  class="upload-header">Size(KB)</p>
       <p class="attach-details">2</p>
  </div>  </div>

                           <div class="col-md-2">
             <div class="form-group">
     <p  class="upload-header">Upload By</p>
      <div> <img src="../../Images/Photo/05774f3a.jpg" onerror="this.src='../../Images/Photo/no-photo.png'" data-bs-toggle="tooltip" title="" data-bs-original-title="Sa - SOFTWARE ENGINEER TEAM MEMBER"></div>

  </div>  </div>
                               <div class="col-md-1">
             <div class="form-group">
   
     <i class="fa fa-trash-o" aria-hidden="true" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" onclick="Delete_UserStory(8514,'')" data-bs-original-title="Delete Attachment"></i>
  </div>  </div>
                   </div>

 
    	<div class="clearfix"> </div>	</div>


    </div>
</div>--%>
                                </div>


                            </div>
                        </div>
                        <%--</section>--%>
                    </div>
                </div>
            </div>
        </div>
        <script>
            //Added By Riddhesh Patil on 22/12/2022
            var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
		//End of Added By Riddhesh Patil on 22/12/2022

            /*Added By Kashish S  on 19-06-2018*/

            //$('[data-bs-toggle="tooltip"]').tooltip();

            //$(function () {
            //    $(document).tooltip({
            //        position: {
            //            my: "center bottom-20",
            //            at: "center top",
            //            using: function (position, feedback) {
            //                $(this).css(position);
            //                $(this)
            //                    .addClass(feedback.vertical);
            //            }
            //        }
            //    });

            //});

            $(function () {
                //debugger;
                $(document).tooltip({

                    position: {
                        my: 'center top',
                        at: 'center bottom+3',
                        collision: "flip",
                        trigger: "hover",
                        container: "body",
                        using: function (position, feedback) {
                            $(this).css(position);
                            $(this)
                                .addClass(feedback.vertical);

                        }

                    }

                });

            });

            //Commented and Added by Usha Pandit on 25.03.2019 for End Date Selection issue
            //$('#txtSRStartDate,#txtSREndDate').datepicker({
            //    dateFormat: "mm-dd-yy",
            //    changeMonth: true,
            //    changeYear: true,
            //    yearRange: '2000:2020'

            //});
            
            var dateToday = new Date();
            //Commented and Added by Usha Pandit On 15.12.2020 for Start End Date Format change
            //$('#txtSRStartDate').datepicker({
            //    dateFormat: "mm-dd-yy",
            //    changeMonth: true,
            //    changeYear: true,
            //    yearRange: '2000:2020'

            //});
            //$('#txtSREndDate').datepicker({
            //    dateFormat: "mm-dd-yy",
            //    changeMonth: true,
            //    changeYear: true,
            //    minDate: dateToday,
            //    yearRange: '2000:2020'
            //});

            opDateFormat = '<%= strInputFormat %>';
            var dtformatval = dtFormat(opDateFormat);

            $('#txtSRStartDate').datepicker({
                dateFormat: dtformatval,
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+100'

            });
            $('#txtSREndDate').datepicker({
                dateFormat: dtformatval,
                changeMonth: true,
                changeYear: true,
                //minDate: dateToday, //2020
                yearRange: 'c-100:c+100'
            });

            //End Of Added by Usha Pandit On 15.12.2020 for Start End Date Format change
            $('#txtSREndDate,#txtSRStartDate').prop('readonly', true);
            //End of Added by Usha Pandit on 25.03.2019 for End Date Selection issue

            $('#SRdpd1').click(function () {
                $('#txtSRStartDate').datepicker('show');
            });
            $('#SRdpd2').click(function () {
                $('#txtSREndDate').datepicker('show');
            });

            $('#dropdown-content').on('click', function (e) {
                e.stopPropagation();
                //$('#filter-dropdown').toggle();

            });

            //$(".dropdown").click(function () {
            //    $(this).find(".dropdown-menu").slideToggle("fast");
            //});
            function clear_onclick() {
                // debugger;
                $("#txtSprint").val('');
            }

            function clear_click() {
                // debugger;
                $("#search_table").val('');
                $("#SearchTask").val('');
                $("#searchIssue").val('');
                $("#Search_Review").val('');
                $("#Search_History").val('');
            }



            var Count = "";
            function getRows() {
                //debugger;
                if ($("#txtSRDescription").val() != undefined) {
                    var numberOfColumns = 70;
                    var numberOfLines = 1;
                    //numberOfColumns = document.getElementById("txtActionItems").cols;
                    var eachLine = $("#txtSRDescription").val().split('\n');
                    var lineheight = $("#txtSRDescription").val();
                    numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                    characterCount = lineheight.length + numberOfLineBreaks;
                    var charCount = lineheight.length //.replace(/\s/g, "")
                    count = 1000 - charCount;

                    if (characterCount > numberOfColumns) {
                        numberOfLines = parseInt(characterCount / numberOfColumns);
                        // var height = document.getElementById("txtSRDescription").rows = numberOfLines - 5;
                        $("#txtSRDescription").attr("style", "height: auto");

                    }
                    else {
                        //  var height = document.getElementById("txtSRDescription").rows = numberOfLines;
                        $("#txtSRDescription").attr("style", "height: auto");
                    }
                    //$("#countDown").html(count);
                }


            }

            /*Maxlength*/
            var IsFlagcountdownFN = 0;
            var IsFlagcountdownAC = 0;
            var IsFlagcountdownSummary = 0;
            var IsFlagSubus = 0;
            var IsFlag = 0;
            var IsFlagTaskname = 0;
            var IsFlagcountcountTaskNote = 0;
            var IsFlagcountcountTaskName = 0;

            function limitText(limitField, limitCount, limitNum) {
                //debugger;
                var length;
                if (limitField.value.length > limitNum) {
                    limitField.value = limitField.value.substring(0, limitNum);
                } else {
                    limitCount.innerHTML = (limitNum - limitField.value.length);

                    if (limitCount.innerHTML != 0) {
                        IsFlagcountdownSummary = 0;
                        IsFlagcountdownFN = 0;
                        IsFlagcountdownAC = 0;
                        IsFlagSubus = 0;
                        IsFlag = 0;
                        IsFlagcountcountTaskNote = 0;
                        IsFlagcountcountTaskName = 0;
                    }
                }
                //if (limitCount.innerHTML == -20) {
                //    limitCount.innerHTML = 0;

                //    IsFlagcountcountTaskName = 0;

                //}
                if (limitCount.innerHTML == 0) {

                    if (limitCount.id == 'countDown') {
                        if (IsFlagcountdownFN != 1) {
                            //document.getElementById("countDown").style.color = 'red' //when Char 0 length  then Color red
                            // $('#spanBusinessValue').html("You Can Enter Only 1000 Character");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
                            IsFlagcountdownFN = 1;
                            return IsFlagcountdownFN;
                        }
                    }
                    //else if (limitCount.id == 'countDown') {
                    //    document.getElementById("countDown").style.color = 'red' //when Char 0 length  then Color red
                    //    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('You Can Enter Only 255 Character', 'error', 5);
                    //}

                }
                if (limitField.clientHeight < limitField.scrollHeight) {
                    limitField.style.height = limitField.scrollHeight + "px";
                    if (limitField.clientHeight < limitField.scrollHeight) {
                        limitField.style.height =
                            (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
                    }
                }
                //else {
                //    limitField.style.height = limitField.clientHeight + "px";
                //}

            }

            $('txtSRDescription').each(function () {
                // this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
            }).on('input', function () {
                this.style.height = 'auto';
                this.style.height = (this.scrollHeight) + 'px';
            });

            function AutoGrowTextArea(textField) {
                //debugger;
                if (textField.clientHeight < textField.scrollHeight) {
                    textField.style.height = textField.scrollHeight + "px";
                    if (textField.clientHeight < textField.scrollHeight) {
                        textField.style.height =
                            (textField.scrollHeight * 2 - textField.clientHeight) + "px";
                    }
                }

            }



            function toggleSeeMore() {
                if (document.getElementById("more_data").style.display == 'none') {
                    document.getElementById("more_data").style.display = 'block';
                    document.getElementById("seeMore").innerHTML = 'See less';
                }
                else {
                    document.getElementById("more_data").style.display = 'none';
                    document.getElementById("seeMore").innerHTML = 'See more';
                }
            }

            /*End of Added By Kashish S on 19-06-2018*/

            var strPageName = 'frmSprintDetails.aspx';
            var objForm = GetFormReference("frmSprintDetails");
            function AssignToListClick(IterationID) {
                // debugger;
                //$("#txtSprint").val(object.name);
                //$("#hdntxtSprint").val(object.id);
                var flagSR = getParameterByName('flagSR');
                //$("#SprintlistUL").css("display", "none");
                //location.reload();
                objForm.action = strPageName + "?flagSR=" + flagSR + "&IterationID=" + IterationID;
                objForm.submit();

                //FilterSprintDetails(IterationID);
            }

            /*Added By Ankush T on 21-06-2018*/

            var SprintName = "";
            var startdate = "";
            var enddate = "";
            var IterationStatus = "";
            var Duration = "";
            var PlannedEffort = "";
            var ActualEffort = "";
            var TaskCount = "";
            var IssueCount = "";
            var DoneCount = "";
            var InProgressCount = "";
            var DoListCount = "";
            var NoOfDay = "";
            var LeftDays = "";
            var NewIterationID = "";
            var stdate = "";
            var edate = "";
            var StoryPoints = "";
            var TaskNotControl = "";
            var Description = "";

            function ClearSpan(txt, span) {
                //debugger;
                if ($('#' + txt).val() == "") {
                }
                else {
                    $('#' + txt).css('border-color', '#d8dade');
                    $('#' + txt).css('border-width', '1px');
                    $('#' + span).text("");
                }

            }


            function getParameterByName(name, url) {
                if (!url) url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }

            function ParseDate(input) {
                //debugger;
                theDate = new Date(parseInt(input.substring(6, 19)));

                return theDate.toLocaleDateString();
                //return theDate.toString('MM-dd-YYYY');
            }

            function formatDate(input) {
                //debugger;
                var datePart = input.match(/\d+/g);
                var month = datePart[0]
                var day = datePart[1]
                var year = datePart[2];


                return year + '-' + month + '-' + day;
            }

            //function formatDateBind(input) {
            //    //debugger;
            //    var datePart = input.match(/\d+/g);
            //    var day = datePart[0]
            //    var month  = datePart[1]
            //    var year = datePart[2];


            //    return month + '-' + day + '-' + year;
            //}


            function Reply_OnClick(DiscussionID) {
                //  alert(DiscussionID)
                //added & commented By Dipali V On 30th April 2019 For Placeholder issue
                //document.getElementById("DiscussionTextArea").placeholder = "Reply new Discussion..";
                document.getElementById("DiscussionTextArea").placeholder = "Reply to Discussion..";
               //End of added & commented By Dipali V On 30th April 2019 For Placeholder issue
                document.getElementById("post_discuss").textContent = "Reply";
                document.getElementById("post_discuss").title = "Reply";
                document.getElementById("post_discuss").setAttribute('onclick', 'AddNewDiscussion(' + DiscussionID + ')')
                $("#post_discuss").focus();

            }


            //makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            //    //debugger;
            //    var output = document.querySelector('.demo-droppable');
            //    output.innerHTML = '';
            //    for (var i = 0; i < files.length; i++) {
            //        arrFile[0] = files[i];
            //        output.innerHTML += '<p>' + files[i].name + '</p>';
            //        //id = "lblcaption"
            //    }
            //});

            function Back_click() {

                window.location.href = "../Agile/frmSprintPlanning.aspx?FromWhere=Back" + "&IterationID=" + globalIterationID;
            }

            var blnStartDateChange = false;
            var blnEndDateChange = false;
            var curStartDateval = '';
            var curEndDateval = '';
            var globalIterationID1 = "";

            var IsTaskListCount = 0;
            var IsIssueListCount = 0;
            var IsHistoryListCount = 0;
            var IsSubUSListCount = 0;
            var IsReviewListCount = 0;
            $(document).ready(function () {
               

                // debugger;
                var flagSR = getParameterByName('flagSR');
                var IterationID = getParameterByName('IterationID');
                var FlagSR = flagSR;
                var UniqueID = IterationID;
                globalIterationID1 = UniqueID;
                //limitText(this, countDown, 1000);
                getRows();
                PopulateSelectSprint();
                BindSprintData(flagSR, IterationID);
                $("#lblSprintName").html(SprintName);
                $("#lblstartdate").html(stdate);
                $("#lblenddate").html(edate);
                if (IterationStatus == "Not Yet Started") {
                    $("#divstatus").html("Start Sprint");
                } else {
                    $("#divstatus").html(IterationStatus);
                }

                if (CurrentSprint == 1) {
                    document.getElementById("divsprintstatus").title = "Current sprint status";
                }
                else {
                    document.getElementById("divsprintstatus").title = "Sprint status";
                }
                $("#lblstorypoints").html("[" + StoryPoints + "]");
                $("#planefforts").html(PlannedEffort);
                $("#actualefforts").html(ActualEffort);
                $("#taskcount").html(TaskNotControl);
                $("#issuecount").html(IssueCount);
                $("#issuedone").html(IssueDone);
                $("#issueinprogress").html(IssueInProgress);
                $("#issuetodo").html(IssueToDo);
                $("#lblNoOfDays").html(LeftDays);



                $('#txtSRStartDate,#txtSREndDate').change(function () {      
                    //Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                    //GetDuration('Sprint');
                    //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                });
               

                var len = Description.length;
                var count = 1000 - len;
                $("#countDown").html(count);

                BindupdSprint(IterationID);
                BindProgressbarData(flagSR, IterationID);

                BindEfforts(flagSR, IterationID);
                BindDays(flagSR, IterationID);

               
                PopulateSubUserStoryTable(IterationID);
                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsSubUSListCount > 0) {
                    BindTable("#tblShowSubUserStory");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

                
                PopulateTaskListTable(flagSR, IterationID);
                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsTaskListCount > 0) {
                    BindTable("#tblTaskDetails");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

               
                PopulateIssueListTable(flagSR, IterationID);
                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsIssueListCount > 0) {
                    BindTable("#tblIssueDetails");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue
             
                PopulateReviewListTable(flagSR, IterationID);
                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsReviewListCount > 0) {
                    BindTable("#tblReviewList");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue
               
                PopulateHistoryListTable(flagSR, IterationID);
                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsHistoryListCount > 0) {
                    BindTable("#tblHistoryList");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

                BindTeamData(flagSR, IterationID);

                BindAttachementsData(IterationID, flagSR)

                BindDisscussionData(flagSR, IterationID);
                ShowLessMoreContent();

                GetLineBurnUP(UniqueID, 'Iteration', UniqueID, "", "BurnDown");
                GetLineBurnDown(UniqueID, 'Iteration', UniqueID, "", "BurnUp");

                GetLineBurnUPEffortS(UniqueID, FlagSR, UniqueID, "", "BurnDown");
                GetLineBurnUpStoryPoints(UniqueID, FlagSR, UniqueID, "", "BurnUp");

                // GetLineVelocityStoryBar(UniqueID, FlagSR, UniqueID, "", "BurnUp");
                // GetLineVelocityEffortBar(UniqueID, FlagSR, UniqueID, "", "BurnDown");

                //FilterSprintDetails(IterationID);

                makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                    //debugger;
                    var output = document.querySelector('.demo-droppable');
                    output.innerHTML = '';
                    for (var i = 0; i < files.length; i++) {
                        arrFile[0] = files[i];
                        output.innerHTML += '<p>' + files[i].name + '</p>';
                        //id = "lblcaption"
                    }
                });


                $("#divdetails").css("height", window.innerHeight - 182 + "px");

                $("#divBurnupdown").css("height", window.innerHeight - 322 + "px");

                $("#divuserstory").css("height", window.innerHeight - 272 + "px");

                $("#mainDivTeams").css("height", window.innerHeight - 272 + "px");

                $("#divTask").css("height", window.innerHeight - 272 + "px");

                $("#divIssue").css("height", window.innerHeight - 272 + "px");

                $("#mainDivDisscussion").css("height", window.innerHeight - 239 + "px");

                $("#divReview").css("height", window.innerHeight - 272 + "px");

                $("#divHistory").css("height", window.innerHeight - 272 + "px");

                $("#DivAttachments").css("height", window.innerHeight - 347 + "px");

                $('[data-bs-toggle="tooltip"]').tooltip();
                //alert(window.innerHeight);
                //$("#SprintlistUL").niceScroll();
                //$("#SprintlistUL").css("overflow-y", "auto");
                $("#txtSRDescription").niceScroll();
                $("#DiscussionTextArea").niceScroll();
                 // Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                opDateFormat = '<%= strInputFormat %>';
                var dtformatval = dtFormat(opDateFormat);
               
                $('#txtSRStartDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            yearRange: 'c-100:c+100'
                            , dateFormat: dtformatval
                        }
                    ); 
                    $('#txtSREndDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            yearRange: 'c-100:c+100'
                            , dateFormat: dtformatval
                            //, minDate: dateToday //2020
                        }
                    );
               
               
                $('#txtSRStartDate').change(function () {
                    blnStartDateChange = true;
                    oDateFormat = '<%= strDateFormat %>';
                   

                    var objStartNew = document.getElementById("txtSRStartDate");
                    var objEndNew = document.getElementById("txtSREndDate");
                                       
                    try {
                        objStartNew.value = opformatDate(objStartNew.value, opDateFormat);
                    }
                    catch (ex) {

                    }
                    var objStartVal = objStartNew.value;
                    //Commented By Usha Pandit On 15.12.2020 for Start End Date Format change
                    //if (objStartNew != null && objEndNew != null) {
                    //    var old1objStartVal = objStartNew.value;
                    //   var old1objEndVal = objEndNew.value;
                       
                    //    if (old1objStartVal != '' && old1objEndVal != '') {
                    //        getInputDateFormat(objStartNew, objEndNew, 1, opDateFormat, oDateFormat);
                           
                    //        if (dtvsdt.indexOf("undefined") != -1) {
                    //            objStartNew.value = old1objStartVal;
                    //        }
                    //        else {
                    //            objStartNew.value = objStartVal;
                    //        }
                    //        //alert(old1objEndVal);
                    //        //alert(objEndNew.value);
                    //        //if (dtvedt.indexOf("undefined") != -1) {
                    //        //    if (blnEndDateChange == false) {
                    //        //        objEndNew.value = old1objEndVal;
                    //        //    }                                
                    //        //}
                    //        //else {
                    //        //    objEndNew.value = dtvedt;
                    //        //} 
                    //        objEndNew.value = old1objEndVal;
                    //        if (blnEndDateChange == true) {
                    //            objEndNew.value = old1objEndVal;
                    //        }
                    //    }
                    //}
                    //End Of Commented By Usha Pandit On 15.12.2020 for Start End Date Format change
                    var old1objStartVal = objStartNew.value;
                    var old1objEndVal = objEndNew.value;
                   
                    
                    $('#txtSRStartDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            yearRange: '2000:2020'
                            , dateFormat: dtformatval
                        }
                    ); 
                    $('#txtSREndDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            yearRange: 'c-100:c+100'
                            , dateFormat: dtformatval
                            //, minDate: dateToday //2020
                        }
                    );
                    
                    //Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                    //var curEndDateval = $('#txtSREndDate').datepicker(
                    //    {
                    //        changeMonth: true,
                    //        changeYear: true,
                    //        yearRange: '2000:2020'
                    //        , dateFormat: dtformatval
                    //        , setDate: new Date(old1objEndVal)
                    //        //, minDate: dateToday
                            
                    //    }
                    //).val();
                    //alert(old1objEndVal);
                    //$('#datepicker1').datepicker({ dateFormat: dtformatval }).datepicker('setDate', old1objEndVal);
                    //curEndDateval = $('#txtSREndDate').datepicker('setDate', old1objEndVal).val();
                    //alert(curEndDateval);
                    if ((oDateFormat != 'dd/mm/yyyy' && dtformatval != 'dd/mm/yy') || (oDateFormat == 'dd-mmm-yyyy')) {
                        if (curStartDateval == '' && curEndDateval == '') {
                            curEndDateval = $('#txtSREndDate').datepicker('setDate', new Date(old1objEndVal)).val();
                        }
                        else {
                            curEndDateval = $('#txtSREndDate').datepicker(
                                {
                                    changeMonth: true,
                                    changeYear: true,
                                    yearRange: 'c-100:c+100'
                                    , dateFormat: dtformatval
                                    , setDate: new Date(old1objEndVal)
                                    //, minDate: dateToday
                                }
                            ).val();
                        }

                        //getDtFormat(dtformatval, old1objStartVal, old1objEndVal, 'end');
                        //var curStartDateval = $('#txtSRStartDate').datepicker('setDate', new Date(old1objStartVal)).val();
                        //objStartNew.value = curStartDateval;
                        
                        if (curEndDateval.indexOf('-') == 0) {
                            curEndDateval = curEndDateval.substring(1);
                        }                        
                        if (curEndDateval.indexOf('--') != -1) {
                            curEndDateval = curEndDateval.toString().replace("--", "-");
                        }
                        if (curEndDateval.indexOf('.-') != -1) {
                            curEndDateval = curEndDateval.toString().replace(".-", ".");
                        }
                        if (curEndDateval.indexOf('/-') != -1) {
                            curEndDateval = curEndDateval.toString().replace("/-", "/");
                        }                        
                        objEndNew.value = curEndDateval;
                    }
                    //alert("before " + objStartNew.value);
                    //alert("before " + objEndNew.value);
                    //alert("after ");
                    GetDuration('Sprint');
                    //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                });
                 $('#txtSREndDate').change(function () {
                     blnEndDateChange = true;
                    oDateFormat = '<%= strDateFormat %>';

                     var objStartNew = document.getElementById("txtSRStartDate");
                     var objEndNew = document.getElementById("txtSREndDate");  
                     
                     try {
                         objEndNew.value = opformatDate(objEndNew.value, opDateFormat);
                     }
                     catch (ex) {

                     }
                     
                     var objEndVal = objEndNew.value;   
                     //Commented By Usha Pandit On 15.12.2020 for Start End Date Format change
                     //if (objStartNew != null && objEndNew != null) {
                     //    var old1objStartVal = objStartNew.value;
                     //    var old1objEndVal = objEndNew.value;

                     //    if (old1objStartVal != '' && old1objEndVal != '') {
                     //        getInputDateFormat(objStartNew, objEndNew, 1, opDateFormat, oDateFormat);
                     //        //alert(dtvsdt);
                     //        //alert(dtvedt);
                     //        if (dtvsdt.indexOf("undefined") != -1) {
                     //            objStartNew.value = old1objStartVal;
                     //        }
                     //        else {
                     //            //objStartNew.value = dtvsdt;
                     //        }
                     //        if (blnStartDateChange == true) {
                     //            objStartNew.value = old1objStartVal;
                     //        }
                     //        if (dtvedt.indexOf("undefined") != -1) {
                     //            objEndNew.value = old1objEndVal;
                     //        }
                     //        else {
                     //            objEndNew.value = objEndVal;
                     //        }
                     //    }
                     //}
                     var old1objStartVal = objStartNew.value;
                     var old1objEndVal = objEndNew.value;
                     //End Of Commented By Usha Pandit On 15.12.2020 for Start End Date Format change
                    
                    $('#txtSRStartDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            yearRange: 'c-100:c+100'
                            , dateFormat: dtformatval
                        }
                    ); 
                    $('#txtSREndDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            yearRange: 'c-100:c+100'
                            , dateFormat: dtformatval
                            //, minDate: dateToday //2020
                        }
                     );
                     //Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                     if ((oDateFormat != 'dd/mm/yyyy' && dtformatval != 'dd/mm/yy') || (oDateFormat == 'dd-mmm-yyyy')) {
                         if (curStartDateval == '' && curEndDateval == '') {
                             //$('#txtSRStartDate').datepicker('setDate', new Date(old1objStartVal))
                             curStartDateval = $('#txtSRStartDate').datepicker('setDate', new Date(old1objStartVal)).val();
                         }
                         else {
                             //$('#txtSRStartDate').datepicker('setDate', new Date(old1objStartVal));                     
                             curStartDateval = $('#txtSRStartDate').datepicker(
                                 {
                                     changeMonth: true,
                                     changeYear: true,
                                     yearRange: '2000:2020'
                                     , dateFormat: dtformatval
                                     , setDate: new Date(old1objStartVal)
                                 }
                             ).val();
                         }
                         //var curStartDateval = $('#txtSRStartDate').datepicker('setDate', new Date(old1objStartVal)).val();
                         if (curStartDateval.indexOf('-') == 0) {
                             curStartDateval = curStartDateval.substring(1);
                         }
                         if (curStartDateval.indexOf('--') != -1) {
                             curStartDateval = curStartDateval.toString().replace("--", "-");
                         }
                         if (curStartDateval.indexOf('.-') != -1) {
                             curStartDateval = curStartDateval.toString().replace(".-", ".");
                         }
                         if (curStartDateval.indexOf('/-') != -1) {
                             curStartDateval = curStartDateval.toString().replace("/-", "/");
                         }
                         objStartNew.value = curStartDateval;
                     }
                     //objEndNew.value = curEndDateval;
                     GetDuration('Sprint');                   
                     //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                });
                  //Added By Dipali V On 26th Oct 2020 For Calculate Bussniess Days
                $('#txtSRStartDate,#txtSREndDate').change(function () {
                   // debugger;
                    //Commented By Usha Pandit On 15.12.2020 for Start End Date Format change
                    //GetDuration('Sprint');
                    //End Of Commented By Usha Pandit On 15.12.2020 for Start End Date Format change
                });
                 //End of Added By Dipali V On 26th Oct 2020 For Calculate Bussniess Days
                

            });

            //Added By Usha Pandit On 15.12.2020 for Start End Date Format change
            var tempobjStartVal = '';
            var tempobjEndVal = '';
            function getDtFormat(dtFormat, oldobjStartVal, oldobjEndVal, flag)
            {
                try {
                    var month_names = ["Jan", "Feb", "Mar",
                        "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep",
                        "Oct", "Nov", "Dec"];
                    if (flag == 'startend') {
                        if (dtFormat == 'dd-mm-yy') {
                            arrStartDtVal = oldobjStartVal.split("-");
                            arrEndDtVal = oldobjEndVal.split("-");

                            curStartIndex = arrStartDtVal[1] - 1;
                            curEndIndex = arrEndDtVal[1] - 1;
                            tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                            tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                        }
                        else if (dtFormat == 'dd.mm.yy') {
                            arrStartDtVal = oldobjStartVal.split(".");
                            arrEndDtVal = oldobjEndVal.split(".");

                            curStartIndex = arrStartDtVal[1] - 1;
                            curEndIndex = arrEndDtVal[1] - 1;
                            tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                            tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                        }
                        else if (dtFormat == 'dd/mm/yy') {
                            arrStartDtVal = oldobjStartVal.split("/");
                            arrEndDtVal = oldobjEndVal.split("/");

                            curStartIndex = arrStartDtVal[1] - 1;
                            curEndIndex = arrEndDtVal[1] - 1;
                            tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                            tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                        }
                        else if (dtFormat == 'yy-dd-mm') {
                            arrStartDtVal = oldobjStartVal.split("-");
                            arrEndDtVal = oldobjEndVal.split("-");

                            curStartIndex = arrStartDtVal[2] - 1;
                            curEndIndex = arrEndDtVal[2] - 1;
                            tempobjStartVal = arrStartDtVal[1] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[0];
                            tempobjEndVal = arrEndDtVal[1] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[0];
                        }
                        else if (dtFormat == 'yy.dd.mm') {
                            arrStartDtVal = oldobjStartVal.split(".");
                            arrEndDtVal = oldobjEndVal.split(".");

                            curStartIndex = arrStartDtVal[2] - 1;
                            curEndIndex = arrEndDtVal[2] - 1;
                            tempobjStartVal = arrStartDtVal[1] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[0];
                            tempobjEndVal = arrEndDtVal[1] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[0];
                        }
                        else if (dtFormat == 'yy/dd/mm') {
                            arrStartDtVal = oldobjStartVal.split("/");
                            arrEndDtVal = oldobjEndVal.split("/");

                            curStartIndex = arrStartDtVal[2] - 1;
                            curEndIndex = arrEndDtVal[2] - 1;
                            tempobjStartVal = arrStartDtVal[1] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[0];
                            tempobjEndVal = arrEndDtVal[1] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[0];
                        }
                        else {
                            tempobjStartVal = oldobjStartVal;
                            tempobjEndVal = oldobjEndVal;
                        }
                    }
                    if (flag == 'start') {
                    }
                    if (flag == 'end') {
                        //if (dtFormat == 'dd-mm-yy') {
                        //    arrStartDtVal = oldobjStartVal.split("-");
                        //    arrEndDtVal = oldobjEndVal.split("-");

                        //    curStartIndex = arrStartDtVal[1] - 1;
                        //    curEndIndex = arrEndDtVal[1] - 1;
                        //    tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                        //    tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                        //}
                    }
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }
            //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
            //Added By Dipali V On 26th Oct 2020 For Calculate Bussniess Days
            function GetDuration(MODE) {
                    //debugger;
                    var objStart;
                    var objEnd;
                    Mode = MODE;

                    if (MODE == "Sprint") {
                        objStart = document.getElementById("txtSRStartDate");
                        objEnd = document.getElementById("txtSREndDate");
                    }
                    else {
                        //objStart = document.getElementById("txtStartDateR");
                        //objEnd = document.getElementById("txtEndDateR");
                    }
                   
                    //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                    var oldobjStartVal = objStart.value;
                    var oldobjEndVal = objEnd.value;
                var opDateFormat = '<%= strInputFormat %>';
                
                    //getInputDateFormat(objStart, objEnd, 1, opDateFormat);
               
                    //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation

                    //Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                
                if (dtformatval == 'dd-mm-yy') {
                    getDtFormat(dtformatval, oldobjStartVal, oldobjEndVal, 'startend');                    
                    //arrStartDtVal = oldobjStartVal.split("-");
                    //arrEndDtVal = oldobjEndVal.split("-");

                    //curStartIndex = arrStartDtVal[1] - 1;
                    //curEndIndex = arrEndDtVal[1] - 1;
                    //tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                    //tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                }
                else if (dtformatval == 'dd.mm.yy') {
                    getDtFormat(dtformatval, oldobjStartVal, oldobjEndVal, 'startend');
                    //arrStartDtVal = oldobjStartVal.split(".");
                    //arrEndDtVal = oldobjEndVal.split(".");

                    //curStartIndex = arrStartDtVal[1] - 1;
                    //curEndIndex = arrEndDtVal[1] - 1;
                    //tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                    //tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                }
                else if (dtformatval == 'dd/mm/yy') {
                    getDtFormat(dtformatval, oldobjStartVal, oldobjEndVal, 'startend');
                    //arrStartDtVal = oldobjStartVal.split("/");
                    //arrEndDtVal = oldobjEndVal.split("/");

                    //curStartIndex = arrStartDtVal[1] - 1;
                    //curEndIndex = arrEndDtVal[1] - 1;
                    //tempobjStartVal = arrStartDtVal[0] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[2];
                    //tempobjEndVal = arrEndDtVal[0] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[2];
                }
                else if (dtformatval == 'yy-dd-mm') {
                    getDtFormat(dtformatval, oldobjStartVal, oldobjEndVal, 'startend');
                    //arrStartDtVal = oldobjStartVal.split("-");
                    //arrEndDtVal = oldobjEndVal.split("-");

                    //curStartIndex = arrStartDtVal[2] - 1;
                    //curEndIndex = arrEndDtVal[2] - 1;
                    //tempobjStartVal = arrStartDtVal[1] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[0];
                    //tempobjEndVal = arrEndDtVal[1] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[0];
                }
                else if (dtformatval == 'yy.dd.mm') {
                    getDtFormat(dtformatval, oldobjStartVal, oldobjEndVal, 'startend');
                    //arrStartDtVal = oldobjStartVal.split(".");
                    //arrEndDtVal = oldobjEndVal.split(".");

                    //curStartIndex = arrStartDtVal[2] - 1;
                    //curEndIndex = arrEndDtVal[2] - 1;
                    //tempobjStartVal = arrStartDtVal[1] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[0];
                    //tempobjEndVal = arrEndDtVal[1] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[0];
                }
                else if (dtformatval == 'yy/dd/mm') {
                    getDtFormat(dtformatval, oldobjStartVal, oldobjEndVal, 'startend');
                    //arrStartDtVal = oldobjStartVal.split("/");
                    //arrEndDtVal = oldobjEndVal.split("/");

                    //curStartIndex = arrStartDtVal[2] - 1;
                    //curEndIndex = arrEndDtVal[2] - 1;
                    //tempobjStartVal = arrStartDtVal[1] + '-' + month_names[curStartIndex] + '-' + arrStartDtVal[0];
                    //tempobjEndVal = arrEndDtVal[1] + '-' + month_names[curEndIndex] + '-' + arrEndDtVal[0];
                }                
                else {
                    tempobjStartVal = oldobjStartVal;
                    tempobjEndVal = oldobjEndVal;
                }
                //alert(dtformatval);
                //alert(tempobjStartVal);
                //alert(tempobjEndVal);
                    //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                        if (oldobjStartVal != "" && oldobjEndVal != "") {
                           // debugger;
                            var url = "frmSprintPlanning.aspx/GetDuration"
                            //Commented And Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                            //var data = JSON.stringify({ strStartDate: oldobjStartVal, strEndDate: oldobjEndVal })
                            var data = JSON.stringify({ strStartDate: tempobjStartVal, strEndDate: tempobjEndVal })
                            //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                            var result = AJAXCallWithResult(url, data, false);
                            if (result.d != '') {
                               // debugger;
                                var strArray = String(result.d).split("|");
                                if (Mode == "Sprint") {
                                    document.getElementById("txtSRCalendersDuration").value = strArray[0];
                                    document.getElementById("txtSRBusinessDuration").value = strArray[1];
                                } 
                            //}
                        }
                    }

                    //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation                                   
                    objStart.value = oldobjStartVal;
                    objEnd.value = oldobjEndVal;                    
                    //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                }
              //End of Added By Dipali V On 26th Oct 2020 For Calculate Bussniess Days

             //Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            $("#DiscussionTextArea").keypress(function () {
            if ($("#DiscussionTextArea").val().length >= 2000) {
               alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter Discussion less than 2000 characters.', 'error', 5);
                $("#DiscussionTextArea").focus();
            }
        });
        //End of Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478

            var globalIterationID = "";
            function Upload_Click() {
                // debugger;
                // alert(NewIterationID)

                //UploadDataSR(IterationID, flag)
                if (NewIterationID != '') {
                    IterationID = NewIterationID;
                    UploadData(IterationID);
                    globalIterationID = IterationID;

                }
                else {
                    var IterationID = getParameterByName('IterationID');
                    var flagSR = getParameterByName('flagSR');
                    UploadData(IterationID);
                    globalIterationID = IterationID;
                }

                //makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                //    var output = document.querySelector('.demo-droppable');
                //    output.innerHTML = '';
                //    for (var i = 0; i < files.length; i++) {
                //        arrFile[0] = files[i];
                //        output.innerHTML += '<p>' + files[i].name + '</p>';
                //    }
                //});
            }

            function BindDays(flagSR, IterationID) {
                var strUserResult = ajaxCall("frmSprintDetails.aspx/GetSprintReleaseDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                $("#Days").html("");

                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                    var SpnDay = "";
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;

                        var Days = obj.NoOfDay;
                        //var str = obj.LeftDays;
                        var resdays = Days.split(" ", 1);
                        //alert(resdays);
                        if (resdays < 0) {
                            SpnDay =
                                "<span id='spnNoOfDays' style='font-size: 14px; color:red; font-weight: 600;white-space:nowrap;margin-top:-10px;margin-left: -14px;' title='Remaining Days'>" + Days + "</span>"


                        } else {
                            SpnDay =
                                "<span id='spnNoOfDays' style='font-size: 14px; color:green; font-weight: 600;white-space:nowrap;margin-top:-10px;margin-left: -14px;' title='Remaining Days'>" + Days + "</span>"
                        }

                        $("#Days").append(SpnDay);

                    });
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }

            function BindProgressbarData(flagSR, IterationID) {
                //debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/GetSprintReleaseDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                $("#progressbar").html("");

                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                    var Progress = "";
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;
                        LeftDays = Math.abs(obj.LeftDays);
                        var Days = obj.LeftDays;
                        //var Pos = "";
                        //var str = obj.LeftDays;
                        //var res = str.split(" ", 1);
                        //alert(Days);
                        var TotalDuration = 100 - Days;

                        if (Days < 0) {
                            Progress =
                                "<div class='progress active' style='margin-left: -15px;margin-top: -13px;'>" +
                                " <div id='progressleftDays' class='progress-bar progress-bar-striped' data-rel='tooltip'  title='Delayed' style='width:100%;background-color:#d43939;'  role='progressbar' aria-valuenow='" + obj.LeftDays + "' aria-valuemin='0' aria-valuemax='100'>" +
                                " </div>" +

                                //" <div id='progleftdays'  class='progress-bar bg-warning progress-bar-striped' style='width:" + obj.LeftDays + "%;background-color: rgb(31, 191, 38);'  role='progressbar' aria-valuenow='" + obj.LeftDays + "' aria-valuemin='0' aria-valuemax='100' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Days'>" +
                                //"</div>"+
                                "</div>"
                        } else {
                            Progress =
                                "<div class='progress active'  style='margin-left: -15px;margin-top: -13px;' >" +
                                " <div id='progleftdays'  class='progress-bar progress-bar-striped' style='width:" + TotalDuration + "%;background-color:rgb(31, 191, 38); '  role='progressbar' aria-valuenow='" + obj.Duration + "' aria-valuemin='0' aria-valuemax='100' title='Left Days'>" +
                                "</div>" +

                                "<div id='progressleftDays' class='progress-bar progress-bar-striped' style='width: " + Days + "%;background-color:#337ab7;'  role='progressbar' aria-valuenow='" + obj.LeftDays + "' aria-valuemin='0' aria-valuemax='100' title='Remaining Days '>" +
                                "</div>" +
                                "</div>"
                        }

                        $("#progressbar").append(Progress);

                    });
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }

            function BindEfforts(flagSR, IterationID) {
                // debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/GetSprintReleaseDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                $("#divefforts").html("");

                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                    var Efforts = "";
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;
                        var plan = obj.PlannedEffort;
                        var actual = obj.ActualEffort;


                        //Commented and Added By Usha Pandit on 28-Mar-2019 Purpose::Project Work field level changes 

                        //   if (plan < actual) {

                        //       Efforts =
                        //"<p style='white-space:nowrap!important;' >" +

                        //"<label id='planefforts' class='' style='background-color: blue;color:white; padding:3px; font-size:15px; font-weight:600; padding-left:-20px; width:40px;text-align:center' title='Planned Efforts'>" + obj.PlannedEffort + "</label>" +

                        //"<label id='actualefforts' class='' style='padding: 3px; margin-left: -4px; background-color:red ; color: white; font-weight: 600; font-size: 15px; width: 60px;text-align:center' title='Actual Efforts'>" + obj.ActualEffort + "</label>" +
                        //"</p>"
                        //   }
                        //   else {

                        //       Efforts =
                        //"<p style='white-space:nowrap!important;' >" +

                        //"<label id='planefforts' class='' style='background-color: blue;color:white; padding:3px; font-size:15px; font-weight:600; padding-left:-20px; width: 50px;text-align:center' title='Planned Efforts'>" + obj.PlannedEffort + "</label>" +

                        //"<label id='actualefforts' class='' style='padding: 3px; margin-left: -4px; background-color:green; color: white; font-weight: 600; font-size: 15px; width: 50px;text-align:center' title='Actual Efforts'>" + obj.ActualEffort + "</label>" +
                        //"</p>"
                        //   }

                        var data = JSON.stringify({ DecimalHours: plan });
                        var hmPlannedEffortResult = AJAXCallWithResult("frmSprintDetails.aspx/getHMHours", data, false);

                        var hmPlannedEffort = "00:00";
                        if (hmPlannedEffortResult != undefined) {
                            hmPlannedEffort = hmPlannedEffortResult.d;
                        }
                        var data = JSON.stringify({ DecimalHours: actual });
                        var hmActualEffortResult = AJAXCallWithResult("frmSprintDetails.aspx/getHMHours", data, false);

                        var hmActualEffort = "00:00";

                        if (hmActualEffortResult != undefined) {
                            hmActualEffort = hmActualEffortResult.d;
                        }


                        if (plan < actual) {

                            Efforts =
                                "<p style='white-space:nowrap!important;' >" +

                                "<label id='planefforts' class='' style='background-color: blue;color:white; padding:3px; font-size:14px; font-weight:600; padding-left:-20px; padding: 3px 10px;max-width: 200px;text-align:center' title='Planned Efforts'>" + hmPlannedEffort + "</label>" +

                                "<label id='actualefforts' class='' style='padding: 3px; margin-left: -4px; background-color:red ; color: white; font-weight: 600; font-size: 14px; padding: 3px 10px;max-width: 200px;text-align:center' title='Actual Efforts'>" + hmActualEffort + "</label>" +
                                "</p>"
                        }
                        else {

                            Efforts =
                                "<p style='white-space:nowrap!important;' >" +

                                "<label id='planefforts' class='' style='background-color: blue;color:white; padding:3px; font-size:14px; font-weight:600; padding-left:-20px; padding: 3px 10px;max-width: 200px;text-align:center' title='Planned Efforts'>" + hmPlannedEffort + "</label>" +

                                "<label id='actualefforts' class='' style='padding: 3px; margin-left: -4px; background-color:green; color: white; font-weight: 600; font-size: 14px; padding: 3px 10px;max-width: 200px;text-align:center' title='Actual Efforts'>" + hmActualEffort + "</label>" +
                                "</p>"
                        }
                        //End of Added By Usha Pandit on 28-Mar-2019 Purpose::Project Work field level changes 

                        $("#divefforts").append(Efforts);

                    });
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
            var CurrentSprint = "";
            function BindSprintData(flagSR, IterationID) {
                //debugger;

                var strUserResult = ajaxCall("frmSprintDetails.aspx/GetSprintReleaseDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));



                var strArray = String(strUserResult.d).split("|")

                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    SprintName = obj.IterationName;
                    startdate = ParseDate(obj.StartDate);
                    enddate = ParseDate(obj.EndDate);
                    stdate = obj.SDate;
                    edate = obj.EDate;
                    Description = obj.Description;
                    Duration = obj.Duration
                    IterationStatus = obj.IterationStatus;
                    PlannedEffort = obj.PlannedEffort;
                    ActualEffort = obj.ActualEffort;
                    TaskCount = obj.TaskCount;
                    TaskNotControl = obj.TaskNotControl;
                    IssueCount = obj.IssueCount;
                    IssueDone = obj.IssueDone;
                    IssueInProgress = obj.IssueInProgress;
                    IssueToDo = obj.IssueToDo;
                    NoOfDay = obj.NoOfDay;
                    LeftDays = obj.LeftDays;
                    StoryPoints = obj.StoryPoints;
                    CurrentSprint = obj.CurrentSprint;
                });


            }
            function BindSprintDataFilter(flagSR, IterationID) {
                //debugger;

                var strUserResult = ajaxCall("frmSprintDetails.aspx/GetSprintReleaseDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));

                var strArray = String(strUserResult.d).split("|")

                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    //$("#txtSRName").val(obj.IterationName);
                    //$("#txtSRDescription").val(obj.Description);
                    //$("#txtSRStartDate").val(ParseDate(obj.StartDate)); //formatDateBind(
                    //$("#txtSREndDate").val(ParseDate(obj.EndDate));
                    //$("#txtSRCalendersDuration").val(obj.Duration);
                    //$("#txtSRBusinessDuration").val(obj.BusinessDuration);
                    //$("#txtSREfforts").val(obj.Velocity);
                    //alert(startdate);
                    SprintName = obj.IterationName;
                    startdate = (ParseDate(obj.StartDate));
                    enddate = ParseDate(obj.EndDate);
                    stdate = obj.SDate;
                    edate = obj.EDate;
                    Duration = obj.Duration
                    IterationStatus = obj.IterationStatus;
                    PlannedEffort = obj.PlannedEffort;
                    ActualEffort = obj.ActualEffort;
                    TaskCount = obj.TaskCount;
                    TaskNotControl = obj.TaskNotControl;
                    IssueCount = obj.IssueCount;
                    IssueDone = obj.IssueDone;
                    IssueInProgress = obj.IssueInProgress;
                    IssueToDo = obj.IssueToDo;
                    NoOfDay = obj.NoOfDay;
                    LeftDays = obj.LeftDays;
                    StoryPoints = obj.StoryPoints;
                    CurrentSprint = obj.CurrentSprint;
                });


            }

            function Update_OnClick() {
                //debugger;

                if (NewIterationID != '') {
                    var flag = getParameterByName('flagSR');
                    IterationID = NewIterationID;
                    UpdateSprintRelease(flag, IterationID);
                    FilterSprintDetails(IterationID);
                }
                else {
                    var IterationID = getParameterByName('IterationID');
                    var flag = getParameterByName('flagSR');
                    UpdateSprintRelease(flag, IterationID);
                    FilterSprintDetails(IterationID);
                }
            }
            function CompairDates(obj1, Obj2) {
                //debugger;
                var date1 = new Date(obj1);
                var date2 = new Date(Obj2);
                if (date1 > date2) {
                    return 1;
                }
                else if (date1 < date2) {
                    return -1;
                }
                else {
                    return 0;
                }
            }

            function CompairDates1(obj1, Obj2) {
                //debugger;
                var date1 = obj1;
                var date2 = Obj2;
                if (date1 > date2) {
                    return 1;
                }
                else if (date1 < date2) {
                    return -1;
                }
                else {
                    return 0;
                }
            }

            //Added By Riddhesh Patil on 22/12/2022
            function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
                if (WebConfigSpecialCharacters != '') {
                    var regularExpression = WebConfigSpecialCharacters;
                    regularExpression += '"';
                    var isSpecialCharacter = 0;
                    for (var i = 0; i < regularExpression.length; i++) {
                        if (value.indexOf(regularExpression[i]) != -1) {
                            isSpecialCharacter = 1
                        }
                    }
                    if (isSpecialCharacter == 1) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
		//End of Added By Riddhesh Patil on 22/12/2022

            function checkSpecialCharacter(value) {
                var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                if (isSpecialCharacter == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function RestrictNonNumeric(obj) {
                // debugger;
                if (obj == null) { return false; }
                if (isBlank(getInputValue(obj))) { return false; }

                var dofocus = (arguments.length > 1) ? arguments[1] : true;
                if (!isNumeric(getInputValue(obj))) {
                    if (dofocus) {
                        setFocus(obj);
                    }
                    return true;
                }
                return false;
            }
             // Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
            var opDateFormat = '';
            var dtsdt, dtedt;
            var dtstart = '';
            var dtend = '';
            var dtvsdt = '';
            var dtvedt = '';
        // End of Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656

            function validationSprint() {
                // debugger;
                var checkvalue = 0;
                var Flag = 0;
                var checkvalue = 0;
                var strmsg = "";
                var errorMsg = "<ul>"
                var dtStartDate = document.getElementById("txtSRStartDate");
                var dtEndDate = document.getElementById("txtSREndDate");

                //var dtStartDate = formatDate($('#txtSRStartDate').val());
                //var dtEndDate = formatDate($('#txtSREndDate').val());
                //var ProjectID = document.getElementById('hdnProjectID').value;    
               
                if ($("#txtSRName").val() == "") {
                    strmsg = 'Sprint Name should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                //Added By Riddhesh Patil on 11-NOV-2022 
                else if (checkSpecialCharacter($("#txtSRName").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Sprint Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtSRName").focus();
                    Flag = 1;
                    checkvalue = 1;
                }
                //Added By Riddhesh Patil on 11-NOV-2022 
                if ($("#txtSRDescription").val() != " ") {
                    if (checkSpecialCharacter($("#txtSRDescription").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtSRDescription").focus();
                        Flag = 1;
                        checkvalue = 1;
                    }
                }

			   
			    //End of Added By Riddhesh Patil
                if ($("#txtSRStartDate").val() == "") {
                    strmsg = 'Sprint Start Date should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                if ($("#txtSREndDate").val() == "") {
                    strmsg = 'Sprint End date should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                 // Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656

            var oldobjStartVal = dtStartDate.value;
            var oldobjEndVal = dtEndDate.value;
               
                opDateFormat = '<%= strInputFormat %>';
                oDateFormat = '<%= strDateFormat %>';
                if (curStartDateval != "" || curEndDateval != "" || (oDateFormat == 'dd/mm/yyyy' && dtformatval == 'dd/mm/yy')) {
                    getInputDateFormat(dtStartDate, dtEndDate, 1, opDateFormat);
                }  
            // End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                //Commented And Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                //if (CompairDates(dtStartDate, dtEndDate) == 1) {
                //    strmsg = 'Sprint End date should be greater than Sprint start date';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    Flag = 1;
                //    checkvalue = 1;

                //}
                if (curStartDateval == "" && curEndDateval == "" && ((oDateFormat != 'dd/mm/yyyy' && dtformatval != 'dd/mm/yy') || (oDateFormat == 'dd-mmm-yyyy'))) {
                    dtvsdt = dtStartDate.value;
                    dtvedt = dtEndDate.value;
                }
                
                if (CompairDates1(dtStartDate.value, dtEndDate.value) == 1) {
                    strmsg = 'Sprint End date should be greater than Sprint start date';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;

                }
                //End Of Added By Usha Pandit On 15.12.2020 for Start End Date Format change
                //Commented and Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                //if (checkvalue == 0) {
                
                if (checkvalue == 0 && dtvsdt != undefined && dtvedt != undefined && dtvsdt.indexOf("undefined") == -1 && dtvedt.indexOf("undefined") == -1) {
                          //End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                    //Commented and Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                    <%--var data = JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', StartDate: dtStartDate, EndDate: dtEndDate });--%>
                    var data = JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', StartDate: dtvsdt, EndDate: dtvedt });
                     //End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                    var result = AJAXCallWithResult("frmSprintDetails.aspx/ValidateProjectDates", data, false);
                    result = result.d;
                    if (result != '') {
                        var arrResult = result.split('##');

                        if (arrResult[0] == '1') {
                            //dtStartDate.style.borderColor = 'red';
                            //dtStartDate.style.borderWidth = '1px';
                            //spandtStartDate.innerHTML = arrResult[1];

                            //checkvalue = 1;
                            strmsg = arrResult[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkvalue = 1;
                        }
                        if (arrResult[0] == '2') {

                            //dtEndDate.style.borderColor = 'red';
                            //dtEndDate.style.borderWidth = '1px';
                            //spandtEndDate.innerHTML = arrResult[1];

                            //checkvalue = 1;
                            strmsg = arrResult[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkvalue = 1;
                        }
                    }
                       // Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                dtStartDate.value = oldobjStartVal;
                dtEndDate.value = oldobjEndVal;
                 // End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                }


                if ($("#txtSRCalendersDuration").val() == "") {
                    strmsg = 'Calendars days should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                if ($("#txtSRCalendersDuration").val() != "") {
                    if (RestrictNonNumeric(document.getElementById('txtSRCalendersDuration')) == true) {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = 'Please Enter only positive numeric value for Calendar Day"s" !!!';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        //alertify.notify('', 'error');
                        checkvalue = 1;

                    } 
                    //else if (checkSpecialCharacter($('#txtSRCalendersDuration').val()) == true) {
                    //    // alertify.set('notifier', 'position', 'top-right');
                    //    strmsg = 'Calenders days cannot contain any of these /\\:*?<>|,"+- Characters';
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    //    checkvalue = 1;

                    //}
                    else if (checkSpecialCharacter($("#txtSRCalendersDuration").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Calendar Days Duration should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtSRCalendersDuration").focus();
                        Flag = 1;
                        checkvalue = 1;

                    }
                }

                if ($("#txtSRBusinessDuration").val() == "") {
                    strmsg = 'Business days should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                if ($("#txtSRBusinessDuration").val() != "") {
                    if (RestrictNonNumeric(document.getElementById('txtSRBusinessDuration')) == true) {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = 'Please Enter only positive numeric value for Business Day"s" !!!';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        //alertify.notify('', 'error');
                        checkvalue = 1;

                    }
                    //else if (checkSpecialCharacter($('#txtSRBusinessDuration').val()) == true) {
                    //    // alertify.set('notifier', 'position', 'top-right');
                    //    strmsg = 'Business days cannot contain any of these /\\:*?<>|,"+- Characters';
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    //    checkvalue = 1;

                    //}
                    else if (checkSpecialCharacter($("#txtSRBusinessDuration").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Business days should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtSRBusinessDuration").focus();
                        Flag = 1;
                        checkvalue = 1;

                    }
                }


                if ($("#txtSREfforts").val() == "") {
                    strmsg = 'Efforts should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 
                //if ($("#txtSREfforts").val() != "") {
                //    if (RestrictNonNumeric(document.getElementById('txtSREfforts')) == true) {
                //        // alertify.set('notifier', 'position', 'top-right');
                //        strmsg = 'Please Enter only positive numeric value for Efforts !!!';
                //        errorMsg += "<li>" + strmsg + "</li></br>";
                //        //alertify.notify('', 'error');
                //        checkvalue = 1;

                //    }
                //    else if (checkSpecialCharacter($('#txtSREfforts').val()) == true) {
                //        // alertify.set('notifier', 'position', 'top-right');
                //        strmsg = 'Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
                //        errorMsg += "<li>" + strmsg + "</li></br>";
                //        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                //        checkvalue = 1;

                //    }


                //}

                if ($("#txtSREfforts").val() != "") {
                    try {
                        var blnHMFormat = true;
                        var objHMEffort = document.getElementById("txtSREfforts");
                        var objVal = objHMEffort.value;

                        var objnewVal = objHMEffort.value;

                        objHMEffort.value = objHMEffort.value.replace(":", ".");
                        var isdigit = isNumeric(objHMEffort.value);
                        objHMEffort.value = objVal;

                        if (isdigit == false) {
                            strmsg = 'Please Enter only positive numeric value For Efforts in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            checkvalue = 1;
                        }

                        if (objHMEffort.value.indexOf(":") == -1) {
                            //strmsg = 'Please enter efforts in valid format hh:mm!!';
                            //errorMsg += "<li>" + strmsg + "</li></br>";
                            //blnHMFormat = false;
                            ////setFocus(objHMEffort);
                            //checkvalue = 1;
                            objHMEffort.value = objnewVal + ':00';
                            objnewVal = objHMEffort.value;
                        }

                        if (objHMEffort.value.indexOf(":") != -1) {
                            objHMEffort.value = objHMEffort.value.replace(':', '.');
                        }

                        //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                        var tempEffort = objHMEffort.value.replace('-', '');
                        //if (checkSpecialCharacter(tempEffort) == true) {
                        //    // alertify.set('notifier', 'position', 'top-right');
                        //    strmsg = 'Efforts cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        //    objHMEffort.value = objVal;
                        //    checkvalue = 1;
                        //}
                        if (checkSpecialCharacter($("#txtSREfforts").val(), WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Efforts should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            $("#txtSREfforts").focus();
                            Flag = 1;
                            checkvalue = 1;
                        }

                        //if (blnResult == true) {
                        //    checkvalue = 1;
                        //}

                        //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                        if (blnHMFormat == true) {
                            if (RestrictNonNumeric(document.getElementById("txtSREfforts")) == true) {
                                strmsg = 'Please enter Efforts in H:M format.';
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                objHMEffort.value = objVal;
                                checkvalue = 1;
                            }
                        }

                        //if (blnResult == true) {
                        //    checkvalue = 1;
                        //}

                        objHMEffort.value = objHMEffort.value.replace('.', ':');

                        var WorkHour = objHMEffort.value;

                        WorkHour = WorkHour.trim();
                        var idxColon = WorkHour.indexOf(':');

                        var hrs = WorkHour.substring(0, idxColon);

                        var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                        if (mins.length == 1 && mins > 5) {
                            mins = mins + "0";
                        }
                        if (blnHMFormat == true) {
                            if (mins == "") {
                                //mins = "00";
                                strmsg = "Please enter Efforts in H:M format.";
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                checkvalue = 1;
                            }

                            if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                                strmsg = 'Hours should not be less than or equal to zero (0).';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                checkvalue = 1;
                            }

                            // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                            if (blnHMFormat == true) {
                                if (mins.length > 2) {
                                    strmsg = "Please enter minutes in two decimal and less than 60.";
                                    errorMsg += "<li>" + strmsg + "</li>";
                                    blnHMFormat = false;
                                    checkvalue = 1;
                                }
                            }
                            // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                            if (blnHMFormat == true) {
                                if (mins > 59 || mins < 0) {
                                    strmsg = 'Please enter minutes between (0-59) range';
                                    errorMsg += "<li>" + strmsg + "</li></br>";
                                    blnHMFormat = false;
                                    checkvalue = 1;
                                }
                            }
                        }
                        var MinDAENtryDisplay = "";

                        var MinDAEntry = '<%=m_MinHoursForDAEntry%>';



                if (MinDAEntry == 0.25) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:15"
                }
                else if (MinDAEntry == 0.50) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:30"
                }
                else if (MinDAEntry == 0.75) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:45"
                }

                if ('<%=m_RestrictByMinHours%>' == 'True') {
                            if (MinDAEntry == 0.016) {
                            }
                            else {
                                var minutes = WorkHour.split(':');

                                var p = minutes[0];
                                var dec = minutes[1];

                                if (dec != undefined) {
                                    if (dec.length > 2) {
                                        dec = dec.substring(0, 2);
                                    }
                                    if (dec.length == 1) {
                                        dec = dec + "0";
                                    }

                                    if (dec == undefined) { dec = 0; }
                                    d = (dec - 0) / 60 + (p - 0);

                                    if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                                        //strmsg = 'Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                                        if (blnHMFormat == true) {
                                            strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                            errorMsg += "<li>" + strmsg + "</li></br>";
                                            checkvalue = 1;
                                        }
                                    }
                                }
                            }
                        }
                        if (checkvalue == 1) {
                            objHMEffort.value = objVal;
                        }
                        else {

                            if (objHMEffort.value.toString().indexOf(":") != -1) {
                                var chkhr = objHMEffort.value.split(":")[0];
                                var chkmin = objHMEffort.value.split(":")[1];
                                if (chkhr.length == 1) {
                                    chkhr = "0" + chkhr;
                                    objHMEffort.value = chkhr + ":" + chkmin;
                                }
                                if (chkmin.length == 1) {
                                    chkmin = chkmin + "0";
                                    objHMEffort.value = chkhr + ":" + chkmin;
                                }
                            }
                        }
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                }
                //End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

                var objCurrentIterationStartDate = dtStartDate.value;
                var objCurrentIterationEndDate = dtEndDate.value;
                
                // Commented and Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                //if (dtStartDate != null && dtEndDate != null) {
                if (dtStartDate != null && dtEndDate != null && (dtStartDate.value != "" && dtEndDate.value != "") && dtvsdt.indexOf("undefined") == -1 && dtvedt.indexOf("undefined") == -1) {
                    // End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656

                    // Commented and Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                         <%--var data = JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', StartDate: dtStartDate, EndDate: dtEndDate, Flag: "Sprint" });--%>
                    var data = JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', StartDate: dtvsdt, EndDate: dtvedt, Flag: "Sprint",IterationID: GlobalIterationIDNew });
                    // End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                    // Commneted and added by Chetan M on 12 Dec 2020 for Issue fixing
                    //var result1 = AJAXCallWithResult("frmSprintDetails.aspx/ValidateIterationDate", data, false);
                    var result1 = AJAXCallWithResult("frmSprintDetails.aspx/ValidateIterationDate_Alert", data, false);
                    //if (result1.d != '') {
                    if (result1.d != '' && result1.d != null) {
                    //End of Commneted and added by Chetan M on 12 Dec 2020 for Issue fixing
                    
                        strmsg = result1.d;
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        // alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify(result1.d, 'error', 15);
                        checkvalue = 1;

                    }
                    //Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                    dtStartDate.value = oldobjStartVal;
                    dtEndDate.value = oldobjEndVal;
                    //End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                }

                  // Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
                dtStartDate.value = oldobjStartVal;
                dtEndDate.value = oldobjEndVal;
                 // End of Added by Usha Pandit on 30.04.2019 Purpose:: Agile Issue ID- 18656
              // alert(globalIterationID1);
                if (checkvalue == 0) {
                    var data = JSON.stringify({
                        strIterationID: globalIterationID1,//Added By Dipali V On 16th July 2020 for Validate efforts with Project Efforts
                        strEfforts: $('#txtSREfforts').val()
                    })
                    var strResultEfforts = AJAXCallWithResult("frmSprintDetails.aspx/CheckSprintEfforts", data, false)
                    if (strResultEfforts.d != '') {
                        checkvalue = 1;
                        strmsg = strResultEfforts.d;
                        errorMsg += "<li>" + strResultEfforts.d + "</li></br>";
                    }
                }

                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error', 8);

                }
                return checkvalue;




            }
            //Added by Chetan M on 12 Dec 2020 for Issue Fixing
            var GlobalIterationIDNew = 0;
            function UpdateSprintRelease(flag, IterationID) {
                //debugger;
                GlobalIterationIDNew = IterationID;
                //End of Added by Chetan M on 12 Dec 2020 for Issue Fixing
                if (validationSprint() == 0) {
                    var SRName = $('#txtSRName').val();

                    
                    //if (blnStartDateChange == false) {
                    //    var objStartNew = document.getElementById("txtSRStartDate");
                    //    objStartNew.value = opformatDate(objStartNew.value, opDateFormat);
                    //}
                    //if (blnEndDateChange == false) {
                    //    var objEndNew = document.getElementById("txtSREndDate");
                    //    objEndNew.value = opformatDate(objEndNew.value, opDateFormat);
                    //}
                    var StartDate = formatDate($('#txtSRStartDate').val());
                    var Description = $('#txtSRDescription').val();
                    var EndDate = formatDate($('#txtSREndDate').val());
                    var CalenderDuration = $('#txtSRCalendersDuration').val();
                    var BusinessDuration = $('#txtSRBusinessDuration').val();
                    if (flag == "Iteration") {
                        var Efforts = $('#txtSREfforts').val();
                    }
                   
                    var obj = {};
                    obj.IterationID = IterationID;
                    obj.strIteration = SRName;
                    obj.strDescription = Description;
                  
                    if (dtvsdt != '' && dtvsdt != undefined && dtvedt != '' && dtvedt != undefined && dtvsdt.indexOf("undefined") == -1 && dtvedt.indexOf("undefined") == -1) {
                        obj.dtStartDate = dtvsdt;
                        obj.dtEndDate = dtvedt;
                    }
                    else {
                        obj.dtStartDate = StartDate;
                        obj.dtEndDate = EndDate;
                    }
                   


                    
                    obj.intDuration = CalenderDuration;

                    //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

                    //if (flag == "Iteration") {
                    //    obj.fltVelocity = Efforts;
                    //} else {
                    //    obj.fltVelocity = 0
                    //}

                    if (flag == "Iteration") {
                        obj.strVelocity = Efforts;
                    } else {
                        obj.strVelocity = 0
                    }
                    //End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

                    obj.intBusinessDuration = BusinessDuration;
                    obj.flag = flag;

                    //$.ajax({
                    //    type: "POST",
                    //    url: "frmSprintDetails.aspx/UpdateSprintReleaseRecords",
                    //    data: JSON.stringify(obj),
                    //    contentType: "application/json; charset=utf-8",
                    //    dataType: "json",
                    //    async: false,
                    //success: function (data) {
                    //}
                    //});
                    var strDecimal = "";
                    var strBeforeDecimal = "";
                    var objEffort = obj.strVelocity;


                    strBeforeDecimal = objEffort.substr(0, objEffort.indexOf(":"));
                    if (strBeforeDecimal.length == 1) {
                        strBeforeDecimal = "0" + strBeforeDecimal
                    }

                    strDecimal = objEffort.substr(objEffort.indexOf(":") + 1, 2)
                    if (strDecimal == "") {
                        strDecimal = "00";
                    }
                    objEffort = strBeforeDecimal + ":" + strDecimal
                    $('#txtSREfforts').val(objEffort);

                    //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

                    //var strUserResult = ajaxCall("frmSprintDetails.aspx/UpdateSprintReleaseRecords", "POST", "application/json", "json",
                    //              JSON.stringify({ IterationID: obj.IterationID, strIteration: obj.strIteration, strDescription: obj.strDescription, dtStartDate: obj.dtStartDate, dtEndDate: obj.dtEndDate, intDuration: obj.intDuration, fltVelocity: obj.fltVelocity, intBusinessDuration: obj.intBusinessDuration, flag: flag }));
                  
                    var strUserResult = ajaxCall("frmSprintDetails.aspx/UpdateSprintReleaseRecords", "POST", "application/json", "json",
                        JSON.stringify({ IterationID: obj.IterationID, strIteration: obj.strIteration, strDescription: obj.strDescription, dtStartDate: obj.dtStartDate, dtEndDate: obj.dtEndDate, intDuration: obj.intDuration, strVelocity: obj.strVelocity, intBusinessDuration: obj.intBusinessDuration, flag: flag }));

                    //End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 


                    if (strUserResult != null) {

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Data saved successfully.', 'success', 5);

                    }


                    //FilterSprintDetails(IterationID);
                }
            }

            function PopulateSelectSprint() {
                // debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/ScrumIterationList", "POST", "application/json", "json",
                    JSON.stringify({}));
                $("#SprintlistUL").html("");
                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;
                    var Sprints = "";
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        //debugger;
                        //alert(obj.IterationID);
                        //alert(obj.CurrentSprint);
                        if (obj.CurrentSprint != 1) {

                            Sprints =
                                "<li class='clsAssignedListItem dropdown-item' name='dropdownlist'><a href='#' id='SprintNM' name='SprintName' onclick='AssignToListClick(" + obj.IterationID + ")'>" + obj.IterationName + "</a></li>"


                        }
                        else {

                            Sprints =
                                "<li class='clsAssignedListItem dropdown-item' name='dropdownlist'><a href='#' id='SprintNM' name='SprintName' onclick='AssignToListClick(" + obj.IterationID + ")'><i class=' fa fa-star current-release-icon' aria-hidden=' true' style='color:#ff8c00;padding: -6px;margin-left:-15px;margin-right: 4px;' data-bs-original-title='' title=''></i>" + obj.IterationName + "</a></li>"
                        }
                        $("#SprintlistUL").append(Sprints);

                    });
                }

            }

            function filterFunction() {
                // debugger;
                var input, filter, ul, li, a, i;
                input = document.getElementById("txtSprint");
                filter = input.value.toUpperCase();
                div = document.getElementById("divSprintdetails");
                a = div.getElementsByTagName("a");
                for (i = 0; i < a.length; i++) {
                    if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                        a[i].style.display = "";
                    } else {
                        a[i].style.display = "none";
                    }
                }
            }


            function FilterSprintDetails(IterationID) {
                // debugger;
                NewIterationID = IterationID;
                var flagSR = getParameterByName('flagSR');
                //alert(IterationID);

                PopulateSelectSprint();
                BindSprintDataFilter(flagSR, IterationID);
                getRows();
                $("#lblSprintName").html(SprintName);
                $("#lblstartdate").html(stdate);
                $("#lblenddate").html(edate);
                if (IterationStatus == "Not Yet Started") {
                    $("#divstatus").html("Start Sprint");
                } else {
                    $("#divstatus").html(IterationStatus);
                }
                if (CurrentSprint == 1) {
                    document.getElementById("divsprintstatus").title = "Current sprint status";
                }
                else {
                    document.getElementById("divsprintstatus").title = "Sprint status";
                }

                $("#lblstorypoints").html("[" + StoryPoints + "]");
                $("#planefforts").html(PlannedEffort);
                $("#actualefforts").html(ActualEffort);
                $("#taskcount").html(TaskNotControl);
                $("#issuecount").html(IssueCount);
                $("#issuecount").html(IssueCount);
                $("#issuedone").html(IssueDone);
                $("#issueinprogress").html(IssueInProgress);
                $("#issuetodo").html(IssueToDo);
                $("#lblNoOfDays").html(LeftDays);

                //$("#txtSRStartDate").html(formatDate(startdate));
                //$("#txtSREndDate").html(formatDate(enddate));

                BindupdSprint(IterationID);
                BindProgressbarData(flagSR, IterationID);

                BindEfforts(flagSR, IterationID);
                BindDays(flagSR, IterationID);

                
                PopulateSubUserStoryTable(IterationID);
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsSubUSListCount > 0) {
                    BindTable("#tblShowSubUserStory");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue


              
                PopulateTaskListTable(flagSR, IterationID);
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsTaskListCount > 0) {
                    BindTable("#tblTaskDetails");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue


              
                PopulateIssueListTable(flagSR, IterationID);
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsIssueListCount > 0) {
                    BindTable("#tblIssueDetails");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

               
                PopulateReviewListTable(flagSR, IterationID);
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsReviewListCount > 0) {
                    BindTable("#tblReviewList");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

             
                PopulateHistoryListTable(flagSR, IterationID);
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if (IsHistoryListCount > 0) {
                    BindTable("#tblHistoryList");
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

                BindTeamData(flagSR, IterationID);

                BindAttachementsData(IterationID, flagSR)

                BindDisscussionData(flagSR, IterationID);
                ShowLessMoreContent();

                var UniqueID = IterationID;
                var FlagSR = flagSR;
                GetLineBurnUP(UniqueID, 'Iteration', UniqueID, "", "BurnDown");
                GetLineBurnDown(UniqueID, 'Iteration', UniqueID, "", "BurnUp");

                GetLineBurnUPEffortS(UniqueID, FlagSR, UniqueID, "", "BurnDown");
                GetLineBurnUpStoryPoints(UniqueID, FlagSR, UniqueID, "", "BurnUp");

                //$("#filter-dropdown").css('display', "none");

                //GetLineVelocityStoryBar(UniqueID, FlagSR, UniqueID, "", "BurnUp");
                // GetLineVelocityEffortBar(UniqueID, FlagSR, UniqueID, "", "BurnDown");
                //$('#dropdown-content').toggle();

                //AssignToListClick(IterationID);
                makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                    var output = document.querySelector('.demo-droppable');
                    output.innerHTML = '';
                    for (var i = 0; i < files.length; i++) {
                        arrFile[0] = files[i];
                        output.innerHTML += '<p>' + files[i].name + '</p>';
                    }
                });
            }

            function BindupdSprint(IterationID) {
                //debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/SprintUpdBtn", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID }));
                $("#btnupdSprint").html("");
                //alert(strUserResult.d);
                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    //alert(strArray[0]);
                    var i = 0;
                    var updSprint = "";
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        //debugger;
                        var strSprintStatus = obj.Column1;

                        if (strSprintStatus == 1) {
                            updSprint =
                                "<button type='button'  class='btn btn-info'  id='updateSprintRelease' style=' margin-left:-17px;' data-toggle='tooltip' data-bs-original-title='Sprint Already started/completed,you do not have access to change data'>Update</button>"
                        }
                        else {
                            updSprint =
                                "<button type='button' class='btn btn-info' style=' margin-left:-17px;' onclick='Update_OnClick()' id='updateSprintRelease' data-toggle='tooltip' data-bs-original-title='Update'>Update</button>"
                        }
                        $("#btnupdSprint").append(updSprint);

                    });
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }

            function PopulateSubUserStoryTable(IterationID) {
                //debugger;

                var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowUserStoryDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID }));

                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;
                        //Added By Dipali V On 28th March 2023 For Datable Issue
                        IsSubUSListCount = 1;
                         //End of Added By Dipali V On 28th March 2023 For Datable Issue
                        myTable.row.add([obj.UserStoryID, obj.UserSToryName, obj.Description, obj.InitialEstimate, obj.Status]);

                        myTable.draw();
                    });
                }

            }
            oTable1 = $('#tblShowSubUserStory').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#search_table').keyup(function () {
                oTable1.search($(this).val()).draw();
            })

           
            function PopulateTaskListTable(flagSR, IterationID) {
                // debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowTaskDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;

                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        //debugger;
                        //alert(obj.Effort);
                        //Added By Dipali V On 28th March 2023 For data Table Issue
                        IsTaskListCount = 1;
                        //End of Added By Dipali V On 28th March 2023 For data Table Issue
                        //Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

                        //var PlanEffort = obj.Effort + " / " + obj.Actual;

                        var strDecimal = "";
                        var strBeforeDecimal = "";
                        var objEffort = obj.Effort;
                        var objActual = obj.Actual;

                        strBeforeDecimal = objEffort.substr(0, objEffort.indexOf(":"));
                        if (strBeforeDecimal.length == 1) {
                            strBeforeDecimal = "0" + strBeforeDecimal
                        }

                        strDecimal = objEffort.substr(objEffort.indexOf(":") + 1, 2)
                        if (strDecimal == "") {
                            strDecimal = "00";
                        }
                        objEffort = strBeforeDecimal + ":" + strDecimal


                        strDecimal = "";
                        strBeforeDecimal = "";

                        strBeforeDecimal = objActual.substr(0, objActual.indexOf(":"));
                        if (strBeforeDecimal.length == 1) {
                            strBeforeDecimal = "0" + strBeforeDecimal
                        }
                        strDecimal = objActual.substr(objActual.indexOf(":") + 1, 2)
                        if (strDecimal == "") {
                            strDecimal = "00";
                        }
                        objActual = strBeforeDecimal + ":" + strDecimal

                        var PlanEffort = objEffort + " / " + objActual;

                        //End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

                        myTable.row.add([obj.ScrumTaskName, obj.AssignedTo, PlanEffort, obj.IsActive, obj.UserStoryName]);

                        myTable.draw();
                    });
                }
            }

            oTable2 = $('#tblTaskDetails').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#SearchTask').keyup(function () {
                oTable2.search($(this).val()).draw();
            })

            function PopulateIssueListTable(flagSR, IterationID) {
                //debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowIssueDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;
                        //Added By Dipali V On 28th March 2023 For data Table Issue
                        IsIssueListCount = 1;
                        //End of Added By Dipali V On 28th March 2023 For data Table Issue
                        if (obj.IsImpediment == 1) {
                            var Flag = "<p><span id='spnissue' title='Issue converted from impediment'><i class='fa fa-star' aria-hidden='true' style='color:red !important'></i></span></p>"
                        } else {
                            var Flag = "";
                        }
                        myTable.row.add([Flag, obj.IssueID, ParseDate(obj.ReportedDate), obj.Type, obj.UserStoryName, obj.Summary]);

                        myTable.draw();
                    });
                }

            }
            oTable3 = $('#tblIssueDetails').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#searchIssue').keyup(function () {
                oTable3.search($(this).val()).draw();
            })

            function PopulateReviewListTable(flagSR, IterationID) {
                // debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowReviewDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;
                        //Added By Dipali V On 28th March 2023 For data Table Issue
                        IsReviewListCount = 1;
                        //End of Added By Dipali V On 28th March 2023 For data Table Issue
                        myTable.row.add([ParseDate(obj.ReviewedDate), obj.UserStoryName, obj.ReviewStatus, obj.ReviewTitle, obj.ReviewedBy, obj.Reviewee]);

                        myTable.draw();
                    });
                }
            }

            oTable4 = $('#tblReviewList').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#Search_Review').keyup(function () {
                oTable4.search($(this).val()).draw();
            })

            function PopulateHistoryListTable(flagSR, IterationID) {
                // debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowHistoryList", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                if (strUserResult != null) {
                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        // debugger;
                        //Added By Dipali V On 28th March 2023 For data Table Issue
                        IsHistoryListCount = 1;
                        //End of Added By Dipali V On 28th March 2023 For data Table Issue
                        myTable.row.add([ParseDate(obj.Date), obj.ModifiedBy, obj.FieldName, obj.OldValue, obj.NewValue]);

                        myTable.draw();
                    });
                }
            }

            oTable5 = $('#tblHistoryList').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#Search_History').keyup(function () {
                oTable5.search($(this).val()).draw();
            })


            function BindTeamData(flagSR, IterationID) {
                //debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowTeamsDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                $("#mainDivTeams").html("");

                if (strUserResult.d != '[]|') {

                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;

                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        var Teams = ""
                        Teams = "<div class='col-md-6'><div class='col-sm-11 col-sm-11 sprint_card team_cards'><div class=''><div class='col-md-2 col-sm-2 col-sm-12 discussionbox'>" +
                            "<span class='chat-img float-start' title='Employee Image'>" +
                            "<img class='img-circle' src='../../Images/Photo/" + obj.SystemFilename + "' onerror=this.src='../../Images/Photo/no-photo.png' ></span></div>" +
                            "<div class='col-md-10 col-sm-10 col-sm-12'>" +
                            "<p class='ClsTeamDetails' >" +
                            "<span  title='Employee Name' data-bs-original-title='Employee Name'>" + obj.EmployeeName + "</span> |" +
                            "<label class='ClsRole' title='Role-" + (obj.RoleDescription) + "'  data-bs-original-title='" + (obj.RoleDescription) + "'>" + (obj.RoleDescription).substr(0, 13) + "...</label></p>" +
                            "<p class='ResourcePercentage'><span title='Resource Percentage' data-bs-original-title='Resource Percentage'>" + obj.ResourcePercentage + " % Allocation</span> </p>" +
                            "<div class='progress' style='width: 80%;' title='Task Completion Percentage'>" +
                            "<div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='" + obj.TaskCompletionPercentage + "' aria-valuemin='0' aria-valuemax='100' style='width: " + obj.TaskCompletionPercentage + "%' title='Task Completion Percentage'></div></div>" +
                            "<span class='label label-primary' style='float: right; margin-top: -34px; margin-right:5px; border-radius: 10px;' title='Task Completion Percentage'>" + obj.TaskCompletionPercentage.toFixed(2) + "%</span><br>" +
                            "</div></div></div>"


                        $("#mainDivTeams").append(Teams);
                    });
                }
                else {
                    var Teams = ""
                    Teams = "<div class='col-md-6'><span style='text-align:center'> There are no items to show</span></div>"
                    $("#mainDivTeams").append(Teams);
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }

            function BindDisscussionData(flagSR, IterationID, flag) {
                //debugger;
                try {
                    var strUserResult = ajaxCall("frmSprintDetails.aspx/ShowDiscussionDetails", "POST", "application/json", "json",
                        JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                    if (strUserResult.d != '[]|') {
                        $("#mainDivDisscussion").html("");
                        // alert(strUserResult.d)
                        var strArray = String(strUserResult.d).split("|");
                        var i = 0;
                        var Replycount = 0;

                        $.each(JSON.parse(strArray[0]), function (id, obj) {
                            var USDisscussions = ""
                            var Replycount = 0;


                    //var dateFormat;
                    //dateFormat = "<%=strDateFormat%>";

                    //var dateInputFormat;
                    //dateInputFormat = "<%=strInputFormat%>";                

                            //DT = GetFormat(obj.DiscussionDates, dateFormat, dateInputFormat);


                            USDisscussions = "<div class='feed-element'><a class='float-start'>" +
                                "<img class='img-circle' src='../../Images/Photo/" + obj.SystemFilename + "' onerror=this.src='../../Images/Photo/no-photo.png' title='Employee Image'></a>" +
                                "<div class='media-body'><small class='float-end text-navy' >" + obj.Duration + "</small><strong  title='Employee Name' >" + obj.EmployeeName + "</strong>" +
                                "<p style='word-break: break-word !important;' class='more' >" + obj.Comments + "</p>" + //text-align: justify;word-spacing: -1px;
                                "<small class='text-muted' title='Posted on'>" + obj.DiscussionDates + "</small>" +
                                // "<label data-bs-toggle='collapse' data-bs-target='#collapse_" + obj.DiscussionID + "' style='cursor:pointer;margin-left: 10px;' ><span title='View all reply' class='clsReply'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label><a class='btn btn-xs btn-white' onclick=' Reply_OnClick(" + obj.DiscussionID + ")' style='font-size: 12px;' title='Reply'><i class='fa fa-reply'></i>Reply </a><label id='ReplyCount_" + obj.DiscussionID + "' class='label label-warning' style='font-size:9px' title='Reply count'></label>" +
                                "<label data-bs-toggle='collapse' data-bs-target='#collapse_" + obj.DiscussionID + "' style='cursor:pointer;margin-left: 10px;' ><span title='View all reply' class='clsReply'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label><a class='btn btn-xs btn-white' onclick=' Reply_OnClick(" + obj.DiscussionID + ")' style='font-size: 12px;' title='Reply'><i class='fa fa-reply'></i>Reply </a><label id='ReplyCount_" + obj.DiscussionID + "' class='label' style='font-size:9px' title='Reply count'></label>" +
                                "</div></div>"
                            $("#mainDivDisscussion").append(USDisscussions);

                            var strUSReply = ajaxCall("frmSprintDetails.aspx/ShowDisscussionsReply", "POST", "application/json", "json",
                                JSON.stringify({ IterationID: IterationID, DiscussionID: obj.DiscussionID }));

                            if (strUSReply.d != '[]|') {
                                var i = 0;
                                var strArray1 = String(strUSReply.d).split("|");
                                USDisscussions = "<div id='collapse_" + obj.DiscussionID + "' class='chat chat-inline collapse'></div>"
                                $("#mainDivDisscussion").append(USDisscussions);
                                $.each(JSON.parse(strArray1[0]), function (id, objs) {
                                    Replycount = Replycount + 1;
                                    USDisscussions = "<div class='feed-element' style='background-color: lightgrey;'><div class='right'><span class='date-time' style='margin-left: 14px' >" + objs.Duration + "</span><a href='javascript:;' class='image float-end'>" +
                                        "<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' src='../../Images/Photo/" + objs.SystemFilename + "' title='Employee Image'></a>" +
                                        "<P style='margin-left:200px;text-align:right;font-weight:600;' title='Employee Name'>" + objs.EmployeeName + " &nbsp; &nbsp;</p><div class='more' style='margin-left: 15px;word-break: break-word !important;margin-right: 76px;text-align:Left;'>" + objs.Comments + "</div>" + //text-align:justify;word-spacing: -1px;
                                        "<div class='row' style='margin-top: 10px;'><div class='col-md-2'></div><div class='col-md-8' style='margin-left: 35px;'><small class='text-muted' style='margin-left: 138px;' title='Posted on'>" + objs.DiscussionDates + "</small>" +
                                        "<a class='btn btn-xs btn-white' onclick=' Reply_OnClick(" + obj.DiscussionID + ")' style='font-size: 12px;' title='Reply'><i class='fa fa-reply'></i>Reply </a>" +
                                        "<div class='clearfix'></div></div></div></div></div>"
                                    //$("#mainDivDisscussion").append(USDisscussions);
                                    $("#collapse_" + obj.DiscussionID).append(USDisscussions);
                                });
                            }
                            $("#ReplyCount_" + obj.DiscussionID).text(Replycount);
                            if (flag == 'reply' + obj.DiscussionID) {
                                $("#collapse_" + obj.DiscussionID).addClass('in');
                            }
                        });
                    }
                    else {
                        $("#mainDivDisscussion").html("");
                        var USDisscussions = ""
                        USDisscussions = "<div class='col-md-6'><span style='text-align:center'> There are no items to show</span></div>"
                        $("#mainDivDisscussion").append(USDisscussions);
                    }
                }
                catch (ex) {
                    //alert(ex.message);
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
                //ShowLessMoreContent();
            }



            function ShowLessMoreContent() {
                //debugger;
                var showChar = 100;
                var ellipsestext = "...";
                var moretext = "more";
                var lesstext = "less";
                $('.more').each(function () {
                    //debugger;
                    var content = $(this).html();

                    if (content.length > showChar) {

                        var c = content.substr(0, showChar);
                        var h = content.substr(showChar, content.length - showChar);

                        var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

                        $(this).html(html);
                    }

                });

                $(".morelink").click(function () {
                    if ($(this).hasClass("less")) {
                        $(this).removeClass("less");
                        $(this).html(moretext);
                    } else {
                        $(this).addClass("less");
                        $(this).html(lesstext);
                    }
                    $(this).parent().prev().toggle();
                    $(this).prev().toggle();
                    return false;
                });
            }

            function AddNewDiscussion(DiscussionID) {
                // debugger;
                var DiscussionVal = document.getElementById("post_discuss").innerHTML;
                var DiscussionData = document.getElementById("DiscussionTextArea").value;
                var flagSR = getParameterByName('flagSR');
                //var IterationID = getParameterByName('IterationID');

                if ($("#DiscussionTextArea").val() != "") {
                    if (checkSpecialCharacter($('#DiscussionTextArea').val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Discussion should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#DiscussionTextArea").focus();
                        return false;
                    }
                }
                if (DiscussionVal == "Post") {
                    if (NewIterationID != '') {
                        IterationID = NewIterationID;
                        AddNewDiscussionSR(IterationID, flagSR, DiscussionData, 'DiscussionTextArea');
                        BindDisscussionData(flagSR, IterationID);
                        ShowLessMoreContent();
                    }
                    else {
                        var IterationID = getParameterByName('IterationID');

                        AddNewDiscussionSR(IterationID, flagSR, DiscussionData, 'DiscussionTextArea');
                        BindDisscussionData(flagSR, IterationID);
                        ShowLessMoreContent();
                    }

                }
                else if (DiscussionVal == "Reply") {
                    if (NewIterationID != '') {
                        IterationID = NewIterationID;
                        insertSprintReleaseDiscussion(IterationID, flagSR, DiscussionData, 'DiscussionTextArea', DiscussionID);
                        BindDisscussionData(flagSR, IterationID);
                        ShowLessMoreContent();
                    }
                    else {
                        var IterationID = getParameterByName('IterationID');

                        insertSprintReleaseDiscussion(IterationID, flagSR, DiscussionData, 'DiscussionTextArea', DiscussionID);
                        var flag = "reply" + DiscussionID;
                        BindDisscussionData(flagSR, IterationID, flag);
                        ShowLessMoreContent();
                    }

                }
            }

            function AddNewDiscussionSR(UniqueID, Flag, obj, txtID) {
                //debugger;
                var DiscussionID = 0;
                if ($("#DiscussionTextArea").val() != "") {
                    //Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
                    //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
                    //if ($("#DiscussionTextArea").val().length >= 2000) {
                    //    $("#DiscussionTextArea").focus();
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('Please Enter Discussion less than 2000 characters, you have entered ' + $("#DiscussionTextArea").val().length + ' characters.', 'error', 5);
                    //}
                    //else {
                    //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
                        //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478
                        var strUserResult = ajaxCall("frmSprintDetails.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));

                        document.getElementById("mainDivDisscussion").innerHTML = strUserResult.d;
                        $("#post_discuss").html('');
                        $("#post_discuss").html('Post');
                        $("#DiscussionTextArea").val('');

                        //DiscussionID = 0;
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
                    //Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
                    //}
                    //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
                    //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478
                }
                else {
                    $("#DiscussionTextArea").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please Add Discussion', 'error', 5);
                }

            }


            function insertSprintReleaseDiscussion(UniqueID, Flag, obj, txtID, DiscussionID) {
                // alert();
                //debugger;

                if ($("#DiscussionTextArea").val() != "") {
                    var strUserResult = ajaxCall("frmSprintDetails.aspx/SaveDiscussionSR", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
                    //alert(strUserResult.d);
                    if (Flag != "Iteration") {
                        //document.getElementById("mainDivDisscussion").innerHTML = strUserResult.d;
                        $("#post_discuss").html('');
                        $("#post_discuss").html('Post');
                        $("#DiscussionTextArea").val('');
                        document.getElementById("DiscussionTextArea").placeholder = "Post new Discussion..";

                        $('[data-bs-toggle="tooltip"]').tooltip();


                    }
                    else {
                        //document.getElementById("mainDivDisscussion").innerHTML = strUserResult.d;
                        $("#post_discuss").html('');
                        $("#post_discuss").html('Post');
                        $("#DiscussionTextArea").val('');
                        document.getElementById("DiscussionTextArea").placeholder = "Post new Discussion..";
                        //$("#collapse_" + obj.DiscussionID).addClass('in');
                    }

                    //  $("#FreeTextBox_editor").html('');
                    //DiscussionID = 0;
                    $('[data-bs-toggle="tooltip"]').tooltip();

                }
                else {
                    $("#DiscussionTextArea").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please Add Discussion', 'error', 5);
                }
            }
            function ajaxCall(url, type, contentType, dataType, data) {
                var ajaxResult;
                $.ajax({
                    url: url,
                    type: type,
                    contentType: contentType,
                    dataType: dataType,
                    data: data,
                    async: false,
                    success: function (result) {
                        ajaxResult = result;
                    },
                    error: function (xhr) {
                        console.log(xhr);
                    }
                })

                return ajaxResult;
            }

            function BindTable(tableID) {
                //debugger;
                $(tableID).DataTable().clear();
                //$(tableID).DataTable().fnClearTable();
                myTable = $(tableID).DataTable({
                    "deferRender": true,
                    "paging": true,
                    "lengthChange": true,
                    "info": true,
                    "autoWidth": true,
                    "sDom": 'lfrtip',
                    "searching": true,
                    "pageLength": 5,
                    ordering: false,
                    pagingType: "simple_numbers",
                    language: {
                        paginate: {
                            next: '<i class="fa fa-angle-double-right"></i>',
                            previous: '<i class="fa fa-angle-double-left"></i>'

                        }
                    }

                });
                $('[data-bs-toggle="tooltip"]').tooltip();
                myTable.clear();
                myTable.draw();

                //myTable.row.add([ ]).draw();
            }

            var arrFile = [];

            (function (window) {
                function triggerCallback(e, callback) {
                    if (!callback || typeof callback !== 'function') {
                        return;
                    }
                    var files;
                    if (e.dataTransfer) {
                        files = e.dataTransfer.files;
                    } else if (e.target) {
                        files = e.target.files;
                    }
                    callback.call(null, files);
                }

                function makeDroppable(ele, callback) {
                    var input = document.createElement('input');
                    input.setAttribute('type', 'file');
                    input.setAttribute('multiple', true);
                    input.style.display = 'none';

                    input.addEventListener('change', function (e) {
                        triggerCallback(e, callback);
                    });
                    ele.appendChild(input);

                    //ele.addEventListener('dragover', function (e) {
                    //    //e.preventDefault();
                    //    //e.stopPropagation();
                    //    //ele.classList.add('dragover');

                    //    e.stopPropagation();
                    //    e.preventDefault();
                    //    e.dataTransfer.dropEffect = 'copy';
                    //});

                    ele.addEventListener("dragover", function (e) {
                        e.stopPropagation();
                        e.preventDefault();
                        e.dataTransfer.dropEffect = 'copy';
                        //e.dataTransfer.effectAllowed = "move";
                    }, false);
                    ele.addEventListener("drop", function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        // var data = event.dataTransfer.getData("text");
                        ele.classList.remove('dragover');
                        triggerCallback(e, callback);

                    }, false);


                    ele.addEventListener('dragleave', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        ele.classList.remove('dragover');
                    });

                    //ele.addEventListener('drop', function (e) {
                    //    e.preventDefault();
                    //    e.stopPropagation();
                    //    ele.classList.remove('dragover');
                    //    triggerCallback(e, callback);
                    //});

                    ele.addEventListener('click', function () {
                        input.value = null;
                        input.click();
                    });
                    ele.addEventListener('dragstart', function (e) {
                        if (!e)
                            e = window.event;

                        dragSrcEl = (window.event) ? window.event.srcElement /* for IE */ : event.target;
                        e.dataTransfer.effectAllowed = 'copy';
                        e.dataTransfer.setData('text/html', dragSrcEl.innerHTML);
                    });

                    ele.addEventListener('dragenter', function (event) {
                        //if (event.preventDefault)
                        event.preventDefault();

                        //event.dataTransfer.dropEffect = 'move';
                        //event.stopPropagation();
                        //var data = node.childNodes[0].nodeValue;
                        ////console.log('Drag enter: "' + data + '"');
                        //return false;

                    });
                }
                window.makeDroppable = makeDroppable;
            })(this);

            function UploadData(IterationID) {
                //debugger;
                if (arrFile[0] != undefined) {
                    var formdata = new FormData();
                    formdata.append('file', arrFile[0]);
                    formdata.append('Mode', 'Upload');
                    formdata.append('IterationID', IterationID);
                    $.ajax({
                        type: 'post',
                        url: 'frmSprintDetails.aspx',
                        data: formdata,
                        async: false,
                        success: function (status) {
                            //  debugger;
                            // alert(status);
                            if (status == "Invalid") {
                                // alert("Invalid content type!");
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify("Invalid content type!", 'error', 25);
                            }
                            else {
                                document.getElementById("mainDivAttachments").innerHTML = status;
                                $('[data-bs-toggle="tooltip"]').tooltip();
                                var flagSR = getParameterByName('flagSR');
                                BindAttachementsData(IterationID, flagSR);

                                // $('.radio-inline').tooltip()
                                alertify.set('notifier', 'position', 'top-right');

                                alertify.notify('Attachment saved successfully.', 'success', 5);

                                //makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                                //    var output = document.querySelector('.demo-droppable');
                                //    output.innerHTML = '';
                                //    for (var i = 0; i < files.length; i++) {
                                //        arrFile[0] = files[i];
                                //        output.innerHTML += '<p>' + files[i].name + '</p>';
                                //    }
                                //});


                            }
                            arrFile = [];
                        },
                        processData: false,
                        contentType: false,
                        error: function (error) {
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("oops something went wrong!", 'error', 25);
                            // alert("oops something went wrong!");
                            // alert(error.status);
                            // alert(error.responseText);
                        }
                    });


                }

                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Please select file to  Upload", 'error', 25);


                }

                makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                    var output = document.querySelector('.demo-droppable');
                    output.innerHTML = '';
                    for (var i = 0; i < files.length; i++) {
                        arrFile[0] = files[i];
                        output.innerHTML += '<p>' + files[i].name + '</p>';
                    }
                });
            }
            function BindAttachementsData(IterationID, flagSR) {
                //debugger;
                $("#mainDivAttachments").html("");
                var strUserResult = ajaxCall("frmSprintDetails.aspx/AttachmentDetails", "POST", "application/json", "json",
                    JSON.stringify({ IterationID: IterationID, flagSR: flagSR }));
                if (strUserResult != null) {

                    var strArray = String(strUserResult.d).split("|");
                    var i = 0;
                    //alert(strUserResult.d);
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        //alert(strUserResult.d);
                        //debugger;
                        var strSystemFileName = obj.FilePath;
                        var OriginalFileName = obj.OriginalFileName;

                        var strOriginalFileNameNew = OriginalFileName.substr(OriginalFileName.lastIndexOf('\\') + 1);
                        var strOriginalFileName = strOriginalFileNameNew.replace(/ +/g, "");

                        //alert(strOriginalFileName);

                        var Attachments = ""
                        Attachments = "<div class='activity-row' id='Div1' style=''><div class='row'><div class='col-md-3' style='text-align: center;'><div class='form-group'>" +
                            "<p class='upload-header'>Document Name</p>" +
                            "<p class='attach-details'><a  title='Download Attachment'  onclick=Document_OnClick(\'" + strSystemFileName + obj.OriginalFileName.substring(obj.OriginalFileName.lastIndexOf(".")) + "\','" + strOriginalFileName + "') style='color:#414040;cursor:pointer;font-size: 11.5px !important;'>" + strOriginalFileNameNew + "</a></p>" +
                            "</div></div>" +
                            "<div class='col-md-3' style='text-align: center;'><div class='form-group'> " +
                            "<p class='upload-header'>Uploaded Date</p><p class='attach-details' title='Uploaded Date' style='font-size: 11.5px !important;'>" + ParseDate(obj.DateOfAttaching) + "</p></div></div>" +
                            "<div class='col-md-2' style='text-align: center;'><div class='form-group'><p class='upload-header' style='margin-left: 15px;'>Size(KB)</p><p class='attach-details' style='margin-left: 20px;font-size: 11.5px !important;' title='Size'>" + parseInt(obj.FileSize / 1024) + "</p></div></div>" +
                            "<div class='col-md-3' style='text-align: center;'><div class='form-group'><p class='upload-header'>Uploaded By</p><div style='text-align:center;' title='Uploaded By'>" +
                            // "<img src='../../Images/Photo/05774f3a.jpg' onerror='this.src='../../Images/Photo/no-photo.png'' data-bs-toggle='tooltip' title='' data-bs-original-title='Sa - SOFTWARE ENGINEER TEAM MEMBER'></div>" +
                            "<p class='attach-details' style='font-size: 11.5px !important;'>" + obj.AttachedBy + " [" + obj.Duration + "]" + "</p></div>" +
                            "</div></div>" +
                            "<div class='col-md-1'><div class='form-group'>" +
                            '<i class="fa fa-trash-o" aria-hidden="true" title="Delete Attachment" onclick="Delete_Attachment(' + obj.AttachmentID + ',' + IterationID + ',\'Userstory\',1)" style="margin-top:34px;cursor:pointer;font-size: 11.5px !important;"></i></div></div></div>' +
                            "<div class='clearfix'></div></div>"

                        $("#mainDivAttachments").append(Attachments);
                        arrFile = [];

                    });
                    //$(".demo-droppable").html("");
                    //$("#lblcaption").html("");
                    //$("#lblcaption").html(" Drop files here Or click to upload.");

                    //  $("#divDropZone").html("");
                    document.getElementById("divDropZone").innerHTML = "<div class='demo-droppable'>" +
                        "<p>Drop files here Or click to upload.</p>" +
                        "<input type='file' multiple='multiple'  style='display: none;'/>" +
                        "</div>";
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }

            var strUser = '';
            function Delete_Attachment(AttachmentID, IterationID) {
                //debugger;
                var strUserResult = ajaxCall("frmSprintDetails.aspx/DeleteAttachment", "POST", "application/json", "json", JSON.stringify({ strAttachmentID: AttachmentID, strIterationID: IterationID, strEntity: 'UserStory' }));
                //alert(strUserResult.d);
                strUser = String(strUserResult.d).split("||");

                //document.getElementById("Attachmentus").innerHTML = "";

                //document.getElementById("Attachmentus").innerHTML = strUser[1];

                $('[data-bs-toggle="tooltip"]').tooltip();

                if (strUser[1] == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strUser[0], 'error', 5);
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');

                    alertify.notify(strUser[0], 'success', 5);
                }

                var flagSR = getParameterByName('flagSR');
                BindAttachementsData(IterationID, flagSR);
                makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                    var output = document.querySelector('.demo-droppable');
                    output.innerHTML = '';
                    for (var i = 0; i < files.length; i++) {
                        arrFile[0] = files[i];
                        output.innerHTML += '<p>' + files[i].name + '</p>';
                    }
                });
            }

            function GetLineBurnUPEffortS(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {
                //debugger;
                var BurnupGraphEfforts = $("#BurnupGraphEfforts" + UniqueID);
                $("#BurnupGraphEfforts").html("");
                if (UniqueID == GrapID) {
                    BurnupGraphEfforts = $("#BurnupGraphEfforts");
                }

                var strResult, data;
                data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
                strResult = AJAXCallWithResult("frmSprintDetails.aspx/GetGetBurnUpChartGraphDetails", data, false);

                var strInRate1 = [];
                var strOutRate1 = [];
                var strOutStanding1 = [];
                var arrBackColor1 = [];
                var strLabels1 = [];
                if (strResult.d != "") {
                    // debugger;
                    $.each(JSON.parse(strResult.d), function (id, object) {
                        strLabels1.push(object["EntryDate"]);
                        strInRate1.push(object["Planned"]);
                        strOutRate1.push(object["Remained"]);
                        // strOutStanding1.push(object["OutStanding"]);



                        // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                    });

                }

                var lineChartData1 = {
                    labels: strLabels1,
                    datasets: [{
                        label: "Planned",
                        borderColor: "#55acee",
                        backgroundColor: "#55acee",
                        fill: false,
                        data: strInRate1,
                        //yAxisID: "y-axis-1",
                    }, {
                        label: "Actual Completed",
                        borderColor: "#4c66a4",
                        backgroundColor: "#4c66a4",
                        fill: false,
                        data: strOutRate1,
                        //yAxisID: "y-axis-2"
                    },

                    ]
                };
                //options
                var options = {
                    responsive: true,
                    title: {
                        display: true,
                        position: "top",
                        text: "Burn Up Chart(Efforts)",
                        fontSize: 13,
                        fontColor: "#111"
                    },
                    //Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Actual Completed") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    //if (data.datasets[tooltipItems.datasetIndex].label == "Available") {
                    //    var HMAvailableEfforts = tooltipItems.yLabel.toFixed(2);
                    //    HMAvailableEfforts = HMAvailableEfforts.toString().replace(".", ":");
                    //    return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMAvailableEfforts;
                    //}
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                        HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
                    legend: {
                        display: true,
                        position: "bottom",
                        labels: {
                            fontColor: "#333",
                            fontSize: 12
                        }
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                // autoSkip: false,
                                // maxRotation: 90,
                                // minRotation: 90
                            }
                        }],
                        yAxes: [{
                            // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                            display: true,
                            //position: "left",
                            //id: "y-axis-1",
                            ticks: {
                                min: 0
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Efforts'
                            }
                            //}, {
                            //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                            //    display: true,
                            //  //  position: "right",
                            //  //  id: "y-axis-2",
                            //    scaleLabel: {
                            //        display: true,
                            //        // labelString: 'cumulative % (0-100%)'
                            //    }
                        }],
                    }
                };

                var chart = new Chart(BurnupGraphEfforts, {
                    type: "line",
                    data: lineChartData1,
                    options: options
                });
            }

            function GetLineBurnUpStoryPoints(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {
                //debugger;
                var BurnupGraphStoryPoints = $("#BurnupGraphStoryPoints" + UniqueID);
                $("#BurnupGraphStoryPoints").html("");
                if (UniqueID == GrapID) {
                    BurnupGraphStoryPoints = $("#BurnupGraphStoryPoints");
                }

                // var ctx1 = $("#line-chartcanvas1");
                var strResult, data;
                data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
                strResult = AJAXCallWithResult("frmSprintDetails.aspx/GetBurnUpStoryPoint", data, false);

                var strInRate1 = [];
                var strOutRate1 = [];
                var strOutStanding1 = [];
                var arrBackColor1 = [];
                var strLabels1 = [];
                if (strResult.d != "") {
                    // debugger;
                    $.each(JSON.parse(strResult.d), function (id, object) {
                        strLabels1.push(object["EntryDate"]);
                        strInRate1.push(object["Planned"]);
                        strOutRate1.push(object["Remained"]);
                        // strOutStanding1.push(object["OutStanding"]);

                        // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                    });

                }

                var lineChartData1 = {
                    labels: strLabels1,
                    datasets: [{
                        label: "Planned",
                        borderColor: "#55acee",
                        backgroundColor: "#55acee",
                        fill: false,
                        data: strInRate1,
                        //yAxisID: "y-axis-1",
                    }, {
                        label: "Actual Completed",
                        borderColor: "#4c66a4",
                        backgroundColor: "#4c66a4",
                        fill: false,
                        data: strOutRate1,
                        //yAxisID: "y-axis-2"
                    },

                    ]
                };
                //options
                var options = {
                    responsive: true,
                    title: {
                        display: true,
                        position: "top",
                        text: "Burn Up Chart(Story Points)",
                        fontSize: 13,
                        fontColor: "#111"
                    },
                    legend: {
                        display: true,
                        position: "bottom",
                        labels: {
                            fontColor: "#333",
                            fontSize: 12
                        }
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                // autoSkip: false,
                                // maxRotation: 90,
                                // minRotation: 90
                            }
                        }],
                        yAxes: [{
                            // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                            display: true,
                            //position: "left",
                            //id: "y-axis-1",
                            ticks: {
                                min: 0
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Story Points'
                            }
                            //}, {
                            //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                            //    display: true,
                            //  //  position: "right",
                            //  //  id: "y-axis-2",
                            //    scaleLabel: {
                            //        display: true,
                            //        // labelString: 'cumulative % (0-100%)'
                            //    }
                        }],
                    }
                };
                var chart = new Chart(BurnupGraphStoryPoints, {
                    type: "line",
                    data: lineChartData1,
                    options: options
                });
            }
            //End of Burnup Graph

            function GetLineBurnDown(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

                //debugger;
                var ctx = $("#BurnDownGraph" + UniqueID);
                $("#BurnDownGraph").html("");
                if (UniqueID == GrapID) {
                    ctx = $("#BurnDownGraph");
                }
                var strResult, data;
                data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
                strResult = AJAXCallWithResult("frmSprintDetails.aspx/GetGraphDetails", data, false);

                var strInRate1 = [];
                var strOutRate1 = [];
                var strOutStanding1 = [];
                var arrBackColor1 = [];
                var strLabels1 = [];
                if (strResult.d != "") {
                    // debugger;
                    $.each(JSON.parse(strResult.d), function (id, object) {
                        strLabels1.push(object["EntryDate"]);
                        strInRate1.push(object["Planned"]);
                        strOutRate1.push(object["Remained"]);
                        // strOutStanding1.push(object["OutStanding"]);

                        // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                    });
                }
                var lineChartData1 = {
                    labels: strLabels1,
                    datasets: [{
                        label: "Planned",
                        borderColor: "orange",
                        backgroundColor: "orange",
                        fill: false,
                        data: strInRate1,
                        //yAxisID: "y-axis-1",
                    }, {
                        label: "Remaining",
                        borderColor: "#4cae4c",
                        backgroundColor: "#4cae4c",
                        fill: false,
                        data: strOutRate1,
                        //yAxisID: "y-axis-2"
                    },

                    ]
                };
                //options
                var options = {
                    responsive: true,
                    title: {
                        display: true,
                        position: "top",
                        text: "Burn Down Chart(Efforts)",
                        fontSize: 13,
                        fontColor: "#111"
                    },
                    //Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Remaining") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    //if (data.datasets[tooltipItems.datasetIndex].label == "Available") {
                    //    var HMAvailableEfforts = tooltipItems.yLabel.toFixed(2);
                    //    HMAvailableEfforts = HMAvailableEfforts.toString().replace(".", ":");
                    //    return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMAvailableEfforts;
                    //}
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                        HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
                    legend: {
                        display: true,
                        position: "bottom",
                        labels: {
                            fontColor: "#333",
                            fontSize: 12
                        }
                    },
                };
                var chart = new Chart(ctx, {
                    type: "line",
                    data: lineChartData1,
                    options: options
                });

            }

            //For Flow Efforts Graph
            function GetLineBurnUP(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

                // debugger;

                var ctx1 = $("#BurnUpGraph" + UniqueID);
                $("#BurnUpGraph").html("");
                if (UniqueID == GrapID) {
                    ctx1 = $("#BurnUpGraph");
                }
                // var ctx1 = $("#line-chartcanvas1");
                var strResult, data;
                data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
                strResult = AJAXCallWithResult("frmSprintDetails.aspx/GetGraphDetailsForGraph", data, false);

                var strInRate1 = [];
                var strOutRate1 = [];
                var strOutStanding1 = [];
                var arrBackColor1 = [];
                var strLabels1 = [];
                if (strResult.d != "") {
                    // debugger;
                    $.each(JSON.parse(strResult.d), function (id, object) {
                        strLabels1.push(object["EntryDate"]);
                        strInRate1.push(object["Planned"]);
                        strOutRate1.push(object["Remained"]);
                        // strOutStanding1.push(object["OutStanding"]);

                        // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                    });

                }

                var lineChartData1 = {
                    labels: strLabels1,
                    datasets: [{
                        label: "Planned",
                        borderColor: "orange",
                        backgroundColor: "orange",
                        fill: false,
                        data: strInRate1,
                        //yAxisID: "y-axis-1",
                    }, {
                        label: "Remaining",
                        borderColor: "#4cae4c",
                        backgroundColor: "#4cae4c",
                        fill: false,
                        data: strOutRate1,
                        //yAxisID: "y-axis-2"
                    },

                    ]
                };
                //options
                var options = {
                    responsive: true,
                    title: {
                        display: true,
                        position: "top",
                        text: "Burn Down Chart(Story Points)",
                        fontSize: 13,
                        fontColor: "#111"
                    },
                    legend: {
                        display: true,
                        position: "bottom",
                        labels: {
                            fontColor: "#333",
                            fontSize: 12
                        }
                    },
                };

                var chart = new Chart(ctx1, {
                    type: "line",
                    data: lineChartData1,
                    options: options
                });
            }
            //End of BurnDown Graph

            //For Velocity Bar Graph
            //var preChartVelocityStoryBar;
            //function GetLineVelocityStoryBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            //    //var VelocitySToryPoints = document.getElementById("VelocitySToryPoints" + UniqueID).getContext("2d");

            //    var VelocitySToryPoints = $("#VelocitySToryPoints" + UniqueID);
            //    $("#VelocitySToryPoints").html("");
            //    if (UniqueID == GrapID) {
            //        VelocitySToryPoints = $("#VelocitySToryPoints");
            //    }
            //    var strResult, data;

            //    data = JSON.stringify({ strGraphFilter: "Storypoint", UniqueID: UniqueID });

            //    console.log(data)
            //    strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetVelocityData", data, false);
            //    var strEntityCount = [];
            //    var PercentCount = [];
            //    var arrBackColor = [];
            //    var strLabels = [];
            //    if (strResult.d != "") {

            //        $.each(JSON.parse(strResult.d), function (id, object) {
            //            strLabels.push(object["IterationName"]);
            //            strEntityCount.push(object["Velocity"]);
            //            PercentCount.push(object["Efforts"]);
            //            // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
            //        });

            //    }

            //    var config1 = {
            //        type: 'bar',
            //        data: {
            //            labels: strLabels,
            //            datasets: [{
            //                type: 'bar',
            //                label: 'Velocity',
            //                backgroundColor: [
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)"
            //                ],
            //                borderColor: [
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)"
            //                ],
            //                borderWidth: 1,
            //                //fill: false,
            //                data: strEntityCount,
            //                // yAxisID: "y-axis-2",
            //            }, {

            //                type: 'bar',
            //                label: 'Efforts',
            //                // data: PercentCount,
            //                backgroundColor: [
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)"
            //                ],
            //                borderColor: [
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)"
            //                ],
            //                borderWidth: 1,
            //                data: PercentCount,
            //                //  borderColor: 'white',
            //                // borderWidth: 2,
            //                // yAxisID: "y-axis-1",
            //            }]
            //        },

            //    };


            //    var options = {
            //        responsive: true,
            //        title: {
            //            display: true,
            //            position: "top",
            //            text: "Velocity Bar Graph(Story Points)",
            //            fontSize: 13,
            //            fontColor: "#111"
            //        },
            //        legend: {
            //            display: true,
            //            position: "bottom",
            //            labels: {
            //                fontColor: "#333",
            //                fontSize: 12
            //            }
            //        },
            //        //scales: {
            //        //    yAxes: [{
            //        //        ticks: {
            //        //            min: 0
            //        //        }
            //        //    }]
            //        //},
            //        //scaleLabel: {
            //        //    display: true,
            //        //    labelString: 'Story Points'
            //        //}
            //        scales: {
            //            xAxes: [{
            //                ticks: {
            //                    // autoSkip: false,
            //                    // maxRotation: 90,
            //                    // minRotation: 90
            //                }
            //            }],
            //            yAxes: [{
            //                // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            //                display: true,
            //                //position: "left",
            //                //id: "y-axis-1",
            //                ticks: {
            //                    min: 0
            //                },
            //                scaleLabel: {
            //                    display: true,
            //                    labelString: 'Story Points'
            //                }
            //                //}, {
            //                //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            //                //    display: true,
            //                //  //  position: "right",
            //                //  //  id: "y-axis-2",
            //                //    scaleLabel: {
            //                //        display: true,
            //                //        // labelString: 'cumulative % (0-100%)'
            //                //    }
            //            }],
            //        }
            //    };

            //    // Remove the old chart and all its event handles
            //    if (preChartVelocityStoryBar) {
            //        preChartVelocityStoryBar.destroy();
            //    }

            //    // // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
            //    var temp = jQuery.extend(true, {}, config1);
            //    temp.type = 'bar';
            //    temp.options = options;
            //    preChartVelocityStoryBar = new Chart(VelocitySToryPoints, temp);
            //};


            //var preChartVelocity;
            //function GetLineVelocityEffortBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            //    //var VelocityEffortBar = document.getElementById("VelocityEffortBar" + UniqueID).getContext("2d");

            //    var VelocityEffortBar = $("#VelocityEffortBar" + UniqueID);
            //    $("#VelocityEffortBar").html("");
            //    if (UniqueID == GrapID) {
            //        VelocityEffortBar = $("#VelocityEffortBar");
            //    }
            //    var strResult, data;

            //    data = JSON.stringify({ strGraphFilter: "Effort", UniqueID: UniqueID });

            //    console.log(data)
            //    strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetVelocityData", data, false);
            //    var strEntityCount = [];
            //    var PercentCount = [];
            //    var arrBackColor = [];
            //    var strLabels = [];
            //    if (strResult.d != "") {

            //        $.each(JSON.parse(strResult.d), function (id, object) {
            //            strLabels.push(object["IterationName"]);
            //            strEntityCount.push(object["Velocity"]);
            //            PercentCount.push(object["Efforts"]);
            //            // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
            //        });

            //    }
            //    //  alert(strEntityCount)
            //    //   alert(PercentCount)
            //    var config1 = {
            //        type: 'bar',
            //        data: {
            //            labels: strLabels,
            //            datasets: [{
            //                type: 'bar',
            //                label: 'Velocity',
            //                backgroundColor: [
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)",
            //                      "rgba(10,20,30,0.3)"
            //                ],
            //                borderColor: [
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)",
            //                    "rgba(10,20,30,1)"
            //                ],
            //                borderWidth: 1,
            //                //fill: false,
            //                data: strEntityCount,
            //                // yAxisID: "y-axis-2",
            //            }, {

            //                type: 'bar',
            //                label: 'Efforts',
            //                // data: PercentCount,
            //                backgroundColor: [
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)",
            //                    "rgba(50,150,200,0.3)"
            //                ],
            //                borderColor: [
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)",
            //                    "rgba(50,150,200,1)"
            //                ],
            //                borderWidth: 1,
            //                data: PercentCount,
            //                //  borderColor: 'white',
            //                // borderWidth: 2,
            //                // yAxisID: "y-axis-1",
            //            }]
            //        },

            //    };


            //    var options = {
            //        responsive: true,
            //        title: {
            //            display: true,
            //            position: "top",
            //            text: "Velocity Bar Graph(Effort)",
            //            fontSize: 13,
            //            fontColor: "#111"
            //        },
            //        legend: {
            //            display: true,
            //            position: "bottom",
            //            labels: {
            //                fontColor: "#333",
            //                fontSize: 12
            //            }
            //        },
            //        //scales: {
            //        //    yAxes: [{
            //        //        ticks: {
            //        //            min: 0
            //        //        }
            //        //    }]
            //        //},
            //        //scaleLabel: {
            //        //    display: true,
            //        //    labelString: 'Story Points'
            //        //}
            //        scales: {
            //            xAxes: [{
            //                ticks: {
            //                    // autoSkip: false,
            //                    // maxRotation: 90,
            //                    // minRotation: 90
            //                }
            //            }],
            //            yAxes: [{
            //                // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            //                display: true,
            //                //position: "left",
            //                //id: "y-axis-1",
            //                ticks: {
            //                    min: 0
            //                },
            //                scaleLabel: {
            //                    display: true,
            //                    labelString: 'Efforts'
            //                }
            //                //}, {
            //                //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            //                //    display: true,
            //                //  //  position: "right",
            //                //  //  id: "y-axis-2",
            //                //    scaleLabel: {
            //                //        display: true,
            //                //        // labelString: 'cumulative % (0-100%)'
            //                //    }
            //            }],
            //        }
            //    };

            //    // Remove the old chart and all its event handles
            //    if (preChartVelocity) {
            //        preChartVelocity.destroy();
            //    }

            //    // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
            //    var temp = jQuery.extend(true, {}, config1);
            //    temp.type = 'bar';
            //    temp.options = options;
            //    preChartVelocity = new Chart(VelocityEffortBar, temp);
            //};
            //End  of  Velocity Bar Graph

            var AjaxResult;
            function AJAXCallWithResult(url, data, async) {
                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    async: async,
                    success: function (result) {
                        AjaxResult = result;

                    },
                    error: function (error) {
                        // alert(Error);
                    }
                });

                return AjaxResult;
            }

            function Export_PDFClick() {
                //debugger;
                format = 'PDF';

                if (NewIterationID != '') {
                    IterationID = NewIterationID;
                    var flag = getParameterByName('flagSR');
                    Export_onclick(flag, format, IterationID);

                }
                else {
                    var IterationID = getParameterByName('IterationID');
                    var flag = getParameterByName('flagSR');
                    Export_onclick(flag, format, IterationID);
                }
            }

            function Export_ExcelClick() {
                //debugger;
                format = 'Excel';

                if (NewIterationID != '') {
                    IterationID = NewIterationID;
                    var flag = getParameterByName('flagSR');
                    Export_onclick(flag, format, IterationID);

                }
                else {
                    var IterationID = getParameterByName('IterationID');
                    var flag = getParameterByName('flagSR');

                    Export_onclick(flag, format, IterationID);
                }
            }


            function Export_onclick(flag, format, EntityID) {
                var objform;
                format = format.toUpperCase();
                var strExportResult = ajaxCall("frmSprintDetails.aspx/ExportToExcel", "POST", "application/json", "json", JSON.stringify({ ReportFormat: format, Entity: flag, EntityID: EntityID }));

                if (strExportResult.d != "") {
                    //alert(strExportResult.d);
                }
                window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strExportResult.d, "_report", "");
            }

            function Document_OnClick(strSystemFileName, strOriginalFileName) {
                // alert(strSystemFileName);
                // alert(strOriginalFileName);
                // debugger;

                var strTemp = '../General/ViewAttachment.aspx?FromWhere=Agile&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;
                window.open(strTemp);
            }

    /*End of Added By Ankush T on 04-07-2018*/
        </script>
    </form>
</body>
</html>
