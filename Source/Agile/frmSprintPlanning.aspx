<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmSprintPlanning.aspx.vb" Inherits="Whizible.frmSprintPlanning" %>

<!DOCTYPE html>
<script runat="server">

'Protected Sub Page_Load(sender As Object, e As EventArgs)

'End Sub
</script>


<html>
                <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">
    <%--<title></title>
    
<link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
<link rel="stylesheet" href="css/SprintPlanning.css" />
<%--<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/editor.css" />
<%--<link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />
    
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="js/autosize.js"></script> 
<%--<script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
<script src="../../Whizible2.0-new/dist/js/bootbox.min.js"></script>
<%--<script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<script src="../../Whizible2.0-new/dist/js/editor.js"></script>
<script src="js/CommonJS.js?v=2.0"></script>

    <style>

        /*Added By Usha Pandit On 11.07.2019 for wrap text issue */
        .ajs-message {
            overflow-wrap: break-word;
            word-wrap: break-word;
        }
         /*End Of Added By Usha Pandit On 11.07.2019 for wrap text issue */

        .ajs-message ul li {
          /*white-space:pre-wrap;*/
          word-break:break-word;
        }
        #uldropdown li {
            list-style: none;
            cursor: pointer;
            float: left;
            width: 100%;
            padding: 5px 10px!important;
            font-weight: normal;
            margin-top: 10px;
}
        .modal-footer {
            border-top: none !important;
        }
        /*Added By Kashish on  for task detail issue fixing*/
        .tooltip-inline {
            display: inline-block !important;
        }
        /*span +.tooltip {
        left:10px!important;
        }*/
        /*textarea {
            resize: none !important;
        }*/
        #ulmodal .dropdown-menu {

           left:auto!important;
        }
        @media (max-width:1245px) {
            _:-moz-tree-row(hover), .box1 {
                width: 508px !important;
                overflow: hidden;
                padding: 10px;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 517px !important;
            }
        }

        @media (max-width:1170px) {
            _:-moz-tree-row(hover), .box1 {
                width: 492px !important;
                overflow: hidden;
                padding: 10px;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 498px !important;
            }

            #Showmore {
                color: #428bca !important;
                font-size: 11.5px;
                /* Modified By Madhuri.K On 01-04-2026 */
            }

            .fa, .fas, .far {
                font-size: 11.5px !important;
            }
        }

        @media (max-width:1170px) {
            _:-moz-tree-row(hover), .box1 {
                width: 471px !important;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 479px !important;
            }
        }

        @media (max-width:1100px) {
            _:-moz-tree-row(hover), .box1 {
                width: 438px !important;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 448px !important;
            }

            .panel-footer .fa {
                margin-right: 1px !important;
            }

            #Showmore {
                margin-right: -4px !important;
            }
        }

        @media (max-width:1035px) {
            .panel-footer .fa {
                font-size: 11px !important;
            }

            _:-moz-tree-row(hover), .box1 {
                width: 396px !important;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 402px !important;
            }
        }

        @media (max-width:900px) {
            _:-moz-tree-row(hover), .box1 {
                width: 830px !important;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 839px !important;
            }
        }

        @media (max-width:875px) {
            _:-moz-tree-row(hover), .box1 {
                width: 786px !important;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                width: 799px !important;
            }
            /*#MainDiv2 {
                 overflow: hidden!important;
                    width: 102%!important;
                }*/
        }

        @media (max-width:823px) {
            _:-moz-tree-row(hover), .box1 {
                width: 683px !important;
                overflow: hidden;
                padding: 10px;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                height: 668px;
                overflow: auto;
                width: 693px !important;
            }
        }

        @media (min-width:1200px) {
            _:-moz-tree-row(hover), .box1 {
                width: 548px !important;
                overflow: hidden;
                padding: 10px;
            }

            _:-moz-tree-row(hover), .OuterDiv {
                overflow: auto;
                width: 554px !important;
            }

            _:-moz-tree-row(hover), #divLeft.OuterDiv {
                overflow: auto;
                width: 543px !important;
            }
        }

        .OuterDiv {
            overflow-x: hidden !important;
        }

        #MainDiv {
            padding-top: 10px;
            padding-right: 0px;
            overflow-x: hidden !important;
            width: 103%;
        }

        .table {
            margin-bottom: 0rem !important;
            margin-top: 8px;
        }

        .wordwrap {
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
            word-break: break-word;
        }

        .tooltip-inner {
            word-break:break-word;
            /* Modified By Madhuri.K On 01-04-2026 */
            font-size: 11.5px !important;
        }

        /*Added By Kashish on24 july 2018 for tooltip issue fixing*/
        .tooltip_span {
            /*display:inline-block;
            width:100%!important;*/
            outline: none !important;
        }

            .tooltip_span [disabled] {
                pointer-events: none;
            }

        .tooltip_span_resource {
            /*display: inline-block;
            width: 100%!important;*/
            outline: none !important;
        }

            .tooltip_span_resource [disabled] {
                pointer-events: none;
            }
        /*.d-inline-block [disabled] {
                pointer-events: none!important;
            }*/
        .d-inline-block {
            outline: none !important;
        }
        /*End of Added By Kashish on24 july 2018 for tooltip issue fixing*/
        /*Added by kashish for task detail issue fixingon 22-8-2018*/
        #tblProjectDetail .fa-calendar-check, #trProjectDetail .fa-calendar-check {
            margin-top: 12px !important;
            float: right !important;
            margin-right: 5px;
            color: #0099CC;
            width: 0px;
        }

        ::-webkit-input-placeholder { /* Chrome/Opera/Safari */
            color: #ccc !important;
        }

        ::-moz-placeholder { /* Firefox 19+ */
            color: #ccc !important;
        }

        :-ms-input-placeholder { /* IE 10+ */
            color: #ccc !important;
        }

        :-moz-placeholder { /* Firefox 18- */
            color: #ccc !important;
        }
        /*Changed By YAsmin on 2st Aug 2018*/
        .placeholder {
            border: 2px dashed #ccc;
            padding: 40px 220px;
        }

        .draggable {
            height: auto;
            border-radius: 5px;
        }

        .clsSprint {
            background: #fff7e9;
        }

            .clsSprint .panel-heading {
                padding: 0px;
            }

        .panel-body {
            padding-top: 0px;
            padding-bottom: 0px;
        }

        .clsSprint .panel-body {
            padding: 15px;
        }

        #DivSprintlist th {
            text-align: center;
        }

        .search-container {
            text-align: right;
        }

        input[type=text]::-ms-clear {
            display: none;
        }

        .input-group-addon {
            background: white;
            border: 0px;
        }

        .col-sm-2 span {
            cursor: pointer;
        }

        .col-sm-3 span {
            cursor: pointer;
        }
        /*UI chnages done by Yasmin on 2nd May*/
        /*#MainDiv2 {
            overflow: auto;
            width: 103%;
            padding-right: 1% !important;
            padding-top: 10px !important;
            margin-top: 0px;
        }*/

        /*#MainDiv {
            overflow: hidden;
        }*/

        body {
            overflow: hidden;
            background-color: #fff;
        }


        .fa-check-square {
            color: green;
        }

        .fa-spinner {
            color: orange;
        }

        .fa-list-ol {
            color: #3baddc;
        }
        /*.modal-lg {
            width: auto;
        }*/
        .table > tbody > tr > td {
            padding: 2px;
        }


        #DivCurrentSprintUS #DivTaskList .table > tbody > tr > td {
            word-break: break-word;
        }


        .draggable .panel-footer .table td {
            white-space: nowrap;
        }

        .draggable .col-sm-2 {
            padding: 0px;
            width: 13%;
            text-align: center;
            margin-top: 5px;
        }

        .notifyThFirstTable {
            top: 4px;
            margin-left: 2px;
        }

        .draggable .col-sm-3 {
            padding: 0px;
            white-space: nowrap;
            text-align: right;
            margin-top: 5px;
            margin-bottom: 10px;
        }

        #dashBody .modal-header {
            padding: 8px !important;
        }

        .required {
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: red;
        }

        .Activity {
            height: 600px;
            overflow-y: auto;
        }

        @media (min-width: 992px) {
            .col-md-6 {
                width: 49% !important;
            }

            .modal_close {
                position: absolute !important;
                right: 6px !important;
            }

            .team_cards {
                width: 46% !important;
                margin: 1% !important;
            }
        }


        .clsBox {
            min-height: 500px !important;
            margin-bottom: 10px;
            /*Added By Kashish for task dtail ui change*/
            /*margin-right: 28px;*/
        }

        .draggable {
            padding-top: 20px;
            border: 1px solid #ddd;
            margin-left: 1%;
            /*width: 46%;*/
            margin-top: 10px;
        }

        @media (max-width:1100px) {
            .draggable .col-sm-3 {
                text-align: justify !important;
                margin-left: 10px;
            }

            .sprint_header {
                font-size: 11px !important;
            }

            .team_cards {
                margin: 1% !important;
            }
        }

        @media (max-width:900px) {
            .draggable {
                width: 100%;
            }
        }

        .card [class*=card-header-]:not(.card-header-icon):not(.card-header-text):not(.card-header-image) {
            border-radius: 3px !important;
            margin-top: -20px !important;
            padding: 4px 0px !important;
            margin-left: -9px !important;
            margin-right: -6px !important;
            z-index: 999 !important;
        }

        .header_badge {
            cursor: pointer;
            display: inline-block;
            min-width: 10px !important;
            padding: 3px 5px !important;
            font-size: 11px !important;
            font-weight: 700 !important;
            line-height: 1 !important;
            color: rgb(3, 174, 195) !important;
            text-align: center !important;
            white-space: nowrap !important;
            vertical-align: middle !important;
            background: #fff;
            border-radius: 10px !important;
            margin-top: -33px !important;
            margin-left: -15px !important;
            position: relative !important;
        }
        /*#divIssueForm .col-md-3 {
            margin-left:0px!important;
        }*/

        /*Added by Ankush T on 06/06/2018 for review list alignment */
        #DivReviewList table tr th {
            text-align: center !important;
        }
        /* End of Added by Ankush T on 06/06/2018 for review list alignment */


        /*Added by Usha Pandit on 07 June 2018 for word wrap for long text*/
        #DivHistorykList table tbody tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivHistorykList table tbody tr td:nth-child(2) {
            width: 10% !important;
        }

        #DivHistorykList table tbody tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivHistorykList table tbody tr td:nth-child(4) {
            width: 30% !important;
        }

        #DivHistorykList table tbody tr td:nth-child(5) {
            width: 35% !important;
        }

        #DivHistorykList table thead tr th:nth-child(1) {
            width: 10% !important;
        }

        #DivHistorykList table thead tr th:nth-child(2) {
            width: 10% !important;
        }

        #DivHistorykList table thead tr th:nth-child(3) {
            width: 10% !important;
        }

        #DivHistorykList table thead tr th:nth-child(4) {
            width: 30% !important;
        }

        #DivHistorykList table thead tr th:nth-child(5) {
            width: 35% !important;
        }
        /*End of Added by Usha Pandit on 07 June 2018 for word wrap for long text*/

        /*Added by Usha Pandit on 11 June 2018 for hiding scrollbar*/
        .scrollspy-example {
            -ms-scrollbar-arrow-color: white !important;
            -ms-scrollbar-base-color: white !important;
            -ms-scrollbar-shadow-color: white !important;
        }

        @media (min-width:992px) {
            .container {
                width: 990px;
            }
        }

        #Showmore {
            color: #428bca !important;
        }

        _:-moz-tree-row(hover), #divTaskList {
            width: 100.3%;
        }

        _:-moz-tree-row(hover), #divTasksUS {
            margin-right: 0px !important;
        }

        /*textarea {
            resize: none !important;
        }*/
        /*End of Added by Usha Pandit on 11 June 2018 for hiding scrollbar*/

        /*Added by Usha Pandit On 28 March 2019 for user story large description tooltip */
        .large .tooltip-inner {
            max-width: 550px !important;
            width: 550px !important;
        }
        /*End of Added by Usha Pandit On 28 March 2019 for user story large description tooltip */
        #DivAttachSprint .close {
            padding-left: 10px !important;
        }

        #divHeader1{display:inline-flex}
        .panel-footer {
    padding: 0 15px;
    background-color: rgb(245, 245, 245);
    border-top: 1px solid rgb(221, 221, 221);
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
}
        input[type="text"]{margin-bottom:0}
        .searchus{float:right}
        .label-warning {background-color: #f0ad4e;color:#fff;padding:0 8px}
        .nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus {
    color: #fff;
    background-color: #428bca;
}
        .ClsHeaderGraph{font-size:14px}
        #BurnUp{margin-top:14%}
        .fa, .fas {cursor: pointer;}
        #MainDiv2 {margin-top: 55px!important;}
        #divHeader1 .col-sm-2{position:relative}
        .panel-footer .fa, .panel-footer .fas, .panel-footer .far{margin-right: 10px; margin-top: 2px;}
        .fa, .fas, .far {font-size: 11.5px !important;}
        #div_details .form-group{display:flex}
        .demo-droppable p{font-size:14px}
        #Export{position:absolute;left: 65%;top: 4%;}
        .dropdown-menu{font-size:11.5px}
        #DivAttachSprint .modal-header{display:block}
        .modal-content .fa-search{padding-top:12px}

        /*added by Ashwini M on 27-3-2023*/
        .modal {overflow: auto;}
        #myModal_addSprint .modal-header{display:block}
        #myModal_addSprint .col-md-12, #myModal_addSprint .col-md-6{display:flex}
        #myModal_addSprint .form-control{border-radius:0}
        #myModal_addSprint #add_sprint{margin-left:auto}
        /*End of added by Ashwini M on 27-3-2023*/

        /*Added by Ashwini M on 29-3-2023*/
        #frmDetails .form-group{display:flex}
        #frmDetails .form-control{border-radius:0}
        /*End of Added by Ashwini M on 29-3-2023*/

        /*Added by Ashwini M on 31-3-2023*/
        #divSubstories .form-group{display:flex}
        .paginate_button.current {
    background-color: #0288D1 !important;
    color: #fff !important;
}

.paginate_button {
    text-decoration: none;
    border: none !important;
    border-radius: 20px;
    color: #0288D1 !important;
    padding: 6px 10px;
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
        /*End of Added by Ashwini M on 31-3-2023*/

/*Added by pradip on 12-4-2023*/
#modalsprint label.col-md-3.control-label {
    width: 152px;
    margin-left: 0px;
}
#tab_link{ width:97%;}
#modalsprint .row .col-md-9{ width:79%;}
/*End Added by pradip on 12-4-2023*/

@media only screen and (min-width: 992px) and (max-width: 1240px){
    #txtSearchPendingUS{
        margin-top: 0;
    }
}
    /* Added By Gauri On 04th Sep 2024 For Alignment Issue */
    .panel {
        border: 1px solid #ddd;
        margin-bottom: 20px;
    }
    .panel-default > .panel-heading {
        color: #000;
        background-color: #f5f5f5 !important;
        border-bottom: 1px solid #ddd;
        padding: 10px 15px;
    }
    .panel-heading span label {
        color: #333;
    }
    .panel-footer table tbody tr td{
        background: unset;
    }
    #tblFGrid th, tr, td {
        background-color: transparent;
    }
    .UndragFirstRow table tbody tr td{
        background: unset;
    }
    /* End of Added By Gauri On 04th Sep 2024 For Alignment Issue */

    /* Added By Gauri On 05th Sep 2024 For Alignment Issue */
    .modal-title {
        font-weight: 400;
    }
    #DivSprintlist table thead tr th {
        background: #fff;
        font-size: 11.5px !important;
    }
    #DivSprintlist table tbody tr td,
    #divReviewList table tbody tr td {
        font-size: 11.5px !important;
    }
    #divReviewList table thead tr th {
        background: #fff;
        font-size: 11.5px !important;
        font-weight: 700 !important;
        color: #8b8b8b !important;
    }
    .odd {
        background-color: #f7f7f7 !important;
    }
    #myModal_dash INPUT.clsTextBox {
        FONT-SIZE: 10pt;
        opacity: 0.7;
        margin-top: 0;
    }
    h2{
        font-weight: 400;
    }
    .modal-content{
        padding: 5px 15px;
    }
    .panel-heading span {
        color: #000 !important;
    }
    /* End of Added By Gauri On 05th Sep 2024 For Alignment Issue */

    /* Added By Gauri On 11th Sep 2024 For Alignment Issue */
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
        /* End of Added By Gauri On 11th Sep 2024 For Alignment Issue */

    </style>

    <%--// var IsAlert=0;--%>

    <script id="MainScript">

</script>
    <script type="text/javascript">
        //Added By Riddhesh Patil on 22/12/2022
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of Added By Riddhesh Patil on 22/12/2022
        //Added By Yasmin On 7th Feb 2019 for height of boxes
        //Added By Yasmin On 7th Feb 2019 for navigate to User story Details page
        $(document).click(function () {
            $(".tooltip").removeClass("in");
        });

        var height = $(window).height();
        if (window.matchMedia('(max-width: 991px)').matches) {
            $("#MainDiv").css({ "height": height, "overflow-y": "auto" });
            $("#divRight").css("margin-top", "20px");
        }
        function MoreDetailOnClick(UserStoryId) {

            window.location.href = "../Agile/UserStoryDetails.aspx?Back=Sprint" + "&UserStoryId=" + UserStoryId;
        }
        // ----------------- Global Variables-------------
        var isProductOwner = "<%=strIsPrductOwner%>";
        var gUserStoryID = '';
        var gIterationID = '';

        //For Hidden Fields
        var dragUserStoryD = '';
        var dragUserStoryID2 = '';
        var CategoryID = '';
        var dragIterationID = '';
        var draggedIterationID2 = '';

        //---------------------Open Sprint DashBoard---------------------------

        function OpenSprintDetailHead(flagSR, IterationID, flag) {
            //debugger;
            AfterRelaseSprintSave(flagSR, IterationID, flag);
        }
        function OpenSprintIssueHead(flagSR, IterationID, flag) {

            AfterRelaseSprintSave(flagSR, IterationID, flag);
        }
        function OpenSprintDiscussionHead(flagSR, IterationID, flag) {

            AfterRelaseSprintSave(flagSR, IterationID, flag);
        }
        function OpenSprintChartsHead(flagSR, IterationID, flag) {

            AfterRelaseSprintSave(flagSR, IterationID, flag);
        }

        var newChartTab;
        function AfterRelaseSprintSave(FlagSR, UniqueID, Flag) {


            var data1 = JSON.stringify({ IterationValue: UniqueID, Flag: FlagSR });
            var result1 = AJAXCallWithResult("frmSprintPlanning.aspx/GetSprintDetails", data1, false);
            if (result1.d != "") {
                if (FlagSR == 'Iteration') {
                    $('#myModal_addSprint').modal('hide');
                } else if (FlagSR == 'Release') {
                    $('#myModal_addRelease').modal('hide');
                }

                $('#dashBody').html("");
                $('#dashBody').html(result1.d);
                $(".empimg").tooltip();
                $('[data-bs-toggle="tooltip"]').tooltip();
                AutoResizeTextArea();
                gettextareaRows();
                RemoveTextArea();
                $('#myModal_dash').modal('show');
                $(".empimg").tooltip();
                $('[data-bs-toggle="tooltip"]').tooltip();
                var $li = $('#tab_link a').click(function () {
                    $li.removeClass('selected');
                    $(this).addClass('selected');
                });
            }

            $('#sprint_details').css("height", ((window.innerHeight / 2) + 50 + 'px'));

            $('#tab_link li').click(function () {
                $('#tab_link li a').css("text-decoration", "none");
                $('#tab_link li a').css("color", "");
                $("a", this).css("text-decoration", "underline");
                $("a", this).css("color", "#60ffa7");
            })
            $(".clsBox").hover(function () {
                $('#tab_link li a').css("text-decoration", "none");
                $('#tab_link li a').css("color", "");

                $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
                $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
                //$("[href=#" + $(this).attr("id") + "]").addClass("Selected")
                // alert( $(this).attr("id"));
            });
            // alert(Flag)
            //debugger;
            //if (Flag != undefined) {
            //    setTimeout(function () {
            //        $("[href=#" + Flag + "]").click();
            //        if ($("#" + Flag + "").offset() != undefined) {
            //        var scrollPos = $("#" + Flag + "").offset().top;

            //        $("#sprint_details").scrollTop(scrollPos - 200);
            //        }


            //    }, 500)
            //}
            //Change By Yasmin on 11-4-19
            if (Flag != undefined) {
                setTimeout(function () {
                    $("[href=#" + Flag + "]").click();
                    var widthAdd = 0;
                    var lengthPreDiv = $("#" + Flag + "").prevAll().length;
                    for (i = 0; i < lengthPreDiv; i++) {
                        widthAdd = widthAdd + parseInt($("#" + Flag + "").siblings().eq(i).height());
                    }
                    $("#sprint_details").scrollTop(widthAdd);

                }, 500)
            }

            var $li = $('#tab_link a').click(function () {
                var divId = $(this).attr("href").toString();
                divId = divId.replace("#", "");
                $("div").removeClass("activecls");
                //  alert(divId);
                $("#" + divId).addClass("activecls");
            });

            newChartTab = $('#myScrollspy ul li').click(function () {
                newChartTab.removeClass('active');
                $(this).addClass('active');

            });

            $(".tabcontentChart").hover(function () {
                //Commented and Added by Usha PAndit on 13 June 2018 for burn up down button highlight issue
                //$('#myScrollspy ul li a').css("background-color", "white");
                //$('#myScrollspy ul li a').css("color", "black");
                //// $("[href=#" + $(this).attr("id") + "]").removeClass('active');
                //// $(this).addClass('active');
                //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
                //$("[href=#" + $(this).attr("id") + "]").css("color", "white");


                $('#myScrollspy ul li').removeClass('active');
                $("[href=#" + $(this).attr("id") + "]").parent().addClass('active');


                $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
                $('#myScrollspy ul li a').css("cssText", "color:black!important;");


                $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
                $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");
                //End of Added by Usha PAndit on 13 June 2018 for burn up down button highlight issue
            });

            makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                var output = document.querySelector('.demo-droppable');
                output.innerHTML = '';
                for (var i = 0; i < files.length; i++) {
                    arrFile[0] = files[i];
                    output.innerHTML += '<p>' + files[i].name + '</p>';
                }
            });

            var $li = $('#tab_link a').click(function () {
                $li.removeClass('selected');
                $(this).addClass('selected');
            });

            //common();

            $("#editReleaseName").tooltip();
            $("#ReleaseSprintPer").tooltip();
            $("#ReleaseSprintNext").tooltip();
            $("#tab_content").tooltip();
            $(".ClsCaptiontooltip").tooltip();
            $(".card-text ").tooltip();
            $("span").tooltip();

            //Added By Dipali V On 24th March 2023 For Datatable Issue

            if ($("#FilterDivCurrentSprintUS").val() > 0) {
                datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '');
            }

            if ($("#FilterDivSubTabIssuesList").val() > 0) {
                datatables('DivSubTabIssuesList', 'txtSearchIssues', '');
            }

            if ($("#FilterDivImpedimentsLogsList").val() > 0) {
                datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '');
            }

            if ($("#FilterDivRisksList").val() > 0) {
                datatables('DivRisksList', 'txtSearchRisks', '');
            }

            if ($("#FilterDivReviewList").val() > 0) {
                datatables('DivReviewList', 'txtSearchReviews', '');
            }

            if ($("#FilterDivTaskList").val() > 0) {
                datatables('DivTaskList', 'txtSearchTask', '');
            }


            if ($("#FilterDivHistorykList").val() > 0) {
                datatables('DivHistorykList', 'txtSearchhistory', '');
            }

            if ($("#FilterdivsprintFormRefresh").val() > 0) {
                datatables('divsprintFormRefresh1', '', '');
            }
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue
            // debugger
            GetLineBurnUP(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnDown");
            GetLineBurnDown(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnUp");

            GetLineBurnUPEffortS(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnDown");
            GetLineBurnDownStoryPoints(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnUp");


            // GetLineVelocityEffortBar(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnDown");
            // GetLineVelocityStoryBar(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnUp");

            // GetFlowEfforts(UniqueID, FlagSR, 'divGraph' + UniqueID, "", "BurnDown");
            // GetCompleteCancelSprintSprint(UniqueID, 'Cancel')
            // GetCompleteCancelSprintSprint(UniqueID, 'Complete')
            //GetFlowStoryPoints(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");
            HighLightChart();
             $("[href=#" + Flag + "]").click();

        }

        //For Flow Efforts Graph
        function GetLineBurnUP(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            // debugger;

            var ctx1 = $("#BurnUp" + UniqueID);
            // var ctx1 = $("#line-chartcanvas1");
            var strResult, data;
            data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetGraphDetailsForGraph", data, false);

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
        //For BurnDown Graph
        function GetLineBurnDown(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            //debugger
            var ctx = $("#BurnDown" + UniqueID);
            var strResult, data;
            data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetGraphDetails", data, false);

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
            //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Remaining") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format           
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

        //For Burnup Graph
        function GetLineBurnUPEffortS(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            var BurnupGraphEfforts = $("#BurnupGraphEfforts" + UniqueID);
            var strResult, data;
            data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetGetBurnUpChartGraphDetails", data, false);

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
                //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Actual Completed") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format           
             
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

        function GetLineBurnDownStoryPoints(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {
            var BurnupGraphStoryPoints = $("#BurnupGraphStoryPoints" + UniqueID);
            // var ctx1 = $("#line-chartcanvas1");
            var strResult, data;
            data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
            strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetBurnUpStoryPoint", data, false);

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

        //For Velocity Bar Graph
        var preChartVelocity;
        function GetLineVelocityEffortBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            var VelocityEffortBar = document.getElementById("VelocityEffortBar" + UniqueID).getContext("2d");

            var strResult, data;

            data = JSON.stringify({ strGraphFilter: "Effort", UniqueID: UniqueID });

            console.log(data)
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetVelocityData", data, false);
            var strEntityCount = [];
            var PercentCount = [];
            var arrBackColor = [];
            var strLabels = [];
            if (strResult.d != "") {

                $.each(JSON.parse(strResult.d), function (id, object) {
                    strLabels.push(object["IterationName"]);
                    strEntityCount.push(object["Velocity"]);
                    PercentCount.push(object["Efforts"]);
                    // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                });

            }
            //  alert(strEntityCount)
            //   alert(PercentCount)
            var config1 = {
                type: 'bar',
                data: {
                    labels: strLabels,
                    datasets: [{
                        type: 'bar',
                        label: 'Velocity',
                        backgroundColor: [
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)"
                        ],
                        borderColor: [
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)"
                        ],
                        borderWidth: 1,
                        //fill: false,
                        data: strEntityCount,
                        // yAxisID: "y-axis-2",
                    }, {

                        type: 'bar',
                        label: 'Efforts',
                        // data: PercentCount,
                        backgroundColor: [
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)"
                        ],
                        borderColor: [
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)"
                        ],
                        borderWidth: 1,
                        data: PercentCount,
                        //  borderColor: 'white',
                        // borderWidth: 2,
                        // yAxisID: "y-axis-1",
                    }]
                },

            };


            var options = {
                responsive: true,
                title: {
                    display: true,
                    position: "top",
                    text: "Velocity Bar Graph(Effort)",
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
                //scales: {
                //    yAxes: [{
                //        ticks: {
                //            min: 0
                //        }
                //    }]
                //},
                //scaleLabel: {
                //    display: true,
                //    labelString: 'Story Points'
                //}
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

            // Remove the old chart and all its event handles
            if (preChartVelocity) {
                preChartVelocity.destroy();
            }

            // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
            var temp = jQuery.extend(true, {}, config1);
            temp.type = 'bar';
            temp.options = options;
            preChartVelocity = new Chart(VelocityEffortBar, temp);
        };
        var preChartVelocityStoryBar;
        function GetLineVelocityStoryBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

            var VelocitySToryPoints = document.getElementById("VelocitySToryPoints" + UniqueID).getContext("2d");

            var strResult, data;

            data = JSON.stringify({ strGraphFilter: "Storypoint", UniqueID: UniqueID });

            console.log(data)
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetVelocityData", data, false);
            var strEntityCount = [];
            var PercentCount = [];
            var arrBackColor = [];
            var strLabels = [];
            if (strResult.d != "") {

                $.each(JSON.parse(strResult.d), function (id, object) {
                    strLabels.push(object["IterationName"]);
                    strEntityCount.push(object["Velocity"]);
                    PercentCount.push(object["Efforts"]);
                    // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                });

            }

            var config1 = {
                type: 'bar',
                data: {
                    labels: strLabels,
                    datasets: [{
                        type: 'bar',
                        label: 'Velocity',
                        backgroundColor: [
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)",
                            "rgba(10,20,30,0.3)"
                        ],
                        borderColor: [
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)",
                            "rgba(10,20,30,1)"
                        ],
                        borderWidth: 1,
                        //fill: false,
                        data: strEntityCount,
                        // yAxisID: "y-axis-2",
                    }, {

                        type: 'bar',
                        label: 'Efforts',
                        // data: PercentCount,
                        backgroundColor: [
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)",
                            "rgba(50,150,200,0.3)"
                        ],
                        borderColor: [
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)",
                            "rgba(50,150,200,1)"
                        ],
                        borderWidth: 1,
                        data: PercentCount,
                        //  borderColor: 'white',
                        // borderWidth: 2,
                        // yAxisID: "y-axis-1",
                    }]
                },

            };


            var options = {
                responsive: true,
                title: {
                    display: true,
                    position: "top",
                    text: "Velocity Bar Graph(Story Points)",
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
                //scales: {
                //    yAxes: [{
                //        ticks: {
                //            min: 0
                //        }
                //    }]
                //},
                //scaleLabel: {
                //    display: true,
                //    labelString: 'Story Points'
                //}
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

            // Remove the old chart and all its event handles
            if (preChartVelocityStoryBar) {
                preChartVelocityStoryBar.destroy();
            }

            // // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
            var temp = jQuery.extend(true, {}, config1);
            temp.type = 'bar';
            temp.options = options;
            preChartVelocityStoryBar = new Chart(VelocitySToryPoints, temp);
        };
        //End  of  Velocity Bar Graph

        //For Flow Efforts Graph
        function GetFlowEfforts(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {


            var FlowGraphEfforts = $("#FlowGraphEfforts" + UniqueID);
            var strResult, data;
            data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/GetFlowGraph", data, false);

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
                    borderColor: "#5bc0de",
                    backgroundColor: "#5bc0de",
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
                    text: "Flow Chart(Flow)",
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
                }
            };
            var chart = new Chart(FlowGraphEfforts, {
                type: "line",
                data: lineChartData1,
                options: options
            });
        }

        function GetCompleteCancelSprintSprint(ReleaseID, GraphFlag) {
            var strResult = ajaxCall("frmSprintPlanning.aspx/GetCompleteCancelGraphDetails", "POST", "application/json", "json",
                JSON.stringify({ ReleaseID: ReleaseID, GraphFlag: GraphFlag }));//188
            if (strResult.d != "") {

                if (GraphFlag != "Complete") {

                    $("#CanSprintGrid" + ReleaseID).html("");
                    $("#CanSprintGrid" + ReleaseID).html(strResult.d);
                    //Added By Dipali V On 24th March 2023 For Datatable Issue
                    if ($("#FilterDivCancelSprint").val() > 0) {
                        datatables('DivCancelSprint', '', '')
                    }
                   //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                    


                }
                else {
                    $("#ComSprintGrid" + ReleaseID).html("");
                    $("#ComSprintGrid" + ReleaseID).html(strResult.d);
                   
                    //Added By Dipali V On 24th March 2023 For Datatable Issue
                    if ($("#FilterDivCompleteSprint").val() > 0) {
                        datatables('DivCompleteSprint', '', '')
                    }
                   //End of Added By Dipali V On 24th March 2023 For Datatable Issue


                }
                $('[data-bs-toggle="tooltip"]').tooltip();
                // $('.radio-inline').tooltip()
            }
        }

        function editReleaseName(ReleaseName) {
            $("#txtReleaseName").prop('disabled', false);
            $("#txtReleaseName").css("border-bottom", "#ddd");
            $("#txtReleaseName").focus();
        }

        var arrTabs = [];
        var arrTabs1 = [
            "div_details",
            "graph",
            "Sprints",
            "div_UserStory",
            "div_Team",
            "div_Task",
            "div_Issues",
            "div_Discussion",
            "div_Reviews",
            "div_Impedement",
            "div_Risks",
            "div_History",
            "div_Attachment"
        ];

        var arrTabs = [
            "div_details",
            "graph",
            "Sprints",
            "div_UserStory",
            "div_Team",
            "div_Task",
            "div_Issues",
            "div_Discussion",
            "div_Reviews",
            "div_Impedement",
            "div_Risks",
            "div_History",
            "div_Attachment"
        ];

        function PreSprintRelease(Flag) {
            if (Flag != "Iteration") {
                arrTabs = arrTabs1;
            }
            else {
                arrTabs = arrTabs;
            }
            for (var i = 0; i < arrTabs.length; i++) {
                if (i != arrTabs.length - 1) {
                    if ($("#" + arrTabs[i]).hasClass("activecls")) {
                        var curTab = i - 1;
                        // $("#" + arrTabs[curTab]).click();
                        $("[href=#" + arrTabs[curTab] + "]").click();
                        // var scrollPos = $("#" + Flag + "").offset().top;
                        var scrollPos = $("#" + arrTabs[curTab] + "").offset().top;
                        $("#sprint_details").scrollTop(scrollPos - 250);
                        break;
                    }
                }
            }
        }
        function NextSprintRelease(Flag) {
            if (Flag != "Iteration") {
                arrTabs = arrTabs1;
            }
            else {
                arrTabs = arrTabs;
            }
            for (var i = 0; i < arrTabs.length; i++) {
                if (i != arrTabs.length - 1) {
                    if ($("#" + arrTabs[i]).hasClass("activecls")) {
                        var curTab = i + 1;
                        // $("#" + arrTabs[curTab]).click();
                        $("[href=#" + arrTabs[curTab] + "]").click();
                        // var scrollPos = $("#" + Flag + "").offset().top;
                        var scrollPos = $("#" + arrTabs[curTab] + "").offset().top;
                        $("#sprint_details").scrollTop(scrollPos - 250);
                        break;
                    }
                }
            }
        }

        //---------------------End Sprint DashBoard---------------------------
        function OpenAllSprint(UserStoryID) {
            gUserStoryID = UserStoryID;
            var strResult, data;
            data = JSON.stringify({ Mode: "OnlyReady" });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/ScrumIterationList", data, false);

            if (strResult.d != '') {
                $("#IdheaderNEW").html("Sprint List")
                $("#DivAttachSprint").modal('show');
                $("#divListdetailsNEW").html(strResult.d);
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                if ($("#FilterListCount").val() > 0) {
                    datatables('DivSprintlist', 'txtattchlinkSprintSearch', '');
                }
                //End of Added By Dipali V On 24th March 2023 For Datatable Issue
              
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }
        // ---------------------------End Discussion Box-----------------------------
        //-------------------------Add Sprint- And Add Release-------------------------------------------------

        function ShowAddSprint() {
            var Flag = "Iteration";
            var result = ajaxCall("frmSprintPlanning.aspx/BindSprintModal", "POST", "application/json", "json", JSON.stringify({ Flag: Flag }))

            if (result.d != '') {
                $('#SprintBody').html(result.d);
                //AutoResizeTextArea();
                RemoveTextArea();
                $('#myModal_addSprint').modal('show');

                common();
                $("#divProductBacklog .modal-lg").css("width", "");
                /*Added By yasmin on 7-3-19*/
                $("#txtStartDateS").prop('readonly', true);
                $("#txtEndDateS").prop('readonly', true);
            }
        }
        function ShowAddRelease() {
            //$('#myModal_addRelease').modal('show');
            var Flag = "Release";
            var result = ajaxCall("frmSprintPlanning.aspx/BindReleaseModal", "POST", "application/json", "json", JSON.stringify({ Flag: Flag }))
            if (result.d != '') {
                $('#ReleaseBody').html(result.d);
                $('#myModal_addRelease').modal('show');
                common();
                $("#divProductBacklog .modal-lg").css("width", "");
            }
        }

        function AddSprint() {
            if (validationSprit() == 0) {
                var SSprintName = $('#txtSprintName').val();
                var SStratDate = $('#txtStartDateS').val();
                var SDescription = $('#txtDescriptionS').val();
                var SEndDate = $('#txtEndDateS').val();
                var SDurCal = $('#txtDurationCalendeS').val();
                var SDurBus = $('#txtDurationBusinessDayS').val();
                var Sefforts = $('#txtEffortsS').val();

                //if (SSprintName == '') {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Enter Sprint Name');
                //    return false;
                //} else if (SStratDate == '') {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Select Start Date');
                //    return false;
                //} else if (SEndDate == '') {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Select End Date');
                //    return false;
                //} else if (Sefforts == '') {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Enter Efforts.');
                //    return false;
                //}

                //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                dtStartDate = document.getElementById("txtStartDateS");
                dtEndDate = document.getElementById("txtEndDateS");

                var oldobjStartVal = dtStartDate.value;
                var oldobjEndVal = dtEndDate.value;

                // Commented and Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
                //getInputDateFormat(dtStartDate, dtEndDate, 1);
                getInputDateFormat(dtStartDate, dtEndDate, 1, opDateFormat);

                // Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

                SStratDate = dtStartDate.value;
                SEndDate = dtEndDate.value;

                dtStartDate.value = oldobjStartVal;
                dtEndDate.value = oldobjEndVal;

                //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation

                var obj = {};
                //obj.intIterationID = '';
                //obj.intProjectID = '';
                obj.strIteration = SSprintName;
                //obj.intReleaseID = '';
                obj.strDescription = SDescription;
                obj.dtStartDate = SStratDate;
                obj.dtEndDate = SEndDate;
                obj.intDuration = SDurCal;

                //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                //obj.fltVelocity = Sefforts;
                obj.strVelocity = Sefforts;
                //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 


                //obj.strUserName = '';
                obj.intBusinessDuration = SDurBus;

                var data = JSON.stringify(obj);
                var result = AJAXCallWithResult("frmSprintPlanning.aspx/InsertSprintRecords", data, false);
                if (result.d != '') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('Sprint created successfully.');

                    AfterRelaseSprintSave('Iteration', result.d, 'div_details');
                }
            }
        }

        function AddRelease() {
            var RReleaseName = $('#txtReleaseName').val();
            var RStratDate = $('#txtStartDateR').val();
            var RDescription = $('#txtDescriptionR').val();
            var REndDate = $('#txtEndDateR').val();
            var RDurCal = $('#txtDurationCalendeR').val();
            var RDurBus = $('#txtDurationBusinessDayR').val();
            var Refforts = $('#txtEffortsR').val();

            if (RReleaseName == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Enter Release Name');
                return false;
            } else if (RStratDate == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select StartDate');
                return false;
            } else if (RDescription == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Enter Description');
                return false;
            } else if (REndDate == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select EndDate');
                return false;
            }

            var obj = {};

            obj.strReleaseName = RReleaseName;
            obj.strDescription = RDescription;
            obj.dtStartDate = RStratDate;
            obj.dtEndDate = REndDate;
            obj.intDuration = RDurCal;
            // obj.fltVelocity = Refforts;                
            obj.intBusinessDuration = RDurBus;

            var data = JSON.stringify(obj);
            var result = AJAXCallWithResult("frmSprintPlanning.aspx/InsertReleaseRecords", data, false);
            if (result.d != '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('Release Inserted Successfully.');

                AfterRelaseSprintSave('Release', result.d, 'div_details');
            }
        }
         //added by Chetan M on 12 Dec 2020 for Issue fixing
 var GlobalIterationIDNew = 0;
        function UpdateSprintRelease(flag, IterationID) {
            //debugger;
            GlobalIterationIDNew = IterationID;
             // End of added by Chetan M on 12 Dec 2020 for Issue fixing
            var SRName = $('#txtSRName').val();
            var StartDate = $('#txtSRStartDate').val();
            var Description = $('#txtSRDescription').val();
            var EndDate = $('#txtSREndDate').val();
            var CalenderDuration = $('#txtSRCalendersDuration').val();
            var BusinessDuration = $('#txtSRBusinessDuration').val();

            /*Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/
            var blnValidateEfforts = true;
            /*End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/


            if (flag == "Iteration") {

                /*Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/
                if (validationSpritRelease() == 1) {
                    blnValidateEfforts = false;
                }
                /*End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/

                var Efforts = $('#txtSREfforts').val();
            }

            /*Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/
            if (blnValidateEfforts == true) {
                /*End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/

                var obj = {};
                obj.IterationID = IterationID;
                obj.strIteration = SRName;
                obj.strDescription = Description;
                obj.dtStartDate = StartDate;
                obj.dtEndDate = EndDate;
                obj.intDuration = CalenderDuration;

                // Commented and Added By Ankush T on 26-Mar-2019 Purpose::Project Work field level changes 
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
                //End of Commented and Added By Ankush T on 26-Mar-2019 Purpose::Project Work field level changes 
                obj.intBusinessDuration = BusinessDuration;
                obj.flag = flag;

                $.ajax({
                    type: "POST",
                    url: "frmSprintPlanning.aspx/UpdateSprintReleaseRecords",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('Data saved successfully.');
                    }
                });
                /*Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/
            }
            /*End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/
        }

        function MapMultipleSprint(releaseids) {
            var strSeletedIteration = '';
            //strSeletedIteration = $('input[name=chkIterationSelect]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');

            var chkIterationSels = document.getElementsByName("chkIterationSelect");
            for (var i = 0; i < chkIterationSels.length; i++) {
                if (chkIterationSels[i].checked == true) {
                    if (strSeletedIteration == '') {
                        strSeletedIteration = chkIterationSels[i].value;
                    }
                    else {
                        strSeletedIteration += ',' + chkIterationSels[i].value;
                    }
                }
            }

            if (strSeletedIteration.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Iteration', 'error');
                return;
            } else {

                var obj = {};
                obj.SelectedSprint = strSeletedIteration;
                obj.ReleaseID = releaseids;
                var data = JSON.stringify(obj);

                var strResult = AJAXCallWithResult("frmSprintPlanning.aspx/SaveUnmappedSprinttoRelease", data, false);

                if (strResult.d != '') {
                    var arrPriority = String(strResult.d).split("||")
                    $('#divSprintLists').html("");
                    $('#divSprintLists').html(arrPriority[1]);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Saved Unmapped Sprint successfully', 'success', 5);
                }
                //$.ajax({
                //    type: "POST",
                //    url: "frmSprintPlanning.aspx/MapSprintToRelease",
                //    data: JSON.stringify(obj),
                //    contentType: "application/json; charset=utf-8",
                //    dataType: "json",
                //    success: function (data) {
                //        alertify.set('notifier', 'position', 'top-right');
                //        alertify.success('Sorted Rows Saved Successfully');
                //    }
                //});
            }
        }
        function UnmappedSprint(IterationID, SprintID) {
            $('#txtRemark').val('');
            gIterationID = IterationID;
            $("#divUnmapSprint").css("display", "")
            $("#divSprintLists").css("display", "none")
        }

        function EnableSprintReleaseName() {
            var na = $('#txtSprintReleaseName').val();
            //alert(na);
            $('#txtSprintReleaseName').attr("editable", true);
        }
        function TerminateSprint1(ReleaseID, txtID, Flag) {
            // debugger;
            //alert(ReleaseID + '-' + gIterationID);
            var txtRemark = document.getElementById(txtID);
            //var spanRemark = document.getElementById("spanRemark" + GlobalstrIterationID);
            if (txtRemark.value != "") {
                var strResult = AJAXCallWithResult("frmSprintPlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: gIterationID, strReleaseID: ReleaseID }), false);
                if (strResult.d == "2") {

                    var result = AJAXCallWithResult("frmSprintPlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: gIterationID, strRemark: txtRemark.value, ReleaseID: ReleaseID, Flag: Flag }), false);
                    if (result.d != "") {
                        var ResultLefdiv = result.d.split("||")
                        document.getElementById("divSprintLists").innerHTML = ResultLefdiv[1];
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sprint unmapped successfully', 'success', 5);

                        ShowData1('List', '');
                    }
                }
                else if (strResult.d == "1") {
                    // ShowPopup("Release is released.You can not terminate Sprint.");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Release is released.You can not terminate Sprint.', 'error');
                    ShowData1('List', '');
                }
                else if (strResult.d == "3") {
                    //ShowPopup("You can not terminate Sprint.");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You can not terminate Sprint', 'error');
                    ShowData1('List', '');

                }
                else {
                    //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
                }
            }
            else {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter Remark', 'error');
                //$("#" + "txtRemark" + GlobalstrIterationID).css('border-color', 'red');
                //$("#" + "txtRemark" + GlobalstrIterationID).css('border-width', '1px');
                //$("#" + "spanRemark" + GlobalstrIterationID).text("Please Enter Remark");
                return false;
            }
        }

        //Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
        //function StartSprint(IterationID) {
        //    if (isProductOwner == 1) {
        //        var data = JSON.stringify({ IterationID: IterationID });
        //        var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetIterationMappedToUserStory", data, false);
        //        if (result.d == "") {
        //            var result2 = AJAXCallWithResult("frmSprintPlanning.aspx/GetSprintStartDetails", data, false);
        //            if (result2.d != "") {

        //                if (result2.d.indexOf("Completed") > 0) {
        //                    alertify.set('notifier', 'position', 'top-right');
        //                    alertify.notify('Sprint completed successfully', 'success', 25);
        //                    //$("#btnStartSprint").text('Completed');
        //                    $('#btnStartSprint').addClass("btn btn-success");
        //                    $('#btnStartSprint').text('Completed');
        //                    //RefreshBothTable(userStoryID, IterationID);
        //                }
        //                else {
        //                    // alert(result2.d);
        //                    // alert('1');
        //                    alertify.set('notifier', 'position', 'top-right');
        //                    alertify.notify(result2.d, 'error', 25);
        //                }
        //            }
        //            else {
        //                //SET COLOR
        //                $('#btnStartSprint').addClass("btn btn-success");
        //                $('#btnStartSprint').text('In Progress');

        //                alertify.set('notifier', 'position', 'top-right');
        //                alertify.notify('Sprint Started successfully', 'success', 25);
        //            }
        //        } else {
        //            //alert(result2.d);
        //            /// alert('2');
        //            alertify.set('notifier', 'position', 'top-right');
        //            alertify.notify(result.d, 'error', 25);
        //        }
        //    } else {
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.notify('You are not a Product Owner to perform any action on Sprint.', 'error', 25);
        //    }
        //}

        //Added by Usha Pandit on 23 Aug 2018 for refresh confrim popup on sprint completion
        //function showConfirmBoxOnSprintComplete(IterationID) {
        //    debugger;

        //    var data = JSON.stringify({ IterationID: IterationID });


        //    var strResult1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToSprint", data, false);
        //    if (strResult1 != null && strResult1 != undefined) {
        //        if (strResult1.d != '') {
        //            var sprintcompletecheckdata = strResult1.d.toString().split("###");
        //            if (sprintcompletecheckdata.length == 4) {

        //                return sprintcompletecheckdata;
        //            }
        //            //$("#mdlConfirmBody").html(strResult1.d);
        //            //$("#myModalconfirm").modal('show');
        //            //AutoResizeTextArea();
        //            //RemoveTextArea();
        //            //setTimeout(
        //            //    function () {
        //            //        $("#txtRemark" + IterationID).focus();
        //            //    }, 500
        //            //    )
        //        }
        //    }

        //}
        //End of Added by Usha Pandit on 23 Aug 2018 for refresh confrim popup on sprint completion

        function StartSprint(IterationID, SprintStatus, EndDateFlag, DODSprintStatusFlag, ConfirmBoxMessage) {
            //debugger;
            //var checkstatus = 0;
            //alert(ConfirmBoxMessage);
            //Commented and Added by Usha Pandit on 23 Aug 2018 for refresh confrim popup on sprint completion
            //if (ConfirmBoxMessage != "" && ConfirmBoxMessage != undefined) {
            //    ConfirmBoxMessage = ConfirmBoxMessage.replace("[", " ' ");
            //    ConfirmBoxMessage = ConfirmBoxMessage.replace("]", " ' ");
            //}

            //var sprintconfirmboxdata = showConfirmBoxOnSprintComplete(IterationID);
            //SprintStatus = sprintconfirmboxdata[0];
            //EndDateFlag = sprintconfirmboxdata[1];
            //DODSprintStatusFlag = sprintconfirmboxdata[2];
            //ConfirmBoxMessage = sprintconfirmboxdata[3];

            if (ConfirmBoxMessage != "" && ConfirmBoxMessage != undefined) {
                ConfirmBoxMessage = ConfirmBoxMessage.replace("[", " ' ");
                ConfirmBoxMessage = ConfirmBoxMessage.replace("]", " ' ");
            }
            //End of Added by Usha Pandit on 23 Aug 2018 for refresh confrim popup on sprint completion
            //if ($("#btnStartSprint").text() == "In Progress") {
            //    checkstatus = 1;
            //    SprintStatus = "Ready To Complete";
            //}
            //alert(EndDateFlag);
            EndDateFlag = 1;
            if (isProductOwner == 1) {
                var data = JSON.stringify({ IterationID: IterationID });
                var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetIterationMappedToUserStory", data, false);
                if (result.d == "") {
                    if (SprintStatus == "Ready To Complete" && EndDateFlag == 1 && DODSprintStatusFlag == "True") {
                        try {
                            // debugger;
                            bootbox.confirm({
                                message: ConfirmBoxMessage,//"Are you sure do you want to complete the sprint before sprint end date?",
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
                                        var result2 = AJAXCallWithResult("frmSprintPlanning.aspx/GetSprintStartDetails", data, false);
                                        if (result2.d != "") {
                                            if (result2.d.indexOf("Completed") > 0) {
                                                alertify.set('notifier', 'position', 'top-right');
                                                //Commented And Added By Reshma Chavan on 21 jan 2022 for getting correct alert
                                                //alertify.notify('Sprint completed successfully', 'success', 5);
                                                var result = result2.d.replace('$$$1', '');
                                                alertify.notify(result, 'success', 5);
                                                //End of Commented And Added By Reshma Chavan on 21 jan 2022 for getting correct alert
                                                //$("#btnStartSprint").text('Completed');
                                                $('#btnStartSprint').addClass("btn btn-success");
                                                $('#btnStartSprint').text('Completed');
                                                //RefreshBothTable(userStoryID, IterationID);  
                                                RefreshBothTable('', IterationID);
                                            }
                                        }
                                    }
                                }
                            });
                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    }
                    else {
                        //debugger;
                        //alert('2')
                        var result2 = AJAXCallWithResult("frmSprintPlanning.aspx/GetSprintStartDetails", data, false);
                        //Added by Chetan M on 14 May 2021 for Wrong alert and refresh issue when complete the sprint
                        if (result2.d == null) {
                            result2.d = "";
                        }
                        //End of Added by Chetan M on 14 May 2021 for Wrong alert and refresh issue when complete the sprint
                        if (result2.d != "") {

                            if (result2.d.indexOf("Completed") > 0) {
                                alertify.set('notifier', 'position', 'top-right');
                                //Commented And Added By Reshma Chavan on 21 jan 2022 for getting correct alert
                                //alertify.notify('Sprint completed successfully', 'success', 5);
                                var result = result2.d.replace('$$$1', '');
                                alertify.notify(result, 'success', 5);
                                //End of Commented And Added By Reshma Chavan on 21 jan 2022 for getting correct alert
                                //$("#btnStartSprint").text('Completed');
                                $('#btnStartSprint').addClass("btn btn-success");
                                $('#btnStartSprint').text('Completed');
                                //RefreshBothTable(userStoryID, IterationID);
                                 RefreshBothTable('', IterationID);
                            }
                            else {
                                // alert(result2.d);
                                // alert('1');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify(result2.d, 'error', 15);
                            }
                        }
                        else {
                            // alert('12')
                            if (SprintStatus == "In Process") {
                                //SET COLOR
                                $('#btnStartSprint').addClass("btn btn-success");
                                $('#btnStartSprint').text('In Progress');
                                //$('#btnStartSprint').text('Ready to Complete');
                               // RefreshBothTable('', IterationID);


                            }
                            //else if (checkstatus == 1)
                            //{
                            //    $('#btnStartSprint').addClass("btn btn-success");
                            //    $('#btnStartSprint').text('Ready To Complete');

                            //}
                            //Added by Ankush T on 26 Mar 2018 For If US done is NA then status is displaying as Inprogress
                            //Else IF Added by Chetan M on 14 May 2021 for Wrong alert and refresh issue when complete the sprint
                            else if (SprintStatus == "Ready To Complete") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify('Sprint completed successfully', 'success', 5);
                                RefreshBothTable('', IterationID);
                            }
                            else {
                                // $('#btnStartSprint').addClass("btn btn-success");
                                //$('#btnStartSprint').text('Ready To Complete');
                                //Select_Sprint()
                                // RefreshBothTable('', IterationID);

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Sprint Started successfully', 'success', 5);
                            }
                            //End of Added by Ankush T on 26 Mar 2018 For If US done is NA then status is displaying as Inprogress
                           

                        }
                    }
                } else {
                    //alert(result.d);
                    /// alert('2');
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(result.d, 'error', 5);
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You are not a Product Owner to perform any action on Sprint.', 'error', 5);
            }
        }

        //End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

        function ChangeSprintName(IterationID, Flag) {
            var result = AJAXCallWithResult("frmSprintPlanning.aspx/ChangeSprintName", JSON.stringify({ IterationID: IterationID, SprintName: $("#txtReleaseName").val(), Flag: Flag }), false);
            if (result.d != "") {
                //alert(result.d);
                $('#tab_link li').click(function () {
                    $('#tab_link li a').css("text-decoration", "none");
                    $('#tab_link li a').css("color", "");
                    $("a", this).css("text-decoration", "underline");
                    $("a", this).css("color", "#60ffa7");
                })
                $(".clsBox").hover(function () {
                    $('#tab_link li a').css("text-decoration", "none");
                    $('#tab_link li a').css("color", "");
                    $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
                    $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
                });
            }
        }
        function editSprintName(ReleaseName) {
            $("#txtReleaseName").prop('disabled', false);
            $("#txtReleaseName").css("border-bottom", "#ddd");
            $("#txtReleaseName").focus();
        }
        //-------------------------End Add Sprint ---------------------------------------------
        function ShowModal(type, categoryID) {
            // debugger;
            if (type == "User") {

                //Added 2-Apr-2018
                strUserStoryId = "";

                var strUserResult = ajaxCall("frmSprintPlanning.aspx/AddUserStoryModal", "POST", "application/json", "json", JSON.stringify({ CategoryID: categoryID }));

                document.getElementById("divProductBacklog_Body").innerHTML = strUserResult.d;
                //AutoResizeTextArea();
                RemoveTextArea();
                //autosize(document.querySelectorAll('textarea'));
                $("#divProductBacklog_Body").find("input,textarea,select").removeAttr("disabled");
                $("#divProductBacklog_Body").find("input,textarea,select").removeAttr("readonly");
                $("#divProductBacklog").modal('show');
                $("#frmDetails").css({ "height": "100%!important", "overflow-y": "hidden!important" });

                $("#frmDetails").removeClass("clsBox");
                $("#divProductBacklog .modal-lg").css("width", "");
                $("#txtUserDesc").css("height", "auto!important;");
            }

            //$('textarea').on('input', function () {
            //    $(this).css('height', "25px");
            //    $(this).css('height', this.scrollHeight + "px");
            //});
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
        function ValidateBlankField(obj, spanObj, Msg) {
            var checkValue = 0;
            if ($("#" + obj.id).val() == "") {
                $("#" + obj.id).css('border-color', 'red');
                $("#" + obj.id).css('border-width', '1px');
                $("#" + spanObj.id).text(Msg);
                if (checkValue != 1) {
                    $("#" + obj.id).focus()
                }
                checkValue = 1;
            }
            return checkValue;
        }
        function GetPriorityColor_Success(result) {

            var arrPriority = String(result.d).split("||")
            var cColor = arrPriority[0]
            var ChangeColorTD = arrPriority[1];
            $("#tblPriorityColor").html("")
            $("#tblPriorityColor").append(ChangeColorTD);
            $("#iPriorityColor").css("color", cColor)
        }
        function SelectFVersionColor(versionID) {

            var versionID = versionID.value;
            if (versionID != "") {
                var url = "frmSprintPlanning.aspx/GetVersionColor";
                var data = JSON.stringify({ versionID: versionID, Mode: 'FVersion' });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                GetFversionColor_Success(strResult)
            }
        }
        function SelectVersionColor(versionID) {
            var versionID = versionID.value;
            if (versionID != "") {
                var url = "frmSprintPlanning.aspx/GetVersionColor";
                var data = JSON.stringify({ versionID: versionID, Mode: 'Version' });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                GetversionColor_Success(strResult);
            }
        }
        function GetversionColor_Success(result) {
            var arrPriority = String(result.d).split("||")

            var cColor = arrPriority[0]
            var ChangeColorTD = arrPriority[1];
            $("#tblVersionColor").html("")
            $("#tblVersionColor").append(ChangeColorTD);
            $("#iVersion").css("color", cColor)
        }
        var cColor;
        function ChangeColor(ID, color, mode) {
            cColor = color;
            var url = "frmSprintPlanning.aspx/ChangeColor";
            var data = JSON.stringify({ ID: ID, color: color, mode: mode });
            var strResult = ajaxCall(url, "POST", "application/json", "json", data);
            ChangeColor_Success(strResult);

        }
        function ChangeColor_Success(result, para) {

            if (result.d == 1) {
                $("#iPriorityColor").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 2) {
                $("#oColor").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 3) {
                $("#iVersion").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 4) {
                $("#iFVersion").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            //var url = "frmProductBacklog.aspx/RefreshGrid";
            //var data = JSON.stringify({});
            //AJAXCall(url, data, BindGrid);

        }
        function SaveValidation() {
            var objPriorityForCompare = document.getElementById('cboPriority');
            var objSpanPriorityForCompare = document.getElementById('spanPriority');



            var checkvalue = 0;
            var Flag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"


            if ($("#txtFeatureName").val() == "") {
                strmsg = '- User Story Name should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#txtFeatureName").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('User story should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtFeatureName").focus();
                Flag = 1;
                checkvalue = 1;
            }
            //End of Added By Riddhesh Patil
            else if ($("#txtUserDesc").val() == "") {
                strmsg = '- User Description should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            else if ($("#txtUserDesc").val() != "") {

                if (String($("#txtUserDesc").val()).length > 1000) {


                    strmsg = '- You Can Enter Only 1000 Character for User Story Description';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                //Added By Riddhesh Patil on 11-NOV-2022 
                else if (checkSpecialCharacter($("#txtUserDesc").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('User story Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtUserDesc").focus();
                    Flag = 1;
                    checkvalue = 1;
                }
                //End of Added By Riddhesh Patil
            }

            if ($("#cboPriority").val() == "") {
                strmsg = '- Priority should not be blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            //added by Dipali V On 24th  april 2018 For validation 
            if ($("#txtBusinessValue").val() != "") {

                if (RestrictNonNumeric(document.getElementById('txtBusinessValue')) == true) {


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
                    $("#txtBusinessValue").focus();

                }

            }

            if ($("#txtStoryPoint").val() != "") {

                if (RestrictNonNumeric(document.getElementById('txtStoryPoint')) == true) {


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
                //else if (checkSpecialCharacter($("#txtStoryPoint").val(), WebConfigSpecialCharacters) == true) {
                //    strmsg = 'Story point should not contain any of these ' + WebConfigSpecialCharacters + ' characters';
                //    errorMsg += "<li>" + strmsg + "</li></br>";

                //    // alertify.set('notifier', 'position', 'top-right');
                //    // alertify.error('Story point should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //    $("#txtStoryPoint").focus();
                //    Flag = 1;
                //    checkvalue = 1;
                //}
                //Added By Usha Pandit On 25.04.2020 For only allowing story point greater than 0
                else if (parseFloat($("#txtStoryPoint").val()) == 0) {
                    //alert('Please enter positive number');
                    strmsg = '- Please enter Story Point greater than 0';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                    $("#txtStoryPoint").focus();

                }
                //End Of Added By Usha Pandit On 25.04.2020 For only allowing story point greater than 0
                else {
                    var n = $("#txtStoryPoint").val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        strmsg = '- Please enter Story Points without decimal';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkvalue = 1;
                        $("#txtStoryPoint").focus();
                    }
                }
            }
            //End of added by Dipali V On 24th  april 2018 For validation 
            //if ($("#txtStoryPoint").val() != "")
            //{
            //    var ValueNumeric = $("#txtStoryPoint").val();
            //    var objRegex = /(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)|^([1-9][0-9]{0,2}|1000)$/;

            //    if (objRegex.test(ValueNumeric)) {
            //        //alert("Your Given Input \"" + ValueNumeric + "\" Is Not Correct.");
            //        strmsg = '- Please enter intger Value For Story Point between(1-999)';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        Flag = 1;
            //        checkvalue = 1;
            //        $("#txtStoryPoint").focus();
            //    }
            //    else {
            //        // alert("Your Given Input\"" + ValueNumeric + "\" Is Correct.");

            //    }

            //}


            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);
                Flag = 1;
                checkvalue = 1;
            }
                return checkvalue;
            
        }
        var ExistingUniqueNo = 0;
        var UniqueNo = 0;

        function SaveNew_UserStory() {
           
            objFunctionalNumber = document.getElementById("txtFunctionalNumber")
            objFeatureName = document.getElementById('txtFeatureName');
            objSpanFeatureName = document.getElementById('spanFeatureName');
            objUserDesc = document.getElementById('txtUserDesc');
            objSpanUserDesc = document.getElementById('spanUserDesc');
            objPriority = document.getElementById('cboPriority');
            objSpanPriority = document.getElementById('spanPriority');
            objComplexity = document.getElementById('cboComplexity');
            objSpanComplexity = document.getElementById('spanComplexity');
            objStoryPoint = document.getElementById('txtStoryPoint');
            spanStoryPoint = document.getElementById('spanStoryPoint');

            objBusinessValue = document.getElementById('txtBusinessValue');
            objState = document.getElementById('cboStateEdit');
            objCategory = document.getElementById('cboCategory');
            objVersion = document.getElementById('cboVersion');
            objIterationName = document.getElementById('cboIterationName');
            objReleaseName = document.getElementById('cboReleaseName');
            objlblFunctionalNumber = document.getElementById('lblFunctionalNumber');
            objFixedVersion = document.getElementById('cboFixedVersion');
            objAcceptanceCriteria = document.getElementById('txtAcceptanceCriteria');

            if (objFunctionalNumber == null) {
                objFunctionalNumber = ""
            }
            else {
                objFunctionalNumber = objFunctionalNumber.value;
            }

            if (objBusinessValue == null) {
                objBusinessValue = ""
            }
            else {
                objBusinessValue = objBusinessValue.value;
            }

            if (objState == null) {
                objState = ""
            }
            else {

                objState = objState.value;
            }

            if (objCategory == null) {
                objCategory = ""
            }
            else {
                objCategory = objCategory.value;
            }
            if (objVersion == null) {
                objVersion = ""
            }
            else {
                objVersion = objVersion.value;
            }
            if (objIterationName == null) {
                objIterationName = ""
            }
            else {
                objIterationName = objIterationName.value;
            }
            if (objReleaseName == null) {
                objReleaseName = ""
            }
            else {
                objReleaseName = objReleaseName.value;
            }
            if (objlblFunctionalNumber == null) {
                objlblFunctionalNumber = ""
            }
            else {
                objlblFunctionalNumber = objlblFunctionalNumber.value
            }
            if (objFixedVersion == null) {
                objFixedVersion = ""
            }
            else {
                objFixedVersion = objFixedVersion.value;
            }
            if (objAcceptanceCriteria == null) {
                objAcceptanceCriteria = ""
            }
            else {
                objAcceptanceCriteria = objAcceptanceCriteria.value;
            }


            if (objComplexity == null) {
                objComplexity = ""
            }
            else {
                objComplexity = objComplexity.value;
            }

            if (objPriority == null) {
                objPriority = ""
            }
            else {
                objPriority = objPriority.value;
            }

             
            
            GetExistingUniqueNumberFromDB(objComplexity, objPriority); // To get Already No. associate with userstory;
        }
        var Flag = "";
        function RefreshGrid(Flag) {
            //Added by Usha Pandit on 29 Apr 2019 for user story popup close crash            
            var UserStoryID = '';
            //End of Added by Usha Pandit on 29 Apr 2019 for user story popup close crash

            //Added BY Dipali V On 27th July 2018 For refresh Page
            if (Flag == "New") {
                var url = "frmSprintPlanning.aspx/RefreshGrid";
                var data = JSON.stringify({ UserStoryID: "" });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                //alert();
                BindGrid(strResult);
            }
            else {
                //Commented and Added by Usha Pandit on 29 Apr 2019 for user story popup close crash
                //if ($("#hdnglobalUSID").val() != "") {
                //    UserStoryID = $("#hdnglobalUSID").val();
                //}
                if ($("#hdnglobalUSID").val() != "" && $("#hdnglobalUSID").val() != undefined) {
                    UserStoryID = $("#hdnglobalUSID").val();
                }
                //End of Commented and Added by Usha Pandit on 29 Apr 2019 for user story popup close crash

                //Commented and Added by Usha Pandit on 19 Apr 2019 for user story popup close crash
                //if ($("#hdnIterationID").val() != "") {
                //    IterationID = $("#hdnIterationID").val();
                //}
                if ($("#hdnIterationID").val() != "" && $("#hdnIterationID").val() != undefined) {
                    IterationID = $("#hdnIterationID").val();
                }
                else {
                    IterationID = '';
                }
                //End of Commented and Added by Usha Pandit on 19 Apr 2019 for user story popup close crash

                //Commented and Added by Usha Pandit on 26 Mar 2019 for refresh tables
                //RefreshBothTable(UserStoryID, IterationID)

                if (UserStoryID == undefined)
                    UserStoryID = '';
                if ($("#hdnIterationID").val() == "") {
                    RefreshBothTable(UserStoryID, '')
                }
                else {
                    RefreshBothTable(UserStoryID, IterationID)
                }
                //End of Commented and Added by Usha Pandit on 26 Mar 2019 for refresh tables
            }
            //End of Added BY Dipali V On 27th July 2018 For refresh Page
            // }

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

        var IsFlagcountdownFN = 0;
        var IsFlagcountdownAC = 0;
        var IsFlagcountdownSummary = 0;
        var IsFlagSubus = 0;
        var IsFlag = 0;
        var IsFlagcountcountTaskNote = 0;
        var IsFlagcountcountTaskName = 0;
        function limitText(limitField, limitCount, limitNum) {
            // debugger;
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
                else if (limitCount.id == 'countdownBU') {
                    document.getElementById("countdownBU").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 200 Character', 'error', 5);
                }
                else if (limitCount.id == 'countSubUSdown') {
                    if (IsFlagSubus != 1) {
                        //Commented & Added By Dipali V On 6th April 2019 for Java script issue
                        //document.getElementById("countdownAC").style.color = 'red'
                        document.getElementById("countSubUSdown").style.color = 'red'//when Char 0 length  then Color red
                        //End of Commented & Added By Dipali V On 6th April 2019 for Java script issue
                        // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
                        IsFlagSubus = 1;
                        return IsFlagSubus;
                    }
                }
                else if (limitCount.id == 'countdownAC') {
                    document.getElementById("countdownAC").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanAcceptanceCriteria').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
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
                else if (limitCount.id == 'countTaskNote') {
                    if (IsFlagcountcountTaskNote != 1) {
                        document.getElementById("countTaskNote").style.color = 'red' //when Char 0 length  then Color red
                        // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 2000 Character', 'error', 5);
                        IsFlagcountcountTaskNote = 1;
                        return IsFlagcountcountTaskNote;
                    }
                }
                else if (limitCount.id == 'countTaskName') {
                    if (IsFlagcountcountTaskName != 1) {
                        document.getElementById("countTaskName").style.color = 'red' //when Char 0 length  then Color red
                        // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 255 Character', 'error', 5);
                        IsFlagcountcountTaskName = 1;
                        return IsFlagcountcountTaskName;
                    }
                }
                else {
                    document.getElementById("countdown").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanUserDesc').html("You Can Enter Only 1000 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
                }
            }
            else {
                if (limitCount.id == 'countdownBU') {
                    // document.getElementById("countdownBU").style.color = 'black'
                    // $('#spanBusinessValue').text("");
                }
                else if (limitCount.id == 'countdownAC') {
                    // document.getElementById("countdownAC").style.color = 'black'
                    // $('#spanAcceptanceCriteria').text("");
                }
                else {
                    // document.getElementById("countdown").style.color = 'black'
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
        function SelectPriorityColor(PriorityID) {

            var PriorityID = PriorityID.value;
            if (PriorityID != "") {
                var url = "frmSprintPlanning.aspx/GetPriorityColor";
                var data = JSON.stringify({ PriorityID: PriorityID });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                GetPriorityColor_Success(strResult);
            }
        }
        function SelectCategoryColor(categoryID) {

            var categoryID = categoryID.value;
            if (categoryID != "") {
                var url = "frmSprintPlanning.aspx/GetCategoryColor";
                var data = JSON.stringify({ categoryID: categoryID });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                GetCategoryColor_Success(strResult);
            }
        }
        function GetCategoryColor_Success(result) {
            var arrPriority = String(result.d).split("||")
            var cColor = arrPriority[0]
            var ChangeColorTD = arrPriority[1];
            $("#tblCategoryColor").html("")
            $("#tblCategoryColor").append(ChangeColorTD);
            $("#oColor").css("color", cColor)
        }

        var objComplexityTemp;
        var PriorityTemp;
        var strUserStoryId = "";
        function GetExistingUniqueNumberFromDB(objComplexity, Priority) {
            //debugger;
            objComplexityTemp = objComplexity;
            PriorityTemp = Priority;

            if (PriorityTemp != "") {
                var url = "frmSprintPlanning.aspx/GetExistingUniqueNumberFromDB";
                var data = JSON.stringify({ objComplexity: objComplexity, Priority: Priority, strUserStoryId: strUserStoryId });
                var strResult = ajaxCall(url, "POST", "application/json", "json", data);
                GetExistingUniqueNumberFromDB_Success(strResult);
            }
            else {
                if (SaveValidation() == 0) {
                    var ProjectId = document.getElementById('hdnProjectID').value;
                    var url = "frmSprintPlanning.aspx/SaveUserStory";
                    objPriority = document.getElementById('cboPriority');
                    if (ProjectId != "") {
                        if (objPriority != null)
                            var selectedText = objPriority.options[objPriority.selectedIndex].text;
                        //debugger;
                        if (objStoryPoint == null) {
                            objStoryPoint = ""
                        }
                        else {
                            objStoryPoint = objStoryPoint;
                        }

                        objIterationName = "";
                        //if (EditModeFlag == 1) {
                        //    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity.value, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                        //} else {
                        var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity.value, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                        //}
                        var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                        SaveSuccess(strUserResult)
                    }
                }
            }
        }

        function GetExistingUniqueNumberFromDB_Success(result) {

            ExistingUniqueNo = result.d;

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

            if (SaveValidation() == 0) {
                var ProjectId = document.getElementById('hdnProjectID').value;
                var url = "frmSprintPlanning.aspx/SaveUserStory";

                if (ProjectId != "") {

                    objPriority = document.getElementById('cboPriority');
                    if (objPriority != null)
                        var selectedText = objPriority.options[objPriority.selectedIndex].text;
                    if (objStoryPoint == null) {
                        objStoryPoint = ""
                    }
                    else {
                        objStoryPoint = objStoryPoint.value;
                    }
                    objIterationName = "";
                    //if (EditModeFlag == 1) {
                    //    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                    //} else {
                    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                    //}
                    var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                    SaveSuccess(strUserResult)
                }
            }
        }

        function GetComplexityUniqueNo(ExistingUniqueNo, objComplexity, Priority) {
            if (objComplexity == "High") {
                switch (Priority) {
                    case '1':
                        UniqueNo = '1.1.' + ExistingUniqueNo;

                        break;
                    case '2':
                        UniqueNo = '2.1.' + ExistingUniqueNo;
                        break;
                    case '3':
                        UniqueNo = '3.1.' + ExistingUniqueNo;
                        break;
                    case '4':
                        UniqueNo = '4.1.' + ExistingUniqueNo;
                        break;
                    default:
                }
            }
            else if (objComplexity == "Medium") {
                switch (Priority) {
                    case '1':
                        UniqueNo = '1.2.' + ExistingUniqueNo;
                        break;
                    case '2':
                        UniqueNo = '2.2.' + ExistingUniqueNo;
                        break;
                    case '3':
                        UniqueNo = '3.2.' + ExistingUniqueNo;
                        break;
                    case '4':
                        UniqueNo = '4.2.' + ExistingUniqueNo;
                        break;
                    default:
                }
            }
            else if (objComplexity == "Low") {
                switch (Priority) {
                    case '1':
                        UniqueNo = '1.3.' + ExistingUniqueNo;
                        break;
                    case '2':
                        UniqueNo = '2.3.' + ExistingUniqueNo;
                        break;
                    case '3':
                        UniqueNo = '3.3.' + ExistingUniqueNo;
                        break;
                    case '4':
                        UniqueNo = '4.3.' + ExistingUniqueNo;
                        break;
                    default:
                }
            }
            else {
                switch (Priority) {
                    case '1':
                        UniqueNo = '1.0.' + ExistingUniqueNo;
                        break;
                    case '2':
                        UniqueNo = '2.0.' + ExistingUniqueNo;
                        break;
                    case '3':
                        UniqueNo = '3.0.' + ExistingUniqueNo;
                        break;
                    case '4':
                        UniqueNo = '4.0.' + ExistingUniqueNo;
                        break;
                    default:
                }
            }

            return UniqueNo;
        }

        function SaveSuccess(result) {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('User Story Saved Successfully', 'success');
            //Commented and added by Usha Pandit on 06 June 2018 for User Story Popup display Issue 
            //$("#divProductBacklog").css("display", ""); 
            $("#divProductBacklog").modal('hide');
            //End of added by Usha Pandit on 06 June 2018 for User Story Popup display Issue 
            //Added BY Dipali V On 27th July 2018 For refresh Page

            if (result.d != "") {
                UserStoryID = result.d;
            }

            //Commented and Added by Usha Pandit on 18 Apr 2019 for user story save crash

            //if ($("#hdnIterationID").val() != "") {
            //    IterationID = $("#hdnIterationID").val();
            //}
            if ($("#hdnIterationID").val() != "" && $("#hdnIterationID").val() != undefined) {
                IterationID = $("#hdnIterationID").val();
            }
            else {
                IterationID = "";
            }
            //End of Added by Usha Pandit on 18 Apr 2019 for user story save crash

            //Commented and Added by Usha Pandit on 22 aug 2018 for refresh tables
            //RefreshBothTable(UserStoryID, IterationID)
            if ($("#hdnIterationID").val() == "") {
                RefreshBothTable(UserStoryID, '')
            }
            else {
                RefreshBothTable(UserStoryID, IterationID)
            }
            //End of Added by Usha Pandit on 22 aug 2018 for refresh tables

            //End of Added BY Dipali V On 27th July 2018 For refresh Page
            //RefreshFirstTable('close');
            common();
            //$("#divProductBacklog .modal-lg").css("width", "auto");
            //Commented By Dipali V On 26th April 2018 After creation of User story page should not redirect to user story details page
            // EditUserStory(result.d);
            //End of Commented By Dipali V On 26th April 2018 After creation of User story page should not redirect to user story details page
        }

        function NewAJAXCall(url, data, method) {
            $.ajax({
                type: "GET",
                url: url,
                async: false,
                success: function (result) {
                    console.log(result);
                    method(result);

                    //  Stop();
                },
                error: function (xhr, status, error) {
                    // Stop();
                    //  StopAjaxLoader("body");
                    console.log(xhr.responseText);
                    window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

        }

        //function Customfiled(obj) {
        //   // debugger;
        //    var tasktype = obj.value;
        //    var UserStoryId = $("#hdnusid").val();
        //    var url = "frmSprintPlanning.aspx?Mode=CustomField&UserStoryId=" + UserStoryId + "&TaskTypeID=" + tasktype
        //    data = JSON.stringify({ UserStoryId: UserStoryId, tasktype: tasktype });
        //    NewAJAXCall(url, data, PlotCustomFieldSuccess);

        //}

        var resultArr, Results;
        function PlotCustomFieldSuccess(result) {
            // alert(result.d);

            resultArr = result.split("####");
            document.getElementById('divCustomFields').innerHTML = "";
            document.getElementById('divCustomFields').innerHTML = resultArr[0];//Plotting

            // alert(resultArr[2]);
            var WholeScript = '';

            if (resultArr[0].indexOf("No Custom fields has be defined") == -1) {
                blnCustomFieldExists = true; // Added by Usha Pandit on 16 Feb 2018 for Custom Field Validation
            }

            document.getElementById('divGuidelines').innerHTML = "";
            document.getElementById('divGuidelines').innerHTML = resultArr[1];//Guidlines
            var WholeScript = '';


            var e = document.getElementById('MainScript');
            WholeScript += resultArr[2];
            if (e != null)
                e.innerHTML = '';
            e.innerHTML = '';
            //var script = "document.getElementById('btnSave').onclick = " + WholeScript + ""
            var script = WholeScript;
            //var script = "$('#btnSave').click(function (){  " + WholeScript + " SaveRequest_OnClick();  });"
            var newsc = script;
            //  alert(newsc);
            if (e != null)
                e.innerHTML = newsc;
            //  alert(e.innerHTML);
            if (e != null)
                $.globalEval(e.innerHTML);



            //var e = document.getElementById('MainScript');
            //WholeScript += resultArr[2];
            //if (e != null)
            //    e.innerHTML = '';

            //var script = "document.getElementById('btnSave').onclick = " + WholeScript + ""

            ////var script = "$('#btnSave').click(function (){  " + WholeScript + " SaveRequest_OnClick();  });"
            // var newsc = script;
            ////  alert(newsc);
            //if (e != null)
            //    e.innerHTML = newsc;
            ////  alert(e.innerHTML);
            //if (e != null)
            //    $.globalEval(e.innerHTML);

        }

        var newChartTab = "";
        var curTabClicked = '';      //Added by Usha Pandit on 07 Jun 2018 for highlighting selected tab only
        function EditUserStory(userStoryID, flag) {

            
            strUserStoryId = userStoryID
            var strResult = ajaxCall("frmSprintPlanning.aspx/GetUserStoryDetails", "POST", "application/json", "json", JSON.stringify({ UserStoryId: userStoryID }))
            $("#divProductBacklog_Body").html(strResult.d);

            //$('#[id*=SaveBtn]').prop("disabled", true);
            //$('#[id*=SaveBtn]').attr('disabled','disabled');
            if ($('#txtStartDate0').val()) {
                $("#txtStartDate0").prop('readonly', true);
            }

            if ($('#txtEndDate0').val()) {
                $("#txtEndDate0").prop('readonly', true);
            }
            // alert(strResult.d);
            AutoResizeTextArea();
            getRows();
            RemoveTextArea();
            //autosize(document.querySelectorAll('textarea'));
            //$('textarea').on('input', function () {
            //    $(this).css('height', "25px");
            //    $(this).css('height', this.scrollHeight + "px");
            //});
            //alert(1);
            //init();
            if ($('#txtReviewStartDate').val()) {
                $('#txtReviewStartDate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            }

            if ($('#txtReviewEnddate').val()) {
                $('#txtReviewEnddate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            }

            $("#divUserStroryDetails").css("height", window.innerHeight - 300 + 'px');
            //$('#divUserStroryDetails').css("height", (window.innerHeight / 2 + 'px'));
            $('#ulTabs li').click(function () {
                curTabClicked = $("a", this).attr("href");   //Added by Usha Pandit on 07 Jun 2018 for highlighting selected tab only
                $('#ulTabs li a').css("text-decoration", "none");
                $('#ulTabs li a').css("color", "");
                $("a", this).css("text-decoration", "underline");
                $("a", this).css("color", "#5bc0de");
            })
            $(".clsBox").hover(function () {
                //alert(1);
                //alert($(this).prop("id"));
                //$(".clsDiscussion").text($(this).attr("id") + " " + curTabClicked);
                if (curTabClicked == "#" + $(this).attr("id") || curTabClicked == '#frmDetails') {       //Added by Usha Pandit on 07 Jun 2018 for highlighting selected tab only

                    $('#ulTabs li a').css("text-decoration", "none");
                    $('#ulTabs li a').css("color", "");
                    $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
                    $("[href=#" + $(this).attr("id") + "]").css("color", "#5bc0de");
                }
            });
            //if (flag != undefined) {
            //    setTimeout(function () {
            //        $("[href=#" + flag + "]").click();
            //        var scrollPos = $("#" + flag + "").offset().top;
            //        $("#divUserStroryDetails").scrollTop(scrollPos - 250);
            //    }, 500)alert($('#SprintStartdate').val());
            //}
              //Change By Yasmin on 30-4-19
            if (Flag != undefined && Flag !="") {
                setTimeout(function () {
                    $("[href=#" + Flag + "]").click();
                    var widthAdd = 0;
                    var lengthPreDiv = $("#" + Flag + "").prevAll().length;
                    for (i = 0; i < lengthPreDiv; i++) {
                        widthAdd = widthAdd + parseInt($("#" + Flag + "").siblings().eq(i).height());
                    }
                    // var scrollPos = $("#" + Flag + "").offset().top;
                    // alert(scrollPos);
                    /*Changed By Yasmin On 10-04-19*/
                    //$("#sprint_details").css("top",currentScroll)
                    $("#sprint_details").scrollTop(widthAdd);

                }, 500)
            }
            $('.counter-count').each(function () {
                $(this).prop('Counter', 0).animate({
                    Counter: $(this).text()
                }, {
                        duration: 5000,
                        easing: 'swing',
                        step: function (now) {
                            $(this).text(Math.ceil(now));
                        }
                    });
            });


            newChartTab = $('#myScrollspy ul li').click(function () {

                newChartTab.removeClass('active');
                $(this).addClass('active');

            });

            $(".tabcontentChart").hover(function () {

                $('#myScrollspy ul li a').css("background-color", "white");
                $('#myScrollspy ul li a').css("color", "black");
                $("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
                $("[href=#" + $(this).attr("id") + "]").css("color", "white");

            });

            HighLightChart();


            makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                var output = document.querySelector('.demo-droppable');
                output.innerHTML = '';
                for (var i = 0; i < files.length; i++) {
                    arrFile[0] = files[i];
                    output.innerHTML += '<p>' + files[i].name + '</p>';
                }
            });
            //document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 200) + 'px'

            // $("#txtDiscussion").Editor();

            GetLineBurnUP(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
            GetLineBurnDown(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");

            GetLineBurnUPEffortS(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
            GetLineBurnDownStoryPoints(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");

            //GetLineVelocityEffortBar(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
            //GetLineVelocityStoryBar(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");

            //GetFlowEfforts(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
            //GetCompleteCancelSprintSprint(userStoryID, 'Cancel')
            //GetCompleteCancelSprintSprint(userStoryID, 'Complete')

           
            // datatables('DivHistorykList', 'txtSearchhistory', '');

            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterDivHistorykList").val() > 0) {
                datatables('DivHistorykList', 'txtSearchhistoryUS', '');

            }
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue

            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterDivReviewList").val() > 0) {
                datatables('DivReviewList', 'txtSearchReviews', '')

            }
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue


            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterDivSubTabIssuesList").val() > 0) {
                datatables('DivSubTabIssuesList', 'txtSearchIssue', '')
            }
                   //End of Added By Dipali V On 24th March 2023 For Datatable Issue
            //$("#divProductBacklog modal-lg").css("width", "auto");
            var projectid = $("#hdnProjectID").val();
            // debugger;
            IssueType_OnChange(projectid);
            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
            /*Added By Yasmin on 7-3-19*/
            if ($('#txtStartDate0').val()) {
                $("#txtStartDate0").prop('readonly', true);
            }
            if ($('#txtEndDate0').val()) {
                $("#txtEndDate0").prop('readonly', true);
            }
            if ($('#txtReviewStartDate').val()) {
                $("#txtReviewStartDate").prop('readonly', true);
            }
            if ($('#txtReviewEnddate').val()) {
                $("#txtReviewEnddate").prop('readonly', true);
            }
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
                //debugger;
                if (ele != null) {
                    var input = document.createElement('input');
                    input.setAttribute('type', 'file');
                
                   // input.setAttribute('multiple', true);
                    input.style.display = 'none';
                    input.addEventListener('change', function (e) {
                        triggerCallback(e, callback);
                    });
                    ele.appendChild(input);

                    ele.addEventListener('dragover', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        ele.classList.add('dragover');
                    });

                    ele.addEventListener('dragleave', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        ele.classList.remove('dragover');
                    });

                    ele.addEventListener('drop', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        ele.classList.remove('dragover');
                        triggerCallback(e, callback);
                    });

                    ele.addEventListener('click', function () {
                        input.value = null;
                        input.click();
                    });
                    ele.addEventListener('dragenter', function (event) {
                        if (event.preventDefault)
                            event.preventDefault();

                    });
                }
            }
            window.makeDroppable = makeDroppable;
        })(this);

        //Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
        function refreshTeams() {

            var strUserResult = ajaxCall("frmSprintPlanning.aspx/ShowTeams", "POST", "application/json", "json",
                JSON.stringify({ UserStoryID: $("#hdnusid").val() }));
            if (strUserResult != undefined) {
                if (strUserResult.d != '') {
                    $("#divResourceUS").html(strUserResult.d);
                }
            }
        }
        //End of Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation

        function RestrictNonNumeric(obj) {
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

        function EditUserStory1(userStoryID, flag) {
            
            $('#divProductBacklog').modal('show');
            $('#divProductBacklog').css('display', 'block');
            EditUserStory(userStoryID, flag);
            $('[data-bs-toggle="tooltip"]').tooltip();
            //$("#divProductBacklog .modal-lg").css("width", "auto");
            if ($('#dtStartDateAssigntask').val()) {
                $('#dtStartDateAssigntask').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            }
            if ($('#dtEndDateAssigntask').val()) {
                $('#dtEndDateAssigntask').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            }

            $('textarea').on('input', function () {
                $(this).css('height', "45px");
                $(this).css('height', this.scrollHeight + "px");
            });
            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
            //alert(1);
            //init();
        }



        //-------------Save Discussion Sprint Release -----------------
        var DiscussionID = 0;
        var strnewDiscussionID = "";
        function insertSprintReleaseDiscussion(UniqueID, Flag, obj, txtID) {
            // alert();

            //Added by Usha Pandit on 25.03.2019 for blank discussion validation
            if ($("#txtDiscussions").val() != "") {
                //End of Added by Usha Pandit on 25.03.2019 for blank discussion validation

                var strUserResult = ajaxCall("frmSprintPlanning.aspx/SaveDiscussionSR", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
                //alert(strUserResult.d);
                if (Flag != "UserStory") {
                    // var strDiscussionID =  $("#hdnstrDiscussionID").val();

                    // strnewDiscussionID =strDiscussionID - 1;
                    //  alert(strnewDiscussionID);
                    document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult.d;
                    $("#spanpost").html('');
                    //AutoResizeTextArea();

                    //RemoveTextArea();
                    $("#spanpost").html('Post');
                    // $("#SprintRelease").css("display","block");
                    $("#txtDiscussion").val('');
                    // debugger;
                    $("#collapse_" + strnewDiscussionID).addClass('in');
                    $("#collapse_" + strnewDiscussionID).focus();
                }
                else {
                    document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                    $("#btnSend").html('');
                    $("#btnSend").html('Post');
                    $("#DiscussionTextArea").val('');
                    $("#collapse_" + strnewDiscussionID).addClass('in');
                }

                //  $("#FreeTextBox_editor").html('');
                DiscussionID = 0;
                $('[data-bs-toggle="tooltip"]').tooltip();
                //Added by Usha Pandit on 25.03.2019 for blank discussion validation
            }
            else {
                $("#txtDiscussions").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Add Discussion', 'error', 25);
            }
            //End of Added by Usha Pandit on 25.03.2019 for blank discussion validation

        }
        function AddNewDiscussion(obj, textid) {
            // debugger;
            $("#" + textid).val("");
            $("#" + textid).focus();
        }
        function reply_onclickSR(userstoryID, discussionID, Flag) {
            // debugger;
            //AutoResizeTextArea();

            //RemoveTextArea();
            strnewDiscussionID = discussionID;
            if (Flag != "UserStory") {
                $("#txtDiscussions").focus();
                //Added by Usha Pandit On 28 March 2019 for Discussion placeholder
                //document.getElementById("txtDiscussions").placeholder = "Reply New Discussion";
                $("#txtDiscussions").prop("placeholder", "Reply to discussion");

                //End of Added by Usha Pandit On 28 March 2019 for Discussion placeholder
                $("#SprintReleaseAddDiscussion").removeAttr('disabled');
            }
            else {
                $("#DiscussionTextArea").focus();
            }

            // $("#FreeTextBox_editor").focus();
            if (Flag != "UserStory") {
                $("#spanpost").html('Reply');

            }
            else {
                $("#btnSend").html('Reply');
            }
            DiscussionID = discussionID;
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        function ShowMoreLessSR(discussionID, obj) {

            if (document.getElementById(discussionID).style.display == "none") {
                document.getElementById(discussionID).style.display = "block";
                obj.innerHTML = "Less"
            }
            else {
                document.getElementById(discussionID).style.display = "none";
                obj.innerHTML = "More"
            }
        }
        //----------------User story Discussion-------------------
        var DiscussionID1 = 0;
        var strnewDiscussionID1 = "";
        function insertUserStorytDiscussionUS(UniqueID, Flag, obj, txtID) {
            var diss1 = $('#' + txtID).val();
            var diss2 = $("#" + txtID).val();
            var strUserResult = ajaxCall("frmSprintPlanning.aspx/SaveDiscussionUS", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID1, Flag: Flag }));
            // alert(strUserResult.d);
            if (Flag == "UserStory") {
                // var strDiscussionID =  $("#hdnstrDiscussionID").val();

                // strnewDiscussionID1 =strDiscussionID - 1;
                //  alert(strnewDiscussionID1);
                document.getElementById("divDiscussionListUserStory").innerHTML = strUserResult.d;
                $("#spanpostUS").html('');
                $("#spanpostUS").html('Post');
                // $("#SprintRelease").css("display","block");
                $("#txtDiscussionus").val('');
                // debugger;
                $("#collapse_" + strnewDiscussionID1).addClass('in');
                $("#collapse_" + strnewDiscussionID1).focus();
            }
            else {
                document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                $("#btnSend").html('');
                $("#btnSend").html('Post');
                $("#DiscussionTextArea").val('');
                $("#collapse_" + strnewDiscussionID1).addClass('in');
            }

            //  $("#FreeTextBox_editor").html('');
            DiscussionID1 = 0;
            $('[data-bs-toggle="tooltip"]').tooltip();

        }

        function reply_onclickUS(userstoryID, discussionID1, Flag) {
            strnewDiscussionID1 = discussionID1;
            if (Flag == "UserStory") {
                $("#txtDiscussionsus").focus();
            }
            else {
                $("#DiscussionTextArea").focus();
            }

            // $("#FreeTextBox_editor").focus();
            if (Flag == "UserStory") {
                $("#spanpostUS").html('Reply');
            }
            else {
                $("#btnSend").html('Reply');
            }
            DiscussionID1 = discussionID1;
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        function AddNewDiscussionUS(obj, textid) {
            $("#" + textid).val("");
            $("#" + textid).focus();
        }

        function ShowMoreLessUS(discussionID1, obj) {
            if (document.getElementById(discussionID1).style.display == "none") {
                document.getElementById(discussionID1).style.display = "block";
                obj.innerHTML = "Less"
            }
            else {
                document.getElementById(discussionID1).style.display = "none";
                obj.innerHTML = "More"
            }
        }
        //-------------End Save Discussion -----------------
        //------------ Start Sub Stories -------------------

        function ShowData(type, WhichTab, Whichpage) {
            // debugger;
            if (Whichpage == 'UserStory') {
                if (WhichTab == 'SubUS') {
                    if (type == 'List') {
                        $("#divSubstoryList").css("display", "")
                        $("#divSubstoryForm").css("display", "none")
                    }
                    else if (type == "Form") {
                        $("#divSubstoryList").css("display", "none")
                        $("#divSubstoryForm").css("display", "")
                        $('#txtSubStoryName').val('');
                        $('#txtSubStoryDesc').val('');
                        $('#SubcboPriority').val('');

                        AutoResizeTextAreaforuserstories();

                        RemoveTextArea();
                    }
                }
                else if (WhichTab == 'subTask') {
                    if (type == 'List') {
                        $("#divTaskList11").css("display", "block")
                        /*Added By kashish for task detail page*/
                        $("#SaveBtn0").css("display", "inline-block");
                        $("#divtaskForm").css("display", "none")
                        $("#AssignSaveBtn0").css("display", "none");
                        AutoResizeTextArea();
                        RemoveTextArea();
                    }
                    else if (type == "Form") {
                        //$('#txtTaskName').val('');
                        //$('#cboresource').val('');
                        //$('#txtWork').val('');
                        //$('#txtStartDate').val('');
                        //$('#txtEnddate').val('');
                        //$('#cboPrioritytask').val('');
                        //$('#cboTtypetask').val('');
                        //$('#txtStoryPoints').val('');
                        $("#AssignSaveBtn0").css("display", "block");
                        $("#divtaskForm").css("display", "block")
                        //$("#divTaskList").css("display", "none") //comment by poonam s on 24/8/2018
                        $('#AssigntaskcboTaskType').val('');
                        $('#AssigntxtWorkHrs').val('');
                        $('#dtStartDateAssigntask').val('');
                        $('#dtEndDateAssigntask').val('');
                        $('#AssigntaskcboPriorities').val('');
                        $('#AssigntxtTaskName').val('');
                        $('#txtTaskNotes').val('');
                        $('#cboAssignResources').val('');
                        $('#chkBillable').prop("checked", "false");
                        $('#chkHold').prop("checked", false)

                        //  $("#divTaskList").css("display", "none") //comment by poonam s on 24/8/2018
                        $('#dtStartDateAssigntask').datepicker({
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        });
                        $('#dtEndDateAssigntask').datepicker({
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        });


                        //Added by Poonam S on 23/8/2018 for refresh grid
                        $("#divTaskList11").css("display", "none")

                        if ($("#divtaskForm").css("display") == "block") {

                            $("#divTaskList11").attr('display', 'none');

                            document.getElementById("divTaskList11").style.display = "none";

                        }
                        else {
                            $("#divTaskList11").css("display", "none")


                        }
                        //Ended by Poonam S on 23/8/2018 for refresh grid
                    }
                }
                else if (WhichTab == 'subIssue') {
                    if (type == 'List') {
                        $("#divIssuesList").css("display", "")
                        $("#divIssueForm").css("display", "none")
                    }
                    else if (type == "Form") {
                        $("#txtSummary").val('')
                        $("#txtDescription").val('')
                        $("#cboIssueType").val('')
                        $("#cboSubIssueType").val('')
                        $("#cboreporter").val('')
                        $("#cboResonsible").val('')
                        $("#cboStatus").val('')
                        // ID = ' txtReported'
                        // timeNow(ID);
                        $("#divIssuesList").css("display", "none")
                        $("#divIssueForm").css("display", "")
                        AutoResizeTextArea();
                        RemoveTextArea();
						// GetSelectedSubtype();
                //Added by Dipali V On 25th June 2020 For  Get Default values
                //GetSelectedSubtype()

                        GetDefaultValues();
                        GetSelectedSubtype(document.getElementById("cboIssueType"));                    
                    }
                }
                else if (WhichTab == 'subReview') {
                    if (type == 'List') {
                        $("#divReviewList").css("display", "")
                        $("#divReviewForm").css("display", "none")
                    }
                    else if (type == "Form") {
                        $('#txtReviewtitle').val('');
                        $('#cboReviewtype').val('');
                        $('#txtReviewStartDate').val('');
                        $('#txtReviewEnddate').val('');
                        $('#cboReviewer').val('');
                        $('#hdnReviwerID').val('');
                        $('#txtReviewHrs').val('');
                        $('#cboRevieStatus').val('');
                        $('#cboTtypetask').val('');
                        $('#cboReviewee').val('');
                        ResoureIDs = "";
                        Reviwers = "";
                        // timeNow(ID);
                        $("#divReviewList").css("display", "none")
                        $("#divReviewForm").css("display", "")

                        $(".k-checkboxcboReviewer").each(function () {
                            $(this).prop('checked', false);
                        });

                        $(".k-checkbox").each(function () {
                            $(this).prop('checked', false);
                        });

                        // alert();
                        $('#cboReviewer').val($("#hdnstrUserName").val());

                    }
                }
            }
        }

        var strFlag = "";
        var ID = 0;
        function Save_SubTab_Data(UserStoryID, SubTabFlag, ID) {

            //  alert(ID);
            var objComplexity = document.getElementById("cboComplexity");
            var objPriority = document.getElementById("cboPriority");


            if (SubTabFlag == "SubStory") {

                //Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting
                var objSubComplexity = document.getElementById("SubcboComplexity");
                var objSubCategory = document.getElementById("SubcboCategory");
                //End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting


                var checkFlag = 0;
                var objSubStoryName, objSubStoryDesc;
                var selectedText = ""
                objSubStoryName = $('#txtSubStoryName');
                objSubStoryDesc = $('#txtSubStoryDesc');



                var checkFlag = 0;
                var Flag = 0;
                var strmsg = "";
                var errorMsg = "<ul>"
                if ($("#txtSubStoryName").val() == "") {
                    strmsg = '- Sub User Story name should not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkFlag = 1;
                }
                //Added By Riddhesh Patil on 11-NOV-2022 
                else if ($("#txtSubStoryName").val() != "") {
                    if (checkSpecialCharacter($("#txtSubStoryName").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('User Story should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtSubStoryName").focus();
                        Flag = 1;
                        checkvalue = 1;
                    }
                }
        //End of Added By Riddhesh Patil
                if ($("#txtSubStoryDesc").val() == "") {
                    strmsg = '- Sub User Story Description should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkFlag = 1;
                    $("#txtSubStoryDesc").focus();
                }
                //Added By Riddhesh Patil on 11-NOV-2022 
                else if ($("#txtSubStoryDesc").val() != "") {
                    if (checkSpecialCharacter($("#txtSubStoryDesc").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(' User Story Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtSubStoryDesc").focus();
                        Flag = 1;
                        checkvalue = 1;
                    }
                }
        //End of Added By Riddhesh Patil
                if (document.getElementById("txtSubStoryDesc").value.length > 2000) {
                    strmsg = '- Sub User Story Description should not be greater than 2000 characters.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkFlag = 1;
                    $("#txtSubStoryDesc").focus();
                    // $("#spanSubStoryDesc").html("Sub User Story Description should not greater than 2000 characters. You have entered " + document.getElementById("txtSubStoryDesc").value.length + " characters.");

                }

                if ($("#SubcboPriority").val() == "") {
                    strmsg = '- Priority should not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkFlag = 1;
                    $("#SubcboPriority").focus();
                }

                else {
                    selectedText = document.getElementById("SubcboPriority").options[document.getElementById("SubcboPriority").selectedIndex].text;
                    //alert(selectedText);
                }
                if (checkFlag == 1) {
                    if (strmsg != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(errorMsg, 'error', 5);

                    }
                    return;
                }

                var objPriority = document.getElementById("SubcboPriority");

                var objComplexityTemp;
                var PriorityTemp;
                if (objComplexity != null)
                    objComplexityTemp = objComplexity.value;
                else
                    objComplexityTemp = '';
                PriorityTemp = objPriority.value;

                var url1 = "frmSprintPlanning.aspx/GetExistingUniqueNumberFromDB";
                var data1 = JSON.stringify({ objComplexity: objComplexityTemp, Priority: objPriority.value, strUserStoryId: UserStoryID });
                var result1 = ajaxCall(url1, "POST", "application/json", "json", data1, false);
                ExistingUniqueNo = result1.d;

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


                //Commented and Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting
                //var data = JSON.stringify({ UserStoryID: UserStoryID, SubStoryName: objSubStoryName.val(), SubStoryDesc: objSubStoryDesc.val(), strPriority: selectedText, strRank: UniqueNo });
                var data = JSON.stringify({ UserStoryID: UserStoryID, SubStoryName: objSubStoryName.val(), SubStoryDesc: objSubStoryDesc.val(), strPriority: selectedText, strRank: UniqueNo, Complexity: objSubComplexity.value, Category: objSubCategory.value });
                //End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

                var result = ajaxCall("frmSprintPlanning.aspx/SaveSubStories", "POST", "application/json", "json", data);
                document.getElementById("divSubstoryList").innerHTML = result.d;
                $('#txtSubStoryName').val('')
                $('#txtSubStoryDesc').val('')
                $('#SubcboPriority').val('')
                ShowData('List', 'SubUS', 'UserStory');
                var strUserResult = ajaxCall("frmSprintPlanning.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
                //Commented and Added by Usha Pandit on 10.05.2019 for null getting display on div
                //document.getElementById("divUserStories").innerHTML = strUserResult.d;
                if (strUserResult != undefined) {
                    if (strUserResult.d != null && strUserResult.d != undefined) {
                        document.getElementById("divUserStories").innerHTML = strUserResult.d;
                    }
                }
                //End of Added by Usha Pandit on 10.05.2019 for null getting display on div

                //added By Dipali V On 30th Mach 2018 For Sub Us Creation
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sub User Story Created successfully', 'success', 5);
                //added by dipali V on 6th May 2019 For Javascript issue
                if (document.getElementById("leftTree") != undefined || document.getElementById("leftTree") != null) {
                    document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
                }
                //End of added by dipali V on 6th May 2019 For Javascript issue
                $('[data-bs-toggle="tooltip"]').tooltip();
                //End of added By Dipali V On 30th Mach 2018 For Sub Us Creation
            }
            else if (SubTabFlag == "Issue") {
                if (validateissue() == 0) {

                    //debugger
                    var Summary = $("#txtSummary").val()
                    var Description = $("#txtDescription").val()
                    var IssueType = $("#cboIssueType").val()
                    var SubIssueType = $("#cboSubIssueType").val()
                    var reporter = $("#cboreporter").val()
                    var Resonsible = $("#cboResonsible").val()
                    var Status = $("#cboStatus").val()
                    var data = JSON.stringify({
                        UserStoryId: strUserStoryId,
                        Summary: Summary,
                        Description: Description,
                        IssueType: IssueType,
                        SubIssueType: SubIssueType,
                        reporter: reporter,
                        Resonsible: Resonsible,
                        Status: Status

                    });
                    var result = ajaxCall("frmProductBacklog.aspx/SaveUSIssue", "POST", "application/json", "json", data);
                    if (result.d != "") {
                        document.getElementById("divIssuesList").innerHTML = result.d;
                        $("#txtSummary").val('')
                        $("#txtDescription").val('')
                        $("#cboIssueType").val('')
                        $("#cboSubIssueType").val('')
                        $("#cboreporter").val('')
                        $("#cboResonsible").val('')
                        $("#cboStatus").val('')
                        document.getElementById("txtSummary").style.height = "50px";
                        document.getElementById("txtDescription").style.height = "50px";
                        $("#countdownSummary").text(500);
                        $("#countdownSummary").css("color", "black");
                        $("#countdownDescription").text(1000);
                        ShowData('List', 'subIssue', 'UserStory');
                       
                        //Added By Dipali V On 24th March 2023 For Datatable Issue
                        if ($("#FilterDivSubTabIssuesList").val() > 0) {
                            datatables('DivSubTabIssuesList', 'txtSearchIssue', '')
                        }
                       //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                        // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
                        // document.getElementById("divUserStories").innerHTML = strUserResult.d;
                        //added By Dipali V On 30th Mach 2018 For Sub Us Creation
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Issue Created successfully', 'success', 5);
                        // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
                        $('[data-bs-toggle="tooltip"]').tooltip();
                    }
                }

            }
            else if (SubTabFlag == "Task") {
                // alert(ID);
                if (validateTask(ID) == 0) {
                    // if (ID != 0) {

                    //debugger;
                    saveFlag = 1;
                    if (saveFlag == 1) {

                        $("#SaveBtn0").css("display", "none");

                    }
                    var htRowCount = document.getElementsByName("hdrownumber");
                    for (var i = 0; i < htRowCount.length; i++) {
                        if (htRowCount[i] != null) {

                            var objTaskName = $('#txtTaskName' + htRowCount[i].value);
                            var objResource = $('#cboresource' + htRowCount[i].value);
                            var objTaskType = $('#cboTaskType' + htRowCount[i].value).val();
                            var StoryPoints = $('#txtStoryPoints' + htRowCount[i].value).val();
                            var objWorkHrs = $('#txtWorkHrs' + htRowCount[i].value);
                            var objStartDate = $('#txtStartDate' + htRowCount[i].value);
                            var objEndDate = $('#txtEndDate' + htRowCount[i].value);
                            // alert(objTaskType);
                            //  cboresource
                            var objPriorities = "";
                            //var objTaskType = "";
                            // var StoryPoints = ""
                            var BillableValue, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;


                            var PracticeID = 0;
                            var extraPara = [];
                            extraPara.push(htRowCount[i].value);
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


                        var URL, data;



                        URL = 'frmSprintPlanning.aspx/SaveTask';

                        var AssignTaskData = [];

                        AssignTaskData.push({
                            TaskID: 0,
                            TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                            Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                            MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: $("#hdnProjectID").val(), PracticeID: PracticeID,
                            UserStoryID: strUserStoryId, strEntity: "", StoryPoints: StoryPoints
                        });

                        data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: strUserStoryId, });
                        // alert(data)
                        AJAXCallWithPara(URL, data, AfterSaveTask, extraPara);
                    }


                    $('#txtStartDate0,#txtEndDate0').prop('readonly', true);

                }


                // }

            }

            else if (SubTabFlag == "Review") {

                if (validateReview() == 0) {

                    // var ResoureallIDs;
                    var ReviewID = "0";
                    var Reviewtitle = $('#txtReviewtitle').val();
                    var Reviewtype = $('#cboReviewtype').val();
                    var ReviewStartDate = $('#txtReviewStartDate').val();
                    var ReviewEnddate = $('#txtReviewEnddate').val();
                    // var Reviewer = $('#cboReviewer option:selected').text();
                    var Reviewer = $('#cboReviewer').val();

                    var reviewstatus = $('#cboRevieStatus').val();
                    var objTaskType = $('#cboTtypetask').val();
                    var Reviewee = $('#cboReviewee').val();
                    // var Reviewee = $('#cboReviewee option:selected').text();
                    var RevieweeWork = $('#txtReviewHrs').val();

                    var RevieweeActualfrom = "";
                    var RevieweeActualto = "";

                    var ReviewPhase = "";
                    var defects = "";
                    var per = "";
                    var unit = "";
                    var reviewnote = "";
                    //var reviewstatus = "";
                    var billable;
                    var billable = "0"
                    var workproduct = "";
                    var workproductname = "";
                    var conculsion = "";
                    var Delivariables = "";

                    var Requestor = "";
                    var Coordinator = "";
                    var method = "";
                    var Deviation = "";
                    var Completion = "";
                    var Disposition = "";
                    var Checklist = $("#cboChecklist").val();

                    if (RevieweeWork == "") {

                        RevieweeWork = 0;


                    }
                    else {
                        RevieweeWork = RevieweeWork;


                    }
                    //if (ReviewerIDs == "") {
                    //    ReviewerIDs = 0;
                    //}
                    //else {

                    //    var ReviewerIDs = $("#ReviewerIDs" + EntityID).val();
                    //    var RevieweeIDs = $("#RevieweeIDs" + EntityID).val();
                    //    //alert(ReviewerIDs);
                    //}
                    // var ResoureIDs = "";
                    var ModuleID = "";
                    var offline = "";
                    if (Reviewee == null)
                        Reviewee = ""

                    else {
                        offline = "0"
                    }
                    // StartLoader("CreateEditView");
                    var MileStone = "";
                    var ProjectID = "";
                    // StartLoader("CreateEditView");
                    var MileStone = "";
                    //alert(ResoureIDs);
                    //  alert(Reviwers);
                    var url = "frmProductBacklog.aspx/SaveReviewDetails";

                    var data = JSON.stringify({
                        ReviewID: ReviewID, Reviewtype: Reviewtype, Reviewtitle: Reviewtitle,
                        Reviewer: String(Reviwers),
                        offline: offline, Reviewee: String(ResoureIDs),
                        ReviewPlanned: ReviewStartDate, ReviewPlannedto: ReviewEnddate,
                        RevieweeWork: RevieweeWork, RevieweeActualfrom: RevieweeActualfrom,
                        RevieweeActualto: RevieweeActualto, ReviewPhase: ReviewPhase,
                        Delivariables: Delivariables, ModuleID: ModuleID,
                        defects: defects, per: per, unit: unit, reviewnote: reviewnote,
                        reviewstatus: reviewstatus, billable: billable, workproduct: workproduct,
                        workproductname: workproductname, conculsion: conculsion, Requestor: Requestor,
                        Coordinator: Coordinator, method: method, Deviation: Deviation, Completion: Completion,
                        Disposition: Disposition, Checklist: Checklist, MileStone: MileStone,
                        strEntityID: strUserStoryId, strEntity: ""
                    })


                    //StartLoader("#projectrisk")
                    var result = AJAXCallWithResult(url, data, false);
                    // var strResult = String(result.d).split("||");divReviewList
                    var strResult = String(result.d)

                    if (strResult != '') {
                        document.getElementById('divReviewList').innerHTML = "";
                        document.getElementById('divReviewList').innerHTML = result.d;
                        $('#txtReviewtitle').val('');
                        $('#cboReviewtype').val('');
                        $('#txtReviewStartDate').val('');
                        $('#txtReviewEnddate').val('');
                        $('#cboReviewer').val('');
                        $('#cboRevieStatus').val('');
                        $('#cboTtypetask').val('');
                        $('#cboReviewee').val('');
                        $('#hdnReviwerID').val('');
                        $('#txtReviewHrs').val('');

                        ShowData('List', 'subReview', 'UserStory');
                      
                        //Added By Dipali V On 24th March 2023 For Datatable Issue
                        if ($("#FilterDivReviewList").val() > 0) {
                            datatables('DivReviewList', 'txtSearchReviews', '')
                        }
                       //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                        $('#txtReviewStartDate').datepicker({
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        });
                        $('#txtReviewEnddate').datepicker({
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        });
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Review Created successfully', 'success', 5);
                        // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
                        $('[data-bs-toggle="tooltip"]').tooltip();
                    }
                    //if (strResult.length > 0) {
                    //    if (strResult.length == 1) {
                    //        document.getElementById("SpnMainReview" + EntityID).innerHTML = strResult[0];
                    //    }
                    //    else {
                    //        document.getElementById("SpnMainReview" + EntityID).innerHTML = strResult[0];
                    //        document.getElementById("SpnMainReview" + strResult[1]).innerHTML = strResult[2];
                    //    }
                    //}
                    // StopAjaxLoader("CreateEditView")
                }




            }
            //Added by Usha Pandit on 21 Aug 2018 for refresh grid if changes made
            Refresh_Sprint();
            //End of Added by Usha Pandit on 21 Aug 2018 for refresh grid if changes made
        }
        function Delete_UserStory(taskID, Flag) {
            //debugger;
            var UserStoryID = taskID;



            var url = "frmSprintPlanning.aspx/DeleteEntryValidation";
            var data = JSON.stringify({ UserStoryID: UserStoryID });
            var para = []
            para.push(UserStoryID, Flag)
            var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
            DeleteEntrySuccess(strUserResult, para)
        }


        function DeleteEntrySuccess(result, para) {

            if (result.d == "0") {
                // alert(result.d);
                var url = "frmSprintPlanning.aspx/DeleteEntry";
                var data = JSON.stringify({ UserStoryID: para[0], Flag: para[1] });
                var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);

                if (para[1] == "SubUS") {
                    BindSubGrid(strUserResult)
                }
                else {
                    RefreshBothTable(para[0], $("#hdnIterationID").val());
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('User Story Deleted Successfully', 'success', 5);
                    $("#divProductBacklog").modal('hide');
                    RefreshGrid();
                }
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Following User Story is in use.You can not delete this user story', 'error', 5);
                // var r = confirm(result.d);
                //if (r == true) {
                //    var url = "frmProductBacklog.aspx/DeleteEntry";
                //    var data = JSON.stringify({ UserStoryID: para[0] });
                //    var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                //    BindGrid(strUserResult)
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify('User Stories Deleted Successfully', 'success', 20);
                //} else 
                //{
                return
                // }
            }

        }

        var isValid = 0; saveFlag = 0;
        function validateAssignFormTask() {

            var checkFlag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var dtAssignStartDate = "", dtAssignEndDate = "";
            var ProjectID = document.getElementById('hdnProjectID').value;

            dtAssignStartDate = document.getElementsByName("dtStartDateAssigntask");
            dtAssignEndDate = document.getElementsByName("dtEndDateAssigntask");

            if ($("#AssigntxtTaskName").val() == "") {
                strmsg = '- Task Name should not be left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#AssigntxtTaskName").focus();
            }

            /*Added by kashish for task detail issue fixing on 22-8-2018*/
            if ($("#cboAssignResources").val() == "") {
                strmsg = '- Resource should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboAssignResources").focus();
            }


            if ($("#AssigntxtWorkHrs").val() == "") {
                strmsg = '- Work(Hrs) should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#AssigntxtWorkHrs").focus();
            }

              if ($("#dtStartDateAssigntask").val() != '' && $("#dtEndDateAssigntask").val() != '' && checkFlag == 0) {
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

            //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 
            //if ($("#AssigntxtWorkHrs").val() != "") {
            //    if (RestrictNonNumeric(document.getElementById('AssigntxtWorkHrs')) == true) {


            //        strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        isValid = 1;
            //        checkFlag = 1;
            //    }

            //    else if (($("#AssigntxtWorkHrs").val() - 0) == 0) {

            //        strmsg = '- Please Enter Work(Hrs) greater than 0';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        isValid = 1;
            //        checkFlag = 1;

            //    }

            //    else if (parseFloat($("#AssigntxtWorkHrs").val()) < 0 && $("#AssigntxtWorkHrs").val() != '') {

            //        strmsg = '- Please enter positive Value For  Work(Hrs)';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        isValid = 1;
            //        checkFlag = 1;
            //        $("#AssigntxtWorkHrs").focus();

            //    }


            //}


            if ($("#AssigntxtWorkHrs").val() != "" && checkFlag == 0) {
                try {
                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("AssigntxtWorkHrs");
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    if (objHMEffort.value.indexOf(":") == -1) {
                        //strmsg = 'Please enter efforts in valid format hh:mm!!';
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
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        objHMEffort.value = objVal;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    //if (blnResult == true) {
                    //    isValid = 1;
                    //    checkFlag = 1;
                    //}

                    //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById("AssigntxtWorkHrs")) == true) {
                            strmsg = 'Please enter Work(Hrs) in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            objHMEffort.value = objVal;
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }
                    //if (blnResult == true) {
                    //    isValid = 1;
                    //    checkFlag = 1;
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
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = 'Hours should not be less than or equal to zero (0).';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = 'Please enter minutes in two decimal and less than 60.';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = 'Please enter minutes between (0-59) range';
                                errorMsg += "<li>" + strmsg + "</li></br>";
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
            }
            //End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 



            if ($("#dtStartDateAssigntask").val() == "") {
                strmsg = '- Start Date should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#dtEndDateAssigntask").val() == "") {
                strmsg = '- End Date should not be left blank';
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
            //debugger;
          

            //Commented and Added by Usha Pandit on 06.06.2019 for sprint start date and end date validation

            //if (checkFlag == 0) {
            //    var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#dtStartDateAssigntask").val(), EndDate: $("#dtEndDateAssigntask").val() });
            //    var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

            //    if (Newresult.d != '') {
            //        var arrResult = Newresult.d.split('##');

            //        if (arrResult[0] == '1') {


            //            strmsg = '-' + arrResult[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";
            //            isValid = 1;
            //            checkFlag = 1;
            //        }
            //        if (arrResult[0] == '2') {
            //            strmsg = '-' + arrResult[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";
            //            isValid = 1;
            //            checkFlag = 1;
            //        }

            //        //if (arrResult[0] == '3') {
            //        //    strmsg = '-' + arrResult[1];
            //        //    errorMsg += "<li>" + strmsg + "</li></br>";
            //        //    isValid = 1;
            //        //    checkFlag = 1;
            //        //}
            //    }

            //}



            //if ($("#dtEndDateAssigntask").val() != '') {
            //    var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: $("#dtStartDateAssigntask").val(), strEndDate: $("#dtEndDateAssigntask").val() }), false);
            //    if (result.d != "") {
            //        var strMsg = String(result.d).split("_");
            //        if (strMsg[0] == "1") {
            //            // $('#spndtStartDate').text(strMsg[1]);
            //            strmsg = '- ' + strMsg[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";

            //        }
            //        else {
            //            //$('#spndtEndDate').text(strMsg[1]);
            //            strmsg = '- ' + strMsg[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";

            //        }
            //        isValid = 1;
            //        checkFlag = 1;
            //    }
            //}

            if ($("#dtEndDateAssigntask").val() != '' && checkFlag == 0) {
                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: $("#dtStartDateAssigntask").val(), strEndDate: $("#dtEndDateAssigntask").val() }), false);
                if (result.d != "") {
                    var strMsg = String(result.d).split("_");
                    if (strMsg[0] == "1") {
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    else {
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
                }

            }            

            //End of Added by Usha Pandit on 06.06.2019 for sprint start date and end date validation

            if ($("#AssigntaskcboPriorities").val() == "") {
                strmsg = '- Priority should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#AssigntaskcboTaskType").val() == "") {
                strmsg = '- Task Type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#cboUserStory").val() == "") {
                strmsg = '- User Story should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }


            if ($("#AssigntxtStoryPoints").val() != "") {
                if (RestrictNonNumeric(document.getElementById('AssigntxtStoryPoints')) == true) {


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


                    var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#AssigntxtStoryPoints").val(), TaskID: "" });
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
                        //  objPhase1.css('border-color', 'red');
                        // objPhase1.css('border-width', '1px');
                        // $('#spnPhase').text('Phase should not left blank !');
                        strmsg = '- Phase should not be left blank.'
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

                        strmsg = '- Module should not be left blank.'
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
                        strmsg = '- Sub Project should not be left blank.'
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
                        strmsg = '- Milestone should not be left blank.'
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
                        strmsg = '- Change Request should not be left blank.'
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
        function SaveAssignTask(USID) {
            if (validateAssignFormTask() == 0) {

                saveFlag = 1;
                if (saveFlag == 1) {

                    $("#AssignSaveBtn0").css("display", "none");

                }
                var TaskID = 0;
                var BillableValue, StoryPoints, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;
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

                if (objHold[0].checked == true) {
                    OnHoldValue = "1"
                }
                else {
                    OnHoldValue = "0"
                }




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


                var URL, data;



                URL = 'frmSprintPlanning.aspx/SaveTask';

                var AssignTaskData = [];

                AssignTaskData.push({
                    TaskID: TaskID,
                    TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                    Priority: objPriorities.val(), TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                    MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: $("#hdnProjectID").val(), PracticeID: PracticeID,
                    UserStoryID: USID, strEntity: "", StoryPoints: StoryPoints
                });

                data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: USID, });
                //alert(data)
                AJAXCallWithPara(URL, data, AfterSaveTask, extraPara);

                //Added by Usha Pandit on 21 Aug 2018 for refresh grid if changes made
                Refresh_Sprint();
                //End of Added by Usha Pandit on 21 Aug 2018 for refresh grid if changes made

            }


        }





        function AfterSaveTask(data, extraPara) {
            var Id = extraPara[0];

            var strProjectID = document.getElementById('hdnProjectID').value;
            document.getElementById("divTasksUS").innerHTML = data.d;
            $('#AssignSaveBtn0').hide();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Created successfully', 'success', 5);
            // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            isValid = 0;
            saveFlag = 0;
            //$("#AssignSaveBtn0").css("display", "block");
            /*Added By kashish for task detail page*/
            $("#SaveBtn0").css("display", "inline-block");
            $('#txtEndDate' + Id).datepicker();
            $('#txtStartDate' + Id).datepicker();

            $('#txtEndDate' + Id).datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                 yearRange: 'c-100:c+100'
                 //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtStartDate' + Id).datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('[data-bs-toggle="tooltip"]').mouseout(function () {
                $('.tooltip').fadeOut('fast', function () {

                    $('.tooltip').remove();
                });
            });
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('.tooltip').fadeOut('fast', function () {
                    $('.tooltip').remove();
                });
            });
            $('[data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover'
            });
            $('#txtStartDate0,#txtEndDate0').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $('#txtStartDate0,#txtEndDate0').prop('readonly', true);
            $('#txtStartDate' + Id).prop('readonly', true);
            $('#txtEndDate' + Id).prop('readonly', true);
        }

        function DeleteEntry() {



        }
        function ShowHide_SectionTR() {
            // alert(isValid)
            // alert(saveFlag)

            //Commented by kashish for task detail issue fixing on 20-8-2018
            //if (isValid == 0) {



            validateTask(0);

            //}
        }
        function BindGrid(result) {
            // var MainResult = result.d.split("||");

            //document.getElementById("divGrid").innerHTML = "";MainDiv2
            //  alert(result.d);

            if (result != undefined) {
                document.getElementById("MainDiv2").innerHTML = result.d;//DivmainRight
                if (display == "none")
                    $("#icnShow").click();

                //  document.getElementById("divSubstoryList").innerHTML = result.d;
                SetWidthHeight();
                $(".attachment").tooltip();
                $(".discussion").tooltip();
                $(".issue").tooltip();
                $(".details").tooltip();
                $(".charts").tooltip();
                $(".priority").tooltip();
                $(".drag").tooltip();
                $(".story_point").tooltip();
                $(".view_story").tooltip();
                $(".delete_story").tooltip();
                $(".user_story").tooltip();
                $(".rank").tooltip();
                $(".issue").tooltip();
                $(".user-story-description").tooltip();
                $(".fa-ellipsis-h").tooltip();
                $('[data-bs-toggle="tooltip"]').tooltip();


                //Added By Kashish on 24 july 2018 for task detail  issue fixing
                tooltipShow();
            }
            var display = $("#icnShow").parent().parent().css("display");
            $("#divProductBacklog").modal('hide');
            // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'
            // $("#divUS").modal('hide');

        }

        function BindSubGrid(result) {

            document.getElementById("divSubstoryList").innerHTML = "";
            document.getElementById("divSubstoryList").innerHTML = result.d;
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('User Stories Deleted Successfully', 'success', 5);


        }



        function TaskReFresh() {

            URL = 'frmSprintPlanning.aspx/RefereshTask';

            data = JSON.stringify({ UserStoryId: strUserStoryId, });
            AJAXCallWithPara(URL, data, AfterClickTask, "");
            //$('#txtEndDate').datepicker();
            //$('#txtStartDate').datepicker();
            //$('#txtEndDate0').datepicker();
            //$('#txtStartDate0').datepicker();
            $('#txtStartDate0,#txtEndDate0').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $("#txtStartDate0").prop('readonly', true);
            $("#txtEndDate0").prop('readonly', true);
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
        }


        function AfterClickTask(data) {


            var strProjectID = document.getElementById('hdnProjectID').value;
            document.getElementById("divTasksUS").innerHTML = data.d;
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            //$('#txtEndDate').datepicker();
            //$('#txtStartDate').datepicker();
            ///*Added by kashish for task detail issue fixing on 22-8-2018*/
            //$('#txtEndDate0').datepicker();
            //$('#txtStartDate0').datepicker();
            $('#txtStartDate,#txtEndDate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $('#txtStartDate0,#txtEndDate0').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $('#txtStartDate,#txtEndDate').prop('readonly', true);
            $("#txtStartDate0").prop('readonly', true);
            $("#txtEndDate0").prop('readonly', true);
            isValid = 0;
            saveFlag = 0;


        }


        var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
        var isValidTypeExeCheckFlag = false;
        async function UploadData(userStoryID) {
            // debugger;
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
               // const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
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
                                alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
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

            if (arrFile[0] != undefined) {
                var formdata = new FormData();
                formdata.append('file', arrFile[0]);
                formdata.append('Mode', 'Upload');
                formdata.append('UserStoryID', userStoryID);
                $.ajax({
                    type: 'post',
                    url: 'frmProductBacklog.aspx',
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
                            document.getElementById("divAttachmentList").innerHTML = status;
                            $('[data-bs-toggle="tooltip"]').tooltip();

                            makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                                var output = document.querySelector('.demo-droppable');
                                output.innerHTML = '';
                                for (var i = 0; i < files.length; i++) {
                                    arrFile[0] = files[i];
                                    output.innerHTML += '<p>' + files[i].name + '</p>';
                                }
                            });

                            // $('.radio-inline').tooltip()
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
        var strUser = '';
        function Delete_Attachment(AttachmentID, UserStoryID) {
            //debugger;
           
            var strUserResult = ajaxCall("frmSprintPlanning.aspx/DeleteAttachment", "POST", "application/json", "json", JSON.stringify({ strAttachmentID: AttachmentID, strUserStoryID: UserStoryID, strEntity: 'UserStory' }));
            strUser = strUserResult.d.split("||");

            document.getElementById("Attachmentus").innerHTML = "";
            document.getElementById("Attachmentus").innerHTML = strUser[2];

            $('[data-bs-toggle="tooltip"]').tooltip();
            makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                var output = document.querySelector('.demo-droppable');
                output.innerHTML = '';
                for (var i = 0; i < files.length; i++) {
                    arrFile[0] = files[i];
                    output.innerHTML += '<p>' + files[i].name + '</p>';
                }
            });

             //Commented and Added by Usha Pandit on 09.05.2019 for Exception Alertify should be in red
            //alertify.set('notifier', 'position', 'top-right');
            ////Commented and Added by Usha Pandit on 05 JUNE 2018 for correct validation alert
            ////alertify.notify("Attachment Deleted Successfully.", 'success', 25);
            //alertify.notify(strUser[0], 'success', 5);
            ////End of Added by Usha Pandit on 05 JUNE 2018 for correct validation alert
            ////alertify.notify(strUserResult[0], 'success', 25);

            if (strUser[1] == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strUser[0], 'error', 15);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strUser[0], 'success', 15);
            }
            //End of Added by Usha Pandit on 09.05.2019 for Exception Alertify should be in red
        }

     async   function UploadDataSR(userStoryID, flag) {

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
                const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
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
                            alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
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



            if (arrFile[0] != undefined) {
                var formdata = new FormData();
                formdata.append('file', arrFile[0]);
                formdata.append('Mode', 'Upload');
                formdata.append('UserStoryID', userStoryID);
                formdata.append('Flag', flag);
                $.ajax({
                    type: 'post',
                    url: 'frmSprintPlanning.aspx',
                    data: formdata,
                    success: function (status) {
                        //  debugger;
                        if (status == "Invalid") {
                            // alert("Invalid content type!");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Invalid content type!", 'error', 5);
                        }
                        else {
                            document.getElementById("AttachmentusSprintdelete").innerHTML = status;
                            $('[data-bs-toggle="tooltip"]').tooltip();
                            // $('.radio-inline').tooltip()
                        }
                        arrFile = [];
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        // alertify.set('notifier', 'position', 'top-right');
                        /// alertify.notify("oops something went wrong!", 'error', 25);
                        // alert("oops something went wrong!");
                    }
                });
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please Upload file!", 'error', 5);
            }
        }

        function Delete_AttachmentSR(AttachmentID, UserStoryID, Flag) {
            // debugger;
            var strUserResult = ajaxCall("frmSprintPlanning.aspx/DeleteAttachment",
                "POST", "application/json", "json", JSON.stringify({ strAttachmentID: AttachmentID, strUserStoryID: UserStoryID, strEntity: Flag }));
            strUserResult = strUserResult.d.split("||")
            if (Flag != "UserStory") {
                //  alert(strUserResult[1]);
                // document.getElementById("AttachmentusSprintdelete").innerHTML = "";
                document.getElementById("AttachmentusSprintdelete").innerHTML = "";
                document.getElementById("AttachmentusSprintdelete").innerHTML = strUserResult[2];
                // document.getElementById("Sprintattachmentdata").innerHTML = strUserResult[1];
            }
            else {
                //document.getElementById("Attachmentus").innerHTML = "";            
                //document.getElementById("Attachmentus").innerHTML = strUserResult[1];            

            }
            makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                var output = document.querySelector('.demo-droppable');
                output.innerHTML = '';
                for (var i = 0; i < files.length; i++) {
                    arrFile[0] = files[i];
                    output.innerHTML += '<p>' + files[i].name + '</p>';
                }
            });
            //Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

            if (strUserResult[1] == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strUserResult[0], 'error', 15);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strUserResult[0], 'success', 5);
            }
            //End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

        }
        //---------------End Attachment ---------------------------

        //------------------------End User Story -----------------------------------------
        //Modal Popup      
        function ShowAllStoryList() {
            var strResult, data;
            data = JSON.stringify({ Mode: "" });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/ScrumIterationList", data, false);
            gUserStoryID = '';
            if (strResult.d != '') {
                $("#txtSprintSearch").val('');
                $("#Idheader").html("Sprint List")
                $("#DivSprintlist").modal('show');
                $("#divListdetails").html(strResult.d);
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                if ($("#FilterListCount").val() > 0) {
                    datatables('DivSprintlist', 'txtSprintSearch', '');
                }
                //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }

        //For Datatable
        function datatables(divID, txtBoxID, height) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                "pageLength": 5,
                //scrollY: '275px',
                pagingType: "numbers",
                //Commented And Added By Usha Pandit On 18.07.2019 For Error: Object doesn't support property or method 'push'
                //sorting: false,
                bSort: false,
                //End Of Added By Usha Pandit On 18.07.2019 For Error: Object doesn't support property or method 'push'
                //scrollX: true,
                //Tooltip:true,
            });

            if (txtBoxID != "") {
                $('#' + txtBoxID).on('keyup change', function () {
                    table.search($(this).val()).draw();
                    $('[data-bs-toggle="tooltip"]').tooltip();
                })
            }
        }

        //Cancel user story...
        function CancelUserStory(userStoryID, IterationID) {
            //  debugger;
            var strResult1, strResult2, data;
            data = JSON.stringify({ userStoryID: userStoryID, IterationID: IterationID });
            strResult1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckActivityFilledAgainstIssueReview", data, false);

            if (strResult1.d != '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strResult1.d, 'error');
                return;
            } else {

                strResult2 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory", data, false);
                if (strResult2.d != '') {
                    $("#mdlConfirmBody").html(strResult2.d);
                    $("#myModalconfirm").modal('show');
                    AutoResizeTextArea();
                    RemoveTextArea();
                    setTimeout(
                        function () {
                            $("#txtRemark" + IterationID).focus();
                        }, 500
                    )
                }
            }
        }

        // //Ok BUTTION click event..
        function TerminateUserStory(userStoryID, IterationID, txtRemark, obj) {

            //  debugger;
            var Remark = '';
            if (obj == "") {
                Remark = txtRemark;
            } else {
                Remark = txtRemark.value;
            }
            if (Remark != '') {

                var data = JSON.stringify({ userStoryID: userStoryID, IterationID: IterationID });
                var strResult_3 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckUserStoryIsMappedOrNot", JSON.stringify({ IterationID: IterationID, userStoryID: userStoryID }), false);
                if (strResult_3.d == '') {
                    var result = AJAXCallWithResult("frmSprintPlanning.aspx/CancelUserStory", JSON.stringify({ strUserSoryID: userStoryID, strRemark: Remark, iterationID: IterationID, flag: 0 }), false);
                    //Refresh Second Table
                    RefreshBothTable(userStoryID, IterationID);

                } else if (strResult_3.d == "1") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is completed.You can not unmap User story.', 'error');
                    return;
                } else if (strResult_3.d == "2") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Release is released.You can not unmap User story.', 'error');
                    return;
                } else if (strResult_3.d == "3") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You can not unmap Sub User Story from the sprint as parent User Story is already mapped to sprint ', 'error');
                    return;
                } else if (strResult_3.d == "4") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('All the sub stories mapped to selected parent user story  will also unmapped from the sprint ', 'error');
                    var result = AJAXCallWithResult("frmSprintPlanning.aspx/CancelUserStory", JSON.stringify({ strUserSoryID: userStoryID, strRemark: Remark, iterationID: IterationID, flag: 0 }), false);
                    //Refresh Second Table
                    $("#myModalconfirm").modal('hide');
                    RefreshBothTable(userStoryID, IterationID);
                    return;
                } else if (strResult_3.d == "5") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You can not unmap User Story from the sprint. ', 'error');
                    return;
                } else if (strResult_3.d == "6") {
                } else if (strResult_3.d == "7") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is started.You can not unmap User story.', 'error');
                    return;
                } else if (strResult_3.d == "8") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Actual are not filled against review tasks mapped to the user story,You can not unmap User Story from the sprint.', 'error');
                    return;
                }
                //Hide Modal Popup...
                $("#myModalconfirm").modal('hide');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please Enter Remark.');
                return false;
            }


            //if (txtRemark.value != '') {
            //    //$("#myModalconfirm").modal('hide');
            //    var data = JSON.stringify({ userStoryID: userStoryID, IterationID: IterationID });
            //    var strResult_1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory1", data, false);
            //    if (strResult_1.d != '') {
            //        //var strResult_2 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory1", data, false);
            //        //if (strResult_2.d != "") {
            //        var strResult_3 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckUserStoryIsMappedOrNot", JSON.stringify({ IterationID: IterationID, userStoryID: userStoryID }), false);
            //        if (strResult_3.d == '') {
            //            var result = AJAXCallWithResult("frmSprintPlanning.aspx/CancelUserStory", JSON.stringify({ strUserSoryID: userStoryID, strRemark: txtRemark.value, iterationID: IterationID, flag: 0 }), false);

            //        } else if (strResult_3.d == "1") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('Sprint is completed.You can not unmap User story.', 'error');
            //            return;
            //        } else if (strResult_3.d == "2") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('Release is released.You can not unmap User story.', 'error');
            //            return;
            //        } else if (strResult_3.d == "3") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('You can not unmap Sub User Story from the sprint as parent User Story is already mapped to sprint ', 'error');
            //            return;
            //        } else if (strResult_3.d == "4") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('All the sub stories mapped to selected parent user story  will also unmapped from the sprint ', 'error');
            //            return;
            //        } else if (strResult_3.d == "5") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('You can not unmap User Story from the sprint. ', 'error');
            //            return;
            //        } else if (strResult_3.d == "6") {
            //        } else if (strResult_3.d == "7") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('Sprint is started.You can not unmap User story.', 'error');
            //            return;
            //        } else if (strResult_3.d == "8") {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('Actual are not filled against review tasks mapped to the user story,You can not unmap User Story from the sprint.', 'error');
            //            return;
            //        }
            //    }
            //    else {
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.notify('Task Not Mapped To user Story.', 'error');
            //        return false;
            //        //var url = 'frmSprintPlanning.aspx/Save_IterationUserStories';
            //        //var data = JSON.stringify({ draggedUserStoryID: UserStoryID, IterationID: iterationID, strMapFlag: "MapWithoutTask" });
            //        //AJAXCall(url, data, DragUserStory);
            //    }
            //    //Hide Modal Popup...
            //    $("#myModalconfirm").modal('hide');
            //} else {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error('Please Enter Remark.');
            //    return false;
            //}

        }

        function RefreshFirstTable(Flag) {
            //if (Flag == 'FirstTable') {
            //    Flag = 

            //}
            $(".modal-backdrop ").remove();
            var strPriorityF = '';
            var strPriorityS = '';
            var data = JSON.stringify({ strPriorityF: strPriorityF, strPriorityS: strPriorityS, flag: 'Filter', tableFlag: Flag });//FirstTable
            var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetPriorityGrid", data, false);
            //$('#fDiv').html("");
            //var hdata = $(result.d).html();
            //$('#fDiv').html(hdata);
            $('#MainDiv2').html("");
            $('#MainDiv2').html(result.d);
            var windowheight = $(window).height();
            $('.OuterDiv').css('height', windowheight - 175 + 'px');
            $(".OuterDiv").css("overflow", "auto");

            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
            //$(".outerdiv").css("height", window.innerHeight - 175 + "px");
            //$(".outerdiv").css("overflow", "auto");
            if ($(".outer").length <= 4) {

                $(".outerRightdiv").css("height", "inherit");
            }
            //else if ($(".outer").length >= 2) {
            //    $(".outerRightdiv").css("height", "inherit");
            //}
            else {
            }
            common();

        }
        function RefreshBothTable(UserStoryID, IterationID) {

            //First Table
            //Added by Usha Pandit on 26 Mar 2019 for refresh tables
            if (UserStoryID == "") {
                $(".modal-backdrop ").remove();
            }
            //End of Added by Usha Pandit on 26 Mar 2019 for refresh tables

            var strPriorityF = '';
            var strPriorityS = '';
            //var data = JSON.stringify({ strPriorityF: strPriorityF, strPriorityS: strPriorityS, flag: 'Filter', tableFlag: 'FirstTable' });
            //var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetPriorityGrid", data, false);
            //$('#fDiv').html("");
            //var hdata = $(result.d).html();
            //$('#fDiv').html(hdata);
            //$('#MainDiv2').html("");
            //$('#MainDiv2').html(result.d);
            //Second Table

            var data = JSON.stringify({ strSeletedIteration: IterationID, flag: 'Filter', tableFlag: 'SecondTable' });
            var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetIterationFilterGrid", data, false);
            if (result.d != '') {
                //$('#sDiv').html("");
                //var hdata = $(result.d).html();
                //$('#sDiv').html(hdata);
               // alert(result.d);
                $('#MainDiv2').html("");
                $('#MainDiv2').html(result.d);
            }
            common();
        }

        //txtRemark Validations...
        function CheckTextLength(obj, lbl, span) {
            // debugger;
            var MaxLength = obj.getAttribute("maxlength");

            if (parseInt(String(obj.value).length) >= MaxLength) {
                $("#" + span).text("you can enter only " + MaxLength + " characters.");
            }
            else {
                $("#" + span).text("");
            }
            document.getElementById(lbl).innerHTML = '-' + (MaxLength - parseInt(String(obj.value).length));
        }

        //select One checkbox at time
        function SelectOne(obj) {
            $('input.clscheckbox').on('change', function () {
                $('input.clscheckbox').not(this).prop('checked', false);
            });
        }

        function ShowPopup(strMessage) {
            $('#customMessage').html(strMessage);
            $("#myModal").modal({
                backdrop: 'static'
            });
        }
        ///Filter Grid 
        function FilterGrid(strPriorityF, strPriorityS) {
            //debugger;
            var data = JSON.stringify({ strPriorityF: strPriorityF, strPriorityS: strPriorityS, flag: 'Filter', tableFlag: 'FirstTable' });
            var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetPriorityGrid", data, false);
            //$('#fDiv').html("");
            //var hdata = $(result.d).html();
            //$('#fDiv').html(hdata);
            // alert(result.d);
            $('#DivmainLeft').html("");
            $('#DivmainLeft').html(result.d);
            //$('#DivmainRight').html("");
            //$('#DivmainRight').html(result.d);
            $('[data-bs-toggle="tooltip"]').tooltip();
            var windowheight = $(window).height();
            $('.OuterDiv').css('height', windowheight - 175 + 'px');
            $(".OuterDiv").css("overflow", "auto");
            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
            //$(".outerdiv").css("height", window.innerHeight - 175 + "px");
            //$(".outerdiv").css("overflow", "auto");
            if ($(".outer").length <= 4) {

                $(".outerRightdiv").css("height", "inherit");
            }
            //else if ($(".outer").length >= 2) {
            //    $(".outerRightdiv").css("height", "inherit");
            //}
            else {
            }
            common();
            //FilterGrid2(strPriorityF, strPriorityS);
        }

        function FilterGrid2(strPriorityF, strPriorityS) {
            //debugger;
            var data = JSON.stringify({ strPriorityF: strPriorityF, strPriorityS: strPriorityS, flag: 'Filter', tableFlag: 'SecondTable' });
            var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetPriorityGrid", data, false);
            //$('#sDiv').html("");
            //alert(result.d);
            //var hdata = $(result.d).html();
            //$('#sDiv').html(hdata);
            $('#DivmainRight').html("");
            $('#DivmainRight').html(result.d);
            $("#divRight .panel-heading").css("background-color", "rgb(189, 218, 183)!important");
            $("#btnStartSprint").parent(".panel-heading").css("background-color", "#fff!important");
            //$('#MainDiv2').html("");
            //$('#MainDiv2').html(result.d);
            $('[data-bs-toggle="tooltip"]').tooltip();
            var windowheight = $(window).height();
            $('.OuterDiv').css('height', windowheight - 175 + 'px');
            $(".OuterDiv").css("overflow", "auto");
            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
            //$(".outerdiv").css("height", window.innerHeight - 175 + "px");
            // $(".outerdiv").css("overflow", "auto");
            if ($(".outer").length <= 4) {

                $(".outerRightdiv").css("height", "inherit");
            }
            //else if ($(".outer").length >= 2) {
            //    $(".outerRightdiv").css("height", "inherit");
            //}
            else {
            }
            common();
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

        // Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
        var opDateFormat = '';
        // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

        common();
        var globalUSID = "";
        function common() {
            //debugger;
            $("span").tooltip();
            var hdnstrIsPrductOwner = 0;
            $(document).ready(function () {
                var height = $(window).height();
                if (window.matchMedia('(max-width: 991px)').matches) {
                    $("#MainDiv").css({ "height": height, "overflow-y": "auto" });
                    $("#divRight").css("margin-top", "20px");
                }
                //Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
                opDateFormat = '<%= strInputFormat %>';
                // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

                $("#AssignSaveBtn0").hide();
                //Added & Commneted By Dipali V On 1st Aug 2018 
                // $("#MainDiv2").css("height", window.innerHeight - 100 + "px");
                //Added and commented by yasmin  On 7th Aug 2018 
                var windowheight = $(window).height();
                var divheight = $('.OuterDiv').css('height', windowheight - 160 + 'px');
                //$('#divRight').css('height', windowheight -80+ 'px');
                //$('#divRight .outerRightdiv ').css('height', windowheight+ 'px');
                //$(".OuterDiv").css("height", window.innerHeight - 150 + "px");
                $(".OuterDiv").css("overflow", "auto");

                //$(".outerdiv").css("height", window.innerHeight - 175 + "px");
                //$(".outerdiv").css("overflow", "auto");
                //$(".outerRightdiv").css("overflow", "auto");
                var outer = $(".outerRightdiv").height();
                if ($(".outer").length <= 4) {

                    $(".outerRightdiv").css("height", "inherit");
                }
                //else if ($(".outer").length >= 2) {
                //    $(".outerRightdiv").css("height", "inherit");
                //}
                else {
                }
                //Changed By Yasmin S On 2st Aug 2018 
                //  $(".outerRightdiv ").css("height", window.innerHeight - 150 + "px");
                //$(".outerRightdiv ").css("overflow", "auto");
                //$("#divRight").css("height", window.innerHeight - 100 + "px");
                //$("#divRight").css("overflow", "auto");
                //End of Added & Commneted By Dipali V On 1st Aug 2018 
                //$("#MainDiv2").scroll(function () {
                //    $(this).find(".card-header").css("top", $("#MainDiv2").scrollTop() - 18);
                //    // $(this).find(".card-header").css("top", $("#DivmainRight").scrollTop() - 10000);
                //})

                //$("#outerRightdiv").scroll(function () {
                //    $(this).find(".card-header").css("top", $("#outerRightdiv").scrollTop() - 18);
                //    // $(this).find(".card-header").css("top", $("#DivmainRight").scrollTop() - 10000);
                //})
                $("span").tooltip();
                /*Added By Yasmin On 13th July*/
                var pbheight = $("#divLeft").height();
                var pbheight = $("#divRight").height();
                //var spheight = $("#divRight").height();
                //if ($('#divLeft').height() > $('#divRight').height()) {
                //    $('#divRight').css('height', pbheight + 20);
                //    console.log("pb");

                //}
                //else {
                //    $('#divRight').css('height', spheight + 20);
                //    console.log("sp");
                //}

                //Search User Story....
                $('#message1').css("display", "none");
                $('#message2').css("display", "none");
                $('#txtSearchPendingUS').keyup(function () {
                    //debugger;
                    // Search Text
                    var search = $(this).val();
                    // Hide all table tbody rows
                    $('table tbody #MouseOver').hide();
                    // Searching text in columns and show match row
                    $('table tbody tr td:contains("' + search + '")').each(function () {
                        $(this).closest('#MouseOver').show();
                        $('.UndragFirstRow').show();

                        $('#message1').css("display", "none");
                        $('#message2').css("display", "none");
                    });
                    var rowCount = $('#mainbody1 tr').length;
                    var numOfVisibleRows1 = $('#mainbody1 tr:visible').length;
                    var numOfVisibleRows2 = $('#mainbody2 tr:visible').length;

                    if (numOfVisibleRows1 == 0) {
                        $('table tbody').show();
                        $('#message1').css("display", "table-row");
                    }
                    if (numOfVisibleRows2 == 0) {
                        $('table tbody').show();
                        $('#message2').css("display", "block");
                    } else if (numOfVisibleRows2 != 0) {
                        //$('.UndragFirstRow').show();
                    }

                    $.each($(".panel"), function (id, val) {
                        var strHTML = String($(this).html()).toLowerCase();
                        var n = strHTML.search(String($("#txtSearchPendingUS").val()).toLowerCase());
                        if (n == -1) {
                            $(this).css("display", "none");
                        }
                        else {
                            $(this).css("display", "");
                        }
                    })

                });




                $('#mainbody2').hover(function () {
                    draggedIterationID2 = $('#hdnIterationID2').val();
                });

                hdnstrIsPrductOwner = $("#hdnstrIsPrductOwner").val();

                ////Sortable event
                $(".connectedSortable").sortable({
                    connectWith: ".connectedSortable",
                    placeholder: "placeholder",
                    cursor: "highlight",
                    scroll: false,
                    cancel: ".UndragFirstRow",
                    cursor: 'move',

                    over: function (e, ui) {
                        if ($(".outer").length == 0) {
                        }
                        else if ($(".outer").length >= 3) {
                            var buffer = 16;
                            var step = 30;
                            var speed = 250;
                            var upper = $('#divRight .OuterDiv').position().top + buffer;
                            var lower = $('#divRight .OuterDiv').position().top + $('#divRight .OuterDiv').height() - buffer;
                            var current = $('#divRight .OuterDiv').scrollTop();
                            switch (true) {
                                case (ui.position.top <= upper):
                                    console.log("Direction: Up");
                                    $('#divRight .OuterDiv').scrollTop(ui.position.top - outer);

                                    break;


                                case ((ui.position.top + ui.helper.height()) >= lower):
                                    console.log("Direction: Down");
                                    $('#divRight .OuterDiv').scrollTop(ui.position.top + outer);
                                    break;
                            }
                        }
                    },
                    //sort: function (event, ui) {
                    //    $('#divRight .OuterDiv').scrollTop(ui.position.top + i);
                    //    //$('#divRight .OuterDiv').scrollTop(ui.position.top - 1600);
                    //    //$('#divRight .OuterDiv').scrollTop(ui.position.top + 1600);
                    //    //$('#divRight .OuterDiv').offset().top + $('#divRight .OuterDiv').height() - 50;
                    //    //var scroll = $('#divRight .OuterDiv').scrollTop(ui.position.top + 90);
                    //    //if ($(".outer").length == 0) {



                    //    //}
                    //    ////else if ($(".outer").length >= 3) {
                    //    ////    //alert(1)
                    //    ////    //$('#divRight .OuterDiv').scrollTop(ui.position.top - 40);
                    //    ////    $('#divRight .OuterDiv').scrollTop(ui.position.top - 100);
                    //    ////    $('#divRight .OuterDiv').css('margin-bottom', '20px');
                    //    ////}
                    //    //else {


                    //    //    var scroll = $('#divRight .OuterDiv').scrollTop(ui.position.top - 90);
                    //    //    var h = $(".OuterDiv").height();
                    //    //    console.log(h);
                    //    //    console.log(scroll);
                    //    //    //$('#divRight .OuterDiv').scrollTop(ui.position.top + 80);
                    //    //    //$('#divRight .OuterDiv').css('margin-bottom', '20px');
                    //    //}
                    //},
                    start: function (event, ui) {
                        holdAndPress = true;
                    },
                    stop: function (event, ui) {
                        holdAndPress = false;
                    },
                    activate: function (ev, ui) {
                        $(".tooltip").hide();
                    },

                    update: function (event, ui) {

                        // if (hdnstrIsPrductOwner == 1)
                        //{
                        dragUserStoryD = $(ui.item).find("#hdnUserStoryID").val();
                        dragUserStoryID2 = $(ui.item).find("#hdnUserStoryID2").val();
                        draggedIterationID2 = $('#hdnIterationID2').val();

                        CategoryID = $(ui.item).find("[name=hdnCategoryIDs]").val();
                        //alert("USer Story --" + dragUserStoryD + " ITERATION ID -" + draggedIterationID2);
                        if (draggedIterationID2 == undefined) {
                            draggedIterationID2 = '';
                        }

                        if (ui.sender == null) {
                            var obj = {};
                            var label = '';
                            $('.lblIDS').each(function () {
                                label = label + $(this).text() + ',';
                            });

                            obj.UserStoryID = label;
                            obj.CategoryVal = CategoryID;
                            obj.DragUserStoryID = dragUserStoryD;
                            globalUSID = dragUserStoryD;

                            if (obj.UserStoryID.length != 0) {
                                $.ajax({
                                    type: "POST",
                                    url: "frmSprintPlanning.aspx/InsertSortedRowsLeftTable",
                                    data: JSON.stringify(obj),
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        RefreshBothTable(dragUserStoryD, draggedIterationID2);

                                    }
                                });
                            }
                        } else {
                            var getDivID;
                            var IterationID = '';
                            var getDivID = $(this).attr('id');


                            if (getDivID == "divLeft") {
                                //------------------Update drag table 2 to 1st Table------------                           
                                TerminateUserStory(dragUserStoryID2, draggedIterationID2, 'OK', '')

                                ////-------------Refresh Grid Start................
                                //var data = JSON.stringify({ ID: 1 });
                                //var result = AJAXCallWithResult("frmSprintPlanning.aspx/RefreshGrid1", data, false);
                                //if (result.d != '') {
                                //    $('#MainDiv2').html("");
                                //    var hdata = $(result.d).html();
                                //    $('#MainDiv2').html(hdata);
                                //    //called Common Functions....
                                //    common();
                                //}
                                //-------------Refresh Grid End................
                                //------------------Update drag table 2 to 1st Table------------
                            }
                            else if (getDivID == "divRight") {
                                //debugger;
                                //---------------Update drag table 1 To 2nd Table-----------------
                                if (draggedIterationID2 != '') {
                                    var obj1 = {};
                                    dragUserStoryD = globalUSID;
                                    obj1.UserStoryID = dragUserStoryD;
                                    obj1.IterationID = draggedIterationID2;
                                    obj1.strMapFlag = "MapWithoutTask";

                                    if (isProductOwner == 1) {
                                        if (dragUserStoryD != "") {
                                            var flag = AJAXCallWithResult("frmSprintPlanning.aspx/CheckComplexity", JSON.stringify({ strUserStoryID: dragUserStoryD, strIterationID: draggedIterationID2 }), false);
                                            if (flag.d == "10") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('User Story is already cancelled from the sprint, you can not map user story to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "11") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Selected sprint is not map with any release, you can not map user story to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "2") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Sprint is already started/completed. You can not map user story to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "8") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Sprint is terminated. You can not map user story to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "6") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Sprint is cancelled. You can not map user story to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "3") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('User story is inactive. You can not map to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "4") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Sprint is completed, you can not map user story to sprint', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            else if (flag.d == "5") {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Parent User Story  is not Planned for the Selected Sub User Story ,Plan the Parent User Story First.', 'error');
                                                RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            }
                                            //else if (flag.d == "7") {
                                            //    //ShowConfirm("By mapping User Story to Sprint all Sub User Stories will be mapped to Sprint.", draggedIterationID2, dragUserStoryD, ui);
                                            //    //RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                            //    //Work Remain
                                            //}
                                            else if (flag.d != "1") {
                                                //Added for sprint cancellation changes
                                                //var strResult_1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory1", JSON.stringify({ userStoryID: dragUserStoryD, IterationID: draggedIterationID2 }), false);
                                                //if (strResult_1.d != "") {
                                                //    ///Work Remain
                                                //} else {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "frmSprintPlanning.aspx/Save_IterationUserStories",
                                                    data: JSON.stringify(obj1),
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.success('User story Saved Successfully Against Sprint.');
                                                        //Refresh Grid...
                                                        RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                                        //commonFunction();
                                                        //RefreshFirstTable('close');
                                                        common();
                                                    }
                                                });
                                                //}

                                            }
                                            else {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Please map Story point to user story/sub user story', 'error');
                                                // RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                                // debugger;
                                                common();
                                            }
                                        }
                                    } else {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('You are not a Product Owner to map user story to sprint', 'error');
                                        RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                    }
                                }
                                else {

                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('Please select atleast one sprint.', 'error');
                                    RefreshBothTable(dragUserStoryD, draggedIterationID2)
                                    common();
                                }
                            }
                        }
                        // }


                    },
                    stop: function (event, ui) {
                    }


                });



                var heights1 = $('#mainbody1').height();
                var heights2 = $('#mainbody2').height();
                if (heights1 >= heights2) {
                    $("#mainbody2").css('height', heights1 + 'px');
                    $("#mainbody2").css('display', 'table-footer-group');
                    $("#mainbody2").css('width', '100%');
                } else {
                    //$("#mainbody1").css('height', heights2 + 'px');
                    //$("#mainbody1").css('display', 'inline-table');
                    //$("#mainbody1").css('width', '100%');
                }
                //$('#SecondDivTbl').css('height', heights + 'px');
                //$('#SecondDivTbl').css('display', 'block');
                //$('#SecondDivTbl')





                // Enter Only Digits...
                //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                //$("#txtEffortsS").keypress(function (e) {
                //    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //        // $("#errmsg").html("Digits Only").show().fadeOut("slow");
                //        return false;
                //    }
                //});
                //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                // ------------------ Dashboard--------------------
                //Tooltip                
                $('[data-bs-toggle="tooltip"]').tooltip();




                var $li = $('#tab_link a').click(function () {
                    $li.removeClass('selected');
                    $(this).addClass('selected');
                });


                $('#txtStartDateS,#txtEndDateS').change(function () {
                    GetDuration('Sprint');
                });
                $('#txtStartDateR,#txtEndDateR').change(function () {
                    GetDuration('Release');
                });
                // var Mode = 'Edit';
                function GetDuration(MODE) {
                    //debugger;
                    var objStart;
                    var objEnd;
                    Mode = MODE;

                    if (MODE == "Sprint") {
                        objStart = document.getElementById("txtStartDateS");
                        objEnd = document.getElementById("txtEndDateS");
                    }
                    else {
                        objStart = document.getElementById("txtStartDateR");
                        objEnd = document.getElementById("txtEndDateR");
                    }
                    // Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                    //var dtstart = new Date(objStart.value);
                    //var dtend = new Date(objEnd.value);
                    // End of Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                    //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                    var oldobjStartVal = objStart.value;
                    var oldobjEndVal = objEnd.value;

                    getInputDateFormat(objStart, objEnd, 1, opDateFormat);

                    //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation

                    if (isNaN(dtstart.getTime()) && isNaN(dtend.getTime())) {
                    }
                    else {
                        if (objStart.value != "" && objEnd.value != "") {
                            var url = "frmSprintPlanning.aspx/GetDuration"
                            var data = JSON.stringify({ strStartDate: objStart.value, strEndDate: objEnd.value })
                            var result = AJAXCallWithResult(url, data, false);
                            if (result.d != '') {
                                var strArray = String(result.d).split("|");
                                if (Mode == "Sprint") {
                                    document.getElementById("txtDurationCalendeS").value = strArray[0];
                                    document.getElementById("txtDurationBusinessDayS").value = strArray[1];
                                } else {
                                    document.getElementById("txtDurationCalendeR").value = strArray[0];
                                    document.getElementById("txtDurationBusinessDayR").value = strArray[1];
                                }
                            }
                        }
                    }

                    //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                    objStart.value = oldobjStartVal;
                    objEnd.value = oldobjEndVal;
                    //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                }

                //Un Sort FirstRow...            
                $('#mainbody2').sortable({
                    cancel: '.UndragFirstRow:not(first)'
                });

                //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                var sprintDateFormat = '';
                switch ('<%=strInputFormat%>') {

                    case 'DD-MM-YYYY':
                        sprintDateFormat = 'dd-mm-yy';
                        break;

                    case 'DD/MM/YYYY':
                        sprintDateFormat = 'dd/mm/yy';
                        break;

                    case 'DD.MM.YYYY':
                        sprintDateFormat = 'dd.mm.yy';
                        break;


                    case 'MM-DD-YYYY':
                        sprintDateFormat = 'mm-dd-yy';
                        break;

                    case 'MM/DD/YYYY':
                        sprintDateFormat = 'mm/dd/yy';
                        break;

                    case 'MM.DD.YYYY':
                        sprintDateFormat = 'mm.dd.yy';
                        break;

                    case 'YYYY-DD-MM':
                        sprintDateFormat = 'yy-dd-mm';
                        break;

                    case 'YYYY.DD.MM':
                        sprintDateFormat = 'yy.dd.mm';
                        break;

                    case 'YYYY/DD/MM':
                        sprintDateFormat = 'yy/dd/mm';
                        break;

                    case 'YYYY-MM-DD':
                        //Modified By VarunA on 6-Aug-2008 RequestID-14286
                        //Purpose : To have month place instead of day
                        //newDate=y + '-' + d + '-' + m;
                        sprintDateFormat = 'yy-mm-dd';
                        //End By VarunA on 6-Aug-2008 RequestID-14286
                        break;

                    case 'YYYY/MM/DD':
                        sprintDateFormat = 'yy/mm/dd';
                        break;

                    case 'YYYY.MM.DD':
                        sprintDateFormat = 'yy.mm.dd';
                        break;

                }
                //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation

                if ($('#txtStartDateS').val() != undefined && $('#txtEndDateS').val() != undefined) {
                    $('#txtStartDateS,#txtEndDateS').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change

                            //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                            , dateFormat: sprintDateFormat
                            //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                        }
                    );
                }
                $('#txtStartDateR').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        //yearRange: '2000:2020'
                        yearRange: 'c-100:c+100'
                        //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    });
                //Added by Ankush T on 04/03/2019 for The dates before the current date should be disabled
                var dateToday = new Date();

                $('#txtEndDateR').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    minDate: dateToday,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
                //End of Added by Ankush T on 04/03/2019 for The dates before the current date should be disabled

                $('#txtSRStartDate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
                //Added by Ankush T on 04/03/2019 for The dates before the current date should be disabled
                $('#txtSREndDate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    minDate: dateToday,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
                $('#txtSRStartDate,#txtSREndDate,#txtEndDateR,#txtStartDateR').prop('readonly', true);
                //End of Added by Ankush T on 04/03/2019 for The dates before the current date should be disabled

                $('#SRdpd1').click(function () {
                    $('#txtSRStartDate').datepicker('show');
                });
                $('#SRdpd2').click(function () {
                    $('#txtSREndDate').datepicker('show');
                });
                $('#dpImg1').click(function () {
                    $('#txtStartDateS').datepicker('show');
                });
                $('#dpImg2').click(function () {
                    $('#txtEndDateS').datepicker('show');
                });
                $('#dpImg1R').click(function () {
                    $('#txtStartDateR').datepicker('show');
                });
                $('#dpImg2R').click(function () {
                    $('#txtEndDateR').datepicker('show');
                });
            });

            //Added by Usha Pandit On 28 March 2019 for user story large description tooltip 

            $('.tt_large').tooltip({
                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
            });
            //End of Added by Usha Pandit On 28 March 2019 for user story large description tooltip 
        }

        function Select_AttchSprint() {
            // alert();
            var strSeletedIteration = '';
            var chkIterationSels = document.getElementsByName("chkIterationSel");

            for (var i = 0; i < chkIterationSels.length; i++) {
                if (chkIterationSels[i].checked == true) {
                    if (strSeletedIteration == '') {
                        strSeletedIteration = chkIterationSels[i].value;
                    }
                    else {
                        strSeletedIteration += ',' + chkIterationSels[i].value;
                    }
                }
            }

            if (strSeletedIteration.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            }
            //else {

            //    if (gUserStoryID == '') {
            //        var data = JSON.stringify({ strSeletedIteration: strSeletedIteration, flag: 'Filter', tableFlag: 'SecondTable' });
            //        var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetIterationFilterGrid", data, false);
            //        if (result.d != '') {

            //            //$('#sDiv').html("");
            //            //var hdata = $(result.d).html();
            //            //$('#sDiv').html(hdata);

            //            $('#MainDiv2').html("");
            //            $('#MainDiv2').html(result.d);

            //            $("#DivSprintlist").modal('hide');
            //            //called Common Functions....
            //            common();
            //            //  ToRefreshpage();
            //        }

            //    }
            else {
                var obj1 = {};
                obj1.UserStoryID = gUserStoryID;
                obj1.IterationID = strSeletedIteration;
                obj1.strMapFlag = "MapWithoutTask";
                var flag = AJAXCallWithResult("frmSprintPlanning.aspx/CheckComplexity", JSON.stringify({ strUserStoryID: gUserStoryID, strIterationID: strSeletedIteration }), false);
                if (flag.d == "10") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('User Story is already cancelled from the sprint, you can not map user story to sprint', 'error');
                    //RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "11") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Selected sprint is not map with any release, you can not map user story to sprint', 'error');
                    //RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "2") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is already started/completed. You can not map user story to sprint', 'error');
                    // RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "8") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is terminated. You can not map user story to sprint', 'error');
                    // RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "6") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is cancelled. You can not map user story to sprint', 'error');
                    //RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "3") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('User story is inactive. You can not map to sprint', 'error');
                    // RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "4") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is completed, you can not map user story to sprint', 'error');
                    //RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                else if (flag.d == "5") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Parent User Story  is not Planned for the Selected Sub User Story ,Plan the Parent User Story First.', 'error');
                    // RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
                //else if (flag.d == "7") {
                //ShowConfirm("By mapping User Story to Sprint all Sub User Stories will be mapped to Sprint.", draggedIterationID2, dragUserStoryD, ui);
                //RefreshBothTable(dragUserStoryD, draggedIterationID2)
                //Work Remain
                //}
                else if (flag.d != "1") {
                    ////Added for sprint cancellation changes
                    //var strResult_1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory1", JSON.stringify({ userStoryID: gUserStoryID, IterationID: strSeletedIteration }), false);
                    //if (Trim(strResult_1.d) != "") {
                    //    ///Work Remain
                    //    // alert(strResult_1.d);
                    //    // alertify.set('notifier', 'position', 'top-right');
                    //    // alertify.notify(strResult_1.d, 'error');
                    //    RefreshBothTable(gUserStoryID, strSeletedIteration)
                    //}
                    //else {
                    $.ajax({
                        type: "POST",
                        url: "frmSprintPlanning.aspx/Save_IterationUserStories",
                        data: JSON.stringify(obj1),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $("#DivSprintlist").modal('hide');
                            gUserStoryID = '';
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('User Story Added Successfully Against Sprint');
                            if ($("#hdnIterationID").val() != "") {

                                RefreshBothTable(gUserStoryID, $("#hdnIterationID").val())
                            }
                            $("#DivAttachSprint").modal('hide');
 							//Added By Dipali V On 26th Jun 2020 For RefreshGrid
                            RefreshGrid();
                             //End of Added By Dipali V On 26th Jun 2020 For RefreshGrid
                            //Refresh Grid...
                            //var data = JSON.stringify({ ID: 1 });
                            //var result = AJAXCallWithResult("frmSprintPlanning.aspx/RefreshGrid1", data, false);
                            //// alert(result.d);
                            //if (result.d != '') {
                            //    $('#MainDiv2').html("");
                            //    var hdata = $(result.d).html();
                            //    $('#MainDiv2').html(result.d);
                            //    //called Common Functions....
                            //    common();
                            //}
                        }
                    });
                    //}
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please map Story point to user story/sub user story', 'error');
                    // RefreshBothTable(gUserStoryID, strSeletedIteration)
                }
            }
        }

        //Added by Usha Pandit on 21 Aug 2018 for refresh grid if changes made
        function Refresh_Sprint() {

            var strSeletedIteration = '';
            //strSeletedIteration = $('input[name=chkIterationSel]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');

            var chkIterationSels = document.getElementsByName("chkIterationSel");

            for (var i = 0; i < chkIterationSels.length; i++) {
                if (chkIterationSels[i].checked == true) {
                    if (strSeletedIteration == '') {
                        strSeletedIteration = chkIterationSels[i].value;
                    }
                    else {
                        strSeletedIteration += ',' + chkIterationSels[i].value;
                    }
                }
            }

            if (strSeletedIteration.length > 0) {

                if (gUserStoryID == '') {
                    var data = JSON.stringify({ strSeletedIteration: strSeletedIteration, flag: 'Filter', tableFlag: 'SecondTable' });
                    var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetIterationFilterGrid", data, false);
                    if (result.d != '') {

                        //$('#sDiv').html("");
                        //var hdata = $(result.d).html();
                        //$('#sDiv').html(hdata);

                        $('#MainDiv2').html("");
                        $('#MainDiv2').html(result.d);

                        //$("#DivSprintlist").modal('hide');
                        //called Common Functions....

                        //  ToRefreshpage();
                    }
                }

            }
        }
        //End of Added by Usha Pandit on 21 Aug 2018 for refresh grid if changes made



        function Select_Sprint() {

            var strSeletedIteration = '';
            //strSeletedIteration = $('input[name=chkIterationSel]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');

            var chkIterationSels = document.getElementsByName("chkIterationSel");

            for (var i = 0; i < chkIterationSels.length; i++) {
                if (chkIterationSels[i].checked == true) {
                    if (strSeletedIteration == '') {
                        strSeletedIteration = chkIterationSels[i].value;
                    }
                    else {
                        strSeletedIteration += ',' + chkIterationSels[i].value;
                    }
                }
            }

            if (strSeletedIteration.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            } else {

                if (gUserStoryID == '') {
                    var data = JSON.stringify({ strSeletedIteration: strSeletedIteration, flag: 'Filter', tableFlag: 'SecondTable' });
                    var result = AJAXCallWithResult("frmSprintPlanning.aspx/GetIterationFilterGrid", data, false);
                    if (result.d != '') {

                        //$('#sDiv').html("");
                        //var hdata = $(result.d).html();
                        //$('#sDiv').html(hdata);

                        $('#MainDiv2').html("");
                        $('#MainDiv2').html(result.d);

                        $("#DivSprintlist").modal('hide');
                        //called Common Functions....
                        common();
                        //  ToRefreshpage();
                    }

                }
                else {
                    var obj1 = {};
                    obj1.UserStoryID = gUserStoryID;
                    obj1.IterationID = strSeletedIteration;
                    obj1.strMapFlag = "MapWithoutTask";
                    var flag = AJAXCallWithResult("frmSprintPlanning.aspx/CheckComplexity", JSON.stringify({ strUserStoryID: gUserStoryID, strIterationID: strSeletedIteration }), false);
                    if (flag.d == "10") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('User Story is already cancelled from the sprint, you can not map user story to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "11") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Selected sprint is not map with any release, you can not map user story to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "2") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sprint is already started/completed. You can not map user story to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "8") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sprint is terminated. You can not map user story to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "6") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sprint is cancelled. You can not map user story to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "3") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('User story is inactive. You can not map to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "4") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sprint is completed, you can not map user story to sprint', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    else if (flag.d == "5") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Parent User Story  is not Planned for the Selected Sub User Story ,Plan the Parent User Story First.', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                    //else if (flag.d == "7") {
                    //ShowConfirm("By mapping User Story to Sprint all Sub User Stories will be mapped to Sprint.", draggedIterationID2, dragUserStoryD, ui);
                    //RefreshBothTable(dragUserStoryD, draggedIterationID2)
                    //Work Remain
                    //}
                    else if (flag.d != "1") {
                        ////Added for sprint cancellation changes
                        //var strResult_1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory1", JSON.stringify({ userStoryID: gUserStoryID, IterationID: strSeletedIteration }), false);
                        //if (Trim(strResult_1.d) != "") {
                        //    ///Work Remain
                        //    // alert(strResult_1.d);
                        //    // alertify.set('notifier', 'position', 'top-right');
                        //    // alertify.notify(strResult_1.d, 'error');
                        //    RefreshBothTable(gUserStoryID, strSeletedIteration)
                        //}
                        //else {
                        $.ajax({
                            type: "POST",
                            url: "frmSprintPlanning.aspx/Save_IterationUserStories",
                            data: JSON.stringify(obj1),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                $("#DivSprintlist").modal('hide');
                                gUserStoryID = '';
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success('User Story Added Successfully Against Sprint');

                                // RefreshBothTable(gUserStoryID, strSeletedIteration);
                                //Refresh Grid...
                                var data = JSON.stringify({ ID: 1 });
                                var result = AJAXCallWithResult("frmSprintPlanning.aspx/RefreshGrid1", data, false);
                                // alert(result.d);
                                if (result.d != '') {
                                    $('#MainDiv2').html("");
                                    var hdata = $(result.d).html();
                                    $('#MainDiv2').html(result.d);
                                    //called Common Functions....
                                    common();
                                }
                            }
                        });
                        //}
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please map Story point to user story/sub user story', 'error');
                        RefreshBothTable(gUserStoryID, strSeletedIteration)
                    }
                }
            }
            $(document).click(function () {
                $(".tooltip").removeClass("in");
            });
        }



        function DashBoardDatePicker() {
            $('#SRdpd1').click(function () {
                $('#txtSRStartDate').datepicker('show');
            });
            $('#SRdpd2').click(function () {
                $('#txtSREndDate').datepicker('show');
            });
            $('#dpImg1').click(function () {
                $('#txtStartDateS').datepicker('show');
            });
            $('#dpImg2').click(function () {
                $('#txtEndDateS').datepicker('show');
            });
            $('#dpImg1R').click(function () {
                $('#txtStartDateR').datepicker('show');
            });
            $('#dpImg2R').click(function () {
                $('#txtEndDateR').datepicker('show');
            });
        }

        // Added by sagar N on 09-Apr-2019 Purpose:: Agile Issue ID- 11993
        var dtsdt, dtedt;
        var dtstart = '';
        var dtend = '';
        var dtvsdt = '';
        var dtvedt = '';
        // Added by sagar N on 09-Apr-2019 Purpose:: Agile Issue ID- 11993

        function commonFunction() {   //TollTip
            $(document).ready(function () {
                $("#AssignSaveBtn0").hide();
                $('[data-bs-toggle="tooltip"]').tooltip()
                //Mouse over Event.....
                $('#tblFGrid #MouseOver').hover(function () {
                    $(this).css("border", "1px solid");
                    $(this).css("box-shadow", "2px 7px #888888");
                }, function () {
                    $(this).css("box-shadow", "");
                    $(this).css("border", "");
                    $(this).css("border-bottom", "double silver");
                });
                $('#tblSGrid #MouseOver').hover(function () {
                    $(this).css("border", "2px solid");
                    $(this).css("box-shadow", "2px 7px #888888");
                }, function () {
                    $(this).css("box-shadow", "");
                    $(this).css("border", "");
                    $(this).css("border-bottom", "double silver");
                });
                //For Sortable
                $(".connectedSortable").sortable({
                    connectWith: ".connectedSortable",
                    placeholder: "placeholder",
                });
                //Un Sort FirstRow...            
                $('#mainbody2').sortable({
                    cancel: '#firstRow:not(first)'
                });

                $('.connectedSortable').droppable({
                    placeholder: "placeholder",
                    drop: function (e, ui) {
                        var $from = $(ui.draggable);
                        dragUserStoryD = $from.find("[name=hdnUserStoryID]").val();
                        CategoryID = $from.find("[name=hdnCategoryIDs]").val();
                        dragIterationID = $from.find("[name=hdnIterationID]").val();
                        //draggedIterationID2 = $from.find("[name=hdnIterationID2]").val();
                        draggedIterationID2 = $('#hdnIterationID2').val();
                        dragUserStoryID2 = $from.find("[name=hdnUserStoryID2]").val();
                    }
                });

                var $li = $('#tab_link a').click(function () {
                    $li.removeClass('selected');
                    $(this).addClass('selected');
                });
            });
        }
        function CompairDates(obj1, Obj2) {
            var date1 = new Date(obj1.value);
            var date2 = new Date(Obj2.value);
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
        function validationSprit() {
            var checkvalue = 0;
            var Flag = 0;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            dtStartDate = document.getElementById("txtStartDateS");
            dtEndDate = document.getElementById("txtEndDateS");
            var ProjectID = document.getElementById('hdnProjectID').value;
            if ($("#txtSprintName").val() == "") {
                strmsg = '- Sprint Name should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                $("#txtSprintName").focus();
                Flag = 1;
                checkvalue = 1;
            }

            else if ($("#txtSprintName").val() != "") {
                //if (checkSpecialCharacter($('#txtSprintName').val()) == true) {
                //    // alertify.set('notifier', 'position', 'top-right');
                //    strmsg = '- Sprint Name cannot contain any of these /\\:*?<>|,"+- Characters';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                //    checkvalue = 1;

                //}

                //Added By Riddhesh Patil on 11-NOV-2022 
                if (checkSpecialCharacter($("#txtSprintName").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Sprint Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtSprintName").focus();
                    Flag = 1;
                    checkvalue = 1;
                }
                //End of Added By Riddhesh Patil
            }
            else {

                $.ajax({
                    url: "frmProductBacklog.aspx/CheckIterationName",
                    data: JSON.stringify({ strIterationName: $("#txtSprintName").val(), strProjectID: ProjectID, flag: "Sprint" }),
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json",
                    async: false,
                    success: function (result) {
                        if (result.d != 0) {
                            strmsg = result.d;
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            /// checkvalue = 1;
                            if (checkvalue != 1) {
                                $("#txtSprintName").focus();
                            }
                            checkvalue = 1;
                        }
                    }
                })
            }
            if ($("#txtDescriptionS").val() != "") {
                //Added By Riddhesh Patil on 11-NOV-2022 
                if (checkSpecialCharacter($("#txtDescriptionS").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Sprint Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtDescriptionS").focus();
                    Flag = 1;
                    checkvalue = 1;
                }
                //End of Added By Riddhesh Patil
            }

            else if ($("#txtStartDateS").val() == "") {
                strmsg = '- Sprint Start Date should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                $("#txtStartDateS").focus();
                Flag = 1;
                checkvalue = 1;
            }

          else  if ($("#txtEndDateS").val() == "") {
                strmsg = '- Sprint End date should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                $("#txtEndDateS").focus();
                Flag = 1;
                checkvalue = 1;
            }

            // Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            var oldobjStartVal = dtStartDate.value;
            var oldobjEndVal = dtEndDate.value;
            var blnAlertExist = false;
            getInputDateFormat(dtStartDate, dtEndDate, 1, opDateFormat);

            // End of Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            
            if (CompairDates(dtStartDate, dtEndDate) == 1) {
                strmsg = '- Sprint End date should be greater than Sprint start date';
                errorMsg += "<li>" + strmsg + "</li></br>";
                $("#txtEndDateS").focus();
                blnAlertExist = true;
                Flag = 1;
                checkvalue = 1;

            }
            // Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            //if (checkvalue == 0) {
            if (checkvalue == 0 && dtsdt != undefined && dtedt != undefined) {
                // End of Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtsdt, EndDate: dtedt });
                // End of Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                var result = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);
                result = result.d;
                if (result != '') {
                    var arrResult = result.split('##');

                    if (arrResult[0] == '1') {
                        //dtStartDate.style.borderColor = 'red';
                        //dtStartDate.style.borderWidth = '1px';
                        //spandtStartDate.innerHTML = arrResult[1];

                        //checkvalue = 1;
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkvalue = 1;
                    }
                    if (arrResult[0] == '2') {

                        //dtEndDate.style.borderColor = 'red';
                        //dtEndDate.style.borderWidth = '1px';
                        //spandtEndDate.innerHTML = arrResult[1];

                        //checkvalue = 1;
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkvalue = 1;
                    }
                }
                // Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                dtStartDate.value = oldobjStartVal;
                dtEndDate.value = oldobjEndVal;
                // End of added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            }




            if (RestrictNonNumeric(document.getElementById('txtDurationCalendeS')) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
                errorMsg += "<li>" + strmsg + "</li></br>";
                $("#txtDurationCalendeS").focus();
                //alertify.notify('', 'error');
                checkvalue = 1;

            }

            if (RestrictNonNumeric(document.getElementById('txtDurationBusinessDayS')) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Please Enter only positive numeric value for Business Day"s" !!!';
                errorMsg += "<li>" + strmsg + "</li></br>";
                $("#txtDurationBusinessDayS").focus();
                //alertify.notify('', 'error');
                checkvalue = 1;

            }


            if ($("#txtEffortsS").val() == "") {
                strmsg = '- Efforts should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                if (blnAlertExist == false) {
                    $("#txtEffortsS").focus();
                }
                Flag = 1;
                checkvalue = 1;
            }

            //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
            //if ($("#txtEffortsS").val() != "") {
            //    if (RestrictNonNumeric(document.getElementById('txtEffortsS')) == true) {
            //        // alertify.set('notifier', 'position', 'top-right');
            //        strmsg = ' - Please Enter only positive numeric value for Efforts !!!';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        //alertify.notify('', 'error');
            //        checkvalue = 1;

            //    }
            //    else if (checkSpecialCharacter($('#txtEffortsS').val()) == true) {
            //        // alertify.set('notifier', 'position', 'top-right');
            //        strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //        checkvalue = 1;

            //    }


            //}
            if ($("#txtEffortsS").val() != "") {
                try {
                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("txtEffortsS");
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = ' - Please Enter only positive numeric value For Efforts in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        $("#txtEffortsS").focus();
                        blnHMFormat = false;
                        Flag = 1;
                        checkvalue = 1;
                    }

                    if (objHMEffort.value.indexOf(":") == -1) {
                        //strmsg = ' - Please enter efforts in valid format hh:mm!!';
                        //errorMsg += "<li>" + strmsg + "</li></br>";
                        //blnHMFormat = false;
                        ////setFocus(objHMEffort);
                        //Flag = 1;
                        //checkvalue = 1;
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
                        strmsg = ' - Efforts cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        $("#txtEffortsS").focus();
                        objHMEffort.value = objVal;
                        Flag = 1;
                        checkvalue = 1;
                    }

                    //if (blnResult == true) {
                    //    checkvalue = 1;
                    //}

                    //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById("txtEffortsS")) == true) {
                            strmsg = ' - Please enter Efforts in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            blnHMFormat = false;
                            $("#txtEffortsS").focus();
                            objHMEffort.value = objVal;
                            Flag = 1;
                            checkvalue = 1;
                        }
                    }
                    //if (blnResult == true) {
                    //    Flag = 1;
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
                            strmsg = " - Please enter Efforts in H:M format.";
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            $("#txtEffortsS").focus();
                            blnHMFormat = false;
                            Flag = 1;
                            checkvalue = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = ' - Hours should not be less than or equal to zero (0).';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            $("#txtEffortsS").focus();
                            blnHMFormat = false;
                            Flag = 1;
                            checkvalue = 1;
                        }

                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = ' - Please enter minutes in two decimal and less than 60.';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                $("#txtEffortsS").focus();
                                blnHMFormat = false;
                                Flag = 1;
                                checkvalue = 1;
                            }
                        }
                        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = ' - Please enter minutes between (0-59) range';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                $("#txtEffortsS").focus();
                                blnHMFormat = false;
                                Flag = 1;
                                checkvalue = 1;
                            }
                        }
                    }

                    //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                    //if (dtStartDate.value != "" && dtEndDate.value != "") {

                    //    var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;

                    //    var data = JSON.stringify({ HMHours: WorkHour });
                    //    var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
                    //    var dblTotalWork = decTotalWorkResult.d;

                    //    dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                    //    // alert(dblAvgHoursPerDay);
                    //    // alert(dblTotalDuration);
                    //    if (dblAvgHoursPerDay > 24) {    ///////////////////////////////////////////                           

                    //        strmsg = ' - You cannot assign more than 24 hours work per day';
                    //        errorMsg += "<li>" + strmsg + "</li></br>";
                    //        blnHMFormat = false;
                    //        isValid = 1;
                    //        checkFlag = 1;
                    //    }
                    //}
                    //End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

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
                                    if (blnHMFormat == true) {
                                        //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                                        strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                        errorMsg += "<li>" + strmsg + "</li></br>";
                                        Flag = 1;
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
            //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 


            var objCurrentIterationStartDate = dtStartDate.value;
            var objCurrentIterationEndDate = dtEndDate.value;

            // Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            //if (dtStartDate != null && dtEndDate != null) {
            if (dtStartDate != null && dtEndDate != null && (dtStartDate.value != "" && dtEndDate.value != "")) {
                // End of Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                // Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                //var oldobjStartVal = dtStartDate.value;
                //var oldobjEndVal = dtEndDate.value;

                //getInputDateFormat(dtStartDate, dtEndDate, 1);

                //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                // End of Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993               

                // Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Sprint" });
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtvsdt, EndDate: dtvedt, Flag: "Sprint" });
                // End of Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
                if (result1.d != '') {
                    strmsg = result1.d;
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify(result1.d, 'error', 15);
                    checkvalue = 1;

                }

                //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
                dtStartDate.value = oldobjStartVal;
                dtEndDate.value = oldobjEndVal;
                //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
            }


            if (checkvalue == 0) {
                var data = JSON.stringify({
                    strIterationID: "",
                    strEfforts: $('#txtEffortsS').val()
                })
                var strResultEfforts = AJAXCallWithResult("frmSprintPlanning.aspx/CheckSprintEfforts", data, false)
                if (strResultEfforts.d != '') {
                    checkvalue = 1;
                    strmsg = strResultEfforts.d;
                    errorMsg += "<li>" + strResultEfforts.d + "</li></br>";
                }
            }
            ////Added By Dipali V On  25th April 2018 
            //if ($("#SprinttxtStoryPoint").val() != "") {

            //    if (RestrictNonNumeric(document.getElementById('SprinttxtStoryPoint')) == true) {


            //        strmsg = '- Please Enter Numeric Value For Story Point';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        Flag = 1;
            //        checkvalue = 1;
            //    }
            //    if (parseFloat($("#SprinttxtStoryPoint").val()) < 0 && $("#SprinttxtStoryPoint").val() != '') {
            //        //alert('Please enter positive number');
            //        strmsg = '- Please enter positive Value For Story Point';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        Flag = 1;
            //        checkvalue = 1;
            //        $("#SprinttxtStoryPoint").focus();

            //    }

            //}
            ////End of Added By Dipali V On  25th April 2018 


            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkvalue;




        }

        /*Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/
        function validationSpritRelease() {
            try {

                var checkvalue = 0;
                var Flag = 0;
                var checkvalue = 0;
                var strmsg = "";
                var errorMsg = "<ul>"
                dtStartDate = document.getElementById("txtSRStartDate");
                dtEndDate = document.getElementById("txtSREndDate");

                var ProjectID = document.getElementById('hdnProjectID').value;
                if ($("#txtSRName").val() == "") {
                    strmsg = '- Sprint Name should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                var curSprintId = '';
                curSprintId = $(".clsIterationID").val();
                if ($("#txtSRName").val() != "") {


                    $.ajax({
                        url: "frmProductBacklog.aspx/CheckIterationNameOnUpdate",
                        data: JSON.stringify({ strIterationName: $("#txtSRName").val(), strProjectID: ProjectID, flag: "Sprint", IterationId: curSprintId }),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json",
                        async: false,
                        success: function (result) {
                            if (result.d != 0) {
                                strmsg = result.d;
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                Flag = 1;
                                /// checkvalue = 1;
                                if (checkvalue != 1) {
                                    $("#txtSRName").focus();
                                }
                                checkvalue = 1;
                            }
                        },
                        error: function (result) {

                        }
                    })
                }

                if ($("#txtSRStartDate").val() == "") {
                    strmsg = '- Sprint Start Date should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                if ($("#txtSREndDate").val() == "") {
                    strmsg = '- Sprint End date should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                if (CompairDates(dtStartDate, dtEndDate) == 1) {
                    strmsg = '- Sprint End date should be greater than Sprint start date';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;

                }

                if (checkvalue == 0) {
                    var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
                    var result = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);
                    result = result.d;
                    if (result != '') {
                        var arrResult = result.split('##');

                        if (arrResult[0] == '1') {

                            strmsg = '-' + arrResult[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkvalue = 1;
                        }
                        if (arrResult[0] == '2') {

                            strmsg = '-' + arrResult[1];
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkvalue = 1;
                        }
                    }

                }

                if (RestrictNonNumeric(document.getElementById('txtSRCalendersDuration')) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;

                }

                if (RestrictNonNumeric(document.getElementById('txtSRBusinessDuration')) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter only positive numeric value for Business Day"s" !!!';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;

                }


                if ($("#txtSREfforts").val() == "") {
                    strmsg = '- Efforts should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }

                //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                //if ($("#txtEffortsS").val() != "") {
                //    if (RestrictNonNumeric(document.getElementById('txtEffortsS')) == true) {
                //        // alertify.set('notifier', 'position', 'top-right');
                //        strmsg = ' - Please Enter only positive numeric value for Efforts !!!';
                //        errorMsg += "<li>" + strmsg + "</li></br>";
                //        //alertify.notify('', 'error');
                //        checkvalue = 1;

                //    }
                //    else if (checkSpecialCharacter($('#txtEffortsS').val()) == true) {
                //        // alertify.set('notifier', 'position', 'top-right');
                //        strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
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
                            strmsg = ' - Please Enter only positive numeric value For Efforts in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            Flag = 1;
                            checkvalue = 1;
                        }

                        if (objHMEffort.value.indexOf(":") == -1) {
                            //strmsg = ' - Please enter efforts in valid format hh:mm!!';
                            //errorMsg += "<li>" + strmsg + "</li></br>";
                            //blnHMFormat = false;
                            ////setFocus(objHMEffort);
                            //Flag = 1;
                            //checkvalue = 1;
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
                            strmsg = ' - Efforts cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');

                            objHMEffort.value = objVal;
                            Flag = 1;
                            checkvalue = 1;
                        }

                        //if (blnResult == true) {
                        //    checkvalue = 1;
                        //}

                        //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                        if (blnHMFormat == true) {
                            if (RestrictNonNumeric(document.getElementById("txtSREfforts")) == true) {
                                strmsg = ' - Please enter Efforts in H:M format.';
                                errorMsg += "<li>" + strmsg + "</li>";
                                blnHMFormat = false;
                                objHMEffort.value = objVal;
                                Flag = 1;
                                checkvalue = 1;
                            }
                        }
                        //if (blnResult == true) {
                        //    Flag = 1;
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
                                strmsg = " - Please enter Efforts in H:M format.";
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                Flag = 1;
                                checkvalue = 1;
                            }

                            if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                                strmsg = ' - Hours should not be less than or equal to zero (0).';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                Flag = 1;
                                checkvalue = 1;
                            }

                            // Added By sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                            if (blnHMFormat == true) {
                                if (mins.length > 2) {
                                    strmsg = ' - Please enter minutes in two decimal and less than 60.';
                                    errorMsg += "<li>" + strmsg + "</li></br>";
                                    blnHMFormat = false;
                                    Flag = 1;
                                    checkvalue = 1;
                                }
                            }
                            // End of Added By sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                            if (blnHMFormat == true) {
                                if (mins > 59 || mins < 0) {
                                    strmsg = ' - Please enter minutes between (0-59) range';
                                    errorMsg += "<li>" + strmsg + "</li></br>";
                                    blnHMFormat = false;
                                    Flag = 1;
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
                                        if (blnHMFormat == true) {
                                            //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                                            strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                            errorMsg += "<li>" + strmsg + "</li></br>";
                                            Flag = 1;
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
                //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 




                if (dtStartDate != null && dtEndDate != null) {

                    //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Sprint" });
                    //var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
                     // Commneted and added by Chetan M on 12 Dec 2020 for Issue fixing
                    //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Sprint"});
                    var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Sprint", IterationID: GlobalIterationIDNew });
                    //var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
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
                }


                if (checkvalue == 0) {
                    var data = JSON.stringify({
                        strIterationID: "",
                        strEfforts: $('#txtSREfforts').val()
                    })
                    var strResultEfforts = AJAXCallWithResult("frmSprintPlanning.aspx/CheckSprintEfforts", data, false)
                    if (strResultEfforts.d != '') {
                        checkvalue = 1;
                        strmsg = strResultEfforts.d;
                        errorMsg += "<li>" + strResultEfforts.d + "</li></br>";
                    }
                }

                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error', 5);

                }
                return checkvalue;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        /*End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed*/


        var isValid = 0, ID = 0;
        function validateTask(ID) {
            // debugger;

            //Added by Kashish s On 20 Aug 2018 for checking duplicate date validation message
            var blnChkDateValidation = false;
            //End of Added by Kashish s On 20 Aug 2018 for checking duplicate date validation message


            var checkFlag = 0;
            // debugger;
            var strmsg = "";
            var errorMsg = "<ul>"
            var dtStartDate = "", dtEndDate = "";
            var ProjectID = document.getElementById('hdnProjectID').value;
            var InitialEstimate = $("#txtStoryPoint").val();
            var htRowCount = document.getElementsByName("hdrownumber");
            // alert(InitialEstimate);

            if (ID == 0) {
                for (var i = 0; i < htRowCount.length; i++) {
                    if (htRowCount[i] != null) {
                        //if ($("#txtReviewtitle" + htRowCount[i].value).val() == 0) {
                        //    Flag = 1;
                        //    checkFlag = 1;
                        //    $("#txtReviewtitle" + htRowCount[i].value).css("border", "1px solid red");
                        //}
                        dtStartDate = document.getElementsByName("txtStartDate" + htRowCount[i].value);
                        dtEndDate = document.getElementsByName("txtEndDate" + htRowCount[i].value);

                        if ($("#txtTaskName" + htRowCount[i].value).val() == "") {
                            strmsg = '- Task Name should not  be left blank.';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            //$("#txtTaskName" + htRowCount[i].value).focus();
                        }


                        if ($("#txtStartDate" + htRowCount[i].value).val() == "") {
                            strmsg = '- Start Date should not  be left blank';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            // $("#txtStartDate" + htRowCount[i].value).focus();
                        }

                        if ($("#txtEndDate" + htRowCount[i].value).val() == "") {
                            strmsg = '- End Date should not  be left blank';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            //$("#txtEndDate" + htRowCount[i].value).focus();
                        }


                        //if (CompairDates(dtStartDate, dtEndDate) == 1) {
                        //    strmsg = '- Task Start date should not be less than Task End date';
                        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //    isValid = 1;
                        //    checkFlag = 1;
                        //    //$("#txtReviewEnddate").focus();

                        //}


                        if ($("#txtEndDate" + htRowCount[i].value).val() != '' && $("#txtStartDate" + htRowCount[i].value).val() != '' && checkFlag == 0) {
                            if (CompairDates1($("#txtStartDate" + htRowCount[i].value).val(), $("#txtEndDate" + htRowCount[i].value).val()) == 1 && CompairDates1($("#txtStartDate" + htRowCount[i].value).val(), $("#txtEndDate" + htRowCount[i].value).val()) != 0) {
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

                        
                        //Commented and Added by Usha Pandit on 06.06.2019 for sprint start date and end date validation
                        //if (checkFlag == 0) {
                        //    var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + htRowCount[i].value).val(), EndDate: $("#txtEndDate" + htRowCount[i].value).val() });
                        //    var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                        //    if (Newresult.d != '') {
                        //        var arrResult = Newresult.d.split('##');

                        //        if (arrResult[0] == '1') {


                        //            strmsg = '-' + arrResult[1];
                        //            errorMsg += "<li>" + strmsg + "</li></br>";
                        //            isValid = 1;
                        //            checkFlag = 1;
                        //        }
                        //        if (arrResult[0] == '2') {
                        //            strmsg = '-' + arrResult[1];
                        //            errorMsg += "<li>" + strmsg + "</li></br>";
                        //            isValid = 1;
                        //            checkFlag = 1;
                        //        }

                        //        //if (arrResult[0] == '3') {
                        //        //    strmsg = '-' + arrResult[1];
                        //        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //        //    isValid = 1;
                        //        //    checkFlag = 1;
                        //        //}
                        //    }

                        //}


                        ////if (dtEndDate.value != '' && dtEndDate.value != undefined)
                        //if ($("#txtEndDate" + htRowCount[i].value).val() != '') {
                        //    var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + htRowCount[i].value).val(), strEndDate: $("#txtEndDate" + htRowCount[i].value).val() }), false);
                        //    if (result.d != "") {
                        //        var strMsg = String(result.d).split("_");
                        //        //Added by Kashish s On 20 Aug 2018 for checking duplicate date validation message
                        //        blnChkDateValidation = true;
                        //        //End of Added by Kashish s On 20 Aug 2018 for checking duplicate date validation message
                        //        if (strMsg[0] == "1") {
                        //            // $('#spndtStartDate').text(strMsg[1]);
                        //            strmsg = '- ' + strMsg[1];
                        //            errorMsg += "<li>" + strmsg + "</li></br>";

                        //        }
                        //        else {
                        //            //$('#spndtEndDate').text(strMsg[1]);
                        //            strmsg = '- ' + strMsg[1];
                        //            errorMsg += "<li>" + strmsg + "</li></br>";

                        //        }
                        //        isValid = 1;
                        //        checkFlag = 1;
                        //    }
                        //}

                        if ($("#txtEndDate" + htRowCount[i].value).val() != '' && checkFlag == 0) {
                            var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + htRowCount[i].value).val(), strEndDate: $("#txtEndDate" + htRowCount[i].value).val() }), false);
                            if (result.d != "") {
                                var strMsg = String(result.d).split("_");
                               
                                blnChkDateValidation = true;
                                
                                if (strMsg[0] == "1") {
                                    strmsg = '- ' + strMsg[1];
                                    errorMsg += "<li>" + strmsg + "</li></br>";

                                }
                                else {
                                    strmsg = '- ' + strMsg[1];
                                    errorMsg += "<li>" + strmsg + "</li></br>";

                                }
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }

                         if (checkFlag == 0) {
                            var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + htRowCount[i].value).val(), EndDate: $("#txtEndDate" + htRowCount[i].value).val() });
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
                            }

                        }                        
                        
                        //End of Added by Usha Pandit on 06.06.2019 for sprint start date and end date validation
                        if ($("#txtWorkHrs" + htRowCount[i].value).val() == "") {
                            strmsg = '- Work(Hrs) should not  be left blank';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            //$("#txtWorkHrs" + htRowCount[i].value).focus();
                        }

                        if ($("#txtWorkHrs" + htRowCount[i].value).val() != "" && checkFlag == 0) {
                            //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 
                            //if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + htRowCount[i].value)) == true) {


                            //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                            //    errorMsg += "<li>" + strmsg + "</li></br>";
                            //    isValid = 1;
                            //    checkFlag = 1;
                            //}

                            //else if (($("#txtWorkHrs" + htRowCount[i].value).val() - 0) == 0) {
                            //    //Added by kashish on 20-8-2018 for task planning alignment
                            //    if ($("#txtWorkHrs" + htRowCount[i].value).val() != "") {
                            //    strmsg = '- Please Enter Work(Hrs) greater than 0';
                            //    errorMsg += "<li>" + strmsg + "</li></br>";
                            //    isValid = 1;
                            //    checkFlag = 1;
                            //    }
                            //}

                            //else if (parseFloat($("#txtWorkHrs" + htRowCount[i].value).val()) < 0 && $("#txtWorkHrs" + htRowCount[i].value).val() != '') {

                            //    strmsg = '- Please enter positive Value For  Work(Hrs)';
                            //    errorMsg += "<li>" + strmsg + "</li></br>";
                            //    isValid = 1;
                            //    checkFlag = 1;
                            //    //$("#txtWorkHrs").focus();

                            //}

                            try {
                                var blnHMFormat = true;
                                var objHMEffort = document.getElementById("txtWorkHrs" + htRowCount[i].value);
                                var objVal = objHMEffort.value;
                                var objnewVal = objHMEffort.value;

                                objHMEffort.value = objHMEffort.value.replace(":", ".");
                                var isdigit = isNumeric(objHMEffort.value);
                                objHMEffort.value = objVal;

                                if (isdigit == false) {
                                    strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                                    errorMsg += "<li>" + strmsg + "</li></br>";
                                    blnHMFormat = false;
                                    isValid = 1;
                                    checkFlag = 1;
                                }

                                if (objHMEffort.value.indexOf(":") == -1) {
                                    //strmsg = 'Please enter efforts in valid format hh:mm!!';
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
                                    errorMsg += "<li>" + strmsg + "</li></br>";
                                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                                    objHMEffort.value = objVal;
                                    isValid = 1;
                                    checkFlag = 1;
                                }


                                //if (blnResult == true) {
                                //    isValid = 1;
                                //    checkFlag = 1;
                                //}

                                //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                                if (blnHMFormat == true) {
                                    if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + htRowCount[i].value)) == true) {
                                        strmsg = 'Please enter Work(Hrs) in H:M format.';
                                        errorMsg += "<li>" + strmsg + "</li></br>";
                                        blnHMFormat = false;
                                        objHMEffort.value = objVal;
                                        isValid = 1;
                                        checkFlag = 1;
                                    }
                                }

                                //if (blnResult == true) {
                                //    isValid = 1;
                                //    checkFlag = 1;
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
                                        errorMsg += "<li>" + strmsg + "</li></br>";
                                        blnHMFormat = false;
                                        isValid = 1;
                                        checkFlag = 1;
                                    }

                                    if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                                        strmsg = 'Hours should not be less than or equal to zero (0).';
                                        errorMsg += "<li>" + strmsg + "</li></br>";
                                        blnHMFormat = false;
                                        isValid = 1;
                                        checkFlag = 1;
                                    }

                                    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                                    if (blnHMFormat == true) {
                                        if (mins.length > 2) {
                                            strmsg = 'Please enter minutes in two decimal and less than 60.';
                                            errorMsg += "<li>" + strmsg + "</li></br>";
                                            blnHMFormat = false;
                                            isValid = 1;
                                            checkFlag = 1;
                                        }
                                    }
                                    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                                    if (blnHMFormat == true) {
                                        if (mins > 59 || mins < 0) {
                                            strmsg = 'Please enter minutes between (0-59) range';
                                            errorMsg += "<li>" + strmsg + "</li></br>";
                                            blnHMFormat = false;
                                            isValid = 1;
                                            checkFlag = 1;
                                        }
                                    }
                                }


                                //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                                dtStartDate = document.getElementById("txtStartDate0");
                                dtEndDate = document.getElementById("txtEndDate0");

                                if (dtStartDate.value != "" && dtEndDate.value != "") {

                                    var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;

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

                            //End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

                            if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + htRowCount[i].value)) == false && (objHMEffort.value.indexOf(":") != -1)) {
                                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationEfforts', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strEfforts: $("#txtWorkHrs" + htRowCount[i].value).val(), strTaskID: "" }), false);

                                if (result.d != "") {
                                    //Added by Kashish s On 20 Aug 2018 for checking duplicate date validation message
                                    if (blnChkDateValidation == false) {
                                        //End of Added by Kashish s On 20 Aug 2018 for checking duplicate date validation message
                                        strmsg = '- ' + result.d;
                                        errorMsg += "<li>" + strmsg + "</li></br>";
                                        isValid = 1;
                                        checkFlag = 1;
                                        //$("#txtWorkHrs").focus();
                                    }
                                }
                            }
                        }


                        if ($("#txtStoryPoints" + htRowCount[i].value).val() != "") {
                            if (RestrictNonNumeric(document.getElementById('txtStoryPoints' + htRowCount[i].value)) == true) {


                                strmsg = '- Please Enter only positive numeric value For Story Point';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                isValid = 1;
                                checkFlag = 1;
                            }
                            else {
                                var n = $("#txtStoryPoints" + htRowCount[i].value).val();
                                var result = (n - Math.floor(n)) !== 0;

                                if (result) {
                                    strmsg = '- Please enter Story Points without decimal';
                                    errorMsg += "<li>" + strmsg + "</li></br>";
                                    isValid = 1;
                                    checkFlag = 1;
                                }
                            }
                        }
                        //commented by kashish on 20-8-2018 for task planning alignment
                        //if ($("#txtStoryPoints" + htRowCount[i].value).val() == "0") {


                        //    strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //    isValid = 1;
                        //    checkFlag = 1;
                        //}





                        //var InitialEstimate = ($("#txtStoryPoint").val() - 0);
                        //if (InitialEstimate != 0) {
                        //    if (($("#txtStoryPoints" + htRowCount[i].value).val() - 0) > InitialEstimate) {

                        //        strmsg = '- Story Point should be less than ' + InitialEstimate + '(assigned on User story)';
                        //        errorMsg += "<li>" + strmsg + "</li></br>";
                        //        isValid = 1;
                        //        checkFlag = 1;
                        //    }
                        //}



                        if ($("#cboTaskType" + htRowCount[i].value).val() == "Select TaskType") {
                            strmsg = '- Task Type should not be left blank';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            //$("#cboTaskType" + htRowCount[i].value).focus();
                        }

                        if ($("#cboresource" + htRowCount[i].value).val() == "0") {
                            strmsg = '- Resource should not be left blank';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            isValid = 1;
                            checkFlag = 1;
                            //$("#cboresource" + htRowCount[i].value).focus();
                        }


                        //alert($("#hdnusid").val());


                        if (checkFlag == 0) {
                            var TaskID = "";
                            var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints" + htRowCount[i].value).val(), TaskID: "" });
                            var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);
                            // alert(Newresult.d);
                            if (Newresult.d != '') {
                                strmsg = Newresult.d;
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                isValid = 1;
                                checkFlag = 1;
                                $("#txtStoryPoints" + htRowCount[i].value).focus();
                            }
                        }


                        //if ($("#cboPrioritytask").val() == "") {
                        //    strmsg = '- Priority should not left blank';
                        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //    Flag = 1;
                        //    checkFlag = 1;
                        //    $("#cboPrioritytask").focus();
                        //}



                        //if ($("#cboTtypetask").val() == "") {
                        //    strmsg = '- Task Type  should not left blank';
                        //    errorMsg += "<li>" + strmsg + "</li></br>";
                        //    Flag = 1;
                        //    checkFlag = 1;
                        //    $("#cboTtypetask").focus();
                        //}




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

        function validateissue() {
            var checkFlag = 0;
            var Flag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"


            if ($("#txtSummary").val() == "") {
                strmsg = '- Summary should not be left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#txtSummary").focus();
            }

            if ($("#txtDescription").val() == "") {
                strmsg = '- Description should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#txtDescription").focus();
            }

            if ($("#cboIssueType").val() == "" || $("#cboIssueType").val() == null) {
                strmsg = '- Issue Type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboIssueType").focus();
            }

            if ($("#cboSubIssueType").val() == "" || $("#cboSubIssueType").val() == null) {
                strmsg = '- Sub Issue Type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboSubIssueType").focus();
            }

            if ($("#cboreporter").val() == "" || $("#cboreporter").val() == null) {
                strmsg = '- Reported By should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboreporter").focus();
            }

            if ($("#cboResonsible").val() == "") {
                strmsg = '- Resonsible Person should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboResonsible").focus();
            }

            if ($("#cboStatus").val() == "") {
                strmsg = '- Status should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboStatus").focus();
            }


            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkFlag;


        }

        function validateReview() {
            // debugger;
            var checkFlag = 0;
            var Flag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var dtStartDate, dtEndDate;
            var ProjectID = document.getElementById('hdnProjectID').value;
            dtStartDate = document.getElementById("txtReviewStartDate");
            dtEndDate = document.getElementById("txtReviewEnddate");

            if ($("#txtReviewtitle").val() == "") {
                strmsg = '- Review title should not be left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#txtReviewtitle").focus();
            }

            if ($("#cboReviewtype").val() == "") {
                strmsg = '- Review type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboReviewtype").focus();
            }
            //Added By Dipali On 23rd April 2018 For Validate new Fiedls Work Hrs


            if ($("#txtReviewStartDate").val() == "") {
                strmsg = '- Review Start Date should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                // $("#txtReviewStartDate").focus();
            }

            if ($("#txtReviewEnddate").val() == "") {
                strmsg = '- Review End date should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                // $("#txtReviewEnddate").focus();
            }

            if (CompairDates(dtStartDate, dtEndDate) == 1) {
                strmsg = '- Review Start date should be less than Review End date';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                //$("#txtReviewEnddate").focus();

            }
           
             //Added by Usha Pandit on 07.06.2019 for checking sprint start date and end date validation
            if (dtStartDate.value != '' && checkFlag == 0) {
              
                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: $("#hdnUserStoryID2").val(), strStartDate: dtStartDate.value, strEndDate: dtEndDate.value }), false);
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
                    Flag = 1;
                    checkFlag = 1;
                }
            }
            //Added by Usha Pandit on 07.06.2019 for checking sprint start date and end date validation
            // debugger;
            if (checkFlag == 0) {
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
                var result = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                if (result.d != '') {
                    var arrResult = result.d.split('##');

                    if (arrResult[0] == '1') {


                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkFlag = 1;
                    }
                    if (arrResult[0] == '2') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkFlag = 1;
                    }

                    if (arrResult[0] == '3') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        checkFlag = 1;
                    }
                }

            }

            if ($("#cboReviewer").val() == "") {
                strmsg = '- Reviewer should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboReviewer").focus();
            }

            if ($("#cboReviewee").val() == "") {
                strmsg = '- Reviewee should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboReviewee").focus();
            }

            if ($("#cboRevieStatus").val() == "" || $("#cboRevieStatus").val() == null) {
                strmsg = '- Status should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#cboRevieStatus").focus();
            }

            if ($("#txtReviewHrs").val() == "") {
                strmsg = '- Work Hrs should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#txtReviewHrs").focus();
            }

            if ($("#txtReviewHrs").val() != "" && checkFlag == 0) {
                //Commented and added by Ankush T on 29 mar 2019 work field changes

                //if (RestrictNonNumeric(document.getElementById('txtReviewHrs')) == true) {


                //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //}


                //else if (($("#txtReviewHrs").val() - 0) == 0) {
                //    strmsg = '- Work(Hrs) should be  more than 0';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    Flag = 1;
                //    checkFlag = 1;
                //}

                //else if (($("#txtReviewHrs").val() - 0) > 24) {
                //    strmsg = '-  one day you can assign only 24 hrs';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    Flag = 1;
                //    checkFlag = 1;
                //}

                //else if (parseFloat($("#txtReviewHrs").val()) < 0 && $("#txtReviewHrs").val() != '') {
                //    //alert('Please enter positive number');
                //    // alertify.set('notifier', 'position', 'top-right');
                //    // alertify.notify('- Please enter positive Value For Category Order.', 'error');
                //    strmsg = '- Please enter positive Value For Work(Hrs)';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    Flag = 1;
                //    checkFlag = 1;
                //    $("#txtReviewHrs").focus();

                //}
                //debugger;
                var blnHMFormat = true;
                var objHMEffort = document.getElementById('txtReviewHrs');
                var objVal = objHMEffort.value;
                var objnewVal = objHMEffort.value;

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                var isdigit = isNumeric(objHMEffort.value);
                objHMEffort.value = objVal;
                if (blnHMFormat == true) {
                    if (isdigit == false) {
                        strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }
                }

                if (objHMEffort.value.indexOf(":") == -1) {
                    //strmsg = 'Please enter efforts in valid format hh:mm!!';
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
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    objHMEffort.value = objVal;
                    isValid = 1;
                    checkFlag = 1;
                }

                //if (blnResult == true) {
                //    isValid = 1;
                //    checkFlag = 1;
                //}

                //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                if (blnHMFormat == true) {
                    if (RestrictNonNumeric(document.getElementById('txtReviewHrs')) == true) {
                        strmsg = 'Please enter Work(Hrs) in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        objHMEffort.value = objVal;
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
                //if (blnResult == true) {
                //    isValid = 1;
                //    checkFlag = 1;
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
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                        strmsg = 'Hours should not be less than or equal to zero (0).';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                    if (blnHMFormat == true) {
                        if (mins.length > 2) {
                            strmsg = 'Please enter minutes in two decimal and less than 60.';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }
                    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                    if (blnHMFormat == true) {
                        if (mins > 59 || mins < 0) {
                            strmsg = 'Please enter minutes between (0-59) range';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }
                }

                //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                if (dtStartDate.value != "" && dtEndDate.value != "") {

                    var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;

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
                //End of Commented and added by Ankush T on 29 mar 2019 work field changes
            }
            //End of Added By Dipali On 23rd April 2018 For Validate new Fiedls Work Hrs



            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkFlag;


        }
 		var Type, SubType, Status;
        function GetSelectedSubtype(obj) {
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

            var url = "frmProductBacklog.aspx/GetSubType";

            data = JSON.stringify({ TypeID: obj.value, WhichList: 'SubType' });
            CustomAJAXCall(url, data, BindDropdownSubType);

            IssueField = document.getElementById("cboIssueType").value;
            if (IssueField != "") {
                var url = "frmProductBacklog.aspx/GetStatus";
                data = JSON.stringify({ ProjectID: projectid, Issue_Type: obj.value });
                CustomAJAXCall(url, data, BindStatus);

            }


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

            // objCbo1.value = result.d;

        }

        function BindDropdownSubType(result) {


            var strArray = String(result.d).split("|")
            objCbo1 = document.getElementById("cboSubIssueType");


            var i = 0;

            var url = "frmProductBacklog.aspx/GetDefaultValues";
            data = JSON.stringify({ strResult: document.getElementById("cboSubIssueType").value });
            var result = AJAXCallWithResult(url, data, true);



            objCbo1.innerHTML = "";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = obj.FieldID;
                objOption.value = obj.FieldName;

            });

            objCbo1.value = result.d;



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
        function Export_onclick(flag, format, EntityID) {
            var objform;
            format = format.toUpperCase();
            var strExportResult = ajaxCall("frmSprintPlanning.aspx/ExportToExcel", "POST", "application/json", "json", JSON.stringify({ ReportFormat: format, Entity: flag, EntityID: EntityID }));

            if (strExportResult.d != "") {
                //alert(strExportResult.d);
            }
            window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strExportResult.d, "_report", "");
        }

        function ClearSpans() { }


        function AJAXCallWithPara(url, data, method, para) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                //timeout: 180000,
                success: function (result) {
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

        }




        function Document_OnClick(strSystemFileName, strOriginalFileName) {           
            // debugger;
            var strTemp = '../General/ViewAttachment.aspx?FromWhere=Agile&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;
            window.open(strTemp);
        }



        function insertuserStoryDiscussion(UniqueID, Flag, obj, txtID) {
            if ($("#DiscussionTextArea").val() != "") {
                if (checkSpecialCharacter($('#DiscussionTextArea').val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Discussion should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#DiscussionTextArea").focus();
                    loginFlag = false;
                }
                else {
                    var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
                    document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                    $("#spanpost").html('');
                    AutoResizeTextArea();
                    getRows();
                    RemoveTextArea();
                    $("#spanpost").html('Post');
                    $("#DiscussionTextArea").val('');
                    $("#DiscussionTextArea").attr("placeholder", "Post New Discussion");
                    $("#collapse_" + strnewDiscussionID).addClass('in');


                    //  $("#FreeTextBox_editor").html('');
                    DiscussionID = 0;
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $("#SprintReleaseAddDiscussion").attr('disabled');
                    // RefreshBothTable(UserStoryID, IterationID);
                }
            }
            else {
                $("#DiscussionTextArea").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Enter Discussion', 'error', 5);
            }
        }

        function reply_onclick(userstoryID, discussionID, Flag) {
            //if ($("#DiscussionTextArea").val() != "") {
            AutoResizeTextArea();
            getRows();
            RemoveTextArea();
            strnewDiscussionID = discussionID;
            $("#DiscussionTextArea").focus();
            //  Added & Commented by dipali v on 6th may 2019 for plceholder issue
            // $("#DiscussionTextArea").prop("placeholder", "Reply New Discussion");
            $("#DiscussionTextArea").prop("placeholder", "Reply to discussion");
           
            $("#spanpost").html('Reply');
            $("#DiscussionTextArea").prop("placeholder", "Reply to discussion");
            // $("#DiscussionTextArea").prop("placeholder", "Reply New Discussion");
            // End of  Added & Commented by dipali v on 6th may 2019 for plceholder issue
            DiscussionID = discussionID;
            $('[data-bs-toggle="tooltip"]').tooltip();
            //$("#SprintReleaseAddDiscussion").css('display','block');
            $("#SprintReleaseAddDiscussion").removeAttr('disabled');


            //}
            //else {
            //    $("#DiscussionTextArea").focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('-Please Add Discussion', 'error', 25);
            //}
        }

        function AddNewDiscussion(UniqueID, Flag, obj, txtID) {

            var DiscussionID = 0; strnewDiscussionID = 0;
            if ($("#DiscussionTextArea").val() != "") {
                if (checkSpecialCharacter($('#DiscussionTextArea').val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Discussion should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#DiscussionTextArea").focus();
                    return false;
                }
                else {
                    var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
                    document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                    $("#spanpost").html('');
                    AutoResizeTextArea();

                    RemoveTextArea();
                    $("#spanpost").html('Post');
                    $("#DiscussionTextArea").val('');
                    $("#DiscussionTextArea").prop("placeholder", "Post New Discussion");
                    $("#collapse_" + strnewDiscussionID).addClass('in');


                    //  $("#FreeTextBox_editor").html('');
                    DiscussionID = 0;
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $("#SprintReleaseAddDiscussion").attr('disabled');
                    $("#DiscussionTextArea").val("");
                }
            }
            else {
                $("#DiscussionTextArea").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Add Discussion', 'error', 5);
            }

        }


        function AddNewDiscussionSR(UniqueID, Flag, obj, txtID) {

            var DiscussionID = 0; strnewDiscussionID = 0;
            if ($("#txtDiscussions").val() != "") {

                var strUserResult = ajaxCall("frmSprintPlanning.aspx/SaveDiscussionSR", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
                document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult.d;
                $("#spanpost").html('');
                $("#spanpost").html('Post');
                $("#txtDiscussions").val('');
                $("#collapse_" + strnewDiscussionID).addClass('in');


                //  $("#FreeTextBox_editor").html('');
                DiscussionID = 0;
                $('[data-bs-toggle="tooltip"]').tooltip();
                $("#SprintReleaseAddDiscussion").attr('disabled');
                $("#txtDiscussions").val("");


            }
            else {
                $("#txtDiscussions").focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Add Discussion', 'error', 5);
            }

        }




        function IssueType_OnChange(obj) {


            // debugger;
            IssueField = document.getElementById("cboIssueType").value;
            projectid = obj;


            var url = "frmProductBacklog.aspx/GetDropDownValue";
            data = JSON.stringify({ ProjectID: projectid, WhichList: "IssueType", Mode: 'New', Issue_Type: IssueField });
            CustomAJAXCall(url, data, BindDropDownValues);
            data = JSON.stringify({ ProjectID: projectid, WhichList: "Reporter", Mode: 'New', Issue_Type: IssueField });
            CustomAJAXCall(url, data, BindDropDownValues1);
            IssueField = document.getElementById("cboIssueType").value;

            var url = "frmProductBacklog.aspx/GetDropDownValue";
            data = JSON.stringify({ ProjectID: projectid, WhichList: 'SubType', Mode: 'New', Issue_Type: IssueField });
            CustomAJAXCall(url, data, BindDropdownSubType);

        }



        function BindDropDownValues(result) {


            var strArray = String(result.d).split("|")


            objCbo = document.getElementById("cboIssueType");

            var i = 0;

            objCbo.innerHTML = "";

            var url = "frmProductBacklog.aspx/GetDefaultType";
            data = JSON.stringify({ strResult: $("#hdnProjectID").val() });
            var result1 = AJAXCallWithResult(url, data, false);

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.FieldID;
                objOption.value = obj.FieldName;

            });
            //$("#cboIssueType").val(result1.d);
            objCbo.value = result1.d;
            //objCbo.options[objCbo.selectedIndex].text = result1.d;
            if (document.getElementById('btnMainSave') != null) {
                var s = "document.getElementById('btnMainSave').onclick = function(){  " + strArray[2] + ";  SaveOnClick(); }; ";
                addCode(s);
            }

        }


        function addCode(code) {
            var JS = document.createElement('script');
            JS.text = code;
            document.body.appendChild(JS);
        }

        function BindDropDownValues1(result) {
            //alert(result.d);
            var strArray = String(result.d).split("|")
            objCbo1 = document.getElementById("cboreporter");
            var i = 0;

            objCbo1.innerHTML = "";
            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = obj.UserName;
                objOption.value = obj.UserName;

            });

            //document.getElementById("cboreporter").value = $("#hdnStrReporter").val();
            $("#cboreporter").val($("#hdnstrUserName").val());
            // $('#cboReviewer').val($("#hdnstrUserName").val());

        }

        function BindDropdownSubType(result) {
            var strArray = String(result.d).split("|")
            objCbo1 = document.getElementById("cboSubIssueType");
            //document.getElementById("PlotDynamic_Control").innerHTML = "";
            //document.getElementById("PlotDynamic_Control").innerHTML = strArray[1];
            //var s = "document.getElementById('btnMainSave').onclick = function(){  " + strArray[2] + ";  SaveOnClick(); }; ";
            if (document.getElementById('btnMainSave') != null) {
                var s = "document.getElementById('btnMainSave').onclick = function(){  " + strArray[2] + ";  SaveOnClick(); }; ";
                addCode(s);
            }

            var i = 0;
            objCbo1.innerHTML = "";
            var url = "frmProductBacklog.aspx/GetDefaultValues";
            data = JSON.stringify({ strResult: document.getElementById("cboIssueType").value });
            var result1 = AJAXCallWithResult(url, data, false);



            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = obj.FieldID;
                objOption.value = obj.FieldName;

            });


            //$("#cboSubIssueType").val(result1.d);
            objCbo1.value = result1.d;
            //  objCbo1.options[objCbo1.selectedIndex].text = result1.d;
        }

        function GetSelectedSubtype(obj) {
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

            var url = "frmProductBacklog.aspx/GetSubType";

            data = JSON.stringify({ TypeID: obj.value, WhichList: 'SubType' });
            CustomAJAXCall(url, data, BindDropdownSubType);

            IssueField = document.getElementById("cboIssueType").value;
            if (IssueField != "") {
                var url = "frmProductBacklog.aspx/GetStatus";
                data = JSON.stringify({ ProjectID: projectid, Issue_Type: obj.value });
                CustomAJAXCall(url, data, BindStatus);

            }


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

            // objCbo1.value = result.d;

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



        var ResoureIDs = "";
        function SelectResource(object, EmployeeID, EmployeeName) {

            $("#cboReviewee").val('');
            $(".k-checkbox").each(function () {
                if ($(this).prop('checked')) {
                    var value = $(this).val();
                    // var ResoureName = value.split(",")
                    // var ResoureIDAll = ResoureName[1];

                    //$("#cboReviewee").val($("#cboReviewee").val() + ResoureName + ',');
                    $("#cboReviewee").val($("#cboReviewee").val() + value + ',');
                    // alert($("#cboReviewee").val());
                    //ResoureIDs.push(ResoureIDAll)
                    if (ResoureIDs == undefined) {
                        ResoureIDs = '';
                    }
                    if (ResoureIDs.indexOf($("#hdnresourceID" + EmployeeID).val()) == -1) {
                        ResoureIDs = ResoureIDs + $("#hdnresourceID" + EmployeeID).val() + ','
                        ResoureallIDs = ResoureIDs;
                    }

                    // alert(ResoureallIDs);
                    // $(this).css("background-color", "#3c7dcf");
                    //  $(".dropdown-menu li").addClass('activecls');
                    $(this).find('li').addClass('activecls');
                }
                else {
                    // $(".dropdown-menu li").addClass('activecls');
                    $(this).find('li').removeClass('activecls');
                }
            });

        }


        var Reviwers = "";
        function SelectReviwer(object, EmployeeID, EmployeeName) {

            $("#cboReviewer").val('');
            $(".k-checkboxcboReviewer").each(function () {
                if ($(this).prop('checked')) {
                    var value = $(this).val();
                    //  $('#cboReviewer').val($("#hdnstrUserName").val());
                    // $("#cboReviewer").val($("#hdnstrUserName").val() + ',' + value + ',');
                    $("#cboReviewer").val($("#cboReviewer").val() + value + ',');
                    if (Reviwers == undefined) {
                        Reviwers = '';
                    }

                    if (Reviwers.indexOf($("#hdnReviwerID" + EmployeeID).val()) == -1) {
                        //Reviwers = Reviwers + $("#hdnReviwerID" + EmployeeID).val() + ','
                        Reviwers = Reviwers + $("#hdnReviwerID" + EmployeeID).val() + ','
                        // $('#cboReviewer').val($("#hdnstrUserName").val());
                    }


                    // $(this).css("background-color", "#3c7dcf");
                    //  $(".dropdown-menu li").addClass('activecls');
                    $(this).find('li').addClass('activecls');
                }
                else {
                    // $(".dropdown-menu li").addClass('activecls');
                    $(this).find('li').removeClass('activecls');
                }
            });

        }



        function validateupdatetask(TaskID) {
            // debugger;
            var strmsg = "";
            var checkFlag = 0;
            var ProjectID = document.getElementById('hdnProjectID').value;
            var errorMsg = "<ul>"
            var dtStartDate = document.getElementById('txtStartDate' + TaskID);
            var dtEndDate = document.getElementById('txtEndDate' + TaskID);

            if ($("#txtStartDate" + TaskID).val() == "") {
                strmsg = '- Start Date should not be left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtStartDate" + TaskID).focus();
            }


            if ($("#txtEndDate" + TaskID).val() == "") {
                strmsg = '- End Date should not be left blank.';
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
            //if ($("#txtEndDate" + TaskID).val() != '' && $("#txtStartDate" + TaskID).val() != '') {
            //    if (CompairDates1($("#txtStartDate" + TaskID).val(), $("#txtEndDate" + TaskID).val()) == 1 && CompairDates1($("#txtStartDate" + TaskID).val(), $("#txtEndDate" + TaskID).val()) != 0) {
            //        // $('#dtEndDate').css('border-color', 'red');
            //        // $('#dtEndDate').css('border-width', '1px');
            //        strmsg = '- Please enter Task End Date greater than or equal to Task Start Date!'
            //        errorMsg += "<li>" + strmsg + "</li></br>";

            //        // $('#spndtEndDate').text("Please enter Task End Date greater than or equal to Task Start Date!");
            //        if (checkFlag != 1) {
            //            //objEndDate.focus()
            //        }
            //        isValid = 1;
            //        checkFlag = 1;
            //    }
            //}

            //Commented and Added by Usha Pandit on 06.06.2019 for sprint start date and end date validation
            //if (checkFlag == 0) {

            //    //Commented and Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
            //    //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + TaskID).val(), EndDate: $("#txtEndDate" + TaskID).val() });
            //    var data = '';

            //    if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
            //        var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
            //        var curEnd = opformatDate($("#txtEndDate" + TaskID).val(), 'DD/MM/YYYY');
                   
            //         //Commented and Added by Usha Pandit on 06.06.2019 for passing User Story Id
            //        //data = JSON.stringify({ ProjectID: ProjectID, StartDate: curStart, EndDate: curEnd });
            //        var userStoryId = $("#hdnUserStoryID2").val(); 
            //         userStoryId = '';
            //        data = JSON.stringify({ ProjectID: ProjectID, StartDate: curStart, EndDate: curEnd, UserStoryId: userStoryId });
            //        //End of Added by Usha Pandit on 06.06.2019 for passing User Story Id
            //    }
            //    else {
            //        //Commented and Added by Usha Pandit on 06.06.2019 for passing User Story Id
            //        //data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + TaskID).val(), EndDate: $("#txtEndDate" + TaskID).val() });
            //        var userStoryId = $("#hdnUserStoryID2").val();  
            //        userStoryId = '';
            //        data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + TaskID).val(), EndDate: $("#txtEndDate" + TaskID).val(), UserStoryId: userStoryId });
            //        //End of Added by Usha Pandit on 06.06.2019 for passing User Story Id
            //    }
            //    //End of Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
               
            //    var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);
               
            //    if (Newresult.d != '') {
            //        var arrResult = Newresult.d.split('##');

            //        if (arrResult[0] == '1') {


            //            strmsg = '-' + arrResult[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";
            //            isValid = 1;
            //            checkFlag = 1;
            //        }
            //        if (arrResult[0] == '2') {
            //            strmsg = '-' + arrResult[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";
            //            isValid = 1;
            //            checkFlag = 1;

            //        }

            //        if (arrResult[0] == '3') {
            //            strmsg = '-' + arrResult[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";
            //            isValid = 1;
            //            checkFlag = 1;
            //        }
            //    }

            //}


            //if (dtEndDate.value != '') {
            //    //Commented and Added by Usha Pandit on 25.03.2019 for UserStoryId undefined crash issue
            //    //var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
            //    var result = "";
            //    //Commented and Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
            //    //if (document.getElementById('hdnusid') == undefined || document.getElementById('hdnusid') == null) {
            //    //    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnUserStoryID').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
            //    //}
            //    //else {
            //    //    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
            //    //}

            //    if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
            //        var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
            //        var curEnd = opformatDate($("#txtEndDate" + TaskID).val(), 'DD/MM/YYYY');
            //        result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: curStart, strEndDate: curEnd }), false);
            //    }
            //    else {
            //        result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
            //    }
            //    //End of Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy


            //    //End of Added by Usha Pandit on 25.03.2019 for UserStoryId undefined crash issue
            //    if (result.d != "") {
            //        var strMsg = String(result.d).split("_");
            //        if (strMsg[0] == "1") {
            //            // $('#spndtStartDate').text(strMsg[1]);
            //            strmsg = '- ' + strMsg[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";

            //        }
            //        else {
            //            //$('#spndtEndDate').text(strMsg[1]);
            //            strmsg = '- ' + strMsg[1];
            //            errorMsg += "<li>" + strmsg + "</li></br>";

            //        }
            //        isValid = 1;
            //        checkFlag = 1;
            //    }
            //}

            if (dtEndDate.value != '' && checkFlag == 0) {
                //Commented and Added by Usha Pandit on 25.03.2019 for UserStoryId undefined crash issue
                //var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
                var result = "";
                //Commented and Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
                //if (document.getElementById('hdnusid') == undefined || document.getElementById('hdnusid') == null) {
                //    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnUserStoryID').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
                //}
                //else {
                //    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
                //}

                if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
                    var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
                    var curEnd = opformatDate($("#txtEndDate" + TaskID).val(), 'DD/MM/YYYY');
                    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: curStart, strEndDate: curEnd }), false);
                }
                else {
                    result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strStartDate: $("#txtStartDate" + TaskID).val(), strEndDate: $("#txtEndDate" + TaskID).val() }), false);
                }
                //End of Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy


                //End of Added by Usha Pandit on 25.03.2019 for UserStoryId undefined crash issue
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

                //Commented and Added by Usha Pandit on 15.05.2019 for exception due to date format dd-mm-yyyy
                //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + TaskID).val(), EndDate: $("#txtEndDate" + TaskID).val() });
                var data = '';

                if ($("#txtStartDate" + TaskID).val().toString().indexOf("-") != -1) {
                    var curStart = opformatDate($("#txtStartDate" + TaskID).val(), 'DD/MM/YYYY');
                    var curEnd = opformatDate($("#txtEndDate" + TaskID).val(), 'DD/MM/YYYY');
                                       
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


            


            //End of Added by Usha Pandit on 06.06.2019 for sprint start date and end date validation

            if ($("#txtWorkHrs" + TaskID).val() == "") {
                strmsg = '- Work(Hrs) should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtWorkHrs" + TaskID).focus();
            }

            //if ($("#txtWork" + TaskID != "")) {
            if ($("#txtWorkHrs" + TaskID).val() != "") {
                //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 
                //if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + TaskID)) == true) {


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

                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("txtWorkHrs" + TaskID);
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }


                    if (objHMEffort.value.indexOf(":") == -1) {
                        //strmsg = 'Please enter efforts in valid format hh:mm!!';
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
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        objHMEffort.value = objVal;
                        isValid = 1;
                        checkFlag = 1;
                    }

                    //if (blnResult == true) {
                    //    isValid = 1;
                    //    checkFlag = 1;
                    //}

                    //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + TaskID)) == true) {
                            strmsg = 'Please enter Work(Hrs) in H:M format.';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            objHMEffort.value = objVal;
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                    }
                    //if (blnResult == true) {
                    //    isValid = 1;
                    //    checkFlag = 1;
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
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = 'Hours should not be less than or equal to zero (0).';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = 'Please enter minutes in two decimal and less than 60.';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = 'Please enter minutes between (0-59) range';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }

                    //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

                    if (dtStartDate.value != "" && dtEndDate.value != "" && checkFlag == 0) {

                        var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;

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

                //End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

                if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + TaskID)) == false && (objHMEffort.value.indexOf(":") != -1)) {
                    var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationEfforts', JSON.stringify({ strUserStoryID: document.getElementById('hdnusid').value, strEfforts: $("#txtWorkHrs" + TaskID).val(), strTaskID: TaskID }), false);
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
                strmsg = '- Task Type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboTaskType" + TaskID).focus();
            }

            if ($("#cboresource" + TaskID).val() == "0") {
                strmsg = '- Resource should not be left blank.';
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

                //Commented and Added by Usha Pandit on 25.03.2019 for UserStoryId undefined crash issue
                //var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: TaskID });
                var data = "";
                if (document.getElementById('hdnusid') == undefined || document.getElementById('hdnusid') == null) {
                    data = JSON.stringify({ UserStoryID: $("#hdnUserStoryID").val(), StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: TaskID });
                }
                else {
                    data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints" + TaskID).val(), TaskID: TaskID });
                }
                //End of Added by Usha Pandit on 25.03.2019 for UserStoryId undefined crash issue
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

        function UpdateTask(TaskID) {
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            if (TaskID != "") {



                if (validateupdatetask(TaskID) == 0) {

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



                    URL = 'frmSprintPlanning.aspx/SaveTask';

                    var AssignTaskData = [];

                    AssignTaskData.push({
                        TaskID: TaskID,
                        TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                        Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                        MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: $("#hdnProjectID").val(), PracticeID: PracticeID,
                        UserStoryID: strUserStoryId, strEntity: "", StoryPoints: StoryPoints
                    });

                    data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: strUserStoryId, });
                    //alert(data)
                    AJAXCallWithPara(URL, data, AfterEditTask, extraPara);


                }



            }



            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            $('#txtEndDate').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtStartDate').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });


        }

        function DeleteTask(USID, taskId) {
            // debugger;
            var extraPara = [];
            extraPara.push(taskId);
            //var AssignDeletetaskData = [];
            URL = 'frmSprintPlanning.aspx/AfterDeleteTask';
            //AssignDeletetaskData.push({
            //    taskId: taskId

            //});

            data = JSON.stringify({ taskId: taskId, UserStoryId: strUserStoryId, });
            AJAXCallWithPara(URL, data, AfterDeleteTask, extraPara);
            $('#txtEndDate').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtStartDate').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });

            /*Changed By yasmin on 5-3-19*/

            //$('#txtEndDate0').datepicker();
            //$('#txtStartDate0').datepicker();
            $('#txtStartDate0,#txtEndDate0').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $('#txtStartDate0,#txtEndDate0,#txtEndDate,#txtStartDate').prop('readonly', true);
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
        }
        function AfterDeleteTask(data, extraPara) {
            var Id = extraPara[0];

            var strProjectID = document.getElementById('hdnProjectID').value;
            document.getElementById("divTasksUS").innerHTML = data.d;

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Deleted successfully', 'success', 5);
            // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            isValid = 0;
            saveFlag = 0;


            $('#txtEndDate' + Id).datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtStartDate' + Id).datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });


            $('#txtEndDate').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
            $('#txtStartDate').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });

            /*Changed By yasmin on 5-3-19*/

            $('#txtStartDate0,#txtEndDate0').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $('#txtStartDate,#txtEndDate,#txtStartDate0,#txtEndDate0').prop('readonly', true);
            $('[data-bs-toggle="tooltip"]').mouseout(function () {
                $('.tooltip').fadeOut('fast', function () {

                    $('.tooltip').remove();
                });
            });
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('.tooltip').fadeOut('fast', function () {
                    $('.tooltip').remove();
                });
            });
            $('[data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover'
            });
        }



        function AfterEditTask(data, extraPara) {
            var Id = extraPara[0];
            // alert(data.d);
            var strProjectID = document.getElementById('hdnProjectID').value;
            document.getElementById("divTasksUS").innerHTML = "";
            document.getElementById("divTasksUS").innerHTML = data.d;

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Updated successfully', 'success', 5);
            // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Kashish on 24 july 2018 for task detail  issue fixing
            tooltipShow();
            /*Changed By yasmin on 5-3-19*/

            //$('#txtEndDate0').datepicker();
            //$('#txtStartDate0').datepicker();
            $('#txtStartDate0,#txtEndDate0').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                }
            );
            $('#txtStartDate0,#txtEndDate0').prop('readonly', true);
            isValid = 0;
            saveFlag = 0;

        }


        function EditTask(UserStoryID, TaskID) {

            if (TaskID != "") {
                var strProjectID = document.getElementById('hdnProjectID').value;
                $('[data-bs-toggle="tooltip"]').tooltip();
                //Added By Kashish on 24 july 2018 for task detail  issue fixing
                tooltipShow();
                $("#tblProjectDetail").find("#txtStartDate" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#txtEndDate" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#txtWorkHrs" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#txtWorkHrs" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#dpEnddate" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#dpstartdate" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#cboTaskType" + TaskID).removeAttr("disabled")
                $("#tblProjectDetail").find("#txtStoryPoints" + TaskID).removeAttr("disabled")
                //Added by kashish for task detail
                $('#onhold').css('display', 'block');
                $('#txtEndDate' + TaskID).datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
                $('#txtStartDate' + TaskID).datepicker({
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
                $("#Update" + TaskID).html("");
                //cboresource
                document.getElementById('Update' + TaskID).innerHTML = "<i style='font-size:11.5px!important;text-align:center' data-bs-toggle='tooltip'  id='UpdateBtn' data-bs-toggle='tooltip'  data-bs-placement='top'  title='Update Task' class='fa fa-refresh' onclick=UpdateTask(" + TaskID + ") ></i>"
                //Added By kashish for task detail on 13-8-2018
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }


        function ToRefreshpage() {


            var obj1 = {};
            obj1.UserStoryID = gUserStoryID;
            obj1.IterationID = strSeletedIteration;
            obj1.strMapFlag = "MapWithoutTask";
            var flag = AJAXCallWithResult("frmSprintPlanning.aspx/CheckComplexity", JSON.stringify({ strUserStoryID: gUserStoryID, strIterationID: strSeletedIteration }), false);
            if (flag.d == "10") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('User Story is already cancelled from the sprint, you can not map user story to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "11") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Selected sprint is not map with any release, you can not map user story to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "2") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sprint is already started/completed. You can not map user story to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "8") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sprint is terminated. You can not map user story to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "6") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sprint is cancelled. You can not map user story to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "3") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('User story is inactive. You can not map to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "4") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sprint is completed, you can not map user story to sprint', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            else if (flag.d == "5") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Parent User Story  is not Planned for the Selected Sub User Story ,Plan the Parent User Story First.', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }
            //else if (flag.d == "7") {
            //ShowConfirm("By mapping User Story to Sprint all Sub User Stories will be mapped to Sprint.", draggedIterationID2, dragUserStoryD, ui);
            //RefreshBothTable(dragUserStoryD, draggedIterationID2)
            //Work Remain
            //}
            else if (flag.d != "1") {
                //Added for sprint cancellation changes
                //var strResult_1 = AJAXCallWithResult("frmSprintPlanning.aspx/CheckTasksMappedToUserStory1", JSON.stringify({ userStoryID: gUserStoryID, IterationID: strSeletedIteration }), false);
                //if (Trim(strResult_1.d) != "") {
                //    ///Work Remain
                //    //alert(strResult_1.d);
                //    // alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(strResult_1.d, 'error');
                //    RefreshBothTable(gUserStoryID, strSeletedIteration)
                //}
                //else {
                $.ajax({
                    type: "POST",
                    url: "frmSprintPlanning.aspx/Save_IterationUserStories",
                    data: JSON.stringify(obj1),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $("#DivSprintlist").modal('hide');
                        gUserStoryID = '';
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('User Story Added Successfully Against Sprint');

                        // RefreshBothTable(gUserStoryID, strSeletedIteration);
                        //Refresh Grid...
                        var data = JSON.stringify({ ID: 1 });
                        var result = AJAXCallWithResult("frmSprintPlanning.aspx/RefreshGrid1", data, false);
                        // alert(result.d);
                        if (result.d != '') {
                            $('#MainDiv2').html("");
                            var hdata = $(result.d).html();
                            $('#MainDiv2').html(result.d);
                            //called Common Functions....
                            common();
                        }
                    }
                });
                //}
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please map Story point to user story/sub user story', 'error');
                RefreshBothTable(gUserStoryID, strSeletedIteration)
            }

        }
        /*Added by Yasmin For Texarea Enhancement*/
        function AutoResizeTextArea() {
            jQuery.each(jQuery('textarea[data-autoresize]'), function () {
                var offset = this.offsetHeight - this.clientHeight;

                var resizeTextarea = function (el) {
                    jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
                };
                jQuery(this).on('keyup input', function () {
                    //if ($(this).attr("id") == "txtUserDesc") {
                    //    Maxlength(this, "countdown", 1000);
                    //}
                    //if ($(this).attr("id") == "txtFeatureName") {
                    //    Maxlength(this, "countdownFN", 200);
                    //}

                    //if ($(this).attr("id") == "txtSubStoryDesc") {
                    //    Maxlength(this, "countSubUSdown", 1000);
                    //}

                    resizeTextarea(this);
                }).removeAttr('data-autoresize');


            });
        }
        function AutoResizeTextAreaforuserstories() {
            //jQuery.each(jQuery('textarea[data-autoresize]'), function () {
            //    var offset = this.offsetHeight - this.clientHeight;

            //    var resizeTextarea = function (el) {
            //        jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
            //    };
            //    jQuery(this).on('keyup input', function () {
            //        if ($(this).attr("id") == "txtSubStoryDesc") {
            //            Maxlength(this, "countSubUSdown", 1000);
            //        }
            //        if ($(this).attr("id") == "txtFeatureName") {
            //            Maxlength(this, "countdownFN", 200);
            //        }

            //        if ($(this).attr("id") == "txtSubStoryDesc") {
            //            Maxlength(this, "countSubUSdown", 1000);
            //        }

            //        resizeTextarea(this);
            //    }).removeAttr('data-autoresize');


            //});
        }
        function RemoveTextArea() {
            $('textarea').keydown(function (e) {
                var $this = $(this),
                    rows = parseInt($this.attr('rows')),
                    lines;

                // on enter
                if (e.which === 13)
                    $this.attr('rows', rows + 1);

                // on backspace -- THIS IS THE PROBLEM
                if (e.which === 8 && rows !== 2) {
                    lines = $(this).val().split('\n')
                    console.log(lines);
                    if (!lines[lines.length - 1]) {
                        $this.attr('rows', rows - 1);
                    }
                }
            });
        }
        function getRows() {
            if ($("#txtFeatureName").val() != undefined) {
                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtFeatureName").val().split('\n');
                var lineheight = $("#txtFeatureName").val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("txtFeatureName").rows = numberOfLines + 1;
                    $("#txtFeatureName").attr("style", "height: auto !important");
                }

            }
            if ($("#txtUserDesc").val() != undefined) {
                var numberOfColumns4 = 70;
                var numberOfLines4 = 1;
                //numberOfColumns4 = document.getElementById("txtImpedimentDescription").cols;
                var eachLine4 = $("#txtUserDesc").val().split('\n');
                var lineheight4 = $("#txtUserDesc").val();
                numberOfLineBreaks4 = (lineheight4.match(/\n/g) || []).length;
                characterCount4 = lineheight4.length + numberOfLineBreaks4;

                if (characterCount4 > numberOfColumns4) {
                    numberOfLines4 = parseInt(characterCount4 / numberOfColumns4);
                    var height4 = document.getElementById("txtUserDesc").rows = numberOfLines4 + 1;
                    $("#txtUserDesc").attr("style", "height: auto !important");
                }

            }
            if ($("#txtAcceptanceCriteria").val() != undefined) {
                var numberOfColumns2 = 70;
                var numberOfLines2 = 1;
                var characterCount2;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine2 = $("#txtAcceptanceCriteria").val().split('\n');
                var lineheight2 = $("#txtAcceptanceCriteria").val();
                numberOfLineBreaks2 = (lineheight2.match(/\n/g) || []).length;
                characterCount2 = lineheight2.length + numberOfLineBreaks2;

                if (characterCount2 > numberOfColumns2) {
                    numberOfLines2 = parseInt(characterCount2 / numberOfColumns2);
                    var height2 = document.getElementById("txtAcceptanceCriteria").rows = numberOfLines2 + 1;
                    $("#txtAcceptanceCriteria").attr("style", "height: auto !important");
                }

            }



        }
        function gettextareaRows() {
            if ($("#txtDescriptionS").val() != undefined) {
                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtDescriptionS").val().split('\n');
                var lineheight = $("#txtDescriptionS").val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("txtDescriptionS").rows = numberOfLines + 1;
                    $("#txtDescriptionS").attr("style", "height: auto !important");
                }

            }
            if ($("#txtSRDescription").val() != undefined) {
                var numberOfColumns4 = 70;
                var numberOfLines4 = 1;
                //numberOfColumns4 = document.getElementById("txtImpedimentDescription").cols;
                var eachLine4 = $("#txtSRDescription").val().split('\n');
                var lineheight4 = $("#txtSRDescription").val();
                numberOfLineBreaks4 = (lineheight4.match(/\n/g) || []).length;
                characterCount4 = lineheight4.length + numberOfLineBreaks4;

                if (characterCount4 > numberOfColumns4) {
                    numberOfLines4 = parseInt(characterCount4 / numberOfColumns4);
                    var height4 = document.getElementById("txtSRDescription").rows = numberOfLines4 + 1;
                    $("#txtSRDescription").attr("style", "height: auto !important");
                }

            }

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
        //function getRows() {
        //    //alert(document.getElementById('txtFeatureName').value.split("\n").length);
        //    if ($("#txtFeatureName").val() != undefined) {
        //        var str2 = document.getElementById("txtFeatureName").value;
        //        str2 = str2.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
        //        document.getElementById("txtFeatureName").value = str2;
        //        var lineheight = document.getElementById("txtFeatureName").value.split("\n").length + 1;
        //        var height = document.getElementById("txtFeatureName").rows = lineheight;

        //        $("#txtFeatureName").attr("style", "height: auto !important");
        //    }
        //    //var lineheight = document.getElementById('txtFeatureName').value.split("\n").length;
        //    //var height = document.getElementById("txtFeatureName").rows = lineheight;
        //    if ($("#txtUserDesc").val() != undefined) {
        //        var str1 = document.getElementById("txtUserDesc").value;
        //        str1 = str1.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
        //        document.getElementById("txtUserDesc").value = str1;
        //        var lineheight1 = document.getElementById("txtUserDesc").value.split("\n").length;
        //        var height1 = document.getElementById("txtUserDesc").rows = lineheight1;

        //        $("#txtUserDesc").attr("style", "height: auto !important");
        //    }
        //    //var lineheight1 = document.getElementById('txtUserDesc').value.split("\n").length;
        //    //var height1 = document.getElementById("txtUserDesc").rows = lineheight1;
        //    if ($("#txtAcceptanceCriteria").val() != undefined) {
        //        var str = document.getElementById("txtAcceptanceCriteria").value;
        //        str = str.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
        //        document.getElementById("txtAcceptanceCriteria").value = str;
        //        var lineheight2 = document.getElementById("txtAcceptanceCriteria").value.split("\n").length;
        //        var height2 = document.getElementById("txtAcceptanceCriteria").rows = lineheight2;

        //        $("#txtAcceptanceCriteria").attr("style", "height: auto !important");
        //    }
        //    //var lineheight2 = document.getElementById('txtAcceptanceCriteria').value.split("\n").length;
        //    //var height2 = document.getElementById("txtAcceptanceCriteria").rows = lineheight2;

        //    //$("#txtUserDesc").attr("style", "height: auto !important");
        //    //$("#txtFeatureName").attr("style", "height: auto !important");
        //    //$("#txtAcceptanceCriteria").attr("style", "height: auto !important");

        //}
        //function gettextareaRows() {

        //    //alert($("#txtDescriptionS").val());
        //    if ($("#txtDescriptionS").val() != undefined) {
        //        var str = document.getElementById("txtDescriptionS").value;
        //        str = str.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
        //        document.getElementById("txtDescriptionS").value = str;
        //        var lineheight = document.getElementById("txtDescriptionS").value.split("\n").length;
        //        var height = document.getElementById("txtDescriptionS").rows = lineheight;

        //        $("#txtDescriptionS").attr("style", "height: auto !important");
        //    }
        //    if ($("#txtSRDescription").val() != undefined) {
        //        var str1 = document.getElementById("txtSRDescription").value;
        //        str1 = str1.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
        //        document.getElementById("txtSRDescription").value = str1;
        //        var lineheight1 = document.getElementById("txtSRDescription").value.split("\n").length;
        //        var height1 = document.getElementById("txtSRDescription").rows = lineheight1;

        //        $("#txtSRDescription").attr("style", "height: auto !important");
        //    }


        //    //var lineheight1 = document.getElementById('txtSRDescription').value.split("\n").length;
        //    //var height1 = document.getElementById("txtSRDescription").rows = lineheight1;
        //    //$("#txtSRDescription").attr("style", "height: auto !important");
        //}

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
    <script>
        var observe;
        if (window.attachEvent) {
            observe = function (element, event, handler) {
                element.attachEvent('on' + event, handler);
            };
        }
        else {
            observe = function (element, event, handler) {
                element.addEventListener(event, handler, false);
            };
        }
        function init() {
            var text = document.getElementById('txtUserDesc');
            function resize() {
                text.style.height = '20px';
                text.style.height = text.scrollHeight + 'px';
            }
            /* 0-timeout to get the already changed text */
            function delayedResize() {
                window.setTimeout(resize, 0);
            }
            observe(text, 'change', resize);
            observe(text, 'cut', delayedResize);
            observe(text, 'paste', delayedResize);
            observe(text, 'drop', delayedResize);
            observe(text, 'keydown', delayedResize);

            text.focus();
            text.select();
            resize();
        }
        //function autoAdjustTextArea(o) {
        //    o.style.height = '1px'; // Prevent height from growing when deleting lines.
        //    o.style.height = o.scrollHeight + 'px';
        //}


        //// Get a reference to the text area.
        //var txtAra = document.getElementsByTagName('textarea')[0];
        //// Generate some random characters of length between 150 and 300.
        //txtAra.value = randChars(chars, randRange(150, 300));
        //// Trigger the event.
        //autoAdjustTextArea(txtAra);
        $(document).ready(function () {


            //Added by Usha Pandit On 28 March 2019 for user story large description tooltip 

            $('.tt_large').tooltip({
                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
            });
            //End of Added by Usha Pandit On 28 March 2019 for user story large description tooltip 


            // Select all links with hashes
            //$('a[href*="#"]')
            //  // Remove links that don't actually link to anything
            //  .not('[href="#"]')
            //  .not('[href="#0"]')
            //  .click(function (event) {
            //      // On-page links
            //      if (
            //        location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
            //        &&
            //        location.hostname == this.hostname
            //      ) {
            //          // Figure out element to scroll to
            //          var target = $(this.hash);
            //          target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            //          // Does a scroll target exist?
            //          if (target.length) {
            //              // Only prevent default if animation is actually gonna happen
            //              event.preventDefault();
            //              $('#divUserStroryDetails').animate({
            //                  scrollTop: target.offset().top
            //              }, 1000, function () {
            //                  // Callback after animation
            //                  // Must change focus!
            //                  var $target = $(target);
            //                  $target.focus();
            //                  if ($target.is(":focus")) { // Checking if the target was focused
            //                      return false;
            //                  } else {
            //                      $target.attr('tabindex', '-1'); // Adding tabindex for elements not focusable
            //                      $target.focus(); // Set focus again
            //                  };
            //              });
            //          }
            //      }
            //  });


            //var clicked = false, clickY;
            //$(window).mousemove(function (e) {
            //    clicked && updateScrollPos(e);
            //});
            //$(window).mouseup(function () {
            //    clicked = false;
            //    $('#divUserStroryDetails').css('cursor', 'auto');
            //});
            //$('#divUserStroryDetails').mousedown(function (e) {
            //    clicked = true;
            //    clickY = e.pageY + $('#divUserStroryDetails').scrollTop();
            //});
            //var updateScrollPos = function (e) {
            //    $('#divUserStroryDetails').css('cursor', 's-resize');
            //    $('#divUserStroryDetails').scrollTop(clickY - e.pageY);
            //    e.preventDefault();
            //}
        });



        function RefreshTab(SelectedTab, Flag, UniqueID, DivID) {

            data = JSON.stringify({ SelectedTab: SelectedTab, Flag: Flag, UniqueID: UniqueID });
            strResult = AJAXCallWithResult("frmSprintPlanning.aspx/ReFreshTab", data, false);



            if (strResult.d != "") {
                $("#" + DivID).html("");
                $("#" + DivID).html(strResult.d);
                 // Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivCurrentSprintUS").val() > 0) {
                    datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '');
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue

                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivSubTabIssuesList").val() > 0) {
                    datatables('DivSubTabIssuesList', 'txtSearchIssues', '');
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivImpedimentsLogsList").val() > 0) {
                    datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '');
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivRisksList").val() > 0) {
                    datatables('DivRisksList', 'txtSearchRisks', '');
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivReviewList").val() > 0) {
                    datatables('DivReviewList', 'txtSearchReviews', '');
                }
                //Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivTaskList").val() > 0) {
                    datatables('DivTaskList', 'txtSearchTask', '');
                }
                 //End of Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterDivHistorykList").val() > 0) {
                    datatables('DivHistorykList', 'txtSearchhistory', '');
                }
                 //Added By Dipali V On 28th March 2023 For Datable Issue
                if ($("#FilterdivsprintFormRefresh").val() > 0) {
                    datatables('divsprintFormRefresh1', '', '');

                } //End of Added By Dipali V On 28th March 2023 For Datable Issue
                /*Added By Yasmin on 1-4-19*/
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }
        function HighLightChart() {

            $('#myScrollspy ul li').click(function () {


                //$('#myScrollspy ul li a').removeClass("activecharttab");
                //$(this).addClass("activecharttab");

                //$('#myScrollspy ul li a').css("background-color", "white");
                //$('#myScrollspy ul li a').css("color", "black");
                //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
                //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

                $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
                $('#myScrollspy ul li a').css("cssText", "color:black!important;");


                $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
                $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");

                //$(this).css("cssText", "background-color:#337ab7!important;");
                //$(this).css("cssText", "color:white!important;");
                //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7!important;");
                //$("[href=#" + $(this).attr("id") + "]").css("cssText", "color:white!important;");



            });

            $('#myScrollspy ul li a').click(function () {


                //$('#myScrollspy ul li a').removeClass("activecharttab");
                //$(this).addClass("activecharttab");

                //$('#myScrollspy ul li a').css("background-color", "white");
                //$('#myScrollspy ul li a').css("color", "black");
                //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
                //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

                $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
                $('#myScrollspy ul li a').css("cssText", "color:black!important;");


                $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
                $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");


                //$(this).css("cssText", "background-color:#337ab7!important;");
                //$(this).css("cssText", "color:white!important;");
                //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7!important;");
                //$("[href=#" + $(this).attr("id") + "]").css("cssText", "color:white!important;");



            });
        }
        function Showmore(flagSR, IterationID) {
            //  debugger;
            window.location.href = "../Agile/frmSprintDetails.aspx?flagSR=" + flagSR + "&IterationID=" + IterationID;

        }
        /*Added By Kashish on 24 july 2018 for task detail  issue fixing*/

        function tooltipShow() {
            $(".tooltip_span_resource").each(function () {
                var currentresource = $(this).find("select option:selected").text();


                if (currentresource == '') {
                    $(this).parent().find("span").attr("data-original-title", currentresource);
                }
                else {
                    $(this).parent().find("span").attr("data-original-title", "Resource - " + currentresource);
                }
            });
        }

        $('[data-bs-toggle="tooltip"]').mouseout(function () {
            $('.tooltip').fadeOut('fast', function () {

                $('.tooltip').remove();
            });
        });
        $('[data-bs-toggle="tooltip"]').click(function () {
            $('.tooltip').fadeOut('fast', function () {
                $('.tooltip').remove();
            });
        });
        $('[data-bs-toggle="tooltip"]').tooltip({
            trigger: 'hover'
        });


        /* End of Added By Kashish on 24 july 2018 for task detail  issue fixing*/
    </script>
  
   
   
</head>
<body>
    <form id="form1" runat="server">
        <div id="MainDiv" class="container-fluid" style="padding-top: 10px; padding-right: 0px;">
            <%--  <%CommonFunctions.General.WriteHTML(objClsCommon.PlotHeader("Sprint Planning"))%>--%>
            <%CommonFunctions.General.WriteHTML(PlotHeader())%>
            <div class='row' id='MainDiv2'>
                <%If Request.QueryString("FromWhere") = "Back" Then%>
                <%PlotGrid(, , , , , )%>
                <%Else%>
                <%PlotGrid()%>
                <%End If%>
            </div>

            <%--Second Modal --%>


            <div class="modal fade" id="DivSprintlist" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="display:block">
                            <button type="button" class="close" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip' data-bs-container="body">&times;</button>
                            <h4 class="modal-title" id="Idheader"></h4>
                            <div class="col-sm-12 search-container">
                                <input type="text" id="txtSprintSearch" placeholder="Search.." name="search" />

                                <i class="fa fa-search" style="margin-left: -22px;"></i>
                            </div>
                        </div>

                        <%--<div class="modal-header">
                              <button type="button" class="close" style="font-weight:bold;" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                             <h5 class="modal-title" style="color: maroon;" id="Idheader"></h5>                                                     
                        </div>--%>
                        <div class="modal-body" id="divListdetails">
                        </div>
                        <div class="modal-footer" style="margin-right: 7px; background-color: white; margin-bottom: 13px; border-radius: 10px;">
                            <button type="button" class="btn btn-info" id="SelectSprint" onclick="Select_Sprint()">Select</button>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade" id="DivAttachSprint" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip'>&times;</button>
                            <h4 class="modal-title" id="IdheaderNEW"></h4>
                            <div class="col-sm-12 search-container">
                                <input type="text" id="txtattchlinkSprintSearch" placeholder="Search.." name="search" />
                                <i class="fa fa-search" style="float: right;"></i>
                            </div>
                        </div>

                        <%--<div class="modal-header">
                              <button type="button" class="close" style="font-weight:bold;" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                             <h5 class="modal-title" style="color: maroon;" id="Idheader"></h5>                                                     
                        </div>--%>
                        <div class="modal-body" id="divListdetailsNEW">
                        </div>
                        <div class="modal-footer" style="margin-right: 7px; background-color: white; margin-bottom: 13px; border-radius: 10px;">
                            <button type="button" class="btn btn-info" id="SelectSprintnew" onclick="Select_AttchSprint()">Select</button>
                        </div>
                    </div>
                </div>
            </div>



            <div id="myModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><i class="fa fa-exclamation-triangle" style="color: red; margin-right: 5px;"></i>Alert</h4>
                        </div>
                        <div class="modal-body">
                            <p id="customMessage">Do you want to save changes you made to document before closing?</p>
                            <%-- <p class="text-warning"><small>If you don't save, your changes will be lost.</small></p>--%>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" style="background-color: #3C8DBC!important; color: white" data-bs-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="myModalconfirm" class="modal fade" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-md" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 style="float: left; font-size: 14px;">Unmap From Sprint</h3>
                            <a class="close" data-bs-dismiss="modal" style="padding: 10px; padding-right: 0px;"><i class="fas fa-times" style="color: black!important; margin-right: -2px; margin-top: 6px; font-size: 14px;" data-original-title="" title=""></i></a>
                        </div>
                        <%-- <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-check-circle" style="color: green; margin-right: 5px;"></i>Confirmation</h4>
                    </div>--%>
                        <div id="mdlConfirmBody" class="modal-body">
                        </div>
                        <%-- <div class="modal-footer">
                            <button id="divOK" type="button" class="btn btn-primary">ok</button>
                            <button type="button" class="btn btn-default" data-bs-dismiss="modal" aria-hidden="true">Cancel</button>
                            <%-- <button id="divClose" type="button" class="btn btn-default">Cancel</button>--%>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="divProductBacklog" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content" id="USmodalcontent">
                        <div class="">
                            <div class="row">
                                <div class="col-sm-12" id="divProductBacklog_Body">
                                </div>
                                <div class="modal-footer">
                                    <%-- <button type="button" class="btn btn-info" onclick="SaveNew_UserStory()" title="Save">Save</button>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <%-- <div id="myModalAddSprint" class="modal fade" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">                
                 <div class="modal-dialog" role="document">
                     <div class="modal-content" style="height: 390px!important; width: 60%; left: 170px;">
                         <div class="modal-header" style="background-color: white; color: gray; height: 70px; padding: 15px; border-bottom: 1px solid #e5e5e5">
                             <h3 style="float: left; font-size: 20px;">Add Sprint</h3>
                             <a class="close" data-bs-dismiss="modal" style="padding: 10px; padding-right: 0px;"><i class="fas fa-times" style="color: black!important;" data-original-title="" title=""></i></a>
                         </div>
                         <div id="AddSprintBody" class="modal-body">
                         </div>
                     </div>
                 </div>
            </div>--%>
        </div>
    </form>
</body>
</html>


<%--<link href="../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
<link href="../../EnhancementFiles/css/datepicker.css" rel="stylesheet" />
<link href="../../EnhancementFiles/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />--%>


<%--<link href="../../responsive/css/bootstrap.min.css" rel="stylesheet" />--%>

