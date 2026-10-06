<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmReleasePlanning.aspx.vb" Inherits="Whizible.frmReleasePlanning" %>

<!DOCTYPE html>

<html>
<!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
<head id="Head1" runat="server">
<%--    <title></title>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0' />
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0' />
    <meta name='vs_defaultClientScript' content='JavaScript' />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache/" />

    
<link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
<%--<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery.dataTables-1.13.1.min.css" />--%>
<link rel="stylesheet" href="css/ReleasePlanning.css" />
<link rel="stylesheet" href="css/Release_Monitoring.css" />
<link rel="stylesheet" href="../General/loaderStylesheet.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/editor.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/sb-admin.css" />
<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<script src="js/autosize.js"></script>
<script src="../General/CommonFunctions.js"></script>
<%--<script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
<script src="../../Whizible2.0-new/dist/js/New_CommonFunctions.js"></script>
<%--<script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<script src="js/CommonJS.js?v=4.3"></script> 
<script src="../../Whizible2.0-new/dist/js/editor.js"></script>


  
</head>
      <style>
        .dropdown-menu li {
    list-style: none;
    cursor: pointer;
    float: left;
    width: 100%;
    /*padding: 15px 10px;*/
    font-weight: normal;
    margin-top: 10px;
}
        .open > .dropdown-menu {
    background: #fff !important;
    opacity: 1 !important;
    left: 0px !important;
    margin-top: 10px !important;
    display: block !important;
    z-index: 9 !important;
}
        .filter-menu {
            margin-left: -121px !important;
            margin-top: 18px !important;
        }

            .filter-menu li {
                padding: 15px 10px;
            }


        .fixed-top {
            position: fixed !important;
            right: 0;
            left: 0;
            z-index: 1030;
              /* Changed by Madhuri.K on 09-03-2026 */
    background: #F8FAFC;
            /* background: #e5e5e5; */
            padding: 6px !important;
            padding-bottom: 8px !important;
            margin-top: -10px;
            line-height: 0;
        }

        .clsDiscussion1 {
            /* background-color: #ddd; */
            /* height: 10px; */
            margin-top: 0% !important;
            /* padding-top: 2%; */
            line-height: 2;
            font-size: 14px !important;
            padding-bottom: 2%;
            COLOR: #000 !important;
            margin-bottom: 1% !important;
            border-bottom: 2px solid rgb(60, 141, 188) !important;
        }

        .placeholder {
            border: 2px dashed #ccc;
            padding: 40px 300px;
        }

        .clsBox {
            height: 100%;
            background: #fff !important;
            margin-bottom: 10px;
            overflow: auto;
        }

        .input-group {
            width: 100% !important;
        }

        #DivDetailss {
            z-index: 99 !important;
        }

        #scroll::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
            background-color: #F5F5F5;
        }

        #scroll::-webkit-scrollbar {
            width: 0px;
            background-color: #F5F5F5;
        }

        #scroll::-webkit-scrollbar-thumb {
            background-color: #fff;
            border: 2px solid #555555;
        }

        body {
            scrollbar-base-color: white;
            scrollbar-3dlight-color: white;
            scrollbar-highlight-color: white;
            scrollbar-track-color: white;
            scrollbar-arrow-color: white;
            scrollbar-shadow-color: white;
            scrollbar-dark-shadow-color: white;
        }

        @media only screen and (min-width:1200px) {
        }

        @media (min-width: 992px) {
            .col-md-6 {
                width: 49% !important;
            }

            .team_cards {
                width: 46% !important;
            }

            .modal_close {
            }

            /*.scrollspy-example.col-sm-9 {
                width: 70% !important;
            }*/
        }

        @media (max-width:1100px) {
            #RightDiv {
                margin-top: 30px !important;
                margin-left: 0px !important;
            }

            #div_details {
                width: 104%;
            }

            .SprintSeach {
                float: right;
                margin-right: 78px;
            }
        }

        #DivCurrentSprintUS .table > tbody > tr > td {
            word-break: break-word;
        }

        #DivSubTabIssuesList .table > tbody > tr > td {
            word-break: break-word;
        }

        #DivSubTabIssuesList table tr td:nth-child(5) {
            width: 20% !important;
        }
        /*Added By Ankush T on 06/06/2018 for user story name to be wrap*/
        #DivCurrentSprintUS table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(2) {
            width: 10% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(4) {
            width: 30% !important;
        }

        /*#DivCurrentSprintUS table tr td:nth-child(5) {
            width: 35% !important;
        }*/
        /*End By Ankush T on 06/06/2018 for user story name to be wrap*/

        /*Added By Ankush T on 06/06/2018 for Description to be wrap*/
        #DivImpedimentsLogsList table tr td:nth-child(1) {
            width: 30% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(2) {
            width: 15% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(4) {
            width: 35% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(5) {
            width: 10% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(6) {
            width: 10% !important;
        }
        /*End By Ankush T on 06/06/2018 for Description to be wrap*/

        /*Added By Ankush T on 06/06/2018 for Description to be wrap*/
        #DivRisksList table tr td:nth-child(1) {
            width: 15% !important;
        }

        #DivRisksList table tr td:nth-child(2) {
            width: 15% !important;
        }

        #DivRisksList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivRisksList table tr td:nth-child(4) {
            width: 35% !important;
        }

        #DivRisksList table tr td:nth-child(5) {
            width: 10% !important;
        }
        /*End By Ankush T on 06/06/2018 for Description to be wrap*/

        /*Added By Ankush T on 06/06/2018 for user story name to be wrap*/
        #DivUSlist table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivUSlist table tr td:nth-child(2) {
            width: 30% !important;
            word-break: break-all !important;
            white-space: pre-line !important;
        }

        #DivUSlist table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivUSlist table tr td:nth-child(4) {
            width: 10% !important;
        }

        /*End By Ankush T on 06/06/2018 for user story name to be wrap*/
        /*Added By Ankush T on 08/06/2018 for task name to be wrap*/
        #DivTaskList table tr td:nth-child(1) {
            width: 15% !important;
        }

        #DivTaskList table tr td:nth-child(2) {
            width: 15% !important;
        }

        #DivTaskList table tr td:nth-child(3) {
            width: 15% !important;
        }

        #DivTaskList table tr td:nth-child(4) {
            width: 15% !important;
        }

        #DivTaskList table tr td:nth-child(5) {
            width: 30% !important;
        }
        /*End By Ankush T on 08/06/2018 for task name to be wrap*/


        /*Added By Ankush T on 08/06/2018 for sprint name to be wrap*/
        /*#DivNoTMappedSprintlist table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivNoTMappedSprintlist table tr td:nth-child(2) {
            width: 30% !important;
        }

        #DivNoTMappedSprintlist table tr td:nth-child(3) {
            width: 15% !important;
        }

        #DivNoTMappedSprintlist table tr td:nth-child(4) {
            width: 10% !important;
        }*/

        /*End By Ankush T on 08/06/2018 for sprint name to be wrap*/

        /*Added By Dipali V On 25th June 2020 For Issue ID 25289*/
        .clsSpanRemark {
            border-style: None;
            float: right;
            margin-top: -1% !important;
            margin-right: -8% !important;
        }
        .clsTextArea {
            width: 100% !important;
            MARGIN-TOP:71px!important;
        }

        #divSprintList {
            margin-top: 15px;
            overflow: auto !important;
            height: 450px !important;
        }
   


         /*End of Added By Dipali V On 25th June 2020 For Issue ID 25289*/

         
         /*added style by pradip on 23-9-2020*/
         .tooltip.bottom {margin-left: 0px!important;}
         #divSprintList .clsunmappedAllcounts .fa {margin-right: 10px;}
         .fixed-top{display:flex}
         .clsCountDetails, .clsAllcounts, .clsunmappedAllcounts{position:relative}
         .card [class*=card-header-]{color:#fff}
         body{
    font-family: helvetica !important;
    /* Modified By Madhuri.K On 03-04-2026 */ 
    font-size: 11.5px!important;
}
         /* Modified By Madhuri.K On 03-04-2026 */ 
.fa-check-square{font-size:1.5px}
         .btn.btn-info{color:#fff!important}
         /* Modified By Madhuri.K On 03-04-2026 */ 
         .ClsHeaderGraph, .HeaderLine{font-size:11.5px}
         .clsDiscussion{display:flex}
         .searchbox{margin-left: auto;align-items: baseline;margin-top: -10px;}
         .label-primary {background-color: #428bca;}
         .progress {height: 20px;}
         #divAttachmentList{margin-top:20px}
         /* Modified By Madhuri.K On 03-04-2026 */ 
         .demo-droppable p{font-size:11.5px}
.scrollspy-example .divLineGraph{ height:auto!important;}
#divUserstories h5, #divTasks h5, #divIssues h5, #divReview h2, #divImpedimentsLogs h2, #divRisks h2, #divHistory h2{ margin:0!important;}
#txtDescription{border-bottom:1px solid #ddd}
.editDetails .col-md-12, .editDetails .col-md-7, .editDetails .col-md-5{display:flex;margin-bottom:12px}
#addUpdate{margin-left:auto}

/*added by Ashwini M on 27-3-2023*/
#CreateSprint .modal-header{display:block}
#CreateSprint .form-control{border-bottom:1px solid #ccc}
#CreateSprint #addsprint{margin-left:auto}
#CreateSprint .far.fa-calendar-check{margin-top: -25px!important}
.caret {
     display: inline-block; 
     width: 0; 
     height: 0; 
    margin-left: 2px;
    vertical-align: middle;
    border-top: 4px solid;
    border-right: 4px solid transparent;
    border-left: 4px solid transparent;
}
/*End of added by Ashwini M on 27-3-2023*/

        /*.modal-header {
            display: inline-block!important;
        }*/ /*Commented by pradip on 12-4-2023*/

#myScrollspy .nav-pills > li > a.active, #myScrollspy .nav-pills > li a.active:focus{ background:#4263c1; color:#fff!important;}
/*Added by pradip on 13-4-2023*/
div#div2 {
    padding: 0;
}
.label-warning {
    background-color: #f0ad4e;
}
    </style>
<body id="mainBody">


    <form id="frmReleaseplanning" runat="server">
        <div id="scroll">
            <div>
                <%ReleasePlanning("", "")%>
            </div>
        </div>
    </form>



    <div class="modal fade" id="DivRleaselist" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle='tooltip'>&times;</button>
                    <h4 class="modal-title" id="Idheader"></h4>

                </div>

                <div class="col-sm-12">
                    <input type='text' name='table_search' id='txtSearchRelease' class='txtBox form-control float-end' placeholder='Search' /><i class="fa fa-search Release" aria-hidden="true"></i>

                </div>
                <div class="modal-body" id="divListdetails" style="margin-top: -2%">
                </div>
                <div class="modal-footer" style="margin-top: 1%; margin-right: 2%">
                    <button type="button" class="btn btn-info" onclick="SelectRelease()" id="btnsave" title="Select" data-bs-toggle='tooltip'>Select</button>
                </div>

            </div>
        </div>
    </div>


    <div class="modal fade" id="Remark" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle='tooltip'>
                        &times;
                    </button>
                    <h4 class="modal-title" id="SprintHeader"></h4>


                </div>
                <div class="modal-body" id="TerminateRemark">
                </div>
                <div class="modal-footer">
                    <%--  <button type="button" class="btn btn-primary" onclick="SelectRelease()" id="Button1" title="Save">Save</button>--%>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="divUS" data-keyboard="false" data-backdrop="static" role="dialog">
        <div class="modal-dialog" role="document" style="max-width: 98%">
            <div class="modal-content" id="USmodalcontent">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" onclick="refresh()" title="Close" data-bs-toggle='tooltip'>&times;</button>
                    <h4 class="modal-title" id="headerUS">Create User Story</h4>
                </div>
                <%-- <div class="modal-header" id="SectionHeader">
                       
                        <div class="col-md-6 col-sm-12 col-sm-12">
                            <i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save' style="margin-top: 4px; float: left; margin-left: 38%;"></i>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="close modal " style="margin-top: 4px!important">
                                &times;
                            </button>
                        </div>

                    </div>--%>
                <div class="modal-body" id="divUSbodys">
                    '<%--//divProductBacklog_Body--%>
                </div>
                <div class="col-md-12 align-right" style="margin-bottom: 20px">
                    <%--   <button type="button" class="btn btn-info" onclick="SaveNew_UserStory()" id="Button2" title='Save' data-bs-toggle='tooltip'>Save</button>--%>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="FilterUS" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip'>&times;</button>
                    <h4 class="modal-title" id="h4">User Stories</h4>

                </div>
                <div class="col-sm-12 col-sm-12">
                    <div class="input-group FilterUS">
                        <input type="text" class="form-control" name='table_search' id='txtSearchUS' placeholder="Search" />
                       <i class="fa fa-search"></i>
                          
                    </div>

                </div>
                <%--<div class="modal-header">
                        <div class="col-sm-4">
                            <h5 class="modal-title" style="color: maroon;" id="FilterHeader">User Stories</h5>
                        </div>
                        <div class="col-sm-7">
                            <input type='text' name='table_search' id='txtSearchUS' class='txtBox form-control float-end' placeholder='Search' /><i class="fa fa-search Release" aria-hidden="true"></i>

                        </div>
                        <div class="col-sm-1">
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="close modal ">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>--%>
                <div class="modal-body" id="FilterUSbody" style="">
                </div>
                <div class="modal-footer" style="margin-right: 2%; margin-top: -40px;">
                    <button type="button" class="btn btn-info" onclick="ApplyFilter('UserStory')" id="Button1" title="Apply" data-bs-toggle='tooltip'>Apply</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="FilterSprint" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip'>&times;</button>
                    <h4 class="modal-title" id="h5">Sprints</h4>

                </div>
                <div class="col-sm-12">
                    <%--    <input type='text' name='table_search' id='txtSearchSprint11' class='txtBox form-control float-end' placeholder='Search' /><i class="fa fa-search Release" aria-hidden="true"></i>--%>
                    <div class="input-group FilterUS">
                        <input type="text" class="form-control" name='table_search' id='txtSearchSprint11' placeholder="Search" />
                        <i class="fa fa-search"></i>
                           
                    </div>
                </div>

                <div class="modal-body" id="FilterSprintbody" style="margin-top: -2%">
                </div>
                <div class="modal-footer" style="margin-top: -4%; margin-right: 2%">
                    <button type="button" class="btn btn-info" onclick="ApplyFilter('Sprint')" id="Button3" title="Apply" data-bs-toggle='tooltip'>Apply</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="FilterRelese" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip'>&times;</button>
                    <h4 class="modal-title" id="h2">Releases</h4>

                </div>
                <div class="col-sm-12">
                    <%--  <input type='text' name='table_search' id='txtSearchRelease11' class='txtBox form-control float-end' placeholder='Search' /><i class="fa fa-search Release" aria-hidden="true"></i>--%>
                    <div class="input-group FilterUS">
                        <input type="text" class="form-control" name='table_search' id='txtSearchRelease11' placeholder="Search" />
                        <i class="fa fa-search"></i>
                         
                    </div>
                </div>

                <div class="modal-body" id="FilterReleasebody" style="margin-top: -2%">
                </div>
                <div class="modal-footer" style="margin-top: -4%; margin-right: 2%">
                    <button type="button" class="btn btn-info" onclick="ApplyFilter('Release')" id="Button4" title="Apply" data-bs-toggle='tooltip'>Apply</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal fade" id="CreateSprint" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip'>&times;</button>
                    <h4 class="modal-title" id="HeaderCreate"></h4>
                </div>

                <div class="modal-body" id="SprintBody">
                </div>
                <div class="col-md-12 align-right">
                    <%-- <button type="button" class="btn btn-primary" onclick="SaveSprint()" id="Button5" title="Save">Save</button>--%>
                </div>

            </div>
        </div>
    </div>


    <div class="modal" id="myModal_dash" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document" style="max-width: 98%!IMPORTANT;">
            <div class="modal-content" id="dashcontent">
                <div class="modal-header" id="dashheader">
                    <div class="col-sm-4">
                        <h5 class="modal-title" style="color: maroon;" id="H1"></h5>
                    </div>

                    <div class="col-sm-1">
                        <button type="button" class="close" title="close" onclick="RefreshAllPage()" style="margin-top: -6%!important; margin-right: -3%!important" data-bs-dismiss="modal" aria-label="Close" style="margin-top: -2%; margin-right: -8%">
                            <%--data-bs-dismiss="modal" aria-label="Close"--%>
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <div class="modal-body" id="DashBody">
                </div>
                <div class="modal-footer">
                    <%-- <button type="button" class="btn btn-primary" onclick="SaveSprint()" id="Button5" title="Save">Save</button>--%>
                </div>

            </div>
        </div>
    </div>
    <div class="modal fade releaselist" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" title="Close">&times;</button>
                    <h4 class="modal-title">Map To Release</h4>
                </div>
                <div class="modal-body">
                    <select class="form-control">
                        <option>Release1
                        </option>

                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info">Save</button>
                </div>
            </div>

        </div>
    </div>
    <input type="hidden" id="hdnselectedReleaseID" name="hdnselectedReleaseID" value="" />




</body>
</html>

<script>
       /*Added by Usha Pandit on 11.04.2019 for disabling date before current date for End Date Control*/
    var dateToday = new Date();
    /*End of Added by Usha Pandit on 11.04.2019 for disabling date before current date for End Date Control*/

    $(function () {

        /*Added By yasmin on 5-3-19*/

         /*Commented and Added by Usha Pandit on 11.04.2019 for disabling date before current date for End Date Control*/
        //$('#SprintStartdate,#SprintEnddate').datepicker(
        //    {
        //        changeMonth: true,
        //        changeYear: true,
        //        yearRange: '2000:2020'
        //    }
        //);
        
          $('#SprintStartdate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
                 //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                 //yearRange: '2000:2020'
                 yearRange: 'c-100:c+100'
                 //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            }
        );
     
         $('#SprintEnddate').datepicker(
            {
                changeMonth: true,
                 changeYear: true,
                minDate: dateToday,
                 //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                 //yearRange: '2000:2020'
                 yearRange: 'c-100:c+100'
                 //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            }
        );
        /*End of Added by Usha Pandit on 11.04.2019 for disabling date before current date for End Date Control*/

        $('#RstartDate,#txtEndDate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            }
        );
   $('#RstartDate,#txtEndDate,#SprintEnddate,#SprintStartdate').prop('readonly', true);
    });
    var intDivGridListHeight, dragUserStoryD = '', ReleaseID = '';
    var strResultForStatus = "";
    var globalReleaseID = "";
    // Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
    var opDateFormat = '';
    // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
    
    $(document).ready(function () {
         // Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
        opDateFormat = '<%= strInputFormat %>';
        // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

        globalReleaseID = $("#hdnReleaseIDnewup").val();
        //alert(globalReleaseID);
        //Commented And Added By Usha Pandit On 29.01.2021 For sprint drag drop issue due to javascript error
        //$(window).load(function () {
        //    centerContent();
        //});
        $(window).on('load', function () {
            centerContent();
        });
        //End Of Added By Usha Pandit On 29.01.2021 For sprint drag drop issue due to javascript error
        $(window).resize(function () {
            centerContent();
        });

        function centerContent() {
            var container = $('.input-box');
            var content = $('.input-box-p');
            content.css("left", (container.width() - content.width()) / 2);
            content.css("top", (container.height() - content.height()) / 2);
        }

        $(".filter").tooltip();
        $(".releaselist").tooltip();
        $('.fa').tooltip();
        $('span').tooltip();
        //$('p').tooltip();
        $('lblname').tooltip();
        $('.clsTROdd ').tooltip();
        $('.even').tooltip();
        // $('body').tooltip({ selector: '[data-bs-toggle="tooltip"]' });
        $('[data-bs-toggle="tooltip"]').tooltip()
        $(".clsrightdiv").sortable({
            connectWith: ".clsrightdiv ",
            placeholder: "placeholder",
            scroll: true,
            cursor: "move",
            opacity: 0.7,
        });
        $('#hdnselectedReleaseID').val("");
        //$('.clsrightdiv .card:not(.DivDetailss)').hover(function () {

        //}, function () {
        //    $(this).css("box-shadow", "");
        //    $(this).css("border", "");
        //});


        $(".clsrightdiv").sortable({
            connectWith: ".clsrightdiv",
            placeholder: "placeholder",
            activate: function (ev, ui) {

            },
            update: function (event, ui) {
                var strIterationID = "";
                var label = "", ReleaseID = 0;

                //alert("");
                if (ui.sender == null) {
                    //debugger;
                    $('.lblIDS').each(function () {
                        label = label + $(this).text() + ',';
                        // alert(label);

                    });
                }
                else {
                    //  alert("Another");

                    var getDivID = $(this).attr('id');
                    var ReleaseID = document.getElementById('hdnReleaseID').value;
                    if (ReleaseID == "") {
                        ReleaseID = document.getElementById('hdnReleaseIDUS').value;
                    }

                    if (getDivID == "RightDiv") {
                        ReleaseID = ReleaseID;
                    }
                    else {
                        ReleaseID = 0;
                    }

                    // alert(ReleaseID);

                    // debugger
                    if (strIterationID == "") {
                        strIterationID = $(ui.item).find("#hdnhdnIterationID").val();
                    }
                    else {
                        strIterationID += "," + $(ui.item).find("#hdnhdnIterationID").val();
                    }
                    var ProjectID = document.getElementById('hdnProjectID').value;
                    // debugger;
                    var data;
                    if (ui.sender != null) {
                        if (strIterationID != undefined) {
                            if (getDivID == "RightDiv") {
                                if (ReleaseID != "") {
                                    $.ajax({
                                        url: "frmReleasePlanning.aspx/CheckReleaseDates",
                                        data: JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID, strProjectID: ProjectID }),
                                        type: "POST",
                                        contentType: "application/json;charset-utf=8",
                                        dataType: "json",
                                        success: function (result) {
                                            var strTextReleaseStartDate;
                                            var strTextReleaseEndDate;
                                            var strTextisValid;
                                            var strText;
                                            var arrStr;
                                            strText = String(result.d);
                                            arrStr = strText.split(",");
                                            strTextisValid = arrStr[0];
                                            strTextReleaseStartDate = arrStr[1];
                                            strTextReleaseEndDate = arrStr[2];
                                            //     alert(arrStr[4]);

                                            if (arrStr[4] == 0) {
                                                //ShowPopup("ITERATIONMAPPING");
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('You are not a Product Owner, you can not map the sprint to release.', 'error');
                                                $(ui.sender).sortable("cancel");
                                                // $(ui.sender).sortable("cancel");
                                                return;
                                            }

                                            if ((arrStr[5] == "Sprint Cancelled") || (arrStr[5] == "Sprint Terminated")) {
                                                //ShowPopup("Selected sprint is cancelled, you can not map cancelled sprint to release.");
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Selected sprint is cancelled/terminated, you can not map cancelled sprint to release.', 'error');
                                                //ADDED BY DIPALI V ON 29TH APRIL 2019 FOR DRAGGING
                                                $(ui.sender).sortable("cancel");
                                                 //END OF ADDED BY DIPALI V ON 29TH APRIL 2019 FOR DRAGGING
                                                return;
                                            }

                                            if (arrStr[6] == "1") {
                                                // ShowPopup("Release is already started, you can not map sprint to release.");
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Release is already started, you can not map sprint to release.', 'error');
                                                $(ui.sender).sortable("cancel");
                                                return;
                                            }

                                            else if (arrStr[6] == "2") {
                                                // ShowPopup("Release is already started, you can not map sprint to release.");
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Released, you can not map sprint to release.', 'error');
                                                $(ui.sender).sortable("cancel");
                                                return;
                                            }
                                            else if (strTextisValid == 0) {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Start Date and End Date should be between Release Dates i.e.' + strTextReleaseStartDate + " and " + strTextReleaseEndDate, 'error');
                                                // ShowPopup("Start Date and End Date should be between Release Dates i.e. " + strTextReleaseStartDate + " and " + strTextReleaseEndDate);
                                                $(ui.sender).sortable("cancel");
                                                return;
                                            }

                                            data = JSON.stringify({ strIterationID: strIterationID, ReleaseID: ReleaseID });
                                            strResult = AJAXCallWithResult("frmReleasePlanning.aspx/MapSprintToRelease", data, false);
                                            var Result = strResult.d.split("||")
                                            if (Result[0] != "") {

                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify('Sprint Mapped to Release successfully', 'success');
                                                $("#MainDiv").html(Result[1]);
                                                refresh();

                                            }
                                        }
                                    });
                                }
                                else {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('Before map sprint ,you should  first create release', 'error');
                                    $(ui.sender).sortable("cancel");
                                    return;
                                }
                            }

                            else {
                                //alert(strResult.d);
                                var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID }), false);
                                //alert(strResult.d);
                                if (strResult.d == "2") {
                                    // obj.disabled=true;
                                    //alert(strResult.d);
                                    var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: strIterationID, strRemark: "", ReleaseID: ReleaseID, Flag: "" }), false);
                                    if (result.d != "") {
                                        var ResultLefdiv = result.d.split("||")
                                        //alert(ResultLefdiv[1]);
                                        $("#MainDiv").html("");
                                        $("#MainDiv").html(ResultLefdiv[1]);
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Sprint UnMapped to Release successfully', 'success');
                                        // $("#Remark").modal("hide");
                                        refresh();
                                    }
                                    // GetIterationData(iterationID);
                                }
                                else if (strResult.d == "1") {
                                    // ShowPopup("Release is released.You can not terminate Sprint.");
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('Release is released.You can not terminate Sprint.', 'error');
                                    $(ui.sender).sortable("cancel");//Added By Dipali V on 26th June 2020 For Refresh issue
                                    return;

                                }
                                else if (strResult.d == "3") {
                                    //ShowPopup("You can not terminate Sprint.");
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('You can not terminate Sprint', 'error');
                                    $(ui.sender).sortable("cancel");//Added By Dipali V on 26th June 2020 For Refresh issue
                                    return;
                                }
                                else {
                                    //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
                                }
                            }

                        }

                        else {

                            $(this).sortable("cancel");
                        }

                    }
                }

            },
            cancel: "#DivDetailss",
            cancel: "#tblFGrid",
            cancel: "#rightNoddata"
        });
        $(".clsrightdiv").disableSelection();
        intDivGridListHeight = parseInt(window.innerHeight);
        $(".vl").css('height', intDivGridListHeight + 500 + 'px');
        $(".vl1").css('height', intDivGridListHeight + 500 + 'px');

        var $li = $('#tab_link a').on('click', function () {
            
            $li.removeClass('selected');
            $(this).addClass('selected');
            
            //var divId = $(this).attr("href").toString();
            //alert(divId);
            //divId = divId.replace("tab", "");
            //$("div").removeClass("activecls");
            //$("#" + divId).addClass("activecls");
        });

          $("#Button2").css('display', 'inline-block');
         AutoResizeTextArea();
            getRows();
            RemoveTextArea();
    });

    //For Refresh
    function refresh() {

        $('[data-bs-toggle="tooltip"]').tooltip()
        //$('.radio-inline').tooltip()
        //setFrameLoader();
        $(".clsrightdiv").sortable({
            connectWith: ".clsrightdiv ",
            placeholder: "placeholder",
            scroll: true,
            cursor: "move",
            opacity: 0.7,
        });


        //$('.clsrightdiv .card:not(.DivDetailss)').hover(function () {


        //}, function () {
        //    $(this).css("box-shadow", "");
        //    $(this).css("border", "");
        //});



        $(".clsrightdiv").sortable({
            connectWith: ".clsrightdiv",
            placeholder: "placeholder",
            activate: function (ev, ui) {

            },
            update: function (event, ui) {
                var strIterationID = "";
                var label = "", ReleaseID = 0;

                // alert(display1);
                if (ui.sender == null) {
                    //debugger;
                    $('.lblIDS').each(function () {
                        label = label + $(this).text() + ',';
                        //alert(label);

                    });
                }
                else {
                    //alert("Another");
                    // debugger;
                    var getDivID = $(this).attr('id');
                    var ReleaseID = document.getElementById('hdnReleaseID').value;
                    if (ReleaseID == "") {
                        ReleaseID = document.getElementById('hdnReleaseIDUS').value;
                    }

                    if (getDivID == "RightDiv") {

                        ReleaseID = ReleaseID;
                    }
                    else {
                        ReleaseID = ReleaseID;
                    }

                    if (strIterationID == "") {
                        strIterationID = $(ui.item).find("#hdnhdnIterationID").val();
                    }
                    else {
                        strIterationID += "," + $(ui.item).find("#hdnhdnIterationID").val();
                    }
                    // alert(strIterationID);
                    // alert(ReleaseID);
                    var ProjectID = document.getElementById('hdnProjectID').value;

                    if (ui.sender != null) {
                        if (strIterationID != undefined) {
                            if (getDivID == "RightDiv") {
                                $.ajax({
                                    url: "frmReleasePlanning.aspx/CheckReleaseDates",
                                    data: JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID, strProjectID: ProjectID }),
                                    type: "POST",
                                    contentType: "application/json;charset-utf=8",
                                    dataType: "json",
                                    success: function (result) {
                                        var strTextReleaseStartDate;
                                        var strTextReleaseEndDate;
                                        var strTextisValid;
                                        var strText;
                                        var arrStr;
                                        strText = String(result.d);
                                        arrStr = strText.split(",");
                                        strTextisValid = arrStr[0];
                                        strTextReleaseStartDate = arrStr[1];
                                        strTextReleaseEndDate = arrStr[2];
                                        //     alert(arrStr[4]);
                                        //if (arrStr[4] == 1) {
                                        //    //ShowPopup("ITERATIONMAPPING");
                                        //    alertify.set('notifier', 'position', 'top-right');
                                        //    alertify.notify('ITERATIONMAPPING.', 'error');
                                        //    $(ui.sender).sortable("cancel");
                                        //    return;
                                        //}

                                        if ((arrStr[5] == "Sprint Cancelled") || (arrStr[5] == "Sprint Terminated")) {
                                            //ShowPopup("Selected sprint is cancelled, you can not map cancelled sprint to release.");
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify('Selected sprint is cancelled/terminated, you can not map cancelled sprint to release.', 'error');
                                             //ADDED BY DIPALI V ON 29TH APRIL 2019 FOR DRAGGING
                                            $(ui.sender).sortable("cancel");
                                             //END OF ADDED BY DIPALI V ON 29TH APRIL 2019 FOR DRAGGING
                                            return;
                                        }

                                        if (arrStr[6] == "1") {
                                            // ShowPopup("Release is already started, you can not map sprint to release.");
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify('Release is already started, you can not map sprint to release.', 'error');
                                            $(ui.sender).sortable("cancel");
                                            return;
                                        }

                                        else if (arrStr[6] == "2") {
                                            // ShowPopup("Release is already started, you can not map sprint to release.");
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify('Released, you can not map sprint to release.', 'error');
                                            $(ui.sender).sortable("cancel");
                                            return;
                                        }

                                        else if (strTextisValid == 0) {
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify('Start Date and End Date should be between Release Dates i.e.' + strTextReleaseStartDate + " and " + strTextReleaseEndDate, 'error');
                                            // ShowPopup("Start Date and End Date should be between Release Dates i.e. " + strTextReleaseStartDate + " and " + strTextReleaseEndDate);
                                            $(ui.sender).sortable("cancel");
                                            return;
                                        }

                                        data = JSON.stringify({ strIterationID: strIterationID, ReleaseID: ReleaseID });
                                        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/MapSprintToRelease", data, false);
                                        var Result = strResult.d.split("||")
                                        if (Result[0] != "") {

                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify('Sprint Mapped to Release successfully', 'success');
                                            $("#MainDiv").html(Result[1]);
                                            refresh();

                                        }
                                    }
                                });
                            }
                            else {
                                //debugger;
                                //if (strIterationID == "")
                                //{
                                //    strIterationID = $(ui.item).find("#hdnhdnIterationID").val();
                                //}
                                //else {
                                //    strIterationID += "," + $(ui.item).find("#hdnhdnIterationID").val();
                                //}
                                var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID }), false);
                                if (strResult.d == "2") {
                                    // obj.disabled=true;

                                    var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: strIterationID, strRemark: "", ReleaseID: ReleaseID, Flag: "" }), false);
                                    if (result.d != "") {
                                        var ResultLefdiv = result.d.split("||")
                                        //alert(ResultLefdiv[1]);
                                        $("#MainDiv").html("");
                                        $("#MainDiv").html(ResultLefdiv[1]);
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Sprint terminated from Release successfully', 'success');
                                        // $("#Remark").modal("hide");
                                        refresh();
                                    }
                                    // GetIterationData(iterationID);
                                }
                                else if (strResult.d == "1") {
                                    // ShowPopup("Release is released.You can not terminate Sprint.");
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('Release is released.You can not terminate Sprint.', 'error');//Added By Dipali V on 26th June 2020 For Refresh issue
                                    $(ui.sender).sortable("cancel");
                                    return;
                                }
                                else if (strResult.d == "3") {
                                    //ShowPopup("You can not terminate Sprint.");
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('You can not terminate Sprint', 'error');//Added By Dipali V on 26th June 2020 For Refresh issue
                                     $(ui.sender).sortable("cancel");
                                    return;
                                }
                                else if (strResult.d == "4") {
                                    //ShowPopup("You can not terminate Sprint.");
                                    alertify.set('notifier', 'position', 'top-right');//Added By Dipali V on 26th June 2020 For Refresh issue
                                    alertify.notify('Sprint is already completed, you can not teriminate the sprint.', 'error');
                                    $(ui.sender).sortable("cancel");
                                    return;
                                }
                                else {
                                    //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
                                }
                            }

                        }

                        else {

                            $(this).sortable("cancel");
                        }

                    }
                }

            },
            cancel: "#DivDetailss",
            cancel: "#tblFGrid",
            cancel: "#rightNoddata"
        });
        $(".clsrightdiv").disableSelection();


        intDivGridListHeight = parseInt(window.innerHeight);
        $(".vl").css('height', intDivGridListHeight + 350 + 'px');
        $(".vl1").css('height', intDivGridListHeight + 350 + 'px');


        $('.fa').tooltip();
        $('span').tooltip();
        //$('p').tooltip();
        $('lblname').tooltip();


        var $li = $('#tab_link a').on('click', function () {
            $li.removeClass('selected');
            $(this).addClass('selected');

            // var divId = $(this).attr("href").toString();
            //  alert(divId);
            //divId = divId.replace("tab", "");
            //$("div").removeClass("activecls");
            //$("#" + divId).addClass("activecls");
        });
        $("#Button2").css('display', 'inline-block');

    }

    //select One checkbox at time
    function SelectOne(obj) {
        $('input.clscheckbox').on('change', function () {
            $('input.clscheckbox').not(this).prop('checked', false);
        });
        $(this).is(":checked");
        if ($(this).is(":checked")) {
            $('#DivRleaselist input[name=SelectReleaseList]:checked').each(function () {
                $('#hdnselectedReleaseID').val(strSeletedRelease + ',');

            });

        }
        else {
            $(this).prop('checked', false);
            $('#hdnselectedReleaseID').val("")

        }
        //alert($('#hdnselectedReleaseID').val());

    }


    //select One checkbox at time (US List)
    function SelectMappedUS(obj, USID, Flag) {
        // alert(Flag);
        if (Flag == "Us") {
            $('input.clscheckbox').on('change', function () {
                $('input.clscheckbox').not(this).prop('checked', false);
            });
            $(this).is(":checked");
        }
        else if (Flag == "Sprint") {
            $('input.clscheckboxSprint').on('change', function () {
                $('input.clscheckboxSprint').not(this).prop('checked', false);
            });
            $(this).is(":checked");
        }
        else if (Flag == "Release") {
            $('input.clscheckboxRelease').on('change', function () {
                $('input.clscheckboxRelease').not(this).prop('checked', false);
            });
            $(this).is(":checked");
        }
    }
    //function SetWidthHeight() {
    //    //  $("#divMain").css("height", window.innerHeight - 12 + 'px');
    //    //$(".Main").css("height", window.innerHeight - 80 + 'px');
    //    $("#divUSbodys").css("height", (window.innerHeight / 1.5) + 50 +'px');
    //    $(".container-fluid").css("height", window.innerHeight - 12 + 'px');

    //    $("#divUSbodys").css("margin-top", '-2%');
    //    //if ($(window).width() > 768) {
    //    //    $(".divDraggable").css("min-height", window.innerHeight - 80 + 'px');
    //    //    $(".divDraggable").css("height", '100%');
    //    //    //$(".Main").css("height", window.innerHeight - 80 + 'px');
    //    //    $(".divDraggable").css("width", (window.innerWidth / 3) - 35 + 'px');
    //    //}
    //    //else {
    //    //    $(".divDraggable").css("min-height", '');
    //    //    $(".divDraggable").css("height", '');
    //    //    $(".Main").css("height", '');
    //    //    $(".divDraggable").css("width", '100%');
    //    //}



    //}
    $(window).resize(function () {
        //SetWidthHeight()
    })

    //For Showwing All Release List
    function ShowAllReleaseList() {
        var strResult, data, SelectedReleaseID;
        // debugger;
        if ($('#hdnselectedReleaseID').val() != '') {
            data = JSON.stringify({ Flag: "Release", SelectedReleaseID: $('#hdnselectedReleaseID').val() });
        }
        else {
            {
                data = JSON.stringify({ Flag: "Release", SelectedReleaseID: "" });
            }
        }
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/ReleaseList", data, false);

        //alert($('#hdnselectedReleaseID').val());
        //$('#hdnselectedReleaseID').val($('#hdnselectedReleaseID').val().replace(/,$/g,''));


        if (strResult.d != '') {
            $("#Idheader").html("Select Releases")
            $("#DivRleaselist").modal('show');
            $("#divListdetails").html(strResult.d);
            if ($("#FilterRelease").val() > 0) {
                datatables('DivRelaseList', 'txtSearchRelease', '')
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            // $('.radio-inline').tooltip()
            //$('#DivRelaseList .odd').tooltip();
            //$('#DivRelaseList .even').tooltip();
        }

    }

    function ApplyFilter(Flag) {
        var strSeletedUS = "", strSeletedSprint = "", strSeletedRelease = "";
        //  debugger;
        var flag = 0;
        if (Flag == "UserStory") {
            flag = 1;
            strSeletedUS = $('input[name=SelectUSList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedUS.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one User Story', 'error');
                return;
            }
        }
        else if (Flag == "Sprint") {
            // alert("Sprints");
            flag = 1;
            strSeletedUS = $('input[name=SelectSprintList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedUS.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            }
        }
        else {
            //  alert("Release");
            flag = 1;
            strSeletedUS = $('input[name=SelectReleaseList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedUS.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Release', 'error');
                return;
            }
        }

        if (flag == 1) {
            // debugger;
            var strResult, data;
            var ReleaseID = document.getElementById('hdnReleaseID').value;
            data = JSON.stringify({ ReleaseID: "", strSeletedUS: strSeletedUS, FilterFlag: Flag });//UserStory
            strResult = AJAXCallWithResult("frmReleasePlanning.aspx/SelectUserStory", data, false);

            if (strResult.d != '') {


                //$("#MainDiv").html("");
                //$("#MainDiv").html(strResult.d);
                // $("#FilterUS").modal('hide');

                // $("#Idheader").html("Release")
                // $("#DivRleaselist").modal('show');

                if (Flag == "Sprint") {
                    $("#FilterSprint").modal('hide');
                    $("#MainDiv").html("");
                    $("#MainDiv").html(strResult.d);
                }
                else if (Flag == "UserStory") {
                    $("#FilterUS").modal('hide');
                    $("#MainDiv").html("");
                    $("#MainDiv").html(strResult.d);
                }
                else {
                    $("#FilterRelese").modal('hide');
                    $("#MainDiv").html("");
                    $("#MainDiv").html(strResult.d);
                }

                refresh();
                $('[data-bs-toggle="tooltip"]').tooltip();
                // $('.radio-inline').tooltip()
            }
        }

    }

    //For Remark Validation
     var span1 = 0;
    function CheckTextLength(obj, lbl, span) {
      
        var MaxLength = obj.getAttribute("maxlength");
        // alert(MaxLength)
        if (span1 == 0)
        {

               if (parseInt(String(obj.value).length) >= MaxLength) {
          
                   //debugger;
                    $("#" + span).css("display", "block")
                    // $("#" + span).text("you can enter only " + MaxLength + " characters.");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("You can enter only " + MaxLength + " characters.", 'error');
                   span1 = 1;
                   return;
                }
                else {
                   $("#" + span).text("");
                   span1 = 0;
                }


        }
        if (obj.value == "") {
            $("#" + span).css("display", "block")
            obj.focus();
        }
        
        document.getElementById(lbl).innerHTML = '-' + (MaxLength - parseInt(String(obj.value).length));
    }


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
            if ($("#txtRemark3").val() != undefined) {
                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtRemark3").val().split('\n');
                var lineheight = $("#txtRemark3").val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("txtRemark3").rows = numberOfLines + 1;
                    $("#txtRemark3").attr("style", "height: auto !important");
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












    //For Remark Focus
    function focusTextBox(txtID, IterationID, ReleaseID) {
        // $("#" + txtID).focus();
        //debugger;
        var strResult, data;
        data = JSON.stringify({ IterationID: IterationID, ReleaseID: ReleaseID });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/PlotTerminated", data, false);

        if (strResult.d != '') {

            $("#Remark").modal('show');
            $("#SprintHeader").html("Unmap From Release");
            $("#TerminateRemark").html(strResult.d);
            $("#" + txtID).focus();

            var txtRemark = document.getElementById(txtID);
            setTimeout(function () {
                txtRemark.focus();
            }, 100);

        }
        /*Added by kashish For Texarea Enhancement*/
        //AutoResizeTextArea();

        //RemoveTextArea();
        //autosize(document.querySelectorAll('textarea'));
    }

    //For Terminate Sprint
    function TerminateSprint(iterationID, ReleaseID, txtID, obj) {
      //debugger;
        var txtRemark = document.getElementById(txtID);
        var spanRemark = document.getElementById("spanRemark" + iterationID);
        if (txtRemark.value != "") {
            var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: iterationID, strReleaseID: ReleaseID }), false);
            if (strResult.d == "2") {
                // obj.disabled=true;

                var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: iterationID, strRemark: txtRemark.value, ReleaseID: ReleaseID, Flag: "" }), false);
                if (result.d != "") {
                    var ResultLefdiv = result.d.split("||")
                    //alert(ResultLefdiv[1]);
                    $("#MainDiv").html("");
                    $("#MainDiv").html(ResultLefdiv[1]);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint UnMapped to Release successfully', 'success');
                    $("#Remark").modal("hide");
                    refresh();
                }
                // GetIterationData(iterationID);
            }
            else if (strResult.d == "1") {
                // ShowPopup("Release is released.You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Release is released.You can not terminate Sprint.', 'error');
                $(ui.sender).sortable("cancel");//Added By Dipali V on 26th June 2020 For Refresh issue
                                    return;
            }
            else if (strResult.d == "3") {
                //ShowPopup("You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You can not terminate Sprint', 'error');
                $(ui.sender).sortable("cancel");//Added By Dipali V on 26th June 2020 For Refresh issue
                                    return;
            }
            else {
                //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
            }
        }
        else {
            $("#" + "txtRemark" + iterationID).css('border-color', 'red');
            $("#" + "txtRemark" + iterationID).css('border-width', '1px');
            $("#" + "spanRemark" + iterationID).text("Please Enter Remark");
            return false;
        }
        /*Added by kashish For Texarea Enhancement*/
        //AutoResizeTextArea();
        //getRows();
        //RemoveTextArea();
        //autosize(document.querySelectorAll('textarea'));
    }

    //For Select Release
    var SetFlag = 0;
    function SelectRelease() {


        var strSeletedRelease = "";
        strSeletedRelease = $('input[name=SelectReleaseList]:checked').map(function () {
            return this.value;
        }).get().join(',');

        $('#DivRleaselist input[name=SelectReleaseList]:checked').each(function () {
            $('#hdnselectedReleaseID').val(strSeletedRelease + ',');
            if ($('#hdnselectedReleaseID').val() != "") {
                SetFlag = 1;
            }
        });

        // $('#hdnselectedReleaseID').val($('#hdnselectedReleaseID').val().replace(/,$/g,''));

        if (strSeletedRelease.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Select at least one Release', 'error');
            return;
        }
        else {

            var strResult, data;
            data = JSON.stringify({ strSeletedRelease: strSeletedRelease });
            strResult = AJAXCallWithResult("frmReleasePlanning.aspx/SelectRelease", data, false);

            if (strResult.d != '') {
                // alert(strResult.d);
                $("#DivRleaselist").modal('hide');
                $("#MainDiv").html("");
                $("#MainDiv").html(strResult.d);
                refresh();
                //$("#Idheader").html("Release")
                //$("#DivRleaselist").modal('show');
                //$("#divListdetails").html(strResult.d);
            }
        }

    }

    //For Datatable
    function datatables(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-striped");
        var table = $('#' + divID + ' > table').DataTable({
            "responsive": true,
            "pageLength": 5,
            "scrollY": '260px',
            "pagingType": "numbers",
            "sorting": true,
            "scrollX": true,
            "tooltip": true,
            "destroy": true


        });

        //  table.$('tr').tooltip();

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }


    }

    //For Open Modal
    var SprintID = 0;
    var ReleaseID = 0;
    function ShowModal(type, categoryID, obj) {
        globalReleaseID = "";
        // ReleaseID="";
        //For Hightlight Selected Option
        $('.dropdown-item').removeClass('active');
        $(obj).addClass('active');
        //End of Hightlight Selected Option
        var categoryID = "";

        var strUserResult = ajaxCall("frmReleasePlanning.aspx/AddUserStoryModal", "POST", "application/json", "json", JSON.stringify({ CategoryID: categoryID, type: type }));
        //alert(strUserResult.d);
        //debugger;
        // document.getElementById("divUSbodys").innerHTML = strUserResult.d;
        //$("#divProductBacklog_Body").html(strUserResult.d);
        //$("#divProductBacklog_Body").find("input,textarea,select").removeAttr("disabled");
        //$("#divProductBacklog_Body").find("input,textarea,select").removeAttr("readonly");divUSbodys
        if (type == "User") {
            $("#divUSbodys").html(strUserResult.d);
            $("#divUSbodys").find("input,textarea,select").removeAttr("disabled");
            $("#divUSbodys").find("input,textarea,select").removeAttr("readonly");
            $("#divUS").modal('show');
            /*Added by kashish For Texarea Enhancement*/
            AutoResizeTextArea();
            RemoveTextArea();
            //autosize(document.querySelectorAll('textarea'));
        }

        else if (type == "Sprint" || type == "Release") {
            $("#DashBody").html("");
            $("#SprintBody").html(strUserResult.d);
            /*Added by kashish For Texarea Enhancement*/
            //AutoResizeTextArea();
            RemoveTextArea();
            //autosize(document.querySelectorAll('textarea'));
            //$("#divUSbodys").find("input,textarea,select").removeAttr("disabled");
            //$("#divUSbodys").find("input,textarea,select").removeAttr("readonly");
            $("#CreateSprint").modal('show');
            if (type == "Sprint") {
                $("#HeaderCreate").html('Create Sprint')

                $("#SprintStartdate,#SprintEnddate").change(function () {
                    GetDuration("Edit");
                });


            }
            else {
                $("#HeaderCreate").html('Create Release')
                $("#hdnReleaseIDnew").val("");
                $("#RstartDate,#txtEndDate").change(function () {
                    GetDuration("Release");
                });
                /*Added By yasmin on 5-3-19*/
                $('#RstartDate,#txtEndDate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        //yearRange: '2000:2020'
                        yearRange: 'c-100:c+100'
                        //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    }
                );
                $('#RstartDate,#txtEndDate').prop('readonly', true);
            }
        }

        //else if (type == "Release") {
        //    $("#SprintBody").html(strUserResult.d);
        //    //$("#divUSbodys").find("input,textarea,select").removeAttr("disabled");
        //    //$("#divUSbodys").find("input,textarea,select").removeAttr("readonly");
        //    $("#CreateSprint").modal('show');
        //}

        // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        var dtfmt = dtFormat(opDateFormat);

        $('#SprintStartdate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                 yearRange: 'c-100:c+100'
                 //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                , dateFormat: dtfmt
            }
        );

        $('#SprintEnddate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                , dateFormat: dtfmt
            }
        );
        $('#SprintEnddate,#SprintStartdate').prop('readonly', true);
        //End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
    }

    var arrFile = [];
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
    //For Select Priority
    function SelectPriorityColor(PriorityID) {

        var PriorityID = PriorityID.value;
        if (PriorityID != "") {
            var url = "frmReleasePlanning.aspx/GetPriorityColor";
            var data = JSON.stringify({ PriorityID: PriorityID });
            var strResult = ajaxCall(url, "POST", "application/json", "json", data);
            GetPriorityColor_Success(strResult);
        }
    }

    function GetPriorityColor_Success(result) {

        var arrPriority = String(result.d).split("||")
        var cColor = arrPriority[0]
        var ChangeColorTD = arrPriority[1];
        $("#tblPriorityColor").html("")
        $("#tblPriorityColor").append(ChangeColorTD);
        $("#iPriorityColor").css("color", cColor)
    }

    var cColor;
    function ChangeColor(ID, color, mode) {
        cColor = color;
        var url = "frmReleasePlanning.aspx/ChangeColor";
        var data = JSON.stringify({ ID: ID, color: color, mode: mode });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        ChangeColor_Success(strResult);

    }
    function ChangeColor_Success(result, para) {

        if (result.d == 1) {
           /* Modified By Madhuri.K On 03-04-2026 */ 
            $("#iPriorityColor").attr("style", "font-size:11.5px;color:" + cColor + "!important")
        }
        if (result.d == 2) {
            /* Modified By Madhuri.K On 03-04-2026 */ 
            $("#oColor").attr("style", "font-size:11.5px;color:" + cColor + "!important")
        }
        if (result.d == 3) {
            /* Modified By Madhuri.K On 03-04-2026 */ 
            $("#iVersion").attr("style", "font-size:11.5px;color:" + cColor + "!important")
        }
        if (result.d == 4) {
            /* Modified By Madhuri.K On 03-04-2026 */ 
            $("#iFVersion").attr("style", "font-size:11.5px;color:" + cColor + "!important")
        }
        //var url = "frmProductBacklog.aspx/RefreshGrid";
        //var data = JSON.stringify({});
        //AJAXCall(url, data, BindGrid);

    }


    //For Select Category
    function SelectCategoryColor(categoryID) {

        var categoryID = categoryID.value;
        if (categoryID != "") {
            var url = "frmReleasePlanning.aspx/GetCategoryColor";
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


    function ClearSpan(txt, span) {

        if ($('#' + txt).val() == "") {
        }
        else {
            $('#' + txt).css('border-color', '#d8dade');
            $('#' + txt).css('border-width', '1px');
            $('#' + span).text("");
        }
    }

    //For US Validation
    function SaveValidation() {
        var objPriorityForCompare = document.getElementById('cboPriority');
        var objSpanPriorityForCompare = document.getElementById('spanPriority');

        var CheckFlag = 0;
        //if (RestrictNonNumeric(objStoryPoint)) {

        //    $("#" + objStoryPoint.id).css('border-color', 'red');
        //    $("#" + objStoryPoint.id).css('border-width', '1px');
        //    $("#" + spanStoryPoint.id).text("Please Enter Numeric Value");
        //    CheckFlag = 1;
        //}
        //if (ValidateBlankField(objFeatureName, objSpanFeatureName, "Feature Name should not be blank") == 1) {
        //    CheckFlag = 1;
        //}
        //if (ValidateBlankField(objUserDesc, objSpanUserDesc, "User Description should not be blank") == 1) {
        //    CheckFlag = 1;
        //}
        //if (objPriorityForCompare != null && objSpanPriorityForCompare != null) {
        //    if (ValidateBlankField(objPriorityForCompare, objSpanPriorityForCompare, "Priority should not be blank") == 1) {
        //        CheckFlag = 1;
        //    }
        //}

        //if (String(objUserDesc.value).length > 1000) {
        //    $("#txtUserDesc").css({ 'border-color': 'red', 'border-width': '1px' });
        //    var Msg = "User Description shhould not be grater than 1000 characters.";
        //    Msg = Msg.replace('<control_name>', 'User Description');
        //    Msg = Msg.replace('<max_length>', '1000');
        //    Msg = Msg.replace('<L>', $("#txtUserDesc").val().length);
        //    $("#spanUserDesc").html(Msg);

        //    if (CheckFlag == 1) {
        //        $("#txtUserDesc").focus();
        //    }
        //    CheckFlag = 1;
        //}
        //return CheckFlag;

        var checkvalue = 0;
        var Flag = 0;
        var strmsg = "";
        var errorMsg = "<ul>"


        if ($("#txtFeatureName").val() == "") {
            strmsg = '- Feature Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
        if ($("#txtUserDesc").val() == "") {
            strmsg = '- User Description should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if (RestrictNonNumeric(document.getElementById('txtStoryPoint')) == true) {


            strmsg = '- Please Enter Numeric Value For Story Point';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }


        if ($("#cboPriority").val() == "") {
            strmsg = '- Priority should not be blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

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


        if ($("#txtStoryPoint").val() != undefined) {

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
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;

    }
    //function SaveValidation() {
    //    var objPriorityForCompare = document.getElementById('cboPriority');
    //    var objSpanPriorityForCompare = document.getElementById('spanPriority');

    //    var CheckFlag = 0;
    //    if (RestrictNonNumeric(objStoryPoint)) {

    //        $("#" + objStoryPoint.id).css('border-color', 'red');
    //        $("#" + objStoryPoint.id).css('border-width', '1px');
    //        $("#" + spanStoryPoint.id).text("Please Enter Numeric Value");
    //        CheckFlag = 1;
    //    }
    //    if (ValidateBlankField(objFeatureName, objSpanFeatureName, "Feature Name should not be blank") == 1) {
    //        CheckFlag = 1;
    //    }
    //    if (ValidateBlankField(objUserDesc, objSpanUserDesc, "User Description should not be blank") == 1) {
    //        CheckFlag = 1;
    //    }
    //    if (objPriorityForCompare != null && objSpanPriorityForCompare != null) {
    //        if (ValidateBlankField(objPriorityForCompare, objSpanPriorityForCompare, "Priority should not be blank") == 1) {
    //            CheckFlag = 1;
    //        }
    //    }

    //    if (String(objUserDesc.value).length > 1000) {
    //        $("#txtUserDesc").css({ 'border-color': 'red', 'border-width': '1px' });
    //        var Msg = "User Description shhould not be grater than 1000 characters.";
    //        Msg = Msg.replace('<control_name>', 'User Description');
    //        Msg = Msg.replace('<max_length>', '1000');
    //        Msg = Msg.replace('<L>', $("#txtUserDesc").val().length);
    //        $("#spanUserDesc").html(Msg);

    //        if (CheckFlag == 1) {
    //            $("#txtUserDesc").focus();
    //        }
    //        CheckFlag = 1;
    //    }
    //    return CheckFlag;

    //}
    var ExistingUniqueNo = 0;
    var UniqueNo = 0;

    //For US Saving
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


    var objComplexityTemp;
    var PriorityTemp;
    var strUserStoryId = "";
    function GetExistingUniqueNumberFromDB(objComplexity, Priority) {

        //debugger;
        objComplexityTemp = objComplexity;
        PriorityTemp = Priority;

        if (PriorityTemp != "") {
            var url = "frmReleasePlanning.aspx/GetExistingUniqueNumberFromDB";
            var data = JSON.stringify({ objComplexity: objComplexity, Priority: Priority, strUserStoryId: strUserStoryId });
            var strResult = ajaxCall(url, "POST", "application/json", "json", data);
            GetExistingUniqueNumberFromDB_Success(strResult);
        }
        else {
            if (SaveValidation() == 0) {
                var ProjectId = document.getElementById('hdnProjectID').value;
                var url = "frmReleasePlanning.aspx/SaveUserStory";
                objPriority = document.getElementById('cboPriority');
                if (ProjectId != "") {
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
                    //    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity.value, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                    //} else {

                    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity.value, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                    //}
                    var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                    SaveSuccess(strUserResult)
                    //alert(strUserResult.d);
                }
            }
        }
    }
    function SaveSuccess(result) {
        EditUserStory(result.d, '');
    }

    function GetComplexityUniqueNo(ExistingUniqueNo, objComplexity, Priority) {
        if (objComplexity == "High") {
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


    function limitText(limitField, limitCount, limitNum) {

        var length;
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            limitCount.innerHTML = (limitNum - limitField.value.length);
        }

        if (limitCount.innerHTML == 0) {
            if (limitCount.id == 'countdownBU') {
                document.getElementById("countdownBU").style.color = 'red' //when Char 0 length  then Color red
                $('#spanBusinessValue').html("You Can Enter Only 200 Character");
            }
            else if (limitCount.id == 'countdownAC') {
                document.getElementById("countdownAC").style.color = 'red' //when Char 0 length  then Color red
                $('#spanAcceptanceCriteria').html("You Can Enter Only 200 Character");
            }
            else {
                document.getElementById("countdown").style.color = 'red' //when Char 0 length  then Color red
                $('#spanUserDesc').html("You Can Enter Only 1000 Character");
            }
        }
        else {
            if (limitCount.id == 'countdownBU') {
                document.getElementById("countdownBU").style.color = 'black'
                $('#spanBusinessValue').text("");
            }
            else if (limitCount.id == 'countdownAC') {
                document.getElementById("countdownAC").style.color = 'black'
                $('#spanAcceptanceCriteria').text("");
            }
            else {
                document.getElementById("countdown").style.color = 'black'
                $('#spanUserDesc').text("");
            }
        }
    }



    function ShowLength(limitField, limitCount, limitNum, Flag) {

        var length;
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            limitCount.innerHTML = (limitNum - limitField.value.length);
        }

        if (limitCount.innerHTML == 0) {
            if (Flag == 'Sprint') {
                document.getElementById("countdownSprint").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanBusinessValue').html("You Can Enter Only 100 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error');
            }
            else if (Flag == 'Release') {
                document.getElementById("countdownRelease").style.color = 'red' //when Char 0 length  then Color red
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error');
            }

        }
        else {
            if (Flag == 'Sprint') {
                document.getElementById("countdownSprint").style.color = 'black'
                // $('#spanBusinessValue').text("");
            }
            else if (Flag == 'Release') {
                document.getElementById("countdownRelease").style.color = 'black'
                // $('#spanAcceptanceCriteria').text("");
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

    //Validate Description Limit
    //function CheckTextLength(limitField, limitCount, limitNum) {
    //    //  alert();
    //    var length;
    //    if (limitField.value.length > limitNum) {
    //        limitField.value = limitField.value.substring(0, limitNum);
    //    } else {
    //        limitCount.innerHTML = '-' + (limitNum - limitField.value.length);
    //    }
    //    if (limitField.id == "txtDescription") {
    //        if (limitCount.innerHTML == 0) {

    //            //document.getElementById("countdowndes").style.color = 'red'
    //            $("#ShowCount").css("color", "red");
    //            $("#ShowCount").css("margin-top", "-27px");
    //            $("#txtDescription").css("border-color", "red");
    //            $("#txtDescription").addClass('clstxtArea');
    //            $("#ShowErrorMSG").css("color", "red");
    //            $('#ShowErrorMSG').html("You Can Enter Only 500 Character").show();
    //        }
    //        else {

    //            //document.getElementById("countdowndes").style.color = 'black'
    //            $("#ShowCount").css("color", "black");
    //            $("#ShowCount").css("margin-top", "");
    //            $('#txtDescription').css('border-color', 'rgb(216, 218, 222)');
    //            $('#ShowErrorMSG').text("");
    //            //$("#ShowErrorMSG").css("color", "red");
    //            $("#txtDescription").addClass('clstxtArea');
    //        }
    //    }
    //}

    //For Edit US 
    function EditUserStory(userStoryID, flag) {
        //  debugger;
        strUserStoryId = userStoryID
        var strResult = ajaxCall("frmReleasePlanning.aspx/GetUserStoryDetails", "POST", "application/json", "json", JSON.stringify({ UserStoryId: userStoryID }))
        $("#headerUS").html("User Story Details");

        //$("#SectionHeader").css('display', 'none');
        $("#Button2").css('display', 'none');
        // alert(strResult.d);
        //$("#FreeTextBox_editor").Editor();
        $("#divUSbodys").html(strResult.d);
        //alert(window.innerHeight / 2 - 50)
        $('#divUserStroryDetails').css("height", (window.innerHeight / 2) - 10 + 'px');
        $('#divUserStroryDetails').css("overflow", "auto");
        //divUserStroryDetails
        //$("#divUSbodys").css("height", (window.innerHeight / 1.5) + 100 +'px');
        $("#divUSbodys").css("margin-top", '-2%');
        $('#ulTabs li').on('click', function () {
            $('#ulTabs li a').css("text-decoration", "none");
            $('#ulTabs li a').css("color", "");
            $("a", this).css("text-decoration", "underline");
            $("a", this).css("color", "#5bc0de");
        })
        $(".clsBox").hover(function () {
            $('#ulTabs li a').css("text-decoration", "none");
            $('#ulTabs li a').css("color", "");
            $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
            $("[href=#" + $(this).attr("id") + "]").css("color", "#5bc0de");
        })



        // var scrollPos = $("#" + flag + "").offset().top;
        //  $("#divUserStroryDetails").scrollTop(scrollPos - 250);



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

        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });
        document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'
        // $("#txtDiscussion").Editor();
        $('[data-bs-toggle="tooltip"]').tooltip();
        //Added By Dipali V On 28th March 2023 For Datable Issue
        if ($("#FilterHistorykList").val() > 0) {
            datatables('DivHistorykList', 'txtSearchhistory', '')
        }

        if ($("#FilterIssuesList").val() > 0) {
            datatables('DivSubTabIssuesList', 'txtSearchIssue', '')
        }

        if ($("#FilterReviewList").val() > 0) {
            datatables('DivReviewList', 'txtSearchReviews', '')
        }

        if ($("#FilterTaskList").val() > 0) {
            datatables('DivTaskList', 'txtSearchTask', '')
        }
        //End of Added By Dipali V On 28th March 2023 For Datable Issue
        // ID = ' txtReported'
        // timeNow(ID);
        var projectid = $("#hdnProjectID").val();
        // debugger;
        IssueType_OnChange(projectid)


        GetLineBurnUP(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
        GetLineBurnDown(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");

        GetLineBurnUPEffortS(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
        GetLineBurnDownStoryPoints(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");


        GetLineVelocityEffortBar(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
        GetLineVelocityStoryBar(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");


        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });
        document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 120) + 'px';
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('.fa-pencil-alt').tooltip();
        /*Added By yasmin on 5-3-19*/
        $('#txtEndDate,#txtStartDate,#txtStartDate0,#txtEndDate0,#txtReviewStartDate,#txtReviewEnddate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
               //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
               //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            }
        );
        //  IssueType_OnChange();
    }


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

            if (ele != undefined) {
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
            var url = "frmReleasePlanning.aspx/SaveUserStory";

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

    //For Validation Numeric
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
    //For Validation Blank
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

    //For Searching By Sprint Name
    function SearchBySprintName() {
        //debugger;
        var strResult, data;
        var filtertext = $("#txtSearchSprint").val();
        var ProjectID = $("#hdnProjectID").val();

        data = JSON.stringify({ filtertext: filtertext, ProjectID: ProjectID });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/FilterSprintsection", data, false);

        if (strResult.d != '') {
            //alert(strResult.d);
            $("#SearchID").html("");
            $("#SearchID").html(strResult.d);
            ////$("#LeftDiv").removeClass('clsrightdiv ui-sortable');
            ////$("#SearchID").addClass('clsrightdiv ui-sortable')

        }

    }












    //Filter Section
    var currentReleaseID;
    function FilterUSData(Entity, object) {
        // alert(Entity)
        // debugger;
        // $('.dataTables_scrollBody').tooltip();
        //  $('.clsTREvenRow').tooltip();
        $('.clsli').removeClass('ApplyActiveclass');
        $(this).addClass('ApplyActiveclass');
        $("#txtSearchUS").val("");
        var ReleaseID = document.getElementById('hdnReleaseID').value;
        if (ReleaseID == "") {
            ReleaseID = document.getElementById('hdnReleaseIDUS').value;
        }

        // alert(ReleaseID);
        // if (Entity != "US")
        if (Entity != "UserStory" && Entity != "Sprint" && Entity != "Release1") {
            if (Entity == "CurrentSprint") {
                ReleaseID = ""

            }
            else {
                Entity = "null"
                ReleaseID = ReleaseID;
            }
            var strUserResult = ajaxCall("frmReleasePlanning.aspx/SelectUserStory", "POST", "application/json", "json", JSON.stringify({ ReleaseID: ReleaseID, strSeletedUS: "", FilterFlag: Entity }));
            $("#MainDiv").html("");
            // alert(strUserResult.d);
            $("#MainDiv").html(strUserResult.d);

            // $("#rightNoddata").html("");
            refresh();
        }
        else {
            // alert();
            var strUserResult = ajaxCall("frmReleasePlanning.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ Entity: Entity, ReleaseID: ReleaseID }));

            if (Entity == "UserStory") {
                $("#FilterUSbody").html("");
                $("#FilterUSbody").html(strUserResult.d);
                if ($("#FilterUserStory").val() > 0) {
                    datatables('DivUSlist', 'txtSearchUS', '')
                }
                $("#FilterUS").modal('show');
            }
            else if (Entity == "Sprint") {
                $("#FilterSprintbody").html("");
                $("#FilterSprintbody").html(strUserResult.d);
                if ($("#Filter_NewSprint").val() > 0) {
                    datatables('DivSprintlist', 'txtSearchSprint11', '')
                }
                //  $("#FilterHeader").html("")
                // $("#FilterHeader").html("Sprint")
                $("#FilterSprint").modal('show');
            }
            else {
                $("#FilterReleasebody").html("");
                $("#FilterReleasebody").html(strUserResult.d);
                if ($("#FilterRelease1").val() > 0) {
                    datatables('DivRelease1list', 'txtSearchRelease11', '')
                }
                // $("#FilterHeader").html("")
                // $("#FilterHeader").html("Release")
                $("#FilterRelese").modal('show');
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            //  $('.radio-inline').tooltip()
            //datatables('DivUSlist', 'txtSearchUS', '')
            //datatables('DivUSlist', 'txtSearchUS', '')


        }

    }


    var SprintID = 0;
    //var ReleaseID=0;
    var GlobaluniqueId = "";
    function SaveSprintRelease(Flag) {
       // debugger;
        
        if (Flag == "Sprint") {
            if (validationSprit() == 0) {
                //debugger;
                //if ($("#hdnSprintIDnew").val() != undefined) {
                //    $("#Sprintname").val("");
                //    $("#SprintStartdate").val("");
                //    $("#txtDescriptionSprint").val("");
                //    $("#SprintEnddate").val("");
                //    $("#txtCalendar").val("");
                //    $("#txtBusiness").val("");
                //    $("#txtEfforts").val("");
                //}

                var Sprintname = $("#Sprintname").val();

                // Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993    
                //var SprintStartdate = $("#SprintStartdate").val();
                //var SprintEnddate = $("#SprintEnddate").val();
                //End of Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                var txtDescriptionSprint = $("#txtDescriptionSprint").val();
                var txtCalendar = $("#txtCalendar").val();
                var txtBusiness = $("#txtBusiness").val();
                var txtEfforts = $("#txtEfforts").val();
                var ProjectID = document.getElementById('hdnProjectID').value;

                 // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                //var SprintStartdate = dtsdt;
                //var SprintEnddate = dtedt;
                var SprintStartdate = '';
                var SprintEnddate = '';
               
                if (dtsdt.indexOf("undefined") == -1 && dtedt.indexOf("undefined") == -1) {
                    SprintStartdate = dtsdt;
                    SprintEnddate = dtedt;

                }
                else {
                    SprintStartdate = $("#SprintStartdate").val();
                    SprintEnddate = $("#SprintEnddate").val();
                }
                //End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993


                if (Sprintname == "") {
                    Sprintname = "";
                }
                else {
                    Sprintname = Sprintname.replace(/'/g,"''");
                }

                if (txtDescriptionSprint == "") {
                    txtDescriptionSprint = "";
                }
                else {
                    txtDescriptionSprint = txtDescriptionSprint;
                }


                if (txtEfforts == "") {
                    txtEfforts = "";
                }
                else {
                    txtEfforts = txtEfforts;
                }
                // debugger;

                //Added by Usha Pandit on 02.05.2019 for selecting current release
                //globalReleaseID = $("#hdnReleaseIDnewup").val();
                //End of Added by Usha Pandit on 02.05.2019 for selecting current release

                if (globalReleaseID != "") {
                    ReleaseID = globalReleaseID;
                } else {
                    ReleaseID = "0";
                }
                //alert(ReleaseID);





                var SprintID = $("#hdnSprintIDnew").val();
                //alert(SprintID);
                if (SprintID != undefined) {
                    SprintID = SprintID;
                } else {
                    SprintID = "0";
                }

                
                var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveSprintRelease", "POST", "application/json", "json", JSON.stringify({ Flag: Flag, SprintID: SprintID, ProjectID: ProjectID, Sprintname: Sprintname, ReleaseID: ReleaseID, txtDescriptionSprint: txtDescriptionSprint, SprintStartdate: SprintStartdate, SprintEnddate: SprintEnddate, txtCalendar: txtCalendar, txtEfforts: txtEfforts, txtBusiness: txtBusiness, strStatus: "" }));
               
                if (strUserResult.d != "") {
                    //debugger;


                    var NewSprintID = strUserResult.d;
                    alertify.set('notifier', 'position', 'top-right');
                    //Commented and Added by Usha Pandit on 02.05.2019 for wrong alert
                    //alertify.notify('Sprint Created Successfully', 'success');
                    if (SprintID == "0") {
                        alertify.notify('Sprint Created Successfully', 'success');
                    }
                    else {
                        alertify.notify('Sprint Updated Successfully', 'success');
                    }
                    //End of Added by Usha Pandit on 02.05.2019 for wrong alert
                    $("#CreateSprint").modal('hide');
                    //  $("#hdnNewCreatedReleaseID").val(NewSprintID)
                    //   debugger;
                    // alert(NewSprintID);
                    //  debugger;
                    if (strUserResult.d != "") {
                        NewSprintID = strUserResult.d;

                    }
                    else {
                        NewSprintID = $("#hdnSprintIDnew").val();

                    }
                    AfterRelaseSprintSave(Flag, NewSprintID)
                    //debugger;
                    getRows();
                    // $("#DashBody").html("");
                    //$("#DashBody").html(strUserResult.d);
                    //$("#myModal_dash").modal('show');
                }
            }
            else {


            }
        }

        else {
            if (validationRelease() == 0) {
                //  debugger;
                var ReleaseName = $("#ReleaseName").val();
                var RstartDate = $("#RstartDate").val();
                var txtDescription = $("#txtDescription").val();
                var txtEndDate = $("#txtEndDate").val();
                var txtRelCalendar = $("#txtRelCalendar").val();
                // var txtBusiness = $("#txtBusiness").val();
                var txtRelEfforts = $("#txtRBusinessDuration").val();
                var ProjectID = document.getElementById('hdnProjectID').value;



                if (ReleaseName == "") {
                    ReleaseName = "";
                }
                else {
                    ReleaseName = ReleaseName.replace(/'/g,"''");
                }

                if (txtDescription == "") {
                    txtDescription = "";
                }
                else {
                    txtDescription = txtDescription;
                }


                if (txtRelEfforts == "") {
                    txtRelEfforts = "";
                }
                else {
                    txtRelEfforts = txtRelEfforts;
                }

                var ReleaseID = $("#hdnReleaseIDnew").val();
                if (ReleaseID != undefined) {
                    ReleaseID = ReleaseID;
                } else {
                    ReleaseID = "0";
                }



                SprintID = "0";
                var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveSprintRelease", "POST", "application/json", "json", JSON.stringify({ Flag: Flag, SprintID: ReleaseID, ProjectID: ProjectID, Sprintname: ReleaseName, ReleaseID: ReleaseID, txtDescriptionSprint: txtDescription, SprintStartdate: RstartDate, SprintEnddate: txtEndDate, txtCalendar: txtRelCalendar, txtEfforts: txtRelEfforts, txtBusiness: "", strStatus: "" }));

                if (strUserResult.d != "") {
                    //  debugger;

                    var NewSprintID = strUserResult.d;
                    GlobaluniqueId = NewSprintID;


                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Release saved Successfully', 'success');
                    $("#CreateSprint").modal('hide');

                    AfterRelaseSprintSave(Flag, NewSprintID)
                    // var strResult = ajaxCall("frmReleasePlanning.aspx/Modal_popupdashboard", "POST", "application/json", "json", JSON.stringify({}));
                    // alert(strUserResult.d);
                    // $("#DashBody").html("");
                    // $("#DashBody").html(strResult.d);
                    // $("#myModal_dash").modal('show');

                }
            }
        }


    }

    function validationSprit() {

        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        dtStartDate = document.getElementById("SprintStartdate");
        dtEndDate = document.getElementById("SprintEnddate");
        var ProjectID = document.getElementById('hdnProjectID').value;
        if ($("#Sprintname").val() == "") {
            strmsg = '- Sprint Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
        //Added By Riddhesh Patil on 11-NOV-2022 
        else if (checkSpecialCharacter($("#Sprintname").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Sprint Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#Sprintname").focus();
            checkvalue = 1;
        }

        else if ($("#txtDescriptionSprint").val() != "") {
            if (checkSpecialCharacter($("#txtDescriptionSprint").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescriptionSprint").focus();
                checkvalue = 1;
            }
        }
        //End of Added By Riddhesh Patil

        //Commented by Rutuja D. on 18 feb 2022 for issueid = 32109
        //if ($("#Sprintname").val() != "") {
        //    if (checkSpecialCharacter($('#Sprintname').val()) == true) {
        //        // alertify.set('notifier', 'position', 'top-right');
        //        strmsg = '- Sprint Name cannot contain any of these /\\:*?<>|,"+- Characters';
        //        errorMsg += "<li>" + strmsg + "</li></br>";
        //        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
        //        checkvalue = 1;

        //    }
        //}
         //Commented by Rutuja D. on 18 feb 2022 for issueid = 32109


        if ($("#SprintStartdate").val() == "") {
            strmsg = '- Sprint Start Date should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#SprintEnddate").val() == "") {
            strmsg = '- Sprint End date should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        //Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993
        oldobjStartVal = dtStartDate.value;
        oldobjEndVal = dtEndDate.value;
        getInputDateFormat(dtStartDate, dtEndDate, 1, opDateFormat);
        //End of Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993
        if (dtvsdt.indexOf("undefined") != -1 || dtvedt.indexOf("undefined") != -1) {
            dtvsdt = oldobjStartVal;
            dtvedt = oldobjEndVal;
        }
        if (CompairDates(dtStartDate, dtEndDate) == 1) {
            //Commented and Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
            //strmsg = '- Sprint Start date should not be less than End date';
            strmsg = '- Sprint End date should be greater than Sprint start date';
            // End of Commented & Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;

        }

          //Commented and Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
        //if (checkvalue == 0) {
        if (checkvalue == 0 && dtsdt != undefined && dtedt != undefined && dtsdt != '' && dtedt != '') {
              // End of Commented & Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993
            // Commented & Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
             var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtsdt, EndDate: dtedt });
            // End of Commented & Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            var result = AJAXCallWithResult("frmReleasePlanning.aspx/ValidateProjectDates", data, false);
            //debugger;
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
            // Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993
            dtStartDate.value = oldobjStartVal;
            dtEndDate.value = oldobjEndVal;
            // End of added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993
        }
        if (RestrictNonNumeric(document.getElementById('txtCalendar')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
            errorMsg += "<li>" + strmsg + "</li></br>";
            //alertify.notify('', 'error');
            checkvalue = 1;

        }

        if (RestrictNonNumeric(document.getElementById('txtBusiness')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Business Day"s" !!!';
            errorMsg += "<li>" + strmsg + "</li></br>";
            //alertify.notify('', 'error');
            checkvalue = 1;

        }


        if ($("#txtEfforts").val() == "") {
            strmsg = '- Efforts should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
        else if (checkSpecialCharacter($('#txtEfforts').val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Efforts should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtEfforts").focus();
                return false;
            }
      
        //Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

        //if ($("#txtEfforts").val() != "") {
        //    if (RestrictNonNumeric(document.getElementById('txtEfforts')) == true) {
        //        // alertify.set('notifier', 'position', 'top-right');
        //        strmsg = ' - Please Enter only positive numeric value for Efforts !!!';
        //        errorMsg += "<li>" + strmsg + "</li></br>";
        //        //alertify.notify('', 'error');
        //        checkvalue = 1;

        //    }
        //    else if (checkSpecialCharacter($('#txtEfforts').val()) == true) {
        //        // alertify.set('notifier', 'position', 'top-right');
        //        strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
        //        errorMsg += "<li>" + strmsg + "</li></br>";
        //        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
        //        checkvalue = 1;

        //    }
        //}
        
        if ($("#txtEfforts").val() != "") {
            try {
                var blnHMFormat = true;
                var objHMEffort = document.getElementById("txtEfforts");
                var objVal = objHMEffort.value;
                var objnewVal = objHMEffort.value;

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                var isdigit = isNumeric(objHMEffort.value);
                objHMEffort.value = objVal;

                if (isdigit == false) {
                    strmsg = 'Please Enter only positive numeric value For Efforts in H:M format.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    blnHMFormat = false;
                    Flag = 1;
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
                if (checkSpecialCharacter(tempEffort) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = 'Efforts cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    blnHMFormat = false;
                    objHMEffort.value = objVal;
                    Flag = 1;
                    checkvalue = 1;
                }

                //if (blnResult == true) {
                //    checkvalue = 1;
                //}

                //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                if (blnHMFormat == true) {
                    if (RestrictNonNumeric(document.getElementById("txtEfforts")) == true) {

                        strmsg = 'Please enter Efforts in H:M format.';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        objHMEffort.value = objVal;
                        blnHMFormat = false;
                        Flag = 1;
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
                    //alert(mins)
                    if (blnHMFormat == true) {
                        if (mins.length > 2) {
                            strmsg = "Please enter minutes in two decimal and less than 60.";
                            errorMsg += "<li>" + strmsg + "</li></br>";
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
        //debugger;
        //ProjectID = document.getElementById('hdnProjectID').value;
       
        // Commented and Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        //if (dtStartDate != null && dtEndDate != null) {
        if (dtStartDate != null && dtEndDate != null && (dtStartDate.value != "" && dtEndDate.value != "")) {
            //End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            // Commented and Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Sprint" });
             var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtvsdt, EndDate: dtvedt, Flag: "Sprint" });
            //End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
            if (result1.d != '') {
                strmsg = result1.d;
                errorMsg += "<li>" + strmsg + "</li></br>";
                // alertify.set('notifier', 'position', 'top-right');
                // alertify.notify(result1.d, 'error', 15);
                checkvalue = 1;

            }
            // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            dtStartDate.value = oldobjStartVal;
            dtEndDate.value = oldobjEndVal;
            // End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        }


        if (checkvalue == 0) {
            var data = JSON.stringify({
                strIterationID: "",
                strEfforts: $('#txtEfforts').val()
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
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;




    }


    function validationRelease() {

        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        dtStartDate = document.getElementById("RstartDate");
        dtEndDate = document.getElementById("txtEndDate");
        var ProjectID = document.getElementById('hdnProjectID').value;

        if ($("#ReleaseName").val() == "") {
            strmsg = '- Release Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
        //Added By Riddhesh Patil on 11-NOV-2022 
        else if (checkSpecialCharacter($("#ReleaseName").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Release Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#ReleaseName").focus();
            checkvalue = 1;
        }

        else if ($("#txtDescription").val() != "") {
            if (checkSpecialCharacter($("#txtDescription").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescription").focus();
                checkvalue = 1;
            }
        }
        //End of Added By Riddhesh Patil


        var ReleaseID = $("#hdnReleaseIDnew").val();

        if (ReleaseID != undefined) {
            ReleaseID = ReleaseID;
        } else {
            ReleaseID = "0";
        }
        if (ReleaseID == "")
            ReleaseID = "0";

        if ($("#ReleaseName").val() != "") {
            //Commented by Rutuja D. on 18 feb 2022 for issueid = 32109
            //if (checkSpecialCharacter($('#ReleaseName').val()) == true) {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = '- Release Name cannot contain any of these /\\:*?<>|,"+- Characters';
            //    errorMsg += "<li>" + strmsg + "</li></br>";
            //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //    checkvalue = 1;

            //}
            //Commented by Rutuja D. on 18 feb 2022 for issueid = 32109

             //Added by Usha Pandit on 22.04.2019 for checking duplicate release name
            $.ajax({
                url: "frmReleaseMonitoring.aspx/CheckIterationName",
                data: JSON.stringify({ strIterationName: $("#ReleaseName").val(), strProjectID: ProjectID, flag: "Release", EntityID: ReleaseID }),
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
                            $("#ReleaseName").focus();
                        }
                        checkvalue = 1;
                    }
                }
            });
            //End of Added by Usha Pandit on 22.04.2019 for checking duplicate release name
        }

        if ($("#RstartDate").val() == "") {
            strmsg = '- Release Start Date should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#txtEndDate").val() == "") {
            strmsg = '- Release End date should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if (CompairDates(dtStartDate, dtEndDate) == 1) {
            strmsg = '- Release Start date should not be less than End date';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;

        }


        if (checkvalue == 0) {
            var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
            var result = AJAXCallWithResult("frmReleasePlanning.aspx/ValidateProjectDates", data, false);
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

        }

        if (RestrictNonNumeric(document.getElementById('txtRelCalendar')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
            errorMsg += "<li>" + strmsg + "</li></br>";
            //alertify.notify('', 'error');
            checkvalue = 1;

        }

        //if ($("#txtRelEfforts").val() == "") {
        //    strmsg = '- Efforts should not be left blank';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    Flag = 1;
        //    checkvalue = 1;
        //}

        if ($("#txtRBusinessDuration").val() != "") {
            if (RestrictNonNumeric(document.getElementById('txtRBusinessDuration')) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Please Enter only positive numeric value for Business Duration !!!';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //alertify.notify('', 'error');
                checkvalue = 1;

            }
            //else if (checkSpecialCharacter($('#txtRelEfforts').val()) == true) {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //    checkvalue = 1;

            //}
        }

        var objCurrentIterationStartDate = dtStartDate.value;
        var objCurrentIterationEndDate = dtEndDate.value;
        

         
        if (ReleaseID == "0") {
            if (dtStartDate != null && dtEndDate != null) {
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Release" });
                var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
                if (result1.d != '') {
                    strmsg = result1.d;
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify(result1.d, 'error', 15);
                    checkvalue = 1;

                }
            }
        }
        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;




    }
    //function setFrameLoader() {

    //    $("HTML").append("<div id='preloader'></div>");
    //    $("HTML").append("<div id='fillDiv'></div>");
    //}

    //function RemoveFrameLoader() {
    //    jQuery("#preloader").remove();
    //    jQuery("#fillDiv").remove();
    //    jQuery("#preloader").fadeOut("slow");
    //    jQuery("#fillDiv").fadeOut("slow");
    //    jQuery("#preloader").remove();
    //    jQuery("#fillDiv").remove();
    //}

    var newChartTab;
    //Added by Chetan M on 31st Jully 2020 for Issue ID 25477
    var GblUniqueID = 0;
    //End of Added by Chetan M on 31st Jully 2020 for Issue ID 25477
    function AfterRelaseSprintSave(Flag, UniqueID) {
        //debugger;
        //Added by Chetan M on 31st Jully 2020 for Issue ID 25477
        GblUniqueID = UniqueID;
        //End of Added by Chetan M on 31st Jully 2020 for Issue ID 25477
        var strResult = ajaxCall("frmReleasePlanning.aspx/Modal_popupdashboard", "POST", "application/json", "json", JSON.stringify({ UniqueID: UniqueID, Flag: Flag }));
        // setFrameLoader();
        //  globalReleaseID=UniqueID;
        var arrResult = strResult.d.split('||');
        // alert(arrResult);
        //  alert(UniqueID);
        //  alert(arrResult[0]);
        $("#DashBody").html("");
        //getRows();
        $("#addsprint").html("Update");
        $("#DashBody").html("");
       // debugger;
        //calculateHeight();
        // $("#add_Release").html("");
        $("#addRelease").html("Update");
        getRows();
        //Added By Dipali V On 28th March 2023 For Datable Issue
        if ($("#FilterNoTMapped").val() > 0) {
            datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '');
        }
        //debugger;
        //var Arrdata = arrResult[1].split('##');
        //alert(Arrdata[0]);
        //alert(Arrdata[1]);
        //alert(Arrdata[2]);
        //alert(Arrdata[3]);
        //alert(Arrdata[4]);
        //alert(Arrdata[5]);
        //alert(Arrdata[6]);

        //if (Flag == "Sprint")
        //{
        //  //  $('#Sprintname').val(Arrdata[1]);
        //    document.getElementById('Sprintname').value = Arrdata[0];
        //    document.getElementById('txtDescriptionSprint').value = Arrdata[1];
        //    document.getElementById('SprintStartdate').value = Arrdata[2];
        //    document.getElementById('SprintEnddate').value = Arrdata[3];
        //    document.getElementById('txtCalendar').value = Arrdata[4];
        //    document.getElementById('txtEfforts').value = Arrdata[5];
        //    document.getElementById('txtBusiness').value = Arrdata[6];
        //    //$('#txtDescriptionSprint').val(Arrdata[1]);
        //    //$('#SprintStartdate').val(Arrdata[2]);
        //    //$('#SprintEnddate').val(Arrdata[3]);
        //    //$('#txtCalendar').val(Arrdata[4]);
        //    //$('#txtEfforts').val(Arrdata[5]);
        //    //$('#txtBusiness').val(Arrdata[6]);

        //    // CustomerContact = Arrdata[9];
        //}
        //  RemoveFrameLoader();
        $("#SprintBody").html("");
        $("#DashBody").html(arrResult[0]);

        //Added by Usha Pandit on 19.04.2019 for getting sprint status
        var arrResultData = '';
        if (arrResult[1] != undefined && arrResult[1] != "") {
            arrResultData = arrResult[1].split('##');          
        }
        //End of Added by Usha Pandit on 19.04.2019 for getting sprint status

        //$("#txtDescriptionSprint").prop("readonly", false);

      //  AutoResizeTextArea();
       // RemoveTextArea();
       // getRows();
        //autosize(document.querySelectorAll('textarea'));

        $("#myModal_dash").modal('show');
        /*Added by kashish For Texarea Enhancement*/


        $("#dashheader").css('display', 'none');
        //      $("#txtDiscussion").Editor();
        $('#sprint_details').css("height", ((window.innerHeight / 2) + 50 + 'px'));

        //if (Flag != "Sprint") {
        //    $('#div_details').css("height", ((window.innerHeight / 2) - 35 + 'px'));
        //}
        //else {

        // alert((window.innerHeight / 2)+ 200)
        //}

        /*Commented and Added by Usha Pandit on 11.04.2019 for disabling date before current date for End Date Control*/
        //$('#RstartDate,#txtEndDate,#SprintStartdate,#SprintEnddate').datepicker(
        //    {
        //        changeMonth: true,
        //        changeYear: true,
        //        yearRange: '2000:2020'
        //    }
        //);
        
        $('#RstartDate,#txtEndDate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                  yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            }
        );

         //Added By Dipali V On 25th Jun 2020 For Get B.Days & C.Days
        $("#RstartDate,#txtEndDate").change(function () {
            GetDuration("Release");
        });
        //End of Added By Dipali V On 25th Jun 2020 For Get B.Days & C.Days
        //Added by Usha Pandit on 19.04.2019 for getting sprint status
        var curSprintStatus = 0; 
        if (arrResultData != undefined) {
            if (arrResultData[7] != undefined) {
                curSprintStatus = arrResultData[7];
            }
        }
       //End of Added by Usha Pandit on 19.04.2019 for getting sprint status
         var dtformatval = dtFormat(opDateFormat); 
        if (curSprintStatus == 0) { //Added by Usha Pandit on 19.04.2019 for getting sprint status
            $('#SprintStartdate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    , dateFormat: dtformatval
                }
            );

            $('#SprintEnddate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    , dateFormat: dtformatval
                    , minDate: dateToday
                }
            );
        }
        // End of Added by Usha Pandit on 11.04.2019 for disabling date before current date for End Date Control*/

        // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
       
       
       
        if (curSprintStatus == 0) { //Added by Usha Pandit on 19.04.2019 for getting sprint status           
          
             //Added by Usha Pandit on 19.04.2019 for date format issue          
           
             var objStartNew = document.getElementById("SprintStartdate");
            var objEndNew = document.getElementById("SprintEnddate");
           
            //ADDED BY DIPALI VEKHANDE ON 26TH APRIL 2019 FOR JAVASCRIPT
            if (objStartNew != null) {
                var old1objStartVal = objStartNew.value;
                var old1objEndVal = objEndNew.value;  
                getInputDateFormat(objStartNew, objEndNew, 1, opDateFormat);  
               //Commented and Added by Usha Pandit on 02.05.2019 for wrong date format
                //objStartNew.value = dtvsdt;
                //objEndNew.value = dtvedt;
                
                if (dtvsdt.indexOf('undefined') != -1 && dtvedt.indexOf('undefined') != -1) {                  
                    objStartNew.value = old1objStartVal;
                    objEndNew.value = old1objEndVal;
                }
                else {
                    objStartNew.value = dtvsdt;
                    objEndNew.value = dtvedt;
                }
                //End of Added by Usha Pandit on 02.05.2019 for wrong date format
                
            }
            //END OF ADDED BY DIPALI VEKHANDE ON 26TH APRIL 2019 FOR JAVASCRIPT            

            var dtformatval = dtFormat(opDateFormat);
             // End of Added by Usha Pandit on 11.04.2019 for date format issue 
             $('#SprintStartdate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    , dateFormat: dtformatval
                } );

                $('#SprintEnddate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        //yearRange: '2000:2020'
                        yearRange: 'c-100:c+100'
                        //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        , dateFormat: dtformatval
                        , minDate: dateToday
                    });
             
              //End of Added by Usha Pandit on 19.04.2019 for getting sprint status           
        }
         
        //End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

        $('#tab_link li').on('click', function () {
            $('#tab_link li a').css("text-decoration", "none");
            $('#tab_link li a').css("color", "");
            $("a", this).css("text-decoration", "underline");
            $("a", this).css("color", "#60ffa7");
            // $("#dashcontent").css("top", "-10px");
            //  $("a", this).css("color", "#60ffa7");
            // debugger;
            //$("a", this).attr("href").addClass("SelectedDIV")




        });
        $(".clsBox").hover(function () {
            $('#tab_link li a').css("text-decoration", "none");
            $('#tab_link li a').css("color", "");
            $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
            $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
            //$("[href=#" + $(this).attr("id") + "]").addClass("Selected")
            // alert( $(this).attr("id"));
        });

        if (Flag != undefined) {
            setTimeout(function () {
                $("[href=#" + Flag + "]").click();
                var offsetval = $("#" + Flag + "").offset();
                if (offsetval != undefined) {
                    var scrollPos = $("#" + Flag + "").offset().top;


                    if (Flag != "Sprint") {
			//Commented And Added By Usha Pandit On 02.09.2020 For discussion alignment issue
                        //$("#div_details").scrollTop(scrollPos - 250);
			$("#sprint_details").scrollTop(scrollPos - 250);
			//End Of Added By Usha Pandit On 02.09.2020 For discussion alignment issue
                        // $('#div_details').css("height", ((window.innerHeight / 2) - 35 + 'px'));
                    }
                    else {
                        $("#sprint_details").scrollTop(scrollPos - 200);
                    }

                }
            }, 500)
        }


        var $li = $('#tab_link a').on('click', function () {
            //$li.removeClass('selected');
            //$(this).addClass('selected');
            var divId = $(this).attr("href").toString();

            divId = divId.replace("#", "");
            $("div").removeClass("activecls");
            //  alert(divId);
            $("#" + divId).addClass("activecls");
        });

        newChartTab = $('#myScrollspy ul li').on('click', function () {
            newChartTab.removeClass('active');
            $(this).addClass('active');

        });

        $(".tabcontentChart").hover(function () {


            //$('#myScrollspy ul li a').css("cssText", "background-color:white;color:black!important;");

            //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7;color:white!important;");         

            $('#myScrollspy ul li').removeClass('active');
            $("[href=#" + $(this).attr("id") + "]").parent().addClass('active');


            $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
            $('#myScrollspy ul li a').css("cssText", "color:black!important;");


            $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
            $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");


        });

        $('#myScrollspy .nav-pills > li > a').on('click', function () {
            var $this = $(this);
            $('#myScrollspy .nav-pills > li').removeClass('active');
            $('#myScrollspy .nav-pills > li > a').removeClass('active');
            $this.addClass('active');
        }); //Added by pradip on 12-4-2023
        
        //debugger;
        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });
        //if (document.getElementById("leftTree").style != null)
        //{
        //    document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 200) + 'px';

        //}

        var $li = $('#tab_link a').on('click', function () {
            $li.removeClass('selected');
            $(this).addClass('selected');
            //if ($('#tab_link a').hasClass('selected')) {
            //    $(this).removeClass('selected');

            //}
            //else {
            //    $(this).addClass('selected');

            //}

        });
        $('[data-bs-toggle="tooltip"]').tooltip();
        //   $('.radio-inline').tooltip()
        $("#editReleaseName").tooltip();
        $("#ReleaseSprintPer").tooltip();
        $("#ReleaseSprintNext").tooltip();
        $("#tab_content").tooltip();
        $(".ClsCaptiontooltip").tooltip();
        $(".card-text ").tooltip();

        // document.getElementById("defaultOpen").click();
        // debugger
        GetLineBurnUP(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnDown");
        GetLineBurnDown(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnUp");

        GetLineBurnUPEffortS(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnDown");
        GetLineBurnDownStoryPoints(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnUp");


        GetLineVelocityEffortBar(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnDown");
        GetLineVelocityStoryBar(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnUp");

        GetFlowEfforts(UniqueID, Flag, 'divGraph' + UniqueID, "", "BurnDown");
        GetCompleteCancelSprintSprint(UniqueID, 'Cancel')
        GetCompleteCancelSprintSprint(UniqueID, 'Complete')
        //GetFlowStoryPoints(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");

        //Added By Dipali V On 28th March 2023 For Datable Issue
        if ($("#FilterCurrentSprintUS").val() > 0) {
            datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '')
        }
        if ($("#FilterIssuesList").val() > 0) {
            datatables('DivSubTabIssuesList', 'txtSearchIssues', '')
        }

        if ($("#FilterImpedimentsLogsList").val() > 0) {
            datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '')
        }

        if ($("#FilterNoTMapped").val() > 0) {
            datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '')
        }

        if ($("#FilterReviewList").val() > 0) {
            datatables('DivReviewList', 'txtSearchReviews', '')
        }

        if ($("#FilterTaskList").val() > 0) {
            datatables('DivTaskList', 'txtSearchTask', '')
        }

        if ($("#FilterHistorykList").val() > 0) {
            datatables('DivHistorykList', 'txtSearchhistory', '')
        }

        if ($("#FilterAttachmentList").val() > 0) {
            datatables('DivAttachmentList', 'txtDivAttachmentList', '')
        }
        //End of Added By Dipali V On 28th March 2023 For Datable Issue
        $('input[name=SelectUnmappedSprintList]').on('change', function () {
            $('input.clscheckbox').not(this).prop('checked', false);
        });

        HighLightChart();
    }

    function HighLightChart() {

        $('#myScrollspy ul li').on('click', function () {

            $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
            $('#myScrollspy ul li a').css("cssText", "color:black!important;");


            $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
            $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");

        });

        $('#myScrollspy ul li a').on('click', function () {

            $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
            $('#myScrollspy ul li a').css("cssText", "color:black!important;");


            $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
            $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");

        });
    }
    function GetCompleteCancelSprintSprint(ReleaseID, GraphFlag) {
        var strResult = ajaxCall("frmReleasePlanning.aspx/GetCompleteCancelGraphDetails", "POST", "application/json", "json",
            JSON.stringify({ ReleaseID: ReleaseID, GraphFlag: GraphFlag }));//188
        if (strResult.d != "") {

            if (GraphFlag != "Complete") {

                $("#CanSprintGrid" + ReleaseID).html("");
                $("#CanSprintGrid" + ReleaseID).html(strResult.d);
                if ($("#FilterCancel").val() > 0) {
                    datatables('DivCancelSprint', '', '')
                }


            }
            else {
                $("#ComSprintGrid" + ReleaseID).html("");
                $("#ComSprintGrid" + ReleaseID).html(strResult.d);
                if ($("#FilterComplete").val() > 0) {
                    datatables('DivCompleteSprint', '', '')
                }


            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            // $('.radio-inline').tooltip()
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

    //$("#tab_Discussions").onclickclick(function(){

    //    alert();
    //    $("#SprintRelease").html('');
    //    $("#SprintRelease").html('Post');
    //});

    var DiscussionID = 0;
    var strnewDiscussionID = "";
    function insertSprintReleaseDiscussion(UniqueID, Flag, obj, txtID) {
        
       
        //Added by Usha Pandit on 08.05.2019 for wrong discussion count display
        var curReleaseID = '';
        if (Flag == 'Iteration') {
          curReleaseID = $("#hdnReleaseIDnewup").val();
        }
         //End of Added by Usha Pandit on 08.05.2019 for wrong discussion count display
     
        // alert(strUserResult.d);
        //Commented & Added By Dipali V On 13th April 2023 For Blank Space Saving
        //if ($("#" + txtID).val() != "") {
        if ($("#" + txtID).val().trim() != "") {
       //End of Commented & Added By Dipali V On 13th April 2023 For Blank Space Saving
            if (checkSpecialCharacter($("#" + txtID).val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Discussion should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#" + txtID).focus();
                return false;
            }
            else {
             //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
             //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
            //if ($("#" + txtID).val().length >= 2000) {
            //    $("#" + txtID).focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please Enter Discussion less than 2000 characters, you have entered ' + $("#" + txtID).val().length + ' characters.', 'error', 5);
            //    return;
            //}
            //else {
             //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
                 //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478

                //Commented and Added by Usha Pandit on 08.05.2019 for wrong discussion count display
                //var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
                var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag, curReleaseId: curReleaseID }));
                //End of Added by Usha Pandit on 08.05.2019 for wrong discussion count display

                if (Flag != "UserStory") {

                    // var strDiscussionID =  $("#hdnstrDiscussionID").val();

                    // strnewDiscussionID =strDiscussionID - 1;
                    //  alert(strnewDiscussionID);
                    document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult.d;
                    /*Added by kashish For Texarea Enhancement*/
                    //AutoResizeTextArea();
                    //autosize(document.querySelectorAll('textarea'));
                    $("#spanpost").html('');
                    $("#spanpost").html('Post');
                    // $("#SprintRelease").css("display","block");
                    $("#txtDiscussion").val('');
                    // debugger;
                    $("#collapse_" + strnewDiscussionID).addClass('in');
                    $("#collapse_" + strnewDiscussionID).focus();
                    $("#SprintReleaseAddDiscussion").attr('disabled', true);
                }
                else {
                    document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                    $("#btnSend").html('');
                    $("#btnSend").html('Post');
                    $("#DiscussionTextArea").val('');
                    $("#collapse_" + strnewDiscussionID).addClass('in');
                    $("#SprintReleaseAddDiscussion").attr('disabled', true);
                }

                //  $("#FreeTextBox_editor").html('');
                DiscussionID = 0;
                $('[data-bs-toggle="tooltip"]').tooltip();
                 //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
                 //Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
            //}
                //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
             //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478
        }
    }
        else {
            $("#" + txtID).focus();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please Enter Discussion', 'error', 25);
            return;
        }

    }
    //function AddNewDiscussion(obj,textid)
    //{
    //    // debugger;
    //    $("#"+ textid).val("");

    //}


    function AddNewDiscussion(UniqueID, Flag, obj, txtID) {

        var DiscussionID = 0; strnewDiscussionID = 0;

        //Added by Usha Pandit on 08.05.2019 for wrong discussion count display
        var curReleaseID = '';
        if (Flag == 'Iteration') {
          curReleaseID = $("#hdnReleaseIDnewup").val();
        }
        //End of Added by Usha Pandit on 08.05.2019 for wrong discussion count display

         //Commented and Added by Usha Pandit on 08.05.2019 for wrong discussion count display
        //var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
        var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag, curReleaseId : curReleaseID }));
        //End of Added by Usha Pandit on 08.05.2019 for wrong discussion count display

        //Commented & Added By Dipali V On 13th April 2023 For Blank Space Saving
        //if ($("#" + txtID).val() != "") {
        if ($("#" + txtID).val().trim() != "") {
        //End of Commented & Added By Dipali V On 13th April 2023 For Blank Space Saving

            if (Flag != "UserStory") {

                // var strDiscussionID =  $("#hdnstrDiscussionID").val();

                // strnewDiscussionID =strDiscussionID - 1;
                //  alert(strnewDiscussionID);
                document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult.d;
                /*Added by kashish For Texarea Enhancement*/
                //AutoResizeTextArea();
                //autosize(document.querySelectorAll('textarea'));
                $("#spanpost").html('');
                $("#spanpost").html('Post');
                // $("#SprintRelease").css("display","block");
                $("#txtDiscussion").val('');
                  $("#txtDiscussion").prop("placeholder", "Post New Discussion");
                // debugger;
                $("#collapse_" + strnewDiscussionID).addClass('in');
                $("#collapse_" + strnewDiscussionID).focus();
                $("#SprintReleaseAddDiscussion").attr('disabled', true);
            }
            else {
                document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                $("#btnSend").html('');
                $("#btnSend").html('Post');
                $("#DiscussionTextArea").val('');
                $("#collapse_" + strnewDiscussionID).addClass('in');
                $("#SprintReleaseAddDiscussion").attr('disabled', true);
            }

            //  $("#FreeTextBox_editor").html('');
            DiscussionID = 0;
            $('[data-bs-toggle="tooltip"]').tooltip();


        }
        else {
            $("#" + txtID).focus();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please Enter Discussion', 'error', 25);
        }
    }

    function reply_onclick(userstoryID, discussionID, Flag) {
        strnewDiscussionID = discussionID;
        if (Flag != "UserStory") {
            $("#txtDiscussions").focus();
              //dipali
             //$("#txtDiscussions").prop("placeholder", "Reply New Discussion");
              $("#txtDiscussions").prop("placeholder", "Reply to Discussion");
        }
        else {
            $("#DiscussionTextArea").focus();
              //dipali
              //$("#DiscussionTextArea").prop("placeholder", "Reply New Discussion");
              $("#DiscussionTextArea").prop("placeholder", "Reply to Discussion");
        }

        // $("#FreeTextBox_editor").focus();
        if (Flag != "UserStory") {
            $("#spanpost").html('Reply');
              //dipali
              //$("#txtDiscussions").prop("placeholder", "Reply New Discussion");
               $("#txtDiscussions").prop("placeholder", "Reply to Discussion");
        }
        else {
            $("#btnSend").html('Reply');
            //dipali
              //$("#DiscussionTextArea").prop("placeholder", "Reply New Discussion");
             $("#DiscussionTextArea").prop("placeholder", "Reply to Discussion");
        }
        DiscussionID = discussionID;
        $('[data-bs-toggle="tooltip"]').tooltip();
        $("#SprintReleaseAddDiscussion").removeAttr('disabled', false);
        /*Added by kashish For Texarea Enhancement*/
        //AutoResizeTextArea();
        //autosize(document.querySelectorAll('textarea'));
    }

    function ShowMoreLess(discussionID, obj) {
        //  debugger;

        if (document.getElementById(discussionID).style.display == "none") {
            document.getElementById(discussionID).style.display = "block";
            obj.innerHTML = "Less"
        }
        else {
            document.getElementById(discussionID).style.display = "none";
            obj.innerHTML = "More"
        }
    }


    var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
    var isValidTypeExeCheckFlag = false;
    async function UploadData(userStoryID, Flag) {
        //debugger;

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
            formdata.append('Flag', Flag);
            formdata.append('UserStoryID', userStoryID);
            $.ajax({
                type: 'post',
                url: 'frmReleasePlanning.aspx',
                data: formdata,
                success: function (status) {
                    //  debugger;
                    if (status == "Invalid") {
                        // alert("Invalid content type!");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Invalid content type!", 'error', 25);
                    }
                    else {
                        document.getElementById("divAttachmentList").innerHTML = status;
                        if ($("#FilterAttachmentList").val() > 0) {
                            datatables('DivAttachmentList', 'txtDivAttachmentList', '')
                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        //makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                        //    var output = document.querySelector('.demo-droppable');
                        //    output.innerHTML = '';
                        //    for (var i = 0; i < files.length; i++) {
                        //        arrFile[0] = files[i];
                        //        output.innerHTML += '<p>' + files[i].name + '</p>';
                        //    }
                        //});
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        // $('.radio-inline').tooltip()
                    }
                    arrFile = [];

                    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                        var output = document.querySelector('.demo-droppable');
                        output.innerHTML = '';
                        for (var i = 0; i < files.length; i++) {
                            arrFile[0] = files[i];
                            output.innerHTML += '<p>' + files[i].name + '</p>';
                        }
                    });
                },
                processData: false,
                contentType: false,
                error: function () {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Invalid content type!", 'error', 25);
                    // alert("oops something went wrong!");
                }
            });
        }

        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Please Upload file!", 'error', 25);

        }
    }

    function Delete_Attachment(AttachmentID, UserStoryID, Flag) {
        //debugger;
        var strUserResult = ajaxCall("frmReleasePlanning.aspx/DeleteAttachment", "POST", "application/json", "json", JSON.stringify({ strAttachmentID: AttachmentID, strUserStoryID: UserStoryID, strEntity: Flag }));
        strUserResult = strUserResult.d.split("||")
        //  alert(strUserResult.d)
        // alert(strUserResult[1]);
        if (Flag != "UserStory") {

            // document.getElementById("divDiscussionListSprintRelease").innerHTML = "";
            //document.getElementById("Sprintattachmentdata").innerHTML = "";
            //document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult[1];
          //Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
                if (strUserResult[1] == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strUserResult[0], 'error', 15);
                    return;
                }
                else {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strUserResult[0], 'success', 15);
                    //debugger
                    //Added By Dipali V On 26th April 2019 for Refresh Issue
                    document.getElementById("divAttachmentList").innerHTML = "";
                    // document.getElementById("attachmentdata").innerHTML = "";
                    document.getElementById("divAttachmentList").innerHTML = strUserResult[2];
                    // document.getElementById("attachmentdata").innerHTML = strUserResult[1];
                    if ($("#FilterAttachmentList").val() > 0) {
                        datatables('DivAttachmentList', 'txtDivAttachmentList', '')
                    }
                    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                    var output = document.querySelector('.demo-droppable');
                        output.innerHTML = '';
                        for (var i = 0; i < files.length; i++) {
                            arrFile[0] = files[i];
                            output.innerHTML += '<p>' + files[i].name + '</p>';
                        }
                     });
                     //End of Added By Dipali V On 26th April 2019 for Refresh Issue
                    return;
                }
        //End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
         


            // document.getElementById("Sprintattachmentdata").innerHTML = strUserResult[1];
        }
        else {
            if (strUserResult[0] != "") {
                 //Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
                if (strUserResult[1] == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strUserResult[0], 'error', 15);
                    return;
                }
                else {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strUserResult[0], 'success', 15);
                     //Added By Dipali V On 26th April 2019 for Refresh Issue
                     document.getElementById("divAttachmentList").innerHTML = "";
                    // document.getElementById("attachmentdata").innerHTML = "";
                    document.getElementById("divAttachmentList").innerHTML = strUserResult[2];
                    //Added By Dipali V On 28th March 2023 For Datable Issue
                    if ($("#FilterAttachmentList").val() > 0) {
                        datatables('DivAttachmentList', 'txtDivAttachmentList', '')
                    }
                    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                    var output = document.querySelector('.demo-droppable');
                    output.innerHTML = '';
                    for (var i = 0; i < files.length; i++) {
                        arrFile[0] = files[i];
                        output.innerHTML += '<p>' + files[i].name + '</p>';
                    }
                });
                    // document.getElementById("attachmentdata").innerHTML = strUserResult[1];
                     //End of Added By Dipali V On 26th April 2019 for Refresh Issue
                    return;
                }
        //End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

            }
           

        }
      

    }






    function ShowSprintData(type) {
        if (type == 'List') {
            $("#divSprintList").css("display", "")
            $("#divSprintForm").css("display", "none")
            $("#divRemarks").css("display", "none");
        }
        else if (type == "Form") {
            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterNoTMapped").val() > 0) {
                datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '')
            }
            //End of Added By Dipali V On 28th March 2023 For Datable Issue
            $("#divSprintList").css("display", "none")
            $("#divSprintForm").css("display", "")
            $("#divRemarks").css("display", "none");
        }
    }


    var strFlag = "";
    function Save_SubTab_Data(UserStoryID, SubTabFlag) {
        var objComplexity = document.getElementById("cboComplexity");
        var objPriority = document.getElementById("cboPriority");
        if (SubTabFlag == "SubStory") {
            var checkFlag = 0;
            var objSubStoryName, objSubStoryDesc;
            var selectedText = ""
            objSubStoryName = $('#txtSubStoryName');
            objSubStoryDesc = $('#txtSubStoryDesc');

            //if (disallowBlank(document.getElementById("txtSubStoryName"), '', true)) {
            //    $("#txtSubStoryName").css({ 'border-color': 'red', 'border-width': '1px' });
            //    $("#spanSubStoryName").html("Sub UserStory name should not left blank.");
            //    $("#txtIterationName").focus();

            //    checkFlag = 1;
            //}
            //if (document.getElementById("txtSubStoryDesc").value == "") {
            //    $("#txtSubStoryDesc").css({ 'border-color': 'red', 'border-width': '1px' });
            //    $("#spanSubStoryDesc").html("Sub User Story Description should not left blank.");
            //    $("#txtSubStoryDesc").focus();

            //    checkFlag = 1;
            //}
            //if (document.getElementById("txtSubStoryDesc").value.length > 2000) {
            //    $("#txtSubStoryDesc").css({ 'border-color': 'red', 'border-width': '1px' });
            //    $("#spanSubStoryDesc").html("Sub User Story Description should not greater than 2000 characters. You have entered " + document.getElementById("txtSubStoryDesc").value.length + " characters.");
            //    $("#txtSubStoryDesc").focus();

            //    checkFlag = 1;
            //}
            //if (document.getElementById("SubcboPriority").value == "") {
            //    $("#SubcboPriority").css({ 'border-color': 'red', 'border-width': '1px' });
            //    $("#spanSubPriority").html("Priority should not left blank.");
            //    $("#SubcboPriority").focus();

            //    checkFlag = 1;
            //}
            //else {
            //    selectedText = document.getElementById("SubcboPriority").options[document.getElementById("SubcboPriority").selectedIndex].text;
            //    //alert(selectedText);
            //}
            //if (checkFlag == 1) {
            //    return;
            //}

            var checkFlag = 0;
            var Flag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"


            if ($("#txtSubStoryName").val() == "") {
                strmsg = '- Sub User Story Description should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
            }

            if ($("#txtSubStoryDesc").val() == "") {
                strmsg = '- Sub User Story Description should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#txtSubStoryDesc").focus();
            }

            if (document.getElementById("txtSubStoryDesc").value.length > 2000) {
                strmsg = '- Sub User Story Description should not greater than 2000 characters.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
                $("#txtSubStoryDesc").focus();
                // $("#spanSubStoryDesc").html("Sub User Story Description should not greater than 2000 characters. You have entered " + document.getElementById("txtSubStoryDesc").value.length + " characters.");



            }

            if ($("#SubcboPriority").val() == "") {
                strmsg = '- Priority should not left blank.';
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
                    alertify.notify(errorMsg, 'error', 15);

                }
                return;
            }



            var objComplexityTemp;
            var PriorityTemp;
            objComplexityTemp = objComplexity.value;
            PriorityTemp = objPriority.value;

            var url1 = "frmReleasePlanning.aspx/GetExistingUniqueNumberFromDB";
            var data1 = JSON.stringify({ objComplexity: objComplexity.value, Priority: objPriority.value, strUserStoryId: UserStoryID });
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


            //debugger;
            var data = JSON.stringify({ UserStoryID: UserStoryID, SubStoryName: objSubStoryName.val(), SubStoryDesc: objSubStoryDesc.val(), strPriority: selectedText, strRank: UniqueNo });
            var result = ajaxCall("frmReleasePlanning.aspx/SaveSubStories", "POST", "application/json", "json", data);
            document.getElementById("divSubstoryList").innerHTML = result.d;
            $('#txtSubStoryName').val('')
            $('#txtSubStoryDesc').val('')
            $('#SubcboPriority').val('')
            //debugger;
            ShowData('List', 'SubUS');
            // ShowData
            var strUserResult = ajaxCall("frmReleasePlanning.aspx/FilterDataUS", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
            document.getElementById("divUserStories").innerHTML = strUserResult.d;
            document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Sub User Story Created successfully', 'success', 25);
        }
        else if (SubTabFlag == "MappedSprint") {
            // debugger;
            //var SelectUnmappedSprintList="";
            //SelectUnmappedSprintList = $('input[name=SelectUnmappedSprintList]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');

            //if (SelectUnmappedSprintList.length <= 0) {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Select at least one Sprint', 'error');
            //    return;
            //}

            var SelectUnmappedSprintList = "";

            SelectUnmappedSprintList = $('input[name=SelectUnmappedSprintList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (SelectUnmappedSprintList.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            }


            // alert(SelectUnmappedSprintList);
            //var data = JSON.stringify({ SelectedSprint: SelectUnmappedSprintList, ReleaseID: UserStoryID });
            //var result = ajaxCall("frmReleasePlanning.aspx/SaveUnmappedSprinttoRelease", "POST", "application/json", "json", data);
            //var Resultsplit = result.d.split("||");
            //document.getElementById("divSprintList").innerHTML = Resultsplit[1];

            //// alert(Resultsplit[0]);
            //// alert(Resultsplit[1]);
            //if (Resultsplit[0]!= 0){
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Sprint added successfully', 'success', 25);
            //}
            //ShowSprintData('List');
            //document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'
            var ProjectID = document.getElementById('hdnProjectID').value;
            // debugger;
            var data;

            if (UserStoryID != "") {
                $.ajax({
                    url: "frmReleasePlanning.aspx/CheckReleaseDates",
                    data: JSON.stringify({ strIterationID: SelectUnmappedSprintList, strReleaseID: UserStoryID, strProjectID: ProjectID }),
                    type: "POST",
                    contentType: "application/json;charset-utf=8",
                    dataType: "json",
                    success: function (result) {
                        var strTextReleaseStartDate;
                        var strTextReleaseEndDate;
                        var strTextisValid;
                        var strText;
                        var arrStr;
                        //  alert(result.d);
                        strText = String(result.d);
                        arrStr = strText.split(",");
                        strTextisValid = arrStr[0];
                        strTextReleaseStartDate = arrStr[1];
                        strTextReleaseEndDate = arrStr[2];
                        //     alert(arrStr[4]);



                        if (arrStr[5] == "Sprint Cancelled") {
                            //ShowPopup("Selected sprint is cancelled, you can not map cancelled sprint to release.");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Selected sprint is cancelled, you can not map cancelled sprint to release.', 'error');
                            //  $(ui.sender).sortable("cancel");
                            return;
                        }

                        if (arrStr[6] == "1") {
                            // ShowPopup("Release is already started, you can not map sprint to release.");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Release is already started, you can not map sprint to release.', 'error');
                            // $(ui.sender).sortable("cancel");
                            return;
                        }

                        else if (strTextisValid == 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Start Date and End Date should be between Release Dates i.e.' + strTextReleaseStartDate + " and " + strTextReleaseEndDate, 'error');
                            // ShowPopup("Start Date and End Date should be between Release Dates i.e. " + strTextReleaseStartDate + " and " + strTextReleaseEndDate);
                            //  $(ui.sender).sortable("cancel");
                            return;
                        }

                        var data = JSON.stringify({ SelectedSprint: SelectUnmappedSprintList, ReleaseID: UserStoryID });
                        var result = ajaxCall("frmReleaseMonitoring.aspx/SaveUnmappedSprinttoRelease", "POST", "application/json", "json", data);
                        var Resultsplit = result.d.split("||");


                        // alert(Resultsplit[0]);
                        // alert(Resultsplit[1]);
                        if (Resultsplit[0] != 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Sprint added successfully', 'success', 25);
                            document.getElementById("divSprintList").innerHTML = Resultsplit[1];
                        }
                        ShowSprintData('List');
                    }
                });
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Before map sprint ,you should  first create release', 'error');
                // $(ui.sender).sortable("cancel");
                return;
            }


        }

        else if (SubTabFlag == "Issue") {
            if (validateissue() == 0) {

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
                    ShowData('List', 'subIssue');
                    //Added By Dipali V On 28th March 2023 For Datable Issue
                    if ($("#FilterIssuesList").val() > 0) {
                        datatables('DivSubTabIssuesList', 'txtSearchIssue', '')
                    }
                    // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
                    // document.getElementById("divUserStories").innerHTML = strUserResult.d;
                    //added By Dipali V On 30th Mach 2018 For Sub Us Creation
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Issue Created successfully', 'success', 25);
                    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }
            }

        }
        else if (SubTabFlag == "Task") {

            if (validateTask() == 0) {

                // debugger;
                saveFlag = 1;
                var htRowCount = document.getElementsByName("hdrownumber");
                for (var i = 0; i < htRowCount.length; i++) {
                    if (htRowCount[i] != null) {

                        var objTaskName = $('#txtTaskName' + htRowCount[i].value);
                        var objResource = $('#cboresource' + htRowCount[i].value);
                        var objWorkHrs = $('#txtWorkHrs' + htRowCount[i].value);
                        var objStartDate = $('#txtStartDate' + htRowCount[i].value);
                        var objEndDate = $('#txtEndDate' + htRowCount[i].value);
                        var objPriorities = "";
                        var objTaskType = "";
                        var StoryPoints = ""
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



                    URL = 'frmReleasePlanning.aspx/SaveTask';

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



            }




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
                var RevieweeWork = "";

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
                    ShowData('List', 'subReview');
                    //Added By Dipali V On 28th March 2023 For Datable Issue
                    if ($("#FilterReviewList").val() > 0) {
                        datatables('DivReviewList', 'txtSearchReviews', '');
                    }
                    /*Commented By yasmin on 5-3-19*/
                    //$('#txtReviewStartDate').datepicker();
                    //$('#txtReviewEnddate').datepicker();
                    $('#txtReviewStartDate,#txtReviewEnddate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        }
                    );
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Review Created successfully', 'success', 25);
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





    }




    function validateReview() {

        var checkFlag = 0;
        var Flag = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        var dtStartDate, dtEndDate;
        dtStartDate = document.getElementById("txtReviewStartDate");
        dtEndDate = document.getElementById("txtReviewEnddate");

        if ($("#txtReviewtitle").val() == "") {
            strmsg = '- Review title should not left blank.';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtReviewtitle").focus();
        }

        if ($("#cboReviewtype").val() == "") {
            strmsg = '- Review type should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboReviewtype").focus();
        }

        if ($("#txtReviewStartDate").val() == "") {
            strmsg = '- Review Start Date should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtReviewStartDate").focus();
        }

        if ($("#txtReviewEnddate").val() == "") {
            strmsg = '- Review End date should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtReviewEnddate").focus();
        }

        if (CompairDates(dtStartDate, dtEndDate) == 1) {
            strmsg = '- Review Start date should not be less than Review End date';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtReviewEnddate").focus();

        }

        if ($("#cboReviewer").val() == "") {
            strmsg = '- Reviewer should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboReviewer").focus();
        }

        if ($("#cboRevieStatus").val() == "") {
            strmsg = '- Status should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboRevieStatus").focus();
        }


        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkFlag;


    }


    function validateissue() {

        var checkFlag = 0;
        var Flag = 0;
        var strmsg = "";
        var errorMsg = "<ul>"


        if ($("#txtSummary").val() == "") {
            strmsg = '- Summary should not left blank.';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtSummary").focus();
        }

        if ($("#txtDescription").val() == "") {
            strmsg = '- Description should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtDescription").focus();
        }

        if ($("#cboIssueType").val() == "" || $("#cboIssueType").val() == null) {
            strmsg = '- Issue Type should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboIssueType").focus();
        }

        if ($("#cboSubIssueType").val() == "" || $("#cboSubIssueType").val() == null) {
            strmsg = '- Sub Issue Type should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboSubIssueType").focus();
        }

        if ($("#cboreporter").val() == "" || $("#cboreporter").val() == null) {
            strmsg = '- Reporter By should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboreporter").focus();
        }

        if ($("#cboResonsible").val() == "") {
            strmsg = '- Resonsible Person should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboResonsible").focus();
        }

        if ($("#cboStatus").val() == "") {
            strmsg = '- Status should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#cboStatus").focus();
        }


        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkFlag;


    }

    var isValid = 0;
    function validateTask() {
        // debugger;
        var checkFlag = 0;

        var strmsg = "";
        var errorMsg = "<ul>"
        var startdate = "", EndDate = "";
        var htRowCount = document.getElementsByName("hdrownumber");
        for (var i = 0; i < htRowCount.length; i++) {
            if (htRowCount[i] != null) {
                //if ($("#txtReviewtitle" + htRowCount[i].value).val() == 0) {
                //    Flag = 1;
                //    checkFlag = 1;
                //    $("#txtReviewtitle" + htRowCount[i].value).css("border", "1px solid red");
                //}
                startdate = document.getElementsByName("txtStartDate" + htRowCount[i].value);
                EndDate = document.getElementsByName("txtEndDate" + htRowCount[i].value);

                if ($("#txtTaskName" + htRowCount[i].value).val() == "") {
                    strmsg = '- Task Name should not left blank.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtTaskName" + htRowCount[i].value).focus();
                }

                //if ($("#txtDescriptiontask" + htRowCount[i].value).val() == "") {
                //    strmsg = '- Description should not left blank';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    Flag = 1;
                //    checkFlag = 1;
                //    $("#txtDescriptiontask").focus();
                //}

                if ($("#txtStartDate" + htRowCount[i].value).val() == "") {
                    strmsg = '- Start Date should not left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    // $("#txtStartDate" + htRowCount[i].value).focus();
                }

                if ($("#txtEndDate" + htRowCount[i].value).val() == "") {
                    strmsg = '- End Date should not left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    //$("#txtEndDate" + htRowCount[i].value).focus();
                }

                //if (CompairDates(startdate, EndDate) == 1) {
                //    strmsg = '- Task Start date should not be less than Task End date';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    $("#txtEndDate" + htRowCount[i].value).focus();

                //}

                if (CompairDates(startdate, EndDate) == 1) {
                    strmsg = '- Task Start date should not be less than Task End date';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;

                }



                if ($("#txtWorkHrs" + htRowCount[i].value).val() == "") {
                    strmsg = '- Work(Hrs) should not left blank';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtWorkHrs" + htRowCount[i].value).focus();
                }
                if ($("#txtWork").val() != "") {
                    if (RestrictNonNumeric(document.getElementById('txtWork')) == true) {


                        strmsg = '- Please Enter Numeric Value For Work(Hrs)';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }


                //if ($("#txtStoryPoint").val() != "") {
                //    if (RestrictNonNumeric(document.getElementById('txtStoryPoint')) == true) {


                //        strmsg = '- Please Enter Numeric Value For Story Point';
                //        errorMsg += "<li>" + strmsg + "</li></br>";
                //        Flag = 1;
                //        checkFlag = 1;
                //    }
                //}
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



                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error', 15);

                }
                return checkFlag;
                return isValid;
            }
        }


    }

    function editReleaseName(ReleaseName) {
        //alert();
        // debugger;
        $("#txtReleaseName").prop('disabled', false);
        $("#txtReleaseName").css("border-bottom", "#ddd");
        //  $("#txtReleaseName").val("");
        $("#txtReleaseName").focus();

        //Added by Sagar N on 09-May-2019 For Issue ID-18753
        $("#txtSprintName").prop('disabled', false);
        $("#txtSprintName").css("border-bottom", "#ddd");
        $("#txtSprintName").focus();
        //End of Added by Sagar N on 09-May-2019 For Issue ID-18753
    }


    function ChangeReleaseName(IterationID) {
        //  alert();
        //  debugger;
        var Flag = "";
        var result = AJAXCallWithResult("frmReleasePlanning.aspx/ChangeReleaseName", JSON.stringify({ IterationID: IterationID, ReleaseName: $("#txtReleaseName").val() }), false);
        if (result.d != "") {
            //alert(result.d);
            $('#tab_link li').on('click', function () {
                $('#tab_link li a').css("text-decoration", "none");
                $('#tab_link li a').css("color", "");
                $("a", this).css("text-decoration", "underline");
                $("a", this).css("color", "#60ffa7");
                //  $("a", this).css("color", "#60ffa7");
                // debugger;
                //$("a", this).attr("href").addClass("SelectedDIV")

            })
            $(".clsBox").hover(function () {
                $('#tab_link li a').css("text-decoration", "none");
                $('#tab_link li a').css("color", "");
                $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
                $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
                //$("[href=#" + $(this).attr("id") + "]").addClass("Selected")
            });
            //if (Flag != undefined) {
            //    setTimeout(function () {
            //        $("[href=#" + Flag + "]").click();
            //        var scrollPos = $("#" + Flag + "").offset().top;


            //        //if (Flag != "Sprint") {
            //        //    $("#div_details").scrollTop(scrollPos - 250);
            //        //   // $('#div_details').css("height", ((window.innerHeight / 2) - 35 + 'px'));
            //        //}
            //        //else {
            //        $("#sprint_details").scrollTop(scrollPos - 250);

            //        // }
            //    }, 500)

            //}

        }
    }

     //Added by Sagar N on 09-May-2019 For Issue ID-18753
    function ChangeSprintName(IterationID) {
        var Flag = "";
        var result = AJAXCallWithResult("frmReleasePlanning.aspx/ChangeSprintName", JSON.stringify({ IterationID: IterationID, SprintName: $("#txtSprintName").val() }), false);

        if (result.d != "") {
            
        }
    }
    // End of Added by Sagar N on 09-May-2019 For Issue ID-18753

    var Mode = 'Edit';

    // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
     var dtstart = '';
    var dtend = '';
    var dtsdt = '';
    var dtedt = '';
    var dtvsdt = '';
    var dtvedt = '';
    // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

    function GetDuration(MODE) {

        var objStart;
        var objEnd;
        Mode = MODE;

        if (MODE == "Release") {
            objStart = document.getElementById("RstartDate");
            objEnd = document.getElementById("txtEndDate");

            // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            var dtstartNew = new Date(objStart.value);
            var dtendNew = new Date(objEnd.value);

            if (isNaN(dtstartNew.getTime()) && isNaN(dtendNew.getTime())) {
            }
            else {
                if (objStart.value != "" && objEnd.value != "") {
                    var url = "frmReleasePlanning.aspx/GetDuration"
                    var data = JSON.stringify({ strStartDate: objStart.value, strEndDate: objEnd.value })
                    AJAXCall(url, data, bindDuration);
                }
            }
            // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        }
        else {

            objStart = document.getElementById("SprintStartdate");
            objEnd = document.getElementById("SprintEnddate");
            //}// Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            // Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            //var dtstart = new Date(objStart.value);
            //var dtend = new Date(objEnd.value);
            // End of Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

              // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                var oldobjStartVal = objStart.value;
            var oldobjEndVal = objEnd.value;  

             getInputDateFormat(objStart, objEnd, 1, opDateFormat);
                //End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
           
            if (isNaN(dtstart.getTime()) && isNaN(dtend.getTime())) {
            }
            else {
                if (objStart.value != "" && objEnd.value != "") {
                    var url = "frmReleasePlanning.aspx/GetDuration"
                    var data = JSON.stringify({ strStartDate: objStart.value, strEndDate: objEnd.value })
                    AJAXCall(url, data, bindDuration);
                }
            }

             // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                objStart.value = oldobjStartVal;
                objEnd.value = oldobjEndVal;

                var dtformatval = dtFormat(opDateFormat);

                $('#SprintStartdate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        //yearRange: '2000:2020'
                        yearRange: 'c-100:c+100'
                        //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                        , dateFormat: dtformatval
                        // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                    }
                );

                $('#SprintEnddate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        //yearRange: '2000:2020'
                        yearRange: 'c-100:c+100'
                        //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                        , dateFormat: dtformatval
                        // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                        , minDate: dateToday
                    }
                );
          $('#SprintEnddate,#SprintStartdate').prop('readonly', true);
                // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        }// Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
    }


    function AJAXCall(url, data, method) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout:180000,
            success: function (result) {  
                method(result);
                $(".loadingoverlay", parent.document).css("display", "none");
                // Stop();
            },
            error: function (xhr, status, error) {
                // Stop();
                StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

    }

    function bindDuration(result) {
        var strArray = String(result.d).split("|");
        if (Mode == "New") {
            document.getElementById("txtDuration").value = strArray[0];
            document.getElementById("txtDurationBusiness").value = strArray[1];
        }
        else if (Mode == "Release") {
            document.getElementById("txtRelCalendar").value = strArray[0];
            document.getElementById("txtRBusinessDuration").value = strArray[1];
        }
        else {
            document.getElementById("txtCalendar").value = strArray[0];
            document.getElementById("txtBusiness").value = strArray[1];
        }
    }


    var arrTabs = [
        "div_details",
        "graph",
        //"Sprints",
        "div1",
        "Teams",
        "Tasks",
        "div6",
        "div2",
        "div9",
        "ImpedimentsLogs",
        "Risks",
        "History",
        "div3"

    ];

    var arrTabs = [];
    var arrTabs1 = [
        "div_details",
        "graph",
        "Sprints",
        "div1",
        "Teams",
        "Tasks",
        "div6",
        "div2",
        "div9",
        "ImpedimentsLogs",
        "Risks",
        "History",
        "div3"
    ];

    function PreSprintRelease(Flag) {
        //debugger;
        if (Flag != "Sprint") {
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
        // debugger;
        //  debugger;
        if (Flag != "Sprint") {
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


    function UnmappedSprint(strIterationID, ReleaseID, txtID) {
        $("#" + txtID).val("");
        $("#divRemarks").css("display", "block");
        $("#divSprintList").css("display", "none");
        GlobalstrIterationID = strIterationID

    }
    var GlobalstrIterationID = ""

    function TerminateSprint1(ReleaseID, txtID, Flag) {
        // debugger;

        var txtRemark = document.getElementById(txtID);
        var spanRemark = document.getElementById("spanRemark" + GlobalstrIterationID);
        if (txtRemark.value != "") {
            var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: GlobalstrIterationID, strReleaseID: ReleaseID }), false);
            if (strResult.d == "2") {
                // obj.disabled=true;
               /// alert(123);
                var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: GlobalstrIterationID, strRemark: txtRemark.value, ReleaseID: ReleaseID, Flag: Flag }), false);
                if (result.d != "") {
                    var ResultLefdiv = result.d.split("||")
                    document.getElementById("divSprintList").innerHTML = ResultLefdiv[1];
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint unmapped successfully', 'success', 25);

                    ShowSprintData('List');
                    $("#divRemarks").css("display", "none");
                    txtRemark.value = "";


                }

            }
            else if (strResult.d == "1") {
                // ShowPopup("Release is released.You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Release is released.You can not terminate Sprint.', 'error');
                ShowSprintData('List');
            }
            else if (strResult.d == "3") {
               // alert();
                //ShowPopup("You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You can not terminate Sprint', 'error');
                //SearchBySprintName();
                ShowSprintData('List');
                

            }
            else if (strResult.d == "4") {
                //ShowPopup("You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sprint is already completed, you can not terminate the Sprint.', 'error');
                ShowSprintData('List');

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


    var ReleaseID = "";
    function Showmore(ReleaseID, Flag) {
           //AutoResizeTextArea();
           // getRows();
           // RemoveTextArea();
        $('[data-bs-toggle="tooltip"]').tooltip();
        //  globalReleaseID=ReleaseID;
        //debugger;
        AfterRelaseSprintSave(Flag, ReleaseID);

    }

    var AjaxResult;
    function AJAXCallWithResult(url, data, async) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            async: async,
            success: function (result) {
                AjaxResult = result;
                $(".loadingoverlay", parent.document).css("display", "none");
                // Stop();
            },
            error: function (xhr, status, error) {
                //  Stop();
                StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }


    function StartIteration(IterationID) {
        // debugger;
        // alert(IterationID);
        $('#idStartIteration').css('color', '#00a65a');
        var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckIterationMappedToUserStory", JSON.stringify({ intIterationID: IterationID }), false)
        if (strResult.d == "") {
            var data = JSON.stringify({ IterationID: IterationID, ProjectID: <%=Session("intProjectID")%> });
            var result = AJAXCallWithResult("frmReleasePlanning.aspx/StartIteration", data, false)
            strResultForStatus = result.d;
            //debugger;
            //alert(strResultForStatus);
            var arr = [];
            if (String(strResultForStatus).indexOf("$$$") == -1) {
                arr[0] = strResultForStatus;
            }
            else {
                arr = String(strResultForStatus).split("$$$");
            }


            if (strResultForStatus != "" && arr[1] == "1") {
                //ShowConfirm1(arr[0]);

                //alert(arr[0]);
            }
            else if (strResultForStatus != "" && arr[1] != "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(arr[0], 'error', 20);
                // $(ui.sender).sortable('cancel');
                return;

            }
            else {

                //alert('Iteration_onClick');
                Iteration_onClick(intIterationID, strIterationName);
            }


        }
        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strResult.d, 'error', 20);
            //ShowPopup(strResult.d);
        }
    }



    function Delete_UserStory(ID) {
        //    debugger;
        var UserStoryID = ID;
        var url = "frmReleasePlanning.aspx/DeleteEntryValidation";
        var data = JSON.stringify({ UserStoryID: UserStoryID });
        var para = []
        para.push(UserStoryID)
        var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
        DeleteEntrySuccess(strUserResult, para)
    }
    function DeleteEntrySuccess(result, para) {
        //  debugger;
        if (result.d == "0") {
            var url = "frmReleasePlanning.aspx/DeleteEntry";
            var data = JSON.stringify({ UserStoryID: para[0] });
            var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
            BindGrid(strUserResult)
        }
        else {
            var r = confirm(result.d);
            if (r == true) {
                var url = "frmReleasePlanning.aspx/DeleteEntry";
                var data = JSON.stringify({ UserStoryID: para[0] });
                var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                BindGrid(strUserResult)
            } else {
                return
            }
        }

    }
    function DeleteEntry() { }

    function BindGrid(result) {
        // debugger;
        // var display = $("#icnShow").parent().parent().css("display");

        // alert(result.d);
        document.getElementById("divSubstoryList").innerHTML = result.d;
        //SetWidthHeight();
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Sub User Stories Deleted Successfully', 'error', 20);
        document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'
        $("#divUS").modal('hide');
    }




    //function Tab_onclick(evt, cityName,ReleaseID) 
    //{
    //    // alert(ReleaseID);
    //    var i, tabcontent, tablinks;
    //    tabcontent = document.getElementsByClassName("tabcontentChart");
    //    for (i = 0; i < tabcontent.length; i++) {
    //        tabcontent[i].style.display = "none";
    //    }
    //    tablinks = document.getElementsByClassName("tablinks1");
    //    for (i = 0; i < tablinks.length; i++) {
    //        tablinks[i].className = tablinks[i].className.replace(" active", "");
    //    }
    //    document.getElementById(cityName).style.display = "block";
    //    evt.currentTarget.className += " active";
    //    if (cityName=="BurnUp")
    //    {

    //        $("#SprintRelease").html('Post');
    //    }


    //    $('#sprint_details').css("height", ((window.innerHeight / 2) + 80 + 'px'));
    //}

    // Get the element with id="defaultOpen" and click on it



    //function openCity1(evt, cityName) 
    //{

    //    var i, tabcontent, tablinks;
    //    tabcontent = document.getElementsByClassName("tabcontentChart");
    //    for (i = 0; i < tabcontent.length; i++) {
    //        tabcontent[i].style.display = "none";
    //    }
    //    tablinks = document.getElementsByClassName("tablinks1");
    //    for (i = 0; i < tablinks.length; i++) {
    //        tablinks[i].className = tablinks[i].className.replace(" active", "");
    //    }
    //    document.getElementById(cityName).style.display = "block";
    //    evt.currentTarget.className += " active";
    //}

    //function GetLineGraph(){


    //    debugger;
    //  //  get the line chart canvas
    //var ctx = $("#BurnDown");

    //    //line chart data
    //    var data = {
    //        labels: ["match1", "match2", "match3", "match4", "match5"],
    //        datasets: [
    //            {
    //                label: "TeamA Score",
    //                data: [10, 50, 25, 70, 40],
    //                backgroundColor: "blue",
    //                borderColor: "lightblue",
    //                fill: false,
    //                lineTension: 0,
    //                radius: 5
    //            },
    //            {
    //                label: "TeamB Score",
    //                data: [20, 35, 40, 60, 50],
    //                backgroundColor: "green",
    //                borderColor: "lightgreen",
    //                fill: false,
    //                lineTension: 0,
    //                radius: 5
    //            }
    //        ]
    //    };

    //    //options
    //    var options = {
    //        responsive: true,
    //        title: {
    //            display: true,
    //            position: "top",
    //            text: "Line Graph",
    //            fontSize: 18,
    //            fontColor: "#111"
    //        },
    //        legend: {
    //            display: true,
    //            position: "bottom",
    //            labels: {
    //                fontColor: "#333",
    //                fontSize: 16
    //            }
    //        }
    //    };

    //    //create Chart class object
    //    var chart = new Chart(ctx, {
    //        type: "line",
    //        data: data,
    //        options: options
    //    });
    //}
    //  GetLineGraph(UniqueID,'Release', 'divGraph' + UniqueID, "");

    //For BurnDown Graph Effortwise
    function GetLineBurnDown(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        //debugger
        if (Flag == 'Sprint')
            Flag = 'Iteration'
        var ctx = $("#BurnDown" + UniqueID);
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGraphDetails", data, false);

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
                fontSize: 11.5,
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
                    /* Modified By Madhuri.K On 03-04-2026 */ 
                    fontSize: 11.5
                }
            },


        };


        var chart = new Chart(ctx, {
            type: "line",
            data: lineChartData1,
            options: options
        });

    }
    //For Burn down chart storypoint wise
    function GetLineBurnUP(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        // debugger;
        if (Flag == 'Sprint')
            Flag = 'Iteration'
        var ctx1 = $("#BurnUp" + UniqueID);
        // var ctx1 = $("#line-chartcanvas1");
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGraphDetailsStoryPoint", data, false);

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
                fontSize: 11.5,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    fontSize: 11.5
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


    //For Burnup Graph Effort wise
    function GetLineBurnUPEffortS(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        if (Flag == 'Sprint')
            Flag = 'Iteration'
        var BurnupGraphEfforts = $("#BurnupGraphEfforts" + UniqueID);
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGetBurnUpChartGraphDetails", data, false);

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
                fontSize: 11.5,
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
                    fontSize: 11.5
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
    //Burn up chart story point wise
    function GetLineBurnDownStoryPoints(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        if (Flag == 'Sprint')
            Flag = 'Iteration'

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
                fontSize: 11.5,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    fontSize: 11.5
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
        //alert();
        if (document.getElementById("VelocityEffortBar" + UniqueID) != null) {
            var VelocityEffortBar = document.getElementById("VelocityEffortBar" + UniqueID).getContext("2d");
        }
        else {
            return;
        }
        var strResult, data;

        data = JSON.stringify({ strGraphFilter: "Effort", UniqueID: UniqueID });

        console.log(data)
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetVelocityData", data, false);
        var strEntityCount = [];
        var PercentCount = [];
        var arrBackColor = [];
        var strLabels = [];
        var r = 0;
        var g = 0;
        var b = 0;
        if (strResult.d != "") {

            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels.push(object["IterationName"]);
                strEntityCount.push(object["Velocity"]);
                PercentCount.push(object["Efforts"]);
                //arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                //r += 30;
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
                    label: 'Commited',
                    backgroundColor: 'orange',
                    borderWidth: 1,
                    //fill: false,
                    data: strEntityCount,
                    // yAxisID: "y-axis-2",
                }, {

                    type: 'bar',
                    label: 'Completed',
                    // data: PercentCount,
                    backgroundColor: 'green',
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
                fontSize: 11.5,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    fontSize: 11.5
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
        if (document.getElementById("VelocitySToryPoints" + UniqueID) != null) {
            var VelocitySToryPoints = document.getElementById("VelocitySToryPoints" + UniqueID).getContext("2d");
        }
        else {
            return;
        }

        var strResult, data;

        data = JSON.stringify({ strGraphFilter: "Storypoint", UniqueID: UniqueID });

        console.log(data)
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetVelocityData", data, false);
        var strEntityCount = [];
        var PercentCount = [];
        var arrBackColor = [];
        var r = 0;
        var g = 0;
        var b = 0;
        var strLabels = [];
        if (strResult.d != "") {

            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels.push(object["IterationName"]);
                strEntityCount.push(object["Velocity"]);
                PercentCount.push(object["Efforts"]);
                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                r += 30;
            });

        }

        var config1 = {
            type: 'bar',
            data: {
                labels: strLabels,
                datasets: [{
                    type: 'bar',
                    label: 'Commited',
                    backgroundColor: 'Orange',
                    borderWidth: 1,
                    //fill: false,
                    data: strEntityCount,
                    // yAxisID: "y-axis-2",
                }, {

                    type: 'bar',
                    label: 'Completed',
                    // data: PercentCount,
                    backgroundColor: 'green',
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
                fontSize: 11.5,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    fontSize: 11.5
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
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetFlowGraph", data, false);

        var strToDO = [];
        var strInProgress = [];
        var strCompleted = [];
        var arrBackColor1 = [];
        var strLabels1 = [];
        if (strResult.d != "") {
            // debugger;
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels1.push(object["EntryDate"]);
                strToDO.push(object["ToDo"]);
                strInProgress.push(object["InProgress"]);
                strCompleted.push(object["Completed"]);
            });

        }

        var lineChartData1 = {
            labels: strLabels1,
            datasets: [{
                label: "To-Do List",
                borderColor: "orange",
                backgroundColor: "orange",
                fill: false,
                data: strToDO,
            }, {
                label: "In Progress",
                borderColor: "#5bc0de",
                backgroundColor: "#5bc0de",
                fill: false,
                data: strInProgress,
            },
            {
                label: "Completed",
                borderColor: "green",
                backgroundColor: "green",
                fill: false,
                data: strCompleted,
            }
            ]
        };
        //options
        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Flow Chart(Flow)",
                fontSize: 11.5,
                fontColor: "#111"
            },

            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    fontSize: 11.5
                }
            }
        };

        var chart = new Chart(FlowGraphEfforts, {
            type: "line",
            data: lineChartData1,
            options: options
        });

    }





    var data, strResult;
    //Commented and added by Chetan M on 1st August 2020 for Issue ID = 25477
    //function RefreshAllPage() {
    function RefreshAllPage(flag) {
       //End of Commented and added by Chetan M on 1st August 2020 for Issue ID = 25477
        var ReleaseID = document.getElementById('hdnReleaseID').value;
        if (ReleaseID == "") {
            ReleaseID = document.getElementById('hdnReleaseIDUS').value;
        }

        if (ReleaseID == "") {

            ReleaseID = GlobaluniqueId;

        }

        data = JSON.stringify({ ReleaseID: ReleaseID });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/RefreshPage", data, false);
        if (strResult.d != "") {
            // $('.fade').removeclass('in');
            //refresh();       //Commented by Usha Pandit on 12 June 2018 for sprint drag issue
            $('#myModal_dash').modal('hide');
            document.getElementById("MainDiv").innerHTML == "";
            document.getElementById("MainDiv").innerHTML = strResult.d;
            refresh();        //Added by Usha Pandit on 12 June 2018 for sprint drag issue

        }
        //added by Chetan M on 1st August 2020 for Issue ID = 25477
        if (flag == "Sprint") {
            Showmore(ReleaseID, 'Release');
        }
        //End of  added by Chetan M on 1st August 2020 for Issue ID = 25477
        // $('#myModal_dash').modal('hide');

    }




    //function GetFlowStoryPoints(UniqueID, Flag,GrapID,SelectedID,WhichGraph) {



    //    var FlowGraphStoryPoints = $("#FlowGraphStoryPoints"+ UniqueID);
    //    // var ctx1 = $("#line-chartcanvas1");
    //    var strResult, data;
    //    data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag,SelectedID:"Null" });
    //    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGraphDetails", data, false);

    //    var strInRate1 = [];
    //    var strOutRate1 = [];
    //    var strOutStanding1 = [];
    //    var arrBackColor1 = [];
    //    var strLabels1 = [];
    //    if (strResult.d != "") {
    //        // debugger;
    //        $.each(JSON.parse(strResult.d), function (id, object) {
    //            strLabels1.push(object["EntryDate"]);
    //            strInRate1.push(object["Planned"]);
    //            strOutRate1.push(object["Remained"]);
    //            // strOutStanding1.push(object["OutStanding"]);

    //            // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
    //        });

    //    }

    //    var lineChartData1 = {
    //        labels: strLabels1,
    //        datasets: [{
    //            label: "Planned",
    //            borderColor: "orange",
    //            backgroundColor:"orange",
    //            fill: false,
    //            data: strInRate1,
    //            //yAxisID: "y-axis-1",
    //        }, {
    //            label: "Remaining",
    //            borderColor: "#5bc0de",
    //            backgroundColor:"#5bc0de",
    //            fill: false,
    //            data: strOutRate1,
    //            //yAxisID: "y-axis-2"
    //        },

    //        ]
    //    };
    //    //options
    //    var options = {
    //        responsive: true,
    //        title: {
    //            display: true,
    //            position: "top",
    //            text: "Flow Chart(Flow)",
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
    //        }
    //    };




    //    var chart = new Chart(FlowGraphStoryPoints, {
    //        type: "line",
    //        data: lineChartData1,
    //        options: options
    //    });



    //}
    //end of  Flow S P Graph





    var isValid = 0;
    var saveFlag = 0;
    var intResource = 1;

    var strcombohtml = "";
    var strcombohtml1 = "";
    var objform = GetFormReference('form1');
    var objDivMain = GetObjectReference('form1', 'PageDiv');
    var objDivTab = GetObjectReference('form1', 'divTblGrid');
    var objTaskSDt, objTaskEDt, objTaskHrs, objBalenceWork;
    var objTbl = GetObjectReference('form1', 'tblProjectDetail');
    var objQTaskCounter = GetObjectReference('', 'RowNumber');

    if (objQTaskCounter != null)
        noOfRows = parseInt(objQTaskCounter.value) - 1;
    else
        noOfRows = 0;

    if (objTbl != null) {
        NewTR1 = objTbl.insertRow(objTbl.rows.length);

        NewTD1 = NewTR1.insertCell(0);
        NewTD1 = NewTR1.insertCell(1);
        NewTD1 = NewTR1.insertCell(2);
        NewTD1 = NewTR1.insertCell(3);
        NewTD1 = NewTR1.insertCell(4);
        NewTD1 = NewTR1.insertCell(5);
        NewTD1 = NewTR1.insertCell(6);
        NewTD1 = NewTR1.insertCell(7);
        NewTD1 = NewTR1.insertCell(8);
    }
    var noOfRows;
    var LastRowNumber;
    LastRowNumber = -1; var isInValid = 0;


    function CreateRowForResource() {


        if (insertRow != null) {
            NewTR = tblProjectDetail.insertRow(tblProjectDetail.rows.length)
        }

        if (noOfRows == 0) {
            noOfRows = 1;
        }
        else
            noOfRows = noOfRows + 1;


        objTbl = GetObjectReference('form1', 'tblProjectDetail');
        totalcount = tblProjectDetail.rows.length - 1;
        // alert(totalcount)

        if (noOfRows == 0) {
            noOfRows = 1;
            totalcount = 1;
        }
        else {
            noOfRows = noOfRows;
            totalcount = totalcount;
        }

        newTD = NewTR.insertCell(0);
        // newTD.align = 'Left';
        newTD.innerHTML = "<td style='Width:5%;text-align:left' ><a onclick='deleteRow(this," + totalcount + ")'><i class='fa fa-remove ' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%'  data-bs-toggle='tooltip' title='Remove record' data-bs-placement='right'></i></a></td>"



        //cell 2

        newTD = NewTR.insertCell(1);
        newTD.align = 'Left';
        NewTR.id = 'TR' + totalcount;
        strcombohtml += "<input type='text' placeholder='Task Name' class='form-control' id='txtTaskName" + totalcount + "' name='txtTaskName" + totalcount + "')>"
        strcombohtml = strcombohtml.replace(/txtTaskName/g, "txtTaskName")
        strcombohtml =
            /* Modified By Madhuri.K On 03-04-2026 */ 
        strcombohtml += "<td  style='color:#dd4b39;font-size:11.5px'>"
        //strcombohtml += "<i id='spanRole" + totalcount + "' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>";
        strcombohtml += "</td>";
        newTD.innerHTML = '<td style="width:20%"> ' + strcombohtml + '<input type=hidden name="hdrownumber" value=' + totalcount + ' /></td>';


        // alert(strcombohtml)


        newTD = NewTR.insertCell(2);
        newTD.align = 'Left';
        strcombohtml = "";
        strcombohtml += "<input type='text' placeholder='Start Date' class='form-control' id='txtStartDate" + totalcount + "' name='txtStartDate" + totalcount + "' )>"
        strcombohtml = strcombohtml.replace(/txtStartDate/g, "txtStartDate")
        strcombohtml += "<input type=hidden name='hdrownumber' value='" + totalcount + "' />"
        strcombohtml += " <i class='far fa-calendar-check' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpstartdate" + totalcount + "'  onclick='$('#txtStartDate" + totalcount + "').datepicker();$('#txtStartDate" + totalcount + "').datepicker('show')'></i>"




        newTD.innerHTML = '<td style="width:15%"> ' + strcombohtml + '</td>';


        newTD = NewTR.insertCell(3);
        newTD.align = 'Left';
        strcombohtml = "";
        strcombohtml += "<input type='text' placeholder='End Date' class='form-control' id='txtEndDate" + totalcount + "' name='txtEndDate" + totalcount + "')>"
        strcombohtml = strcombohtml.replace(/txtEndDate/g, "tASKEndDate")
        strcombohtml += " <i class='far fa-calendar-check' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpEnddate" + totalcount + "'  onclick='$('#txtEndDate" + totalcount + "').datepicker();$('#txtEndDate" + totalcount + "').datepicker('show')'></i>"


        newTD.innerHTML = '<td style="width:15%"> ' + strcombohtml + '</td>';
        //  alert(NewTR.id)

        newTD = NewTR.insertCell(4);


        newTD.align = 'Left';
        strcombohtml = "";
       /* Modified By Madhuri.K On 03-04-2026 */ 
        newTD.style = 'color:#dd4b39;font-size:11.5px'
        strcombohtml += "<input type='text' placeholder='Work Hrs' class='form-control' id='txtWorkHrs" + totalcount + "' name='txtWorkHrs" + totalcount + "')>"
        strcombohtml = strcombohtml.replace(/txtWorkHrs/g, "txtWorkHrs")
        newTD.innerHTML = '<td style="width:10%">' + strcombohtml + '</td>';




        newTD = NewTR.insertCell(5);


        newTD.align = 'Left';
        strcombohtml = "";
        /* Modified By Madhuri.K On 03-04-2026 */ 
        newTD.style = 'color:#dd4b39;font-size:11.5px'
        strcombohtml += "<select name='cboresource" + totalcount + "' name='cboresource" + totalcount + "' class='form-control' style='width:120px'>"
        strcombohtml = strcombohtml.replace(/cboresource/g, "cboresource")
        newTD.innerHTML = '<td style="width:10%">' + strcombohtml + '</td>';






        newTD = NewTR.insertCell(6);


        newTD.align = 'Left';
        strcombohtml = "";
        /* Modified By Madhuri.K On 03-04-2026 */ 
        newTD.style = 'color:#dd4b39;font-size:11.5px;text-align:center'
        strcombohtml += "<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-toggle='tooltip'  id='idEdit" + totalcount + "' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt-alt' onclick='EditTask()'></i>"
        strcombohtml = strcombohtml.replace(/idEdit/g, "idEdit")
        newTD.innerHTML = '<td style="width:7%;text-align:center">' + strcombohtml + '</td>';



        newTD = NewTR.insertCell(7);


        newTD.align = 'Left';
        strcombohtml = "";
       /* Modified By Madhuri.K On 03-04-2026 */ 
        newTD.style = 'color:#dd4b39;font-size:11.5px;text-align:center'
        strcombohtml += "<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  id='iddelete" + totalcount + "' title='Delete Task' class='fa fa-ban' onclick='DeleteTask()' disabled></i>"
        strcombohtml = strcombohtml.replace(/iddelete/g, "iddelete")
        newTD.innerHTML = '<td style="width:7%;text-align:center">' + strcombohtml + '</td>';






        newTD = NewTR.insertCell(8);


        newTD.align = 'Left';
        strcombohtml = "";
        // var flag = "Task";
        /* Modified By Madhuri.K On 03-04-2026 */ 
        newTD.style = 'color:black;font-size:11.5px;text-align:center'
        strcombohtml += "<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  id='SaveBtn" + totalcount + "' title='Save Task' class='fa fa-save' onclick=Save_SubTab_Data('" + strUserStoryId + "','Task')></i>"
        strcombohtml = strcombohtml.replace(/SaveBtn/g, "SaveBtn")
        newTD.innerHTML = '<td style="width:7%;text-align:center;color:black">' + strcombohtml + '</td>';


        newTD = NewTR.insertCell(9);
        newTD.align = 'Left';
        strcombohtml = "";
        /* Modified By Madhuri.K On 03-04-2026 */ 
        newTD.innerHTML = '<td><a id=errorPopOver' + totalcount + '  style="font-size:11.5px;display:none" title="Header" data-bs-toggle="popover" data-bs-target="#popOverDiv"  data-bs-placement="left" data-content="" onmouseover="DataHover(this)" class="btn btn-block btn-danger far fa-check-square errorList"></a></td>'

        newTD.innerHTML = '' + newTD.innerHTML + '';




        //BindEmployeeDetails(totalcount);

    }

    function AfterSaveTask(data, extraPara) {
        var Id = extraPara[0];
        //$('#txtTaskName' + Id).val('');
        //$('#cboresource' + Id).val('');
        //$('#txtWork'+ Id).val('');
        //$('#txtStartDate').val('');
        //$('#tASKEnddate').val('');
        //$('#cboPrioritytask').val('');
        //$('#cboTtypetask').val('');
        //$('#txtStoryPoints').val('');
        var strProjectID = document.getElementById('hdnProjectID').value;
        document.getElementById("divTasks").innerHTML = data.d;
        // ShowData('List', 'subTask');
        //  datatables('DivTaskList', 'txtSearchTask', '')
        // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
        // document.getElementById("divUserStories").innerHTML = strUserResult.d;
        //added By Dipali V On 30th Mach 2018 For Sub Us Creation
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Task Created successfully', 'success', 25);
        // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
        $('[data-bs-toggle="tooltip"]').tooltip();
        isValid = 0;
        saveFlag = 0;


    }

    function EditTask(UserStoryID, TaskID) {

        if (TaskID != "") {
            var strProjectID = document.getElementById('hdnProjectID').value;
            $('[data-bs-toggle="tooltip"]').tooltip();
            $("#tblProjectDetail").find("#txtStartDate" + TaskID).removeAttr("disabled")
            $("#tblProjectDetail").find("#txtEndDate" + TaskID).removeAttr("disabled")
            $("#tblProjectDetail").find("#txtWorkHrs" + TaskID).removeAttr("disabled")
            $("#tblProjectDetail").find("#txtWorkHrs" + TaskID).removeAttr("disabled")
            $("#tblProjectDetail").find("#dpEnddate" + TaskID).removeAttr("disabled")
            $("#tblProjectDetail").find("#dpstartdate" + TaskID).removeAttr("disabled")
            //$('#txtEndDate' + TaskID).datepicker();
            //$('#txtStartDate' + TaskID).datepicker();
            //$("#Update" + TaskID).html("");
            $('#txtEndDate' + TaskID).datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            $('#txtStartDate' + TaskID).datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            $('#Update' + TaskID).datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                });
            //cboresource
            /* Modified By Madhuri.K On 03-04-2026 */ 
            document.getElementById('Update' + TaskID).innerHTML = "<i style='font-size:11.5px!important;text-align:center' data-bs-toggle='tooltip'  id='UpdateBtn' data-bs-toggle='tooltip' title='Update Task' class='fa fa-refresh' onclick=UpdateTask(" + TaskID + ") ></i>"

            var strmsg = "";
            var errorMsg = "<ul>"


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


            if ($("#txtWorkHrs" + TaskID).val() == "") {
                strmsg = '- WorkHrs should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtWorkHrs" + TaskID).focus();
            }
        }
    }

    function UpdateTask(TaskID) {
        $('[data-bs-toggle="tooltip"]').tooltip();
        if (TaskID != "") {

            var strmsg = "";
            var checkFlag = 0;
            var errorMsg = "<ul>"


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


            if ($("#txtWorkHrs" + TaskID).val() == "") {
                strmsg = '- WorkHrs should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtWorkHrs" + TaskID).focus();
            }

            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 15);

            }
            checkFlag = 0;
            isValid = 0;

            if (isValid == 0) {

                saveFlag = 1;
                //alert();
                var objTaskName = $('#txtTaskName' + TaskID);
                var objResource = $('#cboresource' + TaskID);
                var objWorkHrs = $('#txtWorkHrs' + TaskID);
                var objStartDate = $('#txtStartDate' + TaskID);
                var objEndDate = $('#txtEndDate' + TaskID);
                var objPriorities = "";
                var objTaskType = "";
                var StoryPoints = ""
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



                URL = 'frmProductBacklog.aspx/SaveTask';

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
        /*Commented By yasmin on 5-3-19*/
        //$('#txtEndDate').datepicker();
        //$('#txtStartDate').datepicker();
        $('#txtEndDate,#txtStartDate').datepicker(
            {
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
        URL = 'frmProductBacklog.aspx/AfterDeleteTask';
        //AssignDeletetaskData.push({
        //    taskId: taskId

        //});

        data = JSON.stringify({ taskId: taskId, UserStoryId: strUserStoryId, });
        AJAXCallWithPara(URL, data, AfterDeleteTask, extraPara);
        $('#txtEndDate,#txtStartDate').datepicker(
                 {
                     changeMonth: true,
                     changeYear: true,
                     //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                 }
                 );
        $('[data-bs-toggle="tooltip"]').tooltip();
    }
    function AfterDeleteTask(data, extraPara) {
        var Id = extraPara[0];

        var strProjectID = document.getElementById('hdnProjectID').value;
        document.getElementById("divTasks").innerHTML = data.d;

        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Task Deleted successfully', 'success', 25);
        // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('#txtEndDate,#txtStartDate').datepicker(
                 {
                     changeMonth: true,
                     changeYear: true,
                     //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                    //yearRange: '2000:2020'
                    yearRange: 'c-100:c+100'
                    //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                 });
        isValid = 0;
        saveFlag = 0;


    }

    function AfterEditTask(data, extraPara) {
        var Id = extraPara[0];
        //$('#txtTaskName' + Id).val('');
        //$('#cboresource' + Id).val('');
        //$('#txtWork'+ Id).val('');
        //$('#txtStartDate').val('');
        //$('#tASKEnddate').val('');
        //$('#cboPrioritytask').val('');
        //$('#cboTtypetask').val('');
        //$('#txtStoryPoints').val('');
        var strProjectID = document.getElementById('hdnProjectID').value;
        document.getElementById("divTasks").innerHTML = data.d;
        // ShowData('List', 'subTask');
        //  datatables('DivTaskList', 'txtSearchTask', '')
        // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
        // document.getElementById("divUserStories").innerHTML = strUserResult.d;
        //added By Dipali V On 30th Mach 2018 For Sub Us Creation
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Task Update successfully', 'success', 25);
        // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('#txtEndDate0').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
        $('#txtStartDate0').datepicker({
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
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
      
        isValid = 0;
        saveFlag = 0;

    }

    function ShowData(type, WhichTab) {
        // debugger;
        if (WhichTab == 'SubUS') {
            if (type == 'List') {
                $("#divSubstoryList").css("display", "")
                $("#divSubstoryForm").css("display", "none")
            }
            else if (type == "Form") {
                $("#divSubstoryList").css("display", "none")
                $("#divSubstoryForm").css("display", "")
            }
        }
        else if (WhichTab == 'subTask') {
            if (type == 'List') {
                $("#divTaskList").css("display", "")
                $("#divTaskForm").css("display", "none")
            }
            else if (type == "Form") {
                $('#txtTaskName').val('');
                $('#cboresource').val('');
                $('#txtWork').val('');
                $('#txtStartDate').val('');
                $('#txtEnddate').val('');
                $('#cboPrioritytask').val('');
                $('#cboTtypetask').val('');
                $('#txtStoryPoints').val('');
                $("#divTaskList").css("display", "none")
                $("#divTaskForm").css("display", "")
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
                $('#cboRevieStatus').val('');
                $('#cboTtypetask').val('');
                $('#cboReviewee').val('');
                // timeNow(ID);
                $("#divReviewList").css("display", "none")
                $("#divReviewForm").css("display", "")

                $(".k-checkboxcboReviewer").each(function () {
                    $(this).prop('checked', false);
                });

                $(".k-checkbox").each(function () {
                    $(this).prop('checked', false);
                });

            }
        }
    }


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

    var projectid, IssueField;
    function IssueType_OnChange(obj) {


        projectid = obj;
        IssueField = document.getElementById("cboIssueType").value;
        var url = "frmProductBacklog.aspx/GetDropDownValue";
        data = JSON.stringify({ ProjectID: projectid, WhichList: "IssueType", Mode: 'New', Issue_Type: IssueField });
        objAbbrivatdName = projectid



        CustomAJAXCall(url, data, BindDropDownValues);

        var url = "frmProductBacklog.aspx/GetDropDownValue";
        data = JSON.stringify({ ProjectID: projectid, WhichList: "Reporter", Mode: 'New', Issue_Type: IssueField });
        CustomAJAXCall(url, data, BindDropDownValues1);

        IssueField = document.getElementById("cboIssueType").value;
        var url = "frmProductBacklog.aspx/GetDropDownValue";
        data = JSON.stringify({ ProjectID: projectid, WhichList: 'SubType', Mode: 'New', Issue_Type: IssueField });
        CustomAJAXCall(url, data, BindDropdownSubType);


        //FieldValidation();
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
    function BindDropDownValues(result) {

        var strArray = String(result.d).split("|")
        objCbo = document.getElementById("cboIssueType");

        var i = 0;
        objCbo.innerHTML = "";


        var url = "frmProductBacklog.aspx/GetDefaultType";
        data = JSON.stringify({ strResult: $("#hdnProjectID").val() });
        var result = AJAXCallWithResult(url, data, false);

        $.each(JSON.parse(strArray[0]), function (id, obj) {
            // alert(strArray);
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.FieldID;
            objOption.value = obj.FieldName;
            // GetSelectedSubtype(FieldName)
        });

        objCbo.value = result.d;


        //addCode(s);

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

        objCbo1.value = $("#hdnstrUserName").val();

    }
    function GetSelectedSubtype(obj) {


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

                $("#cboReviewer").val($("#cboReviewer").val() + value + ',');

                if (Reviwers == undefined) {
                    Reviwers = '';
                }
                if (Reviwers.indexOf($("#hdnReviwerID" + EmployeeID).val()) == -1) {
                    Reviwers = Reviwers + $("#hdnReviwerID" + EmployeeID).val() + ','

                }

                //alert(Reviwers);
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
    function Filter_clear() {

        RefreshGrid();
        $(".fa-ellipsis-v").tooltip();
        $("#idfilter").css("display", "none");
        // $("#uldropdown").css("display", "none")

    }
    function GetObjectReference(strFormId, strElementId, blnIsName) {
        var objElement;
        var objCombo;

        if (blnIsName) {
            objElement = document.getElementsByName(strElementId);
        }
        else if (!(blnIsName)) {
            objElement = document.getElementById(strElementId);
        }
        return objElement;

    }
    function Export_onclick(flag, format, EntityID) {
        var objform;
        format = format.toUpperCase();
        var strExportResult = ajaxCall("frmReleasePlanning.aspx/ExportToExcel", "POST", "application/json", "json", JSON.stringify({ ReportFormat: format, Entity: flag, EntityID: EntityID }));

        if (strExportResult.d != "") {
            //alert(strExportResult.d);
        }
        window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strExportResult.d, "_report", "");
    }
    /*Added by kashish For Texarea Enhancement*/

    //function AutoResizeTextArea() {
    //    $('#txtDescriptionSprint').autosize({ append: "" });
    //    //var a = $("#txtActionItems").height();
    //    //alert(a);
    //    //var b=a-150 + 'px';
    //    //$('#txtActionItems').css('height', b);
    //    //$('#txtRemark').autosize({ append: "" });
    //    //$('#txtImpedimentDescription').autosize({ append: "" });
    //    //$('#txtPreventiveAction').autosize({ append: "" });

    //    //$('#PreventiveAction').autosize({ append: "" });
    //    //$('#txtCorrectiveAction').autosize({ append: "" });

    //}


    function AutoGrowTextArea(textField) {
        //Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
    //if (textField.value.length >= 2000) {
    if (textField.value.length >= 2000) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Please Enter Discussion less than 2000 characters.', 'error', 5);
        $(textField).focus();
    }
    //End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
        if (textField.clientHeight < textField.scrollHeight) {
            textField.style.height = textField.scrollHeight + "px";
            if (textField.clientHeight < textField.scrollHeight) {
                textField.style.height =
                    (textField.scrollHeight * 2 - textField.clientHeight) + "px";
            }
        }
    }
    function AutoResizeTextArea() {
        //alert();
        jQuery.each(jQuery('textarea[data-autoresize]'), function () {
            //var offset = this.offsetHeight - this.clientHeight;

            var resizeTextarea = function (el) {
                //jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
            };
            jQuery(this).on('keyup input', function () {
                if ($(this).attr("id") == "txtRemark3") {

                    Maxlength(this, "smallRemark_3", 1000);

                }
              

                resizeTextarea(this);
            }).removeAttr('data-autoresize');


        });
    }

    function RemoveTextArea() {
        $('textarea').keydown(function (e) {
            var $this = $(this),
                rows = parseInt($this.attr('rows')),
                lines;
            //alert(rows);
            //// on enter
            //if (e.which === 13){
            //    $this.attr('rows', rows + 1);
            //}

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

        if ($("#txtRemark3").val() != undefined) {


            var numberOfColumns = 70;
            var numberOfLines = 1;
            //numberOfColumns = document.getElementById("txtActionItems").cols;
            var eachLine = $("#txtRemark3").val().split('\n');
            var lineheight = $("#txtRemark3").val();
            numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
            characterCount = lineheight.length + numberOfLineBreaks;

            if (characterCount > numberOfColumns) {
                numberOfLines = parseInt(characterCount / numberOfColumns);
                var height = document.getElementById("txtRemark3").rows = numberOfLines;
                $("#txtRemark3").attr("style", "height: auto !important");
            }

        }
        
    }

    function RefreshTab(SelectedTab, Flag, UniqueID, DivID) {
        //table.DataTable().destroy();
        //alert();
        //table.ajax.reload();
		var scrolltop = $("#" + DivID + "").offset().top;
        data = JSON.stringify({ SelectedTab: SelectedTab, Flag: Flag, UniqueID: UniqueID });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/ReFreshTab", data, false);
        //alert(strResult.d);
        if (strResult.d != "") {
            $("#" + DivID).html("");
            $("#" + DivID).html(strResult.d);
            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterCurrentSprintUS").val() > 0) {
                datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterIssuesList").val() > 0) {
                datatables('DivSubTabIssuesList', 'txtSearchIssues', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterImpedimentsLogsList").val() > 0) {
                datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterRisksList").val() > 0) {
                datatables('DivRisksList', 'txtSearchRisks', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterReviewList").val() > 0) {
                datatables('DivReviewList', 'txtSearchReviews', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterTaskList").val() > 0) {
                datatables('DivTaskList', 'txtSearchTask', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterHistorykList").val() > 0) {
                datatables('DivHistorykList', 'txtSearchhistory', '')
            }

            //Added By Dipali V On 28th March 2023 For Datable Issue
            if ($("#FilterAttachmentList").val() > 0) {
                datatables('DivAttachmentList', 'txtDivAttachmentList', '')
            }
        }


        //  }

        $('[data-bs-toggle="tooltip"]').tooltip();


    }

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




