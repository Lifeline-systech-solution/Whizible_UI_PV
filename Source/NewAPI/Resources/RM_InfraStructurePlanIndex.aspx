<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_InfraStructurePlanIndex.aspx.vb" Inherits="PbNIT.RM_InfraStructurePlanIndex" %>

<!DOCTYPE html> 
 
<html>
     <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 

<head runat="server">
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">


  

</head>
      <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

a.clearalllink {font-weight: bold;margin: 7px 0px 0 8px;display: none;}
.filter.pull-right { margin: 2px 0 0 8px;}
table tr th{ vertical-align:middle!important;}
table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before{ margin-right:0;}
  .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        #ProcessConfigurePlanModal table tr th:first-child, #ProcessConfigurePlanModal table tr td:first-child {
            text-align: left;
        }

.dropdown-submenu .dropdown-submenu > a:after {border-color: transparent transparent transparent #fff;    border-style: solid;border-width: 5px 0 5px 5px;content: " ";display: block;float: right;height: 0;    margin-right: 10px;margin-top: 5px;width: 0;}
.dropdown-submenu>.dropdown-submenu:hover a:after{border-color: transparent transparent transparent #464a4c;}
table tr th:first-child, table tr td:first-child{ text-align:center;width:50px;}
table tr th[colspan="3"]:first-child, table tr td[colspan="3"]:first-child{ text-align:left;}
.rowhead td{background:#f5f5f5; font-weight:bold; color: #4263c1;}
.table tbody tr td:nth-child(2){ text-align:left}
.RPlisttbl td{ position:relative;}
.RPlisttbl tr:hover{ background:#f5f5f5;}
        .RPlisttbl td:first-child::before {
            position: absolute;
            content: "\f111";
            /*content: "";*/
            left: 10px;
            font-size: 6px;
            top: 12px;
            font-family: "Font Awesome 5 Free";
            width: 10px;
            height: 10px; display:none;
            /*background: url(../../../Whizible2.0-new/dist/img/list-arrow-right.svg) 0 8px no-repeat*/
        }
/*.RPlisttbl .subrow td{position:relative;}
.RPlisttbl .subrow td::after{position:absolute; content:"\f101";left:10px; top:8px;font-family:"Font Awesome 5 Free";width:10px;height:10px;}*/
.RPlisttbl .subrow td::before{ left:20px;}

.checkconfgr_circle_red {color: #eb1c24;}
.checkconfgr_circle_green {color: #81cf09;}
.checkconfgr_circle_orang {color: #fbb03b;}

/*Added css by pradip on 28-05-2020*/
.accordion-toggle .collapsedown{display:block}
.accordion-toggle .collapseup{display:none}
.accordion-toggle.in .collapsedown{display:none}
.accordion-toggle.in .collapseup{display:block}

.show{display:revert!important}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">

      
        <div class="bgwhite">
           <div class="content">
            <table class="table table-bordered RPlisttbl">
                <thead>
                    <tr>
                        
                        <th colspan="2" class="text-left">Manage Infrastructure</th>
                        <th width="100">&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
        
                    <!--Default Plan liks-->
                    <tr data-bs-toggle="collapse" data-bs-target=".RPIndexRow4" class="accordion-toggle rowhead">
                        <td colspan="3">
                            Master <a href="javascript:;" class="nostyle collapsicon hidden-xs pull-right" data-bs-toggle="collapse" data-bs-target=".projecthide1">
                                <img data-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-bs-original-title="View Details">
                                <img class="collapseup" data-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-bs-original-title="Hide Details">
                            </a>
                        </td>
                    </tr>
                    <tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Pending Configure"><i class="far fa-check-circle checkconfgr_default"></i></a></td>
                        <td>Infrastructure Group</td>
                        <td><a href="RM_InfraGroup.aspx">Configure</a></td>
                    </tr>
                    <tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Partially Configure"><i class="far fa-check-circle checkconfgr_circle_orang"></i></a></td>
                        <td>Infrastructure Type</td>
                        <td><a href="RM_InfraType.aspx">Configure</a></td>
                    </tr>
                    <tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Completed"><i class="far fa-check-circle checkconfgr_circle_green"></i></a></td>
                        <td>Infrastructure Status</td>
                        <td><a href="RM_InfraStatus.aspx">Configure</a></td>
                    </tr>
                    <tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Pending Configure"><i class="far fa-check-circle checkconfgr_default"></i></a></td>
                        <td>Infrastructure Resource Management</td>
                        <td><a href="RM_ResourceManagementInfra.aspx">Configure</a></td>
                    </tr>
                    <tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Pending Configure"><i class="far fa-check-circle checkconfgr_default"></i></a></td>
                        <td>Infrastructure Request Approval</td>
                        <td><a href="RM_IrRequestApproval.aspx">Configure</a></td>
                    </tr>  
                    <tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Pending Configure"><i class="far fa-check-circle checkconfgr_default"></i></a></td>
                        <td>Project Infrastructure Resource </td>
                        <td><a href="Rm_ProjectInfraResource.aspx">Configure</a></td>
                    </tr>                    
                    <%--<tr class="subrow RPIndexRow4 hiddenRow collapse">
                        <td><a href="javascript:" data-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-bs-original-title="Pending Configure"><i class="far fa-check-circle checkconfgr_default"></i></a></td>
                        <td>Skill Category</td>
                        <td><a href="#">Configure</a></td>
                    </tr>--%>
                </tbody>
            </table>
                
            </div>

            <div class="clearfix"></div>
        </div>

        <!--add modal start here-->
        <div class="modal custmodal fade" id="AddPracticePopup" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Add Practice</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="notebox graybg" style="font-style:italic"><small><strong>Note:</strong> When 'Is Product Execution Project' is checked, project of the selected practice can configure product at project and track deliverables, Change Requests and Issues against the product.</small></div>
                        <div class="form-group row">
                            <div class="col-sm-6">
                                <label class="required">Practice</label>
                                <input type="text" id="Pract1" class="form-control" />
                                <!--<select class="selectpicker form-control">
                                <option></option>
                            </select>-->
                            </div>
                            <div class="col-sm-6">
                                <label>Organization Units</label>
                                <select class="selectpicker form-control">
                                    <option></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-6">
                                <label class="required">Project PMI</label>
                                <select class="selectpicker form-control">
                                    <option></option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label class="required">Project Type</label>
                                <select class="selectpicker form-control">
                                    <option></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-6">
                                <div class="custom_chckbox">
                                    <input id="APChck1" class="" type="checkbox">
                                    <label for="APChck1">Is Product Execution Project</label>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="custom_chckbox">
                                    <input id="APChck1" class="" type="checkbox">
                                    <label for="APChck1">Is Product Execution Project</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-6">
                                <div class="custom_chckbox">
                                    <input id="APChck1" class="" type="checkbox">
                                    <label for="APChck1">Is Agile Methodology Followed?</label>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                &nbsp;
                            </div>
                        </div>
                        <div class="text-center">
                            <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal">Cancel</a>
                            <a href="javascript:;" class="btn btnyellow" data-bs-dismiss="modal">Save</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add modal end here-->
        <!--Configure Plan modal start here-->
        <div class="modal custmodal fade" id="ProcessConfigurePlanModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Plan</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <table class="table table-stripped table-bordered">
                            <thead>
                                <tr>
                                    <th>Plan</th>
                                    <th width="100">
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck0" class="chckHead" type="checkbox">
                                            <label for="PAdevChck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Backup Plans</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck1" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck1"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Build Efforts</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck2" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck2"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Hardware Used</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck3" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck3"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Modules</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck4" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck4"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Practice</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck5" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck5"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Preliminary Project Scope Statement</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck6" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck6"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Project Scope</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck7" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck7"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Quantitative Objective</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck8" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck8"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>SCM Plan</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck9" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck9"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>SQA Plan</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck10" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck10"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Sub Projects</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck11" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck11"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Training Plans</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck12" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck12"></label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Work Plan</td>
                                    <td>
                                        <div class="custom_chckbox">
                                            <input id="PAdevChck13" class="chcktbl" type="checkbox">
                                            <label for="PAdevChck13"></label>
                                        </div>
                                    </td>
                                </tr>

                            </tbody>
                        </table>

                        <div class="text-center">
                            <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal">Cancel</a>
                            <a href="javascript:;" class="btn btnyellow" data-bs-dismiss="modal">Save</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Configure Plan modal end here-->
       

 <%--   <!-- REQUIRED JS SCRIPTS -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>


    <script>

        //$('.btn-action').click(function () {
        //    var url = $(this).data("url");
        //    $.ajax({
        //        type: "GET",
        //        url: url,
        //        dataType: 'html',
        //        success: function (res) {

        //            // get the ajax response data
        //            var data = res.body;
        //            // update modal content
        //            $('.modal-body').text(data.someval);
        //            // show modal
        //            $('#myModal').modal('show');

        //        },
        //        error: function (request, status, error) {
        //            console.log("ajax call went wrong:" + request.responseText);
        //        }
        //    });
        //});




        //$('.editor1').wysihtml5();
        //change date format
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        //datepicker

        $('').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });

        $(document).ready(function () {

        });


        //datatable
        $('.sciSLAtbl').dataTable({
            //"ajax": '/api/data',
            "scrollY": true,
            "scrollX": true,
            //"scroller": true,
            "pageLength": 10,
            //"paging": false,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true
            //"scrollable":true,
            //"scrollCollapse": true
        });

        function dtalign() {
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        }

        function resizeSection() {
            if ($(this).height() <= 800) {
                $('.dataTables_scrollBody').css('max-height', '330px'); //set max height
            } else {
                $('.dataTables_scrollBody').css('max-height', ''); //delete attribute
            }
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            dtalign(this);
        });


        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
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

        //Script added by pradip .p on 21-01-2020
        $('[data-toggle="tooltip"]').tooltip();

        $('.hiddenRow').on('show.bs.collapse', function () {
            $(this).prev(".accordion-toggle").toggleClass("in");
        });
        $('.hiddenRow').on('hidden.bs.collapse', function () {
            $(this).prev(".accordion-toggle").removeClass("in");
        });

    </script>

</body>
</html>
