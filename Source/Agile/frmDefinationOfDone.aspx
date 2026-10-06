<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmDefinationOfDone.aspx.vb" Inherits="PbNIT.frmDefinationOfDone" %>

<!DOCTYPE html>

<html>

<head runat="server">
    <title>Defination Of Done</title>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
    <meta name='vs_defaultClientScript' content='JavaScript'>
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Pragma" content="no-cache">
    <%CommonFunctions.General.PlotPageHeadTag("DOD")%>

     <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--  
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/font.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />


    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>  
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />
    <script src="js/resize.js"></script>


</head>
    <style>

    body {
    font-family: 'Roboto', sans-serif!important;
   /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
    font-size:11.5px!important
}
    /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
.btn{font-size:11.5px!important}
    .modal-header {
    min-height: 16.43px;
    padding: 15px;
    border-bottom: 1px solid #e5e5e5!important;
}
    .modal-title {
        line-height: 2.42857 !important;
    font-size: 14px !important;
    /* Modified By Madhuri.K On 01-04-2026 */
    color: rgb(128, 128, 128) !important;
    text-align: center !important;
    display: inherit !important;
    margin: 0px !important;
    }
    checkbox input[type=checkbox], .checkbox-inline input[type=checkbox], .radio input[type=radio], .radio-inline input[type=radio] {
        position: relative !important;
        margin: 4px !important;
    }

    #DivGridShowHistory .table th:nth-child(4), #DivGridShowHistory .table td:nth-child(4), #DivGridShowHistory .table th:nth-child(5), #DivGridShowHistory .table td:nth-child(5) {
        width: 130px;
        word-break: break-all;
    }

    ::-webkit-scrollbar {
        display: none;
    }

    textarea {
        overflow-y: auto !important;
        -ms-overflow-style: none;
        overflow: -moz-scrollbars-none;
        padding-bottom: 16px !important;
        outline: none;
        border-bottom: 1px solid #ddd;
        border-top-color: transparent;
        border-left-color: transparent;
        border-right-color: transparent;
        width: 440px !important;
        border-radius: 5px;
        padding-bottom: 15px !important;
    }

    .post-title-line {
        height: 1px;
        border: 0.1px solid #bbb;
        margin-top: -5px;
        margin-bottom: 10px;
    }

    .btn-primary {
        color: #fff !important;
        background-color: #337ab7 !important;
        border-color: #2e6da4 !important;
    }

        .btn-primary:hover {
            color: #fff !important;
            background-color: #337ab7 !important;
            border-color: #2e6da4 !important;
        }
    /*.nav-tabs > li.active > a {
border-top-color: transparent!important;
  
    border-left-color: transparent!important;

        }*/
    .col-sm-6 {
        width: auto !important;
    }

    .complete {
        display: none;
    }

    .card-block {
        padding: 6px !important;
    }

    .v-tabs .tabcontent {
        float: left;
        padding: 0;
        border-style: solid;
        border-color: #647ea8;
        border-width: 0px 0px 0px 0px !important;
        width: 100%;
        border-left: none;
        height: 1214px;
    }


    input.form-control:not([type=button]) {
        width: 495px !important;
        height: 40px !important;
        margin-left: 62px;
    }

    hr {
        margin-top: -5px !important;
    }

    .vl {
        border-left: 1px solid #cccccc;
        /*height: 424px;*/
        position: absolute;
        left: 50%;
        margin-left: -3px;
        top: 63px;
    }
    /*Added by Yasmin on 7th May*/
    .ClsPageheader {
       color: #292828;
        font-weight: 500;
       /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size: 14px;
        margin-left: 41px;
        margin-top: 5px;
    }
    .fixed-top {
        position: fixed !important;
        right: 0;
        left: 0;
        z-index: 1030;
        /* Changed by Madhuri.K on 09-03-2026 */
         background: #F8FAFC;
        /* background: #e7edf0; modified by pradip on 6-10-2020 */
        padding: 10px;
    }

    @media only screen and (max-width: 1024px) {
        .vl {
            display: none !important;
        }
    }
    /*@media only screen and (max-width: 1024px) {
    .container  {
    max-width: 540px!important;
    }
}*/
    .btn:hover {
        color: white !important;
    }

    .btn-lg {
        padding: 6px !important;
    }

    .text_items {
        color: grey;
        font-weight: 600;
    }

    .anotherText_items {
        color: grey;
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size: 11.5px;
    }

    .btn-default {
        /*width: 60%!important;*/
        /*color: #808080!important;*/
        /*background-color: #ddd!important;*/
        /*border-color: #5cb85c!important;*/
        border-radius: 3px !important;
        /*float:right;*/
    }

        .btn-default:hover {
            /*width: 60%!important;*/
            /*color: #808080!important;
    background-color: #ddd!important;*/
            /*border-color: #5cb85c!important;*/
            border-radius: 3px !important;
            /*float:right;*/
        }

    .checkbox-inline input[type=checkbox] {
        position: initial !important;
    }

    .nav-tabs > li > a.active {
        cursor: default;
        background-color: #ffffff;
        border: 1px solid #ddd;
        border-bottom-color: transparent;
        color: #4caac0 !important;
        text-decoration: underline;
    }

    .nav-tabs > li > a {
        margin-right: 2px;
        line-height: 1.42857143;
        border: 1px solid transparent;
        border-radius: 4px 4px 0 0;
    }

    .nav > li > a {
        position: relative;
        display: block;
        padding: 10px 15px;
        font-weight: 600;
        color: grey;
       /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size: 11.5px;
    }
    /*li a {
         font-weight: 600;
         color: grey;
         font-size: 13px;
      }*/
    .imgcontainer {
        text-align: left;
        position: relative;
        /*background: #398439;*/
        border: 1px solid #ddd;
        color: #fff;
        height: 34px;
        padding: 1% !important;
    }

    .modal-content {
        /*margin-left: -22%;*/
        /* margin-right: 10%; */
        /*height: 450px;*/
        /* margin-top: 3%; */
        width: 710px;
        position: absolute;
    }

    .close {
        float: right;
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size: 18px;
        font-weight: 700;
        line-height: 1;
        color: #ddd !important;
        text-shadow: 0 1px 0 #fff;
        filter: alpha(opacity=20);
        opacity: 1.2 !important;
        /*padding: 1% !important;*/
    }

    #ShowErrorMSG {
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size: 11.5px;
        font-weight: 100;
        text-align: center;
    }

     #ShowCount {
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size: 11.5px;
        font-weight: 500;
        color: #887d7d !important;
        float: right;
        margin-right: 55px;
        margin-top: -10px;
    }

    .clstxtArea {
        border: none !important;
        border-bottom: 1px solid #ddd !important;
    }

    #btnSave {
        /*width: 14%!important;*/
        /*color: #808080!important;
        background-color: #ddd!important;*/
        /*border-color: #5cb85c!important;*/
        border-radius: 3px !important;
        float: right;
        margin-top: -6%;
        margin-right: 5px;
    }

    #btnHistory {
        /*width: 19%!important;*/
        /*color: #808080!important;
        background-color: #ddd!important;*/
        /*border-color: #5cb85c!important;*/
        border-radius: 3px !important;
        float: right;
        margin-top: -6%;
        margin-right: 1%;
    }

    #IdheaderCustom {
        color: #808080 !important;
    }

    #Idheader {
        color: #808080 !important;
    }

    #tableAddRow {
        width: 98%;
        margin-left: 2%;
        /*margin-top: 2%;*/
    }

    #tableAddRowDodolist {
        width: 90%;
        margin-left: 2%;
        margin-top: 2%;
    }

    #tableAddRowInprocessDone {
        width: 90%;
        margin-left: 2%;
        margin-top: 2%;
    }

    #tableAddRowInprocess {
        width: 90%;
        margin-left: 2%;
        margin-top: 2%;
    }

    /*#divRightSection .col-sm-3 {
             width:28%!important;
         }*/

    #divRightSection .col-sm-2 {
        width: 25% !important;
    }

    #DivShowHistory {
        position: relative;
        overflow: auto;
        width: 100%;
        margin-top: 1%;
        height: 430PX;
        overflow-x: hidden;
        margin-left: 1%;
        font-weight: 100 !important;
        /*white-space:pre-wrap;*/
        /*word-break:break-all;*/
    }
    /*.btn-default:hover {
         color:black!important;
         background-color:white!important;
     }*/
    #DivGridShowHistory {
        margin-top: -4%;
    }

        #DivGridShowHistory table tr th {
            font-weight: 100 !important;
        }

            #DivGridShowHistory table tr th .dataTables_sizing {
                height: 36px !important;
            }

        #DivGridShowHistory .dataTables_scrollHead {
            /*height:36px;*/
            font-weight: 100;
        }

        #DivGridShowHistory .dataTables_length {
            display: none;
        }

        #DivGridShowHistory .dataTables_filter {
            display: none;
        }

        #DivGridShowHistory .paging_simple_numbers {
            float: right;
        }



    #DivCustomStage .form-control {
        width: 200px !important;
        height: 31px !important;
        margin-left: 0px !important;
    }

    #btnSaveUpdate {
        float: right;
        margin-right: 60px;
    }

    #SpnTitle {
        color: #808080 !important;
    }

    #DivSprint {
        margin-top: 2%;
    }

        #DivSprint table tr th {
            font-weight: 100 !important;
        }

    #DivRelease table tr th {
        font-weight: 100 !important;
    }

        #DivRelease table tr th:nth-child(5) {
            text-align: center;
        }

    #DivSprint table tr th:nth-child(5) {
        text-align: center;
    }


    #DivRelease {
        margin-top: 2%;
    }

    #btnAdd {
        float: right;
    }

    #lblDescri {
        margin-top: 6%;
    }

    #DivDescri {
        margin-top: -5%;
    }

    .modal-footer {
        border-top: 1px solid white !important;
    }



    .NewCard {
        text-align: center;
    }

    .clstable {
        width: 100%;
    }

        .clstable table tr td:nth-child(1) {
            width: 5%;
        }

        .clstable table tr td:nth-child(1) {
            width: 95%;
        }

    #DivGridShowHistory .dataTables_scrollHeadInner table tr th {
        display: none !important;
    }

    #DivGridShowHistory .dataTables_scrollBody table thread tr th {
        height: 50px !important;
    }

    #DivGridShowHistory .dataTables_scrollBody table tr {
        height: 50px !important;
    }

    #DivGridShowHistory .dataTables_paginate {
        float: right;
    }

    #DivGridShowHistory .dataTables_info {
        margin-top: 9%;
    }

    .odd {
        background-color: #f7f7f7;
    }

    .even {
        background-color: white;
    }

    .odd:hover {
        background-color: #f7f7f7;
    }

    .even:hover {
        background-color: white;
    }

    /*#DivCustomStage .table-bordered > tbody > tr > td {
         border:none!important;
     }*/

    #DivRelaseSprint .modal-body {
        margin-top: -3%;
    }

    #DivRelaseSprint .modal-header .close {
        margin-right: -63%;
    }

    /*.fa-chevron-down::after {
        font-family: 'Glyphicons Halflings';
        content: "\e114"!important;
        float: right!important;
        transition: all 0.5s!important;
        rotation:180deg;
}*/
    #DivWholedata {
        overflow: auto;
        width: 102%;
    }
    /*Ui CHange done by Yasmin on 2nd may 2018*/
    #OuterDiv {
        width: 100%;
        overflow: hidden;
    }

    #txtDescription {
        /*height: 166px;*/
        overflow: hidden;
    }

    .pagination > li > a:hover {
        color: #fff !important;
        text-decoration: none;
        background-color: #1bb4c7 !important;
        border: none !important;
        border-radius: 20px;
    }


    .page-item.active .page-link {
        z-index: 1;
        color: #fff;
        background-color: #1bb4c7 !important;
        border-color: #1bb4c7 !important;
        border-radius: 20px !important;
         padding: 6px 10px;
    }

    .pagination > li > a, .pagination > li > span {
        position: relative;
        float: left;
        padding: 6px 12px;
        margin-left: -1px;
        line-height: 1.42857143;
        color: #1bb4c7;
        text-decoration: none;
        background-color: #fff;
        border: none !important;
    }
    .pagination > a, .pagination > a:hover, .pagination > a:focus {
        z-index: 2;
        color: #fff!important;
        cursor: default;
        background-color: #1bb4c7!important;
        border-color: #1bb4c7!important;
    }


    :focus {
        outline: none!important;
    }

    .pagination > li:first-child > a, .pagination > li:last-child > a {
        border-radius: 20px!important;
    }
    .table-bordered>:not(caption)>*>*{border-color:#ddd}
    .paginate_button {
        text-decoration:none
    }
    .paginate_button.current {
        z-index: 1;
        color: #fff;
        background-color: #1bb4c7 !important;
        border-color: #1bb4c7 !important;
        border-radius: 20px !important;
         padding: 6px 10px;
    }
    #DivGridShowHistory .dataTables_paginate a {
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        font-size:11.5px; margin-right:10px
    }
    #DivGridShowHistory .dataTables_paginate a:hover {
    color: #fff !important;
    text-decoration: none;
    background-color: #1bb4c7 !important;
    border: none !important;
    border-radius: 20px;
    padding: 6px 10px;
    margin-right:10px
}
</style>
<body>
    <form id="frmDOD" runat="server">
        <div id="OuterDiv">
            <%DefinitionOfDone("Load")%>
        </div>

    </form>

    <%--<div id="DivRelaseSprint" class="modal fade in"  data-keyboard="false" data-backdrop="static" tabindex="-1">
           <form class="modal-content animate " action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title" id="SpnTitle"></span>
                    <span  class="close" title="Close Modal" data-bs-dismiss="modal" aria-label="Close">&times;</span>

                </div>
                <div class="container-fluid" id="GetData">
                </div>
                <div class="col-sm-12">
                   <button type="button" class="btn btn-default" onclick="SaveReleaseSprint()" id="btnAdd">Add</button>
                </div>
         </form>
    </div>--%>


    <div class="modal fade" id="DivRelaseSprint" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="col-sm-11">
                        <h5 class="modal-title" style="color: maroon;" id="SpnTitle"></h5>
                    </div>
                    <div class="col-sm-1">
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle='tooltip' data-bs-placement='bottom'>
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <div class="modal-body" id="GetData">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="SaveReleaseSprint()" id="btnAdd" title="Add" data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-plus'></i>Add</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="DivShowhistory" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="col-sm-11">
                        <h5 class="modal-title" style="color: maroon;" id="Idheader"></h5>
                    </div>
                    <div class="col-sm-1">
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle='tooltip' data-bs-placement='bottom'>
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <div class="modal-body" id="GetShowhistory">
                </div>
                <div class="modal-footer">
                    <%-- <button type="button" class="btn btn-default" onclick="SaveReleaseSprint()" id="Button2">Add</button>--%>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="DivCustomStage" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="col-sm-11">
                        <h5 class="modal-title" style="color: maroon;" id="IdheaderCustom"></h5>
                    </div>
                    <div class="col-sm-1">
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="Close" data-bs-toggle='tooltip' data-bs-placement='bottom'>
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <div class="modal-body" id="divStages">
                    <table class="table table-bordered table-hover" id="table1">
                        <tbody>
                            <tr id="tr_0">
                                <td><span class="glyphicon glyphicon-plus addBtn" id="addBtnRemove_0" style="color: #3c8dbc!important"></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="SaveCustomStages()" id="btnsave" title="Save" data-bs-toggle='tooltip' data-bs-placement='bottom'>Save</button>
                </div>

            </div>
        </div>
    </div>


</body>
</html>
<script>
    $('[data-bs-toggle="tooltip"]').click(function () {
                  $('.tooltip ').removeClass("in");

        });
    //AutoResizeTextArea();
    //$('textarea').each(function () {
    //    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
    //}).on('input', function () {
    //    this.style.height = 'auto';
    //    this.style.height = (this.scrollHeight) + 'px';
    //});
    getRows();
    AutoResizeTextArea();
    RemoveTextArea();

    var intDivGridListHeight;
    $(document).ready(function () {

        //$('textarea').each(function () {
        //    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
        //}).on('input', function () {
        //    this.style.height = 'auto';
        //    this.style.height = (this.scrollHeight) + 'px';
        //});

        $("#txtDescription").css("height", "auto!important");
        getRows();
        AutoResizeTextArea();
        RemoveTextArea();
        // getRows();
        //RemoveTextArea();
        //autosize(document.querySelectorAll('textarea'));
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('.fa-chevron-down').tooltip();

        intDivGridListHeight = parseInt(window.innerHeight);
        //$(".vl").css('height', intDivGridListHeight + 350 + 'px')//Commented By Dipali V On 11th May 2023 
        $(".setheight").css('height', intDivGridListHeight + 100 + 'px')

        $("#DivWholedata").css('height', intDivGridListHeight + 'px')

        $("#inlineUSDoneNA").parent().css("display", "none");
        $("#inlineSprintNA").parent().css("display", "none");
    });

    //For Change Function On tab Click
    function Tab_Onclick(evt, TabName) {
        // debugger;
        if (TabName == "Sprint") {

            PlotTabSection("Sprint");

        }
        else if (TabName == "Release") {

            PlotTabSection("Release");
        }
    }

    //For Ploting Tab(Sprint/Release)
    var Mode = "";
    function PlotTabSection(Flag) {
        // alert(Flag);
        Mode = Flag;
        var strResult, data;
        data = JSON.stringify({ Flag: Flag });
        strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/PlotSubtab", data, false);

        if (strResult.d != '') {
            //  var Result = strResult.d.split("||")
            // alert(strResult.d);
            $("#divRightSection").html("");
            $("#divRightSection").html(strResult.d);

            if (Mode == "Sprint") {
                $("#Idfirstli").addClass('active')
                $("#Idsecli").removeClass('active')


            }
            else {

                $("#Idsecli").addClass('active')
                $("#Idfirstli").removeClass('active')
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-chevron-down').tooltip();
        }

        intDivGridListHeight = parseInt(window.innerHeight);
        $(".vl").css('height', intDivGridListHeight + 350 + 'px')
        $(".setheight").css('height', intDivGridListHeight + 100 + 'px')
        $("#DivWholedata").css('height', intDivGridListHeight + 'px')
    }

    //For Add Sprint
    var selectedFlag = "";
    function AddSprintRelease(Flag) {

        // alert(Flag);
        selectedFlag = Flag;
        // $(".card-block p").tooltip();
        var ProjectID = document.getElementById('hdnProjectID').value;
        if (Flag == "Sprint") {
            $("#SpnTitle").html("Add Sprint");
        }
        else {
            $("#SpnTitle").html("Add Release");
        }

        data = JSON.stringify({ Flag: Flag, ProjectID: ProjectID });
        strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/AddReleaseSprint", data, false);
        if (strResult.d != '') {

            $('#DivRelaseSprint').modal('show');
            var Result = strResult.d.split("||");
            // alert(Result)
            //  alert(Result[1])
            $("#DivRelaseSprint #GetData").html(Result[1]);
            if (Result[0] == "0") {
                $("#btnAdd").css("display", "none");
            } else {

                $("#btnAdd").css("display", "block");
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-chevron-down').tooltip();
            // $("#DivRelaseSprint #GetData").html(strResult.d);

            // $("#Idheader").html("Show History");
            //datatables("DivRelaseSprint", '', "");
            //$("#DivRelaseSprint").css("display", "block");

        }
    }

    //For Saving Release & Sprint
    function SaveReleaseSprint() {
        //  debugger;
        var strSeletedSprint, StrselectedReleaseIDs;
        var ProjectID = document.getElementById('hdnProjectID').value;
        if (selectedFlag == "Sprint") {
            //debugger
            strSeletedSprint = $('input[name=chkAddSprintSelectList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedSprint.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            }
        }
        else {

            StrselectedReleaseIDs = $('input[name=chkAddSelectReleaseList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (StrselectedReleaseIDs.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Release', 'error');
                return;
            }


        }

        if (selectedFlag == "Sprint") {
            data = JSON.stringify({ StrselectedIDs: strSeletedSprint, selectedFlag: selectedFlag, ProjectID: ProjectID });
        }
        else {
            data = JSON.stringify({ StrselectedIDs: StrselectedReleaseIDs, selectedFlag: selectedFlag, ProjectID: ProjectID });
        }

        strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/AddExitingSprintRelease", data, false);

        if (selectedFlag == "Sprint") {
            if (strResult.d != "") {
                var result = String(strResult.d).split("|")
                // $("#DivRelaseSprint").css("display", "none");
                $("#DivRelaseSprint").modal('hide');
                if (result[0] == "1") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint Added successfully', 'success');
                    document.getElementById("DivSubtabWholedata").innerHTML = "";
                    document.getElementById("DivSubtabWholedata").innerHTML = result[1];
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $(".fa-chevron-down,.fa-chevron-up").tooltip();
                }
            }
        } else {

            if (strResult.d != "") {
                var result = String(strResult.d).split("|")
                // $("#DivRelaseSprint").css("display", "none");
                $("#DivRelaseSprint").modal('hide');
                if (result[0] == "1") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Release Added successfully', 'success');
                    //document.getElementById("DivSubtabWholedata").innerHTML = "";
                    //document.getElementById("DivSubtabWholedata").innerHTML = result[1];
                    document.getElementById("divRightSection").innerHTML = "";
                    document.getElementById("divRightSection").innerHTML = result[1];
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $(".fa-chevron-down,.fa-chevron-up").tooltip();
                }
            }

            //$("#DivRelaseSprint").css("display", "none");
            //alertify.set('notifier', 'position', 'top-right');
            //alertify.notify('Release Added successfully', 'success');

        }
        $("#inlineUSDoneNA").parent().css("display", "none");
        $("#inlineSprintNA").parent().css("display", "none");
    }
    //Display Custom Stages
    function DisplayCustomFields() {
        // debugger;
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('.fa-chevron-down').tooltip();
        $("#DivCustomStage").css("display", "block");
        CountTR = 0;
        //$('#DivCustomStage').modal('show')
        //$("#inlineCustomApplicable").attr("data-bs-toggle", "modal");
        $("#IdheaderCustom").text("Add Custom Stages");
        PTClick();

    }


    //Validate Description Limit
    function validateData(limitField, limitCount, limitNum) {
        //  alert();
        var length;
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            limitCount.innerHTML = (limitNum - limitField.value.length);
        }
        if (limitField.id == "txtDescription") {
            if (limitCount.innerHTML == 0) {

                //document.getElementById("countdowndes").style.color = 'red'
                $("#ShowCount").css("color", "red");
                //$("#ShowCount").css("margin-top", "-27px");
                $("#txtDescription").css("border-color", "red");
                $("#txtDescription").addClass('clstxtArea');
                // $("#ShowErrorMSG").css("color", "red");
                //$('#ShowErrorMSG').html("You Can Enter Only 1000 Character").show();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Characters', 'error');
            }
            else {

                //document.getElementById("countdowndes").style.color = 'black'
                $("#ShowCount").css("color", "black");
                $("#ShowCount").css("margin-top", "");
                $('#txtDescription').css('border-color', 'rgb(216, 218, 222)');
                // $('#ShowErrorMSG').text("");
                //$("#ShowErrorMSG").css("color", "red");
                $("#txtDescription").addClass('clstxtArea');
            }
        }
    }
    //Ajax Function
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

            },
            error: function (xhr, status, error) {

                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);

            }
        });

        return AjaxResult;
    }

    //For Saving Overall
    function Save_OnClick() {

        //Added By Riddhesh Patil on 11-NOV-2022 
        if ($("#txtDescription").val() != "") {
            if (checkSpecialCharacter($("#txtDescription").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtDescription").focus();
                Flag = 1;
                checkvalue = 1;
            }
        }
        //End of Added By Riddhesh Patil

        else if ($("#txtDescription").val().length > 1000) {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You Can Enter Only 1000 Characters', 'error');
            return;
        }

        else {
            var ProjectID = document.getElementById('hdnProjectID').value;
            //var PracticeID = document.getElementById('hdnstrProjectTypeID').value;

            var txtDescription, USTask, USIssue, USReview, USCheckReview, USCustom, sprintIssue, SprintReview, SprintChecklist, SprintADDUS
            var SprintCancelUS, ReleaseIssues, ReleaseReview, ReleaseChecklist, inlineRelaseAddUS, RelaseTerminateUS, USDONE, sprintDone, RelaseAddUS;
            txtDescription = document.getElementById('txtDescription').value;
            if (txtDescription == "") {
                txtDescription = "";
            }
            else {
                txtDescription = txtDescription;
            }

            //For US
            if ($("#inlineTask").is(':checked')) {
                USTask = 1;
            }
            else if ($("#inlineTaskNA").is(':checked')) {
                USTask = 3;
            }

            // debugger;

            if ($("#inlineIssueClosed").is(':checked')) {
                USIssue = 1;
            }
            else if ($("#inlineIssueFWD").is(':checked')) {
                USIssue = 2;
            }
            else {
                USIssue = 3;
            }

            if ($("#inlineReviewClosed").is(':checked')) {
                USReview = 1;
            }
            else if ($("#inlineReviewFWD").is(':checked')) {
                USReview = 2;
            }
            else {
                USReview = 3;
            }

            //if ($("#inlineCheckListClosed").is(':checked')) {
            //    USCheckReview = 1;
            //}
            //else if ($("#inlineCheckListFWD").is(':checked')) {
            //    USCheckReview = 2;
            //}
            //else {
            USCheckReview = 3;
            //}


            if ($("#inlineCustomApplicable").is(':checked')) {
                USCustom = 1;
            }
            else if ($("#inlineCustomNA").is(':checked')) {
                USCustom = 3;
            }


            //For Sprint

            if ($("#inlineUSDone").is(':checked')) {
                USDONE = 1;
            }

            else if ($("#inlineUSDoneNA").is(':checked')) {

                USDONE = 3;

            }

            if ($("#inlineSprintIssueClose").is(':checked')) {
                sprintIssue = 1;
            }
            else if ($("#inlineSprintIssueFWD").is(':checked')) {
                sprintIssue = 2;
            }
            else {
                sprintIssue = 3;
            }

            // debugger;
            if ($("#inlineSprintReviewClosed").is(':checked')) {
                SprintReview = 1;
            }
            else if ($("#inlineSprintReviewFWD").is(':checked')) {
                SprintReview = 2;
            }
            else {
                SprintReview = 3;
            }

            //if ($("#inlineSprintChecklistClosed").is(':checked')) {
            //    SprintChecklist = 1;
            //}
            //else if ($("#inlineSprintChecklistFWD").is(':checked')) {
            //    SprintChecklist = 2;
            //}
            //else {
            SprintChecklist = 3;
            //}



            if ($("#inlineSprintADDUS").is(':checked')) {
                SprintADDUS = 1;
            }
            else {
                SprintADDUS = 0;
            }


            if ($("#inlineSprintCancelUS").is(':checked')) {
                SprintCancelUS = 1;
            }
            else {
                SprintCancelUS = 0;
            }



            //For Release

            if ($("#inlineRleaseSprintDone").is(':checked')) {
                sprintDone = 1;
            }
            else if ($("#inlineSprintNA").is(':checked')) {
                sprintDone = 3;
            }


            if ($("#inlineReleaseIssuesClosed").is(':checked')) {
                ReleaseIssues = 1;
            }
            else if ($("#inlineReleaseIssuesNA").is(':checked')) {
                ReleaseIssues = 3;
            }

            if ($("#inlineReleaseReviewclose").is(':checked')) {
                ReleaseReview = 1;
            }
            else if ($("#inlineReleaseReviewNA").is(':checked')) {
                ReleaseReview = 3;
            }


            //if ($("#inlineReleaseChecklistClose").is(':checked')) {
            //    ReleaseChecklist = 1;
            //}
            //else if ($("#inlineReleaseChecklistNA").is(':checked')) {
            ReleaseChecklist = 3;
            // }



            if ($("#inlineRelaseAddUS").is(':checked')) {
                RelaseAddUS = 1;
            }
            else {
                RelaseAddUS = 0;
            }


            if ($("#inlineRelaseTerminateUS").is(':checked')) {
                RelaseTerminateUS = 1;
            }
            else {
                RelaseTerminateUS = 0;
            }


            var strResult, data;
            data = JSON.stringify({ ProjectID: ProjectID, txtDescription: txtDescription, USTask: USTask, USIssue: USIssue, USReview: USReview, USCheckReview: USCheckReview, USCustom: USCustom, sprintIssue: sprintIssue, SprintReview: SprintReview, SprintChecklist: SprintChecklist, SprintADDUS: SprintADDUS, SprintCancelUS: SprintCancelUS, ReleaseIssues: ReleaseIssues, ReleaseReview: ReleaseReview, ReleaseChecklist: ReleaseChecklist, RelaseAddUS: RelaseAddUS, RelaseTerminateUS: RelaseTerminateUS, USDONE: USDONE, sprintDone: sprintDone, Mode: 'AfterSaveRefresh' });
            strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/SaveUSSprintReleaseData", data, false);
            // alert(data);
            if (strResult.d != '') {
                // alert(strResult.d);
                var result = String(strResult.d).split("|")
                // alert(result[1])
                document.getElementById("DivWholedata").innerHTML = "";
                document.getElementById("DivWholedata").innerHTML = result[1];
                //$('textarea').each(function () {
                //    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
                //}).on('input', function () {
                //    this.style.height = 'auto';
                //    this.style.height = (this.scrollHeight) + 'px';
                //});
                getRows();
                AutoResizeTextArea();
                RemoveTextArea();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Details Saved successfully', 'success');
                $('[data-bs-toggle="tooltip"]').tooltip();
                $('.fa-chevron-down').tooltip();
                $("#inlineUSDoneNA").parent().css("display", "none");
                $("#inlineSprintNA").parent().css("display", "none");
            }


        }
    }

    //For Saving Release & Sprint
    var globalID;
    function SaveSprintRelease(Flag) {
        //debugger
        var RightUSDOne, RightSprintIssue, RightSprintReview, RightSprintChecklist, RightSprintAdd, RightSprintCancel;
        //var UniqueID = $("#hdnIterationID").val();
        //alert(UniqueID);
        var ProjectID = document.getElementById('hdnProjectID').value;
        var UniqueID = document.getElementsByName("hdnIterationID");//htRowCountUS[i].value


        if (Flag == "Sprint") {
            for (var i = 0; i < UniqueID.length; i++) {
                globalID = UniqueID[i].value;
                if ($("#inlineRightUSDone_" + UniqueID[i].value).is(':checked')) {
                    RightUSDOne = 1;
                }
                else if ($("#inlineRightUSDoneNA_" + UniqueID[i].value).is(':checked')) {
                    RightUSDOne = 3;
                }

                //RightSprintIssue = $("#inlineRightSprintIssueClose_" + UniqueID[i].value).is(':checked').val()
                if ($("#inlineRightSprintIssueClose_" + UniqueID[i].value).is(':checked')) {
                    RightSprintIssue = 1;
                }
                else if ($("#inlineRightSprintIssueFWD_" + UniqueID[i].value).is(':checked')) {
                    RightSprintIssue = 2;
                }
                else {
                    RightSprintIssue = 3;

                }


                if ($("#inlineRightSprintReviewClosed_" + UniqueID[i].value).is(':checked')) {
                    RightSprintReview = 1;
                }
                else if ($("#inlineRightSprintReviewFWD_" + UniqueID[i].value).is(':checked')) {
                    RightSprintReview = 2;
                }
                else {
                    RightSprintReview = 3;

                }

                // commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD
                //if ($("#inlineRightSprintChecklistClosed_" + UniqueID[i].value).is(':checked')) {
                //    RightSprintChecklist = 1;
                //}
                //else if ($("#inlineRightSprintChecklistFWD_" + UniqueID[i].value).is(':checked')) {
                //    RightSprintChecklist = 2;
                //}
                //else {
                //    RightSprintChecklist = 3;

                //}
                //End of commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD

                if ($("#inlineRightSprintADDUS_" + UniqueID[i].value).is(':checked')) {
                    RightSprintAdd = 1;
                }
                else {
                    RightSprintAdd = 0;
                }

                if ($("#inlineRightSprintCancelUS_" + UniqueID[i].value).is(':checked')) {
                    RightSprintCancel = 1;
                }
                else {
                    RightSprintCancel = 0;
                }

                var strResult, data;
                // alert(UniqueID.length);
                //if (UniqueID.length == 0) {
                //    Mode = "AfterSaveSubtabRefresh";
                //}
                //else {
                //    Mode = "";
                //}

                data = JSON.stringify({ UniqueID: globalID, ProjectID: ProjectID, RightUSDOne: RightUSDOne, RightSprintIssue: RightSprintIssue, RightSprintReview: RightSprintReview, RightSprintChecklist: 3, RightSprintAdd: RightSprintAdd, RightSprintCancel: RightSprintCancel, Mode: "AfterSaveSubtabRefresh", Flag: Flag });
                strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/SaveTabData", data, false);
                // alert(data);
                if (strResult.d != '') {
                    // if (Mode == "AfterSaveSubtabRefresh") {
                    var result = String(strResult.d).split("|")
                    // alert(result[1]);
                    //document.getElementById("DivSubtabWholedata").innerHTML = "";
                    //document.getElementById("DivSubtabWholedata").innerHTML = result[1];
                    //// $("#collapseExample_" + globalID).addClass('in');
                    //if ($("#collapseExample_" + globalID).hasClass('in')) {
                    //    $("#collapseExample_" + globalID).addClass('in')
                    //}

                    // }
                }


            }

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Details Saved successfully', 'success');
            $('[data-bs-toggle="tooltip"]').tooltip()
            $("#inlineUSDoneNA").parent().css("display", "none");
            $("#inlineSprintNA").parent().css("display", "none");
        }

        else {

            var hdnReleaseID = document.getElementsByName("hdnReleaseID");

            for (var i = 0; i < hdnReleaseID.length; i++) {
                globalID = hdnReleaseID[i].value;
                // alert(globalID);
                if ($("#inlineRightRleaseSprintDone_" + hdnReleaseID[i].value).is(':checked')) {
                    RightUSDOne = 1;
                }
                else if ($("#inlineRightSprintNA_" + hdnReleaseID[i].value).is(':checked')) {
                    RightUSDOne = 3;
                }


                if ($("#inlineRightReleaseIssuesClosed_" + hdnReleaseID[i].value).is(':checked')) {
                    RightSprintIssue = 1;
                }
                else if ($("#inlineRightReleaseIssuesNA_" + hdnReleaseID[i].value).is(':checked')) {

                    RightSprintIssue = 3;

                }


                if ($("#inlineRightReleaseReviewclose_" + hdnReleaseID[i].value).is(':checked')) {
                    RightSprintReview = 1;
                }

                else if ($("#inlineRightReleaseReviewNA_" + hdnReleaseID[i].value).is(':checked')) {//inlineRightReleaseReviewNA_1
                    RightSprintReview = 3;

                }

                // commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD
                //if ($("#inlineRightReleaseChecklistClose_" + hdnReleaseID[i].value).is(':checked')) {
                //    RightSprintChecklist = 1;
                //}
                //else {
                //    RightSprintChecklist = 3;

                //}
                //End of commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD

                if ($("#inlineRightRelaseAddUS_" + hdnReleaseID[i].value).is(':checked')) {
                    RightSprintAdd = 1;
                }
                else {
                    RightSprintAdd = 0;
                }

                if ($("#inlineRightRelaseTerminateUS_" + hdnReleaseID[i].value).is(':checked')) {
                    RightSprintCancel = 1;
                }
                else {
                    RightSprintCancel = 0;
                }

                var strResult, data;
                //if (UniqueID.length == 0) {
                //    Mode = "AfterSaveSubtabRefresh";
                //}
                //else {
                //    Mode = "";
                //}
                data = JSON.stringify({ UniqueID: globalID, ProjectID: ProjectID, RightUSDOne: RightUSDOne, RightSprintIssue: RightSprintIssue, RightSprintReview: RightSprintReview, RightSprintChecklist: 3, RightSprintAdd: RightSprintAdd, RightSprintCancel: RightSprintCancel, Mode: "AfterSaveSubtabRefresh", Flag: Flag });
                strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/SaveTabData", data, false);
                //alert(data);
                if (strResult.d != '') {
                    //if (Mode == "AfterSaveSubtabRefresh")
                    //{
                    var result = String(strResult.d).split("|")
                    //document.getElementById("DivSubtabWholedata").innerHTML = "";
                    //document.getElementById("DivSubtabWholedata").innerHTML = result[1];
                    ////$("#collapseExample_" + globalID).addClass('in');
                    //if ($("#collapseExample_" + globalID).hasClass('in')) {
                    //    $("#collapseExample_" + globalID).addClass('in')
                    //}

                    //}
                }
            }
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Details Saved successfully', 'success');
            $('[data-bs-toggle="tooltip"]').tooltip()
            $("#inlineUSDoneNA").parent().css("display", "none");
            $("#inlineSprintNA").parent().css("display", "none");
        }

    }

    //For Show History Pop_up
    function showhistory_OnClick() {
       // debugger;
        var strResult, data;
        data = JSON.stringify({ UniqueID: "" });
        strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/ShowHistoryDetails", data, false);
        //alert(strResult.d);
        if (strResult.d != "") {

            $("#DivShowhistory #GetShowhistory").html(strResult.d);
            datatables("DivGridShowHistory", '', "");
            $("#DivShowhistory").modal('show');
            $("#Idheader").html("Show History");
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-chevron-down').tooltip();
            $("#inlineUSDoneNA").parent().css("display", "none");
            $("#inlineSprintNA").parent().css("display", "none");
        }


    }

    //For Datatable
    function datatables(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            "pageLength": 5,
            // scrollY: '130px',
            pagingType: "numbers",
            sorting: true,
            scrollX: true
        });

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }

    //For Adding New Row

    var IsCheckTrCount = 1;
    var GlobalisCustom = 0;
    var CountTR = 0;
    var Color = "";

    function PTClick() {

        var result = AJAXCallWithResult("frmDefinationOfDone.aspx/GetData", JSON.stringify({}), false)
        var arrPer = [];
        if (result.d != "") {

            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-chevron-down').tooltip();
            //document.getElementById("hdnWorkFlowID").value = PTId;
            var strResult = String(result.d).split("||");
            //$("#txtWorkFlowCode").val(strResult[0]);
            //$("#txtWorkFlowName").val(strResult[1]);
            //$("#txtRevisionNo").val(strResult[2]);
            GlobalisCustom = strResult[4]


            // $("#btnSaveUpdate").html("Update");//Added By Dipali V On 7th Aug 2017
            var strHTML = "";
            strHTML += '<table class="table table-bordered table-hover" id="tableAddRow">'

            strHTML += "<tbody>"
            $.each(JSON.parse(strResult[6]), function (id, val) {
                if (val.IsCustom != "0") {
                    strHTML += '<tr style="background-color:' + val.Color + '">'
                }
                else {
                    strHTML += '<tr style="background-color:white">'
                }
                //alert(strResult[3]);
                if (id == (JSON.parse(strResult[6]).length - 2)) {
                    strHTML += '<td><span class="glyphicon glyphicon-plus addBtn" id="addBtnRemove_' + id + '" style="color:#3c8dbc!important" title="Add Row" data-bs-toggle="tooltip" data-bs-placement="bottom"></span></td>'
                }
                else {
                    strHTML += '<td><span id="addBtnRemove_' + id + '" title="Add Row" data-bs-toggle="tooltip" data-bs-placement="bottom"></span></td>'
                }
                strHTML += '<td>' + val.OrderNo + '<input type="hidden" name="hdnStageID" value=' + val.StageID + '/></td>'
                strHTML += '<td>' + val.StageName + '</td>'
                if (id == 0 || id == (JSON.parse(strResult[6]).length - 1)) {
                    // strHTML += "<td></td>";
                }
                else {
                    arrPer.push(val.StageID)
                    //strHTML += '<td><%=CommonFunctions.HTMLControls.DrawComboBox("cboApproval", "usp_sel_ProcessStage_ApprovalPercent", 230, , "class=form-control", True, True).Replace("'", """")%></td>';
                }
                if (val.IsCustom != "0") {
                    strHTML += '<td style="text-align:center"  class="addBtnRemove">'
                    strHTML += "<a onclick=GetRemove(" + val.StageID + ") title='Remove Row' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-remove' style='color:grey;text-align:center' ></i></a>"
                    strHTML += '</td>'

                }
                else {
                    strHTML += '<td></td>'
                }
                strHTML += '</tr>'
            })
            strHTML += "</tbody>"
            strHTML += '</table>'
            $("#divStages").html(strHTML);
            //IsCheckTrCount = 1;
            $('.addBtn').on('click', function () {
                //var trID;
                //trID = $(this).closest('tr'); // table row ID 
                //if (GlobalisCustom == 0) {
                //    if (IsCheckTrCount <= 2) {
                //        addTableRow();
                //    }
                //}
                //else {

                //    if (GlobalisCustom >= 2){
                //        alertify.set('notifier', 'position', 'top-right');
                //        alertify.notify('You Can add only 2 Custom Stages', 'error');
                //    }
                //    else {

                //        addTableRow();
                //    }

                //}
                // debugger;
                if (GlobalisCustom == 0) {
                    if (IsCheckTrCount <= 2) {
                        addTableRow();
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can add only 2 Custom Stages', 'error');
                    }

                }
                else {

                    if (GlobalisCustom >= 2) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can add only 2 Custom Stages', 'error');
                    }
                    else {
                        if (GlobalisCustom == 1 && CountTR == 0) {
                            addTableRow();
                            CountTR = 1;
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You Can add only 2 Custom Stages', 'error');
                        }

                    }

                }


            });

            var i = 1;
            function addTableRow() {
                var strHTML = "";
                strHTML += '<tr><td><span class="glyphicon glyphicon-minus addBtnRemove" id="addBtn_' + i + '" style="color:#3c8dbc!important"></span></td>';
                strHTML += "<td><input type='text' class='form-control' name='txtOrder' id='txtOrder_" + i + "'  /></td>"
                strHTML += "<td><input type='text' class='form-control' name='txtStageName' id='txtStagename_" + i + "' /></td>"
                strHTML += '<td style="text-align:center" class="addBtnRemove">'
                strHTML += "<a title='Remove Row' data-bs-toggle='tooltip' data-bs-placement='bottom' ><i class='fa fa-remove' style='color:grey;text-align:center' title='Remove Row' data-bs-toggle='tooltip' data-bs-placement='bottom'></i></a>"
                strHTML += '</td>'
                strHTML += "<input type='hidden' class='form-control' name='TextBoxControl' value='" + i + "' />"
                strHTML += "</tr>"
                var tempTr = $(strHTML).on('click', function () {
                    //$(this).closest('tr').remove();
                    //$(document.body).on('click', '.TreatmentHistoryRemove', function (e) {
                    //    $(this).closest('tr').remove();
                    //});
                });
                IsCheckTrCount++;
                $("#tableAddRow").find("tbody > tr:last-child").before(tempTr)
                $('.addBtnRemove').click(function () {
                    // alert();
                    $(this).closest('tr').remove();
                    IsCheckTrCount = 1;
                })
                i++;
            }
        }

        var cboStage = document.getElementsByName("cboStage");
        for (var i = 0; i < cboStage.length; i++) {
            cboStage[i].value = arrPer[i];
            // alert(cboStage[i].value);
        }
        //var cboApproval = document.getElementsByName("cboApproval");
        //for (var i = 0; i < cboApproval.length; i++) {
        //    cboApproval[i].value = arrPer[i];
        //}
        $(".tab-content").css("height", "");
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('.fa-chevron-down').tooltip();
    }


    //For Saving Custom Stages
    function SaveCustomStages() {
        //  $('[data-bs-toggle="tooltip"]').tooltip();
        var hdnStageID, OrderNumber, StageName, ProjectID;
        var valid = 0;
        CountTR = 0;
        var hdnTextBoxControl = document.getElementsByName("TextBoxControl");
        for (var i = 0; i < hdnTextBoxControl.length; i++) {
            //globalID = UniqueID[i].value;

            //if (document.getElementById("hdnStageID").value != "") {
            //    hdnStageID = document.getElementById("hdnStageID").value;
            //}
            if (document.getElementById("hdnProjectID").value != "") {
                ProjectID = document.getElementById('hdnProjectID').value;
            }


            if ($("#txtOrder_" + hdnTextBoxControl[i].value).val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter Order No', 'error');
                valid = 1
            }

            if (isNumeric($("#txtOrder_" + hdnTextBoxControl[i].value).val()) == false) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please enter numeric Order No', 'error');
                valid = 1
            }
            if ($("#txtStagename_" + hdnTextBoxControl[i].value).val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter Stage Name', 'error');
                valid = 1
            }


            if (valid == 0) {
                var RNo = AJAXCallWithResult("frmDefinationOfDone.aspx/CheckOrderNo", JSON.stringify({ ProjectID: ProjectID, OrderNo: $("#txtOrder_" + hdnTextBoxControl[i].value).val() }), false)
                if (RNo.d == 1) {
                    // $("#spantxtRevisionNo").html('Order No. should be greater than previous Revision Number.');
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Order No. should be greater than previous Order No.', 'error');
                    valid = 1
                }
                else {
                    // $("#spantxtRevisionNo").html('');
                }
            }
            if (valid == 0) {
                var result = AJAXCallWithResult("frmDefinationOfDone.aspx/CheckDuplicate", JSON.stringify({ ProjectID: ProjectID, OrderNo: $("#txtOrder_" + hdnTextBoxControl[i].value).val(), strStageName: $("#txtStagename_" + hdnTextBoxControl[i].value).val() }), false)
                if (result.d == 1) {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('WorkFlow Code/WorkFlow Name can not be duplicate.', 'error');
                    valid = 1
                }
                else {
                    // $("#spantxtWorkFlowName").html('');
                }
            }
            //alert(hdnTextBoxControl[i].value);
            OrderNumber = $("#txtOrder_" + hdnTextBoxControl[i].value).val();
            StageName = $("#txtStagename_" + hdnTextBoxControl[i].value).val();
            var StageID = "null";
            if (valid == 0) {
                var strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/SaveData", JSON.stringify({ StageID: StageID, OrderNumber: OrderNumber, StageName: StageName }), false)
                var strHTML = "";
                strHTML += "<table class='table'>"
                //strHTML += "<thead>"
                //strHTML += "<tr>"
                //strHTML += "<th>"
                //strHTML += "Order No."
                //strHTML += "</th>"
                //strHTML += "<th>"
                //strHTML += "Stage Name"
                //strHTML += "</th>"
                //strHTML += "</tr>"
                //strHTML += "</thead>"
                strHTML += "<tbody>"
                $.each(JSON.parse(strResult.d), function (id, val) {
                    strHTML += "<tr>"

                    strHTML += "<td valign=top align=center title='" + val.StageName + "' ><a href=# onclick=PTClick(" + val.StageID + ")>" + val.OrderNo + "</a></td>";
                    strHTML += "<td>" + val.StageName + "</td>"
                    //strHTML += "<td>"
                    //strHTML += val.StageName
                    //strHTML += "</td>"
                    strHTML += "</tr>"
                    if ((JSON.parse(strResult.d).length - 1) == id) {
                        StageID = val.StageID
                    }
                })
                strHTML += "</tbody>"
                strHTML += "</table>"
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Custom Stages Added Successfully', 'success');
                //document.getElementById("divBGList").innerHTML = strHTML;
                //datatable("divBGList");
                //datatable_2("divBGList", 200);
                if (StageID == "Null") {
                    PTClick()
                }
            }

        }

        PTClick();
        $("#inlineUSDoneNA").parent().css("display", "none");
        $("#inlineSprintNA").parent().css("display", "none");
    }

    //For numeric validation
    function isNumeric(val) { return (parseFloat(val, 10) == (val * 1)); }

    //Remove Row
    function GetRemove(stagID) {
        CountTR = 0;
        $('.addBtnRemove').click(function () {
            $(this).closest('tr').remove();
            //alert(stagID);
            IsCheckTrCount--;
            CountTR = 0;
        });

        var strResult, data;
        var ProjectID = document.getElementById('hdnProjectID').value;
        data = JSON.stringify({ stagID: stagID, ProjectID: ProjectID });
        strResult = AJAXCallWithResult("frmDefinationOfDone.aspx/DeleteCustomStages", data, false);
        //alert(strResult.d);
        if (strResult.d != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Custom Stages Deleted successfully', 'success');
        }

        PTClick();
        IsCheckTrCount--;
    }

    //Display Arrow 
    function ShowArrow(ID) {

        if ($("#IdArrow_" + ID).hasClass('fa-chevron-down')) {
            $("#IdArrow_" + ID).removeClass('fa-chevron-down')
            $("#IdArrow_" + ID).addClass('fa-chevron-up')

        }
        else {

            $("#IdArrow_" + ID).addClass('fa-chevron-down')
            $("#IdArrow_" + ID).removeClass('fa-chevron-up')
        }

    }

    //function AutoResizeTextArea() {
    //    $('#txtDescription').autosize({ append: "\n" });
    //    $('#txtDescription').css("height", "auto!important");


    //}
    //$('textarea').each(function () {
    //    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
    //}).on('input', function () {
    //    this.style.height = 'auto';
    //    this.style.height = (this.scrollHeight) + 'px';
    //});
    function Maxlength(limitField, limitCountField, limitNum) {
        var length;
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            document.getElementById(limitCountField).innerHTML = +(limitNum - limitField.value.length);
        }

        if (limitNum - limitField.value.length == 0) {

            document.getElementById(limitCountField).style.color = 'red' //when Char 0 length  then Color red               



        }
        else {

            document.getElementById(limitCountField).style.color = 'black'
            // $('#spanBusinessValue').text("");


        }
        if (limitField.clientHeight < limitField.scrollHeight) {
            limitField.style.height = limitField.scrollHeight + "px";
            if (limitField.clientHeight < limitField.scrollHeight) {
                limitField.style.height = (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
            }
        }
    }

    function AutoResizeTextArea() {
        jQuery.each(jQuery('textarea[data-autoresize]'), function () {
            //var offset = this.offsetHeight - this.clientHeight;

            var resizeTextarea = function (el) {
                //jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
            };
            jQuery(this).on('keyup input', function () {
                if ($(this).attr("id") == "txtDescription") {
                    Maxlength(this, "ShowCount", 1000);
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
        if ($("#txtDescription").val() != undefined) {
            var numberOfColumns = 70;
            var numberOfLines = 1;
            //numberOfColumns = document.getElementById("txtActionItems").cols;
            var eachLine = $("#txtDescription").val().split('\n');
            var lineheight = $("#txtDescription").val();
            numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
            characterCount = lineheight.length + numberOfLineBreaks;

            if (characterCount > numberOfColumns) {
                numberOfLines = parseInt(characterCount / numberOfColumns);
                var height = document.getElementById("txtDescription").rows = numberOfLines + 2;
                $("#txtDescription").attr("style", "height: auto !important");
            }

        }


    }
    //function getRows() {
    //    //alert(document.getElementById('txtDescription').value.split("\n").length);
    //    var str = document.getElementById("txtDescription").value;
    //    str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
    //    document.getElementById("txtDescription").value = str;
    //    var lineheight = document.getElementById('txtDescription').value.split("\n").length +2;
    //    var height = document.getElementById("txtDescription").rows = lineheight;
    //    $("#txtDescription").attr("style", "height: auto !important");


    //}

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
 <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" rel="stylesheet" />
<script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

