﻿﻿
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="My_Leaves.aspx.vb" Inherits="Whizible.My_Leaves" %>
<%--Code Added by Vaibhav K on 26-12-25 for W26 My Leave page--%>
<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("My_Leaves")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Leaves</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    


    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" >
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">

 <!-- Added By Madhuri.K On 26-03-2026 -->
 <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">


    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>



    <style>
     /*    * {
    
     font-size: 11px !important;
    
 }*/

 /* =====================================================
   GLOBAL FONT CONSISTENCY 
   ===================================================== */

/* Base text */
body {
    font-size:11.5px /*14px*/;
}

/* Action bar controls */
.action-bar select,
.action-bar input,
.action-bar button {
                /*  Commented & Added By Dipali V On 25th March 2026 For Font Size Consistency*/
    /*font-size: 14px;*/
    font-size: 11.5px!important;
  /*End of Commented & Added By Dipali V On 25th March 2026 For Font Size Consistency*/

}

/* Dropdowns */
.form-select,
.form-select-sm-custom {
                /*  Commented & Added By Dipali V On 25th March 2026 For Font Size Consistency*/
    /*font-size: 14px;*/
    font-size: 11.5px!important;
  /*End of Commented & Added By Dipali V On 25th March 2026 For Font Size Consistency*/
    height: 34px;
    padding: 4px 8px;
}

/* Text inputs */
/*.form-control {
    font-size: 14px !important;
    height: 34px;
    padding: 4px 8px;
}
*/


/* Inputs & selects – single line */
input.form-control,
select.form-control {
    font-size: 11px !important;
    height: 34px;
    padding: 4px 8px;
}

/* Textareas – allow multi-line */
textarea.form-control {
    font-size: 11.5px/*14px*/ !important; /* Modified By Madhuri.K On 26-03-2026 */
    padding: 6px 8px;
    height: auto !important;   /* ✅ KEY FIX */
    min-height: unset;
}



p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    unicode-bidi: isolate;
}



/* Buttons */
.btn {
    font-size: 11.5px/*14px */!important;
    padding: 4px 10px;
}

/* Table */
.newTblStyle th {
    font-size: 12px/*14px*/;
    font-weight: 600;
}

.newTblStyle td {
    font-size: 11.5px/*14px*/;
}

/* Pagination */
.pagination-container {
    font-size: 11.5px/*14px*/;
}

.pagination-container button {
    font-size: 11.5px;
    padding: 3px 8px;
}

/* Badges (Submitted / Approved) */
.badge {
    font-size: 11.5px;
    padding: 4px 6px;
    font-weight: 400;
}

/* Links like Cancel */
.textUndrln {
    font-size: 11.5px/*14px*/;
}




 .custmodal .modal-content .modal-header .close {
            top: 5px;
            background-color: #4263c1;
        }

/* Hover */
.btnyellow:hover,
.btnyellow:focus {
    background-color: #e0b428 !important;
    color: #000 !important;
}

/* Disabled */
.btnyellow:disabled {
    background-color: #f6dfa0 !important;
    color: #666 !important;
    cursor: not-allowed;
}





 /*       .borderbtn {
            background-color: #fff !important; 
            border: 1px solid #ccc !important; 
            color: #333 !important;


        }*/

        .borderbtn {
    background: #fff;
    border-color: #1359a6;
    color: #1359a6;
    font-weight: 500;
}

        .borderbtn:hover,
.borderbtn:focus {
    background-color: #1359a6 !important;
    color: #fff !important;
    border-color: #1359a6 !important;
}
.borderbtn:hover i,
.borderbtn:focus i {
    color: #fff !important;
}

        .graybg { padding: 10px; border-bottom: 1px solid #ddd; }
        .textUndrln { text-decoration: underline; cursor: pointer; color: #0d6efd; }
        
        /* Table Styling */
        .newTblStyle thead th {
            background-color: #f8f9fa;
            position: sticky;
            top: 0;
            z-index: 10;
            border-bottom: 2px solid #dee2e6;
            color: #333;
            font-weight: 600;
        }
        .newTblStyle tbody td { vertical-align: middle; }
        #LeavesTbl tbody tr td:first-child { color: #1359a6 !important; font-weight: 500; }
        
        /* Action Bar */
        .action-bar {
            background: #e7edf0/*rgb(231, 237, 240)*/;
            padding: 0.5rem 1rem;
            margin: 0 1.0rem 0 1.0rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.75rem;
        }

        /* Filter Controls */
        .filter-group { display: flex; align-items: center; gap: 10px; }
        .form-select-sm-custom {
            width: 150px;
            height: 34px;
            border-radius: 4px;
            border: 1px solid #d1d5db;
        }

        /* Pagination & Footer */
      /*  .pagination-container {
            background: white;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            gap: 1rem;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            border-top: 1px solid #eee;
        }*/
      .pagination-container {
    background: white;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 0.75rem 0;
    gap: 1rem;
    border-top: 1px solid #eee;
    margin: 0.5rem 0 1rem 0; /* spacing before graph */
}

/* Graph Card - Aligned Top */
.card.leave-chart-card {
    margin-bottom: 0 !important;
}

/* Action Bar - No Gap After Graph */
.action-bar {
    margin-top: 3rem !important;
}

/* Header Section - Minimal Bottom Margin */
.page-header-section {
    margin-bottom: 0 !important;
}

/* Content/Table Section - Aligned Bottom */
.content {
    margin-top: 0 !important;
}

/* Force dropdown to always open downward */
.dropdown-menu {
    top: 100% !important;
    bottom: auto !important;
    transform: none !important;
}

/*For checkbox*/
#offcanvas_ApplyLeave .form-check-input {
    -webkit-appearance: auto;
    -moz-appearance: auto;
    appearance: auto;
}



.bgwhite {
     font-size:11.5px!important;
}.form-control, .btn, a, p, input, select.form-select
{
     font-size:11.5px!important;
}
.custmodal {
     font-size: 11.5px !important;
}
    .modal-lg {
        --bs-modal-width: 700px;
    }

/*Added by Vaibhav to to fix font issue on 11-03-26*/
        .offcanvas-title {
        font-size:16px;
        }
/*End of Added by Vaibhav to to fix font issue on 11-03-26*/

/* Fullscreen loader overlay */
.loader-overlay {
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    width: 100%; height: 100%;
    background-color: transparent;
    z-index: 2000;
}
/* Centered loader GIF */
.loader-overlay .loader {
    position: absolute;
    top: 50%; left: 50%;
    width: 100px; height: 100px;
    margin: -50px 0 0 -50px;
    background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
}
/* Initial page-load preloader */
.preloader {
    position: fixed;
    top: 50%; left: 50%;
    width: 100px; height: 100px;
    margin: -50px 0 0 -50px;
    background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    z-index: 2100;
}


    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <div id="MyLeavesSec" class="preloader"></div>

<!-- Page Loader -->
<div class="loader-overlay" id="loaderOverlay" style="display: none;">
    <div class="loader"></div>
</div>



    <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
        <div class="page-header-section" style="background: white;">
            <div class="graybg" style="padding: 0.4rem 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                    <i class="fas fa-calendar-check" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
                    <%=MyBase.GetResourceString("C_MyLeaves")%>
                </h2>
                <p style="color: #6b7280; margin: 0;"><%=MyBase.GetResourceString("C_MyLeaves_Description")%></p>
            </div>
        </div>

        <div class="card leave-chart-card">
            <div class="card-header bg-light">
                <strong><%=MyBase.GetResourceString("C_LeaveEntitlementVsBalance")%></strong>
            </div>
            <div class="card-body px-3" style="height:300px;">
                <canvas id="leaveBalanceChart"></canvas>
            </div>
        </div>

        <div class="action-bar">
            <div class="filter-group">
     <%--           <% 
                    CommonFunctions.HTMLControls.DrawComboBox(
                        "ddlFilterRequestType",
                        "usp_sel_RequestLeaveType",
                                , ,
                        "class='selectpicker form-control' data-live-search='false'",
                        True
                    )
                %>
                <% 
                    CommonFunctions.HTMLControls.DrawComboBox(
                    "ddlFilterLeaveStatus",
                    "usp_Sel_tbl_PM_LeaveStatusMaster",
                          , ,
                    "class='selectpicker form-control' data-live-search='true'",
                    True
                )
                %>--%>
            
              <% 
                  CommonFunctions.HTMLControls.DrawComboBox(
                      "ddlFilterRequestType",
                      "usp_Whizible2_Sel_RequestLeaveType",
                                            , ,
                      "class='selectpicker form-control' data-live-search='true'",
                           ,,
  )
                %>
                <% 
                    CommonFunctions.HTMLControls.DrawComboBox(
                                "ddlFilterLeaveStatus",
                                "usp_Whizible2_Sel_tbl_PM_LeaveStatusMaster",
                                                                          , ,
                                "class='selectpicker' data-live-search='true'",
                                                           ,,
    )
                %>
                                                      
            
            </div>

            <div style="display: flex; align-items: center; gap: 0.5rem;">
                <button class="btn borderbtn" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_LeaveBalance" title="<%=MyBase.GetResourceString("C_CheckBalance")%>">
                    <i class="fas fa-chart-pie me-1"></i> <%=MyBase.GetResourceString("C_LeaveBalance")%>
                </button>

                <% If m_blnAddAccess Then %>
                <button type="button" id="btnAddLeave" class="btn borderbtn" onclick="OpenApplyLeaveOffcanvas()">
                    <i class="fas fa-plus me-1"></i> <%=MyBase.GetResourceString("C_Add")%>
                </button>
                <% End If %>

                <% If m_blnDeleteAccess Then %>
                <button class="btn borderbtn" id="deleteLeaveBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Delete")%>">
                    <%=MyBase.GetResourceString("C_Delete")%>
                </button>
                <% End If %>

                <a href="javascript:;" class="clearalllink pe-3 ms-2" id="SelectAllBtn" onclick="selectAllLeaves()">
                    <strong><%=MyBase.GetResourceString("C_SelectAll")%></strong>
                </a>
                <a href="javascript:;" class="clearalllink pe-3" id="ClearAllBtn" onclick="clearAllLeaves()">
                    <strong><%=MyBase.GetResourceString("C_ClearAll")%></strong>
                </a>
            </div>
        </div>

        <div class="content">
            <table id="LeavesTbl" class="table table-hover newTblStyle" style="width:100%">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_FromDate")%></th>
                        <th><%=MyBase.GetResourceString("C_ToDate")%></th>
                        <th><%=MyBase.GetResourceString("C_Type")%></th> 
                        <th><%=MyBase.GetResourceString("C_Status")%></th>
                        <th><%=MyBase.GetResourceString("C_Comments")%></th> 
                        <th><%=MyBase.GetResourceString("C_Action")%></th>   
                        <th style="width: 40px; text-align:center;">
                            <% If m_blnDeleteAccess Then %>
                            <input type="checkbox" id="chkSelectAll" class="chckHead"  title="<%=MyBase.GetResourceString("C_SelectAll")%>" />
                            <% End If %>
                        </th>
                    </tr>
                </thead>
                <tbody id="LeavesTbl_body">
                    </tbody>
            </table>
        </div>

        <div class="pagination-container">
            <span id="totalRecords" style="color: #6b7280; font-size: 11.5px;"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
            <div style="display: flex; gap: 0.5rem;">
                <button class="btn borderbtn" id="firstPageBtn" onclick="goToPreviousPage()" data-bs-toggle="tooltip" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
                <button class="btn borderbtn" id="lastPageBtn" onclick="goToNextPage()" data-bs-toggle="tooltip" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
            </div>
        </div>
        <div class="container-fluid mb-3"></div>
    </div> 

    <div class="offcanvas offcanvas-end offcanvas-85" tabindex="-1" id="offcanvas_ApplyLeave">
        <div class="offcanvas-header graybg">
            <h5 class="offcanvas-title" id="applyLeaveLabel" style="color: #1e40af; font-weight:600;"><%=MyBase.GetResourceString("C_ApplyLeave")%></h5>
   
            
            <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>"></button>
        </div>
        <div class="offcanvas-body">
            <div class="row mb-3">
                <div class="col-12 text-end">
                            
              <!-- ✅ ADDED: Leave Approver -->
    <div id="leaveApproverContainer"  class="ms-auto text-end me-3 my-2"
        >
        
        <strong><%= MyBase.GetResourceString("Lbl_LeaveApprover") %> :</strong>

        <span id="spnLeaveApprover">-</span>
    </div>

                
                    <button id="btnSaveLeave" class="btn btnyellow me-2" onclick="saveLeaveAndShowEmail()"><%=MyBase.GetResourceString("C_Save")%></button>
                   
                    <%--<button class="btn borderbtn" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Close")%></button>--%>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4 mb-2">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_AppliedDate")%><span class="text-danger">*</span></label>
                    <input type="text" id="txtAppliedDate" class="form-control" >
                </div>
                <div class="col-md-4 mb-2">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_RequestType")%> <span class="text-danger">*</span></label>
                    <% CommonFunctions.HTMLControls.DrawComboBox("ddlRequestTypeApply", "usp_Whizible2_Sel_RequestLeaveType", , , "class='selectpicker form-control' data-live-search='true'", ,,) %>
                </div>
                <div class="col-md-4 mb-2" id="leaveTypeContainer">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_LeaveType")%> <span class="text-danger">*</span></label>
                    <% CommonFunctions.HTMLControls.DrawComboBox("ddlLeaveTypes", "usp_Whizible2_Sel_tbl_PM_LeaveType " & Session("intUserId"), , , "class='selectpicker form-control' data-live-search='true'", ,,) %>
                </div>
                <div class="col-md-4 mb-2" id="workFromHomeInfo" style="display: none;">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_LeaveType")%></label>
                    <div class="text-muted" style="padding: 0.375rem 0.75rem; font-size: 11.5px;">
                       <%=MyBase.GetResourceString("C_WorkFromHomeInfo")%>
                    </div>
                </div>
            </div>

            <div class="row mb-6">
                <div class="col-md-4">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_FromDate")%> <span class="text-danger">*</span></label>

                    <%--Commented and Added by Vaibhav K for icon of from date on 11-03-26--%>
                    <%--<input type="text" id="txtFromDate" class="form-control" >--%>

                    <!-- From Date -->
                    <div class="input-group">
                        <input type="text" id="txtFromDate" class="form-control" autocomplete="off">
                        <span class="input-group-text" id="txtFromDateIcon" style="cursor:pointer;">
                            <i class="fas fa-calendar-alt"></i>
                        </span>
                    </div>
                    <%--End of Commented and Added by Vaibhav K for icon of from date on 11-03-26--%>


                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_ToDate")%> <span class="text-danger">*</span></label>
                    
                    <%--Commented and Added by Vaibhav K for icon of from date on 11-03-26--%>
                    
                    <%--<input type="text" id="txtToDate" class="form-control">--%>

                    <!-- To Date -->
                <div class="input-group">
                <input type="text" id="txtToDate" class="form-control" autocomplete="off">
                  <span class="input-group-text" id="txtToDateIcon" style="cursor:pointer;">
                 <i class="fas fa-calendar-alt"></i>
                    </span>
                    </div>
                    <%--End of Commented and Added by Vaibhav K for icon of from date on 11-03-26--%>


                    
                
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-3 d-flex align-items-center">
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" id="chkFirstHalf">
                        <label class="form-check-label"><%=MyBase.GetResourceString("C_FirstHalfDay")%></label>
                    </div>
                </div>
                <div class="col-md-3 d-flex align-items-center">
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" id="chkSecondHalf">
                        <label class="form-check-label"><%=MyBase.GetResourceString("C_SecondHalfDay")%></label>
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_Address")%><span class="text-danger">*</span></label>
                    <textarea id="txtAddress" class="form-control" rows="2" maxlength="100"></textarea>
                </div>
                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_Reason")%><span class="text-danger">*</span></label>
                    <textarea id="txtReason" class="form-control" rows="2" maxlength="200"></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold"><%=MyBase.GetResourceString("C_Telephone")%><span class="text-danger">*</span></label>
                    <input type="text" id="txtTelephone" maxlength="13" class="form-control" >
                </div>
            </div>

            <div class="mt-4">
                <div class="alert alert-light border">
                    <strong><%=MyBase.GetResourceString("C_LeaveDetails")%></strong>
                </div>
                <table class="table table-bordered table-sm newTblStyle">
                    <thead>
                        <tr>
                            <th><%=MyBase.GetResourceString("C_LeaveType")%></th>
                            <th><%=MyBase.GetResourceString("C_LeavesTaken")%></th>
                            <th><%=MyBase.GetResourceString("C_LeaveBalance")%></th>
                        </tr>
                    </thead>
                    <tbody id="applyLeaveStatsBody">
                       
                    </tbody>
                </table>
                  </div>
    </div>
    <%--Added by Vaibhav K - pagination outside body so it sticks to bottom--%>
    <div style="display:flex; justify-content:flex-end; align-items:center; gap:1rem; padding:0.5rem 1rem; border-top:1px solid #eee; background:white;">
        <span id="applyLeaveTotalRecords" style="color:#6b7280; font-size:0.875rem;"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
        <div style="display:flex; gap:0.5rem;">
            <button class="btn borderbtn" id="alPrevBtn" onclick="alGoToPrev()" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
            <button class="btn borderbtn" id="alNextBtn" onclick="alGoToNext()" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
        </div>
    </div>
    <%--End of Added by Vaibhav K--%>
</div>

    <div class="offcanvas offcanvas-end offcanvas-70" tabindex="-1" id="offcanvas_LeaveBalance">
        <div class="offcanvas-header graybg">
            <h5 class="offcanvas-title" style="color: #1e40af; font-weight:600;"><%=MyBase.GetResourceString("C_LeaveBalance")%></h5>
            <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>"></button>
        </div>
        <div class="offcanvas-body">
            <div class="alert alert-light border mb-2">
                <%--Pending--%>
                <strong><%=MyBase.GetResourceString("C_EmployeeLeaveBalance")%></strong>
            </div>
            <table class="table table-bordered table-sm newTblStyle" style="width:100%;">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_LeaveType")%></th>
                        <th ><%=MyBase.GetResourceString("C_LeaveEntitlement")%></th>
                        <th ><%=MyBase.GetResourceString("C_LeaveBalance")%></th>
                    </tr>
                </thead>
                <tbody id="leaveBalanceTblBody"></tbody>
            </table>
            <div class="text-end text-muted" style="font-size:12px;">
              

        </div>
        </div>
    <%--Added by Vaibhav K - pagination outside body so it sticks to bottom--%>
    <div style="display:flex; justify-content:flex-end; align-items:center; gap:1rem; padding:0.5rem 1rem; border-top:1px solid #eee; background:white;">
        <span id="leaveBalanceTotalRecords" style="color:#6b7280; font-size:0.875rem;"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
        <div style="display:flex; gap:0.5rem;">
            <button class="btn borderbtn" id="lbPrevBtn" onclick="lbGoToPrev()" title="Previous Page"><i class="fas fa-angle-double-left"></i></button>
            <button class="btn borderbtn" id="lbNextBtn" onclick="lbGoToNext()" title="Next Page"><i class="fas fa-angle-double-right"></i></button>
        </div>
    </div>
    <%--End of Added by Vaibhav K--%>
</div>

<div id="cancelConfirmModal"
    <div id="cancelConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4> 
                </div>
                <div class="modal-body">
                    <p><center><%=MyBase.GetResourceString("A_ConfirmCancelLeave")%></center></p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_No")%></button>
                    <button class="btn btnyellow" onclick="proceedWithCancel()"><%=MyBase.GetResourceString("C_Yes")%></button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div id="deleteLeaveConfirm" class="modal fade custmodal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteLeave")%></h4>
                </div>
                <div class="modal-body text-center">
                    <p><%=MyBase.GetResourceString("A_ConfirmDeleteLeave")%></p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn float-start" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_No")%></button>
                    <button class="btn btnyellow" id="btnDeleteLeaveYes"><%=MyBase.GetResourceString("C_Yes")%></button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <div id="viewCommentModal" class="modal fade custmodal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header graybg">
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_ViewComments")%></h4>
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <label class="form-label fw-bold mb-1"><%=MyBase.GetResourceString("C_Comments")%></label>
                    <textarea id="txtViewComment" class="form-control" rows="3" readonly style="resize:none;"></textarea>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Close")%></button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal custmodal fade" id="SendLeaveEmailModal" data-bs-backdrop="static" aria-hidden="true" style="overflow-y:hidden;">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="margin-top:-40px;">
                <div class="modal-header">
                    <h5 class="modal-title text-center"><%=MyBase.GetResourceString("C_SendEmail")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="padding-top:12px; padding-bottom:15px;">
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-2 text-end">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_From")%></strong></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendLeaveEmailFrom" class="form-control" readonly="readonly" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-2 text-end">
                             <label class="control-label"><strong><%=MyBase.GetResourceString("C_To")%></strong> <span style="color:red;">*</span></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendLeaveEmailTo" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-2 text-end">
                             <label class="control-label"><strong><%=MyBase.GetResourceString("C_CC")%></strong></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendLeaveEmailCC" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-2 text-end">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_Subject")%></strong> <span style="color:red;">*</span></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendLeaveEmailSubject" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-2 text-end"><b><%=MyBase.GetResourceString("c_Note")%></b></div>
                        <div class="form-group col-sm-9">
                            <small style="color:#666;"><%=MyBase.GetResourceString("C_EmailSeparatorInfo")%></small>
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-2 text-end">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_Message")%></strong> <span style="color:red;">*</span></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <textarea id="sendLeaveEmailBody" class="form-control" rows="10" style="width:94%; padding:6px 10px; line-height: 1.5!important; resize:vertical; min-height:180px; box-sizing:border-box;" maxlength="1000"></textarea>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-sm-12 text-center">
                            <button id="sendLeaveEmailBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Send")%>" class="btn btnyellow" onclick="sendLeaveEmailConfirm()"><%=MyBase.GetResourceString("C_Send")%></button>
                            <button data-bs-dismiss="modal" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Cancel")%>" class="btn borderbtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <%Else%>
        <div id="ViewAccess" class="tab-pane" style="height: 448px">
            <div style="text-align: center">
                <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_AuthView")%></p>
            </div>
        </div>
    <%End If%>

   <script>
       // =============================================
       // RESOURCES (Loaded from Server)
       // =============================================
       var resourceKeys = {
      
           TotalRecords: '<%=MyBase.GetResourceString("C_TotalRecords")%>',
           ConfirmCancel: '<%=MyBase.GetResourceString("A_ConfirmCancelLeave")%>',
           SelectOneDelete: '<%=MyBase.GetResourceString("A_SelectAtLeastOneRecord")%>',
           NoValidDelete: '<%=MyBase.GetResourceString("A_NoValidLeaveSelected")%>',
           InvalidEmpID: '<%=MyBase.GetResourceString("A_InvalidEmployeeID")%>',
           LeaveDeleted: '<%=MyBase.GetResourceString("A_LeaveDeletedSuccess")%>',
           DeleteFailed: '<%=MyBase.GetResourceString("A_LeaveDeleteFailed")%>',
           InvalidLeaveID: '<%=MyBase.GetResourceString("A_InvalidLeaveID")%>',
           TotalEntitled: '<%=MyBase.GetResourceString("C_Chart_TotalEntitled")%>',
           Balance: '<%=MyBase.GetResourceString("C_Chart_Balance")%>',
           NoData: '<%=MyBase.GetResourceString("C_Chart_NoData")%>',
           NoDataAvailable: '<%=MyBase.GetResourceString("A_NoDataAvailable")%>',
           ReqAppliedDate: '<%=MyBase.GetResourceString("A_SelectAppliedDate")%>',
           ReqRequestType: '<%=MyBase.GetResourceString("A_SelectRequestType")%>',
            ReqLeaveType: '<%=MyBase.GetResourceString("A_SelectLeaveType")%>',
            ReqFromDate: '<%=MyBase.GetResourceString("A_SelectFromDate")%>',
            ReqToDate: '<%=MyBase.GetResourceString("A_SelectToDate")%>',
            InvalidDates: '<%=MyBase.GetResourceString("A_InvalidDates")%>',
            SaveFailed: '<%=MyBase.GetResourceString("A_SaveLeaveFailed")%>',
            LoadDetailsFailed: '<%=MyBase.GetResourceString("A_UnableToLoadLeaveDetails")%>',
            ReqEmailTo: '<%=MyBase.GetResourceString("A_EmailToRequired")%>',
            ReqEmailSubject: '<%=MyBase.GetResourceString("A_EmailSubjectRequired")%>',
            ReqEmailMsg: '<%=MyBase.GetResourceString("A_EmailMessageRequired")%>',
            EmailSuccess: '<%=MyBase.GetResourceString("A_EmailSentSuccess")%>',
            EmailFailed: '<%=MyBase.GetResourceString("A_EmailSendFailed")%>',
            CancelSuccess: '<%=MyBase.GetResourceString("A_LeaveCancelledSuccess")%>',
            CancelFailed: '<%=MyBase.GetResourceString("A_LeaveCancelFailed")%>',
           CommentsNotAvail: '<%=MyBase.GetResourceString("A_CommentsNotAvailable")%>',
           CancelNotAllowedPastDate: '<%=MyBase.GetResourceString("A_CancelNotAllowedPastDate")%>',
           ReqAddress: '<%=MyBase.GetResourceString("A_SelectAddress")%>',
           ReqReason: '<%=MyBase.GetResourceString("A_SelectReason")%>',
           Resubmit: '<%=MyBase.GetResourceString("C_Resubmit")%>',


           AddrMinLength: '<%=MyBase.GetResourceString("A_AddressMinLength")%>', // "Address is too short (Minimum 5 characters required)."
           AddrMaxLength: '<%=MyBase.GetResourceString("A_AddressMaxLength")%>', // "Address is too long (Maximum 250 characters allowed)."
           ReasonMaxLength: '<%=MyBase.GetResourceString("A_ReasonMaxLength")%>',
           ReqTelephone: '<%=MyBase.GetResourceString("A_SelectTelephone")%>',
           PhoneInvalidChar: '<%=MyBase.GetResourceString("A_PhoneInvalidChar")%>', // "A 'Telephone' can contain only + - characters."
           DateRangeError: '<%=MyBase.GetResourceString("A_DateRangeError")%>', // "To Date cannot be less than From Date."

           InvalidLeaveIDForUpdate: '<%=MyBase.GetResourceString("A_InvalidLeaveIDForUpdate")%>',
           LeaveUpdateFailed: '<%=MyBase.GetResourceString("A_LeaveUpdateFailed")%>',
           <%--LeaveUpdatedSuccess: '<%=MyBase.GetResourceString("A_LeaveUpdatedSuccess")%>',
LeaveSavedSuccess: '<%=MyBase.GetResourceString("A_LeaveSavedSuccess")%>',--%>
EmailTemplateLoadFailed: '<%=MyBase.GetResourceString("A_EmailTemplateLoadFailed")%>',
           EmailDetailsLoadFailed: '<%=MyBase.GetResourceString("A_EmailDetailsLoadFailed")%>',

           LeaveAppliedSuccess: '<%=MyBase.GetResourceString("A_LeaveAppliedSuccess")%>',

     

           NoDataList: '<%=MyBase.GetResourceString("C_NoDataAvailable")%>',



       };

       //for approver name
       var cachedLeaveApproverName = null;


       //For bulk delete
       // ----- GLOBAL UI STATE -----
       var isDeleteAll = false;              // logical mode
       var selectedIDs = new Set();          // normal selection
       var excludedIDs = new Set();          // exclusions after select all


       var lastOffcanvasContext = null; // will store rowId or 'ADD'



        // =============================================
        // API Configuration and Session Variables
        // =============================================
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        //Declaring global variable for send email
        //var currentSavedLeaveID = 0;
        //var approverEmail = '';

       // global variable add / update
       var editingLeaveID = 0;

        if (strUrl.endsWith('/')) {
            strUrl = strUrl.slice(0, -1);
        }
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';

       // =============================================
       // Pagination variables
       // =============================================
       var currentPageNumber = 1;
       var totalPages = 1;
       var pageSize = 5;
       var totalRecords = 0;

       var lastOffcanvasContext = null; // will store rowId or 'ADD'

       function resetOffcanvasScrollIfNeeded(currentContext) {
           var offcanvasEl = document.getElementById('offcanvas_ApplyLeave');
           if (!offcanvasEl) return;

           if (lastOffcanvasContext !== currentContext) {
               offcanvasEl.addEventListener('shown.bs.offcanvas', function () {
                   var body = offcanvasEl.querySelector('.offcanvas-body');
                   if (body) {
                       body.scrollTop = 0;
                       console.log('Offcanvas scroll reset →', currentContext);
                   }
               }, { once: true });
           } else {
               console.log('Same context → scroll preserved →', currentContext);
           }

           lastOffcanvasContext = currentContext;
       }



       // =============================================
       // GLOBAL Alertify configuration
       // =============================================
       alertify.set('notifier', 'position', 'top-right');

       // Use this function to open and reset the offcanvas
       function OpenApplyLeaveOffcanvas() {
         

           var offcanvasElement = document.getElementById('offcanvas_ApplyLeave');
           // This checks if an instance already exists, if not creates one
           var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
           if (!bsOffcanvas) {
               bsOffcanvas = new bootstrap.Offcanvas(offcanvasElement);
           }

          // Added By Vyankat B. on 18-Aug-2026 to clear the existing Address and Phone Number
            $('#txtAddress').val('');
            $('#txtTelephone').val('');
          // End of Added By Vyankat B. on 18-Aug-2026 to clear the existing Address and Phone Number



           // ✅ CALL THE NEW FUNCTION HERE
           GetEmployeeLeaveMasterStats();

           // ✅ SHOW Save button (Add flow)
           $('#btnSaveLeave').show();

           //  Enable all fields (in case they were disabled by viewing an Approved leave previously)
           $('#offcanvas_ApplyLeave input, #offcanvas_ApplyLeave select, #offcanvas_ApplyLeave textarea').prop('disabled', false);

           //  RESET Global ID for Add Mode
           editingLeaveID = 0;

           // Reset Button Text to "Save" and Ensure it is Visible
           $('#btnSaveLeave').text('<%=MyBase.GetResourceString("C_Save")%>').prop('disabled', false).show();


           // 5. CLEAR FIELDS (Using Correct IDs)
           // Commented By Vyankat B. on 18-Aug-2026 to retain Address and Phone Number
           //$('#txtAddress').val('');
           $('#txtReason').val('');
           //$('#txtTelephone').val('');
           // End of Commented By Vyankat B. on 18-Aug-2026 to retain Address and Phone Number
           $('#txtFromDate').val('');
           $('#txtToDate').val('');
           $('#txtLeaveType').val('');
           $('#txtDescription').val('');
           //$('#ddlLeaveTypes').val('');
           //$('#ddlRequestTypeApply').val('');

           $('#ddlLeaveTypes')
               .val('')
               .selectpicker('refresh');

           $('#ddlRequestTypeApply')
               .val('')
               .selectpicker('refresh');




           // 6. RESET Checkboxes
           $('#chkFirstHalf').prop('checked', false);
           $('#chkSecondHalf').prop('checked', false);





           resetOffcanvasScrollIfNeeded('ADD');
           bsOffcanvas.show();

       }


       // Cancel Link Alert Logic
       function confirmCancel(element) {
           if (confirm(resourceKeys.ConfirmCancel)) {
               // Logic to remove row
           }
       }

       //// Check/Uncheck All Logic - only affect enabled checkboxes
       //function selectAllLeaves() {
       //    $('.chcktbl:not(:disabled)').prop('checked', true);
       //    var totalEnabled = $('.chcktbl:not(:disabled)').length;
       //    var checkedEnabled = $('.chcktbl:not(:disabled):checked').length;
       //    $('#chkSelectAll').prop('checked', totalEnabled > 0 && totalEnabled === checkedEnabled);
       //}
       //function clearAllLeaves() {
       //    $('.chcktbl:not(:disabled)').prop('checked', false);
       //    $('#chkSelectAll').prop('checked', false);
       //}
       function selectAllLeaves() {

         /*  console.log('👉 Select All clicked');*/

           isDeleteAll = true;
           selectedIDs.clear();
           excludedIDs.clear();

           $('.chcktbl:not(:disabled)').prop('checked', true);
           $('#chkSelectAll').prop('checked', true);

           logDeleteState();
       }

       function clearAllLeaves() {

          /* console.log('👉 Clear All clicked (RESET MODE)');*/

           isDeleteAll = false;
           selectedIDs.clear();
           excludedIDs.clear();

           $('.chcktbl:not(:disabled)').prop('checked', false);
           $('#chkSelectAll').prop('checked', false);

           logDeleteState();
       }




       // Header Checkbox Click - only check enabled checkboxes
       //$('#chkSelectAll').on('change', function () {
       //    var isChecked = $(this).is(':checked');
       //    $('.chcktbl:not(:disabled)').prop('checked', isChecked);
       //});
       $('#chkSelectAll').on('change', function () {

           var checked = $(this).is(':checked');

       /*    console.log('👉 Header checkbox changed:', checked);*/

           if (checked) {
               // ENTER delete-all mode
               isDeleteAll = true;
               selectedIDs.clear();
               excludedIDs.clear();

               $('.chcktbl:not(:disabled)').prop('checked', true);
           } else {
               // USER explicitly exited select-all
               isDeleteAll = false;
               selectedIDs.clear();
               excludedIDs.clear();

               $('.chcktbl:not(:disabled)').prop('checked', false);
           }

           logDeleteState();
       });




       // Individual Checkbox Click - update header checkbox based on enabled checkboxes only
       //$(document).on('change', '.chcktbl', function () {
       //    var totalEnabled = $('.chcktbl:not(:disabled)').length;
       //    var checkedEnabled = $('.chcktbl:not(:disabled):checked').length;
       //    $('#chkSelectAll').prop('checked', totalEnabled > 0 && totalEnabled === checkedEnabled);
       //});

       $(document).on('change', '.chcktbl', function () {

           var leaveID = parseInt($(this).attr('data-id')) || 0;
           var checked = $(this).is(':checked');

           //console.log('👉 Row checkbox:', leaveID, 'checked:', checked);

           if (isDeleteAll) {
               // DELETE-ALL MODE
               if (!checked) {
                   excludedIDs.add(leaveID);
               } else {
                   excludedIDs.delete(leaveID);
               }

               // Visual only
               $('#chkSelectAll').prop('checked', false);


           } else {
               // NORMAL MODE
               if (checked) {
                   selectedIDs.add(leaveID);
               } else {
                   selectedIDs.delete(leaveID);
               }
           }

           logDeleteState();
       });



       // Delete Button Logic
       $('#deleteLeaveBtn').click(function () {

           // Only count enabled checkboxes that are checked
           //var selectedCount = $('.chcktbl:not(:disabled):checked').length;

           //// ❌ No selection → show red alertify
           //if (selectedCount === 0) {
           //    alertify.error(resourceKeys.SelectOneDelete);
           //    return;
           //}

           if (!isDeleteAll && selectedIDs.size === 0) {
               alertify.error(resourceKeys.SelectOneDelete);
               return;
           }
           // If select-all is active but no actual data rows exist, treat as no selection
           if (isDeleteAll && $('.chcktbl').length === 0) {
               alertify.error(resourceKeys.SelectOneDelete);
               return;
           }

           // ✅ Selection exists → open confirmation modal
           $('#deleteLeaveConfirm').modal('show');
       });

       $('#btnDeleteLeaveYes').on('click', function () {

           $('#deleteLeaveConfirm').modal('hide');

           var employeeID = parseInt(SessionEmployeeId) || 0;

           if (!employeeID) {
               alertify.error(resourceKeys.InvalidEmpID);
               return;
           }

           if (!isDeleteAll && selectedIDs.size === 0) {
               alertify.error(resourceKeys.SelectOneDelete);
               return;
           }

           var payload = {
               employeeID: employeeID,
               isDeleteAll: isDeleteAll,
               selectedLeaveIDs: isDeleteAll ? '' : Array.from(selectedIDs).join(','),
               excludedLeaveIDs: isDeleteAll ? Array.from(excludedIDs).join(',') : '',
               filterRequestType: $('#ddlFilterRequestType').val() || '',
               filterStatus: $('#ddlFilterLeaveStatus').val() || ''
           };

           //console.log('🚀 FINAL DELETE PAYLOAD');
           //console.log(JSON.stringify(payload, null, 2));

           // 🔥 SINGLE API CALL (your backend already supports it)
           var response = AJAXCallWithResult(
               "/api/MyLeaves/DeleteEmployeeLeave",
               JSON.stringify(payload),
               false
           );

          
           if (response && response.data.DeleteEmployeeLeaveEntity[0].rowsAffected>0) {
               alertify.success(resourceKeys.LeaveDeleted);

               // RESET STATE
               isDeleteAll = false;
               selectedIDs.clear();
               excludedIDs.clear();
               $('#chkSelectAll').prop('checked', false);

               currentPageNumber = 1;
               GetMyLeaves();
           } else {
               alertify.error(resourceKeys.DeleteFailed);
           }
       });

       //function logDeleteState() {
       //    console.log('--- DELETE STATE ---');
       //    console.log('isDeleteAll:', isDeleteAll);
       //    console.log('selectedIDs:', Array.from(selectedIDs));
       //    console.log('excludedIDs:', Array.from(excludedIDs));
       //    console.log('--------------------');
       //}



       // =============================================
       // ADDED: Leave Balance Chart (API Integration)
       // =============================================

       var leaveChartInstance = null;
       // Prevent multiple re-renders
       var globalLeaveBalanceData = [];
       // Store balance data globally to reuse for table

       // =============================================
       // Function to get Employee Leave Balance from API
       // =============================================
       function GetEmployeeLeaveBalance() {
           var employeeID = parseInt(SessionEmployeeId) || 0;

           if (!employeeID || employeeID <= 0) {
               // If no employee ID, render chart with empty data
               globalLeaveBalanceData = [];
               renderLeaveBalanceChart([]);
               return;
           }

           var requestParam = {
               EmployeeID: employeeID
           };
           var param = JSON.stringify(requestParam);
           var response = AJAXCallWithResult("/api/MyLeaves/GetEmployeeLeaveBalance", param, false);

           var balanceData = [];
           if (response && response.data) {
               var responseData = response.data;
               // Extract EmployeeLeaveBalanceEntity array
               if (responseData.EmployeeLeaveBalanceEntity && Array.isArray(responseData.EmployeeLeaveBalanceEntity)) {
                   balanceData = responseData.EmployeeLeaveBalanceEntity;
               }
           }

           // Store data globally for reuse in table
           globalLeaveBalanceData = balanceData;
           // Render chart with API data
           renderLeaveBalanceChart(balanceData);
       }

       // =============================================
       // Function to render Leave Balance Chart
       // =============================================
       function renderLeaveBalanceChart(balanceData) {

           var ctx = document.getElementById('leaveBalanceChart');
           if (!ctx) return;

           // Destroy existing chart if already created
           if (leaveChartInstance) {
               leaveChartInstance.destroy();
           }

           // Prepare chart data from API response
           var labels = [];
           var entitlementData = [];
           var balanceDataArray = [];

           if (balanceData && Array.isArray(balanceData) && balanceData.length > 0) {
               balanceData.forEach(function (item) {
                   labels.push(item.leaveType || '');
                   entitlementData.push(item.leaveEntitlement || 0);
                   balanceDataArray.push(item.balanceLeaves || 0);
               });
           } else {
               // If no data, show empty chart
               labels = [resourceKeys.NoData];
               entitlementData = [0];
               balanceDataArray = [0];
           }

           // Create chart with API data
           leaveChartInstance = new Chart(ctx, {
               type: 'bar',
               data: {
                   labels: labels,
                   datasets: [
                       {
                           label: resourceKeys.TotalEntitled,
                           data: entitlementData,
                           backgroundColor: '#93c5fd',
                           categoryPercentage: 0.45, // controls group width
                           barPercentage: 0.7        // controls bar width inside group
                       },
                       {
                           label: resourceKeys.Balance,
                           data: balanceDataArray,
                           backgroundColor: '#22c55e',
                           categoryPercentage: 0.45, // controls group width
                           barPercentage: 0.7        // controls bar width inside group
                       }
                   ]
               },
               options: {
                   responsive: true,
                   maintainAspectRatio: false,
                   plugins: {
                       legend: {
                           position: 'bottom'
                       }
                   },
                   scales: {
                       y: {
                           beginAtZero: true,
                           ticks: { stepSize: 2 }
                       }
                   }
               }
           });
       }

       // =============================================
       // Function to populate Leave Balance table in offcanvas
       // Uses globalLeaveBalanceData that was fetched for the graph
       // =============================================
       function populateLeaveBalanceTable() {
        // Commented and added by Vaibhav K on 11-03-26 for adding pagaination
           //var tbody = $('#leaveBalanceTblBody');
           //var totalRecordsSpan = $('#leaveBalanceTotalRecords');

           //if (!tbody.length) {
           //    return;
           //    // Table doesn't exist, skip
           //}

           //// Clear existing rows
           //tbody.empty();
           //// Use global data that was already fetched for the graph
           //var balanceData = globalLeaveBalanceData || [];

           //if (balanceData && Array.isArray(balanceData) && balanceData.length > 0) {
           //    balanceData.forEach(function (item) {
           //        var leaveType = item.leaveType || '';
           //        var leaveEntitlement = item.leaveEntitlement || 0;
           //        var balanceLeaves = item.balanceLeaves || 0;

           //        // Format numbers to 2 decimal places
           //        var formattedEntitlement = parseFloat(leaveEntitlement).toFixed(2);
           //        var formattedBalance = parseFloat(balanceLeaves).toFixed(2);

           //        var row = $('<tr>');
           //        row.append($('<td>').text(leaveType));
           //        row.append($('<td>').text(formattedEntitlement));
           //        row.append($('<td>').text(formattedBalance));

           //        tbody.append(row);
           //    });
           //    // Update total records
           //    if (totalRecordsSpan.length) {
           //        totalRecordsSpan.text(balanceData.length);
           //    }
           //} else {
           //    // No data - show empty message
           //    var emptyRow = $('<tr>');
           //    emptyRow.append($('<td>').attr('colspan', '3').addClass('text-center text-muted').text(resourceKeys.NoDataAvailable));
           //    tbody.append(emptyRow);

           //    if (totalRecordsSpan.length) {
           //        totalRecordsSpan.text('0');
           //    }
           //}

           lbAllData = globalLeaveBalanceData || [];
           lbCurrentPage = 1;
           lbTotalPages = Math.max(1, Math.ceil(lbAllData.length / lbPageSize));
           lbRenderPage();
         // End of Commented and added by Vaibhav K on 11-03-26 for adding pagaination


       }

       // =============================================
       // ADDED: Initialize date pickers for Apply Leave
       // Uses same logic as old My Leaves page
       // =============================================

       function initApplyLeaveDatePickers() {

           // Applied Date
           $('#txtAppliedDate').datepicker({
               //autoclose: true,
               //changeMonth: true,
               //changeYear: true,
               dateFormat: 'dd M yy'
           }).datepicker('setDate', new Date()).datepicker('disable');
           // From Date
           $('#txtFromDate').datepicker({
               autoclose: true,
               changeMonth: true,
               changeYear: true,
               dateFormat: 'dd M yy',
               //onSelect: function (selectedDate) {
               //    $('#txtToDate').datepicker('option', 'minDate', selectedDate);
               //}
           });
           // To Date
           $('#txtToDate').datepicker({
               autoclose: true,
               changeMonth: true,
               changeYear: true,
               dateFormat: 'dd M yy',
               //onSelect: function (selectedDate) {
               //    $('#txtFromDate').datepicker('option', 'maxDate', selectedDate);
               //}
           });
       }

       function openLeaveFromRow(el) {

           // Get current row
           var row = $(el).closest('tr');
           // Get leaveID from row data attribute
           var leaveID = row.attr('data-id') || row.data('id') || 0;

           //  SET Global ID for Edit Mode
           editingLeaveID = leaveID;

           resetOffcanvasScrollIfNeeded('ROW_' + leaveID);


           if (!leaveID || leaveID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidLeaveID);
               return;
           }

           // ❌ HIDE Save button (View/Edit flow)
           /* =====================================================
         🔄 Change Save → Resubmit for Rejected leaves
          ===================================================== */

           var $saveBtn = $('#btnSaveLeave').first();
           // Get status from badge text (this is the SOURCE OF TRUTH)
           var statusText = row.find('.badge').text().trim().toLowerCase();

           if ($saveBtn.length) {
               var status = statusText;
               if (status == 'rejected') {

                   // ✅ Rejected → Resubmit
                   $saveBtn
                       .text(resourceKeys.Resubmit)

                       .prop('disabled', false)
                       .show();


               } else {
                   $('#btnSaveLeave').hide();

               }
           }



           // Open offcanvas first
           var offcanvasEl = document.getElementById('offcanvas_ApplyLeave');
           var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);

           if (!bsOffcanvas) {
               bsOffcanvas = new bootstrap.Offcanvas(offcanvasEl);
           }

           // RESET FIRST
           resetApplyLeaveForm();



           // ✅ CALL THE NEW FUNCTION HERE
           GetEmployeeLeaveMasterStats();

           // Show offcanvas
           bsOffcanvas.show();
           // Call API to get leave details
           GetEmployeeLeaveDetailsByLeaveID(leaveID);
       }

       // =============================================
       // Function to get Employee Leave Details by LeaveID
       // =============================================
       function GetEmployeeLeaveDetailsByLeaveID(leaveID) {
           if (!leaveID || leaveID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidLeaveID);
               return;
           }

           var requestParam = {
               LeaveID: leaveID
           };
           var param = JSON.stringify(requestParam);
           var response = AJAXCallWithResult("/api/MyLeaves/GetEmployeeLeaveDetailsByLeaveID", param, false);

           var leaveDetails = null;
           if (response && response.data) {
               var responseData = response.data;
               // Extract EmployeeLeaveDetailsByLeaveIDEntity array
               if (responseData.EmployeeLeaveDetailsByLeaveIDEntity && Array.isArray(responseData.EmployeeLeaveDetailsByLeaveIDEntity) && responseData.EmployeeLeaveDetailsByLeaveIDEntity.length > 0) {
                   leaveDetails = responseData.EmployeeLeaveDetailsByLeaveIDEntity[0];
               }
           }

           if (leaveDetails) {
               // Populate offcanvas fields with API data
               populateLeaveDetailsInOffcanvas(leaveDetails);
           } else {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.LoadDetailsFailed);
           }
       }

       // =============================================
       // Function to populate leave details in offcanvas
       // =============================================
       function populateLeaveDetailsInOffcanvas(leaveDetails) {

           resetApplyLeaveForm(); // reset


           // Initialize date pickers first (but don't set default date for Applied Date)
           initApplyLeaveDatePickersForEdit();
           // Wait for offcanvas to be fully shown before populating dropdowns
           var offcanvasEl = document.getElementById('offcanvas_ApplyLeave');
           if (offcanvasEl) {
               // Use offcanvas shown event to ensure it's fully rendered
               var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
               if (bsOffcanvas && offcanvasEl.classList.contains('show')) {
                   // Offcanvas is already shown, populate immediately with delay for selectpicker
                   setTimeout(function () {
                       populateFields(leaveDetails);
                   }, 300);
               } else {
                   // Wait for offcanvas to be shown
                   $(offcanvasEl).one('shown.bs.offcanvas', function () {
                       setTimeout(function () {
                           populateFields(leaveDetails);
                       }, 300);
                   });
               }
           } else {
               populateFields(leaveDetails);
           }
       }

       // =============================================
       // Initialize date pickers for edit mode (without default date)
       // =============================================
       function initApplyLeaveDatePickersForEdit() {
           // Applied Date - initialize without setting default date
           if (!$('#txtAppliedDate').data('datepicker')) {
               $('#txtAppliedDate').datepicker({
                   autoclose: true,
                   changeMonth: true,
                   changeYear: true,
                   dateFormat: 'dd M yy'
               });
           }

           // From Date
           if (!$('#txtFromDate').data('datepicker')) {
               $('#txtFromDate').datepicker({
                   autoclose: true,
                   changeMonth: true,
                   changeYear: true,
                   dateFormat: 'dd M yy',
                   //onSelect: function (selectedDate) {
                   //    $('#txtToDate').datepicker('option', 'minDate', selectedDate);
                   //}
               });
           }

           // To Date
           if (!$('#txtToDate').data('datepicker')) {
               $('#txtToDate').datepicker({
                   autoclose: true,
                   changeMonth: true,
                   changeYear: true,
                   dateFormat: 'dd M yy',
                   //onSelect: function (selectedDate) {
                   //    $('#txtFromDate').datepicker('option', 'maxDate', selectedDate);
                   //}
               });
           }
       }

       // =============================================
       // Helper function to populate fields
       // =============================================
       function populateFields(leaveDetails) {
           // Applied Date - format using datepicker formatDate
           if (leaveDetails.appliedDate) {
               try {
                   var appliedDateObj = new Date(leaveDetails.appliedDate);
                   if (!isNaN(appliedDateObj.getTime())) {
                       // Set date using datepicker setDate method (it will format according to dateFormat option)
                       $('#txtAppliedDate').datepicker('setDate', appliedDateObj);
                   }
               } catch (e) {
                   console.error('Error formatting applied date:', e);
               }
           }




           // Initialize and set dropdown values
           setDropdownValues(leaveDetails);
       }

       // =============================================
       // Helper function to set dropdown values
       // =============================================
       function setDropdownValues(leaveDetails) {
           // Initialize selectpicker if not already initialized
           if (typeof $.fn.selectpicker !== 'undefined') {
               var $requestTypeSelect = $('#ddlRequestTypeApply');
               var $leaveTypeSelect = $('#ddlLeaveTypes');

               // Initialize Request Type dropdown
               if ($requestTypeSelect.length && !$requestTypeSelect.data('selectpicker')) {
                   $requestTypeSelect.selectpicker();
               }

               // Initialize Leave Type dropdown
               if ($leaveTypeSelect.length && !$leaveTypeSelect.data('selectpicker')) {
                   $leaveTypeSelect.selectpicker();
               }
           }

           // Request Type dropdown (leaveOrWFH: "L" = Leave, "W" = Work From Home)
           if (leaveDetails.leaveOrWFH && $('#ddlRequestTypeApply').length) {
               var requestTypeValue = String(leaveDetails.leaveOrWFH).trim().toUpperCase();
               var $requestTypeSelect = $('#ddlRequestTypeApply');

               // Try to find option by value or text
               var selectedValue = null;
               var allOptions = $requestTypeSelect.find('option');

               allOptions.each(function () {
                   var $option = $(this);
                   var optionValue = String($option.val()).trim();
                   var optionText = String($option.text()).trim().toLowerCase();

                   // First try: exact value match (case insensitive)
                   if (optionValue.toUpperCase() === requestTypeValue) {
                       selectedValue = optionValue;
                       return false;
                   }

                   // Second try: match by text content
                   if (requestTypeValue === 'L') {
                       // Looking for "Leave" option
                       if (optionText === 'leave' || (optionText.indexOf('leave') !== -1 && optionText.indexOf('work') === -1)) {
                           selectedValue = optionValue;
                           return false;
                       }
                   } else if (requestTypeValue === 'W') {
                       // Looking for "Work From Home" option
                       if (optionText.indexOf('work') !== -1 || optionText.indexOf('wfh') !== -1 || optionText.indexOf('home') !== -1) {
                           selectedValue = optionValue;
                           return false;
                       }
                   }
               });
               // Set value if found
               if (selectedValue !== null) {
                   // Set value on native select element
                   var nativeSelect = $requestTypeSelect[0];
                   if (nativeSelect) {
                       nativeSelect.value = selectedValue;
                   }
                   $requestTypeSelect.val(selectedValue);
                   // Refresh selectpicker to update display
                   if (typeof $.fn.selectpicker !== 'undefined') {
                       $requestTypeSelect.selectpicker('refresh');
                       // Verify value was set
                       setTimeout(function () {
                           if ($requestTypeSelect.val() !== selectedValue) {
                               nativeSelect.value = selectedValue;
                               $requestTypeSelect.selectpicker('refresh');
                           }
                           // Handle Request Type change to show/hide Leave Type
                           handleRequestTypeChange();
                       }, 50);
                   } else {
                       // Handle Request Type change immediately if selectpicker not used
                       handleRequestTypeChange();
                   }
               }
           } else {
               // If no Request Type value, ensure Leave Type is visible
               handleRequestTypeChange();
           }

           // Leave Type dropdown (using leaveTypeID)
           if (leaveDetails.leaveTypeID && $('#ddlLeaveTypes').length) {
               var $leaveTypeSelect = $('#ddlLeaveTypes');
               var leaveTypeID = parseInt(leaveDetails.leaveTypeID) || 0;

               if (leaveTypeID > 0) {
                   // Set value on native select element
                   var nativeSelect = $leaveTypeSelect[0];
                   if (nativeSelect) {
                       nativeSelect.value = leaveTypeID;
                   }
                   $leaveTypeSelect.val(leaveTypeID);
                   // Check if value was set correctly
                   var newVal = $leaveTypeSelect.val();
                   if (newVal != leaveTypeID && newVal != String(leaveTypeID)) {
                       // Try as string
                       if (nativeSelect) {
                           nativeSelect.value = String(leaveTypeID);
                       }
                       $leaveTypeSelect.val(String(leaveTypeID));
                   }

                   // Refresh selectpicker to update display
                   if (typeof $.fn.selectpicker !== 'undefined') {
                       $leaveTypeSelect.selectpicker('refresh');
                       // Verify value was set
                       setTimeout(function () {
                           var verifyVal = $leaveTypeSelect.val();
                           if (verifyVal != leaveTypeID && verifyVal != String(leaveTypeID)) {
                               if (nativeSelect) {
                                   nativeSelect.value = leaveTypeID;
                               }
                               $leaveTypeSelect.selectpicker('refresh');
                           }
                       }, 50);
                   }
               }
           }

           // From Date - set using datepicker setDate method
           if (leaveDetails.fromDate) {
               try {
                   var fromDateObj = new Date(leaveDetails.fromDate);
                   if (!isNaN(fromDateObj.getTime())) {
                       $('#txtFromDate').datepicker('setDate', fromDateObj);
                   }
               } catch (e) {
                   console.error('Error formatting from date:', e);
               }
           }

           // To Date - set using datepicker setDate method
           if (leaveDetails.toDate) {
               try {
                   var toDateObj = new Date(leaveDetails.toDate);
                   if (!isNaN(toDateObj.getTime())) {
                       $('#txtToDate').datepicker('setDate', toDateObj);
                   }
               } catch (e) {
                   console.error('Error formatting to date:', e);
               }
           }

           // First Half Day checkbox
           var firstHalfChecked = false;
           if (leaveDetails.firstHalfDay !== undefined && leaveDetails.firstHalfDay !== null) {
               firstHalfChecked = leaveDetails.firstHalfDay === true || leaveDetails.firstHalfDay === 'true';
               $('#chkFirstHalf').prop('checked', firstHalfChecked);
           }

           // Second Half Day checkbox
           var secondHalfChecked = false;
           if (leaveDetails.secondHalfDay !== undefined && leaveDetails.secondHalfDay !== null) {
               secondHalfChecked = leaveDetails.secondHalfDay === true || leaveDetails.secondHalfDay === 'true';
               $('#chkSecondHalf').prop('checked', secondHalfChecked);
           }

           // Ensure only one checkbox is checked (mutually exclusive)
           // If both are checked, prioritize First Half Day
           if (firstHalfChecked && secondHalfChecked) {
               $('#chkSecondHalf').prop('checked', false);
           }

           // Address
           if (leaveDetails.address) {
               $('#txtAddress').val(leaveDetails.address);
           }

           // Reason
           if (leaveDetails.reason) {
               $('#txtReason').val(leaveDetails.reason);
           }

           // Telephone
           if (leaveDetails.telephone) {
               $('#txtTelephone').val(leaveDetails.telephone);
           }


           // Disable fields if status is Approved
           var status = leaveDetails.leaveStatus || '';
           if (status.toLowerCase() === 'approved') {
               $('#offcanvas_ApplyLeave input, #offcanvas_ApplyLeave select, #offcanvas_ApplyLeave textarea')
                   .prop('disabled', true);
           } else {
               $('#offcanvas_ApplyLeave input, #offcanvas_ApplyLeave select, #offcanvas_ApplyLeave textarea')
                   .prop('disabled', false);
           }

           //  DISABLE APPLIED DATE (Permanently No Edit)
           $('#txtAppliedDate').prop('disabled', true);
       }

       // =============================================
       // Helper function to format date for input fields (dd MM yy format)
       // =============================================
       function formatDateForInput(dateString) {
           if (!dateString) return '';
           try {
               var dateObj = new Date(dateString);
               if (!isNaN(dateObj.getTime())) {
                   // Format as dd MM yy for datepicker
                   var day = String(dateObj.getDate()).padStart(2, '0');
                   var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                   var year = String(dateObj.getFullYear()).substring(2);
                   return day + ' ' + month + ' ' + year;
               }
           } catch (e) {
               // If parsing fails, return original string
           }
           return dateString;
       }

       // =============================================
       // ADDED: Initialize when Apply Leave offcanvas opens
       // (required because offcanvas content is hidden initially)
       // =============================================

       // =============================================
       // Function to handle Request Type dropdown change
       // Shows/hides Leave Type dropdown based on selection
       // =============================================

       function handleRequestTypeChange() {
           var $requestTypeSelect = $('#ddlRequestTypeApply');
           var $leaveTypeContainer = $('#leaveTypeContainer');
           var $workFromHomeInfo = $('#workFromHomeInfo');

           if (!$requestTypeSelect.length) {
               return;
           }

           var selectedValue = $requestTypeSelect.val();
           var selectedText = $requestTypeSelect.find('option:selected').text().trim().toLowerCase();
           // Check if Work From Home is selected (by value "W" or text contains "work" or "wfh")
           var isWorkFromHome = false;
           if (selectedValue && (selectedValue.toUpperCase() === 'W' || selectedValue.toLowerCase() === 'work from home')) {
               isWorkFromHome = true;
           } else if (selectedText && (selectedText.indexOf('work') !== -1 || selectedText.indexOf('wfh') !== -1)) {
               isWorkFromHome = true;
           }

           if (isWorkFromHome) {
               // Hide Leave Type dropdown, show informational text
               $leaveTypeContainer.hide();
               $workFromHomeInfo.show();

               // Clear Leave Type selection
               var $leaveTypeSelect = $('#ddlLeaveTypes');
               if ($leaveTypeSelect.length) {
                   $leaveTypeSelect.val('');
                   if (typeof $.fn.selectpicker !== 'undefined' && $leaveTypeSelect.data('selectpicker')) {
                       $leaveTypeSelect.selectpicker('refresh');
                   }
               }
               // commented as we now ALLOW Half Day for WFH.
               //// Disable and uncheck First Half Day and Second Half Day checkboxes
               //$('#chkFirstHalf').prop('disabled', true).prop('checked', false);
               //$('#chkSecondHalf').prop('disabled', true).prop('checked', false);
           } else {
               // Show Leave Type dropdown, hide informational text
               $leaveTypeContainer.show();
               $workFromHomeInfo.hide();




               var $leaveTypeSelect = $('#ddlLeaveTypes');
               if ($leaveTypeSelect.length && (!$leaveTypeSelect.val() || $leaveTypeSelect.val() === '')) {
                   // Select the first option (which is usually "Select Leave Type")
                   var defaultVal = $leaveTypeSelect.find('option:first').val();
                   $leaveTypeSelect.val(defaultVal);

                   // Refresh selectpicker to update UI from "Nothing selected" to "Select Leave Type"
                   if (typeof $.fn.selectpicker !== 'undefined' && $leaveTypeSelect.data('selectpicker')) {
                       $leaveTypeSelect.selectpicker('refresh');
                   }
               }


               // commented as we now ALLOW Half Day for WFH.
               // Enable First Half Day and Second Half Day checkboxes
               //$('#chkFirstHalf').prop('disabled', false);
               //$('#chkSecondHalf').prop('disabled', false);

               // Ensure only one checkbox is checked (mutually exclusive)
               // If both are checked, prioritize First Half Day
               if ($('#chkFirstHalf').is(':checked') && $('#chkSecondHalf').is(':checked')) {
                   $('#chkSecondHalf').prop('checked', false);
               }
           }
       }

       // =============================================
       // Function to handle mutually exclusive checkbox behavior
       // Only one checkbox (First Half Day or Second Half Day) can be checked at a time
       // =============================================
       function handleCheckboxMutualExclusive() {
           // First Half Day checkbox change handler
           $(document).on('change', '#chkFirstHalf', function () {
               if ($(this).is(':checked') && !$(this).prop('disabled')) {
                   // If First Half Day is checked, uncheck Second Half Day
                   $('#chkSecondHalf').prop('checked', false);
               }
           });
           // Second Half Day checkbox change handler
           $(document).on('change', '#chkSecondHalf', function () {
               if ($(this).is(':checked') && !$(this).prop('disabled')) {
                   // If Second Half Day is checked, uncheck First Half Day
                   $('#chkFirstHalf').prop('checked', false);
               }
           });
       }

       // ADDED: ensure bootstrap + jQuery are ready before binding
       $(document).ready(function () {

           // Hide preloader, show main content
           $("#MyLeavesSec").hide();

           var applyLeaveCanvas = document.getElementById('offcanvas_ApplyLeave');

           if (applyLeaveCanvas) {
               applyLeaveCanvas.addEventListener('shown.bs.offcanvas', function () {
                   initApplyLeaveDatePickers();

                   // Initialize Request Type change handler
                   handleRequestTypeChange();

                   // Get Approver Name
                   GetLeaveApproverName();
               });


           }


           // Add change event handler for Request Type dropdown
           $(document).on('changed.bs.select', '#ddlRequestTypeApply', function () {
               handleRequestTypeChange();
           });

           // Also handle native change event as fallback
           $(document).on('change', '#ddlRequestTypeApply', function () {
               // Only trigger if selectpicker is not initialized (fallback)
               if (typeof $.fn.selectpicker === 'undefined' || !$(this).data('selectpicker')) {
                   handleRequestTypeChange();
               }
           });
           // Initialize mutually exclusive checkbox behavior
           handleCheckboxMutualExclusive();
           // Populate Leave Balance table when offcanvas opens
           var leaveBalanceCanvas = document.getElementById('offcanvas_LeaveBalance');
           if (leaveBalanceCanvas) {
               leaveBalanceCanvas.addEventListener('shown.bs.offcanvas', function () {
                   populateLeaveBalanceTable();
               });
           }


           function GetLeaveApproverName() {
               // ✅ If already fetched, reuse
               if (cachedLeaveApproverName) {
                   $('#spnLeaveApprover').text(cachedLeaveApproverName);
                   return;
               }


               var employeeID = parseInt(SessionEmployeeId) || 0;

               if (!employeeID || employeeID <= 0) {
                   $('#spnLeaveApprover').text('-');
                   return;
               }

               var requestParam = {
                   EmployeeID: employeeID
               };

               var response = AJAXCallWithResult(
                   "/api/MyLeaves/GetApproverName",
                   JSON.stringify(requestParam),
                   false
               );

               //if (response && response.data && response.data.approverName.reportingToName) {
               //    $('#spnLeaveApprover').text(response.data.reportingToName);
               //} else {
               //    $('#spnLeaveApprover').text('-');
               //}

               // Approver Name
               if (
                   response &&
                   response.approverName &&
                   Array.isArray(response.approverName) &&
                   response.approverName.length > 0 &&
                   response.approverName[0].reportingToName
               ) {
                   cachedLeaveApproverName = response.approverName[0].reportingToName;
                   $('#spnLeaveApprover').text(response.approverName[0].reportingToName);
               } else {
                   $('#spnLeaveApprover').text('');
               }
           }

          // Added by Vaibhav K on 11-03-26 for calander icon
           // Calendar icon click opens datepicker
           $(document).on('click', '#txtFromDateIcon', function () {
               $('#txtFromDate').datepicker('show');
           });
           $(document).on('click', '#txtToDateIcon', function () {
               $('#txtToDate').datepicker('show');
           });
       }
       );



       // =============================================
       // ADDED: Render chart ONLY when offcanvas opens
       // =============================================


       $(document).ready(function () {
           // Initialize selectpicker for filter dropdowns if not already initialized
           if (typeof $.fn.selectpicker !== 'undefined') {
               setTimeout(function () {
                   if ($('#ddlFilterRequestType').length && !$('#ddlFilterRequestType').data('selectpicker')) {
                       $('#ddlFilterRequestType').selectpicker();
                   }
                   if ($('#ddlFilterLeaveStatus').length && !$('#ddlFilterLeaveStatus').data('selectpicker')) {
                       $('#ddlFilterLeaveStatus').selectpicker();
                   }
               }, 100);
           }

           showLoader();
           // Load leave balance chart data on page load
           GetEmployeeLeaveBalance();

           // Load leaves data on page load
           GetMyLeaves();
           // Add change event handlers for filter dropdowns
           hideLoader();
           // When filter changes, reset to page 1 and reload data
           $(document).on('changed.bs.select', '#ddlFilterRequestType, #ddlFilterLeaveStatus', function () {
               currentPageNumber = 1; // Reset to first page when filter changes
               GetMyLeaves();
           });

           // Also handle native change event as fallback
           $(document).on('change', '#ddlFilterRequestType, #ddlFilterLeaveStatus', function () {
               // Only trigger if selectpicker is not initialized (fallback)
               if (typeof $.fn.selectpicker === 'undefined' || !$(this).data('selectpicker')) {
                   currentPageNumber = 1; // Reset to first page when filter changes
                   GetMyLeaves();
               }
           });

           // Fetch approver name once on page load
           GetLeaveApproverName();

       });


       // =============================================
       // Function to get My Leaves list
       // =============================================
       function GetMyLeaves() {
           var employeeID = parseInt(SessionEmployeeId) || 0;



           if (!employeeID || employeeID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidEmpID);
               return;
           }

           // Get filter values from dropdowns
           var leaveOrWFH = $('#ddlFilterRequestType').val() || null;
           var leaveStatusID = $('#ddlFilterLeaveStatus').val() || null;

           // Convert empty string to null
           if (leaveOrWFH === '' || leaveOrWFH === '0') {
               leaveOrWFH = null;
           }
           if (leaveStatusID === '' || leaveStatusID === '0') {
               leaveStatusID = null;
           }

           // Convert leaveStatusID to integer if not null
           if (leaveStatusID !== null) {
               leaveStatusID = parseInt(leaveStatusID) || null;
           }

           var requestParam = {
               EmployeeID: employeeID,
               PageNo: currentPageNumber,
               PageSize: pageSize,
               leaveOrWFH: leaveOrWFH,
               leaveStatusID: leaveStatusID
           };
           // Destroy existing DataTable if it exists
           if ($.fn.DataTable.isDataTable('#LeavesTbl')) {
               $('#LeavesTbl').DataTable().destroy();
           }

           // Clear table body
           $("#LeavesTbl_body").empty();
           var param = JSON.stringify(requestParam);
           var response = AJAXCallWithResult("/api/MyLeaves/GetMyLeaves", param, false);
           if (response && response.data) {
               var responseData = response.data;
               // Handle different response structures
               var data = null;
               var pagination = null;

               if (Array.isArray(responseData)) {
                   data = responseData;
               } else if (responseData && Array.isArray(responseData.My_LeavesEntity)) {
                   data = responseData.My_LeavesEntity;
                   // Extract pagination info
                   if (responseData.LeavePaginationEntity && Array.isArray(responseData.LeavePaginationEntity) && responseData.LeavePaginationEntity.length > 0) {
                       pagination = responseData.LeavePaginationEntity[0];
                   }
               } else if (responseData && Array.isArray(responseData.leaves)) {
                   data = responseData.leaves;
               } else if (responseData && Array.isArray(responseData.leaveEntity)) {
                   data = responseData.leaveEntity;
               }

               // Update pagination info if available
               if (pagination) {
                   totalRecords = pagination.totalRecords || 0;
                   totalPages = pagination.totalPages || 1;
                   currentPageNumber = pagination.currentPage || currentPageNumber;
               } else {
                   totalRecords = 0;
                   totalPages = 1;
               }

               // Bind data to table
               var tbody = $("#LeavesTbl_body");
               if (data && Array.isArray(data) && data.length > 0) {
                   data.forEach(function (leave) {
                       var leaveId = leave.leaveID || leave.LeaveID || 0;
                       var fromDate = leave.fromDate || leave.FromDate || '';
                       var toDate = leave.toDate || leave.ToDate || '';
                       var leaveType = leave.leaveType || leave.LeaveType || '';
                       var status = leave.leaveStatus || leave.status || leave.Status || '';
                       var comments = leave.viewComments || leave.comments || leave.Comments || '';
                       var hasComments = comments && comments !== null && comments.trim() !== '';
                       var isDelete = leave.isDelete !== undefined ? leave.isDelete : (leave.IsDelete !== undefined ? leave.IsDelete : 1); // Default to 1 (enabled) if not provided

                       // Format dates if needed
                       var formattedFromDate = formatDate(fromDate);
                       var formattedToDate = formatDate(toDate);

                       var row = $('<tr>').attr('data-id', leaveId);

                       // From Date column
                       //row.append($('<td>').text(formattedFromDate));
                       row.append($('<td>').text(formattedFromDate).addClass('textUndrln').css('cursor', 'pointer').attr('onclick', 'openLeaveFromRow(this)'));




                       // To Date column
                       row.append($('<td>').text(formattedToDate));
                       // Type column
                       row.append($('<td>').text(leaveType));
                       // Status column with badge
                       var statusBadge = $('<span>').addClass('badge');
                       var statusLower = status.toLowerCase();
                       if (statusLower === 'approved') {
                           statusBadge.addClass('bg-success').text(status);
                       } else if (statusLower === 'rejected') {
                           statusBadge.addClass('bg-danger').text(status);
                       } else if (statusLower === 'cancelled') {
                           statusBadge.addClass('bg-secondary').text(status);
                           //statusBadge.attr('onclick', 'openLeaveFromRow(this)');
                       } else {
                           statusBadge.addClass('bg-primary').text(status);
                           //statusBadge.attr('onclick', 'openLeaveFromRow(this)');
                       }
                       //statusBadge.attr('onclick', 'openLeaveFromRow(this)');

                       //Add cursor: pointer to make it look clickable
                       //statusBadge.attr('onclick', 'openLeaveFromRow(this)').css('cursor', 'pointer');


                       row.append($('<td>').append(statusBadge));
                       //// Comments column
                       var canViewComments =
                           leave.canViewComment === 1 ||
                           leave.canViewComment === true ||
                           leave.canViewComment === 1 ||
                           leave.canViewComment === true;

                       var commentIcon = $('<i>');
                       if (canViewComments) {
                           // ✅ Clickable (PRIMARY)
                           commentIcon
                               .addClass('fas fa-comment-dots text-primary')
                               .attr('title', 'View Comments')
                               .css('cursor', 'pointer')
                               .attr('onclick', 'openViewComment(this)');
                       } else {
                           // ❌ Not clickable (SECONDARY)
                           commentIcon
                               .addClass('far fa-comment-dots text-secondary')
                               .attr('title', 'Comments not available')
                               .css('cursor', 'not-allowed');
                           // ❌ NO onclick
                       }

                       row.append($('<td>').append(commentIcon));
                       // Action column
                       var actionCell = $('<td>');
                       if (statusLower === 'approved' || statusLower === 'cancelled') {
                           actionCell.append($('<span>').addClass('text-muted').text('-'));
                       } else {
                           var cancelLink = $('<a>')
                               .attr('href', 'javascript:;')
                               .addClass('textUndrln text-primary')
                               .text('Cancel')
                               .attr('onclick', 'showCancelConfirmation(this)')
                               .attr('data-leave-id', leaveId);
                           actionCell.append(cancelLink);
                       }
                       row.append(actionCell);
                       // Checkbox column
                       var checkboxCell = $('<td>').addClass('text-center');
                       var checkbox = $('<input>')
                           .attr('type', 'checkbox')
                           .addClass('chcktbl')
                           .attr('data-id', leaveId)
                           .attr('value', leaveId);
                       // Enable/disable checkbox based on isDelete flag
                       // isDelete = 0 → disabled, isDelete = 1 → enabled
                       if (isDelete === 0 || isDelete === '0' || isDelete === false) {
                           checkbox.prop('disabled', true);
                       } else {
                           checkbox.prop('disabled', false);
                       }

                       checkboxCell.append(checkbox);
                       row.append(checkboxCell);

                       tbody.append(row);

                 

                   });
               }

             <%--Added by Vaibhav K for showing note on empty records on 11-03-26--%>
               else {
                   // No data row - same style as Lessons Learnt
                   tbody.append(
                       $('<tr>').append(
                           $('<td>')
                               .attr('colspan', 7)
                               .addClass('text-center text-muted')
                               .css({ 'padding': '16px 20px', 'font-size': '12px' })
                               .text(resourceKeys.NoDataList)
                       )
                   );
               }
               <%--End of Added by Vaibhav K for showing note on empty records on 11-03-26--%>

               // ===================================================
               // 🔥 RESTORE SELECTION UI AFTER TABLE BINDING
               // ===================================================
               if (isDeleteAll) {

                   /*console.log('♻ Restore DELETE-ALL mode UI');*/

                   // Header checkbox: checked ONLY if no exclusions
                   $('#chkSelectAll').prop(
                       'checked',
                       excludedIDs.size === 0
                   );

                   // Restore row states based on exclusions
                   $('.chcktbl:not(:disabled)').each(function () {
                       var id = parseInt($(this).attr('data-id')) || 0;

                       $(this).prop('checked', !excludedIDs.has(id));
                   });

               } else {

                   //console.log('♻ Restore NORMAL selection UI');

                   // Header checkbox must be unchecked
                   $('#chkSelectAll').prop('checked', false);

                   // Restore row states based on selectedIDs
                   $('.chcktbl:not(:disabled)').each(function () {
                       var id = parseInt($(this).attr('data-id')) || 0;

                       if (selectedIDs.has(id)) {
                           $(this).prop('checked', true);
                       }
                   });
               }


               // Force table width to remain stable after DataTable initialization
               setTimeout(function () {
                   $('#LeavesTbl').css({
                       'table-layout': 'fixed',
                       'width': '100%'
                   });
               }, 100);
               // Update total records and pagination buttons
               updateTotalRecords();
               updatePaginationButtons();
           } else {
               // No data or error
               totalRecords = 0;
               totalPages = 1;

               $("#LeavesTbl").DataTable({
                   paging: false,
                   pageLength: 10,
                   bLengthChange: false,
                   bFilter: false,
                   ordering: true,
                   responsive: false,
                   destroy: true,
                   retrieve: true,
                   info: false,
                   bPaginate: false,
                   autoWidth: false,
                   scrollX: false,
                   scrollCollapse: false,
                   language: {
                       emptyTable: resourceKeys.NoDataAvailable,
                       zeroRecords: resourceKeys.NoDataAvailable
                   }
               });
               setTimeout(function () {
                   $('#LeavesTbl').css({
                       'table-layout': 'fixed',
                       'width': '100%'
                   });
               }, 100);

               updateTotalRecords();
               updatePaginationButtons();
           }
       }

       // Function to get My Leaves list

       // =============================================
       // Pagination Functions
       // =============================================
       function goToPreviousPage() {
           if (currentPageNumber > 1) {
               currentPageNumber = currentPageNumber - 1;
               GetMyLeaves();
           }
       }

       function goToNextPage() {
           if (currentPageNumber < totalPages) {
               currentPageNumber = currentPageNumber + 1;
               GetMyLeaves();
           }
       }

       function updatePaginationButtons() {
           var firstBtn = document.getElementById('firstPageBtn');
           var lastBtn = document.getElementById('lastPageBtn');

           if (!firstBtn || !lastBtn) return;

           // Disable Previous button if on first page or no data
           if (currentPageNumber <= 1 || totalRecords === 0 || totalPages === 0) {
               firstBtn.disabled = true;
               firstBtn.style.opacity = '0.5';
               firstBtn.style.cursor = 'not-allowed';
               firstBtn.style.background = '#f8f9fa';
               firstBtn.style.color = '#6c757d';
           } else {
               firstBtn.disabled = false;
               firstBtn.style.opacity = '1';
               firstBtn.style.cursor = 'pointer';
               firstBtn.style.background = 'white';
               firstBtn.style.color = '#333';
           }

           // Disable Next button if on last page or no data
           if (currentPageNumber >= totalPages || totalRecords === 0 || totalPages === 0) {
               lastBtn.disabled = true;
               lastBtn.style.opacity = '0.5';
               lastBtn.style.cursor = 'not-allowed';
               lastBtn.style.background = '#f8f9fa';
               lastBtn.style.color = '#6c757d';
           } else {
               lastBtn.disabled = false;
               lastBtn.style.opacity = '1';
               lastBtn.style.cursor = 'pointer';
               lastBtn.style.background = 'white';
               lastBtn.style.color = '#333';
           }
       }
       // End of Pagination Functions

       // =============================================
       // Helper function to format date
       // =============================================
       function formatDate(dateString) {
           if (!dateString) return '';
           try {
               var dateObj = new Date(dateString);
               if (!isNaN(dateObj.getTime())) {
                   // Format as dd-MMM-yyyy
                   var day = String(dateObj.getDate()).padStart(2, '0');
                   var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                   var month = monthNames[dateObj.getMonth()];
                   var year = dateObj.getFullYear();
                   return day + '-' + month + '-' + year;
               }
           } catch (e) {
               // If parsing fails, return original string
           }
           return dateString;
       }

       // =============================================
       // Function to save leave and show email modal
       // =============================================


       function saveLeaveAndShowEmail() {
           // ==========================================
           // 1. GET & VALIDATE FORM DATA (Common Logic)
           // ==========================================
           var appliedDateObj = $('#txtAppliedDate').datepicker('getDate');
           var fromDateObj = $('#txtFromDate').datepicker('getDate');
           var toDateObj = $('#txtToDate').datepicker('getDate');

           var appliedDate = $('#txtAppliedDate').val();
           var requestType = $('#ddlRequestTypeApply').val();
           var fromDate = $('#txtFromDate').val();
           var toDate = $('#txtToDate').val();

           // Check Request Type
           var isWorkFromHome = false;
           if (requestType) {
               var requestTypeText = $('#ddlRequestTypeApply').find('option:selected').text().trim().toLowerCase();
               if (requestTypeText.indexOf('work') !== -1 || requestTypeText.indexOf('wfh') !== -1 || requestType.toUpperCase() === 'W') {
                   isWorkFromHome = true;
               }
           }

           var leaveType = '';
           if (!isWorkFromHome) {
               leaveType = $('#ddlLeaveTypes').val();
           }

           // --- Validation Checks ---
           if (!appliedDate) { alertify.error(resourceKeys.ReqAppliedDate); return; }
           if (!requestType || requestType === "Select Request Type") { alertify.error(resourceKeys.ReqRequestType); return; }
           if (!isWorkFromHome && (!leaveType || leaveType === "0")) { alertify.error(resourceKeys.ReqLeaveType); return; }
           if (!fromDate) { alertify.error(resourceKeys.ReqFromDate); return; }
           if (!toDate) { alertify.error(resourceKeys.ReqToDate); return; }
           if (fromDateObj > toDateObj) { alertify.error(resourceKeys.DateRangeError || 'To Date cannot be less than From Date'); return; }

           var address = $('#txtAddress').val() || '';
           var reason = $('#txtReason').val() || '';
           var telephone = $('#txtTelephone').val() || '';
           var firstHalfDay = $('#chkFirstHalf').is(':checked');
           var secondHalfDay = $('#chkSecondHalf').is(':checked');

           var leaveTypeID = 0;
           if (!isWorkFromHome && leaveType) { leaveTypeID = parseInt(leaveType) || 0; }

           // --- Mandatory Fields ---
           if (!address || address.trim() === '') { alertify.error(resourceKeys.ReqAddress); $('#txtAddress').focus(); return; }
           if (!reason || reason.trim() === '') { alertify.error(resourceKeys.ReqReason); $('#txtReason').focus(); return; }
           if (!telephone || telephone.trim() === '') { alertify.error(resourceKeys.ReqTelephone); $('#txtTelephone').focus(); return; }

           // Telephone Regex
           var phoneRegex = /^\+?[0-9\-]+$/;
           if (!phoneRegex.test(telephone)) { alertify.error(resourceKeys.PhoneInvalidChar); return; }
           //if (telephone.length > 13)  { alertify.error(resourceKeys.PhoneInvalidLen); return; }

           // Determine 'L' or 'W'
           var requestTypeValue = requestType;
           if (requestTypeValue) {
               var requestTypeText = $('#ddlRequestTypeApply').find('option:selected').text().trim().toLowerCase();
               if (requestTypeText.indexOf('work') !== -1 || requestTypeText.indexOf('wfh') !== -1) {
                   requestTypeValue = 'W';
               } else {
                   requestTypeValue = 'L';
               }
           }

           // --- Date ISO Conversion (Noon Fix) ---
           var appliedDateISO = null, fromDateISO = null, toDateISO = null;

           // Helper to fix date
           function getIsoAtNoon(dObj, dStr) {
               if (dObj && !isNaN(dObj.getTime())) {
                   return new Date(dObj.getFullYear(), dObj.getMonth(), dObj.getDate(), 12, 0, 0, 0).toISOString();
               }
               return convertDateToISO(dStr);
           }

           appliedDateISO = getIsoAtNoon(appliedDateObj, appliedDate);
           fromDateISO = getIsoAtNoon(fromDateObj, fromDate);
           toDateISO = getIsoAtNoon(toDateObj, toDate);

           if (!appliedDateISO || !fromDateISO || !toDateISO) {
               alertify.error(resourceKeys.InvalidDates);
               return;
           }

           var employeeID = parseInt(SessionEmployeeId) || 0;
           var userName = UserName || '';

           // ==========================================
           // 2. CHECK BUTTON MODE: SAVE OR RESUBMIT?
           // ==========================================
           var btnText = $('#btnSaveLeave').text().trim();
           // Check local resource string or literal "Resubmit"
           var isResubmit = (btnText === resourceKeys.Resubmit || btnText === 'Resubmit');

           if (isResubmit) {
               // =======================
               //      UPDATE LOGIC
               // =======================
               if (!editingLeaveID || editingLeaveID <= 0) {
                   alertify.error(resourceKeys.InvalidLeaveIDForUpdate);
                   return;
               }

               var updateReq = {
                   LeaveID: editingLeaveID,
                   AppliedDate: appliedDateISO,
                   LeaveOrWFH: requestTypeValue,
                   LeaveTypeID: leaveTypeID,
                   FromDate: fromDateISO,
                   ToDate: toDateISO,
                   FirstHalfDay: firstHalfDay,
                   SecondHalfDay: secondHalfDay,
                   Address: address,
                   Reason: reason,
                   Telephone: telephone,
                   EmployeeID: employeeID,
                   ModifiedBy: userName // ✅ Using ModifiedBy as per your C# Request
               };

               var response = AJAXCallWithResult("/api/MyLeaves/UpdateEmployeeLeave", JSON.stringify(updateReq), false);

               if (response.status === false || response.Status === "FAILURE") {
                   alertify.error(response.message || response.data.message || resourceKeys.LeaveUpdateFailed);
                   return;
               }

               // Success
               alertify.success(response.data.message || resourceKeys.LeaveAppliedSuccess);


               //  Close Offcanvas & Refresh Grid immediately
               var offcanvasElement = document.getElementById('offcanvas_ApplyLeave');
               var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
               if (bsOffcanvas) {
                   bsOffcanvas.hide();
               }
               // Reload grid
               currentPageNumber = 1;
               GetMyLeaves();

               // Show Email Modal (Reusing the editing ID)
               var emailMessageID = isWorkFromHome ? 482 : 68;
               populateLeaveEmailFromAPI(editingLeaveID, emailMessageID);

           } else {
               // =======================
               //      INSERT LOGIC
               // =======================
               var saveReq = {
                   appliedDate: appliedDateISO,
                   leaveOrWFH: requestTypeValue,
                   leaveTypeID: leaveTypeID,
                   fromDate: fromDateISO,
                   toDate: toDateISO,
                   firstHalfDay: firstHalfDay,
                   secondHalfDay: secondHalfDay,
                   address: address,
                   reason: reason,
                   telephone: telephone,
                   leaveStatusID: 1, // Submitted
                   employeeID: employeeID,
                   createdBy: userName // ✅ Using CreatedBy for Insert
               };

               var saveResponse = AJAXCallWithResult("/api/MyLeaves/InsertEmployeeLeave", JSON.stringify(saveReq), false);

               if (saveResponse.status === false || saveResponse.Status === "FAILURE") {
                   alertify.error(saveResponse.message);
                   bsOffcanvas.hide();
                   return;
               }

               // Extract ID
               var savedLeaveID = 0;
               if (saveResponse.data && saveResponse.data.InsertEmployeeLeaveEntity && saveResponse.data.InsertEmployeeLeaveEntity.length > 0) {
                   savedLeaveID = parseInt(saveResponse.data.InsertEmployeeLeaveEntity[0].pk) || 0;
               } else if (saveResponse.PK) {
                   savedLeaveID = parseInt(saveResponse.PK);
               }

               if (savedLeaveID > 0) {
                   alertify.success(saveResponse.message || "Leave Saved Successfully");
                   var emailMessageID = isWorkFromHome ? 482 : 68;
                   populateLeaveEmailFromAPI(savedLeaveID, emailMessageID);

                   //  Close Offcanvas & Refresh Grid immediately
                   var offcanvasElement = document.getElementById('offcanvas_ApplyLeave');
                   var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                    bsOffcanvas.hide();
                   

               } else {
                   alertify.error(resourceKeys.SaveFailed);
               }
           }
       }


       // =============================================
       // Helper function to convert date from dd MM yy to ISO format
       // Fixes timezone issue by creating date at noon local time
       // =============================================
       function convertDateToISO(dateString) {
           if (!dateString || dateString.trim() === '') {
               return null;
           }

           try {
               // Parse date from dd MM yy format (e.g., "23 12 2025")
               var parts = dateString.trim().split(' ');
               if (parts.length === 3) {
                   var day = parseInt(parts[0]);
                   var month = parseInt(parts[1]) - 1; // Month is 0-indexed
                   var year = 2000 + parseInt(parts[2]);
                   // Convert yy to yyyy

                   // Validate parsed values
                   if (isNaN(day) || isNaN(month) || isNaN(year)) {
                       console.error('Invalid date parts:', parts);
                       return null;
                   }

                   // Validate month range
                   if (month < 0 || month > 11) {
                       console.error('Invalid month:', month);
                       return null;
                   }

                   // Validate day range
                   if (day < 1 || day > 31) {
                       console.error('Invalid day:', day);
                       return null;
                   }

                   // Create date at noon local time to avoid timezone issues
                   // This ensures the date stays the same when converted to ISO
                   var dateObj = new Date(year, month, day, 12, 0, 0, 0);
                   if (!isNaN(dateObj.getTime())) {
                       // Return ISO string format: YYYY-MM-DDTHH:mm:ss.sssZ
                       return dateObj.toISOString();
                   } else {
                       console.error('Invalid date object created');
                       return null;
                   }
               } else {
                   // Try parsing as ISO string or other formats
                   var dateObj = new Date(dateString);
                   if (!isNaN(dateObj.getTime())) {
                       // If it's already a date, create at noon to avoid timezone shift
                       var year = dateObj.getFullYear();
                       var month = dateObj.getMonth();
                       var day = dateObj.getDate();
                       var fixedDate = new Date(year, month, day, 12, 0, 0, 0);
                       return fixedDate.toISOString();
                   }
                   console.error('Date format not recognized:', dateString);
                   return null;
               }
           } catch (e) {
               console.error('Error converting date:', e, dateString);
               return null;
           }
       }

       // =============================================
       // Function to populate email modal from API
       // =============================================
       function populateLeaveEmailFromAPI(leaveID, messageID) {
           if (!leaveID || leaveID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidLeaveID);
               return;
           }

           // Default messageID to 68 if not provided
           if (!messageID || messageID <= 0) {
               messageID = 68;
               // Default to Leave messageID
           }

           // Step 1: Get CC emails from two APIs
           var ccEmailList = [];
           // Call GetApproverEmailCC
           var approverCCParam = {
               leaveID: leaveID,
               messageID: messageID
           };
           var approverCCResponse = AJAXCallWithResult("/api/MyLeaves/GetApproverEmailCC", JSON.stringify(approverCCParam), false);

           if (approverCCResponse && approverCCResponse.data && approverCCResponse.data.ApproverEmailCCEntity) {
               approverCCResponse.data.ApproverEmailCCEntity.forEach(function (item) {
                   if (item.emailID && item.emailID.trim() !== '') {
                       ccEmailList.push(item.emailID.trim());
                   }
               });
           }

           // Call GetEmailMessageMailIDForCC
           var emailCCParam = {
               messageID: messageID
           };
           var emailCCResponse = AJAXCallWithResult("/api/MyLeaves/GetEmailMessageMailIDForCC", JSON.stringify(emailCCParam), false);

           if (emailCCResponse && emailCCResponse.data && emailCCResponse.data.ApproverEmailCCEntity) {
               emailCCResponse.data.ApproverEmailCCEntity.forEach(function (item) {
                   if (item.emailID && item.emailID.trim() !== '') {
                       // Avoid duplicates
                       if (ccEmailList.indexOf(item.emailID.trim()) === -1) {
                           ccEmailList.push(item.emailID.trim());
                       }
                   }
               });
           }

           // Step 2: Get email template and leave details
           var emailDetailsParam = {
               leaveID: leaveID,
               messageID: messageID
           };
           var emailDetailsResponse = AJAXCallWithResult("/api/MyLeaves/GetEmployeeLeaveDetailsWithEmail", JSON.stringify(emailDetailsParam), false);

           if (!emailDetailsResponse || !emailDetailsResponse.data) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.EmailTemplateLoadFailed);

               return;
           }

           // Extract leave details
           var leaveDetails = null;
           if (emailDetailsResponse.data.leaveDetails && emailDetailsResponse.data.leaveDetails.EmployeeLeaveDetailsByLeaveIDDetailEntity &&
               emailDetailsResponse.data.leaveDetails.EmployeeLeaveDetailsByLeaveIDDetailEntity.length > 0) {
               leaveDetails = emailDetailsResponse.data.leaveDetails.EmployeeLeaveDetailsByLeaveIDDetailEntity[0];
           }

           // Extract email message
           var emailMessage = null;
           if (emailDetailsResponse.data.emailMessage && emailDetailsResponse.data.emailMessage.EMsgEntity &&
               emailDetailsResponse.data.emailMessage.EMsgEntity.length > 0) {
               emailMessage = emailDetailsResponse.data.emailMessage.EMsgEntity[0];
           }

           var showPopup = false; // default fallback
           if (emailMessage && typeof emailMessage.showPopup === 'boolean') {
               showPopup = emailMessage.showPopup;
           }

           if (!leaveDetails || !emailMessage) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.EmailDetailsLoadFailed);

               return;
           }

           // Step 3: Replace template placeholders
           var emailBody = emailMessage.body || '';
           var emailSubject = emailMessage.subject || '';

           // Replace placeholders
           if (leaveDetails.employeeName) {

               // Commented and Added By Vyankat B. on 18th Aug 2026 to correct the Approver Name
               //emailBody = emailBody.replace(/<NAME>/g, leaveDetails.employeeName);
                 emailBody = emailBody.replace(/<NAME>/g, leaveDetails.toEmployeeName);
               //End of Commented and Added By Vyankat B. on 18th Aug 2026 to correct the Approver Name

               emailBody = emailBody.replace(/<SENDER_NAME>/g, leaveDetails.employeeName);
           }

           // Handle <HALF_DAY> placeholder
           var halfDayText = '';
           if (leaveDetails.firstHalfDay === true) {
               halfDayText = ' first half day';
           } else if (leaveDetails.secondHalfDay === true) {
               halfDayText = ' second half day';
           }
           emailBody = emailBody.replace(/<HALF_DAY>/g, halfDayText);
           // Format dates (fromDate and toDate are in ISO format, convert to dd-MMM-yyyy)
           var formattedFromDate = formatDateForEmailTemplate(leaveDetails.fromDate);
           var formattedToDate = formatDateForEmailTemplate(leaveDetails.toDate);

           emailBody = emailBody.replace(/<From_Date>/g, formattedFromDate);
           emailBody = emailBody.replace(/<To_Date>/g, formattedToDate);
           if (leaveDetails.reason) {
               emailBody = emailBody.replace(/<Reason>/g, leaveDetails.reason);
           }

           if (leaveDetails.address) {
               emailBody = emailBody.replace(/<Address>/g, leaveDetails.address);
           }

           if (leaveDetails.telephone) {
               emailBody = emailBody.replace(/<Telephone>/g, leaveDetails.telephone);
           }

           // Step 4: Populate email modal
           var fromEmail = leaveDetails.emailID || '';
          // Commented and Added By Vyankat B. on 18th Aug 2026 to retrieve the Reporting Manager's email address
          // var toEmail = leaveDetails.emailID || ''; // Same as From
           var toEmail = leaveDetails.toMail || ''; // Same as From
          // End of Commented and Added By Vyankat B. on 18th Aug 2026 to retrieve the Reporting Manager's email address

           
           //approverEmail = leaveDetails.emailID || '';


           $('#sendLeaveEmailFrom').val(fromEmail);
           $('#sendLeaveEmailTo').val(toEmail);
           $('#sendLeaveEmailCC').val(ccEmailList.join(', '));
           $('#sendLeaveEmailSubject').val(emailSubject);
           $('#sendLeaveEmailBody').val(emailBody);

           // Step 5: Show email modal
           //var sendEmailModal = new bootstrap.Modal(document.getElementById('SendLeaveEmailModal'));
           //sendEmailModal.show();
           // Step 5: Decide Popup vs Direct Send
           if (showPopup === true) {

               // Existing behavior → show modal
               var sendEmailModal = new bootstrap.Modal(
                   document.getElementById('SendLeaveEmailModal')
               );
               sendEmailModal.show();

           } else {

               // NEW behavior → send email directly
               //sendLeaveEmailDirectly();
               // ⏳ Delay auto-send so success alert is visible
               setTimeout(function () {
                   sendLeaveEmailDirectly(true); // silent mode
               }, 600);

           }




       }

       // =============================================
       // Helper function to format date for email template (dd-MMM-yyyy)
       // =============================================
       function formatDateForEmailTemplate(dateString) {
           if (!dateString) return '';
           try {
               var dateObj = new Date(dateString);
               if (!isNaN(dateObj.getTime())) {
                   var day = String(dateObj.getDate()).padStart(2, '0');
                   var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                   var month = monthNames[dateObj.getMonth()];
                   var year = dateObj.getFullYear();
                   return day + '-' + month + '-' + year;
               }
           } catch (e) {
               console.error('Error formatting date:', e);
           }
           return dateString;
       }

       // =============================================
       // Helper function to format date for email (dd-MMM-yyyy, e.g., 02-Jan-2028)
       // =============================================
       function formatDateForEmail(dateString) {
           if (!dateString) return '';
           try {
               // Parse date from dd MM yy format
               var parts = dateString.split(' ');
               if (parts.length === 3) {
                   var day = parts[0];
                   var monthNum = parseInt(parts[1]) - 1; // Month is 0-indexed
                   var year = '20' + parts[2];
                   // Convert yy to yyyy

                   // Convert month number to month abbreviation
                   var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                   var month = monthNames[monthNum] || parts[1];

                   return day + '-' + month + '-' + year;
               }
           } catch (e) {
               // If parsing fails, return original string
           }
           return dateString;
       }

       // =============================================
       // Function to confirm and send leave email
       // =============================================
       function sendLeaveEmailConfirm() {
           var toEmail = $('#sendLeaveEmailTo').val().trim();
           var ccEmail = $('#sendLeaveEmailCC').val().trim();
           var fromEmail = $('#sendLeaveEmailFrom').val().trim();
           var subject = $('#sendLeaveEmailSubject').val().trim();

           //var body = $('#sendLeaveEmailBody').val().trim();
           var rawText = $('#sendLeaveEmailBody').val().trim();

           var body =
               "<html><body style='font-family: Arial, Helvetica, sans-serif; font-size:12px; color:#000;'>" +
               rawText
                   .replace(/&/g, "&amp;")
                   .replace(/</g, "&lt;")
                   .replace(/>/g, "&gt;")
                   .replace(/\n/g, "<br>") +
               "</body></html>";






           // Validation
           if (!toEmail) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.ReqEmailTo);
               $('#sendLeaveEmailTo').focus();
               return;
           }

           if (!subject) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.ReqEmailSubject);
               $('#sendLeaveEmailSubject').focus();
               return;
           }

           if (!body) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.ReqEmailMsg);
               $('#sendLeaveEmailBody').focus();
               return;
           }

           // Prepare API request
           var emailRequestParam = {
               toEmailID: toEmail,
               ccEmailID: ccEmail || '',
               fromEmailID: fromEmail || '',
               subject: subject,
               body: body,
               // 🔥 NEW REQUIRED FIELDS for saving email approver
               //approverEmailID: approverEmail,
               //primaryKeyValue: currentSavedLeaveID,
               //action: null,
               //actionTaken: false,
               //guid: null,
               //entityType: "Leave"
           };
           //if (!currentSavedLeaveID || currentSavedLeaveID <= 0) {
           //    alertify.error('Invalid leave reference. Please save again.');
           //    return;
           //}

           var emailParam = JSON.stringify(emailRequestParam);
           // Call SendMyLeavesEmail API
           var emailResponse = AJAXCallWithResult("/api/MyLeaves/SendMyLeavesEmail", emailParam, false);
           // Check response
           if (emailResponse) {
               var isSuccess = false;
               var message = '';

               // Check for status === true
               if (emailResponse.status === true || emailResponse.status === 'true') {
                   isSuccess = true;
                   message = emailResponse.message || resourceKeys.EmailSuccess;
               } else if (emailResponse.data && emailResponse.data.status === true) {
                   isSuccess = true;
                   message = emailResponse.data.message || emailResponse.message || resourceKeys.EmailSuccess;
               }

               if (isSuccess) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.success(message);

                   // Close modal
                   var sendEmailModal = bootstrap.Modal.getInstance(document.getElementById('SendLeaveEmailModal'));
                   if (sendEmailModal) {
                       sendEmailModal.hide();
                   }

                   // Clear form
                   $('#sendLeaveEmailTo').val('');
                   $('#sendLeaveEmailCC').val('');
                   $('#sendLeaveEmailSubject').val('');
                   $('#sendLeaveEmailBody').val('');

                   // Close offcanvas and reload data
                   var offcanvasElement = document.getElementById('offcanvas_ApplyLeave');
                   var bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                   if (bsOffcanvas) {
                       bsOffcanvas.hide();
                   }

                   // Reload leaves list
                   currentPageNumber = 1;
                   GetMyLeaves();
               } else {
                   // Show error message
                   var errorMessage = emailResponse.message || resourceKeys.EmailFailed;
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error(errorMessage);
               }
           } else {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.EmailFailed);
           }
       }


        // =============================================
       // Function to send mail directly without popup
       // =============================================
   
       function sendLeaveEmailDirectly(showAlert) {

           var rawText = $('#sendLeaveEmailBody').val().trim();

           var body =
               "<html><body style='font-family: Arial, Helvetica, sans-serif; font-size:12px; color:#000;'>" +
               rawText
                   .replace(/&/g, "&amp;")
                   .replace(/</g, "&lt;")
                   .replace(/>/g, "&gt;")
                   .replace(/\n/g, "<br>") +
               "</body></html>";

           var emailRequestParam = {
               toEmailID: $('#sendLeaveEmailTo').val().trim(),
               ccEmailID: $('#sendLeaveEmailCC').val().trim(),
               fromEmailID: $('#sendLeaveEmailFrom').val().trim(),
               subject: $('#sendLeaveEmailSubject').val().trim(),
               body: body
           };

           var emailResponse = AJAXCallWithResult(
               "/api/MyLeaves/SendMyLeavesEmail",
               JSON.stringify(emailRequestParam),
               false
           );

           if (showAlert === true) {
               if (emailResponse && (emailResponse.status === true || emailResponse.data?.status === true)) {
                   alertify.success(resourceKeys.EmailSuccess);
               } else {
                   alertify.error(emailResponse?.message || resourceKeys.EmailFailed);
               }
           }

           currentPageNumber = 1;
           GetMyLeaves();
       }




       // =============================================
       // Function to update total records
       // =============================================
       function updateTotalRecords() {
           var totalRecordsElement = document.getElementById('totalRecords');
           if (!totalRecordsElement) return;

           var recordCount = totalRecords || 0;

           // Fallback: if totalRecords is not set, try to get from DataTable
           if (recordCount === 0 && $.fn.DataTable.isDataTable('#LeavesTbl')) {
               var info = $('#LeavesTbl').DataTable().page.info();
               recordCount = info.recordsTotal || 0;
           } else if (recordCount === 0) {
               // Fallback: count rows
               var table = document.getElementById('LeavesTbl');
               if (table) {
                   var tbody = table.getElementsByTagName('tbody')[0];
                   var rows = tbody ? tbody.getElementsByTagName('tr') : [];
                   recordCount = rows.length;
               }
           }

           totalRecordsElement.textContent = resourceKeys.TotalRecords + ': ' + recordCount;
       }

       // =============================================
       // AJAX Call Function (same as PM_Releases.aspx)
       // =============================================
       var ajaxResult;
       function AJAXCallWithResult(url, param, async) {
           $.ajax({
               url: encodeURI(strUrl) + url,
               type: "POST",
               data: param,
               async: async,
               dataType: "json",
               contentType: "application/json;charset-utf=8",
               beforeSend: function (xhr) {
                   xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                   if (param) {
                       xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                   }
               },
               success: function (data) {
                   ajaxResult = data;
               },
               //error: function (err) {
               //    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
               //    if (xhr.status === 400 && xhr.responseJSON) {
               //        // Return the error response so the calling function can display the message
               //        ajaxResult = xhr.responseJSON;
               //        // ✅ KEY STEP: Inject 'status' so UI code doesn't break
               //        // We add both 'status' (bool) and 'Status' (string) to match your codebase's mixed conventions
               //        //if (ajaxResult.status === undefined) {
               //            ajaxResult.status = false;
               //        ajaxResult.Status = "FAILURE";
               //        console.log(ajaxResult.status, "and " ,ajaxResult.Status);
               //        //}

               //    } else {
               //        // Only redirect for critical errors (500, 404, etc.)
               //        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
               //    }
               // ✅ FIX: Handle 400 errors (Validation) without redirecting
               error: function (xhr, status, error) {
                   if (xhr.status === 400 && xhr.responseJSON) {
                       // Return the error response so the calling function can display the message
                       ajaxResult = xhr.responseJSON;
                       // ✅ KEY STEP: Inject 'status' so UI code doesn't break
                       // We add both 'status' (bool) and 'Status' (string) to match your codebase's mixed conventions
                       if (ajaxResult.status === undefined) {
                           ajaxResult.status = false;
                           ajaxResult.Status = "FAILURE";
                       }

                   } else {
                       // Only redirect for critical errors (500, 404, etc.)
                       window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                   }

               }
           });

           return ajaxResult;
       }


       // End of AJAX Call Function

       // Variable to store the leave ID for cancellation
       var cancelLeaveID = 0;
       // =============================================
       // Function to show the cancel confirmation popup
       // =============================================
       function showCancelConfirmation(element) {
           // ✅ FIX: define row first
           var row = $(element).closest('tr');

           // Get leave ID from the clicked element
           var leaveID = $(element).attr('data-leave-id') || $(element).closest('tr').attr('data-id') || 0;
           leaveID = parseInt(leaveID) || 0;

           if (!leaveID || leaveID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidLeaveID);
               return;
           }

           /* =====================================================
      🔴 NEW VALIDATION: Past date cancellation not allowed
      ===================================================== */
           //var fromDateText = row.find('td:eq(0)').text().trim(); // From Date column
           var fromDateText = row.find('td:eq(0)').text().trim(); // ✅ now works


           if (fromDateText) {
               var parts = fromDateText.split('-'); // dd-MMM-yyyy
               var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
               var day = parseInt(parts[0], 10);
               var month = monthNames.indexOf(parts[1]);
               var year = parseInt(parts[2], 10);

               var fromDate = new Date(year, month, day);
               var today = new Date();
               today.setHours(0, 0, 0, 0);

               if (fromDate < today) {
                   alertify.error(resourceKeys.CancelNotAllowedPastDate);
                   return; // ⛔ STOP HERE
               }
           }
           /* ===================================================== */


           // Store leave ID for cancellation
           cancelLeaveID = leaveID;
           // Show the confirmation modal
           $('#cancelConfirmModal').modal('show');
       }

       // =============================================
       // Function to execute when user clicks "Yes" in cancel confirmation
       // =============================================
       function proceedWithCancel() {
           if (!cancelLeaveID || cancelLeaveID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidLeaveID);
               $('#cancelConfirmModal').modal('hide');
               return;
           }

           var employeeID = parseInt(SessionEmployeeId) || 0;

           if (!employeeID || employeeID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidEmpID);
               $('#cancelConfirmModal').modal('hide');
               return;
           }

           // Prepare API request
           var requestParam = {
               LeaveID: cancelLeaveID,
               EmployeeID: employeeID
           };
           var param = JSON.stringify(requestParam);

           // Call CancelEmployeeLeave API
           var response = AJAXCallWithResult("/api/MyLeaves/CancelEmployeeLeave", param, false);
           // Hide the confirmation modal
           $('#cancelConfirmModal').modal('hide');
           // Check response
           if (response) {
               // Check for success indicators (adjust based on actual API response structure)
               var isSuccess = false;
               var message = '';

               if (response.status === true || response.status === 'true' || response.success === true || response.success === 'true') {
                   isSuccess = true;
                   message = response.message || resourceKeys.CancelSuccess;
               } else if (response.data && (response.data.status === true || response.data.success === true)) {
                   isSuccess = true;
                   message = response.data.message || response.message || resourceKeys.CancelSuccess;
               } else if (response.message) {
                   // Some APIs return message even on success
                   message = response.message;
                   if (response.status !== false && response.Status !== "FAILURE") {
                       // If message contains success keywords, treat as success
                       if (message.toLowerCase().indexOf('success') !== -1 ||
                           message.toLowerCase().indexOf('cancelled') !== -1
                           //|| message.toLowerCase().indexOf('cancel') !== -1
                       ) {
                           isSuccess = true;
                       }
                   }
               }

               if (isSuccess) {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.success(message || resourceKeys.CancelSuccess);

                   //   Open Email Modal for Cancellation
                   var cancelledID = cancelLeaveID; // Capture ID before resetting

                   // 1. Reload the grid (background update)
                   currentPageNumber = 1;
                   GetMyLeaves();

                   // 2. Open the Email Modal with MessageID 84 (Cancellation Template)
                   // We use a small timeout to ensure the modal transition is smooth
                   setTimeout(function () {
                       // 84 is the MessageID used in the legacy code for Cancellation
                       populateLeaveEmailFromAPI(cancelledID, 84);
                   }, 300);
                   //  Email pop up ENDS HERE


                   // Reset to first page and reload data
                   currentPageNumber = 1;
                   GetMyLeaves();
               } else {
                   alertify.set('notifier', 'position', 'top-right');
                   alertify.error(message || response.message || resourceKeys.CancelFailed);
               }
           } else {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.CancelFailed);
           }

           // Reset cancel leave ID
           cancelLeaveID = 0;
       }
       // =============================================
       // Function to load Leave Stats in Apply Offcanvas
       // =============================================
       function GetEmployeeLeaveMasterStats() {
           var tbody = $('#applyLeaveStatsBody');
           tbody.empty(); // Clear previous data

           // Get Employee ID from session variable
           var employeeID = parseInt(SessionEmployeeId) || 0;

           var requestParam = {
               "employeeID": employeeID,
               "leaveTypeID": 0  // 0 fetches all types based on your requirement
           };

           var param = JSON.stringify(requestParam);

           // Call the API
           var response = AJAXCallWithResult("/api/MyLeaves/GetEmployeeLeaveMaster", param, false);
           if (response && response.data && response.data.EmployeeLeaveMasterEntity) {
               var data = response.data.EmployeeLeaveMasterEntity;

               //Commented and Added by Vaibhav K to add pagination on 11-03 - 26

               //if (Array.isArray(data) && data.length > 0) {
               //    data.forEach(function (item) {
               //        // Safely handle null values
               //        var leaveType = item.leaveType || '';
               //        var leavesTaken = parseFloat(item.leavesTaken || 0).toFixed(2);
               //        var leaveBalance = parseFloat(item.leaveBalance || 0).toFixed(2);

               //        var row = $('<tr>');
               //        row.append($('<td>').text(leaveType));
               //        row.append($('<td>').text(leavesTaken));
               //        row.append($('<td>').text(leaveBalance));

               //        tbody.append(row);
               //    });
               //} else {
               //    // Handle case where data array is empty
               //    tbody.append('<tr><td colspan="3" class="text-center text-muted">' + resourceKeys.NoDataAvailable + '</td></tr>');
               //}

               alAllData = Array.isArray(data) ? data : [];
               alCurrentPage = 1;
               alTotalPages = Math.max(1, Math.ceil(alAllData.length / alPageSize));
               alRenderPage();
               //End of Commented and Added by Vaibhav K to add pagination on 11-03-26

           } else {
               // Handle API failure or empty response
               tbody.append('<tr><td colspan="3" class="text-center text-muted">' + resourceKeys.NoDataAvailable + '</td></tr>');
           }

            // ==========================================================
            // Result Set 2 - Employee Address and Phone Number
            // ==========================================================
            // Added By Vyankat B. on 18-Aug-2026
            // for showing Employee Address and Phone Number

              if (response && response.data && response.data.EmpAddressPhoneEntity) {
                var employeeDetails = response.data.EmpAddressPhoneEntity[0];

                // Bind Employee Address
                $('#txtAddress').val(employeeDetails.address || '');

                // Bind Employee Phone Number
                $('#txtTelephone').val(employeeDetails.phone || '');
            }
            else {
                // Clear fields when employee details are not available
                $('#txtAddress').val('');
                $('#txtTelephone').val('');
            }

            // End of Added By Vyankat B. on 18-Aug-2026
            // for showing Employee Address and Phone Number

       }


       // =============================================
       // Function to open View Comment modal and load comment from API
       // =============================================
       function openViewComment(el) {
           // Get current table row
           var row = $(el).closest('tr');
           var leaveID = row.attr('data-id') || 0;

           if (!leaveID || leaveID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidLeaveID);
               return;
           }

           var employeeID = parseInt(SessionEmployeeId) || 0;

           if (!employeeID || employeeID <= 0) {
               alertify.set('notifier', 'position', 'top-right');
               alertify.error(resourceKeys.InvalidEmpID);
               return;
           }

           // Prepare API request
           var requestParam = {
               LeaveID: parseInt(leaveID),
               EmployeeID: employeeID
           };
           var param = JSON.stringify(requestParam);

           // Call GetEmployeeLeaveComment API
           var response = AJAXCallWithResult("/api/MyLeaves/GetEmployeeLeaveComment", param, false);
           var commentText = '';

           // Parse response
           if (response) {
               // Check different possible response structures
               if (response.data) {
                   // If response has data property
                   if (response.data.EmployeeLeaveCommentEntity[0].comments) {
                       //alert(response.data.EmployeeLeaveCommentEntity[0].comments);
                       commentText = response.data.EmployeeLeaveCommentEntity[0].comments;
                   }
               } else if (response.comment) {
                   commentText = response.comment;
               } else if (response.comments) {
                   commentText = response.comments;
               } else if (response.message) {
                   commentText = response.message;
               }
           }

           // If no comment found, show default message
           if (!commentText || commentText.trim() === '') {
               commentText = resourceKeys.CommentsNotAvail;
           }

           // Set comment text in textarea
           $('#txtViewComment').val(commentText);
           // Open the modal
           $('#viewCommentModal').modal('show');
       }


       //Reset apply dates
       function resetApplyLeaveForm() {

           // Clear text inputs
           $('#offcanvas_ApplyLeave input[type="text"]').val('');

           // Clear textareas
           $('#offcanvas_ApplyLeave textarea').val('');

           // Reset checkboxes
           $('#chkFirstHalf').prop('checked', false);
           $('#chkSecondHalf').prop('checked', false);

           // Reset dropdowns properly
           if (typeof $.fn.selectpicker !== 'undefined') {
               $('#ddlRequestTypeApply').val('').selectpicker('refresh');
               $('#ddlLeaveTypes').val('').selectpicker('refresh');
           } else {
               $('#ddlRequestTypeApply').val('');
               $('#ddlLeaveTypes').val('');
           }

           // Reset datepickers safely
           $('#txtAppliedDate').datepicker('setDate', null);
           $('#txtFromDate').datepicker('setDate', null);
           $('#txtToDate').datepicker('setDate', null);
       }

       //Added by Vaibhav K to add pagination on 11-03 - 26
       // =============================================
       // LEAVE BALANCE OFFCANVAS - Client Side Pagination
       // =============================================
       var lbAllData = [];   // full dataset
       var lbPageSize = 5;
       var lbCurrentPage = 1;
       var lbTotalPages = 1;

       function lbRenderPage() {
           var tbody = $('#leaveBalanceTblBody');
           tbody.empty();

           var start = (lbCurrentPage - 1) * lbPageSize;
           var end = start + lbPageSize;
           var pageData = lbAllData.slice(start, end);

           if (pageData.length > 0) {
               pageData.forEach(function (item) {
                   var row = $('<tr>');
                   row.append($('<td>').text(item.leaveType || ''));
                   row.append($('<td>').text(parseFloat(item.leaveEntitlement || 0).toFixed(2)));
                   row.append($('<td>').text(parseFloat(item.balanceLeaves || 0).toFixed(2)));
                   tbody.append(row);
               });
           } else {
               tbody.append('<tr><td colspan="3" class="text-center text-muted">' + resourceKeys.NoDataAvailable + '</td></tr>');
           }

           $('#leaveBalanceTotalRecords').text('Total Records: ' + lbAllData.length);
           lbUpdateButtons();
       }

       function lbUpdateButtons() {
           var prev = document.getElementById('lbPrevBtn');
           var next = document.getElementById('lbNextBtn');
           if (!prev || !next) return;

           var disablePrev = lbCurrentPage <= 1 || lbAllData.length === 0;
           prev.disabled = disablePrev;
           prev.style.opacity = disablePrev ? '0.5' : '1';
           prev.style.cursor = disablePrev ? 'not-allowed' : 'pointer';

           var disableNext = lbCurrentPage >= lbTotalPages || lbAllData.length === 0;
           next.disabled = disableNext;
           next.style.opacity = disableNext ? '0.5' : '1';
           next.style.cursor = disableNext ? 'not-allowed' : 'pointer';
       }

       function lbGoToPrev() {
           if (lbCurrentPage > 1) { lbCurrentPage--; lbRenderPage(); }
       }
       function lbGoToNext() {
           if (lbCurrentPage < lbTotalPages) { lbCurrentPage++; lbRenderPage(); }
       }

       // =============================================
       // APPLY LEAVE OFFCANVAS STATS - Client Side Pagination
       // =============================================
       var alAllData = [];
       var alPageSize = 5;
       var alCurrentPage = 1;
       var alTotalPages = 1;

       function alRenderPage() {
           var tbody = $('#applyLeaveStatsBody');
           tbody.empty();

           var start = (alCurrentPage - 1) * alPageSize;
           var end = start + alPageSize;
           var pageData = alAllData.slice(start, end);

           if (pageData.length > 0) {
               pageData.forEach(function (item) {
                   var row = $('<tr>');
                   row.append($('<td>').text(item.leaveType || ''));
                   row.append($('<td>').text(parseFloat(item.leavesTaken || 0).toFixed(2)));
                   row.append($('<td>').text(parseFloat(item.leaveBalance || 0).toFixed(2)));
                   tbody.append(row);
               });
           } else {
               tbody.append('<tr><td colspan="3" class="text-center text-muted">' + resourceKeys.NoDataAvailable + '</td></tr>');
           }

           $('#applyLeaveTotalRecords').text('Total Records: ' + alAllData.length);
           alUpdateButtons();
       }

       function alUpdateButtons() {
           var prev = document.getElementById('alPrevBtn');
           var next = document.getElementById('alNextBtn');
           if (!prev || !next) return;

           var disablePrev = alCurrentPage <= 1 || alAllData.length === 0;
           prev.disabled = disablePrev;
           prev.style.opacity = disablePrev ? '0.5' : '1';
           prev.style.cursor = disablePrev ? 'not-allowed' : 'pointer';

           var disableNext = alCurrentPage >= alTotalPages || alAllData.length === 0;
           next.disabled = disableNext;
           next.style.opacity = disableNext ? '0.5' : '1';
           next.style.cursor = disableNext ? 'not-allowed' : 'pointer';
       }

       function alGoToPrev() {
           if (alCurrentPage > 1) { alCurrentPage--; alRenderPage(); }
       }
       function alGoToNext() {
           if (alCurrentPage < alTotalPages) { alCurrentPage++; alRenderPage(); }
       }
       //End of Added by Vaibhav K to add pagination on 11-03 - 26

       // Loader state
       var loaderShown = false;
       var loaderStartTime = 0;

       function showLoader() {
           document.getElementById('loaderOverlay').style.display = 'block';
           loaderShown = true;
           loaderStartTime = Date.now();
       }

       function hideLoader() {
           if (!loaderShown) return;
           var elapsedTime = Date.now() - loaderStartTime;
           var minDisplayTime = 1500; // Minimum 1.5 seconds
           if (elapsedTime < minDisplayTime) {
               setTimeout(function () {
                   document.getElementById('loaderOverlay').style.display = 'none';
                   loaderShown = false;
               }, minDisplayTime - elapsedTime);
           } else {
               document.getElementById('loaderOverlay').style.display = 'none';
               loaderShown = false;
           }
       }

   </script>


</body>
</html>

<%--End of Code Added by Vaibhav K on 26-12-25--%>
