<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Dashboard.aspx.vb" Inherits="PbNIT.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <%CommonFunctions.General.PlotPageHeadTag("Dashboard")%>
<head>
    <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version upgrade -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css"> -->

    <!-- Bootstrap 3.3.5 -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1"> -->
    <!-- bootstrap select -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css"> -->
    <!-- bootstrap select -->

    <!-- Font Awesome -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css"> -->

    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css">
    <!-- animate css -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css"> -->
    <!-- sticky table -->
    <link href='../../../Whizible2.0/dist/css/table-fixed-header.css' rel='stylesheet'>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_issues.css?v=2">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=1">
    <!-- bootstrap datepicker -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0/dist/css/bootstrap-datetimepicker.min.css"> -->

    <!--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet">-->
    

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<style type="text/css">

</style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <section class="content">
            <div class="graybg container-fluid pt-1 pb-1 headertopp">
                        <div class="row">
                            <div class="col-md-2 col-sm-2 col-xs-2" data-toggle="tooltip" data-placement="bottom" title="Select Project">
                                <div class="col-sm-9">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboIssueProjects", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " & Session("intUserID"),,, "class='form-control selectpicker' onChange='javascript:IssueProjectDrop_OnChange(this.value);'",,, ) %>
                                        </div>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-2 pl0">
                                <a data-toggle="tooltip" data-placement="bottom" title="New Issues" class="btn borderbtn h32" href="CreateNewIssue.aspx">New Issues +</a>
                            </div>

                            <div class="col-md-5 col-sm-5 col-xs-5">

                                <ul class="headernavlist pl-0">
                                    <li><a href="IssueList.aspx">Issue List</a></li>
                                    <li><a href="#">Dashboard</a></li>
                                    <li><a href="copywizard.html">Copy Issue</a></li>
                                    <li><a href="bulkupdate.html">Bulk Update</a></li>
                                </ul>

                            </div>

                            <div class="col-md-3 col-sm-3 col-xs-3">
                                <div class="form-group form-inline viewapplyfield pull-right">
                                    <label><a href="javascript:;" data-toggle="modal" data-target="#viewapplied">View Applied</a></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Xyz"/>
                                        <span class="input-group-btn">
                              <button class="btn btnyellow btn-flat" type="button">Default</button>
                              </span>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>
                <div class="Issuemodulewrap_main">
                    <div class="headerspacing">&nbsp;</div>

                   <div class="col-md-12 dashpanel">
                    <div class="row">

                        <div class="col-md-6">
                            <div class="box box-panel box-solid chartbox">

          <div class="box chartboxheader">
              <label class="mr-1">Overall Open Requests</label> <select class="selectpicker"><option>By Staus</option>
                <option>By Customer</option>
                <option>By Type</option>
                <option>By Sub Type</option>
                <option>By Employee</option>
                <option>By Priority</option>
              </select>

              <select class="selectpicker"><option>Duration All</option>
                <option>By Customer</option>
                <option>By Type</option>
                <option>By Sub Type</option>
                <option>By Employee</option>
                <option>By Priority</option>
              </select>

              <div class="chartboxaction dropdown pull-right">               
                <button type="button" class="btn borderbtngray dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Grapf Type"><i class="far fa-chart-bar"></i> <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="#">Bar Chart</a></li>
                    <li><a href="#">Donut Chart</a></li>       
                  </ul>           
                <button type="button" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="row">
                <div class="col-md-8">
                  <div class="chart-responsive">
                    <canvas id="pieChart" height="200"></canvas>
                  </div>
                  <!-- ./chart-responsive -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">
                  <ul class="chart-legend clearfix">
                    <li><i class="fas fa-square text-red"></i> Chrome</li>
                    <li><i class="fas fa-square text-green"></i> IE</li>
                    <li><i class="fas fa-square text-yellow"></i> FireFox</li>
                    <li><i class="fas fa-square text-aqua"></i> Safari</li>
                    <li><i class="fas fa-square text-light-blue"></i> Opera</li>
                    <li><i class="fas fa-square text-gray"></i> Navigator</li>
                  </ul>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->

          <!-- /.box -->
        </div>

    </div>

    <div class="col-md-6">
        <div class="box box-panel box-solid chartbox">

          <div class="box chartboxheader">
              <label class="mr-1">Assigned to me</label> <select class="selectpicker"><option>By Status</option>
                <option>By Customer</option>
                <option>By Type</option>
                <option>By Sub Type</option>
                <option>By Employee</option>
                <option>By Priority</option>
              </select>

              <select class="selectpicker"><option>Duration All</option>
                <option>By Customer</option>
                <option>By Type</option>
                <option>By Sub Type</option>
                <option>By Employee</option>
                <option>By Priority</option>
              </select>

              <div class="chartboxaction dropdown pull-right">               
                <button type="button" class="btn borderbtngray dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" title="Select Grapf Type"><i class="far fa-chart-bar"></i> <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="#">Bar Chart</a></li>
                    <li><a href="#">Donut Chart</a></li>       
                  </ul>           
                <button type="button" class="btn borderbtngray" data-widget="remove" data-toggle="tooltip" data-placement="bottom" title="Reload Metadata"><i class="fas fa-redo"></i></button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="row">
                <div class="col-md-8">
                  <div class="chart-responsive">
                    <canvas id="pieChart2" height="200"></canvas>
                  </div>
                  <!-- ./chart-responsive -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">
                  <ul class="chart-legend clearfix">
                    <li><i class="fas fa-square text-red"></i> Chrome</li>
                    <li><i class="fas fa-square text-green"></i> IE</li>
                    <li><i class="fas fa-square text-yellow"></i> FireFox</li>
                    <li><i class="fas fa-square text-aqua"></i> Safari</li>
                    <li><i class="fas fa-square text-light-blue"></i> Opera</li>
                    <li><i class="fas fa-square text-gray"></i> Navigator</li>
                  </ul>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.box-body -->

          <!-- /.box -->
        </div>
    </div>

                    </div>
                        </div>

                        </div>
                <div class="clearfix"></div>

        </section>

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <!-- <script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script> -->
    <!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
    <!-- jqueryUI js -->
    <!-- <script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script> -->
    <!-- Bootstrap 3.3.5 -->
    <!-- <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script> -->
    <!-- Bootstrap 3.3.5 -->
    <!-- <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script> -->
    <!--daterangepicker-->
    <!-- <script src="../../../Whizible2.0/dist/js/moment.min.js"></script> -->

    <!--daterangepicker-->
    <!-- <script src="../../../Whizible2.0/dist/js/bootstrap-datetimepicker.min.js"></script> -->

    <!--autofilter-->
    <script src="../../../Whizible2.0/dist/js/autocomplete/tabcomplete.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/livefilter.min.js"></script>
    <script src="../../../Whizible2.0/dist/js/autocomplete/bootstrap-select-autocomplete.js"></script>

    <!--style-custome-->
    <!-- <script src="../../../Whizible2.0/dist/js/issues_custom.js"></script> -->

    <!-- stickytable js -->
    <script src="../../../Whizible2.0/dist/js/table-fixed-header.js"></script>
    <!--freezetbl_header_in_modalpopupbox-->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/jquery.freezeheader.js"></script>
    <!-- multiselect -->
    <script type="text/javascript" src="../../../Whizible2.0/dist/js/multiselect.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <!-- ChartJS 1.0.1 -->
    <script src="../../../Whizible2.0/plugins/chartjs/Chart.min.js"></script>
    <!-- dashboard -->
    <script src="../../../Whizible2.0/dist/js/dashboard2.js"></script>
    <script type="text/javascript">
  

$(document).ready(function () {
  
    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var $target = $(e.target);
    
        if ($target.parent().hasClass('disabled')) {
            return false;
        }
    });

    $(".nextwizardbtn").click(function (e) {

        var $active = $('.wizard .nav-wizard li.active');
        $active.next().removeClass('disabled');
        nextTab($active);

    });
});

function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}


    </script>
</body>
</html>
