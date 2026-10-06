<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserStoryDetails.aspx.vb" Inherits="Whizible.UserStoryDetails" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
<%--    <title></title>
     <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=11" /> 
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

<%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="assets/js/dragdrop.js"></script>
    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
  <%--  <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/editor.js"></script>
<%--    <script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="js/CommonJS.js?v=1.21"></script>
<%--    <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
    <script src="assets/js/jquery-progresspiesvg-min.js"></script>
    <script src="assets/js/progresspiesvgAppl-min.js"></script>
    

</head>

    <style>
            /*Added By Dipali V On 10th May 2019 For Reviewee & Reviwer List height*/
            #uiRevieweeList {
                height:150px;
                overflow:auto;

            }
        
            #uiReviewerList {
                height: 150px;
                overflow: auto;
            }
            /*End of Added By Dipali V On 10th May 2019 For Reviewee & Reviwer List height*/
            #divTaskList .form-control[readonly], #divReviewForm .form-control[readonly]{
                cursor: auto !important;
            }
            .tab-pane {
                background-color: white;
            }

            a:hover, a:focus {
                outline: none;
                text-decoration: none;
            }

            .tab .nav-tabs {
                /*background: #fff;*/
                border: none;
            }

                .tab .nav-tabs li {
                    margin: 0 4px 10px 0;
                    border: none;
                    text-align: center;
                }

                    .tab .nav-tabs li a {
                        padding: 7px 30px;
                        font-size:12px;
                        /* font-weight: 600; */
                        color: #fff;
                        /* text-transform: uppercase; */
                        background: #0288D1;
                        border: none;
                        border-top: 2px solid #0288D1;
                        border-bottom: 2px solid #0288D1;
                        margin-right: 0;
                        border-radius: 0;
                        position: relative;
                        transition: all 0.3s ease 0s;
                    }

                        .tab .nav-tabs li a:hover {
                            background: #ff9420;
                            border-color: #ff9420;
                        }

                    .tab .nav-tabs li a.active {
                        background: #fff;
                        color: #ff9420;
                        border: none;
                        /*border-top: 2px solid #ff9420;*/
                        border-bottom: 2px solid #ff9420;
                    }

            .tab .tab-content {
                font-size:11.5px;
                /* Modified By Madhuri.K On 01-04-2026 */
                color: #737271;
                line-height: 30px;
                /*padding: 10px 0;*/
            }
            /*@media only screen and (max-width: 1653px){
            .tab .nav-tabs li a{ padding: 15px 47px; }
            }*/
            /*Added by swapna 17-7-2018*/
            @media only screen and (max-width: 1653px) {
                .tab .nav-tabs li a {
                    /* padding: 11px 25.60px; */
                    padding: 3px 15px;
                }
            }

            @media only screen and (max-width: 1219px) {
                .tab .nav-tabs li a {
                    /* padding: 15px 20px; */
                    padding: 3px 15px;
                }
            }

            @media only screen and (max-width: 1150px) {
                .tab .nav-tabs li a {
                    /* padding: 15px 17px; */
                    padding: 3px 15px;
                }
            }

            @media only screen and (max-width: 480px) {
                .tab .nav-tabs li {
                    padding: 15px 12px;
                }
            }

            @media only screen and (max-width: 990px) {
                .tab .nav-tabs li a {
                    padding: 15px 4px;
                }
            }

            @media only screen and (max-width: 950px) {
                .tab .nav-tabs li a {
                    padding: 15px 10px;
                }
            }

            @media only screen and (max-width: 767px) {
                .tab .nav-tabs li a {
                    padding: 15px 2px;
                }
            }
            /*End by swapna 17-7-2018*/
            .form-control {
                display: block;
                width: 100%;
                height: 34px;
                margin-bottom: 10px;
                padding: 6px 12px;
                font-size: 12px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff !important;
                background-image: none;
                border-top: 0px !important;
                border-right: 0px !important;
                border-left: 0px !important;
                border-bottom: 1px solid #ccc !important;
                border-radius: 0px !important;
                box-shadow: none !important;
            }

            .btn-default {
                /*color: grey;*/
                background-color: #d4d4d478;
                border-color: #8c8c8c1f;
            }

            .required {
                font-size: 18px !important;
                color: red !important;
            }

            .fa {
                margin-right: 5px !important;
                display: inline-block;
            }

            .fa-trash-o {
                color: red;
            }

            hr {
                margin-left: -6px;
                padding-left: -12px;
                width: 48px;
                margin-top: -3px;
                /* margin-bottom: 20px; */
                border: 0;
                border-top: 2px solid #eee;
            }

            .btn-group > .btn-group:first-child:not(:last-child) > .dropdown-toggle {
                display: none;
            }
            /*.btn-group > .btn-group:last-child:not(:first-child) > .btn:first-child {
                display:none;
            }*/
            .btn-group > .btn:not(:first-child):not(:last-child) > .dropdown-toggle {
                display: none;
            }

            .demo-droppable {
                /* background: #08c; */
                /*Comment Added by swapna*/
                /*color: white !important;*/
                /*Comment Added by swapna*/
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
                font-size: 12px;
                font-weight: 600;
                /*color: #808080d1 !important;*/
            }
                    
            .tickmark {
                color: #22af81;
                font-size: 17px;
            }

            .dataTables_length {
                display: none;
            }

            #example_filter {
                display: none;
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
                padding: 10px;
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
                color: #368ce0 !important;
                font-size: 15px !important;
                font-weight: 500 !important;
            }

            img {
                border-radius: 50%;
                width: 50px;
                height: 50px;
            }

            .bootstrap-select.btn-group .dropdown-toggle .filter-option {
                color: white !important;
            }

            .bootstrap-select {
                width: 65% !important;
            }

            @media only screen and (max-width: 1024px) {
                .bootstrap-select {
                    width: auto !important;
                }
            }

            .attach-details {
                /* color: #8080809e !important;*/
                font-size: 15px !important;
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
                color: #1ab394;
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

            .team_cards {
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

            a {
                color: #737271;
                font-size: 11.5px;
            }

            .dataTables_filter {
                display: none;
            }

            .clsDiscussion {
                height: 25px;
                border-bottom: 2px solid rgb(60, 141, 188) !important;
                line-height: 1;
                font-size: 14px !important;
                /*padding-bottom: 4%;*/
            }


            /* Added by Swapna*/
            .dataTables_filter {
                display: none;
            }

            #tblShowSubUserStory_paginate {
                float: right;
            }

            #tblShowHistory_paginate {
                float: right;
            }

            #tblShowIssues_paginate {
                float: right;
            }

            #tblShowReviews_paginate {
                float: right;
            }
            /*#tblShowTasks_paginate {
                float: right;
            }*/
            #tblTestCaseList_paginate {
                float: right;
            }
            /*td {
                word-break: break-all;
            }*/
            /*p{
                word-break: break-all;
            }*/
            #lblUserStoryName {
                word-break: break-all;
            }

            .message, .DissComment {
                word-break: break-all;
            }

            /*a {
                color: #0254EB;
            }*/

            /*a:visited {
                    color: #0254EB;
                }*/

            /*a.morelink {
                    text-decoration: none;
                    outline: none;
                }*/

            .morecontent span {
                display: none;
            }

            .DissComment, .message {
                /*width: 400px;
                /*background-color: #f0f0f0;*/
                /*margin: 10px;*/
            }
            /*End*/
            /*Added by swapna*/
            .progresspie-foreground {
                stroke: #22af81 !important;
            }

            /*.dataTables_wrapper {
                margin-right: -15px;
                margin-left: -15px;
            }*/

            #tblShowHistory tr td:nth-child(3) {
                word-break: break-all;
                width: 20%;
            }

            #tblShowHistory tr td:nth-child(4) {
                word-break: break-all;
                width: 30%;
                text-align: left;
            }

            #tblShowHistory tr td:nth-child(5) {
                word-break: break-all;
                width: 30%;
                text-align: left;
            }

            #tblShowIssues tr td:nth-child(5) {
                word-break: break-all;
                width: 20%;
            }

            #tblShowIssues tr td:nth-child(6) {
                word-break: break-all;
                width: 30%;
                text-align: left;
            }


            #tblShowSubUserStory td, th {
                text-align: center;
            }

            #tblShowSubUserStory tr td:nth-child(2) {
                word-break: break-all;
                width: 30%;
                text-align: left;
            }

            #tblShowIssues td, th {
                text-align: center;
            }


            #tblShowHistory td, th {
                text-align: center;
            }

            #tblShowReviews td, th {
                text-align: center;
            }

            #tblTestCaseList td, th {
                text-align: center;
            }
            #tblTestCaseList tr td:nth-child(4) {
            
                text-align: left;
            }

            /*end by swapna*/
            .fixed {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
            }


            /*Added by Usha Pandit on 18 july 2018 for issue - Previous and next link get disappear on hover*/
            .pagination .page-item previous {
                display: none !important;
            }

            .pagination .page-item next {
                display: none !important;
            }

            .breadcrumb, .pagination {
                display: -webkit-box;
                display: -ms-flexbox;
                border-radius: .25rem;
                list-style: none;
            }
                /*.pagination {
                    display: flex;
                    padding-left: 0;
                }

                .pagination-lg .page-link {
                    padding: .75rem 0;
                    font-size: 1.25rem;
                    line-height: 1.5;
                }

                .pagination-lg .page-item:first-child .page-link {
                    border-top-left-radius: .3rem;
                    border-bottom-left-radius: .3rem;
                }

                .pagination-lg .page-item:last-child .page-link {
                    border-top-right-radius: .3rem;
                    border-bottom-right-radius: .3rem;
                }

                .pagination-sm .page-link {
                    padding: .25rem 0;
                    font-size: .875rem;
                    line-height: 1.5;
                }*/

                .pagination > li > a, .pagination > li > span {
                    text-decoration: none;
                    border: none !important;
                    border-radius: 20px;
                    color: #0288D1 !important;
                }

                .pagination > .active > a {
                    background-color: #0288D1 !important;
                    color: #fff !important;
                }

                .pagination > li > a:hover {
                    color: #fff !important;
                    text-decoration: none;
                    background-color: #0288D1 !important;
                    border: none !important;
                    border-radius: 20px;
                }

                .pagination .page-item previous {
                    display: none !important;
                }

                .pagination .page-item next {
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

            ::-webkit-scrollbar {
                display: none !important;
                
                /*background-color:transparent!important;*/
            }
            ::-webkit-scrollbar-track {
                display: none !important;
                
            }


            body {
                -ms-overflow-style: none;
            }
            /*End of Added by Usha Pandit on 18 july 2018 for issue - Previous and next link get disappear on hover*/
            /*Added by swapna*/
            .pagination > li:first-child > a, .pagination > li:first-child > span {
                display: none;
            }

            .pagination > li:last-child > a, .pagination > li:last-child > span {
                display: none;
            }
            /*Changed By Yasmin On 10-9-19 for Graph display purpose*/
            .chartjs-render-monitor {
                width: 788px !important;
                height: 480px !important;
                display:block;
            }

            .tool-tip {
                display: inline-block;
                width: 100% !important;
            }

                .tool-tip [disabled] {
                    pointer-events: none;
                }

            #content browser {
                margin-right: -17px !important;
                margin-bottom: -17px !important;
                overflow-y: scroll;
                overflow-x: hidden;
            }

            html, body {
                padding: 0;
                margin: 0;
                overflow: hidden;
                overflow: -moz-scrollbars-none;
                background-color: #fff;
            }

            #container {
                position: absolute;
                left: 0;
                top: 0;
                right: -30px;
                bottom: 0;
                padding-right: 15px;
                overflow-y: scroll;
            }

            .center {
                margin: auto;
                width: 60%;
                padding: 10px;
            }
            .tooltip-inner {
            font-size:12px!important;
            word-break:normal;
            }
            /*select::-ms-expand {
            display: none;
            
            }*/
                
            /*select::-ms-expand {
                display: inline-block;
            }*/ 
            /*select{ 
                -webkit-appearance: none;
                -moz-appearance: none;}
            .select-container {position:relative; display: inline;}*/
            /*.no-scroll::-moz-scrollbars {display:none!important;}*/
            /*End by swapna*/

            .label-warning {background-color: #f0ad4e;}
            .label {
            display: inline;
            padding: 0.2em 0.6em 0.3em;
            font-size: 75%;
            font-weight: 700;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25em;
        }
        .nav.nav-pills{height:20px}
        .nav.nav-pills li{width:120px;margin-bottom:5px}
        .nav-pills > li > a.active, .nav-pills > li > a:hover, .nav-pills > li > a:focus {color: #fff;background-color: #428bca;}
        #Section1 .col-md-12{display:flex}
        .Editor-editor:focus-visible{outline:0;padding: 1% 2%!important;}
        .caret {display: inline-block;width: 0;height: 0;margin-left: 2px;vertical-align: middle;border-top: 4px solid;border-right: 4px solid transparent;border-left: 4px solid transparent;}
        #divIssueForm .form-group, #divReviewForm .form-group, #divTaskForm .form-group{display:flex}

        /*Added by Ashwini M on 31-3-2023*/     
        .paginate_button.current {
            background-color: #0288D1 !important;
            color: #fff !important;
        }

        .paginate_button {
            text-decoration: none;
            border: none !important;
            border-radius: 20px;
            color: #0288D1 !important;
            padding: 5px 10px;
        }
        .paginate_button:hover {
            color: #fff !important;
            text-decoration: none;
            background-color: #0288D1 !important;
            border: none !important;
            border-radius: 20px;
            padding: 5px 10px;
        }
        .paginate_button.previous, .paginate_button.next{display:none}
        #divSubstoryForm .form-group{display:flex}
        /*End of Added by Ashwini M on 31-3-2023*/

        /*Added by pradip on 13-4-2023*/
        #tblShowTasks td {position: relative;}
        #tblShowTasks span.d-inline-block {
            padding: 0;
            background: transparent;
            position: relative;
        }

        #tblShowTasks td i.fa-calendar-check{position: absolute;
            right: 0;
            bottom: 18px;
        }
        /* Added By Gauri On 02nd Sep 2024 For Alignment Issue */
        #divTabs .tabs {
            width: 100%;
        }
        @media only screen and (min-width: 992px) and (max-width: 1240px){
            #search_table, #search_table_Issues, #search_table_Reviews, #search_table_History, #search_test{
                margin-top: 0;
            }
        }
        .btn-search {
            /* padding: 8px; */
            height: 34px;
        }
        /* End of Added By Gauri On 02nd Sep 2024 For Alignment Issue */
        
        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        .btn-success {
            color: #fff;
            background: #198754;
            border-color: #198754;
        }
        .btn-success:hover {
            color: #fff;
            background: #157347;
            border-color: #157347;
        }
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */

        /* Added By Gauri On 06th Sep 2024 For Alignment Issue */x
        #divSubstoryForm label{
            font-size: 14px;
        }
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
        .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
            border: 1px solid #dad55e !important;
            background: #fffa90 !important;
            color: #777620 !important;
        }
        #post_discuss{
            color: #fff !important;
        }
        .nav.nav-pills li {
            /* width: 120px; */
            height: 50px;
        }
        .nav-pills > li > a.active, .nav-pills > li > a:hover, .nav-pills > li > a:focus {
            color: #fff !important;
            height: 50px;
            width: 125px;
        }
        .nav > li > a {
            line-height: 40px;
            font-size: 11.5px;
            font-weight: 400;
        }
        /* #ui-datepicker-div + .bs-tooltip-auto {
            display: none;
        } */
        /* End of Added By Gauri On 06th Sep 2024 For Alignment Issue */

    </style>
    <!-- <body  class="clsBody" style=""> -->
    <!-- Added By Gauri On 02nd Sep 2024 For Alignment Issue -->
    <body  class="" style="">
    <!-- End of Added By Gauri On 02nd Sep 2024 For Alignment Issue -->
    <form id="form1" runat="server" style="margin-bottom: 10px;margin-top: 20px;">
        <div id="container" style="margin-top: 2%;  margin-left: 0%;  margin-right: 1%;padding-bottom: 2%;">


            <div class="container-fluid" >
               <%-- Added by swapna 17-7-2018--%>
               <%-- <div class="row" style="margin-right:-130px">--%>
                <div class="row">
                 <%-- End by swapna 17-7-2018--%>
                    <div class="container-fluid" style="padding-bottom:20px">
                    <div class="row" >
                        <div class="col-md-12" style="display:flex">
                        <div class="col-sm-1">
                            <div style="height: 50px; width: 50px; position: relative;">
                                <i class="fa fa-certificate" aria-hidden="true" style="font-size: 60px; color: #FFB6C1;"></i>
                                <p id="txtUserStoryID" style="color: white; font-weight: 600; font-size: 14px; position: absolute; top: 19px; left: 5px; transform: translate(20%,0); text-align: center;" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="User story ID"><%= intUserStoryID%></p>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <%--<p style="font-size: 16px; font-weight: 500;"><span id="lblUserStoryName" class="userstoryname" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="User Story Name"><%= strFeatureName %></span></p>--%>
                              <span style="font-size: 16px; font-weight: 500;"  id="lblUserStoryName" class="userstoryname" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="User Story Name"><%= strFeatureName %></span><br/>
                            <div class="">
                            <label id="lblCreatedBy" style="white-space: nowrap; font-weight: normal; font-size: 11px">Created By: <%= strCreatedBy%> On <%= strCreatedDate %></label>
                            <p id="lblRank" class="label label-warning" style="font-weight: 600; font-size: 14px; margin-left: 9px;" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Rank"><%= strInitialRank %></p>
                                </div>
                        </div>
                        <div class="col-sm-3" >
                            <div class="row" style="display: flex;justify-content: flex-end;">
                            <p style="color: orange; font-weight: 600; font-size: 11.5px;text-align:right;margin-right:60px">Change the Stage</p>
                           </div>
                            <%--<button id="btnStatus" type="button" class="btn btn-success"  ><%= strStatus %></button>--%>
                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_sel_tbl_NG2_ScrumStages " & Session("intProjectID") & ",0,0", , strStatus, "class=' btn-primary' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, )%>--%>
                           <div class="row" style="display: flex;justify-content: flex-end;">
                               <div class="col-sm-12" style="text-align:right">
                             <div class="btn-group">
                                <button type="button" style="" class="btn btn-success" id="btnStatus_<%= intUserStoryID %>" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Current Status">Status</button>
                                <button type="button" id="btnDropDown_<%= intUserStoryID%>" class="btn btn-success dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" id="StatusDropDown_<%= intUserStoryID%>">
                               
                                </ul>
                            </div>
                                <input type="button" class="btn btn-info" onclick="Back_click()" name="Back"  value="Back" style="margin-left: 5px;" />
 <%--<button style="margin-left: 5px;" type="button" class="btn btn-primary" onclick="window.open('frmProductBacklog.aspx','_self');" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Back">Back</button>--%>
                        </div>
                               </div>
                           </div>
                        
                        <%--<div class="col-sm-1">
                            <ul class="pager" style="margin-top: 29px;">

                                <li class="next" onclick="window.open('frmProductBacklog.aspx','_self');"><a href="#" style="color: white; background-color: #0288D1;" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Go To Previous Page"><span>&nbsp;</span>Back</a></li>
                            </ul>
                        </div>--%>
                    </div>
                   </div>

                    
                        <div class="row">
                            <div class="col-md-12">
                                <div id="divTabs"  class="tab" role="tabpanel">
                                    <!-- Nav tabs -->
                                     <ul id="uiTabs" class="nav nav-tabs  sticky" role="tablist" style="display: inline-flex;z-index:10"  id="myHeader">
                                        <li role="presentation"><a href="#Section1" class="active" aria-controls="home" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(Section1)">Details</a></li>
                                        <li role="presentation"><a href="#SectionSubUserStory" aria-controls="profile" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionSubUserStory)">Substories</a></li>
                                        <li role="presentation"><a href="#SectionAttachments" aria-controls="messages" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionAttachments)">Attachments</a></li>
                                        <li role="presentation"><a href="#SectionDiscussion" aria-controls="profile" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionDiscussion)">Discussion</a></li>
                                        <li role="presentation"><a href="#SectionTeams" aria-controls="messages" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionTeams)">Teams</a></li>
                                        <li role="presentation"><a href="#SectionHistory" aria-controls="profile" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionHistory)">History</a></li>
                                        <li role="presentation"><a href="#SectionIssues" aria-controls="messages" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionIssues)">Issues</a></li>
                                        <li role="presentation"><a href="#SectionReviews" aria-controls="profile" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionReviews)">Reviews</a></li>
                                          <li role="presentation"><a href="#SectionTask" aria-controls="messages" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionTask)">Task</a></li>
                                        <li role="presentation"><a href="#SectionCharts" aria-controls="messages" role="tab" data-bs-toggle="tab" onclick="ReFreshTab(SectionCharts)">Charts</a></li>
                                        <li role="presentation"><a href="#SectionTestCase" aria-controls="profile" role="tab" data-bs-toggle="tab" style="white-space: nowrap;" onclick="ReFreshTab(SectionTestCase)">Test Case</a></li>

                                    </ul>
                                    <!-- Tab panes -->
                                    <div class="tab-content tabs" >
                                        <%--Commented & Added By Dipali V On 28th March 2023 For Details should diplay by default--%>
                                        <%--<div role="tabpanel" class="tab-pane fade in active"  id="Section1" style="background-color: white;padding-right: 13px;" >--%>
                                        <div role="tabpanel" class="tab-pane fade in active show"  id="Section1" style="background-color: white;padding-right: 13px;" >
                                        <%--End of Commented & Added By Dipali V On 28th March 2023 For Details should diplay by default--%>
                                            <%--    <h3>Section 1</h3>--%>


                                            <div class="row">

                                                <div class="col-md-9" id="frmDetails">
                                                    <div class="row">
                                                        <div class="col-md-11">
                                                        </div>
                                                        <div class="col-md-1" id="divAddDeleteUS" style="display: none;">
                                                            <i data-bs-toggle="tooltip" title="" onclick="Update_UserStory()" class="fa fa-save" data-original-title="Save" style="cursor:pointer;font-size: 17px;"></i><i id="DeleteUserStory" class="fas fa-trash-alt"  data-bs-toggle="tooltip" data-bs-placement="bottom" title="" data-original-title="Delete User Story" style="cursor:pointer;font-size: 17px;"></i>
                                                            <hr>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                       <div class="col-md-12" id="divUserStoryName" style="display: none;margin-bottom: -15px;">
                                                            <label class="col-md-2 control-label labelcls" style="font-weight: normal;margin-right: -40px;" for="txtFeatureName">User Story<span class="required">*</span></label>
                                                            <div class="col-md-10 ">
                                                                <%--<input id="txtUserStoryName" type="Textbox" class="form-control" value="">--%>
                                                             <% CommonFunctions.HTMLControls.DrawTextArea("txtFeatureName", "txtFeatureName", , "form-control", , , , , , , , strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownFN,200)'", , )%>
                                                               <small name="countdownFN" id="countdownFN" style="color: black;float:right;margin-bottom: -30px;"><%= len %></small>
                                                              <%--<% CommonFunctions.HTMLControls.DrawTextArea("txtFeatureName", "txtFeatureName", , "form-control", , , , , , , , , , , ,IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), False, True) , , , "onkeyup='javascript:limitText(this,countdownFN,200)' onKeyUp='javascript:limitText(this,countdownFN, 200)' data-autoresize", , )%>--%>
                                                         <%-- Commented by Swapna--%>
                                                                <%-- <span class="input-group-addon "></span><small name='countdownFN' Id='countdownFN'> " & len & " </small>--%>
                                                       <%--   End Comment by Swapna--%>
                                                                  </div>
                                                        </div>
                                                         <div class="" id="divDescription" style="display: none;    margin-bottom: 2%;" data->
                                                            <br />
                                                            <label class="col-md-4 control-label labelcls" style="font-weight: normal;">Description <span class="required">*</span></label>
                                                            <div class="col-md-12 ">
                                                                <div id="txtEditor"></div>
                                                            </div>
                                                        </div>
                                                       
                                                      
                                                      <div class="col-md-6" id="divBusinessValue" style="display: none;"> 
                                                          <label class="col-md-4 control-label" style="white-space: nowrap;margin-top: 11px;font-weight: normal;">Business Value</label>  
                                                          <div class="col-md-8 ">
                                                              <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtBusinessValue", "txtBusinessValue", "form-control", , 100, , , , ,  IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), False, True), , , "onkeyup=ClearSpan('strBusinesValue','strBusinesValue')", , , , , , , )%>--%>
                                                             <%CommonFunctions.HTMLControls.DrawTextBox("txtBusinessValue", "txtBusinessValue", "form-control", , 100, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), False, True), , , "onkeyup=ClearSpan('strBusinesValue','strBusinesValue')", , , , , , , )%>
                                                               <span id="spanBusinessValue" style="color: #dd1037; font-size: 12px;"></span>

                                                          </div>

                                                      </div>
                                                      <div class="col-md-6" id="divComplexity" style="display: none;">
                                                           <label class="col-md-4 control-label labelcls" style="font-weight: normal;    margin-top: 11px;">Complexity</label>  
                                                          <div class="col-md-8 ">
                                                             <%CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, ) %>
                                                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , , "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') ", True, )%>--%>
                                                              <span id="spanComplexity" style="color: #dd1037; font-size: 12px;">
                                                              </span>

                                                          </div>

                                                      </div>
                                                        <div class="col-md-6" id="divState" style="display: none;"  >
                                                            <label class="col-md-4 control-label" style="white-space: nowrap; margin-top: 11px;font-weight: normal;">State</label>
                                                            <div class="col-md-8 ">
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), "", "disabled"), True, )%>
                                                                  <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , , "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') ", True, )%>--%>
                                                                <span id="spanState" style="color: #dd1037; font-size: 12px;"></span></div>
                                                        </div>
                                                      <div class="col-md-6" id="divVersion" style="display: none;">
                                                            <label class="col-md-4 control-label" style="white-space: nowrap; margin-top: 11px;font-weight: normal;">Version</label>
                                                            <div class="col-md-8 ">
                                                               <%CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), "", "disabled"), True, )%>
                                                              <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , , "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   ", True, )%>--%>
                                                            </div>
                                                        </div>
                                                          <div class="col-md-12" id="divAcceptanceCriteria" style="display: none;margin-bottom: 3%;">
                                                             <br />
                                                            <label class="col-md-4 control-label labelcls" style="font-weight: normal;">Acceptance Criteria </label>
                                                            <div class="col-md-12 ">
                                                                <div id="txtEditor_accept"></div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6" id="divFixedVersion" style="display: none;">
                                                            <label class="col-md-4 control-label" style="white-space: nowrap; margin-top: 11px;font-weight: normal;">Fixed Version</label>
                                                            <div class="col-md-8 ">
                                                              <%CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), "", "disabled"), True, ) %>
                                                                <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , , "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  ", True, ) %>--%>
                                                            </div>
                                                        </div>
                                                        
                                                       
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-0" style="padding-top: 50px; background-color: #F0F0F0!important;">
                                                    <div class="col-md-12" id="divPriority" style="display: none;">
                                                        <label class="col-md-4 control-label labelcls" style="font-weight: normal;">Priority<span class="required">*</span></label>
                                                        <div class="col-md-8 ">

                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), "", "disabled"), True, ) %>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities ", 180, "ProjectDropDown", "class='form-control' style='background-color: #e1e1e114!important; border-bottom-color: white!important;'", True, , , , , )%>--%>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12" id="divCategory" style="display: none;font-weight: normal;">
                                                        <label class="col-md-4 control-label labelcls" style="font-weight: normal;">Category</label>
                                                        <div class="col-md-8 ">

                                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboUSCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", 180, strCategory, "class='form-control' style='background-color: #fff !important; border-bottom-color: white!important;'", True, , , , , )%>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12" id="divStoryPoints" style="display: none;">
                                                    <label class="col-md-4 control-label labelcls" style="white-space: nowrap;padding-left:10px;font-weight: normal;">Story Points</label>
                                                    <div class="col-md-8 " >
                                                         <% Dim strDisabledCheck As String = "" %>
                                                        <%If strState <> "InActive" And strIterationName = "" Then
                                                                strDisabledCheck = ""
                                                            Else
                                                                strDisabledCheck = "disabled"
                                                            End If %>
                                                        <%If strCategory <> "" Then %>
                                                       
                                                         <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = "","disabled",TRUE) , "", "disabled"),  , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", , , , , , ,) %>--%>
                                                        <%CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')" & strDisabledCheck, , , , , , ,) %>
                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , , "", )%>--%>
                                                        <%Else %>
                                                         <%--<%CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = "","disabled",TRUE) , "", "disabled"),  , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", , , , , , ,) %>--%>
                                                        <%CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", , , , , , ,) %>
                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , , "", )%>--%>
                                                        <%End If %>
                                                       
                                                    </div>
                                                    </div>
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <div class="col-md-12">
                                                        <p class="col-md-9" style=" font-weight: 500;">Is Parent&nbsp;: </p>
                                                        <p class="col-md-3" style=" font-weight: 500;"><%=intParentUserStoryID %></p>
                                                        </div>

                                                     <div class="col-md-12">
                                                        <p class="col-md-9" style=" font-weight: 500;">Issue Count&nbsp;: </p>
                                                        <p class="col-md-3" style=" font-weight: 500;"><%= intIssueCount %></p>
                                                     </div>
                                                     <div class="col-md-12">
                                                        <p class="col-md-9" style=" font-weight: 500;">Test Cases Passed&nbsp;: </p>
                                                        <p class="col-md-3" style=" font-weight: 500;"><%= intTCPassCount %></p>
                                                     </div>
                                                     <div class="col-md-12">
                                                        <p class="col-md-9" style=" font-weight: 500;">Test Cases Failed&nbsp;: </p>
                                                        <p class="col-md-3" style=" font-weight: 500;"> <%= intTCFailCount%></p>
                                                     </div>
                                                    <div class="col-md-12">
                                                        <p class="col-md-9" style=" font-weight: 500;">Test Cases Not Tested&nbsp;: </p>
                                                        <p class="col-md-3" style=" font-weight: 500;"><%=intTCNotPlanCount %></p>
                                                    </div>
                                                   <%-- <p class="col-md-4" style="color: blue; font-weight: 500;">Is Parent-<%=intParentUserStoryID %></p>--%>
                                                   <%--      <p class="col-md-12" style="color: #53d653; font-weight: 600; font-size: 14px;">Issue Count:<%= intIssueCount %></p>
                                               
                                                    <p class="col-md-12" style="color: #53d653; font-weight: 600; font-size: 14px;">Test Case Passed : <%= intTCPassCount %></p>
                                                    <p class="col-md-12" style="color: #53d653; font-weight: 600; font-size: 14px;">Test Case Failed : <%= intTCFailCount%></p>
                                                     <p class="col-md-12" style="color: #53d653; font-weight: 600; font-size: 14px;">Test Case Not Tested : <%=intTCNotPlanCount %></p>--%>
                                                </div>
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane fade" id="SectionSubUserStory">
                                            <%--       <h3>Section 2</h3>--%>
                                            <h3 class="clsDiscussion">Sub User Stories</h3>
                                            <%--Added By swapna --%>
                                            <div class="col-md-12">
                                                <h2 style="text-align: right;  padding: 4px; margin-bottom: 21px;margin-top: auto;"><a onclick="ShowDatasubstoryTable()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="List View" style="cursor: pointer;font-size:12px">List</a> | <a onclick="ShowDatasubstorywForm()" data-bs-toggle="tooltip" title="Add" data-bs-placement="bottom" data-original-title="" style="cursor: pointer;font-size:12px">Add</a><a id="SaveSubStoryForm" onclick="SaveSubData('SubStory')" data-bs-toggle="tooltip" title="Save" data-bs-placement="bottom" data-original-title="" style="cursor: pointer;font-size:12px display:none " > | Save</a></h2>
                                            </div>
                                            <%--End  by swapna--%>
                                            <div id="divSubstoryList">
                                                <div class="row" style="padding-top: 10px;">
                                                    <div class="col-md-9">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="search_table" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important;height: 34px;">
                                                            <span class="input-group-btn">
                                                                <button class="btn btn-search" type="button" style="background-color: #0288D1; color: white;">Go</button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <table id="tblShowSubUserStory" class="table table-bordered" style="width: 100%;" data-page-length='5'>
                                                    <thead >
                                                        <tr >
                                                           <%-- Added by swapna--%>
                                                            <%--Commented And Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story--%>
                                                            <%--<th>User Story ID</th>   --%>
                                                            <th>Sub User Story ID</th>
                                                            <%--End Of Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story--%>
                                                            <th>Description</th>
                                                            <th>Owner</th>
                                                            <th >Completed</th>
                                                            <th>Task</th>
                                                            <th>Due Date (End Date)</th>
                                                             <th>Stage</th>
                                                            <%--<th>Delete</th>--%>
                                                           <%-- End by swapna--%>
                                                        </tr>
                                                    </thead>

                                                </table>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">

                                                    <div id="divSubstoryForm" style="display: none;">
                                                        <div class="col-sm-12" id="" style="">
                                                           <%-- <div class="col-sm-12 "><i data-bs-toggle="tooltip" style="float: right;cursor:pointer" title="" data-bs-placement="left" onclick="SaveSubData('SubStory')" class="fa fa-save" data-original-title="Save"></i></div>--%>
                                                            <div class="col-sm-12">
                                                                <div class="form-group">
                                                                    <%--Commented And Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story--%>
                                                                    <%--<label class="col-sm-1 control-label" style="white-space: nowrap; margin-top: 11px;font-weight: normal;text-align: right;">User Story<span class="required">*</span></label>--%>
                                                                    <label class="col-sm-1 px-0 control-label" style="white-space: nowrap; margin-top: 11px;font-weight: normal;text-align: right;">Sub User Story<span class="required">*</span></label>
                                                                    <%--End Of Added By Usha Pandit On 17.07.2020 For identifying wheather its a User Story or Sub User Story--%>
                                                                    <div class="col-sm-11 ">
                                                                        <input type="Textbox" name="txtSubStoryName" id="txtSubStoryName" class="form-control" style="text-align: Left" maxlength="100" value="" onkeyup="ClearSpan('txtFunctionalNumber','spanFunctionalNumber')">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-1 control-label" style="white-space: nowrap; margin-top: 10px;font-weight: normal;text-align: right;">Description<span class="required">*</span></label>
                                                                    <div class="col-sm-11 ">
                                                                        <textarea wrap="Soft" name="txtSubStoryDesc" id="txtSubStoryDesc" class="form-control" style="text-align: left; overflow-x: hidden; word-wrap: break-word; resize: horizontal;height: 33px;" onkeyup="javascript:limitText(this,countSubUSdown,1000)"  onchange="ClearSpan('txtUserDesc','spanUserDesc')"></textarea><small name="countSubUSdown" id="countSubUSdown" style="float:right;">1000</small>
                                                                       <%-- <span class="input-group-addon"><small name="countSubUSdown" id="countSubUSdown">1000</small><span id="spanAcceptanceCriteria" style="color: #dd1037; font-size: 12px;"></span></span>--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-1 control-label" style="white-space: nowrap; margin-top: 10px;font-weight: normal;text-align: right;">Priority<span class="required">*</span></label>
                                                                    <div class="col-sm-11 ">
                                                                       
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("SubcboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True,) %>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <%--Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting--%>
                                                              <div class="col-sm-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-1 control-label" style="white-space: nowrap; margin-top: 10px;font-weight: normal;text-align: right;">Complexity<span class="required"></span></label>
                                                                    <div class="col-sm-11 ">
                                                                       
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("SubcboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , , "class='form-control' onchange=ClearSpan('SubcboComplexity','spanComplexity')", True, )%>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                              <div class="col-sm-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-1 control-label" style="white-space: nowrap; margin-top: 10px;font-weight: normal;text-align: right;">Category<span class="required"></span></label>
                                                                    <div class="col-sm-11 ">
                                                                       
                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("SubcboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", , , "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('SubcboCategory','spanCategory')", True,) %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%--End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane fade" id="SectionAttachments">
                                            <%--     <h3>Section 3</h3>--%>

                                            <div id="Attachmentus" style="padding: 10px;">
                                                <div class="row">
                                                    <div class="col-md-8" style="padding: 10px;    padding-left: 10%;">
                                                        <%--  <h2 style="text-align:right;border-bottom: 1px solid #ddd;padding:4px;"></h2>--%>
                                                        <div class="demo-droppable" id="divDropZone" style="cursor:pointer">
                                                           <%-- Comment added by swapna--%>
                                                      <%--      <p id="pDropZone">Drag files here or click to upload</p>--%>
                                                            <%--<input type="file" multiple="multiple" style="display: none;" />--%></div>
                                                       <%-- end by swapna--%>
                                                    </div>
                                                    <div class="col-md-4" style="margin-top: 28px;">
                                                        <a class="btn btn-info" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" onclick="UploadFileData()" data-original-title="Upload File" style="margin-left: 6pc; width: 30%; line-height: 183%;"><i class="fa fa-upload"></i>Upload</a>
                                                        <div id="listattachment"></div>
                                                    </div>
                                                </div>


                                            </div>
                                            <br />
                                            <div class="row" style="display: flex; flex-direction: row; flex-wrap: wrap;  justify-content: center; align-items: center;">
                                                <div class="col-md-12" id="mainDivAttachments" style="width: 90%;">
                                                </div>
                                            </div>
                                        </div>

                                        <div role="tabpanel" class="tab-pane fade" id="SectionDiscussion" style="width: 99%;">
                                            <h2 class="clsDiscussion">Discussions</h2>
                                            <div class="row">
                                                <div class="col-md-5" id="mainDivDisscussion" style="padding-left: 50px;">
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="widget-area no-padding blank" style="margin-top: 83px;">
                                                        <div class="status-upload">
                                                            <%-- Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478 --%>
                                                            <%--<textarea placeholder="Post New Discussion" id="DiscussionTextArea" onloadeddata="AutoGrowTextArea(this)"   maxlength="1000" style="padding: 20px; border: 2px solid #ddd; width: 100%;  overflow: hidden;height: 74px;" ></textarea>--%>
                                                            <textarea placeholder="Post New Discussion" id="DiscussionTextArea" onloadeddata="AutoGrowTextArea(this)"   maxlength="2000" style="padding: 20px; border: 2px solid #ddd; width: 100%;  overflow: hidden;height: 74px;" ></textarea>
                                                            <%-- //End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478 --%>

                                                            <form class="form-inline">


                                                                <button class="btn btn-primary float-end" data-bs-toggle="tooltip" title="Post" onclick="AddNewDiscus()"  id="post_discuss" type="button" style="background-color: #22af81 !important; border-color: #22af81 !important; font-weight: 600;">Post</button>
                                                                    
                                                            </form>

                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane fade" id="SectionTeams" style="width: 99%;">
                                            <h3 class="clsDiscussion">User Story Team</h3>
                                            <div class="row" id="mainDivTeams">
                                            </div>
                                        </div>
                                        <div role="tabpanel" class="tab-pane fade" id="SectionHistory" style="width: 99%;">
                                            <h3 class="clsDiscussion">History</h3>

                                            <div class="row" style="padding-top: 10px;">
                                                <div class="col-md-9">
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" id="search_table_History" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important;height: 34px;">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-search" type="button" style="background-color: #0288D1; color: white;">Go</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <table id="tblShowHistory" class="table table-bordered" style="width: 100%;" data-page-length='5'>
                                                <thead>
                                                    <tr>
                                                        <th>Date</th>
                                                        <th>Modified By</th>
                                                        <th>Field Name</th>
                                                        <th>Old Value</th>
                                                        <th>New Value</th>
                                                    </tr>
                                                </thead>


                                            </table>
                                        </div>



                                        <div role="tabpanel" class="tab-pane fade" id="SectionIssues" style="width: 99%;">
                                            <h3 class="clsDiscussion">Issues</h3>
                                            <div class="col-md-12" id="divIssueListAdd">
                                                <h2 style="text-align: right; padding: 4px; margin-bottom: 21px;margin-left: -15px;margin-right:-15px;margin-top: auto;"><a data-bs-toggle="tooltip" title="" style="cursor: pointer;font-size:12px" data-bs-placement="bottom" data-original-title="List View" onclick="ShowDataFormTable()">List</a> | <a id="AddIssueForm" onclick="ShowData()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" style="cursor: pointer;font-size:12px" data-original-title="Add">Add</a><a id="SaveIssueForm" onclick="SaveSubData('Issue')" data-bs-toggle="tooltip" title="Save" data-bs-placement="bottom" style="cursor: pointer;font-size:12px   display:none; " data-original-title="Save"> | Save</a></h2>
                                            </div>


                                            <div id="table_issue">
                                                <div class="row" style="padding-top: 10px;">
                                                    <div class="col-md-9">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="search_table_Issues" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important;height: 34px;">
                                                            <span class="input-group-btn">
                                                                <button class="btn btn-search" type="button" style="background-color: #0288D1; color: white;">Go</button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <table id="tblShowIssues" class="table table-bordered" style="width: 100%" data-page-length='5'>
                                                    <thead>
                                                        <tr>
                                                            <TH>Flag</TH>
                                                            <TH>ID</TH>
                                                            <TH>Reported Date</TH>
                                                            <TH>Type</TH>
                                                            <th>Sprint Name</th>
                                                            <th>Summary</th>
                                                          <%--  <th>Status</th>
                                                            <th>Responsible Person</th>--%>


                                                        </tr>
                                                    </thead>
                                                </table>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div id="divIssueForm" style="display: none;">
                                                      <%--  <div class="col-sm-12 "><i id="SaveIssue" data-bs-toggle="tooltip" style="float: right;cursor:pointer" title="" data-bs-placement="left" onclick="SaveSubData('Issue')" class="fa fa-save" data-original-title="Save"></i></div>--%>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <div class="form-group ">
                                                                    <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Summary<span class="required">*</span></label>
                                                                    <div class="col-md-10">
                                                                        <textarea wrap="Soft" name="txtSummary" id="txtSummary" maxlength="500" class="form-control" style="text-align: left; overflow-x: hidden; word-wrap: break-word; resize: horizontal;height: 33px;" onkeyup="javascript:limitText(this,countdownSummary,500)"  onchange="ClearSpan('txtSummary','spanUserDesc')"></textarea><small name="countdownSummary" id="countdownSummary" style="border-style: None; float: left; margin-top: 0%; margin-left: 100%;"></small> 
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <div class="form-group ">
                                                                    <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Description<span class="required">*</span></label>
                                                                    <div class="col-md-10">
                                                                        <textarea wrap="Soft" name="txtDescription" id="txtDescription" maxlength="1000" class="form-control" style="text-align: left; overflow-x: hidden; word-wrap: break-word; resize: horizontal;height: 33px;" onkeyup="javascript:limitText(this,countdownDescription,1000)"  onchange="ClearSpan('txtDescription','spanUserDesc')"></textarea><small name="countdownDescription" id="countdownDescription" style="border-style: None; float: left; margin-top: 0%; margin-left: 100%;">1000</small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="col-md-6">
                                                                <div class="form-group ">
                                                                    <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Type<span class="required">*</span></label>
                                                                    <div class="col-md-3" style="margin-left: 1%">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboIssueType", "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & Session("intProjectID") & ",'T',Null,Null,Null,Null,Null,'" & HttpContext.Current.Session("intpostid") & "'", , , "onchange=GetSelectedSubtype(this) Class='form-control' style='width:222px!important'", True, )%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group SecControl">
                                                                    <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Sub Type<span class="required">*</span></label>
                                                                    <div class="col-md-3" style="margin-left: 6%">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSubIssueType", "SELECT ''", , " form-control", "Class='form-control' style='width:222px!important'", True, )%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="col-md-6">
                                                                <div class="form-group ">
                                                                    <label class="col-md-3 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Reported By<span class="required">*</span></label>
                                                                    <div class="col-md-3" style="margin-left: 9%">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboreporter", "usp_Sel_IB_IssueEntry_EmployeeList ReportedBy ," & Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",1, NULL,NULL,E,New,0", , , "Class='form-control' style='width:222px!important'", True, , , , , )%>
                                                                    </div>
                                                                    <input type="hidden" id="hdnStrReporter" value="504">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group SecControl">
                                                                    <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Status<span class="required">*</span></label>
                                                                    <div class="col-md-3" style="margin-left: 6%">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "Select ''", , " form-control", "Class='form-control' style='width:222px!important'", True, )%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <div class="form-group SecControl">
                                                                    <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Responsible Person<span class="required">*</span></label>
                                                                    <div class="col-md-3" style="">

                                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboResonsible", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , , "Class='form-control' style='width:222px!important'", True, , , , , )%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div role="tabpanel" class="tab-pane fade" id="SectionReviews" style="width: 99%;">
                                            <h3 class="clsDiscussion">Reviews</h3>
                                            <div class="col-md-12">
                                                <h2 style="text-align: right;  padding: 4px; margin-bottom: 21px;margin-left: -15px;margin-right:-15px;margin-top: auto;"><a onclick="ShowDataReviewTable()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="List View" style="cursor: pointer;font-size:12px">List</a> | <a onclick="ShowDataReviewForm()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="Add" style="cursor: pointer;font-size:12px">Add</a><a id="saveReviewForm" onclick="SaveSubData('Review')" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="Save" style="cursor: pointer;font-size:12px    display: none;"> | Save</a></h2>
                                            </div>

                                            <div id="divReviewList">
                                                <div class="row" style="padding-top: 10px;">
                                                    <div class="col-md-9">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="search_table_Reviews" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important;height: 34px;">
                                                            <span class="input-group-btn">
                                                                <button class="btn btn-search" type="button" style="background-color: #0288D1; color: white;">Go</button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <table id="tblShowReviews" class="table table-bordered" style="width: 100%" data-page-length='5'>
                                                    <thead>
                                                        <tr>
                                                          
                                                            <th>Reviewed Date</th>
                                                            <th>Sprint Name</th>
                                                            <th>Status</th>
                                                            
                                                              <th>Review Title</th>
                                                             <%--Commented and Added by Usha Pandit on 22.04.2019 for caption change--%>
                                                            <%--<th>Reviewed By</th>--%>
                                                            <th>Reviewer</th>
                                                              <%--End of Added by Usha Pandit on 22.04.2019 for caption change--%>
                                                            <th>Reviewee</th>
                                                        </tr>
                                                    </thead>

                                                </table>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div id="divReviewForm" style="display: none;">
                                                       <%-- <div class="col-sm-12 ">
                                                            <i data-bs-toggle="tooltip" style="float: right; margin-top: -10px;cursor:pointer" title="" data-bs-placement="left" onclick="SaveSubData('Review')" class="fa fa-save" data-original-title="Save"></i>

                                                        </div>--%>


                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Review Title<span class="required">*</span></label>
                                                                <div class="col-md-10">
                                                                  <%--  <input type="Textbox" name="txtReviewtitle" id="txtReviewtitle" class="form-control" style="text-align: Left" maxlength="100" value="">--%>
                                                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtReviewtitle", "txtReviewtitle", "form-control", , 50, , , , , , , , "", , , , , , , )%>
                                                                </div>
                                                            </div>




                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Review Type<span class="required">*</span></label>
                                                                <div class="col-md-10">
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboReviewtype", "usp_Sel_tbl_PM_ProjectReviewTypes " & Session("IntProjectID"), , , "class='form-control' ", True, )%>
                                                                </div>
                                                            </div>
                                                        </div>



                                                        <div class="row px-3">
                                                        <div class="col-md-6">
                                                            <div class="form-group ">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">R.Start Date<span class="required">*</span></label>
                                                                <div class="col-md-6">
                                                                    <input type="Textbox" name="txtReviewStartDate" id="txtReviewStartDate" class="form-control" style="text-align: Left" maxlength="100" value="" onkeyup="ClearSpan('txtStartDate','spantxtStartDate')"/>
                                                                    <i class="far fa-calendar-check" aria-hidden="true" style="float: right; margin-top: -35px; color: #0099CC;" id="dpreviewstartdate" onclick=""></i>

                                                                </div>

                                                            </div>

                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">R.End Date<span class="required">*</span></label>
                                                                <div class="col-md-8">
                                                                    <input type="Textbox" name="txtReviewEnddate" id="txtReviewEnddate" class="form-control " style="text-align: Left;" maxlength="100" value="" onkeyup="ClearSpan('txtEnddate','spantxtEnddate')">
                                                                    <i class="far fa-calendar-check" aria-hidden="true" style="float: right; margin-top: -35px; color: #0099CC;" id="#dpReviewEnddate" onclick="$('#txtReviewEnddate').datepicker();$('#txtReviewEnddate').datepicker('show');"></i>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        </div>

                                                        <div class="row px-3">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                            <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Reviewer<span class="required">*</span></label>
                                                            <div class="col-md-6">
                                                                <div class="btn-group dropdown" style="width: 100%;">
                                                                    <%CommonFunctions.HTMLControls.DrawTextBox("cboReviewer", "cboReviewer", "form-control ", , 100, , , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", , , , , , , )%>
                                                                    <ul class="dropdown-menu" style="min-width: 190px!important;" id="uiReviewerList">
                                                                    </ul>
                                                                </div>

                                                            </div>
                                                        </div>
                                                            </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Reviewee<span class="required">*</span></label>
                                                                <div class="col-md-8">
                                                                    <div class="btn-group dropdown" style="width: 100%;">
                                                                        <%CommonFunctions.HTMLControls.DrawTextBox("cboReviewee", "cboReviewee", "form-control ", , 100, , , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", , , , , , , )%>
                                                                        <ul class="dropdown-menu" id="uiRevieweeList">
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                            </div>
                                                        <div class="row px-3">
                                                        <div class="col-md-6">
                                                            <div class="form-group ">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Status<span class="required">*</span></label>
                                                                <div class="col-md-6">

                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRevieStatus", "usp_Sel_tbl_RTS_ProjectSpecificControlData 'ReviewStatus_ADD_NEW'", , "Open", "class='form-control' ", True, )%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                               
                                                               <label class="col-md-4 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Checklist</label>

                                                                <div class="col-md-8">
                                                                     <%--Added by Usha--%>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboChecklist", "usp_sel_GetProjectChecklistsAndGroups " & Session("intprojectID"), , , "class='form-control' ", True, )%>
                                                                 <%--End by Usha--%>
                                                                </div>

                                                            </div>
                                                        </div>
                                                            </div>
                                                        <div class="row px-3">
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Work (H:M).<span class="required">*</span></label>
                                                                <div class="col-md-6">
                                                                    <input type="Textbox" name="txtReviewHrs" id="txtReviewHrs" class="form-control "  style="text-align: Left" maxlength="100" value="" onkeyup="ClearSpan('txtEnddate','spantxtEnddate')">
                                                                </div>
                                                            </div>
                                                        </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div role="tabpanel" class="tab-pane fade" id="SectionTask" style="background-color: white;">
                                            <h3 class="clsDiscussion">Tasks</h3>
                                            <div class="col-md-12">
                                                <%--<%Added &  Commented By Dipali V On 15th May 2020 For Issue ID 24380 %>--%>
                                                <%--Uncommented And Commented By Usha Pandit On 18.05.2021 For plotting Add link for agile project--%>
                                                <h2 style="text-align: right; padding: 4px; margin-bottom: 21px; margin-left: -15px; margin-right: -15px;margin-top: auto;"><a onclick="ShowDataTaskTable()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="List View" style="cursor: pointer;font-size:12px">List</a> | <a onclick="ShowDataTaskForm()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="Add" style="cursor: pointer;font-size:12px">Add</a><a id="SaveTaskForm" onclick="SaveAssignTask(<%= intUserStoryID %>)" data-bs-toggle="tooltip" title="Save" data-bs-placement="bottom" data-original-title="Save" style="cursor: pointer;font-size:12px    display: none;"> | Save</a></h2>
                                            
                                                <%--<h2 style="text-align: right; padding: 4px; margin-bottom: 21px; margin-left: -15px; margin-right: -15px;margin-top: auto;"><a onclick="ShowDataTaskTable()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="List View" style="cursor: pointer;font-size:12px">List</a></h2>--%>
                                             <%--End Of Commented By Usha Pandit On 18.05.2021 For plotting Add link for agile project--%>
                                            <%-- <%  end of Added Commented By Dipali V On 15th May 2020 For Issue ID 24380 %>--%>
                                            </div>
                                            <br />
                                            <div id="divTaskList">
                                                <table id="tblShowTasks" class="table" style="width: 100%;">
                                                    <tbody>
                                                        <%--       <tr>
                                                        <td style='width:20%'>
                                                         <input type="Textbox" name="txtTaskName0" id="txtTaskName0" class="form-control" style="text-align:Left" maxlength="255" value="" placeholder="Task Name" title="Task Name">
                                                        </td>
                                                          <td style='width:15%' >
                                                            <input type="Textbox" name="txtStartDate0" id="txtStartDate0" class="form-control" style="text-align:Left" maxlength="100" value="" placeholder="Start Date" title="Start Date" onkeyup="ClearSpan('txtStartDate','spantxtStartDate')">
                                                          <i class="far fa-calendar-check" aria-hidden="true" style="margin-top: -35px!important;float:right!important;color:#0099CC;" id="#dpstartdate0" onclick="$('#txtStartDate0').datepicker();$('#txtStartDate0').datepicker('show');"></i>      
                                                          </td>
                                                          <td style='width:15%'>
                                                              <input type="Textbox" name="txtEndDate0" id="txtEndDate0" class="form-control" style="text-align:Left" maxlength="100" value="" placeholder="End Date" title="End Date" onkeyup="ClearSpan('txtEndDate0','spantxtEndDate0')">
                                                         <i class="far fa-calendar-check" aria-hidden="true" style="margin-top: -35px!important;float:right!important;color:#0099CC;" id="#dpEnddate0" onclick="$('#txtEndDate0').datepicker();$('#txtEndDate0').datepicker('show');"></i>
                                                               </td>
                                                          <td style='width:13%'>
                                                              <input type="Textbox" name="txtWorkHrs0" id="txtWorkHrs0" class="form-control" style="text-align:Left" value="" placeholder="Work Hrs" title="Work Hrs" onkeyup="ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0')" maxlength="4">
                                                          </td>
                                                          <td style='width:13%'>
                                                              <input type="Textbox" name="txtStoryPoints0" id="txtStoryPoints0" class="form-control" style="text-align:Center" maxlength="3" value="" placeholder="Story Pts" title="Story Pts">
                                                          </td>
                                                         <td style='width:12%'>
                                                           <%CommonFunctions.HTMLControls.DrawComboBox("cboTaskType0", "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", 104, , "class='form-control' title='Task Type' style='width:110%!Important'", False, , , , , ) %>
                                                         </td>
                                                          <td style='width:23%'>
                                                             <%CommonFunctions.HTMLControls.DrawComboBox("cboresource0", "usp_NG2_Sel_tbl_PM_ProjectEmployees " & Session("intprojectID") & "", 104, , "class='form-control' title='Resource' style='width:100%!Important;margin-left:15%'", False, , , , , ) %>
                                                          </td>
                                                          <td style='width:3%;'>
                                                              <i style="font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop" data-bs-placement="bottom" id="idEdit0" data-bs-toggle="tooltip" title="" class="fa fa-pencil" onclick="EditTask(4250,0)" disabled="" data-original-title="Edit Task"></i>
                                                          </td>
                                                          <td style='width:3%;'>
                                                              <i style="font-size:14px!important;text-align:center;color:red;cursor:no-drop" data-bs-placement="bottom" data-bs-toggle="tooltip" id="iddelete0" title="" class="fa fa-trash" disabled="" data-original-title="Delete Task"></i>
                                                          </td>
                                                      </tr>--%>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div id="divTaskForm" style="display: none;">
                                             <%--   <div class="col-sm-12 "><i id="SaveTask" data-bs-toggle="tooltip" style="float: right; cursor: pointer" title="" data-bs-placement="left" onclick="SaveAssignTask(<%= intUserStoryID %>)" class="fa fa-save" data-original-title="Save"></i></div>--%>
                                                <div class="row">
                                                    <div class="form-row">
                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Task Name<span class="required">*</span></label>
                                                                <div class="col-md-10">
                                                                    <input type="Textbox" name="AssigntxtTaskName" id="AssigntxtTaskName" class="form-control " style="text-align: Left" maxlength="255" value="" >
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-row">
                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Task Notes</label>
                                                                <div class="col-md-10">
                                                                    <textarea wrap="Soft" name="txtTaskNotes" id="txtTaskNotes" class="form-control" style="text-align: Left;height: 33px;" onkeyup="javascript:limitText(this,countTaskNote,2000)" data-autoresize=""></textarea><small name="countTaskNote" id="countTaskNote" style="border-style:None;float:Right;">2000</small>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-row">
                                                        <div class="col-md-6">
                                                            <div class="form-group ">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Resource(s)<span class="required">*</span></label>
                                                                <div class="col-md-3" ><%--style="margin-left: 6%"--%>
                                                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboAssignResources", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, )%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Work(H:M)<span class="required">*</span></label>
                                                                <div class="col-md-3" style="margin-left: 6%;width: 218px;">
                                                                   <%-- Commented and Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes --%>
                                                                    <%--<input type="Textbox" name="AssigntxtWorkHrs" id="AssigntxtWorkHrs" class="form-control " style="text-align: Left" maxlength="6" value="" onkeyup="ClearSpan('txtWorkHrs','spntxtWorkHrs')">--%>
                                                                    <input type="Textbox" name="AssigntxtWorkHrs" id="AssigntxtWorkHrs" class="form-control " style="text-align: Left" maxlength="8" value="" onkeyup="ClearSpan('txtWorkHrs','spntxtWorkHrs')">
                                                                     <%-- End of Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes --%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-md-6">
                                                            <div class="form-group ">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Start Date<span class="required">*</span></label>
                                                                <div class="col-md-3" style="width: 218px;"><%--margin-left: 6%--%>
                                                                    <input type="Textbox" name="dtStartDateAssigntask" id="dtStartDateAssigntask" class="form-control  " style="text-align: Left" maxlength="100" value="" "/>
                                                                    <i class="far fa-calendar-check" aria-hidden="true" style="float: right; margin-top: -35px; color: #0099CC;" id="#dtStartDateAssigntask" onclick="$('#dtStartDateAssigntask').datepicker();$('#dtStartDateAssigntask').datepicker('show');"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">End Date<span class="required">*</span></label>
                                                                <div class="col-md-3" style="margin-left: 6%;width: 218px;">
                                                                    <input type="Textbox" name="dtEndDateAssigntask" id="dtEndDateAssigntask" class="form-control  " style="text-align: Left" maxlength="100" value="" onkeyup="ClearSpan('txtEnddate','spantxtEnddate')">
                                                                    <i class="far fa-calendar-check" aria-hidden="true" style="float: right; margin-top: -35px; color: #0099CC;" id="#dtEndDateAssigntask" onclick="$('#dtEndDateAssigntask').datepicker();$('#dtEndDateAssigntask').datepicker('show');"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-md-6">
                                                            <div class="form-group ">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Priority<span class="required">*</span></label>
                                                                <div class="col-md-3"> <%--style="margin-left: 6%"--%>
                                                                    <%--   <select onchange="ClearSpan('cboPriorities','spncboPriorities')" id="AssigntaskcboPriorities" name="AssigntaskcboPriorities" class="form-control"><option value=""></option><option title="High" value="High">High</option><option title="Low" value="Low">Low</option><option title="Medium" value="Medium">Medium</option></select>--%>
                                                                    <%CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboPriorities", "usp_NG2_Sel_tbl_IB_Priorities", 190, , "class='form-control' ", True, )%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Task Type<span class="required">*</span></label>
                                                                <div class="col-md-3" style="margin-left: 6%">
                                                                   <%CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", 190, , "class='form-control' ", True, )%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <%--<div class="col-md-6">
                                                            <%---Dipali V On 20th April 2020 For IssueID 23704  ---%>
                                                          <%--  <div class="form-group ">
                                                                <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">On Hold</label>
                                                                <div class="col-md-3" style="margin-left: 6%">
                                                                    <input type="checkbox" id="chkHold" name="chkHold" value="">
                                                                </div>
                                                            </div>--%>
                                                             <%---End of Dipali V On 20th April 2020 For IssueID 23704  ---%>
                                                      <%--  </div>--%>
                                                        <div class="col-md-6">
                                                            <div class="form-group SecControl">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Billable</label>
                                                                <div class="col-md-3" ><%--style="margin-left: 6%"--%>
                                                                    <input type="checkbox" id="chkBillable" name="chkBillable" checked="true" value="1">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-md-12">
                                                            <div class="form-group ">
                                                                <label class="col-md-2 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Story Points</label>
                                                                <div class="col-md-2" style="width: 219px;">
                                                                    <input type="Textbox" name="AssigntxtStoryPoints" id="AssigntxtStoryPoints" class="form-control " style="text-align: Left" maxlength="3" value="" onkeyup="ClearSpan('AssigntxtStoryPoints','spntxtStoryPoints')">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="divEntity">
                                                    <fieldset>
                                                        <legend>Task Attributes</legend>
                                                        <div id="divDynamicFields">
                                                            <div class="form-row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group ">
                                                                        <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Change Request</label>
                                                                        <div class="col-md-3" style="margin-left: 6%">
                                                                            <%--  <select onchange="ClearSpan('cboChangeRequest','spnChangeRequest');" mandatory="0" id="cboChangeRequest" name="cboChangeRequest" class="form-control">
                                                                                 <option value=""></option>
                                                                             </select>--%>
                                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequest", "usp_Ng2_Sel_tbl_PM_ChangeRequest_Master " & Session("intprojectID") & ",Null,'','','',Null,'','',NULL", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, )%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group SecControl">
                                                                        <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Milestone</label>
                                                                        <div class="col-md-3" style="margin-left: 6%">

                                                                            <%--<select onchange="ClearSpan('cboMilestone','spnMilestone');" mandatory="0" id="cboMilestone" name="cboMilestone" class="form-control">
                                                                                 <option value=""></option>
                                                                             </select>--%>
                                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboMilestone", "usp_Ng2_Sel_tbl_PM_Milestones " & Session("intprojectID") & ",'T',NULL,NULL ", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, )%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group ">
                                                                        <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Module</label>
                                                                        <div class="col-md-3" style="margin-left: 6%">
                                                                            <%--<select onchange="ClearSpan('cboModule','spnModule');" mandatory="1" id="cboModule" name="cboModule" class="form-control"><option value=""></option><option title="aasfaf" value="19">aasfaf</option></select>--%>
                                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_Ng2_Sel_tbl_PM_Module " & Session("intprojectID") & ",NULL,'A',NULL ", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, )%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group SecControl">
                                                                        <label class="col-md-2 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Sub Project</label>
                                                                        <div class="col-md-3" style="margin-left: 6%">

                                                                            <%-- <select onchange="ClearSpan('cboSubProject','spnSubProject');" mandatory="0" id="cboSubProject" name="cboSubProject" class="form-control"><option value=""></option></select>--%>
                                                                            <%CommonFunctions.HTMLControls.DrawComboBox("cboSubProject", "usp_Ng2_Sel_tbl_PM_SubProject " & Session("intprojectID") & ",NULL,'T',NULL,NULL", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') ", True, )%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group ">
                                                                        <label class="col-md-4 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">User Stories</label>
                                                                        <div class="col-md-3" style="margin-left: 6%">
                                                                            <%--<select onchange="UserStoryID_OnChange(value)" id="cboUserStory" name="cboUserStory" class="form-control" style="width: 190px">
                                                                                <option value=""></option>
                                                                            </select>--%>
                                                                             <%CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "Usp_Ng2_Sel_tbl_PM_ScrumUserStory_AssignTasks " & Session("intprojectID") & ",NULL", 190, intUserStoryID, "class='form-control' disabled onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", , )%>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                
                                                                <div class="col-md-6">
                                                                    <div class="form-group ">
                                                                        <label class="col-md-3 control-label" style="white-space: nowrap; text-align: left;font-weight: normal;margin-top: 10px;">Release</label>
                                                                        <div class="col-md-3" style="margin-left: -15px;width: 219px;">
                                                                            <input type="Textbox" name="txtRelease" id="txtRelease" class="form-control clsTextBoxReadOnly" style=" text-align: left; "  value="<%= strReleaseName %>" disabled="disabled">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group SecControl">
                                                                        <label class="col-md-4 control-label" style="white-space: nowrap;font-weight: normal;margin-top: 10px;">Sprint</label>
                                                                        <div class="col-md-3" style="margin-left: 5%;width: 219px;">

                                                                            <input type="Textbox" name="txtIteration" id="txtIteration" class="form-control clsTextBoxReadOnly" style="text-align: left;"  value="<%= strSprintName %>" disabled="disabled">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </fieldset>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div role="tabpanel" class="tab-pane fade" id="SectionCharts" style="padding: 10px;">
                                            <h3 class="clsDiscussion">Charts</h3>


                                            <div class="container" style="display:flex">
                                                <ul class="nav nav-pills nav-stacked col-md-2">
                                                    <li><a href="#BurnDown" class="active" data-bs-toggle="pill">Burn Down</a></li>
                                                    <li><a href="#BurnUp" data-bs-toggle="pill">Burn Up</a></li>

                                                </ul>
                                                <div class="tab-content col-md-10" >
                                                    <div class="tab-pane active" id="BurnDown">

                                                        <h4>Burn Down</h4>
                                                        <%--Added by swapna 18-07-2018--%>
                                                       <%--Changed By Yasmin On 10-9-19 for Graph display purpose--%>
                                                        <div class="divLineGraph" style="width: 100% !important; height: 600px;padding:10px;border-top:2px solid #3c8dbc !important">
                                                        <canvas width="697" height="348" class="chartjs-render-monitor" id="BurnDown<%= intUserStoryID %>" style="width: 697px; height: 348px; display: block;"></canvas>
                                                        <canvas width="697" height="348" class="chartjs-render-monitor" id="BurnUp<%= intUserStoryID %>" style="width: 697px; height: 348px; display: block;"></canvas>
                                                         </div>
                                                            <%--End by swapna 18-07-2018--%>
                                                    </div>
                                                    <div class="tab-pane" id="BurnUp">
                                                        <h4>Burn Up</h4>
                                                         <%--Added by swapna 18-07-2018--%>
                                                       <%-- <canvas id="BurnupGraphEfforts" width="800" height="450"></canvas>--%>
                                                        <%--Changed By Yasmin On 10-9-19 for Graph display purpose--%>
                                                        <div class="divLineGraph" style="width: 100% !important; height: 600px;padding:10px;border-top:2px solid #3c8dbc !important">
                                                            <canvas width="697" height="348" class="chartjs-render-monitor" id="BurnupGraphEfforts<%= intUserStoryID%>" style="width: 697px; height: 348px; display: block;"></canvas>
                                                            <canvas width="697" height="348" class="chartjs-render-monitor" id="BurnupGraphStoryPoints<%= intUserStoryID%>" style="width: 697px; height: 348px; display: block;"></canvas>
                                                        </div>
                                                            <%--End by swapna 18-07-2018--%>
                                                         </div>

                                                </div>
                                                <!-- tab content -->
                                            </div>
                                        </div>
                                          <div role="tabpanel" class="tab-pane fade" id="SectionTestCase" style="width: 99%;">
                                            <h3 class="clsDiscussion">TestCase</h3>
                                           <%-- <div class="col-md-12">
                                                <h2 style="text-align: right; border-bottom: 1px solid #ddd; padding: 4px; margin-bottom: 21px;"><a onclick="ShowDataReviewTable()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="List View" style="cursor: pointer">List</a> | <a onclick="ShowDataReviewForm()" data-bs-toggle="tooltip" title="" data-bs-placement="bottom" data-original-title="Add" style="cursor: pointer">Add</a></h2>
                                            </div>--%>

                                            <div id="SectionTestCases">
                                                <div class="row" style="padding-top: 10px;">
                                                    <div class="col-md-9">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="search_test" placeholder="Search" style="border-top: 1px solid #ddd!important; border-left: 1px solid #ddd!important; border-right: 1px solid #ddd!important;">
                                                            <span class="input-group-btn">
                                                                <button class="btn btn-search" type="button" style="background-color: #0288D1; color: white;">Go</button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                
                                                <table id="tblTestCaseList" class="table table-bordered" style="width: 100%" data-page-length='5'>
                                                    <thead>
                                                        <tr>
                                                            <th>Test Case ID</th>
                                                            <th>Test Case Code</th>
                                                            <th>Test Case Name</th>
                                                            <th>Test Case Procedure</th>
                                                            <th>Issues</th>
                                                            <th>Pass</th>
                                                            <th>Fail</th>
                                                            <th>Not Tested</th>
                                                        </tr>
                                                    </thead>

                                                </table>
                                            </div>
                                    </div>

                                    </div>
                                </div>
                            </div>


                        </div>

                    </div>

                </div>
            </div>
        </div>

    </form>
    <script>

        //var initTopPosition = $('#uiTabs').offset().top;
        //$(window).scroll(function () {
        //    if ($(window).scrollTop() > initTopPosition)
        //        $('#uiTabs').css({ 'position': 'fixed', 'top': '0px' });
        //    else
        //        $('#uiTabs').css({ 'position': 'absolute', 'top': initTopPosition + 'px' });
        //});
         function getParameterByName(name, url) {
                if (!url) url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }
        //Added By Yasmin On 7th Feb 2019 for back to sprint and product backlog page
         var UserStoryID = "";
        function Back_click() {
           
             var flag = getParameterByName('Back');
             if (flag == "Sprint") {
                 window.location.href = "../Agile/frmSprintPlanning.aspx?FromWhere=Back" + "&IterationID=" + UserStoryID;
                 flag = null;
             }
             else {
                 window.open('frmProductBacklog.aspx','_self');
             }
            }
        $('#divTabs a[data-bs-toggle="tab"]').bind('click', function (e) {
            $("#search_table").val('');
            $('#tblShowSubUserStory').dataTable().fnFilter('');
           
            $("#search_table_History").val('');
            $('#tblShowHistory').dataTable().fnFilter('');
            
            $("#search_table_Issues").val('');
            $('#tblShowIssues').dataTable().fnFilter('');

            $("#search_table_Reviews").val('');
            $('#tblShowReviews').dataTable().fnFilter('');

            $("#search_test").val('');
            $('#tblTestCaseList').dataTable().fnFilter('');

            ShowDatasubstoryTable();
            ShowDataFormTable();
            ShowDataReviewTable();
            ShowDataTaskTable();
        });

        var arrFile = [];
        $('textarea').on('change keyup keydown paste cut load', function () {
            if ($(this).outerHeight() > this.scrollHeight) {
                $(this).height(1)
            }
            while ($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
                $(this).height($(this).height() + 1)
            }
        });
    
        //$(window).scroll(function () {
        //    var sticky = $('.sticky'),
        //        scroll = $(window).scrollTop();

        //    if (scroll >= 100) sticky.addClass('fixed');
        //    else sticky.removeClass('fixed');
        //});

        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            //debugger;
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });


        function initializFormControls() {
           // $("#txtSummary").trigger('change');
            //$("#txtSummary").trigger('change');
            //$("#txtSummary").trigger('change');
        }

        // Added By Gauri On 20th Sep 2024 For Tooltip Issue
        function hideTooltipsNearDatepicker() {
            const tooltips = document.querySelectorAll('#ui-datepicker-div ~ .bs-tooltip-auto');
            
            tooltips.forEach(tooltip => {
                tooltip.style.display = 'none'; 
            });
        }

        $(function(){
            $("#ui-datepicker-div").on('click', function() {
                hideTooltipsNearDatepicker();
            });
        })
        // End of Added By Gauri On 20th Sep 2024 For Tooltip Issue


        function SaveAssignTask(USID, flag) {
            if ((flag == 1 ? validateNewTask() : validateAssignFormTask()) == 0) {
               // debugger;
                //saveFlag = 1;
                //if (saveFlag == 1) {

                //    $("#AssignSaveBtn0").css("display", "none");

                //}
                //Added By Yasmin On 22-3-19 for preventing multiple click on task save button
                 $("#SaveTaskForm").css("display", "none");
                 $("#SaveBtn0").css("display", "none");
                var TaskID = 0;
                var BillableValue, StoryPoints, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;
                if (flag == 1) {
                    var objTaskName = $('#txtTaskName0');
                    var objResource = $('#cboresource0');
                    var objTaskType = $('#cboTaskType0').val();
                    var StoryPoints = $('#txtStoryPoints0').val();
                    var objWorkHrs = $('#txtWorkHrs0');
                    var objStartDate = $('#txtStartDate0');
                    var objEndDate = $('#txtEndDate0');
                    // alert(objTaskType);
                    //  cboresource
                    var objPriorities = "";
                    //var objTaskType = "";
                    // var StoryPoints = ""
                    var BillableValue, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;


                    var PracticeID = 0;
                    var extraPara = [];
                    extraPara.push(TaskID);
                    //extraPara.push(strPrimaryKey);

                    BillableValue = "0"
                    OnHoldValue = "0"

                    if (StoryPoints == "") {

                        StoryPoints = 0;

                    }
                    else {
                        StoryPoints = StoryPoints;

                    }


                    var objPhase = 0;
                    var objModule = 0;
                    var objSubProject = 0;
                    var objMilestone = 0;
                    var objChangeRequest = 0;
                    var objDeliverable = 0;


                    if (objPhase == 0)
                        PhaseVal = 0

                    if (objModule == 0)
                        ModuleVal = 0

                    if (objSubProject == 0)
                        SubProjectVal = 0

                    if (objMilestone == 0)
                        MilestoneVal = 0

                    if (objChangeRequest == 0)
                        ChangeRequestVal = 0

                    if (objDeliverable == 0)
                        DeliverableVal = 0
                }
                else {
                    var objTaskName = $('#AssigntxtTaskName');
                    var objResource = $('#cboAssignResources');
                    var objTaskType = $('#AssigntaskcboTaskType').val();
                    var objWorkHrs = $('#AssigntxtWorkHrs');
                    var objStartDate = $('#dtStartDateAssigntask');
                    var objEndDate = $('#dtEndDateAssigntask');
                    var objPriorities = $('#AssigntaskcboPriorities');
                    var objBillable = $('#chkBillable');
                    var objHold = $('#chkHold');

                    var objPhase = document.getElementById('cboPhase');
                    var objModule = document.getElementById('cboModule');
                    var objSubProject = document.getElementById('cboSubProject');
                    var objMilestone = document.getElementById('cboMilestone');
                    var objChangeRequest = document.getElementById('cboChangeRequest');
                    var objDeliverable = document.getElementById('cboDeliverable');
                    if (objBillable[0].checked == true) {
                        BillableValue = "1"
                    }
                    else {
                        BillableValue = "0"
                    }
                    //Added & Commented By Dipali V 20th April 2020 For OnHold check box hide while add create task
                    //if (objHold[0].checked == true) {
                    //    OnHoldValue = "1"
                    //}
                    //else {
                    //   OnHoldValue = "0"
                    //}

                    OnHoldValue = "0"
                    //End of Added & Commented By Dipali V 20th April 2020 For OnHold check box hide while add create task
                 var PracticeID = 0;
                    var extraPara = [];
                    extraPara.push(TaskID);
                    StoryPoints = $("#AssigntxtStoryPoints").val();


                    if (StoryPoints == "") {
                        StoryPoints = 0
                    } else {
                        StoryPoints = StoryPoints;
                    }
                    if (objPhase != null) {
                        PhaseVal = objPhase.value;
                    }
                    else {
                        PhaseVal = 0
                    }

                    if (objModule != null) {
                        ModuleVal = objModule.value;
                    }
                    else {
                        ModuleVal = 0
                    }
                    if (objSubProject != null) {
                        SubProjectVal = objSubProject.value;
                    }
                    else {
                        SubProjectVal = 0
                    }
                    if (objMilestone != null) {
                        MilestoneVal = objMilestone.value;
                    }
                    else {
                        MilestoneVal = 0
                    }
                    if (objChangeRequest != null) {
                        ChangeRequestVal = objChangeRequest.value;
                    }
                    else {
                        ChangeRequestVal = 0
                    }
                    if (objDeliverable != null) {
                        DeliverableVal = objDeliverable.value;
                    }
                    else {
                        DeliverableVal = 0
                    }

                    if (PhaseVal == '')
                        PhaseVal = 0

                    if (ModuleVal == '')
                        ModuleVal = 0

                    if (SubProjectVal == '')
                        SubProjectVal = 0

                    if (MilestoneVal == '')
                        MilestoneVal = 0

                    if (ChangeRequestVal == '')
                        ChangeRequestVal = 0

                    if (DeliverableVal == '')
                        DeliverableVal = 0
                }
              
                var URL, data;



                URL = 'UserStoryDetails.aspx/SaveTask';

                var AssignTaskData = [];
                if (flag == 1) {
                   
                    AssignTaskData.push({
                        TaskID: 0,
                        TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                        Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                        MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: '<%= Session("intProjectID")%>', PracticeID: PracticeID,
                        UserStoryID: USID, strEntity: "", StoryPoints: StoryPoints, PageFlag: 1
                    });
                       
                }
                else {
                      
                AssignTaskData.push({
                    TaskID: TaskID,
                    TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                    Priority: objPriorities.val(), TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                    MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: '<%= Session("intProjectID")%>', PracticeID: PracticeID,
                    UserStoryID: USID, strEntity: "", StoryPoints: StoryPoints,PageFlag : 1
                    });
                    
                }
                data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: USID, });
                
             AJAXCallWithPara(URL, data, AfterSaveTask, extraPara);
            
            }


        }
        //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check
        function DateDiff(start, end, interval, rounding) {

            var iOut = 0;

            // Create 2 error messages, 1 for each argument.</KBD> 
            //var startMsg = "Check the Start Date and End Date\n"
            //startMsg += "must be a valid date format.\n\n"
            //startMsg += "Please try again." ;

            //var intervalMsg = "Sorry the dateAdd function only accepts\n"
            //intervalMsg += "d, h, m OR s intervals.\n\n"
            //intervalMsg += "Please try again." ;

            var bufferA = Date.parse(start);
            var bufferB = Date.parse(end);

            //// check that the start parameter is a valid Date. </KBD>
            //if ( isNaN (bufferA) || isNaN (bufferB) )
            //{
            //    alert( startMsg ) ;
            //    return null ;
            //}

            // check that an interval parameter was not numeric.</KBD> 
            //if ( interval.charAt == 'undefined' ) 
            //{
            //    // the user specified an incorrect interval, handle the error.</KBD> 
            //    alert( intervalMsg ) ;
            //    return null ;
            //}

            //if(isDate($("#datepicker1"))==false){
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please enter Start date in Valid format.', 'error');
            //    checkvalue = 1;
            //}
            //if(isDate($("#datepicker2"))==false){
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please enter End date in Valid format.', 'error');
            //    checkvalue = 1;
            //}

            var number = bufferB - bufferA;
            // what kind of add to do?</KBD> 
            switch (interval.charAt(0)) {
                case 'd': case 'D':
                    iOut = parseInt(number / 86400000);
                    if (rounding) iOut += parseInt((number % 86400000) / 43200001);
                    break;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000);
                    if (rounding) iOut += parseInt((number % 3600000) / 1800001);
                    break;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000);
                    if (rounding) iOut += parseInt((number % 60000) / 30001);
                    break;
                case 's': case 'S':
                    iOut = parseInt(number / 1000);
                    if (rounding) iOut += parseInt((number % 1000) / 501);
                    break;
                default:
                    // If we get to here then the interval parameter
                    // didn't meet the d,h,m,s criteria.  Handle
                    // the error.</KBD> 		
                    //alert(intervalMsg) ;
                    return null;
            }
            return iOut;
        }
        //End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check
        function AfterSaveTask(data, extraPara) {

            $("#AssigntxtTaskName").val('')
            $("#txtTaskNotes").val('')
            //$("#txtTaskNotes").trigger('change');
            $("#cboAssignResources").val('')
            $("#dtStartDateAssigntask").val('')
            $("#dtEndDateAssigntask").val('')
            $("#AssigntaskcboPriorities").val('')
            $("#AssigntaskcboTaskType").val('')
            $("#AssigntxtStoryPoints").val('')

            $("#cboChangeRequest").val('')
            $("#cboMilestone").val('')
            $("#cboModule").val('')
            $("#cboSubProject").val('')
            $("#cboUserStory").val('')
            $("#txtRelease").val('')
            $("#AssigntxtWorkHrs").val('')
            PopulateTasksTable('<%= intUserStoryID%>')
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Created successfully', 'success',5);
            
        }
        function validateNewTask() {
            try {
                var checkFlag = 0;
                var strmsg = "";
                var errorMsg = "<ul>"
                var dtAssignStartDate = "", dtAssignEndDate = "";
                var ProjectID = '<%= Session("intProjectID")%>';

                dtAssignStartDate = document.getElementsByName("txtStartDate0");
                dtAssignEndDate = document.getElementsByName("txtEndDate0");

                if ($("#txtTaskName0").val() == "") {
                    strmsg = '- Task Name should not left blank.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtTaskName0").focus();
                }

                //Added By Riddhesh Patil on 11-NOV-2022 
               else if (checkSpecialCharacter($("#txtTaskName0").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Task Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtTaskName0").focus();
                        Flag = 1;
                        checkvalue = 1;
                    }
                
        //End of Added By Riddhesh Patil

                else if ($("#cboresource0").val() == "0" || $("#cboresource0").val() == "") {
                    strmsg = 'Resource should not left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#cboresource0").focus();
                }
                if ($("#txtStartDate0").val() != '' && $("#txtEndDate0").val() != '' && checkFlag == 0) {
                    if (CompairDates1($("#txtStartDate0").val(), $("#txtEndDate0").val()) == 1 && CompairDates1($("#txtStartDate0").val(), $("#txtEndDate0").val()) != 0) {
                        // $('#dtEndDate').css('border-color', 'red');
                        // $('#dtEndDate').css('border-width', '1px');
                        strmsg = '- Please enter Task End Date greater than or equal to Task Start Date!'
                        errorMsg += "<li>" + strmsg + "</li></br>";

                        // $('#spndtEndDate').text("Please enter Task End Date greater than or equal to Task Start Date!");
                        if (checkFlag != 1) {
                            //objEndDate.focus()
                        }
                        isValid = 1;
                        checkFlag = 1;
                    }
                }

                if ($("#txtWorkHrs0").val() == "") {
                    strmsg = 'Work(Hrs) should not left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtWorkHrs0").focus();
                }


                if ($("#txtWorkHrs0").val() != "" && checkFlag == 0) {
                    //if (RestrictNonNumeric(document.getElementById('AssigntxtWorkHrs')) == true) {


                    //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    isValid = 1;
                    //    checkFlag = 1;
                    //}

                    //Commented and Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 

                    //if (($("#txtWorkHrs0").val() - 0) == 0) {

                    //    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    isValid = 1;
                    //    checkFlag = 1;

                    //}

                    //else if (parseFloat($("#txtWorkHrs0").val()) < 0 && $("#txtWorkHrs0").val() != '') {

                    //    strmsg = '- Please enter positive Value For  Work(Hrs)';
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    isValid = 1;
                    //    checkFlag = 1;
                    //    $("#txtWorkHrs0").focus();

                    //}

                    try {
                        //alert(1);
                        //if ($("#cboTaskType0").val() == "Select TaskType") {
                        //    alert(11);
                        //}

                        var blnHMFormat = true;

                        var objHMEffort = document.getElementById("txtWorkHrs0");
                        var objVal = objHMEffort.value;
                        var objnewVal = objHMEffort.value;

                        objHMEffort.value = objHMEffort.value.replace(":", ".");
                        var isdigit = isNumeric(objHMEffort.value);
                        objHMEffort.value = objVal;

                        if (isdigit == false) {
                            strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                        if (objHMEffort.value.indexOf(":") == -1) {
                            //strmsg = ' - Please enter efforts in valid format hh:mm!!';
                            //errorMsg += "<li>" + strmsg + "</li></br>";
                            //blnHMFormat = false;
                            ////setFocus(objHMEffort);
                            //isValid = 1;
                            //checkFlag = 1;
                            objHMEffort.value = objnewVal + ':00';
                            objnewVal = objHMEffort.value;
                        }

                        if (objHMEffort.value.indexOf(":") != -1) {
                            objHMEffort.value = objHMEffort.value.replace(':', '.');
                        }

                        //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");

                        var tempEffort = objHMEffort.value.replace('-', '');
                        if (checkSpecialCharacter(tempEffort) == true) {
                            // alertify.set('notifier', 'position', 'top-right');
                            strmsg = 'Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            objHMEffort.value = objVal;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        //if (blnResult == true) {
                        //    checkvalue = 1;
                        //}

                        //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                        if (blnHMFormat == true) {
                            if (RestrictNonNumeric(document.getElementById("txtWorkHrs0")) == true) {
                                strmsg = 'Please enter Work(Hrs) in H:M format.';
                                errorMsg += "<li>" + strmsg + "</li>";
                                objHMEffort.value = objVal;
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
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
                                strmsg = "Please enter Work(Hrs) in H:M format.";
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }

                            if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                                strmsg = 'Hours should not be less than or equal to zero (0).';
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }

                            // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                            if (blnHMFormat == true) {
                                if (mins.length > 2) {
                                    strmsg = "Please enter minutes in two decimal and less than 60.";
                                    errorMsg += "<li>" + strmsg + "</li>";
                                    blnHMFormat = false;
                                    isValid = 1;
                                    checkFlag = 1;
                                }
                            }
                            // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                            if (blnHMFormat == true) {
                                if (mins > 59 || mins < 0) {
                                    strmsg = 'Please enter minutes between (0-59) range';
                                    errorMsg += "<li>" + strmsg + "</li>";
                                    blnHMFormat = false;
                                    isValid = 1;
                                    checkFlag = 1;
                                }
                            }
                        }

                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                        //var dsdt = $("#txtStartDate0").val();
                        //var dedt = $("#txtEndDate0").val();


                        //dsdt = dsdt.split('/');
                        //dedt = dedt.split('/');

                        //dsdt = dsdt[2] + '-' + dsdt[1] + '-' + dsdt[0];
                        //dedt = dedt[2] + '-' + dedt[1] + '-' + dedt[0];
                        //dsdt = new Date(dsdt);
                        //dedt = new Date(dedt);
                        //var NoOfDays = ((dedt - dsdt) / (1000 * 60 * 60 * 24)) + 1;

                        //var HrsPerDay = new Number((whrs.replace(':', '.')) / NoOfDays);

                        //HrsPerDay = HrsPerDay.toFixed(2);

                        //if (HrsPerDay > (NoOfDays * 24)) {
                        //    strmsg = 'You cannot assign more than 24 hours work per day';
                        //    errorMsg += "<li>" + strmsg + "</li>";
                        //    isValid = 1;
                        //    checkFlag = 1;
                        //}
                        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                        //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check
                        // debugger;
                        dtStartDate = document.getElementById("txtStartDate0");
                        dtEndDate = document.getElementById("txtEndDate0");

                        if (dtStartDate.value != "" && dtEndDate.value != "") {
                            // alert(dtStartDate.value);
                            var dStartDate = new Date(dtStartDate.value);
                            //alert(dStartDate);
                            var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;
                            // alert(DateDiff(dtStartDate.value, dtEndDate.value, "d"));
                            // alert(WorkHour);
                            var data = JSON.stringify({ HMHours: WorkHour });
                            var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
                            var dblTotalWork = decTotalWorkResult.d;

                            dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                            // alert(dblAvgHoursPerDay);
                            // alert(dblTotalDuration);
                            if (dblAvgHoursPerDay > 24) {    ///////////////////////////////////////////                           

                                strmsg = 'You cannot assign more than 24 hours work per day';
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        //End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                        var MinDAENtryDisplay = "";

                        var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
                        var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                        var MinDAEntry = resMinHoursForDAEntry.d;

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

                        var data = JSON.stringify({ Flag: "RestrictByMinHours" });
                        var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                        if (resRestrictByMinHours.d == 'True') {
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
                                        //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                                        if (blnHMFormat == true) {
                                            strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                            errorMsg += "<li>" + strmsg + "</li>";
                                            isValid = 1;
                                            checkFlag = 1;
                                        }
                                    }
                                }
                            }
                        }
                        if (checkFlag == 1) {
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
                    //End of Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 

                }



                if ($("#txtStartDate0").val() == "") {
                    strmsg = '- Start Date should not left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    //$("#txtEndDate" + htRowCount[i].value).focus();
                }

                if ($("#txtEndDate0").val() == "") {
                    strmsg = '- End Date should not left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    //$("#txtEndDate" + htRowCount[i].value).focus();
                }

                //if ($("#dtEndDateAssigntask").val() != '' && $("#dtStartDateAssigntask").val() != '') {
                //    if (CompairDates(dtAssignStartDate, dtAssignEndDate) == 1) {
                //        strmsg = '- Task Start date should not be less than Task End date';
                //        errorMsg += "<li>" + strmsg + "</li></br>";
                //        Flag = 1;
                //        checkFlag = 1;
                //        $("#dtEndDateAssigntask").focus();

                //    }
                //}
                // debugger;


                if ($("#txtEndDate0").val() != '' && checkFlag == 0) {
                    var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: $("#txtStartDate0").val(), strEndDate: $("#txtEndDate0").val() }), false);
                    if (result.d != "") {
                        var strMsg = String(result.d).split("_");
                        if (strMsg[0] == "1") {
                            // $('#spndtStartDate').text(strMsg[1]);
                            strmsg = '- ' + strMsg[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";

                        }
                        else {
                            //$('#spndtEndDate').text(strMsg[1]);
                            strmsg = '- ' + strMsg[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";

                        }
                        isValid = 1;
                        checkFlag = 1;
                    }
                }

                if (checkFlag == 0) {
                    var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate0").val(), EndDate: $("#txtEndDate0").val() });
                    var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                    if (Newresult.d != '') {
                        var arrResult = Newresult.d.split('##');

                        if (arrResult[0] == '1') {


                            strmsg = '-' + arrResult[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                        }
                        if (arrResult[0] == '2') {
                            strmsg = '-' + arrResult[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                        }

                        //if (arrResult[0] == '3') {
                        //    strmsg = '-' + arrResult[1];
                        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //    isValid = 1;
                        //    checkFlag = 1;
                        //}
                    }

                }





                if ($("#cboTaskType0").val() == "" || $("#cboTaskType0").val() == "Select TaskType") {
                    strmsg = 'Task Type should not left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    isValid = 1;
                    checkFlag = 1;
                    //$("#txtEndDate" + htRowCount[i].value).focus();
                }




                if ($("#txtStoryPoints0").val() != "") {
                    //Added By Riddhesh Patil on 11-NOV-2022 
                  
                        if (checkSpecialCharacter($("#txtStoryPoints0").val(), WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Story Point should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            $("#txtStoryPoints0").focus();
                            Flag = 1;
                            checkvalue = 1;
                        }
                  
        //End of Added By Riddhesh Patil
                    if ((document.getElementById('txtStoryPoints0')) < 0) {


                        strmsg = '- Please Enter only positive numeric value For Story Point';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                    else {

                        var n = $("#txtStoryPoints0").val();
                        var result = (n - Math.floor(n)) !== 0;

                        if (result) {
                            strmsg = '- Please enter Story Points without decimal';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }



                }

                if ($("#txtStoryPoints0").val() == "0") {


                    strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }


                //debugger;
                if (checkFlag == 0) {
                    var TaskID = "";
                    if ($("#txtStoryPoints0").val() != "") {
                        //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                        //var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints0").val(), TaskID: "" });
                        var data = "";
                        if ('<%= intUserStoryID%>' != undefined) {
                            data = JSON.stringify({ UserStoryID: '<%= intUserStoryID%>', StoryPoints: $("#txtStoryPoints0").val(), TaskID: "" });
                        }
                        else {
                            data = JSON.stringify({ UserStoryID: '', StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: "" });
                        }

                        //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 

                        var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);
                        // alert(Newresult.d);
                        if (Newresult.d != '') {
                            strmsg = Newresult.d;
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            $("#txtStoryPoints0").focus();
                        }
                    }
                }

                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error', 5);

                }
                
                return checkFlag;
                return isValid;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function validateAssignFormTask() {
            //debugger;
            var checkFlag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var dtAssignStartDate = "", dtAssignEndDate = "";
            var ProjectID = '<%= Session("intProjectID")%>';

            dtAssignStartDate = document.getElementsByName("dtStartDateAssigntask");
            dtAssignEndDate = document.getElementsByName("dtEndDateAssigntask");

            if ($("#AssigntxtTaskName").val() == "") {
                strmsg = '- Task Name should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#AssigntxtTaskName").focus();
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#AssigntxtTaskName").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Task Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#AssigntxtTaskName").focus();
                Flag = 1;
                checkvalue = 1;
            }

            //End of Added By Riddhesh Patil
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if ($("#txtTaskNotes").val() != ""){
                if (checkSpecialCharacter($("#txtTaskNotes").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Task Notes should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtTaskNotes").focus();
                Flag = 1;
                checkvalue = 1;
            }
        }
        //End of Added By Riddhesh Patil
            if ($("#cboAssignResources").val() == "0") {
                strmsg = '- Resource should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboAssignResources").focus();
            }


            if ($("#AssigntxtWorkHrs").val() == "") {
                strmsg = 'Work(Hrs) should not left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                isValid = 1;
                checkFlag = 1;
                $("#AssigntxtWorkHrs").focus();
            }

             if ($("#dtStartDateAssigntask").val() != '' && $("#dtEndDateAssigntask").val() != '') {
                if (CompairDates1($("#dtStartDateAssigntask").val(), $("#dtEndDateAssigntask").val()) == 1 && CompairDates1($("#dtStartDateAssigntask").val(), $("#dtEndDateAssigntask").val()) != 0) {
                    // $('#dtEndDate').css('border-color', 'red');
                    // $('#dtEndDate').css('border-width', '1px');
                    strmsg = '- Please enter Task End Date greater than or equal to Task Start Date!'
                    errorMsg += "<li>" + strmsg + "</li></br>";

                    // $('#spndtEndDate').text("Please enter Task End Date greater than or equal to Task Start Date!");
                    if (checkFlag != 1) {
                        //objEndDate.focus()
                    }
                    isValid = 1;
                    checkFlag = 1;
                }
            }

            if ($("#AssigntxtWorkHrs").val() != "" && checkFlag == 0) {
                //if (RestrictNonNumeric(document.getElementById('AssigntxtWorkHrs')) == true) {


                //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //}

                //Commented and Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 

                //  if (($("#AssigntxtWorkHrs").val() - 0) == 0) {

                //    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;

                //}

                //else if (parseFloat($("#AssigntxtWorkHrs").val()) < 0 && $("#AssigntxtWorkHrs").val() != '') {

                //    strmsg = '- Please enter positive Value For  Work(Hrs)';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    $("#AssigntxtWorkHrs").focus();

                //}

                try {
                    //alert(2);
                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("AssigntxtWorkHrs");
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    if (objHMEffort.value.indexOf(":") == -1) {
                        //strmsg = ' - Please enter efforts in valid format hh:mm!!';
                        //errorMsg += "<li>" + strmsg + "</li></br>";
                        //blnHMFormat = false;
                        ////setFocus(objHMEffort);
                        //isValid = 1;
                        //checkFlag = 1;
                        objHMEffort.value = objnewVal + ':00';
                        objnewVal = objHMEffort.value;
                    }

                    if (objHMEffort.value.indexOf(":") != -1) {
                        objHMEffort.value = objHMEffort.value.replace(':', '.');
                    }

                    //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    var tempEffort = objHMEffort.value.replace('-', '');
                    if (checkSpecialCharacter(tempEffort) == true) {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = 'Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        blnHMFormat = false;
                        objHMEffort.value = objVal;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    //if (blnResult == true) {
                    //    checkvalue = 1;
                    //}

                    //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById("AssigntxtWorkHrs")) == true) {
                            strmsg = 'Please enter Work(Hrs) in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            objHMEffort.value = objVal;
                            isValid = 1;
                            checkFlag = 1;
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
                            strmsg = "Please enter Work(Hrs) in H:M format.";
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = 'Hours should not be less than or equal to zero (0).';
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                        
                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = "Please enter minutes in two decimal and less than 60.";
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = ' Please enter minutes between (0-59) range';
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }

                    //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check
                     dtAssignStartDate = document.getElementById("dtStartDateAssigntask");
                    dtAssignEndDate = document.getElementById("dtEndDateAssigntask");
                    if (dtAssignStartDate.value != "" && dtAssignEndDate.value != "") {

                        var dblTotalDuration = DateDiff(dtAssignStartDate.value, dtAssignEndDate.value, "d") + 1;
                       
                        var data = JSON.stringify({ HMHours: WorkHour });
                        var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
                        var dblTotalWork = decTotalWorkResult.d;

                        dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                        // alert(dblAvgHoursPerDay);
                        // alert(dblTotalDuration);
                        if (dblAvgHoursPerDay > 24) {    ///////////////////////////////////////////                           

                            strmsg = 'You cannot assign more than 24 hours work per day';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }
                    //End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                    var MinDAENtryDisplay = "";

                    var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
                    var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    var MinDAEntry = resMinHoursForDAEntry.d;

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

                    var data = JSON.stringify({ Flag: "RestrictByMinHours" });
                    var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    if (resRestrictByMinHours.d == 'True') {
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
                                    //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                                    if (blnHMFormat == true) {
                                        strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                        errorMsg += "<li>" + strmsg + "</li>";
                                        isValid = 1;
                                        checkFlag = 1;
                                    }
                                }
                            }
                        }
                    }
                    if (checkFlag == 1) {
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

                //End of Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
            }



            if ($("#dtStartDateAssigntask").val() == "") {
                strmsg = '- Start Date should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#dtEndDateAssigntask").val() == "") {
                strmsg = '- End Date should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            //if ($("#dtEndDateAssigntask").val() != '' && $("#dtStartDateAssigntask").val() != '') {
            //    if (CompairDates(dtAssignStartDate, dtAssignEndDate) == 1) {
            //        strmsg = '- Task Start date should not be less than Task End date';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        Flag = 1;
            //        checkFlag = 1;
            //        $("#dtEndDateAssigntask").focus();

            //    }
            //}
           // debugger;
           

             if ($("#dtEndDateAssigntask").val() != '' && checkFlag == 0) {
                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: $("#dtStartDateAssigntask").val(), strEndDate: $("#dtEndDateAssigntask").val() }), false);
                if (result.d != "") {
                    var strMsg = String(result.d).split("_");
                    if (strMsg[0] == "1") {
                        // $('#spndtStartDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    else {
                        //$('#spndtEndDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    isValid = 1;
                    checkFlag = 1;
                }
            }

            if (checkFlag == 0) {
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#dtStartDateAssigntask").val(), EndDate: $("#dtEndDateAssigntask").val() });
                var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                if (Newresult.d != '') {
                    var arrResult = Newresult.d.split('##');

                    if (arrResult[0] == '1') {


                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                    if (arrResult[0] == '2') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }

                    //if (arrResult[0] == '3') {
                    //    strmsg = '-' + arrResult[1];
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    isValid = 1;
                    //    checkFlag = 1;
                    //}
                }

            }



           
            if ($("#AssigntaskcboPriorities").val() == "") {
                strmsg = 'Priority should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#AssigntaskcboTaskType").val() == "" || $("#AssigntaskcboTaskType").val() == "Select TaskType") {
                strmsg = 'Task Type should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#cboUserStory").val() == "") {
                strmsg = '- User Story should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }


            if ($("#AssigntxtStoryPoints").val() != "") {
                if ((document.getElementById('AssigntxtStoryPoints')) < 0) {


                    strmsg = '- Please Enter only positive numeric value For Story Point';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }
                else {
                 
                    var n = $("#AssigntxtStoryPoints").val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        strmsg = '- Please enter Story Points without decimal';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }



            }

            if ($("#AssigntxtStoryPoints").val() == "0") {


                strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }


            //debugger;
            if (checkFlag == 0) {
                var TaskID = "";
                if ($("#AssigntxtStoryPoints").val() != "") {
                    ///ADDED & COMMENTED BY DIPALI V ON 7TH MAY 2019 FOR S.P VALIDATION
                   // var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#AssigntxtStoryPoints").val(), TaskID: "" });
                    var data = JSON.stringify({ UserStoryID: '<%= intUserStoryID%>' , StoryPoints: $("#AssigntxtStoryPoints").val(), TaskID: "" });

                   ///ADDED & COMMENTED BY DIPALI V ON 7TH MAY 2019 FOR S.P VALIDATION
                    var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);
                    // alert(Newresult.d);
                    if (Newresult.d != '') {
                        strmsg = Newresult.d;
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                        $("#AssigntxtStoryPoints").focus();
                    }
                }
            }


            var objPhase = document.getElementById('cboPhase');
            var objModule = document.getElementById('cboModule');
            var objSubProject = document.getElementById('cboSubProject');
            var objMilestone = document.getElementById('cboMilestone');
            var objChangeRequest = document.getElementById('cboChangeRequest');
            var objDeliverable = document.getElementById('cboDeliverable');

            //debugger;
            if (objPhase != null) {
                if (objPhase.getAttribute("Mandatory") == "1") {
                    if (objPhase.value == '') {
                        //  objPhase1.css('border-color', 'red');2
                        // objPhase1.css('border-width', '1px');
                        // $('#spnPhase').text('Phase should not left blank !');
                        strmsg = '- Phase should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;


                    }
                }
            }

            if (objModule != null) {
                if (objModule.getAttribute("Mandatory") == "1") {
                    if (objModule.value == '') {
                        //objModule1.css('border-color', 'red');
                        //objModule1.css('border-width', '1px');
                        //$('#spnModule').text('Module should not left blank !');

                        strmsg = '- Module should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }

            if (objSubProject != null) {
                if (objSubProject.getAttribute("Mandatory") == "1") {
                    if (objSubProject.value == '') {
                        // objSubProject1.css('border-color', 'red');
                        // objSubProject1.css('border-width', '1px');
                        // $('#spnSubProject').text('Sub Project should not left blank !');

                        //if (checkFlag != 1) {
                        //   objSubProject.focus()
                        //}
                        //checkFlag = 1;
                        strmsg = '- Sub Project should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }
            if (objMilestone != null) {
                if (objMilestone.getAttribute("Mandatory") == "1") {
                    if (objMilestone.value == '') {
                        // objMilestone1.css('border-color', 'red');
                        // objMilestone1.css('border-width', '1px');
                        // $('#spnMilestone').text('Milestone should not left blank !');

                        // if (checkFlag != 1) {
                        //     objMilestone.focus()
                        // }
                        //checkFlag = 1;
                        strmsg = '- Milestone should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }

            if (objChangeRequest != null) {
                if (objChangeRequest.getAttribute("Mandatory") == "1") {
                    if (objChangeRequest.value == '') {
                        //objChangeRequest1.css('border-color', 'red');
                        //objChangeRequest1.css('border-width', '1px');
                        // $('#spnChangeRequest').text('Change Request should not left blank !');

                        //if (checkFlag != 1) {
                        //    objChangeRequest.focus()
                        //}
                        strmsg = '- Change Request should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                        //checkFlag = 1;
                    }
                }
            }

            if (($('#txtRelease') == "" || $('#txtIteration')) == "") {
                // $('#spnUserStory').text('Task cannot be created, As UserStory is not mapped to iteration or release!.');
                // document.getElementById('cboUserStory').focus()
                strmsg = '- Task cannot be created, As UserStory is not mapped to iteration or release.'
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }

            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkFlag;
            return isValid;

        }

        //function RestrictNonNumeric(obj) {
        //    if (obj == null) { return false; }
        //    if (isBlank(getInputValue(obj))) { return false; }

        //    var dofocus = (arguments.length > 1) ? arguments[1] : true;
        //    if (!isNumeric(getInputValue(obj))) {
        //        if (dofocus) {
        //            setFocus(obj);
        //        }
        //        return true;
        //    }
        //    return false;
        //}

        function UploadFileData() {
           // debugger;
            if (UploadData('<%= intUserStoryID%>', 1) == 1) {
                
               
            }
        }


        var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
        async function UploadData(userStoryID, pageFlag) {
            //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not


            if (arrFile[0] != "") {
                var objtxtFileName = arrFile[0].name;
                var objFile = objtxtFileName;
                var fileName = objtxtFileName;
                var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();
                

                isValidTypeExeCheck = false;
                //var fileName = arrFile[0];
                //    var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

                //  var objFileName = arrFile[0] ;
                isValidTypeExeCheck = false;
                //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                const ValidExtsExe = ValidateFileExtension.split(",");
                isValidTypeExeCheck = ValidExtsExe.includes(extension);

                if (isValidTypeExeCheck) {
                    const file = arrFile[0];
                    //const error = await validateDocFileForExe(file);
                    //console.log(error);
                    //await checkFileForExe(file);
                    await validateDocFileForExe(file)
                        .then(() => {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("File is valid and ready to upload.");
                            isValidTypeExeCheckFlag = true
                        })
                        .catch(error => {
                            console.log(error);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                            $(".demo-droppable p").text("Drag files here or click to upload");
                            arrFile = [];
                            isValidTypeExeCheck = false;
                            isValidTypeExeCheckFlag = false;
                            $(objtxtFileName).val("");
                            /*$(objFileName).attr("placeholder", "Upload File");*/
                            //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                            return;
                        });



                    if (!isValidTypeExeCheck) {
                        return;
                    }
                }

                //$(objtxtFileName).val("");

                //Ended by Parth Godshelwar
            }





            //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            // debugger;
            if (arrFile[0] != undefined) {
                var formdata = new FormData();
                formdata.append('file', arrFile[0]);
                formdata.append('Mode', 'Upload');
                formdata.append('UserStoryID', userStoryID);
                $.ajax({
                    type: 'post',
                    url: 'UserStoryDetails.aspx',
                    data: formdata,
                    success: function (status) {
                        //  debugger;
                        // alert(status);
                        if (status == "Invalid") {
                            // alert("Invalid content type!");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Invalid content type!", 'error', 5);
                        }
                        else {
                            if (pageFlag == 1) {
                                // debugger;
                                BindAttachementsData(userStoryID)
                                //Commented by swapna
                               // alert("kljs")
                                //document.getElementById("pDropZone").innerHTML = 
                                //document.getElementById("pDropZone").textContent = "Drag files here or click to upload";
                              
                             
                                //$("#pDropZone").text("Drag files here or click to upload")
                                //Comment end by swapna
                            }
                            else {
                            //alert("asd")
                                document.getElementById("divAttachmentList").innerHTML = status;
                                $('[data-bs-toggle="tooltip"]').tooltip();
                            }
                          
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
                alertify.notify("Please select file to  Upload", 'error', 5);


            }


            //  document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px';
            //if (arrFile[0] == undefined) {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify("Please Upload file!", 'error', 25);
            //}
        }
        //End by Swapna
        //Added by Usha Pandit on 22.03.2019 for Rank Save Issue
        function GetExistingUniqueNumberFromDBUS(strResult, objComplexityTemp, PriorityTemp) {
            
            ExistingUniqueNo = strResult.d;

            switch (PriorityTemp) {

                case '1':
                    UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '1');
                    break;
                case '2':
                    UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '2');
                    break;
                case '3':
                    UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '3');
                    break;
                case '4':
                    UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '4');
                    break;
                default:

            }
        }
        //End of Added by Usha Pandit on 22.03.2019 for Rank Save Issue

        function Update_UserStory() {
            //alert("fgfg")
           // debugger;
            //var checkvalue = 0;
            //var Flag = 0;
            //var strmsg = "";
            //var errorMsg = "<ul>"
            
            var UserStoryName = document.getElementById("txtFeatureName").value;
            if (document.getElementById("FreeTextDesc0") != undefined || document.getElementById("FreeTextDesc0") != null) {
                var Desc = document.getElementById("FreeTextDesc0").textContent;
            } else {
                var Desc = "";
            }

            if (document.getElementById("FreeTextDesc1") != undefined || document.getElementById("FreeTextDesc1") != null) {
                var AccepatanceCriteria = document.getElementById("FreeTextDesc1").textContent;
            } else {
                var AccepatanceCriteria = "";
            }
           
            //var AccepatanceCriteria = document.getElementById("FreeTextDesc1").textContent;
            var Priority = $("#cboPriority option:selected").text();
            var CategoryID = $("#cboUSCategory option:selected").val();
            var StoryPoints = document.getElementById("txtStoryPoint").value;
            
            var BusinessVal = document.getElementById("txtBusinessValue").value;   
            var Complexity = $("#cboComplexity option:selected").text();
            var StrState = $("#cboStateEdit option:selected").text();
            var version = $("#cboVersion option:selected").val();
            var FixedVersion = $("#cboFixedVersion option:selected").val();

            //Added by Usha Pandit on 22.03.2019 for Rank Save Issue
            var objComplexity = Complexity;
            var objPriority = document.getElementById('cboPriority');
            var PriorityTemp = objPriority.value;
            var strUserStoryId = '<%= intUserStoryID%>';
            flagUSID = strUserStoryId;
            //GetExistingUniqueNumberFromDB(objComplexity, PriorityTemp, flagUSID);
            if (PriorityTemp != "") {
                var url = "frmProductBacklog.aspx/GetExistingUniqueNumberFromDB";
                var data = JSON.stringify({ objComplexity: objComplexity, Priority: PriorityTemp, strUserStoryId: strUserStoryId });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                GetExistingUniqueNumberFromDBUS(strResult, objComplexity, PriorityTemp);
            }
            //End of Added by Usha Pandit on 22.03.2019 for Rank Save Issue
            if (SaveValidation() == 0) {

                // var RemoveHtml = $("#FreeTextDesc0").remove();
                var DescText = document.getElementById("FreeTextDesc0")
                var AcceptanceText = document.getElementById("FreeTextDesc1")
                var HTMLDesc = $("#FreeTextDesc0").html()
                var HTMLAcceptance = $("#FreeTextDesc1").html()



                var result = ajaxCall("UserStoryDetails.aspx/SaveUserStoryDetails", "POST", "application/json", "json",
                    JSON.stringify({
                        UserStoryID: getSearchParams('UserStoryId'),
                        strUserStoryName: UserStoryName, Description: Desc,
                        AcceptanceCriteria: AccepatanceCriteria, Priority: Priority, CategoryID: CategoryID,
                        StoryPoints: StoryPoints, HTMLDesc: HTMLDesc, HTMLAcceptance: HTMLAcceptance, BusinessVal: BusinessVal,
                        Complexity: Complexity, StrState: StrState, version: version, FixedVersion: FixedVersion
                        //Added by Usha Pandit on 22.03.2019 for Rank Save Issue
                        , UniqueNo: UniqueNo
                        //End of Added by Usha Pandit on 22.03.2019 for Rank Save Issue
                    }));
                //alert(result);
                if (result != undefined) {
                    if (result.d != 0) {
                        // alert(result.d)
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('User story details updated successfully', 'success', 5);
                        $("#lblUserStoryName").text($("#txtFeatureName").val())
                        //Added by swapna 18-07-2018
                        BindSubUserStoryTable("#tblShowHistory");
                        PopulateHistoryTable('<%= intUserStoryID%>');
                        //Added by Usha Pandit on 11.04.2019 for Rank Save Issue
                        $("#lblRank").text(UniqueNo);
                        //End of Added by Usha Pandit on 11.04.2019 for Rank Save Issue
                        //End by swapna
                    }

                }
            }
            
        }
        function SaveValidation() {
            var checkvalue = 0;
            var Flag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
           // debugger;
            if ($("#txtFeatureName").val() == "") {
                strmsg = '- User Story Name should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#txtFeatureName").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('User Story Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtFeatureName").focus();
                    Flag = 1;
                    checkvalue = 1;
                }
            
        //End of Added By Riddhesh Patil
            if ($("#FreeTextDesc0").text() == "") {
                strmsg = '- User Description should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            if ($("#FreeTextDesc0").text() != "") {

                if (String($("#FreeTextDesc0").text()).length > 1000) {


                    strmsg = '- You Can Enter Only 1000 Characters';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                //Added By Riddhesh Patil on 11-NOV-2022 
                else if (checkSpecialCharacter($("#FreeTextDesc0").text(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('User Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#FreeTextDesc0").focus();
                    Flag = 1;
                    checkvalue = 1;
                }

        //End of Added By Riddhesh Patil
            }
            
            if ($("#FreeTextDesc1").text() != "") {

                if (String($("#FreeTextDesc1").text()).length > 1000) {


                    strmsg = '- You Can Enter Only 1000 Characters';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
            }
            if ($("#cboPriority").val() == "") {
                strmsg = '- Priority should not be blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            
            if ($("#txtBusinessValue").val() != "") {
               // debugger;   
                if (isNaN(document.getElementById('txtBusinessValue').value) == true) {
                    

                    strmsg = '- Please Enter Numeric Value For Business Value';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                if (parseFloat($("#txtBusinessValue").val()) < 0 && $("#txtBusinessValue").val() != '') {
                    //alert('Please enter positive number');
                    strmsg = '- Please enter positive Value For Business Value';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                    //$("#txtBusinessValue").focus();

                }

            }
         
            if ($("#txtStoryPoint").val() != undefined) {
                
                if ($("#txtStoryPoint").val() != "") {
                    if (isNaN(document.getElementById('txtStoryPoint').value) == true) {


                        strmsg = '- Please Enter Numeric Value For Story Point';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkvalue = 1;
                    }
                    else if (parseFloat($("#txtStoryPoint").val()) < 0 && $("#txtStoryPoint").val() != '') {
                        //alert('Please enter positive number');
                        strmsg = '- Please enter positive Value For Story Point';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkvalue = 1;
                        $("#txtStoryPoint").focus();

                    }

                    else {

                        var n = $("#txtStoryPoint").val();
                        var result = (n - Math.floor(n)) !== 0;

                        // alert(result);
                        if (result) {
                            strmsg = '- Please enter Story Points without decimal';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkvalue = 1;
                            $("#txtStoryPoint").focus();

                        }

                    }

                }
              
            }
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkvalue
        }
       
     
        function AddNewDiscus(DiscussionID) {
            //debugger;
            if (DiscussionID == undefined) {
                DiscussionID = 0;
            }
            //alert(DiscussionID)
            var DiscussionVal = document.getElementById("post_discuss").innerHTML;
            var DiscussionData = document.getElementById("DiscussionTextArea").value;
            var UserStoryID = getSearchParams('UserStoryId');

            //Added By Riddhesh Patil on 11-NOV-2022 
            if ($("#DiscussionTextArea").val() != "") {
                if (checkSpecialCharacter($("#DiscussionTextArea").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Discussion should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#DiscussionTextArea").focus();
                    return false;
                }
            }
        //End of Added By Riddhesh Patil
            if (DiscussionVal == "Post") {
               
                AddNewDiscussion(UserStoryID, 'UserStory', DiscussionData, 'DiscussionTextArea', 1);
                BindDisscussionData(UserStoryID)
                ShowLessMoreContent()
                document.getElementById("DiscussionTextArea").value = "";
                $("#DiscussionTextArea").trigger('change');//For after saving Size of Textarea should be standard
            }
            else if (DiscussionVal == "Reply") {
                insertuserStoryDiscussion(UserStoryID, 'UserStory', DiscussionData, 'DiscussionTextArea', DiscussionID)
                BindDisscussionData(UserStoryID)
                ShowLessMoreContent()
                document.getElementById("DiscussionTextArea").value = "";
               $("#DiscussionTextArea").trigger('change');//For after saving Size of Textarea should be standard 

                document.getElementById("DiscussionTextArea").placeholder = "Post New Discussion..";
                document.getElementById("post_discuss").textContent = "Post";
                document.getElementById("post_discuss").setAttribute('onclick', 'AddNewDiscus()')

                // Added By Gauri On 06th Sep 2024 For Tooltip Issue
                document.getElementById("post_discuss").textContent = "Post";
                const postTooltip = bootstrap.Tooltip.getInstance('#post_discuss');

                let postTxt = 'Post'; 
                if (postTxt === 'Post') {
                    postTooltip.setContent({
                        '.tooltip-inner': 'Post'
                    }); 
                } else {
                    postTooltip.setContent({
                        '.tooltip-inner': 'Reply' 
                    });
                }
                // End of Added By Gauri On 06th Sep 2024 For Tooltip Issue
            }
        }
        var validateflag;
        function SaveSubData(strFlag) {
           //debugger;
            var UserStoryID = getSearchParams('UserStoryId');
            //added By dipali V On 29th April 2019
            validateflag = Save_SubTab_Data(UserStoryID, strFlag, '<%= Session("intProjectID")%>');
             //added By dipali V On 29th April 2019
            if (strFlag == 'Issue') {
                $("#txtSummary").trigger('change');
                $("#txtDescription").trigger('change');
                $("#countdownSummary").text('500')
            }
             //added By dipali V On 29th April 2019
            if (validateflag != 1) {
                if (strFlag == 'SubStory') {
                    ShowDatasubstoryTable()
                }
                BindSubUserStoryTable("#tblShowSubUserStory");
                PopulateSubUserStoryTable();
            }
            //added By dipali V On 29th April 2019
            BindSubUserStoryTable("#tblShowIssues");
            PopulateIssuesTable(UserStoryID);

            BindSubUserStoryTable("#tblShowReviews");
            PopulateReviewsTable(UserStoryID);

          
        }
        function clearIssueForm() {
            $("#txtSummary").val('')
            $("#txtDescription").val('')
            $("#cboIssueType").val('')
            $("#cboSubIssueType").val('')
            $("#cboreporter").val('')
            $("#cboResonsible").val('')
            $("#cboStatus").val('')
            $("#countdownSummary").text("500")
            $("#countdownDescription").text("1000")
        }
       var Type, SubType, Status
        function ShowData() {
            clearIssueForm();
            //var strUserResult = ajaxCall("UserStoryDetails.aspx/ChkUSMapped", "POST", "application/json", "json",
            //                     JSON.stringify({ UserStoryID: UserStoryID }));
            var strUserResult = '<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & intUserStoryID & ",'UserStory'", True))%>'
            if (strUserResult == 1) {
                //Added by Dipali V On 21st April 2020 For Login person should get display selected
                 var UserName =  "<%= Session("strUserName").ToString() %>";
                $("#cboreporter option:contains(" + UserName + ")").prop('selected', true);
                 //End of Added by Dipali V On 21st April 2020 For Login person should get display selected
                 
				//Added by Dipali V On 21st April 2020 For Login person should get display selected
                var Configureresponsible = "<%=Configureresponsible%>";
               // alert(Configureresponsible);
                //$("#cboResonsible option:contains(" + Configureresponsible + ")").prop('selected', true);
                $("#cboResonsible").val(Configureresponsible);
                 //End of Added by Dipali V On 21st April 2020 For Login person should get display selected

               // GetSelectedSubtype();
                //Added by Dipali V On 21st April 2020 For  Get Default values
                //GetSelectedSubtype()

                GetDefaultValues();
               // debugger;
                GetSelectedSubtype(document.getElementById("cboIssueType"));
                
                //End of Added by Dipali V On 21st April 2020 For  Get Default values
                document.getElementById("divIssueForm").style.display = "block";
                document.getElementById("table_issue").style.display = "none";

                document.getElementById("SaveIssueForm").style.display = "inline";
                
            }
            else {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Map User story to sprint", 'error', 5);
            }
        }
        function ShowDataFormTable() {

            document.getElementById("table_issue").style.display = "block";
            document.getElementById("divIssueForm").style.display = "none";

            document.getElementById("SaveIssueForm").style.display = "none";
        }
        function clearReviewForm() {
            $("#txtReviewtitle").val('');
            $("#cboReviewtype").val('');
            $("#txtReviewStartDate").val('');
            $("#txtReviewEnddate").val('');
            $("#cboReviewer").val('');
            $("#cboReviewee").val('');
            $("#cboRevieStatus").val('');
            $("#cboChecklist").val('');
            $("#txtReviewHrs").val('');
            GetReviewerList();
            GetRevieweeList();
        }
        function ShowDataReviewForm() {
            clearReviewForm();
            //var strAddLinkAccess = '<%--<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_checkUShasSprintnot " & intUserStoryID & ",'UserStory'", True))%>--%>'
            var strAddLinkAccess = '<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & intUserStoryID & ",'UserStory'", True))%>'
            if (strAddLinkAccess == 1) {
                document.getElementById("divReviewForm").style.display = "block";
                document.getElementById("divReviewList").style.display = "none";
                
                document.getElementById("saveReviewForm").style.display = "inline";
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                //Added by swapna 17-7-2018
                //alertify.notify("Map Relase and Sprint to Create Review", 'error', 25);
                alertify.notify("Map User Story to Sprint", 'error', 5);
                //End by swapna 17-7-2018
            }
        }
        function ShowDataReviewTable() {

            document.getElementById("divReviewList").style.display = "block";
            document.getElementById("divReviewForm").style.display = "none";

            document.getElementById("saveReviewForm").style.display = "none";

        }
        function clearTaskForm() {
            $("#AssigntxtTaskName").val('');
            $("#txtTaskNotes").val('');
            $("#cboAssignResources").val('');
            $("#AssigntxtWorkHrs").val('');
            $("#dtStartDateAssigntask").val('');
            $("#dtEndDateAssigntask").val('');
            $("#AssigntaskcboPriorities").val('');
            $("#AssigntaskcboTaskType").val('');
            $("#AssigntxtStoryPoints").val('');
            $("#cboChangeRequest").val('');
            $("#cboMilestone").val('');
            $("#cboModule").val('');
            $("#cboSubProject").val('');
            $("#countTaskNote").text('2000')
        }
        function ShowDataTaskForm() {
            clearTaskForm();
            //document.getElementById("divTaskForm").style.display = "block";
            //document.getElementById("divTaskList").style.display = "none";
            var strAddLinkAccess= '<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & intUserStoryID & ",'UserStory'", True))%>'
            if (strAddLinkAccess == 1) {
                document.getElementById("divTaskForm").style.display = "block";
                document.getElementById("divTaskList").style.display = "none";
                
                document.getElementById("SaveTaskForm").style.display = "inline";
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Task can not be created as User Story/Sprint get completed/not started", 'error', 5);
            }
        }

        function ShowDataTaskTable() {
            if (document.getElementById("divTaskList") != undefined) {///Added By Dipali V on 25th june 2020 For javascript

                document.getElementById("divTaskList").style.display = "block";
            }
            if (document.getElementById("divTaskForm") != undefined) {///Added By Dipali V on 25th june 2020 For javascript
                document.getElementById("divTaskForm").style.display = "none";
            }
            if (document.getElementById("SaveTaskForm") != undefined) {///Added By Dipali V on 25th june 2020 For javascript

                document.getElementById("SaveTaskForm").style.display = "none";
            }
            //Commented and Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
            PopulateTasksTable('<%= intUserStoryID%>');
            //End of Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
        }
        function ShowDatasubstoryTable() {
            
           
                 document.getElementById("divSubstoryList").style.display = "block";
                 document.getElementById("divSubstoryForm").style.display = "none";

                 document.getElementById("SaveSubStoryForm").style.display = "none";
            
        }
        function ShowDatasubstorywForm() {

            var UserStoryID = getSearchParams('UserStoryId');
            $("#txtSubStoryName").val('')
            $("#txtSubStoryDesc").val('')
            $("#SubcboPriority").val('')
            //Added By Dipali V On 6th May 2019 for Clear control
            $("#SubcboComplexity").val('')
            $("#SubcboCategory").val('')
            //End of Added By Dipali V On 6th May 2019 for Clear control
            $("#countSubUSdown").text('1000')
            var result=  ajaxCall("UserStoryDetails.aspx/ChkSubUS", "POST", "application/json", "json",
                                JSON.stringify({ UserStoryID: UserStoryID }));

            if (result.d == 1) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Sprint already started/completed you can not add sub userstory", 'error', 5);
                //document.getElementById("AddIssueForm").setAttribute('onclick', 'ShowData()')
            }
            else if (result.d == 2) {
                alertify.set('notifier', 'position', 'top-right');
                //Commented And Added By Usha Pandit On 17.07.2020 For giving correct alert
                //alertify.notify("Sub User story can not be added against user story", 'error', 5);
                alertify.notify("Sub User Story can not be added against Sub User Story", 'error', 5);
                //End Of Added By Usha Pandit On 17.07.2020 For giving correct alert
            }
            else if ((result.d == 0)) {
                document.getElementById("divSubstoryForm").style.display = "block";
                document.getElementById("divSubstoryList").style.display = "none";
                
                document.getElementById("SaveSubStoryForm").style.display = "inline";
            }
        }
        function GetSelectedSubtype(obj) {

            //alert(obj.value);
            //debugger;
            if (obj.value == "" || obj.value == undefined) {
                  //Added By Dipali V On For Issue ID 24350 
                if ($("#cboIssueType").val() == "") {
                    Type = obj.value;
                } else {
                    Type = Type;
                }
                  //End of Added By Dipali V On For Issue ID 24350 
            } else {

                 Type = obj.value;
            }
            var result = ajaxCall("UserStoryDetails.aspx/GetSubType", "POST", "application/json", "json",
                                 JSON.stringify({ TypeID:Type , WhichList: "SubType" }));
            if (result.d != '[]|') {

                BindDropdownSubType(result)
            }

            var result1 = ajaxCall("UserStoryDetails.aspx/GetStatus", "POST", "application/json", "json",
                                 JSON.stringify({ Issue_Type: obj.value }));
            if (result1.d != '[]|') {

                BindStatus(result1)
            }

        }
        //Added By Dipali V On 21st April 2020 For get default values
         function GetDefaultValues() {

            var result = ajaxCall("UserStoryDetails.aspx/GetDefultType", "POST", "application/json", "json",
                                 JSON.stringify({ }));
             if (result.d != '[]|') {
                // debugger;
                
                Result = result.d.split("||")
                Type = Result[0];
                SubType = Result[1];
                 Status = Result[2];
                 $("#cboIssueType").val(Type);
                 $("#cboSubIssueType").val(SubType);
                  $("#cboStatus").val(Status);
            }
            
            //var result1 = ajaxCall("UserStoryDetails.aspx/GetStatus", "POST", "application/json", "json",
            //                     JSON.stringify({ Issue_Type: obj.value }));
            //if (result1.d != '[]|') {

            //    BindStatus(result1)
            //}

        }

          //End of Added By Dipali V On 21st April 2020 For get default values

        function BindDropdownSubType(result) {
            var strArray = String(result.d).split("|")
            objCbo1 = document.getElementById("cboSubIssueType");
            $("#cboSubIssueType option").remove();
            //Added By Dipali V On For Issue ID 24350 
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = ""
            objOption.value = ""
              //End of Added By Dipali V On For Issue ID 24350 
            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = obj.FieldID;
                objOption.value = obj.FieldName;

            });

             //Added By Dipali v On 21st April 2020 For Default status
            if (SubType != "") {
                objCbo1.value = SubType;

                ///alert(objCbo1.value);
            }
            //End of Added By Dipali v On 21st April 2020 For Default status

        }
        function BindStatus(result) {
            // debugger;
            var strArray = String(result.d).split("|")
            // alert(strArray);
            objCbo1 = document.getElementById("cboStatus");
            var i = 0;
            objCbo1.innerHTML = "";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = obj.FieldID;
                objOption.value = obj.FieldName;

            });
            //Added By Dipali v On 21st April 2020 For Default status
            if (Status != "") {
                objCbo1.value = Status;

                ///alert(objCbo1.value);
            }
            //End of Added By Dipali v On 21st April 2020 For Default status
        }
        function BindTaskType() {
            var result = ajaxCall("UserStoryDetails.aspx/GetTaskType", "POST", "application/json", "json",
                               JSON.stringify({}));
            if (result.d != '[]|') {

                var strArray = String(result.d).split("|")
                objCbo1 = document.getElementById("cboTaskType0");
              //  $("#cboTaskType0 option").remove();
                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.text = obj.TaskType;
                    objOption.value = obj.TaskType;

                });
            }
        }

        function BindTaskResources() {
            var result = ajaxCall("UserStoryDetails.aspx/GetTaskResources", "POST", "application/json", "json",
                               JSON.stringify({}));
            if (result.d != '[]|') {

                var strArray = String(result.d).split("|")
                objCbo1 = document.getElementById("cboresource0");
               // $("#cboresource0 option").remove();
                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    //Added by swapna 13-07-2018
                    objOption.text = obj.UserName;
                    objOption.value = obj.EmployeeId;
                    //End by swapna 13-07-2018
                });
            }
        }
        function GetReviewerList() {
            $("#uiReviewerList").empty();
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowReviewerList", "POST", "application/json", "json",
                                JSON.stringify({}));
            if (strUserResult.d != '[]|') {
                //alert(strUserResult.d)
                var strArray = String(strUserResult.d).split("|")
                var i = 0;
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    //Commented & Added By Rutuja D. on 18 Jan 2020 For Revieew DropDown Resource Name display insted of Employee Name IssueID=29010
                   // var ReviwerName = obj["Resource Name"]
                    var ReviwerName = obj["Employee Name"]
                    //End of Commented & Added By Rutuja D. on 18 Jan 2020 For Revieew DropDown Resource Name display insted of Employee Name IssueID=29010
                    var ReviwerID = obj["EmployeeID"]
                    var List = "";
                    List = '<li style="padding-left: 4px;"><input type="hidden" id="hdnReviwerID' + ReviwerID + '" value="' + ReviwerID + '"><input type="checkbox" id="Reviwer' + ReviwerID + '" value="' + ReviwerName + '" class="k-checkboxcboReviewer" onclick="SelectReviwer(this,' + ReviwerID + ',\'' + ReviwerName + '\')"><label class="k-checkbox-label" for="eq1" style="margin-left: 9%; font-weight: 100!important">' + ReviwerName + '</label></li>'

                    $("#uiReviewerList").append(List);
                });
            }

        }


        function GetRevieweeList() {
            $("#uiRevieweeList").empty();
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowRevieweeList", "POST", "application/json", "json",
                                JSON.stringify({}));
            if (strUserResult.d != '[]|') {

                var strArray = String(strUserResult.d).split("|")
                var i = 0;
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    var ResourceName = obj["UserName"]
                    var ResourceID = obj["EmployeeId"]
                    // alert(ReviwerName)
                    var List = "";
                    List = '<li style="padding-left: 10px;"><input type="hidden" id="hdnresourceID' + ResourceID + '" value="' + ResourceID + '"><input type="checkbox" id="Resource' + ResourceID + '" value="' + ResourceName + '" class="k-checkbox" onclick="SelectResource(this, ' + ResourceID + ', \'' + ResourceName + '\')"><label class="k-checkbox-label" for="eq1" style="margin-left: 9%; font-weight: 100!important">' + ResourceName + '</label></li>'

                    $("#uiRevieweeList").append(List);
                });
            }
        }

        $(function(){
            // $('.ui-datepicker-prev').on("click", function(){
            //     $(".bs-tooltip-auto").removeClass("show");
            // })

            // Remove the tooltip attribute from the specific element
            // $('.ui-datepicker-prev').removeAttr('data-bs-original-title');
           
            // Select the element and add the data-bs-toggle attribute for the tooltip
            // $('#ui-datepicker-div > .ui-datepicker-prev').attr('data-bs-toggle', 'tooltip');

            // // Optionally, if you want to initialize the tooltip after adding the attribute
            // $('.ui-datepicker-prev').tooltip('disabled');

            // Select the 'Prev' button
const prevButton = document.querySelector('.ui-datepicker-prev');
prevButton.attr('data-bs-toggle', 'tooltip');
// Check if a tooltip already exists for this element
let prevTooltip = bootstrap.Tooltip.getInstance(prevButton);

// If tooltip already exists, dispose of it
if (prevTooltip) {
    prevTooltip.dispose();
}

// Reinitialize tooltip or create a new one
prevTooltip = new bootstrap.Tooltip(prevButton, {
    title: 'Prev', // You can set the title dynamically or use existing data attributes
    trigger: 'hover' // Ensure the tooltip behaves as expected on hover or click
});

// Optional: Ensure tooltips hide on click or other interactions
prevButton.addEventListener('click', function() {
    alert(111)
    const instance = bootstrap.Tooltip.getInstance(this);
    if (instance) {
        instance.hide(); // Hide tooltip after click
    }
});

        })

        $(document).ready(function ($) {
            //debugger;
            var x = 0;
            var count = 0;
            $("[id='FreeTextBox_editor']").each(function () {
                $(this).attr("id", "FreeTextDesc" + x);
                x++;

            })
            $('[data-bs-toggle="tooltip"]').tooltip();

          //  $(".progresspie").progressPie({ mode: $.fn.progressPie.Mode.COLOR, valueData: "val", strokeWidth: 15, strokeColor: "#ddd" });
            
            var UserStoryID = getSearchParams('UserStoryId');
            PlotControls();
            BindUserStoryData(UserStoryID)
            //Added by swapna
            BindStatusDropDown(UserStoryID)
            //end by swapna
            BindSubUserStoryTable("#tblShowSubUserStory");
            PopulateSubUserStoryTable();
            $(".progresspie").progressPie({ mode: $.fn.progressPie.Mode.COLOR, valueData: "val", strokeWidth: 15, strokeColor: "#ddd" });
            BindAttachementsData(UserStoryID);
            BindTeamData(UserStoryID)
           // debugger;
            BindSubUserStoryTable("#tblShowHistory");
            PopulateHistoryTable(UserStoryID);

            BindDisscussionData(UserStoryID);
            ShowLessMoreContent()
            BindSubUserStoryTable("#tblShowIssues");
            PopulateIssuesTable(UserStoryID);

            BindSubUserStoryTable("#tblShowReviews");
            PopulateReviewsTable(UserStoryID);
            GetReviewerList();
            GetRevieweeList();

            //Added by swapna 18-07-2018
            GetLineBurnUPEffortS(UserStoryID, 'UserStory', UserStoryID, "", "BurnDown");
            GetLineBurnDownStoryPoints(UserStoryID, 'UserStory', UserStoryID, "", "BurnUp");
            GetLineBurnDown(UserStoryID, 'UserStory', UserStoryID, "", "BurnUp");
            GetLineBurnUP(UserStoryID, 'UserStory', UserStoryID, "", "BurnDown");
            //End by swapna 18-07-2018

           // BindSubUserStoryTable("#tblShowTasks");
            PopulateTasksTable(UserStoryID)
            //BindTaskResourceDropDown(UserStoryID)
            // BindIssueAdd(UserStoryID);
            BindSubUserStoryTable("#tblTestCaseList");
            PopulateTestCaseTable(UserStoryID);
          
            initializFormControls();
            //Added by Usha Pandit on 18 July 2018 for close date picker on date selection
            $('.hasDatepicker').on('changeDate', function (ev) {
                $(this).datepicker('hide');
            });
           // debugger;
           //Added By Dipali V on 24th April 2018 For Disbaled Story Point control
            if ($("#txtStoryPoint").attr("readonly"))
            {
                $("#txtStoryPoint").prop("disabled", true);
            }
           //End of Added By Dipali V on 24th April 2018 For Disbaled Story Point control
          //Added by Usha Pandit on 18 July 2018 for close date picker on date selection

           //Comment Added by swapna
             //  getRows();
            //Comment End by swapna
            //$(".progresspie").progressPie({ mode: $.fn.progressPie.Mode.COLOR, valueData: "val", strokeWidth: 15, strokeColor: "#ddd" });
           // $(".progresspie").progressPie();
          
        });
        //function BindTaskResourceDropDown(UserStoryID) {
        //   //Added by swapna
        //    var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowAssignedResources", "POST", "application/json", "json",
        //                            JSON.stringify({ UserStoryID: UserStoryID }));
        //    //end by swapna
        //    if (strUserResult.d != '[]|') {

        //        var strArray = String(strUserResult.d).split("|")
        //        var i = 0;

        //        $.each(JSON.parse(strArray[0]), function (id, obj) {
                   
        //            $('#cboresource0').append($("<option></option>").attr("value", "1").text("abc"));
        //        });
        //    }
           

          
        //}

        //Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
        $("#DiscussionTextArea").keypress(function () {           
            if ($("#DiscussionTextArea").val().length >= 2000) {
               alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter Discussion less than 2000 characters.', 'error', 5);
                $("#DiscussionTextArea").focus();
            }
        });
        //End of Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
        //Commented and Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
        function PopulateTasksTableold(UserStoryID) {
           // alert("asds")
            //debugger;
            $("#tblShowTasks").empty();
            $('[data-bs-toggle="tooltip"]').tooltip();
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowTasksList", "POST", "application/json", "json",
                               JSON.stringify({ UserStoryID: UserStoryID }));
            var strAddLinkAccess = '<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & intUserStoryID & ",'UserStory'", True))%>'
            if (strUserResult.d != '[]|') {
                //alert(strUserResult.d)
                
                var strArray = String(strUserResult.d).split("|")
                var i = 0;
                
               
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    var Tasks =""
                   
                    Tasks = "       <tr><td></td>" +
                    "                <td style='width:20%' >" +
                                                         "<span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Name:" + obj.ScrumTaskName + "'><input type='Textbox' onmouseover='$(this).tooltip();' name='txtTaskName" + obj.TaskID + "' id='txtTaskName" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='255' value='" + obj.ScrumTaskName + "' placeholder='Task Name'  disabled></span>" +
                "</td>"+
                                                         " <td style='width:15%' >"+
                "  <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Start Date:" + ParseDate(obj.StartDate) + "'><input type='Textbox' name='txtStartDate" + obj.TaskID + "' id='txtStartDate" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='" + ParseDate(obj.StartDate) + "' placeholder='Start Date' onkeyup='ClearSpan('txtStartDate','spantxtStartDate" + obj.TaskID + "')' disabled></span>" +
                " <i  class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpstartdate" + obj.TaskID + "'  disabled></i>  " +
                " </td>"+
                " <td style='width:15%'>"+
                "    <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='End Date:" + ParseDate(obj.EndDate) + "'> <input type='Textbox' name='txtEndDate" + obj.TaskID + "' id='txtEndDate" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='" + ParseDate(obj.EndDate) + "' placeholder='End Date' onkeyup='ClearSpan('txtEndDate0','spantxtEndDate" + obj.TaskID + "')' disabled></span>" +
                "<i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpEnddate"+ obj.TaskID +"'  disabled></i>" +
                "      </td>"+
                " <td style='width:13%'>" +

                "   <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Working Hours:" + obj.Effort + "'> <input type='Textbox' name='txtWorkHrs" + obj.TaskID + "' id='txtWorkHrs" + obj.TaskID + "'  class='form-control' style='text-align:Center;width: 95%;' value='" + obj.Effort + "' placeholder='Work Hrs' onkeyup='ClearSpans(this.id,'SpantxtRresourceStartDate" + obj.TaskID + "','spanWorkHrs" + obj.TaskID + "','errorPopOver" + obj.TaskID + "')' maxlength='8' disabled></span>" +
                "</td>"+
                "<td style='width:13%'>"+
                "  <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Story Points:" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "'> <input type='Textbox' name='txtStoryPoints" + obj.TaskID + "' id='txtStoryPoints" + obj.TaskID + "' class='form-control' style='text-align:Center;width: 95%;' maxlength='3' value='" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "' placeholder='Story Pts' disabled></span>" +
                "</td>" +
               
              "<td style='width:12%'>" +
              //(strAddLinkAccess == 1 ?
              //"<select class='form-control' title='Task Type' style='width:110%!Important' id='cboTaskType" + obj.TaskID + "' name='cboTaskType" + obj.TaskID + "'><option title='TaskType' value='" + obj.EntityTypeID + "'>" + obj.EntityTypeID + "</option></select>" :
              //"<select class='form-control' title='Task Type' style='width:110%!Important' id='cboTaskType" + obj.TaskID + "' name='cboTaskType" + obj.TaskID + "'><option title='TaskType' value='" + obj.EntityTypeID + "'>" + obj.EntityTypeID + "</option></select>") + 

              //" 
                      "<span class='tool-tip' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Type:" + obj.EntityTypeID + "'><select class='form-control' style='width:90%!Important;' id='cboTaskType" + obj.TaskID + "' name='cboTaskType" + obj.TaskID + "' disabled><option  value='" + obj.EntityTypeID + "'>" + obj.EntityTypeID + "</option></select></span>" +
                      //<option title="Select TaskType" value="Select TaskType">Select TaskType</option><option title="Analysis" value="Analysis">Analysis</option><option title="Design" value="Design">Design</option><option title="Development" value="Development">Development</option><option title="Documentation" value="Documentation">Documentation</option><option title="Estimation" value="Estimation">Estimation</option><option title="Meeting" value="Meeting">Meeting</option><option title="Project Management" value="Project Management">Project Management</option><option title="Release" value="Release">Release</option><option title="Requirement Gathering" value="Requirement Gathering">Requirement Gathering</option><option title="Study or Research" value="Study or Research">Study or Research</option><option title="Review" value="Review">Review</option><option title="Rework" value="Rework">Rework</option><option title="Customer Support" value="Customer Support">Customer Support</option><option title="Training" value="Training">Training</option><option title="Testing" value="Testing">Testing</option><option title="User Acceptance Test" value="User Acceptance Test">User Acceptance Test</option>
               "</td>" +
                "  <td style='width:20%'>"+
                      "<span class='tool-tip ' tabindex='0'  data-bs-toggle='tooltip' data-bs-placement='top' title='Resource:" + obj.AssignedTo + "'><select class='form-control' style='width: 95%;' id='cboresource" + obj.TaskID + "' name='cboresource" + obj.TaskID + "' disabled><option value='" + obj.EmployeeID + "'>" + obj.AssignedTo + "</option></select></span>" +
                " </td>"+
                //Commented And Added By Usha Pandit On 16.12.2020 For hiding save task icon
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
                        " <td style='width:3%;'>" +
                (strAddLinkAccess == 1 ? 
                "   <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:pointer;'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Edit Task' onmouseover='$(this).tooltip();' class='fas fa-pencil-alt' onclick='EditTask(" + '<%= intUserStoryID %>' + "," + obj.TaskID + ")'></i>" :
                "  <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Task can not be edited as User Story/ Sprint is completed/Not started.' onmouseover='$(this).tooltip();' class='fas fa-pencil-alt' onclick='EditTask(" + '<%= intUserStoryID %>' + ",0)' disabled></i>") +
                "</td>"+
                "<td style='width:3%;'>" +
                 (strAddLinkAccess == 1 ? 
                "<i style='font-size:14px!important;text-align:center;color:red;cursor:pointer' data-bs-toggle='tooltip'  id='iddelete" + obj.TaskID + "' title='Delete Task' onmouseover='$(this).tooltip();' class='fa fa-trash' onclick='DeleteTask(" + '<%= intUserStoryID %>' + "," + obj.TaskID + ")' ></i>" :
                "<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='iddelete" + obj.TaskID + "'  title='Task can not be deleted as User Story/ Sprint is completed/Not started.' onmouseover='$(this).tooltip();' class='fa fa-trash' ></i>") +
                "</td>" +
                 "<td style='width:3%;' id='Update"+ obj.TaskID +"'>" +
                "<i style='font-size:14px!important;text-align:center;cursor:no-drop' data-bs-toggle='tooltip' data-bs-placement='auto' id='SaveBtn" + obj.TaskID + "' title='' onmouseover='$(this).tooltip();' class='fa fa-save' data-original-title='save Task' disabled></i>" +
                "</td>" +
                        //"<td style='width:3%;'></td>"     +
                        //"<td style='width:3%;'></td>"     +
                        //"<td style='width:3%;'></td>"     +
                        //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
                //End Of Added By Usha Pandit On 16.12.2020 For hiding save task icon
                "</tr>" 
                $("#tblShowTasks").append(Tasks);
                //myTable.row.add(["<input type='Textbox' name='txtTaskName0' id='txtTaskName0' class='form-control' style='text-align:Left' maxlength='255' value='' placeholder='Task Name' title='Task Name'>"]);

                //myTable.draw();
               // $("txtTaskName" + obj.TaskID + "").tooltip();
                   
                });
               // 
            
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            var Tasks1 = ""
            //Commented And Added By Usha Pandit On 15.12.2020 For hiding add task icon
            //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            Tasks1 = "       <tr><td><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;' onclick='validateNewTask(0)' data-bs-toggle='tooltip' data-bs-placement='right' title='' data-original-title='Click here to add new record'></i></td>" +
            //Tasks1 = "       <tr><td></td>" +
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            //End Of Added By Usha Pandit On 15.12.2020 For hiding add task icon
                "                <td style='width:20%'>" +
                                                     "<input type='Textbox' maxlength=255 name='txtTaskName0' id='txtTaskName0' class='form-control' style='text-align:Left;width: 95%;' maxlength='255' value='' placeholder='Task Name' data-bs-toggle='tooltip' title='Task Name' onmouseover='$(this).tooltip();'>" +
            "</td>" +
                                                     " <td style='width:15%' >" +
            "  <input type='Textbox' name='txtStartDate0' id='txtStartDate0' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='' placeholder='Start Date' data-bs-toggle='tooltip' title='Start Date' onmouseover='$(this).tooltip();' onkeyup='ClearSpan('txtStartDate','spantxtStartDate0')' >" +
            " <i  class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpstartdate0'  ></i>  " +
            " </td>" +
            " <td style='width:15%'>" +
            "     <input type='Textbox' name='txtEndDate0' id='txtEndDate0' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='' placeholder='End Date' data-bs-toggle='tooltip' title='End Date' onmouseover='$(this).tooltip();' onclick='' onkeyup='ClearSpan('txtEndDate0','spantxtEndDate')' >" +
            "<i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpEnddate0'  ></i>" +
            "      </td>" +
            " <td style='width:13%'>" +

            "    <input type='Textbox' name='txtWorkHrs0' id='txtWorkHrs0' class='form-control' style='text-align:Center;width: 95%;' value='' placeholder='Work Hrs' data-bs-toggle='tooltip' title='Work Hrs' onmouseover='$(this).tooltip();' onkeyup='ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0')' maxlength='4' >" +
            "</td>" +
            "<td style='width:13%'>" +
            "   <input type='Textbox' name='txtStoryPoints0' id='txtStoryPoints0' class='form-control' style='text-align:Center;width: 95%;' maxlength='3' value='' placeholder='Story Pts' data-bs-toggle='tooltip' title='Story Pts' onmouseover='$(this).tooltip();' >" +
            "</td>" +

          "<td style='width:12%'>" +

                  "<select class='form-control' data-bs-toggle='tooltip' title='Task Type' onmouseover='$(this).tooltip();' style='width:90%!Important;' id='cboTaskType0' name='cboTaskType0' ></select>" +

           "</td>" +
            "  <td style='width:20%'>" +
                  "<select class='form-control' data-bs-toggle='tooltip' title='Resource' onmouseover='$(this).tooltip();' style='width: 95%;' id='cboresource0' name='cboresource0' ><option value=''></option></select>" +
            " </td>" +
            " <td style='width:3%;'>" +
           //(strAddLinkAccess == 1 ?
           <%-- "<i style='font-size:14px!important;text-align:center;cursor:pointer' data-bs-toggle='tooltip' data-bs-placement='bottom' id='SaveBtn0' title='' onmouseover='$(this).tooltip();' class='fa fa-save' onclick='SaveAssignTask(" + '<%= intUserStoryID%>' + ",1)' data-original-title='save Task'></i>" :
           "<i style='font-size:14px!important;text-align:center;cursor:pointer' data-bs-toggle='tooltip' data-bs-placement='bottom' id='SaveBtn0' data-bs-toggle='tooltip' title='' onmouseover='$(this).tooltip();' class='fa fa-save' data-original-title='Task can not be created as User Story/ Sprint is completed/Not started.'></i>") +
            --%>
"</td>" +
            "<td style='width:3%;'>" +
             //"<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='iddelete0'  title='' class='fa fa-trash' disabled></i>" +
            "</td>" +
             "<td style='width:3%;' id='Update'>" +
            
                "</td>" +
                "</tr>"
                $("#tblShowTasks").append(Tasks1);

                BindTaskType()
                BindTaskResources()
                $('#txtStartDate0').datepicker({
                    dateFormat: "mm/dd/yy",
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
                $('#txtEndDate0').datepicker({
                    dateFormat: "mm/dd/yy",
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
              $('#txtStartDate0,#txtEndDate0').prop('readonly', true);
        }
      
        function PopulateTasksTable(UserStoryID) {
           
            //debugger;
            $("#tblShowTasks").empty();
            $('[data-bs-toggle="tooltip"]').tooltip();
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowTasksList", "POST", "application/json", "json",
                               JSON.stringify({ UserStoryID: UserStoryID }));
            var strAddLinkAccess = '<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & intUserStoryID & ",'UserStory'", True))%>'
            if (strUserResult.d != '[]|') {
                //alert(strUserResult.d)

                var strArray = String(strUserResult.d).split("|")
                var i = 0;


                $.each(JSON.parse(strArray[0]), function (id, obj) {

                   
                    //alert(obj.IsCancelStoryTasks );
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    var Tasks = ""
                    //Commented And Added By Reshma Chavan on 8th March 2022 
                   <%-- Tasks = "       <tr><td></td>" +
                    "                <td style='width:20%' >" +
                                                         "<span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Name:" + obj.ScrumTaskName + "'><input type='Textbox' onmouseover='$(this).tooltip();' name='txtTaskName" + obj.TaskID + "' id='txtTaskName" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='255' value='" + obj.ScrumTaskName + "' placeholder='Task Name'  disabled></span>" +
                "</td>" +
                                                         " <td style='width:15%' >" +
                "  <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Start Date:" + ParseDate(obj.StartDate) + "'><input type='Textbox' name='txtStartDate" + obj.TaskID + "' id='txtStartDate" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='" + ParseDate(obj.StartDate) + "' placeholder='Start Date' onkeyup='ClearSpan('txtStartDate','spantxtStartDate" + obj.TaskID + "')' disabled></span>" +
                " <i  class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpstartdate" + obj.TaskID + "'  disabled></i>  " +
                " </td>" +
                " <td style='width:15%'>" +
                "    <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='End Date:" + ParseDate(obj.EndDate) + "'> <input type='Textbox' name='txtEndDate" + obj.TaskID + "' id='txtEndDate" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='" + ParseDate(obj.EndDate)  + "' placeholder='End Date' onkeyup='ClearSpan('txtEndDate0','spantxtEndDate" + obj.TaskID + "')' disabled></span>" +
                "<i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpEnddate" + obj.TaskID + "'  disabled></i>" +
                "      </td>" +
                " <td style='width:13%'>" +

                "   <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Working Hours:" + obj.HMEffort + "'> <input type='Textbox' name='txtWorkHrs" + obj.TaskID + "' id='txtWorkHrs" + obj.TaskID + "'  class='form-control' style='text-align:Center;width: 95%;' value='" + obj.HMEffort + "' placeholder='Work Hrs' onkeyup='ClearSpans(this.id,'SpantxtRresourceStartDate" + obj.TaskID + "','spanWorkHrs" + obj.TaskID + "','errorPopOver" + obj.TaskID + "')' maxlength='8' disabled></span>" +
                "</td>" +
                "<td style='width:13%'>" +
                "  <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Story Points:" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "'> <input type='Textbox' name='txtStoryPoints" + obj.TaskID + "' id='txtStoryPoints" + obj.TaskID + "' class='form-control' style='text-align:Center;width: 95%;' maxlength='3' value='" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "' placeholder='Story Pts' disabled></span>" +
                "</td>" +

              "<td style='width:12%'>" +
              
                      "<span class='tool-tip' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Type:" + obj.EntityTypeID + "'><select class='form-control' style='width:90%!Important;' id='cboTaskType" + obj.TaskID + "' name='cboTaskType" + obj.TaskID + "' disabled><option  value='" + obj.EntityTypeID + "'>" + obj.EntityTypeID + "</option></select></span>" +
                      //<option title="Select TaskType" value="Select TaskType">Select TaskType</option><option title="Analysis" value="Analysis">Analysis</option><option title="Design" value="Design">Design</option><option title="Development" value="Development">Development</option><option title="Documentation" value="Documentation">Documentation</option><option title="Estimation" value="Estimation">Estimation</option><option title="Meeting" value="Meeting">Meeting</option><option title="Project Management" value="Project Management">Project Management</option><option title="Release" value="Release">Release</option><option title="Requirement Gathering" value="Requirement Gathering">Requirement Gathering</option><option title="Study or Research" value="Study or Research">Study or Research</option><option title="Review" value="Review">Review</option><option title="Rework" value="Rework">Rework</option><option title="Customer Support" value="Customer Support">Customer Support</option><option title="Training" value="Training">Training</option><option title="Testing" value="Testing">Testing</option><option title="User Acceptance Test" value="User Acceptance Test">User Acceptance Test</option>
               "</td>" +
                "  <td style='width:20%'>" +
                      "<span class='tool-tip ' tabindex='0'  data-bs-toggle='tooltip' data-bs-placement='top' title='Resource:" + obj.AssignedTo + "'><select class='form-control' style='width: 95%;' id='cboresource" + obj.TaskID + "' name='cboresource" + obj.TaskID + "' disabled><option value='" + obj.EmployeeID + "'>" + obj.AssignedTo + "</option></select></span>" +
                        " </td>" +
                       
                         " <td style='width:3%;'>" +
                     (strAddLinkAccess == 1 ?                       
                "   <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:pointer;'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Edit Task' onmouseover='$(this).tooltip();' class='fa fa-pencil' onclick='EditTask(" + '<%= intUserStoryID %>' + "," + obj.TaskID + ")'></i>" :               

                            "  <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Task can not be edited as User Story/ Sprint is completed/Not started.' onmouseover='$(this).tooltip();' class='fa fa-pencil' onclick='EditTask(" + '<%= intUserStoryID %>' + ",0)' disabled></i>") +
                        "</td>" +                                                        

                "<td style='width:3%;'>" +
                 (strAddLinkAccess == 1 ?
                "<i style='font-size:14px!important;text-align:center;color:red;cursor:pointer' data-bs-toggle='tooltip'  id='iddelete" + obj.TaskID + "' title='Delete Task' onmouseover='$(this).tooltip();' class='fa fa-trash' onclick='DeleteTask(" + '<%= intUserStoryID %>' + "," + obj.TaskID + ")' ></i>" :
                "<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='iddelete" + obj.TaskID + "'  title='Task can not be deleted as User Story/ Sprint is completed/Not started.' onmouseover='$(this).tooltip();' class='fa fa-trash' ></i>") +
                "</td>" +
                 "<td style='width:3%;' id='Update" + obj.TaskID + "'>" +
                "<i style='font-size:14px!important;text-align:center;cursor:no-drop' data-bs-toggle='tooltip' data-bs-placement='auto' id='SaveBtn" + obj.TaskID + "' title='' onmouseover='$(this).tooltip();' class='fa fa-save' data-original-title='save Task' disabled></i>" +
                "</td>" +
                       
                "</tr>"--%>

                    Tasks += " <tr><td></td>"
                    Tasks += " <td style='width:20%' >"
                    Tasks += "<span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Name:" + obj.ScrumTaskName + "'><input type='Textbox' onmouseover='$(this).tooltip();' name='txtTaskName" + obj.TaskID + "' id='txtTaskName" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='255' value='" + obj.ScrumTaskName + "' placeholder='Task Name'  disabled></span>"
                    Tasks += "</td>"
                    Tasks += "<td style='width:15%' >"
                    Tasks += "<span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Start Date:" + ParseDate(obj.StartDate) + "'><input type='Textbox' name='txtStartDate" + obj.TaskID + "' id='txtStartDate" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='" + ParseDate(obj.StartDate) + "' placeholder='Start Date' onkeyup='ClearSpan('txtStartDate','spantxtStartDate" + obj.TaskID + "')' disabled></span>"
                    Tasks += " <i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpstartdate" + obj.TaskID + "'  disabled></i>  "
                    Tasks += "</td>"
                    Tasks += "<td style='width:15%'>"
                    Tasks += "<span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='End Date:" + ParseDate(obj.EndDate) + "'> <input type='Textbox' name='txtEndDate" + obj.TaskID + "' id='txtEndDate" + obj.TaskID + "' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='" + ParseDate(obj.EndDate) + "' placeholder='End Date' onkeyup='ClearSpan('txtEndDate0','spantxtEndDate" + obj.TaskID + "')' disabled></span>"
                    Tasks += "<i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpEnddate" + obj.TaskID + "'  disabled></i>"
                    Tasks += " </td>"
                    Tasks += "<td style='width:13%'>"

                    Tasks += " <span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Working Hours:" + obj.HMEffort + "'> <input type='Textbox' name='txtWorkHrs" + obj.TaskID + "' id='txtWorkHrs" + obj.TaskID + "'  class='form-control' style='text-align:Center;width: 95%;' value='" + obj.HMEffort + "' placeholder='Work Hrs' onkeyup='ClearSpans(this.id,'SpantxtRresourceStartDate" + obj.TaskID + "','spanWorkHrs" + obj.TaskID + "','errorPopOver" + obj.TaskID + "')' maxlength='8' disabled></span>"
                    Tasks += "</td>"
                    Tasks += "<td style='width:13%'>"
                    Tasks += "<span class='d-inline-block' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Story Points:" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "'> <input type='Textbox' name='txtStoryPoints" + obj.TaskID + "' id='txtStoryPoints" + obj.TaskID + "' class='form-control' style='text-align:Center;width: 95%;' maxlength='3' value='" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "' placeholder='Story Pts' disabled></span>"
                    Tasks += "</td>"

                    Tasks += "<td style='width:12%'>"

                    Tasks += "<span class='tool-tip' tabindex='0' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Type:" + obj.EntityTypeID + "'><select class='form-control' style='width:90%!Important;' id='cboTaskType" + obj.TaskID + "' name='cboTaskType" + obj.TaskID + "' disabled><option  value='" + obj.EntityTypeID + "'>" + obj.EntityTypeID + "</option></select></span>"

                    Tasks += "</td>"
                    Tasks += "  <td style='width:20%'>"
                    Tasks += "<span class='tool-tip ' tabindex='0'  data-bs-toggle='tooltip' data-bs-placement='top' title='Resource:" + obj.AssignedTo + "'><select class='form-control' style='width: 95%;' id='cboresource" + obj.TaskID + "' name='cboresource" + obj.TaskID + "' disabled><option value='" + obj.EmployeeID + "'>" + obj.AssignedTo + "</option></select></span>"
                    Tasks += " </td>"

                    Tasks += " <td style='width:3%;'>"
                    if (strAddLinkAccess == 1) {
                        if (obj.IsCancelStoryTasks == true) {
                            Tasks += " <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop;'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Edit Task' onmouseover='$(this).tooltip();' class='fas fa-pencil-alt' onclick='EditTask(" + '<%= intUserStoryID %>' + ")'></i>"
                        }
                        else {
                           Tasks += " <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:pointer;'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Edit Task' onmouseover='$(this).tooltip();' class='fas fa-pencil-alt' onclick='EditTask(" + '<%= intUserStoryID %>' + "," + obj.TaskID + ")'></i>"
                        }
                    }
                    else {
                        Tasks += "  <i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-bs-placement='bottom' id='idEdit" + obj.TaskID + "' data-bs-toggle='tooltip' title='Task can not be edited as User Story/ Sprint is completed/Not started.' onmouseover='$(this).tooltip();' class='fas fa-pencil-alt' onclick='EditTask(" + '<%= intUserStoryID %>' + ",0)' disabled></i>"
                    }
                    Tasks += "</td>"

                    Tasks += "<td style='width:3%;'>" 
                    if (strAddLinkAccess == 1) {
                       
                       Tasks += "<i style='font-size:14px!important;text-align:center;color:red;cursor:pointer' data-bs-toggle='tooltip'  id='iddelete" + obj.TaskID + "' title='Delete Task' onmouseover='$(this).tooltip();' class='fa fa-trash' onclick='DeleteTask(" + '<%= intUserStoryID %>' + "," + obj.TaskID + ")' ></i>" 
                    }
                    else {
                       Tasks += "<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='iddelete" + obj.TaskID + "'  title='Task can not be deleted as User Story/ Sprint is completed/Not started.' onmouseover='$(this).tooltip();' class='fa fa-trash' ></i>" 
                    }
                    Tasks += "</td>"
                    Tasks += "<td style='width:3%;' id='Update" + obj.TaskID + "'>"
                    Tasks += "<i style='font-size:14px!important;text-align:center;cursor:no-drop' data-bs-toggle='tooltip' data-bs-placement='auto' id='SaveBtn" + obj.TaskID + "' title='' onmouseover='$(this).tooltip();' class='fa fa-save' data-original-title='save Task' disabled></i>"
                    Tasks += "</td>"

                    Tasks += "</tr>"
                    //End of Commented And Added By Reshma Chavan on 8th March 2022 
                    $("#tblShowTasks").append(Tasks);
                   

                });
                // 

            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            var Tasks1 = ""
            //Commented And Added By Usha Pandit On 15.12.2020 For hiding add task icon
           //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            Tasks1 = "       <tr><td><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;' onclick='validateNewTask(0)' data-bs-toggle='tooltip' data-bs-placement='right' title='' data-original-title='Click here to add new record'></i></td>" +
            //Tasks1 = "       <tr><td></td>" +
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
                //End Of Added By Usha Pandit On 15.12.2020 For hiding add task icon
                "                <td style='width:20%'>" +
                                                     "<input type='Textbox' maxlength=255 name='txtTaskName0' id='txtTaskName0' class='form-control' style='text-align:Left;width: 95%;' maxlength='255' value='' placeholder='Task Name' data-bs-toggle='tooltip' title='Task Name' onmouseover='$(this).tooltip();'>" +
            "</td>" +
                                                     " <td style='width:15%' >" +
            "  <input type='Textbox' name='txtStartDate0' id='txtStartDate0' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='' placeholder='Start Date' data-bs-toggle='tooltip' title='Start Date' onmouseover='$(this).tooltip();' onkeyup='ClearSpan('txtStartDate','spantxtStartDate0')' >" +
            " <i  class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpstartdate0'  ></i>  " +
            " </td>" +
            " <td style='width:15%'>" +
            "     <input type='Textbox' name='txtEndDate0' id='txtEndDate0' class='form-control' style='text-align:Left;width: 95%;' maxlength='100' value='' placeholder='End Date' data-bs-toggle='tooltip' title='End Date' onmouseover='$(this).tooltip();' onclick='' onkeyup='ClearSpan('txtEndDate0','spantxtEndDate')' >" +
            "<i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px!important;float:right!important;color:#0099CC;' id='#dpEnddate0'  ></i>" +
            "      </td>" +
            " <td style='width:13%'>" +

            "    <input type='Textbox' name='txtWorkHrs0' id='txtWorkHrs0' class='form-control' style='text-align:Center;width: 95%;' value='' placeholder='Work Hrs' data-bs-toggle='tooltip' title='Work Hrs' onmouseover='$(this).tooltip();' onkeyup='ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0')' maxlength='8' >" +
            "</td>" +
            "<td style='width:13%'>" +
            "   <input type='Textbox' name='txtStoryPoints0' id='txtStoryPoints0' class='form-control' style='text-align:Center;width: 95%;' maxlength='3' value='' placeholder='Story Pts' data-bs-toggle='tooltip' title='Story Pts' onmouseover='$(this).tooltip();' >" +
            "</td>" +

          "<td style='width:12%'>" +

                  "<select class='form-control' data-bs-toggle='tooltip' title='Task Type' onmouseover='$(this).tooltip();' style='width:90%!Important;' id='cboTaskType0' name='cboTaskType0' ></select>" +

           "</td>" +
            "  <td style='width:20%'>" +
                  "<select class='form-control' data-bs-toggle='tooltip' title='Resource' onmouseover='$(this).tooltip();' style='width: 95%;' id='cboresource0' name='cboresource0' ><option value=''></option></select>" +
            " </td>" +                
                "<td style='width:3%;'>" +
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
             "<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='iddelete0'  title='' class='fa fa-trash' disabled></i>" +
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
                "</td>" +
                " <td style='width:3%;'>" +
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
                (strAddLinkAccess == 1 ?
                    "<i style='font-size:14px!important;text-align:center;cursor:pointer' data-bs-toggle='tooltip' data-bs-placement='bottom' id='SaveBtn0' title='' onmouseover='$(this).tooltip();' class='fa fa-save' onclick='SaveAssignTask(" + '<%= intUserStoryID%>' + ",1)' data-original-title='save Task'></i>" :
                    "<i style='font-size:14px!important;text-align:center;cursor:pointer' data-bs-toggle='tooltip' data-bs-placement='bottom' id='SaveBtn0' data-bs-toggle='tooltip' title='' onmouseover='$(this).tooltip();' class='fa fa-save' data-original-title='Task can not be created as User Story/ Sprint is completed/Not started.'></i>") +
                //Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project

                "</td>" +
             "<td style='width:3%;' id='Update'>" +

                "</td>" +
                "</tr>"
            $("#tblShowTasks").append(Tasks1);

            BindTaskType()
            BindTaskResources()

            //Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
            BindTeamData(UserStoryID);
            //End of Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
            $('#txtStartDate0').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtEndDate0').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
              $('#txtStartDate0,#txtEndDate0').prop('readonly', true);
        }
        //End of Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 

        function EditTask(UserStoryID, TaskID) {
        
            $('[data-bs-toggle="tooltip"]').tooltip();
            if (TaskID != "") {
          
               $("#txtStartDate" + TaskID).removeAttr("disabled")
               $("#txtEndDate" + TaskID).removeAttr("disabled")
               $("#dpstartdate" + TaskID).removeAttr("disabled")
               $("#dpEnddate" + TaskID).removeAttr("disabled")
                $("#txtWorkHrs" + TaskID).removeAttr("disabled")
               $("#txtStartDate" + TaskID).css('cursor', 'pointer')
               $("#txtEndDate" + TaskID).css('cursor', 'pointer')
               $("#txtStoryPoints" + TaskID).removeAttr("disabled")
               $("#SaveBtn" + TaskID).removeAttr("disabled")
                //$("#SaveBtn" + TaskID).attr('class', 'fa fa-refresh');
                $("#SaveBtn" + TaskID).attr('class', 'fas fa-sync-alt');
               $('#txtStartDate' + TaskID).datepicker({
                   dateFormat: "mm/dd/yy",
                   changeMonth: true,
                   changeYear: true,
                   //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
               });
               $('#txtEndDate' + TaskID).datepicker({
                   dateFormat: "mm/dd/yy",
                   changeMonth: true,
                   changeYear: true,
                   //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
               });
              
               $("#SaveBtn" + TaskID).css('cursor', 'pointer')
               document.getElementById('SaveBtn' + TaskID).setAttribute('onclick', 'UpdateTask(' + TaskID + ')')
              
            }
        }
        function UpdateTask(TaskID) {
            //debugger;
            $('[data-bs-toggle="tooltip"]').tooltip();
          //  if (TaskID != "") {



                if (validateupdatetask(TaskID) == 0) {
                    //alert("asd")
                  // debugger;
                    saveFlag = 1;

                    var objTaskName = $('#txtTaskName' + TaskID);
                    var objResource = $('#cboresource' + TaskID);
                    var objTaskType = $('#cboTaskType' + TaskID).val();
                    var objWorkHrs = $('#txtWorkHrs' + TaskID);
                    var objStartDate = $('#txtStartDate' + TaskID);
                    var objEndDate = $('#txtEndDate' + TaskID);
                    var objPriorities = "";
                    var StoryPoints = $('#txtStoryPoints' + TaskID).val();
                    var BillableValue, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;

                    // alert(objTaskType);
                    var PracticeID = 0;
                    var extraPara = [];
                    extraPara.push(TaskID);
                    //extraPara.push(strPrimaryKey);

                    BillableValue = "0"
                    OnHoldValue = "0"

                    if (StoryPoints == "") {

                        StoryPoints = 0;
                    }

                    var objPhase = 0;
                    var objModule = 0;
                    var objSubProject = 0;
                    var objMilestone = 0;
                    var objChangeRequest = 0;
                    var objDeliverable = 0;


                    if (objPhase == 0)
                        PhaseVal = 0

                    if (objModule == 0)
                        ModuleVal = 0

                    if (objSubProject == 0)
                        SubProjectVal = 0

                    if (objMilestone == 0)
                        MilestoneVal = 0

                    if (objChangeRequest == 0)
                        ChangeRequestVal = 0

                    if (objDeliverable == 0)
                        DeliverableVal = 0

                    var URL, data;



                    URL = 'UserStoryDetails.aspx/SaveTask';

                    var AssignTaskData = [];
                   
                    AssignTaskData.push({
                        TaskID: TaskID,
                        TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                        Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                        MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: '<%= Session("intProjectID")%>', PracticeID: PracticeID,
                        UserStoryID: '<%= intUserStoryID%>', strEntity: "", StoryPoints: StoryPoints, PageFlag: 1
                    });

                    data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: '<%= intUserStoryID%>', });
                    //alert(data)
                    //Added by swapna
                    //var strUserResult = ajaxCall(URL, "POST", "application/json", "json", data);
                   // alert()
                   AJAXCallWithPara(URL, data, AfterEditTask, extraPara);
                     //alert(strUserResult.d)
                    //End by swapna
                    //if (strUserResult.d == 1) {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('Task Updated successfully', 'success', 25);
                    //}

               // }
            }


            $('[data-bs-toggle="tooltip"]').tooltip();
            $('#txtEndDate').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtStartDate').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });

        }
        //Added by swapna
        function AfterEditTask(data, extraPara) {
          
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Updated successfully', 'success', 5);
            PopulateTasksTable('<%= intUserStoryID%>')
        }
        //End by swapna
        function validateupdatetask(TaskID) {
            
           
            var strmsg = "";
            var checkFlag = 0;
            var ProjectID = '<%= Session("intProjectID")%>';
            var errorMsg = "<ul>"
            var dtStartDate = document.getElementById('txtStartDate' + TaskID);
            var dtEndDate = document.getElementById('txtEndDate' + TaskID);

            if ($("#txtStartDate" + TaskID).val() == "") {
                strmsg = '- Start Date should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtStartDate" + TaskID).focus();
            }


            if ($("#txtEndDate" + TaskID).val() == "") {
                strmsg = '- End Date should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtEndDate" + TaskID).focus();
            }


            if ($("#txtEndDate" + TaskID).val() != '' && $("#txtStartDate" + TaskID).val() != '') {
                //if (CompairDates(dtStartDate, dtEndDate) == 1) {
                //    strmsg = '- Task Start date should not be less than Task End date';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    Flag = 1;
                //    checkFlag = 1;
                //    $("#txtEndDate").focus();

                //}

                if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
                    try {
                        var oldcurStart = $("#txtStartDate" + TaskID).val();
                        var oldcurEnd = $("#txtEndDate" + TaskID).val();
                        var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
                        var curEnd = opformatDate($("#txtEndDate" + TaskID).val(), 'DD/MM/YYYY');
                        $("#txtStartDate" + TaskID).val(curStart);
                        $("#txtEndDate" + TaskID).val(curEnd);
                        if (CompairDates(dtStartDate, dtEndDate) == 1) {
                            strmsg = '- Task Start date should be less than Task End date';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkFlag = 1;
                            $("#txtEndDate").focus();

                        }
                        $("#txtStartDate" + TaskID).val(oldcurStart);
                        $("#txtEndDate" + TaskID).val(oldcurEnd);
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                }
                else {
                    if (CompairDates(dtStartDate, dtEndDate) == 1) {
                        strmsg = '- Task Start date should be less than Task End date';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkFlag = 1;
                        $("#txtEndDate").focus();

                    }
                }
            }
    
             if (dtEndDate.value != '' && checkFlag == 0) {
                //Commented and Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
                //var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: '<%= intUserStoryID%>', strStartDate:  $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
                 var result = '';
                if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
                    var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
                    var curEnd = opformatDate($("#txtEndDate" + TaskID).val(), 'DD/MM/YYYY');
                   
                    
                    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: '<%= intUserStoryID%>', strStartDate: curStart, strEndDate: curEnd }), false);
                }
                else {
                    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: '<%= intUserStoryID%>', strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
                }	
                //End of Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy

                if (result.d != "") {
                    var strMsg = String(result.d).split("_");
                    if (strMsg[0] == "1") {
                        // $('#spndtStartDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    else {
                        //$('#spndtEndDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    isValid = 1;
                    checkFlag = 1;
                    //$("#txtStartDate" + TaskID).focus();
                }
            }

            if (checkFlag == 0) {

                //Commented and Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
                //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: parseDate($("#txtStartDate" + TaskID).val()), EndDate: parseDate($("#txtEndDate" + TaskID).val()) });
                var data = '';
                if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
                    var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
                    var curEnd = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
                   
                    data = JSON.stringify({ ProjectID: ProjectID, StartDate: curStart, EndDate: curEnd });
                }
                else {
                    data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + TaskID).val(), EndDate: $("#txtEndDate" + TaskID).val() });
                }
                //End of Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy

                var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                if (Newresult.d != '') {
                    var arrResult = Newresult.d.split('##');

                    if (arrResult[0] == '1') {


                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                    if (arrResult[0] == '2') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;

                    }

                    if (arrResult[0] == '3') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }

            }


           // debugger;
            if ($("#txtWorkHrs" + TaskID).val() == "") {
                strmsg = 'Work(Hrs) should not left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                isValid = 1;
                checkFlag = 1;
                $("#txtWorkHrs" + TaskID).focus();
            }
           // debugger;
            //if ($("#txtWork" + TaskID != "")) {
            if ($("#txtWorkHrs" + TaskID).val() != "" && checkFlag == 0) {

                //Commented and Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
                //if ((isNaN($("#txtWorkHrs" + TaskID).val()) == true)) {


                //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //}

                //else if (($("#txtWorkHrs" + TaskID).val() - 0) == 0) {

                //    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;

                //}

                //else if (parseFloat($("#txtWorkHrs" + TaskID).val()) < 0 && $("#txtWorkHrs" + TaskID).val() != '') {

                //    strmsg = '- Please enter positive Value For  Work(Hrs)';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    $("#txtWorkHrs").focus();

                //}

                try {
                    //alert(3);
                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("txtWorkHrs" + TaskID);
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    if (objHMEffort.value.indexOf(":") == -1) {
                        //strmsg = ' - Please enter efforts in valid format hh:mm!!';
                        //errorMsg += "<li>" + strmsg + "</li></br>";
                        //blnHMFormat = false;
                        ////setFocus(objHMEffort);
                        //isValid = 1;
                        //checkFlag = 1;
                        objHMEffort.value = objnewVal + ':00';
                        objnewVal = objHMEffort.value;
                    }

                    if (objHMEffort.value.indexOf(":") != -1) {
                        objHMEffort.value = objHMEffort.value.replace(':', '.');
                    }

                    //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    var tempEffort = objHMEffort.value.replace('-', '');
                    if (checkSpecialCharacter(tempEffort) == true) {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = 'Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        objHMEffort.value = objVal;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    //if (blnResult == true) {
                    //    checkvalue = 1;
                    //}

                    //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById("txtWorkHrs" + TaskID)) == true) {
                            strmsg = 'Please enter Work(Hrs) in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            objHMEffort.value = objVal;
                            isValid = 1;
                            checkFlag = 1;
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
                            strmsg = "Please enter Work(Hrs) in H:M format.";
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = 'Hours should not be less than or equal to zero (0).';
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                        
                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = "Please enter minutes in two decimal and less than 60.";
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = 'Please enter minutes between (0-59) range';
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }

                    //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check
                    
                 
                    if (dtStartDate.value != "" && dtEndDate.value != "" && checkFlag == 0) {
                       
                        //var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;
                       // alert(dtStartDate.value);
                        
                       
                        //alert(dStartDate);
                        // alert(dEndDate);
                        //var dblTotalDuration = DateDiff(dtStartDate.value.replace('?',''), dtEndDate.value.replace('?',''), "d") + 1;
                         var data = JSON.stringify({ StartDate: dtStartDate.value, EndDate :  dtEndDate.value });
                         var cntDaysCountResult = AJAXCallWithResult("UserStoryDetails.aspx/getDateDiff", data, false);
                       
                        var dblTotalDuration = cntDaysCountResult.d;
                      //  alert(DateDiff($("#txtStartDate" + TaskID).val(), $("#txtEndDate" + TaskID).val(), "d"));
                     
                        data = JSON.stringify({ HMHours: WorkHour });
                        var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
                        var dblTotalWork = decTotalWorkResult.d;

                        dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                      
                        // alert(dblAvgHoursPerDay);
                        // alert(dblTotalDuration);
                        if (dblAvgHoursPerDay > 24) {    ///////////////////////////////////////////                           

                            strmsg = 'You cannot assign more than 24 hours work per day';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }
                    //End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                    var MinDAENtryDisplay = "";

                    var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
                    var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    var MinDAEntry = resMinHoursForDAEntry.d;

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

                    var data = JSON.stringify({ Flag: "RestrictByMinHours" });
                    var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    if (resRestrictByMinHours.d == 'True') {
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
                                    //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                                    if (blnHMFormat == true) {
                                        strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                        errorMsg += "<li>" + strmsg + "</li>";
                                        isValid = 1;
                                        checkFlag = 1;
                                    }
                                }
                            }
                        }
                    }
                    if (checkFlag == 1) {
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

                if (RestrictNonNumeric(document.getElementById("txtWorkHrs" + TaskID)) == false && (objHMEffort.value.indexOf(":") != -1)) {
                    //End of Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 

                    var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationEfforts', JSON.stringify({ strUserStoryID: '<%= intUserStoryID%>', strEfforts: $("#txtWorkHrs" + TaskID).val(), strTaskID: TaskID }), false);
                    if (result.d != "") {
                        strmsg = "- " + result.d + "";
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                        $("#txtWorkHrs").focus();
                    }
                }
            }

            if ($("#cboTaskType" + TaskID).val() == "Select TaskType") {
                strmsg = '- Task Type should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboTaskType" + TaskID).focus();
            }

            if ($("#cboresource" + TaskID).val() == "0") {
                strmsg = '- Resource should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboresource" + TaskID).focus();
            }



            if ($("#txtStoryPoints" + TaskID).val() != "") {
                if (RestrictNonNumeric(document.getElementById('txtStoryPoints')) == true) {
                    strmsg = '- Please Enter  only positive numeric value For Story Point';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }
                else {
                    var n = $("#txtStoryPoints" + TaskID).val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        strmsg = '- Please enter Story Points without decimal';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }


            if ($("#txtStoryPoints" + TaskID).val() == "0") {
                {


                    strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }

            }
            //var InitialEstimate = ($("#txtStoryPoint").val() - 0);
            //if (InitialEstimate != 0) {
            //    if (($("#txtStoryPoints" + TaskID).val() - 0) > InitialEstimate) {

            //        strmsg = '- Story Point should be less than ' + InitialEstimate + '(assigned on User story)';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        Flag = 1;
            //        checkFlag = 1;
            //        $("#txtStoryPoints" + TaskID).focus();

            //    }
            //}

            if (checkFlag == 0) {

                //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                //var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: TaskID });
                var data = "";
                if ('<%= intUserStoryID%>'  != undefined) {
                    data = JSON.stringify({ UserStoryID: '<%= intUserStoryID%>' , StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: TaskID });
                }
                else {
                    data = JSON.stringify({ UserStoryID: '', StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: TaskID });
                }

                //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 

                var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);

                if (Newresult.d != '') {
                    strmsg = Newresult.d;
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtStoryPoints" + TaskID).focus();
                }
            }

            //if (($("#hdnInitialEstimate").val() - 0) < ($("#hdnSumEfforts").val() - 0)) {

            //    strmsg = '- The sum of tasks was greater that Story point of User Story.';
            //    errorMsg += "<li>" + strmsg + "</li></br>";
            //    isValid = 1;
            //    checkFlag = 1;
            //    $("#txtStoryPoints" + TaskID).focus();

            //}



            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkFlag;
            return isValid;

        }
        function DeleteTask(USID, taskId) {
            //alert("asa")
            // debugger;
            //var extraPara = [];
           // extraPara.push(taskId);
            //debugger;
            var strUserResult = ajaxCall("UserStoryDetails.aspx/AfterDeleteTask", "POST", "application/json", "json",
                                 JSON.stringify({ taskId: taskId, UserStoryId: '<%= intUserStoryID%>' }));
            if (strUserResult.d == 1) {
                
                PopulateTasksTable('<%= intUserStoryID%>')
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Task Deleted successfully', 'success', 5);
            }

            //var AssignDeletetaskData = [];
           // URL = 'frmSprintPlanning.aspx/AfterDeleteTask';
            //AssignDeletetaskData.push({
            //    taskId: taskId

            //});

            //data = JSON.stringify({ taskId: taskId, UserStoryId: strUserStoryId, });
         //   AJAXCallWithPara(URL, data, AfterDeleteTask, extraPara);
            //$('#txtEndDate').datepicker();
            //$('#txtStartDate').datepicker();
            //$('#txtEndDate0').datepicker();
            //$('#txtStartDate0').datepicker();
            //$('[data-bs-toggle="tooltip"]').tooltip();
        }
        function PopulateTestCaseTable(UserStoryID) {
            //debugger;
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowTestCaseList", "POST", "application/json", "json",
                                   JSON.stringify({ UserStoryID: UserStoryID }));
            if (strUserResult.d != '[]|') {
                //alert(strUserResult.d)
                var strArray = String(strUserResult.d).split("|")
                var i = 0;
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    myTable.row.add(["<span data-bs-toggle='tooltip' title='Test Case ID'>" + obj.ProjectTestCaseID + "</span>", "<span data-bs-toggle='tooltip' title='Test Case Code'>" + obj.TestCaseCode + "</span>",
                        "<span data-bs-toggle='tooltip' title='Test Set Name'>" + obj.TestSetName, "<span data-bs-toggle='tooltip' title='Test Procedure'>" + obj.TestProcedure + "</span>",
                        "<span data-bs-toggle='tooltip' title='Issues'>" + obj.Issues + "</span>", "<span data-bs-toggle='tooltip' title='Pass'>" + obj.Pass + "</span>", "<span data-bs-toggle='tooltip' title='Fail'>" + obj.Fail + "</span>",
                        "<span data-bs-toggle='tooltip' title='Non Tested'>" + obj.NonTested + "</span>"]);

                    myTable.draw();
                });
            }
        }
        oTable4 = $('#tblTestCaseList').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
        $('#search_test').keyup(function () {
            oTable4.search($(this).val()).draw();
        })
        //function BindStatusDropDown added by swapna
        function BindStatusDropDown(UserStoryID, Status) {
            //try {
                // debugger;
                if (UserStoryID == '<%= intUserStoryID%>') {
                    var strStatus = '<%= strStatus%>'
                }
                else {
                    var strStatus = Status
                }


                if (strStatus != 'Open') {
                    var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowStatus", "POST", "application/json", "json",
                        JSON.stringify({}));
                    if (strUserResult.d != '[]|') {

                        var strArray = String(strUserResult.d).split("|")
                        var i = 0;

                        $.each(JSON.parse(strArray[0]), function (id, obj) {
                            var Status = ""
                            Status = '<li><a class="dropdown-item" href="#" onclick="changeStatus(' + obj.StageID + ',\'' + obj.StageName + '\' ,' + obj.IsCustom + ',' + UserStoryID + ')">' + obj.StageName + '</a></li>'
                            $("#StatusDropDown_" + UserStoryID).append(Status)
                        });
                    }
                    $("#btnStatus_" + UserStoryID).text(strStatus)
                }
                else {
                    $("#btnStatus_" + UserStoryID).text("Not Planned");
                    //Commented And Added By Usha Pandit On 17.07.2020 for javascript error
                    //document.getElementById("btnDropDown_" + UserStoryID).style.display = 'none';
                    if (document.getElementById("btnDropDown_" + UserStoryID) != null && document.getElementById("btnDropDown_" + UserStoryID) != undefined)
                    {                        
                        document.getElementById("btnDropDown_" + UserStoryID).style.display = 'none';
                    }
                    //End Of Added By Usha Pandit On 17.07.2020 for javascript error
                }

            //}
            //catch (ex) {
            //    alert(ex.message);
            //}
        }
        //function BindStatusDropDown end by swapna

        // function changeStatus Added by Swapna
        function changeStatus(StageID, StageName, IsCustom, USID) {
            //alert(StageID)
            //alert(StageName)
            //alert(IsCustom)
            $.ajax({
                type: "POST",
                url: "frmScrumBoard.aspx/ValidateLogPersonAccessUserStory",
                data: JSON.stringify({ UserStoryID: USID }),
                dataType: "json",
                contentType: "application/json",
                timeout: 180000,
                async: false,
                success: function (res) {

                    if (res.d != "") {

                        bootbox.confirm({
                            message: res.d,
                            buttons: {
                                cancel: {
                                    label: 'No',
                                    className: 'btn-danger float-end1'
                                },
                                confirm: {
                                    label: 'Yes',
                                    className: 'btn-success'
                                }

                            },
                            callback: function (result) {
                               // debugger;
                                if (result == true) {
                                    //if drop stage is a custom stage
                                    if (IsCustom == 1) {
                                        $.ajax({
                                            type: "POST",
                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Custom" }),
                                            dataType: "json",
                                            contentType: "application/json",
                                            timeout: 180000,
                                            async: true,
                                            success: function (result) {

                                                if (result.d == "1") {
                                                    $("#btnStatus_"+USID).text(StageName)
                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify("User Story Moved Successfully", 'success', 20);
                                                    //$("#DragDropModal .close").click();
                                                    //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                }
                                                else {
                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify(result.d, 'error', 20);
                                                    return;
                                                }
                                            },
                                            error: function (xhr, status, error) {
                                                console.log(xhr.responseText);

                                            }
                                        });
                                    }
                                        //End of if drop stage is a custom stage
                                        //If drop stage is not a custom stage
                                    else {
                                        if (StageName == 'In Progress') {


                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/DropValidation",
                                                data: JSON.stringify({ UserStoryID: USID, StageID: "", Mode: "InProgress", IssueOpenFlag: "0" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {

                                                    if (result.d != 0) {

                                                        bootbox.confirm({
                                                            message: result.d,
                                                            buttons: {
                                                                cancel: {
                                                                    label: 'No',
                                                                    className: 'btn-danger float-end1'
                                                                },
                                                                confirm: {
                                                                    label: 'Yes',
                                                                    className: 'btn-success'
                                                                }

                                                            },
                                                            callback: function (result) {

                                                                if (result == true) {
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                                        data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                                        dataType: "json",
                                                                        contentType: "application/json",
                                                                        timeout: 180000,
                                                                        async: true,
                                                                        success: function (result) {
                                                                            //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                            if (result.d == "1") {
                                                                                //End Added By Vaijat K ON 13/04/2017 
                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                                //$("#DragDropModal .close").click();
                                                                                //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                $("#btnStatus_"+USID).text(StageName)
                                                                            }
                                                                            else {
                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify(result.d, 'error', 20);
                                                                                return;
                                                                            }
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            console.log(xhr.responseText);

                                                                        }
                                                                    });
                                                                }
                                                                else {

                                                                    return;
                                                                }
                                                            }
                                                        })
                                                    }
                                                    else {
                                                        // Update StageId
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: true,
                                                            success: function (result) {

                                                                if (result.d == "1") {

                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                    $("#btnStatus_"+USID).text(StageName)
                                                                    //$("#DragDropModal .close").click();
                                                                    //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                }
                                                                else {
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                    //  alert();
                                                                    return;
                                                                }
                                                            },
                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);

                                                            }
                                                        });
                                                    }

                                                },
                                                error: function (xhr, status, error) {

                                                    console.log(xhr.responseText);

                                                }
                                            });

                                        }
                                            //For Complete Stage
                                        else if (StageName == 'Completed') {
                                            //alert(DropTdId)
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/DropValidation",
                                                data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "1" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {
                                                    var arr = [];

                                                    if (String(result.d).indexOf("$$$") == -1) {
                                                        arr[0] = result.d
                                                    }
                                                    else {
                                                        arr = String(result.d).split("$$$")
                                                    }
                                                    if (arr[1] == 2) {

                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(arr[0], 'error', 20);
                                                      //  $(ui.sender).sortable('cancel');
                                                        return;
                                                    }
                                                    if (arr[1] == "1") {
                                                        if (arr[0] != "") {

                                                            bootbox.confirm({
                                                                message: arr[0],
                                                                buttons: {
                                                                    cancel: {
                                                                        label: 'No',
                                                                        className: 'btn-danger float-end1'
                                                                    },
                                                                    confirm: {
                                                                        label: 'Yes',
                                                                        className: 'btn-success'
                                                                    }

                                                                },
                                                                callback: function (result) {

                                                                    if (result == true) {
                                                                        $.ajax({
                                                                            type: "POST",
                                                                            url: "frmScrumBoard.aspx/DropValidation",
                                                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                                            dataType: "json",
                                                                            contentType: "application/json",
                                                                            timeout: 180000,
                                                                            async: true,
                                                                            success: function (result) {
                                                                                if (result.d != 0) {

                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify(result.d, 'error', 20);
                                                                                    return;
                                                                                }
                                                                                else {
                                                                                    // Update StageId

                                                                                    $.ajax({
                                                                                        type: "POST",
                                                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                                                        data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                                                        dataType: "json",
                                                                                        contentType: "application/json",
                                                                                        timeout: 180000,
                                                                                        async: true,
                                                                                        success: function (result) {

                                                                                            if (result.d == "1") {
                                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                                alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                                                //$("#DragDropModal .close").click();
                                                                                                //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                                $("#btnStatus_"+USID).text(StageName)
                                                                                            }
                                                                                            else {
                                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                                alertify.notify(result.d, 'error', 20);
                                                                                                return;
                                                                                            }
                                                                                        },
                                                                                        error: function (xhr, status, error) {
                                                                                            console.log(xhr.responseText);

                                                                                        }
                                                                                    });
                                                                                }
                                                                            }
                                                                        });

                                                                    }
                                                                    else {

                                                                        if (result.d != undefined) {
                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                            alertify.notify(result.d, 'error', 20);
                                                                        }

                                                                    }
                                                                }
                                                            });
                                                        }
                                                    }
                                                    else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/DropValidation",
                                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: true,
                                                            success: function (result) {
                                                                if (result.d != 0) {

                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                    return;
                                                                }
                                                                else {
                                                                    // Update StageId

                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                                        data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                                        dataType: "json",
                                                                        contentType: "application/json",
                                                                        timeout: 180000,
                                                                        async: true,
                                                                        success: function (result) {


                                                                            if (result.d == "1") {

                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                                //$("#DragDropModal .close").click();
                                                                                //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                $("#btnStatus_"+USID).text(StageName)
                                                                            }
                                                                            else {
                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify(result.d, 'error', 20);
                                                                                return;
                                                                            }
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            console.log(xhr.responseText);

                                                                        }
                                                                    });
                                                                }
                                                            }
                                                        });
                                                    }


                                                },
                                                error: function (xhr, status, error) {

                                                    console.log(xhr.responseText);

                                                }
                                            });
                                        }
                                            //End for Complete stage
                                            //When Drop to othe stage than inprogress and Complete  
                                        else if (StageName == 'To-Do List') {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {

                                                    if (result.d == "1") {

                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify("User Story Moved Successfully", 'success', 5);
                                                        //$("#DragDropModal .close").click();
                                                        //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                        $("#btnStatus_"+USID).text(StageName)
                                                    }
                                                    else {
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(result.d, 'error', 20);
                                                        alert();
                                                        return;
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);

                                                }
                                            });
                                        }
                                    }
                                    //End if drop is not a custom stage

                                }
                                else {

                                    return;
                                }
                            }
                        })

                    }////

                    else {
                        if (IsCustom == 1) {
                            $.ajax({
                                type: "POST",
                                url: "frmScrumBoard.aspx/UpdateStageID",
                                data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Custom" }),
                                dataType: "json",
                                contentType: "application/json",
                                timeout: 180000,
                                async: false,
                                success: function (result) {

                                    if (result.d == "1") {
                                        // AfterDragRefresh();
                                        //alert("updated")
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify("User Story Moved Successfully", 'success', 5);
                                        //$("#DragDropModal .close").click();
                                        //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                        $("#btnStatus_"+USID).text(StageName)
                                    }
                                    else {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify(result.d, 'error', 20);
                                       // $(ui.sender).sortable('cancel');
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.log(xhr.responseText);

                                }
                            });
                        }
                        else {
                            if (StageName == 'In Progress') {

                                
                                $.ajax({
                                    type: "POST",
                                    url: "frmScrumBoard.aspx/DropValidation",
                                    data: JSON.stringify({ UserStoryID: USID, StageID: "", Mode: "InProgress", IssueOpenFlag: "0" }),
                                    dataType: "json",
                                    contentType: "application/json",
                                    timeout: 180000,
                                    async: false,
                                    success: function (result) {

                                        if (result.d != 0) {

                                            bootbox.confirm({
                                                message: result.d,
                                                buttons: {
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-danger float-end1'
                                                    },
                                                    confirm: {
                                                        label: 'Yes',
                                                        className: 'btn-success'
                                                    }

                                                },
                                                callback: function (result) {

                                                    if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: false,
                                                            success: function (result) {
                                                                //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                if (result.d == "1") {
                                                                    //End Added By Vaijat K ON 13/04/2017 
                                                                    // AfterDragRefresh();
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                    //$("#DragDropModal .close").click();
                                                                    //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                    $("#btnStatus_"+USID).text(StageName)
                                                                }
                                                                else {
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                  //  $(ui.sender).sortable('cancel');
                                                                }
                                                            },
                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);

                                                            }
                                                        });
                                                    }
                                                    else {
                                                       // debugger;
                                                      //  $(ui.sender).sortable('cancel');
                                                        return;
                                                    }
                                                }
                                            })
                                        }
                                        else {
                                            // Update StageId
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: false,
                                                success: function (result) {
                                                    //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                    if (result.d == "1") {
                                                        //End Added By Vaijat K ON 13/04/2017 
                                                        // AfterDragRefresh();
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify("User Story Moved Successfully", 'success', 5);
                                                        //$("#DragDropModal .close").click();
                                                        //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                        $("#btnStatus_"+USID).text(StageName)
                                                    }
                                                    else {
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(result.d, 'error', 20);
                                                       // $(ui.sender).sortable('cancel');
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);

                                                }
                                            });
                                        }

                                    },
                                    error: function (xhr, status, error) {

                                        console.log(xhr.responseText);

                                    }
                                });

                            }
                                //For Complete Stage
                            else if (StageName == 'Completed') {
                                //alert(DropTdId)
                                $.ajax({
                                    type: "POST",
                                    url: "frmScrumBoard.aspx/DropValidation",
                                    data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "1" }),
                                    dataType: "json",
                                    contentType: "application/json",
                                    timeout: 180000,
                                    async: false,
                                    success: function (result) {
                                        var arr = [];

                                        if (String(result.d).indexOf("$$$") == -1) {
                                            arr[0] = result.d
                                        }
                                        else {
                                            arr = String(result.d).split("$$$")
                                        }
                                        if (arr[1] == 2) {

                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify(arr[0], 'error', 20);
                                          //  $(ui.sender).sortable('cancel');
                                            return;
                                        }
                                        if (arr[1] == "1") {
                                            if (arr[0] != "") {

                                                bootbox.confirm({
                                                    message: arr[0],
                                                    buttons: {
                                                        cancel: {
                                                            label: 'No',
                                                            className: 'btn-danger float-end1'
                                                        },
                                                        confirm: {
                                                            label: 'Yes',
                                                            className: 'btn-success'
                                                        }

                                                    },
                                                    callback: function (result) {

                                                        if (result == true) {
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "frmScrumBoard.aspx/DropValidation",
                                                                data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                                dataType: "json",
                                                                contentType: "application/json",
                                                                timeout: 180000,
                                                                async: false,
                                                                success: function (result) {
                                                                    if (result.d != 0) {

                                                                        alertify.set('notifier', 'position', 'top-right');
                                                                        alertify.notify(result.d, 'error', 20);
                                                                      //  alert("Updated")
                                                                      //  $(ui.sender).sortable('cancel');
                                                                    }
                                                                    else {
                                                                        // Update StageId

                                                                        $.ajax({
                                                                            type: "POST",
                                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                                            dataType: "json",
                                                                            contentType: "application/json",
                                                                            timeout: 180000,
                                                                            async: false,
                                                                            success: function (result) {
                                                                                //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                if (result.d == "1") {
                                                                                    //End Added By Vaijat K ON 13/04/2017 
                                                                                    //  AfterDragRefresh();
                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                                    //$("#DragDropModal .close").click();
                                                                                    //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                    $("#btnStatus_"+USID).text(StageName)
                                                                                }
                                                                                else {
                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify(result.d, 'error', 20);
                                                                                   // $(ui.sender).sortable('cancel');
                                                                                }
                                                                            },
                                                                            error: function (xhr, status, error) {
                                                                                console.log(xhr.responseText);

                                                                            }
                                                                        });
                                                                    }
                                                                }
                                                            });

                                                        }
                                                        else {

                                                            if (result.d != undefined) {
                                                                alertify.set('notifier', 'position', 'top-right');
                                                                alertify.notify(result.d, 'error', 20);
                                                            }
                                                         //   $(ui.sender).sortable('cancel');
                                                        }
                                                    }
                                                });
                                            }
                                        }
                                        else {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/DropValidation",
                                                data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: false,
                                                success: function (result) {
                                                    if (result.d != 0) {

                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(result.d, 'error', 20);
                                                       // alert("Updated")
                                                       // $(ui.sender).sortable('cancel');
                                                    }
                                                    else {
                                                        // Update StageId

                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                            data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: false,
                                                            success: function (result) {
                                                                //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                if (result.d == "1") {
                                                                    //End Added By Vaijat K ON 13/04/2017 
                                                                    // AfterDragRefresh();
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify("User Story Moved Successfully", 'success', 5);
                                                                    //$("#DragDropModal .close").click();
                                                                    //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                    $("#btnStatus_"+USID).text(StageName)
                                                                }
                                                                else {
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                  //  $(ui.sender).sortable('cancel');
                                                                }
                                                            },
                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);

                                                            }
                                                        });
                                                    }
                                                }
                                            });
                                        }


                                    },
                                    error: function (xhr, status, error) {

                                        console.log(xhr.responseText);

                                    }
                                });
                            }
                                //End for Complete stage
                            else if (StageName == 'To-Do List') {
                                //debugger;
                                $.ajax({
                                    type: "POST",
                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                    data: JSON.stringify({ UserStoryID: USID, StageID: StageID, Mode: "InProgress" }),
                                    dataType: "json",
                                    contentType: "application/json",
                                    timeout: 180000,
                                    async: true,
                                    success: function (result) {

                                        if (result.d == "1") {

                                            //AfterDragRefresh();
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify("User Story Moved Successfully", 'success', 5);
                                            
                                            //$("#DragDropModal .close").click();
                                            //Sprint_OnChange(document.getElementById("ScrumIterations"));
                                            $("#btnStatus_"+USID).text(StageName)
                                           // $("#DragDropModal .close").click();
                                           // Sprint_OnChange(document.getElementById("ScrumIterations"));
                                        }
                                        else {
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify(result.d, 'error', 20);
                                            //   alert();
                                            return;
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.log(xhr.responseText);

                                    }
                                });
                            }
                        }
                    }
                }
            })

            //Added by swapna 18-07-2018
            BindSubUserStoryTable("#tblShowHistory");
            PopulateHistoryTable('<%= intUserStoryID%>');
            //End by swapna
        }
        //function changestatus end by swapna

        function ShowLessMoreContent() {
            var showChar = 100;
            var ellipsestext = "...";
            var moretext = "More";
            var lesstext = "Less";
            $('.more').each(function () {
                var content = $(this).html();

                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    var h = content.substr(showChar - 1, content.length - showChar);

                    var html = c + '<span class="moreellipses">' + ellipsestext + '</span><span class="morecontent" style="word-break: normal;"><span>' + h + '</span><a href="" class="morelink" >' + moretext + '</a></span>';

                    $(this).html(html);
                }

            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");
                    //Commented and Added by Usha On 18 July 2018 for More text alignment in discussion issue
                    $(this).html(moretext);
                    //$(this).html("<br>" + moretext);
                    //End of Added by Usha On 18 July 2018 for More text alignment in discussion issue
                } else {
                    $(this).addClass("less");

                    //Commented and Added by Usha On 18 July 2018 for More text alignment in discussion issue
                    $(this).html("..."+lesstext);
                    //$(this).html("<br>" + lesstext);
                    //End of Added by Usha On 18 July 2018 for More text alignment in discussion issue
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });
        }
        function PlotControls() {
            //debugger;
            var temp = [0];
            var strUserResult = ajaxCall("UserStoryDetails.aspx/PlotUSControls", "POST", "application/json", "json",
                                JSON.stringify({}));
           // alert(strUserResult.d)
         
            temp = (strUserResult.d).split(",")
            var str = "";
           
            $.each(temp, function (i) {
               
                switch (temp[i]) {
                    case 'UserStoryName': $("#divUserStoryName").show(); break;
                    case 'BusinessValue': $("#divBusinessValue").show(); break;
                    case 'Complexity': $("#divComplexity").show(); break;
                    case 'State': $("#divState").show(); break;
                    case 'Version': $("#divVersion").show(); break;
                    case 'FixedVersion': $("#divFixedVersion").show(); break;
                    case 'Description': $("#divDescription").show(); break;
                    case 'AcceptanceCriteria': $("#divAcceptanceCriteria").show(); break;
                    case 'Priority': $("#divPriority").show(); break;
                    case 'Category': $("#divCategory").show(); break;
                    case 'InitialEstimate': $("#divStoryPoints").show(); break;
                }
            });
      
           
            //var result = ajaxCall("UserStoryDetails.aspx/SprintStatus", "POST", "application/json", "json",
            //                     JSON.stringify({ UserStoryID: getSearchParams('UserStoryId') }));

            var result = '<%= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & intUserStoryID & ",'UserStory'", True))%>'
            // alert(result.d)
           
            if (result == 0) {
                if ('<%= m_objAccess.Edit%>' == "True") {
                $("#divAddDeleteUS").show()
                document.getElementById("DeleteUserStory").setAttribute("onclick", "Delete_UserStory(" + getSearchParams('UserStoryId') + ",'')")
               }
            }
           
        }
      
        //function BindIssueAdd(UserStoryID) {
           

        //}
        function BindSubUserStoryTable(tableID) {
           // debugger;
            $(tableID).DataTable().clear();
            myTable = $(tableID).DataTable({
                retrieve: true,
                responsive: true, "pageLength": 5,
                //"bSort": true,
              //  "bSort": true,
               // scrollY: height + 'px',
               // scrollX: true,
                ordering: false,
                pagingType: "simple_numbers",
                language: {
                    paginate: {
                        next: '<i class="fa fa-angle-double-right"></i>',
                        previous: '<i class="fa fa-angle-double-left"></i>'
                       
                    }
                }
                
            });
           
         
        }

        function PopulateSubUserStoryTable() {
         
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowSubUserStory", "POST", "application/json", "json",
                                 JSON.stringify({ UserStoryID: '<%= intUserStoryID%>' }));
            if (strUserResult.d != '[]|') {
                var strArray = String(strUserResult.d).split("|")
                var i = 0;
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    
                    var result = ajaxCall("UserStoryDetails.aspx/checkUShasSprintnot", "POST", "application/json", "json",
                                 JSON.stringify({ UserStoryID: obj.UserStoryID }));
                    if (result.d == 0) {
                       // alert(obj.CompletedTasks)
                        //Added by swapna
                        // myTable.row.add([obj.UserStoryID, obj.Description, obj.CreatedBy,"<span class='progresspie'>100</span> %","", ParseDate(obj.CreatedDate),"<i class='fa fa-check tickmark'  aria-hidden='true'></i>", '<i class="fas fa-trash-alt" style="cursor:pointer" aria-hidden="true" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete User Story" onclick="Delete_UserStory(' + obj.UserStoryID + ',\'SubUS\')" data-original-title="Delete User Story"></i>']);
                        myTable.row.add(["<span data-bs-toggle='tooltip' title='Sub User Story ID' onmouseover='$(this).tooltip();'>" + obj.UserStoryID + "</span>", "<span data-bs-toggle='tooltip' title='Description' onmouseover='$(this).tooltip();'>" + obj.Description + "</span>", "<span data-bs-toggle='tooltip' title='Owner' onmouseover='$(this).tooltip();'>" + obj.CreatedBy + "</span>",
                            "<div class='col-md-6' data-bs-toggle='tooltip' title='Completed Task' onmouseover='$(this).tooltip();'><span class='progresspie' style='float: right;' data-val=" + obj.CompletedTasks + "></span></div><div class='col-md-6'><span style='margin-left: -15px;'>" + obj.CompletedTasks + "%</span></div>", "<span data-bs-toggle='tooltip' title='Total Tasks' onmouseover='$(this).tooltip();'>" + obj.TotalTasks + "</span>", "<span data-bs-toggle='tooltip' title='End Date' onmouseover='$(this).tooltip();'>" + obj.TaskEndDate + "</span>",
                            "  <div class='btn-group'><button type='button' style='width:100px' class='btn btn-success' id='btnStatus_" + obj.UserStoryID + "' data-bs-toggle='tooltip' title='Change Stage'>Status</button>" +
                                "<button type='button' id='btnDropDown_" + obj.UserStoryID + "' class='btn btn-success dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><span class='caret'></span></button>" +
                               " <ul class='dropdown-menu' id='StatusDropDown_" + obj.UserStoryID + "'></ul></div>"]);
                    }
                    else if (result.d == 1) {
                        // myTable.row.add([obj.UserStoryID, obj.Description, obj.CreatedBy,"<span class='progresspie'>100</span> %","",ParseDate(obj.CreatedDate),"<i class='fa fa-check tickmark'  aria-hidden='true'></i>", '<i title="User Story already Mapped to sprint,you do not have acess to delete" data-bs-toggle="tooltip" data-bs-placement="bottom" class="fa fa-trash" style="margin-right:13px!important"></i>']);
                        myTable.row.add(["<span data-bs-toggle='tooltip' title='Sub User Story ID' onmouseover='$(this).tooltip();'>" + obj.UserStoryID + "</span>", "<span data-bs-toggle='tooltip' title='Description' onmouseover='$(this).tooltip();'>" + obj.Description + "</span>", "<span data-bs-toggle='tooltip' title='Owner' onmouseover='$(this).tooltip();'>" + obj.CreatedBy + "</span>",
                            "<div class='col-md-6' data-bs-toggle='tooltip' title='Completed Task' onmouseover='$(this).tooltip();'><span class='progresspie' style='float: right;    margin-right: -15px;' data-val=" + obj.CompletedTasks + "></span></div><div class='col-md-6'><span style='margin-left: -15px;'>" + obj.CompletedTasks + "%</span></div>", "<span data-bs-toggle='tooltip' title='Total Tasks' onmouseover='$(this).tooltip();'>" + obj.TotalTasks + "</span>", "<span data-bs-toggle='tooltip' title='End Date' onmouseover='$(this).tooltip();'>" + obj.TaskEndDate + "</span>",
                            "  <div class='btn-group'><button type='button' style='width:100px' class='btn btn-success' id='btnStatus_" + obj.UserStoryID + "' data-bs-toggle='tooltip' title='Change Stage'>Status</button>" +
                                "<button type='button' id='btnDropDown_" + obj.UserStoryID + "' class='btn btn-success dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><span class='caret'></span></button>" +
                               " <ul class='dropdown-menu' id='StatusDropDown_" + obj.UserStoryID + "'></ul></div>"]);
                        //end by swapna
                    }
                    myTable.draw();
                    BindStatusDropDown(obj.UserStoryID,obj.Status)
                });
            }

        }
        function Delete_UserStory(ID, Flag) {
            
            var UserStoryID = ID;
            var result = ajaxCall("UserStoryDetails.aspx/DeleteEntryValidation", "POST", "application/json", "json",
                                JSON.stringify({ UserStoryID: UserStoryID }));
          
            if ((result.d == "0" || result.d == "1" || result.d == "2")) {
                var strChkParent = ""+'<%= strHasSubUS%>'+""
                if (strChkParent == 'Yes') {
                    alertify.set('notifier', 'position', 'top-right');

                    alertify.notify(' This User story has associated sub user story.You can not delete it.', 'error', 5);
                }
                else {

                var url = "UserStoryDetails.aspx/DeleteEntry";
                var data = JSON.stringify({ UserStoryID: UserStoryID, Flag: Flag });
                var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                if (Flag == "SubUS") {
                    BindSubUserStoryTable("#tblShowSubUserStory");
                    PopulateSubUserStoryTable();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('User Stories Deleted Successfully', 'success', 5);
                }
                else {

                    window.open('frmProductBacklog.aspx', '_self');
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('User Stories Deleted Successfully', 'success', 5);
                }
                 
            
                }
            }
            else {
                alertify.set('notifier', 'position', 'top-right');

                alertify.notify('Following User Story is in use.You can not delete this user story', 'error', 5);
                
            }
        }

function BindUserStoryData(UserStoryID) {
            //var x = 0;
            //var count = 0;
            //$("[id='FreeTextBox_editor']").each(function () {
            //    $(this).attr("id", "FreeTextDesc" + x);
            //    x++;

            //})
           // debugger;

            //$("#txtUserStoryID").text(UserStoryID)
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowUserStoryDetails", "POST", "application/json", "json",
                                JSON.stringify({ UserStoryID: UserStoryID }));
            

            if (strUserResult.d != '[]|') {
                var strIsPrductOwner = ajaxCall("UserStoryDetails.aspx/ChkAccessRights", "POST", "application/json", "json",
                               JSON.stringify({}));
                

                var strArray = String(strUserResult.d).split("|")
                
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                   // debugger;
                    //$("#lblUserStoryName").text(obj.UserStoryName)
                   // $("#lblCreatedBy").text("Created By: " + obj.CreatedBy + " On " + ParseDate(obj.CreatedDate) + "")
                   // $("#lblRank").text(obj.InitialRank)

                   // .val(obj.UserStoryName)
                  //  $("#cboPriority").val(obj.PriorityID)
                   // $("#cboUSCategory").val(obj.CategoryId)
                   // $("#txtStoryPoint").val(obj.StoryPoint)
                    //  $("#btnStatus").text(obj.Status)
                    $("#txtFeatureName").trigger('change')
                    if (obj.HTMLDescription == null) {
                        $("#FreeTextDesc0").html(obj.Description)
                    }
                    else{
                        $("#FreeTextDesc0").html(obj.HTMLDescription)
                    }
                    if ((obj.HTMLAcceptanceCriteria) == null) {
                        $("#FreeTextDesc1").html(obj.AcceptanceCriteria)
                    }
                    else{
                        $("#FreeTextDesc1").html(obj.HTMLAcceptanceCriteria)
                    }
                  //  $("#txtBusinessValue").val(obj.BusinessValue)
                  //  $("#cboComplexity").val(obj.Complexity)
                  //  $("#cboStateEdit").val(obj.State)
                  //  $("#cboVersion").val(obj.Version)
                 //   $("#cboFixedVersion").val(obj.FixedVersion)
                    //alert(obj.HTMLDescription);
                    var ReadOnlyORNot = '<%= IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And intUserStoryID = ""), False, True)%>'
                    if (ReadOnlyORNot == 'True') {
                        $("#FreeTextDesc0").attr("contenteditable", false);
                        $("#FreeTextDesc1").attr("contenteditable", false);
                       // $("#FreeTextDesc0").css("cursor", "not-allowed");
                    }

                    

                    //$("#FreeTextDesc0").attr("onkeypress", "swapna()");
                    var editor0 = document.getElementById("FreeTextDesc0")
                    //Added By Dipali V On 16th April 2019 For JavaScript Issue
                    if (document.getElementById("FreeTextDesc0") != undefined || document.getElementById("FreeTextDesc0") != null) {
                        editor0.setAttribute("onkeyup", "return limitFreeText('FreeTextDesc0')")
                    }
                   //End of Added By Dipali V On 16th April 2019 For JavaScript Issue
                  
                   // editor0.setAttribute("data-max-length", "1000")
                   // editor0.setAttribute("onkeypress", "return (document.getElementById('FreeTextDesc0').innerText.length <= 256)")
                  //Added By Dipali V On 16th April 2019 For JavaScript Issue
                    if (document.getElementById("FreeTextDesc1") != undefined || document.getElementById("FreeTextDesc1") != null) {
                         document.getElementById("FreeTextDesc1").setAttribute("onkeyup", "return limitFreeText('FreeTextDesc1')")
                    }
                    //End of Added By Dipali V On 16th April 2019 For JavaScript Issue
                    
                    
                });
            }
        }
        

        $("html").bind('paste', function (e) {
            //Commented by Reshma Chavan on 02.05.2019 for enable copy paste in IE
            //e.preventDefault();
            //if (e.originalEvent.clipboardData != undefined) {
            //    var pastedData = e.originalEvent.clipboardData.getData('text');


            //    document.execCommand("insertHTML", false, pastedData);
            //}
            //End of Commented by Reshma Chavan on 02.05.2019 for enable copy paste in IE
        });
        function limitFreeText(limitField) {
            //debugger;
            if (limitField == 'FreeTextDesc0') {

              
                if ($("#FreeTextDesc0").text().length > 1000) {
                    //$("#FreeTextDesc0").html($("#FreeTextDesc0").text().substr(0, 1000));
                    alertify.closeAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 1000 Character', 'error', 1);
                  
                    }
                //}

                
            }
            if (limitField == 'FreeTextDesc1') {
                if ($("#FreeTextDesc1").text().length > 1000) {
                    alertify.closeAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 1000 Character', 'error', 1);

                }
            }
        }
        function BindAttachementsData(UserStoryID) {
            //Added by swapna
            $("#divDropZone").empty()
            document.getElementById("divDropZone").innerHTML = "<p id='pDropZone'>Drag files here or click to upload</p>";
            //Added by swapna
           // $("#divDropZone").append("<p id='pDropZone'>Drag files here or click to upload</p>");

            $("#mainDivAttachments").empty();
            var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowAttachemnts", "POST", "application/json", "json",
                                JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', UserStoryID: UserStoryID }));
            if (strUserResult.d != '[]|') {

                var strArray = String(strUserResult.d).split("|")
                var i = 0;
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                   
                    var Attachments = ""
                    Attachments = "<div class='activity-row' id='Div1' style=''><div class='row'><div class='col-md-3'><div class='form-group'>" +
                            "<p class='upload-header' >Document Name(latest)</p>" +
                            "<p class='attach-details' data-bs-toggle='tooltip' title='Download' onmouseover='$(this).tooltip();' style='text-decoration: underline;cursor:pointer;    word-break: break-all;' onclick='Document_OnClick(\"" + obj.FilePath + obj.OriginalFileName.substring(obj.OriginalFileName.lastIndexOf(".")) + "\",\"" + obj.OriginalFileName.substring(obj.OriginalFileName.lastIndexOf("\\") + 1) + "\")'>" + obj.OriginalFileName.substring(obj.OriginalFileName.lastIndexOf("\\") + 1) + "</p>" +
                        "</div></div>" +
                        "<div class='col-md-3'><div class='form-group'> " +
                        "<p class='upload-header'>Upload Date</p><p class='attach-details' style='width: 50%;'  data-bs-toggle='tooltip' title='Upload Date' onmouseover='$(this).tooltip();'>" + ParseDate(obj.DateOfAttaching) + "</p></div></div>" +
                        "<div class='col-md-3'><div class='form-group'><p class='upload-header'>Size(KB)</p><p class='attach-details' style='width: 30%;'  data-bs-toggle='tooltip' title='File Size'>" + obj.FileSize + "</p></div></div>" +
                        "<div class='col-md-2'><div class='form-group'><p class='upload-header'>Upload By</p><div  data-bs-toggle='tooltip' title='Upload By'>" +
                       // "<img src='../../Images/Photo/05774f3a.jpg' onerror='this.src='../../Images/Photo/no-photo.png'' data-bs-toggle='tooltip' title='' data-original-title='Sa - SOFTWARE ENGINEER TEAM MEMBER'></div>" +
                         "" + obj.AttachedBy + "</div>" +
                        "</div></div>" +
                        "<div class='col-md-1'><div class='form-group'>" +
                        '<i class="fas fa-trash-alt" aria-hidden="true" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" style="cursor:pointer;vertical-align: -40px;" onclick="Delete_Attachment(' + obj.AttachmentID + ',' + UserStoryID + ',\'Userstory\',1)" data-original-title="Delete Attachment"></i></div></div></div>' +
                        "<div class='clearfix'></div></div>"
                    $("#mainDivAttachments").append(Attachments);

                   // $("#pAttachmentDwnld").tooltip();
                });
            }

            }

            function BindTeamData(UserStoryID) {
                var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowTeams", "POST", "application/json", "json",
                                    JSON.stringify({ UserStoryID: UserStoryID }));
                
                if (strUserResult.d != '[]|') {
                    //Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
                    $("#mainDivTeams").html('');
                //End of Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                      var Teams = ""
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        //alert(strArray[0]);
                        //Added & Commented By Dipali V On 21st April 2020 for Team Member not list out all
                         //Teams ="<div class='col-md-6'><div class='col-sm-11 sprint_card team_cards'><div class=''><div class='col-md-2 col-sm-2 col-sm-12 discussionbox'>" +
                         //            "<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Employee Image'>" +
                         //            "<img src='../../Images/Photo/" + obj.SystemFilename + "' onerror=this.src='../../Images/Photo/no-photo.png' data-bs-toggle='tooltip' title='' aria-describedby='tooltip753350'></span></div>" +
                         //            "<div class='col-md-10 col-sm-10 col-sm-12'>" +
                         //            "<p class='ClsTeamDetails'>" +
                         //            "<span data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Employee Name'>" + obj.EmployeeName + "</span> |" +
                         //            "<label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='' data-original-title='" + obj.RoleDescription + "'>" + (obj.RoleDescription).substr(0, 13) + "...</label></p>" +
                         //            "<p class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Resource Percentage'>" + obj.ResourcePercentage + " % Allocation</span> </p>" +
                         //            "<div class='progress' style='width: 70%;'>" +
                         //            "<div class='progress-bar progress-bar-striped active' onmouseover='$(this).tooltip();'  data-bs-toggle='tooltip' title='Progress' role='progressbar' aria-valuenow='" + obj.TaskCompletionPercentage + "' aria-valuemin='0' aria-valuemax='100' style='width: " + obj.TaskCompletionPercentage + "%'></div></div>" +
                         //            "<span class='label label-primary' style='float: right; margin-top: -38px; margin-right: 60px; border-radius: 10px;' data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Task Completion Percentage'>" + obj.TaskCompletionPercentage + "%</span><br>" +
                         //            "</div></div></div>"
                        Teams += "<div class='col-md-6'><div class='col-sm-11 sprint_card team_cards'><div class=''><div class='col-md-2 col-sm-2 col-sm-12 discussionbox'>" +
                            "<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Employee Image'>" +
                            "<img src='../../Images/Photo/" + obj.SystemFilename + "' onerror=this.src='../../Images/Photo/no-photo.png' data-bs-toggle='tooltip' title='' aria-describedby='tooltip753350'></span></div>" +
                            "<div class='col-md-10 col-sm-10 col-sm-12'>" +
                            "<p class='ClsTeamDetails'>" +
                            "<span data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Employee Name'>" + obj.EmployeeName + "</span> |" +
                            "<label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='' data-original-title='" + obj.RoleDescription + "'>" + (obj.RoleDescription).substr(0, 13) + "...</label></p>" +
                            "<p class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Resource Percentage'>" + obj.ResourcePercentage + " % Allocation</span> </p>" +
                            "<div class='progress' style='width: 70%;'>" +
                            "<div class='progress-bar progress-bar-striped active' onmouseover='$(this).tooltip();'  data-bs-toggle='tooltip' title='Progress' role='progressbar' aria-valuenow='" + obj.TaskCompletionPercentage + "' aria-valuemin='0' aria-valuemax='100' style='width: " + obj.TaskCompletionPercentage + "%'></div></div>" +
                            "<span class='label label-primary' style='float: right; margin-top: -38px; margin-right: 60px; border-radius: 10px;' data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Task Completion Percentage'>" + obj.TaskCompletionPercentage + "%</span><br>" +
                            "</div></div></div></div>";
                          //End of Added & Commented By Dipali V On 21st April 2020 for Team Member not list out all
                         
                    });

                    //Added & commented By Dipali V On 16th April 2019 For Binding Issue
                        // $("#mainDivTeams").append(Teams);
                        $("#mainDivTeams").html("");
                        $("#mainDivTeams").html(Teams);
                        //End of Added & commented By Dipali V On 16th April 2019 For Binding Issue
                }
                else {
                    var Teams = ""
                    //Added & commented By Dipali V On 16th April 2019 For Binding Issue
                    // Teams = "<div class='col-md-6' ><span style='text-align:center'> There are no items to show</span></div>"
                    Teams = "<div class='col-md-12'  style='text-align:center'><span style='text-align:center'> There are no items to show</span></div>"
                     //end of Added & commented By Dipali V On 16th April 2019 For Binding Issue
                       //Added & commented By Dipali V On 16th April 2019 For Binding Issue
                        // $("#mainDivTeams").append(Teams);
                        $("#mainDivTeams").html("");
                        $("#mainDivTeams").html(Teams);
                        //End of Added & commented By Dipali V On 16th April 2019 For Binding Issue
                }
            }
            function BindDisscussionData(UserStoryID) {
           
                var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowDisscussions", "POST", "application/json", "json",
                                  JSON.stringify({ UserStoryID: UserStoryID }));
                if (strUserResult.d != '[]|') {
                    $("#mainDivDisscussion").html("");
                    // alert(strUserResult.d)
                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;

                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        var USDisscussions = ""
                        var Replycount =0
                        USDisscussions = "    <div class='feed-element'><a class='float-start'>" +
                            "<img src='../../Images/Photo/" + obj.SystemFilename + "' onerror=this.src='../../Images/Photo/no-photo.png' data-bs-toggle='tooltip' title='' data-original-title='Employee Image' aria-describedby='tooltip753350'></a>" +
                            "<div class='media-body '><small data-bs-toggle='tooltip' title='Posted time' class='float-end text-navy'>" + obj.Duration + "</small><strong data-bs-toggle='tooltip' title='Employee Name'>" + obj.EmployeeName + "</strong>" +
                            "<p class='DissComment more' style='word-break: normal;' data-bs-toggle='tooltip' title='Discussion'>" + obj.Comments + "</p>" +
                            "</div><small class='text-muted' data-bs-toggle='tooltip' title='Discussion Date'>" + obj.DiscussionDates + "</small>" +
                            "&nbsp&nbsp&nbsp<label data-bs-toggle='collapse' data-bs-target='#collapse_" + obj.DiscussionID + "' style='cursor:pointer'>" +
                            "<span title='' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom' data-original-title='View all reply'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></span></span></label>"+
                        "<a class='btn btn-xs btn-white' onclick='Reply_OnClick(" + obj.DiscussionID + ")' style='font-size: 12px;' data-bs-toggle='tooltip' title='Reply'><i class='fa fa-reply'></i>Reply </a>" +
                        "&nbsp&nbsp<label id='ReplyCount" + obj.DiscussionID + "' class='label label-warning' style='font-size:9px' title='' data-bs-toggle='tooltip' data-bs-placement='bottom' data-original-title='Reply count'>" + Replycount + "</label>" +
                        "</div>"
                       
                        $("#mainDivDisscussion").append(USDisscussions);
                          //$("#mainDivDisscussion").html(USDisscussions);
                        var strUSReply = ajaxCall("UserStoryDetails.aspx/ShowDisscussionsReply", "POST", "application/json", "json",
                                  JSON.stringify({ UserStoryID: UserStoryID, DiscussionID: obj.DiscussionID }));
                        if (strUSReply.d != '[]|') {
                            var i = 0;
                            var strArray1 = String(strUSReply.d).split("|")
                            USDisscussions = "<div id='collapse_" + obj.DiscussionID + "' class='chat chat-inline collapse'></div>"
                            $("#mainDivDisscussion").append(USDisscussions);
                              //$("#mainDivDisscussion").html(USDisscussions);
                            $.each(JSON.parse(strArray1[0]), function (id, objs) {
                                Replycount = Replycount + 1;
                                USDisscussions = "<div class='feed-element'><div class='right'><span class='date-time' data-bs-toggle='tooltip' title='Posted time'>" + objs.Duration + "</span><a href='javascript:;' class='image float-end'>" +
                                                "<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' data-bs-toggle='tooltip' title='Employee Image' src='../../Images/Photo/" + objs.SystemFilename + "'></a>" +
                                                "<strong class='name' data-bs-toggle='tooltip' title='Employee Name'>" + objs.EmployeeName + " &nbsp; &nbsp;</strong><div class='message more' style='word-break: normal;text-align: justify;' data-bs-toggle='tooltip' title='Discussion'>" + objs.Comments + "</div>" +
                                                "<br><div class='row'><div class='col-md-6'></div><div class='col-md-6' style='text-align: right;'><small class='text-muted' data-bs-toggle='tooltip' title='Discussion Date'>" + objs.DiscussionDates + "</small>" +
                                                "<a class='btn btn-xs btn-white' onclick=' Reply_OnClick(" + obj.DiscussionID + ")' style='font-size: 12px;' data-bs-toggle='tooltip' title='Reply'><i class='fa fa-reply'></i>Reply </a>" +
                                                "<div class='clearfix'></div></div></div></div></div>"
                                $("#collapse_" + obj.DiscussionID).append(USDisscussions);
                                  //$("#collapse_" + obj.DiscussionID).html(USDisscussions);
                            });
                           
                        }
                        $("#ReplyCount" + obj.DiscussionID).text(Replycount);


                    });
                }
                else {
                    var USDisscussions = ""
                    USDisscussions = "<div class=''><span style='text-align:center'> There are no items to show</span></div>"
                   // $("#mainDivDisscussion").append(USDisscussions);
                     $("#mainDivDisscussion").html(USDisscussions);
                }
            }

            function PopulateHistoryTable(UserStoryID) {
                //   debugger;

                var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowHistory", "POST", "application/json", "json",
                                    JSON.stringify({ UserStoryID: UserStoryID }));
                if (strUserResult.d != '[]|') {

                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                      //  if (obj.FieldName == 'Sprint' &&)
                        myTable.row.add(["<span data-bs-toggle='tooltip' title='Date' onmouseover='$(this).tooltip();'>" + ParseDate(obj.Date) + "</span>", "<span data-bs-toggle='tooltip' title='Modified By' onmouseover='$(this).tooltip();'>" + obj.ModifiedBy + "</span>",
                            "<span data-bs-toggle='tooltip' title='Field Name' onmouseover='$(this).tooltip();'>" + obj.FieldName + "</span>", "<span data-bs-toggle='tooltip' title='Old Value' onmouseover='$(this).tooltip();'>" + (obj.FieldName == "Sprint" && obj.OldValue == "" ? "Product Backlog" : obj.OldValue) + "</span>",
                            "<span data-bs-toggle='tooltip' title='New Value' onmouseover='$(this).tooltip();'>" + (obj.FieldName == "Sprint" && obj.NewValue == "" ? "Product Backlog" : obj.NewValue) + "</span>"]);

                        myTable.draw();
                    });
                }
                $('[data-bs-toggle="tooltip"]').tooltip();
            }

            function PopulateIssuesTable(UserStoryID) {

                var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowIssuesList", "POST", "application/json", "json",
                                    JSON.stringify({ UserStoryID: UserStoryID }));
                if (strUserResult.d != '[]|') {

                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        if (obj.IsImpediment == 1) {
                            myTable.row.add(["<i class='fa fa-star' aria-hidden='true' title='Converted from impediment' onmouseover='$(this).tooltip();' style='color:red !important'></i>", "<span data-bs-toggle='tooltip' title='Issue Id' onmouseover='$(this).tooltip();'>" + obj.IssueID + "</span>", "<span data-bs-toggle='tooltip' title='Reported Date' onmouseover='$(this).tooltip();'>" + ParseDate(obj.ReportedDate) + "</span>",
                                "<span data-bs-toggle='tooltip' title='Issue Type' onmouseover='$(this).tooltip();'>" + obj.Type + "</span>", "<span data-bs-toggle='tooltip' title='Sprint Name' onmouseover='$(this).tooltip();'>" + obj.IterationName + "</span>", "<span data-bs-toggle='tooltip' title='Summary' onmouseover='$(this).tooltip();'>" + obj.Summary + "</span>"]);
                        }
                        else {
                            myTable.row.add(["", "<span data-bs-toggle='tooltip' title='Issue Id' onmouseover='$(this).tooltip();'>" + obj.IssueID + "</span>", "<span data-bs-toggle='tooltip' title='Reported Date' onmouseover='$(this).tooltip();'>" + ParseDate(obj.ReportedDate) + "</span>",
                                "<span data-bs-toggle='tooltip' title='Issue Type' onmouseover='$(this).tooltip();'>" + obj.Type + "</span>", "<span data-bs-toggle='tooltip' title='Sprint Name' onmouseover='$(this).tooltip();'>" + obj.IterationName + "</span>", "<span data-bs-toggle='tooltip' title='Summary' onmouseover='$(this).tooltip();'>" + obj.Summary + "</span>"]);
                        }
                        
                        myTable.draw();
                    });
                }

            }

            function PopulateReviewsTable(UserStoryID) {

                var strUserResult = ajaxCall("UserStoryDetails.aspx/ShowReviewsList", "POST", "application/json", "json",
                                    JSON.stringify({ UserStoryID: UserStoryID }));
                if (strUserResult.d != '[]|') {
                    //alert(strUserResult.d)
                    var strArray = String(strUserResult.d).split("|")
                    var i = 0;
                    $.each(JSON.parse(strArray[0]), function (id, obj) {
                        myTable.row.add(["<span data-bs-toggle='tooltip' title='Reviewed Date' onmouseover='$(this).tooltip();'>" + ParseDate(obj.ReviewedDate) + "</span>", "<span data-bs-toggle='tooltip' title='Sprint Name' onmouseover='$(this).tooltip();'>" + obj.IterationName + "</span>",
                            "<span data-bs-toggle='tooltip' title='Review Status' onmouseover='$(this).tooltip();'>" + obj.ReviewStatus + "</span>", "<span data-bs-toggle='tooltip' title='Review Title' onmouseover='$(this).tooltip();'>" + obj.ReviewTitle + "</span>",
                            "<span data-bs-toggle='tooltip' title='Reviewed By' onmouseover='$(this).tooltip();'>" + obj.ReviewedBy + "</span>", "<span data-bs-toggle='tooltip' title='Reviewee' onmouseover='$(this).tooltip();'>" + obj.Reviewee + "</span>"]);

                        myTable.draw();
                    });
                }

            }
            

            function getSearchParams(k) {
                var p = {};
                location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (s, k, v) { p[k] = v })
                return k ? p[k] : p;
            }
        function ParseDate(input) {
            if (input != null) {
                theDate = new Date(parseInt(input.substring(6, 19)));

                return theDate.toLocaleDateString();
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
            var result;
            function AJAXCallWithPara(url, data, method, para) {
                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    //timeout: 180000,
                    success: function (result) {
                       // AjaxResult = result;
                        method(result, para);
                        // $(".loadingoverlay", parent.document).css("display", "none");
                        // Stop();
                    },
                    error: function (xhr, status, error) {
                        // Stop();
                        // StopAjaxLoader("body");
                        // $(".loadingoverlay", parent.document).css("display", "none");
                        console.log(xhr.responseText);
                        window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    }
                });
                return result
            }
            function CustomAJAXCall(url, data, method) {
                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    timeout: 180000,
                    async: false,
                    success: function (result) {
                        method(result);
                        //Stop();
                    },
                    error: function (xhr, status, error) {
                        // Stop();
                        //  StopAjaxLoader("body");
                        console.log(xhr.responseText);
                        window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    }
                });

            }
            function CompairDates1(obj1, Obj2) {
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

            $("#txtEditor").Editor();
            $("#txtEditor_accept").Editor();

       

            oTable = $('#tblShowSubUserStory').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#search_table').keyup(function () {
                oTable.search($(this).val()).draw();
            })

            $('[data-bs-toggle="tooltip"]').tooltip();


            $('#tblShowSubUserStory').DataTable();

            oTable2 = $('#tblShowHistory').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#search_table_History').keyup(function () {
                oTable2.search($(this).val()).draw();
            })
            $('#tblShowHistory').DataTable();

            oTable1 = $('#tblShowIssues').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#search_table_Issues').keyup(function () {
                oTable1.search($(this).val()).draw();
            })
            $('#tblShowIssues').DataTable();


            oTable3 = $('#tblShowReviews').DataTable();   //pay attention to capital D, which is mandatory to retrieve "api" datatables' object, as @Lionel said
            $('#search_table_Reviews').keyup(function () {
                oTable3.search($(this).val()).draw();
            })
            $('#tblShowReviews').DataTable();
            //
        document.getElementById("tblShowHistory_paginate").setAttribute('title', 'Pagination')
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('#txtReviewStartDate').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            
           // $('#txtReviewStartDate').datepicker('show');
            $('#txtReviewEnddate').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });


            $('#dtStartDateAssigntask').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });

            // $('#txtReviewStartDate').datepicker('show');
            $('#dtEndDateAssigntask').datepicker({
                dateFormat: "mm/dd/yy",
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
        });
        $('#dtEndDateAssigntask,#dtStartDateAssigntask,#txtReviewEnddate,#txtReviewStartDate').prop('readonly', true);
          //  $('#txtStartDate0').datepicker('show');
          //  $('#txtEndDate0').datepicker('show');

            function TaskStartDate(TaskID) {
              
                $('#txtStartDate' + TaskID + '').datepicker({
                    dateFormat: "mm/dd/yy",
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }); $('#txtStartDate' + TaskID + '').datepicker('show');
                 $('#txtStartDate' + TaskID + '').prop('readonly', true);
            }
            function TaskEndDate(TaskID) {
                $('#txtEndDate' + TaskID + '').datepicker({
                    dateFormat: "mm/dd/yy",
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }); $('#txtEndDate' + TaskID + '').datepicker('show');
                 $('#txtEndDate' + TaskID + '').prop('readonly', true);
            }

         
            /*Added by Kashish*/
            function Reply_OnClick(DiscussionID) {
              //  alert(DiscussionID)
                //document.getElementById("DiscussionTextArea").placeholder = "Reply New Discussion";
                  document.getElementById("DiscussionTextArea").placeholder = "Reply to Discussion";

                // Added By Gauri On 06th Sep 2024 For Tooltip Issue
                document.getElementById("post_discuss").textContent = "Reply";
                const replyTooltip = bootstrap.Tooltip.getInstance('#post_discuss');

                let replyTxt = 'Reply'; 
                if (replyTxt === 'Reply') {
                    replyTooltip.setContent({
                        '.tooltip-inner': 'Reply'
                    });
                } else {
                    replyTooltip.setContent({
                        '.tooltip-inner': 'Post' 
                    });
                }
                // End of Added By Gauri On 06th Sep 2024 For Tooltip Issue

                document.getElementById("post_discuss").setAttribute('onclick', 'AddNewDiscus(' + DiscussionID + ')')
                $("#DiscussionTextArea").focus();
                // document.getElementById("post_discuss").setAttribute('title', 'Reply')

            }
            function AutoGrowTextArea(textField) {
               
                if (textField.clientHeight < textField.scrollHeight) {
                    textField.style.height = textField.scrollHeight + "px";
                    if (textField.clientHeight < textField.scrollHeight) {
                        textField.style.height =
                          (textField.scrollHeight * 2 - textField.clientHeight) + "px";
                    }
                }
            }
   //Added by usha
            function limitText(limitField, limitCount, limitNum) {
                //debugger;
               // alert(limitField)
                //if (limitCount.innerHTML != 0) {


                //}
                var length;
                //debugger;
                if (limitField.value.length > limitNum) {
                    limitField.value = limitField.value.substring(0, limitNum);
                } else {
                    limitCount.innerHTML = (limitNum - limitField.value.length);

                    if (limitCount.innerHTML != 0) {
                        //debugger;
                        IsFlagcountdownSummary = 0;
                        IsFlagcountdownFN = 0;
                        IsFlagcountdownAC = 0;
                        IsFlagSubus = 0;
                        IsFlag = 0;
                        // alert(limitCount.innerHTML);
                    }
                }
                //alert(limitCount.innerHTML);
                if (limitCount.innerHTML == 0) {

                    if (limitCount.id == 'countdownFN') {
                        if (IsFlagcountdownFN != 1) {
                            document.getElementById("countdownFN").style.color = 'red' //when Char 0 length  then Color red
                            // $('#spanBusinessValue').html("You Can Enter Only 1000 Character");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can Enter Only 200 Character', 'error', 5);
                            IsFlagcountdownFN = 1;
                            return IsFlagcountdownFN;
                        }
                    }
                    else if (limitCount.id == 'countdownAC') {
                        if (IsFlagcountdownAC != 1) {
                            document.getElementById("countdownAC").style.color = 'red' //when Char 0 length  then Color red
                            // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
                            IsFlagcountdownAC = 1;
                            return IsFlagcountdownAC;
                        }
                    }
                    else if (limitCount.id == 'countdownSummary') {
                        if (IsFlagcountdownSummary != 1) {
                            document.getElementById("countdownSummary").style.color = 'red' //when Char 0 length  then Color red
                            // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can Enter Only 500 Character', 'error', 5);
                            IsFlagcountdownSummary = 1;
                            return IsFlagcountdownSummary;
                        }
                    }
                    else if (limitCount.id == 'countSubUSdown') {
                        if (IsFlagSubus != 1) {
                            document.getElementById("countSubUSdown").style.color = 'red' //when Char 0 length  then Color red
                            // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
                            //debugger;
                            $("#divAttachments .clsBox").css("min-height", "558px");
                            IsFlagSubus = 1;
                            return IsFlagSubus;
                        }
                    }
                    else {
                        if (IsFlag != 1) {
                            // document.getElementById("countdown").style.color = 'red' //when Char 0 length  then Color red
                            // $('#spanUserDesc').html("You Can Enter Only 1000 Character");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
                            IsFlag = 1;
                            return IsFlag;
                        }
                    }
                }
                else {
                    if (limitCount.id == 'countdownBU') {
                        document.getElementById("countdownBU").style.color = 'black'
                        //  $('#spanBusinessValue').text("");
                    }
                    else if (limitCount.id == 'countdownAC') {
                        document.getElementById("countdownAC").style.color = 'black'
                        // $('#spanAcceptanceCriteria').text("");
                    }
                    else if (limitCount.id == 'countdownFN') {
                        document.getElementById("countdownFN").style.color = 'black'
                        // $('#spanUserDesc').text("");
                    }
                    else {
                        //document.getElementById("countdown").style.color = 'black'
                        // $('#spanUserDesc').text("");
                    }

                }
                if (limitField.clientHeight < limitField.scrollHeight) {
                    limitField.style.height = limitField.scrollHeight + "px";
                    if (limitField.clientHeight < limitField.scrollHeight) {
                        limitField.style.height =
                          (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
                    }
                }
            }
            function ClearSpan(txt, span) {

                if ($('#' + txt).val() == "") {
                }
                else {
                    $('#' + txt).css('border-color', '#d8dade');
                    $('#' + txt).css('border-width', '1px');
                    $('#' + span).text("");
                }
            }

            
           //End by usha
            function adddata() {
                myLineChart.data.datasets[0].data[7] = 60;
                myLineChart.data.labels[7] = "Newly Added";
                myLineChart.update();
            }

            var option = {
                showLines: true
            };
           
          //Added  By Dipali V On 16th April 2019 For tab Refresh isssue
        var WhichTab = "";
        function ReFreshTab(WhichTab) {
            // alert(WhichTab.id)
            var UserStoryID = getSearchParams('UserStoryId');
            if (WhichTab.id == "SectionDiscussion") {
              BindDisscussionData(UserStoryID)
            }
             else if (WhichTab.id == "SectionAttachments") {
               BindAttachementsData(UserStoryID);
            }
              else if (WhichTab.id == "SectionSubUserStory") {
              BindSubUserStoryTable("#tblShowSubUserStory");
              PopulateSubUserStoryTable();

            }
                //Commented By Yasmin on 22-5-19 for User Story textare misaligned  under Details Tab
             else if (WhichTab.id == "Section1") {
             //BindUserStoryData(UserStoryID)
            }
             else if (WhichTab.id == "SectionTeams") {
             BindTeamData(UserStoryID)

            }
             else if (WhichTab.id == "SectionHistory") {
            BindSubUserStoryTable("#tblShowHistory");
            PopulateHistoryTable(UserStoryID);

            }
            else if (WhichTab.id == "SectionIssues") {
            BindSubUserStoryTable("#tblShowIssues");
            PopulateIssuesTable(UserStoryID);

            }
            else if (WhichTab.id == "SectionReviews") {
            BindSubUserStoryTable("#tblShowReviews");
            PopulateReviewsTable(UserStoryID);
            GetReviewerList();
            GetRevieweeList();
            }
             else if (WhichTab.id == "SectionTask") {
            // BindSubUserStoryTable("#tblShowTasks");
            PopulateTasksTable(UserStoryID)
            //BindTaskResourceDropDown(UserStoryID)
            // BindIssueAdd(UserStoryID);

            }
            else if (WhichTab.id == "SectionCharts") {
            GetLineBurnUPEffortS(UserStoryID, 'UserStory', UserStoryID, "", "BurnDown");
            GetLineBurnDownStoryPoints(UserStoryID, 'UserStory', UserStoryID, "", "BurnUp");
            GetLineBurnDown(UserStoryID, 'UserStory', UserStoryID, "", "BurnUp");
            GetLineBurnUP(UserStoryID, 'UserStory', UserStoryID, "", "BurnDown");

            }
            else (WhichTab.id == "SectionTestCase")
            {
            BindSubUserStoryTable("#tblTestCaseList");
            PopulateTestCaseTable(UserStoryID);

            }
             // initializFormControls();

        }
         //End of Added By Dipali V On 16th April 2019 For Tab Refresh issue

        //Added By Riddhesh Patil on 22/12/2022
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of Added By Riddhesh Patil on 22/12/2022


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
    </script>

</body>
</html>
