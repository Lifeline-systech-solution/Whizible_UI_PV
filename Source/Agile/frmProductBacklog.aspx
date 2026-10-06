<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmProductBacklog.aspx.vb" Inherits="PbNIT.frmProductBacklog" %>

<!DOCTYPE html>
<html>

    <%CommonFunctions.General.PlotPageHeadTag("Product Backlog")%>
<head id="Head1" runat="server">
    <%--<title>Product Backlog</title>
    
    <link href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/dist/css/font.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/fontawesome/css/all.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../../Whizible2.0-new/dist/css/editor.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link href="css/StyleSheet_Agile.css?v=3.37" rel="stylesheet" />
   <%-- Added By Dipali V On 10th May 2023 For Calender Issue--%>
    <%--<link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
     <%--End of Added By Dipali V On 10th May 2023 For Calender Issue--%>

    <%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <script src="js/autosize.js"></script>
    <%--<script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
    <script src="js/CommonJS.js?date=<%=DateTime.Now %>"></script>
    <%--<script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/editor.js"></script>
    <%--<script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/timepicker.min.js"></script>  
    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
 
    <style>
        /*Added by Swapna*/
        /*div{
            -ms-overflow-style:none;
        }*/
        /*End*/

        body {
    font-size:11.5px!important 
    /* Modified By Madhuri.K On 26-03-2026 */
}
   
        /*Added by Usha Pandit on 06 june 2018 for hiding scroll bar for history  grid*/
        #DivHistorykList, #divhistoryList {
            -ms-scrollbar-arrow-color: white !important;
            -ms-scrollbar-base-color: white !important;
            -ms-scrollbar-shadow-color: white !important;
        }

        .clsHistoryTableBorder {
            border-right: 5px solid #ddd !important;
        }
        /*End of Added by Usha Pandit on 06 june 2018 for hiding scroll bar for history  grid*/

        .dashed-placeholder {
            border: 2px dashed #999;
            padding: 60px;
        }

        .btn-info:hover {
            z-index: 99 !important;
        }

        .clsDiscussion {
            /*height: 25px;*/
            border-bottom: 2px solid rgb(60, 141, 188) !important;
            line-height: 1;
            font-size: 14px !important;
            padding-bottom: inherit;
        }

        .demo-droppable {
            margin-bottom: 10px;
        }

        .input-group {
            width: 100%;
        }

        .tooltip.right, .bottom, .top, .left {
            font-weight: 500 !important;
        }

        .sortable.grid {
            overflow: hidden;
        }

        .sortable-placeholder {
            border: 2px dashed #CCC;
            padding: 80px;
            background: none;
        }

        #tblFieldList label {
            font-weight: 100 !important;
        }

        .cards {
        }

        .FixedTD {
            /*background-color:#F0D1A1;/*#e6ffff*/
            padding: 5px !important;
            position: fixed;
            /*background-clip: padding-box;*/
            /*background-color:#f0ccc3!important;*/
            border: 1px solid white;
            overflow-x: hidden;
            overflow-y: auto;
        }

        .card [class*=card-header-]:not(.card-header-icon):not(.card-header-text):not(.card-header-image) {
            border-radius: 3px;
            margin-top: -20px;
            padding: 8px !important;
        }
        /*#Outerdiv {
            overflow:auto;
        }*/
        .Outerdiv {
            overflow-y: auto;
        }

        /*.blankdiv:hover {
            overflow:auto;
        }*/


        #excelDataDivInner .dataTables_scrollHeadInner {
            display: none;
        }

        #excelDataDivInner .dataTables_sizing {
            height: 40px !important;
            font-weight: 100;
            /**/ /*text-align: center;*/
            margin-top: 0%;
        }

        #excelDataDivInner .dataTables_length {
            display: none;
        }

        #excelDataDivInner .dataTables_filter {
            display: none;
        }

        #excelDataDivInner .dataTables_scrollBody {
            width: 100% !important;
        }

        #excelDataDivInner .dataTables_info {
            margin-top: 8%;
        }

        #excelDataDivInner.dataTables_empty {
            text-align: center;
        }
        /*Added by kashish for Ui change*/
        .dataTables_scrollBody {
            height: 217px !important;
        }

        #countSubUSdown {
            float: right;
            margin-top: -35px;
            margin-right: -42px;
        }

        #DivSubTabIssuesList .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            border: 1px solid #ddd !important;
        }

        #DivReviewLis {
            margin-left: 0% !important;
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

        .note {
            color: red;
            margin-top: 17px;
            font-size: 12px !important;
            float: right;
        }
        /*.cards {
            position:fixed;
        }*/

        @media (max-width:991px) {
            .clsDiscussion {
                padding-bottom: 5% !important;
            }
        }


        /*Added By Ankush T on 22/05/2018*/


        #NewExcelUpload .btn-primary .btn-primary,
        .btn-primary {
            border: none !important;
            top: 0px;
        }

        #NewExcelUpload .table > thead > tr > th,
        .table > tbody > tr > th,
        .table > tfoot > tr > th,
        .table > thead > tr > td,
        .table > tbody > tr > td,
        .table > tfoot > tr > td {
            padding: 8px;
            line-height: 1.42857143;
            vertical-align: top;
            border-top: 1px solid white !important;
        }

        #lblstep {
            margin-top: -16px;
            font-weight: 100;
            color: #4b3b86;
            font-size: 17px;
        }

        #NewExcelUpload .input-group {
            width: 22% !important;
        }


        /*#NewExcelUpload .btn-info:hover, 
              .btn-info:focus, 
              .btn-info:active 
               {
                color: #fff!important;
                background-color: #00aec5 !important;
                border-color: #00aec5 !important;
               }*/

        /*#NewExcelUpload .btn-breadcrumb .btn.btn-info:after {
  border-left: 10px solid #225b96;
}
 #NewExcelUpload .btn-breadcrumb .btn.btn-info:before {
  border-left: 10px solid #225b96;
}*/

        #NewExcelUpload .btn-breadcrumb .btn.btn-info:hover:after {
            border-left: 13px solid #efeded;
        }

        #NewExcelUpload .btn-breadcrumb .btn.btn-info:hover:before {
            border-left: 13px solid #efeded;
        }
        /*#NewExcelUpload .btn-info
              .btn-info, 
              .btn-info
             {
                color: #fff!important;
                background-color:#00aec5 !important;
                border-color:#00aec5 !important;
             }*/
        /*.btn-breadcrumb .btn:after {
  content: " ";
  display: block;
  width: 0;
  height: 0;
  border-top: 17px solid transparent;
  border-bottom: 17px solid transparent;
  border-left: 10px solid #b0b3b7;
  position: absolute;
  top: 50%;
  margin-top: -17px;
  left: 100%;
  z-index: 3;
}*/

        .btn-breadcrumb .btn:after { /*first-child:*/
            content: " ";
            display: block;
            width: 0;
            height: 0;
            border-top: 17px solid transparent;
            border-bottom: 17px solid transparent;
            border-left: 13px solid #efeded;
            position: absolute;
            top: 50%;
            margin-top: -17px;
            margin-left: -1px;
            left: 100%;
            z-index: 3;
        }
        /*.btn-breadcrumb .btn:before {
  content: " ";
  display: block;
  width: 0;
  height: 0;
  border-top: 17px solid transparent;
  border-bottom: 17px solid transparent;
  border-left: 10px solid #225b96 !important;
  position: absolute;
  top: 50%;
  margin-top: -17px;
  margin-left: 1px;
  left: 100%;
  z-index: 3;
}*/

        #Exceluploadfile {
            margin-left: 0px !important;
            margin-top: 5px !important;
        }

        #NewExcelUpload label {
            display: inline-block;
            max-width: 100%;
            margin-bottom: 5px;
            font-weight: 100;
        }

        #astep1 {
            width: 33% !important;
            border: 0px solid #F5F1F1 !important;
        }

        #astepnew2 {
            width: 33% !important;
            border: 0px solid #F5F1F1 !important;
        }

        #astepnew3 {
            width: 33% !important;
            border: 0px solid #F5F1F1 !important;
        }

        #astep2 {
            background-color: #bbb6b6 !important;
            /*border-color: #bbb6b6 !important;*/
            width: 33% !important;
            margin-top: -3px !important;
        }

            #astep2:after {
                content: " ";
                display: block;
                width: 0;
                height: 0;
                border-top: 17px solid transparent;
                border-bottom: 17px solid transparent;
                border-left: 10px solid #bbb6b6 !important;
                position: absolute;
                top: 50%;
                margin-top: -17px;
                left: 100%;
                z-index: 3;
            }

            #astep2:hover:before {
                border-left: 10px solid #bbb6b6 !important;
            }

            #astep2:hover:after {
                border-left: 10px solid #bbb6b6 !important;
            }

        #astep3 {
            background-color: #bbb6b6 !important;
            /*border-color: #bbb6b6 !important;*/
            width: 33% !important;
            margin-top: -3px !important;
        }

            #astep3:after {
                content: " ";
                display: block;
                width: 0;
                height: 0;
                border-top: 17px solid transparent;
                border-bottom: 17px solid transparent;
                border-left: 10px solid #bbb6b6 !important;
                position: absolute;
                top: 50%;
                margin-top: -17px;
                left: 100%;
                z-index: 3;
            }

            #astep3:hover:before {
                border-left: 10px solid #bbb6b6 !important;
            }

            #astep3:hover:after {
                border-left: 10px solid #bbb6b6 !important;
            }

        #NewExcelUpload .btn.btn-info {
            text-transform: Capitalize !important;
            color: #fff !important;
            box-shadow: 0 0px 0px 0 rgb(255,255,255), 0 0px 0px -3px rgb(255,255,255), 0 0px 0px 0 rgb(255,255,255) !important;
            -webkit-box-shadow: 0 0px 0px 0 rgb(255,255,255), 0 0px 0px -3px rgb(255,255,255), 0 0px 0px 0 rgb(255,255,255) !important;
            -moz-box-shadow: 0 0px 0px 0 rgb(255,255,255), 0 0px 0px -3px rgb(255,255,255), 0 0px 0px 0 rgb(255,255,255) !important;
            /* box-shadow: 0 2px 2px 0 rgba(0,188,212,.14), 0 3px 1px -2px rgba(0,188,212,.2), 0 1px 5px 0 rgba(0,188,212,.12) !important; */
        }
        /*End of Added By Ankush T on 22/05/2018*/
        .clsValidRow td {
            text-align: center !important;
        }

        .clsInValidRow td {
            text-align: center !important;
        }
        /* Added By Ankush T on 06/06/2018 for history issue and review header color change*/
        #divhistoryList .clsTRColumnHeader tr {
            background-color: #fff !important;
        }

        #DivSubTabIssuesList .clsTRColumnHeader tr {
            background-color: #fff !important;
        }

        #DivReviewList .clsTRColumnHeader tr {
            background-color: #fff !important;
        }

        #DivReviewList tr td {
            text-align: center !important;
        }

        .Outerdiv {
            border: 1px solid #ddd !important;
        }
        /* End of Added By Ankush T on 06/06/2018 for history issue and review header color change*/

        /*Added By Ankush T on 08/06/2018 for Oldvalue and New value of userstory to be wrap*/
        #DivHistorykList table tr td:nth-child(1) {
            width: 15% !important;
        }

        #DivHistorykList table tr td:nth-child(2) {
            width: 15% !important;
        }

        #DivHistorykList table tr td:nth-child(3) {
            width: 15% !important;
        }

        #DivHistorykList table tr td:nth-child(4) {
            width: 30% !important;
        }

        #DivHistorykList table tr td:nth-child(5) {
            width: 30% !important;
        }
        /*End By Ankush T on 08/06/2018 for  Oldvalue and New value of userstory to be wrap*/

        /*Added by pradip on 6-10-2020*/
        /*.clsCategory{ background:#4263c1;}*/
        .HeaderFreeze {    right: 0;
    left: 0;
    z-index: 1030;
    background: #e5e5e5;
    padding: 12px;
    margin-top: 0px;
        }
        #divMain {margin-top:0px;}
        input#txtSearchPendingP {
    margin-top: 1px;
    border: none;
}
        /*End Added by pradip on 6-10-2020*/
        .modal-body .form-group{display:inline-flex}
        .fa, .fas {font-family: 'Font Awesome 5 Free'!important;}
        /*:not(.fa):not(small) {font-size: 14px;font-family: 'Font Awesome 5 Free'!important;}*/
        i.fas {font-family: 'Font Awesome 5 Free'!important;}
        /*.clsCategory label.addcategory {margin-top: -22px;}*/
        .modal-body .col-md-12, .modal-body .col-md-6{display:inline-flex}
        .modal-header{display:block}
        #btnFilter{background: white;margin-top: -2px;height: 26px;}
        .fas.fa-pencil-alt{float:left;margin-top:6px}
        .clsCategory {
    /* width: 100%; */
    padding: 6px!important;
    padding-left: 15px!important;
    padding-right: 15px!important;
    margin-bottom: 5px!important;
    background: linear-gradient(60deg,#26c6da,#00acc1);
    color: #fff !important;
    text-transform: capitalize;
    font-weight: 700;
    font-size: 11.5px !important;
    /* Modified By Madhuri.K On 26-03-2026 */
    top: -3px;
    box-shadow: 0 10px 16px rgb(0 0 0 / 9%), 0 5px 5px rgb(0 0 0 / 6%) !important;
    position: relative;
}
        .addcategory {margin-top: 2px;}
        .panel-footer {
    background-color: #fff !important;
    color: #808080 !important;
    padding: 7px 15px;
    min-height: 36px;
    border-bottom: 1px solid #f4f4f4;
    margin-top:33px
}
        .panel-footer {
    padding: 10px 15px;
    background-color: #f5f5f5;
    border-top: 1px solid #ddd;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
}
        .fa.fa-eye{color:#999;font-size:14px}
        /*.fa.fa-trash{font-size:14px}*/
        .fa.fa-filter{font-size:14px!important}

        /*added by Ashwini M on 24-3-2023*/
        .modal {overflow: auto;}
        #NewExcelUpload .modal-body .col-md-12, #NewExcelUpload .modal-body .col-md-6{display:block}
        #tblFieldList tr{border-style: hidden;}
        @media (min-width: 992px){#divProductBacklog  .modal-lg {max-width: 1000px !important;}}
        .label-warning {background-color: #f0ad4e;}
        .label {display: inline;padding: 0.2em 0.6em 0.3em;font-size: 75%;font-weight: 700;line-height: 1;color: #fff;text-align: center;white-space: nowrap;vertical-align: baseline;border-radius: 0.25em;}
        .fas.fa-trash-alt{font-size:14px;color: red;margin-left: 5px;}    
        #divUserStories .close{margin-top:-50px}
        #SprintBody .col-sm-6{display:flex;padding:0}
        .caret {display: inline-block;width: 0;height: 0;margin-left: 2px;vertical-align: middle;border-top: 4px solid;border-right: 4px solid transparent;border-left: 4px solid transparent;}
        /*End of added by Ashwini M on 24-3-2023*/
        
        #divUserStroryDetails .col-md-12, #divUserStroryDetails .col-md-6, #divSubstories .form-group{display:flex}
        #CreateSprint #HeaderCreate{color:#fff!important}
        #divProductBacklog #frmDetails .col-md-6{padding-left:25px;padding-right:0}

/*Added by pradip on 18-4-23*/
#ulTabs li{ padding:3px 7px !important;}
#divChart .nav-pills li.active a, #divChart .nav-pills li.active a:focus{ background:#428bca;}
#divChart .nav-pills  li a:focus, #divChart .nav-pills  li:focus a{ color:black!important;}
#divProductBacklog_Body label.col-md-4.control-label.labelcls {padding-left: 0;}

.divDraggable1 .clsCategory span.col-sm-7 {
    float: none;
    display: inline-flex;
    padding-left: 0;
}
.divDraggable1 .clsCategory label { 
    order: 2;
}
.divDraggable1 .clsCategory .fas.fa-pencil-alt {
    float: left;
    margin-top: 6px;
    order: 1; margin-right:10px;
}
/* Added By Gauri On 16th Sep 2024 For Alignment Issue */
#leftTree.table-bordered{
    border: none;
}
.btn-info.clsCategory{
    background: #01579B !important;
}
/* End of Added By Gauri On 16th Sep 2024 For Alignment Issue */

    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div id="divMain">
            <%CommonFunctions.General.WriteHTML(objClsCommon.PlotHeader("Product Backlog"))%>
            <div id="divGrid">
                <%CommonFunctions.General.WriteHTML(PlotGrid())%>
            </div>
        </div>
        <%--    <select id="multi-select-demo" multiple="multiple">
            <option value="jQuery">jQuery tutorial</option>
            <option value="Bootstrap">Bootstrap Tips</option>
            <option value="HTML">HTML</option>
            <option value="CSS">CSS tricks</option>
            <option value="angular">Angular JS</option>
    </select>--%>

        <div class="modal fade" id="CreateSprint" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <%--    /*Added by kashish for Ui change*/--%>
                        <button type="button" class="close" data-bs-dismiss="modal" title="close" data-bs-toggle='tooltip' data-bs-placement='top'>&times;</button>
                        <h5 class="modal-title" style="color: maroon;" id="HeaderCreate"></h5>



                    </div>
                    <div class="modal-body" id="SprintBody">
                    </div>
                    <div class="col-md-12 align-center">
                        <%-- <button type="button" class="btn btn-primary" onclick="SaveSprint()" id="Button5" title="Save">Save</button>--%>
                    </div>
                    <%--    /*commented by kashish for Ui change*/--%>
                    <%-- <div class="modal-footer">--%>
                    <%-- <button type="button" class="btn btn-primary" onclick="SaveSprint()" id="Button5" title="Save">Save</button>--%>
                    <%--  </div>--%>
                </div>
            </div>
        </div>
        <%--    /*Added by kashish for Ui change*/--%>
        <div class="modal fade" id="ExcelUpload" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" style="width: 100%" role="document">
                <div class="modal-content" style="border: none">
                    <%--    /*Added by kashish for Ui change*/--%>
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title" style="color: maroon;" id="H2">Excel Upload</h5>



                    </div>
                    <%--    /*commented by kashish for Ui change*/--%>
                    <%-- <div class="modal-header" style="background-color: white; color: black">
                        <div class="col-sm-4">
                            <h5 style="color: black;" id="H1">Excel Upload</h5>
                        </div>

                        <div class="col-sm-8">
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="close modal " data-bs-toggle='tooltip'>
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>--%>
                    <div class="modal-body" id="ExcelUploadProductBacklock" style="overflow-y: auto; height: 603px;">
                    </div>
                    <div id='modalFooter' class='modal-footer'>
                        <button type='button' onclick='UploadFile_Click(this);' data-bs-toggle='tooltip' title='Upload Data' class='btn btn-primary mr-auto'>Upload Data</button>
                        <button type='button' class='btn btn-secondary' data-bs-toggle='tooltip' title='Cancel Upload' data-bs-dismiss='modal'>Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="DivSprintlist" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="border-radius: 10px;">
                    <div class="modal-header" style="background-color: white; color: gray; height: 70px; padding: 15px; border-radius: 12px">
                        <h5 style="float: left;" id="Idheader">Map to sprint</h5>
                        <%--<input type='text' name='table_search' id='txtSearchSprint' class='txtBox form-control float-end' placeholder='Search' /><button type='button' class='btn btn-default'><i class='fa fa-search'></i></button>--%>
                        <div class="search-container" style="text-align: right; margin-right: 57px;">
                            <input type="text" id="txtSprintSearch" placeholder="Search.." name="search" style="width: 255px; height: 36px;" />
                            <i class="fa fa-search"></i>
                        </div>
                        <a class="close" data-bs-dismiss="modal" style="padding: 10px; padding-right: 0px;"><i class="fa fa-close" style="color: black!important; margin-top: 10px; font-size: 17px;" data-original-title="" title=""></i></a>
                    </div>
                    <%--<div class="modal-header">
                              <button type="button" class="close" style="font-weight:bold;" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                             <h5 class="modal-title" style="color: maroon;" id="Idheader"></h5>                                                     
                        </div>--%>
                    <div class="modal-body" id="divListdetails">
                    </div>
                    <div class="modal-footer" style="margin-right: 7px; background-color: white; margin-bottom: 13px; border-radius: 10px;">
                        <%-- <button type="button" class="btn btn-primary" id="SelectSprint" onclick="MappedSprint()" title="Save">Select</button>--%>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal" tabindex="-1" role="dialog" id="AddCategory">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Category</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle='tooltip' data-bs-placement='top'>
                            &times;
                        </button>
                    </div>
                    <div class="modal-body" id="AddCategoryBody">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" onclick="SaveCategory()" title="Save" data-bs-toggle='tooltip' data-bs-placement='top' style="margin-top: 30px;">Save</button>
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal" title="Close" data-bs-toggle='tooltip' data-bs-placement='top' style="margin-top: 30px;">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <%--Added By Ankush T on 22/05/2018--%>
        <div class="modal fade" id="NewExcelUpload" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" style="width: 80%" role="document">
                <div class="modal-content" style="border: none;">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal" onclick="clearuploadFile()">&times;</button>
                        <h5 class="modal-title" style="color: maroon;" id="H1">Product Backlog Excel Upload</h5>
                        <%--<label for="clslbl" id="lblstep" style="float:right !important;"></label>--%>
                    </div>


                    <div class="modal-body" id="ExcelUploadNew" style="overflow-y: auto; height: auto">
                    </div>
                    <div id='Div3' class='modal-footer'>
                        <%-- <button type='button' onclick='UploadFile_Click(this);' data-bs-toggle='tooltip' title='Upload Data' class='btn btn-primary mr-auto'>Upload Data</button>
                        <button type='button' class='btn btn-secondary' data-bs-toggle='tooltip' title='Cancel Upload' data-bs-dismiss='modal'>Cancel</button>--%>
                    </div>
                </div>
            </div>
        </div>
        <%--End of Added By Ankush T on 22/05/2018--%>
    </form>

    <script>
        //Added 
        var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'

        //Added By Riddhesh Patil on 22/12/2022
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
//End of Added By Riddhesh Patil on 22/12/2022

        $("#idfilter1").tooltip();
        //added by swapna
        function MoreDetailOnClick(UserStoryId) {

            window.location.href = "../Agile/UserStoryDetails.aspx?UserStoryId=" + UserStoryId;
        }
        //end by swapna
        //$('#demo').multiselect();
        $(".FixedTD").css("top", "0px")
        $("#DivList").scroll(function () {
            $(".FixedTD").css("top", $("#DivList1").scrollTop() - 1);
        });
        $(".Outerdiv").css("height", window.innerHeight - 220 + 'px');
        $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
        $(".adjustheight").css("height", window.innerHeight - 220 + 'px');

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
        $(".view").tooltip();
        $(".user-story-description").tooltip();
        $(".fa-ellipsis-h").tooltip();


        //$('[data-bs-toggle="tooltip"]').tooltip({
        //    position: fixed
        //});

        $('#listSprint').on('click', function (e) {
            e.stopPropagation();
        });
        $('#listRelease').on('click', function (e) {
            e.stopPropagation();
        });
        //window.onload = function () {
        //    //RemoveFrameLoader();
        //    $(".Outerdiv").css("height", window.innerHeight - 150 + 'px');
        //}

         $(document).on("load",function () {
            //RemoveFrameLoader();
            $(".Outerdiv").css("height", window.innerHeight - 150 + 'px');
        });
        //Added  For Excel uplaod Functionality
        function USField_OnChange(FieldID) {
            var objcboUSField = document.getElementById("cboUSField_" + FieldID);
            var objspnUSField = document.getElementById("spnUSField_" + FieldID);

            if (objcboUSField.value == "Priority") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Priority should be in 'Must Have','Should Have','Could Have','Wont Have' only in excel ", 'error', 10)
            }
            else {
                $("#spnUSField_" + FieldID).text("");
            }
        }


        var PBFile;
        function CreateDropZone() {
            //   alert("dsf")
            makeDroppable(window.document.querySelector('#divDropZone'), function (files) {
                //console.log(files);
                var output = window.document.querySelector('#divDropZone');

                output.innerHTML = '';
                output.innerHTML += '<p>' + files[0].name + '</p>';

                PBFile = files[0];
                //for (var i = 0; i < files.length; i++) {
                //    //if (files[i].type.indexOf('image/') === 0) {
                //    //    output.innerHTML += '<img width="200" src="' + URL.createObjectURL(files[i]) + '" />';
                //    //}
                //    output.innerHTML += '<p>' + files[i].name + '</p>';
                //}
                var flag = 0;
                console.log(PBFile)
                //this.reset();
                //return false;

                //$(arrFiles).each(function(ind,val){
                //    if (arrFiles[ind].id == id){
                //        arrFiles[ind].file = files;
                //        flag = 1;
                //    } 
                //})
                //if (flag == 0){
                //    arrFiles.push({"id" :  id,file : files })
                //}
            })
        }

        function ProcessFile_Click(object) {

            var strURL = "frmProductBacklog.aspx";
            var formData = new FormData();
            formData.append('File', PBFile);
            formData.append('Mode', 'ProcessFile');
            if (PBFile != undefined) {
                if (PBFile.name.indexOf(".xls") > 0 || PBFile.name.indexOf(".xlsx") > 0) {
                    $.ajax({
                        //Server script to process data
                        type: 'POST',
                        url: 'frmProductBacklog.aspx',
                        data: formData,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            $('#ExcelUploadProductBacklock').html(result);
                            // if ($('tr.clsValidRow ').length <= 0) {
                            var flag = 0;
                            $(".chkUS").each(function () {
                                // debugger;
                                var $this = $(this);
                                if ($this.is(":checked")) {
                                    flag = 1;
                                }
                            });

                            if (flag == 1) {
                                // $("#modalFooter button.btn-primary").prop('disabled', 'false');
                                $("#modalFooter button.btn-primary").removeAttr("disabled")
                            }
                            else {
                                $("#modalFooter button.btn-primary").prop('disabled', 'true');
                                // $("#modalFooter button.btn-primary").addAttr("disabled")
                                //}
                                //    
                                // $("#modalFooter button.btn-primary").prop('disabled', 'true');
                            }

                            $('#modalFooter').show();

                            var intDivHeight;

                            //if (WhichBrowser() == 'IE') {
                            //    intDivHeight = window.innerHeight - ($('#excelDataDivInner').offset().top * 2.5) + 30;
                            //}
                            //else {
                            //    intDivHeight = window.innerHeight - ($('#excelDataDivInner').offset().top * 2.5) + 10;
                            //}

                            datatablesExcelUpload('excelDataDivInner', 'txtSearchExcelData', intDivHeight);

                            //$('.clsInValidRow').css('color','red');
                            //$('.clsValidRow').css('color','green');
                        },

                    });
                }
                else {
                    // alert("Only excel files are allowed.");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Only excel files are allowed.', 'error');
                }
            }

        }
        function SaveConfiguration(object) {

            var k;
            var strMsg = "";
            var IsPriorityPresent = 0;
            var IsDescriptionPresent = 0;
            var IsUSNamePresent = 0;
            var arrPBFields = [];
            var arrExcelFields1 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
            var arrExcelFields = [];

            for (k = 1; k <= 12; k++) {
                var objcboUSField = document.getElementById("cboUSField_" + k);

                if (objcboUSField != null) {

                    arrPBFields.push(objcboUSField.value);
                    arrExcelFields.push(arrExcelFields1[k - 1]);

                    if (objcboUSField.value == "Priority") {
                        IsPriorityPresent = 1;
                    }

                    if (objcboUSField.value == "Description") {
                        IsDescriptionPresent = 1;
                    }

                    if (objcboUSField.value == "UserStoryName") {
                        IsUSNamePresent = 1;
                    }
                }
            }

            if (IsPriorityPresent == 0)
                strMsg += "Priority,";

            if (IsDescriptionPresent == 0)
                strMsg += "Description,";

            if (IsUSNamePresent == 0)
                strMsg += "UserStoryName,";

            strMsg = strMsg.substr(0, strMsg.length - 1);

            if (strMsg != "") {
                strMsg += " fields are mandatory."
                //commented & added By Diplali V On 9th April Excel Upload
                //  $('#spnCommonAlert').text(strMsg);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strMsg, 'error');
                //End of commented & added By Diplali V On 9th April Excel Upload
                return;
            }
            else {
                // $('#spnCommonAlert').text("");
                // alertify.set('notifier', 'position', 'top-right');
                // alertify.notify("", 'error');

            }

            var data = JSON.stringify({ arrPBFields: arrPBFields, arrExcelFields: arrExcelFields });
            var strResult = AJAXCallWithResult("frmProductBacklog.aspx/SaveExcelConfiguration", data, false);

            if (strResult.d == "1") {
                //commented & added By Diplali V On 9th April Excel Upload  
                //  $('#spnCommonAlert').text("Saved Successfully");
                // $('#spnCommonAlert').css("color", "green");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Details Saved Successfully", 'success');
                //End of commented & added By Diplali V On 9th April Excel Upload
                ExcelUploadClick();
            }

        }
        function ValidateConfigFields() {
            var k;
            var strMsg = "";
            var IsPriorityPresent = 0;
            var IsDescriptionPresent = 0;
            var IsUSNamePresent = 0;
            var arrPBFields = [];
            var arrExcelFields1 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
            var arrExcelFields = [];

            for (k = 1; k <= 12; k++) {
                var objcboUSField = document.getElementById("cboUSField_" + k);

                if (objcboUSField != null) {

                    arrPBFields.push(objcboUSField.value);
                    arrExcelFields.push(arrExcelFields1[k - 1]);

                    if (objcboUSField.value == "Priority") {
                        IsPriorityPresent = 1;
                    }

                    if (objcboUSField.value == "Description") {
                        IsDescriptionPresent = 1;
                    }

                    if (objcboUSField.value == "UserStoryName") {
                        IsUSNamePresent = 1;
                    }
                }
            }

            if (IsPriorityPresent == 0)
                strMsg += "Priority,";

            if (IsDescriptionPresent == 0)
                strMsg += "Description,";

            if (IsUSNamePresent == 0)
                strMsg += "UserStoryName,";

            strMsg = strMsg.substr(0, strMsg.length - 1);

            if (strMsg != "") {
                strMsg += " fields are mandatory."
                //commented & added By Diplali V On 9th April Excel Upload
                //  $('#spnCommonAlert').text(strMsg);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strMsg, 'error');
                //End of commented & added By Diplali V On 9th April Excel Upload
                return false;
            }
            else {
                $('#spnCommonAlert').text("");
            }
        }

        function UploadFile_Click(object) {
            if ($("#hdnIschecklimit").val() != 1) {
                var AttachmentID = document.getElementById("hdnAttachmentID").value;

                var data = JSON.stringify({ AttachmentID: AttachmentID });
                var strResult = AJAXCallWithResult("frmProductBacklog.aspx/UploadDataExcel", data, false);

                var finalResult = strResult.d.split("||");
                // alert(finalResult[0]);
                // alert(finalResult[1]);
                if (finalResult[0] == "1") {
                    $("[data-bs-dismiss=modal]").trigger({ type: "click" });
                }
                //alert($("#hdnIschecklimit").val());
                document.getElementById("divGrid").innerHTML = finalResult[1];
                $("#divMain").css("height", window.innerHeight - 12 + 'px');
                $(".Outerdiv").css("height", window.innerHeight - 220 + 'px');
                $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
                $(".adjustheight").css("height", window.innerHeight - 220 + 'px');

                $(".Main").css("width", (((window.innerWidth / 3) - 30) * $(".divDraggable1").length) + 'px');

                if ($(window).width() > 768) {
                    $(".divDraggable1").css("min-height", window.innerHeight - 80 + 'px');
                    $(".divDraggable1").css("height", '100%');
                    $(".divDraggable1").css("width", (window.innerWidth / 3) - 35 + 'px');
                }
                else {
                    $(".divDraggable1").css("min-height", '');
                    $(".divDraggable1").css("height", '');
                    $(".Main").css("height", '');
                    $(".divDraggable1").css("width", '100%');
                }
                SetWidthHeight();
            }
            else {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Max 100  user stroies you can upload at a time ", 'error');

            }
        }

        function ExcelUploadClick() {

            var ProjectID = '<%=Session("intProjectID")%>';
            var data = JSON.stringify({ ProjectID: ProjectID });
            var strResult = AJAXCallWithResult("frmProductBacklog.aspx/GetExcelUploadDiv", data, false);

            if (strResult.d != "") {
                $('#ExcelUploadProductBacklock').html(strResult.d);
                CreateDropZone();
            }
        }

        function ExcelUploadonclick() {
            // alert("asd")
            if ($("#hdnCheckFileExistornot").val() == "1") {
                ExcelUploadClick();

            }
            else {
                //  alertify.set('notifier', 'position', 'top-right');
                // alertify.notify("Please Fill the all Mandatory fileds", 'error');
            }

        }
        function datatables_1(divID, pagelen, height) {

            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' > table').addClass("table table-striped");
            $('#' + divID + ' > table').css("border", "1px solid #DDD");

            var table = $('#' + divID + ' > table').DataTable({
                responsive: true, "pageLength": pagelen,
                scrollY: height + 'px',
                scrollX: true,
                ordering: false,
                pagingType: "simple_numbers",
                language: {
                    paginate: {
                        next: '<i class="fa fa-angle-double-right"></i>',
                        previous: '<i class="fa fa-angle-double-left"></i>'
                    }
                },
            });


            $('#txtSearchExcelData').keyup(function () {
                table.search($(this).val()).draw();
            })
        }

        function ClearConfiguration() {

            var data = JSON.stringify({});

            var strResult = AJAXCallWithResult("frmProductBacklog.aspx/ClearExcelConfiguration", data, false);

            if (strResult.d == "1")
                ExcelUploadClick();
        }
        function DownloadFile(strFileName) {
            window.open("../General/ViewAttachment.aspx?FromWhere=Documents&FileName=" + strFileName);
        }
        //End of Added  For Excel uplaod Functionality

        // Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
        function getInputDateFormatValue() {
            return '<%=strInputFormat %>';
        }
        // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

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


        $("#divChart #myScrollspy .nav-pills li").removeAttr("style");

    </script>



</body>
</html>



