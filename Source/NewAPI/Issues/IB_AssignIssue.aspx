<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IB_AssignIssue.aspx.vb" Inherits="PbNIT.IB_AssignIssue" %>

<!DOCTYPE html>

<html >
    <%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head runat="server">
    
    <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version upgrade -->
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_TITILE") %></title>--%>
    <!-- Tell the browser to be responsive to screen width -->
    <%--<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css?v=2">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=3">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>



  

</head>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyAssignIssue">
    <div class="bgwhite">
        <div class="container-fluid pt-3 pb-3 text-end graybg">
            <h5 class="pgtitle float-start" id="idpageTiltle"><%= MyBase.GetResourceString("C_TITILE") %></h5>
            <div class="clearfix"></div>
        </div>


        <div class="form-group row">
                 <div class="col-sm-6">
                    <div class="row">
                       <div class="pt-3 pb-3" style="cursor: auto;text-align:left">
                          <%--<span class="clsnote"><%= MyBase.GetResourceString("C_TITILE") %> </span>--%>
                     </div>
                            
                    </div>
                </div>
             <div class="col-sm-6">
                <div class="row">
                   <div class="pt-3 pb-3 text-end" style="cursor: auto;">
                      <%--<a href="javascript:;" class="btn borderbtn mr-5" id="btncopytoissue" ><%= MyBase.GetResourceString("C_PreviousIssues") %><span id="spnissuecount"></span></a>--%>
                       <a href="javascript:;" class="btn borderbtn mr-5" id="btnAssign" onclick="Save_AssignIssue()"><%= MyBase.GetResourceString("C_Assign") %></a>
                       <a href="javascript:;" class="btn borderbtn mr-5" id="btnClose" onclick="Cancel_issue()"><%= MyBase.GetResourceString("C_Close") %></a>
                  </div>
                 </div>
               </div>
             </div>



        <div class="content pt-0">
                        <div class="RAdetailinfo">
                            <table class="informationtbl" style="width: 100%;">
                                <tbody>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_REQUESTOR") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblREQUESTOR"></span></td>

                                        <th><%= MyBase.GetResourceString("C_REQUESTID") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblREQUESTID"></span></td>
                                    </tr>
                                 

                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_DEPARTMENT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblDEPARTMENT"></span></td>

                                        <th><%= MyBase.GetResourceString("C_STATUS") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblSTATUS"></span></td>
                                    </tr>
                                 

                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_REQTYPE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblREQTYPE"></span></td>

                                        <th><%= MyBase.GetResourceString("C_SUBREQUESTTYPE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblSUBREQUESTTYPE"></span></td>
                                    </tr>


                                    
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_SUBJECT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblSUBJECT"></span></td>
                                    </tr>
                                 

                                      <tr>
                                        <th><%= MyBase.GetResourceString("C_PRODUCT") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblPRODUCT"></span></td>


                                        <th><%= MyBase.GetResourceString("C_MODULE") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblMODULE"></span></td>
                                    </tr>



                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_PRIORITY") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span class="lmtname" id="lblPRIORITY"></span></td>

                                        <th><%= MyBase.GetResourceString("C_SEVERITY") %></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><span id="lblSEVERITY"></span></td>
                                    </tr>

                                      <tr>
                                        <th><b><%= MyBase.GetResourceString("C_PreviousIssuesCount") %></b></th>
                                        <td class="colan">:</td>
                                        <td class="pr-3"><b><span class="lmtname" id="spnissuecount"></span></b></td>

                                        
                                    </tr>


                                </tbody>
                            </table>
                        </div>
                        <hr />
                        <div id="TabDetails">
                         <div class="form-group row">
                         <div class="col-sm-6">
                            <div class="row">
                            <div class="container-fluid pt-3 pb-3 text-end">
                            <h5 class="pgtitle float-start" id=""><%= MyBase.GetResourceString("C_TITILE") %></h5>
                             <div class="clearfix"></div>
                             </div>
                            </div>
                        </div></div>

                        <div class="formbody" style="margin-left:60px">
                            <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label required" id="lblsummary"><%= MyBase.GetResourceString("C_SUMMARY") %></label>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("summary", "summary", "", "form-control",,,,, 450, 80,,,,,,,,, "' autocomplete='Off'",,,,,,,,,,) %>

                                      </div>
                                    </div>
                              </div>     
                            
                            <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label required" id="lblDescription"><%= MyBase.GetResourceString("C_DESC") %></label>
                                            <% CommonFunctions.HTMLControls.DrawTextArea("desc", "desc", "", "form-control",,,,, 450, 80,,,,,,,,, "' autocomplete='Off'",,,,,,,,,,) %>

                                      </div>
                                    </div>
                              </div>     

                             <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label required" id="lblProject"><%= MyBase.GetResourceString("C_PROJECT") %></label>
                                           <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueProject", "Select 0,'Select' ", 450,, "class='form-select input-sm' onchange=Project_Onchnge(this)",,, ) %>

                                      </div>
                                    </div>
                              </div> 
                            
                              <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                         <label class="control-label required" id="lblAssignTo"><%= MyBase.GetResourceString("C_ASSIGNTO") %></label>
                                         <% CommonFunctions.HTMLControls.DrawComboBox("objcboAssignTo", "usp_CRM_Get_ProjectEmployees 0,0,0 ", 450,, "class='form-select input-sm'",,, ) %>

                                      </div>
                                    </div>
                              </div> 

                              <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label required" id="lblIssueType">Issue Type</label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo 0", 450,, "class='form-select input-sm' onchange=IssueType_Onchnge(this)",,, ) %>

                                      </div>
                                    </div>
                              </div> 

                             <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label required" id="lblIssueStatus"><%= MyBase.GetResourceString("C_ISSUESTATUS") %></label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus 0,0,0", 450,, "class='form-select input-sm'",,, ) %>

                                      </div>
                                    </div>
                              </div> 

                             <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label" id="lblIssuePriority"><%= MyBase.GetResourceString("C_PRIORITY") %></label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssuePriority", "usp_Sel_tbl_IB_Project_Priorities 0,0", 450,, "class='form-select input-sm' ",,, ) %>

                                      </div>
                                    </div>
                              </div>
                            
                               <div class="form-group">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label" id="lblIssueSeverity"><%= MyBase.GetResourceString("C_SEVERITY") %></label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueSeverity", "usp_Sel_tbl_IB_Project_Severity 0,0", 450,, "class='form-select input-sm' ",,, ) %>

                                      </div>
                                    </div>
                              </div> 
                            <div id="ProductCustomerComp" style="display:none">

                             <div class="form-group"  id="DivCustomer">
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label" id="lblCutomer"><%= MyBase.GetResourceString("C_Customer") %></label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueCutomer", "usp_Whizible2_Sel_tbl_PM_Customer_ProductExecution ", 450,, "onchange=Customer_Onchange(this) class='form-select input-sm' ",,, ) %>

                                      </div>
                                    </div>
                              </div> 


                             <div class="form-group" >
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label required" id="lblProduct"><%= MyBase.GetResourceString("C_PRODUCT") %></label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueProduct", "Select 0,'Select' ", 450,, "onchange=IssueProduct_Onchange(this) class='form-select input-sm' ",,, ) %>

                                      </div>
                                    </div>
                              </div> 

                           
                            <div class="form-group" >
                                 <div class="row">
                                      <div class="col-sm-6">
                                            <label class="control-label" id="lblComponent"><%= MyBase.GetResourceString("C_Component") %></label>
                                                 <% CommonFunctions.HTMLControls.DrawComboBox("CboIssueComponent", "Select 0,'Select' ", 450,, "class='form-select input-sm' ",,, ) %>

                                      </div>
                                    </div>
                              </div> 
                                </div>

                         </div>
                      </div>
                      <span class="clsnote">Note: Product dropdown is populated only if selected project is 'Support Project' or requestor is a customer of selected project.</span>
                 <br />
                 <div class="container-fluid pt-3 pb-3 text-end graybg">
                    <h5 class="pgtitle float-start" id=""><%= MyBase.GetResourceString("C_PreviousIssues") %></h5>
                    <div class="clearfix"></div>
                 </div>
                          
                        <br />
                               <div>
                                    <table class="table table-bordered table-stripped cls_insideTbl" id="tablePrevious">
                                        <thead>
                                            <tr>
                                                <th><%= MyBase.GetResourceString("C_ISSUEID") %></th>
                                                 <th><%= MyBase.GetResourceString("C_RD") %></th>
                                                 <th><%= MyBase.GetResourceString("C_SUMMARY") %></th>
                                                 <th><%= MyBase.GetResourceString("C_TYPE") %></th>
                                                 <th><%= MyBase.GetResourceString("C_PN") %></th>
                                                 <th><%= MyBase.GetResourceString("C_REPORTEDBY") %></th>
                                                 <th><%= MyBase.GetResourceString("C_RP") %></th>
                                                 <th><%= MyBase.GetResourceString("C_DUEDATE") %></th>
                                                 <th><%= MyBase.GetResourceString("C_STATUS") %></th>
                                               
                                            </tr>
                                        </thead>
                                        <tbody id="tbodytablePrevious">
                                           
                                        </tbody>
                                    </table>
                                </div>

        </div>
    </div>
    <style>
        
        .informationtbl tr th {
            text-align: right;
            font-weight: 500;
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px;
        }

          .informationtbl {
            margin-bottom: 15px
        }

            .informationtbl tr th {
                text-align: right;
                font-weight: 500
            }

        body .informationtbl tr td {
            text-align: left
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px
        }

        body .informationtbl tr td.pr-3 {
            padding-right: 3em
        }

        table.informationtbl {
            width: 100%
        }

        td.Agpm {
            color: #eb1c24
        }
        .input-group .btn.borderbtn:focus, .input-group .btn.borderbtn:hover {color: #fff;background: #135a9c;}

        .content {
            padding-top: 0px !important;
        }

       #TabDetails input::placeholder {
            font-size: 10px !important;
        }

        ::-webkit-input-placeholder {
            font-size: 12px !important;
        }

        :-moz-placeholder { /* Firefox 18- */
            font-size: 12px !important;
        }

        ::-moz-placeholder { /* Firefox 19+ */
            font-size: 12px !important;
        }

        .clsnote {
            margin-left: 22px;
            font-size: 10px;
        }
        th.sorting_disabled::after, th.sorting_disabled::before{
            display:none!important;
        }

.form-select, .form-control{ font-size:14px;}
    </style>
</body>
</html>
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
        <%--<script src="../../General/CommonValidations.js?v=2"></script>--%>

     <!-- custome js -->
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

<script type="text/javascript">
    var Projectonchange = 0;
    params = getParams();
    $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
    var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>'
    var SelectedDepartmentID = "";
    var SelectedstrRequestorSLoginType = "";
    var SelectedstrRequestorSUserName = "";
    $(document).ready(function () {

        GetDetails();
        GetCRMDetails();
        getplacholder();

    });


    function getplacholder() {
        $("#CboIssueType").html("");
        $("#CboIssueType").prepend(new Option("Select Issue Type", "0"));
        $("#CboIssueType").val("0");

        if (Projectonchange == 0) {
            $("#CboIssueProject").prepend(new Option("Select Project", "0"));
            $("#CboIssueProject").val("0");
        }
        
        $("#objcboAssignTo").html("");
        $("#objcboAssignTo").prepend(new Option("Select Assign To", "0"));
        $("#objcboAssignTo").val("0");

        $("#CboIssueStatus").html("");
        $("#CboIssueStatus").prepend(new Option("Select Status", "0"));
        $("#CboIssueStatus").val("0");

        $("#CboIssueSeverity").prepend(new Option("Select Severity", "0"));
        $("#CboIssueSeverity").val("0");

        $("#CboIssueProduct").prepend(new Option("Select Product", "0"));
        $("#CboIssueProduct").val("0");

        $("#CboIssuePriority").prepend(new Option("Select Priority", "0"));
        $("#CboIssuePriority").val("0");

        $("#CboIssueComponent").prepend(new Option("Select Component", "0"));
        $("#CboIssueComponent").val("0");

        
         //$("#CboIssueCutomer").prepend(new Option("Select Customer", "0"));
         //$("#CboIssueCutomer").val("0");
    }

    function getParams() {
        var params = {},
            pairs = document.URL.split('?')
                .pop()
                .split('&');
        for (var i = 0, p; i < pairs.length; i++) {
            p = pairs[i].split('=');
            params[p[0]] = p[1];
        }
        return params;
    }

    function GetDetails() {
        //  debugger;
        var CRMRequestID = unescape(params["QueryID"]);
        var HDDetails = {
            CRMRequestID: encodeURI(CRMRequestID),
        }

        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetDetails", param, false);
        if (strResult.length != 0) {
            for (var i = 0; i < strResult.length; i++) {
               
                $("#lblREQUESTOR").text(strResult[i].CustomerID);

                if (strResult[i].CustomerName != "") {
                    $("#lblREQUESTOR").text(strResult[i].CustomerID + " | " + strResult[i].CustomerName);
                }
                $("#lblDEPARTMENT").text(strResult[i].Department);
                $("#lblREQTYPE").text(strResult[i].RequestType);
                $("#lblSUBREQUESTTYPE").text(strResult[i].SubRequestType);
                $("#lblSUBJECT").text(strResult[i].Subject);
                $("#lblPRODUCT").text(strResult[i].Product);
                $("#lblMODULE").text(strResult[i].Component);
                $("#lblPRIORITY").text(strResult[i].Priority);
                $("#lblSEVERITY").text(strResult[i].Severity);
                $("#lblSTATUS").text(strResult[i].Status);
                $("#lblREQUESTID").text(strResult[i].QueryID);

                //spnissuecount
                GetIssueCount();
            }
        }
    }

    function GetIssueCount() {
        //  debugger;
        var CRMRequestID = unescape(params["QueryID"]);
        var HDDetails = {
            CRMRequestID: encodeURI(CRMRequestID),
        }

        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetIssueCount", param, false);
        if (strResult.length != 0) {
            for (var i = 0; i < strResult.length; i++) {
                $("#spnissuecount").text(strResult[i]);
            }
        }
    }

    var PostID = '<%= Session("intPostID") %>';
    var strUserName = '<%= Session("strUserName") %>';

    function IssueType_Onchnge(obj) {
       // debugger;
        var ProjectID = $("#CboIssueProject").val();
        var CRMRequestID = unescape(params["QueryID"]);
        var IssueType = unescape(obj.value);
        if (IssueType != "") {
            var HDDetails = {
                CRMRequestID: encodeURI(CRMRequestID),
                ProjectID: encodeURI(ProjectID),
                PostID: encodeURI(PostID),
                DepartmentID: encodeURI(SelectedDepartmentID),
                strRequestorSLoginType: encodeURI(SelectedstrRequestorSLoginType),
                strRequestorSUserName: encodeURI(SelectedstrRequestorSUserName),
                IssueType: IssueType,
            }

            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetData", param, false);
            var ProjectStatus = strResult.ProjectStatus;
          
            $("#CboIssueStatus").html("");
            $("#CboIssueStatus").prepend(new Option("Select Status", "0"));
            $("#CboIssueStatus").val("0");
            if (ProjectStatus.length != 0) {
                for (var i = 0; i < ProjectStatus.length; i++) {
                    var s = ('<option value=' +  escape(ProjectStatus[i].FieldID) + ' >' + ProjectStatus[i].FieldName + '</option>');
                    $("#CboIssueStatus").append("");
                    $("#CboIssueStatus").append(s);
                }
            }

        }
    }
    var IsShowProduct = "";
    function Project_Onchnge() {
         // debugger;
        var CRMRequestID = unescape(params["QueryID"]);
        var ProjectID = $("#CboIssueProject").val();
        var IssueType = "0"
        if (ProjectID != "") {
            $("#CboIssueType").html("");
            $("#CboIssueStatus").html("");
            $("#objcboAssignTo").html("");
            $("#CboIssuePriority").html("");
            $("#CboIssueSeverity").html("");
            $("#CboIssueProduct").html("");
            $("#CboIssueComponent").html("");
            // $("#CboIssueCutomer").html("");
            //$("#CboIssueProject").html("");
            var HDDetails = {
                CRMRequestID: encodeURI(CRMRequestID),
                ProjectID: encodeURI(ProjectID),
                PostID: encodeURI(PostID),
                DepartmentID: encodeURI(SelectedDepartmentID),
                strRequestorSLoginType: encodeURI(SelectedstrRequestorSLoginType),
                strRequestorSUserName: encodeURI(SelectedstrRequestorSUserName),
                IssueType: IssueType,
            }

            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetData", param, false);
            var ProjectIssueType = strResult.ProjectIssueType;
            var ProjectEmployee = strResult.drProjectEmployee;
            var ProjectStatus = strResult.ProjectStatus;
            var ProjectPriority = strResult.drProjectPriority;
            var ProjectSeverity = strResult.drProjectSeverity;
            var Product = strResult.Product;
             IsShowProduct = strResult.IsShowProduct;

            if (IsShowProduct == "1") {
                $("#ProductCustomerComp").show();
            } else {
                $("#ProductCustomerComp").hide();
            }

            if (SelectedstrRequestorSLoginType != "C") {
                //$("#CboIssueCutomer").html("");
                //$("#CboIssueCutomer").prepend(new Option("Select Customer", "0"));
                //$("#CboIssueCutomer").val("0");
                $("#DivCustomer").show();
            } else {
                $("#DivCustomer").hide();
            }
            //debugger;
           
            getplacholder();
            if (ProjectIssueType.length != 0) {
                for (var i = 0; i < ProjectIssueType.length; i++) {
                    var s = ('<option value=' +  escape(ProjectIssueType[i].Type)+ ' >' + ProjectIssueType[i].Type + '</option>');
                    $("#CboIssueType").append(s);
                }
            }


            if (ProjectEmployee.length != 0) {
                for (var i = 0; i < ProjectEmployee.length; i++) {
                    var s = ('<option value=' + ProjectEmployee[i].EmployeeID + ' >' + ProjectEmployee[i].UserName + '</option>');
                    $("#objcboAssignTo").append("");
                    $("#objcboAssignTo").append(s);
                }
            }


            if (ProjectStatus.length != 0) {
                for (var i = 0; i < ProjectStatus.length; i++) {
                    var s = ('<option value=' + escape(ProjectStatus[i].FieldID) + ' >' + ProjectStatus[i].FieldName + '</option>');
                    $("#CboIssueStatus").append("");
                    $("#CboIssueStatus").append(s);
                }
            }


            if (ProjectPriority.length != 0) {
                for (var i = 0; i < ProjectPriority.length; i++) {
                    var s = ('<option value=' + ProjectPriority[i].FieldId + ' >' + ProjectPriority[i].FieldName + '</option>');
                    $("#CboIssuePriority").append("");
                    $("#CboIssuePriority").append(s);
                }
            }


            if (ProjectSeverity.length != 0) {
                for (var i = 0; i < ProjectSeverity.length; i++) {
                    var s = ('<option value=' + ProjectSeverity[i].FieldId + ' >' + ProjectSeverity[i].FieldName + '</option>');
                    $("#CboIssueSeverity").append("");
                    $("#CboIssueSeverity").append(s);
                }
            }

            if (IsShowProduct == "1") {

                if (Product.length != 0) {
                    for (var i = 0; i < Product.length; i++) {
                        var s = ('<option value=' + Product[i].ProductVersionID + ' >' + Product[i].ProductVersion + '</option>');
                        $("#CboIssueProduct").append("");
                        $("#CboIssueProduct").append(s);
                    }
                }
            }



        } else {
            $("#ProductCustomerComp").hide();
            $("#CboIssueType").html("");
            $("#CboIssueStatus").html("");
            $("#objcboAssignTo").html("");
            $("#CboIssuePriority").html("");
            $("#CboIssueSeverity").html("");
            $("#CboIssueProduct").html("");
            $("#CboIssueComponent").html("");
            $("#CboIssueCutomer").html("");
            //$("#CboIssueProject").html("");

            getplacholder();
        }
    }


    function GetCRMDetails() {
        //  debugger;
        var CRMRequestID = unescape(params["QueryID"]);
        var PreIssueID = unescape(params["PreIssueID"]);
        var HDDetails = {
            CRMRequestID: encodeURI(CRMRequestID),
        }

        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetCRMDetails", param, false);
        if (strResult.length != 0) {
            for (var i = 0; i < strResult.length; i++) {
               // debugger;
                var strSummary = "Request ID->" + CRMRequestID + "-->" + strResult[i].Subject
                $("#summary").val(strSummary);
                if (strResult[i].Description == "") {
                    $("#desc").val(strResult[i].strSummary);
                } else {
                    $("#desc").val(strResult[i].Description);
                }
               
                //$("#desc").val(strResult[i].Subject);
                //debugger;
                GetProject(strResult[i].FunctionId, strResult[i].LoginType, strResult[i].CustomerID);
                SelectedDepartmentID = strResult[i].FunctionId;
                SelectedstrRequestorSLoginType = strResult[i].LoginType;
                SelectedstrRequestorSUserName = strResult[i].CustomerID;
                GetPreviousIssuesDetails(CRMRequestID);

                
            }
        }
    }

    function Cancel_issue() {
        window.close();
    }
  
    function IssueID_OnClick(IssueID, ProjectID) {
        //$("#issueentrymodal").modal("show");

        var url_New = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";
      // debugger;
        var issueIdList = '';
        var tab = 'undefined';
        var intPageNo = 1;
        var ProjectID = ProjectID;
        var ProjectName = $("#ProjectName" + IssueID).text();
        var validatedparameter = parseInt(IssueID) + parseInt(ProjectID);
        var token;
        $.ajax({
            url: url_New + '/api/IB_IssueDetails/generateToken',
            type: 'POST',
            data: JSON.stringify(validatedparameter),
            dataType: 'json',
            async: false,
            contentType: "application/json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Issue"));
                if (validatedparameter) {
                    xhr.setRequestHeader("Params", encryptString(isJson(validatedparameter) ? validatedparameter : JSON.stringify(validatedparameter)));
                }
            },
            success: function (result) {
               // debugger;
                token = result;
                var secondfilter = "";
                var FirstFilter = "";
                if (secondfilter != "") {
                    if (secondfilter.indexOf("''") > -1) {
                        secondfilter = secondfilter.replace(/\''/g, "'");
                    }
                }
                if (FirstFilter != "") {
                    if (FirstFilter.indexOf("''") > -1) {
                        FirstFilter = FirstFilter.replace(/\''/g, "'");
                    }
                }

                var SavedQueryName = "";
                var EmployeeID = "";
                var QueryID = "";
                var QueryType = "";
                var vType = "A";
                var vid = "0"; 
                var url1 = "../Dashboard/PMDAshBoardIssueDetail.aspx?ProjectID=" + parseInt(ProjectID) + "&PKToken=" + token + "&ProjectName=" + ProjectName + " &IssueID=" + parseInt(IssueID) + " &IssueIDList=" + issueIdList + " &ViewType=" + vType + "&View=" + vid +
                    " &intPageNo=" + intPageNo + " &tab=" + tab + "&secondfilter=" + escape(secondfilter)
                    + "&FirstFilter=" + escape(FirstFilter) + "&SavedQueryName=" + escape(SavedQueryName) +
                    "&FromWhere=AssignIssue&EmployeeID=" + escape(EmployeeID) + "&QueryID=" + escape(QueryID) + "&QueryType=" + escape(QueryType) + "";
                     PopUpWondowUtilization(url1, 1150, 500);
            },
            error: function (xhr, errorThrown) {

            }
        });
    }

    function PopUpWondowUtilization(url, width, height) {
        var leftPosition, topPosition;
        leftPosition = (window.screen.width / 2) - ((width / 2) + 10);
        topPosition = (window.screen.height / 2) - ((height / 2) + 50);
        window.open(url, "Window2",
            "status=no,height=" + height + ",width=" + width + ",resizable=yes,left="
            + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY="
            + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
    }

    function Customer_Onchange(obj) {
        var ProjectID = $("#CboIssueProject").val();
        var CustomerID = obj.value;
        var HDDetails = {
            CustomerID: encodeURI(CustomerID),
            ProjectID: encodeURI(ProjectID),

        }
        $("#CboIssueProduct").html("");
        $("#CboIssueProduct").prepend(new Option("Select Product", "0"));
        $("#CboIssueProduct").val("0");

        $("#CboIssueComponent").html("");
        $("#CboIssueComponent").prepend(new Option("Select Component", "0"));
        $("#CboIssueComponent").val("0");

        
        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetProductCombo", param, false);
        var Product = strResult.Product;
        if (Product.length != 0) {
            for (var i = 0; i < Product.length; i++) {
                var HDIssue = Product[i];
                var s = ('<option value=' + HDIssue.ProductVersionID + ' >' + HDIssue.ProductVersion + '</option>');
                $("#CboIssueProduct").append(s);
            }
        }
    }


    function IssueProduct_Onchange(obj) {
        var ProductID = obj.value;
        var HDDetails = {
            ProductID: encodeURI(ProductID),
           
        }
        $("#CboIssueComponent").html("");
        $("#CboIssueComponent").prepend(new Option("Select Component", "0"));
        $("#CboIssueComponent").val("0");
        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetModuleOrComponent", param, false);
        if (strResult.length != 0) {
            for (var i = 0; i < strResult.length; i++) {
                var HDIssue = strResult[i];
                var s = ('<option value=' + HDIssue.ComponentID + ' >' + HDIssue.Component + '</option>');
                $("#CboIssueComponent").append(s);
            }
        }
    }

    //Added by Aditya J. on 19-11-2024
    var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
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
    //End of Added by Aditya J. on 19-11-2024

    function ValidateAssignIssue() {
        debugger;
        var checkvalue = 0;
        var objtxtSummary = document.getElementById('summary');
      
        if ($("#summary").val() == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_summeryblank") %>', 'error');
            $("#summary").focus();
            checkvalue = 1;
        }

        else if (objtxtSummary.length > 512) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_SUMMERYLENGHT") %>', 'error');
            $("#summary").focus();
            checkvalue = 1;

        }
            //Added by Aditya J. on 19-11-2024
        else if (checkSpecialCharacter($('#summary').val().trim(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Summary should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#summary").focus();
            checkvalue = 1;
        }
            //End of Added by Aditya J. on 19-11-2024
        else if ($("#desc").val() == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_DescBlank") %>', 'error');
            $("#desc").focus();
            checkvalue = 1;
        }
            //Added by Aditya J. on 19-11-2024
        else if (checkSpecialCharacter($('#desc').val().trim(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#desc").focus();
            checkvalue = 1;
        }
            //End of Added by Aditya J. on 19-11-2024
        else if ($("#CboIssueProject").val() == "0") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_ProjectBlank") %>', 'error');
            $("#CboIssueProject").focus();
            checkvalue = 1;
        }
        else if ($("#objcboAssignTo").val() == "0") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_AssignToBlank") %>', 'error');
            $("#objcboAssignTo").focus();
            checkvalue = 1;
        }

        else if ($("#CboIssueType").val() == "0") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_IssueTypeBlank") %>', 'error');
            $("#CboIssueType").focus();
            checkvalue = 1;
        }
        else if ($("#CboIssueStatus").val() == "0") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('<%= MyBase.GetResourceString("C_IssueStatusBlank") %>', 'error');
            $("#CboIssueStatus").focus();
            checkvalue = 1;
        }
       

        //if ($("#CboCustomer").val() == "0") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please select Customer', 'error');
        //    checkvalue = 1;
        //}
        if (IsShowProduct == "1")
        {
           if ($("#CboIssueProduct").val() == "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("C_ProductBlank") %>', 'error');
                $("#CboIssueProduct").focus();
                checkvalue = 1;
            }
        }

        return checkvalue;

    }

    function Save_AssignIssue() {
        
        if (ValidateAssignIssue() == 0) {
            var summary = $("#summary").val();
            var desc = $("#desc").val();
            var CboIssueProject = $("#CboIssueProject").val();
            var objcboAssignTo = $("#objcboAssignTo").val();
            var CboCustomer;
            if (objcboAssignTo == undefined) {
                objcboAssignTo = "";
            }
            var CboIssueStatus = unescape($("#CboIssueStatus").val());
            var CboIssueType = unescape($("#CboIssueType").val());
            var CboIssueProject = $("#CboIssueProject").val();

            var CboIssuePriority = $("#CboIssuePriority").val();
            var CboIssueSeverity = $("#CboIssueSeverity").val();
            if ($("#CboIssueCutomer").val() == undefined && $("#CboIssueProduct").val() == undefined && $("#CboIssueComponent").val() == undefined) {
                var CboIssueProduct = "";
                var CboIssueComponent = "";
                CboCustomer = "";

            }
            else {
                var CboIssueProduct = $("#CboIssueProduct").val();
                var CboIssueComponent = $("#CboIssueComponent").val();
                CboCustomer = $("#CboIssueCutomer").val();

            }
            if (CboCustomer == undefined) {
                CboCustomer = "";
            }

            if (CboIssuePriority == "") {
                CboIssuePriority = "NULL";
            }


            if (CboIssueSeverity == "") {
                CboIssueSeverity = "NULL";
            }

            if (CboIssueProduct == "") {
                CboIssueProduct = "NULL";
            }

            if (CboIssueComponent == "") {
                CboIssueComponent = "NULL";
            }
            if (CboCustomer == "") {
                CboCustomer = "NULL";
            }

            var CRMRequestID = unescape(params["QueryID"]);
            var HDDetails = {
                summary: encodeURI(summary),
                desc: encodeURI(desc),
                CboIssueProject: encodeURI(CboIssueProject),
                objcboAssignTo: encodeURI(objcboAssignTo),
                CboIssueStatus: encodeURI(CboIssueStatus),
                CboIssueProduct: encodeURI(CboIssueProduct),
                CboIssueStatus: encodeURI(CboIssueStatus),
                CboIssueComponent: encodeURI(CboIssueComponent),
                CRMRequestID: encodeURI(CRMRequestID),
                strUserName: encodeURI(strUserName),
                CboIssueType: encodeURI(CboIssueType),
                CboIssuePriority: encodeURI(CboIssuePriority),
                CboIssueSeverity: encodeURI(CboIssueSeverity),
                CboCustomer: encodeURI(CboCustomer),
            }
            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/IB_AssignIssue/SaveAssignIssue", param, false);
            if (strResult.length != 0) {
                //alert(strResult.d);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("C_RequestAssignSuccess") %>', 'success')
                GetDetails();
                GetCRMDetails();
                GetIssueCount();
                GetPreviousIssuesDetails();
                $("#CboIssueType").html("");
                $("#CboIssueStatus").html("");
                $("#objcboAssignTo").html("");
                $("#CboIssuePriority").html("");
                $("#CboIssueSeverity").html("");
                $("#CboIssueProduct").html("");
                $("#CboIssueComponent").html("");
                // $("#CboIssueCutomer").html("");
                //$("#CboIssueProject").html("");

                 //$("#CboIssueCutomer").prepend(new Option("Select Customer", "0"));
                  $("#CboIssueCutomer").val("0");
                   getplacholder();
            }
        }
    }

   
    function GetProject(DepartmentID, LoginType, CustomerID) {
        var CRMRequestID = unescape(params["QueryID"]);
        var HDDetails = {
            DepartmentID: encodeURI(DepartmentID),
            strRequestorSLoginType: encodeURI(LoginType),
            CRMRequestID: encodeURI(CRMRequestID),
            strRequestorSUserName: encodeURI(CustomerID),
        }
        $("#CboIssueProject").html("");
        $("#CboIssueProject").prepend(new Option("Select Project", "0"));
        $("#CboIssueProject").val("0");
        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetProjectDetails", param, false);
        if (strResult.length != 0) {
            for (var i = 0; i < strResult.length; i++) {
                Projectonchange = 1;
                var HDIssue = strResult[i];
                var s = ('<option value=' + HDIssue.ProjectID + ' >' + HDIssue.ProjectName + '</option>');

                $("#CboIssueProject").append(s);
                
            }
        }
    }

    function GetPreviousIssuesDetails() {
        var CRMRequestID = unescape(params["QueryID"]);
        var HDDetails = {
            CRMRequestID: encodeURI(CRMRequestID),
           
        }
        var Strhtml = "";
        $("#tablePrevious").dataTable().fnDestroy();
        $("#tbodytablePrevious").html("");
        var param = JSON.stringify(HDDetails);
        var strResult = AJAXCallWithResult("/api/IB_AssignIssue/GetAssignIssueDetails", param, false);
        if (strResult.length != 0) {
            for (var i = 0; i < strResult.length; i++) {
                //debugger;
                var DueDate = "";
                if (strResult[i].ConvertedDueDate == null) {
                    DueDate = "Not Sepecified"
                } else {
                    DueDate = strResult[i].ConvertedDueDate;
                }
                Strhtml += '<tr class="" style="">';
                Strhtml += '<td><a href="JavaScript:IssueID_OnClick(' + strResult[i].IssueID + ',' + strResult[i].ProjectID + ')">' + strResult[i].IssueID + '</a></td >';
                Strhtml += '<td>' + strResult[i].ConvertReportedDate + '</td >';
                Strhtml += '<td>' + strResult[i].Summary + '</td >';
                Strhtml += '<td>' + strResult[i].Type + '</td >';
                Strhtml += '<td>' + strResult[i].ProjectName + '</td >';
                Strhtml += '<td>' + strResult[i].ReportedBy + '</td >';
                Strhtml += '<td>' + strResult[i].AssignTo + '</td >';
                Strhtml += '<td>' + DueDate + '</td >';
                Strhtml += '<td>' + strResult[i].Status + '<span id="ProjectName' + strResult[i].IssueID + '" value="' + strResult[i].ProjectName + '" style="display:none"> ' + strResult[i].ProjectName +'</span></td >';
                Strhtml += '</tr>';
            }
            $("#tbodytablePrevious").html(Strhtml);
        }

        $("#tablePrevious").DataTable({
            "scrollY": false,
            "scrollX": true,
            "pageLength": 10,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": true,
            "retrieve": true,
            "responsive": true
        });

    }



    var ajaxResult;
    function AJAXCallWithResult(url, param, async) {
        StartLoader("#bodyAssignIssue");
        $.ajax({
            url: encodeURI(strUrl + url),
            type: "POST",
            data: param,
            async: async,
            dataType: "json",
            contentType: "application/json;charset-utf=8",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Issue"));
                if (param) {
                    xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                }
            },
            success: function (data) {
                ajaxResult = data;
            },
            error: function (err) {
                ajaxResult = undefined;
                console.log(err.responseText)
                // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        StopAjaxLoader("#bodyAssignIssue");
        return ajaxResult;
    }

</script>
