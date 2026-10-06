<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_BulkResAllocation.aspx.vb" Inherits="Whizible.PM_BulkResAllocation" %>

<!DOCTYPE html>
<html lang="en">
     <%CommonFunctions.General.PlotPageHeadTag("Bulk Resource Allocation")%>
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><%=MyBase.GetResourceString("C_PageTitle")%> </title>
  <%-- Core CSS (Bootstrap, bootstrap-select, jQuery UI, Font Awesome, Alertify) loaded by PlotPageHeadTag above — do not duplicate here or dropdowns break --%>
  <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
  <link rel="stylesheet" href="../../../EnhancementFiles/OnlineFiles/css/Jquery.ui.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/PM_BulkResAllocation.css?v=33">
  <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
  <%-- Page styles: Whizible2.0-new/dist/css/PM_BulkResAllocation.css --%>
</head>
<body>
<%-- Added 25-May-2026 — Full-page loader shown during AJAX calls (HR_SkillRequestApprovals.aspx pattern) --%>
<div class="loader-overlay" id="loaderOverlay" style="display: none;">
    <div class="loader"></div>
</div>
<%-- End of Added 25-May-2026 — loader overlay markup --%>

<%-- ══ Hidden template: Employee Role select cloned for every resource group row ══ --%>
<%-- Modified by Nikhil Mane on 15-04-2026 — renamed to tmpl-employee-role; uses use_Sel_Whizible2_Role SP --%>
<span id="tmpl-employee-role" style="display:none;">
  <% CommonFunctions.HTMLControls.DrawComboBox("cboEmployeeRoleTemplate", "use_Sel_Whizible2_Role", 200,, "class='selectpicker rg-role' data-live-search='true' data-width='100%' data-container='body'",,, ) %>
</span>
<%-- ══ Hidden template: Project Role select for offcanvas Default Selection ══ --%>
<%-- Added by Nikhil Mane on 15-04-2026 — uses usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo SP, separate from Employee Role --%>
<span id="tmpl-project-role" style="display:none;">
  <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectRoleAdd", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo",, "class='form-control'",,, ) %>
</span>
<%-- End of Modified by Nikhil Mane on 15-04-2026 --%>
<%-- Added By Dipali V On 26th May 2026 - Set Skill row templates (PM_BulkResourceReq; Comment column not in reference) --%>
<%-- Skill — options from GetProjectSkillsForBulkAlloc on Set Skill / Add Skill Set --%>
<span id="tmpl-ba-skill-master" style="display:none;">
  <%-- Added By Dipali V On 26th May - Skill options bound client-side from GetProjectSkillsForBulkAlloc (selectpicker) --%>
  <select id="cboSkillMasterNameBA" name="cboSkillMasterNameBA" class="selectpicker form-control skill-select" data-live-search="true" data-width="100%" data-container="body" title="<%=MyBase.GetResourceString("C_SelectSkill")%>"><option value="0"><%=MyBase.GetResourceString("C_SelectSkill")%></option></select>
</span>
<%-- Experience — month dropdown (usp_Sel_GetYears 0,30) --%>
<span id="tmpl-ba-skill-month" style="display:none;">
  <%-- Added By Dipali V On 26th May - Experience month dropdown uses selectpicker for consistent UI --%>
  <%=CommonFunctions.HTMLControls.DrawComboBox("cboMonthNameBA", "usp_Sel_GetYears 0 ,30 ", 50, , "class='selectpicker form-control' data-width='100%' data-container='body'", False, ReturnAsHTML:=True).ToString.Replace("'", "&#39;")%>
</span>
<%-- Experience — year dropdown (usp_Sel_GetYears 0,11) --%>
<span id="tmpl-ba-skill-year" style="display:none;">
  <%-- Added By Dipali V On 26th May - Experience year dropdown uses selectpicker for consistent UI --%>
  <%=CommonFunctions.HTMLControls.DrawComboBox("cboYearNameBA", "usp_Sel_GetYears 0 ,11 ", 50, , "class='selectpicker form-control' data-width='100%' data-container='body'", False, ReturnAsHTML:=True).ToString.Replace("'", "&#39;")%>
</span>
<%-- Proficiency — HR parameters level 7 --%>
<span id="tmpl-ba-skill-proficiency" style="display:none;">
  <%-- Added By Dipali V On 26th May - Proficiency dropdown uses selectpicker for consistent UI --%>
  <%=CommonFunctions.HTMLControls.DrawComboBox("cboParametersNameBA", "usp_Whizible2_Sel_tbl_HR_Parameters 7 ", , , "class='selectpicker form-control' data-width='100%' data-container='body'", False, ReturnAsHTML:=True).ToString.Replace("'", "&#39;")%>
</span>
<%-- End of Added By Dipali V On 26th May 2026 --%>

<%-- ═══ Role Access Guard — mirrors PM_BulkResourceReq.aspx ═══ --%>
<%-- Added by Vyankat B. on 13-Apr-2026 --%>
<%If m_blnViewAccess = True Then%>

<!-- ══ PAGE HEADER ══ -->
<div class="page-header">
  <div class="icon-wrap"><i class="fas fa-users-cog"></i></div>
  <div>
    <h1 class="pgtitle"><%=MyBase.GetResourceString("C_PageTitle1")%> </h1>
    <div class="pgsubtitle"><%=MyBase.GetResourceString("C_SubPageTitle")%>.</div>
  </div>
</div>

<!-- ══ MAIN CONTENT ══ -->
<%-- Added By Dipali V On 26th May - Layout: fixed top (note/filters/tabs) + scrollable role sections --%>
<div class="main-content bulk-alloc-layout">

  <div class="bulk-alloc-sticky-top">
  <%-- Added By Dipali V On 27th May 2026 — Project/Skill (left) + collapsible Notes bullets (right), PM_BulkResourceReq pattern --%>
  <div class="project-note-row">
  <div class="project-note-toolbar-row">
    <div class="project-toolbar-left">
      <div class="note-filter-item note-filter-project">
        <label class="note-inline-label" for="cboProjects"><%=MyBase.GetResourceString("C_PROJECT")%>  :</label>
        <div class="note-filter-control">
          <% CommonFunctions.HTMLControls.DrawComboBox("cboProjects", "Select ''",,, "class='selectpicker' data-live-search='true' data-width='100%'",,, ) %>
        </div>
      </div>
        <%--Added By Diapli V on 17th Jun 2026 For Mentioned ID for Div--%>
      <div class="note-filter-item note-filter-skill" id="SearchbySkillDiv">
        <span class="note-inline-label"><%=MyBase.GetResourceString("C_SearchBySkill")%>   :</span>
        <div class="note-filter-control">
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" role="switch" id="chkSkillFilter"
                   data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"
                   title="" />
            <span class="skill-switch-state off" id="skillSwitchStateText"></span>
          </div>
        </div>
      </div>


    </div>
<br />
  <div class="note-wrap">
  <div class="note-bar" id="noteBanner">
    <div class="note-header" onclick="toggleBulkAllocNote()"
         data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left"
         title="">
      <div class="note-left">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="flex-shrink:0;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
        <strong><%=MyBase.GetResourceString("C_Notes")%></strong>
      </div>
      <span class="note-chevron" id="noteChevron">
        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
      </span>
    </div>
    <div class="note-expanded" id="noteExpanded">
    <ol class="note-bullets-always">
          <li><%=MyBase.GetResourceString("C_NoteBullet1")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet2")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet3")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet4")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet5")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet6")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet7")%></li>
          <li><%=MyBase.GetResourceString("C_NoteBullet8")%></li>
      </ol>
    </div>
  </div>
</div>

  </div>
 

  </div>
  <%-- End of Added By Dipali V On 27th May 2026 --%>

  <%-- Added 26-May-2026 — Tabbed layout: Bulk Allocation vs Reallocation --%>
  <ul class="nav nav-tabs bulk-alloc-tabs" id="bulkAllocTab" role="tablist">
    <li class="nav-item" role="presentation">
      <button type="button" class="nav-link active" id="tab-bulk-allocation-btn"
              data-bs-toggle="tab" data-bs-target="#tabBulkAllocation" role="tab"
              aria-controls="tabBulkAllocation" aria-selected="true">
        <%=MyBase.GetResourceString("C_BulkAllocation")%>
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button type="button" class="nav-link" id="tab-reallocation-btn"
              data-bs-toggle="tab" data-bs-target="#tabReallocation" role="tab"
              aria-controls="tabReallocation" aria-selected="false">
         <%=MyBase.GetResourceString("C_Reallocation")%> 
      </button>
    </li>
  </ul>
  </div><%-- /bulk-alloc-sticky-top --%>

  <div class="bulk-alloc-scroll-body">
  <div class="tab-content bulk-alloc-tab-content" id="bulkAllocTabContent">
    <!-- Tab 1: Bulk Allocation — Project Details + allocation entry rows -->
    <div class="tab-pane fade show active" id="tabBulkAllocation" role="tabpanel" aria-labelledby="tab-bulk-allocation-btn">
      <%-- Added By Dipali V On 28th May - Tab 1 top sticky actions: Add More (left) + Allocate (right) --%>
      <%If m_blnAddAccess = True Then%>
      <div class="bulk-alloc-action-bar">
        <div class="bulk-alloc-action-left">
          <button class="btn-add-more" type="button" onclick="handleAddMore()"
                  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom"
                  data-bs-title="Add New Row">
            <i class="fas fa-plus"></i> <%=MyBase.GetResourceString("C_AddMore")%>
          </button>
        </div>
        <div class="bulk-alloc-action-right">
          <button class="btn-allocate btn btnyellow" onclick="handleAllocate()"
                  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom"
                  title="<%=MyBase.GetResourceString("C_AllocateTooltip")%>">
              <%--Commented Icon from button as per new design on 15-06-2026 by Dipali V--%>
            <%--<i class="fas fa-paper-plane"></i> <%=MyBase.GetResourceString("C_Allocate")%>--%> 
             <%=MyBase.GetResourceString("C_Allocate")%> 
          </button>
        </div>
      </div>
      <%End If%>
      <div class="card-section">
        <div class="ba-project-top-row">
          <div class="section-title ba-project-details-title"><%=MyBase.GetResourceString("C_ProjectDetails")%></div>
            <%--Added By Dipali V On 16th Jun 2026 for added note if resource selected is under pending allocation in same time frame in the project.--%>
          <div class="ba-pending-alloc-note" id="baPendingAllocNote" style="display:none;" aria-live="polite"></div>
            <%--End of Added By Dipali V On 16th Jun 2026 for added note if resource selected is under pending allocation in same time frame in the project.--%>
          <div class="additional-columns-card" id="baAdditionalColumnsCard">
            <div class="section-header" onclick="toggleBaAdditionalColumns()" style="margin-bottom:8px;">
              <h3 style="margin-bottom:0;"><%=MyBase.GetResourceString("C_AdditionalColumns")%></h3>
              <span class="note-chevron" id="baAdditionalColChevron">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
              </span>
            </div>
            <div id="baAdditionalColBody" style="display:none;">
              <div class="tag-bar" id="baTagBar">
                <button type="button" class="tag-bar-chevron-btn" id="baTagBarChevronBtn"
                  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Select Additional Columns">
                  <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
                </button>
              </div>
            </div>
            <div class="col-dropdown" id="baColDropdown"></div>
          </div>
          <div class="ba-project-details-block ba-project-details-body">
            <div class="project-info-row">
              <div class="info-item name-item">
                <label><%=MyBase.GetResourceString("C_ProjectName")%>  </label>
                <span id="pdProjectName"><i class="fas fa-spinner fa-spin" style="color:#9ca3af;font-size:11px;"></i></span>
              </div>
              <div class="info-item date-item">
                <label><%=MyBase.GetResourceString("C_StartDate")%>  </label>
                <span id="pdStartDate">—</span>
              </div>
              <div class="info-item date-item">
                <label><%=MyBase.GetResourceString("C_EndDate")%> </label>
                <span id="pdEndDate">—</span>
              </div>
            </div>
          </div>
        </div>
        <div id="bulkAllocationGroupsContainer"></div>
      </div>
    </div>

    <!-- Tab 2: Reallocation — Allocated Resources sections (per role group) -->
    <div class="tab-pane fade" id="tabReallocation" role="tabpanel" aria-labelledby="tab-reallocation-btn">
      <div class="card-section">
        <div class="section-title rrl-tab-section-title">
          <span class="rrl-tab-section-caption">
            <i class="fas fa-users rrl-icon" aria-hidden="true"></i>
            <span><%=MyBase.GetResourceString("C_AllocatedResources")%></span>
            <span class="rrl-count-badge empty" id="rrl-tab-badge"
                  data-bs-toggle="tooltip" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_TotalAllocatedResourcesTooltip")%>">0</span>
          </span>
          <%-- Added By Dipali V On 5th Jun 2026 — Update inline with Allocated Resources header (same row) --%>
          <% If m_blnEditAccess Then %>
          <div class="rrl-save-block" id="rrl-tab-save-block" style="display:none;">
            <%-- Added by dipali v on 18th Jun 2026 for purpose — Employee Name search on Reallocation tab --%>
            <div class="d-flex align-items-center gap-2 flex-wrap justify-content-end">
              <div class="input-group input-group-sm" style="width: 267px;height: 27px;">
                <input type="text" class="form-control" id="rrlEmployeeNameSearch" autocomplete="off"
                  placeholder="Search by resource name" oninput="_filterRrlEmployeeName('realloc')">
                <button class="btn btn-light border" type="button" onclick="_filterRrlEmployeeName('realloc', true)"><i class="fas fa-search"></i></button>
              </div>
              <button type="button" class="btn btnyellow btn-rrl-save" id="btn-rrl-save-realloc"
                onclick="saveAllocatedResources('realloc')" data-bs-toggle="tooltip" data-bs-placement="top"
                title='<%=MyBase.GetResourceString("C_Save")%>'><%=MyBase.GetResourceString("C_Save")%></button>
            </div>
            <label class="form-label mb-0 text-end rrl-mandatory-note"><span class="req">*</span> <%=MyBase.GetResourceString("C_Mandatory")%></label>
          </div>
          <% End If %>
        </div>
        <%--<p class="reallocation-tab-intro" id="reallocationTabIntro">
          View and update resources already allocated to the selected project. Data loads when you open this tab.
        </p>--%>
        <div id="reallocationGroupsContainer"></div>
        <div class="reallocation-empty" id="reallocationEmptyMsg">
          <%=MyBase.GetResourceString("C_NoRecordsToView")%>
        </div>
      </div>
    </div>
  </div>
  <%-- End of Added 26-May-2026 — Tabbed layout --%>
  </div><%-- /bulk-alloc-scroll-body --%>

</div><!-- /main-content bulk-alloc-layout -->

<%-- ═══ No View Access banner ═══ --%>
<%Else%>
<div class="no-access-banner">
  <%--<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><line x1="4.93" y1="4.93" x2="19.07" y2="19.07"/></svg>--%>
  <p><%=MyBase.GetResourceString("C_YouNotAuthorized")%></p>
</div>
<script>
    /* Hide loader before main script block runs (no APIs when view access is denied). */
    (function () {
        function hideNow() {
            var el = document.getElementById('loaderOverlay');
            if (el) el.style.display = 'none';
        }
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', hideNow);
        } else {
            hideNow();
        }
    })();
</script>
<%End If%>
<%-- ═══ End Role Access Guard ═══ --%>

<!-- ══════════════════════════════════════════════════
     SELECT RESOURCE OFFCANVAS
     ══════════════════════════════════════════════════ -->
<div class="offcanvas offcanvas-end offcanvas-wide" tabindex="-1" id="selectResourceOffcanvas" data-bs-backdrop="true" data-bs-scroll="true" data-bs-keyboard="true">
  <div class="offcanvas-header border-bottom pb-3">
    <h5 class="offcanvas-title fw-bold"><%=MyBase.GetResourceString("C_SelectResources")%></h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
            data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left"
            title="<%=MyBase.GetResourceString("C_Close")%>"></button>
  </div>
  <div class="offcanvas-body pt-2">

    <!-- Search accordion -->
    <div class="accordion mb-2" id="selectResourceAccordion">
     
      <%-- Added By Dipali V On 26th May - Default Selection open by default when offcanvas opens --%>
      <div class="accordion-item border-0 border-bottom">
        <h2 class="accordion-header">
          <button class="accordion-button px-0 fw-bold default-selection-accordion-btn" type="button"
                  data-bs-toggle="collapse" data-bs-target="#defaultAccordionBody"
                  aria-expanded="true" aria-controls="defaultAccordionBody">
            <%=MyBase.GetResourceString("C_DefaultSelectionForAll")%>
          </button>
        </h2>
        <div id="defaultAccordionBody" class="accordion-collapse collapse show">
          <div class="accordion-body px-0 pt-2">
            <div class="row g-3 mb-2">
              <div class="col-md-6">
                <label class="form-label"><%=MyBase.GetResourceString("C_ProjectRole")%></label>
                <select class="selectpicker" data-live-search="true" data-width="100%"
                        data-container="body" id="ocProjectRole">
                  <option value=""><%=MyBase.GetResourceString("C_SelectRole")%></option>
                </select>
              </div>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_NoOfResources")%></label><input class="form-control" id="ocNoOfResources" readonly></div>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_PlannedStartDate")%></label><input class="form-control" id="ocStartDate" readonly></div>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_PlannedEndDate")%></label><input class="form-control" id="ocEndDate" readonly></div>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_PercentAllocation")%></label><input class="form-control" id="ocAllocation" readonly></div>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_ReportingTo")%></label>
               <%-- Added By Dipali V On 16th Jun 2026 For Reporting to filter issue--%>
                  <select class="selectpicker" data-live-search="true" data-width="100%" data-none-selected-text="<%=MyBase.GetResourceString("C_SelectReportingTo")%>" title="<%=MyBase.GetResourceString("C_SelectReportingTo")%>" id="ocReportingTo">
                  <option value="" disabled hidden></option>
                </select>
                   <%--End of Added By Dipali V On 16th Jun 2026 For Reporting to filter issue--%>
              </div>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_ResourceStatus")%></label>
                <%-- Bound from usp_Whizible2_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable – Added by Nikhil Mane on 09-04-2026 --%>
                <% CommonFunctions.HTMLControls.DrawComboBox("ocResourceStatus", "usp_Whizible2_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable", 200,, "class='selectpicker' data-live-search='true' data-width='100%'",,,) %>
              </div>
              <%-- Modified by Nikhil Mane on 16-04-2026 — added oninput workHHMMInput for xxxx:yy format enforcement --%>
              <div class="col-md-6"><label class="form-label"><%=MyBase.GetResourceString("C_WorkHHMM")%></label><input class="form-control" placeholder="<%=MyBase.GetResourceString("C_HHMMPlaceholder")%>" id="ocWorkHM" maxlength="8" oninput="workHHMMInput(this)" autocomplete="off" inputmode="numeric"></div>
              <%-- End of Modified by Nikhil Mane on 16-04-2026 --%>
              <%-- Modified by Nikhil Mane on 15-04-2026 — changed input to textarea with maxlength 900 --%>
              <div class="col-md-12"><label class="form-label"><%=MyBase.GetResourceString("C_Responsibilities")%></label><textarea class="form-control" placeholder="<%=MyBase.GetResourceString("C_EnterResponsibilities")%>" id="ocResponsibilities" maxlength="1000" rows="2" style="resize:vertical;min-height:60px;"></textarea></div>
              <%-- End of Modified by Nikhil Mane on 15-04-2026 --%>
              <%-- Added by Vyankat B. on 13-Apr-2026 — Billable + Is Default Approver checkboxes --%>
              <div class="col-md-6  align-items-center gap-2 pt-1">
                <input type="checkbox" id="ocIsBillable" class="form-check-input" style="width:16px;height:16px;cursor:pointer;">
                <label class="form-label mb-0" for="ocIsBillable" style="cursor:pointer;"><%=MyBase.GetResourceString("C_Billable")%></label>
              </div>
              <div class="col-md-6 align-items-center gap-2 pt-1" id="divOcIsDefaultApprover" style="display:none!important;">
                <input type="checkbox" id="ocIsDefaultApprover" class="form-check-input" style="width:16px;height:16px;cursor:pointer;">
                <label class="form-label mb-0" for="ocIsDefaultApprover" style="cursor:pointer;"><%=MyBase.GetResourceString("C_IsDefaultApprover")%></label>
              </div>
              <%-- Added By Dipali V On 17th Jun 2026 — Is Product Owner when project IsAgileMethodFollowed=1 --%>
              <div class="col-md-6 align-items-center gap-2 pt-1" id="divOcIsProductOwner" style="display:none;">
                <input type="checkbox" id="ocIsProductOwner" class="form-check-input" style="width:16px;height:16px;cursor:pointer;">
                <label class="form-label mb-0" for="ocIsProductOwner" style="cursor:pointer;">Is Product Owner</label>
              </div>
              <%-- End of Added By Dipali V On 17th Jun 2026 --%>
              <%-- End of Added by Vyankat B. on 13-Apr-2026 --%>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ── Match type radio + Add button row ── -->
    <div class="d-flex align-items-center justify-content-between mb-3 flex-wrap gap-2">

      <!-- Exact / Probable radio toggle -->
      <div class="match-type-bar">
        <%-- Probable is ON by default when offcanvas opens --%>
        <label id="lbl-exact" for="rdoExact"
               data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"
               title="<%=MyBase.GetResourceString("C_ExactMatchTooltip")%>">
          <span class="match-type-dot dot-exact"></span> <%=MyBase.GetResourceString("C_ExactMatch")%>
          <input type="radio" id="rdoExact" name="matchType" value="exact" onchange="onMatchTypeChange()">
        </label>
        <label id="lbl-probable" for="rdoProbable" class="active-probable"
               data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"
               title="<%=MyBase.GetResourceString("C_ProbableTooltip")%>">
          <span class="match-type-dot dot-probable"></span> <%=MyBase.GetResourceString("C_Probable")%>
          <input type="radio" id="rdoProbable" name="matchType" value="probable" checked onchange="onMatchTypeChange()">
        </label>
      </div>

      <%If m_blnAddAccess = True Then%>
      <div class="offcanvas-action-btn-group">
        <button class="btn-add-selected btn-offcanvas-action btn btnyellow" type="button" onclick="confirmSelection()"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"
                title="<%=MyBase.GetResourceString("C_SelectResourceTooltip")%>">
            <%--Commented Icon from button as per new design on 15-06-2026 by Dipali V--%>
          <%--<i class="fas fa-check me-1"></i> <%=MyBase.GetResourceString("C_SelectResource")%>--%>
          <%=MyBase.GetResourceString("C_SelectResource")%>
        </button>
        <button class="btn-allocate btn-offcanvas-action btn btnyellow" type="button" onclick="handleAllocateFromOffcanvas()"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom"
                title="<%=MyBase.GetResourceString("C_AllocateTooltip")%>">
             <%--Commented Icon from button as per new design on 15-06-2026 by Dipali V--%>
          <%--<i class="fas fa-paper-plane"></i> <%=MyBase.GetResourceString("C_Allocate")%>--%>
           <%=MyBase.GetResourceString("C_Allocate")%>
        </button>
      </div>
      <%End If%>
    </div>


       <div class="accordion-item border-0 border-bottom" id="searchAccordionItem">
   <h2 class="accordion-header">
     <button class="accordion mb-2 accordion-button px-0 fw-bold default-selection-accordion-btn" type="button"
             data-bs-toggle="collapse" data-bs-target="#searchAccordionBody"
             aria-expanded="false" aria-controls="searchAccordionBody">
       <%=MyBase.GetResourceString("C_Search")%>
     </button>
   </h2>
   <div id="searchAccordionBody" class="accordion mb-2 accordion-collapse collapse">
     <div class="accordion-body px-0 pt-2">
       <div class="row g-3 mb-2">
         <%-- Dropdowns bound from SP via DrawComboBox – Added by Nikhil Mane on 09-04-2026 --%>
         <div class="col-md-6">
           <label class="form-label"><%=MyBase.GetResourceString("C_Designation")%></label>
           <% CommonFunctions.HTMLControls.DrawComboBox("ocDesignation", "use_Sel_Whizible2_Designation", 200,, "class='selectpicker' data-live-search='true' data-width='100%' onchange='filterResourcesByDropdowns()'", False,,,) %>
         </div>
         <div class="col-md-6">
           <label class="form-label"><%=MyBase.GetResourceString("C_Department")%></label>
           <% CommonFunctions.HTMLControls.DrawComboBox("ocDepartment", "use_Sel_Whizible2_Department", 200,, "class='selectpicker' data-live-search='true' data-width='100%' onchange='filterResourcesByDropdowns()'", False,,,) %>
         </div>
         <div class="col-md-6">
           <label class="form-label"><%=MyBase.GetResourceString("C_BusinessGroup")%></label>
           <% CommonFunctions.HTMLControls.DrawComboBox("ocBusinessGroup", "use_Sel_Whizible2_BusinessGroup", 200,, "class='selectpicker' data-live-search='true' data-width='100%' onchange='filterResourcesByDropdowns()'", False,,,) %>
         </div>
         <div class="col-md-6">
           <label class="form-label"><%=MyBase.GetResourceString("C_OrganizationUnit")%></label>
           <% CommonFunctions.HTMLControls.DrawComboBox("ocOrgUnit", "use_Sel_Whizible2_OrganizationUnit", 200,, "class='selectpicker' data-live-search='true' data-width='100%' onchange='filterResourcesByDropdowns()'", False,,,) %>
         </div>
         <%-- End of Added by Nikhil Mane on 09-04-2026 --%>
         <%-- Modified by Nikhil Mane on 05-May-2026 — Skill shown for Exact Match;
              Employee Role shown for Probable Match. Only one is visible at a time. --%>
         <div class="col-md-6" id="divOcSkill">
           <label class="form-label"><%=MyBase.GetResourceString("C_Skill")%></label>
           <%-- Modified by Nikhil Mane on 05-May-2026 — removed data-container="body".
                The four other filter dropdowns (Designation, Department, BusinessGroup,
                OrgUnit) rendered by DrawComboBox do NOT use data-container="body" and
                their live-search works correctly inside the offcanvas. With
                data-container="body" the selectpicker menu is appended to <body> and
                Bootstrap 5's offcanvas focus-trap intercepts keyboard events, making
                the search input unable to receive typed characters. --%>
           <select class="selectpicker" data-live-search="true" data-width="100%" title="<%=MyBase.GetResourceString("C_SelectSkill")%>" id="ocSkill" onchange="filterResourcesByDropdowns()">
           </select>
         </div>
         <%-- Added by Nikhil Mane on 05-May-2026 — Employee Role dropdown shown only
              when Probable Match is active. Uses the tmpl-employee-role template
              (use_Sel_Whizible2_Role SP). When roleid > 0, its value overrides the
              project role ID sent to GetResourcesProbableAllocationMatch for searching
              only — the main group's project role is NOT affected. --%>
         <div class="col-md-6" id="divOcEmployeeRole" style="display:none;">
           <label class="form-label"><%=MyBase.GetResourceString("C_EmployeeRole")%></label>
           <select class="selectpicker" data-live-search="true" data-width="100%"
                   title="<%=MyBase.GetResourceString("C_SelectEmployeeRole")%>" id="ocEmployeeRole"
                   onchange="filterResourcesByDropdowns()">
           </select>
         </div>
         <%-- End of Added by Nikhil Mane on 05-May-2026 --%>
         <div class="col-md-6">
           <label class="form-label"><%=MyBase.GetResourceString("C_EmployeeName")%></label>
           <input class="form-control" placeholder="<%=MyBase.GetResourceString("C_SearchByName")%>" id="resourceSearch" oninput="filterResourcesByName()">
         </div>
       </div>
     </div>
   </div>
 </div>

    <!-- Resource list table with loading overlay -->
    <div class="res-table-wrap">
      <div class="res-loading-overlay" id="resLoadingOverlay">
        <div class="text-center">
          <i class="fas fa-spinner fa-spin fa-2x" style="color:#2563eb;"></i>
          <div class="mt-2" style="color:#2563eb;font-weight:600;font-size:12px;" id="resLoadingText"><%=MyBase.GetResourceString("C_LoadRes")%></div>
        </div>
      </div>
      <div class="line-card mb-3 table-scroll-y">
        <table class="table table-hover mb-0 align-middle">
          <thead class="table-light">
            <tr>
              <th><%=MyBase.GetResourceString("C_ResourceName")%></th>
              <th><%=MyBase.GetResourceString("C_Role")%></th>
              <th><%=MyBase.GetResourceString("C_AvailabilityPct")%></th>
              <th><%=MyBase.GetResourceString("C_ResourceLoading")%></th>
              <th><%=MyBase.GetResourceString("C_ViewDetails")%></th>
              <th><%=MyBase.GetResourceString("C_Select")%></th>
            </tr>
          </thead>
          <tbody id="resourceTableBody">
            <tr><td colspan="7" class="text-center text-muted py-3"><%=MyBase.GetResourceString("C_ClickSelectResourceToLoad")%></td></tr>
          </tbody>
        </table>
      </div>
      <%-- Added by Vyankat B. on 8th April 2026 - Pagination controls for resource list (same behavior as PM_TrainingPlan pattern). --%>
      <div class="d-flex align-items-center justify-content-end gap-2 mt-2 mb-1" id="resourcePagerWrap">
        <div class="fw-semibold text-muted small" id="resourcePagerTotal"><%=MyBase.GetResourceString("C_TotalRecordsLabel")%></div>
        <div class="btn-group btn-group-sm" role="group" aria-label="Resource pagination">
          <button type="button" class="btn btn-light border resource-pager-btn" id="btnResourcePrev" onclick="onResourcePrevPage()"
                  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_PreviousPageTitle")%>">
            <i class="fas fa-angle-double-left"></i>
          </button>
          <button type="button" class="btn btn-light border resource-pager-btn" id="btnResourceNext" onclick="onResourceNextPage()"
                  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_NextPageTitle")%>">
            <i class="fas fa-angle-double-right"></i>
          </button>
        </div>
      </div>
      <%-- End of Added by Vyankat B. on 8th April 2026 - Pagination controls for resource list. --%>
    </div>

  </div>
</div>

<!-- ══ RESOURCE DETAILS OFFCANVAS ══ -->
<div class="offcanvas offcanvas-end resource-detail-panel" tabindex="-1" id="resourceDetailsOffcanvas" data-bs-backdrop="true" data-bs-scroll="true">
  <div class="offcanvas-header">
    <div class="d-flex align-items-center gap-2">
      <span style="color:#2563eb;"><i class="far fa-user"></i></span>
      <div>
        <h5 class="resource-detail-name" id="detailName">—</h5>
        <div class="resource-detail-sub" id="detailRole">—</div>
      </div>
    </div>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
            data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left"
            title="<%=MyBase.GetResourceString("C_Close")%>"></button>
  </div>
  <div class="offcanvas-body pt-0">
    <h6 class="detail-block-title"><i class="far fa-list-alt"></i> <%=MyBase.GetResourceString("C_ResourceInformation")%></h6>
    <div class="line-card mb-3">
      <table class="table table-sm mb-0 info-kv-table"><tbody id="detailInfoBody"></tbody></table>
    </div>
    <%--<h6 class="detail-block-title"><i class="fas fa-circle" style="color:#2563eb;font-size:7px;"></i> Primary Skills</h6>
    <div class="mb-2" id="detailPrimarySkills"><span class="skill-chip primary">—</span></div>
    <h6 class="detail-block-title"><i class="fas fa-circle" style="color:#9ca3af;font-size:7px;"></i> Secondary Skills</h6>
    <div class="mb-3" id="detailSecondarySkills"><span class="skill-chip secondary">—</span></div>--%>
    <h6 class="detail-block-title"><i class="fas fa-chart-bar"></i> <%=MyBase.GetResourceString("C_AllocationOverview")%></h6>
    <div class="alloc-box">
      <div class="alloc-row"><span><%=MyBase.GetResourceString("C_CurrentAllocation")%></span><span class="pct" id="detailCurrentAlloc">—</span></div>
      <div class="mini-progress"><span id="detailAllocBar" style="width:0%"></span></div>
    </div>
    <div class="alloc-box">
      <div class="alloc-row"><span><%=MyBase.GetResourceString("C_FreeAvailable")%></span><span class="pct" id="detailFreeAlloc">—</span></div>
      <div class="mini-progress"><span id="detailFreeBar" style="width:0%;background:#16a34a;"></span></div>
    </div>
  </div>
</div>

<!-- Added By Dipali V On 5th Jun 2026 — Reallocation tab: full allocation details (list shows Role, Start, End, Alloc %, Work only) -->
<div class="offcanvas offcanvas-end resource-detail-panel" tabindex="-1" id="rrlAllocationDetailOffcanvas" data-bs-backdrop="true" data-bs-scroll="true">
  <div class="offcanvas-header">
    <div class="d-flex align-items-center gap-2">
      <span style="color:#2563eb;"><i class="far fa-user"></i></span>
      <div>
        <h5 class="resource-detail-name" id="rrlOcName">—</h5>
        <div class="resource-detail-sub" id="rrlOcRole">—</div>
      </div>
    </div>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
            data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left"
            title="<%=MyBase.GetResourceString("C_Close")%>"></button>
  </div>
  <div class="offcanvas-body pt-0">
    <h6 class="detail-block-title"><i class="far fa-list-alt"></i> <%=MyBase.GetResourceString("C_ResourceInformation")%></h6>
    <div id="rrlOcViewWrap">
      <div class="line-card mb-3">
        <table class="table table-sm mb-0 info-kv-table"><tbody id="rrlOcDetailBody"></tbody></table>
      </div>
    </div>
       <% If m_blnEditAccess Then %>
    <div id="rrlOcEditWrap" class="d-none">
      <div class="line-card mb-3 p-3" id="rrlOcEditFields"></div>
      <div class="text-end">
        <button type="button" class="btn btnyellow px-4" id="btnRrlOcUpdate"><%=MyBase.GetResourceString("C_Save")%></button>
      </div>
    </div>
      <% End If %>
  </div>
</div>

<!-- ══ RESOURCE LOADING OFFCANVAS ══ -->
<div class="offcanvas offcanvas-end resource-loading-panel" tabindex="-1" id="resourceLoadingOffcanvas" data-bs-backdrop="true" data-bs-scroll="true">
  <div class="offcanvas-header">
    <%-- Added by Vyankat B. on 8th April 2026 - Bind Resource Utilization title from resource file in new UI. --%>
    <h5 class="offcanvas-title fw-bold"><%=MyBase.GetResourceString("C_ResourceUtilization")%></h5>
    <%-- End of Added by Vyankat B. on 8th April 2026 --%>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
            data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left"
            title="<%=MyBase.GetResourceString("C_Close")%>"></button>
  </div>
  <div class="offcanvas-body">
    <%-- Added by Vyankat B. on 8th April 2026 - Add ResourceLoadingYear and ResourceName strip in new UI. --%>
    <p class="container-fluid pt-1 pb-1 text-end clearfix">
      <strong><span class="float-start" id="ResourceLoadingYear"></span></strong>
      <span class="float-end"><strong><span data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="" id="ResourceName"></span></strong></span>
    </p>
    <%-- End of Added by Vyankat B. on 8th April 2026 --%>
    <div class="row g-3 mb-3">
      <div class="col-lg-6">
        <div class="line-card p-3"><canvas id="loadingPieChart" height="210"></canvas></div>
      </div>
      <div class="col-lg-6">
        <table class="table table-bordered mb-0">
          <%-- Added by Vyankat B. on 8th April 2026 - Resource Utilization summary body bound from GetResourceLoadingBulk API. --%>
          <tbody id="tblResourceWorkSummaryBody">
            <tr><th><%=MyBase.GetResourceString("C_InstallCapacity")%></th><td class="text-end">--<%=MyBase.GetResourceString("C_HrsSuffix")%></td></tr>
            <tr><th><%=MyBase.GetResourceString("C_AvailableForAllocation")%></th><td class="text-end">--<%=MyBase.GetResourceString("C_HrsSuffix")%></td></tr>
            <tr><th><%=MyBase.GetResourceString("C_Leaves")%></th><td class="text-end">--<%=MyBase.GetResourceString("C_HrsSuffix")%></td></tr>
            <tr><th><%=MyBase.GetResourceString("C_BillableAllocation")%></th><td class="text-end">--<%=MyBase.GetResourceString("C_HrsSuffix")%></td></tr>
            <tr><th><%=MyBase.GetResourceString("C_NonBillableAllocation")%></th><td class="text-end">--<%=MyBase.GetResourceString("C_HrsSuffix")%></td></tr>
          </tbody>
          <%-- End of Added by Vyankat B. on 8th April 2026 --%>
        </table>
      </div>
    </div>
    <%-- Added by Vyankat B. on 9th April 2026 - Monthly / Project loading from GetResourceLoadingBulk (PieChart:false); FY columns from GetCompanyStartMonth. --%>
    <h5 class="fw-bold mb-2"><%=MyBase.GetResourceString("C_MonthlyLoading")%></h5>
    <div class="table-responsive line-card loading-table-wrap p-2 mb-3">
      <table class="table table-striped table-bordered table-sm mb-0 monthly-loading-table">
        <thead class="table-light" id="tblmonthlyLoadingThead"><tr></tr></thead>
        <tbody id="tblmonthlyLoadingTbody"></tbody>
      </table>
    </div>
    <h5 class="fw-bold mb-2"><%=MyBase.GetResourceString("C_ProjectLoading")%></h5>
    <div class="table-responsive line-card loading-table-wrap p-2 mb-3">
      <table class="table table-striped table-bordered table-sm mb-0 project-loading-table">
        <thead class="table-light" id="tblProjectLoadingThead"><tr></tr></thead>
        <tbody id="tblProjectLoadingTbody"></tbody>
      </table>
    </div>
    <%-- End of Added by Vyankat B. on 9th April 2026 --%>
  </div>
</div>

<%-- Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas when Search By Skill is ON and project has no skills (replaces PM_ToolsSkills page navigation) --%>
<div class="offcanvas offcanvas-end offcanvas-wide ba-skill-selection-offcanvas" tabindex="-1" id="baSkillsSelectionOffcanvas" data-bs-backdrop="true" data-bs-scroll="true" data-bs-keyboard="true">
  <div class="offcanvas-header border-bottom pb-3">
    <h5 class="offcanvas-title fw-bold w-100 pe-4">Skills Selection</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
            data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left"
            title="<%=MyBase.GetResourceString("C_Close")%>"></button>
  </div>
  <div class="offcanvas-body pt-2">
    <div class="ba-skill-selection-toolbar d-flex align-items-center gap-2 mb-2">
      <div class="ba-skill-search-wrap">
        <div class="input-group input-group-sm" style="width:37%!important;">
          <input type="text" id="baSkillSearchInput" class="form-control" autocomplete="off" placeholder="<%=MyBase.GetResourceString("C_Search")%>.."
                 onkeyup="onBaSkillSearchInput()" />
          <button class="btn btn-light border" type="button" onclick="onBaSkillSearchInput()"><i class="fas fa-search"></i></button>
        </div>
      </div>
      <div class="ba-skill-save-wrap">
        <button type="button" class="btn btnyellow px-4" onclick="saveBaProjectSkillsSelection()"><%=MyBase.GetResourceString("C_Save")%></button>
      </div>
    </div>
    <div class="table-responsive line-card">
      <table class="table table-bordered table-sm mb-0 ba-skill-selection-table" id="baSkillSelectionTbl">
        <thead class="table-light">
          <tr>
            <th><%=MyBase.GetResourceString("C_SkillsSelection")%></th>
            <th class="text-center" style="width:90px;"><%=MyBase.GetResourceString("C_Select")%></th>
          </tr>
        </thead>
        <tbody id="baSkillSelectionBody">
          <tr><td colspan="2" class="text-center text-muted py-3"><%=MyBase.GetResourceString("C_LoadingEllipsis")%></td></tr>
        </tbody>
      </table>
    </div>
    <div class="d-flex align-items-center justify-content-end gap-2 mt-2 mb-1" id="baSkillPagerWrap">
      <div class="fw-semibold text-muted small" id="baSkillPagerTotal"><%=MyBase.GetResourceString("C_TotalRecordsLabel")%></div>
      <div class="btn-group btn-group-sm" role="group" aria-label="Skills pagination">
        <button type="button" class="btn btn-light border resource-pager-btn" id="btnBaSkillPrev" onclick="onBaSkillPrevPage()"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_PreviousPageTitle")%>">
          <i class="fas fa-angle-double-left"></i>
        </button>
        <button type="button" class="btn btn-light border resource-pager-btn" id="btnBaSkillNext" onclick="onBaSkillNextPage()"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="<%=MyBase.GetResourceString("C_NextPageTitle")%>">
          <i class="fas fa-angle-double-right"></i>
        </button>
      </div>
    </div>
  </div>
</div>
<%-- End of Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas --%>

<!-- ══ SCRIPTS ══ -->
<%-- jQuery, jQuery UI, Bootstrap, bootstrap-select, Alertify, CommonFunctions/Validations loaded by PlotPageHeadTag — do not reload or selectpicker dropdowns stop opening --%>
<%--<script src="../../../Whizible2.0-new/bootstrap/js/jquery-3.7.1.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
<script src="../../../EnhancementFiles/js/jquery-ui.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
<script src="../../../Whizible2.0-new/plugins/chartjs/Chart.bundle.js"></script>

<script>
    /* ═══════════════════════════════════════════════════════════════════════
       CONFIG  –  mirrors PM_BulkResourceReq.aspx pattern exactly
       ═══════════════════════════════════════════════════════════════════════ */
    var strUrl = '<%=ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
    if (strUrl.endsWith('/')) { strUrl = strUrl.slice(0, -1); }
    var SessionProjectID = <%= Session("intProjectID") %>;
    var SessionUserID    = <%= Session("intUserID") %>;
    // Added 26-May-2026 — LoginType for accessible-projects API (PM_Resources.aspx pattern).
    var LoginType = '<%= System.Web.HttpUtility.JavaScriptStringEncode(System.Convert.ToString(Session("LoginType"))) %>';
    // Page-level Skill filter toggle: when false, skillID is not sent to Exact Match API; Set Skill hidden.
    // Added By Dipali V On 26th May 2026 - Default Skill toggle OFF
    var _pageSkillFilterEnabled = false;
    /* Added By Dipali V On 26th May 2026 - Set Skill panel: project skills cache (loaded on click only) */
    var _bulkAllocProjectSkillsCache = null;
    /* Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas state (available skills list, pagination, checked ids, toggle-after-save flag) */
    var _baAvailableSkillsAll = [];
    var _baAvailableSkillsFiltered = [];
    var _baSkillSelPage = 1;
    var _baSkillSelPageSize = 10;
    var _baSkillSelCheckedIds = new Set();
    var _baSkillSelEnableToggleAfterSave = false;
    var _bulkAllocSkillCounter = 0;
    var _bulkAllocSkillCountersByGroup = {};
    /* Per role-group flag: user chose to open Select Resource without role skills while Search By Skill is ON */
    var _skipRoleSkillFilterByGroup = {};
    // Suppress project-change reload during initial selectpicker bind.
    var _suppressProjectChange = true;
    /* Added By Dipali V On 9th Jun 2026 — single loader session during page init (no second flash from extend-note API) */
    var _pageInitInProgress = false;
    var SessionUserName  = '<%= System.Web.HttpUtility.JavaScriptStringEncode(System.Convert.ToString(Session("strUserName"))) %>';
    // Added by Vyankat B. on 13-Apr-2026 – Page access flags, mirrors PM_BulkResourceReq.aspx.
    var viewAccess   = <%= m_blnViewAccess.ToString().ToLower() %>;
    var addAccess    = <%= m_blnAddAccess.ToString().ToLower() %>;
    var editAccess   = <%= m_blnEditAccess.ToString().ToLower() %>;
    var deleteAccess = <%= m_blnDeleteAccess.ToString().ToLower() %>;
    // End of Added by Vyankat B. on 13-Apr-2026

    /* ── Localised string resources (PM_BulkResAllocation.resx) ── */
    var RES = {
        A_Row: '<%= ResJs("A_Row") %>',
        A_Allocation: '<%= ResJs("A_Allocation") %>',
        A_AllocationNotBlank: '<%= ResJs("A_AllocationNotBlank") %>',
        A_AllocationPctBlank: '<%= ResJs("A_AllocationPctBlank") %>',
        A_AllocationPctBetween: '<%= ResJs("A_AllocationPctBetween") %>',
        A_AllocationPctBetweenRow: '<%= ResJs("A_AllocationPctBetweenRow") %>',
        A_AllocationPctBlankRow: '<%= ResJs("A_AllocationPctBlankRow") %>',
        A_AllocationPctNoDecimal: '<%= ResJs("A_AllocationPctNoDecimal") %>',
        A_AllocationPctNoDecimalRow: '<%= ResJs("A_AllocationPctNoDecimalRow") %>',
        A_AllocationPeriodPassedNoChange: '<%= ResJs("A_AllocationPeriodPassedNoChange") %>',
        A_AllocatingResources: '<%= ResJs("A_AllocatingResources") %>',
        A_AllocationCompleted: '<%= ResJs("A_AllocationCompleted") %>',
        A_AllocationFailed: '<%= ResJs("A_AllocationFailed") %>',
        A_AllocationTentativeLeavingDate: '<%= ResJs("A_AllocationTentativeLeavingDate") %>',
        A_AddResourceGroupWithResources: '<%= ResJs("A_AddResourceGroupWithResources") %>',
        A_AddingNewRow: '<%= ResJs("A_AddingNewRow") %>',
        A_AllocatingAction: '<%= ResJs("A_AllocatingAction") %>',
        A_AtLeastOneRoleRow: '<%= ResJs("A_AtLeastOneRoleRow") %>',
        A_AuthenticationFailed: '<%= ResJs("A_AuthenticationFailed") %>',
        A_BulkResourceUpdatedSuccessfully: '<%= ResJs("A_BulkResourceUpdatedSuccessfully") %>',
        A_ResourceUpdatedSuccessfully: '<%= ResJs("A_ResourceUpdatedSuccessfully") %>',
        A_InactiveResourceCannotEdit: '<%= ResJs("A_InactiveResourceCannotEdit") %>',
        A_CompleteSkillRowFirst: '<%= ResJs("A_CompleteSkillRowFirst") %>',
        A_DefaultRoleCannotRemove: '<%= ResJs("A_DefaultRoleCannotRemove") %>',
        A_DuplicateRoleInRow: '<%= ResJs("A_DuplicateRoleInRow") %>',
        A_DuplicateRoleEmployee: '<%= ResJs("A_DuplicateRoleEmployee") %>',
        A_DuplicateSkill: '<%= ResJs("A_DuplicateSkill") %>',
        A_EmailCouldNotBeSent: '<%= ResJs("A_EmailCouldNotBeSent") %>',
        A_EmailSentSuccessfully: '<%= ResJs("A_EmailSentSuccessfully") %>',
        A_EmpRoleNotBlank: '<%= ResJs("A_EmpRoleNotBlank") %>',
        A_EmployeeRoleRequired: '<%= ResJs("A_EmployeeRoleRequired") %>',
        A_EnterRoleRowFields: '<%= ResJs("A_EnterRoleRowFields") %>',
        A_AddOrReviewResources: '<%= ResJs("A_AddOrReviewResources") %>',
        A_SelectResourcesMatchingRole: '<%= ResJs("A_SelectResourcesMatchingRole") %>',
        A_FailedToExtendResourceEndDate: '<%= ResJs("A_FailedToExtendResourceEndDate") %>',
        A_FailedToLoadExactMatchResources: '<%= ResJs("A_FailedToLoadExactMatchResources") %>',
        A_FailedToLoadProbableResources: '<%= ResJs("A_FailedToLoadProbableResources") %>',
        A_FailedToSaveAllocatedResources: '<%= ResJs("A_FailedToSaveAllocatedResources") %>',
        A_FailedLoadProjectSkills: '<%= ResJs("A_FailedLoadProjectSkills") %>',
        /* Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas: validation/success messages */
        A_SelectAtleastOneSkill: '<%= ResJs("A_SelectAtleastOneSkill") %>',
        A_SkillsSavedSuccessfully: '<%= ResJs("A_SkillSelectedSuccessfully!") %>',
        A_FilteringResources: '<%= ResJs("A_FilteringResources") %>',
        A_IsExtendedEndDateUpdated: '<%= ResJs("A_IsExtendedEndDateUpdated") %>',
        A_LoadingExactMatch: '<%= ResJs("A_LoadingExactMatch") %>',
        A_LoadingProbable: '<%= ResJs("A_LoadingProbable") %>',
        A_Max: '<%= ResJs("A_Max") %>',
        A_Max4Skills: '<%= ResJs("A_Max4Skills") %>',
        A_MaxRowsAllowed: '<%= ResJs("A_MaxRowsAllowed") %>',
        A_MaxRolesAtTime: '<%= ResJs("A_MaxRolesAtTime") %>',
        A_NewPlannEndMis: '<%= ResJs("A_NewPlannEndMis") %>',
        A_NoAllocatedResourcesToSave: '<%= ResJs("A_NoAllocatedResourcesToSave") %>',
        A_NoOfResBlnk: '<%= ResJs("A_NoOfResBlnk") %>',
        A_NoOFRes: '<%= ResJs("A_NoOFRes") %>',
        A_NoOfResBetweenRow: '<%= ResJs("A_NoOfResBetweenRow") %>',
        A_NoOfResBetween1And5: '<%= ResJs("A_NoOfResBetween1And5") %>',
        A_NoOfResProjectLess: '<%= ResJs("A_NoOfResProjectLess") %>',
        A_NoPermissionAddGroups: '<%= ResJs("A_NoPermissionAddGroups") %>',
        A_NoPermissionAllocate: '<%= ResJs("A_NoPermissionAllocate") %>',
        A_NoPermissionExtend: '<%= ResJs("A_NoPermissionExtend") %>',
        A_NoPermissionSave: '<%= ResJs("A_NoPermissionSave") %>',
        A_NoPermissionSelectResources: '<%= ResJs("A_NoPermissionSelectResources") %>',
        A_PageReset: '<%= ResJs("A_PageReset") %>',
        A_PlannedEndAfterProject: '<%= ResJs("A_PlannedEndAfterProject") %>',
        A_PlannedEndBlankRow: '<%= ResJs("A_PlannedEndBlankRow") %>',
        A_PlannedEndDateNotBefore: '<%= ResJs("A_PlannedEndDateNotBefore") %>',
        A_PlannedEndDateNotBlank: '<%= ResJs("A_PlannedEndDateNotBlank") %>',
        A_PlannedEndDateNotValid: '<%= ResJs("A_PlannedEndDateNotValid") %>',
        A_PlannedEndNotBlank: '<%= ResJs("A_PlannedEndNotBlank") %>',
        A_PlannedStartBlankRow: '<%= ResJs("A_PlannedStartBlankRow") %>',
        A_PlannedStartNotBlank: '<%= ResJs("A_PlannedStartNotBlank") %>',
        A_PlannedStartBeforeOrEqualEnd: '<%= ResJs("A_PlannedStartBeforeOrEqualEnd") %>',
        A_PlannedstDate: '<%= ResJs("A_PlannedstDate") %>',
        A_PlannedStProjEnddate: '<%= ResJs("A_PlannedStProjEnddate") %>',
        A_ProjEndNotA: '<%= ResJs("A_ProjEndNotA") %>',
        A_ProjectEmployeeRoleIdMissing: '<%= ResJs("A_ProjectEmployeeRoleIdMissing") %>',
        A_RemoveResourcesBeforeRole: '<%= ResJs("A_RemoveResourcesBeforeRole") %>',
        A_RepToNotBlank: '<%= ResJs("A_RepToNotBlank") %>',
        A_ResBut: '<%= ResJs("A_ResBut") %>',
        A_ResStNotBlank: '<%= ResJs("A_ResStNotBlank") %>',
        A_ResourceExtendedSuccess: '<%= ResJs("A_ResourceExtendedSuccess") %>',
        A_ResourceRowValidationPrefix: '<%= ResJs("A_ResourceRowValidationPrefix") %>',
        A_ResourcesAlreadyInOtherRole: '<%= ResJs("A_ResourcesAlreadyInOtherRole") %>',
        A_ResourcesAllocatedSuccessfully: '<%= ResJs("A_ResourcesAllocatedSuccessfully") %>',
        A_ResNotGreater: '<%= ResJs("A_ResNotGreater") %>',
        A_Ress: '<%= ResJs("A_Ress") %>',
        A_Selected: '<%= ResJs("A_Selected") %>',
        A_SelectedCountRequired: '<%= ResJs("A_SelectedCountRequired") %>',
        A_SelectedCountOnly: '<%= ResJs("A_SelectedCountOnly") %>',
        A_SelectProject: '<%= ResJs("A_SelectProject") %>',
        A_SelectResourceBeforeAction: '<%= ResJs("A_SelectResourceBeforeAction") %>',
        A_SelectResourcesRow: '<%= ResJs("A_SelectResourcesRow") %>',
        A_SelectRoleBeforeSkills: '<%= ResJs("A_SelectRoleBeforeSkills") %>',
        A_SelOneRes: '<%= ResJs("A_SelOneRes") %>',
        A_SelRes: '<%= ResJs("A_SelRes") %>',
        A_SelReso: '<%= ResJs("A_SelReso") %>',
        A_SkillRequiredWhenEnabled: '<%= ResJs("A_SkillRequiredWhenEnabled") %>',
   /* Added By Dipali V On  16th Jun 2026 For change skill alert*/
        A_SkillDeleted: '<%= ResJs("A_SkillDeleted") %>',
        //Added By Dipali V On  16th Jun 2026 For change skill alert
        A_StartDateValid: '<%= ResJs("A_StartDateValid") %>',
        A_UnableLoadSkillDropdown: '<%= ResJs("A_UnableLoadSkillDropdown") %>',
        A_WorkNotBlank: '<%= ResJs("A_WorkNotBlank") %>',
        A_WorkHHMMInvalid: '<%= ResJs("A_WorkHHMMInvalid") %>',
        A_WorkHHMMExceedsProject: '<%= ResJs("A_WorkHHMMExceedsProject") %>',
        A_PleaseSelectAtLeastOneResourceBeforeAllocating: '<%= ResJs("A_PleaseSelectAtLeastOneResourceBeforeAllocating") %>',
        A_PleaseSelectAtLeastOneAllocatedResource: '<%= ResJs("A_PleaseSelectAtLeastOneAllocatedResource") %>',
        /* Added By Dipali V On 16th Jun 2026 — block select/allocate when Availability (%) < 0 */
        A_ResourceAvailabilityNegative: '<%= ResJs("A_ResourceAvailabilityNegative") %>',
        C_Action: '<%= ResJs("C_Action") %>',
        C_AddMore: '<%= ResJs("C_AddMore") %>',
        /* Added By Dipali V On  15th Jun 2026 For change Tooltip  */
        C_AddMoreTooltip: '<%= ResJs("C_AddMoreTooltip") %>',  
        C_DeleteRowTooltip: '<%= ResJs("C_DeleteRowTooltip") %>', 
        C_DeleteSkillTooltip: '<%= ResJs("C_DeleteSkillRowTooltip") %>',
        C_AddResourcesTooltip: '<%= ResJs("C_AddResourcesTooltip") %>',
        /* end of Added By Dipali V On  15th Jun 2026 For change Tooltip*/
        C_AddSkillSet: '<%= ResJs("C_AddSkillSet") %>',
        C_AllocatedResources: '<%= ResJs("C_AllocatedResources") %>',
        C_AdditionalColumns: '<%= ResJs("C_AdditionalColumns") %>',
        C_Allocation: '<%= ResJs("C_Allocation") %>',
        C_AllocationOverview: '<%= ResJs("C_AllocationOverview") %>',
        C_AllocationPctReadOnly: '<%= ResJs("C_AllocationPctReadOnly") %>',
        C_AvailabilityPct: '<%= ResJs("C_AvailabilityPct") %>',
        C_AvailableForAllocation: '<%= ResJs("C_AvailableForAllocation") %>',
        C_Billable: '<%= ResJs("C_Billable") %>',
        C_BillableAllocation: '<%= ResJs("C_BillableAllocation") %>',
        C_BusinessGroup: '<%= ResJs("C_BusinessGroup") %>',
        C_Cancel: '<%= ResJs("C_Cancel") %>',
        C_ClickSelectResourceToLoad: '<%= ResJs("C_ClickSelectResourceToLoad") %>',
        C_Close: '<%= ResJs("C_Close") %>',
        C_CloseSkillPanel: '<%= ResJs("C_CloseSkillPanel") %>',
        C_ConfirmAllocateMsg: '<%= ResJs("C_ConfirmAllocateMsg") %>',
        C_ConfirmDeleteGroupMsg: '<%= ResJs("C_ConfirmDeleteGroupMsg") %>',
        C_ConfirmDeleteRoleRowMsg: '<%= ResJs("C_ConfirmDeleteRoleRowMsg") %>',
        C_ConfirmRemoveResourceMsg: '<%= ResJs("C_ConfirmRemoveResourceMsg") %>',
        C_Confirmation: '<%= ResJs("C_Confirmation") %>',
        C_CoreCompetency: '<%= ResJs("C_CoreCompetency") %>',
        C_CurrentAllocation: '<%= ResJs("C_CurrentAllocation") %>',
        C_DefaultSelectionForAll: '<%= ResJs("C_DefaultSelectionForAll") %>',
        C_Delete: '<%= ResJs("C_Delete") %>',
        C_Department: '<%= ResJs("C_Department") %>',
        C_Designation: '<%= ResJs("C_Designation") %>',
        C_EditDetails: '<%= ResJs("C_EditDetails") %>',
        C_EmployeeIdPrefix: '<%= ResJs("A_EmployeeIdPrefix") %>',
        C_EmployeeName: '<%= ResJs("C_EmployeeName") %>',
        C_EmployeeRole: '<%= ResJs("C_EmployeeRole") %>',
        C_EndDateHeader: '<%= ResJs("C_EndDateHeader") %>',
        C_EnterResponsibilities: '<%= ResJs("C_EnterResponsibilities") %>',
        C_ExactMatch: '<%= ResJs("C_ExactMatch") %>',
        C_ExperienceYearMonth: '<%= ResJs("C_ExperienceYearMonth") %>',
        C_FreeAvailable: '<%= ResJs("C_FreeAvailable") %>',
        C_HHMMPlaceholder: '<%= ResJs("C_HHMMPlaceholder") %>',
        C_HrsSuffix: '<%= ResJs("C_HrsSuffix") %>',
        C_InstallCapacity: '<%= ResJs("C_InstallCapacity") %>',
        C_IsDefaultApprover: '<%= ResJs("C_IsDefaultApprover") %>',
        C_IsProductOwner: 'Is Product Owner',
        C_Leaves: '<%= ResJs("C_Leaves") %>',
        C_LoadingResourcesForRole: '<%= ResJs("C_LoadingResourcesForRole") %>',
        C_LoadRes: '<%= ResJs("C_LoadRes") %>',
        C_Mandatory: '<%= ResJs("C_Mandatory") %>',
        C_MatchSkills: '<%= ResJs("C_MatchSkills") %>',
        C_MonthlyLoading: '<%= ResJs("C_MonthlyLoading") %>',
        C_NextPage: '<%= ResJs("C_NextPage") %>',
        C_NextPageTitle: '<%= ResJs("C_NextPageTitle") %>',
        C_No: '<%= ResJs("C_No") %>',
        C_NoDataAvailableForRole: '<%= ResJs("C_NoDataAvailableForRole") %>',
        C_NoOfResources: '<%= ResJs("C_NoOfResources") %>',
        C_NoOfResourcesPlaceholder: '<%= ResJs("C_NoOfResourcesPlaceholder") %>',
        C_NoRecordsToView: '<%= ResJs("C_NoRecordsToView") %>',
        C_NonBillableAllocation: '<%= ResJs("C_NonBillableAllocation") %>',
        C_OrganizationUnit: '<%= ResJs("C_OrganizationUnit") %>',
        C_PercentAllocation: '<%= ResJs("C_PercentAllocation") %>',
        C_PickPlannedEndDate: '<%= ResJs("C_PickPlannedEndDate") %>',
        C_PickPlannedStartDate: '<%= ResJs("C_PickPlannedStartDate") %>',
        C_PlannedEndDate: '<%= ResJs("C_PlannedEndDate") %>',
        C_PlannedEndDateHeader: '<%= ResJs("C_PlannedEndDateHeader") %>',
        C_PlannedStartDate: '<%= ResJs("C_PlannedStartDate") %>',
        C_PreviousPage: '<%= ResJs("C_PreviousPage") %>',
        C_PreviousPageTitle: '<%= ResJs("C_PreviousPageTitle") %>',
        C_Probable: '<%= ResJs("C_Probable") %>',
        C_Proficiency: '<%= ResJs("C_Proficiency") %>',
        C_ProjectLoading: '<%= ResJs("C_ProjectLoading") %>',
        C_ProjectRole: '<%= ResJs("C_ProjectRole") %>',
        C_Remove: '<%= ResJs("C_Remove") %>',
        C_RemoveRoleTooltip: '<%= ResJs("C_RemoveRoleTooltip") %>',
        C_RoleSelectedNotAllocated: '<%= ResJs("C_RoleSelectedNotAllocated") %>',
        C_ResourceSelectedNotAllocated: '<%= ResJs("C_ResourceSelectedNotAllocated") %>',
        C_ReportingTo: '<%= ResJs("C_ReportingTo") %>',
        C_ResDataIncom: '<%= ResJs("C_ResDataIncom") %>',
        C_Resource: '<%= ResJs("C_Resource") %>',
        C_ResourceColon: '<%= ResJs("C_ResourceColon") %>',
        C_ResourceInformation: '<%= ResJs("C_ResourceInformation") %>',
        C_ResourceLoading: '<%= ResJs("C_ResourceLoading") %>',
        C_ResourceLoadingForYear: '<%= ResJs("C_ResourceLoadingForYear") %>',
        C_ResourceName: '<%= ResJs("C_ResourceName") %>',
        C_Resources: '<%= ResJs("C_Resources") %>',
        C_ResourceStatus: '<%= ResJs("C_ResourceStatus") %>',
        C_ResourceUtilization: '<%= ResJs("C_ResourceUtilization") %>',
        C_Responsibilities: '<%= ResJs("C_Responsibilities") %>',
        C_Role: '<%= ResJs("C_Role") %>',
        ////////////////C_Save: '<%= ResJs("C_Save") %>',
        C_Save: 'Update',
        C_Saving: '<%= ResJs("C_Saving") %>',
        C_Search: '<%= ResJs("C_Search") %>',
        C_SearchByName: '<%= ResJs("C_SearchByName") %>',
        C_Select: '<%= ResJs("C_Select") %>',
        C_SelectAllResources: '<%= ResJs("C_SelectAllResources") %>',
        C_SelectEmployeeRole: '<%= ResJs("C_SelectEmployeeRole") %>',
        C_SelectReportingTo: '<%= ResJs("C_SelectReportingTo") %>',
        C_SelectResource: '<%= ResJs("C_SelectResource") %>',
        C_SelectResources: '<%= ResJs("C_SelectResources") %>',
        C_SelectRole: '<%= ResJs("C_SelectRole") %>',
        C_SelectSkill: '<%= ResJs("C_SelectSkill") %>',
        C_SelectedResources: '<%= ResJs("C_SelectedResources") %>',
        C_SetSkill: '<%= ResJs("C_SetSkill") %>',
        C_Skill: '<%= ResJs("C_Skill") %>',
        C_SkillSet: '<%= ResJs("C_SkillSet") %>',
        C_SkillSetForRole: '<%= ResJs("C_SkillSetForRole") %>',
        C_SkillSwitchOn: '<%= ResJs("C_SkillSwitchOn") %>',
        C_SkillSwitchOff: '<%= ResJs("C_SkillSwitchOff") %>',
        C_StartDateHeader: '<%= ResJs("C_StartDateHeader") %>',
        C_TotalRecordsPrefix: '<%= ResJs("C_TotalRecordsPrefix") %>',
        C_ViewDetails: '<%= ResJs("C_ViewDetails") %>',
        C_WorkHHMM: '<%= ResJs("C_WorkHHMM") %>',
        C_Yes: '<%= ResJs("C_Yes") %>',
        C_NoProjectSkillsMsg: '<%= ResJs("C_NoProjectSkillsMsg") %>',
        C_ConfirmAddProjectSkillsMsg: '<%= ResJs("C_ConfirmAddProjectSkillsMsg") %>',
        C_ConfirmExceedProjectResourcesMsg: '<%= ResJs("C_ConfirmExceedProjectResourcesMsg") %>',
        C_ConfirmSkillNotSelectedMsg: '<%= ResJs("C_ConfirmSkillNotSelectedMsg") %>',
        C_ConfirmResourceSkillDiffersMsg: '<%= ResJs("C_ConfirmResourceSkillDiffersMsg") %>',
        C_SkillConfirmProceedWithoutSkill: '<%= ResJs("C_SkillConfirmProceedWithoutSkill") %>',
        C_SkillConfirmAddSkill: '<%= ResJs("C_SkillConfirmAddSkill") %>',
        /* Added By Dipali V On 5th Jun 2026 — Default Approver change confirmation (Reallocation) */
        C_ConfirmChangeDefaultApprover: '<%= ResJs("C_ConfirmChangeDefaultApprover") %>',
        A_OnlyOneDefaultApprover: '<%= ResJs("A_OnlyOneDefaultApprover") %>',
        C_PlannedStartDateM: '<%= ResJs("C_PlannedStartDateM") %>',
        C_ExtendProjectHeading: '<%= ResJs("C_ExtendProjectHeading") %>',
        C_RrlProjectExtendedNote: '<%= ResJs("C_RrlProjectExtendedNote") %>',
        C_ErrorLoadingProject: '<%= ResJs("C_ErrorLoadingProject") %>',
        C_SetSkillsTooltip: '<%= ResJs("C_SetSkillsTooltip") %>',
        C_EnterNoOfResourcesGroupTooltip: '<%= ResJs("C_EnterNoOfResourcesGroupTooltip") %>',
        C_RemoveResourceFromGroupTooltip: '<%= ResJs("C_RemoveResourceFromGroupTooltip") %>',
        A_NoResourcesFoundExtend: '<%= ResJs("A_NoResourcesFoundExtend") %>',
        A_LoadingResourcesExtend: '<%= ResJs("A_LoadingResourcesExtend") %>',
        C_SelectProjectForAllocated: '<%= ResJs("C_SelectProjectForAllocated") %>',
        C_SelectProject: '<%= ResJs("C_SelectProject") %>',
        C_LoadingEllipsis: '<%= ResJs("C_LoadingEllipsis") %>',
        C_SelectYear: '<%= ResJs("C_SelectYear") %>',
        C_SelectMonth: '<%= ResJs("C_SelectMonth") %>',
        C_SelectProficiency: '<%= ResJs("C_SelectProficiency") %>',
        C_RemoveSkill: '<%= ResJs("C_RemoveSkill") %>',
        C_ResourceAllocationEmailSubject: '<%= ResJs("C_ResourceAllocationEmailSubject") %>',
        C_NA: '<%= ResJs("C_NA") %>',
        C_DatePlaceholder: '<%= ResJs("C_DatePlaceholder") %>',
        C_SelectResourceExtend: '<%= ResJs("C_SelectResourceExtend") %>',
        C_ValidationSuffix: '<%= ResJs("C_ValidationSuffix") %>',
        A_AllocationPartialFailures: '<%= ResJs("A_AllocationPartialFailures") %>',
        A_EmailSentPartial: '<%= ResJs("A_EmailSentPartial") %>'
    };
    function _resFmt(template) {
        var args = Array.prototype.slice.call(arguments, 1);
        return String(template).replace(/\{(\d+)\}/g, function (m, i) {
            var v = args[parseInt(i, 10)];
            return (v != null && v !== undefined) ? v : m;
        });
    }
    function _rowLabel(gid) { return RES.A_Row + ' ' + _getGroupDisplayNum(gid); }
    /* Added By Dipali V On 5th Jun 2026 — Tools/Skills page URL when user confirms adding project skills */
    var _BULK_ALLOC_TOOLS_SKILLS_URL = 'PM_ToolsSkills.aspx';
    var _BULK_ALLOC_TOOLS_SKILLS_FROM_PARAM = 'fromBulkAlloc=1';

    /* Build Tools/Skills URL with return marker + current project so Back can restore context */
    function _buildBulkAllocToolsSkillsUrl() {
        var url = _BULK_ALLOC_TOOLS_SKILLS_URL + '?' + _BULK_ALLOC_TOOLS_SKILLS_FROM_PARAM;
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (projectId > 0) url += '&ProjectID=' + encodeURIComponent(projectId);
        return url;
    }

    // Added by Vyankat B. on 8th April 2026 - Alias SessionEmployeeID from SessionUserID for resource loading calls.
    var SessionEmployeeID = SessionUserID;
    // End of Added by Vyankat B. on 8th April 2026

    /* Auth headers – identical to PM_BulkResourceReq.aspx buildAuthHeaders() */
    function buildAuthHeaders(xhr, param) {
        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem('access_token_W26API'));
        _setAjaxParamsHeaderIfWithinLimit(xhr, param);
    }

    // added by dipali v on 18th Jun 2026 for purpose — skip Params header when payload too large for IIS (~16KB total request headers)
    function _setAjaxParamsHeaderIfWithinLimit(xhr, param) {
        if (!param || !xhr) return;
        var paramStr = (typeof param === 'string') ? param : (isJson(param) ? param : JSON.stringify(param));
        if (!paramStr) return;
        var enc = encryptString(paramStr);
        if (enc && enc.length <= 6144) xhr.setRequestHeader('Params', enc);
    }

    /* ═══════════════════════════════════════════════════════════════════════
       STATE
       ═══════════════════════════════════════════════════════════════════════ */
    var groupCounter = 0;
    /* Added By Dipali V On 15th Jun 2026 — Project-level Default Approver employee id (from GetProjectDetails / RRL grid) */
    var _projectDefaultApproverEmployeeId = 0;
    var _initialProjectDefaultApproverEmployeeId = 0;
    var _projectDefaultApproverEmployeeName = '';

    /* Added By Dipali V On 26th May - Single Allocated Resources grid on Reallocation tab (not per role row) */
    var _REALLOC_TAB_GID = 'realloc';
    var _reallocationTabLoaded = false;
    /* Added By Dipali V On 5th Jun 2026 — Additional Columns state (Bulk Allocation role row) */
    var _baColALL_COLS = [];
    var _baColSelectedOrder = [];
    var _baColUnselectedKeys = [];
    var _baColDdOpen = false;
    var _baColDragSrcKey = null;
    var _baColPrefsLoaded = false;
    var _baColFALLBACK = [
        { id: 1, key: 'reporting-to', label: 'Reporting To' },
        { id: 2, key: 'resource-status', label: 'Resource Status' },
        { id: 3, key: 'work-hh', label: 'Work (HH)' },
        { id: 4, key: 'billable', label: 'Billable' },
        { id: 5, key: 'is-default-approver', label: 'Is Default Approver' }
    ];
    var activeGroupId = null;
    var tempSelected = new Set();   // EmployeeIDs checked in offcanvas
    // Added by Nikhil Mane on 05-May-2026 – one-time guard so the Skill AJAX call
    // fires only on the FIRST Add button click, not on every offcanvas open.
    var _skillDropdownLoaded = false;
    var loadingChartInstance = null;
    /* Raw API resource list for the current offcanvas open */
    var RESOURCES = [];
    /* Project dates */
    var _projectStartDate = null;
    var _projectEndDate = null;
    var _projectStartRaw = '';
    var _projectEndRaw = '';
    var _projectNoOfResources = 0; // Added By Dipali V On 27th May - project No_Of_Resource from GetProjectDetails.
    var _projectNoOfResource = 0;  // ProjectNoOfResource — used when IsValiNo_Of_Resource_ForBulk = 1.
    var _isValiNoOfResourceForBulk = false;
    var Count_Request_ResourceSkill = 0;
    var Count_Resource_BulkAllocation = 0;
    var _projectAllocatedResourceCount = 0; /* Added by dipali v on 18th Jun 2026 for purpose — already allocated resources on project */
    var Count_Role_BulkAllocation = 0;
    var _isAllowBackDatedAllocation = false; /* From GetProjectDetails — when 1, block % change after allocation period passed */
    var _isAgileMethodFollowed = false; /* Added By Dipali V On 17th Jun 2026 — from GetProjectDetails; shows Is Product Owner when 1 */
    var _projectHoursCap = 0;
    var _projectTotalAllocatedHours = 0;
    var _projectOUWorkingHours = 0;
    // Added by Vyankat B. on 8th April 2026 - Store GetResourceLoadingBulk rows for pie chart binding.
    var resourceLoadingBulkRows = [];
    // End of Added by Vyankat B. on 8th April 2026
    // Added by Vyankat B. on 8th April 2026 - FY start month from GetCompanyStartMonth (1-12).
    var companyStartMonth = 4;
    // End of Added by Vyankat B. on 8th April 2026
    // Added by Nikhil Mane on 09-04-2026 – UI settings from GetUISetting API.
    var _uiSettings = null;
    // End of Added by Nikhil Mane on 09-04-2026
    // Added by Vyankat B. on 12-May-2026 – Project date audit extended end date flag.
    var _isExtendedEndDate = false;
    var _rrlProjectEndWasExtended = false;
    window._rrlProjectEndWasExtended = false;
    var _rrlExtendNoteRefreshTimer = null;
    var _rrlExtendRefreshGate = { details: false, extended: false, projectId: 0 };
    var _extendProjectModalShown = false;
    var _userWantsExtendResourceEndDate = null;
    var _extendProjectPageSize = 10;
    var _extendProjectState = { page: 1, size: 10, totalRecords: 0, totalPages: 0, loading: false };
    var _extendProjectSelectedById = {};
    var _extendProjectRowCacheById = {};
    var _extendProjectSelectAllActive = false;
    /* Added By Dipali V On 5th Jun 2026 — inline row edits pending Save on Reallocation tab */
    var _rrlPendingInlineEditsByGroup = {};
    // End of Added by Vyankat B. on 12-May-2026
    // Added by Vyankat B. on 13th April 2026 – Configuration from GetResourceRequestConfiguration (mirrors PM_BulkResourceReq.aspx).
    // Count_BulkRequest_Rows: max rows allowed per bulk allocation (0 = no limit).
    // _maxAllocPct: max % allocation from GetresourceHrs (default 100 until loaded).
    var Count_BulkRequest_Rows = 0;
    var _maxAllocPct = 100;
    // End of Added by Vyankat B. on 13th April 2026
    // Added by Vyankat B. on 8th April 2026 - Resource offcanvas pagination state.
    var resourcePageNumber = 1;
    var resourcePageSize = 5;
    var resourceTotalRecords = 0;
    var resourceTotalPages = 0;
    var _resourceNameSearchTimer = null; //Added by Dipali V On 15th Jun 2026 For Resource Name search debounce in offcanvas
    var _rrlEmpNameSearchTimer = null; /* Added by dipali v on 18th Jun 2026 for purpose — Reallocation Employee Name search debounce */
    // Added by Vyankat B. on 8th April 2026 - Keep loaded resource rows across pages for final multi-page selection.
    var resourceByIdCache = {};
    // End of Added by Vyankat B. on 8th April 2026 - Keep loaded resource rows across pages for final multi-page selection.
    // Added by Vyankat B. on 8th April 2026 - Persist selected resource objects across page navigation.
    var selectedResourceMap = {};
    var _offcanvasLastDefaults = { resourceStatus: '', workHM: '', responsibilitiesByGroup: {}, isProductOwner: false };
    var _syncingResourceStatus = false;
    var _syncingReportingTo = false;
    var _syncingBaCheckboxFields = false;
    var _confirmSelectionSucceeded = false;
    var _allocateTriggeredFromOffcanvas = false;
    var _bulkAllocateInFlight = false;
    var _bulkAllocEmailsDispatched = false;

    /* Added 25-May-2026 — show/hide full-page loader during API calls (ref-count for parallel requests) */
    var _loaderActiveCount = 0;
    /* Added By Dipali V On 9th Jun 2026 — hold overlay across chained init/refresh APIs (no hide between waves) */
    var _loaderSessionHold = false;
    function showLoader() {
        _loaderActiveCount++;
        $('#loaderOverlay').css('display', 'flex');
    }
    function hideLoader() {
        if (_loaderActiveCount > 0) _loaderActiveCount--;
        if (_loaderActiveCount < 0) _loaderActiveCount = 0;
        if (_loaderSessionHold || _loaderActiveCount > 0) return;
        $('#loaderOverlay').hide();
    }
    function beginLoaderSession() {
        _loaderSessionHold = true;
        $('#loaderOverlay').css('display', 'flex');
    }
    function endLoaderSession() {
        _loaderSessionHold = false;
        if (_loaderActiveCount <= 0) {
            _loaderActiveCount = 0;
            $('#loaderOverlay').hide();
        }
    }
    function _forceHideLoader() {
        _loaderSessionHold = false;
        _loaderActiveCount = 0;
        $('#loaderOverlay').hide();
    }
    /* Hide overlay after standalone actions (e.g. Allocate) when ref-count is drained */
    function _ensureStandaloneLoaderHidden() {
        if (_loaderActiveCount > 0) return;
        if (_loaderActiveCount < 0) _loaderActiveCount = 0;
        $('#loaderOverlay').hide();
    }
    /* End of Added 25-May-2026 — loader helpers */
    // End of Added by Vyankat B. on 8th April 2026 - Persist selected resource objects across page navigation.
    // Added by Vyankat B. on 8th April 2026 - Preserve offcanvas draft selections per resource group.
    var draftSelectedByGroup = {};
    var draftSelectedObjByGroup = {};
    // Added by Nikhil Mane on 05-May-2026 — snapshot checked resources when offcanvas opens.
    // Used by confirmSelection() to validate count only for newly checked resources in current open.
    var offcanvasOpenSelectedByGroup = {};
    // End of Added by Vyankat B. on 8th April 2026 - Preserve offcanvas draft selections per resource group.
    // End of Added by Vyankat B. on 8th April 2026 - Resource offcanvas pagination state.
    /* From IRApproval/DeveloperDash GetFromMail — filled on Allocate */
    var FromEmail = '';
    var UserName = '';
    var EmployeeName = '';
    var CCEmail = '';
    var CCUserName = '';
    var CCEmployeeName = '';
    var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
    // Added by Vyankat B. on 10th April 2026 - Extra email sender/recipient vars used by sendAllocationEmail.
    var FromEmpId = 0;
    var FromuserName = '';
    var FromemployeeName = '';
    var Toemail = '';
    var TouserName = '';
    var ToemployeeName = '';
    // End of Added by Vyankat B. on 10th April 2026

    /* ═══════════════════════════════════════════════════════════════════════
       INIT
       ═══════════════════════════════════════════════════════════════════════ */
    $(function () {
        /* No view access — do not call APIs (loader would stay visible); hide overlay immediately. */
        if (!viewAccess) {
            _forceHideLoader();
            return;
        }
        _pageInitInProgress = true;
        beginLoaderSession();

        // Added by Nikhil Mane on 09-04-2026 — global cache for per-resource Reporting To dropdowns.
        window._reportingToOptions = [];
        window._reportingToAllRows = []; //Added By Dipali V on 15th Jun 2026 global cache for per-resource Reporting To dropdowns.
        // Added 26-May-2026 — Populate project dropdown then bind change handler (selectpicker).
        FillProjectCombox();
        initSkillToggle();
        $('#cboProjects').on('changed.bs.select', onBulkProjectChange);
        applyPageSkillToggleToOffcanvas();
        _resetRrlExtendRefreshGate(SessionProjectID);
        LoadProjectDetails();
        checkIsExtended();
        
        cloneRoleOptionsToOffcanvas();
        // Added by Nikhil Mane on 05-May-2026 — populate Employee Role dropdown from tmpl-employee-role.
        cloneEmployeeRoleOptionsToOffcanvas();
        // Added by Vyankat B. on 13th April 2026 – Load row-limit and max-alloc config before adding the first group.
        LoadResourceRequestConfig(function () {
            LoadResourceHrs(function () {
                /* Added By Dipali V On 9th Jun 2026 — load Additional Columns before first role row so Select column aligns */
                initBaAdditionalColumnsUi();
                loadBaColumnMaster(function () {
                    /* Modified by AI on 11-May-2026 — load Reporting To options before
                       rendering RRL rows, otherwise the editable Reporting To dropdowns
                       can be empty when GetProjectEmployeeRoleByRole finishes first. */
                    LoadDefaultApprovers(SessionProjectID, function () {
                        initGroupsByAllocatedRoles();
                        _pageInitInProgress = false;
                        endLoaderSession();
                    });
                });
            });
        });
        // End of Added by Vyankat B. on 13th April 2026
        /* Exclude hidden row templates — refreshing them creates duplicate bootstrap-select markup in clones */
        $('.selectpicker').filter(function () {
            return !$(this).closest('[id^="tmpl-"]').length;
        }).each(function () {
            try {
                //Added By Dipali V On 15th Jun 2026 - Initialize selectpickers in offcanvas with special handling for Reporting To dropdowns (load options first, then init or refresh).
                var $p = $(this);
                if (_isReportingToSelectEl($p)) {
                    if (!$p.data('selectpicker')) _initReportingToSelectpicker($p);
                    else $p.selectpicker('refresh');
                } else if (!$p.data('selectpicker')) {
                    $p.selectpicker();
                } else {
                    $p.selectpicker('refresh');
                }
            } catch (e) { /* ignore */ }
            //End of Added By Dipali V On 15th Jun 2026 - Initialize selectpickers in offcanvas with special handling for Reporting To dropdowns (load options first, then init or refresh).
        });
        refreshProjectSelectpicker();
        updateReallocationEmptyState();
        initNoteToggle();
        /* Ensure Probable radio is visually active on load */
        syncMatchTypeUI();
        updateResourcePaginationUI();
        // Added by Vyankat B. on 9th April 2026 - Default FY headers for Monthly and Project loading until View opens.
        bindMonthlyLoadingFinancialYearHeader(companyStartMonth);
        bindProjectLoadingFinancialYearHeader(companyStartMonth);
        bindMonthlyLoadingFromResourceList([], companyStartMonth);
        bindProjectLoadingFromResourceList([], companyStartMonth);
        // End of Added by Vyankat B. on 9th April 2026
        // Added by Nikhil Mane on 09-04-2026 – Load UI settings (billable/approver flags, field visibility) on page init.
        LoadUISetting();
        // End of Added by Nikhil Mane on 09-04-2026
        // Reporting To options are loaded before initGroupsByAllocatedRoles() above.
        // Init Bootstrap 5 tooltips — identical pattern to PM_BulkResourceReq.aspx
        reinitTooltips();
        _suppressProjectChange = false;

        /* Added By Dipali V On 5th Jun 2026 — Default Approver UI guards (Allocation + Reallocation) */
        $(document).on('change', '#rrlOcApprover', function () {
            if (!this.checked || typeof _isDefaultApproverColumnAllowed !== 'function' || !_isDefaultApproverColumnAllowed()) return;
            var rowKey = window._rrlOcActiveRowKey;
            var gid = window._rrlOcActiveGid;
            if (!rowKey || !gid) return;
            var $row = $('tr[data-row-key="' + rowKey + '"]');
            if (!$row.length) return;
            var targetEmp = parseInt($row.attr('data-employee-id'), 10) || 0;
            var targetPerId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
            if (!_rrlNeedsDefaultApproverChangeConfirm(gid, rowKey, targetEmp, targetPerId)) return;
            var $cb = $(this);
            $cb.prop('checked', false);
            _promptDefaultApproverChange(
                function () {
                    _rrlClearOtherDefaultApprovers(gid, rowKey, targetPerId);
                    $cb.prop('checked', true);
                },
                function () { $cb.prop('checked', false); }
            );
        });
        $(document).on('change', '#tabBulkAllocation input[id^="chkApprover_res_"]', function () {
            var parts = (this.id || '').split('_');
            var gid = parts.length >= 4 && parts[1] === 'res' ? parts[2] : null;
            if (!gid) return;
            if (this.checked) {
                if (_getRgNoOfResources(gid) !== 1) {
                    this.checked = false;
                    return;
                }
                $('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]').not(this).prop('checked', false);
                $('#bulkAllocationGroupsContainer input[id^="rg-approver-"]').prop('checked', false);
            }
            if (_syncingBaCheckboxFields) return;
            _applyDefaultApproverSync(gid, this.checked, 'list');
            if (typeof _refreshProjectDefaultApproverFromBaSelection === 'function') {
                _refreshProjectDefaultApproverFromBaSelection();
            }
            if (typeof _syncBaDefaultApproverAllGroups === 'function') _syncBaDefaultApproverAllGroups();
        });

        // Moved by Nikhil Mane on 05-May-2026 – loadSkillDropdown() relocated to
        // openSelectResource() so it fires on Add button click, not on page load.
        // A one-time guard (_skillDropdownLoaded) prevents redundant API calls on
        // subsequent offcanvas opens.
        _bindBaResourceStatusListDelegation();
        _bindBaReportingToListDelegation();
        _bindBaReportingToRgRowDelegation(); //Added By Dipali V On 15th Jun 2026 — Reporting To: offcanvas ↔ role row ↔ list view - bind change event for role row dropdown
        _bindBaBillableApproverListDelegation();
    });

    /* ═══════════════════════════════════════════════════════════════════════
       SELECTPICKER OFFCANVAS CLEANUP HELPERS
       Added by Nikhil Mane on 16-04-2026
       ─────────────────────────────────────────────────────────────────────
       Problem 1: Dropdowns with data-container="body" render their menu as a
       .bs-container element appended directly to <body>.  When the offcanvas
       is closed (or a resource row is removed) without explicitly closing the
       dropdown, this .bs-container remains visible on screen — even though the
       offcanvas itself is gone.

       Problem 2: The lingering .bs-container elements also have a z-index that
       places an invisible overlay over the main resource allocation table.  Any
       click that lands over this invisible overlay is swallowed by the open
       dropdown, which makes it appear that dropdowns open when clicking on
       unrelated table cells.

       Fix: _closeAllOffcanvasSelectpickers() forcibly resets every selectpicker
       inside #selectResourceOffcanvas AND cleans up any floating .bs-container
       menus on <body>.  It is called:
         • From the offcanvas hide.bs.offcanvas event (see below).
         • From confirmSelection() just before .hide() to avoid a race condition.
    ═══════════════════════════════════════════════════════════════════════ */
    function _closeAllOffcanvasSelectpickers() {
        // 1. Close every bootstrap-select inside the offcanvas that is currently open
        $('#selectResourceOffcanvas .bootstrap-select').each(function () {
            var $bs = $(this);
            if ($bs.hasClass('show') || $bs.find('.dropdown-menu.show').length) {
                try {
                    $bs.find('> .dropdown-toggle').attr('aria-expanded', 'false');
                    $bs.removeClass('show');
                    $bs.find('> .dropdown-menu').removeClass('show');
                } catch (e) { /* ignore */ }
            }
        });

        // 2. Also close any matching .bs-container menus floating on <body>.
        //    These are created by selectpickers that use data-container="body".
        //    bootstrap-select identifies them by data-select-id matching the
        //    aria-owns of the toggle button inside the offcanvas.
        var openSelectIds = [];
        $('#selectResourceOffcanvas .bootstrap-select > .dropdown-toggle').each(function () {
            var owns = $(this).attr('aria-owns') || $(this).attr('aria-labelledby') || '';
            if (owns) { openSelectIds.push(owns); }
        });

        // Broad sweep — close only body-appended menus tied to offcanvas selectpickers
        openSelectIds.forEach(function (owns) {
            if (!owns) return;
            $('body > .bs-container').each(function () {
                if (!$(this).find('#' + owns + ', [aria-labelledby="' + owns + '"]').length) return;
                $(this).find('.dropdown-menu.show').removeClass('show');
                $(this).removeClass('show');
            });
        });
    }

    /* Wire offcanvas hide event — runs BEFORE the slide-out animation starts so
       the dropdown close is invisible to the user.                               */
    (function () {
        var oc = document.getElementById('selectResourceOffcanvas');
        if (!oc) return;
        oc.addEventListener('hide.bs.offcanvas', function () {
            _closeAllOffcanvasSelectpickers();
        });
        /* Reset all offcanvas fields AFTER the panel has fully closed (hidden event),
           so the user never sees the values clearing mid-animation.
           This fires on every close: X button, clicking outside, and after confirmSelection(). */
        oc.addEventListener('hidden.bs.offcanvas', function () {
            var closedGid = activeGroupId;
            var preservedRpt = (closedGid && $('#rg-rpt-' + closedGid).length)
                ? String($('#rg-rpt-' + closedGid).val() || '').trim() : '';
            _resetOffcanvasFields();
            if (closedGid != null) {
                delete _skipRoleSkillFilterByGroup[String(closedGid)];
            }
            if (closedGid && preservedRpt && $('#rg-rpt-' + closedGid).length) {
                _setBaReportingToSelectValue($('#rg-rpt-' + closedGid), preservedRpt);
                _refreshReportingToSelectpicker($('#rg-rpt-' + closedGid));
            }
        });
    })();

    /* Bootstrap 5 offcanvas focus trap blocks keystrokes in selectpicker live-search.
       Allow focus and typing inside bootstrap-select dropdown menus (incl. body-appended). */
    (function _bindBaSelectpickerSearchFocusFix() {
        if (window._baSelectpickerSearchFocusFix) return;
        window._baSelectpickerSearchFocusFix = true;
        document.addEventListener('focusin', function (e) {
            var t = e.target;
            if (!t || !t.closest) return;
            if (t.closest('.bootstrap-select .dropdown-menu') || t.closest('.bs-searchbox')) {
                e.stopImmediatePropagation();
            }
        }, true);
        $(document).on('shown.bs.select', 'select[id^="rg-rpt-"], select[id^="rrl-rpt-"], select[id^="cboReportingTo_res_"], #ocReportingTo, #rrlOcRpt', function () {
            var sp = $(this).data('selectpicker');
            var $search = (sp && sp.$menu) ? sp.$menu.find('.bs-searchbox input') : $(this).parent().find('.bs-searchbox input');
            if (!$search.length) return;
            setTimeout(function () {
                try { $search.trigger('focus'); } catch (e) { /* ignore */ }
            }, 10);
            $search.off('keydown.baRptSearch keyup.baRptSearch').on('keydown.baRptSearch keyup.baRptSearch', function (ev) {
                ev.stopPropagation();
            });
        });
    })();

    function _isInsideBaOffcanvas($el) {
        return $el && $el.length && $el.closest('#selectResourceOffcanvas, #rrlAllocationDetailOffcanvas').length > 0;
    }

    function _needsBodySelectpickerContainer($el) {
        if (_isInsideBaOffcanvas($el)) return false;
        return $el.closest('.rrl-table-scroll, .rrl-table-body-scroll, tbody[id^="sel-res-body-"]').length > 0;
    }

    function _isReportingToSelectEl($el) {
        if (!$el || !$el.length) return false;
        var id = ($el.attr('id') || '');
        return id === 'ocReportingTo' || id === 'rrlOcRpt' ||
            id.indexOf('rg-rpt-') === 0 ||
            id.indexOf('rrl-rpt-') === 0 ||
            id.indexOf('cboReportingTo_res_') === 0;
    }

    function _getReportingToSelectpickerOpts($sel) {
        var opts = {
            liveSearch: true,
            liveSearchStyle: 'contains',
            width: '100%',
            size: 8,
            dropupAuto: false,
            hideDisabled: true,
            noneSelectedText: RES.C_SelectReportingTo || 'Select Reporting To'
        };
        /* Append menu to body outside offcanvas panels — avoids overflow clipping in grid/table rows */
        if (!_isInsideBaOffcanvas($sel)) {
            opts.container = 'body';
        } else if (_needsBodySelectpickerContainer($sel)) {
            opts.container = 'body';
        }
        return opts;
    }
    //Added By Dipali V On 15th Jun 2026 Ensure old options are cleared to prevent duplicates; preserves selectpicker structure
    function _cleanupBaSelectpickerDom($sel) {
        if (!$sel || !$sel.length) return;
        if ($sel.data('selectpicker')) {
            try { $sel.selectpicker('destroy'); } catch (e) { /* ignore */ }
        }
        var $parentWrap = $sel.parent('.bootstrap-select');
        if ($parentWrap.length) {
            $sel.insertBefore($parentWrap);
            $parentWrap.remove();
        }
        $sel.next('.bootstrap-select').remove();
        $sel.removeClass('bs-select-hidden').css({ display: '', width: '', height: '', position: '', opacity: '', pointerEvents: '' });
    }

    function _initReportingToSelectpicker($sel) {
        if (!$sel || !$sel.length) return;
        _cleanupBaSelectpickerDom($sel);
        if (!$sel.hasClass('selectpicker')) $sel.addClass('selectpicker');
        $sel.selectpicker(_getReportingToSelectpickerOpts($sel));
    }
    //End of Added By Dipali V On 15th Jun 2026 Ensure old options are cleared to prevent duplicates; preserves selectpicker structure
    function _refreshReportingToSelectpicker($sel) {
        if (!$sel || !$sel.length) return;
        if (!$sel.data('selectpicker')) {
            _initReportingToSelectpicker($sel);
        } else {
            try { $sel.selectpicker('refresh'); } catch (e) { _initReportingToSelectpicker($sel); }
        }
    }
    /* ── End of Selectpicker Offcanvas Cleanup Helpers — Nikhil Mane 16-04-2026 ── */

    /* ═══════════════════════════════════════════════════════════════════════
       OFFCANVAS FIELD RESET
       Called from hidden.bs.offcanvas so the panel is always blank and fresh
       the next time it opens — regardless of whether it was closed via the
       X button, ESC, clicking outside, or after confirmSelection().
       ═══════════════════════════════════════════════════════════════════════ */
    /* Added By Dipali V On 26th May - Offcanvas accordions: Search hidden, Default Selection visible */
    function _setOffcanvasAccordionDefaultState() {
        var $searchBtn = $('[data-bs-target="#searchAccordionBody"]');
        var $searchBody = $('#searchAccordionBody');
        var $defaultBtn = $('[data-bs-target="#defaultAccordionBody"]');
        var $defaultBody = $('#defaultAccordionBody');
        if ($searchBtn.length && $searchBody.length) {
            $searchBtn.addClass('collapsed').attr('aria-expanded', 'false');
            $searchBody.removeClass('show');
        }
        if ($defaultBtn.length && $defaultBody.length) {
            $defaultBtn.removeClass('collapsed').attr('aria-expanded', 'true');
            $defaultBody.addClass('show');
        }
    }

    function setSearchAccordionVisible(visible) {
        var $searchItem = $('#searchAccordionItem');
        var $searchBtn = $('[data-bs-target="#searchAccordionBody"]');
        var $searchBody = $('#searchAccordionBody');
        if (!$searchBtn.length || !$searchBody.length) return;
        if (visible) {
            if ($searchItem.length) $searchItem.show();
            $searchBtn.removeClass('collapsed').attr('aria-expanded', 'true');
            $searchBody.addClass('show');
        } else {
            if ($searchItem.length) $searchItem.hide();
            $searchBtn.addClass('collapsed').attr('aria-expanded', 'false');
            $searchBody.removeClass('show');
        }
    }

    function _ensureValidationControlVisibleAndFocus(el) {
        if (!el) return;
        var $el = $(el);
        if (!$el.length) return;
        if ($el.closest('#searchAccordionBody').length && !$('#searchAccordionBody').hasClass('show')) {
            setSearchAccordionVisible(true);
        }
        if ($el.closest('#defaultAccordionBody').length && !$('#defaultAccordionBody').hasClass('show')) {
            $('[data-bs-target="#defaultAccordionBody"]').removeClass('collapsed').attr('aria-expanded', 'true');
            $('#defaultAccordionBody').addClass('show');
        }
        var $skillSec = $el.closest('.bulk-skill-section');
        if ($skillSec.length) $skillSec.addClass('open');
        var $baStore = $el.closest('.ba-res-data-store');
        if ($baStore.length) $baStore.show();
        try { $el[0].scrollIntoView({ behavior: 'smooth', block: 'center' }); } catch (e) { }
        setTimeout(function () {
            try {
                if ($el.is('select')) {
                    var $bs = $el.closest('.bootstrap-select');
                    if (!$bs.length) $bs = $el.next('.bootstrap-select');
                    if ($bs.length) { $bs.find('button.dropdown-toggle').trigger('focus'); return; }
                }
                $el.trigger('focus');
            } catch (e) { }
        }, 120);
    }

    function _resetOffcanvasFields() {
        /* 1. Search filters */
        $('#resourceSearch').val('');
        $('#ocDesignation').val('0').selectpicker('refresh');
        $('#ocDepartment').val('0').selectpicker('refresh');
        $('#ocBusinessGroup').val('0').selectpicker('refresh');
        $('#ocOrgUnit').val('0').selectpicker('refresh');
        $('#ocSkill').val('0').selectpicker('refresh');
        /* Added by Nikhil Mane on 05-May-2026 — reset Employee Role (Probable Match filter) */
        $('#ocEmployeeRole').val('').selectpicker('refresh');

        /* 2. Default Selection for All — Project Role */
        $('#ocProjectRole').val('').selectpicker('refresh');
        $('#ocProjectRole').closest('.bootstrap-select').removeClass('oc-role-locked oc-val-error');

        /* 3. Read-only mirror fields */
        $('#ocNoOfResources').val('');
        $('#ocStartDate').val('');
        $('#ocEndDate').val('');
        $('#ocAllocation').val('');

        /* 4. User-editable fields — do not sync blank Reporting To back to the main row */
        _syncingReportingTo = true;
        try {
            var $ocRpt = $('#ocReportingTo');
            if ($ocRpt.length) {
                if ($ocRpt.data('selectpicker')) {
                    try { $ocRpt.selectpicker('val', ''); $ocRpt.selectpicker('refresh'); } catch (e) { $ocRpt.val(''); }
                } else {
                    $ocRpt.val('');
                }
            }
        } finally {
            _syncingReportingTo = false;
        }
        /* Resource Status — reset to first blank/placeholder option */
        if (_offcanvasLastDefaults.resourceStatus) {
            $('#ocResourceStatus').val(String(_offcanvasLastDefaults.resourceStatus)).selectpicker('refresh');
        } else {
            $('#ocResourceStatus').prop('selectedIndex', 0).selectpicker('refresh');
        }
        $('#ocWorkHM').val(_offcanvasLastDefaults.workHM || '');
        $('#ocResponsibilities').val('');

        /* 5. Checkboxes */
        document.getElementById('ocIsBillable') && (document.getElementById('ocIsBillable').checked = false);
        document.getElementById('ocIsDefaultApprover') && (document.getElementById('ocIsDefaultApprover').checked = false);
        document.getElementById('ocIsProductOwner') && (document.getElementById('ocIsProductOwner').checked = !!(_offcanvasLastDefaults.isProductOwner && _isAgileProjectForProductOwner()));
        window._baDefaultApproverChangeAcked = false;

        /* 6. Match-type radio default */
        var rdoProbable = document.getElementById('rdoProbable');
        var rdoExact    = document.getElementById('rdoExact');
        if (rdoExact) rdoExact.checked = true;
        if (rdoProbable) rdoProbable.checked = false;
        syncMatchTypeUI();

        /* 7. Clear all validation highlights */
        $('#selectResourceOffcanvas .oc-val-error').removeClass('oc-val-error');
        $('#selectResourceOffcanvas .bootstrap-select.oc-val-error').removeClass('oc-val-error');

        /* 8. Clear the resource table back to placeholder */
        $('#resourceTableBody').html('<tr><td colspan="7" class="text-center text-muted py-3">' + escHtml(RES.C_ClickSelectResourceToLoad) + '</td></tr>');

        /* 9. Reset pagination display */
        resourcePageNumber   = 1;
        resourceTotalRecords = 0;
        resourceTotalPages   = 0;
        updateResourcePaginationUI();

        /* 10. Clear in-memory selection state so next open starts fresh */
        RESOURCES          = [];
        tempSelected       = new Set();
        selectedResourceMap = {};
        activeGroupId      = null;
    }
    /* ── End of Offcanvas Field Reset ── */

    /* ═══════════════════════════════════════════════════════════════════════
       TOOLTIP HELPERS  —  identical to PM_BulkResourceReq.aspx
       Disposes stale instances first, then creates fresh ones with
       trigger:'hover focus' so bubbles always vanish on mouseleave.
       Call after any DOM mutation that adds [data-bs-toggle="tooltip"] nodes.
       ═══════════════════════════════════════════════════════════════════════ */
    function _hideBootstrapTooltip(el) {
        if (!el || typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
        try {
            var inst = bootstrap.Tooltip.getInstance(el);
            if (inst) inst.hide();
        } catch (e) { /* ignore — BS5 can throw when trigger state is null */ }
    }

    /* Black Bootstrap tooltip attrs for truncated grid headers (full label in data-bs-title). */
    function _baRgHdrTooltipAttrs(fullText) {
        return 'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(fullText || '') + '"';
    }

    /* Show full date in black tooltip when the readonly date input is visually truncated. */
    function _syncBaRgDateInputTooltips() {
        if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
        document.querySelectorAll('#tabBulkAllocation .rg-start, #tabBulkAllocation .rg-end').forEach(function (el) {
            var val = (el.value || '').trim();
            var inst = bootstrap.Tooltip.getInstance(el);
            if (!val) {
                el.removeAttribute('data-bs-toggle');
                el.removeAttribute('data-bs-title');
                if (inst) {
                    try { inst.dispose(); } catch (e) { /* ignore */ }
                    delete el.dataset.tooltipBound;
                }
                return;
            }
            var isTrunc = el.scrollWidth > el.clientWidth + 1;
            if (!isTrunc) {
                el.removeAttribute('data-bs-toggle');
                el.removeAttribute('data-bs-title');
                if (inst) {
                    try { inst.dispose(); } catch (e) { /* ignore */ }
                    delete el.dataset.tooltipBound;
                }
                return;
            }
            el.setAttribute('data-bs-toggle', 'tooltip');
            el.setAttribute('data-bs-custom-class', 'black-tooltip');
            el.setAttribute('data-bs-placement', 'top');
            el.setAttribute('data-bs-title', val);
            el.removeAttribute('title');
            el.removeAttribute('data-bs-original-title');
            if (inst) {
                try { inst.setContent({ '.tooltip-inner': val }); } catch (e) { /* ignore */ }
            }
        });
    }

    /* Set Bootstrap tooltip text without leaving a native title (prevents double tooltips). */
    function _setBsTooltip(el, text) {
        if (!el) return;
        var node = (el && el.jquery) ? el[0] : el;
        if (!node) return;
        var tipText = (text == null ? '' : String(text));
        node.setAttribute('data-bs-title', tipText);
        node.removeAttribute('title');
        node.removeAttribute('data-bs-original-title');
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            var inst = bootstrap.Tooltip.getInstance(node);
            if (inst) {
                try { inst.setContent({ '.tooltip-inner': tipText }); } catch (e) { /* ignore */ }
            }
        }
    }

    function _setProjectNameDisplay(name) {
        var el = document.getElementById('pdProjectName');
        if (!el) return;
        var full = (name || '').toString().trim();
        var short = full;
        if (full.length > 15) short = full.substring(0, 15) + '...';
        el.textContent = short || 'N/A';
        if (full) {
            el.setAttribute('data-bs-toggle', 'tooltip');
            el.setAttribute('data-bs-custom-class', 'black-tooltip');
            el.setAttribute('data-bs-placement', 'top');
            _setBsTooltip(el, full);
        } else {
            el.removeAttribute('data-bs-toggle');
            el.removeAttribute('data-bs-custom-class');
            el.removeAttribute('data-bs-placement');
            el.removeAttribute('data-bs-title');
            el.removeAttribute('title');
        }
    }

    function reinitTooltips() {
        if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
        _syncBaRgDateInputTooltips();
        var list = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        /* Pass 1 — hide/dispose stale instances and normalize title handling to avoid
           browser native tooltip + Bootstrap tooltip appearing together. */
        list.forEach(function (el) {
            var existing = bootstrap.Tooltip.getInstance(el);
            if (existing) {
                try { existing.hide(); } catch (e) { /* ignore */ }
                try { existing.dispose(); } catch (e) { /* ignore */ }
            }
            if (!el.getAttribute('data-bs-custom-class')) {
                el.setAttribute('data-bs-custom-class', 'black-tooltip');
            }
            var t = el.getAttribute('title');
            var bsTitle = el.getAttribute('data-bs-title');
            if (t && !bsTitle) el.setAttribute('data-bs-title', t);
            el.removeAttribute('title');
            el.removeAttribute('data-bs-original-title');
        });
        /* Pass 2 — hover-only tooltips, one visible at a time, hide on click */
        list.forEach(function (el) {
            var tip = new bootstrap.Tooltip(el, { trigger: 'hover', html: false, container: 'body' });
            if (!el.dataset.tooltipBound) {
                el.addEventListener('show.bs.tooltip', function () {
                    list.forEach(function (other) {
                        if (other === el) return;
                        _hideBootstrapTooltip(other);
                    });
                });
                el.addEventListener('click', function () { try { tip.hide(); } catch (e) { } });
                el.addEventListener('mouseleave', function () { try { tip.hide(); } catch (e) { } });
                el.dataset.tooltipBound = '1';
            }
        });
    }

    /* Added By Dipali V On 27th May 2026 — RRL allocated-resources: full text on hover when cell is truncated */
    function _isRrlGarbagePlaceholderText(value) {
        var t = (value == null ? '' : String(value)).trim();
        if (!t) return true;
        if (t === '—' || t === '-' || t === '–' || t === '\u2014' || t === '\u2013') return true;
        if (t.indexOf('â€') !== -1) {
            var stripped = t.replace(/[â€¢â€"'\-\s\u00a0\u2013\u2014]/g, '');
            if (!stripped || stripped.length <= 2) return true;
        }
        return false;
    }
    function _cleanRrlText(value) {
        if (_isRrlGarbagePlaceholderText(value)) return '';
        return String(value).trim();
    }
    /* Added By Dipali V On 5th Jun 2026 — first + last word initials (e.g. Tool ADMIN → TA, Dipali Ganesh Bhangade → DB) */
    function _rrlResourceInitials(name) {
        var parts = (name || '').toString().trim().split(/\s+/).filter(Boolean);
        if (!parts.length) return '—';
        if (parts.length === 1) return parts[0].charAt(0).toUpperCase();
        return (parts[0].charAt(0) + parts[parts.length - 1].charAt(0)).toUpperCase();
    }

    function _rrlBuildResourceNameCellHtml(resName, isResourceActive) {
        var safeName = (resName || '—').toString().trim() || '—';
        var initials = _rrlResourceInitials(safeName);
        var avatarHtml = '<span class="rrl-res-initials" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(safeName) + '">' + escHtml(initials) + '</span>';
        var nameInner = isResourceActive
            ? escHtml(safeName)
            : '<span class="rrl-active-dot inactive me-1" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(RES.C_InactiveResource || 'Inactive') + '"></span>' + escHtml(safeName);
        return '<span class="rrl-name-with-initials">' + avatarHtml + '<strong' + _rrlTruncDataAttr(safeName) + '>' + nameInner + '</strong></span>';
    }

    function _rrlTruncDataAttr(fullText) {
        var t = _cleanRrlText(fullText);
        return t ? (' data-rrl-full="' + escHtml(t) + '"') : '';
    }

    // added by dipali v on 18th Jun 2026 for purpose — truncate long responsibilities after 200 chars; full text on tooltip
    function _rrlTrunc200(text) {
        var t = _cleanRrlText(text);
        if (!t) return '';
        return t.length > 200 ? t.substring(0, 200) + '...' : t;
    }
    function _rrlRespTipClass(fullText) {
        var t = _cleanRrlText(fullText);
        return (t && t.length > 200) ? ' rrl-tip-always' : '';
    }
    function _rrlSetRespDisplayVal($el, text) {
        if (!$el || !$el.length) return;
        var full = _cleanRrlText(text);
        $el.text(full ? _rrlTrunc200(full) : '').attr('data-rrl-full', full);
        $el.toggleClass('rrl-tip-always', full.length > 200);
    }
    function _rrlRespOffcanvasCellHtml($row) {
        var $el = $row.find('.rrl-col-resp .rrl-display-val').first();
        var full = _cleanRrlText($el.attr('data-rrl-full') || $el.text() || '');
        if (!full) return '—';
        var short = _rrlTrunc200(full);
        if (full.length <= 200) return escHtml(short);
        return '<span data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(full) + '">' + escHtml(short) + '</span>';
    }

    /* Direct role cell only — compact reallocation rows keep offcanvas fields in .rrl-offcanvas-only (sibling), not inside role td. */
    function _rrlGetRoleDisplayVal($row) {
        if (!$row || !$row.length) return '—';
        var $el = $row.find('td.rrl-col-role > .rrl-display-val').first();
        if (!$el.length) $el = $row.find('.rrl-col-role > .rrl-display-val').first();
        var t = ($el.attr('data-rrl-full') || $el.text() || '').toString().trim();
        return t || '—';
    }
    function _rrlSetDisplayVal($el, text, emptyLabel, alwaysTip) {
        if (!$el || !$el.length) return;
        var cleaned = _cleanRrlText(text);
        var t = cleaned || (emptyLabel === undefined ? '-' : emptyLabel);
        $el.text(t).attr('data-rrl-full', t);
        if (alwaysTip) $el.addClass('rrl-tip-always');
    }
    function _rrlApplyTruncationTooltips(gid) {
        var wrap = document.getElementById('rrl-table-scroll-' + gid);
        if (!wrap) return;
        wrap.querySelectorAll('[data-rrl-full]').forEach(function (el) {
            var full = el.getAttribute('data-rrl-full') || '';
            var isTrunc = el.scrollWidth > el.clientWidth + 1;
            var isAlwaysTip = el.classList.contains('rrl-tip-always');
            if ((isTrunc || isAlwaysTip) && full && full !== '—') {
                el.setAttribute('data-bs-title', full);
                el.setAttribute('data-bs-toggle', 'tooltip');
                el.setAttribute('data-bs-custom-class', 'black-tooltip');
                el.setAttribute('data-bs-placement', 'top');
            } else {
                el.removeAttribute('title');
                el.removeAttribute('data-bs-title');
                el.removeAttribute('data-bs-toggle');
                el.removeAttribute('data-bs-custom-class');
                el.removeAttribute('data-bs-placement');
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    _hideBootstrapTooltip(el);
                    try {
                        var inst = bootstrap.Tooltip.getInstance(el);
                        if (inst) inst.dispose();
                    } catch (e) { /* ignore */ }
                }
                el.removeAttribute('data-bs-original-title');
            }
        });
        reinitTooltips();
    }

    /* ═══════════════════════════════════════════════════════════════════════
       API 1 – GetProjectDetails
       POST /api/PM_BulkResourceAllocation/GetProjectDetails  { "ProjectID": id }
       ═══════════════════════════════════════════════════════════════════════ */
    function _parseProjectDetailsRow(response) {
        var payload = response && response.data ? response.data : response;
        if (payload && payload.data && !Array.isArray(payload.data)) payload = payload.data;
        var dates = payload && (payload.projectDates || payload.ProjectDates);
        if (dates && dates.ProjectDateModel) dates = dates.ProjectDateModel;
        if (Array.isArray(dates) && dates.length) return dates[0];
        if (dates && !Array.isArray(dates)) return dates;
        return null;
    }

    /* Added By Dipali V On 5th Jun 2026 — Default Approver from GetProjectDetails projectDates.DefaultApproverID */
    function _parseProjectDefaultApproverFromResponse(response) {
        var d = _parseProjectDetailsRow(response);
        var id = d ? (parseInt(_readRowValue(d, ['defaultApproverID', 'DefaultApproverID']), 10) || 0) : 0;
        _projectDefaultApproverEmployeeName = '';
        return id > 0 ? id : 0;
    }

    function _readRowValue(row, keys) {
        if (!row || !keys || !keys.length) return null;
        for (var i = 0; i < keys.length; i++) {
            var v = row[keys[i]];
            if (v != null && v !== '') return v;
        }
        return null;
    }

    function _readBulkAllocConfigInt(row) {
        var keys = Array.prototype.slice.call(arguments, 1);
        var v = _readRowValue(row, keys);
        var n = parseInt(v, 10);
        return isNaN(n) ? 0 : n;
    }

    /* Apply GetProjectDetails config — supports API camelCase (e.g. count_Request_ResourceSkill, isValiNo_Of_Resource_ForBulk). */
    function _applyBulkAllocProjectConfigFromRow(d) {
        if (!d) return;
        var rawProjectResCount = _readRowValue(d, [
            'noOfResources', 'NoOfResources',
            'projectNoOfResource', 'ProjectNoOfResource',
            'projectNoOfResources', 'ProjectNoOfResources'
        ]);
        _projectNoOfResources = parseInt(rawProjectResCount, 10) || 0;
        _projectNoOfResource = parseInt(
            _readRowValue(d, ['projectNoOfResource', 'ProjectNoOfResource']) || _projectNoOfResources,
            10
        ) || 0;
        _isValiNoOfResourceForBulk = _parseValiNoOfResourceForBulkFlag(_readRowValue(d, [
            'isValiNo_Of_Resource_ForBulk', 'IsValiNo_Of_Resource_ForBulk',
            'isValiNoOfResourceForBulk', 'IsValiNoOfResourceForBulk'
        ]));
        Count_Request_ResourceSkill = _readBulkAllocConfigInt(d, 'count_Request_ResourceSkill', 'Count_Request_ResourceSkill');
        Count_Resource_BulkAllocation = _readBulkAllocConfigInt(d,
            'count_Resource_BulkAllocation', 'Count_Resource_BulkAllocation',
            'countResourceBulkAllocation', 'CountResourceBulkAllocation');
        Count_Role_BulkAllocation = _readBulkAllocConfigInt(d, 'count_Role_BulkAllocation', 'Count_Role_BulkAllocation');
        _isAllowBackDatedAllocation = _parseAllowBackDatedAllocationFlag(_readRowValue(d, [
            'isAllowBackDatedAllocation', 'IsAllowBackDatedAllocation'
        ]));
        _isAgileMethodFollowed = _parseAgileMethodFollowedFlag(_readRowValue(d, [
            'isAgileMethodFollowed', 'IsAgileMethodFollowed'
        ]));
        _applyAgileProductOwnerVisibility();
    }

    function _parseAgileMethodFollowedFlag(v) {
        if (v === true || v === 1 || v === '1') return true;
        if (typeof v === 'string' && v.trim().toLowerCase() === 'true') return true;
        return false;
    }

    function _isAgileProjectForProductOwner() {
        return !!_isAgileMethodFollowed;
    }

    function _applyAgileProductOwnerVisibility() {
        var show = _isAgileProjectForProductOwner();
        var el = document.getElementById('divOcIsProductOwner');
        if (el) el.style.display = show ? 'flex' : 'none';
        if (!show) {
            var chk = document.getElementById('ocIsProductOwner');
            if (chk) chk.checked = false;
            _offcanvasLastDefaults.isProductOwner = false;
        }
    }

    /* Added By Dipali V On 17th Jun 2026 — keep Is Product Owner for main-page Allocate after offcanvas closes */
    function _persistOcIsProductOwnerDefault() {
        var chk = document.getElementById('ocIsProductOwner');
        _offcanvasLastDefaults.isProductOwner = !!(chk && chk.checked && _isAgileProjectForProductOwner());
    }

    function _getBulkAllocIsProductOwnerForApi() {
        if (!_isAgileProjectForProductOwner()) return 0;
        var chk = document.getElementById('ocIsProductOwner');
        if (chk && chk.checked) return 1;
        return _offcanvasLastDefaults.isProductOwner ? 1 : 0;
    }

    function _rrlIsProductOwnerFromRow($row) {
        if (!$row || !$row.length || !_isAgileProjectForProductOwner()) return false;
        var rowKey = _getRrlRowKey($row);
        var $po = rowKey ? $row.find('#rrl-po-' + rowKey) : $row.find('input[id^="rrl-po-"]');
        if ($po.length) return $po.prop('checked') === true;
        return ($row.attr('data-product-owner') || $row.attr('data-rrl-persisted-product-owner')) === '1';
    }

    function _parseAllowBackDatedAllocationFlag(v) {
        if (v === true || v === 1 || v === '1') return true;
        if (typeof v === 'string' && v.trim().toLowerCase() === 'true') return true;
        return false;
    }

    function _isAllowBackDatedAllocationRestrictEnabled() {
        return _parseAllowBackDatedAllocationFlag(_isAllowBackDatedAllocation);
    }

    function _getMaxResourcesPerRole() {
        var max = parseInt(Count_Resource_BulkAllocation, 10) || 0;
        return max > 0 ? max : 0;
    }

    function _getNoOfResMaxExceededMsg(maxVal) {
        var tpl = (RES.A_NoOfResBetween1And5 || '').toString();
        if (/\{0\}/.test(tpl)) return _resFmt(tpl, maxVal);
        return ': No. of Resources must be between 1 and ' + maxVal + '.';
    }

    function _getMaxRolesPerBulkAlloc() {
        var max = parseInt(Count_Role_BulkAllocation, 10) || 0;
        return max > 0 ? max : 0;
    }

    function _getMaxSkillsPerRole() {
        var max = parseInt(Count_Request_ResourceSkill, 10) || 0;
        return max > 0 ? max : 0;
    }

    function _parseValiNoOfResourceForBulkFlag(v) {
        if (v === true || v === 1 || v === '1') return true;
        if (typeof v === 'string' && v.trim().toLowerCase() === 'true') return true;
        return false;
    }

    function _isValiNoOfResourceForBulkEnabled() {
        return _parseValiNoOfResourceForBulkFlag(_isValiNoOfResourceForBulk);
    }

    /* Selection limits for Select Resource offcanvas — driven by No. of Resources + Count_Resource_BulkAllocation. */
    function _getResourceSelectionLimits(gid) {
        var minRequired = parseInt($('.rg-count[data-group="' + gid + '"]').val(), 10);
        if (isNaN(minRequired) || minRequired < 1) minRequired = 1;
        var maxPerRole = _getMaxResourcesPerRole();
        var maxAllowed = maxPerRole > 0 ? maxPerRole : minRequired;
        return { minRequired: minRequired, maxAllowed: maxAllowed, maxPerRole: maxPerRole };
    }

    function _validateResourceSelectionCount(gid, selectedCountOverride) {
        var selectedCount = (selectedCountOverride != null && selectedCountOverride !== '')
            ? (parseInt(selectedCountOverride, 10) || 0)
            : Array.from(tempSelected).length;
        var limits = _getResourceSelectionLimits(gid);
        alertify.set('notifier', 'position', 'top-right');
        /* Count_Resource_BulkAllocation ceiling always applies when configured. */
        if (limits.maxPerRole > 0 && selectedCount > limits.maxAllowed) {
            alertify.error(_rowLabel(gid) + _resFmt(RES.A_MaxRowsAllowed, limits.maxAllowed));
            return false;
        }
        /* No. of Resources vs selected count — only when IsValiNo_Of_Resource_ForBulk = 1 / true. */
        if (!_isValiNoOfResourceForBulkEnabled()) return true;
        var countVal = parseInt($('.rg-count[data-group="' + gid + '"]').val(), 10);
        if (isNaN(countVal) || countVal < 1) {
            alertify.error(_rowLabel(gid) + RES.A_NoOfResBetweenRow);
            var countEl = document.getElementById('rg-count-' + gid);
            if (countEl) { _markError(countEl, true); _ensureValidationControlVisibleAndFocus(countEl); }
            return false;
        }
        /* Added By Dipali V On 16th Jun 2026 — allow fewer resources than No. of Resources; block only when more than required */
        //if (selectedCount < limits.minRequired) {
        //    alertify.error(_rowLabel(gid) + _resFmt(RES.A_SelectedCountRequired, selectedCount, limits.minRequired));
        //    return false;
        //}
        if (selectedCount > limits.minRequired) {
            alertify.error(_rowLabel(gid) + _resFmt(RES.A_SelectedCountOnly, selectedCount, limits.minRequired));
            return false;
        }
        return true;
    }

    function _sumBulkAllocRgResourceCounts() {
        var total = 0;
        $('#bulkAllocationGroupsContainer .rg-count').each(function () {
            var n = parseInt(this.value, 10);
            if (!isNaN(n) && n > 0) total += n;
        });
        return total;
    }

    /* Added by dipali v on 18th Jun 2026 for purpose — project allocated count for No. of Resources validation */
    function _refreshProjectAllocatedResourceCount() {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) { _projectAllocatedResourceCount = 0; return; }
        _fetchRrlFromApi(projectId, 1, 1, 0, '', function (rows, pagination) {
            _projectAllocatedResourceCount = parseInt(pagination && pagination.totalRecords, 10) || 0;
        });
    }
    function _getProjectAllocatedResourceCount() {
        var badge = parseInt($('#rrl-tab-badge').text() || '0', 10) || 0;
        return badge > 0 ? badge : (parseInt(_projectAllocatedResourceCount, 10) || 0);
    }
    function _countPendingAllocateResources() {
        return document.querySelectorAll('tbody[id^="sel-res-body-"] tr').length;
    }
    function _shouldConfirmAllocateExceedProjectResources() {
        var projectCount = parseInt(_projectNoOfResource, 10) || parseInt(_projectNoOfResources, 10) || 0;
        if (projectCount <= 0) return false;
        var pending = _countPendingAllocateResources();
        return pending > 0 && (_getProjectAllocatedResourceCount() + pending) > projectCount;
    }

    function _bulkAllocConfirmExceedProjectResourcesMessage(rowCount, projectCount, opts) {
        opts = opts || {};
        if (opts.forAllocate) {
            return 'Already allocated resources (' + (opts.allocated || 0) + ') plus resources to be allocate (' + (opts.pending || 0) + ') exceed project No. of Resources (' + projectCount + '). Do you want to continue?';
        }
        var tpl = (RES.C_ConfirmExceedProjectResourcesMsg || RES.A_NoOfResProjectLess || '').toString().trim();
        if (tpl && /\{0\}/.test(tpl)) return _resFmt(tpl, rowCount, projectCount);
        if (tpl) {
            return tpl + ' (Entered: ' + rowCount + ', Project: ' + projectCount + '). Do you want to continue?';
        }
        return 'Project No. of Resources (' + projectCount + ') is less than the entered No. of Resources (' + rowCount + '). Do you want to continue?';
    }

    function showBulkAllocExceedProjectResourceConfirm(gid, forAllocate) {
        window._pendingOpenSelectResourceGid = forAllocate ? null : gid;
        window._pendingAllocateExceedConfirm = !!forAllocate;
        var projectCount = parseInt(_projectNoOfResource, 10) || parseInt(_projectNoOfResources, 10) || 0;
        var allocated = _getProjectAllocatedResourceCount();
        var pending = _countPendingAllocateResources();
        var rowCount = forAllocate ? (allocated + pending) : _sumBulkAllocRgResourceCounts();
        var $msg = $('#projectResourceExceedConfirmMessage');
        if ($msg.length) {
            $msg.text(_bulkAllocConfirmExceedProjectResourcesMessage(rowCount, projectCount, forAllocate
                ? { forAllocate: true, allocated: allocated, pending: pending } : null));
        }
        var modalEl = document.getElementById('projectResourceExceedConfirmModal');
        if (!modalEl) {
            window._pendingOpenSelectResourceGid = null;
            window._pendingAllocateExceedConfirm = false;
            if (forAllocate) {
                window._pendingAllocateExceedAcked = true;
                handleAllocate(true);
            } else {
                _openSelectResourceCore(gid, true);
            }
            return;
        }
        bootstrap.Modal.getOrCreateInstance(modalEl).show();
    }

    function closeBulkAllocExceedProjectResourceConfirm() {
        var modalEl = document.getElementById('projectResourceExceedConfirmModal');
        if (modalEl) bootstrap.Modal.getOrCreateInstance(modalEl).hide();
        window._pendingOpenSelectResourceGid = null;
        window._pendingAllocateExceedConfirm = false;
    }

    function showBulkAllocSkillNotSelectedConfirm(gid, skipExceedConfirm) {
        window._pendingOpenSelectResourceGid = gid;
        window._pendingSkillConfirmSkipExceed = !!skipExceedConfirm;
        var $msg = $('#skillNotSelectedConfirmMessage');
        if ($msg.length) $msg.text(RES.C_ConfirmSkillNotSelectedMsg || '');
        var modalEl = document.getElementById('skillNotSelectedConfirmModal');
        if (!modalEl) {
            window._pendingOpenSelectResourceGid = null;
            window._pendingSkillConfirmSkipExceed = false;
            _skipRoleSkillFilterByGroup[String(gid)] = true;
            _openSelectResourceCore(gid, !!skipExceedConfirm, true);
            return;
        }
        bootstrap.Modal.getOrCreateInstance(modalEl).show();
    }

    function closeBulkAllocSkillNotSelectedConfirm() {
        var modalEl = document.getElementById('skillNotSelectedConfirmModal');
        if (modalEl) bootstrap.Modal.getOrCreateInstance(modalEl).hide();
        window._pendingOpenSelectResourceGid = null;
        window._pendingSkillConfirmSkipExceed = false;
    }

    /* Added By Dipali V On 9th Jun 2026 — Probable match: resource skills differ from requested role skills */
    function _probableSkillMismatchMessage() {
        var msg = (RES.C_ConfirmResourceSkillDiffersMsg || '').toString().trim();
        return msg || 'Resource skill differs from requested. Do you want to continue?';
    }

    function _shouldValidateProbableSkillMismatch(gid) {
        if (!_pageSkillFilterEnabled) return false;
        if (getMatchType() !== 'probable') return false;
        if (_shouldSkipRoleSkillFilterForGroup(gid)) return false;
        return getBulkAllocRoleSkillFilters(gid).length > 0;
    }

    function _unwrapBulkAllocSkillMismatchIds(response) {
        if (!response) return [];
        var d = response.data !== undefined ? response.data : response;
        if (d && d.data !== undefined) d = d.data;
        var raw = (d && d.mismatchedEmployeeIDs) ? d.mismatchedEmployeeIDs
            : (d && d.MismatchedEmployeeIDs) ? d.MismatchedEmployeeIDs
            : (Array.isArray(d) ? d : []);
        if (!Array.isArray(raw)) return [];
        return raw.map(function (x) {
            if (typeof x === 'number') return x;
            return parseInt(x.employeeID || x.EmployeeID || x, 10) || 0;
        }).filter(function (id) { return id > 0; });
    }

    function _validateEmployeesSkillMismatch(employeeIds, skillFilters, onDone) {
        if (!employeeIds.length || !skillFilters.length) {
            if (typeof onDone === 'function') onDone(false);
            return;
        }
        var param = JSON.stringify({
            employeeIDs: employeeIds,
            skillFiltersJson: JSON.stringify(skillFilters)
        });
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/ValidateEmployeeSkillsForBulkAlloc',
            param, true,
            function (response) {
                var mismatched = _unwrapBulkAllocSkillMismatchIds(response);
                if (typeof onDone === 'function') onDone(mismatched.length > 0);
            },
            function () {
                console.warn('ValidateEmployeeSkillsForBulkAlloc failed — skipping skill mismatch gate.');
                if (typeof onDone === 'function') onDone(false);
            }
        );
    }

    function showBulkAllocResourceSkillDiffersConfirm(onYes, onNo) {
        window._pendingProbableSkillDiffersOnYes = onYes;
        window._pendingProbableSkillDiffersOnNo = onNo;
        var $msg = $('#resourceSkillDiffersConfirmMessage');
        if ($msg.length) $msg.text(_probableSkillMismatchMessage());
        var modalEl = document.getElementById('resourceSkillDiffersConfirmModal');
        if (!modalEl) {
            if (typeof onYes === 'function') onYes();
            return;
        }
        bootstrap.Modal.getOrCreateInstance(modalEl).show();
    }

    function closeBulkAllocResourceSkillDiffersConfirm(runNoHandler) {
        var modalEl = document.getElementById('resourceSkillDiffersConfirmModal');
        if (modalEl) bootstrap.Modal.getOrCreateInstance(modalEl).hide();
        var onNo = window._pendingProbableSkillDiffersOnNo;
        window._pendingProbableSkillDiffersOnYes = null;
        window._pendingProbableSkillDiffersOnNo = null;
        if (runNoHandler && typeof onNo === 'function') onNo();
    }

    function _collectProbableUnackedSkillMismatchChecks(onDone) {
        var checks = [];
        $('.resource-group').each(function () {
            var gid = $(this).data('group');
            if (!_shouldValidateProbableSkillMismatch(gid)) return;
            var employeeIds = [];
            $('#sel-res-body-' + gid + ' tr[data-sel-match-type="probable"]').each(function () {
                if ($(this).attr('data-skill-mismatch-acked') === '1') return;
                var id = parseInt($(this).attr('data-res-id'), 10) || 0;
                if (id > 0 && employeeIds.indexOf(id) === -1) employeeIds.push(id);
            });
            if (employeeIds.length > 0) {
                checks.push({ gid: gid, employeeIds: employeeIds, filters: getBulkAllocRoleSkillFilters(gid) });
            }
        });
        if (!checks.length) {
            onDone(false, []);
            return;
        }
        var hasMismatch = false;
        var pending = checks.length;
        var ackFns = [];
        checks.forEach(function (chk) {
            _validateEmployeesSkillMismatch(chk.employeeIds, chk.filters, function (mismatch) {
                if (mismatch) {
                    hasMismatch = true;
                    chk.employeeIds.forEach(function (empId) {
                        ackFns.push(function () {
                            $('#sel-res-body-' + chk.gid + ' tr[data-res-id="' + empId + '"]').attr('data-skill-mismatch-acked', '1');
                        });
                    });
                }
                pending--;
                if (pending === 0) onDone(hasMismatch, ackFns);
            });
        });
    }

    function _shouldSkipRoleSkillFilterForGroup(gid) {
        return !!_skipRoleSkillFilterByGroup[String(gid)];
    }

    function LoadProjectDetails() {
      //  debugger
        var projectId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID) : 0;
        if (!projectId || projectId <= 0) {
            document.getElementById('pdProjectName').textContent = 'N/A';
            _markRrlExtendRefreshGate('details');
            return;
        }
        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetProjectDetails',
            JSON.stringify({ ProjectID: projectId }), true,
            function (response) {
                var d = _parseProjectDetailsRow(response);
                if (!d) {
                    _markRrlExtendRefreshGate('details');
                    return;
                }
                var projName = d.ProjectName || d.projectName || '';
                var rawStart = d.StartDate || d.startDate || '';
                var rawEnd = d.EndDate || d.endDate || '';
                var rawProjectHours = _readRowValue(d, ['workHours', 'WorkHours']) || 0;
                var rawOUWorkingHours = _readRowValue(d, [
                    'ouWorkingHours', 'OUWorkingHours', 'projectOUWorkingHours', 'ProjectOUWorkingHours',
                    'workHrsPerDay', 'WorkHrsPerDay'
                ]) || 0;
                _setProjectNameDisplay(projName || 'N/A');
                document.getElementById('pdStartDate').textContent = _fmtDisplayDate(rawStart) || '—';
                document.getElementById('pdEndDate').textContent = _fmtDisplayDate(rawEnd) || '—';
                _applyBulkAllocProjectConfigFromRow(d);
                _refreshProjectAllocatedResourceCount(); /* Added by dipali v on 18th Jun 2026 for purpose — track already allocated resource count */
                _projectHoursCap = parseFloat(rawProjectHours) || 0;
                var rawAllocatedHours = _readRowValue(d, [
                    'totalWorks', 'TotalWorks',
                    'totalAllocatedHours', 'TotalAllocatedHours',
                    'allocatedWorkHours', 'AllocatedWorkHours',
                    'totalBudgetedHours', 'TotalBudgetedHours'
                ]) || 0;
                _projectTotalAllocatedHours = parseFloat(rawAllocatedHours) || 0;
                _projectOUWorkingHours = parseFloat(rawOUWorkingHours) || 0;
                _projectStartRaw = rawStart;
                _projectEndRaw = rawEnd;
                try { _projectStartDate = $.datepicker.parseDate('dd M yy', rawStart); } catch (e) { _projectStartDate = null; }
                try { _projectEndDate = $.datepicker.parseDate('dd M yy', rawEnd); } catch (e) { _projectEndDate = null; }
                prefillAllGroupDates();
                _initialProjectDefaultApproverEmployeeId = _parseProjectDefaultApproverFromResponse(response);
                _projectDefaultApproverEmployeeId = _initialProjectDefaultApproverEmployeeId;
                if (typeof _applyProjectDefaultApproverReportingTo === 'function') _applyProjectDefaultApproverReportingTo();
                _markRrlExtendRefreshGate('details');
            },
            function () {
                _setProjectNameDisplay(RES.C_ErrorLoadingProject);
                _initialProjectDefaultApproverEmployeeId = 0;
                _projectDefaultApproverEmployeeId = 0;
                _markRrlExtendRefreshGate('details');
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }

    function _hoursDecimalToHHMM(hoursVal) {
        var h = parseFloat(hoursVal);
        if (isNaN(h) || h <= 0) return '';
        var totalMinutes = Math.round(h * 60);
        var hh = Math.floor(totalMinutes / 60);
        var mm = totalMinutes % 60;
        return String(hh).padStart(2, '0') + ':' + String(mm).padStart(2, '0');
    }

    function _hhmmToDecimal(hoursText) {
        var v = String(hoursText || '').trim();
        if (!v) return null;
        if (v.indexOf(':') === -1) {
            var onlyHrs = parseFloat(v);
            return isNaN(onlyHrs) ? null : onlyHrs;
        }
        var parts = v.split(':');
        if (parts.length !== 2) return null;
        var hh = parseInt(parts[0], 10);
        var mm = parseInt(parts[1], 10);
        if (isNaN(hh) || isNaN(mm) || mm < 0 || mm > 59) return null;
        return hh + (mm / 60);
    }

    function _setInputInlineValidation(input, message, msgId) {
        if (!input) return;
        var msgEl = document.getElementById(msgId);
        if (!msgEl) {
            msgEl = document.createElement('div');
            msgEl.id = msgId;
            msgEl.className = 'field-inline-error';
            input.insertAdjacentElement('afterend', msgEl);
        }
        if (message) {
            input.classList.add('oc-val-error');
            msgEl.textContent = message;
            msgEl.style.display = 'block';
        } else {
            input.classList.remove('oc-val-error');
            msgEl.textContent = '';
            msgEl.style.display = 'none';
        }
    }

    function _setOcWorkValidation(message) {
        _setInputInlineValidation(document.getElementById('ocWorkHM'), message, 'ocWorkHMValidationMsg');
    }

    function _budgetedHoursToDecimal(val) {
        if (val == null || val === '') return 0;
        if (typeof val === 'number' && !isNaN(val)) return val;
        var s = String(val).trim();
        if (!s) return 0;
        if (s.indexOf(':') >= 0) {
            var hhmm = _hhmmToDecimal(s);
            return hhmm == null ? 0 : hhmm;
        }
        var n = parseFloat(s);
        return isNaN(n) ? 0 : n;
    }

    function _projectWorkHoursExceededMessage() {
        return _resFmt(RES.A_WorkHHMMExceedsProject, (_projectHoursCap || 0).toFixed(2));
    }

    function _sumSelectedResourceWorkHours(skipUid) {
        var total = 0;
        document.querySelectorAll('tbody[id^="sel-res-body-"] tr').forEach(function (tr) {
            var empId = tr.getAttribute('data-res-id');
            if (!empId) return;
            var tbodyId = (tr.closest('tbody') && tr.closest('tbody').id) ? tr.closest('tbody').id : '';
            var gid = tbodyId.replace('sel-res-body-', '');
            var uid = gid + '_' + empId;
            if (skipUid && uid === skipUid) return;
            var workEl = document.getElementById('txtWork_res_' + uid);
            total += _budgetedHoursToDecimal(workEl ? workEl.value : '');
        });
        return total;
    }

    function _sumSelectedResourceWorkHoursExceptGroup(exceptGid) {
        var total = 0;
        document.querySelectorAll('tbody[id^="sel-res-body-"]').forEach(function (tbody) {
            var gid = (tbody.id || '').replace('sel-res-body-', '');
            if (exceptGid != null && String(gid) === String(exceptGid)) return;
            $(tbody).find('tr').each(function () {
                var empId = $(this).attr('data-res-id');
                if (!empId) return;
                var uid = gid + '_' + empId;
                var workEl = document.getElementById('txtWork_res_' + uid);
                total += _budgetedHoursToDecimal(workEl ? workEl.value : '');
            });
        });
        return total;
    }

    function _countOffcanvasPendingResourceSelections() {
        return tempSelected ? tempSelected.size : 0;
    }

    /* Offcanvas / Select Resource: already allocated on project + (work per resource × checked count) + other role rows pending allocate */
    function _calcOffcanvasPendingProjectWorkHoursTotal(perResourceHours, gid) {
        var workH = parseFloat(perResourceHours);
        if (isNaN(workH)) return null;
        var base = parseFloat(_projectTotalAllocatedHours) || 0;
        var otherGroupsPending = _sumSelectedResourceWorkHoursExceptGroup(gid || activeGroupId);
        var selCount = _countOffcanvasPendingResourceSelections();
        if (selCount <= 0) selCount = 1;
        return base + otherGroupsPending + (workH * selCount);
    }

    function _wouldExceedProjectWorkHoursCapForOffcanvasBatch(perResourceHours, gid) {
        var cap = parseFloat(_projectHoursCap) || 0;
        if (cap <= 0) return false;
        var total = _calcOffcanvasPendingProjectWorkHoursTotal(perResourceHours, gid);
        if (total == null) return false;
        return total > (cap + 0.0001);
    }

    function _wouldExceedProjectWorkHoursCap(newHoursDecimal, options) {
        options = options || {};
        var cap = parseFloat(_projectHoursCap) || 0;
        if (cap <= 0) return false;
        var newH = parseFloat(newHoursDecimal);
        if (isNaN(newH)) return false;

        var base = parseFloat(_projectTotalAllocatedHours) || 0;
        var excludePerId = parseInt(options.excludeProjectEmployeeRoleId, 10) || 0;
        if (excludePerId > 0) {
            var apiRow = _lookupRrlApiRowByPerId(options.gid, excludePerId);
            if (apiRow) {
                base -= _budgetedHoursToDecimal(apiRow.budgetedHours || apiRow.BudgetedHours);
            }
        }
        var additional = parseFloat(options.additionalHoursFromOthers);
        if (isNaN(additional)) additional = 0;
        return (base + additional + newH) > (cap + 0.0001);
    }

    function _validateBulkAllocationWorkHoursTotal(skipUid) {
        var cap = parseFloat(_projectHoursCap) || 0;
        if (cap <= 0) return { ok: true };
        var batchTotal = _sumSelectedResourceWorkHours(skipUid);
        if ((_projectTotalAllocatedHours || 0) + batchTotal > cap) {
            return { ok: false, message: _projectWorkHoursExceededMessage() };
        }
        return { ok: true };
    }

    function _validateRrlBatchWorkHoursBudget(gid, projectEmployeeRoles) {
        var cap = parseFloat(_projectHoursCap) || 0;
        if (cap <= 0) return { ok: true };
        var base = parseFloat(_projectTotalAllocatedHours) || 0;
        var delta = 0;
        var seen = {};
        (projectEmployeeRoles || []).forEach(function (item) {
            var perId = parseInt(item.projectEmployeeRoleId, 10) || 0;
            if (!perId || seen[perId]) return;
            seen[perId] = true;
            var newH = _budgetedHoursToDecimal(item.budgetedHours);
            var oldH = 0;
            var apiRow = _lookupRrlApiRowByPerId(gid, perId);
            if (apiRow) oldH = _budgetedHoursToDecimal(apiRow.budgetedHours || apiRow.BudgetedHours);
            delta += (newH - oldH);
        });
        if (base + delta > cap) {
            return { ok: false, message: _projectWorkHoursExceededMessage() };
        }
        return { ok: true };
    }

    function _applyProjectAllocatedHoursDelta(delta) {
        var d = parseFloat(delta);
        if (isNaN(d)) return;
        _projectTotalAllocatedHours = (parseFloat(_projectTotalAllocatedHours) || 0) + d;
        if (_projectTotalAllocatedHours < 0) _projectTotalAllocatedHours = 0;
    }

    function _validateOcWorkHoursLimit() {
        var input = document.getElementById('ocWorkHM');
        if (!input) return true;
        var val = String(input.value || '').trim();
        if (!val) { _setOcWorkValidation(''); return true; }
        var workHours = _hhmmToDecimal(val);
        if (workHours == null) {
            _setOcWorkValidation(RES.A_WorkHHMMInvalid);
            return false;
        }
        if (_wouldExceedProjectWorkHoursCapForOffcanvasBatch(workHours, activeGroupId)) {
            _setOcWorkValidation(_projectWorkHoursExceededMessage());
            return false;
        }
        _setOcWorkValidation('');
        return true;
    }

    function _isRgWorkHoursVisible() {
        return typeof _baColIsVisible === 'function' && _baColIsVisible('work-hh');
    }

    function _getRgWorkHoursValue(gid) {
        if (!gid) return '';
        var v = ($('#rg-work-' + gid).val() || '').trim();
        if (v) return v;
        if (String(activeGroupId) === String(gid)) return ($('#ocWorkHM').val() || '').trim();
        return '';
    }

    function _canRefreshRgAutoWorkHours(gid) {
        if (!gid) return false;
        var startISO = displayDateToISO($('.rg-start[data-group="' + gid + '"]').val());
        var endISO = displayDateToISO($('.rg-end[data-group="' + gid + '"]').val());
        var allocPct = _parseIntegerAllocation($('.rg-alloc[data-group="' + gid + '"]').val());
        return !!(startISO && endISO && !isNaN(allocPct) && allocPct >= 1 && allocPct <= _maxAllocPct);
    }

    function _fetchAutoWorkHours(startISO, endISO, allocPct, noOfRes, onSuccess, onError) {
        if (!startISO || !endISO || isNaN(allocPct) || allocPct < 1 || allocPct > _maxAllocPct) return;
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetBulkAllocAutoWorkHours',
            JSON.stringify({
                projectID: parseInt(SessionProjectID, 10) || 0,
                userID: parseInt(SessionUserID, 10) || 0,
                expectedStartDate: startISO,
                expectedEndDate: endISO,
                noOfResources: noOfRes || 1,
                resourcePercentage: allocPct,
                ou: 0,
                fromWhereData: 'PM_BulkResAllocation'
            }), true,
            function (response) {
                var r = (response && response.data) ? response.data : response;
                var autoHours = parseFloat((r && (r.autoHours || r.AutoHours || r.totalHours || r.TotalHours)) || 0);
                var hhmm = _hoursDecimalToHHMM(autoHours);
                if (typeof onSuccess === 'function') onSuccess(hhmm || '');
            },
            function () {
                if (typeof onError === 'function') onError();
            }
        );
    }

    function _fetchBulkAllocAutoWorkHours(gid, onSuccess, onError) {
        if (!gid || !_canRefreshRgAutoWorkHours(gid)) return;
        _fetchAutoWorkHours(
            displayDateToISO($('.rg-start[data-group="' + gid + '"]').val()),
            displayDateToISO($('.rg-end[data-group="' + gid + '"]').val()),
            _parseIntegerAllocation($('.rg-alloc[data-group="' + gid + '"]').val()),
            parseInt($('.rg-count[data-group="' + gid + '"]').val(), 10) || 1,
            onSuccess, onError
        );
    }

    function _syncOcWorkHoursToRgList(gid, hhmm) {
        if (!gid) return;
        var val = (hhmm || '').toString().trim();
        if ($('#rg-work-' + gid).length) $('#rg-work-' + gid).val(val);
        _offcanvasLastDefaults.workHM = val;
    }

    function _isBaOffcanvasOpenForGid(gid) {
        if (!gid || String(activeGroupId) !== String(gid)) return false;
        var oc = document.getElementById('selectResourceOffcanvas');
        return !!(oc && (oc.classList.contains('show') || oc.classList.contains('showing')));
    }

    function _shouldSyncBaOcWorkHours(gid, syncOc) {
        return !!syncOc || (!_isRgWorkHoursVisible() && String(activeGroupId) === String(gid));
    }

    function _applyRgWorkHoursValue(gid, hhmm, syncOffcanvas) {
        if (!hhmm) return;
        if ($('#rg-work-' + gid).length) $('#rg-work-' + gid).val(hhmm);
        _offcanvasLastDefaults.workHM = hhmm;
        if (_shouldSyncBaOcWorkHours(gid, syncOffcanvas)) {
            $('#ocWorkHM').val(hhmm);
            _validateOcWorkHoursLimit();
        }
        if (!_isRgWorkHoursVisible()) {
            $('#sel-res-body-' + gid + ' input[id^="txtWork_res_"]').val(hhmm);
        }
    }

    function _autoPopulateRgWorkHours(gid, opts) {
        opts = opts || {};
        if (!gid || !_canRefreshRgAutoWorkHours(gid)) return;
        var workVisible = _isRgWorkHoursVisible();
        var syncOc = opts.syncOffcanvas != null ? !!opts.syncOffcanvas : _isBaOffcanvasOpenForGid(gid);
        if (workVisible) {
            var current = ($('#rg-work-' + gid).val() || '').trim();
            if (opts.onlyIfEmpty && current) {
                if (_shouldSyncBaOcWorkHours(gid, syncOc)) _applyRgWorkHoursValue(gid, current, syncOc);
                return;
            }
        }
        _fetchBulkAllocAutoWorkHours(gid, function (hhmm) {
            if (!hhmm) return;
            _applyRgWorkHoursValue(gid, hhmm, syncOc);
        });
    }

    function _autoPopulateRgWorkHoursAllGroups(opts) {
        if (!_isRgWorkHoursVisible()) return;
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            var gid = $(this).attr('data-group');
            if (gid) _autoPopulateRgWorkHours(gid, opts);
        });
    }

    function _bindRgWorkHoursListSync(gid) {
        var $work = $('#rg-work-' + gid);
        if (!$work.length || $work.data('workListSyncBound')) return;
        $work.data('workListSyncBound', true);
        $work.on('input change', function () {
            if (String(activeGroupId) !== String(gid)) return;
            var val = ($(this).val() || '').trim();
            $('#ocWorkHM').val(val);
            _offcanvasLastDefaults.workHM = val;
            if (val) _validateOcWorkHoursLimit();
            else _setOcWorkValidation('');
        });
    }

    function _bindOcWorkHoursOffcanvasSync() {
        var $oc = $('#selectResourceOffcanvas');
        if (!$oc.length || $oc.data('workOcSyncBound')) return;
        $oc.data('workOcSyncBound', true);
        $oc.on('input change', '#ocWorkHM', function () {
            var gid = activeGroupId;
            if (!gid) return;
            _syncOcWorkHoursToRgList(gid, $(this).val());
        });
    }

    /* Added By Dipali V On 9th Jun 2026 — Resource Status: offcanvas ↔ role row ↔ list view */
    function _setBaResourceStatusSelectValue($sel, statusVal) {
        if (!$sel || !$sel.length) return;
        var v = (statusVal == null ? '' : String(statusVal));
        if (String($sel.val() || '') === v) return;
        $sel.val(v);
        if ($sel.data('selectpicker')) $sel.selectpicker('refresh');
    }

    function _syncResourceStatusToOffcanvas(statusVal) {
        _setBaResourceStatusSelectValue($('#ocResourceStatus'), statusVal);
        _offcanvasLastDefaults.resourceStatus = (statusVal == null ? '' : String(statusVal));
    }

    function _syncResourceStatusToRgRow(gid, statusVal) {
        if (!gid) return;
        _setBaResourceStatusSelectValue($('#rg-status-' + gid), statusVal);
    }

    function _syncResourceStatusToAllListRows(gid, statusVal) {
        if (!gid) return;
        $('#sel-res-body-' + gid + ' select[id^="cboResStatus_res_"]').each(function () {
            _setBaResourceStatusSelectValue($(this), statusVal);
        });
    }

    function _applyResourceStatusSync(gid, statusVal, source) {
        if (_syncingResourceStatus) return;
        _syncingResourceStatus = true;
        try {
            var v = (statusVal == null ? '' : String(statusVal));
            if (source !== 'oc') _syncResourceStatusToOffcanvas(v);
            if (source !== 'rg' && gid) _syncResourceStatusToRgRow(gid, v);
            if (source !== 'list' && gid) _syncResourceStatusToAllListRows(gid, v);
        } finally {
            _syncingResourceStatus = false;
        }
    }

    function _parseSelResStatusControlGid(selectId) {
        var id = String(selectId || '');
        if (id.indexOf('cboResStatus_res_') !== 0) return null;
        var uid = id.replace('cboResStatus_res_', '');
        var sep = uid.indexOf('_');
        if (sep < 0) return null;
        return uid.substring(0, sep);
    }

    function _bindRgResourceStatusSync(gid) {
        var $sel = $('#rg-status-' + gid);
        if (!$sel.length || $sel.data('statusSyncBound')) return;
        $sel.data('statusSyncBound', true);
        $sel.on('changed.bs.select', function () {
            if (_syncingResourceStatus) return;
            _applyResourceStatusSync(gid, $(this).val(), 'rg');
        });
    }

    function _bindOcResourceStatusOffcanvasSync() {
        var $oc = $('#selectResourceOffcanvas');
        if (!$oc.length || $oc.data('statusOcSyncBound')) return;
        $oc.data('statusOcSyncBound', true);
        $oc.on('changed.bs.select', '#ocResourceStatus', function () {
            if (_syncingResourceStatus) return;
            var gid = activeGroupId;
            if (!gid) return;
            _applyResourceStatusSync(gid, $(this).val(), 'oc');
        });
    }

    function _bindBaResourceStatusListDelegation() {
        var $container = $('#bulkAllocationGroupsContainer');
        if (!$container.length || $container.data('statusListSyncBound')) return;
        $container.data('statusListSyncBound', true);
        $container.on('changed.bs.select', 'select[id^="cboResStatus_res_"]', function () {
            if (_syncingResourceStatus) return;
            var gid = _parseSelResStatusControlGid(this.id);
            if (!gid) return;
            _applyResourceStatusSync(gid, $(this).val(), 'list');
        });
    }

    /* Added By Dipali V On 9th Jun 2026 — Reporting To: offcanvas ↔ role row ↔ list view */
    function _setBaReportingToSelectValue($sel, rptVal) {
        if (!$sel || !$sel.length) return;
        var v = (rptVal == null ? '' : String(rptVal)).trim();
        if (v && v !== '0' && !_matchReportingToOptionValue($sel, v)) {
            var id = parseInt(v, 10) || 0;
            var name = '';
            var all = window._reportingToAllRows || window._reportingToOptions || [];
            for (var i = 0; i < all.length; i++) {
                if ((parseInt(_getReportingToRowId(all[i]), 10) || 0) === id) {
                    name = _getReportingToRowName(all[i]);
                    break;
                }
            }
            if (name) _syncReportingToOptionToSelect($sel, v, name);
        }
        var match = (v && v !== '0') ? (_matchReportingToOptionValue($sel, v) || v) : v;
        if (String($sel.val() || '').trim() === String(match || '').trim()) {
            return;
        }
        try {
            if ($sel.data('selectpicker')) {
                $sel.selectpicker('val', match);
            } else {
                $sel.val(match);
            }
        } catch (e) {
            $sel.val(match);
        }
    }

    function _syncReportingToToOffcanvas(rptVal) {
        _setBaReportingToSelectValue($('#ocReportingTo'), rptVal);
    }

    function _syncReportingToToRgRow(gid, rptVal) {
        if (!gid) return;
        _setBaReportingToSelectValue($('#rg-rpt-' + gid), rptVal);
    }

    function _syncReportingToToAllListRows(gid, rptVal) {
        if (!gid) return;
        $('#sel-res-body-' + gid + ' select[id^="cboReportingTo_res_"]').each(function () {
            _setBaReportingToSelectValue($(this), rptVal);
        });
    }

    function _applyReportingToSync(gid, rptVal, source) {
        if (_syncingReportingTo) return;
        _syncingReportingTo = true;
        try {
            var v = (rptVal == null ? '' : String(rptVal)).trim();
            if (source !== 'oc') _syncReportingToToOffcanvas(v);
            if (source !== 'rg' && gid) _syncReportingToToRgRow(gid, v);
            if (source !== 'list' && gid) _syncReportingToToAllListRows(gid, v);
        } finally {
            _syncingReportingTo = false;
        }
    }

    function _parseSelResReportingToControlGid(selectId) {
        var id = String(selectId || '');
        if (id.indexOf('cboReportingTo_res_') !== 0) return null;
        var uid = id.replace('cboReportingTo_res_', '');
        var sep = uid.indexOf('_');
        if (sep < 0) return null;
        return uid.substring(0, sep);
    }

    function _bindRgReportingToSync(gid) {
        var $sel = $('#rg-rpt-' + gid);
        if (!$sel.length || $sel.data('rptSyncBound')) return;
        $sel.data('rptSyncBound', true);
        $sel.on('changed.bs.select change', function () {
            if (_syncingReportingTo) return;
            _applyReportingToSync(gid, $(this).val(), 'rg');
        });
    }
    //Added By Dipali V On 15th Jun 2026 — Reporting To: offcanvas ↔ role row ↔ list view - bind change event for role row dropdown
    function _bindBaReportingToRgRowDelegation() {
        var $container = $('#bulkAllocationGroupsContainer');
        if (!$container.length || $container.data('rptRgSyncBound')) return;
        $container.data('rptRgSyncBound', true);
        $container.on('changed.bs.select change', 'select[id^="rg-rpt-"]', function () {
            if (_syncingReportingTo) return;
            var gid = String(this.id || '').replace('rg-rpt-', '');
            if (!gid) return;
            _applyReportingToSync(gid, $(this).val(), 'rg');
        });
    }
    //End of Added By Dipali V On 15th Jun 2026 — Reporting To: offcanvas ↔ role row ↔ list view - bind change event for role row dropdown
    function _bindOcReportingToOffcanvasSync() {
        var $oc = $('#selectResourceOffcanvas');
        if (!$oc.length || $oc.data('rptOcSyncBound')) return;
        $oc.data('rptOcSyncBound', true);
        $oc.on('changed.bs.select', '#ocReportingTo', function () {
            if (_syncingReportingTo) return;
            var gid = activeGroupId;
            if (!gid) return;
            _applyReportingToSync(gid, $(this).val(), 'oc');
        });
    }

    function _bindBaReportingToListDelegation() {
        var $container = $('#bulkAllocationGroupsContainer');
        if (!$container.length || $container.data('rptListSyncBound')) return;
        $container.data('rptListSyncBound', true);
        $container.on('changed.bs.select change', 'select[id^="cboReportingTo_res_"]', function () {
            if (_syncingReportingTo) return;
            var gid = _parseSelResReportingToControlGid(this.id);
            if (!gid) return;
            _applyReportingToSync(gid, $(this).val(), 'list');
        });
    }

    function _getOffcanvasResponsibilitiesForGroup(gid) {
        if (!gid) return '';
        var map = _offcanvasLastDefaults.responsibilitiesByGroup || {};
        return (map[String(gid)] != null) ? String(map[String(gid)]) : '';
    }

    function _setOffcanvasResponsibilitiesForGroup(gid, val) {
        if (!gid) return;
        if (!_offcanvasLastDefaults.responsibilitiesByGroup) {
            _offcanvasLastDefaults.responsibilitiesByGroup = {};
        }
        _offcanvasLastDefaults.responsibilitiesByGroup[String(gid)] = (val == null ? '' : String(val));
    }

    function _syncResponsibilitiesToOffcanvas(gid) {
        if (!gid) {
            $('#ocResponsibilities').val('');
            return;
        }
        var val = _getOffcanvasResponsibilitiesForGroup(gid);
        if (!val) {
            $('#sel-res-body-' + gid + ' textarea[id^="txtResponsibility_res_"]').each(function () {
                var t = String($(this).val() || '').trim();
                if (t) {
                    val = t;
                    return false;
                }
            });
            if (val) _setOffcanvasResponsibilitiesForGroup(gid, val);
        }
        $('#ocResponsibilities').val(val);
    }

    /* Added By Dipali V On 9th Jun 2026 — Billable & Default Approver: offcanvas ↔ role row ↔ list view */
    function _setBaCheckboxChecked($el, checked) {
        if (!$el || !$el.length) return;
        var want = !!checked;
        if ($el.prop('checked') === want) return;
        $el.prop('checked', want);
    }

    function _parseSelResCheckboxControlGid(id) {
        var parts = String(id || '').split('_');
        if (parts.length >= 4 && parts[1] === 'res') return parts[2];
        return null;
    }

    function _applyBillableSync(gid, checked, source) {
        if (_syncingBaCheckboxFields) return;
        _syncingBaCheckboxFields = true;
        try {
            var val = !!checked;
            if (source !== 'oc') _setBaCheckboxChecked($('#ocIsBillable'), val);
            if (source !== 'rg' && gid) _setBaCheckboxChecked($('#rg-billable-' + gid), val);
            if (source !== 'list' && gid) {
                $('#sel-res-body-' + gid + ' input[id^="chkBillable_res_"]').each(function () {
                    _setBaCheckboxChecked($(this), val);
                });
            }
        } finally {
            _syncingBaCheckboxFields = false;
        }
    }

    function _applyDefaultApproverSync(gid, checked, source) {
        if (_syncingBaCheckboxFields) return;
        if (typeof _isDefaultApproverColumnAllowed === 'function' && !_isDefaultApproverColumnAllowed()) return;
        var allow = gid && _getRgNoOfResources(gid) === 1;
        var val = !!checked && !!allow;
        _syncingBaCheckboxFields = true;
        try {
            var $oc = $('#ocIsDefaultApprover');
            if ($oc.length && !$oc.prop('disabled')) _setBaCheckboxChecked($oc, val);
            else if ($oc.length) _setBaCheckboxChecked($oc, false);
            if (source !== 'rg' && gid) {
                var $rg = $('#rg-approver-' + gid);
                if ($rg.length && !$rg.prop('disabled')) _setBaCheckboxChecked($rg, val);
                else if ($rg.length) _setBaCheckboxChecked($rg, false);
            }
            if (source !== 'list' && gid) {
                var $boxes = $('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]');
                if (val) {
                    $boxes.prop('checked', false);
                    if ($boxes.length) $boxes.first().prop('checked', true);
                } else {
                    $boxes.prop('checked', false);
                }
            }
        } finally {
            _syncingBaCheckboxFields = false;
        }
    }

    function _bindRgBillableApproverSync(gid) {
        var $bill = $('#rg-billable-' + gid);
        if ($bill.length && !$bill.data('billableSyncBound')) {
            $bill.data('billableSyncBound', true);
            $bill.on('change', function () {
                if (_syncingBaCheckboxFields) return;
                _applyBillableSync(gid, this.checked, 'rg');
            });
        }
        var $appr = $('#rg-approver-' + gid);
        if ($appr.length && !$appr.data('approverSyncBound')) {
            $appr.data('approverSyncBound', true);
            $appr.on('change', function () {
                if (_syncingBaCheckboxFields) return;
                if (this.checked) {
                    $('#bulkAllocationGroupsContainer input[id^="rg-approver-"]').not(this).prop('checked', false);
                    $('#bulkAllocationGroupsContainer input[id^="chkApprover_res_"]').prop('checked', false);
                }
                _applyDefaultApproverSync(gid, this.checked, 'rg');
                if (typeof _syncBaDefaultApproverAllGroups === 'function') _syncBaDefaultApproverAllGroups();
            });
        }
    }

    function _bindOcBillableApproverOffcanvasSync() {
        var $oc = $('#selectResourceOffcanvas');
        if (!$oc.length || $oc.data('billableApproverOcSyncBound')) return;
        $oc.data('billableApproverOcSyncBound', true);
        $oc.on('change', '#ocIsBillable', function () {
            if (_syncingBaCheckboxFields) return;
            var gid = activeGroupId;
            if (!gid) return;
            _applyBillableSync(gid, this.checked, 'oc');
        });
        /* Added By Dipali V On 17th Jun 2026 — persist Is Product Owner for main-page Allocate after offcanvas closes */
        $oc.on('change', '#ocIsProductOwner', function () {
            _persistOcIsProductOwnerDefault();
        });
        $oc.on('change', '#ocIsDefaultApprover', function () {
            if (_syncingBaCheckboxFields) return;
            var gid = activeGroupId;
            if (!gid) return;
            if (this.checked && typeof _isDefaultApproverColumnAllowed === 'function' && _isDefaultApproverColumnAllowed()) {
                var pendingEmpId = _baFindPendingDefaultApproverEmployeeId();
                if (!pendingEmpId && draftSelectedByGroup[gid] && draftSelectedByGroup[gid].length === 1) {
                    pendingEmpId = parseInt(draftSelectedByGroup[gid][0], 10) || 0;
                }
                if (_needsDefaultApproverChangeConfirm(pendingEmpId, 0, null, null)) {
                    var $cb = $(this);
                    $cb.prop('checked', false);
                    _promptDefaultApproverChange(
                        function () {
                            window._baDefaultApproverChangeAcked = true;
                            _applyDefaultApproverSync(gid, true, 'oc');
                            _syncBaDefaultApproverAllGroups();
                        },
                        function () {
                            window._baDefaultApproverChangeAcked = false;
                            $cb.prop('checked', false);
                        }
                    );
                    return;
                }
            }
            if (!this.checked) window._baDefaultApproverChangeAcked = false;
            if (this.checked) {
                $('#bulkAllocationGroupsContainer input[id^="rg-approver-"]').not('#rg-approver-' + gid).prop('checked', false);
                $('#bulkAllocationGroupsContainer input[id^="chkApprover_res_"]').prop('checked', false);
            }
            _applyDefaultApproverSync(gid, this.checked, 'oc');
            _syncBaDefaultApproverAllGroups();
        });
    }

    function _bindBaBillableApproverListDelegation() {
        var $container = $('#bulkAllocationGroupsContainer');
        if (!$container.length || $container.data('billableListSyncBound')) return;
        $container.data('billableListSyncBound', true);
        $container.on('change', 'input[id^="chkBillable_res_"]', function () {
            if (_syncingBaCheckboxFields) return;
            var gid = _parseSelResCheckboxControlGid(this.id);
            if (!gid) return;
            _applyBillableSync(gid, this.checked, 'list');
        });
    }

    function _maybeRefreshRgWorkHoursFromDates(gid) {
        if (!_canRefreshRgAutoWorkHours(gid)) return;
        var syncOc = _isBaOffcanvasOpenForGid(gid) || (!_isRgWorkHoursVisible() && String(activeGroupId) === String(gid));
        if (syncOc) {
            $('#ocStartDate').val($('.rg-start[data-group="' + gid + '"]').val() || '');
            $('#ocEndDate').val($('.rg-end[data-group="' + gid + '"]').val() || '');
            $('#ocAllocation').val($('.rg-alloc[data-group="' + gid + '"]').val() || '');
        }
        _autoPopulateRgWorkHours(gid, { onlyIfEmpty: false, syncOffcanvas: syncOc });
    }

    function _autoPopulateOffcanvasWorkHours(gid) {
        if (!gid) return;
        var listWork = ($('#rg-work-' + gid).val() || '').trim();
        if (listWork) {
            _applyRgWorkHoursValue(gid, listWork, true);
            return;
        }
        _autoPopulateRgWorkHours(gid, { syncOffcanvas: true, onlyIfEmpty: false });
    }

    // Added by Vyankat B. on 18-May-2026 – Extend project end date modal (GetProjectEmployeeEndExtended + pagination).
    function _formatDateForExtendApi(dateObj) {
        if (!dateObj || isNaN(dateObj.getTime())) return null;
        var y = dateObj.getFullYear();
        var m = ('0' + (dateObj.getMonth() + 1)).slice(-2);
        var d = ('0' + dateObj.getDate()).slice(-2);
        return y + '-' + m + '-' + d;
    }

    function _getExtendProjectNewExpectedEndDate() {
        if (_projectEndDate) {
            return _formatDateForExtendApi(_projectEndDate);
        }
        if (_projectEndRaw) {
            try {
                var parsed = $.datepicker.parseDate('dd M yy', _projectEndRaw);
                return _formatDateForExtendApi(parsed);
            } catch (e) { /* ignore */ }
        }
        return null;
    }

    function _tryShowExtendProjectModal() {
        /* Popup hidden — Reallocation tab shows conditional note via _updateRrlExtendNoteVisibility */
        _updateRrlExtendNoteVisibility();
    }

    /* Added By Dipali V On 5th Jun 2026 — conditional note on Reallocation tab when project was extended */
    function _isRrlExtendNoteVisible(gid) {
        var $note = $('#rrl-extend-note-' + gid);
        return $note.length > 0 && !$note.hasClass('d-none');
    }

    function _hideRrlExtendNote(gid) {
        gid = gid || _REALLOC_TAB_GID;
        $('#rrl-extend-note-' + gid).addClass('d-none');
    }

    function _resetRrlExtendRefreshGate(projectId) {
        _rrlExtendRefreshGate = {
            details: false,
            extended: false,
            projectId: parseInt(projectId, 10) || 0
        };
    }

    function _markRrlExtendRefreshGate(part) {
        if (part === 'details' || part === 'extended') {
            _rrlExtendRefreshGate[part] = true;
        }
        if (_rrlExtendRefreshGate.details && _rrlExtendRefreshGate.extended) {
            _scheduleRrlExtendNoteRefresh();
        }
    }

    function _scheduleRrlExtendNoteRefresh() {
        if (_rrlExtendNoteRefreshTimer) clearTimeout(_rrlExtendNoteRefreshTimer);
        _rrlExtendNoteRefreshTimer = setTimeout(function () {
            _rrlExtendNoteRefreshTimer = null;
            _updateRrlExtendNoteVisibility();
        }, 50);
    }

    function _fetchRrlResourcesNeedingEndExtensionCount(onDone) {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        var newEndDate = _getExtendProjectNewExpectedEndDate();
        if (!projectId || !newEndDate) {
            if (typeof onDone === 'function') onDone(0);
            return;
        }
        _fetchExtendProjectEndExtendedFromApi(projectId, 1, 1, 0, newEndDate,
            function (rows, pagination) {
                var total = pagination && (pagination.totalRecords != null ? pagination.totalRecords : pagination.TotalRecords);
                if (total == null) total = (rows || []).length;
                if (typeof onDone === 'function') onDone(parseInt(total, 10) || 0);
            },
            function () {
                if (typeof onDone === 'function') onDone(-1);
            },
            !_pageInitInProgress
        );
    }

    function _updateRrlExtendNoteVisibility() {
        var gid = _REALLOC_TAB_GID;
        var $note = $('#rrl-extend-note-' + gid);
        var projectEnd = _getExtendProjectNewExpectedEndDate();
        if (!$note.length) {
            if ((_isExtendedEndDate || _rrlProjectEndWasExtended) && projectEnd) {
                window._pendingExtendProjectModal = true;
            }
            return;
        }
        window._pendingExtendProjectModal = false;
        if (!projectEnd || (!_isExtendedEndDate && !_rrlProjectEndWasExtended)) {
            $note.addClass('d-none');
            if (typeof _rrlResizeBodyScroll === 'function') {
                setTimeout(function () { _rrlResizeBodyScroll(gid); }, 0);
            }
            return;
        }
        _fetchRrlResourcesNeedingEndExtensionCount(function (count) {
            if (count > 0) {
                $note.removeClass('d-none');
                _rrlProjectEndWasExtended = true;
                window._rrlProjectEndWasExtended = true;
            } else if (count === 0) {
                $note.addClass('d-none');
                if (_isExtendedEndDate || _rrlProjectEndWasExtended) {
                    var projectId = parseInt(SessionProjectID, 10) || 0;
                    _callUpdateProjectDateAuditApi(projectId, function () {
                        _rrlProjectEndWasExtended = false;
                        window._rrlProjectEndWasExtended = false;
                    });
                }
            } else if (_isExtendedEndDate || _rrlProjectEndWasExtended) {
                $note.removeClass('d-none');
            } else {
                $note.addClass('d-none');
            }
            if (typeof _rrlResizeBodyScroll === 'function') {
                setTimeout(function () { _rrlResizeBodyScroll(gid); }, 0);
            }
        });
    }

    function _rrlHasPendingInlineEdits(gid) {
        return !!_rrlPendingInlineEditsByGroup[gid];
    }

    function _markRrlInlineEditPending(gid) {
        if (gid) _rrlPendingInlineEditsByGroup[gid] = true;
    }

    function _clearRrlPendingInlineEdits(gid) {
        if (gid) delete _rrlPendingInlineEditsByGroup[gid];
    }

    function _rrlInlineEditChanged(orig, curStart, curEnd, curAlloc, curWork) {
        orig = orig || {};
        return (rrlDateToApi(curStart) !== rrlDateToApi(orig.startVal || ''))
            || (rrlDateToApi(curEnd) !== rrlDateToApi(orig.endVal || ''))
            || (_normRrlAllocValue(curAlloc) !== _normRrlAllocValue(orig.allocVal || ''))
            || ((curWork || '').trim() !== (orig.workVal || '').trim());
    }

    function _normRrlAllocValue(v) {
        var n = parseFloat(String(v || '').replace('%', '').trim());
        return isNaN(n) ? '' : String(n);
    }

    function _isRrlAllocationPeriodPassed(startStr, endStr) {
        var startApi = rrlDateToApi(startStr);
        var endApi = rrlDateToApi(endStr);
        if (!startApi || !endApi) return false;
        var today = new Date();
        today.setHours(0, 0, 0, 0);
        var start = new Date(startApi + 'T00:00:00');
        var end = new Date(endApi + 'T00:00:00');
        if (isNaN(start.getTime()) || isNaN(end.getTime())) return false;
        return today > start && today > end;
    }

    function _getRrlRowPersistedEditable($row) {
        return {
            start: ($row.attr('data-rrl-persisted-start') || '').toString().trim(),
            end: ($row.attr('data-rrl-persisted-end') || '').toString().trim(),
            alloc: ($row.attr('data-rrl-persisted-alloc') || '').toString().trim(),
            work: ($row.attr('data-rrl-persisted-work') || '').toString().trim()
        };
    }

    function _getRrlRowCurrentEditable($row) {
        var rowKey = ($row.attr('data-row-key') || '').toString();
        return {
            start: ($row.find('#rrl-start-' + rowKey).val() || '').toString().trim(),
            end: ($row.find('#rrl-end-' + rowKey).val() || '').toString().trim(),
            alloc: ($row.find('#rrl-alloc-' + rowKey).val() || '').toString().replace('%', '').trim(),
            work: ($row.find('#rrl-work-' + rowKey).val() || '').toString().trim()
        };
    }

    function _rrlPersistedEditableAttrs(start, end, alloc, work) {
        return ' data-rrl-persisted-start="' + escHtml(start) + '"' +
            ' data-rrl-persisted-end="' + escHtml(end) + '"' +
            ' data-rrl-persisted-alloc="' + escHtml(String(alloc)) + '"' +
            ' data-rrl-persisted-work="' + escHtml(work) + '"';
    }

    function _rrlUpdateRowPersistedEditableAttrs($row) {
        var cur = _getRrlRowCurrentEditable($row);
        $row.attr({
            'data-rrl-persisted-start': cur.start,
            'data-rrl-persisted-end': cur.end,
            'data-rrl-persisted-alloc': cur.alloc,
            'data-rrl-persisted-work': cur.work
        });
    }

    /* After API save — push input values into display spans so View Details offcanvas stays in sync */
    function _rrlCommitRowListViewDisplay($row, gid, options) {
        options = options || {};
        var exitEdit = options.exitEdit !== false;
        var rowKey = ($row.attr('data-row-key') || '').toString();
        if (!rowKey) return;

        var startVal = _fmtDisplayDate($('#rrl-start-' + rowKey).val());
        _rrlSetDisplayVal($row.find('#rrl-start-' + rowKey).closest('td').find('.rrl-display-val'), startVal, '—', true);

        var endVal = _fmtDisplayDate($('#rrl-end-' + rowKey).val());
        _rrlSetDisplayVal($row.find('#rrl-end-' + rowKey).closest('td').find('.rrl-display-val'), endVal, '—', true);

        var allocText = ($('#rrl-alloc-' + rowKey).val() || '').toString().replace('%', '').trim();
        _rrlSetDisplayVal($row.find('#rrl-alloc-' + rowKey).closest('td').find('.rrl-display-val'), allocText ? allocText + '%' : '', '—', true);

        var workVal = decimalToHHMM(($('#rrl-work-' + rowKey).val() || '').toString().trim());
        if (workVal) $('#rrl-work-' + rowKey).val(workVal);
        _rrlSetDisplayVal($row.find('#rrl-work-' + rowKey).closest('td').find('.rrl-display-val'), workVal, '—', true);

        _rrlUpdateRowPersistedEditableAttrs($row);
        _rrlSyncApiStateRowFromDom($row, gid);

        if (exitEdit && $row.hasClass('rrl-row-editing')) {
            var $btn = $row.find('.btn-rrl-edit').first();
            $row.removeClass('rrl-row-editing');
            var $table = $row.closest('table.rrl-table');
            if ($table.find('tbody tr.rrl-row-editing').length === 0) {
                $table.removeClass('rrl-editing-active');
            }
            $row.find('input.rrl-alloc-editable, input.rrl-work-editable')
                .removeClass('rrl-alloc-editable rrl-work-editable');
            $row.find('.rrl-date-wrap').removeClass('rrl-field-editable rrl-field-locked');
            if ($btn.length) {
                $btn.removeClass('editing');
                _setBsTooltip($btn[0], RES.C_EditDetails || 'Edit this row');
                $btn.html('<i class="fas fa-pencil-alt"></i>');
            }
            $row.removeData('rrl-orig-state');
        }

        if (gid) {
            setTimeout(function () {
                _rrlSyncScrollTop(gid);
                _rrlApplyTruncationTooltips(gid);
                if (typeof reinitTooltips === 'function') reinitTooltips();
            }, 0);
        }
    }

    function _rrlSyncApiStateRowFromDom($row, gid) {
        var perId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
        if (!perId) return;
        var apiRow = _lookupRrlApiRowByPerId(gid, perId);
        if (!apiRow) return;
        var cur = _getRrlRowCurrentEditable($row);
        var startIso = rrlDateToApi(cur.start);
        var endIso = rrlDateToApi(cur.end);
        if (startIso) {
            apiRow.expectedStartDate = startIso;
            apiRow.ExpectedStartDate = startIso;
        }
        if (endIso) {
            apiRow.expectedEndDate = endIso;
            apiRow.ExpectedEndDate = endIso;
        }
        var alloc = _parseIntegerAllocation(_normRrlAllocValue(cur.alloc));
        if (!isNaN(alloc)) {
            apiRow.resourcePercentage = alloc;
            apiRow.ResourcePercentage = alloc;
        }
        if (cur.work) {
            apiRow.budgetedHours = cur.work;
            apiRow.BudgetedHours = cur.work;
        }
    }

    function _rrlGetListViewFieldForOffcanvas($row, field) {
        var rowKey = ($row.attr('data-row-key') || '').toString();
        if (!rowKey) return '—';
        var inputId, colSel, formatter;
        if (field === 'start') {
            inputId = 'rrl-start'; colSel = '.rrl-col-start'; formatter = _fmtDisplayDate;
        } else if (field === 'end') {
            inputId = 'rrl-end'; colSel = '.rrl-col-end'; formatter = _fmtDisplayDate;
        } else if (field === 'alloc') {
            inputId = 'rrl-alloc'; colSel = '.rrl-col-alloc';
            formatter = function (v) {
                var t = (v || '').toString().replace('%', '').trim();
                return t ? t + '%' : '';
            };
        } else if (field === 'work') {
            inputId = 'rrl-work'; colSel = '.rrl-col-work';
            formatter = function (v) { return decimalToHHMM((v || '').toString().trim()); };
        } else {
            return '—';
        }
        var $inp = $row.find('#' + inputId + '-' + rowKey);
        var raw = ($inp.val() || '').toString().trim();
        if (raw && typeof formatter === 'function') {
            var formatted = formatter(raw);
            if (formatted) return formatted;
        }
        var disp = ($row.find(colSel + ' .rrl-display-val').first().text() || '').toString().trim();
        return disp || '—';
    }

    function _isRrlResourceActiveFromApiRow(r) {
        if (!r) return true;
        var v = r.isResourceActive != null ? r.isResourceActive : r.IsResourceActive;
        if (v === false || v === 0 || v === '0' || String(v).toLowerCase() === 'false') return false;
        return true;
    }

    function _isRrlResourceActiveFromRow($row) {
        if (!$row || !$row.length) return true;
        return ($row.attr('data-resource-active') || '1') !== '0';
    }

    function _rrlInactiveResourceEditMessage() {
        var msg = (RES.A_InactiveResourceCannotEdit || '').toString().trim();
        return msg || 'Inactive resource cannot be updated. Start date, end date, allocation %, and work hours cannot be changed.';
    }

    function _rrlBuildEditButtonHtml(rowKey, isResourceActive) {
        if (!editAccess) return '';
        if (!isResourceActive) {
            var tip = escHtml(_rrlInactiveResourceEditMessage());
            return '<span class="rrl-edit-tip-wrap d-inline-flex" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + tip + '">' +
                '<button type="button" class="btn-rrl-edit rrl-edit-disabled" disabled tabindex="-1"><i class="fas fa-pencil-alt"></i></button></span>';
        }
        return '<button type="button" class="btn-rrl-edit" id="btn-rrl-edit-' + rowKey + '" onclick="toggleRrlRowEdit(this, \'' + rowKey + '\')" data-bs-title="' + escHtml(RES.C_EditDetails) + '" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"><i class="fas fa-pencil-alt"></i></button>';
    }

    function _rrlEditableFieldsChanged(cur, persisted) {
        cur = cur || {};
        persisted = persisted || {};
        if (rrlDateToApi(cur.start) !== rrlDateToApi(persisted.start)) return true;
        if (rrlDateToApi(cur.end) !== rrlDateToApi(persisted.end)) return true;
        if (_normRrlAllocValue(cur.alloc) !== _normRrlAllocValue(persisted.alloc)) return true;
        if ((cur.work || '').trim() !== (persisted.work || '').trim()) return true;
        return false;
    }

    function _rrlRowHasEditableChanges($row) {
        var cur = _getRrlRowCurrentEditable($row);
        var persisted = _getRrlRowPersistedEditable($row);
        if ($row.hasClass('rrl-row-editing')) {
            var orig = $row.data('rrl-orig-state') || {};
            if (_rrlInlineEditChanged(orig, cur.start, cur.end, cur.alloc, cur.work)) return true;
        }
        return _rrlEditableFieldsChanged(cur, persisted);
    }

    function _getRrlRowKey($row) {
        return ($row.attr('data-row-key') || '').toString();
    }

    function _getRrlRowCurrentOffcanvasFields($row) {
        var rowKey = _getRrlRowKey($row);
        if (!rowKey) {
            return {
                reportingTo: 0, reportingToText: '', resourceStatus: '', resourceStatusText: '',
                responsibility: '', isResourceBillable: false, isDefaultApprover: false, isProductOwner: false
            };
        }
        var $rpt = $row.find('#rrl-rpt-' + rowKey);
        var $status = $row.find('#rrl-status-' + rowKey);
        var $resp = $row.find('#rrl-resp-' + rowKey);
        var $bill = $row.find('#rrl-bill-' + rowKey);
        var $approver = $row.find('#rrl-approver-' + rowKey);
        var $po = $row.find('#rrl-po-' + rowKey);
        var isBillable = false;
        var isApprover = false;
        var isProductOwner = false;
        if ($bill.length) {
            isBillable = $bill.prop('checked') === true;
        } else {
            isBillable = ($row.attr('data-billable') || $row.attr('data-rrl-persisted-billable')) === '1'
                || $row.find('.rrl-col-bill .fa-check-circle').length > 0;
        }
        if ($approver.length) {
            isApprover = $approver.prop('checked') === true;
        } else {
            isApprover = ($row.attr('data-default-approver') || $row.attr('data-rrl-persisted-approver')) === '1'
                || $row.find('.rrl-col-approver .fa-check-circle').length > 0;
        }
        if ($po.length) {
            isProductOwner = $po.prop('checked') === true;
        } else {
            isProductOwner = ($row.attr('data-product-owner') || $row.attr('data-rrl-persisted-product-owner')) === '1'
                || $row.find('.rrl-col-product-owner .fa-check-circle').length > 0;
        }
        return {
            reportingTo: parseInt($rpt.val(), 10) || 0,
            reportingToText: ($rpt.find('option:selected').text() || '').toString().trim(),
            resourceStatus: ($status.val() || '').toString().trim(),
            resourceStatusText: ($status.find('option:selected').text() || '').toString().trim(),
            responsibility: _cleanRrlText($resp.val() || ''),
            isResourceBillable: isBillable,
            isDefaultApprover: isApprover,
            isProductOwner: isProductOwner
        };
    }

    function _rrlOcSelectVal($sel) {
        if (!$sel || !$sel.length) return '';
        try {
            if ($sel.data('selectpicker')) {
                var picked = $sel.selectpicker('val');
                if (picked != null && picked !== '') return String(picked);
            }
        } catch (e) { /* ignore */ }
        return ($sel.val() || '').toString();
    }

    function _getRrlRowPersistedOffcanvasFields($row) {
        return {
            reportingTo: parseInt($row.attr('data-rrl-persisted-reporting-to') || $row.attr('data-reporting-to'), 10) || 0,
            resourceStatus: ($row.attr('data-rrl-persisted-status') || $row.attr('data-resource-status') || '').toString().trim(),
            responsibility: _cleanRrlText($row.attr('data-rrl-persisted-resp') || ''),
            isResourceBillable: ($row.attr('data-rrl-persisted-billable') || $row.attr('data-billable')) === '1',
            isDefaultApprover: ($row.attr('data-rrl-persisted-approver') || $row.attr('data-default-approver')) === '1'
        };
    }

    function _rrlOffcanvasFieldsChanged($row) {
        if (!$row.find('.rrl-offcanvas-only').length) return false;
        var cur = _getRrlRowCurrentOffcanvasFields($row);
        var persisted = _getRrlRowPersistedOffcanvasFields($row);
        if (cur.reportingTo !== persisted.reportingTo) return true;
        if (cur.resourceStatus !== persisted.resourceStatus) return true;
        if (cur.responsibility !== persisted.responsibility) return true;
        if (cur.isResourceBillable !== persisted.isResourceBillable) return true;
        if (cur.isDefaultApprover !== persisted.isDefaultApprover) return true;
        return false;
    }

    function _rrlRowHasAnyPendingChanges($row) {
        if (_rrlRowHasEditableChanges($row)) return true;
        return _rrlOffcanvasFieldsChanged($row);
    }

    function _rrlSyncPendingEditsFromDom(gid) {
        var hasChanges = false;
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $row = $(this);
            if (!_isRrlResourceActiveFromRow($row)) return;
            if ($row.hasClass('rrl-row-editing') && _rrlRowHasAnyPendingChanges($row)) {
                hasChanges = true;
                return;
            }
            if (!$row.find('.rrl-row-check').prop('checked')) return;
            if (_rrlRowHasAnyPendingChanges($row)) hasChanges = true;
        });
        if (hasChanges) _markRrlInlineEditPending(gid);
        return hasChanges;
    }

    function _rrlHasResourceDetailChanges(gid) {
        if (_rrlHasPendingInlineEdits(gid)) return true;
        var found = false;
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $row = $(this);
            if (!_isRrlResourceActiveFromRow($row)) return;
            if ($row.hasClass('rrl-row-editing') && _rrlRowHasAnyPendingChanges($row)) {
                found = true;
                return false;
            }
            if (!$row.find('.rrl-row-check').prop('checked')) return;
            if (_rrlRowHasAnyPendingChanges($row)) {
                found = true;
                return false;
            }
        });
        return found;
    }

    function _rrlResourceUpdatedSuccessMessage() {
        var msg = (RES.A_ResourceUpdatedSuccessfully || '').toString().trim();
        return msg || 'Resource Updated Successfully';
    }

    function _isRrlSaveSuccessApiMessage(msg) {
        var lower = (msg || '').toString().trim().toLowerCase();
        if (!lower) return false;
        var phrases = [
            (RES.A_ResourceUpdatedSuccessfully || '').toString().trim().toLowerCase(),
            (RES.A_BulkResourceUpdatedSuccessfully || '').toString().trim().toLowerCase(),
            'resource updated successfully',
            'bulk resource updated successfully'
        ];
        for (var i = 0; i < phrases.length; i++) {
            if (phrases[i] && lower.indexOf(phrases[i]) >= 0) return true;
        }
        return lower.indexOf('updated successfully') >= 0;
    }

    function _isRrlSaveApiFailure(result, updatedRows) {
        if (updatedRows == null) return false;
        if (parseInt(updatedRows, 10) !== 0) return false;
        var apiMessage = (result && (result.message || result.Message)) || '';
        return !_isRrlSaveSuccessApiMessage(apiMessage);
    }

    function _rrlClearSaveFocusState(gid, fromWhere) {
        clearRrlOcValidation();
        clearRrlValidation(gid);
        try {
            if (document.activeElement && document.activeElement.blur) document.activeElement.blur();
        } catch (e) { /* ignore */ }
    }

    function _fetchExtendProjectEndExtendedFromApi(projectId, pageNumber, pageSize, roleId, newExpectedEndDate, onSuccess, onError, useLoader) {
        
        var body = JSON.stringify({
            projectID: parseInt(projectId, 10),
            roleID: parseInt(roleId, 10) || 0,
            newExpectedEndDate: newExpectedEndDate,
            pageNumber: parseInt(pageNumber, 10) || 1,
            pageSize: parseInt(pageSize, 5) || _extendProjectPageSize
        });

        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetProjectEmployeeEndExtended',
            body, true,
            function (response) {
                var payload = _extractRrlApiPayload(response);
                if (typeof onSuccess === 'function') onSuccess(payload.rows || [], payload.pagination);
            },
            function (xhr) {
                console.warn('GetProjectEmployeeEndExtended failed:', xhr.status);
                if (typeof onError === 'function') onError();
            },
            null,
            useLoader
        );
    }

    function _escapeExtendHtml(val) {
        if (val == null) return '';
        return String(val)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

    function _mapExtendProjectApiRow(row) {
        if (!row) {
            return {
                projectEmployeeRoleID: 0, employeeID: 0, roleID: 0, resource: '', role: '',
                plannedEndDate: '', newExpectedEndDate: '', expectedStartDate: '', allocation: '',
                reportingTo: 0, resourceStatus: '', billable: false, isDefaultApprover: false,
                budgetedHours: null, responsibility: ''
            };
        }
        return {
            projectEmployeeRoleID: row.projectEmployeeRoleID || row.ProjectEmployeeRoleID || 0,
            employeeID: row.employeeID || row.EmployeeID || 0,
            roleID: row.roleID || row.RoleID || 0,
            resource: row.employeeName || row.EmployeeName || '',
            role: row.roleDescription || row.RoleDescription || '',
            plannedEndDate: row.expectedEndDate || row.ExpectedEndDate || '',
            newExpectedEndDate: row.newExpectedEndDate || row.NewExpectedEndDate || '',
            expectedStartDate: row.expectedStartDate || row.ExpectedStartDate || '',
            allocation: row.resourcePercentage != null ? row.resourcePercentage : (row.ResourcePercentage != null ? row.ResourcePercentage : ''),
            reportingTo: _resolveReportingToFromApiRow(row),
            resourceStatus: row.resourceStatus || row.ResourceStatus || '',
            billable: row.billable !== undefined ? row.billable : (row.Billable !== undefined ? row.Billable : false),
            isDefaultApprover: row.isDefaultApprover !== undefined ? row.isDefaultApprover : (row.IsDefaultApprover !== undefined ? row.IsDefaultApprover : false),
            budgetedHours: row.budgetedHours != null ? row.budgetedHours : row.BudgetedHours,
            responsibility: row.responsibility || row.Responsibility || ''
        };
    }

    function _cloneExtendSelection(r) {
        return {
            projectEmployeeRoleID: r.projectEmployeeRoleID,
            employeeID: r.employeeID || 0,
            roleID: r.roleID || 0,
            employeeName: r.resource || '',
            roleDescription: r.role || '',
            expectedStartDate: r.expectedStartDate || '',
            expectedEndDate: r.plannedEndDate || '',
            newExpectedEndDate: r.newExpectedEndDate || '',
            resourcePercentage: r.allocation != null ? r.allocation : '',
            reportingTo: r.reportingTo || 0,
            resourceStatus: r.resourceStatus || '',
            billable: !!r.billable,
            isDefaultApprover: !!r.isDefaultApprover,
            budgetedHours: r.budgetedHours,
            responsibility: r.responsibility || ''
        };
    }

    function _cacheExtendProjectRows(mappedRows) {
        for (var i = 0; i < (mappedRows || []).length; i++) {
            var r = mappedRows[i];
            if (r && r.projectEmployeeRoleID) {
                _extendProjectRowCacheById[r.projectEmployeeRoleID] = r;
            }
        }
    }

    function _addExtendProjectSelectionFromRow(r) {
        if (!r || !r.projectEmployeeRoleID) return;
        _extendProjectSelectedById[r.projectEmployeeRoleID] = _cloneExtendSelection(r);
    }

    function _syncExtendProjectRowSelection(checkbox) {
        var id = parseInt($(checkbox).data('per-id'), 10);
        if (!id) return;
        if (checkbox.checked) {
            var cached = _extendProjectRowCacheById[id];
            if (cached) {
                _extendProjectSelectedById[id] = _cloneExtendSelection(cached);
            }
        } else {
            delete _extendProjectSelectedById[id];
        }
    }

    function onExtendProjectRowCheck(checkbox) {
        if (_extendProjectSelectAllActive && !checkbox.checked) {
            _extendProjectSelectAllActive = false;
        }
        _syncExtendProjectRowSelection(checkbox);
        updateExtendProjectSelectAllState();
    }

    function _extendProjectSelectAllResources(selectAll) {
        if (!selectAll) {
            _extendProjectSelectAllActive = false;
            _extendProjectSelectedById = {};
            $('#extendProjectResourceTbody .extend-project-row-check').prop('checked', false);
            updateExtendProjectSelectAllState();
            return;
        }

        var projectId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID, 10) : 0;
        var totalRecords = _extendProjectState.totalRecords || 0;
        if (!projectId || totalRecords <= 0) {
            $('#extendProjectCheckAll').prop('checked', false);
            return;
        }

        _extendProjectSelectAllActive = true;
        var $master = $('#extendProjectCheckAll');
        $master.prop('disabled', true);

        var newEndDate = _getExtendProjectNewExpectedEndDate();
        if (!newEndDate) {
            $master.prop('checked', false);
            alert(RES.A_ProjEndNotA);
            return;
        }

        _fetchExtendProjectEndExtendedFromApi(projectId, 1, totalRecords, 0, newEndDate,
            function (rows) {
                _extendProjectSelectedById = {};
                for (var i = 0; i < (rows || []).length; i++) {
                    _addExtendProjectSelectionFromRow(_mapExtendProjectApiRow(rows[i]));
                }
                $master.prop('disabled', false).prop('checked', true).prop('indeterminate', false);
                $('#extendProjectResourceTbody .extend-project-row-check').prop('checked', true);
            },
            function () {
                _extendProjectSelectAllActive = false;
                _extendProjectSelectedById = {};
                $master.prop('disabled', false).prop('checked', false).prop('indeterminate', false);
                $('#extendProjectResourceTbody .extend-project-row-check').prop('checked', false);
            }
        );
    }

    function toggleExtendProjectSelectAll(masterCb) {
        if (masterCb.checked) {
            _extendProjectSelectAllResources(true);
        } else {
            _extendProjectSelectAllResources(false);
        }
    }

    function updateExtendProjectSelectAllState() {
        var $master = $('#extendProjectCheckAll');
        var totalRecords = _extendProjectState.totalRecords || 0;
        var selectedCount = 0;
        for (var key in _extendProjectSelectedById) {
            if (_extendProjectSelectedById.hasOwnProperty(key)) selectedCount++;
        }

        if (_extendProjectSelectAllActive || (totalRecords > 0 && selectedCount >= totalRecords)) {
            $master.prop('checked', totalRecords > 0 && selectedCount >= totalRecords);
            $master.prop('indeterminate', false);
            return;
        }

        var $rows = $('#extendProjectResourceTbody .extend-project-row-check');
        var total = $rows.length;
        var checked = $rows.filter(':checked').length;
        $master.prop('checked', total > 0 && checked === total);
        $master.prop('indeterminate', false);
    }

    function getSelectedExtendProjectResources() {
        var list = [];
        for (var key in _extendProjectSelectedById) {
            if (_extendProjectSelectedById.hasOwnProperty(key)) {
                list.push(_extendProjectSelectedById[key]);
            }
        }
        return list;
    }

    /* Added By Dipali V On 26th May - Refresh single Reallocation tab grid after extend save */
    function _markReallocationDirty() {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (projectId) delete _rrlCacheByProject[projectId];
        _reallocationTabLoaded = false;
    }

    function _refreshAllRrlGroupsAfterExtendSave() {
        _markReallocationDirty();
    }

    function _rrlCancelInlineRowEdit($row, rowKey, gid) {
        if (!$row || !$row.length || !rowKey) return;
        var persisted = _getRrlRowPersistedEditable($row);
        if (persisted.start) $('#rrl-start-' + rowKey).val(persisted.start);
        if (persisted.end) $('#rrl-end-' + rowKey).val(persisted.end);
        if (persisted.alloc) $('#rrl-alloc-' + rowKey).val(persisted.alloc);
        if (persisted.work) $('#rrl-work-' + rowKey).val(persisted.work);
        $row.find('.oc-val-error').removeClass('oc-val-error');
        $row.find('.rrl-date-wrap.oc-val-error').removeClass('oc-val-error');
        _rrlCommitRowListViewDisplay($row, gid, { exitEdit: true });
        $row.removeData('rrl-orig-state');
    }

    function _rrlRevertAndExitUnselectedEditingRows(gid) {
        $('#rrl-tbody-' + gid + ' tr.rrl-row-editing').each(function () {
            var $row = $(this);
            if ($row.find('.rrl-row-check').prop('checked')) return;
            var rowKey = ($row.attr('data-row-key') || '').toString();
            if (!rowKey) return;
            var persisted = _getRrlRowPersistedEditable($row);
            if (persisted.start) $('#rrl-start-' + rowKey).val(persisted.start);
            if (persisted.end) $('#rrl-end-' + rowKey).val(persisted.end);
            if (persisted.alloc) $('#rrl-alloc-' + rowKey).val(persisted.alloc);
            if (persisted.work) $('#rrl-work-' + rowKey).val(persisted.work);
            _rrlCommitRowListViewDisplay($row, gid, { exitEdit: true });
        });
    }

    function _rrlRefreshGridAfterSaveSuccess(gid) {
        _clearRrlPendingInlineEdits(gid);
        _markReallocationDirty();
        loadReallocationTabAllocatedResources(true);
        _updateRrlExtendNoteVisibility();
    }

    // Added by Vyankat B. on 18-May-2026 — usp_Whizible2_UPD_tbl_PM_Project_DateAudit (sets IsExtendedEndDate = 0).
    function _callUpdateProjectDateAuditApi(projectId, onDone) {
        
        if (!projectId || projectId <= 0) {
            if (typeof onDone === 'function') onDone(false);
            return;
        }
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/UpdateProjectDateAudit',
            JSON.stringify({ ProjectID: projectId }), true,
            function (response) {
                var result = response && response.data ? response.data : response;
                var updatedRows = result && (result.updatedRows != null ? result.updatedRows : result.UpdatedRows);
                var msg = (result && (result.message || result.Message)) || RES.A_IsExtendedEndDateUpdated;
                _isExtendedEndDate = false;
                window._isExtendedEndDate = false;
                if (updatedRows != null && parseInt(updatedRows, 10) > 0) {
                //    alertify.success(msg);
                }
                if (typeof onDone === 'function') onDone(true);
            },
            function () {
                if (typeof onDone === 'function') onDone(false);
            },
            null,
            !_pageInitInProgress
        );
    }

    function saveExtendProjectResourceEndDates(selectedOverride, $btnOverride, options) {
        options = options || {};
        if (!editAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionExtend);
            return;
        }

        var selected = selectedOverride || getSelectedExtendProjectResources();
        if (!selected.length) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelRes);
            return;
        }

        var newEndApi = '';
        var newEndIso = _getExtendProjectNewExpectedEndDate();
        if (newEndIso) {
            newEndApi = newEndIso + 'T00:00:00';
        }

        var projectEmployeeRoles = [];
        var projectId = parseInt(SessionProjectID, 10) || 0;

        for (var i = 0; i < selected.length; i++) {
            var s = selected[i];
            var startApi = rrlDateToApi(s.expectedStartDate);
            var endApi = rrlDateToApi(s.newExpectedEndDate) || newEndApi || rrlDateToApi(_projectEndRaw);

            if (!s.projectEmployeeRoleID || !s.employeeID) {
                alertify.set('notifier', 'position', 'top-right');       
                alertify.error(RES.C_ResDataIncom);
                return;
            }
            if (!startApi) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.C_PlannedStartDateM + ' ' + (s.employeeName || RES.A_SelReso) + '.');
                return;
            }
            if (!endApi) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_NewPlannEndMis + ' ' + (s.employeeName || RES.A_SelReso) + '.');
                return;
            }

            projectEmployeeRoles.push({
                projectID: projectId,
                projectEmployeeRoleId: s.projectEmployeeRoleID,
                rate: 0,
                cost: 0,
                employeeID: s.employeeID,
                role: s.roleID || 0,
                resourcePercentage: parseFloat(s.resourcePercentage) || 0,
                expectedStartDate: startApi,
                expectedEndDate: endApi,
                //resourceStatus: s.resourceStatus || '',
                //isResourceBillable: !!s.billable,
                //responsibility: s.responsibility || '',
                //reportingTo: parseInt(s.reportingTo, 10) || 0,
                //isDefaultApprover: !!s.isDefaultApprover,
                budgetedHours: s.budgetedHours != null ? String(s.budgetedHours) : null,
                intIsProductOwner: (function () {
                    var $row = $('tr[data-project-employee-role-id="' + s.projectEmployeeRoleID + '"]').first();
                    return $row.length ? _rrlIsProductOwnerFromRow($row) : false;
                })()
            });
        }

        var $btn = $btnOverride && $btnOverride.length ? $btnOverride : $('#btnExtendProjectYes');
        var oldHtml = $btn.html();
        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Saving...');

        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/SaveProjectEmployeeRole',
            JSON.stringify({
                userName: SessionUserName || UserName || FromuserName || '',
                projectEmployeeRoles: projectEmployeeRoles
            }),
            true,
            function (response) {
                var result = response && response.data ? response.data : response;
                var apiMessage = (result && (result.message || result.Message)) || '';
                var updatedRows = result && (result.updatedRows != null ? result.updatedRows : result.UpdatedRows);
                alertify.set('notifier', 'position', 'top-right');
                if (updatedRows != null && parseInt(updatedRows, 10) === 0) {
                    alertify.error(apiMessage || RES.A_FailedToExtendResourceEndDate);
                    $btn.prop('disabled', false).html(oldHtml);
                    return;
                }
                alertify.success(RES.A_ResourceExtendedSuccess);
                _userWantsExtendResourceEndDate = true;
                window._userWantsExtendResourceEndDate = true;
                window._selectedExtendProjectResources = selected;
                _rrlProjectEndWasExtended = true;
                window._rrlProjectEndWasExtended = true;
                if (options.hideModal !== false) hideExtendProjectEndDateModal();
                _refreshAllRrlGroupsAfterExtendSave();
                if (options.fromRrlGrid) {
                    _clearRrlPendingInlineEdits(_REALLOC_TAB_GID);
                    _rrlSelectedByGroup[_REALLOC_TAB_GID] = {};
                    _rrlSelectAllActiveByGroup[_REALLOC_TAB_GID] = false;
                    _reallocationTabLoaded = false;
                    loadReallocationTabAllocatedResources(true);
                }
                $btn.prop('disabled', false).html(oldHtml);
                _updateRrlExtendNoteVisibility();
            },
            function (xhr) {
                var msg = RES.A_FailedToExtendResourceEndDate;
                try {
                    var err = JSON.parse(xhr.responseText);
                    if (err && (err.message || err.Message || err.title)) msg = err.message || err.Message || err.title;
                } catch (e) { /* ignore */ }
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(msg);
                $btn.prop('disabled', false).html(oldHtml);
            }
        );
    }

    /* Yes on extend modal: save selected resources, then UpdateProjectDateAudit */
    function handleExtendProjectYesClick() {
        saveExtendProjectResourceEndDates(null, null, { hideModal: true, fromRrlGrid: false });
    }

    /* Added By Dipali V On 5th Jun 2026 — build extend selection from Reallocation grid checkboxes */
    function _getSelectedExtendResourcesFromRrlGrid(gid, onDone) {
        _rrlSyncPageSelectionFromDom(gid);
        if (!_rrlSelectedByGroup[gid]) _rrlSelectedByGroup[gid] = {};
        /* Ensure visible checked rows are tracked (cross-page map may lag on first Save click) */
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $tr = $(this);
            if (!$(this).find('.rrl-row-check').prop('checked')) return;
            if (!_isRrlResourceActiveFromRow($tr)) return;
            var perId = parseInt($tr.attr('data-project-employee-role-id'), 10) || 0;
            if (perId) _rrlSelectedByGroup[gid][perId] = true;
        });

        var selectedMap = _rrlSelectedByGroup[gid] || {};
        var selectAll = !!_rrlSelectAllActiveByGroup[gid];
        var selectedCount = _rrlGetSelectedCount(gid);
        if (!selectAll && selectedCount === 0) {
            if (typeof onDone === 'function') onDone([]);
            return;
        }

        var projectId = parseInt(SessionProjectID, 10) || 0;
        var newEndDate = _getExtendProjectNewExpectedEndDate();
        if (!projectId || !newEndDate) {
            if (typeof onDone === 'function') onDone([]);
            return;
        }
        var newEndDisplay = _fmtDisplayDate(newEndDate) || (typeof isoLikeToDisplay === 'function' ? isoLikeToDisplay(_projectEndRaw) : '') || '';

        function _isSelected(perId) {
            return selectAll || !!selectedMap[perId];
        }

        function _mergeExtendMappedWithGridPersisted(mapped, perId) {
            mapped = mapped || {};
            var $row = $('#rrl-tbody-' + gid + ' tr[data-project-employee-role-id="' + perId + '"]');
            if (!$row.length) return mapped;
            var persisted = _getRrlPersistedReadOnlyFields($row, gid);
            if (persisted.roleId) mapped.roleID = persisted.roleId;
            if (persisted.reportingTo) mapped.reportingTo = persisted.reportingTo;
            if (persisted.resourceStatus) mapped.resourceStatus = persisted.resourceStatus;
            if (persisted.responsibility) mapped.responsibility = persisted.responsibility;
            mapped.billable = !!persisted.isResourceBillable;
            mapped.isDefaultApprover = !!persisted.isDefaultApprover;
            return mapped;
        }

        function _buildListFromRrlRows(rrlRows, extendByPerId) {
            extendByPerId = extendByPerId || {};
            var list = [];
                for (var i = 0; i < (rrlRows || []).length; i++) {
                if (!_isRrlResourceActiveFromApiRow(rrlRows[i])) continue;
                var perId = parseInt(rrlRows[i].projectEmployeeRoleID || rrlRows[i].ProjectEmployeeRoleID
                    || rrlRows[i].projectEmployeeRoleId || rrlRows[i].ProjectEmployeeRoleId || 0, 10) || 0;
                if (!_isSelected(perId)) continue;
                var roleMapped = _mapExtendProjectApiRow(rrlRows[i]);
                var mapped = extendByPerId[perId] || roleMapped;
                if (!mapped.reportingTo) mapped.reportingTo = roleMapped.reportingTo || _resolveReportingToFromApiRow(rrlRows[i]);
                if (!mapped.roleID) mapped.roleID = roleMapped.roleID;
                if (!mapped.resourceStatus) mapped.resourceStatus = roleMapped.resourceStatus;
                if (!mapped.responsibility) mapped.responsibility = roleMapped.responsibility;
                mapped = _mergeExtendMappedWithGridPersisted(mapped, perId);
                if (!mapped.newExpectedEndDate) mapped.newExpectedEndDate = newEndDisplay;
                list.push(_cloneExtendSelection(mapped));
            }
            return list;
        }

        var state = _rrlState[gid] || {};
        var fetchSize = Math.max(parseInt(state.totalRecords, 10) || 0, selectedCount, 500);

        /* Added By Dipali V On 16th Jun 2026 — load every grid page; single API call with large pageSize can miss page-2+ selections */
        _fetchAllRrlRowsForGroup(gid,
            function (rrlRows) {
                _fetchExtendProjectEndExtendedFromApi(projectId, 1, fetchSize, 0, newEndDate,
                    function (extendRows) {
                        var extendByPerId = {};
                        for (var j = 0; j < (extendRows || []).length; j++) {
                            var em = _mapExtendProjectApiRow(extendRows[j]);
                            if (em.projectEmployeeRoleID) extendByPerId[em.projectEmployeeRoleID] = em;
                        }
                        if (typeof onDone === 'function') onDone(_buildListFromRrlRows(rrlRows, extendByPerId));
                    },
                    function () {
                        if (typeof onDone === 'function') onDone(_buildListFromRrlRows(rrlRows, {}));
                    }
                );
            },
            function () {
                if (typeof onDone === 'function') onDone([]);
            }
        );
    }

    function saveExtendProjectResourceEndDatesFromRrlGrid(gid) {
        var $btn = $('#btn-rrl-save-' + gid);
        var oldHtml = $btn.length ? $btn.html() : '';
        if ($btn.length) {
            $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i><span>' + escHtml(RES.C_LoadingEllipsis || 'Loading...') + '</span>');
        }
        _getSelectedExtendResourcesFromRrlGrid(gid, function (selected) {
            if ($btn.length) {
                $btn.prop('disabled', false).html(oldHtml);
            }
            if (!selected.length) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_PleaseSelectAtLeastOneAllocatedResource || RES.A_SelRes);
                return;
            }
            saveExtendProjectResourceEndDates(selected, $btn, { hideModal: false, fromRrlGrid: true });
        });
    }

    function _extendProjectShowLoading(show) {
        var $tbody = $('#extendProjectResourceTbody');
        if (show) {
            $tbody.html('<tr class="extend-loading"><td colspan="5"><i class="fas fa-spinner fa-spin"></i> Loading resources...</td></tr>');
        }
    }

    function _updateExtendProjectPaginationUi() {
        var totalRecords = _extendProjectState.totalRecords || 0;
        var page = _extendProjectState.page || 1;
        var totalPages = _extendProjectState.totalPages || 0;
        var loading = !!_extendProjectState.loading;
        $('#extendProjectTotalText').text('Total Records: ' + totalRecords);
        $('#extendProjectPrev').prop('disabled', loading || page <= 1 || totalPages === 0);
        $('#extendProjectNext').prop('disabled', loading || page >= totalPages || totalPages === 0);
    }

    function _renderExtendProjectResourceTable(resources) {
        var $tbody = $('#extendProjectResourceTbody');
        $tbody.empty();
        if (!resources || !resources.length) {
            $tbody.html('<tr><td colspan="5" style="text-align:center;color:#6b7280;padding:16px;">No resources found</td></tr>');
            $('#extendProjectCheckAll').prop('checked', false).prop('indeterminate', false);
            return;
        }
        var html = '';
        for (var i = 0; i < resources.length; i++) {
            var r = resources[i];
            var perId = r.projectEmployeeRoleID || 0;
            var isChecked = !!_extendProjectSelectedById[perId] || _extendProjectSelectAllActive;
            html += '<tr>'
                + '<td>' + _escapeExtendHtml(r.resource) + '</td>'
                + '<td>' + _escapeExtendHtml(r.role) + '</td>'
                + '<td>' + _escapeExtendHtml(_fmtDisplayDate(r.plannedEndDate)) + '</td>'
                + '<td>' + _escapeExtendHtml(r.allocation) + '</td>'
                + '<td class="extend-project-check-col">'
                + '<input type="checkbox" class="extend-project-row-check"'
                + ' data-per-id="' + _escapeExtendHtml(perId) + '"'
                + ' data-employee-id="' + _escapeExtendHtml(r.employeeID) + '"'
                + ' data-resource="' + _escapeExtendHtml(r.resource) + '"'
                + ' data-role="' + _escapeExtendHtml(r.role) + '"'
                + ' data-planned-end="' + _escapeExtendHtml(r.plannedEndDate) + '"'
                + ' data-allocation="' + _escapeExtendHtml(r.allocation) + '"'
                + (isChecked ? ' checked' : '')
                + ' onchange="onExtendProjectRowCheck(this)" title="Select resource">'
                + '</td>'
                + '</tr>';
        }
        $tbody.html(html);
        updateExtendProjectSelectAllState();
    }

    function _renderExtendProjectResourceTableFromApi(rows) {
        var mapped = [];
        for (var i = 0; i < (rows || []).length; i++) {
            mapped.push(_mapExtendProjectApiRow(rows[i]));
        }
        _cacheExtendProjectRows(mapped);
        _renderExtendProjectResourceTable(mapped);
    }

    function _loadExtendProjectResourcePage(pageNumber) {
        var projectId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID, 10) : 0;
        if (!projectId || projectId <= 0) {
            _extendProjectState.page = 1;
            _extendProjectState.totalRecords = 0;
            _extendProjectState.totalPages = 0;
            _renderExtendProjectResourceTable([]);
            _updateExtendProjectPaginationUi();
            return;
        }

        var newEndDate = _getExtendProjectNewExpectedEndDate();
        if (!newEndDate) {
            _extendProjectState.loading = false;
            _renderExtendProjectResourceTable([]);
            _updateExtendProjectPaginationUi();
            alert(RES.A_ProjEndNotA);
            return;
        }

        var pageSize = _extendProjectState.size || _extendProjectPageSize;
        _extendProjectState.loading = true;
        _extendProjectShowLoading(true);
        _updateExtendProjectPaginationUi();

        _fetchExtendProjectEndExtendedFromApi(projectId, pageNumber, pageSize, 0, newEndDate,
            function (rows, pagination) {
                _extendProjectState.loading = false;
                var norm = pagination || {};
                var currentPage = norm.currentPage || parseInt(pageNumber, 10) || 1;
                var normPageSize = norm.pageSize || pageSize;
                var totalRecords = norm.totalRecords != null ? norm.totalRecords : ((rows && rows.length) ? rows.length : 0);
                var totalPages = norm.totalPages != null ? norm.totalPages : Math.max(1, Math.ceil(totalRecords / normPageSize));

                _extendProjectState.page = currentPage;
                _extendProjectState.size = normPageSize;
                _extendProjectState.totalRecords = totalRecords;
                _extendProjectState.totalPages = totalPages;

                _renderExtendProjectResourceTableFromApi(rows || []);
                _updateExtendProjectPaginationUi();
            },
            function () {
                _extendProjectState.loading = false;
                _extendProjectState.page = 1;
                _extendProjectState.totalRecords = 0;
                _extendProjectState.totalPages = 0;
                _renderExtendProjectResourceTable([]);
                _updateExtendProjectPaginationUi();
            }
        );
    }

    function extendProjectPrevPage() {
        if (_extendProjectState.loading || _extendProjectState.page <= 1) return;
        _loadExtendProjectResourcePage(_extendProjectState.page - 1);
    }

    function extendProjectNextPage() {
        if (_extendProjectState.loading) return;
        var totalPages = _extendProjectState.totalPages || 0;
        if (_extendProjectState.page >= totalPages) return;
        _loadExtendProjectResourcePage(_extendProjectState.page + 1);
    }

    function showExtendProjectEndDateModal() {
        if (_extendProjectModalShown) return;
        _extendProjectModalShown = true;
        var pageSize = (typeof _rrlApiPageSize !== 'undefined' && _rrlApiPageSize > 0) ? _rrlApiPageSize : _extendProjectPageSize;
        _extendProjectState = { page: 1, size: pageSize, totalRecords: 0, totalPages: 0, loading: false };
        _extendProjectSelectedById = {};
        _extendProjectRowCacheById = {};
        _extendProjectSelectAllActive = false;
        $('#extendProjectCheckAll').prop('checked', false).prop('indeterminate', false).prop('disabled', false);

        var el = document.getElementById('extendProjectEndDateModal');
        if (el && typeof bootstrap !== 'undefined') {
            bootstrap.Modal.getOrCreateInstance(el).show();
        }
        _loadExtendProjectResourcePage(1);
    }

    function hideExtendProjectEndDateModal() {
        var el = document.getElementById('extendProjectEndDateModal');
        if (el && typeof bootstrap !== 'undefined') {
            var inst = bootstrap.Modal.getInstance(el);
            if (inst) inst.hide();
        }
    }

    // Added by Vyankat B. on 12-May-2026 - Fetch IsExtendedEndDate flag from project date audit.
    function checkIsExtended() {
        var projectId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID, 10) : 0;
        if (!projectId || projectId <= 0) {
            _isExtendedEndDate = false;
            _markRrlExtendRefreshGate('extended');
            return;
        }

        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetIsExtendProject',
            JSON.stringify({ ProjectID: projectId }), true,
            function (response) {
                var root = response || {};
                var isExtended = root.isExtendedEndDate !== undefined ? root.isExtendedEndDate : root.IsExtendedEndDate;
                var rows = root.data || root.Data;

                if (isExtended === undefined && $.isArray(rows) && rows.length > 0) {
                    isExtended = rows[0].isExtendedEndDate !== undefined ? rows[0].isExtendedEndDate : rows[0].IsExtendedEndDate;
                }
                if (isExtended === undefined && $.isArray(root) && root.length > 0) {
                    isExtended = root[0].isExtendedEndDate !== undefined ? root[0].isExtendedEndDate : root[0].IsExtendedEndDate;
                }

                _isExtendedEndDate = (isExtended === true || isExtended === 1 || isExtended === '1' || String(isExtended).toLowerCase() === 'true');
                window._isExtendedEndDate = _isExtendedEndDate;

                if (_isExtendedEndDate) {
                    _rrlProjectEndWasExtended = true;
                    window._rrlProjectEndWasExtended = true;
                } else if (!_rrlProjectEndWasExtended) {
                    _hideRrlExtendNote(_REALLOC_TAB_GID);
                }
                _markRrlExtendRefreshGate('extended');
            },
            function (xhr) {
                _isExtendedEndDate = false;
                window._isExtendedEndDate = false;
                _markRrlExtendRefreshGate('extended');
                console.warn('GetIsExtendProject failed:', xhr.status);
            }
        );
    }
    // End of Added by Vyankat B. on 12-May-2026

    /* ═══════════════════════════════════════════════════════════════════════
       API 2a – GetUISetting
       POST /api/PM_BulkResourceAllocation/GetUISetting
       Called once on page init. Stores result in _uiSettings for downstream
       field-visibility decisions (e.g. IsDefaultApprover, IsBillable flags).
       Added by Nikhil Mane on 09-04-2026
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadUISetting() {
        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetUISetting',
            null, true,
            function (response) {
                _uiSettings = (response && response.data) ? response.data : null;
                applyUISettings();
            },
            function (xhr) {
                console.warn('GetUISetting failed:', xhr.status);
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }

    /* Apply visibility rules driven by _uiSettings to any always-visible fields.
       Updated by Vyankat B. on 13-Apr-2026 — show/hide Is Default Approver checkbox
       based on showResourceAllocation flag from GetUISetting response. */
    function applyUISettings() {
        if (!_uiSettings) return;

        // showResourceAllocation drives Is Default Approver visibility
        // (mirrors the network response: { showResourceAllocation: true })
        var rawArr = Array.isArray(_uiSettings) ? _uiSettings : null;
        var settingRow = (rawArr && rawArr.length > 0) ? rawArr[0] : _uiSettings;
        var showApprover = !!(
            settingRow.showResourceAllocation ||
            settingRow.ShowResourceAllocation ||
            settingRow.IsDefaultApproverEnabled ||
            settingRow.isDefaultApproverEnabled
        );

        if (showApprover) {
            document.getElementById('divOcIsDefaultApprover').style.setProperty('display', 'flex', 'important');
            document.querySelectorAll('[id^="th-rrl-col-approver-"]').forEach(function (el) {
                el.style.display = 'table-cell';
            });
        } else {
            document.getElementById('divOcIsDefaultApprover').style.setProperty('display', 'none', 'important');
            document.querySelectorAll('[id^="th-rrl-col-approver-"]').forEach(function (el) {
                el.style.display = 'none';
            });
        }

        var showDefaultApproverLegacy = (_uiSettings.IsDefaultApproverEnabled || _uiSettings.isDefaultApproverEnabled);
        if (showDefaultApproverLegacy === false) {
            $('.div-default-approver').hide();
        }
        if (typeof syncBulkAllocTableColumns === 'function') syncBulkAllocTableColumns();
    }
    // End of Added by Nikhil Mane on 09-04-2026

    /* ═══════════════════════════════════════════════════════════════════════
       API 2a-bis – LoadResourceRequestConfig
       POST /api/PM_BulkResourceReq/GetResourceRequestConfiguration
       Reads Count_BulkRequest_Rows (row limit) — same endpoint and SP as
       PM_BulkResourceReq.aspx. onComplete callback fires after load.
       Added by Vyankat B. on 13th April 2026
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadResourceRequestConfig(onComplete) {
        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceReq/GetResourceRequestConfiguration',
            JSON.stringify({}), true,
            function (response) {
                var cfg = null;
                if (response && response.data && response.data.data && response.data.data.length > 0) {
                    cfg = response.data.data[0];
                } else if (response && response.data && response.data.length > 0) {
                    cfg = response.data[0];
                }
                if (cfg) {
                    Count_BulkRequest_Rows = parseInt(cfg.count_BulkRequest_Rows || cfg.Count_BulkRequest_Rows) || 0;
                }
            },
            function (xhr) {
                console.warn('GetResourceRequestConfiguration failed:', xhr.status);
            },
            function () {
                if (typeof onComplete === 'function') onComplete();
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }
    // End of Added by Vyankat B. on 13th April 2026

    /* ═══════════════════════════════════════════════════════════════════════
       API 2a-ter – LoadResourceHrs
       POST /api/PM_BulkResourceReq/GetresourceHrs
       Reads the configured max allocation % from SEM settings — same endpoint
       as PM_BulkResourceReq.aspx validateAllocationLimitsAsync. onComplete
       callback fires after load.
       Added by Vyankat B. on 13th April 2026
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadResourceHrs(onComplete) {
        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceReq/GetresourceHrs',
            JSON.stringify({}), true,
            function (response) {
                var parsed = parseInt(
                    response &&
                    response.ResourceAllocationSettingModel &&
                    response.ResourceAllocationSettingModel[0] &&
                    response.ResourceAllocationSettingModel[0].settingValue
                );
                if (!isNaN(parsed) && parsed > 0) {
                    _maxAllocPct = parsed;
                }
            },
            function (xhr) {
                console.warn('GetresourceHrs failed:', xhr.status);
            },
            function () {
                if (typeof onComplete === 'function') onComplete();
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }
    // End of Added by Vyankat B. on 13th April 2026

    /* ═══════════════════════════════════════════════════════════════════════
       API 2b – GetdefApprovers
       POST /api/PM_BulkResourceAllocation/GetdefApprovers  { "ProjectID": id }
       Populates the "Reporting To" (ocReportingTo) selectpicker in the
       offcanvas every time it opens, scoped to the current project.
       Added by Nikhil Mane on 09-04-2026
       ═══════════════════════════════════════════════════════════════════════ */
    function _extractReportingToRows(response) {
        function _looksLikeReportingToRow(s) {
            if (!s || typeof s !== 'object') return false;
            return s.EmployeeID != null || s.employeeID != null || s.employeeId != null ||
                s.EmployeeName != null || s.employeeName != null ||
                s.ResourceName != null || s.resourceName != null;
        }
        function _unwrapReportingTo(node) {
            if (!node) return [];
            if (Array.isArray(node)) return node;
            if (typeof node === 'string') {
                try { return _unwrapReportingTo(JSON.parse(node)); } catch (e) { return []; }
            }
            if (typeof node !== 'object') return [];
            var rt = node.reportingTo != null ? node.reportingTo : node.ReportingTo;
            if (rt != null) {
                if (Array.isArray(rt)) return rt;
                if (typeof rt === 'object') {
                    if (Array.isArray(rt.ReportingToModel)) return rt.ReportingToModel;
                    if (Array.isArray(rt.reportingToModel)) return rt.reportingToModel;
                    if (Array.isArray(rt.data)) return rt.data;
                    if (Array.isArray(rt.Data)) return rt.Data;
                }
            }
            if (Array.isArray(node.ReportingToModel)) return node.ReportingToModel;
            if (Array.isArray(node.reportingToModel)) return node.reportingToModel;
            if (Array.isArray(node.data)) return node.data;
            if (Array.isArray(node.Data)) return node.Data;
            if (node.data && typeof node.data === 'object') {
                var nested = _unwrapReportingTo(node.data);
                if (nested.length) return nested;
            }
            var keys = Object.keys(node);
            for (var k = 0; k < keys.length; k++) {
                var arr = node[keys[k]];
                if (!Array.isArray(arr) || !arr.length || !arr[0] || typeof arr[0] !== 'object') continue;
                if (_looksLikeReportingToRow(arr[0])) return arr;
            }
            return [];
        }
        if (!response) return [];
        if (Array.isArray(response)) return response;
        var fromData = response.data != null ? _unwrapReportingTo(response.data) : [];
        if (fromData.length) return fromData;
        return _unwrapReportingTo(response);
    }

    function _getReportingToRowName(row) {
        if (!row) return '';
        return (row.EmployeeName || row.employeeName || row.ResourceName || row.resourceName ||
            row.reportingToName || row.ReportingToName || row.approverName || row.ApproverName ||
            row.Text || '').toString().trim();
    }

    function _getReportingToRowId(row) {
        if (!row) return '';
        return String(row.EmployeeID || row.employeeID || row.employeeId || row.EmployeeId ||
            row.approverID || row.ApproverID || row.Value || '').trim();
    }

    function _isReportingToPlaceholder(value, text) {
        var v = String(value || '').trim();
        var t = String(text || '').trim().toLowerCase();
        return (!v || v === '0') ||
               t === '' ||
               t === 'select' ||
               t === 'select reporting to' ||
               t === '--select--';
    }

    function _filterReportingToRows(rows) {
        var byId = {};
        var idOrder = [];
        var ungrouped = [];
        for (var i = 0; i < (rows || []).length; i++) {
            var r = rows[i];
            if (!r || typeof r !== 'object') continue;
            var id = parseInt(_getReportingToRowId(r), 10) || 0;
            var name = _getReportingToRowName(r);
            if (_isReportingToPlaceholder(String(id || ''), name)) continue;
            if (!id && !name) continue;
            if (id) {
                if (!byId[id]) {
                    byId[id] = r;
                    idOrder.push(id);
                }
            } else {
                ungrouped.push(r);
            }
        }
        var out = [];
        for (var j = 0; j < idOrder.length; j++) {
            out.push(byId[idOrder[j]]);
        }
        return out.concat(ungrouped);
    }

    function _sortReportingToRows(rows) {
        return (rows || []).slice().sort(function (a, b) {
            var oa = parseInt(a.OrderNo || a.orderNo || 0, 10) || 0;
            var ob = parseInt(b.OrderNo || b.orderNo || 0, 10) || 0;
            if (oa !== ob) return oa - ob;
            var na = _getReportingToRowName(a);
            var nb = _getReportingToRowName(b);
            return na.localeCompare(nb);
        });
    }

    function _reportingToPlaceholderOptionHtml() {
        return '<option value="" disabled hidden></option>';
    }

    function _buildReportingToOptionsHtml(rows, selectedVal, selectedName) {
        var list = _sortReportingToRows(_filterReportingToRows(rows));
        var html = _reportingToPlaceholderOptionHtml();
        var selectedIdStr = String(parseInt(selectedVal, 10) || 0);
        var selectedNameStr = (selectedName || '').toString().replace(/\u2026/g, '...').replace(/\.\.\.$/, '').trim().toLowerCase();
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            var v = _getReportingToRowId(item);
            var t = _getReportingToRowName(item);
            if (_isReportingToPlaceholder(v, t)) continue;
            if (!v && !t) continue;
            var vNum = String(parseInt(v, 10) || 0);
            var label = t || ('ID ' + v);
            var sel = '';
            if (selectedIdStr !== '0' && vNum === selectedIdStr) sel = ' selected';
            else if ((selectedIdStr === '0' || !selectedIdStr) && selectedNameStr && label.toLowerCase() === selectedNameStr) sel = ' selected';
            else if (v && v !== '0' && v === String(selectedVal || '')) sel = ' selected';
            var lbl = escHtml(label);
            var projRes = ((item.isExternal || item.IsExternal || '') + '').trim().toLowerCase() === 'project resource';
            html += '<option value="' + escHtml(v) + '"' + sel + (projRes ? ' data-content="<strong>' + lbl + '</strong>"' : '') + '>' + lbl + '</option>';
        }
        return html;
    }

    function _fillReportingToOptions($sel, rows, selectedVal, selectedName) {
        if (!$sel || !$sel.length) return;
        var placeholder = RES.C_SelectReportingTo || 'Select Reporting To';
        if (!$sel.attr('data-none-selected-text')) {
            $sel.attr('data-none-selected-text', placeholder);
        }
        if (!$sel.attr('title')) {
            $sel.attr('title', placeholder);
        }
        _cleanupBaSelectpickerDom($sel);//Added By Dipali V On 15th Jun 2026 Ensure old options are cleared to prevent duplicates; preserves selectpicker structure
        $sel.html(_buildReportingToOptionsHtml(rows, selectedVal, selectedName));
        _initReportingToSelectpicker($sel);
    }

    /* Added By Dipali V On 27th May - Default Reporting To as logged-in person in offcanvas */
    function _setOffcanvasReportingToValue($sel, value) {
        if (!$sel || !$sel.length) return;
        var v = String(value || '').trim();
        try {
            if ($sel.data('selectpicker')) {
                $sel.selectpicker('val', v);
            } else {
                $sel.val(v);
            }
        } catch (e) {
            $sel.val(v);
        }
        $sel.trigger('change');
    }

    function _ensureDefaultReportingToSelection($sel) {
        $sel = $sel && $sel.length ? $sel : $('#ocReportingTo');
        if (!$sel.length) return '';
        var cur = String($sel.val() || '').trim();
        if (cur && cur !== '0') return cur;
        return _selectLoggedInAsDefaultReportingTo($sel);
    }

    function _getPreferredReportingToEmployeeId() {
        var daId = parseInt(_projectDefaultApproverEmployeeId, 10) || 0;
        if (daId > 0) return daId;
        return parseInt(SessionEmployeeID || SessionUserID, 10) || 0;
    }

    function _shouldUsePreferredReportingTo(curVal) {
        return !(parseInt(curVal, 10) || 0);
    }

    function _applyProjectDefaultApproverReportingTo() {
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            var gid = $(this).attr('data-group');
            if (!gid || $('#sel-res-body-' + gid + ' tr').length) return;
            var $rpt = $('#rg-rpt-' + gid);
            if (!$rpt.length || !_shouldUsePreferredReportingTo($rpt.val())) return;
            var val = _selectLoggedInAsDefaultReportingTo($rpt);
            if (val) _applyReportingToSync(gid, val, 'rg');
        });
    }

    function _ensureReportingToOption(empId, empName) {
        var id = parseInt(empId, 10) || 0;
        if (!id) return;
        var all = window._reportingToAllRows || (window._reportingToAllRows = []);
        var opts = window._reportingToOptions || (window._reportingToOptions = []);
        if (all.some(function (o) { return (parseInt(_getReportingToRowId(o), 10) || 0) === id; })) return;
        var row = {
            EmployeeID: id,
            employeeID: id,
            EmployeeName: (empName || '').trim() || ('ID ' + id),
            employeeName: (empName || '').trim() || ('ID ' + id),
            IsExternal: '',
            isExternal: ''
        };
        all.push(row);
        opts.push(row);
    }

    function _syncReportingToOptionToSelect($sel, empId, empName) {
        if (!$sel || !$sel.length) return;
        var id = parseInt(empId, 10) || 0;
        if (!id) return;
        _ensureReportingToOption(id, empName);
        if (_matchReportingToOptionValue($sel, id)) return;
        var rows = window._reportingToAllRows || window._reportingToOptions || [];
        var cur = String($sel.val() || id).trim();
        _fillReportingToOptions($sel, rows, cur, empName);
    }

    function _matchReportingToOptionValue($sel, employeeId) {
        if (!$sel || !$sel.length) return '';
        var preferred = parseInt(employeeId, 10) || 0;
        if (!preferred) return '';
        var matched = '';
        $sel.find('option').each(function () {
            var v = String($(this).val() || '').trim();
            if (!v || v === '0') return;
            if ((parseInt(v, 10) || 0) === preferred) { matched = v; return false; }
        });
        return matched;
    }

    function _selectLoggedInAsDefaultReportingTo($sel) {
        if (!$sel || !$sel.length) return '';
        var preferredId = _getPreferredReportingToEmployeeId();
        if (preferredId > 0) {
            _ensureReportingToOption(preferredId, _projectDefaultApproverEmployeeName || '');
            _syncReportingToOptionToSelect($sel, preferredId, _projectDefaultApproverEmployeeName || '');
        }
        var matchedValue = _matchReportingToOptionValue($sel, preferredId);
        if (!matchedValue && preferredId === (parseInt(SessionEmployeeID || SessionUserID, 10) || 0)) {
            var loggedInName = String(SessionUserName || '').trim().toLowerCase();
            $sel.find('option').each(function () {
                var v = String($(this).val() || '').trim();
                var t = String($(this).text() || '').trim().toLowerCase();
                if (!v || v === '0') return;
                if (loggedInName && t === loggedInName) { matchedValue = v; return false; }
            });
        }
        if (typeof _setBaReportingToSelectValue === 'function') {
            _setBaReportingToSelectValue($sel, matchedValue || '');
        } else {
            _setOffcanvasReportingToValue($sel, matchedValue || '');
        }
        return matchedValue || '';
    }

    function _refreshProjectDefaultApproverFromBaSelection() {
        var foundId = 0, foundName = '';
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            var gid = $(this).attr('data-group');
            if (!gid) return;
            $('#sel-res-body-' + gid + ' tr').each(function () {
                var rid = parseInt($(this).attr('data-res-id'), 10) || 0;
                if (!rid) return;
                var chk = document.getElementById('chkApprover_res_' + gid + '_' + rid);
                if (chk && chk.checked) {
                    foundId = rid;
                    foundName = $(this).find('td:first strong').text().trim();
                    return false;
                }
            });
            if (foundId) return false;
        });
        _projectDefaultApproverEmployeeId = foundId || _initialProjectDefaultApproverEmployeeId || 0;
        if (foundId) {
            _projectDefaultApproverEmployeeName = foundName || _projectDefaultApproverEmployeeName;
            _ensureReportingToOption(foundId, foundName);
        }
        _applyProjectDefaultApproverReportingTo();
    }

    function _refreshRrlReportingToOptionsAfterLoad() {
        var projectId = parseInt(SessionProjectID) || 0;
        if (!projectId || typeof _rrlCacheByProject === 'undefined' || !_rrlCacheByProject[projectId]) return;

        document.querySelectorAll('.resource-group').forEach(function (grpEl) {
            var gid = parseInt(grpEl.getAttribute('data-group'), 10) || 0;
            if (!gid) return;
            /* Do not re-render a row while the user is editing it. */
            if ($('#rrl-tbody-' + gid + ' tr.rrl-row-editing').length) return;

            var selectedText = $('#rg-role-' + gid + ' option:selected').text().trim();
            var roleArg = (!selectedText || selectedText === RES.C_SelectRole) ? null : selectedText;
            _rrlRenderForGroup(gid, roleArg, _rrlCacheByProject[projectId], _rrlPaginationByProject[projectId]);
        });
    }

    function LoadDefaultApprovers(projectId, onComplete) {
        var $sel = $('#ocReportingTo');
        _cleanupBaSelectpickerDom($sel);////Added By Dipali V On 15th Jun 2026 Ensure old options are cleared to prevent duplicates; preserves selectpicker structure
        $sel.empty().append('<option value="">Loading…</option>');

        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetdefApprovers',
            JSON.stringify({ ProjectID: parseInt(projectId || SessionProjectID, 10) || 0 }), true,
            function (response) {
                var rows = _filterReportingToRows(_extractReportingToRows(response));
                window._reportingToAllRows = rows;
                window._reportingToOptions = rows.slice();
                if (_projectDefaultApproverEmployeeId > 0) {
                    _ensureReportingToOption(_projectDefaultApproverEmployeeId, _projectDefaultApproverEmployeeName || '');
                }
                var gid = activeGroupId;
                var rgRpt = (gid && $('#rg-rpt-' + gid).length) ? String($('#rg-rpt-' + gid).val() || '').trim() : '';
                var preselect = (rgRpt && rgRpt !== '0') ? rgRpt : '';
                _fillReportingToOptions($sel, rows, preselect, null);
                var selectedReportingTo = preselect
                    ? (_matchReportingToOptionValue($sel, preselect) || preselect)
                    : '';
                setTimeout(function () {
                    if (selectedReportingTo) {
                        _setBaReportingToSelectValue($sel, selectedReportingTo);
                    } else if ((window._reportingToAllRows || []).length) {
                        _selectLoggedInAsDefaultReportingTo($sel);
                    }
                }, 0);
                _refreshRrlReportingToOptionsAfterLoad();
                _refreshRrlPersistedOffcanvasOnDom(_REALLOC_TAB_GID);
                if (typeof _refreshAllBaRgReportingToDropdowns === 'function') _refreshAllBaRgReportingToDropdowns();
            },
            function (xhr) {
                $sel.empty().append('<option value="" disabled hidden></option>');
                _refreshReportingToSelectpicker($sel);
                console.warn('GetdefApprovers failed:', xhr.status);
            },
            function () {
                if (typeof onComplete === 'function') onComplete();
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }
    // End of Added by Nikhil Mane on 09-04-2026

    /* ═══════════════════════════════════════════════════════════════════════
       API 2c – GetResourcesForAllocationByRoleDatePct
       POST /api/PM_BulkResourceAllocation/GetResourcesForAllocationByRoleDatePct
       Body: { roleID, fromDate, toDate, requiredAllocationPct }
       Called when the user changes any filter dropdown (Designation, Dept,
       Business Group, Org Unit) in the offcanvas search section.
       Returns the full candidate pool; results are then filtered client-side
       by the selected dropdown values.
       Added by Nikhil Mane on 09-04-2026
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadResourcesByRoleDatePct(gid, callback) {
        var gidToUse = gid || activeGroupId;
        if (!gidToUse) return;

        var roleId   = parseInt($('#rg-role-' + gidToUse).val()) || null;
        var fromDt   = displayDateToISO($('.rg-start[data-group="' + gidToUse + '"]').val());
        var toDt     = displayDateToISO($('.rg-end[data-group="' + gidToUse + '"]').val());
        var allocPct = _parseIntegerAllocation($('.rg-alloc[data-group="' + gidToUse + '"]').val());
        allocPct = isNaN(allocPct) ? null : allocPct;

        var body = {
            roleID:                roleId,
            fromDate:              fromDt || null,
            toDate:                toDt   || null,
            requiredAllocationPct: allocPct
        };

        showResLoading(RES.A_FilteringResources);

        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetResourcesForAllocationByRoleDatePct',
            JSON.stringify(body), true,
            function (response) {
                var raw = [];
                if (response && Array.isArray(response.data)) raw = response.data;
                else if (Array.isArray(response))              raw = response;
                RESOURCES = raw.map(function (r) {
                    return {
                        id:            r.EmployeeID      || r.employeeID      || 0,
                        name:          r.EmployeeName    || r.employeeName    || '',
                        role:          r.Role            || r.role            || '',
                        dept:          r.Department      || r.department      || '',
                        businessGroup: r.BusinessGroup   || r.businessGroup   || '',
                        designation:   r.Designation     || r.designation     || '',
                        orgUnit:       r.OrganizationUnit|| r.organizationUnit|| '',
                        currentAlloc:  0,
                        availPct:      parseFloat(r.FreePercentage  || r.freePercentage  || 0),
                        maxAlloc:      100,
                        freePct:       parseFloat(r.FreePercentage  || r.freePercentage  || 0),
                        matchType:     r.MatchType       || r.matchType       || ''
                    };
                });
                applyDropdownFiltersAndRender();
                if (typeof callback === 'function') callback(RESOURCES);
            },
            function (xhr) {
                buildResourceTable([]);
                console.warn('GetResourcesForAllocationByRoleDatePct failed:', xhr.status);
            },
            function () { hideResLoading(); }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }

    /* Called on every filter-dropdown change; re-fetches resources with new filter values.
       Modified by Nikhil Mane on 10-04-2026 – Always delegates to the active Exact/Probable
       SP so Department, Business Group, and Org Unit are forwarded as SP parameters
       (@PintDepartmentID, @intBusinessGroupID, @intOfficeID) instead of being applied
       client-side against a stale in-memory list. Page is reset to 1 on each filter change. */
    function filterResourcesByDropdowns() {
        if (!activeGroupId) return;
        /* New filter context — do not count resources selected under the previous filter. */
        _resetOffcanvasPendingSelectionKeepConfirmed(activeGroupId);
        // Reset to first page whenever a search filter changes.
        resourcePageNumber = 1;
        var mode = getMatchType();
        if (mode === 'exact') {
            LoadExactMatchResources(activeGroupId);
        } else {
            LoadProbableMatchResources(activeGroupId);
        }
    }
    // End of Modified by Nikhil Mane on 10-04-2026

    /* Filter the in-memory list and re-render the table.
       Modified by Nikhil Mane on 10-04-2026 – Department, Business Group, and Org Unit
       are now server-side SP params; only Employee Name text search is applied locally.
       Modified by Dipali V On 9th Jun 2026 – When Employee Name is typed, reload page 1
       with a larger page size so name search works across all records, not only the
       current pagination page. */
    function _hasResourceNameSearchFilter() {
        return (($('#resourceSearch').val() || '').trim().length > 0);
    }

    function _getResourceListRequestPaging() {
        if (_hasResourceNameSearchFilter()) {
            var fetchSize = Math.max(resourceTotalRecords || 0, resourcePageSize, 100);
            return { pageNumber: 1, pageSize: Math.min(fetchSize, 500) };
        }
        return { pageNumber: resourcePageNumber, pageSize: resourcePageSize };
    }

    function filterResourcesByName() {
        if (!activeGroupId) return;
        resourcePageNumber = 1;
        clearTimeout(_resourceNameSearchTimer);
        _resourceNameSearchTimer = setTimeout(function () {
            if (getMatchType() === 'exact') LoadExactMatchResources(activeGroupId);
            else LoadProbableMatchResources(activeGroupId);
        }, 300);
    }

    function applyDropdownFiltersAndRender() {
        var fName  = ($('#resourceSearch').val()   || '').toLowerCase().trim();

        var filtered = RESOURCES.filter(function (r) {
            if (fName  && (r.name + ' ' + (r.role || '')).toLowerCase().indexOf(fName) < 0) return false;
            return true;
        });
        buildResourceTable(filtered);
        if (fName) {
            $('#resourcePagerTotal').text('Total Records: ' + filtered.length);
            $('#btnResourcePrev').prop('disabled', true);
            $('#btnResourceNext').prop('disabled', true);
        } else {
            updateResourcePaginationUI();
        }
    }

    /* ═══════════════════════════════════════════════════════════════════════
       API 2d – GetResourceDetailsAllocation
       POST /api/PM_BulkResourceAllocation/GetResourceDetailsAllocation
       Body: { employeeID }
       Called inside openResourceDetails(id) to populate the details offcanvas
       with richer data: Designation, OrgUnit, PrimarySkills, Skills, and the
       per-project allocation breakdown (result set 2).
       Added by Nikhil Mane on 09-04-2026
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadResourceDetailsAllocation(employeeId) {
        var body = { employeeID: parseInt(employeeId) };
        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetResourceDetailsAllocation',
            JSON.stringify(body), true,
            function (response) {
                var info = null;
                if (response && Array.isArray(response.resourceDetails) && response.resourceDetails.length > 0) {
                    info = response.resourceDetails[0];
                } else if (response && Array.isArray(response.data) && response.data.length > 0) {
                    info = response.data[0];
                }
                if (info) {
                    var additionalRows =
                        '<tr><td><i class="far fa-id-card"></i> Designation</td><td>' + escHtml(info.Designation     || info.designation     || '—') + '</td></tr>' +
                        '<tr><td><i class="fas fa-sitemap"></i> Organization Unit</td><td>'    + escHtml(info.OrganizationUnit|| info.organizationUnit|| '—') + '</td></tr>' +
                        '<tr><td><i class="fas fa-star"></i> Primary Skills</td><td>' + escHtml(info.PrimarySkills   || info.primarySkills   || '—') + '</td></tr>' +
                        '<tr><td><i class="fas fa-tools"></i> Secondary Skills</td><td>'    + escHtml(info.Skills          || info.skills          || '—') + '</td></tr>' +
                        '<tr><td><i class="fas fa-percentage"></i> Total Allocation %</td><td><strong>' +
                            (info.totalAllocationPercentage != null ? parseFloat(info.totalAllocationPercentage).toFixed(1) + '%' : '—') +
                        '</strong></td></tr>';
                    $('#detailInfoBody').append(additionalRows);
                }
                var projects = [];
                if (response && Array.isArray(response.projectAllocations)) {
                    projects = response.projectAllocations;
                } else if (response && Array.isArray(response.data2)) {
                    projects = response.data2;
                }
                if (projects.length > 0) {
                    var html = '<div class="detail-block-title"><i class="far fa-list-alt"></i> Project Allocations</div>' +
                               '<div class="project-alloc-list">';
                    projects.forEach(function (p) {
                        var pName  = escHtml(p.ProjectName  || p.projectName  || '');
                        var pAlloc = p.projectAllocationPercentage != null
                            ? parseFloat(p.projectAllocationPercentage).toFixed(1) + '%' : '—';
                        html += '<div class="line"><span>' + pName + '</span><span><strong>' + pAlloc + '</strong></span></div>';
                    });
                    html += '</div>';
                    $('#resourceDetailsOffcanvas .offcanvas-body').append(html);
                }

                $("#UserName").text(escHtml(info.userName));
            },
            function (xhr) {
                console.warn('GetResourceDetailsAllocation failed:', xhr.status);
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */

        reinitTooltips();
    }
    // End of Added by Nikhil Mane on 09-04-2026

    /* ═══════════════════════════════════════════════════════════════════════
       API 2 – Employee Role dropdown for main table (server-rendered template)
       Uses use_Sel_Whizible2_Role SP via tmpl-employee-role
       Modified by Nikhil Mane on 15-04-2026 — uses separate tmpl-employee-role template
       ═══════════════════════════════════════════════════════════════════════ */
    function cloneRoleSelect(newId, groupId) {
        /* Modified by Nikhil Mane on 15-04-2026 — read from tmpl-employee-role (use_Sel_Whizible2_Role) */
        var src = document.getElementById('tmpl-project-role');
        if (!src) {
            return '<select class="selectpicker rg-role" id="' + newId + '" data-group="' + groupId + '" data-live-search="true" data-width="100%" data-container="body"><option value="">Select Role</option></select>';
        }
        var srcSelect = src.querySelector('select');
        if (!srcSelect) {
            return '<select class="selectpicker rg-role" id="' + newId + '" data-group="' + groupId + '" data-live-search="true" data-width="100%" data-container="body"><option value="">Select Role</option></select>';
        }
        var clone = srcSelect.cloneNode(true);
        clone.id = newId;
        clone.setAttribute('data-group', groupId);
        clone.classList.add('selectpicker', 'rg-role');
        clone.setAttribute('data-live-search', 'true');
        clone.setAttribute('data-width', '100%');
        clone.setAttribute('data-container', 'body');
        return clone.outerHTML;
    }

    /* Modified by Nikhil Mane on 15-04-2026 — reads from tmpl-project-role (usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo)
       so the offcanvas Project Role uses a different SP from the main table Employee Role */
    function cloneRoleOptionsToOffcanvas() {
        var src = document.getElementById('tmpl-project-role');
        if (!src) return;
        var srcSelect = src.querySelector('select');
        if (!srcSelect) return;
        var $oc = $('#ocProjectRole').empty();
        $(srcSelect).find('option').each(function () { $oc.append($(this).clone()); });
        $oc.selectpicker('refresh');
    }

    /* Added by Nikhil Mane on 05-May-2026 — Populates the Employee Role selectpicker
       (#ocEmployeeRole) in the offcanvas Search section from the tmpl-employee-role
       template (use_Sel_Whizible2_Role SP). Called once on page init.
       This dropdown is shown only when Probable Match is active and is used solely
       to override the roleID sent to GetResourcesProbableAllocationMatch for searching;
       it does NOT affect the group's main project role dropdown. */
    function cloneEmployeeRoleOptionsToOffcanvas() {
        var src = document.getElementById('tmpl-employee-role');
        if (!src) return;
        var srcSelect = src.querySelector('select');
        if (!srcSelect) return;
        var $oc = $('#ocEmployeeRole').empty();
        $oc.append('<option value="">Select Employee Role</option>');
        $(srcSelect).find('option').each(function () {
            var val = $(this).val();
            if (!val || val === '0' || val === '') return; /* skip blank placeholder */
            $oc.append($(this).clone());
        });
        $oc.selectpicker('refresh');
    }
    /* End of Added by Nikhil Mane on 05-May-2026 */

    /* ═══════════════════════════════════════════════════════════════════════
       API 3 – Exact Match
       POST /api/PM_BulkResourceAllocation/GetResourcesExactAllocationMatch
       Body: { roleID, fromDate, toDate, requiredAllocationPct, requestProjectID }
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadExactMatchResources(gid, callback) {
        var roleId = parseInt($('#rg-role-' + gid).val()) || null;
        var fromDt = displayDateToISO($('.rg-start[data-group="' + gid + '"]').val());
        var toDt = displayDateToISO($('.rg-end[data-group="' + gid + '"]').val());
        var allocPct = _parseIntegerAllocation($('.rg-alloc[data-group="' + gid + '"]').val());
        allocPct = isNaN(allocPct) ? null : allocPct;
        var projId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID) : null;

        // Added by Nikhil Mane on 10-04-2026 – Read search-filter dropdown values so
        // Department, Business Group, and Org Unit (Office) selections are forwarded to
        // the SP (@PintDepartmentID, @intBusinessGroupID, @intOfficeID).
        var deptId     = parseInt($('#ocDepartment').val())     || null;
        var bgId       = parseInt($('#ocBusinessGroup').val())  || null;
        var orgUnitId = parseInt($('#ocOrgUnit').val()) || null;
        var designationId = parseInt($('#ocDesignation').val()) || null;
        // End of Added by Nikhil Mane on 10-04-2026
        // Added by Nikhil Mane on 13-04-2026 – Skill filter and partial availability checkbox
        // Modified 27-May-2026 — Match Skill checkbox removed; Search By Skill controls this behavior.
        var skillId = 0;
        var inclPartial = false;
        var roleSkillFilters = getBulkAllocRoleSkillFilters(gid);
        var skipRoleSkillFilter = _shouldSkipRoleSkillFilterForGroup(gid);
        if (skipRoleSkillFilter) {
            roleSkillFilters = [];
        }
        var primaryRoleSkill = roleSkillFilters.length > 0 ? roleSkillFilters[0] : null;
        if (_pageSkillFilterEnabled && !skipRoleSkillFilter) {
            if (roleSkillFilters.length > 1) {
                /* Multi-skill exact match is driven by skillFiltersJson in API/SP. */
                skillId = 0;
                inclPartial = true;
            } else if (primaryRoleSkill && primaryRoleSkill.skillId > 0) {
                skillId = primaryRoleSkill.skillId;
                inclPartial = true;
            } else {
                skillId = parseInt($('#ocSkill').val()) || 0;
                inclPartial = skillId > 0;
            }
        }
        // End of Added by Nikhil Mane on 13-04-2026

        var listPaging = _getResourceListRequestPaging();
        var param = JSON.stringify({
            roleID: roleId,
            fromDate: fromDt || null,
            toDate: toDt || null,
            requiredAllocationPct: allocPct,
            requestProjectID: projId,
            // Added by Nikhil Mane on 10-04-2026 – Search filter fields passed to SP.
            departmentID:   deptId,
            businessGroupID: bgId,
            officeID: orgUnitId,
            designationID: designationId,
            // End of Added by Nikhil Mane on 10-04-2026
            // Added by Nikhil Mane on 13-04-2026 – Skill filter and partial availability
            skillID: skillId,
            includePartialAvailability: inclPartial,
            /* Added By Dipali V On 27th May - forwarded for API/SP extension;
               current Exact SP uses intSkillID + isSkillRequired. */
            //experienceYear: primaryRoleSkill ? primaryRoleSkill.experienceYear : 0,
            //experienceMonth: primaryRoleSkill ? primaryRoleSkill.experienceMonth : 0,
            //proficiency: primaryRoleSkill ? primaryRoleSkill.proficiency : 0,
            //coreCompetency: primaryRoleSkill ? primaryRoleSkill.coreCompetency : false,
            skillFiltersJson: roleSkillFilters.length ? JSON.stringify(roleSkillFilters) : null,
            // End of Added by Nikhil Mane on 13-04-2026
            pageNumber: listPaging.pageNumber,
            pageSize: listPaging.pageSize
        });

        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        showResLoading(RES.A_LoadingExactMatch);
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetResourcesExactAllocationMatch',
            param, true,
            function (response) {
                var parsed = _parseResourceListApiResponse(response);
                var raw = parsed.raw;
                var pg = parsed.pagination;
                RESOURCES = mapExactMatchResources(raw);
                RESOURCES.forEach(function (r) {
                    var key = String(r.id);
                    resourceByIdCache[key] = r;
                    if (tempSelected.has(key)) selectedResourceMap[key] = r;
                });
                setResourcePaginationStateFromApi(raw, pg);
                applyDropdownFiltersAndRender();
                if (callback) callback();
            },
            function () {
                RESOURCES = [];
                setResourcePaginationStateFromApi([], null);
                applyDropdownFiltersAndRender();
                alertify.set('notifier', 'position', 'top-right'); alertify.error(RES.A_FailedToLoadExactMatchResources);
            },
            function () { hideResLoading(); }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }

    /* ═══════════════════════════════════════════════════════════════════════
       API 4 – Probable Match
       POST /api/PM_BulkResourceAllocation/GetResourcesProbableAllocationMatch
       Same request body as Exact Match
       ═══════════════════════════════════════════════════════════════════════ */
    function LoadProbableMatchResources(gid, callback) {
        var roleId = parseInt($('#rg-role-' + gid).val()) || null;
        var fromDt = displayDateToISO($('.rg-start[data-group="' + gid + '"]').val());
        var toDt = displayDateToISO($('.rg-end[data-group="' + gid + '"]').val());
        var allocPct = _parseIntegerAllocation($('.rg-alloc[data-group="' + gid + '"]').val());
        allocPct = isNaN(allocPct) ? null : allocPct;
        var projId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID) : null;

        // Added by Nikhil Mane on 05-May-2026 — When Probable Match is active and the
        // Employee Role dropdown (#ocEmployeeRole) has a value selected (roleid > 0),
        // use that role ID for the search API call instead of the group's project role.
        // This is for searching only — the main group project role dropdown is unchanged.
        var employeeRoleId = parseInt($('#ocEmployeeRole').val()) || 0;
        if (employeeRoleId > 0) {
            roleId = employeeRoleId;
        }
        // End of Added by Nikhil Mane on 05-May-2026

        // Added by Nikhil Mane on 10-04-2026 – Read search-filter dropdown values so
        // Department, Business Group, and Org Unit (Office) selections are forwarded to
        // the SP (@PintDepartmentID, @intBusinessGroupID, @intOfficeID).
        var deptId     = parseInt($('#ocDepartment').val())     || null;
        var bgId       = parseInt($('#ocBusinessGroup').val())  || null;
        var orgUnitId = parseInt($('#ocOrgUnit').val()) || null;
        var designationId = parseInt($('#ocDesignation').val()) || null;
        // End of Added by Nikhil Mane on 10-04-2026

        var listPaging = _getResourceListRequestPaging();
        var param = JSON.stringify({
            roleID: roleId,
            fromDate: fromDt || null,
            toDate: toDt || null,
            requiredAllocationPct: allocPct,
            requestProjectID: projId,
            // Added by Nikhil Mane on 10-04-2026 – Search filter fields passed to SP.
            departmentID:   deptId,
            businessGroupID: bgId,
            officeID: orgUnitId,
            designationID: designationId,
            // End of Added by Nikhil Mane on 10-04-2026
            pageNumber: listPaging.pageNumber,
            pageSize: listPaging.pageSize
        });

        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        showResLoading(RES.A_LoadingProbable);
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetResourcesProbableAllocationMatch',
            param, true,
            function (response) {
                var parsed = _parseResourceListApiResponse(response);
                var raw = parsed.raw;
                var pg = parsed.pagination;
                RESOURCES = mapExactMatchResources(raw);
                RESOURCES.forEach(function (r) {
                    var key = String(r.id);
                    resourceByIdCache[key] = r;
                    if (tempSelected.has(key)) selectedResourceMap[key] = r;
                });
                setResourcePaginationStateFromApi(raw, pg);
                applyDropdownFiltersAndRender();
                if (callback) callback();
            },
            function () {
                RESOURCES = [];
                setResourcePaginationStateFromApi([], null);
                applyDropdownFiltersAndRender();
                alertify.set('notifier', 'position', 'top-right'); alertify.error(RES.A_FailedToLoadProbableResources);
            },
            function () { hideResLoading(); }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }

    /* Map raw API response → internal resource object */
    function mapExactMatchResources(raw) {
        return (raw || []).map(function (r) {
            var rid = r.EmployeeID || r.employeeID;
            var ridNum = parseInt(rid, 10);
            return {
                id: !isNaN(ridNum) ? ridNum : rid,
                name: r.EmployeeName || r.employeeName || '',
                role: r.RoleDescription || r.roleDescription || '',
                dept: r.Department || r.department || '',
                businessGroup: r.BusinessGroup || r.businessGroup || '',
                currentAlloc: r.CurrentAllocPct || r.currentAllocPct || 0,
                availPct: r.AvailableAllocPct || r.availableAllocPct || 0,
                maxAlloc: r.MaxAllocationPct || r.maxAllocationPct || 0,
                freePct: r.FreePercentage || r.freePercentage || (r.AvailableAllocPct || r.availableAllocPct || 0),
                matchType: r.MatchType || r.matchType || ''
            };
        });
    }

    // Added by Vyankat B. on 8th April 2026 - Pagination helpers for resource list table.
    function _readResourceRowTotalCount(rawRows) {
        var rows = rawRows || [];
        if (!rows.length) return 0;
        var first = rows[0] || {};
        var rowTotal = parseInt(first.totalRecords || first.TotalRecords || 0, 10);
        if (!isNaN(rowTotal) && rowTotal > 0) return rowTotal;
        return rows.length;
    }

    function _parseResourceListApiResponse(response) {
        var root = response || {};
        if (root.data && !Array.isArray(root.data) && (root.data.data || root.data.pagination || root.data.Pagination)) {
            root = root.data;
        }
        var raw = Array.isArray(root.data) ? root.data : (Array.isArray(root) ? root : []);
        var pg = root.pagination || root.Pagination || null;
        if (!pg && raw.length > 0) {
            var inferredTotal = _readResourceRowTotalCount(raw);
            pg = {
                currentPage: resourcePageNumber,
                pageSize: resourcePageSize,
                totalRecords: inferredTotal,
                totalPages: resourcePageSize > 0 ? Math.ceil(inferredTotal / resourcePageSize) : 0
            };
        }
        return { raw: raw, pagination: pg };
    }

    function setResourcePaginationStateFromApi(rawRows, pagination) {
        var rows = rawRows || [];
        var rowTotal = _readResourceRowTotalCount(rows);
        var nameSearch = _hasResourceNameSearchFilter();

        if (pagination) {
            resourcePageNumber = parseInt(pagination.currentPage || pagination.CurrentPage || resourcePageNumber, 10) || 1;
            if (!nameSearch) {
                resourcePageSize = parseInt(pagination.pageSize || pagination.PageSize || resourcePageSize, 10) || 5;
            }
            var pgTotal = parseInt(pagination.totalRecords || pagination.TotalRecords || 0, 10);
            resourceTotalRecords = (pgTotal > 0) ? pgTotal : rowTotal;
            resourceTotalPages = parseInt(pagination.totalPages || pagination.TotalPages || 0, 10) || 0;
            if (resourceTotalPages <= 0 && resourceTotalRecords > 0 && resourcePageSize > 0) {
                resourceTotalPages = Math.ceil(resourceTotalRecords / resourcePageSize);
            }
            return;
        }

        resourceTotalRecords = rowTotal;
        resourceTotalPages = resourcePageSize > 0 ? Math.ceil(resourceTotalRecords / resourcePageSize) : 0;
    }

    function updateResourcePaginationUI() {
        var start = 0;
        var end = 0;
        if (resourceTotalRecords > 0) {
            start = ((resourcePageNumber - 1) * resourcePageSize) + 1;
            end = Math.min(resourcePageNumber * resourcePageSize, resourceTotalRecords);
        }
        $('#resourcePagerTotal').text('Total Records: ' + resourceTotalRecords);

        var canPrev = resourcePageNumber > 1;
        var canNext = resourceTotalPages > 0 && resourcePageNumber < resourceTotalPages;
        $('#btnResourcePrev').prop('disabled', !canPrev);
        $('#btnResourceNext').prop('disabled', !canNext);
    }

    function onResourcePrevPage() {
        if (resourcePageNumber <= 1 || !activeGroupId) return;
        resourcePageNumber--;
        if (getMatchType() === 'exact') LoadExactMatchResources(activeGroupId);
        else LoadProbableMatchResources(activeGroupId);
    }

    function onResourceNextPage() {
        if (!activeGroupId) return;
        if (resourceTotalPages > 0 && resourcePageNumber >= resourceTotalPages) return;
        resourcePageNumber++;
        if (getMatchType() === 'exact') LoadExactMatchResources(activeGroupId);
        else LoadProbableMatchResources(activeGroupId);
    }
    // End of Added by Vyankat B. on 8th April 2026 - Pagination helpers for resource list table.

    /* ═══════════════════════════════════════════════════════════════════════
       MATCH TYPE RADIO
       ═══════════════════════════════════════════════════════════════════════ */
    function onMatchTypeChange() {
        syncMatchTypeUI();
        /* Re-fetch resources for active group using the newly selected mode */
        if (activeGroupId) {
            _resetOffcanvasPendingSelectionKeepConfirmed(activeGroupId);
            resourcePageNumber = 1;
            var mode = getMatchType();
            if (mode === 'exact') {
                LoadExactMatchResources(activeGroupId);
            } else {
                LoadProbableMatchResources(activeGroupId);
            }
        }
    }

    function getMatchType() {
        return document.getElementById('rdoExact').checked ? 'exact' : 'probable';
    }

    function syncMatchTypeUI() {
        var isExact = document.getElementById('rdoExact').checked;
        var $lblExact = $('#lbl-exact');
        var $lblProbable = $('#lbl-probable');
        $lblExact.removeClass('active-exact active-probable');
        $lblProbable.removeClass('active-exact active-probable');
        if (isExact) {
            $lblExact.addClass('active-exact');
        } else {
            $lblProbable.addClass('active-probable');
        }

        /* Modified by Nikhil Mane on 05-May-2026 — Toggle Skill vs Employee Role dropdown.
           Exact Match uses Skill; Probable Match shows Employee Role (tmpl-employee-role).
           The hidden field is reset when switching so stale values don't bleed across modes. */
        if (isExact) {
            $('#divOcSkill').show();
            $('#divOcEmployeeRole').hide();
            $('#ocEmployeeRole').val('').selectpicker('refresh');
            setSearchAccordionVisible(false);
        } else {
            $('#divOcSkill').hide();
            $('#divOcEmployeeRole').show();
            $('#ocSkill').val('').selectpicker('refresh');
            setSearchAccordionVisible(true);
        }
        /* End of Modified by Nikhil Mane on 05-May-2026 */
        applyPageSkillToggleToOffcanvas();
    }

    /* ═══════════════════════════════════════════════════════════════════════
       OPEN SELECT RESOURCE (fires when row button is clicked)
       ═══════════════════════════════════════════════════════════════════════ */
    function openSelectResource(gid) {
        /* ── Access guard — Added by Vyankat B. on 13-Apr-2026 ── */
        if (!addAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionSelectResources);
            return;
        }
        _openSelectResourceCore(gid, false);
    }

    function _shouldConfirmProjectResourceExceed(gid) {
        var rowCount = _sumBulkAllocRgResourceCounts();
        var projectCount = parseInt(_projectNoOfResource, 10) || parseInt(_projectNoOfResources, 10) || 0;
        return projectCount > 0 && rowCount > projectCount;
    }

    function _openSelectResourceCore(gid, skipExceedConfirm, skipSkillConfirm) {
        // Added by Nikhil Mane on 05-May-2026 – Load Skill dropdown on first Add button click.
        // The IIFE was previously in $(document).ready() but fired too early (before the offcanvas
        // opens) and used the wrong controller (PM_BulkResourceReq) with RequestID:0 which always
        // returned an empty list. Moved here so it runs in the correct context; the
        // _skillDropdownLoaded guard ensures the AJAX call is made only once.
        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        if (!_skillDropdownLoaded) {
            var skillParam = JSON.stringify({ ProjectID: SessionProjectID, RequestID: 0 });
            AJAXCallWithResult(
                'api/PM_BulkResourceReq/GetRequestSkillCombo',
                skillParam, true,
                function (response) {
                    var list = (response && response.data) ? response.data : [];
                    var $sel = $('#ocSkill');
                    $sel.empty().append('<option value="0">Select Skill</option>');
                    list.forEach(function (item) {
                        if (item.toolID && $.trim(item.description).length > 0) {
                            $sel.append(new Option(item.description, item.toolID));
                        }
                    });
                    $sel.selectpicker('refresh');
                    _skillDropdownLoaded = true;
                },
                function () { console.warn('Skill dropdown load failed'); }
            );
        }
        /* End of Modified by Nikhil Mane on 08-May-2026 */
        // End of Added by Nikhil Mane on 05-May-2026
        /* Added By Dipali V On 26th May - Require complete row before opening Select Resources offcanvas */
        if (!isGroupValid(gid)) {
            validateAllGroupsForAction('Select Resource', gid);
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_rowLabel(gid) + RES.A_SelectResourcesRow);
            return;
        }
        /* Added By Dipali V On 27th May - when Search By Skill is ON, prompt if no role skill is set. */
        if (_pageSkillFilterEnabled) {
            if (hasDuplicateRoleSkills(gid, true)) return;
            var roleSkillFilters = getBulkAllocRoleSkillFilters(gid);
            if (roleSkillFilters.length === 0) {
                if (!skipSkillConfirm && !_shouldSkipRoleSkillFilterForGroup(gid)) {
                    showBulkAllocSkillNotSelectedConfirm(gid, skipExceedConfirm);
                    return;
                }
            } else {
                delete _skipRoleSkillFilterByGroup[String(gid)];
                /* Auto-sync offcanvas Skill only for single-skill exact match.
                   For multi-skill, filtering is driven by skillFiltersJson. */
                if ($('#ocSkill').length && roleSkillFilters.length === 1) {
                    $('#ocSkill').val(String(roleSkillFilters[0].skillId)).selectpicker('refresh');
                }
            }
        }
        if (!validateAllGroupsForAction('Select Resource', gid)) return;
        if (!skipExceedConfirm && _shouldConfirmProjectResourceExceed(gid)) {
            showBulkAllocExceedProjectResourceConfirm(gid);
            return;
        }
        activeGroupId = gid;
        resourceByIdCache = {};

        // Added by Vyankat B. on 8th April 2026 - Restore draft selection for this group if available.
        if (draftSelectedByGroup[gid] && Array.isArray(draftSelectedByGroup[gid])) {
            tempSelected = new Set(draftSelectedByGroup[gid].map(function (x) { return String(x); }));
            selectedResourceMap = Object.assign({}, draftSelectedObjByGroup[gid] || {});
        } else {
            tempSelected = new Set();
            selectedResourceMap = {};
        }
        // End of Added by Vyankat B. on 8th April 2026 - Restore draft selection for this group if available.

        /* Re-check already-selected resources for this group */
        getGroupSelectedIds(gid).forEach(function (id) { tempSelected.add(String(id)); });
        // Added by Nikhil Mane on 05-May-2026 — capture baseline checks at open time.
        // Count validation in confirmSelection() will use only IDs checked beyond this snapshot.
        offcanvasOpenSelectedByGroup[gid] = Array.from(tempSelected);

        syncDefaultSelectionToOffcanvas(gid);
        if (typeof _syncBaDefaultApproverForGroup === 'function') _syncBaDefaultApproverAllGroups();
        /* Added By Dipali V On 17th Jun 2026 — keep offcanvas Default Approver checked if list/main row is checked, even when disabled */
        if ($('#ocIsDefaultApprover').length) {
            var _ocApproverChecked = !!($('#rg-approver-' + gid).prop('checked') || $('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]:checked').length);
            $('#ocIsDefaultApprover').prop('checked', _ocApproverChecked);
        }
        /* Added By Dipali V On 17th Jun 2026 — restore persisted Is Product Owner when reopening offcanvas */
        if ($('#ocIsProductOwner').length && _isAgileProjectForProductOwner()) {
            $('#ocIsProductOwner').prop('checked', !!_offcanvasLastDefaults.isProductOwner);
        }
        _autoPopulateOffcanvasWorkHours(gid);

        /* Default mode on open: always Exact Match */
        document.getElementById('rdoExact').checked = true;
        document.getElementById('rdoProbable').checked = false;
        syncMatchTypeUI();

        /* Clear search box and filter dropdowns */
        $('#resourceSearch').val('');
        // Added by Nikhil Mane on 10-04-2026 – Reset all search-filter dropdowns so
        // stale values from a previous group open do not carry over to the new group.
        $('#ocDesignation').val('0').selectpicker('refresh');
        $('#ocDepartment').val('0').selectpicker('refresh');
        $('#ocBusinessGroup').val('0').selectpicker('refresh');
        $('#ocOrgUnit').val('0').selectpicker('refresh');
        $('#ocSkill').val('0').selectpicker('refresh');
        // End of Added by Nikhil Mane on 10-04-2026
        // Added by Nikhil Mane on 15-04-2026 – Clear any leftover validation highlights from a previous open.
        $('#selectResourceOffcanvas .oc-val-error').removeClass('oc-val-error');
        $('#selectResourceOffcanvas .bootstrap-select.oc-val-error').removeClass('oc-val-error');
        // End of Added by Nikhil Mane on 15-04-2026
        // Added by Vyankat B. on 8th April 2026 - Reset pager on each fresh resource offcanvas open.
        resourcePageNumber = 1;
        resourceTotalRecords = 0;
        resourceTotalPages = 0;
        updateResourcePaginationUI();
        // End of Added by Vyankat B. on 8th April 2026 - Reset pager on each fresh resource offcanvas open.

        /* Close any child panels and ensure parent is not blurred before opening */
        _closeChildOffcanvasAndRestoreParent();

        /* Standard Bootstrap backdrop (same as PM_ToolsSkills.aspx); parent blur when child opens */
        var selectOcEl = document.getElementById('selectResourceOffcanvas');
        var selectOcInst = bootstrap.Offcanvas.getInstance(selectOcEl);
        if (selectOcInst) selectOcInst.dispose();
        bootstrap.Offcanvas.getOrCreateInstance(
            selectOcEl,
            { backdrop: true, scroll: true, keyboard: true }
        ).show();
        if (typeof _syncBaPendingAllocNote === 'function') _syncBaPendingAllocNote();
        /* Added By Dipali V On 26th May - Search collapsed; Default Selection expanded on each open */
        _setOffcanvasAccordionDefaultState();
        /* Added By Dipali V On 27th May - enforce Probable=search visible / Exact=search hidden after default accordion state. */
        syncMatchTypeUI();

        // Added by Nikhil Mane on 09-04-2026 – Populate "Reporting To" from GetdefApprovers API.
        LoadDefaultApprovers(SessionProjectID);
        // End of Added by Nikhil Mane on 09-04-2026

        if (getMatchType() === 'exact') {
            LoadExactMatchResources(gid);
        } else {
            LoadProbableMatchResources(gid);
        }
    }

    function getGroupSelectedIds(gid) {
        var ids = [];
        $('#sel-res-body-' + gid + ' tr').each(function () {
            var id = parseInt($(this).attr('data-res-id'), 10) || parseInt($(this).data('res-id'), 10) || 0;
            if (id > 0) ids.push(id);
        });
        return ids;
    }

    /* Keep only resources already added to the list view; drop offcanvas draft picks when search context changes. */
    function _resetOffcanvasPendingSelectionKeepConfirmed(gid) {
        if (!gid) return;
        var confirmedSet = new Set(getGroupSelectedIds(gid).map(function (id) { return String(id); }));
        var newTemp = new Set();
        var newMap = {};
        confirmedSet.forEach(function (id) {
            newTemp.add(id);
            if (selectedResourceMap[id]) {
                newMap[id] = selectedResourceMap[id];
            } else if (draftSelectedObjByGroup[gid] && draftSelectedObjByGroup[gid][id]) {
                newMap[id] = draftSelectedObjByGroup[gid][id];
            } else if (resourceByIdCache[id]) {
                newMap[id] = resourceByIdCache[id];
            }
        });
        tempSelected = newTemp;
        selectedResourceMap = newMap;
        draftSelectedByGroup[gid] = Array.from(tempSelected);
        draftSelectedObjByGroup[gid] = Object.assign({}, selectedResourceMap);
        offcanvasOpenSelectedByGroup[gid] = Array.from(tempSelected);
    }

    /* Added By Dipali V On 27th May - Set Skill validation helpers */
    function getBulkAllocSelectedSkillIds(gid) {
        var ids = [];
        $('#bulk-skill-tbody-' + gid + ' select[id^="cboSkillMaster"]').each(function () {
            var id = parseInt($(this).val(), 10) || 0;
            if (id > 0) ids.push(id);
        });
        return ids;
    }

    function hasDuplicateRoleSkills(gid, showAlert) {
        var seen = {};
        var duplicate = false;
        var firstDupSelect = null;
        $('#bulk-skill-tbody-' + gid + ' .bootstrap-select').removeClass('val-error');
        $('#bulk-skill-tbody-' + gid + ' select[id^="cboSkillMaster"]').each(function () {
            var $sel = $(this);
            var id = parseInt($sel.val(), 10) || 0;
            if (!id) return;
            if (seen[id]) {
                duplicate = true;
                $sel.closest('.bootstrap-select').addClass('val-error');
                if (!firstDupSelect) firstDupSelect = this;
            } else {
                seen[id] = true;
            }
        });
        if (duplicate && showAlert) {
            $('#bulk-skill-section-' + gid).addClass('open');
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_DuplicateSkill);
            if (firstDupSelect) _ensureValidationControlVisibleAndFocus(firstDupSelect);
        }
        return duplicate;
    }

    /* Added By Dipali V On 27th May - Collect role-skill filters (Skill/Exp/Proficiency/Core). */
    function getBulkAllocRoleSkillFilters(gid) {
        var rows = [];
        $('#bulk-skill-tbody-' + gid + ' tr').each(function () {
            var trId = this.id || '';
            var parts = trId.split('_');
            var counter = parts[parts.length - 1];
            var skillId = parseInt($('#cboSkillMaster' + counter).val(), 10) || 0;
            if (!skillId) return;
            var experienceYear = parseInt($('#cboMonth' + counter).val(), 10) || 0;   // template maps years here
            var experienceMonth = parseInt($('#cboYear' + counter).val(), 10) || 0;   // template maps months here
            var proficiency = parseInt($('#cboParameters' + counter).val(), 10) || 0;
            var coreCompetency = !!document.getElementById('chkCore' + counter) && document.getElementById('chkCore' + counter).checked;
            rows.push({
                skillId: skillId,
                experienceYear: experienceYear,
                experienceMonth: experienceMonth,
                yearsOfExperience: experienceYear,
                monthsOfExperience: experienceMonth,
                proficiency: proficiency,
                coreCompetency: coreCompetency,
                hasCoreCompetency: coreCompetency
            });
        });
        return rows;
    }

    /* Added By Dipali V On 27th May - Prevent duplicate resource across role groups */
    function isResourceSelectedInOtherGroup(gid, resId) {
        var found = false;
        $('.resource-group').each(function () {
            var otherGid = String($(this).data('group'));
            if (otherGid === String(gid)) return;
            if ($('#sel-res-body-' + otherGid + ' tr[data-res-id="' + String(resId) + '"]').length > 0) {
                found = true;
            }
        });
        return found;
    }

    /* Added by dipali v on 18th Jun 2026 for purpose — clear stale list/offcanvas picks when Project Role changes */
    function _resetBaGroupSelectionForRoleChange(gid) {
        var $body = $('#sel-res-body-' + gid);
        $body.find('.selectpicker').each(function () { try { $(this).selectpicker('destroy'); } catch (e) { /* ignore */ } });
        $body.empty();
        delete draftSelectedByGroup[gid];
        delete draftSelectedObjByGroup[gid];
        delete offcanvasOpenSelectedByGroup[gid];
        if (String(activeGroupId) === String(gid)) {
            tempSelected = new Set();
            selectedResourceMap = {};
        }
        $('#group-' + gid).removeAttr('data-has-selection');
        unlockProjectRoleForGroup(gid);
        updateSelectedResourcesBadge(gid);
        if (typeof _syncBaPendingAllocNote === 'function') _syncBaPendingAllocNote();
    }

    /* ═══════════════════════════════════════════════════════════════════════
       BUILD RESOURCE TABLE
       ═══════════════════════════════════════════════════════════════════════ */
    function buildResourceTable(list) {
        var $body = $('#resourceTableBody').empty();
        if (!list || list.length === 0) {
            $body.append('<tr><td colspan="7" class="text-center text-muted py-3">There are no records to view.</td></tr>');
            return;
        }
        var mode = getMatchType();
        list.forEach(function (r) {
            var key = String(r.id);
            var checked = tempSelected.has(key) ? 'checked' : '';
            var availPct = r.availPct != null ? parseFloat(r.availPct).toFixed(1) : '—';
            var freePct = r.freePct != null ? parseFloat(r.freePct).toFixed(1) : '—';
            var badgeCls = (mode === 'exact') ? 'pct-badge-exact' : 'pct-badge-probable';

            $body.append(
                '<tr data-res-id="' + r.id + '" data-avail-pct="' + escHtml(String(r.availPct != null ? r.availPct : '')) + '">' +
                '<td class="fw-semibold">' + escHtml(r.name) + '</td>' +
                '<td>' + escHtml(r.role) + '</td>' +
                '<td>' +
                '<div class="availability-cell">' +
                '<div class="bar"><span class="bar-fill" data-pct="' + availPct + '"></span></div>' +
                '<span>' + availPct + '%</span>' +
                '</div>' +
                '</td>' +
                '<td><a href="#" class="blue-link" onclick="openResourceLoading(' + r.id + ');return false;"><i class="far fa-chart-bar me-1"  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom" title="Resource Loading"></i>View</a></td>' +
                '<td><a href="#" class="blue-link" onclick="openResourceDetails(' + r.id + ');return false;"><i class="far fa-eye" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom" title="View Details"></i></a></td>' +
                '<td><input type="checkbox" class="form-check-input res-chk" data-res-id="' + r.id + '" ' + checked + ' onchange="toggleResource(this)"/></td>' +
                '</tr>'
            );
        });
        $body.find('.bar-fill').each(function () {
            var pct = parseFloat($(this).data('pct')) || 0;
            $(this).css('width', Math.min(pct, 100) + '%');
        });
    }

    /* Added By Dipali V On 17th Jun 2026 — block Select Resource / Allocate when Availability (%) is zero or negative */
    function _isResourceAvailabilityNegative(res) {
        if (!res) return false;
        var n = parseFloat(res.availPct != null ? res.availPct : res.freePct);
        return !isNaN(n) && n <= 0;
    }

    function _bulkAllocNegativeAvailabilityMsg(names) {
        var tpl = (RES.A_ResourceAvailabilityNegative || '').trim();
        if (tpl && /\{0\}/.test(tpl)) return _resFmt(tpl, names);
        //return (names || 'Resource') + ' cannot be selected or allocated because Availability (%) is 0 or less.';
        return (names || 'Resource') + ' Available % are 0 or less.';
    }

    function _validateBulkAllocSelectedAvailability(resources) {
        var bad = (resources || []).filter(_isResourceAvailabilityNegative);
        if (!bad.length) return true;
        alertify.set('notifier', 'position', 'top-right');
        alertify.error(_bulkAllocNegativeAvailabilityMsg(bad.map(function (r) { return r.name || ('ID ' + r.id); }).join(', ')));
        return false;
    }

    function _collectConfirmedAllocResources() {
        var list = [], seen = {};
        $('.resource-group').each(function () {
            var gid = $(this).data('group');
            $('#sel-res-body-' + gid + ' tr').each(function () {
                var resId = String($(this).data('res-id') || '');
                if (!resId || seen[resId]) return;
                seen[resId] = true;
                list.push(selectedResourceMap[resId] || resourceByIdCache[resId] || {
                    id: resId, name: $(this).find('td:first strong').text().trim(), availPct: $(this).data('avail-pct')
                });
            });
        });
        return list;
    }

    function toggleResource(elOrId) {
        var key = '';
        var isChecked = false;

        if (elOrId && typeof elOrId === 'object' && elOrId.getAttribute) {
            key = String(elOrId.getAttribute('data-res-id') || '');
            isChecked = !!elOrId.checked;
        } else {
            key = String(elOrId);
            isChecked = !tempSelected.has(key);
        }

        if (!key) return;

        if (isChecked) {
            var pickObj = (RESOURCES || []).find(function (r) { return String(r.id) === key; });
            if (_isResourceAvailabilityNegative(pickObj)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(_bulkAllocNegativeAvailabilityMsg(pickObj.name || ('ID ' + key)));
                if (elOrId && elOrId.checked !== undefined) elOrId.checked = false;
                $('input.res-chk[data-res-id="' + key.replace(/"/g, '\\"') + '"]').prop('checked', false);
                return;
            }
            if (activeGroupId != null) {
                var limits = _getResourceSelectionLimits(activeGroupId);
                var nextCount = tempSelected.has(key) ? tempSelected.size : (tempSelected.size + 1);
                if (limits.maxPerRole > 0 && nextCount > limits.maxAllowed) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(_rowLabel(activeGroupId) + ' ' + _resFmt(RES.A_MaxRowsAllowed, limits.maxAllowed));
                    if (elOrId && elOrId.checked !== undefined) elOrId.checked = false;
                    $('input.res-chk[data-res-id="' + key.replace(/"/g, '\\"') + '"]').prop('checked', false);
                    return;
                }
                if (_isValiNoOfResourceForBulkEnabled() && nextCount > limits.minRequired) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(_rowLabel(activeGroupId) + _resFmt(RES.A_SelectedCountOnly, nextCount, limits.minRequired));
                    if (elOrId && elOrId.checked !== undefined) elOrId.checked = false;
                    return;
                }
            }
            tempSelected.add(key);
            var selectedObj = (RESOURCES || []).find(function (r) { return String(r.id) === key; });
            if (selectedObj) selectedResourceMap[key] = selectedObj;
        } else {
            tempSelected.delete(key);
            delete selectedResourceMap[key];
        }

        // Added by Vyankat B. on 8th April 2026 - Keep group-level draft in sync across offcanvas reopen.
        if (activeGroupId != null) {
            draftSelectedByGroup[activeGroupId] = Array.from(tempSelected);
            draftSelectedObjByGroup[activeGroupId] = Object.assign({}, selectedResourceMap);
        }
        // End of Added by Vyankat B. on 8th April 2026 - Keep group-level draft in sync across offcanvas reopen.

        $('input.res-chk[data-res-id="' + key.replace(/"/g, '\\"') + '"]').prop('checked', tempSelected.has(key));
        if (document.getElementById('ocWorkHM')) _validateOcWorkHoursLimit();
    }

    /* ═══════════════════════════════════════════════════════════════════════
       OFFCANVAS FIELD VALIDATION
       Validates: Project Role, No of Resources, Planned Start Date,
                  Planned End Date, % Allocation, Reporting To,
                  Resource Status, Work (HH:MM)
       Called from confirmSelection() (Add Selected Resources button).
       Returns true if all fields are valid, false otherwise.
       Added by Nikhil Mane on 15-04-2026
    ═══════════════════════════════════════════════════════════════════════ */
    function validateOffcanvasFields() {
        var errors = [];
        var firstInvalidEl = null;

        /* Helper: mark / unmark a plain input */
        function _ocMarkInput(el, isErr) {
            if (!el) return;
            if (isErr) el.classList.add('oc-val-error');
            else       el.classList.remove('oc-val-error');
        }

        /* Helper: mark / unmark a bootstrap-select wrapper */
        function _ocMarkSelect(selectId, isErr) {
            var $bs = $('#' + selectId).closest('.bootstrap-select');
            if ($bs.length) {
                if (isErr) $bs.addClass('oc-val-error');
                else       $bs.removeClass('oc-val-error');
            } else {
                /* fallback for plain select */
                var el = document.getElementById(selectId);
                _ocMarkInput(el, isErr);
            }
        }

        /* 1. Project Role — auto-synced from the main table row (read-only in offcanvas); skip validation */
        _ocMarkSelect('ocProjectRole', false);

        /* 2. No of Resources — Modified by Nikhil Mane on 15-04-2026: readonly/auto-updated, skip validation */
        var ocCount = document.getElementById('ocNoOfResources');
        if (ocCount) ocCount.classList.remove('oc-val-error');

        /* 3. Planned Start Date */
        var ocStart = document.getElementById('ocStartDate');
        var ocStartVal = ocStart ? ocStart.value.trim() : '';
        if (!ocStartVal) {
            errors.push(RES.A_PlannedStartNotBlank);
            _ocMarkInput(ocStart, true);
            if (!firstInvalidEl) firstInvalidEl = ocStart;
        } else {
            _ocMarkInput(ocStart, false);
        }

        /* 4. Planned End Date */
        var ocEnd = document.getElementById('ocEndDate');
        var ocEndVal = ocEnd ? ocEnd.value.trim() : '';
        if (!ocEndVal) {
            errors.push(RES.A_PlannedEndNotBlank);
            _ocMarkInput(ocEnd, true);
            if (!firstInvalidEl) firstInvalidEl = ocEnd;
        } else {
            _ocMarkInput(ocEnd, false);
        }

        /* 5. % Allocation */
        var ocAlloc = document.getElementById('ocAllocation');
        var ocAllocVal = ocAlloc ? ocAlloc.value.trim() : '';
        if (!ocAllocVal) {
            errors.push(RES.A_AllocationPctBlank);
            _ocMarkInput(ocAlloc, true);
            if (!firstInvalidEl) firstInvalidEl = ocAlloc;
        } else {
            _ocMarkInput(ocAlloc, false);
        }

        /* 6. Reporting To */
        var ocRptVal = _ensureDefaultReportingToSelection();
        if (!ocRptVal || ocRptVal === '' || ocRptVal === '0') {
            errors.push(RES.A_RepToNotBlank);
            _ocMarkSelect('ocReportingTo', true);
            if (!firstInvalidEl) firstInvalidEl = document.getElementById('ocReportingTo');
        } else {
            _ocMarkSelect('ocReportingTo', false);
        }

        /* 7. Resource Status */
        var ocStatusVal = $('#ocResourceStatus').val();
        if (!ocStatusVal || ocStatusVal === '' || ocStatusVal === '0') {
            errors.push(RES.A_ResStNotBlank);
            _ocMarkSelect('ocResourceStatus', true);
            if (!firstInvalidEl) firstInvalidEl = document.getElementById('ocResourceStatus');
        } else {
            _ocMarkSelect('ocResourceStatus', false);
        }

        /* 8. Work (HH:MM) */
        var ocWork = document.getElementById('ocWorkHM');
        var ocWorkVal = ocWork ? ocWork.value.trim() : '';
        if (!ocWorkVal) {
            errors.push(RES.A_WorkNotBlank);
            _ocMarkInput(ocWork, true);
            _setOcWorkValidation(RES.A_WorkNotBlank);
            if (!firstInvalidEl) firstInvalidEl = ocWork;
        } else {
            var ocWorkHours = _hhmmToDecimal(ocWorkVal);
            if (ocWorkHours == null) {
                errors.push(RES.A_WorkHHMMInvalid);
                _ocMarkInput(ocWork, true);
                _setOcWorkValidation(RES.A_WorkHHMMInvalid);
                if (!firstInvalidEl) firstInvalidEl = ocWork;
            } else if (_wouldExceedProjectWorkHoursCapForOffcanvasBatch(ocWorkHours, activeGroupId)) {
                errors.push(_projectWorkHoursExceededMessage());
                _ocMarkInput(ocWork, true);
                _setOcWorkValidation(_projectWorkHoursExceededMessage());
                if (!firstInvalidEl) firstInvalidEl = ocWork;
            } else {
                _ocMarkInput(ocWork, false);
                _setOcWorkValidation('');
            }
        }

        if (errors.length > 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(errors[0]);
            if (firstInvalidEl) _ensureValidationControlVisibleAndFocus(firstInvalidEl);
            return false;
        }
        return true;
    }
    /* End of Added by Nikhil Mane on 15-04-2026 */

    /* ═══════════════════════════════════════════════════════════════════════
       VALIDATE PER-RESOURCE SUB-TABLE ROWS
       Validates Reporting To, Resource Status, Work (HH:MM) for every
       resource row already added to a group.
       Called from validateAllGroupsForAction() for 'Allocate' and 'Add More'.
       Added by Nikhil Mane on 15-04-2026
    ═══════════════════════════════════════════════════════════════════════ */
    function validateSelectedResourceRows() {
        var errors = [];
        var firstInvalidEl = null;

        function _markResInput(el, isErr) {
            if (!el) return;
            if (isErr) el.classList.add('oc-val-error');
            else       el.classList.remove('oc-val-error');
        }
        function _markResSelect(selectId, isErr) {
            var $bs = $('#' + selectId).closest('.bootstrap-select');
            if ($bs.length) {
                if (isErr) $bs.addClass('oc-val-error');
                else       $bs.removeClass('oc-val-error');
            } else {
                var el = document.getElementById(selectId);
                _markResInput(el, isErr);
            }
        }
        function _setResWorkValidation(workEl, uid, message) {
            if (!workEl || !uid) return;
            _setInputInlineValidation(workEl, message, 'txtWorkValidationMsg_' + uid);
        }

        $('.resource-group').each(function () {
            var gid = $(this).data('group');
            var rowNum = _rowLabel(gid);

            $('#sel-res-body-' + gid + ' tr').each(function () {
                var empId = $(this).data('res-id');
                if (!empId) return;
                var uid = gid + '_' + empId;
                var resName = $(this).find('td:first strong').text() || ('Resource #' + empId);

                /* Reporting To */
                var rptId  = 'cboReportingTo_res_' + uid;
                var $rptSel = $('#' + rptId);
                var rptVal = $rptSel.val();
                if ((!rptVal || rptVal === '0') && $(this).attr('data-reporting-to')) {
                    rptVal = $(this).attr('data-reporting-to');
                    if ($rptSel.length) _syncReportingToOptionToSelect($rptSel, rptVal, '');
                    _setBaReportingToSelectValue($rptSel, rptVal);
                }
                if (!rptVal || rptVal === '' || rptVal === '0') {
                    errors.push(rowNum + _resFmt(RES.A_ResourceRowValidationPrefix, resName) + RES.A_RepToNotBlank);
                    _markResSelect(rptId, true);
                    if (!firstInvalidEl) firstInvalidEl = document.getElementById(rptId);
                } else {
                    _markResSelect(rptId, false);
                }

                /* Resource Status */
                var statusId  = 'cboResStatus_res_' + uid;
                var statusVal = $('#' + statusId).val();
                if (!statusVal || statusVal === '') {
                    errors.push(rowNum + _resFmt(RES.A_ResourceRowValidationPrefix, resName) + RES.A_ResStNotBlank);
                    _markResSelect(statusId, true);
                    if (!firstInvalidEl) firstInvalidEl = document.getElementById(statusId);
                } else {
                    _markResSelect(statusId, false);
                }

                /* Work (HH:MM) */
               // debugger;
                var workEl  = document.getElementById('txtWork_res_' + uid);
                var workVal = workEl ? workEl.value.trim() : '';
                if (!workVal) {
                    errors.push(rowNum + _resFmt(RES.A_ResourceRowValidationPrefix, resName) + RES.A_WorkNotBlank);
                    _markResInput(workEl, true);
                    _setResWorkValidation(workEl, uid, RES.A_WorkNotBlank);
                    if (!firstInvalidEl) firstInvalidEl = workEl;
                } else {
                    var rowWorkHours = _hhmmToDecimal(workVal);
                    if (rowWorkHours == null) {
                        errors.push(rowNum + _resFmt(RES.A_ResourceRowValidationPrefix, resName) + RES.A_WorkHHMMInvalid);
                        _markResInput(workEl, true);
                        _setResWorkValidation(workEl, uid, RES.A_WorkHHMMInvalid);
                        if (!firstInvalidEl) firstInvalidEl = workEl;
                    } else if (_wouldExceedProjectWorkHoursCap(rowWorkHours, { additionalHoursFromOthers: _sumSelectedResourceWorkHours(uid) })) {
                        errors.push(rowNum + _resFmt(RES.A_ResourceRowValidationPrefix, resName) + _projectWorkHoursExceededMessage());
                        _markResInput(workEl, true);
                        _setResWorkValidation(workEl, uid, _projectWorkHoursExceededMessage());
                        if (!firstInvalidEl) firstInvalidEl = workEl;
                    } else {
                        _markResInput(workEl, false);
                        _setResWorkValidation(workEl, uid, '');
                    }
                }
            });
        });

        var batchWorkCheck = _validateBulkAllocationWorkHoursTotal(null);
        if (batchWorkCheck.ok === false) {
            errors.push(batchWorkCheck.message);
            if (!firstInvalidEl) {
                firstInvalidEl = document.querySelector('tbody[id^="sel-res-body-"] input[id^="txtWork_res_"]');
            }
        }

        if (errors.length > 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(errors[0]);
            if (firstInvalidEl) _ensureValidationControlVisibleAndFocus(firstInvalidEl);
            return false;
        }
        return true;
    }
    /* End of Added by Nikhil Mane on 15-04-2026 */

    /* ═══════════════════════════════════════════════════════════════════════
       CONFIRM SELECTION  (Add Selected Resources)
       ═══════════════════════════════════════════════════════════════════════ */
    function confirmSelection(keepOffcanvasOpen, confirmOpts) {
        _confirmSelectionCore(keepOffcanvasOpen, confirmOpts || null);
    }

    function _confirmSelectionCore(keepOffcanvasOpen, confirmOpts) {
        confirmOpts = confirmOpts || {};
        var skipProbableSkillCheck = !!confirmOpts.skipProbableSkillCheck;
        var userAckedSkillMismatch = !!confirmOpts.userAckedSkillMismatch;
        _confirmSelectionSucceeded = false;
        var gid = activeGroupId;
        // Added by Nikhil Mane on 15-04-2026 — validate required offcanvas fields first
        if (!validateOffcanvasFields()) {
            if (gid) _syncBaRoleUnallocatedHighlight(gid);
            return;
        }
        // End of Added by Nikhil Mane on 15-04-2026
        // Modified by Nikhil Mane on 05-May-2026 — capture already-added rows BEFORE rebuilding
        // so count validation can compare only current offcanvas selection (new config) vs No of Resources.
        var existingIdsBeforeConfirm = getGroupSelectedIds(gid).map(function (id) { return String(id); });
        var existingIdSet = new Set(existingIdsBeforeConfirm);
        // Modified by Nikhil Mane on 05-May-2026 — preserve existing per-resource row values
        // so adding a new configuration does not overwrite previously added rows.
        var existingRowStateByResId = {};
        $('#sel-res-body-' + gid + ' tr').each(function () {
            var rid = String($(this).data('res-id') || '');
            if (!rid) return;
            var uid = gid + '_' + rid;
            existingRowStateByResId[rid] = {
                roleText: $(this).find('td:eq(1)').text().trim(),
                startVal: $(this).find('td:eq(2)').text().trim(),
                endVal: $(this).find('td:eq(3)').text().trim(),
                allocVal: $('#txtAlloc_res_' + uid).val() || '',
                mainRoleId: parseInt($(this).attr('data-main-role-id'), 10) || 0,
                startISO: $(this).attr('data-start-iso') || null,
                endISO: $(this).attr('data-end-iso') || null,
                allocPct: parseFloat($(this).attr('data-alloc-pct')) || 0,
                reportingTo: $('#cboReportingTo_res_' + uid).val() || '',
                resourceStatus: $('#cboResStatus_res_' + uid).val() || '',
                workHM: $('#txtWork_res_' + uid).val() || '',
                responsibilities: $('#txtResponsibility_res_' + uid).val() || '',
                isBillable: !!(document.getElementById('chkBillable_res_' + uid) && document.getElementById('chkBillable_res_' + uid).checked),
                isDefaultApprover: !!(document.getElementById('chkApprover_res_' + uid) && document.getElementById('chkApprover_res_' + uid).checked),
                selMatchType: $(this).attr('data-sel-match-type') || '',
                skillMismatchAcked: $(this).attr('data-skill-mismatch-acked') || '0'
            };
        });
        var $body = $('#sel-res-body-' + gid);
        // Sub-table "Project Role" column shows the offcanvas #ocProjectRole (employee-master role),
        // NOT the main table project role field — they are separate concepts.
        // Changing the offcanvas role only affects this display column, not the main table.
        var roleText = $('#ocProjectRole option:selected').text().trim();
        if (!roleText || roleText === RES.C_SelectRole) {
            roleText = $('#rg-role-' + gid + ' option:selected').text().trim() || '';
        }
        // Added by Nikhil Mane on 05-May-2026 — preserve main-row config at selection time
        // so Allocate can use selected-row snapshots even after row reset.
        var mainRoleIdAtSelection = parseInt($('#rg-role-' + gid).val(), 10) || 0;
        var startVal = formatDateForMainTable($('.rg-start[data-group="' + gid + '"]').val());
        var endVal = formatDateForMainTable($('.rg-end[data-group="' + gid + '"]').val());
        var allocVal = $('.rg-alloc[data-group="' + gid + '"]').val() || '';
        var startISOAtSelection = displayDateToISO($('.rg-start[data-group="' + gid + '"]').val()) || null;
        var endISOAtSelection = displayDateToISO($('.rg-end[data-group="' + gid + '"]').val()) || null;
        var allocPctAtSelection = _parseIntegerAllocation($('.rg-alloc[data-group="' + gid + '"]').val()) || 0;
        _ensureDefaultReportingToSelection();
        var rgDyn = (typeof _getRgDynFieldValues === 'function') ? _getRgDynFieldValues(gid) : {};
        var reportingTo = rgDyn.reportingTo || $('#ocReportingTo').val() || '';
        var resourceStatus = rgDyn.resourceStatus || '';
        var workHM = rgDyn.workHM || '';
        var responsibilities = $('#ocResponsibilities').val() || '';
        var ocIsBillable = !!rgDyn.isBillable;
        var ocIsDefaultApprover = !!rgDyn.isDefaultApprover;

        // Added by Vyankat B. on 8th April 2026 - Build selected list from cache so selections across pagination are retained.
        var selected = Array.from(tempSelected)
            .map(function (id) {
                var key = String(id);
                return selectedResourceMap[key] || resourceByIdCache[key];
            })
            .filter(function (r) { return !!r; });
        var duplicateAcrossRoles = selected.filter(function (r) {
            return isResourceSelectedInOtherGroup(gid, r.id);
        });
        if (duplicateAcrossRoles.length > 0) {
            var dupNames = duplicateAcrossRoles.map(function (r) { return r.name || ('ID ' + r.id); }).join(', ');
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_resFmt(RES.A_ResourcesAlreadyInOtherRole, dupNames));
            return;
        }
        // End of Added by Vyankat B. on 8th April 2026 - Build selected list from cache so selections across pagination are retained.
        if (selected.length === 0) {
            //bootstrap.Offcanvas.getInstance(document.getElementById('selectResourceOffcanvas')).hide();
            //return;
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelOneRes);
            return;
        }

        /* Added By Dipali V On 16th Jun 2026 — reject negative Availability (%) before Add Selected Resources */
        if (!_validateBulkAllocSelectedAvailability(selected)) return;

        // ── Validate selection count: min = No. of Resources, max = Count_Resource_BulkAllocation (from GetProjectDetails) ──
        if (!_validateResourceSelectionCount(gid)) return;

        var selMatchType = getMatchType() === 'probable' ? 'probable' : 'exact';
        if (!skipProbableSkillCheck && _shouldValidateProbableSkillMismatch(gid)) {
            var newEmployeeIds = Array.from(tempSelected)
                .filter(function (id) { return !existingIdSet.has(String(id)); })
                .map(function (id) { return parseInt(id, 10) || 0; })
                .filter(function (id) { return id > 0; });
            if (newEmployeeIds.length > 0) {
                var roleSkillFilters = getBulkAllocRoleSkillFilters(gid);
                _validateEmployeesSkillMismatch(newEmployeeIds, roleSkillFilters, function (hasMismatch) {
                    if (hasMismatch) {
                        showBulkAllocResourceSkillDiffersConfirm(function () {
                            _confirmSelectionCore(keepOffcanvasOpen, {
                                skipProbableSkillCheck: true,
                                userAckedSkillMismatch: true,
                                deferAllocateOnSuccess: !!confirmOpts.deferAllocateOnSuccess
                            });
                        });
                        return;
                    }
                    _confirmSelectionCore(keepOffcanvasOpen, {
                        skipProbableSkillCheck: true,
                        userAckedSkillMismatch: false,
                        deferAllocateOnSuccess: !!confirmOpts.deferAllocateOnSuccess
                    });
                });
                return;
            }
        }

        $body.empty();

        // Modified by Nikhil Mane on 09-04-2026 — per-resource unique control IDs.
        // Each resource row gets its own Reporting To, Resource Status, Work (H:M),
        // and Responsibility controls; offcanvas values are used as initial defaults.
        selected.forEach(function (r) {
            var uid = gid + '_' + r.id;  // unique suffix: groupId_empId
            var prev = existingRowStateByResId[String(r.id)] || null;
            var rowRoleText = prev ? (prev.roleText || roleText) : roleText;
            var rowStartVal = prev ? (prev.startVal || startVal) : startVal;
            var rowEndVal = prev ? (prev.endVal || endVal) : endVal;
            var rowAllocVal = prev ? (prev.allocVal || allocVal) : allocVal;
            var rowMainRoleId = prev ? (parseInt(prev.mainRoleId, 10) || 0) : mainRoleIdAtSelection;
            var rowStartISO = prev ? (prev.startISO || startISOAtSelection) : startISOAtSelection;
            var rowEndISO = prev ? (prev.endISO || endISOAtSelection) : endISOAtSelection;
            var rowAllocPct = prev ? (parseFloat(prev.allocPct) || 0) : allocPctAtSelection;
            var rowReportingTo = prev ? (prev.reportingTo || reportingTo) : reportingTo;
            var rowResourceStatus = prev ? (prev.resourceStatus || resourceStatus) : resourceStatus;
            var rowWorkHM = prev ? (prev.workHM || workHM) : workHM;
            // Modified by Nikhil Mane on 05-May-2026 — preserve existing row responsibility as-is.
            // Do not fallback using "||" because empty-string responsibilities were getting replaced
            // by the latest offcanvas value (appearing as override by last selected resource value).
            var rowResponsibilities = _cleanRrlText(prev
                ? ((prev.responsibilities !== undefined && prev.responsibilities !== null)
                    ? prev.responsibilities
                    : responsibilities)
                : responsibilities);
            var rowIsBillable = prev ? prev.isBillable : ocIsBillable;
            var noOfResForApprover = parseInt($('.rg-count[data-group="' + gid + '"]').val(), 10) || 0;
            var rowIsDefaultApprover = (noOfResForApprover === 1)
                ? (prev ? prev.isDefaultApprover : ocIsDefaultApprover)
                : false;

            var rtOpts = _buildReportingToOptionsHtml(window._reportingToAllRows || window._reportingToOptions, rowReportingTo);
            // Fixed by Vyankat B. on 10th April 2026 – Clone Resource Status options directly from the
            // offcanvas #ocResourceStatus select (SP-bound via DrawComboBox) so the table dropdown
            // always matches the offcanvas exactly, including any SP-driven options.
            var statusOpts = '';
            $('#ocResourceStatus option').each(function () {
                var v = $(this).val();
                var t = $(this).text();
                var sel = (v && v === rowResourceStatus) ? ' selected' : '';
                statusOpts += '<option value="' + escHtml(v) + '"' + sel + '>' + escHtml(t) + '</option>';
            });
            if (!statusOpts) {
                // Fallback if offcanvas not yet rendered
                statusOpts = '<option value="">Select</option>';
            }
            // End of fix by Vyankat B. on 10th April 2026

            var isNewRow = !existingIdSet.has(String(r.id));
            var rowSkillAcked = (prev && prev.skillMismatchAcked === '1') ? '1'
                : (isNewRow && userAckedSkillMismatch ? '1' : '0');
            var rowMatchType = (prev && prev.selMatchType) ? prev.selMatchType : selMatchType;
            $body.append(
                // Modified by Nikhil Mane on 05-May-2026 — persist role/start/end/alloc snapshot on each row.
                '<tr data-res-id="' + r.id + '" data-sel-match-type="' + escHtml(rowMatchType) + '" data-skill-mismatch-acked="' + escHtml(rowSkillAcked) + '" data-main-role-id="' + escHtml(String(rowMainRoleId)) + '" data-start-iso="' + escHtml(String(rowStartISO || '')) + '" data-end-iso="' + escHtml(String(rowEndISO || '')) + '" data-alloc-pct="' + escHtml(String(rowAllocPct)) + '"' +
                ' data-reporting-to="' + escHtml(String(rowReportingTo || '')) + '" data-resource-status="' + escHtml(String(rowResourceStatus || '')) + '" data-work-hm="' + escHtml(String(rowWorkHM || '')) + '"' +
                ' data-billable="' + (rowIsBillable ? '1' : '0') + '" data-default-approver="' + (rowIsDefaultApprover ? '1' : '0') + '">' +
                '<td><strong>' + escHtml(r.name) + '</strong></td>' +
                '<td>' + escHtml(rowRoleText) + '</td>' +
                '<td>' + escHtml(rowStartVal) + '</td>' +
                '<td>' + escHtml(rowEndVal) + '</td>' +
                '<td><input type="number" id="txtAlloc_res_' + uid + '" class="form-control form-control-sm" value="' + escHtml(rowAllocVal) + '" readonly data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Allocation % (read only after add)"></td>' +

                /* Reporting To — per-resource, unique ID.
                   data-container="body" ensures the dropdown escapes the overflow:auto table wrapper. */
                '<td class="ba-dyn-td col-rpt" data-col="reporting-to">' +
                '<select id="cboReportingTo_res_' + uid + '" name="cboReportingTo_res_' + uid + '" ' +
                        'class="selectpicker form-control form-control-sm" data-live-search="true" data-width="100%" data-container="body" data-none-selected-text="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '" title="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '">' +
                rtOpts +
                '</select>' +
                '</td>' +

                /* Resource Status — per-resource, unique ID.
                   data-container="body" ensures the dropdown escapes the overflow:auto table wrapper. */
                '<td class="ba-dyn-td col-status" data-col="resource-status">' +
                '<select id="cboResStatus_res_' + uid + '" name="cboResStatus_res_' + uid + '" ' +
                        'class="selectpicker form-control form-control-sm" data-live-search="true" data-width="100%" data-container="body">' +
                statusOpts +
                '</select>' +
                '</td>' +

                /* Work (H:M) — per-resource, unique ID */
                /* Modified by Nikhil Mane on 16-04-2026 — added oninput workHHMMInput for xxxx:yy format enforcement */
                '<td class="ba-dyn-td col-work" data-col="work-hh">' +
                '<input type="text" id="txtWork_res_' + uid + '" name="txtWork_res_' + uid + '" ' +
                           'class="form-control form-control-sm" placeholder="HH:MM" maxlength="8" ' +
                           'oninput="workHHMMInput(this)" autocomplete="off" inputmode="numeric" ' +
                           'value="' + escHtml(rowWorkHM) + '"></td>' +
                /* End of Modified by Nikhil Mane on 16-04-2026 */

                /* Billable checkbox — per-resource, Added by Vyankat B. on 13-Apr-2026 */
                '<td class="ba-dyn-td col-bill" data-col="billable">' +
                '<input type="checkbox" id="chkBillable_res_' + uid + '" name="chkBillable_res_' + uid + '" ' +
                       'class="form-check-input" style="width:16px;height:16px;cursor:pointer;"' +
                       (rowIsBillable ? ' checked' : '') + '>' +
                '</td>' +

                /* Is Default Approver checkbox — per-resource, Added by Vyankat B. on 13-Apr-2026 */
                '<td class="ba-dyn-td col-approver" data-col="is-default-approver">' +
                '<input type="checkbox" id="chkApprover_res_' + uid + '" name="chkApprover_res_' + uid + '" ' +
                       'class="form-check-input" style="width:16px;height:16px;cursor:pointer;"' +
                       (rowIsDefaultApprover ? ' checked' : '') + '>' +
                '</td>' +
                /* End of Added by Vyankat B. on 13-Apr-2026 */

                /* Responsibility — per-resource, unique ID */
                /* Modified by Nikhil Mane on 15-04-2026 — changed input to textarea with maxlength 900 */
                '<td class="col-resp"><textarea id="txtResponsibility_res_' + uid + '" name="txtResponsibility_res_' + uid + '" ' +
                           'class="form-control form-control-sm" placeholder="Responsibility" maxlength="900" ' +
                           'rows="2" style="resize:vertical;min-height:52px;">' + escHtml(rowResponsibilities) + '</textarea></td>' +
                /* End of Modified by Nikhil Mane on 15-04-2026 */
                '<td class="col-act"><button class="btn-delete btn-delete-small" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Remove this resource from the group" onclick="removeSelectedResource(' + gid + ',' + r.id + ')"><i class="fas fa-times"></i></button></td>' +
                '</tr>'
            );
        });
        if (userAckedSkillMismatch) {
            selected.forEach(function (r) {
                if (!existingIdSet.has(String(r.id))) {
                    $('#sel-res-body-' + gid + ' tr[data-res-id="' + r.id + '"]').attr('data-skill-mismatch-acked', '1');
                }
            });
        }
        // End of Modified by Nikhil Mane on 09-04-2026

        /* Preserve latest offcanvas defaults so reopen does not clear these values. */
        _offcanvasLastDefaults.resourceStatus = $('#ocResourceStatus').val() || '';
        _offcanvasLastDefaults.workHM = $('#ocWorkHM').val() || '';
        _persistOcIsProductOwnerDefault();
        _setOffcanvasResponsibilitiesForGroup(gid, $('#ocResponsibilities').val() || '');

        // Fix by Nikhil Mane — newly appended <select> elements are uninitialised;
        // call selectpicker() to initialise them (handles both init + refresh).
        $('#sel-res-body-' + gid + ' .selectpicker').each(function () {
            var $p = $(this);
            if (_isReportingToSelectEl($p)) {
                var $row = $p.closest('tr');
                var rptVal = ($row.length ? ($row.attr('data-reporting-to') || '') : '') || $p.val() || '';
                var rptRows = window._reportingToAllRows || window._reportingToOptions || [];
                if (rptRows.length) {
                    _fillReportingToOptions($p, rptRows, rptVal, null);
                } else {
                    _initReportingToSelectpicker($p);
                }
            } else if (!$p.data('selectpicker')) {
                $p.selectpicker();
            } else {
                $p.selectpicker('refresh');
            }
        });
        syncBulkAllocTableColumns();
        if (typeof _syncBaDefaultApproverForGroup === 'function') _syncBaDefaultApproverAllGroups();
        // Added by Nikhil Mane on 05-May-2026 — update Selected Resources count badge.
        updateSelectedResourcesBadge(gid);
        // Fix — close any bootstrap-select dropdown that is still open before hiding
        // the offcanvas so no orphan .bs-container menus are left floating on <body>.
        _closeAllOffcanvasSelectpickers();
        if (!keepOffcanvasOpen) {
            bootstrap.Offcanvas.getInstance(document.getElementById('selectResourceOffcanvas')).hide();
        }
        // rg-count is now user-entered; do not overwrite it with selected.length

        // Added by Vyankat B. on 8th April 2026 - Persist confirmed selection as latest draft for this group.
        draftSelectedByGroup[gid] = Array.from(tempSelected);
        draftSelectedObjByGroup[gid] = Object.assign({}, selectedResourceMap);
        // End of Added by Vyankat B. on 8th April 2026 - Persist confirmed selection as latest draft for this group.

        /* Added By Dipali V On 26th May - Keep Role/Count/Dates/Allocation; lock Project Role after selection */
        _finalizeMainRowAfterSelection(gid);

        applyUISettings();
        validateAndToggleButton(gid);
        _confirmSelectionSucceeded = true;
        if (typeof _refreshProjectDefaultApproverFromBaSelection === 'function') {
            _refreshProjectDefaultApproverFromBaSelection();
        }
        initializeVendorTooltips();
        if (confirmOpts.deferAllocateOnSuccess) {
            _allocateTriggeredFromOffcanvas = true;
            handleAllocate(true);
        }
    }

    /* Added By Dipali V On 27th May - Offcanvas Allocate uses same main allocation flow.
       Persist checked resources first (same as Select Resource), then trigger handleAllocate(). */
    function handleAllocateFromOffcanvas() {
        if (_bulkAllocateInFlight) return;
        if (!addAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionAllocate);
            return;
        }
        if (!activeGroupId) {
            _allocateTriggeredFromOffcanvas = true;
            handleAllocate();
            return;
        }
        var gid = activeGroupId;
        _confirmSelectionSucceeded = false;
        confirmSelection(true, { deferAllocateOnSuccess: true });
    }

    /* Added By Dipali V On 26th May - After offcanvas confirm: preserve row values; lock Project Role */
    function _finalizeMainRowAfterSelection(gid) {
        if (getGroupSelectedIds(gid).length === 0) return;
        $('#group-' + gid).attr('data-has-selection', 'true');
        lockProjectRoleForGroup(gid);
        validateAndToggleButton(gid);
    }

    function _groupHasSelectedResources(gid) {
        return getGroupSelectedIds(gid).length > 0;
    }

    // Modified by Nikhil Mane on 13-04-2026 — removeSelectedResource now shows confirm modal first
    window._pendingRemoveResGid = null;
    window._pendingRemoveResRid = null;

    function removeSelectedResource(gid, rid) {
        window._pendingRemoveResGid = gid;
        window._pendingRemoveResRid = rid;
        var modalEl = document.getElementById('removeResourceConfirmModal');
        if (modalEl) { bootstrap.Modal.getOrCreateInstance(modalEl).show(); }
    }

    function _executeRemoveSelectedResource(gid, rid) {
        $('#sel-res-body-' + gid + ' tr[data-res-id="' + rid + '"]').fadeOut(180, function () {
            // Fix by Nikhil Mane — destroy selectpickers in the row BEFORE removal so
            // bootstrap-select cleans up its .bs-container elements from <body>.
            // Without this, orphaned .bs-container nodes accumulate on <body> and their
            // invisible overlay blocks clicks on the main resource allocation table,
            // making it appear that dropdowns open on non-dropdown clicks.
            $(this).find('.selectpicker').each(function () {
                try { $(this).selectpicker('destroy'); } catch (e) { /* ignore */ }
            });
            $(this).remove();
            var count = $('#sel-res-body-' + gid + ' tr').length;
            // rg-count is user-controlled; do not overwrite it when rows are removed

            // ── Sync draft selections so offcanvas reflects the removal ──
            var key = String(rid);
            if (draftSelectedByGroup[gid]) {
                draftSelectedByGroup[gid] = draftSelectedByGroup[gid].filter(function (x) { return String(x) !== key; });
            }
            if (draftSelectedObjByGroup[gid]) { delete draftSelectedObjByGroup[gid][key]; }
            // If the offcanvas is currently open for this group, uncheck the row live
            if (activeGroupId === gid) {
                tempSelected.delete(key);
                delete selectedResourceMap[key];
                $('input.res-chk[data-res-id="' + key + '"]').prop('checked', false);
            }

            if (count === 0) {
                /* Added By Dipali V On 26th May - Unlock Project Role when all resources removed from row */
                $('#group-' + gid).removeAttr('data-has-selection');
                unlockProjectRoleForGroup(gid);
            }
            updateSelectedResourcesBadge(gid);
            validateAndToggleButton(gid);
            if (typeof _refreshProjectDefaultApproverFromBaSelection === 'function') {
                _refreshProjectDefaultApproverFromBaSelection();
            }
        });
    }

    /* ═══════════════════════════════════════════════════════════════════════
       RESOURCE GROUP MANAGEMENT
       ═══════════════════════════════════════════════════════════════════════ */
    /* Added By Dipali V On 26th May - Dynamic add/remove role row functionality (reusable HTML builders) */
    function buildResourceGroupActionCell(gid, isContinuationRow) {
        var html = '<div class="rg-action-cell" id="rg-action-cell-' + gid + '">';
        if (addAccess) {
            html += '<button type="button" class="btn-action-add" id="btn-action-add-' + gid + '" disabled onclick="openSelectResource(' + gid + ')" ' +
                'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(RES.A_EnterRoleRowFields) + '">' +
                '<i class="fas fa-user-plus"></i></button>';
        }
        /* Added By Dipali V On 9th Jun 2026 — always reserve remove slot (hidden on first row) for column alignment */
        if (deleteAccess || addAccess) {
            var removeHiddenCls = isContinuationRow ? '' : ' ba-role-remove-hidden';
            html += '<button type="button" class="btn-action-delete ba-role-remove-btn' + removeHiddenCls + '" id="btn-action-delete-' + gid + '" ' +
                'onclick="removeRoleRow(' + gid + ')" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" ' +
                'data-bs-title="' + escHtml(RES.C_DeleteRowTooltip) + '"><i class="fas fa-trash-alt"></i></button>';
        }
        html += '</div>';
        return html;
    }

    function buildBulkResourceGroupHtml(gid, opts) {
        opts = opts || {};
        var fmtStart = opts.fmtStart || '';
        var fmtEnd = opts.fmtEnd || '';
        var isFromDb = !!opts.isFromDb;
        var isContinuationRow = !!opts.isContinuationRow;
        var headerHtml = '';
        if (!isContinuationRow) {
            headerHtml =
            '<div class="rg-header" id="rg-header-' + gid + '">' +
            '<span class="rg-hdr-col rg-hdr-role" ' + _baRgHdrTooltipAttrs(RES.C_ProjectRole) + '>' + escHtml(RES.C_ProjectRole) + '</span>' +
            '<span class="rg-hdr-col rg-hdr-count" ' + _baRgHdrTooltipAttrs(RES.C_NoOfResources) + '>' + escHtml(RES.C_NoOfResources) + '</span>' +
            '<span class="rg-hdr-col rg-hdr-start" ' + _baRgHdrTooltipAttrs(RES.C_PlannedStartDate) + '>' + escHtml(RES.C_PlannedStartDate) + '</span>' +
            '<span class="rg-hdr-col rg-hdr-end" ' + _baRgHdrTooltipAttrs(RES.C_PlannedEndDate) + '>' + escHtml(RES.C_PlannedEndDate) + '</span>' +
            '<span class="rg-hdr-col rg-hdr-alloc" ' + _baRgHdrTooltipAttrs(RES.C_PercentAllocation) + '>' + escHtml(RES.C_PercentAllocation) + '</span>' +
            _buildBaRgDynHeadersHtml(gid) +
            '<span class="rg-hdr-action" ' + _baRgHdrTooltipAttrs(RES.C_Select) + '>' + escHtml(RES.C_Select) + '</span></div>';
        }
        var bandHdr = isContinuationRow ? '' : '<div class="ba-rg-grid-band ba-rg-grid-band-hdr" aria-hidden="true"></div>';
        var bandData = '<div class="ba-rg-grid-band ba-rg-grid-band-data" aria-hidden="true"></div>';
        return (
            '<div class="resource-group" id="group-' + gid + '" data-group="' + gid + '" data-from-db="' + isFromDb + '">' +
            '<div class="ba-rg-grid-surface" id="ba-rg-grid-surface-' + gid + '">' +
            bandHdr + headerHtml + bandData +
            '<div class="rg-row" id="rg-row-' + gid + '">' +
            '<div class="rg-role-wrap">' + cloneRoleSelect('rg-role-' + gid, gid) + '</div>' +
            '<div><input type="text" class="form-control rg-count" id="rg-count-' + gid + '" value="" placeholder="' + escHtml(RES.C_NoOfResourcesPlaceholder) + '" maxlength="5" data-group="' + gid + '" autocomplete="off" inputmode="numeric" ' +
            'oninput="rgNumericOnly(this, false)" onblur="onNoOfResBlur_group(' + gid + ', this)" /></div>' +
            '<div><div class="datefielddiv">' +
            '<input type="text" class="form-control rg-start" id="rg-start-' + gid + '" data-group="' + gid + '" placeholder="' + escHtml(RES.C_DatePlaceholder) + '" value="' + fmtStart + '" readonly/>' +
            '<button class="btn btncalendar rg-start-btn" type="button" data-group="' + gid + '" ' + _baRgHdrTooltipAttrs(RES.C_PickPlannedStartDate) + '><i class="fas fa-calendar-alt"></i></button></div></div>' +
            '<div><div class="datefielddiv">' +
            '<input type="text" class="form-control rg-end" id="rg-end-' + gid + '" data-group="' + gid + '" placeholder="' + escHtml(RES.C_DatePlaceholder) + '" value="' + fmtEnd + '" readonly/>' +
            '<button class="btn btncalendar rg-end-btn" type="button" data-group="' + gid + '" ' + _baRgHdrTooltipAttrs(RES.C_PickPlannedEndDate) + '><i class="fas fa-calendar-alt"></i></button></div></div>' +
            '<div><div class="rg-alloc-wrapper" id="rg-alloc-wrapper-' + gid + '">' +
            '<input type="text" class="rg-alloc" id="rg-alloc-' + gid + '" maxlength="6" inputmode="numeric" data-group="' + gid + '" autocomplete="off" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" ' +
            'onblur="onAllocBlur_group(' + gid + ', this)" oninput="rgAllocationIntegerOnly(this)"/>' +
            '<span class="rg-alloc-pct-label" id="rg-alloc-lbl-' + gid + '">%</span></div></div>' +
            _buildBaRgDynCellsHtml(gid) +
            buildResourceGroupActionCell(gid, isContinuationRow) +
            '</div></div>' +
            '<div class="ba-rg-group-tail" id="ba-rg-group-tail-' + gid + '">' +
            (addAccess ? '<div class="rg-set-skill-row ba-set-skill-row" id="rg-set-skill-row-' + gid + '" style="display:none;">' +
            '<button type="button" class="set-skill-link ba-set-skill-link" id="btn-set-skill-' + gid + '" ' +
            'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="' + escHtml(RES.C_SetSkillsTooltip) + '" ' +
            'onclick="toggleBulkAllocSkill(' + gid + ')">' + escHtml(RES.C_SetSkill) + '</button></div>' : '') +
            '<div class="bulk-skill-section" id="bulk-skill-section-' + gid + '" data-group="' + gid + '">' +
            '<div class="skill-section-inner">' +
            '<div class="skill-section-header">' +
            '<button type="button" class="skill-section-close" onclick="toggleBulkAllocSkill(' + gid + ')" ' +
            'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(RES.C_Close) + '">&#x2715;</button>' +
            '<span class="skill-dot"></span><span>' + escHtml(RES.C_SkillSet) + ' <small style="font-weight:400;color:#6b7280;">' + escHtml(RES.C_SkillSetForRole) + '</small></span></div>' +
            '<table class="skills-table table table-bordered"><thead><tr>' +
            '<th width="30%">' + escHtml(RES.C_Skill) + '</th><th width="30%">' + escHtml(RES.C_ExperienceYearMonth) + '</th><th width="20%">' + escHtml(RES.C_Proficiency) + '</th><th width="10%">' + escHtml(RES.C_CoreCompetency) + '</th><th width="10%">&nbsp;</th>' +
            '</tr></thead>' +
            '<tbody id="bulk-skill-tbody-' + gid + '"></tbody>' +
            '<tfoot><tr><td colspan="5">' +
            (addAccess ? '<button type="button" class="btn-add-skill" onclick="addBulkAllocSkillRow(' + gid + ')" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom"  title="' + escHtml(RES.C_AddSkillSet) + '">' + escHtml(RES.C_AddSkillSet) + '</button>' : '') +
            '</td></tr></tfoot></table></div></div>' +
            '<div class="ba-res-data-store" id="ba-data-' + gid + '" aria-hidden="true">' +
            '<table><tbody id="sel-res-body-' + gid + '"></tbody></table></div></div></div>'
        );
    }

    function buildReallocationGroupHtml(gid) {
        /* Added By Dipali V On 29th May - Reallocation Save in tab header (m_blnEditAccess); extend note only here */
        var rrlExtendNoteText = (RES.C_RrlProjectExtendedNote || '').toString().trim()
            || 'The project end date has been extended. If you would like to extend the resource end date as well, please select the required resource(s) and click Save.';
        var rrlSaveActionsHtml =
            '<div class="rrl-table-actions rrl-actions-row rrl-extend-note-row">' +
            '<div class="inline-info-note rrl-extend-note d-none" id="rrl-extend-note-' + gid + '"><i class="fas fa-info-circle"></i><span>' + escHtml(rrlExtendNoteText) + '</span></div>' +
            '</div>';
        return (
            '<div class="resource-group-rrl" id="group-rrl-' + gid + '" data-group="' + gid + '">' +
            '<div class="rrl-section" id="rrl-section-' + gid + '" data-group="' + gid + '">' +
            '<span class="d-none" id="rrl-badge-' + gid + '" aria-hidden="true">0</span>' +
            '<div class="rrl-body" id="rrl-body-' + gid + '">' +
            '<div class="rrl-loading" id="rrl-loading-' + gid + '"><i class="fas fa-spinner fa-spin" style="color:#2563eb;"></i>' +
            '<span>' + escHtml(RES.C_LoadingResourcesForRole) + '</span></div>' +
            '<div class="rrl-empty" id="rrl-empty-' + gid + '">' + escHtml(RES.C_NoDataAvailableForRole) + '</div>' +
            '<div class="rrl-table-container" id="rrl-table-wrap-' + gid + '" style="display:none;">' +
            rrlSaveActionsHtml +
            /* Added By Dipali V On 5th Jun 2026 — Reallocation list: frozen thead + tbody scroll */
            '<div class="rrl-table-grid" id="rrl-table-grid-' + gid + '">' +
            '<div class="rrl-table-head-pane" id="rrl-table-head-' + gid + '"><table class="rrl-table rrl-compact-list"><thead><tr>' +
            '<th class="col-rrl-name">' + escHtml(RES.C_ResourceName) + '</th>' +
            '<th class="col-rrl-role">' + escHtml(RES.C_ProjectRole) + '<span class="rrl-required-star">*</span></th>' +
            '<th class="col-rrl-start">' + escHtml(RES.C_StartDateHeader) + '<span class="rrl-required-star">*</span></th>' +
            '<th class="col-rrl-end">' + escHtml(RES.C_EndDateHeader) + '<span class="rrl-required-star">*</span></th>' +
            '<th class="col-rrl-alloc">' + escHtml(RES.C_PercentAllocation) + '<span class="rrl-required-star">*</span></th>' +
            '<th class="col-rrl-work">' + escHtml(RES.C_WorkHHMM) + '<span class="rrl-required-star">*</span></th>' +
            '<th class="col-rrl-edit">' + escHtml(RES.C_Action) + '</th>' +
            '<th class="col-rrl-check">' +
            '<input type="checkbox" class="rrl-row-check rrl-check-all" id="rrl-check-all-' + gid + '" onchange="toggleRrlSelectAll(\'' + gid + '\', this)" title="' + escHtml(RES.C_SelectAllResources) + '"></th>' +
            '</tr></thead></table></div>' +
            '<div class="rrl-table-scroll rrl-table-body-scroll" id="rrl-table-scroll-' + gid + '">' +
            '<table class="rrl-table rrl-compact-list"><tbody id="rrl-tbody-' + gid + '"></tbody></table></div></div>' +
            '<div class="rrl-scroll-top" id="rrl-scroll-top-' + gid + '"><span class="rrl-scroll-top-inner" id="rrl-scroll-top-inner-' + gid + '"></span></div>' +
            '<div class="rrl-table-footer ir-pagination-container" id="rrl-footer-' + gid + '">' +
            '<div class="ir-pagination-info"><span id="rrl-total-text-' + gid + '">' + escHtml(RES.C_TotalRecordsLabel) + '</span></div>' +
            '<div class="ir-pagination-buttons">' +
            '<button id="rrl-prev-' + gid + '" type="button" class="ir-page-btn" onclick="rrlPrevPage(\'' + gid + '\')" title="' + escHtml(RES.C_PreviousPage) + '"><i class="fas fa-angle-double-left"></i></button>' +
            '<button id="rrl-next-' + gid + '" type="button" class="ir-page-btn" onclick="rrlNextPage(\'' + gid + '\')" title="' + escHtml(RES.C_NextPage) + '"><i class="fas fa-angle-double-right"></i></button>' +
            '</div></div></div></div></div></div>'
        );
    }

    /* Added By Dipali V On 26th May - True when role row was pre-loaded from DB (restrict remove) */
    function _isBulkAllocRoleGroupFromDb(gid) {
        var $g = $('#group-' + gid);
        return $g.length > 0 && String($g.attr('data-from-db')).toLowerCase() === 'true';
    }

    /* Added By Dipali V On 26th May - First role row has no Remove; subsequent rows show Remove */
    function refreshBulkAllocRoleRemoveButtons() {
        $('#bulkAllocationGroupsContainer .resource-group').each(function (idx) {
            var gid = $(this).attr('data-group');
            var $btn = $('#btn-action-delete-' + gid);
            if (!$btn.length) return;
            $btn.toggleClass('ba-role-remove-hidden', idx === 0);
            if (idx > 0) {
                var selCount = $('#sel-res-body-' + gid + ' tr').length;
                updateGroupDeleteBtn(gid, selCount);
            }
        });
    }

    /* Modified by Nikhil Mane on 23-Apr-2026:
       Added optional preRoleId / preRoleText parameters.
       When provided (called from initGroupsByAllocatedRoles), the role
       dropdown is pre-selected after selectpicker initialisation and the
       RRL section is populated with filtered resources for that role.
       When called without arguments (manual "Add Role" flow), behaviour
       is identical to before. */
    function addResourceGroup(preRoleId, preRoleText) {
        groupCounter++;
        var gid = groupCounter;
        var effectiveStart = (typeof _getEffectiveStartDate === 'function') ? _getEffectiveStartDate() : new Date();
        var fmtStart = _fmtGroupDate(effectiveStart);
        var fmtEnd = isoLikeToDisplay(_projectEndRaw);
        var isFromDb = !!(preRoleText);
        var isContinuationRow = $('#bulkAllocationGroupsContainer .resource-group').length > 0;
        var bulkHtml = buildBulkResourceGroupHtml(gid, {
            fmtStart: fmtStart, fmtEnd: fmtEnd, isFromDb: isFromDb, isContinuationRow: isContinuationRow
        });
        $('#bulkAllocationGroupsContainer').append(bulkHtml);
        $('#ba-rg-group-tail-' + gid).hide().slideDown(220);
        syncBulkAllocSetSkillVisibility(); /* Added By Dipali V On 26th May 2026 */
        refreshBulkAllocRoleRemoveButtons(); /* Added By Dipali V On 26th May - enforce first row has no Remove */
        bindGroupValidation(gid);
        initGroupDatepicker(gid);
        $('#rg-role-' + gid).selectpicker();
        if (typeof syncBulkAllocTableColumns === 'function') syncBulkAllocTableColumns();
        if (typeof initBaRgDynControls === 'function') initBaRgDynControls(gid);
        if (_isRgWorkHoursVisible()) {
            _autoPopulateRgWorkHours(gid, { onlyIfEmpty: false, syncOffcanvas: false });
        }
        if (typeof _syncBaRgUnifiedGridLayout === 'function') _syncBaRgUnifiedGridLayout();
        setTimeout(function () {
            if (typeof _syncBaRgUnifiedGridLayout === 'function') _syncBaRgUnifiedGridLayout();
        }, 80);
        validateAndToggleButton(gid);
        reinitTooltips();
        /* Modified by Nikhil Mane on 23-Apr-2026:
           If a preRoleId is provided (called from initGroupsByAllocatedRoles),
           pre-select that role in the dropdown and load its filtered resource list.
           Otherwise show all project resources (no role selected yet). */
        /* Modified by Nikhil Mane on 23-Apr-2026 (fix):
           Gate on preRoleText alone — preRoleId may be null/'' when the role
           text is not found in the SP-bound template select yet (it is loaded
           asynchronously). We still pre-select by text via the filter-option
           mechanism and always call loadAndRenderRrlForGroup with the role text
           so the RRL section shows only that role's resources. */
        if (preRoleText) {
            (function(g, rid) {
                setTimeout(function() {
                    if (rid) { $('#rg-role-' + g).val(rid).selectpicker('refresh'); }
                    validateAndToggleButton(g);
                }, 120);
            })(gid, preRoleId);
        }
    }

    // Modified by Nikhil Mane on 13-04-2026 — removeGroup now shows confirm modal first
    window._pendingDeleteGroupId = null;

    /* Added By Dipali V On 26th May - Remove Role row (not allowed on default first row; min 1 row) */
    window.removeRoleRow = function (gid) {
        if (!addAccess && !deleteAccess) return;
        var $groups = $('#bulkAllocationGroupsContainer .resource-group');
        if ($groups.length <= 1) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_AtLeastOneRoleRow);
            return;
        }
        var firstGid = $groups.first().attr('data-group');
        if (String(gid) === String(firstGid)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_DefaultRoleCannotRemove);
            return;
        }
        /* Added By Dipali V On 26th May - Newly added (manual) rows: allow remove without allocated-resource restriction */
        if (!_isBulkAllocRoleGroupFromDb(gid)) {
            removeGroup(gid);
            return;
        }
        var selCount = $('#sel-res-body-' + gid + ' tr').length;
        if (selCount > 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_RemoveResourcesBeforeRole);
            return;
        }
        removeGroup(gid);
    };

    function removeGroup(gid) {
        window._pendingDeleteGroupId = gid;
        var modalEl = document.getElementById('deleteGroupConfirmModal');
        if (modalEl) { bootstrap.Modal.getOrCreateInstance(modalEl).show(); }
    }

    function _executeRemoveGroup(gid) {
        var $surface = $('#ba-rg-grid-surface-' + gid);
        var $tail = $('#ba-rg-group-tail-' + gid);
        var $group = $('#group-' + gid);
        $('#rg-row-' + gid).find('.selectpicker').add($tail.find('.selectpicker')).each(function () {
            try { $(this).selectpicker('destroy'); } catch (e) { /* ignore */ }
        });
        $tail.slideUp(200, function () {
            $surface.remove();
            $tail.remove();
            $group.remove();
            refreshBulkAllocRoleRemoveButtons();
            if (typeof syncBulkAllocTableColumns === 'function') syncBulkAllocTableColumns();
        });
    }
    // End of Modified by Nikhil Mane on 13-04-2026

    /* ── Add More with validation: all existing groups must be valid first ── */
    function handleAddMore() {
        /* ── Access guard — Added by Vyankat B. on 13-Apr-2026 ── */
        if (!addAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionAddGroups);
            return;
        }
        /* Role limit from GetProjectDetails — Count_Role_BulkAllocation (0 = no limit) */
        var maxRoles = _getMaxRolesPerBulkAlloc();
        var currentGroups = document.querySelectorAll('.resource-group').length;
        if (maxRoles > 0 && currentGroups >= maxRoles) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_resFmt(RES.A_MaxRolesAtTime, maxRoles));
            return;
        }
        var hasExistingGroups = $('.resource-group').length > 0;
        if (hasExistingGroups) {
            if (!validateAllGroupsForAction('Add More', null)) return;
        }
        addResourceGroup();
        _syncBaRoleUnallocatedHighlightAll();
    }

    /* ═══════════════════════════════════════════════════════════════════════
       VALIDATION  –  all fields required, No of Resources > 0
       ═══════════════════════════════════════════════════════════════════════ */
    function isGroupValid(gid) {
        var role = $('#rg-role-' + gid).val();
        var countVal = $('.rg-count[data-group="' + gid + '"]').val().trim();
        var countNum = parseInt(countVal, 10);
        var start = $('.rg-start[data-group="' + gid + '"]').val();
        var end = $('.rg-end[data-group="' + gid + '"]').val();
        var allocVal = $('.rg-alloc[data-group="' + gid + '"]').val().trim();
        var alloc = _parseIntegerAllocation(allocVal);
        var maxResPerRole = _getMaxResourcesPerRole();
        var countValid = !isNaN(countNum) && countNum >= 1 && (maxResPerRole <= 0 || countNum <= maxResPerRole);
        return !!(role && countVal !== '' && countValid && start && end && allocVal !== '' && !isNaN(alloc) && !_isAllocationDecimalInvalid(allocVal) && alloc >= 1 && alloc <= _maxAllocPct);
    }

    function _findDuplicateRoleGroupId(gid, roleVal) {
        var selectedRole = String(roleVal || '').trim();
        if (!selectedRole || selectedRole === '0') return null;
        var duplicateGid = null;
        document.querySelectorAll('.resource-group').forEach(function (grpEl) {
            if (duplicateGid !== null) return;
            var otherGid = parseInt(grpEl.getAttribute('data-group'), 10) || 0;
            if (!otherGid || otherGid === parseInt(gid, 10)) return;
            var otherRole = String($('#rg-role-' + otherGid).val() || '').trim();
            if (otherRole && otherRole !== '0' && otherRole === selectedRole) {
                duplicateGid = otherGid;
            }
        });
        return duplicateGid;
    }

    function _showDuplicateRoleError(gid, duplicateGid) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.error(_rowLabel(gid) + _resFmt(RES.A_DuplicateRoleInRow, _getGroupDisplayNum(duplicateGid)));
    }

    /* Added By Dipali V On 26th May - Enable Action (Select Resource) when row criteria are complete */
    function validateAndToggleButton(gid) {
        var $btn = $('#btn-action-add-' + gid);
        if (!$btn.length) return;
        var hasSelection = _groupHasSelectedResources(gid);
        var rowComplete = isGroupValid(gid);
        var enabled = rowComplete || hasSelection;
        $btn.prop('disabled', !enabled);
        var tip = enabled
            ? (hasSelection ? RES.A_AddOrReviewResources : RES.A_SelectResourcesMatchingRole)
            : RES.A_EnterRoleRowFields;
        _setBsTooltip($btn[0], tip);
        _syncBaRoleUnallocatedHighlight(gid);
        if (typeof _syncBaPendingAllocNote === 'function') _syncBaPendingAllocNote();
    }

    function bindGroupValidation(gid) {
        var $roleSel = $('#rg-role-' + gid);
        $roleSel.attr('data-prev-role', String($roleSel.val() || ''));
        $roleSel.on('shown.bs.select', function () {
            $(this).attr('data-prev-role', String($(this).val() || ''));
        });
        /* Role change via bootstrap-select fires "change" on the hidden select */
        $(document).on('change', '#rg-role-' + gid, function () {
            var $this = $(this);
            var newRole = String($this.val() || '');
            var prevRole = String($this.attr('data-prev-role') || '');
            var duplicateGid = _findDuplicateRoleGroupId(gid, newRole);
            if (duplicateGid !== null) {
                $this.val(prevRole);
                try { $this.selectpicker('refresh'); } catch (e) { /* ignore */ }
                _markRoleError(gid, true);
                _showDuplicateRoleError(gid, duplicateGid);
                return;
            }
            $this.attr('data-prev-role', newRole);
            _markRoleError(gid, false);
            /* Added by dipali v on 18th Jun 2026 for purpose — fresh resource selection after Project Role change */
            if (prevRole && prevRole !== newRole) _resetBaGroupSelectionForRoleChange(gid);
            validateAndToggleButton(gid);
        });
        /* Number and text inputs — live-clear error highlight when user corrects. */
        /* No of Resources — live error clear */
        $('#rg-count-' + gid).on('input change', function () {
            var el = this;
            var v = parseInt(el.value, 10);
            var maxRes = _getMaxResourcesPerRole();
            if (!isNaN(v) && v >= 1 && v <= 999 && (maxRes <= 0 || v <= maxRes)) _markError(el, false);
            if (typeof _syncBaDefaultApproverForGroup === 'function') _syncBaDefaultApproverAllGroups();
            validateAndToggleButton(gid);
        });
        $('.rg-alloc[data-group="' + gid + '"]')
            .on('input change', function () {
                var el = this;
                var allocVal = (el.value || '').toString().trim();
                var v = _parseIntegerAllocation(allocVal);
                if (allocVal && !_isAllocationDecimalInvalid(allocVal) && !isNaN(v) && v >= 1 && v <= _maxAllocPct) {
                    _markAllocWrapperError(gid, false);
                    _maybeRefreshRgWorkHoursFromDates(gid);
                }
                validateAndToggleButton(gid);
            });
        /* Date inputs (readonly, updated by datepicker) monitored via change */
        $('.rg-start[data-group="' + gid + '"], .rg-end[data-group="' + gid + '"]')
            .on('change', function () {
                _maybeRefreshRgWorkHoursFromDates(gid);
                validateAndToggleButton(gid);
            });
        validateAndToggleButton(gid);
    }

    /* Added By Dipali V On 26th May - Lock Project Role after resources are confirmed for this row */
    function lockProjectRoleForGroup(gid) {
        var $roleSelect = $('#rg-role-' + gid);
        if (!$roleSelect.length) return;
        var currentVal = $roleSelect.val();
        $('#group-' + gid).data('locked-role', currentVal);
        $roleSelect.prop('disabled', true);
        try { $roleSelect.selectpicker('refresh'); } catch (e) { /* ignore */ }
        $roleSelect.closest('.bootstrap-select').addClass('rg-role-locked');
        _syncBaRoleUnallocatedHighlight(gid);
    }

    /* Added By Dipali V On 26th May - Unlock Project Role when row has no selected resources */
    function unlockProjectRoleForGroup(gid) {
        var $roleSelect = $('#rg-role-' + gid);
        if (!$roleSelect.length) return;
        $roleSelect.prop('disabled', false);
        try { $roleSelect.selectpicker('refresh'); } catch (e) { /* ignore */ }
        $roleSelect.closest('.bootstrap-select').removeClass('rg-role-locked');
        $('#group-' + gid).removeData('locked-role');
        _syncBaRoleUnallocatedHighlight(gid);
    }

    function initGroupDatepicker(gid) {
        var $start = $('#rg-start-' + gid);
        var $end = $('#rg-end-' + gid);
        // No minDate / maxDate restrictions on the calendar — the picker is fully open.
        // Date range rules (past dates, project bounds, start before end) are enforced
        // via validateGroupRow() validation messages only, not by the calendar widget.
        // yearRange keeps the year dropdown navigable across a reasonable span.
        // Updated by Vyankat B. on 13-Apr-2026
        _applyDisplayDatepicker($start, function () {
            _markError(document.getElementById('rg-start-' + gid), false);
            $start.trigger('change');
            validateAndToggleButton(gid);
        });
        _applyDisplayDatepicker($end, function () {
            _markError(document.getElementById('rg-end-' + gid), false);
            $end.trigger('change');
            validateAndToggleButton(gid);
        });
        $('.rg-start-btn[data-group="' + gid + '"]').off('click').on('click', function () {
            _showDisplayDatepicker($start);
        });
        $('.rg-end-btn[data-group="' + gid + '"]').off('click').on('click', function () {
            _showDisplayDatepicker($end);
        });
    }

    function syncDefaultSelectionToOffcanvas(gid) {
        /* Sync Project Role: mirror the main row selection and make it read-only in the offcanvas.
           The offcanvas Project Role always reflects whatever role was selected in the main table row
           so the user cannot change it — it is locked for reference only. */
        var mainRoleVal = $('#rg-role-' + gid).val() || '';
        $('#ocProjectRole').val(mainRoleVal).selectpicker('refresh');
        /* Lock the offcanvas Project Role dropdown — pointer-events disabled via CSS class */
        $('#ocProjectRole').closest('.bootstrap-select').addClass('oc-role-locked');
        /* Show a small locked badge below the dropdown */
        $('#oc-role-locked-badge').remove();
        /* Remove any stale validation error from Project Role (it is now auto-set) */
        $('#ocProjectRole').closest('.bootstrap-select').removeClass('oc-val-error');

        $('#ocNoOfResources').val($('.rg-count[data-group="' + gid + '"]').val());
        $('#ocStartDate').val($('.rg-start[data-group="' + gid + '"]').val());
        $('#ocEndDate').val($('.rg-end[data-group="' + gid + '"]').val());
        $('#ocAllocation').val($('.rg-alloc[data-group="' + gid + '"]').val());
        if (typeof _syncRgDynToOffcanvas === 'function') _syncRgDynToOffcanvas(gid);
        /* Added By Dipali V On 17th Jun 2026 — ensure offcanvas Default Approver reflects list row checkbox state for this group */
        var hasApproverChecked = !!($('#rg-approver-' + gid).prop('checked') || $('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]:checked').length);
        if ($('#ocIsDefaultApprover').length) $('#ocIsDefaultApprover').prop('checked', hasApproverChecked);
        if (typeof _syncResponsibilitiesToOffcanvas === 'function') _syncResponsibilitiesToOffcanvas(gid);
    }

    /* ═══════════════════════════════════════════════════════════════════════
       RESOURCE DETAIL PANEL
       ═══════════════════════════════════════════════════════════════════════ */
    function setOffcanvasParentBlur(parentId, shouldBlur) {
        var el = document.getElementById(parentId);
        if (!el) return;
        el.classList.toggle('offcanvas-parent-blur', !!shouldBlur);
    }

    var _keepSelectVisibleForChild = false;
    var _keepDetailsVisibleForChild = false;

    function _isAnyChildOffcanvasOpen() {
        var detailsEl = document.getElementById('resourceDetailsOffcanvas');
        var loadingEl = document.getElementById('resourceLoadingOffcanvas');
        return (detailsEl && detailsEl.classList.contains('show')) ||
            (loadingEl && loadingEl.classList.contains('show'));
    }

    /* Blur parent only while a child panel is actually open (not when parent opens alone). */
    function _syncParentChildBlur() {
        var detailsEl = document.getElementById('resourceDetailsOffcanvas');
        var loadingEl = document.getElementById('resourceLoadingOffcanvas');
        var detailsOpen = !!(detailsEl && detailsEl.classList.contains('show'));
        var loadingOpen = !!(loadingEl && loadingEl.classList.contains('show'));
        var childOpen = detailsOpen || loadingOpen;
        setOffcanvasParentBlur('selectResourceOffcanvas', childOpen);
        setOffcanvasParentBlur('resourceDetailsOffcanvas', detailsOpen && loadingOpen);
    }

    /* Close only the topmost child (loading, then details). */
    function _closeTopChildOffcanvas() {
        var detailsEl = document.getElementById('resourceDetailsOffcanvas');
        var loadingEl = document.getElementById('resourceLoadingOffcanvas');
        try {
            if (loadingEl && loadingEl.classList.contains('show')) {
                var loadingInst = bootstrap.Offcanvas.getInstance(loadingEl);
                if (loadingInst) { loadingInst.hide(); return true; }
            }
            if (detailsEl && detailsEl.classList.contains('show')) {
                var detailsInst = bootstrap.Offcanvas.getInstance(detailsEl);
                if (detailsInst) { detailsInst.hide(); return true; }
            }
        } catch (e) { /* ignore */ }
        return false;
    }

    function _closeChildOffcanvasAndRestoreParent() {
        _keepSelectVisibleForChild = false;
        _keepDetailsVisibleForChild = false;
        while (_isAnyChildOffcanvasOpen()) {
            if (!_closeTopChildOffcanvas()) break;
        }
        _syncParentChildBlur();
    }

    /* Click on dimmed parent panel (outside active child) should dismiss the top child. */
    function _handleLayeredOffcanvasParentClick(e) {
        if (!_isAnyChildOffcanvasOpen()) return;
        var target = e.target;
        if (!target || !target.closest) return;

        var loadingEl = document.getElementById('resourceLoadingOffcanvas');
        var detailsEl = document.getElementById('resourceDetailsOffcanvas');
        var loadingOpen = loadingEl.classList.contains('show');
        var detailsOpen = detailsEl.classList.contains('show');

        /* Keep foreground child open when clicking its own content */
        if (loadingOpen && target.closest('#resourceLoadingOffcanvas')) {
            if (!target.closest('#resourceDetailsOffcanvas.offcanvas-parent-blur') &&
                !target.closest('#selectResourceOffcanvas.offcanvas-parent-blur')) {
                return;
            }
        }
        if (detailsOpen && !loadingOpen && target.closest('#resourceDetailsOffcanvas')) {
            if (!target.closest('#selectResourceOffcanvas.offcanvas-parent-blur')) {
                return;
            }
        }

        if (target.closest('#selectResourceOffcanvas.offcanvas-parent-blur') ||
            target.closest('#resourceDetailsOffcanvas.offcanvas-parent-blur')) {
            e.preventDefault();
            e.stopPropagation();
            _closeTopChildOffcanvas();
        }
    }

    function openResourceDetails(id) {
        //debugger;
        var res = RESOURCES.find(function (x) { return x.id === id; });
        if (!res) return;
        $('#detailName').text(res.name);
        $('#detailRole').text(res.role || '');

        /* Seed the info table with data already in memory */
        $('#detailInfoBody').html(
            '<tr><td><i class="far fa-user"></i> User Name</td><td id="UserName">' + escHtml((res.name || '').toLowerCase().replace(/\s+/g, '.')) + '</td></tr>' +
            '<tr><td><i class="far fa-id-badge"></i> Resource Name</td><td>' + escHtml(res.name) + '</td></tr>' +
            '<tr><td><i class="far fa-building"></i> Business Group</td><td>' + escHtml(res.businessGroup || '—') + '</td></tr>' +
            '<tr><td><i class="far fa-folder-open"></i> Department</td><td>' + escHtml(res.dept || '—') + '</td></tr>' +
            '<tr><td><i class="fas fa-user-shield"></i> Role</td><td>' + escHtml(res.role || '—') + '</td></tr>'
        );
        var curAlloc = parseFloat(res.currentAlloc) || 0;
        var freeAlloc = parseFloat(res.freePct) || 0;
        $('#detailCurrentAlloc').text(curAlloc.toFixed(1) + '%');
        $('#detailAllocBar').css('width', Math.min(curAlloc, 100) + '%');
        $('#detailFreeAlloc').text(freeAlloc.toFixed(1) + '%');
        $('#detailFreeBar').css('width', Math.min(freeAlloc, 100) + '%');

        /* Clear any previously appended project allocation list */
        $('#resourceDetailsOffcanvas .offcanvas-body .project-alloc-list').closest('div').remove();
        $('#resourceDetailsOffcanvas .offcanvas-body .detail-block-title').filter(function () {
            return $(this).text().indexOf('Project Alloc') >= 0;
        }).remove();

        _keepSelectVisibleForChild = true;
        bootstrap.Offcanvas.getOrCreateInstance(
            document.getElementById('resourceDetailsOffcanvas'),
            { backdrop: true, scroll: true, keyboard: true }
        ).show();

        // Added by Nikhil Mane on 09-04-2026 – Enrich details panel via GetResourceDetailsAllocation API.
        LoadResourceDetailsAllocation(id);
        // End of Added by Nikhil Mane on 09-04-2026
       
    }
   

    function openResourceLoading(id) {
        // Added by Vyankat B. on 9th April 2026 - Call GetProjectEmployeeRoleId, GetEmployeeProjectInfo, GetResourceLoadingBulk (pie + list), GetYearlyTotalCapacity, GetCompanyStartMonth on View.
        var employeeId = parseInt(id, 10) || 0;
        var requestParam = {
            ProjectID: SessionProjectID,
            EmployeeID: employeeId
        };
        var empInfo = { EmployeeID: employeeId };
        // Added by Vyankat B. on 8th April 2026 - Bind CurrentYear for GetResourceLoadingBulk request.
        var GetYesr = (new Date()).getFullYear();
        // End of Added by Vyankat B. on 8th April 2026
        var capasityParam = { Year: GetYesr, EmpID: employeeId, PieChart: true };
        var resLoadParam  = { Year: GetYesr, EmpID: employeeId, PieChart: false, LoginEmpID: SessionEmployeeID, RoleLevel: 1 };
        var installCapParam = { Year: GetYesr, EmpID: employeeId };

        try {
            // Call GetProjectEmployeeRoleId before opening loading details.
            var roleResult = AJAXCallWithResult(
                'api/PM_BulkResourceAllocation/GetProjectEmployeeRoleId',
                JSON.stringify(requestParam),
                false
            );

            // Call GetEmployeeProjectInfo after GetProjectEmployeeRoleId.
            var empProjectInfoResult = AJAXCallWithResult(
                'api/PM_BulkResourceAllocation/GetEmployeeProjectInfo',
                JSON.stringify(empInfo),
                false
            );

            // Call GetResourceLoadingBulk (PieChart:true) for summary + pie chart.
            var resourceLoadingBulkResult = AJAXCallWithResult(
                'api/PM_BulkResourceAllocation/GetResourceLoadingBulk',
                JSON.stringify(capasityParam),
                false
            );

            // Call GetYearlyTotalCapacity for Install Capacity value.
            var yearlyTotalCapacityResult = AJAXCallWithResult(
                'api/PM_BulkResourceAllocation/GetYearlyTotalCapacity',
                JSON.stringify(installCapParam),
                false
            );

            // Added by Vyankat B. on 9th April 2026 - GetResourceLoadingBulk list (PieChart:false) for Monthly / Project loading tables.
            var resourceLoadingList = AJAXCallWithResult(
                'api/PM_BulkResourceAllocation/GetResourceLoadingBulk',
                JSON.stringify(resLoadParam),
                false
            );
            // End of Added by Vyankat B. on 9th April 2026

            // Added by Vyankat B. on 8th April 2026 - Get financial year start month for Monthly Loading header.
            var startMonthParam = { ProjectID: SessionProjectID };
            var companyStartMonthResult = AJAXCallWithResult(
                'api/PM_BulkResourceAllocation/GetCompanyStartMonth',
                JSON.stringify(startMonthParam),
                false
            );

            companyStartMonth = parseCompanyStartMonthFromApi(companyStartMonthResult);
            bindMonthlyLoadingFinancialYearHeader(companyStartMonth);
            bindProjectLoadingFinancialYearHeader(companyStartMonth);
            var resourceLoadingListRows = extractResourceLoadingListArray(resourceLoadingList);
            bindMonthlyLoadingFromResourceList(resourceLoadingListRows, companyStartMonth);
            bindProjectLoadingFromResourceList(resourceLoadingListRows, companyStartMonth);
            // End of Added by Vyankat B. on 8th April 2026

            // Added by Vyankat B. on 8th April 2026 - Keep GetResourceLoadingBulk rows for chart data binding.
            resourceLoadingBulkRows = (resourceLoadingBulkResult && Array.isArray(resourceLoadingBulkResult.data))
                ? resourceLoadingBulkResult.data
                : [];
            // End of Added by Vyankat B. on 8th April 2026

            // Added by Vyankat B. on 8th April 2026 - Bind GetResourceLoadingBulk response in Resource Utilization summary table.
            bindResourceLoadingSummary(resourceLoadingBulkResult, yearlyTotalCapacityResult);
            // End of Added by Vyankat B. on 8th April 2026

            // Added by Vyankat B. on 8th April 2026 - Bind ResourceName from GetEmployeeProjectInfo endpoint response.
            var employeeInfoRows = (empProjectInfoResult && Array.isArray(empProjectInfoResult.data)) ? empProjectInfoResult.data : [];
            if (employeeInfoRows.length > 0) {
                var employeeInfo = employeeInfoRows[0] || {};
                var apiUserName = employeeInfo.userName || '';
                var apiEmployeeName = employeeInfo.employeeName || '';
                var apiRoleDescription = employeeInfo.roleDescription || '';
                var resourceText = 'Resource : '
                    + apiUserName
                    + (apiEmployeeName ? (' - ' + apiEmployeeName) : '')
                    + (apiRoleDescription ? (' [ ' + apiRoleDescription + ' ]') : '');
                $('#ResourceName').html(resourceText);
                _setBsTooltip(document.getElementById('ResourceName'), resourceText);
                reinitTooltips();
            }
            // End of Added by Vyankat B. on 8th April 2026

        } catch (e) {
            console.error('Resource loading API chain failed', e);
        }

        // Added by Vyankat B. on 8th April 2026 - Bind ResourceLoadingYear strip.
        var currentYear = (new Date()).getFullYear();
        $('#ResourceLoadingYear').html(_resFmt(RES.C_ResourceLoadingForYear, currentYear, currentYear + 1));
        if (!$('#ResourceName').text().trim()) {
            var selectedResource = RESOURCES.find(function (x) { return x.id === employeeId; });
            var selectedResourceName = selectedResource ? selectedResource.name : ('Employee ID ' + employeeId);
            $('#ResourceName').html(RES.C_ResourceColon + selectedResourceName);
        }
        // End of Added by Vyankat B. on 8th April 2026

        var selectOpen = document.getElementById('selectResourceOffcanvas').classList.contains('show');
        var detailsOpen = document.getElementById('resourceDetailsOffcanvas').classList.contains('show');
        if (selectOpen) _keepSelectVisibleForChild = true;
        if (detailsOpen) _keepDetailsVisibleForChild = true;
        bootstrap.Offcanvas.getOrCreateInstance(
            document.getElementById('resourceLoadingOffcanvas'),
            { backdrop: true, scroll: true, keyboard: true }
        ).show();
        setTimeout(renderLoadingChart, 120);
    }

    function renderLoadingChart() {
        var ctx = document.getElementById('loadingPieChart');
        if (!ctx) return;
        if (loadingChartInstance) loadingChartInstance.destroy();
        // Added by Vyankat B. on 8th April 2026 - Bind pie chart values from GetResourceLoadingBulk "hours" by type.
        var chartMap = { availableForAllocation: 0, leaves: 0, billableAllocation: 0, nonBillableAllocation: 0 };
        for (var i = 0; i < resourceLoadingBulkRows.length; i++) {
            var row = resourceLoadingBulkRows[i] || {};
            var type = String(row.type || '').toLowerCase();
            var h = parseFloat(row.hours);
            if (isNaN(h)) h = 0;
            if (type === 'available for allocation') chartMap.availableForAllocation = h;
            else if (type === 'leaves') chartMap.leaves = h;
            else if (type === 'billable allocation') chartMap.billableAllocation = h;
            else if (type === 'non billable allocation') chartMap.nonBillableAllocation = h;
        }
        // End of Added by Vyankat B. on 8th April 2026
        loadingChartInstance = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: [RES.C_AvailableForAllocation, RES.C_Leaves, RES.C_BillableAllocation, RES.C_NonBillableAllocation],
                datasets: [{ data: [chartMap.availableForAllocation, chartMap.leaves, chartMap.billableAllocation, chartMap.nonBillableAllocation], backgroundColor: ['#bfa95a', '#6cc96c', '#f1da54', '#ef4444'], borderWidth: 0 }]
            },
            options: { plugins: { legend: { position: 'top', align: 'start' } } }
        });
    }

    /* ═══════════════════════════════════════════════════════════════════════
       VALIDATION ENGINE  –  mirrors PM_BulkResourceReq.aspx exactly
       Added by Vyankat B. / Nikhil Mane on 10th April 2026
         • _markError              – val-error class add/remove (same as BulkResourceReq)
         • rgNumericOnly           – strip non-numeric on input
         • onNoOfResBlur_group     – blur handler: No. of Resources
         • onAllocBlur_group       – blur handler: % Allocation
         • _parseAnyDate           – legacy / API / picker → Date
         • _fmtDisplayDate         – Date → "DD MMM YYYY" (e.g. 01 May 2027)
         • _fmtGroupDate           – alias for _fmtDisplayDate
         • _getGroupDisplayNum     – 1-based visual group number for messages
         • validateGroupRow        – full single-group field validation
         • validateAllGroupsForAction – entry point for all three action buttons
       ═══════════════════════════════════════════════════════════════════════ */

    /* ── _markError: identical signature to PM_BulkResourceReq.aspx ── */
    function _markError(el, isError) {
        if (!el) return;
        if (isError) el.classList.add('val-error');
        else         el.classList.remove('val-error');
    }
    /* ── Allocation wrapper gets val-error on the border div ── */
    function _markAllocWrapperError(gid, isError) {
        var wrap = document.getElementById('rg-alloc-wrapper-' + gid);
        if (!wrap) return;
        if (isError) wrap.classList.add('val-error');
        else         wrap.classList.remove('val-error');
    }
    /* ── Role bootstrap-select button gets val-error ── */
    function _markRoleError(gid, isError) {
        var $btn = $('#rg-role-' + gid).closest('.bootstrap-select').find('> button');
        if (isError) $btn.addClass('val-error');
        else         $btn.removeClass('val-error');
    }

    /* ── _getGroupDisplayNum: 1-based visual index (mirrors _getRowDisplayNum) ── */
    function _getGroupDisplayNum(gid) {
        var groups = document.querySelectorAll('.resource-group');
        for (var i = 0; i < groups.length; i++) {
            if (parseInt(groups[i].getAttribute('data-group')) === parseInt(gid)) return i + 1;
        }
        return gid;
    }

    /* Added By Dipali V On 16th Jun 2026 — prevent duplicate alertify errors from blur + action validation firing together */
    var _lastValidationAlertMessage = '';
    var _lastValidationAlertAt = 0;
    function _showValidationErrorOnce(message, dedupeMs) {
        var msg = (message || '').toString();
        if (!msg) return;
        var now = Date.now();
        var waitMs = (typeof dedupeMs === 'number' && dedupeMs > 0) ? dedupeMs : 1200;
        if (_lastValidationAlertMessage === msg && (now - _lastValidationAlertAt) < waitMs) return;
        _lastValidationAlertMessage = msg;
        _lastValidationAlertAt = now;
        alertify.set('notifier', 'position', 'top-right');
        alertify.error(msg);
    }

    /* ── Numeric-only input guard (mirrors BulkResourceReq keydown block) ──
       allowDecimal=false → integers only (No. of Resources, % Allocation)
       allowDecimal=true  → one decimal allowed (legacy; not used for Allocation) */
    function rgNumericOnly(input, allowDecimal) {
        var v = input.value;
        if (allowDecimal) {
            v = v.replace(/[^0-9.]/g, '');
            var parts = v.split('.');
            if (parts.length > 2) v = parts[0] + '.' + parts.slice(1).join('');
        } else {
            v = v.replace(/[^0-9]/g, '');
        }
        input.value = v;
    }

    /* Added By Dipali V On 16th Jun 2026 — % Allocation accepts whole numbers only */
    function rgAllocationIntegerOnly(input) {
        if (!input) return;
        var v = (input.value || '').toString();
        if (v.indexOf('.') !== -1) v = v.split('.')[0];
        v = v.replace(/[^0-9]/g, '');
        input.value = v;
    }

    function _allocationPctNoDecimalMsg() {
        return (RES.A_AllocationPctNoDecimal || 'Decimal values are not allowed in the Allocation field.').toString();
    }

    function _allocationPctNoDecimalRowMsg(gid) {
        var rowMsg = (RES.A_AllocationPctNoDecimalRow || '').toString().trim();
        if (rowMsg) return _rowLabel(gid) + rowMsg;
        return _rowLabel(gid) + _allocationPctNoDecimalMsg();
    }

    function _isAllocationDecimalInvalid(allocVal) {
        var s = (allocVal || '').toString().trim();
        if (!s) return false;
        return s.indexOf('.') !== -1 || !/^\d+$/.test(s);
    }

    function _parseIntegerAllocation(allocVal) {
        var s = (allocVal || '').toString().trim();
        if (!s || _isAllocationDecimalInvalid(s)) return NaN;
        return parseInt(s, 10);
    }

    function _isRrlAllocPctValidationMessage(msg) {
        var lower = (msg || '').toString().toLowerCase();
        return lower.indexOf('resource percentage') >= 0 || lower.indexOf('allocation between') >= 0 ||
            lower.indexOf('% allocation') >= 0 || lower.indexOf('allocation field') >= 0 ||
            lower.indexOf('decimal values') >= 0;
    }

    function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
        var regularExpression = (WebConfigSpecialCharacters || '').toString();
        if (regularExpression === '') return false;

        regularExpression += '"';
        value = (value || '').toString();
        for (var i = 0; i < regularExpression.length; i++) {
            if (value.indexOf(regularExpression[i]) !== -1) {
                return true;
            }
        }
        return false;
    }

    /* ── Work (HH:MM) input guard — Modified by Nikhil Mane on 17-04-2026 ──
       Enforces H+:MM format (1–5 hour digits, colon, up to 2 minute digits; maxlength 8):
         • Digits and ONE colon (:) are accepted; all other chars are blocked.
         • The user may type the colon manually after any 1–5 hour digits, OR
           it is auto-inserted when a 6th digit is entered without a colon.
         • The minutes segment (after the colon) is limited to 2 digits.
         • Duplicate colons (e.g. from paste) are stripped; colon at pos 0 removed.
    ── */
    function workHHMMInput(input) {
        var raw   = input.value;
        var caret = input.selectionStart;
        var maxHourDigits = 5;
        var maxMinuteDigits = 2;
        var maxFormattedLen = maxHourDigits + 1 + maxMinuteDigits; /* xxxxx:yy = 8 */

        /* 1. Strip everything except digits and colons */
        var cleaned = raw.replace(/[^0-9:]/g, '');

        /* 2. Allow only the FIRST colon; strip any extras */
        var firstColon = cleaned.indexOf(':');
        if (firstColon !== -1) {
            cleaned = cleaned.substring(0, firstColon + 1) +
                      cleaned.substring(firstColon + 1).replace(/:/g, '');
        }

        /* 3. Build formatted value */
        var formatted = '';
        var colonPos  = cleaned.indexOf(':');

        if (colonPos === -1) {
            /* No colon yet — pure digit stream */
            var digits = cleaned;
            if (digits.length === 0) {
                formatted = '';
            } else if (digits.length <= maxHourDigits) {
                formatted = digits;                                  /* hours only */
            } else {
                /* 6th digit → auto-insert colon (xxxxx:yy) */
                formatted = digits.substring(0, maxHourDigits) + ':' +
                            digits.substring(maxHourDigits, maxHourDigits + maxMinuteDigits);
            }
        } else {
            /* Colon is present — split into hours / minutes parts */
            var hPart = cleaned.substring(0, colonPos).replace(/[^0-9]/g, '').substring(0, maxHourDigits);
            var mPart = cleaned.substring(colonPos + 1).replace(/[^0-9]/g, '').substring(0, maxMinuteDigits);
            if (hPart.length === 0) {
                formatted = '';          /* colon at position 0 is invalid — discard */
            } else {
                formatted = hPart + ':' + mPart;
            }
        }

        /* Minutes must be 00–59 (match _hhmmToDecimal / save validation) */
        if (formatted.indexOf(':') !== -1) {
            var mmParts = formatted.split(':');
            if (mmParts.length === 2 && mmParts[1].length === 2) {
                var mn = parseInt(mmParts[1], 10);
                if (!isNaN(mn) && mn > 59) formatted = mmParts[0] + ':59';
            }
        }

        if (formatted.length > maxFormattedLen) {
            formatted = formatted.substring(0, maxFormattedLen);
        }

        /* 4. Apply only when value actually changed (avoids infinite loops) */
        if (input.value !== formatted) {
            var shift = formatted.length - raw.length;
            input.value = formatted;
            var newCaret = Math.max(0, Math.min(caret + shift, formatted.length));
            try { input.setSelectionRange(newCaret, newCaret); } catch (e) {}
        }
        if (input && input.id === 'ocWorkHM') {
            if (activeGroupId) _syncOcWorkHoursToRgList(activeGroupId, input.value);
            _validateOcWorkHoursLimit();
        } else if (input && input.id && input.id.indexOf('txtWork_res_') === 0) {
            var val = String(input.value || '').trim();
            if (!val) {
                _setInputInlineValidation(input, '', 'txtWorkValidationMsg_' + input.id.replace('txtWork_res_', ''));
                input.classList.remove('oc-val-error');
            } else {
                var rowHours = _hhmmToDecimal(val);
                if (rowHours == null) {
                    _setInputInlineValidation(input, RES.A_WorkHHMMInvalid, 'txtWorkValidationMsg_' + input.id.replace('txtWork_res_', ''));
                    input.classList.add('oc-val-error');
                } else if (_wouldExceedProjectWorkHoursCap(rowHours, { additionalHoursFromOthers: _sumSelectedResourceWorkHours(input.id.replace('txtWork_res_', '')) })) {
                    _setInputInlineValidation(input, _projectWorkHoursExceededMessage(), 'txtWorkValidationMsg_' + input.id.replace('txtWork_res_', ''));
                    input.classList.add('oc-val-error');
                } else {
                    _setInputInlineValidation(input, '', 'txtWorkValidationMsg_' + input.id.replace('txtWork_res_', ''));
                    input.classList.remove('oc-val-error');
                }
            }
        } else if (input && input.id && input.id.indexOf('rrl-work-') === 0) {
            var rrlWorkVal = String(input.value || '').trim();
            if (!rrlWorkVal) {
                if (typeof clearRrlControlError === 'function') clearRrlControlError($(input));
            } else {
                var rrlWorkDec = _hhmmToDecimal(rrlWorkVal);
                var rrlWorkComplete = rrlWorkDec != null;
                if (rrlWorkComplete && rrlWorkDec != null) {
                    var $rrlRow = $(input).closest('tr');
                    var rrlGid = (($rrlRow.closest('tbody').attr('id') || '').replace('rrl-tbody-', ''));
                    var rrlPerId = parseInt($rrlRow.attr('data-project-employee-role-id'), 10) || 0;
                    if (_wouldExceedProjectWorkHoursCap(rrlWorkDec, { gid: rrlGid, excludeProjectEmployeeRoleId: rrlPerId })) {
                        if (typeof markRrlControl === 'function') markRrlControl($(input));
                    } else if (typeof clearRrlControlError === 'function') {
                        clearRrlControlError($(input));
                    }
                } else if (typeof clearRrlControlError === 'function') {
                    clearRrlControlError($(input));
                }
            }
        }
    }
    /* ── End of Work (HH:MM) input guard — Modified by Nikhil Mane on 17-04-2026 ── */

    /* ── Date helpers (display: DD MMM YYYY e.g. 01 May 2027) ── */
    var _MONTH_ABBR = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    function _parseDdMmYyyy(str) {
        if (!str || !str.trim()) return null;
        var p = str.trim().split('-');
        if (p.length !== 3) return null;
        var d = new Date(parseInt(p[2], 10), parseInt(p[1], 10) - 1, parseInt(p[0], 10));
        return isNaN(d.getTime()) ? null : d;
    }

    function _parseAnyDate(str) {
        if (str == null || str === undefined) return null;
        var s = String(str).trim();
        if (!s || s === '—') return null;
        if (/^\d{4}-\d{2}-\d{2}/.test(s)) {
            var iso = new Date(s);
            if (!isNaN(iso.getTime())) return iso;
        }
        var dmy = _parseDdMmYyyy(s);
        if (dmy) return dmy;
        var dmyDisplay = s.match(/^(\d{1,2})\s+([A-Za-z]{3})\s+(\d{4})$/);
        if (dmyDisplay) {
            var monKey = dmyDisplay[2].charAt(0).toUpperCase() + dmyDisplay[2].slice(1, 3).toLowerCase();
            for (var mi = 0; mi < _MONTH_ABBR.length; mi++) {
                if (_MONTH_ABBR[mi] === monKey) {
                    var parsedDisp = new Date(parseInt(dmyDisplay[3], 10), mi, parseInt(dmyDisplay[1], 10));
                    if (!isNaN(parsedDisp.getTime())) return parsedDisp;
                    break;
                }
            }
        }
        try { return $.datepicker.parseDate('dd M yy', s); } catch (e1) { /* ignore */ }
        try { return $.datepicker.parseDate('dd-mm-yy', s); } catch (e2) { /* ignore */ }
        return null;
    }

    function _fmtDisplayDate(dt) {
        if (!dt) return '';
        var d = (dt instanceof Date) ? dt : _parseAnyDate(dt);
        if (!d || isNaN(d.getTime())) return (typeof dt === 'string') ? String(dt).trim() : '';
        return String(d.getDate()).padStart(2, '0') + ' ' + _MONTH_ABBR[d.getMonth()] + ' ' + d.getFullYear();
    }

    function _fmtGroupDate(dt) {
        return _fmtDisplayDate(dt);
    }

    /* Keep textbox as DD MMM YYYY; datepicker uses dd-mm-yy only internally for setDate. */
    function _syncDateInputDisplay($input) {
        if (!$input || !$input.length) return;
        var parsed = _parseAnyDate($input.val());
        if (!parsed && $input.datepicker) {
            try { parsed = $input.datepicker('getDate'); } catch (e) { /* ignore */ }
        }
        var display = _fmtDisplayDate(parsed);
        if (display) $input.val(display);
        if ($input.hasClass('rg-start') || $input.hasClass('rg-end')) {
            setTimeout(function () {
                _syncBaRgDateInputTooltips();
                if (typeof reinitTooltips === 'function') reinitTooltips();
            }, 0);
        }
    }

    function _primeDisplayDatepicker($input, inst) {
        if (!$input || !$input.length) return null;
        var parsed = _parseAnyDate($input.val());
        if (!parsed || isNaN(parsed.getTime())) {
            try { parsed = $input.datepicker('getDate'); } catch (e) { parsed = null; }
        }
        if (parsed && !isNaN(parsed.getTime())) {
            $input.datepicker('option', 'defaultDate', parsed);
            $input.datepicker('setDate', parsed);
            $input.val(_fmtDisplayDate(parsed));
            if (inst) {
                inst.drawMonth = parsed.getMonth();
                inst.drawYear = parsed.getFullYear();
                inst.selectedMonth = parsed.getMonth();
                inst.selectedYear = parsed.getFullYear();
                inst.selectedDay = parsed.getDate();
            }
        }
        return parsed;
    }

    function _showDisplayDatepicker($input) {
        var $el = ($input && $input.jquery) ? $input : $($input);
        if (!$el.length) return;
        if (!$el.data('display-dp-init')) _applyDisplayDatepicker($el);
        _primeDisplayDatepicker($el);
        $el.datepicker('show');
    }

    function _applyDisplayDatepicker($el, onSelectCb) {
        if (!$el || !$el.length) return;
        if ($el.data('display-dp-init')) return;
        $el.data('display-dp-init', true);

        $el.datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: 'c-10:c+10',
            dateFormat: 'dd-mm-yy',
            beforeShow: function (input, inst) {
                _primeDisplayDatepicker($(input), inst);
            },
            onSelect: function () {
                var picked = $(this).datepicker('getDate');
                $(this).val(_fmtDisplayDate(picked));
                if ($(this).hasClass('rrl-date-input') && typeof clearRrlControlError === 'function') {
                    clearRrlControlError($(this));
                }
                if (typeof onSelectCb === 'function') onSelectCb.call(this);
            },
            onClose: function () {
                _syncDateInputDisplay($(this));
            }
        });

        $el.on('click focus', function () {
            var $input = $(this);
            setTimeout(function () { _syncDateInputDisplay($input); }, 0);
        });

        if ($el.hasClass('rrl-date-input')) {
            $el.on('keydown paste cut', function (e) { e.preventDefault(); });
        }
    }

    function openRrlDatepicker(inputId) {
        _showDisplayDatepicker($('#' + inputId));
    }

    /* ── Blur handlers ── */
    function onNoOfResBlur_group(gid, input) {
        var v = parseInt(input.value, 10);
        var maxResPerRole = _getMaxResourcesPerRole();
        if (!input.value.trim()) {
            _markError(input, false);
        } else if (isNaN(v) || v < 1) {
            _markError(input, true);
            _showValidationErrorOnce(_rowLabel(gid) + RES.A_NoOfResBetweenRow);
        } else if (maxResPerRole > 0 && v > maxResPerRole) {
            _markError(input, true);
            _showValidationErrorOnce(_rowLabel(gid) + _getNoOfResMaxExceededMsg(maxResPerRole));
        } else {
            _markError(input, false);
        }
    }

    function onAllocBlur_group(gid, input) {
        var allocVal = (input.value || '').toString().trim();
        var v = _parseIntegerAllocation(allocVal);
        if (!allocVal) {
            _markAllocWrapperError(gid, false);
        } else if (_isAllocationDecimalInvalid(allocVal)) {
            _markAllocWrapperError(gid, true);
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_allocationPctNoDecimalRowMsg(gid));
            _ensureValidationControlVisibleAndFocus(input);
        } else if (isNaN(v) || v < 1 || v > _maxAllocPct) {
            _markAllocWrapperError(gid, true);
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_rowLabel(gid) + _resFmt(RES.A_AllocationPctBetweenRow, _maxAllocPct));
            _ensureValidationControlVisibleAndFocus(input);
        } else {
            _markAllocWrapperError(gid, false);
            _maybeRefreshRgWorkHoursFromDates(gid);
        }
    }

    /* ═══════════════════════════════════════════════════════════════════════
       CORE SINGLE-GROUP VALIDATOR
       Returns { valid: bool, errors: [string] }
       Mirrors validateMandatoryFields + validateRowFields from BulkResourceReq.
    ═══════════════════════════════════════════════════════════════════════ */
    function validateGroupRow(gid) {
        var errors = [];
        var firstInvalidEl = null;
        var rowNum = _rowLabel(gid);

        /* ── Project date bounds only (no "today" check) ──
              Modified by Nikhil Mane on 17-04-2026: dates are validated only against
              project start / end dates; past-date restriction removed.              */
        var projStart = _projectStartDate ? (function () { var d = new Date(_projectStartDate); d.setHours(0, 0, 0, 0); return d; })() : null;
        var projEnd   = _projectEndDate   ? (function () { var d = new Date(_projectEndDate);   d.setHours(0, 0, 0, 0); return d; })() : null;

        /* 1. Employee Role — Modified by Nikhil Mane on 15-04-2026: renamed from Project Role */
        var roleVal = $('#rg-role-' + gid).val();
        if (!roleVal || roleVal === '' || roleVal === '0') {
            errors.push(rowNum + RES.A_EmpRoleNotBlank);
            _markRoleError(gid, true);
            if (!firstInvalidEl) firstInvalidEl = document.getElementById('rg-role-' + gid);
        } else {
            var duplicateRoleGid = _findDuplicateRoleGroupId(gid, roleVal);
            if (duplicateRoleGid !== null) {
                errors.push(rowNum + _resFmt(RES.A_DuplicateRoleEmployee, _getGroupDisplayNum(duplicateRoleGid)));
                _markRoleError(gid, true);
                if (!firstInvalidEl) firstInvalidEl = document.getElementById('rg-role-' + gid);
            } else {
                _markRoleError(gid, false);
            }
        }

        /* 2. No. of Resources — now user-editable; must be a whole number > 0 */
        var countEl = document.getElementById('rg-count-' + gid) ||
                      document.querySelector('.rg-count[data-group="' + gid + '"]');
        var countVal = countEl ? countEl.value.trim() : '';
        var countNum = parseInt(countVal, 10);
        if (!countVal) {
            errors.push(rowNum + RES.A_NoOfResBlnk);
            _markError(countEl, true);
            if (!firstInvalidEl) firstInvalidEl = countEl;
        } else if (isNaN(countNum) || countNum < 1) {
            errors.push(rowNum + RES.A_NoOfResBetweenRow);
            _markError(countEl, true);
            if (!firstInvalidEl) firstInvalidEl = countEl;
        } else {
            var maxResPerRole = _getMaxResourcesPerRole();
            if (maxResPerRole > 0 && countNum > maxResPerRole) {
                errors.push(rowNum + _getNoOfResMaxExceededMsg(maxResPerRole));
                _markError(countEl, true);
                if (!firstInvalidEl) firstInvalidEl = countEl;
            } else {
                _markError(countEl, false);
            }
        }

        /* 3. Planned Start Date
              Rules (modified by Nikhil Mane on 17-04-2026 — project bounds only):
              a) Not blank
              b) Valid date
              c) >= projectStartDate (if known)
              d) <= projectEndDate   (if known)                                      */
        var startEl   = document.getElementById('rg-start-' + gid);
        var startStr  = startEl ? startEl.value.trim() : '';
        var startDate = _parseAnyDate(startStr);
        if (!startStr) {
            errors.push(rowNum + RES.A_PlannedStartBlankRow);
            _markError(startEl, true);
            if (!firstInvalidEl) firstInvalidEl = startEl;
        } else if (!startDate) {
            errors.push(rowNum + RES.A_StartDateValid);
            _markError(startEl, true);
            if (!firstInvalidEl) firstInvalidEl = startEl;
        } else if (projStart && startDate < projStart) {
            errors.push(rowNum + RES.A_PlannedstDate + _fmtGroupDate(projStart) + RES.C_ValidationSuffix);
            _markError(startEl, true);
            if (!firstInvalidEl) firstInvalidEl = startEl;
        } else if (projEnd && startDate > projEnd) {
            errors.push(rowNum + RES.A_PlannedStProjEnddate + _fmtGroupDate(projEnd) + RES.C_ValidationSuffix);
            _markError(startEl, true);
            if (!firstInvalidEl) firstInvalidEl = startEl;
        } else {
            _markError(startEl, false);
        }

        /* 4. Planned End Date
              Rules (modified by Nikhil Mane on 17-04-2026 — project bounds only):
              a) Not blank
              b) Valid date
              c) >= Planned Start Date (if start is valid)
              d) <= projectEndDate    (if known)                                      */
        var endEl   = document.getElementById('rg-end-' + gid);
        var endStr  = endEl ? endEl.value.trim() : '';
        var endDate = _parseAnyDate(endStr);
        if (!endStr) {
            errors.push(rowNum + RES.A_PlannedEndBlankRow);
            _markError(endEl, true);
            if (!firstInvalidEl) firstInvalidEl = endEl;
        } else if (!endDate) {
            errors.push(rowNum + RES.A_PlannedEndDateNotValid);
            _markError(endEl, true);
            if (!firstInvalidEl) firstInvalidEl = endEl;
        } else if (startDate && endDate < startDate) {
            errors.push(rowNum + RES.A_PlannedEndDateNotBefore + _fmtGroupDate(startDate) + RES.C_ValidationSuffix);
            _markError(endEl, true);
            if (!firstInvalidEl) firstInvalidEl = endEl;
        } else if (projEnd && endDate > projEnd) {
            errors.push(rowNum + _resFmt(RES.A_PlannedEndAfterProject, _fmtGroupDate(projEnd)));
            _markError(endEl, true);
            if (!firstInvalidEl) firstInvalidEl = endEl;
        } else {
            _markError(endEl, false);
        }

        /* 5. % Allocation */
        var allocEl  = document.getElementById('rg-alloc-' + gid) ||
                       document.querySelector('.rg-alloc[data-group="' + gid + '"]');
        var allocVal = allocEl ? allocEl.value.trim() : '';
        var alloc    = _parseIntegerAllocation(allocVal);
        if (!allocVal) {
            errors.push(rowNum + RES.A_AllocationPctBlankRow);
            _markAllocWrapperError(gid, true);
            if (!firstInvalidEl) firstInvalidEl = allocEl;
        } else if (_isAllocationDecimalInvalid(allocVal)) {
            errors.push(rowNum + _allocationPctNoDecimalMsg());
            _markAllocWrapperError(gid, true);
            if (!firstInvalidEl) firstInvalidEl = allocEl;
        } else if (isNaN(alloc) || alloc < 1 || alloc > _maxAllocPct) {
            errors.push(rowNum + _resFmt(RES.A_AllocationPctBetweenRow, _maxAllocPct));
            _markAllocWrapperError(gid, true);
            if (!firstInvalidEl) firstInvalidEl = allocEl;
        } else {
            _markAllocWrapperError(gid, false);
        }

        return { valid: errors.length === 0, errors: errors, firstInvalidEl: firstInvalidEl };
    }

    /* Added by Nikhil Mane on 05-May-2026
       Returns true if a resource group already has allocated resources from either:
         (a) the DB-loaded RRL (rrl-badge count > 0) — rows allocated in a previous session
         (b) resources selected in the current session via the offcanvas (sel-res-body rows)
       Used as the single authoritative check across validation and role-locking logic. */
    function _groupHasAllocatedResources(gid) {
        /* Added By Dipali V On 26th May - Bulk row check uses selected resources only (RRL is single tab-level grid) */
        var sessionCount = document.querySelectorAll('#sel-res-body-' + gid + ' tr').length;
        return sessionCount > 0;
    }
    /* End of Added by Nikhil Mane on 05-May-2026 */

    /* Added By Dipali V On 5th Jun 2026 — highlight when project role is locked (resource selected) but not yet allocated */
    function _groupHasLockedProjectRole(gid) {
        var $roleSelect = $('#rg-role-' + gid);
        if ($roleSelect.length && $roleSelect.prop('disabled')) return true;
        if ($roleSelect.length && $roleSelect.closest('.bootstrap-select').hasClass('rg-role-locked')) return true;
        return $('#group-' + gid).attr('data-has-selection') === 'true';
    }

    /* Unified grid: .rg-row has display:contents (no box) — anchor tooltip on full-width band. */
    function _baRgUsesUnifiedGrid() {
        var container = document.getElementById('bulkAllocationGroupsContainer');
        return !!(container && container.classList.contains('ba-rg-unified-grid'));
    }

    function _baRgUnallocatedTooltipAnchor(gid) {
        if (_baRgUsesUnifiedGrid()) {
            return document.querySelector('#ba-rg-grid-surface-' + gid + ' .ba-rg-grid-band-data');
        }
        return document.getElementById('rg-row-' + gid);
    }

    function _clearBaRgUnallocatedTooltipHandlers(gid) {
        $('#rg-row-' + gid).children().off('.baUnallocTip');
        var band = document.querySelector('#ba-rg-grid-surface-' + gid + ' .ba-rg-grid-band-data');
        if (band) $(band).off('.baUnallocTip');
    }

    function _disposeBaRgUnallocatedTooltip(el) {
        if (!el || typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
        var inst = bootstrap.Tooltip.getInstance(el);
        if (inst) {
            inst.hide();
            inst.dispose();
        }
        $(el).removeAttr('data-bs-toggle data-bs-custom-class data-bs-placement data-bs-title title');
    }

    function _syncBaRoleUnallocatedHighlight(gid) {
        var $group = $('#group-' + gid);
        var $row = $('#rg-row-' + gid);
        if (!$group.length || !$row.length) return;

        /* Highlight only when resources are confirmed in list view (sel-res-body), not offcanvas checkboxes alone */
        var pending = $('#sel-res-body-' + gid + ' tr').length > 0;
        var tip = ((RES.C_ResourceSelectedNotAllocated || RES.C_RoleSelectedNotAllocated || '').toString().trim()
            || 'Resource selected but not allocated to the project.');

        $group.toggleClass('ba-role-unallocated', pending);
        var dataBand = document.querySelector('#ba-rg-grid-surface-' + gid + ' .ba-rg-grid-band-data');
        if (dataBand) dataBand.classList.toggle('ba-rg-band-unallocated', pending);

        _clearBaRgUnallocatedTooltipHandlers(gid);
        _disposeBaRgUnallocatedTooltip($row[0]);
        if (dataBand) _disposeBaRgUnallocatedTooltip(dataBand);

        var tipAnchor = _baRgUnallocatedTooltipAnchor(gid);
        if (!pending || !tipAnchor) return;

        var $anchor = $(tipAnchor);
        $anchor.attr('data-bs-toggle', 'tooltip');
        $anchor.attr('data-bs-custom-class', 'black-tooltip');
        $anchor.attr('data-bs-placement', 'top');
        $anchor.attr('data-bs-title', tip);
        $anchor.removeAttr('title');

        if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;

        var useManual = _baRgUsesUnifiedGrid();
        var tipInst = new bootstrap.Tooltip(tipAnchor, {
            trigger: useManual ? 'manual' : 'hover',
            html: false,
            container: 'body',
            boundary: 'viewport'
        });

        if (useManual) {
            var showTip = function () { tipInst.show(); };
            var hideTip = function () { tipInst.hide(); };
            $row.children().on('mouseenter.baUnallocTip', showTip).on('mouseleave.baUnallocTip', hideTip);
            if (dataBand) $(dataBand).on('mouseenter.baUnallocTip', showTip).on('mouseleave.baUnallocTip', hideTip);
        }
    }

    function _syncBaRoleUnallocatedHighlightAll() {
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            _syncBaRoleUnallocatedHighlight($(this).attr('data-group'));
        });
    }

    /* ═══════════════════════════════════════════════════════════════════════
       VALIDATE ALL GROUPS
       Called from: Allocate button / Add More button / Select Resource button
       actionLabel  = 'Allocate' | 'Select Resource' | 'Add More'
       onlyGroupId  = specific gid to validate, or null = validate all
       Returns true if all validations pass, false + alertify.error otherwise.
    ═══════════════════════════════════════════════════════════════════════ */
    function validateAllGroupsForAction(actionLabel, onlyGroupId) {
        var allErrors    = [];
        var firstInvalidEl = null;

        document.querySelectorAll('.resource-group').forEach(function (grpEl) {
            var gid = parseInt(grpEl.getAttribute('data-group'));
            if (onlyGroupId !== null && onlyGroupId !== undefined && gid !== parseInt(onlyGroupId)) return;
            /* Allocate: validate role row only when resources are confirmed in list view */
            if (actionLabel === 'Allocate' && document.querySelectorAll('#sel-res-body-' + gid + ' tr').length === 0) return;

            // Modified by Nikhil Mane on 05-May-2026 (corrected) — For "Add More", skip
            // field-level validation on rows that already have allocated resources.
            // A row is considered "already allocated" when either:
            //   (a) rrl-badge shows DB-allocated resources (count from the server RRL API), OR
            //   (b) sel-res-body has rows added in the current session via the offcanvas.
            // The previous fix only checked (b), so rows with DB-allocated resources (badge > 0
            // but sel-res-body empty) still triggered "No. of Resources should not be blank".
            if (actionLabel === 'Add More' && _groupHasAllocatedResources(gid)) return;

            var result = validateGroupRow(gid);
            if (!result.valid) {
                result.errors.forEach(function (e) { allErrors.push(e); });
                if (!firstInvalidEl && result.firstInvalidEl) firstInvalidEl = result.firstInvalidEl;
            }
        });

        if (allErrors.length > 0) {
            _showValidationErrorOnce(allErrors[0]);
            if (firstInvalidEl) _ensureValidationControlVisibleAndFocus(firstInvalidEl);
            return false;
        }

        /* For Add More: every pending group must have at least one resource selected */
        if (actionLabel === 'Add More') {
            var emptyGid = null;
            document.querySelectorAll('.resource-group').forEach(function (grpEl) {
                if (emptyGid !== null) return;
                var gid = parseInt(grpEl.getAttribute('data-group'));
                // For "Add More": rows that already have allocated resources (DB or session)
                // are complete — skip the empty-resource check so they don't block adding a new row.
                if (actionLabel === 'Add More' && _groupHasAllocatedResources(gid)) return;
                if (document.querySelectorAll('#sel-res-body-' + gid + ' tr').length === 0) {
                    emptyGid = gid;
                }
            });
            if (emptyGid !== null) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(_rowLabel(emptyGid) + RES.A_SelectResourceBeforeAction + (actionLabel === 'Add More' ? RES.A_AddingNewRow : RES.A_AllocatingAction));
                return false;
            }
        }

        // Modified by Nikhil Mane on 05-May-2026 — Allocate should require at least one
        // selected resource overall (not one per group), then validate only sub-table mandatory fields.
        if (actionLabel === 'Allocate') {
            var totalSelectedRows = document.querySelectorAll('tbody[id^="sel-res-body-"] tr').length;
            if (totalSelectedRows === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_PleaseSelectAtLeastOneResourceBeforeAllocating);
                return false;
            }
            /* Added By Dipali V On 16th Jun 2026 — reject Allocate when any confirmed resource has Availability (%) < 0 */
            if (!_validateBulkAllocSelectedAvailability(_collectConfirmedAllocResources())) return false;
            if (_isValiNoOfResourceForBulkEnabled()) {
                var countOk = true;
                document.querySelectorAll('.resource-group').forEach(function (grpEl) {
                    if (!countOk) return;
                    var gid = grpEl.getAttribute('data-group');
                    if (!gid) return;
                    var confirmed = $('#sel-res-body-' + gid + ' tr').length;
                    if (!confirmed) return;
                    if (!_validateResourceSelectionCount(gid, confirmed)) countOk = false;
                });
                if (!countOk) return false;
            }
        }
        // Added by Nikhil Mane on 15-04-2026 — validate per-resource sub-table fields
        if ((actionLabel === 'Allocate' || actionLabel === 'Add More') && !validateSelectedResourceRows()) return false;
        // End of Added by Nikhil Mane on 15-04-2026

        return true;
    }
    /* End of Added by Vyankat B. / Nikhil Mane on 10th April 2026 */

    /* ═══════════════════════════════════════════════════════════════════════
       ALLOCATE
       ═══════════════════════════════════════════════════════════════════════ */
    /* ═══════════════════════════════════════════════════════════════════════
       ALLOCATE
       POST /api/PM_BulkResourceAllocation/BulkAllocateResourcesMultiRole
       Added by Nikhil Mane on 09-04-2026
       ═══════════════════════════════════════════════════════════════════════ */
    // Modified by Nikhil Mane on 13-04-2026 — handleAllocate now shows confirm modal first
    function handleAllocate(skipProbableSkillCheck) {
        if (!_allocateTriggeredFromOffcanvas) {
            _allocateTriggeredFromOffcanvas = false;
        }
        
        /* ── Access guard — Added by Vyankat B. on 13-Apr-2026 ── */
        if (!addAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionAllocate);
            return;
        }
        /* ── Run full validation on all groups before proceeding ── */
        if (!validateAllGroupsForAction('Allocate', null)) return;

        if (!skipProbableSkillCheck) {
            _collectProbableUnackedSkillMismatchChecks(function (hasMismatch, ackFns) {
                if (hasMismatch) {
                    showBulkAllocResourceSkillDiffersConfirm(function () {
                        (ackFns || []).forEach(function (fn) { fn(); });
                        handleAllocate(true);
                    });
                    return;
                }
                handleAllocate(true);
            });
            return;
        }

        var pendingApproverEmpId = _baFindPendingDefaultApproverEmployeeId();
        if (pendingApproverEmpId && _needsDefaultApproverChangeConfirm(pendingApproverEmpId, 0, null, null) &&
            !window._baDefaultApproverChangeAcked) {
            _promptDefaultApproverChange(
                function () { _proceedToAllocateConfirmModal(); },
                function () { /* No — keep existing Default Approver */ }
            );
            return;
        }

        _proceedToAllocateConfirmModal();
    }

    /* Added by dipali v on 18th Jun 2026 for purpose — warn when already allocated + pending allocate exceeds project No. of Resources */
    function _proceedToAllocateConfirmModal() {
        if (!window._pendingAllocateExceedAcked && _shouldConfirmAllocateExceedProjectResources()) {
            showBulkAllocExceedProjectResourceConfirm(null, true);
            return;
        }
        window._pendingAllocateExceedAcked = false;
        _showAllocateConfirmModal();
    }

    function _showAllocateConfirmModal() {
        var modalEl = document.getElementById('allocateConfirmModal');
        if (modalEl) { bootstrap.Modal.getOrCreateInstance(modalEl).show(); }
    }

    function _bulkAllocApiResultText(response) {
        var result = (response && response.data !== undefined && response.data !== null) ? response.data : response;
        if (!result) return '';
        if (typeof result === 'string') return String(result);
        return String(result.result || result.Result || result.message || result.Message || '');
    }

    function _isBulkAllocateApiSuccess(response) {
        var statusVal = _bulkAllocApiResultText(response);
        if (!statusVal) return false;
        if (statusVal.toUpperCase().indexOf('ERROR:') === 0) return false;
        return statusVal.toUpperCase() === 'SUCCESS';
    }

    /* Added By Dipali V On 16th Jun 2026 — parse failed employee names from SP (tentative / joining / JSON) for partial allocate */
    function _parseBulkAllocFailedEmployeeNames(resultText) {
        var names = [];
        var raw = String(resultText || '').trim();
        if (!raw || raw.toUpperCase() === 'SUCCESS') return names;
        if (raw.toUpperCase().indexOf('ERROR:') === 0) raw = raw.substring(6).trim();

        try {
            var parsed = JSON.parse(raw);
            if (!Array.isArray(parsed)) parsed = [parsed];
            parsed.forEach(function (entry) {
                var failed = (entry && (entry.FailedEmployees || entry.failedEmployees)) || [];
                if (!Array.isArray(failed)) return;
                failed.forEach(function (n) {
                    var s = String(n == null ? '' : n).replace(/^"|"$/g, '').trim();
                    if (s && names.indexOf(s) === -1) names.push(s);
                });
            });
        } catch (e) { /* not JSON */ }
        if (names.length) return names;

        /* SP tentative failure: "Name1, Name2 can not be added to project as..." */
        var tentativeIdx = raw.toLowerCase().indexOf('can not be added to project');
        if (tentativeIdx > 0) {
            raw.substring(0, tentativeIdx).replace(/,\s*$/, '').split(',').forEach(function (n) {
                n = String(n || '').trim();
                if (n && names.indexOf(n) === -1) names.push(n);
            });
            if (names.length) return names;
        }

        /* SP joining-date failure: Resource "Name" Start Date On Project... */
        var joinMatch = raw.match(/Resource\s+"([^"]+)"\s+Start Date/i);
        if (joinMatch && joinMatch[1]) {
            names.push(joinMatch[1].trim());
            return names;
        }

        /* Legacy comma-separated failed names only */
        if (raw.indexOf('Start Date') < 0 && raw.indexOf('can not be added') < 0) {
            raw.split(',').forEach(function (n) {
                n = String(n || '').trim();
                if (n && names.indexOf(n) === -1) names.push(n);
            });
        }
        return names;
    }

    /* Added By Dipali V On 16th Jun 2026 — exclude only SP-failed resources; all other snapshot rows are treated as allocated and mailed */
    function _isBulkAllocRecipientFailed(recipient, failedNames) {
        var name = String((recipient && recipient.employeeName) || '').trim().toLowerCase();
        if (!name || !failedNames || !failedNames.length) return false;
        for (var i = 0; i < failedNames.length; i++) {
            var fail = String(failedNames[i] || '').trim().toLowerCase();
            if (!fail) continue;
            if (name === fail || name.indexOf(fail) >= 0 || fail.indexOf(name) >= 0) return true;
        }
        return false;
    }

    function _filterBulkAllocRecipientsExcludingFailed(allRecipients, failedNames) {
        if (!failedNames || !failedNames.length) return (allRecipients || []).slice();
        return (allRecipients || []).filter(function (r) {
            return !_isBulkAllocRecipientFailed(r, failedNames);
        });
    }

    /* Added By Dipali V On 16th Jun 2026 — every actually allocated resource in snapshot (full list or minus SP failures) */
    function _resolveBulkAllocEmailRecipientsForAllocated(emailRecipientsSnapshot, resultText) {
        var snapshot = emailRecipientsSnapshot || [];
        if (!snapshot.length) return [];
        return _filterBulkAllocRecipientsExcludingFailed(snapshot, _parseBulkAllocFailedEmployeeNames(resultText || ''));
    }

    function _formatBulkAllocTentativeLeavingMsg(failedNames) {
        if (!failedNames || !failedNames.length) return '';
        var suffix = (RES.A_AllocationTentativeLeavingDate || '').trim();
        if (!suffix) {
            suffix = 'can not be added to project as their Project End date is greater than Tentative leaving date';
        }
        return failedNames.join('<br>') + '<br>' + suffix;
    }

    /* Added By Dipali V On 16th Jun 2026 — failure alert text from SP (tentative / joining date) */
    function _formatBulkAllocAllocationFailureMsg(failedNames, resultText) {
        var raw = String(resultText || '').trim();
        if (raw.toUpperCase().indexOf('ERROR:') === 0) raw = raw.substring(6).trim();
        if (/Start Date On Project should not be less than Resource Joining Date/i.test(raw)) {
            return raw.replace(/\n/g, '<br>');
        }
        if (/can not be added to project/i.test(raw)) {
            return raw.replace(/\n/g, '<br>');
        }
        return _formatBulkAllocTentativeLeavingMsg(failedNames);
    }

    /* Added By Dipali V On 16th Jun 2026 — read SP Result from API error body (partial allocate still returns ERROR:) */
    function _bulkAllocRawResultTextFromXhr(xhr) {
        var raw = (xhr && xhr.responseText) ? String(xhr.responseText).trim() : '';
        if (!raw) return '';
        try {
            var err = JSON.parse(raw);
            if (err) {
                var errData = err.data || err.Data;
                if (typeof errData === 'string' && errData) return errData;
                if (errData && typeof errData === 'object') {
                    return String(errData.result || errData.Result || errData.message || errData.Message || '');
                }
                if (err.message || err.Message) return String(err.message || err.Message);
            }
        } catch (e) { /* plain-text SP response */ }
        return raw;
    }

    function _bulkAllocAlertMessageFromXhr(xhr) {
        var raw = (xhr && xhr.responseText) ? String(xhr.responseText).trim() : '';
        if (!raw) return RES.A_AllocationFailed;
        try {
            var err = JSON.parse(raw);
            if (err) {
                var errData = err.data || err.Data || err.message || err.Message || err.Result || err.result;
                if (typeof errData === 'string' && errData) raw = errData;
                else if (err.message || err.Message) raw = err.message || err.Message;
            }
        } catch (e) { /* plain-text SP response */ }
        raw = String(raw || '').trim();
        if (raw.indexOf('ERROR:') === 0) raw = raw.substring(6).trim();
        return raw || RES.A_AllocationFailed;
    }

    var _BULK_ALLOC_TOAST_SEC = 5;

    /* Added By Dipali V On 16th Jun 2026 — one dispatch per allocate; loops all recipients (personalized mail each) */
    function _dispatchBulkAllocationEmailsOnce(recipientsSnapshot, onDone) {
        if (_bulkAllocEmailsDispatched) {
            if (typeof onDone === 'function') onDone(0, 0);
            return;
        }
        if (!recipientsSnapshot || !recipientsSnapshot.length) {
            if (typeof onDone === 'function') onDone(0, 0);
            return;
        }
        _bulkAllocEmailsDispatched = true;
        sendAllocationEmail(recipientsSnapshot, false, onDone);
    }

    /* Added By Dipali V On 16th Jun 2026 — single common toasts: allocation OK + one "Email sent successfully" for all mailed resources */
    function _showBulkAllocSuccessToasts(emailSent, emailFailed) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.success(RES.A_ResourcesAllocatedSuccessfully, _BULK_ALLOC_TOAST_SEC);
        if (emailSent > 0) {
            alertify.success(RES.A_EmailSentSuccessfully, _BULK_ALLOC_TOAST_SEC);
        } else if (emailFailed > 0) {
            alertify.error(RES.A_EmailCouldNotBeSent, _BULK_ALLOC_TOAST_SEC);
        }
    }

    /* Added By Dipali V On 16th Jun 2026 — partial SP failure: mail every allocated resource, then show SP validation error */
    function _tryBulkAllocPartialSuccessUi(resultText, emailRecipientsSnapshot, onCloseOffcanvas) {
        var failedNames = _parseBulkAllocFailedEmployeeNames(resultText);
        if (!failedNames.length) return false;
        var okRecipients = _resolveBulkAllocEmailRecipientsForAllocated(emailRecipientsSnapshot, resultText);
        if (!okRecipients.length) return false;
        if (typeof onCloseOffcanvas === 'function') onCloseOffcanvas();
        _runBulkAllocPartialSuccessUi(okRecipients, failedNames, _formatBulkAllocAllocationFailureMsg(failedNames, resultText));
        return true;
    }

    /* Full success — email every resource in pre-allocate snapshot */
    function _runBulkAllocSuccessUi(emailRecipientsSnapshot) {
        var refreshAfterMs = (_BULK_ALLOC_TOAST_SEC + 1) * 1000;
        _dispatchBulkAllocationEmailsOnce(emailRecipientsSnapshot, function (sent, failed) {
            _showBulkAllocSuccessToasts(sent, failed);
            setTimeout(function () { resetPageToDefault(); }, refreshAfterMs);
        });
    }

    /* Partial success — sendAllocationEmail loops okRecipients so each allocated resource gets mail */
    function _runBulkAllocPartialSuccessUi(successRecipients, failedNames, failMsgOverride) {
        var refreshAfterMs = (_BULK_ALLOC_TOAST_SEC + 2) * 1000;
        var failMsg = failMsgOverride || _formatBulkAllocTentativeLeavingMsg(failedNames);
        _dispatchBulkAllocationEmailsOnce(successRecipients, function (sent, failed) {
            _showBulkAllocSuccessToasts(sent, failed);
            if (failMsg) {
                setTimeout(function () {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(failMsg, 8);
                }, 400);
            }
            setTimeout(function () { resetPageToDefault(); }, refreshAfterMs);
        });
    }

    function _setAllocateConfirmEnabled(enabled) {
        var btn = document.getElementById('btnConfirmAllocate');
        if (btn) btn.disabled = !enabled;
    }

    function _doAllocate() {
        if (_bulkAllocateInFlight) return;

        function _closeOffcanvasAfterAllocateIfNeeded() {
            if (!_allocateTriggeredFromOffcanvas) return;
            var offEl = document.getElementById('selectResourceOffcanvas');
            if (!offEl) return;
            try {
                var inst = bootstrap.Offcanvas.getInstance(offEl) || bootstrap.Offcanvas.getOrCreateInstance(offEl);
                if (inst) inst.hide();
            } catch (e) { /* ignore */ }
        }

        function _finishAllocateRequest() {
            _bulkAllocateInFlight = false;
            _setAllocateConfirmEnabled(true);
            _allocateTriggeredFromOffcanvas = false;
        }

        var roles = [];
        // Modified by Nikhil Mane on 05-May-2026 — build allocation payload from selected rows'
        // persisted configuration snapshot so Allocate works after main row fields are reset.
        var roleBucketMap = {};

        $('.resource-group').each(function () {
            var gid = $(this).data('group');
            $('#sel-res-body-' + gid + ' tr').each(function () {
                var $tr = $(this);
                var empId = parseInt($tr.attr('data-res-id'), 10) || parseInt($tr.data('resId'), 10) || 0;
                if (!empId) return;

                var uid = gid + '_' + empId;
                var roleId = parseInt($tr.attr('data-main-role-id'), 10) || 0;
                /* Added By Dipali V On 17th Jun 2026 — use current list-view dates on Allocate (data-start-iso can be stale after user edits) */
                var startISO = displayDateToISO($('.rg-start[data-group="' + gid + '"]').val()) || $tr.attr('data-start-iso') || null;
                var endISO = displayDateToISO($('.rg-end[data-group="' + gid + '"]').val()) || $tr.attr('data-end-iso') || null;
                var allocPct = _parseIntegerAllocation(($('.rg-alloc[data-group="' + gid + '"]').val() || '').toString().replace('%', '').trim());
                if (isNaN(allocPct) || allocPct < 1) allocPct = parseFloat($tr.attr('data-alloc-pct')) || 0;
                if (!roleId) return; /* skip malformed rows without captured role */
                var roleSkillFilters = (_pageSkillFilterEnabled ? getBulkAllocRoleSkillFilters(gid) : []);

                var bucketKey = [roleId, startISO || '', endISO || '', allocPct].join('|');
                if (!roleBucketMap[bucketKey]) {
                    roleBucketMap[bucketKey] = {
                        roleID:             roleId,
                        resourcePercentage: allocPct,
                        startDate:          startISO || null,
                        endDate:            endISO   || null,
                        rate:               0,
                        cost:               0,
                        selectedSkills:     roleSkillFilters,
                        resources:          []
                    };
                }

                // Added by Vyankat B. on 13-Apr-2026 — read per-resource Billable and IsDefaultApprover checkboxes
                var chkBill     = document.getElementById('chkBillable_res_' + uid);
                var chkApprover = document.getElementById('chkApprover_res_' + uid);
                var resBillable = chkBill ? chkBill.checked : ($tr.attr('data-billable') === '1');
                var resIsDefaultApprover = chkApprover ? chkApprover.checked : ($tr.attr('data-default-approver') === '1');
                // End of Added by Vyankat B. on 13-Apr-2026

                var bucketResources = roleBucketMap[bucketKey].resources;
                for (var br = 0; br < bucketResources.length; br++) {
                    if (parseInt(bucketResources[br].employeeID, 10) === empId) return;
                }

                var $rptSel = $('#cboReportingTo_res_' + uid);
                var $statusSel = $('#cboResStatus_res_' + uid);
                var $workInp = $('#txtWork_res_' + uid);
                bucketResources.push({
                    employeeID        : empId,
                    reportingTo       : parseInt($rptSel.length ? $rptSel.val() : ($tr.attr('data-reporting-to') || ''), 10) || 0,
                    resourceStatus    : ($statusSel.length ? $statusSel.val() : ($tr.attr('data-resource-status') || '')) || '',
                    budgetedHours     : ($workInp.length ? $workInp.val() : ($tr.attr('data-work-hm') || '')) || '',
                    responsibility    : _cleanRrlText($('#txtResponsibility_res_' + uid).val() || ''),
                    // Added by Vyankat B. on 13-Apr-2026
                    isResourceBillable   : resBillable,
                    isDefaultApprover    : resIsDefaultApprover
                    // End of Added by Vyankat B. on 13-Apr-2026
                });
            });
        });
        Object.keys(roleBucketMap).forEach(function (k) {
            if ((roleBucketMap[k].resources || []).length > 0) roles.push(roleBucketMap[k]);
        });

        if (roles.length === 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_AddResourceGroupWithResources);
            return;
        }

        if (_countDefaultApproversInRoleBucketMap(roleBucketMap) > 1) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_onlyOneDefaultApproverMessage());
            return;
        }

        var allocWorkCheck = _validateBulkAllocationWorkHoursTotal(null);
        if (!allocWorkCheck.ok) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(allocWorkCheck.message);
            return;
        }

        /* Global-level fields */
        // Modified by Nikhil Mane on 09-04-2026 — reportingTo removed from request root;
        // it is now a per-resource field inside each resources[] object.
        //debugger;
        var requestBody = {
            projectID:         parseInt(SessionProjectID) || 0,
            isProductOwner:    _getBulkAllocIsProductOwnerForApi(),
            userID:            parseInt(SessionUserID, 10) || 0,
            isSkillSearchEnabled: !!_pageSkillFilterEnabled,
            roles:             roles
        };
        // End of Added by Vyankat B. on 13-Apr-2026

        // Added by Vyankat B. on 10th April 2026 - Collect all resource EmployeeIDs for post-allocation email.
        var toEmpIdsForMail = [];
        for (var rIdx = 0; rIdx < roles.length; rIdx++) {
            var roleResources = roles[rIdx].resources || [];
            for (var eIdx = 0; eIdx < roleResources.length; eIdx++) {
                var rid = parseInt(roleResources[eIdx].employeeID, 10) || 0;
                if (rid > 0 && toEmpIdsForMail.indexOf(rid) === -1) toEmpIdsForMail.push(rid);
            }
        }
        // End of Added by Vyankat B. on 10th April 2026

        /* Snapshot all selected rows before API — used to mail every allocated resource after save */
        var emailRecipientsSnapshot = _captureBulkAllocEmailRecipients();
        _bulkAllocEmailsDispatched = false;
        _bulkAllocateInFlight = true;
        _setAllocateConfirmEnabled(false);

        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        alertify.set('notifier', 'position', 'top-right');
       // alertify.notify(RES.A_AllocatingResources, 'message', 3);
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/BulkAllocateResourcesMultiRole',
            JSON.stringify(requestBody), true,
            function (response) {
                try {
                    var resultText = _bulkAllocApiResultText(response);
                    if (_isBulkAllocateApiSuccess(response)) {
                        _closeOffcanvasAfterAllocateIfNeeded();
                        _runBulkAllocSuccessUi(emailRecipientsSnapshot);
                        return;
                    }
                    if (_tryBulkAllocPartialSuccessUi(resultText, emailRecipientsSnapshot, _closeOffcanvasAfterAllocateIfNeeded)) {
                        return;
                    }
                    /* No parseable partial failure — show raw error only */
                    alertify.set('notifier', 'position', 'top-right');
                    if (resultText.toUpperCase().indexOf('ERROR:') === 0) {
                        alertify.error(resultText.substring(6).trim());
                    } else {
                        alertify.error(RES.A_AllocationPartialFailures, 5);
                        _closeOffcanvasAfterAllocateIfNeeded();
                        setTimeout(function () { resetPageToDefault(); }, 1800);
                    }
                } catch (allocEx) {
                    console.error('BulkAllocateResourcesMultiRole success handler error:', allocEx);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.A_AllocationFailed);
                }
            },
            function (xhr) {
                /* API FAILURE with ERROR: may still have partial DB inserts — mail allocated, common success toast */
                var resultText = _bulkAllocRawResultTextFromXhr(xhr);
                if (!_tryBulkAllocPartialSuccessUi(resultText, emailRecipientsSnapshot, _closeOffcanvasAfterAllocateIfNeeded)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(_bulkAllocAlertMessageFromXhr(xhr));
                }
                console.error('BulkAllocateResourcesMultiRole error:', xhr.status, xhr.responseText);
            },
            function () {
                _finishAllocateRequest();
                _ensureStandaloneLoaderHidden();
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }
    // End of Modified by Nikhil Mane on 13-04-2026 (_doAllocate)
    // End of Added by Nikhil Mane on 09-04-2026

    /* ═══════════════════════════════════════════════════════════════════════
       SEND ALLOCATION EMAIL  (Added by Vyankat B. on 10th April 2026)
       Resolves each recipient via GetEmployeeEmailID; sender via same helper;
       fetches subject from GetEMessage (MessageID:503), then dispatches via
       /api/MyLeaves/SendMyLeavesEmail (same as My_Leaves.aspx).
       ═══════════════════════════════════════════════════════════════════════ */
    function _isBulkAllocEmailSendSuccess(emailResponse) {
        if (!emailResponse) return false;
        if (emailResponse.status === true || emailResponse.status === 'true') return true;
        if (emailResponse.Status === true || emailResponse.Status === 'SUCCESS' || emailResponse.Status === 'success') return true;
        if (emailResponse.data && (emailResponse.data.status === true || emailResponse.data.status === 'true')) return true;
        return false;
    }

    function _bulkAllocEmailHtmlBody(bodyText) {
        var raw = (bodyText || '').toString().trim();
        if (!raw) return '';
        if (/<html|<body/i.test(raw)) return raw;
        return "<html><body style='font-family: Arial, Helvetica, sans-serif; font-size:12px; color:#000;'>" +
            raw.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\n/g, '<br>') +
            '</body></html>';
    }

    function _getBulkAllocProjectName() {
        var el = document.getElementById('pdProjectName');
        var txt = el ? (el.textContent || '').trim() : '';
        if (!txt || txt === '—' || txt === 'N/A') return '';
        if (/spinner|error|loading/i.test(txt)) return '';
        return txt;
    }

    /* Reverse of encryptString() in Common.js — employee EmailID is often stored obfuscated in DB. */
    function _decryptObfuscatedString(enc) {
        if (enc == null || enc === undefined) return '';
        var s = String(enc).trim();
        if (!s) return '';
        if (s.indexOf('@') >= 0) return s;
        if (!/^\d+(-\d+)+$/.test(s)) return s;
        var parts = s.split('-');
        var intEncryptNum = 1;
        var out = '';
        for (var i = 0; i < parts.length; i++) {
            var code = parseInt(parts[i], 10);
            if (isNaN(code)) return s;
            out += String.fromCharCode(code - intEncryptNum);
            intEncryptNum += 2;
        }
        return out;
    }

    function _isValidEmailAddress(addr) {
        if (!addr || typeof addr !== 'string') return false;
        var s = addr.trim();
        if (!s || s.indexOf('@') < 1) return false;
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s);
    }

    function _resolveFromMailRows(apiResult) {
        if (!apiResult) return [];
        var d = apiResult.data !== undefined ? apiResult.data : apiResult.Data;
        if (Array.isArray(d)) return d;
        if (d && Array.isArray(d.data)) return d.data;
        if (d && Array.isArray(d.Data)) return d.Data;
        if (apiResult.employeeToMailResponse) return apiResult.employeeToMailResponse;
        return [];
    }

    function _pickEmployeeMailRow(rows, empId) {
        if (!rows || !rows.length) return null;
        var wantId = parseInt(empId, 10) || 0;
        if (wantId > 0) {
            for (var i = 0; i < rows.length; i++) {
                var rid = parseInt(rows[i].employeeID || rows[i].EmployeeID || 0, 10) || 0;
                if (rid === wantId) return rows[i];
            }
        }
        return rows[0];
    }

    function _normalizeEmployeeEmail(rawEmail) {
        var email = _decryptObfuscatedString(String(rawEmail || '').trim());
        if (!_isValidEmailAddress(email)) {
            var plain = String(rawEmail || '').trim();
            if (_isValidEmailAddress(plain)) email = plain;
        }
        return _isValidEmailAddress(email) ? email.trim() : '';
    }

    /* Per-employee allocation details for personalized notification emails. */
    function _captureBulkAllocEmailRecipients() {
        var list = [];
        var seenEmpIds = {};
        $('.resource-group').each(function () {
            var gid = $(this).data('group');
            var groupRoleText = ($('#rg-role-' + gid + ' option:selected').text() || '').trim();
            if (!groupRoleText || groupRoleText === RES.C_SelectRole) groupRoleText = '';
            $('#sel-res-body-' + gid + ' tr').each(function () {
                var $tr = $(this);
                var empId = parseInt($tr.attr('data-res-id'), 10) || parseInt($tr.data('resId'), 10) || 0;
                if (!empId || seenEmpIds[empId]) return;
                seenEmpIds[empId] = true;
                var name = ($tr.find('td:first strong').text() || '').trim();
                var rowRole = ($tr.find('td').eq(1).text() || '').trim();
                var roleText = rowRole || groupRoleText;
                var startDisp = ($tr.find('td').eq(2).text() || '').trim();
                var endDisp = ($tr.find('td').eq(3).text() || '').trim();
                var startIso = $tr.attr('data-start-iso') || '';
                var endIso = $tr.attr('data-end-iso') || '';
                var allocPct = $tr.attr('data-alloc-pct');
                if (allocPct == null || allocPct === '') {
                    allocPct = ($tr.find('td').eq(4).text() || '').trim();
                }
                list.push({
                    employeeID: empId,
                    employeeName: name,
                    projectRole: roleText,
                    startDate: startDisp || _fmtDisplayDate(_parseAnyDate(startIso)) || '',
                    endDate: endDisp || _fmtDisplayDate(_parseAnyDate(endIso)) || '',
                    allocationPct: String(allocPct != null ? allocPct : '').trim()
                });
            });
        });
        return list;
    }

    function _buildBulkAllocPersonalizedEmailHtml(recipient, projectName, senderName) {
        var r = recipient || {};
        var pn = (projectName || '').trim();
        var sn = (senderName || '').trim();
        var emp = escHtml((r.employeeName || '').trim());
        return "<html><body style='font-family: Arial, Helvetica, sans-serif; font-size:12px; color:#000;'>" +
            'Hi ' + (emp || 'Team Member') + ',<br><br>' +
            'This is to inform you that you have been assigned on the project with the following details<br><br>' +
            '<strong>Project Name :</strong> ' + escHtml(pn) + '<br>' +
            '<strong>Project Role :</strong> ' + escHtml((r.projectRole || '').trim()) + '<br>' +
            '<strong>Planned Start Date :</strong> ' + escHtml((r.startDate || '').trim()) + '<br>' +
            '<strong>Planned End Date :</strong> ' + escHtml((r.endDate || '').trim()) + '<br>' +
            '<strong>Allocation % :</strong> ' + escHtml((r.allocationPct || '').trim()) + '<br><br>' +
            'Regards<br>' + escHtml(sn) +
            '</body></html>';
    }

    function _applyBulkAllocEmailPlaceholders(subject, body, opts) {
        opts = opts || {};
        var projectName = (opts.projectName || _getBulkAllocProjectName() || '').trim();
        var senderName = (opts.senderName || FromemployeeName || FromuserName || EmployeeName || UserName || '').trim();
        var recipient = opts.recipient || {};
        var empName = (opts.employeeName || recipient.employeeName || '').trim();
        var roleName = (opts.projectRole || recipient.projectRole || '').trim();
        var startDate = (opts.startDate || recipient.startDate || '').trim();
        var endDate = (opts.endDate || recipient.endDate || '').trim();
        var allocPct = (opts.allocationPct != null ? opts.allocationPct : recipient.allocationPct);
        allocPct = (allocPct != null && allocPct !== undefined) ? String(allocPct).trim() : '';
        var isHtmlBody = /<html|<body/i.test(body || '');

        var sub = String(subject || '');
        var bod = String(body || '');

        var resourceLine = empName + (roleName ? (' - ' + roleName) : '');
        var map = {
            '<PROJECTNAME>': projectName,
            '<PROJECT NAME>': projectName,
            '<RESOURCES>': resourceLine,
            '<EMPLOYEENAME>': empName,
            '<EmployeeName>': empName,
            '<NAME>': empName,
            '<PROJECTROLE>': roleName,
            '<PROJECT ROLE>': roleName,
            '<PLANNEDSTARTDATE>': startDate,
            '<PLANNED START DATE>': startDate,
            '<STARTDATE>': startDate,
            '<FROM_DATE>': startDate,
            '<PLANNEDENDDATE>': endDate,
            '<PLANNED END DATE>': endDate,
            '<ENDDATE>': endDate,
            '<TO_DATE>': endDate,
            '<ALLOCATIONPCT>': allocPct,
            '<ALLOCATION %>': allocPct,
            '<ALLOCATION%>': allocPct,
            '<SENDER>': senderName,
            '<SENDER_NAME>': senderName,
            '<Send Name>': senderName
        };
        Object.keys(map).forEach(function (token) {
            var val = map[token];
            var re = new RegExp(token.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'gi');
            sub = sub.replace(re, val);
            bod = bod.replace(re, val);
        });
        if (isHtmlBody) {
            bod = bod.replace(/Hi\s+All,?/gi, 'Hi ' + empName + ',');
        } else {
            bod = bod.replace(/^Hi\s+All,?/gim, 'Hi ' + empName + ',');
        }
        return { subject: sub, body: bod };
    }

    function sendAllocationEmail(recipientsOrEmpIds, showToast, onComplete) {
        var _showToast = (showToast !== false);
        var sent = 0;
        var failed = 0;

        function _finishEmailDispatch() {
            if (typeof onComplete === 'function') onComplete(sent, failed);
        }

        function getMailByEmpId(empId) {
            if (!empId || empId <= 0) return null;

            /* Recipient address — by EmployeeID (same as PM_ProjectCharter.aspx). */
            var empReq = JSON.stringify({ EmployeeID: empId });
            var empRes = AJAXCallWithResult('api/PM_ProjectCharter/GetEmployeeEmailID', empReq, false, null, null, null, false);
            var empData = empRes && (empRes.data !== undefined ? empRes.data : empRes.Data);
            var emailRows = (empData && empData.PM_EmployeeEmailModel) || (empData && empData.pM_EmployeeEmailModel) || [];
            if (!Array.isArray(emailRows) || !emailRows.length) return null;
            var emailRow = emailRows[0] || {};
            var email = _normalizeEmployeeEmail(
                emailRow.employeeEmail || emailRow.EmployeeEmail || emailRow.emailID || emailRow.EmailID || ''
            );
            if (!email) return null;

            /* Display name — IR GetFromMail filtered by EmployeeID when available. */
            var nameReq = JSON.stringify({ EmpID: empId, RFIID: 0 });
            var nameRes = AJAXCallWithResult('api/IRApproval/GetFromMail', nameReq, false, null, null, null, false);
            var nameRows = _resolveFromMailRows(nameRes);
            var nameRow = _pickEmployeeMailRow(nameRows, empId) || {};

            return {
                email: email,
                userName: nameRow.userName || nameRow.UserName || '',
                employeeName: nameRow.employeeName || nameRow.EmployeeName || ''
            };
        }

        FromEmpId = (typeof SessionUserID !== 'undefined') ? (parseInt(SessionUserID, 10) || 0) : 0;
        var fromInfo = getMailByEmpId(FromEmpId);
        if (!fromInfo) {
            console.warn('sendAllocationEmail: unable to resolve From mail.');
            _finishEmailDispatch();
            return;
        }

        FromEmail = fromInfo.email || '';
        if (!_isValidEmailAddress(FromEmail)) {
            console.warn('sendAllocationEmail: invalid From mail address.');
            _finishEmailDispatch();
            return;
        }
        FromuserName = fromInfo.userName || '';
        FromemployeeName = fromInfo.employeeName || '';
        UserName = FromuserName;
        EmployeeName = FromemployeeName;
        CCEmail = FromEmail;
        CCUserName = UserName;
        CCEmployeeName = EmployeeName;

        var recipients = [];
        if (Array.isArray(recipientsOrEmpIds) && recipientsOrEmpIds.length > 0 &&
            recipientsOrEmpIds[0] && recipientsOrEmpIds[0].employeeID != null && recipientsOrEmpIds[0].employeeID !== undefined) {
            recipients = recipientsOrEmpIds.slice();
        } else if (window._lastBulkAllocEmailRecipients && window._lastBulkAllocEmailRecipients.length) {
            recipients = window._lastBulkAllocEmailRecipients.slice();
        } else {
            recipients = _captureBulkAllocEmailRecipients();
        }
        if (!recipients.length) {
            var toEmpIds = [];
            if (Array.isArray(recipientsOrEmpIds)) {
                for (var i = 0; i < recipientsOrEmpIds.length; i++) {
                    var rid = parseInt(recipientsOrEmpIds[i], 10) || 0;
                    if (rid > 0 && toEmpIds.indexOf(rid) === -1) toEmpIds.push(rid);
                }
            } else {
                var oneId = parseInt(recipientsOrEmpIds, 10) || 0;
                if (oneId > 0) toEmpIds.push(oneId);
            }
            for (var e = 0; e < toEmpIds.length; e++) {
                recipients.push({ employeeID: toEmpIds[e], employeeName: '', projectRole: '', startDate: '', endDate: '', allocationPct: '' });
            }
        }
        if (!recipients.length) {
            _finishEmailDispatch();
            return;
        }

        var emailParam = JSON.stringify({ MessageID: 503 });
        var emailResult = AJAXCallWithResult('api/IRApproval/GetEMessage', emailParam, false, null, null, null, false);
        var emailRows = (emailResult && emailResult.data)
            || (emailResult && emailResult.EMsgEntity)
            || (emailResult && emailResult.eMsgEntity)
            || [];
        var firstEmail = (emailRows && emailRows.length) ? emailRows[0] : {};
        var rawSubject = firstEmail.subject || firstEmail.Subject || firstEmail.emailSubject || firstEmail.EmailSubject || RES.C_ResourceAllocationEmailSubject;
        var rawBody = firstEmail.body || firstEmail.Body || firstEmail.emailBody || firstEmail.EmailBody || '';
        var projectName = _getBulkAllocProjectName();
        var senderName = FromemployeeName || FromuserName || EmployeeName || UserName;

        var sentEmpIds = {};
        var sentMailKeys = {};
        alertify.set('notifier', 'position', 'top-right');

        /* One personalized email per allocated resource; bulk allocate uses _showBulkAllocSuccessToasts for one common message */
        for (var t = 0; t < recipients.length; t++) {
            var rec = recipients[t] || {};
            var empId = parseInt(rec.employeeID, 10) || 0;
            if (!empId) { failed++; continue; }
            var empKey = String(empId);
            if (sentEmpIds[empKey]) continue;
            sentEmpIds[empKey] = true;

            var toInfo = getMailByEmpId(empId);
            if (!toInfo || !_isValidEmailAddress(toInfo.email)) { failed++; continue; }

            Toemail = toInfo.email;
            TouserName = toInfo.userName || '';
            ToemployeeName = toInfo.employeeName || rec.employeeName || '';
            if (!rec.employeeName && ToemployeeName) rec.employeeName = ToemployeeName;

            var ToMail = String(Toemail).trim().toLowerCase();
            if (sentMailKeys[ToMail]) continue;
            sentMailKeys[ToMail] = true;

            /* Subject may come from MessageID 503; body always uses per-employee format
               (DB template 503 only has PROJECTNAME/RESOURCES/SENDER — not dates/allocation). */
            var mergedSubject = _applyBulkAllocEmailPlaceholders(rawSubject, '', {
                projectName: projectName,
                senderName: senderName,
                recipient: rec
            });
            var emailSubject = mergedSubject.subject;
            var emailBody = _buildBulkAllocPersonalizedEmailHtml(rec, projectName, senderName);

            var emailRequestParam = {
                toEmailID: String(Toemail).trim(),
                ccEmailID: FromEmail || '',
                fromEmailID: FromEmail || '',
                subject: emailSubject,
                body: emailBody
            };
            var sendEmailResult = AJAXCallWithResult(
                'api/MyLeaves/SendMyLeavesEmail',
                JSON.stringify(emailRequestParam),
                false, null, null, null, false
            );
            if (_isBulkAllocEmailSendSuccess(sendEmailResult)) sent++; else failed++;
        }

        if (_showToast) {
            /* Standalone callers only — bulk allocate passes showToast=false and uses one common success toast */
            if (sent > 0) {
                alertify.success(RES.A_EmailSentSuccessfully, _BULK_ALLOC_TOAST_SEC);
            } else {
                alertify.error(RES.A_EmailCouldNotBeSent, _BULK_ALLOC_TOAST_SEC);
            }
        }
        window._lastBulkAllocEmailRecipients = null;
        _finishEmailDispatch();
    }
    // End of Added by Vyankat B. on 10th April 2026 - Send allocation email

    /* ═══════════════════════════════════════════════════════════════════════
       RESET PAGE TO DEFAULT  (Added by Vyankat B. on 10th April 2026)
       Clears all resource groups, resets all state variables, and re-adds a
       single blank group — identical to how the page loads fresh, but without
       a full server round-trip (preserves project details already loaded).
       ═══════════════════════════════════════════════════════════════════════ */
    function resetPageToDefault() {
        /* Modified 26-May-2026 — delegate to shared reload helper after cache bust */
        var _projectIdToReset = parseInt(SessionProjectID, 10) || 0;
        if (_projectIdToReset) { delete _rrlCacheByProject[_projectIdToReset]; }
        reloadPageDataForProject(true);
    }
    // End of Added by Vyankat B. on 10th April 2026 - Reset page to default

    /* ═══════════════════════════════════════════════════════════════════════
       HELPERS
       ═══════════════════════════════════════════════════════════════════════ */
    /* ── Returns projectStartDate as a Date for pre-filling the Start Date field.
          Modified by Nikhil Mane on 17-04-2026: default is the project start date,
          not max(today, projectStartDate). Falls back to today only when no
          project start date is available yet. ── */
    function _getEffectiveStartDate() {
        if (_projectStartDate) {
            var ps = new Date(_projectStartDate.getTime()); ps.setHours(0, 0, 0, 0);
            return ps;
        }
        var today = new Date(); today.setHours(0, 0, 0, 0);
        return today;
    }

    function prefillAllGroupDates() {
        if (!_projectStartRaw && !_projectEndRaw) return;
        // Start date = project start date; end date = project end date
        // Modified by Nikhil Mane on 17-04-2026
        var effectiveStart = _getEffectiveStartDate();
        var fmtStart = _fmtGroupDate(effectiveStart);
        var fmtEnd = isoLikeToDisplay(_projectEndRaw);
        $('.resource-group').each(function () {
            var gid = $(this).data('group');
            if (fmtStart) { $('.rg-start[data-group="' + gid + '"]').val(fmtStart); }
            if (fmtEnd) { $('.rg-end[data-group="' + gid + '"]').val(fmtEnd); }
            validateAndToggleButton(gid);
        });
        setTimeout(function () {
            if (typeof _syncBaRgDateInputTooltips === 'function') _syncBaRgDateInputTooltips();
            if (typeof reinitTooltips === 'function') reinitTooltips();
        }, 0);
    }

    /* Any supported display / legacy value → DD MMM YYYY */
    function isoLikeToDisplay(str) {
        return _fmtDisplayDate(str);
    }

    /* Display / legacy date → "yyyy-mm-ddT00:00:00" for API */
    function displayDateToISO(dateText) {
        var d = _parseAnyDate(dateText);
        if (!d) return '';
        var yyyy = d.getFullYear();
        var mm = String(d.getMonth() + 1).padStart(2, '0');
        var dd = String(d.getDate()).padStart(2, '0');
        return yyyy + '-' + mm + '-' + dd + 'T00:00:00';
    }

    function formatDateForMainTable(dateText) {
        return _fmtDisplayDate(dateText);
    }

    function escHtml(s) {
        if (s == null) return '';
        return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }

    function showResLoading(msg) {
        $('#resLoadingText').text(msg || 'Loading…');
        $('#resLoadingOverlay').addClass('show');
        $('#resourceTableBody').html('<tr><td colspan="7" class="text-center text-muted py-3">' + (msg || RES.C_LoadingEllipsis) + '</td></tr>');
    }
    function hideResLoading() { $('#resLoadingOverlay').removeClass('show'); }

    /* ═══════════════════════════════════════════════════════════════════════
       PROJECT DROPDOWN  (Added 26-May-2026 — PM_BulkResourceReq/GetProjectID)
       ═══════════════════════════════════════════════════════════════════════ */
    /* Normalizes API response to a project array (W26 wrapper or legacy array). */
    function _parseAccessibleProjectsResponse(response) {
        if (!response) return [];
        if (Array.isArray(response)) return response;
        if (response.data) {
            if (Array.isArray(response.data)) return response.data;
            if (Array.isArray(response.data.data)) return response.data.data;
            if (Array.isArray(response.data.bulkResourceAccessibleProjectModel)) {
                return response.data.bulkResourceAccessibleProjectModel;
            }
            if (Array.isArray(response.data.BulkResourceAccessibleProjectModel)) {
                return response.data.BulkResourceAccessibleProjectModel;
            }
        }
        return [];
    }

    function FillProjectCombox() {
        var sessionproj = SessionProjectID;
        if (SessionProjectID === '' || SessionProjectID == null) {
            sessionproj = 0;
        }
        var resourceParameters = {
            UserID: parseInt(SessionUserID, 10) || 0,
            ProjectID: parseInt(sessionproj, 10) || 0,
            LoginType: LoginType || '',
            ShowInactiveProjects: false
        };
        /* Sync project list — skip loader so init async APIs share one overlay (no hide/show flicker). */
        var strResult = AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetProjectID',
            JSON.stringify(resourceParameters),
            false, null, null, null, false
        );
        var list = _parseAccessibleProjectsResponse(strResult);
        var objCbo = document.getElementById('cboProjects');
        if (!objCbo) return;
        $('#cboProjects option').remove();
        if (list.length) {
            for (var i = 0; i < list.length; i++) {
                var proj = list[i];
                var pid = proj.ProjectID != null ? proj.ProjectID : proj.projectID;
                var pname = proj.ProjectName || proj.projectName || '';
                var opt = document.createElement('OPTION');
                objCbo.options.add(opt);
                opt.value = pid;
                opt.text = (pid === 0 || pid === '0') ? 'Select Project' : pname;
            }
        }
        if (SessionProjectID != null && SessionProjectID !== '' && SessionProjectID !== 0) {
            $('#cboProjects').val(String(SessionProjectID));
        }
        refreshProjectSelectpicker();
    }

    /* Refresh bootstrap-select on #cboProjects after dynamic option load. */
    function refreshProjectSelectpicker() {
        var $p = $('#cboProjects');
        if (!$p.length) return;
        if ($p.data('selectpicker')) {
            $p.selectpicker('refresh');
        }
    }

    /* Reload page data when user picks another project from the note-toolbar dropdown. */
    function onBulkProjectChange() {
        if (_suppressProjectChange) return true;
        var currentProjectId = $('#cboProjects').val();
        if (!currentProjectId || currentProjectId === '0') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectProject);
            return false;
        }
        var newProjectId = parseInt(currentProjectId, 10);
        if (newProjectId === parseInt(SessionProjectID, 10)) return true;
        SessionProjectID = newProjectId;
        _isExtendedEndDate = false;
        window._isExtendedEndDate = false;
        _rrlProjectEndWasExtended = false;
        window._rrlProjectEndWasExtended = false;
        _baColPrefsLoaded = false;
        _initialProjectDefaultApproverEmployeeId = 0;
        _projectDefaultApproverEmployeeId = 0;
        _projectDefaultApproverEmployeeName = '';
        window._reportingToAllRows = [];
        window._reportingToOptions = [];
        _resetRrlExtendRefreshGate(SessionProjectID);
        _skillDropdownLoaded = false;
        _bulkAllocProjectSkillsCache = null; /* Added By Dipali V On 26th May 2026 - refresh skills for new project; re-validate on toggle ON */
        if (_pageSkillFilterEnabled) {
            validateBulkAllocProjectHasSkills(function () { /* cache warmed */ }, function () {
                setPageSkillFilterEnabled(false, true);
            });
        }
        _bulkAllocSkillCounter = 0;
        _bulkAllocSkillCountersByGroup = {};
        if (typeof _rrlCacheByProject !== 'undefined' && SessionProjectID) {
            delete _rrlCacheByProject[SessionProjectID];
        }
        refreshBulkAllocationTabData();
        return true;
    }

    /* Added By Dipali V On 9th Jun 2026 — Refresh Bulk Allocation tab (mirrors Reallocation tab shown.bs.tab). */
    function refreshBulkAllocationTabData() {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) return;
        beginLoaderSession();
        LoadProjectDetails();
        checkIsExtended();
        _resetRrlExtendRefreshGate(SessionProjectID);
        loadBaColumnMaster(function () {
            LoadDefaultApprovers(SessionProjectID, function () {
                reloadPageDataForProject(false);
                endLoaderSession();
            });
        });
    }

    /* Clears groups/state and re-inits rows for the current SessionProjectID (no success toast). */
    function reloadPageDataForProject(showToast) {
        $('#bulkAllocationGroupsContainer').empty();
        $('#reallocationGroupsContainer').empty();
        _reallocationTabLoaded = false;
        _clearRrlPendingInlineEdits(_REALLOC_TAB_GID);
        updateReallocationEmptyState();
        _bulkAllocProjectSkillsCache = null; /* Added By Dipali V On 26th May 2026 */
        _bulkAllocSkillCounter = 0;
        _bulkAllocSkillCountersByGroup = {};
        groupCounter = 0;
        activeGroupId = null;
        tempSelected = new Set();
        RESOURCES = [];
        resourceByIdCache = {};
        selectedResourceMap = {};
        draftSelectedByGroup = {};
        draftSelectedObjByGroup = {};
        resourcePageNumber = 1;
        resourceTotalRecords = 0;
        resourceTotalPages = 0;
        FromEmail = '';
        UserName = '';
        EmployeeName = '';
        CCEmail = '';
        CCUserName = '';
        CCEmployeeName = '';
        $('#resourceTableBody').html('<tr><td colspan="7" class="text-center text-muted py-3">' + escHtml(RES.C_ClickSelectResourceToLoad) + '</td></tr>');
        updateResourcePaginationUI();
        document.getElementById('rdoExact').checked = !!_pageSkillFilterEnabled;
        document.getElementById('rdoProbable').checked = !_pageSkillFilterEnabled;
        syncMatchTypeUI();
        applyPageSkillToggleToOffcanvas();
        var pid = parseInt(SessionProjectID, 10) || 0;
        if (pid) { delete _rrlCacheByProject[pid]; }
        initGroupsByAllocatedRoles();
        var reallocActive = $('#tabReallocation').hasClass('show') || $('#tabReallocation').hasClass('active');
        if (reallocActive) {
            setTimeout(function () {
                loadReallocationTabAllocatedResources(true);
            }, 0);
        } else {
            _scheduleRrlExtendNoteRefresh();
        }
        //if (showToast) {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.success(RES.A_PageReset);
        //}
    }

    /* Added By Dipali V On 26th May - One Allocated Resources section on Reallocation tab */
    function ensureReallocationTabSection() {
        var created = !$('#group-rrl-' + _REALLOC_TAB_GID).length;
        if (created) {
            $('#reallocationGroupsContainer').html(buildReallocationGroupHtml(_REALLOC_TAB_GID));
            $('#reallocationEmptyMsg').addClass('d-none');
            $('#reallocationTabIntro').removeClass('d-none');
            reinitTooltips();
        }
        _scheduleRrlExtendNoteRefresh();
    }

    /* Added By Dipali V On 26th May - Load project allocated resources when Reallocation tab opens */
    function loadReallocationTabAllocatedResources(forceReload) {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) {
            $('#reallocationEmptyMsg').removeClass('d-none').text(RES.C_SelectProjectForAllocated);
            $('#reallocationGroupsContainer').empty();
            _reallocationTabLoaded = false;
            $('#rrl-tab-badge').text('0').addClass('empty');
            return;
        }
        ensureReallocationTabSection();
        if (_reallocationTabLoaded && !forceReload) return;
        _reallocationTabLoaded = true;
        loadAndRenderRrlForGroup(_REALLOC_TAB_GID, 0, null);
    }

    function updateReallocationEmptyState() {
        var hasSection = $('#group-rrl-' + _REALLOC_TAB_GID).length > 0;
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) {
            $('#reallocationEmptyMsg').removeClass('d-none');
            $('#reallocationTabIntro').addClass('d-none');
            return;
        }
        $('#reallocationEmptyMsg').toggleClass('d-none', hasSection || _reallocationTabLoaded);
        if (!hasSection && !_reallocationTabLoaded) {
            $('#rrl-tab-badge').text('0').addClass('empty');
        } else if (hasSection) {
            updateReallocationTabBadge();
        }
    }

    /* Skill ON/OFF switch below note — controls Exact Match skill filter and Set Skill visibility. */
    function initSkillToggle() {
        $('#chkSkillFilter').on('change', function () {
            var $chk = $(this);
            var wantOn = $chk.is(':checked');
            if (!wantOn) {
                setPageSkillFilterEnabled(false);
                return;
            }
            /* Added By Dipali V On 26th May 2026 - Skill validation for project specific skill configuration */
            /* Added By Dipali V On 16th Jun 2026 — third arg true: enable Search By Skill after skills saved from offcanvas */
            validateBulkAllocProjectHasSkills(function () {
                setPageSkillFilterEnabled(true);
            }, function () {
                $chk.prop('checked', false);
                setPageSkillFilterEnabled(false, true);
            }, true);
        });
        setPageSkillFilterEnabled(_pageSkillFilterEnabled, true);
    }

    function _bulkAllocConfirmAddProjectSkillsMessage() {
        var msg = (RES.C_ConfirmAddProjectSkillsMsg || RES.C_NoProjectSkillsMsg || '').toString().trim();
        if (msg) return msg;
        return 'Selected project does not have skills configured. Do you want to add skills to the project?';
    }

    /* Added By Dipali V On 26th May 2026 - Confirm when selected project has no skills mapped (replaces Alertify error) */
    /* Modified By Dipali V On 16th Jun 2026 — enableToggleAfterSave: remember if Search By Skill toggle should turn ON after save */
    function showBulkAllocNoProjectSkillsConfirm(onNo, enableToggleAfterSave) {
        window._bulkAllocNoProjectSkillsOnNo = (typeof onNo === 'function') ? onNo : null;
        _baSkillSelEnableToggleAfterSave = !!enableToggleAfterSave; /* Added By Dipali V On 16th Jun 2026 */
        var $msg = $('#noProjectSkillsConfirmMessage');
        if ($msg.length) $msg.text(_bulkAllocConfirmAddProjectSkillsMessage());
        var modalEl = document.getElementById('noProjectSkillsConfirmModal');
        if (!modalEl) {
            if (typeof onNo === 'function') onNo();
            return;
        }
        bootstrap.Modal.getOrCreateInstance(modalEl).show();
    }

    function closeBulkAllocNoProjectSkillsConfirm() {
        var modalEl = document.getElementById('noProjectSkillsConfirmModal');
        if (modalEl) bootstrap.Modal.getOrCreateInstance(modalEl).hide();
        window._bulkAllocNoProjectSkillsOnNo = null;
    }

    /* Added By Dipali V On 26th May 2026 - Skill validation for project specific skill configuration (toggle ON / Set Skill) */
    /* Modified By Dipali V On 16th Jun 2026 — enableToggleAfterSave passed to no-skills confirm for offcanvas save flow */
    function validateBulkAllocProjectHasSkills(onOk, onFail, enableToggleAfterSave) {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectProject);
            if (typeof onFail === 'function') onFail();
            return;
        }
        function finish(list) {
            if (list && list.length > 0) {
                if (typeof onOk === 'function') onOk(list);
            } else {
                showBulkAllocNoProjectSkillsConfirm(onFail, enableToggleAfterSave);
            }
        }
        if (_bulkAllocProjectSkillsCache !== null) {
            finish(_bulkAllocProjectSkillsCache);
            return;
        }
        LoadBulkAllocProjectSkills(finish, onFail);
    }

    function setPageSkillFilterEnabled(enabled, skipReload) {
        _pageSkillFilterEnabled = !!enabled;
        $('#chkSkillFilter').prop('checked', _pageSkillFilterEnabled);
        $('#skillSwitchStateText')
            //.text(_pageSkillFilterEnabled ? 'ON' : 'OFF')
            .toggleClass('off', !_pageSkillFilterEnabled);
        applyPageSkillToggleToOffcanvas();
        syncBulkAllocSetSkillVisibility(); /* Added By Dipali V On 26th May 2026 */
        if (!skipReload && activeGroupId) {
            if (_pageSkillFilterEnabled && getMatchType() !== 'exact') {
                document.getElementById('rdoExact').checked = true;
                document.getElementById('rdoProbable').checked = false;
                onMatchTypeChange();
                return;
            }
            if (getMatchType() === 'exact') {
                resourcePageNumber = 1;
                LoadExactMatchResources(activeGroupId);
            }
        }
    }

    /* Added By Dipali V On 26th May 2026 - Show/hide Set Skill links based on page Skill switch */
    function syncBulkAllocSetSkillVisibility() {
        var show = _pageSkillFilterEnabled && addAccess;
        $('.rg-set-skill-row').toggle(show);
        if (!show) {
            $('.bulk-skill-section').removeClass('open');
        }
    }

    /* Added By Dipali V On 26th May 2026 - Parse project skills API response */
    function _parseBulkAllocProjectSkillsResponse(response) {
        if (!response) return [];
        if (Array.isArray(response)) return response;
        if (response.data) {
            if (Array.isArray(response.data)) return response.data;
            if (Array.isArray(response.data.data)) return response.data.data;
            if (Array.isArray(response.data.bulkAllocProjectSkillModel)) return response.data.bulkAllocProjectSkillModel;
            if (Array.isArray(response.data.BulkAllocProjectSkillModel)) return response.data.BulkAllocProjectSkillModel;
        }
        return [];
    }

    /* Added By Dipali V On 26th May 2026 - Load project skills via SP (on Set Skill / Add Skill Set / toggle ON only) */
    function LoadBulkAllocProjectSkills(onDone, onError) {
        if (_bulkAllocProjectSkillsCache !== null) {
            if (typeof onDone === 'function') onDone(_bulkAllocProjectSkillsCache);
            return;
        }
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectProject);
            if (typeof onError === 'function') onError();
            return;
        }
        var param = JSON.stringify({ ProjectID: projectId });
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetProjectSkillsForBulkAlloc',
            param, true,
            function (response) {
                _bulkAllocProjectSkillsCache = _parseBulkAllocProjectSkillsResponse(response);
                if (typeof onDone === 'function') onDone(_bulkAllocProjectSkillsCache);
            },
            function () {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_FailedLoadProjectSkills);
                if (typeof onError === 'function') onError();
            }
        );
    }

    /* Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas: open panel and load available skills (replaces PM_ToolsSkills navigation) */
    function openBulkAllocSkillsSelectionOffcanvas(enableToggleAfterSave) {
        _baSkillSelEnableToggleAfterSave = !!enableToggleAfterSave;
        _baSkillSelCheckedIds = new Set();
        _baSkillSelPage = 1;
        $('#baSkillSubCategory').val('0');
        $('#baSkillSearchInput').val('');
        $('#baSkillSelectionBody').html('<tr><td colspan="2" class="text-center text-muted py-3">' + escHtml(RES.C_LoadingEllipsis || 'Loading...') + '</td></tr>');
        var ocEl = document.getElementById('baSkillsSelectionOffcanvas');
        if (ocEl) bootstrap.Offcanvas.getOrCreateInstance(ocEl).show();
        loadBaAvailableSkillsForSelection();
    }

    function _parseBulkAllocAvailableSkillsResponse(response) {
        if (!response) return [];
        if (Array.isArray(response)) return response;
        if (response.data) {
            if (Array.isArray(response.data)) return response.data;
            if (Array.isArray(response.data.data)) return response.data.data;
            if (Array.isArray(response.data.pM_ToolsSkillAvb)) return response.data.pM_ToolsSkillAvb;
            if (Array.isArray(response.data.PM_ToolsSkillAvb)) return response.data.PM_ToolsSkillAvb;
        }
        return [];
    }

    /* Added By Dipali V On 16th Jun 2026 — Skill row helpers for offcanvas table (id, category, description) */
    function _getBaSkillItemId(item) {
        return parseInt(item.toolID || item.ToolID || 0, 10) || 0;
    }

    function _getBaSkillItemCategoryId(item) {
        return parseInt(item.tools_CategoryID || item.Tools_CategoryID || 0, 10) || 0;
    }

    function _getBaSkillItemDescription(item) {
        return String(item.description || item.Description || '').trim();
    }

    /* Added By Dipali V On 16th Jun 2026 — Load available skills via API for Skills Selection offcanvas */
    function loadBaAvailableSkillsForSelection() {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectProject);
            return;
        }
        var param = JSON.stringify({ ProjID: projectId, IsSkill: true });
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetAvailableSkillsOrToolsOfProjectsByProjectID',
            param, true,
            function (response) {
                _baAvailableSkillsAll = _parseBulkAllocAvailableSkillsResponse(response) || [];
                _fillBaSkillSubCategoryOptions();
                _filterBaAvailableSkills();
            },
            function () {
                _baAvailableSkillsAll = [];
                _baAvailableSkillsFiltered = [];
                renderBaSkillSelectionPage();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_FailedLoadProjectSkills);
            }
        );
    }

    /* Added By Dipali V On 16th Jun 2026 — Build Skill Sub Category dropdown from loaded available skills */
    function _fillBaSkillSubCategoryOptions() {
        var $ddl = $('#baSkillSubCategory');
        var prev = String($ddl.val() || '0');
        var cats = {};
        _baAvailableSkillsAll.forEach(function (item) {
            var cid = _getBaSkillItemCategoryId(item);
            if (cid > 0) {
                cats[cid] = String(item.categoryName || item.CategoryName || ('Category ' + cid)).trim();
            }
        });
        $ddl.find('option:not(:first)').remove();
        Object.keys(cats).sort(function (a, b) {
            return cats[a].localeCompare(cats[b]);
        }).forEach(function (cid) {
            $ddl.append(new Option(cats[cid], cid));
        });
        if ($ddl.find('option[value="' + prev + '"]').length) $ddl.val(prev);
        else $ddl.val('0');
    }

    /* Added By Dipali V On 16th Jun 2026 — Filter skills by sub category and search text */
    function _filterBaAvailableSkills() {
        var subCat = parseInt($('#baSkillSubCategory').val(), 10) || 0;
        var q = String($('#baSkillSearchInput').val() || '').trim().toLowerCase();
        _baAvailableSkillsFiltered = _baAvailableSkillsAll.filter(function (item) {
            var id = _getBaSkillItemId(item);
            if (id <= 0) return false;
            if (subCat > 0 && _getBaSkillItemCategoryId(item) !== subCat) return false;
            if (q && _getBaSkillItemDescription(item).toLowerCase().indexOf(q) < 0) return false;
            return true;
        });
        _baSkillSelPage = 1;
        renderBaSkillSelectionPage();
    }

    /* Added By Dipali V On 16th Jun 2026 — Sub category change handler for Skills Selection offcanvas */
    function onBaSkillSubCategoryChange() { _filterBaAvailableSkills(); }
    /* Added By Dipali V On 16th Jun 2026 — Search input handler for Skills Selection offcanvas */
    function onBaSkillSearchInput() { _filterBaAvailableSkills(); }

    /* Added By Dipali V On 16th Jun 2026 — Render paginated skills table with Skills / Select columns */
    function renderBaSkillSelectionPage() {
        var $body = $('#baSkillSelectionBody');
        var total = _baAvailableSkillsFiltered.length;
        var totalPages = _baSkillSelPageSize > 0 ? Math.ceil(total / _baSkillSelPageSize) : 0;
        if (_baSkillSelPage > totalPages && totalPages > 0) _baSkillSelPage = totalPages;
        if (_baSkillSelPage < 1) _baSkillSelPage = 1;

        if (!total) {
            $body.html('<tr><td colspan="2" class="text-center text-muted py-3">' + escHtml(RES.C_NoRecordsToView || 'No records to view') + '</td></tr>');
        } else {
            var start = (_baSkillSelPage - 1) * _baSkillSelPageSize;
            var pageRows = _baAvailableSkillsFiltered.slice(start, start + _baSkillSelPageSize);
            var html = '';
            pageRows.forEach(function (item) {
                var id = _getBaSkillItemId(item);
                var desc = escHtml(_getBaSkillItemDescription(item) || ('Skill ' + id));
                var sid = String(id);
                var checked = _baSkillSelCheckedIds.has(sid) ? ' checked' : '';
                html += '<tr>' +
                    '<td><span>' + desc + '</span></td>' +
                    '<td class="text-center"><div class="custom_chckbox">' +
                    '<input type="checkbox" class="mainchck ba-skill-sel-chk" id="baSkillChk_' + id + '" value="' + id + '"' + checked + ' onchange="onBaSkillRowCheck(this)">' +
                    '<label for="baSkillChk_' + id + '"></label></div></td></tr>';
            });
            $body.html(html);
        }

        $('#baSkillPagerTotal').text('Total Records: ' + total);
        $('#btnBaSkillPrev').prop('disabled', _baSkillSelPage <= 1 || total === 0);
        $('#btnBaSkillNext').prop('disabled', totalPages <= 0 || _baSkillSelPage >= totalPages || total === 0);
    }

    /* Added By Dipali V On 16th Jun 2026 — Track checkbox selection across pagination pages */
    function onBaSkillRowCheck(el) {
        var id = String(el && el.value ? el.value : '');
        if (!id) return;
        if (el.checked) _baSkillSelCheckedIds.add(id);
        else _baSkillSelCheckedIds.delete(id);
    }

    /* Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas pagination: previous page */
    function onBaSkillPrevPage() {
        if (_baSkillSelPage <= 1) return;
        _baSkillSelPage--;
        renderBaSkillSelectionPage();
    }

    /* Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas pagination: next page */
    function onBaSkillNextPage() {
        var totalPages = _baSkillSelPageSize > 0 ? Math.ceil(_baAvailableSkillsFiltered.length / _baSkillSelPageSize) : 0;
        if (totalPages > 0 && _baSkillSelPage >= totalPages) return;
        _baSkillSelPage++;
        renderBaSkillSelectionPage();
    }

    /* Added By Dipali V On 16th Jun 2026 — Save selected skills to tbl_PM_ProjectTools; alert if none selected */
    function saveBaProjectSkillsSelection() {
        if (!_baSkillSelCheckedIds || _baSkillSelCheckedIds.size === 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectAtleastOneSkill || 'Please select at least one skill.');
            return;
        }
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectProject);
            return;
        }
        var ids = Array.from(_baSkillSelCheckedIds).map(function (x) { return parseInt(x, 10); }).filter(function (x) { return x > 0; });
        if (!ids.length) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectAtleastOneSkill || 'Please select at least one skill.');
            return;
        }
        var param = JSON.stringify({
            ProjectID: projectId,
            CreatedBy: SessionUserName || '',
            SelectedSkillIDs: ids
        });
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/SaveProjectSkillsForBulkAlloc',
            param, true,
            function () {
                _bulkAllocProjectSkillsCache = null;
                var ocEl = document.getElementById('baSkillsSelectionOffcanvas');
                if (ocEl) bootstrap.Offcanvas.getOrCreateInstance(ocEl).hide();
                LoadBulkAllocProjectSkills(function () {
                    if (_baSkillSelEnableToggleAfterSave) setPageSkillFilterEnabled(true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(RES.A_SkillsSavedSuccessfully || 'Skills saved successfully.');
                });
            },
            function () {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_FailedLoadProjectSkills || 'Failed to save skills.');
            }
        );
    }
    /* End of Added By Dipali V On 16th Jun 2026 — Skills Selection offcanvas */

    /* Clone only native <select> from templates — unwrap select before removing bootstrap-select shells. */
    function _bulkAllocSkillTmpl(tmplId, counter) {
        var el = document.getElementById(tmplId);
        if (!el) return '';
        var tmp = document.createElement('div');
        tmp.innerHTML = el.innerHTML;
        tmp.querySelectorAll('.bootstrap-select').forEach(function (wrap) {
            var innerSel = wrap.querySelector('select');
            if (innerSel) {
                wrap.parentNode.insertBefore(innerSel, wrap);
            }
            wrap.remove();
        });
        tmp.querySelectorAll('.dropdown-menu').forEach(function (n) { n.remove(); });
        var sel = tmp.querySelector('select');
        var html = sel ? sel.outerHTML : '';
        if (!html && tmplId === 'tmpl-ba-skill-master') {
            html = '<select id="cboSkillMasterNameBA" name="cboSkillMasterNameBA" class="selectpicker form-control skill-select" data-live-search="true" data-width="100%" data-container="body" title="Select Skill"><option value="0">Select Skill</option></select>';
        }
        return html
            .replace(/cboSkillMasterNameBA/g, 'cboSkillMaster' + counter)
            .replace(/cboMonthNameBA/g, 'cboMonth' + counter)
            .replace(/cboYearNameBA/g, 'cboYear' + counter)
            .replace(/cboParametersNameBA/g, 'cboParameters' + counter);
    }

    function _safeBulkAllocSelectpicker($el, opts) {
        if (!$el || !$el.length || !$el.is('select')) return;
        try {
            if ($el.data('selectpicker')) $el.selectpicker('destroy');
        } catch (e) { /* ignore */ }
        var $parentWrap = $el.parent('.bootstrap-select');
        if ($parentWrap.length) {
            $el.insertBefore($parentWrap);
            $parentWrap.remove();
        }
        $el.next('.bootstrap-select').remove();
        $el.removeClass('bs-select-hidden').css({ display: '', width: '', height: '', position: '', opacity: '', pointerEvents: '' });
        if (!$el.hasClass('selectpicker')) $el.addClass('selectpicker');
        var settings = opts || { liveSearch: true, width: '100%', container: 'body' };
        $el.selectpicker(settings);
    }

    /* Added By Dipali V On 26th May 2026 - Skill column: populate project-specific skill dropdown from API cache */
    function _fillBulkAllocSkillSelect(sel, selectedVal) {
        if (!sel) return;
        var $sel = $(sel);
        try {
            if ($sel.data('selectpicker')) $sel.selectpicker('destroy');
        } catch (e) { /* ignore */ }
        var $parentWrap = $sel.parent('.bootstrap-select');
        if ($parentWrap.length) {
            $sel.insertBefore($parentWrap);
            $parentWrap.remove();
        }
        $sel.next('.bootstrap-select').remove();
        while (sel.options.length > 0) sel.remove(0);
        var opt0 = document.createElement('option');
        opt0.value = '0';
        opt0.text = 'Select Skill';
        sel.add(opt0);
        (_bulkAllocProjectSkillsCache || []).forEach(function (item) {
            var id = item.toolID != null ? item.toolID : item.ToolID;
            var name = item.description || item.Description || '';
            if (!id || !name) return;
            var o = document.createElement('option');
            o.value = id;
            o.text = name;
            sel.add(o);
        });
        if (selectedVal) $sel.val(String(selectedVal));
    }

    function _nextBulkAllocSkillCounter(gid) {
        var c = _bulkAllocSkillCounter++;
        if (!_bulkAllocSkillCountersByGroup[gid]) _bulkAllocSkillCountersByGroup[gid] = [];
        _bulkAllocSkillCountersByGroup[gid].push(c);
        return c;
    }

    /* Added By Dipali V On 26th May - Initialise selectpicker UI inside Set Skill panel (one instance per select) */
    function initBulkAllocSkillSelectpickers(gid, counter) {
        try {
            var $scope = counter != null
                ? $('#bulk-skill-tbody-' + gid + ' tr#BA_' + gid + '_' + counter)
                : $('#bulk-skill-tbody-' + gid);
            if (!$scope.length) return;
            $scope.find('select.selectpicker').each(function () {
                var $el = $(this);
                var isSkill = (this.id || '').indexOf('cboSkillMaster') === 0;
                _safeBulkAllocSelectpicker($el, isSkill ? {
                    liveSearch: true,
                    width: '100%',
                    container: 'body',
                    noneSelectedText: 'Select Skill',
                    title: 'Select Skill'
                } : {
                    liveSearch: true,
                    width: '100%',
                    container: 'body'
                });
            });
        } catch (e) { /* ignore */ }
    }

    /* Added By Dipali V On 26th May 2026 - Toggle Set Skill panel for a role group */
    window.toggleBulkAllocSkill = function (gid) {
        if (!addAccess || !_pageSkillFilterEnabled) return;
        var roleVal = $('#rg-role-' + gid).val();
        if (!roleVal || roleVal === '' || roleVal === '0') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_SelectRoleBeforeSkills);
            return;
        }
        var $sec = $('#bulk-skill-section-' + gid);
        if ($sec.hasClass('open')) {
            $sec.removeClass('open');
            return;
        }
        /* Added By Dipali V On 26th May 2026 - Skill validation for project specific skill configuration */
        validateBulkAllocProjectHasSkills(function () {
            $sec.addClass('open');
            /* Added By Dipali V On 26th May - Auto-add first skill row when panel opens */
            var tbody = document.getElementById('bulk-skill-tbody-' + gid);
            if (tbody && !tbody.querySelector('tr')) {
                addBulkAllocSkillRow(gid);
            } else {
                initBulkAllocSkillSelectpickers(gid);
            }
            reinitTooltips();
        }, function () {
            $sec.removeClass('open');
        });
    };

    /* Added By Dipali V On 26th May 2026 - Add skill row in Set Skill panel */
    window.addBulkAllocSkillRow = function (gid) {
        if (!addAccess) return;
        var tbody = document.getElementById('bulk-skill-tbody-' + gid);
        if (!tbody) return;

        /* Maximum skills per role from GetProjectDetails — Count_Request_ResourceSkill (0 = no limit) */
        var maxSkills = _getMaxSkillsPerRole();
        var existingSkillRowsCount = tbody.querySelectorAll('tr').length;
        if (maxSkills > 0 && existingSkillRowsCount >= maxSkills) {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.error(_resFmt(RES.A_Max4Skills, maxSkills));
            alertify.error(
                RES.A_Max4Skills.replace('4', maxSkills)
            );
            return;
        }

        var existingRows = tbody.querySelectorAll('tr');
        var hasBlank = false;
        existingRows.forEach(function (tr) {
            var parts = tr.id.split('_');
            var counter = parts[parts.length - 1];
            var $skillSel = $('#cboSkillMaster' + counter);
            var skillVal = $skillSel.length ? $skillSel.selectpicker('val') : null;
            if (!skillVal || skillVal === '0') {
                hasBlank = true;
                if ($skillSel.length) $skillSel.closest('.bootstrap-select').addClass('val-error');
            }
        });
        if (hasBlank) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_CompleteSkillRowFirst);
            return;
        }

        validateBulkAllocProjectHasSkills(function () {
            var counter = _nextBulkAllocSkillCounter(gid);
            var skillHtml = _bulkAllocSkillTmpl('tmpl-ba-skill-master', counter);
            if (!skillHtml || skillHtml.indexOf('<select') < 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(RES.A_UnableLoadSkillDropdown);
                return;
            }
            var monthHtml = _bulkAllocSkillTmpl('tmpl-ba-skill-month', counter);
            var yearHtml = _bulkAllocSkillTmpl('tmpl-ba-skill-year', counter);
            var profHtml = _bulkAllocSkillTmpl('tmpl-ba-skill-proficiency', counter);
            var tr = document.createElement('tr');
            tr.id = 'BA_' + gid + '_' + counter;
            tr.innerHTML =
                /* Skill — project-specific dropdown */
                '<td class="td-skill"><div class="skill-select-wrap">' + skillHtml + '</div></td>' +
                '<td class="td-experience"><div class="exp-wrap"><div class="exp-year">' + monthHtml + '</div><span class="exp-sep">/</span><div class="exp-month">' + yearHtml + '</div></div></td>' +
                '<td><div class="prof-select-wrap">' + profHtml + '</div></td>' +
                '<td class="text-center"><input type="checkbox" id="chkCore' + counter + '" class="chk-core" title="Core Competency"></td>' +
                /* Delete row */
                '<td class="td-action"><button class="ibtnDel nostylebtn" type="button" onclick="deleteBulkAllocSkillRow(this,' + gid + ')" ' +
                'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" data-bs-title="' + escHtml(RES.C_DeleteSkillTooltip) + '"><i class="far fa-trash-alt"></i></button></td>';
            tbody.appendChild(tr);

            var skillSel = document.getElementById('cboSkillMaster' + counter);
            _fillBulkAllocSkillSelect(skillSel, null);
            var $month = $('#cboMonth' + counter);
            var $year = $('#cboYear' + counter);
            var $prof = $('#cboParameters' + counter);
            [$month, $year, $prof].forEach(function ($el) {
                if (!$el || !$el.length) return;
                $el.addClass('selectpicker form-control')
                   .attr('data-width', '100%')
                   .attr('data-container', 'body');
            });
            try {
                if ($month.length && $month.find('option[value="0"]').length === 0) $month.prepend(new Option('Select Year', '0'));
                $month.val('0');
                if ($year.length && $year.find('option[value="0"]').length === 0) $year.prepend(new Option('Select Month', '0'));
                $year.val('0');
                if ($prof.length && $prof.find('option[value="0"]').length === 0) $prof.prepend(new Option('Select Proficiency', '0'));
                $prof.val('0');
            } catch (e) { /* ignore */ }
            initBulkAllocSkillSelectpickers(gid, counter);
            if (skillSel) {
                $(skillSel).on('changed.bs.select', function () {
                    var $cur = $(this);
                    var v = $cur.selectpicker('val');
                    $cur.closest('.bootstrap-select').removeClass('val-error');
                    if (!v || v === '0') return;
                    var duplicateFound = false;
                    $('#bulk-skill-tbody-' + gid + ' select[id^="cboSkillMaster"]').not(this).each(function () {
                        if (String($(this).val()) === String(v)) duplicateFound = true;
                    });
                    if (duplicateFound) {
                        $cur.selectpicker('val', '0');
                        $cur.closest('.bootstrap-select').addClass('val-error');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(RES.A_DuplicateSkill);
                    }
                });
            }
            var $rowScope = $('#BA_' + gid + '_' + counter);
            $rowScope.find('select.selectpicker').each(function () {
                $(this).on('changed.bs.select', function () {
                    var $cur = $(this);
                    var v = ($cur.selectpicker('val') || '').toString();
                    if (v && v !== '0') {
                        $cur.closest('.bootstrap-select').removeClass('val-error');
                    }
                });
            });
            reinitTooltips();
        });
    };

    window.deleteBulkAllocSkillRow = function (btn, gid) {
        if (!deleteAccess && !addAccess) return;
        var row = btn.closest('tr');
        if (!row) return;
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            var tipInstance = bootstrap.Tooltip.getInstance(btn);
            if (tipInstance) { tipInstance.hide(); tipInstance.dispose(); }
        }
        $(row).find('select.selectpicker').each(function () {
            try {
                if ($(this).data('selectpicker')) $(this).selectpicker('destroy');
            } catch (e) { /* ignore */ }
        });
        row.remove();
        alertify.set('notifier', 'position', 'top-right');
        alertify.success((RES.A_SkillDeleted || '').toString().trim() || 'Skill deleted successfully.');
    };

    function applyPageSkillToggleToOffcanvas() {
        var $skill = $('#ocSkill');
        if (_pageSkillFilterEnabled) {
            $skill.prop('disabled', false);
            $('#divOcSkill').removeClass('opacity-50');
        } else {
            $skill.val('0');
            try { $skill.selectpicker('refresh'); } catch (e) { /* ignore */ }
            $skill.prop('disabled', true);
            $('#divOcSkill').addClass('opacity-50');
        }
        try { $skill.selectpicker('refresh'); } catch (e) { /* ignore */ }
    }

    /* Added By Dipali V On 27th May 2026 — collapsible Notes bar (PM_BulkResourceReq.aspx) */
    window.toggleBulkAllocNote = function () {
        var el = document.getElementById('noteExpanded');
        var ch = document.getElementById('noteChevron');
        if (!el || !ch) return;
        var open = window.getComputedStyle(el).display !== 'none';
        el.style.display = open ? 'none' : 'block';
        ch.classList.toggle('open', !open);
    };

    function initNoteToggle() {
        var el = document.getElementById('noteExpanded');
        var ch = document.getElementById('noteChevron');
        if (el) el.style.display = 'none';
        if (ch) ch.classList.remove('open');
    }

    (function bindLiveValidationClearers() {
        var $offcanvas = $('#selectResourceOffcanvas');
        if (!$offcanvas.length || $offcanvas.data('validationClearersBound')) return;
        $offcanvas.data('validationClearersBound', true);

        $offcanvas.on('changed.bs.select', 'select', function () {
            var $sel = $(this);
            var val = ($sel.val() || '').toString();
            var isValid = !!val && val !== '0';
            var $bs = $sel.closest('.bootstrap-select');
            if (isValid && $bs.length) $bs.removeClass('oc-val-error');
        });

        $offcanvas.on('input change', '#ocStartDate,#ocEndDate,#ocAllocation,#ocNoOfResources,#ocWorkHM,#ocResponsibilities', function () {
            var el = this;
            var v = String(el.value || '').trim();
            if (el.id === 'ocWorkHM') {
                if (activeGroupId) _syncOcWorkHoursToRgList(activeGroupId, v);
                if (v) _validateOcWorkHoursLimit();
                if (_hhmmToDecimal(v) != null || !v) el.classList.remove('oc-val-error');
            } else if (el.id === 'ocResponsibilities') {
                if (activeGroupId) _setOffcanvasResponsibilitiesForGroup(activeGroupId, el.value || '');
            } else if (v) {
                el.classList.remove('oc-val-error');
            }
        });
        _bindOcWorkHoursOffcanvasSync();
        _bindOcResourceStatusOffcanvasSync();
        _bindOcReportingToOffcanvasSync();
        _bindOcBillableApproverOffcanvasSync();
    })();

    function showToast(msg, type) {
        var icons = { success: 'fa-check-circle', warning: 'fa-exclamation-triangle', error: 'fa-times-circle' };
        var cls = { success: 'app-toast-success', warning: 'app-toast-warning', error: 'app-toast-error' };
        var $t = $('<div class="app-toast ' + (cls[type] || 'app-toast-success') + '"><i class="fas ' + (icons[type] || 'fa-info-circle') + '"></i> ' + msg + '</div>');
        $('body').append($t);
        setTimeout(function () { $t.fadeOut(300, function () { $(this).remove(); }); }, 3200);
    }

    /* ═══════════════════════════════════════════════════════════════════════
       RESOURCE LOADING HELPERS
       (Added by Vyankat B. on 8th-9th April 2026)
       ═══════════════════════════════════════════════════════════════════════ */

    // Added by Vyankat B. on 9th April 2026 - Month short name helper.
    function getMonthlyLoadingMonthShortName(monthIndex) {
        var names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        if (monthIndex < 1 || monthIndex > 12) return '';
        return names[monthIndex - 1];
    }

    // Added by Vyankat B. on 9th April 2026 - Support both PascalCase and camelCase API keys.
    var RESOURCE_LOADING_CAL_MONTH_TO_KEYS = [
        { count: ['JanCount', 'janCount'], ru: ['RUJan', 'ruJan'] },
        { count: ['FebCount', 'febCount'], ru: ['RUFeb', 'ruFeb'] },
        { count: ['MarCount', 'marCount'], ru: ['RUMar', 'ruMar'] },
        { count: ['AprCount', 'aprCount'], ru: ['RUApr', 'ruApr'] },
        { count: ['MayCount', 'mayCount'], ru: ['RUMay', 'ruMay'] },
        { count: ['JuneCount', 'juneCount'], ru: ['RUJune', 'ruJune'] },
        { count: ['JulyCount', 'julyCount'], ru: ['RUJuly', 'ruJuly'] },
        { count: ['AugCount', 'augCount'], ru: ['RUAug', 'ruAug'] },
        { count: ['SepCount', 'sepCount'], ru: ['RUSep', 'ruSep'] },
        { count: ['OctCount', 'octCount'], ru: ['RUOct', 'ruOct'] },
        { count: ['NovCount', 'novCount'], ru: ['RUNov', 'ruNov'] },
        { count: ['DecCount', 'decCount'], ru: ['RUDec', 'ruDec'] }
    ];
    // End of Added by Vyankat B. on 9th April 2026

    function buildFyCalendarMonthOrder(startMonth) {
        var order = [];
        var sm = parseInt(startMonth, 10);
        if (isNaN(sm) || sm < 1 || sm > 12) sm = 4;
        for (var k = 0; k < 12; k++) {
            order.push(((sm - 1 + k) % 12) + 1);
        }
        return order;
    }

    function extractResourceLoadingListArray(apiResult) {
        if (apiResult == null) return [];
        if (Array.isArray(apiResult)) return apiResult;
        if (Array.isArray(apiResult.data)) return apiResult.data;
        return [];
    }

    function formatResourceLoadingNum(val) {
        if (val == null || val === '') return '--';
        var n = parseFloat(val);
        if (isNaN(n)) return '--';
        return n.toFixed(2);
    }

    // Added by Vyankat B. on 9th April 2026 - Read first available field from mixed-case API response.
    function getValueFromAnyKey(obj, keys) {
        if (!obj || !keys || !keys.length) return null;
        for (var i = 0; i < keys.length; i++) {
            var k = keys[i];
            if (Object.prototype.hasOwnProperty.call(obj, k) && obj[k] != null) return obj[k];
        }
        return null;
    }
    // End of Added by Vyankat B. on 9th April 2026

    function findResourceLoadingTotalSumRow(rows) {
        for (var i = 0; i < rows.length; i++) {
            var r = rows[i] || {};
            var pid = getValueFromAnyKey(r, ['ProjectID', 'projectID']);
            var pname = String(getValueFromAnyKey(r, ['ProjectName', 'projectName']) || '').toLowerCase().replace(/\s+/g, '');
            if (parseInt(pid, 10) === 0) return r;
            if (pname === 'totalsum') return r;
        }
        return null;
    }

    function bindMonthlyLoadingFromResourceList(rows, startMonth) {
        var order = buildFyCalendarMonthOrder(startMonth);
        var totalRow = findResourceLoadingTotalSumRow(rows);
        var hoursCells = '', ruCells = '';
        for (var i = 0; i < order.length; i++) {
            var cm = order[i];
            var keys = RESOURCE_LOADING_CAL_MONTH_TO_KEYS[cm - 1];
            var hVal = totalRow && keys ? getValueFromAnyKey(totalRow, keys.count) : null;
            var ruVal = totalRow && keys ? getValueFromAnyKey(totalRow, keys.ru) : null;
            hoursCells += '<td class="text-end">' + formatResourceLoadingNum(hVal) + '</td>';
            ruCells += '<td class="text-end">' + formatResourceLoadingNum(ruVal) + '</td>';
        }
        $('#tblmonthlyLoadingTbody').html(
            '<tr><th>Hours</th>' + hoursCells + '</tr>' +
            '<tr><th>Resource Utilization %</th>' + ruCells + '</tr>'
        );
    }

    function bindProjectLoadingFromResourceList(rows, startMonth) {
        var order = buildFyCalendarMonthOrder(startMonth);
        var list = rows || [];
        var totalRow = findResourceLoadingTotalSumRow(list);
        var html = '';
        for (var r = 0; r < list.length; r++) {
            var row = list[r] || {};
            var pid = getValueFromAnyKey(row, ['ProjectID', 'projectID']);
            if (parseInt(pid, 10) === 0) continue;
            var nameVal = getValueFromAnyKey(row, ['ProjectName', 'projectName']);
            var name = nameVal != null ? String(nameVal) : '';
            var tds = '<td>' + escHtml(name) + '</td>';
            var sourceRow = row;
            // Added by Vyankat B. on 9th April 2026 - If Open Projects row is all-zero, use TotalSum month counts.
            if (parseInt(pid, 10) === -2 && totalRow) {
                var hasAnyNonZero = false;
                for (var j = 0; j < order.length; j++) {
                    var k0 = RESOURCE_LOADING_CAL_MONTH_TO_KEYS[order[j] - 1];
                    var v0 = k0 ? getValueFromAnyKey(row, k0.count) : null;
                    if (!isNaN(parseFloat(v0)) && parseFloat(v0) !== 0) { hasAnyNonZero = true; break; }
                }
                if (!hasAnyNonZero) sourceRow = totalRow;
            }
            // End of Added by Vyankat B. on 9th April 2026
            for (var i = 0; i < order.length; i++) {
                var keys = RESOURCE_LOADING_CAL_MONTH_TO_KEYS[order[i] - 1];
                var hVal = keys ? getValueFromAnyKey(sourceRow, keys.count) : null;
                tds += '<td class="text-end">' + formatResourceLoadingNum(hVal) + '</td>';
            }
            html += '<tr>' + tds + '</tr>';
        }
        if (!html) html = '<tr><td class="text-muted text-center" colspan="13">--</td></tr>';
        $('#tblProjectLoadingTbody').html(html);
    }

    function parseCompanyStartMonthFromApi(apiResult) {
        // Added by Vyankat B. on 9th April 2026 - GetCompanyStartMonth returns { message, data: [{ startMonth: 1-12 }] }.
        var fallback = 4;
        if (apiResult == null) return fallback;
        if (typeof apiResult === 'number' && apiResult >= 1 && apiResult <= 12) return apiResult;
        if (typeof apiResult === 'string') { var p = parseInt(apiResult, 10); if (!isNaN(p) && p >= 1 && p <= 12) return p; }
        if (typeof apiResult !== 'object') return fallback;
        var d = apiResult.data;
        if (Array.isArray(d) && d.length > 0) {
            var row = d[0] || {};
            var m = row.startMonth != null ? row.startMonth : row.StartMonth;
            if (m != null) { var n = parseInt(m, 10); if (!isNaN(n) && n >= 1 && n <= 12) return n; }
        }
        if (typeof d === 'number' && d >= 1 && d <= 12) return d;
        if (typeof d === 'string') { var p2 = parseInt(d, 10); if (!isNaN(p2) && p2 >= 1 && p2 <= 12) return p2; }
        if (d != null && typeof d === 'object' && !Array.isArray(d)) {
            var m2 = d.startMonth != null ? d.startMonth : d.StartMonth;
            if (m2 != null) { var n2 = parseInt(m2, 10); if (!isNaN(n2) && n2 >= 1 && n2 <= 12) return n2; }
        }
        return fallback;
        // End of Added by Vyankat B. on 9th April 2026
    }

    // Added by Vyankat B. on 8th April 2026 - Build FY column headers for Monthly and Project loading tables.
    function bindMonthlyLoadingFinancialYearHeader(startMonth) {
        var sm = parseInt(startMonth, 10);
        if (isNaN(sm) || sm < 1 || sm > 12) sm = 4;
        var html = '<th></th>';
        var idx = sm, count = 12;
        while (count-- > 0) { html += '<th>' + getMonthlyLoadingMonthShortName(idx) + '</th>'; idx = (idx % 12) + 1; }
        $('#tblmonthlyLoadingThead tr').first().html(html);
    }

    function bindProjectLoadingFinancialYearHeader(startMonth) {
        var sm = parseInt(startMonth, 10);
        if (isNaN(sm) || sm < 1 || sm > 12) sm = 4;
        var html = '<th>Project</th>';
        var idx = sm, count = 12;
        while (count-- > 0) { html += '<th>' + getMonthlyLoadingMonthShortName(idx) + '</th>'; idx = (idx % 12) + 1; }
        $('#tblProjectLoadingThead tr').first().html(html);
    }
    // End of Added by Vyankat B. on 8th April 2026

    // Added by Vyankat B. on 8th April 2026 - Render Resource Utilization summary values from GetResourceLoadingBulk response.
    function bindResourceLoadingSummary(resourceLoadingBulkResult, yearlyTotalCapacityResult) {
        var rows = (resourceLoadingBulkResult && Array.isArray(resourceLoadingBulkResult.data)) ? resourceLoadingBulkResult.data : [];
        var map = { installCapacity: '', availableForAllocation: '', leaves: '', billableAllocation: '', nonBillableAllocation: '' };

        for (var i = 0; i < rows.length; i++) {
            var r = rows[i] || {};
            var type = String(r.type || '').toLowerCase();
            var hm = (r.hmHours != null && String(r.hmHours).trim() !== '') ? String(r.hmHours) : null;
            var hrs = (r.hours != null && r.hours !== '') ? String(r.hours) : null;
            var val = hm || hrs;
            if (!val) continue;
            if (type === 'available for allocation') map.availableForAllocation = val;
            else if (type === 'leaves') map.leaves = val;
            else if (type === 'billable allocation') map.billableAllocation = val;
            else if (type === 'non billable allocation') map.nonBillableAllocation = val;
            else if (type === 'install capacity') map.installCapacity = val;
        }

        // Added by Vyankat B. on 8th April 2026 - Bind Install Capacity from GetYearlyTotalCapacity endpoint response.
        if (yearlyTotalCapacityResult != null) {
            if (typeof yearlyTotalCapacityResult === 'number' || typeof yearlyTotalCapacityResult === 'string') {
                map.installCapacity = String(yearlyTotalCapacityResult);
            } else if (Array.isArray(yearlyTotalCapacityResult.data) && yearlyTotalCapacityResult.data.length > 0) {
                var capRow = yearlyTotalCapacityResult.data[0] || {};
                map.installCapacity = String(capRow.totalCapacity != null ? capRow.totalCapacity : (capRow.yearlyWorkingHours != null ? capRow.yearlyWorkingHours : (capRow.hours != null ? capRow.hours : '')));
            } else if (yearlyTotalCapacityResult.data != null) {
                map.installCapacity = String(yearlyTotalCapacityResult.data);
            }
        }
        // End of Added by Vyankat B. on 8th April 2026

        function showVal(v) { return (v != null && String(v).trim() !== '') ? String(v) : '--'; }

        $('#tblResourceWorkSummaryBody').html(
            '<tr><th>Install Capacity</th><td class="text-end">' + showVal(map.installCapacity) + ' Hrs</td></tr>' +
            '<tr><th>Available for allocation</th><td class="text-end">' + showVal(map.availableForAllocation) + ' Hrs</td></tr>' +
            '<tr><th>Leaves</th><td class="text-end">' + showVal(map.leaves) + ' Hrs</td></tr>' +
            '<tr><th>Billable allocation</th><td class="text-end">' + showVal(map.billableAllocation) + ' Hrs</td></tr>' +
            '<tr><th>Non Billable allocation</th><td class="text-end">' + showVal(map.nonBillableAllocation) + ' Hrs</td></tr>'
        );
    }
    // End of Added by Vyankat B. on 8th April 2026
</script>

    <%-- Added by Vyankat B. on 10th March 2026 - Central AJAX helper used by resource loading API chain. --%>
    <script>
        /* Modified by Nikhil Mane on 08-May-2026 — extended with onSuccess/onError/onComplete
           callbacks so every async $.ajax call on this page routes through here.
           Backward-compatible: sync callers (async=false, no callbacks) unchanged. */
        function AJAXCallWithResult(url, param, async, onSuccess, onError, onComplete, useLoader) {
            var result = null;
            var isAsync = (async !== false);
            var showLoaderOverlay = (useLoader !== false);
            var fullUrl = strUrl.endsWith('/') ? strUrl + url : strUrl + '/' + url;
            /* Added 25-May-2026 — display loader overlay while API request is in progress */
            if (showLoaderOverlay && typeof showLoader === 'function') showLoader();
            /* Added By Dipali V On 26th May - Force paint before sync AJAX so loader is visible */
            if (!isAsync) {
                var $lo = $('#loaderOverlay');
                if ($lo.length) { $lo[0].offsetHeight; }
            }
            $.ajax({
                url: fullUrl,
                type: 'POST',
                data: param,
                async: isAsync,
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem('access_token_W26API'));
                    _setAjaxParamsHeaderIfWithinLimit(xhr, param);
                },
                success: function (data) {
                    result = data;
                    if (typeof onSuccess === 'function') { onSuccess(data); }
                },
                error: function (xhr, status, error) {
                    if (typeof onError === 'function') {
                        onError(xhr, status, error);
                    } else {
                        if (xhr.status === 401) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(RES.A_AuthenticationFailed, 5);
                        } else {
                            window.location.href = '../../General/ErrorPage.aspx?Mode=AJAXError&Error=' + error;
                        }
                    }
                },
                complete: function () {
                    /* Added 25-May-2026 — hide loader when API call finishes (success or error) */
                    if (showLoaderOverlay && typeof hideLoader === 'function') hideLoader();
                    if (typeof onComplete === 'function') { onComplete(); }
                }
            });
            if (!isAsync) { return result; }
            return result;
        }
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    </script>
    <%-- End of Added by Vyankat B. on 10th March 2026 --%>

<%-- ══════════════════════════════════════════════════════════════════════
     Confirm Modals — Added by Nikhil Mane on 13-04-2026
     ══════════════════════════════════════════════════════════════════════ --%>

<%-- ── 1. Delete Resource Group confirm modal ── --%>
<div id="deleteGroupConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title">
          <%=MyBase.GetResourceString("C_Confirmation")%>
        </h4>
        <button type="button" class="close" aria-label="Close" id="btnDeleteGroupClose"
          margin-top: 15px; data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center"><%=MyBase.GetResourceString("C_ConfirmDeleteRoleRowMsg")%></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelDeleteGroup"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmDeleteGroup">
          
          <%=MyBase.GetResourceString("C_Yes")%>
        </button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 2. Remove Selected Resource confirm modal ── --%>
<div id="removeResourceConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnRemoveResourceClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center"><%=MyBase.GetResourceString("C_ConfirmRemoveResourceMsg")%></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelRemoveResource"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmRemoveResource"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 3a. Project resource count exceed confirm (Search / Select Resource) ── --%>
<div id="projectResourceExceedConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnProjectResourceExceedClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center" id="projectResourceExceedConfirmMessage"><%=MyBase.GetResourceString("C_ConfirmExceedProjectResourcesMsg")%></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelProjectResourceExceed"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmProjectResourceExceed"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 3a3. Probable match — resource skill differs from requested role skills ── --%>
<div id="resourceSkillDiffersConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnResourceSkillDiffersClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center" id="resourceSkillDiffersConfirmMessage">Resource skill differs from requested. Do you want to continue?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelResourceSkillDiffers"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmResourceSkillDiffers"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 3a2. Skill not selected confirm (Search by Skill ON, Select Resource without role skills) ── --%>
<div id="skillNotSelectedConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnSkillNotSelectedClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center" id="skillNotSelectedConfirmMessage"><%=MyBase.GetResourceString("C_ConfirmSkillNotSelectedMsg")%></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelSkillNotSelected"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmSkillNotSelected"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 3b. No project skills — add skills confirm modal (Search Resource by Skill) ── --%>
<div id="noProjectSkillsConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnNoProjectSkillsClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center" id="noProjectSkillsConfirmMessage"><%=MyBase.GetResourceString("C_ConfirmAddProjectSkillsMsg")%></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelNoProjectSkills"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmNoProjectSkills"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 3. Allocate confirm modal ── --%>
<div id="allocateConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnAllocateConfirmClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center"><%=MyBase.GetResourceString("C_ConfirmAllocateMsg")%></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelAllocate"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmAllocate"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- Added By Dipali V On 5th Jun 2026 — Default Approver change confirmation (Reallocation tab) --%>
<div id="defaultApproverChangeModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modalsmall ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnDefaultApproverChangeClose">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p align="center" id="defaultApproverChangeMessage">This will change the previously set Default Approver. Do you want to continue?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnCancelDefaultApproverChange"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnConfirmDefaultApproverChange"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- ── 4. Extend Project End Date modal — Added by Vyankat B. on 18-May-2026 --%>
<div id="extendProjectEndDateModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-extend-project ui-draggable">
    <div class="modal-content">
      <div class="modal-header ui-draggable-handle">
        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
        <button type="button" class="close" aria-label="Close" id="btnExtendProjectClose" margin-top: 16px;
          data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="<%=MyBase.GetResourceString("C_Close")%>">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      <div class="modal-body">
        <p class="extend-project-heading"><%=MyBase.GetResourceString("C_ExtendProjectHeading")%></p>
        <div class="extend-project-table-wrap">
          <table class="extend-project-table">
            <thead>
              <tr>
                <th><%=MyBase.GetResourceString("C_Resource")%></th>
                <th><%=MyBase.GetResourceString("C_ProjectRole")%></th>
                <th><%=MyBase.GetResourceString("C_PlannedEndDate")%></th>
                <th><%=MyBase.GetResourceString("C_PercentAllocation")%></th>
                <th class="extend-project-check-col">
                  <input type="checkbox" class="extend-project-row-check extend-project-check-all" id="extendProjectCheckAll"
                    onclick="toggleExtendProjectSelectAll(this)" title="<%=MyBase.GetResourceString("C_SelectAllResources")%>">
                </th>
              </tr>
            </thead>
            <tbody id="extendProjectResourceTbody"></tbody>
          </table>
        </div>
        <div class="extend-project-footer ir-pagination-container" id="extendProjectFooter">
          <div class="ir-pagination-info"><span id="extendProjectTotalText"><%=MyBase.GetResourceString("C_TotalRecordsLabel")%></span></div>
          <div class="ir-pagination-buttons">
            <button type="button" id="extendProjectPrev" class="ir-page-btn" onclick="extendProjectPrevPage()" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" disabled>
              <i class="fas fa-angle-double-left"></i>
            </button>
            <button type="button" id="extendProjectNext" class="ir-page-btn" onclick="extendProjectNextPage()" title="<%=MyBase.GetResourceString("C_NextPage")%>" disabled>
              <i class="fas fa-angle-double-right"></i>
            </button>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn borderbtn float-start uncheckbtn me-auto" id="btnExtendProjectNo"><%=MyBase.GetResourceString("C_No")%></button>
        <button type="button" class="modal-btn-confirm btn btnyellow" id="btnExtendProjectYes"><%=MyBase.GetResourceString("C_Yes")%></button>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

<%-- End of Modals — Added by Nikhil Mane on 13-04-2026 --%>

<%-- ══ Modal JS wiring — Added by Nikhil Mane on 13-04-2026 ══ --%>
<script>
    (function () {
        'use strict';

        function _getModal(id) {
            var el = document.getElementById(id);
            return el ? bootstrap.Modal.getOrCreateInstance(el) : null;
        }

        /* ── 1. DELETE GROUP MODAL ── */
        document.getElementById('btnConfirmDeleteGroup').addEventListener('click', function () {
            if (window._pendingDeleteGroupId !== null) { _executeRemoveGroup(window._pendingDeleteGroupId); }
            window._pendingDeleteGroupId = null;
            _getModal('deleteGroupConfirmModal').hide();
        });
        ['btnCancelDeleteGroup', 'btnDeleteGroupClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                window._pendingDeleteGroupId = null;
                _getModal('deleteGroupConfirmModal').hide();
            });
        });

        /* ── 2. REMOVE RESOURCE MODAL ── */
        document.getElementById('btnConfirmRemoveResource').addEventListener('click', function () {
            if (window._pendingRemoveResGid !== null && window._pendingRemoveResRid !== null) {
                _executeRemoveSelectedResource(window._pendingRemoveResGid, window._pendingRemoveResRid);
            }
            window._pendingRemoveResGid = null;
            window._pendingRemoveResRid = null;
            _getModal('removeResourceConfirmModal').hide();
        });
        ['btnCancelRemoveResource', 'btnRemoveResourceClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                window._pendingRemoveResGid = null;
                window._pendingRemoveResRid = null;
                _getModal('removeResourceConfirmModal').hide();
            });
        });

        /* ── RRL allocation detail offcanvas — Update (edit mode only) ── */
        var btnRrlOcUpdate = document.getElementById('btnRrlOcUpdate');
        if (btnRrlOcUpdate) {
            btnRrlOcUpdate.addEventListener('click', function () {
                if (typeof updateRrlOffcanvasDetails === 'function') updateRrlOffcanvasDetails();
            });
        }
        var rrlOcEl = document.getElementById('rrlAllocationDetailOffcanvas');
        if (rrlOcEl) {
            rrlOcEl.addEventListener('hidden.bs.offcanvas', function () {
                if (typeof _rrlDestroyOcSelectpickers === 'function') _rrlDestroyOcSelectpickers();
                clearRrlOcValidation();
                window._rrlOcActiveRowKey = null;
                window._rrlOcActiveGid = null;
                window._rrlSaveFromWhere = 'ListView';
            });
        }

        /* ── 3a. PROJECT RESOURCE EXCEED CONFIRM MODAL ── */
        document.getElementById('btnConfirmProjectResourceExceed').addEventListener('click', function () {
            if (window._pendingAllocateExceedConfirm) {
                window._pendingAllocateExceedConfirm = false;
                window._pendingAllocateExceedAcked = true;
                closeBulkAllocExceedProjectResourceConfirm();
                handleAllocate(true);
                return;
            }
            var gid = window._pendingOpenSelectResourceGid;
            closeBulkAllocExceedProjectResourceConfirm();
            if (gid != null) _openSelectResourceCore(gid, true);
        });
        ['btnCancelProjectResourceExceed', 'btnProjectResourceExceedClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                closeBulkAllocExceedProjectResourceConfirm();
            });
        });

        /* ── 3a3. PROBABLE SKILL DIFFERS CONFIRM MODAL ── */
        document.getElementById('btnConfirmResourceSkillDiffers').addEventListener('click', function () {
            var onYes = window._pendingProbableSkillDiffersOnYes;
            closeBulkAllocResourceSkillDiffersConfirm(false);
            if (typeof onYes === 'function') onYes();
        });
        ['btnCancelResourceSkillDiffers', 'btnResourceSkillDiffersClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                closeBulkAllocResourceSkillDiffersConfirm(true);
            });
        });

        /* ── 3a2. SKILL NOT SELECTED CONFIRM MODAL ── */
        document.getElementById('btnConfirmSkillNotSelected').addEventListener('click', function () {
            var gid = window._pendingOpenSelectResourceGid;
            var skipExceed = window._pendingSkillConfirmSkipExceed;
            closeBulkAllocSkillNotSelectedConfirm();
            if (gid != null) {
                _skipRoleSkillFilterByGroup[String(gid)] = true;
                _openSelectResourceCore(gid, skipExceed, true);
            }
        });
        function _onSkillNotSelectedChooseAddSkill() {
            var gid = window._pendingOpenSelectResourceGid;
            closeBulkAllocSkillNotSelectedConfirm();
            if (gid == null) return;
            $('#bulk-skill-section-' + gid).addClass('open');
            var $firstSkill = $('#bulk-skill-tbody-' + gid + ' select[id^="cboSkillMaster"]').first();
            if ($firstSkill.length) _ensureValidationControlVisibleAndFocus($firstSkill[0]);
        }
        ['btnCancelSkillNotSelected', 'btnSkillNotSelectedClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', _onSkillNotSelectedChooseAddSkill);
        });

        /* ── 3b. NO PROJECT SKILLS CONFIRM MODAL (Search Resource by Skill) ── */
        /* Added By Dipali V On 16th Jun 2026 — Yes opens Skills Selection offcanvas instead of PM_ToolsSkills page */
        document.getElementById('btnConfirmNoProjectSkills').addEventListener('click', function () {
            var enableToggle = !!_baSkillSelEnableToggleAfterSave;
            closeBulkAllocNoProjectSkillsConfirm();
            openBulkAllocSkillsSelectionOffcanvas(enableToggle);
        });
        ['btnCancelNoProjectSkills', 'btnNoProjectSkillsClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                var onNo = window._bulkAllocNoProjectSkillsOnNo;
                closeBulkAllocNoProjectSkillsConfirm();
                if (typeof onNo === 'function') onNo();
            });
        });

        /* ── 3c. DEFAULT APPROVER CHANGE MODAL — Added By Dipali V On 5th Jun 2026 ── */
        function _closeDefaultApproverChangeModal() {
            _getModal('defaultApproverChangeModal').hide();
            window._rrlDaChangeOnConfirm = null;
            window._rrlDaChangeOnCancel = null;
        }
        document.getElementById('btnConfirmDefaultApproverChange').addEventListener('click', function () {
            var onYes = window._rrlDaChangeOnConfirm;
            _closeDefaultApproverChangeModal();
            if (typeof onYes === 'function') onYes();
        });
        ['btnCancelDefaultApproverChange', 'btnDefaultApproverChangeClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                var onNo = window._rrlDaChangeOnCancel;
                _closeDefaultApproverChangeModal();
                if (typeof onNo === 'function') onNo();
            });
        });

        /* ── 3. ALLOCATE CONFIRM MODAL ── */
        document.getElementById('btnConfirmAllocate').addEventListener('click', function () {
            if (_bulkAllocateInFlight) return;
            _getModal('allocateConfirmModal').hide();
            _doAllocate();
        });
        ['btnCancelAllocate', 'btnAllocateConfirmClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                _getModal('allocateConfirmModal').hide();
            });
        });

        /* ── 4. EXTEND PROJECT END DATE MODAL — Added by Vyankat B. on 18-May-2026 ── */
        document.getElementById('btnExtendProjectYes').addEventListener('click', function () {
            handleExtendProjectYesClick();
        });
        ['btnExtendProjectNo', 'btnExtendProjectClose'].forEach(function (id) {
            document.getElementById(id).addEventListener('click', function () {
                _userWantsExtendResourceEndDate = false;
                window._userWantsExtendResourceEndDate = false;
                hideExtendProjectEndDateModal();
            });
        });

    })();
    // End of Modal JS wiring — Added by Nikhil Mane on 13-04-2026

    // Role Resource List JS — Added by Nikhil Mane on 22-Apr-2026
    var _rrlCacheByProject = {};
    var _rrlPaginationByProject = {};
    var _rrlApiPageSize = 5;
    var _rrlLoadingProject = false;
    /* Added 25-May-2026 — cross-page checkbox selection for Allocated Resources (per group) */
    var _rrlSelectedByGroup = {};
    var _rrlSelectAllActiveByGroup = {};
    var _rrlInactiveByGroup = {};
    var _rrlUnselectedByGroup = {};
    /* End of Added 25-May-2026 — cross-page checkbox selection */

    function loadAndRenderRrlForGroup(gid, roleId, roleText) {
        var projectId = parseInt(SessionProjectID) || 0;
        if (!projectId) return;
        var rid = parseInt(roleId, 10);
        if (isNaN(rid) || rid < 0) rid = 0;
        var rtxt = (roleText && roleText !== RES.C_SelectRole) ? roleText : null;
        if (rid === 0) rtxt = null;
        /* Added 25-May-2026 — reset selections when role/filter reloads the RRL grid */
        _rrlSelectAllActiveByGroup[gid] = false;
        _rrlSelectedByGroup[gid] = {};
        _rrlInactiveByGroup[gid] = {};
        _rrlUnselectedByGroup[gid] = {};
        /* End of Added 25-May-2026 */
        _rrlFetchAndRenderPage(gid, rid, rtxt, 1);
    }

    function _rrlFetchAndRenderPage(gid, roleId, roleText, pageNumber) {
        var projectId = parseInt(SessionProjectID, 10) || 0;
        if (!projectId) return;

        _rrlShowLoading(gid, true);
        _rrlLoadingProject = true;
        var state = _rrlState[gid] || {};
        var pageSize = state.size || _rrlApiPageSize;
        var rid = parseInt(roleId, 10) || 0;
        var empName = (String(gid) === String(_REALLOC_TAB_GID))
            ? ($('#rrlEmployeeNameSearch').val() || '').trim() : '';

        _fetchRrlFromApi(projectId, pageNumber, pageSize, rid, empName,
            function (rows, pagination) {
                _rrlLoadingProject = false;
                _rrlRenderForGroup(gid, rid, roleText, rows || [], pagination);
            },
            function () { _rrlLoadingProject = false; _rrlShowLoading(gid, false); _rrlShowEmpty(gid); }
        );
    }

    function _normaliseRrlPagination(pagination) {
        if (Array.isArray(pagination)) pagination = pagination.length ? pagination[0] : null;
        if (!pagination) return null;
        return {
            currentPage: parseInt(pagination.currentPage || pagination.CurrentPage || 1, 10) || 1,
            pageSize: parseInt(pagination.pageSize || pagination.PageSize || _rrlApiPageSize, 10) || _rrlApiPageSize,
            totalRecords: parseInt(pagination.totalRecords || pagination.TotalRecords || 0, 10) || 0,
            totalPages: parseInt(pagination.totalPages || pagination.TotalPages || 0, 10) || 0
        };
    }

    function _extractRrlApiPayload(response) {
        var payload = response || {};
        /* Unwrap ResponseEntity / nested API envelope: { data: { message, data: [...], paginationEntities: [...] } } */
        if (payload.data && !Array.isArray(payload.data) ) {
            payload = payload.data;
        }

        var rows = [];
        if (Array.isArray(payload)) rows = payload;
        else if (Array.isArray(payload.data)) rows = payload.data;
       

        var pagination = payload.paginationEntities || null;
        return {
            rows: rows,
            pagination: _normaliseRrlPagination(pagination)
        };
    }

    function _fetchRrlFromApi(projectId, pageNumber, pageSize, roleId, employeeName, onSuccess, onError) {
        var body = JSON.stringify({
            projectID: parseInt(projectId, 10),
            roleID: parseInt(roleId, 10) || 0,
            pageNumber: parseInt(pageNumber, 10) || 1,
            pageSize: parseInt(pageSize, 5) || _rrlApiPageSize,
            employeeName: (employeeName || '').trim() || null
        });

        /* Modified by Nikhil Mane on 08-May-2026 — replaced $.ajax with AJAXCallWithResult */
        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/GetProjectEmployeeRoleByRole',
            body, true,
            function (response) {
                var payload = _extractRrlApiPayload(response);
                if (typeof onSuccess === 'function') onSuccess(payload.rows || [], payload.pagination);
            },
            function (xhr) {
                console.warn('GetProjectEmployeeRoleByRole failed:', xhr.status);
                if (typeof onError === 'function') onError();
            }
        );
        /* End of Modified by Nikhil Mane on 08-May-2026 */
    }

    /* Added By Dipali V On 16th Jun 2026 — fetch all RRL pages so Save resolves cross-page checkbox selections */
    function _fetchAllRrlRowsForGroup(gid, onSuccess, onError) {
        var st = _rrlState[gid] || {};
        var projectId = parseInt(SessionProjectID, 10) || 0;
        var roleId = st.roleId || 0;
        var pageSize = st.size || _rrlApiPageSize;
        var totalPages = Math.max(1, parseInt(st.totalPages, 10) || Math.ceil((st.totalRecords || 0) / pageSize) || 1);
        var allRows = [], page = 1;
        (function next() {
            if (page > totalPages) { if (typeof onSuccess === 'function') onSuccess(allRows); return; }
            _fetchRrlFromApi(projectId, page, pageSize, roleId, '', function (rows) {
                allRows = allRows.concat(rows || []); page++; next();
            }, onError);
        })();
    }

    /* ═══════════════════════════════════════════════════════════════════════
       initGroupsByAllocatedRoles — Modified by Nikhil Mane on 05-May-2026
       ─────────────────────────────────────────────────────────────────────
       Always adds a single blank resource group row on page load.
       The RRL section within that row starts by showing ALL allocated
       resources for the project (no role filter).  When the user selects a
       role from the Project Role dropdown the RRL automatically filters to
       show only resources for that role.

       The group row itself loads page 1. Later Previous/Next clicks request
       only the selected page from the API.
       ═══════════════════════════════════════════════════════════════════════ */
    function initGroupsByAllocatedRoles() {
        var projectId = parseInt(SessionProjectID) || 0;

        /* Add the single blank row immediately */
        addResourceGroup();

        if (!projectId) return;
    }

    /* ── _buildGroupsFromRows kept for backward-compat (no longer called on load) ── */
    function _buildGroupsFromRows(rows) {
        addResourceGroup();
    }

    function _rrlRenderForGroup(gid, roleId, roleText, allRows, pagination) {
        _rrlShowLoading(gid, false);
        var rid = parseInt(roleId, 10) || 0;
        var displayRows = allRows || [];
        var apiPagination = pagination || null;
        var pageSize = (apiPagination && apiPagination.pageSize) ? apiPagination.pageSize : _rrlApiPageSize;
        var currentPage = (apiPagination && apiPagination.currentPage) ? apiPagination.currentPage : 1;
        var totalRecords = (apiPagination && apiPagination.totalRecords != null)
            ? apiPagination.totalRecords
            : displayRows.length;
        var totalPages = (apiPagination && apiPagination.totalPages != null)
            ? apiPagination.totalPages
            : Math.max(1, Math.ceil(totalRecords / pageSize));

        var hasRoleFilter = rid > 0;
        var $badge = $('#rrl-badge-' + gid);
        $badge.text(totalRecords);
        if (String(gid) === String(_REALLOC_TAB_GID)) {
            _projectAllocatedResourceCount = totalRecords; /* Added by dipali v on 18th Jun 2026 for purpose */
            updateReallocationTabBadge();
        }

        if (displayRows.length === 0 && totalRecords === 0) { _rrlShowEmpty(gid); return; }

        $('#rrl-empty-' + gid).removeClass('show');
        $('#rrl-table-wrap-' + gid).show();
        $('#rrl-table-wrap-' + gid).find('.rrl-table-actions.rrl-extend-note-row').css('display', 'flex');
        $('#rrl-table-wrap-' + gid).find('.rrl-table-grid, .rrl-table-scroll, .rrl-scroll-top').show();
        _updateRrlTabSaveVisibility(gid);

        _rrlState[gid] = {
            data: displayRows,
            page: currentPage,
            size: pageSize,
            totalRecords: totalRecords,
            totalPages: totalPages,
            roleId: rid,
            roleText: roleText || null,
            employeeName: (String(gid) === String(_REALLOC_TAB_GID)) ? ($('#rrlEmployeeNameSearch').val() || '').trim() : '',
            serverPaged: true
        };
        $('#rrl-total-text-' + gid).text('Total Records: ' + totalRecords);
        _rrlRenderPage(gid);
        if (String(gid) === String(_REALLOC_TAB_GID)) {
            _updateRrlExtendNoteVisibility();
            if (typeof _refreshProjectDefaultApproverFromRrlGrid === 'function') {
                _refreshProjectDefaultApproverFromRrlGrid(gid);
            }
        }
    }

    /* Added by dipali v on 18th Jun 2026 for purpose — server-side Employee Name search across all records */
    function _rrlHasEmployeeNameSearch(gid) {
        return String(gid) === String(_REALLOC_TAB_GID) && !!($('#rrlEmployeeNameSearch').val() || '').trim();
    }

    function _filterRrlEmployeeName(gid, immediate) {
        gid = gid || _REALLOC_TAB_GID;
        var run = function () {
            var state = _rrlState[gid] || {};
            if (typeof _rrlSyncPageSelectionFromDom === 'function') _rrlSyncPageSelectionFromDom(gid);
            _rrlFetchAndRenderPage(gid, state.roleId || 0, state.roleText || null, 1);
        };
        if (immediate) { clearTimeout(_rrlEmpNameSearchTimer); run(); return; }
        clearTimeout(_rrlEmpNameSearchTimer);
        _rrlEmpNameSearchTimer = setTimeout(run, 300);
    }

    /* Added By Dipali V On 5th Jun 2026 — Show/hide header Update button with grid data */
    function _updateRrlTabSaveVisibility(gid) {
        if (String(gid) !== String(_REALLOC_TAB_GID)) return;
        var $block = $('#rrl-tab-save-block');
        if (!$block.length) return;
        var isLoading = $('#rrl-loading-' + gid).hasClass('show');
        var tableVisible = $('#rrl-table-wrap-' + gid).is(':visible');
        var hasRows = !$('#rrl-empty-' + gid).hasClass('show') && !isLoading &&
            $('#rrl-tbody-' + gid + ' tr').length > 0 && !$('#rrl-tbody-' + gid + ' tr.rrl-no-data-row').length;
        /* Added by dipali v on 18th Jun 2026 for purpose — keep search visible on Reallocation tab even when no data */
        $block.css('display', (tableVisible && !isLoading) ? 'flex' : 'none');
        $('#btn-rrl-save-realloc').toggle(!!hasRows);
    }

    function _rrlShowLoading(gid, show) {
        var $el = $('#rrl-loading-' + gid);
        if (show) {
            $el.addClass('show');
            $('#rrl-empty-' + gid).removeClass('show');
            if (String(gid) !== String(_REALLOC_TAB_GID) && !_rrlHasEmployeeNameSearch(gid)) $('#rrl-table-wrap-' + gid).hide();
        } else { $el.removeClass('show'); }
        _updateRrlTabSaveVisibility(gid);
    }
    function _rrlShowEmpty(gid) {
        var hasEmpSearch = _rrlHasEmployeeNameSearch(gid);
        var isReallocTab = String(gid) === String(_REALLOC_TAB_GID);
        $('#rrl-loading-' + gid).removeClass('show');
        $('#rrl-table-wrap-' + gid).show();
        if (isReallocTab || hasEmpSearch) {
            /* Added by dipali v on 18th Jun 2026 for purpose — keep table header + search when no data */
            $('#rrl-empty-' + gid).removeClass('show');
            $('#rrl-table-wrap-' + gid).find('.rrl-table-actions.rrl-extend-note-row').css('display', 'flex');
            $('#rrl-table-wrap-' + gid).find('.rrl-table-grid, .rrl-table-scroll, .rrl-scroll-top').show();
            $('#rrl-tbody-' + gid).html('<tr class="rrl-no-data-row"><td colspan="8" class="text-center py-2">No data available in table.</td></tr>');
            if (isReallocTab && typeof _rrlResizeBodyScroll === 'function') _rrlResizeBodyScroll(gid);
        } else {
            $('#rrl-empty-' + gid).addClass('show').text(
                String(gid) === String(_REALLOC_TAB_GID)
                    ? 'No data available in table.'
                    : 'No data available in table.'
            );
            $('#rrl-table-wrap-' + gid).find('.rrl-table-actions, .rrl-table-grid, .rrl-table-scroll, .rrl-scroll-top').hide();
            $('#rrl-tbody-' + gid).empty();
        }
        $('#rrl-total-text-' + gid).text('Total Records: 0');
        $('#rrl-prev-' + gid + ', #rrl-next-' + gid).prop('disabled', true);
        $('#rrl-badge-' + gid).text('0');
        updateReallocationTabBadge();
        /* Added by dipali v on 18th Jun 2026 for purpose — keep RRL state when Employee Name search has no match */
        if (!isReallocTab && !hasEmpSearch) delete _rrlState[gid];
        else if (_rrlState[gid]) {
            _rrlState[gid].data = [];
            _rrlState[gid].totalRecords = 0;
            _rrlState[gid].totalPages = 0;
            _rrlState[gid].page = 1;
        }
        _updateRrlTabSaveVisibility(gid);
    }
    function _rrlClearGroup(gid) {
        $('#rrl-loading-' + gid).removeClass('show');
        $('#rrl-empty-' + gid).removeClass('show');
        $('#rrl-table-wrap-' + gid).hide();
        $('#rrl-tbody-' + gid).empty();
        $('#rrl-badge-' + gid).text('0');
        updateReallocationTabBadge();
        updateGroupDeleteBtn(gid, 0);
        delete _rrlState[gid];
        _updateRrlTabSaveVisibility(gid);
    }

    /* Sum per-group allocated counts into the single tab-level badge. */
    function updateReallocationTabBadge() {
        var total = parseInt($('#rrl-badge-' + _REALLOC_TAB_GID).text() || '0', 10) || 0;
        var $tabBadge = $('#rrl-tab-badge');
        if (!$tabBadge.length) return;
        $tabBadge.text(total).toggleClass('empty', total === 0);
    }

    /* Added by Nikhil Mane on 05-May-2026
       Enables or disables the Action column Delete button based on allocated resource count.
       count = number of resources already allocated to this role (from rrl-badge).
       Delete is allowed only when count === 0. */
    function updateGroupDeleteBtn(gid, count) {
        var $btn = $('#btn-action-delete-' + gid);
        if ($btn.length === 0 || !$btn.is(':visible')) return;
        /* Added By Dipali V On 26th May - Manual (newly added) rows: Remove always enabled */
        if (!_isBulkAllocRoleGroupFromDb(gid)) {
            $btn.prop('disabled', false);
            _setBsTooltip($btn[0], RES.C_DeleteRowTooltip);
            return;
        }
        var hasAllocated = count > 0;
        $btn.prop('disabled', hasAllocated);
        var tip = hasAllocated
            ? 'Cannot remove: this role has ' + count + ' already-allocated resource(s). Remove them first.'
            : RES.C_DeleteRowTooltip;
        _setBsTooltip($btn[0], tip);
    }
    /* End of Added by Nikhil Mane on 05-May-2026 */

    /* Added by Nikhil Mane on 06-May-2026 — Converts a decimal hours value returned by the SP
       (e.g. "543.57") into HH:MM display format (e.g. "543:34").
       Handles: null / empty / non-numeric as blank; already-HH:MM strings passed through as-is.
       Formula: hours = floor(decimal), minutes = round((decimal - hours) * 60), clamped to 0–59. */
    function decimalToHHMM(val) {
        if (val == null || val === '' || val === undefined) return '';
        var str = String(val).trim();
        if (!str || str === '0' || str === '0.00') return '00:00';
        var hours, minutes;
        if (str.indexOf(':') !== -1) {
            var parts = str.split(':');
            if (parts.length !== 2) return '';
            hours = parseInt(parts[0].replace(/\D/g, ''), 10);
            minutes = parseInt((parts[1] || '0').replace(/\D/g, ''), 10);
            if (isNaN(hours)) return '';
            if (isNaN(minutes)) minutes = 0;
            minutes = Math.min(59, Math.max(0, minutes));
        } else {
            var dec = parseFloat(str);
            if (isNaN(dec) || dec < 0) return '';
            hours = Math.floor(dec);
            minutes = Math.min(59, Math.round((dec - hours) * 60));
        }
        var hh = String(hours);
        if (hh.length < 2) hh = hh.padStart(2, '0');
        return hh + ':' + String(minutes).padStart(2, '0');
    }
    /* End of Added by Nikhil Mane on 06-May-2026 */
    //Added By Dipali V On 25th May 2026 for Tooltip issue on dynamically added elements
    function initializeVendorTooltips() { reinitTooltips(); }


    /* Added by Nikhil Mane on 05-May-2026 — RRL pagination state & helpers */
    var _rrlState = {}; /* keyed by gid: { data, page, size } */

    /* Added By Dipali V On 5th Jun 2026 — Additional Columns helpers (Bulk Allocation role row) */
    function _baColCanAddColumn() {
        return !!addAccess;
    }

    function _baColCanEditColumn() {
        return !!editAccess;
    }

    function _baColIsCheckboxDisabled(key, isSelected) {
        if (isSelected && !_baColCanEditColumn()) return true;
        if (!isSelected && !_baColCanAddColumn()) return true;
        return false;
    }

    function _baColLabelFor(key) {
        var col = (_baColALL_COLS || []).find(function (c) { return c.key === key; });
        if (col && col.label) return col.label;
        if (key === 'reporting-to') return RES.C_ReportingTo || 'Reporting To';
        if (key === 'resource-status') return RES.C_ResourceStatus || 'Resource Status';
        if (key === 'work-hh') return RES.C_WorkHHMM || 'Work (HH)';
        if (key === 'billable') return RES.C_Billable || 'Billable';
        if (key === 'is-default-approver') return RES.C_IsDefaultApprover || 'Is Default Approver';
        return key;
    }

    function _baColNormKey(name) {
        return (name || '').toString().trim().toLowerCase();
    }

    function _baColResolvePrefMatch(p) {
        if (!p) return null;
        var colName = _baColNormKey(p.columnName || p.ColumnName || p.columnKey || p.ColumnKey);
        var colId = parseInt(p.columnID || p.ColumnID, 10);
        var match = null;
        if (colName) {
            match = (_baColALL_COLS || []).find(function (c) { return _baColNormKey(c.key) === colName; });
        }
        if (!match && !isNaN(colId) && colId > 0) {
            match = (_baColALL_COLS || []).find(function (c) { return parseInt(c.id, 10) === colId; });
        }
        return match;
    }

    function _baColPrefApplicable(p) {
        var v = (p.applicable !== undefined && p.applicable !== null) ? p.applicable : p.Applicable;
        return v === true || v === 1 || v === '1' || v === 'true';
    }

    function _baColUnwrapPrefs(response) {
        if (!response) return null;
        var d = response.data !== undefined ? response.data : response;
        if (Array.isArray(d)) return d;
        if (!d || typeof d !== 'object') return null;
        if (Array.isArray(d.data)) return d.data;
        if (Array.isArray(d.bulkAllocationColumnPreferenceModel)) return d.bulkAllocationColumnPreferenceModel;
        if (Array.isArray(d.BulkAllocationColumnPreferenceModel)) return d.BulkAllocationColumnPreferenceModel;
        return null;
    }

    function _baColUnwrapMasterRows(response) {
        if (!response) return null;
        var d = response.data !== undefined ? response.data : response;
        if (Array.isArray(d)) return d;
        if (!d || typeof d !== 'object') return null;
        if (Array.isArray(d.data)) return d.data;
        if (Array.isArray(d.bulkAllocationColumnMasterModel)) return d.bulkAllocationColumnMasterModel;
        if (Array.isArray(d.BulkAllocationColumnMasterModel)) return d.BulkAllocationColumnMasterModel;
        return null;
    }

    function _baDestroyRgSelectpicker($sel) {
        if (!$sel || !$sel.length) return;
        if ($sel.data('selectpicker')) {
            try { $sel.selectpicker('destroy'); } catch (e) { /* ignore */ }
        }
    }

    function _isDefaultApproverColumnAllowed() {
        if (!_uiSettings) return false;
        var rawArr = Array.isArray(_uiSettings) ? _uiSettings : null;
        var settingRow = (rawArr && rawArr.length > 0) ? rawArr[0] : _uiSettings;
        return !!(
            settingRow.showResourceAllocation ||
            settingRow.ShowResourceAllocation ||
            settingRow.IsDefaultApproverEnabled ||
            settingRow.isDefaultApproverEnabled
        );
    }

    /* Added By Dipali V On 5th Jun 2026 — Default Approver: one per project (Allocation + Reallocation) */
    function _defaultApproverConfirmMessage() {
        var msg = (RES.C_ConfirmChangeDefaultApprover || '').toString().trim();
        return msg || 'This will change the previously set Default Approver. Do you want to continue?';
    }

    function _onlyOneDefaultApproverMessage() {
        var msg = (RES.A_OnlyOneDefaultApprover || '').toString().trim();
        return msg || 'Only one resource can be assigned as the Default Approver on a project.';
    }

    function _getRgNoOfResources(gid) {
        return parseInt($('#rg-count-' + gid).val(), 10) || 0;
    }

    function _setDefaultApproverCheckboxEnabled($el, enabled) {
        if (!$el || !$el.length) return;
        $el.prop('disabled', !enabled);
        /* Added By Dipali V On 17th Jun 2026 — when disabled, force no-drop cursor (avoid inherited help/question cursor) */
        $el.css('cursor', enabled ? 'pointer' : 'no-drop');
        if ($el.attr('id') === 'ocIsDefaultApprover') {
            $('#divOcIsDefaultApprover label[for="ocIsDefaultApprover"]').css('cursor', enabled ? 'pointer' : 'no-drop');
        }
        if (!enabled) $el.prop('checked', false);
    }

    function _baFindDefaultApproverHolderGid() {
        var found = null;
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            var gid = $(this).attr('data-group');
            if (!gid) return;
            if ($('#rg-approver-' + gid).prop('checked')) { found = gid; return false; }
            if ($('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]:checked').length) {
                found = gid;
                return false;
            }
        });
        return found;
    }

    /* Bulk Allocation: one Default Approver per project; disable on other role rows when one is checked */
    function _syncBaDefaultApproverForGroup(gid) {
        if (!gid || !_isDefaultApproverColumnAllowed()) return;
        var holderGid = _baFindDefaultApproverHolderGid();
        var allow = _getRgNoOfResources(gid) === 1 && (!holderGid || String(holderGid) === String(gid));
        _setDefaultApproverCheckboxEnabled($('#rg-approver-' + gid), allow);
        /* Added By Dipali V On 17th Jun 2026 — activeGroupId can be number while gid is string; normalize to keep offcanvas Default Approver in sync */
        if (String(activeGroupId) === String(gid)) {
            _setDefaultApproverCheckboxEnabled($('#ocIsDefaultApprover'), allow);
        }
        $('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]').each(function () {
            _setDefaultApproverCheckboxEnabled($(this), allow);
        });
        if (!allow && typeof _syncRgDynToOffcanvas === 'function') {
            _syncRgDynToOffcanvas(gid);
        }
    }

    function _syncBaDefaultApproverAllGroups() {
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            _syncBaDefaultApproverForGroup($(this).attr('data-group'));
        });
    }

    function _countBaPendingSelectedResources() {
        var n = 0;
        document.querySelectorAll('tbody[id^="sel-res-body-"] tr').forEach(function () { n++; });
        return n;
    }

    function _syncBaPendingAllocNote() {
        var $note = $('#baPendingAllocNote');
        if (!$note.length) return;
        var n = _countBaPendingSelectedResources();
        if (n <= 0) { $note.hide().text(''); return; }
        var tpl = (RES.C_ResourceSelectedNotAllocated || RES.C_RoleSelectedNotAllocated || '{0} resource(s) selected, but not allocated on project. Click on Allocate button to add on project.').toString();
        $note.text(/\{0\}/.test(tpl) ? _resFmt(tpl, n) : tpl).show();
    }

    function _countDefaultApproversInRoleBucketMap(roleBucketMap) {
        var count = 0;
        Object.keys(roleBucketMap || {}).forEach(function (k) {
            (roleBucketMap[k].resources || []).forEach(function (r) {
                if (r.isDefaultApprover) count++;
            });
        });
        return count;
    }

    function _rrlApproverIconHtml(isApprover) {
        return isApprover
            ? '<i class="fas fa-check-circle" style="color:#16a34a;" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Default Approver: Yes "></i>'
            : '<i class="fas fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Default Approver: No " style="color:#dc2626;"></i>';
    }

    function _rrlSetRowDefaultApproverUi($row, rowKey, isApprover) {
        if (!$row || !$row.length) return;
        rowKey = rowKey || $row.attr('data-row-key');
        var $chk = rowKey ? $row.find('#rrl-approver-' + rowKey) : $row.find('input[id^="rrl-approver-"]');
        if ($chk.length) $chk.prop('checked', !!isApprover);
        $row.attr('data-default-approver', isApprover ? '1' : '0')
            .attr('data-rrl-persisted-approver', isApprover ? '1' : '0');
        $row.find('.rrl-col-approver .rrl-display-icon').html(_rrlApproverIconHtml(!!isApprover));
    }

    function _getEffectiveProjectDefaultApproverEmployeeId() {
        return parseInt(_projectDefaultApproverEmployeeId, 10) || parseInt(_initialProjectDefaultApproverEmployeeId, 10) || 0;
    }

    function _rrlRowIsDefaultApprover($row) {
        if (!$row || !$row.length) return false;
        if (($row.attr('data-rrl-persisted-approver') || $row.attr('data-default-approver')) === '1') return true;
        var rowKey = $row.attr('data-row-key');
        var $chk = rowKey ? $row.find('#rrl-approver-' + rowKey) : $row.find('input[id^="rrl-approver-"]');
        return $chk.length && $chk.prop('checked') === true;
    }

    function _buildRrlDefaultApproverRef($row, rowKey) {
        return {
            $row: $row,
            rowKey: rowKey,
            employeeId: parseInt($row.attr('data-employee-id'), 10) || 0,
            perId: parseInt($row.attr('data-project-employee-role-id'), 10) || 0
        };
    }

    function _findRrlExistingDefaultApproverRow(gid, excludeRowKey) {
        var existing = null;
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $row = $(this);
            var rowKey = $row.attr('data-row-key');
            if (excludeRowKey && rowKey === excludeRowKey) return;
            if (!_rrlRowIsDefaultApprover($row)) return;
            existing = _buildRrlDefaultApproverRef($row, rowKey);
            return false;
        });
        if (existing) return existing;

        var daEmpId = _getEffectiveProjectDefaultApproverEmployeeId();
        if (daEmpId <= 0) return null;
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $row = $(this);
            var rowKey = $row.attr('data-row-key');
            if (excludeRowKey && rowKey === excludeRowKey) return;
            if ((parseInt($row.attr('data-employee-id'), 10) || 0) !== daEmpId) return;
            existing = _buildRrlDefaultApproverRef($row, rowKey);
            return false;
        });
        return existing;
    }

    function _baFindPendingDefaultApproverEmployeeId() {
        var found = 0;
        $('#bulkAllocationGroupsContainer .resource-group').each(function () {
            var gid = $(this).attr('data-group');
            if (!gid) return;
            $('#sel-res-body-' + gid + ' tr').each(function () {
                var empId = parseInt($(this).attr('data-res-id'), 10) || parseInt($(this).data('resId'), 10) || 0;
                if (!empId) return;
                var uid = gid + '_' + empId;
                var chk = document.getElementById('chkApprover_res_' + uid);
                if (chk && chk.checked) {
                    found = empId;
                    return false;
                }
            });
            if (found) return false;
        });
        return found;
    }

    function _needsDefaultApproverChangeConfirm(targetEmployeeId, targetPerId, gid, excludeRowKey) {
        targetEmployeeId = parseInt(targetEmployeeId, 10) || 0;
        targetPerId = parseInt(targetPerId, 10) || 0;

        var existing = null;
        if (gid) existing = _findRrlExistingDefaultApproverRow(gid, excludeRowKey);
        var daEmpId = _getEffectiveProjectDefaultApproverEmployeeId();
        if (!existing && daEmpId > 0) {
            existing = { employeeId: daEmpId, perId: 0, rowKey: null, $row: $() };
        }
        if (!existing) return false;
        if (targetPerId > 0 && existing.perId > 0 && existing.perId === targetPerId) return false;
        if (targetEmployeeId > 0 && existing.employeeId === targetEmployeeId) return false;
        return true;
    }

    function _refreshProjectDefaultApproverFromRrlGrid(gid) {
        gid = gid || _REALLOC_TAB_GID;
        var found = _findRrlExistingDefaultApproverRow(gid, null);
        if (!found) return;
        _projectDefaultApproverEmployeeId = found.employeeId;
        _projectDefaultApproverEmployeeName = found.$row.find('td:first strong').text().trim() || _projectDefaultApproverEmployeeName;
        _ensureReportingToOption(found.employeeId, _projectDefaultApproverEmployeeName);
        _applyProjectDefaultApproverReportingTo();
    }

    function _promptDefaultApproverChange(onConfirm, onCancel) {
        var $msg = $('#defaultApproverChangeMessage');
        if ($msg.length) $msg.text(_defaultApproverConfirmMessage());
        window._rrlDaChangeOnConfirm = (typeof onConfirm === 'function') ? onConfirm : null;
        window._rrlDaChangeOnCancel = (typeof onCancel === 'function') ? onCancel : null;
        var el = document.getElementById('defaultApproverChangeModal');
        if (!el) return;
        el.style.zIndex = '1075';
        var modal = bootstrap.Modal.getOrCreateInstance(el);
        function _raiseDefaultApproverModalBackdrop() {
            var backdrops = document.querySelectorAll('.modal-backdrop');
            if (backdrops.length) backdrops[backdrops.length - 1].style.zIndex = '1074';
        }
        el.addEventListener('shown.bs.modal', _raiseDefaultApproverModalBackdrop, { once: true });
        modal.show();
    }

    function _rrlNeedsDefaultApproverChangeConfirm(gid, targetRowKey, targetEmployeeId, targetPerId) {
        return _needsDefaultApproverChangeConfirm(targetEmployeeId, targetPerId, gid, targetRowKey);
    }

    function _rrlClearOtherDefaultApprovers(gid, keepRowKey, keepPerId) {
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $row = $(this);
            var rowKey = $row.attr('data-row-key');
            var perId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
            if (keepRowKey && rowKey === keepRowKey) return;
            if (keepPerId > 0 && perId === keepPerId) return;
            if (_rrlRowIsDefaultApprover($row)) {
                _rrlSetRowDefaultApproverUi($row, rowKey, false);
            }
        });
    }

    function _rrlNormalizeDefaultApproverInSavePayload(gid, projectEmployeeRoles) {
        var approverItems = (projectEmployeeRoles || []).filter(function (r) { return !!r.isDefaultApprover; });
        if (approverItems.length > 1) {
            return { ok: false, message: _onlyOneDefaultApproverMessage() };
        }
        if (approverItems.length === 1) {
            var newItem = approverItems[0];
            (projectEmployeeRoles || []).forEach(function (r) {
                if (r.projectEmployeeRoleId !== newItem.projectEmployeeRoleId) {
                    r.isDefaultApprover = false;
                }
            });
        }
        return { ok: true, roles: projectEmployeeRoles };
    }

    function _rrlValidateAndSaveDefaultApproverThenSave(gid, projectEmployeeRoles, options) {
        var normalized = _rrlNormalizeDefaultApproverInSavePayload(gid, projectEmployeeRoles);
        if (!normalized.ok) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(normalized.message);
            return;
        }
        projectEmployeeRoles = normalized.roles;
        var newApprover = (projectEmployeeRoles || []).find(function (r) { return !!r.isDefaultApprover; });
        if (!newApprover) {
            _saveRrlPayloadToBackend(gid, projectEmployeeRoles, options);
            return;
        }
        var targetRowKey = null;
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var perId = parseInt($(this).attr('data-project-employee-role-id'), 10) || 0;
            if (perId === newApprover.projectEmployeeRoleId) {
                targetRowKey = $(this).attr('data-row-key');
                return false;
            }
        });
        if (!_rrlNeedsDefaultApproverChangeConfirm(
            gid, targetRowKey, newApprover.employeeID, newApprover.projectEmployeeRoleId)) {
            _saveRrlPayloadToBackend(gid, projectEmployeeRoles, options);
            return;
        }
        /* Offcanvas: user already confirmed on #rrlOcApprover checkbox — do not prompt again on Save */
        if (_isRrlSaveFromOffcanvas(options && options.fromWhere)) {
            _rrlClearOtherDefaultApprovers(gid, targetRowKey, newApprover.projectEmployeeRoleId);
            _saveRrlPayloadToBackend(gid, projectEmployeeRoles, options);
            return;
        }
        _promptDefaultApproverChange(
            function () {
                _rrlClearOtherDefaultApprovers(gid, targetRowKey, newApprover.projectEmployeeRoleId);
                _saveRrlPayloadToBackend(gid, projectEmployeeRoles, options);
            },
            function () { /* No — leave existing Default Approver unchanged */ }
        );
    }

    function _buildBaRgDynHeadersHtml(gid) {
        var cols = (_baColALL_COLS && _baColALL_COLS.length) ? _baColALL_COLS : _baColFALLBACK;
        return cols.map(function (c) {
            var cls = 'ba-rg-dyn-th ba-dyn-th';
            if (c.key === 'reporting-to') cls += ' col-rpt';
            else if (c.key === 'resource-status') cls += ' col-status';
            else if (c.key === 'work-hh') cls += ' col-work';
            else if (c.key === 'billable') cls += ' col-bill';
            else if (c.key === 'is-default-approver') cls += ' col-approver';
            var extra = (c.key === 'is-default-approver') ? ' id="th-col-approver-' + gid + '"' : '';
            var hdrLabel = _baRgHeaderLabel(c.key);
            var fullLabel = _baColLabelFor(c.key);
            var hdrTitle = ' ' + _baRgHdrTooltipAttrs(fullLabel);
            return '<span class="' + cls + '" data-col="' + escHtml(c.key) + '"' + extra + hdrTitle + '>' + escHtml(hdrLabel) + '</span>';
        }).join('');
    }

    function _buildBaRgDynCellsHtml(gid) {
        var cols = (_baColALL_COLS && _baColALL_COLS.length) ? _baColALL_COLS : _baColFALLBACK;
        return cols.map(function (c) {
            var cls = 'ba-rg-dyn-td ba-dyn-td';
            if (c.key === 'reporting-to') cls += ' col-rpt';
            else if (c.key === 'resource-status') cls += ' col-status';
            else if (c.key === 'work-hh') cls += ' col-work';
            else if (c.key === 'billable') cls += ' col-bill';
            else if (c.key === 'is-default-approver') cls += ' col-approver';
            if (c.key === 'reporting-to') {
                return '<div class="' + cls + '" data-col="reporting-to">' +
                    '<select id="rg-rpt-' + gid + '" class="selectpicker" data-live-search="true" data-width="100%" data-container="body" ' +
                    'data-none-selected-text="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '" title="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '">' +
                    '<option value="" disabled hidden></option></select></div>';
            }
            if (c.key === 'resource-status') {
                return '<div class="' + cls + '" data-col="resource-status">' +
                    '<select id="rg-status-' + gid + '" class="selectpicker" data-live-search="true" data-width="100%" data-container="body"></select></div>';
            }
            if (c.key === 'work-hh') {
                return '<div class="' + cls + '" data-col="work-hh">' +
                    '<input type="text" id="rg-work-' + gid + '" class="form-control form-control-sm" placeholder="' + escHtml(RES.C_HHMMPlaceholder || 'HH:MM') + '" ' +
                    'maxlength="8" oninput="workHHMMInput(this)" autocomplete="off" inputmode="numeric"></div>';
            }
            if (c.key === 'billable') {
                return '<div class="' + cls + ' rg-chk-cell" data-col="billable">' +
                    '<input type="checkbox" id="rg-billable-' + gid + '" class="form-check-input" style="width:16px;height:16px;cursor:pointer;"></div>';
            }
            if (c.key === 'is-default-approver') {
                return '<div class="' + cls + ' rg-chk-cell" data-col="is-default-approver">' +
                    '<input type="checkbox" id="rg-approver-' + gid + '" class="form-check-input" style="width:16px;height:16px;cursor:pointer;"></div>';
            }
            return '<div class="' + cls + '" data-col="' + escHtml(c.key) + '"></div>';
        }).join('');
    }

    function _baRgHeaderLabel(key) {
        if (key === 'is-default-approver') return RES.C_IsDefaultApprover || 'Is Default Approver';
        if (key === 'work-hh') return RES.C_WorkHHMM || 'Work (HH)';
        if (key === 'billable') return RES.C_Billable || 'Billable';
        return _baColLabelFor(key);
    }

    function _baRgColTrackSize(key) {
        switch (key) {
            case 'reporting-to': return 'minmax(128px, 1.25fr)';
            case 'resource-status': return 'minmax(108px, 1fr)';
            case 'work-hh': return 'minmax(76px, 0.7fr)';
            case 'billable': return 'minmax(56px, 56px)';
            case 'is-default-approver': return 'minmax(62px, 62px)';
            default: return 'minmax(80px, 0.85fr)';
        }
    }

    function _baRgVisibleDynKeys() {
        return (_baColSelectedOrder || []).filter(function (k) {
            return typeof _baColIsVisible === 'function' && _baColIsVisible(k);
        });
    }

    function _baRgGridTemplate() {
        var visDyn = _baRgVisibleDynKeys();
        var dynCount = visDyn.length;
        var dateTrack = dynCount >= 3 ? 'minmax(86px, 0.82fr)' : (dynCount >= 1 ? 'minmax(90px, 0.9fr)' : 'minmax(95px, 1fr)');
        var roleTrack = dynCount >= 2 ? 'minmax(104px, 1.35fr)' : 'minmax(110px, 1.5fr)';
        var base = roleTrack + ' minmax(48px, 0.48fr) ' + dateTrack + ' ' + dateTrack + ' minmax(68px, 0.52fr)';
        var dynParts = visDyn.map(function (k) { return _baRgColTrackSize(k); });
        return base + (dynParts.length ? (' ' + dynParts.join(' ')) : '') + ' minmax(76px, 76px)';
    }

    function _baRgGridMinWidth() {
        var visDyn = _baRgVisibleDynKeys();
        var w = 560;
        visDyn.forEach(function (k) {
            if (k === 'reporting-to') w += 128;
            else if (k === 'resource-status') w += 108;
            else if (k === 'work-hh') w += 76;
            else if (k === 'billable') w += 56;
            else if (k === 'is-default-approver') w += 62;
            else w += 80;
        });
        if (visDyn.length >= 2) w += 24;
        return w;
    }

    function _getBaOcDynFieldValues() {
        return {
            reportingTo: $('#ocReportingTo').val() || '',
            resourceStatus: $('#ocResourceStatus').val() || '',
            workHM: ($('#ocWorkHM').val() || '').trim(),
            isBillable: !!(document.getElementById('ocIsBillable') && document.getElementById('ocIsBillable').checked),
            isDefaultApprover: !!(document.getElementById('ocIsDefaultApprover') && document.getElementById('ocIsDefaultApprover').checked)
        };
    }

    function _getBaListDynSnapshot(gid) {
        var $tr = $('#sel-res-body-' + gid + ' tr').first();
        if (!$tr.length) return null;
        var rid = $tr.attr('data-res-id');
        if (!rid) return null;
        var uid = gid + '_' + rid;
        return {
            reportingTo: $('#cboReportingTo_res_' + uid).val() || '',
            resourceStatus: $('#cboResStatus_res_' + uid).val() || '',
            workHM: ($('#txtWork_res_' + uid).val() || '').trim(),
            isBillable: !!(document.getElementById('chkBillable_res_' + uid) && document.getElementById('chkBillable_res_' + uid).checked),
            /* Added By Dipali V On 17th Jun 2026 — default approver is project-level; if any selected row is checked, keep offcanvas checked */
            isDefaultApprover: $('#sel-res-body-' + gid + ' input[id^="chkApprover_res_"]:checked').length > 0
        };
    }

    function _getRgDynFieldValues(gid) {
        var oc = _getBaOcDynFieldValues();
        var rgRpt = ($('#rg-rpt-' + gid).val() || '').trim();
        var rgStatus = ($('#rg-status-' + gid).val() || '').trim();
        var rgBill = document.getElementById('rg-billable-' + gid);
        var rgAppr = document.getElementById('rg-approver-' + gid);
        var workHM = _getRgWorkHoursValue(gid) || oc.workHM;
        return {
            reportingTo: rgRpt || oc.reportingTo,
            resourceStatus: rgStatus || oc.resourceStatus,
            workHM: workHM,
            isBillable: rgBill ? rgBill.checked : oc.isBillable,
            isDefaultApprover: rgAppr ? rgAppr.checked : oc.isDefaultApprover
        };
    }

    function _populateRgReportingToSelect(gid, selectedVal) {
        var $sel = $('#rg-rpt-' + gid);
        if (!$sel.length) return;
        if (_projectDefaultApproverEmployeeId > 0) {
            _ensureReportingToOption(_projectDefaultApproverEmployeeId, _projectDefaultApproverEmployeeName || '');
        }
        _fillReportingToOptions($sel, window._reportingToAllRows || window._reportingToOptions, selectedVal, null);
        if ((!selectedVal || selectedVal === '0') && _shouldUsePreferredReportingTo($sel.val()) &&
            (window._reportingToAllRows || window._reportingToOptions || []).length) {
            _selectLoggedInAsDefaultReportingTo($sel);
        }
    }

    function _populateRgStatusSelect(gid, selectedVal) {
        var $sel = $('#rg-status-' + gid);
        if (!$sel.length) return;
        var opts = '';
        $('#ocResourceStatus option').each(function () {
            var v = $(this).val();
            var t = $(this).text();
            var sel = (v && v === String(selectedVal || '')) ? ' selected' : '';
            opts += '<option value="' + escHtml(v) + '"' + sel + '>' + escHtml(t) + '</option>';
        });
        if (!opts) opts = '<option value="">Select</option>';
        _baDestroyRgSelectpicker($sel);
        $sel.html(opts);
        $sel.selectpicker();
    }

    function initBaRgDynControls(gid, preset) {
        if (!gid) return;
        var preserved = preset || null;
        _populateRgReportingToSelect(gid, preserved ? preserved.reportingTo : '');
        _populateRgStatusSelect(gid, preserved ? preserved.resourceStatus : '');
        $('#rg-work-' + gid).val((preserved && preserved.workHM) ? preserved.workHM : _getRgWorkHoursValue(gid));
        var bill = document.getElementById('rg-billable-' + gid);
        var appr = document.getElementById('rg-approver-' + gid);
        if (bill) bill.checked = preserved ? !!preserved.isBillable : false;
        if (appr) appr.checked = preserved ? !!preserved.isDefaultApprover : false;
        _bindRgWorkHoursListSync(gid);
        _bindRgResourceStatusSync(gid);
        _bindRgReportingToSync(gid);
        _bindRgBillableApproverSync(gid);
        _syncBaDefaultApproverForGroup(gid);
        if (_isRgWorkHoursVisible() && !(preserved && (preserved.workHM || '').trim())) {
            _autoPopulateRgWorkHours(gid, { onlyIfEmpty: false, syncOffcanvas: false });
        }
    }

    function _refreshAllBaRgReportingToDropdowns() {
        document.querySelectorAll('#tabBulkAllocation .resource-group').forEach(function (grp) {
            var gid = grp.getAttribute('data-group');
            if (!gid || !$('#rg-rpt-' + gid).length) return;
            var cur = $('#rg-rpt-' + gid).val() || '';
            _populateRgReportingToSelect(gid, cur);
            if (_shouldUsePreferredReportingTo(cur)) _selectLoggedInAsDefaultReportingTo($('#rg-rpt-' + gid));
        });
    }

    function _syncRgDynToOffcanvas(gid) {
        if (!gid) return;
        var list = _getBaListDynSnapshot(gid);
        if (list) {
            if (list.reportingTo) _applyReportingToSync(gid, list.reportingTo, 'list');
            if (list.resourceStatus) _applyResourceStatusSync(gid, list.resourceStatus, 'list');
            if (list.workHM) {
                $('#ocWorkHM').val(list.workHM);
                _offcanvasLastDefaults.workHM = list.workHM;
                if ($('#rg-work-' + gid).length) $('#rg-work-' + gid).val(list.workHM);
            }
            _applyBillableSync(gid, list.isBillable, 'list');
            _applyDefaultApproverSync(gid, list.isDefaultApprover, 'list');
        }
        var v = _getRgDynFieldValues(gid);
        if ($('#rg-rpt-' + gid).length) {
            var rptVal = v.reportingTo || '';
            _applyReportingToSync(gid, rptVal, 'rg');
            if (!rptVal) {
                var ocRpt = String($('#ocReportingTo').val() || '').trim();
                if (!ocRpt) _ensureDefaultReportingToSelection();
                ocRpt = String($('#ocReportingTo').val() || '').trim();
                if (ocRpt) _applyReportingToSync(gid, ocRpt, 'oc');
            }
        }
        if ($('#rg-status-' + gid).length) {
            _applyResourceStatusSync(gid, v.resourceStatus || '', 'rg');
        }
        if ($('#rg-work-' + gid).length) {
            $('#ocWorkHM').val(_getRgWorkHoursValue(gid) || '');
            _offcanvasLastDefaults.workHM = $('#ocWorkHM').val() || '';
        } else if (!_isRgWorkHoursVisible()) {
            var ocWork = (_offcanvasLastDefaults.workHM || '').trim();
            if (ocWork) $('#ocWorkHM').val(ocWork);
            else if (_canRefreshRgAutoWorkHours(gid)) _autoPopulateRgWorkHours(gid, { syncOffcanvas: true, onlyIfEmpty: false });
        }
        if ($('#rg-billable-' + gid).length) {
            _applyBillableSync(gid, !!v.isBillable, 'rg');
        }
        if ($('#rg-approver-' + gid).length) {
            _applyDefaultApproverSync(gid, !!v.isDefaultApprover, 'rg');
        }
        if ($('#ocReportingTo').length && _shouldUsePreferredReportingTo($('#ocReportingTo').val())) {
            _ensureDefaultReportingToSelection();
        }
    }

    window.toggleBaAdditionalColumns = function () {
        var body = document.getElementById('baAdditionalColBody');
        var ch = document.getElementById('baAdditionalColChevron');
        if (!body) return;
        var open = window.getComputedStyle(body).display !== 'none';
        body.style.display = open ? 'none' : 'block';
        body.style.marginTop = open ? '' : '8px';
        if (ch) ch.classList.toggle('open', !open);
    };

    function _baColDDClose() {
        var dd = document.getElementById('baColDropdown');
        var btn = document.getElementById('baTagBarChevronBtn');
        if (!dd || !_baColDdOpen) return;
        dd.classList.remove('open');
        if (btn) btn.classList.remove('open');
        _baColDdOpen = false;
    }

    function _baColDDOpen() {
        var dd = document.getElementById('baColDropdown');
        var btn = document.getElementById('baTagBarChevronBtn');
        var body = document.getElementById('baAdditionalColBody');
        if (!dd || _baColDdOpen) return;
        if (body && window.getComputedStyle(body).display === 'none') {
            body.style.display = 'block';
            body.style.marginTop = '8px';
            var ch = document.getElementById('baAdditionalColChevron');
            if (ch) ch.classList.add('open');
        }
        dd.classList.add('open');
        if (btn) btn.classList.add('open');
        _baColDdOpen = true;
    }

    function _baColRenderTagBar() {
        var bar = document.getElementById('baTagBar');
        if (!bar) return;
        var chevBtn = bar.querySelector('.tag-bar-chevron-btn');
        Array.from(bar.children).forEach(function (ch) {
            if (!ch.classList.contains('tag-bar-chevron-btn')) bar.removeChild(ch);
        });
        _baColSelectedOrder.forEach(function (key) {
            var pill = document.createElement('span');
            pill.className = 'col-tag';
            var removeCls = _baColCanEditColumn() ? 'remove-tag' : 'remove-tag is-disabled';
            var removeOnclick = _baColCanEditColumn()
                ? (' onclick="deselectBaCol(event,\'' + key + '\')"')
                : '';
            pill.innerHTML = _baColLabelFor(key) +
                '<span class="' + removeCls + '"' + removeOnclick + ' title="Remove">&#x2715;</span>';
            bar.insertBefore(pill, chevBtn);
        });
    }

    function _baColRenderDropdown() {
        var dd = document.getElementById('baColDropdown');
        if (!dd) return;
        dd.innerHTML = '';
        if (_baColSelectedOrder.length > 0) {
            var lbl = document.createElement('div');
            lbl.className = 'dd-section-label';
            lbl.textContent = 'Selected : drag to reorder';
            dd.appendChild(lbl);
            _baColSelectedOrder.forEach(function (key) { dd.appendChild(_baColMakeDropdownRow(key, true)); });
        }
        if (_baColUnselectedKeys.length > 0) {
            if (_baColSelectedOrder.length > 0) {
                var hr = document.createElement('hr');
                hr.className = 'dd-divider';
                dd.appendChild(hr);
            }
            _baColUnselectedKeys.forEach(function (key) { dd.appendChild(_baColMakeDropdownRow(key, false)); });
        }
        dd.scrollTop = 0;
    }

    function _baColMakeDropdownRow(key, isSelected) {
        var row = document.createElement('div');
        var cbDisabled = _baColIsCheckboxDisabled(key, isSelected);
        row.className = 'col-dd-row' + (isSelected ? ' is-selected' : '') + (cbDisabled ? ' is-col-locked' : '');
        row.setAttribute('data-col', key);
        if (isSelected && _baColCanEditColumn()) row.setAttribute('draggable', 'true');
        var cbId = 'ba-chk-' + key;
        row.innerHTML =
            '<span class="dd-handle" title="Drag to reorder">&#8942;&#8942;</span>' +
            '<input type="checkbox" id="' + cbId + '" data-col="' + key + '"' + (isSelected ? ' checked' : '') + (cbDisabled ? ' disabled' : '') + ' />' +
            '<label for="' + cbId + '">' + _baColLabelFor(key) + '</label>';
        var $cb = row.querySelector('input');
        if (cbDisabled) {
            $cb.addEventListener('click', function (ev) { ev.preventDefault(); ev.stopPropagation(); });
        }
        $cb.addEventListener('change', function (ev) {
            ev.stopPropagation();
            if (ev.target.checked && !_baColCanAddColumn()) {
                ev.target.checked = false;
                return;
            }
            if (!ev.target.checked && !_baColCanEditColumn()) {
                ev.target.checked = true;
                return;
            }
            if (ev.target.checked) {
                _baColUnselectedKeys = _baColUnselectedKeys.filter(function (k) { return k !== key; });
                _baColSelectedOrder.push(key);
            } else {
                _baColSelectedOrder = _baColSelectedOrder.filter(function (k) { return k !== key; });
                var origIdx = _baColALL_COLS.findIndex(function (c) { return c.key === key; });
                var insertAt = 0;
                for (var i = 0; i < _baColUnselectedKeys.length; i++) {
                    var uIdx = _baColALL_COLS.findIndex(function (c) { return c.key === _baColUnselectedKeys[i]; });
                    if (uIdx < origIdx) insertAt = i + 1;
                }
                _baColUnselectedKeys.splice(insertAt, 0, key);
            }
            _baColRenderDropdown(); _baColRenderTagBar(); syncBulkAllocTableColumns();
            saveBaColumnPreference();
        });
        if (isSelected && _baColCanEditColumn()) {
            row.addEventListener('dragstart', function (ev) {
                _baColDragSrcKey = key;
                ev.dataTransfer.effectAllowed = 'move';
                setTimeout(function () { row.classList.add('dragging'); }, 0);
            });
            row.addEventListener('dragend', function () {
                row.classList.remove('dragging');
                document.querySelectorAll('#baColDropdown .col-dd-row').forEach(function (r) {
                    r.classList.remove('drag-over-above', 'drag-over-below');
                });
            });
            row.addEventListener('dragover', function (ev) {
                ev.preventDefault();
                if (!_baColDragSrcKey || _baColDragSrcKey === key) return;
                document.querySelectorAll('#baColDropdown .col-dd-row').forEach(function (r) {
                    r.classList.remove('drag-over-above', 'drag-over-below');
                });
                var rect = row.getBoundingClientRect();
                row.classList.add(ev.clientY < rect.top + rect.height / 2 ? 'drag-over-above' : 'drag-over-below');
            });
            row.addEventListener('drop', function (ev) {
                ev.stopPropagation();
                ev.preventDefault();
                if (!_baColDragSrcKey || _baColDragSrcKey === key) return;
                var srcIdx = _baColSelectedOrder.indexOf(_baColDragSrcKey);
                var tgtIdx = _baColSelectedOrder.indexOf(key);
                if (srcIdx < 0 || tgtIdx < 0) return;
                _baColSelectedOrder.splice(srcIdx, 1);
                var rect = row.getBoundingClientRect();
                var insertIdx = ev.clientY < rect.top + rect.height / 2 ? tgtIdx : tgtIdx + 1;
                if (srcIdx < insertIdx) insertIdx--;
                _baColSelectedOrder.splice(insertIdx, 0, _baColDragSrcKey);
                _baColDragSrcKey = null;
                _baColRenderDropdown(); _baColRenderTagBar(); syncBulkAllocTableColumns();
                saveBaColumnPreference();
            });
        }
        return row;
    }

    window.deselectBaCol = function (e, key) {
        if (e) e.stopPropagation();
        if (!_baColCanEditColumn()) return;
        _baColSelectedOrder = _baColSelectedOrder.filter(function (k) { return k !== key; });
        var origIdx = _baColALL_COLS.findIndex(function (c) { return c.key === key; });
        var insertAt = 0;
        for (var i = 0; i < _baColUnselectedKeys.length; i++) {
            var uIdx = _baColALL_COLS.findIndex(function (c) { return c.key === _baColUnselectedKeys[i]; });
            if (uIdx < origIdx) insertAt = i + 1;
        }
        _baColUnselectedKeys.splice(insertAt, 0, key);
        _baColRenderDropdown(); _baColRenderTagBar(); syncBulkAllocTableColumns();
        saveBaColumnPreference();
    };

    function _baColIsVisible(key) {
        if (_baColSelectedOrder.indexOf(key) < 0) return false;
        if (key === 'is-default-approver') return _isDefaultApproverColumnAllowed();
        return true;
    }

    /* Added By Dipali V On 9th Jun 2026 — one parent grid: header + all rows share column tracks */
    function _assignBaRgUnifiedGridPositions(header, row, gridRow) {
        if (!header && !row) return;
        var visDyn = _baRgVisibleDynKeys();
        var actionCol = 5 + visDyn.length + 1;
        var rowNum = String(gridRow || 1);
        function place(el, col) {
            if (!el) return;
            el.style.gridColumn = String(col);
            el.style.gridRow = rowNum;
        }
        function placeBand(surface, selector) {
            if (!surface) return;
            var band = surface.querySelector(selector);
            if (!band) return;
            band.style.gridColumn = '1 / -1';
            band.style.gridRow = rowNum;
        }
        if (header) {
            placeBand(header.closest('.ba-rg-grid-surface'), '.ba-rg-grid-band-hdr');
            place(header.querySelector('.rg-hdr-role'), 1);
            place(header.querySelector('.rg-hdr-count'), 2);
            place(header.querySelector('.rg-hdr-start'), 3);
            place(header.querySelector('.rg-hdr-end'), 4);
            place(header.querySelector('.rg-hdr-alloc'), 5);
            var hc = 6;
            visDyn.forEach(function (key) {
                place(header.querySelector('.ba-rg-dyn-th[data-col="' + key + '"]'), hc);
                hc++;
            });
            place(header.querySelector('.rg-hdr-action'), actionCol);
        }
        if (row) {
            var surface = row.closest('.ba-rg-grid-surface');
            placeBand(surface, '.ba-rg-grid-band-data');
            var grp = row.closest('.resource-group');
            var dataBand = surface && surface.querySelector('.ba-rg-grid-band-data');
            if (dataBand && grp) {
                dataBand.classList.toggle('ba-rg-band-unallocated', grp.classList.contains('ba-role-unallocated'));
            }
            var baseCells = Array.from(row.querySelectorAll(':scope > div:not(.ba-rg-dyn-td):not(.rg-action-cell)'));
            baseCells.forEach(function (cell, idx) { place(cell, idx + 1); });
            var dc = 6;
            visDyn.forEach(function (key) {
                place(row.querySelector('.ba-rg-dyn-td[data-col="' + key + '"]'), dc);
                dc++;
            });
            place(row.querySelector('.rg-action-cell'), actionCol);
        }
    }

    function _ensureBaRgGridBands(surface, hasHeader) {
        if (!surface) return;
        if (hasHeader && !surface.querySelector('.ba-rg-grid-band-hdr')) {
            surface.insertAdjacentHTML('afterbegin', '<div class="ba-rg-grid-band ba-rg-grid-band-hdr" aria-hidden="true"></div>');
        }
        if (!surface.querySelector('.ba-rg-grid-band-data')) {
            var row = surface.querySelector('.rg-row');
            if (row) {
                row.insertAdjacentHTML('beforebegin', '<div class="ba-rg-grid-band ba-rg-grid-band-data" aria-hidden="true"></div>');
            }
        }
    }

    function _syncBaRgUnifiedGridLayout() {
        var container = document.getElementById('bulkAllocationGroupsContainer');
        if (!container || !container.classList.contains('ba-rg-unified-grid')) return;
        var gridRow = 1;
        var firstGrp = container.querySelector('.resource-group');
        if (firstGrp) {
            var hdr = firstGrp.querySelector('.rg-header');
            var firstSurface = firstGrp.querySelector('.ba-rg-grid-surface');
            _ensureBaRgGridBands(firstSurface, !!hdr);
            if (hdr) {
                _assignBaRgUnifiedGridPositions(hdr, null, gridRow);
                gridRow++;
            }
        }
        container.querySelectorAll('.resource-group .rg-row').forEach(function (rowEl) {
            var surface = rowEl.closest('.ba-rg-grid-surface');
            var grp = rowEl.closest('.resource-group');
            _ensureBaRgGridBands(surface, false);
            _assignBaRgUnifiedGridPositions(null, rowEl, gridRow);
            gridRow++;
            var gid = grp ? grp.getAttribute('data-group') : null;
            var tail = gid ? document.getElementById('ba-rg-group-tail-' + gid) : null;
            if (tail) {
                tail.style.gridColumn = '1 / -1';
                tail.style.gridRow = String(gridRow);
            }
            gridRow++;
        });
        setTimeout(function () {
            if (typeof _syncBaRgDateInputTooltips === 'function') _syncBaRgDateInputTooltips();
            if (typeof reinitTooltips === 'function') reinitTooltips();
        }, 0);
    }

    function syncBulkAllocTableColumns() {
        var fullOrder = _baColSelectedOrder.concat(_baColUnselectedKeys);
        var tmpl = _baRgGridTemplate();
        var visDyn = _baRgVisibleDynKeys();
        var gridMinW = _baRgGridMinWidth() + 'px';
        var container = document.getElementById('bulkAllocationGroupsContainer');

        if (container) {
            container.style.setProperty('--ba-rg-grid-cols', tmpl);
            container.style.setProperty('--ba-rg-grid-min-w', gridMinW);
            container.classList.add('ba-rg-unified-grid');
            container.classList.toggle('ba-has-dyn-cols', visDyn.length > 0);
            container.classList.toggle('ba-role-rows-stack', container.querySelectorAll('.resource-group').length > 1);
        }

        document.querySelectorAll('#tabBulkAllocation .resource-group').forEach(function (grp) {
            var header = grp.querySelector('.rg-header');
            var row = grp.querySelector('.rg-row');
            if (!row) return;
            var actionSpan = header ? header.querySelector('.rg-hdr-action') : null;
            var actionCell = row.querySelector('.rg-action-cell');

            if (header && actionSpan) {
                fullOrder.forEach(function (key) {
                    var th = header.querySelector('.ba-rg-dyn-th[data-col="' + key + '"]');
                    if (th) header.insertBefore(th, actionSpan);
                });
                header.querySelectorAll('.ba-rg-dyn-th').forEach(function (th) {
                    var col = th.getAttribute('data-col');
                    th.classList.toggle('ba-rg-dyn-visible', !!_baColIsVisible(col));
                });
                header.style.gridTemplateColumns = '';
                if (visDyn.length > 0) {
                    header.style.minWidth = gridMinW;
                } else {
                    header.style.minWidth = '';
                }
            }

            if (actionCell) {
                fullOrder.forEach(function (key) {
                    var td = row.querySelector('.ba-rg-dyn-td[data-col="' + key + '"]');
                    if (td) row.insertBefore(td, actionCell);
                });
            }
            row.querySelectorAll('.ba-rg-dyn-td').forEach(function (td) {
                var col = td.getAttribute('data-col');
                td.classList.toggle('ba-rg-dyn-visible', !!_baColIsVisible(col));
            });

            row.style.gridTemplateColumns = '';
            grp.style.removeProperty('--ba-rg-grid-cols');
            if (visDyn.length > 0) {
                grp.classList.add('ba-has-dyn-cols');
                row.style.minWidth = gridMinW;
            } else {
                grp.classList.remove('ba-has-dyn-cols');
                row.style.minWidth = '';
            }
        });

        document.querySelectorAll('#tabBulkAllocation .ba-res-data-store tbody tr').forEach(function (tr) {
            var respTd = tr.querySelector('td.col-resp');
            fullOrder.forEach(function (key) {
                var td = tr.querySelector('td.ba-dyn-td[data-col="' + key + '"]');
                if (td && respTd) tr.insertBefore(td, respTd);
            });
            tr.querySelectorAll('td.ba-dyn-td').forEach(function (td) {
                var col = td.getAttribute('data-col');
                td.style.display = _baColIsVisible(col) ? 'table-cell' : 'none';
            });
        });

        _baColRenderDropdown();
        _baColRenderTagBar();
        _syncBaRgUnifiedGridLayout();
        if (_baColIsVisible('work-hh')) {
            _autoPopulateRgWorkHoursAllGroups({ onlyIfEmpty: true, syncOffcanvas: false });
        }
    }

    function _refreshBaRgColumnHeaders() {
        document.querySelectorAll('#tabBulkAllocation .resource-group').forEach(function (grp) {
            var gid = grp.getAttribute('data-group') || '0';
            var header = grp.querySelector('.rg-header');
            var row = grp.querySelector('.rg-row');
            if (!row) return;
            var actionSpan = header ? header.querySelector('.rg-hdr-action') : null;
            var actionCell = row.querySelector('.rg-action-cell');
            if (!actionCell) return;

            var saved = (typeof _getRgDynFieldValues === 'function') ? _getRgDynFieldValues(gid) : null;
            row.querySelectorAll('.ba-rg-dyn-td select.selectpicker').forEach(function (sel) {
                _baDestroyRgSelectpicker($(sel));
            });
            if (header && actionSpan) {
                header.querySelectorAll('.ba-rg-dyn-th').forEach(function (th) { th.remove(); });
                var tempH = document.createElement('div');
                tempH.innerHTML = _buildBaRgDynHeadersHtml(gid);
                Array.from(tempH.children).forEach(function (el) { header.insertBefore(el, actionSpan); });
            }
            row.querySelectorAll('.ba-rg-dyn-td').forEach(function (td) { td.remove(); });
            var tempR = document.createElement('div');
            tempR.innerHTML = _buildBaRgDynCellsHtml(gid);
            Array.from(tempR.children).forEach(function (el) { row.insertBefore(el, actionCell); });
            if (typeof initBaRgDynControls === 'function') initBaRgDynControls(gid, saved);
        });
        syncBulkAllocTableColumns();
    }

    function _baColApplyDefaults() {
        /* No saved prefs for this project/user — start with all optional columns unselected (same as Bulk Resource Req). */
        _baColSelectedOrder = [];
        _baColUnselectedKeys = (_baColALL_COLS || []).map(function (c) { return c.key; });
        _baColRenderDropdown();
        _baColRenderTagBar();
        _refreshBaRgColumnHeaders();
    }

    function buildBaColumnPayload() {
        var cols = [];
        _baColSelectedOrder.forEach(function (key, idx) {
            var col = _baColALL_COLS.find(function (c) { return c.key === key; });
            cols.push({ ColumnID: col ? col.id : 0, ColumnName: key, ColumnOrder: idx, Applicable: true });
        });
        _baColUnselectedKeys.forEach(function (key, idx) {
            var col = _baColALL_COLS.find(function (c) { return c.key === key; });
            cols.push({ ColumnID: col ? col.id : 0, ColumnName: key, ColumnOrder: _baColSelectedOrder.length + idx, Applicable: false });
        });
        return {
            ProjectID: typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0,
            UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0,
            Columns: cols
        };
    }

    function saveBaColumnPreference(onComplete) {
        if (!_baColPrefsLoaded) {
            if (typeof onComplete === 'function') onComplete();
            return;
        }
        if (!_baColCanAddColumn() && !_baColCanEditColumn()) {
            if (typeof onComplete === 'function') onComplete();
            return;
        }
        var param = JSON.stringify(buildBaColumnPayload());
        $.ajax({
            url: strUrl + '/api/PM_BulkResourceAllocation/SaveColumnPreference',
            type: 'POST', data: param, async: true,
            dataType: 'json', contentType: 'application/json;charset=utf-8',
            beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
            complete: function () { if (typeof onComplete === 'function') onComplete(); }
        });
    }

    function loadBaColumnPreference(onComplete) {
        var param = JSON.stringify({
            ProjectID: typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0,
            UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0
        });
        $.ajax({
            url: strUrl + '/api/PM_BulkResourceAllocation/GetColumnPreference',
            type: 'POST', data: param, async: true,
            dataType: 'json', contentType: 'application/json;charset=utf-8',
            beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
            success: function (response) {
                try {
                    var prefs = _baColUnwrapPrefs(response);
                    if (prefs && prefs.length > 0) {
                        _baColSelectedOrder = [];
                        _baColUnselectedKeys = [];
                        var sortedPrefs = prefs.slice().sort(function (a, b) {
                            return (a.columnOrder || a.ColumnOrder || 0) - (b.columnOrder || b.ColumnOrder || 0);
                        });
                        sortedPrefs.forEach(function (p) {
                            var match = _baColResolvePrefMatch(p);
                            if (!match || !match.key) return;
                            if (_baColPrefApplicable(p)) {
                                if (_baColSelectedOrder.indexOf(match.key) === -1) _baColSelectedOrder.push(match.key);
                            } else if (_baColUnselectedKeys.indexOf(match.key) === -1) {
                                _baColUnselectedKeys.push(match.key);
                            }
                        });
                        _baColALL_COLS.forEach(function (c) {
                            if (_baColSelectedOrder.indexOf(c.key) === -1 && _baColUnselectedKeys.indexOf(c.key) === -1) {
                                _baColUnselectedKeys.push(c.key);
                            }
                        });
                    } else {
                        _baColApplyDefaults();
                    }
                } catch (e) {
                    _baColApplyDefaults();
                }
                _baColPrefsLoaded = true;
                _baColRenderDropdown();
                _baColRenderTagBar();
                _refreshBaRgColumnHeaders();
            },
            error: function () {
                _baColApplyDefaults();
                _baColPrefsLoaded = true;
                _refreshBaRgColumnHeaders();
            },
            complete: function () { if (typeof onComplete === 'function') onComplete(); }
        });
    }

    function loadBaColumnMaster(onComplete) {
        $.ajax({
            url: strUrl + '/api/PM_BulkResourceAllocation/GetColumnMaster',
            type: 'POST', data: JSON.stringify({}), async: true,
            dataType: 'json', contentType: 'application/json;charset=utf-8',
            beforeSend: function (xhr) { buildAuthHeaders(xhr); },
            success: function (response) {
                try {
                    var rows = _baColUnwrapMasterRows(response);
                    _baColALL_COLS = (rows && rows.length > 0)
                        ? rows.map(function (r) {
                            return {
                                id: r.columnID || r.ColumnID,
                                key: _baColNormKey(r.columnKey || r.ColumnKey || r.columnName || r.ColumnName),
                                label: r.columnLabel || r.ColumnLabel || r.columnName || r.ColumnName
                            };
                        }).filter(function (c) { return !!c.key; })
                        : _baColFALLBACK.slice();
                } catch (e) {
                    _baColALL_COLS = _baColFALLBACK.slice();
                }
                loadBaColumnPreference(onComplete);
            },
            error: function () {
                _baColALL_COLS = _baColFALLBACK.slice();
                loadBaColumnPreference(onComplete);
            }
        });
    }

    function initBaAdditionalColumnsUi() {
        var chevBtn = document.getElementById('baTagBarChevronBtn');
        if (chevBtn && !chevBtn._baColBound) {
            chevBtn._baColBound = true;
            chevBtn.addEventListener('click', function (e) {
                e.stopPropagation(); e.preventDefault();
                if (_baColDdOpen) _baColDDClose(); else _baColDDOpen();
            });
        }
        if (!window._baColGlobalBound) {
            window._baColGlobalBound = true;
            document.addEventListener('click', function (e) {
                if (!_baColDdOpen) return;
                var dd = document.getElementById('baColDropdown');
                var card = document.getElementById('baAdditionalColumnsCard');
                if (!((card && card.contains(e.target)) || (dd && dd.contains(e.target)))) _baColDDClose();
            });
        }
    }
    /* End of Added By Dipali V On 5th Jun 2026 */

    function _rrlRenderPage(gid) {
        var state = _rrlState[gid];
        if (!state) return;
        var data = state.data, page = state.page, size = state.size;
        var totalRecords = state.totalRecords || data.length;
        var totalPages = state.totalPages || Math.max(1, Math.ceil(totalRecords / size));
        var start = (page - 1) * size;
        var pageData = state.serverPaged ? data : data.slice(start, start + size);
        var $tbody = $('#rrl-tbody-' + gid).empty();
        pageData.forEach(function (r) {
            // Modified by Nikhil Mane on 06-May-2026 — removed Active column; added row-wise Edit button with editable fields.
            var statusText = (r.resourceStatus || r.ResourceStatus || '').toString().trim();
            var isBillable = !!(r.billable || r.Billable || r.isResourceBillable || r.IsResourceBillable);
            var isDefaultApprover = !!(r.isDefaultApprover || r.IsDefaultApprover);
            var isProductOwner = !!(r.isProductOwner || r.IsProductOwner || r.intIsProductOwner || r.IntIsProductOwner);
            //debugger;
            /* Resolve Reporting To name from cached _reportingToOptions using the integer ID */
            var rptId = parseInt(r.reportingTo || r.ReportingTo || 0, 10) || 0;
            var rptName = (r.reportingToName || r.ReportingToName || r.reportingToEmployeeName || r.ReportingToEmployeeName || '').toString().trim() || '—';
            if (rptId > 0 && window._reportingToOptions && window._reportingToOptions.length) {
                var rptMatch = window._reportingToOptions.find(function (opt) {
                    return (parseInt(_getReportingToRowId(opt), 10) || 0) === rptId;
                });
                if (rptMatch) {
                    rptName = _getReportingToRowName(rptMatch) || String(rptId);
                } else if (rptName === '—') {
                    rptName = String(rptId);
                }
            } else if (rptId <= 0 && rptName && rptName !== '—' && window._reportingToOptions && window._reportingToOptions.length) {
                var rptNameMatch = window._reportingToOptions.find(function (opt) {
                    var t = _getReportingToRowName(opt);
                    return t && t === rptName.toString().trim();
                });
                if (rptNameMatch) {
                    rptId = parseInt(_getReportingToRowId(rptNameMatch), 10) || 0;
                }
            }

            /* Modified by Nikhil Mane on 06-May-2026 — Convert BudgetedHours (decimal) → HH:MM display */
            var workHHMM = decimalToHHMM(r.budgetedHours || r.BudgetedHours);

            /* Responsibility text — blank when empty or corrupted placeholder (e.g. â€—) */
            var respText = _cleanRrlText(r.responsibility || r.Responsibility || '');

            /* Is Default Approver column always visible — approverColStyle removed */

            /* Build Reporting To options for the editable dropdown */
            var rtOpts = _buildReportingToOptionsHtml(window._reportingToAllRows || window._reportingToOptions, rptId, rptName);

            /* Build Resource Status options for the editable dropdown */
            var statusOpts = '<option value="">Select</option>';
            $('#ocResourceStatus option').each(function () {
                var v = $(this).val(); var t = $(this).text();
                var sel = (v && v === statusText) ? ' selected' : '';
                if (v) statusOpts += '<option value="' + escHtml(v) + '"' + sel + '>' + escHtml(t) + '</option>';
            });

            /* Build Project Role options for the editable dropdown */
            var roleDesc = (r.roleDescription || r.RoleDescription || '—').toString().trim() || '—';
            var roleOpts = '<option value="">Select Role</option>';
            var tmplSrc = document.getElementById('tmpl-project-role');
            if (tmplSrc) {
                var tmplSelect = tmplSrc.querySelector('select');
                if (tmplSelect) {
                    $(tmplSelect).find('option').each(function () {
                        var v = $(this).val(); var t = $(this).text();
                        if (!v || v === '0') return;
                        var rowRoleId = parseInt(r.roleID || r.RoleID || 0, 10) || 0;
                        var sel = (rowRoleId > 0 && String(v) === String(rowRoleId)) ? ' selected'
                            : (t.trim() === (r.roleDescription || r.RoleDescription || '').trim()) ? ' selected' : '';
                        roleOpts += '<option value="' + escHtml(v) + '"' + sel + '>' + escHtml(t) + '</option>';
                    });
                }
            }

            var rowKey = 'rrl_' + gid + '_' + (r.projectResourceID || r.ProjectResourceID || r.employeeID || r.EmployeeID || Math.random().toString(36).slice(2));

            var projectEmployeeRoleId = parseInt(r.projectEmployeeRoleID || r.ProjectEmployeeRoleID || r.projectEmployeeRoleId || r.ProjectEmployeeRoleId || 0, 10) || 0;
            var employeeId = parseInt(r.employeeID || r.EmployeeID || 0, 10) || 0;
            var rowRoleId = parseInt(r.roleID || r.RoleID || 0, 10) || 0;

            var resName = (r.employeeName || r.EmployeeName || '—').toString().trim() || '—';
            var isResourceActive = _isRrlResourceActiveFromApiRow(r);
            var rrlInactiveRowClass = isResourceActive ? '' : ' rrl-row-inactive';
            var rrlResourceActiveAttr = ' data-resource-active="' + (isResourceActive ? '1' : '0') + '"';
            var resNameCellHtml = _rrlBuildResourceNameCellHtml(resName, isResourceActive);
            var rrlCheckDisabledAttr = isResourceActive
                ? ''
                : ' disabled title="' + escHtml(_rrlInactiveResourceEditMessage()) + '"';
            var rrlStartDisp = _fmtDisplayDate(r.expectedStartDate || r.ExpectedStartDate || '');
            var rrlEndDisp = _fmtDisplayDate(r.expectedEndDate || r.ExpectedEndDate || '');
            var rrlPersistedAttrs = _rrlPersistedEditableAttrs(
                rrlStartDisp,
                rrlEndDisp,
                r.resourcePercentage != null ? r.resourcePercentage : (r.ResourcePercentage != null ? r.ResourcePercentage : ''),
                workHHMM
            );
            var rrlOffcanvasPersistedAttrs = _rrlPersistedOffcanvasAttrs(
                rowRoleId, rptId, statusText, respText, isBillable, isDefaultApprover
            );
            var rrlRowDataAttrs =
                ' data-role-id="' + rowRoleId + '"' +
                ' data-reporting-to="' + rptId + '"' +
                ' data-resource-status="' + escHtml(statusText) + '"' +
                ' data-billable="' + (isBillable ? '1' : '0') + '"' +
                ' data-default-approver="' + (isDefaultApprover ? '1' : '0') + '"' +
                ' data-product-owner="' + (isProductOwner ? '1' : '0') + '"' +
                rrlPersistedAttrs +
                rrlOffcanvasPersistedAttrs;
            var rrlDatePh = escHtml(RES.C_DatePlaceholder || '01 May 2027');
            /* Added By Dipali V On 5th Jun 2026 — Action: View (offcanvas) + Edit (inline Start/End/Alloc/Work in list) */
            var isRrlCompact = String(gid) === String(_REALLOC_TAB_GID);
            var rrlEditBtnHtml = _rrlBuildEditButtonHtml(rowKey, isResourceActive);
            var rrlActionHtml = isRrlCompact
                ? '<button type="button" class="btn-rrl-view" onclick="openRrlAllocationDetail(\'' + rowKey + '\', \'' + gid + '\')" title="' + escHtml(RES.C_ViewDetails) + '" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"><i class="fas fa-eye"></i></button>' +
                  rrlEditBtnHtml
                : rrlEditBtnHtml;
            /* Offcanvas/save fields not shown in reallocation list columns */
            var rrlOffcanvasOnlyHtml =
                '<div class="rrl-offcanvas-only">' +
                '<strong class="rrl-hidden-name"' + _rrlTruncDataAttr(resName) + '>' + escHtml(resName) + '</strong>' +
                '<div class="rrl-col-rpt">' +
                '<span class="rrl-display-val"' + _rrlTruncDataAttr(rptName) + '>' + escHtml(rptName) + '</span>' +
                '<select class="rrl-edit-select rrl-edit-selectpicker" id="rrl-rpt-' + rowKey + '" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" data-container="body" data-none-selected-text="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '" title="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '">' + rtOpts + '</select>' +
                '</div>' +
                '<div class="rrl-col-status">' +
                '<span class="rrl-display-val"' + _rrlTruncDataAttr(statusText) + '>' + escHtml(statusText) + '</span>' +
                '<select class="rrl-edit-select rrl-edit-selectpicker" id="rrl-status-' + rowKey + '" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" data-container="body">' + statusOpts + '</select>' +
                '</div>' +
                '<div class="col-rrl-resp-cell rrl-col-resp">' +
                '<span class="rrl-display-val' + _rrlRespTipClass(respText) + '"' + _rrlTruncDataAttr(respText) + '>' + escHtml(_rrlTrunc200(respText)) + '</span>' +
                '<textarea wrap="Soft" name="txtALResponsibility" id="rrl-resp-' + rowKey + '" class="form-control rrl-edit-textarea" style="text-align:Left" autocomplete="Off" maxlength="1000">' + escHtml(respText) + '</textarea>' +
                '</div>' +
                '<div class="rrl-col-bill">' +
                '<span class="rrl-display-icon">' + (isBillable ? '<i class="fas fa-check-circle" style="color:#16a34a;" data-bs-toggle="tooltip" data-bs-placement="top" title="Billable: Yes "></i>' : '<i class="fas fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Billable: No " style="color:#dc2626;"></i>') + '</span>' +
                '<input type="checkbox" class="rrl-edit-check" id="rrl-bill-' + rowKey + '"' + (isBillable ? ' checked' : '') + ' style="margin:auto;">' +
                '</div>' +
                '<div class="rrl-col-approver">' +
                '<span class="rrl-display-icon">' + (isDefaultApprover ? '<i class="fas fa-check-circle" style="color:#16a34a;" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Default Approver: Yes "></i>' : '<i class="fas fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Default Approver: No " style="color:#dc2626;"></i>') + '</span>' +
                '<input type="checkbox" class="rrl-edit-check" id="rrl-approver-' + rowKey + '"' + (isDefaultApprover ? ' checked' : '') + ' style="margin:auto;">' +
                '</div>' +
                (_isAgileProjectForProductOwner()
                    ? '<div class="rrl-col-product-owner">' +
                    '<span class="rrl-display-icon">' + (isProductOwner ? '<i class="fas fa-check-circle" style="color:#16a34a;" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Product Owner: Yes "></i>' : '<i class="fas fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Product Owner: No " style="color:#dc2626;"></i>') + '</span>' +
                    '<input type="checkbox" class="rrl-edit-check" id="rrl-po-' + rowKey + '"' + (isProductOwner ? ' checked' : '') + ' style="margin:auto;">' +
                    '</div>'
                    : '') +
                '</div>';

            var rowHtml;
            if (isRrlCompact) {
                rowHtml =
                '<tr class="' + (rrlInactiveRowClass ? rrlInactiveRowClass.trim() : '') + '" data-row-key="' + rowKey + '" data-resource-name="' + escHtml(resName) + '" data-project-employee-role-id="' + projectEmployeeRoleId + '" data-employee-id="' + employeeId + '"' + rrlResourceActiveAttr + rrlRowDataAttrs + '>' +
                '<td class="rrl-col-name">' + resNameCellHtml + '</td>' +
                '<td class="rrl-col-role rrl-col-readonly">' +
                '<span class="rrl-display-val"' + _rrlTruncDataAttr(roleDesc) + '>' + escHtml(roleDesc) + '</span>' +
                '<select class="rrl-edit-select rrl-edit-selectpicker" id="rrl-role-' + rowKey + '" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" data-container="body">' + roleOpts + '</select>' +
                '</td>' +
                '<td class="rrl-col-start">' +
                '<span class="rrl-display-val rrl-tip-always"' + _rrlTruncDataAttr(rrlStartDisp || '—') + '>' + escHtml(rrlStartDisp || '—') + '</span>' +
                '<div class="rrl-date-wrap">' +
                '<input type="text" class="rrl-edit-input rrl-date-input" id="rrl-start-' + rowKey + '" placeholder="' + rrlDatePh + '" value="' + escHtml(rrlStartDisp) + '" readonly autocomplete="off">' +
                '<button class="rrl-cal-btn" type="button" onclick="openRrlDatepicker(\'rrl-start-' + rowKey + '\')" title="Pick date"><i class="fas fa-calendar-alt"></i></button>' +
                '</div></td>' +
                '<td class="rrl-col-end">' +
                '<span class="rrl-display-val rrl-tip-always"' + _rrlTruncDataAttr(rrlEndDisp || '—') + '>' + escHtml(rrlEndDisp || '—') + '</span>' +
                '<div class="rrl-date-wrap">' +
                '<input type="text" class="rrl-edit-input rrl-date-input" id="rrl-end-' + rowKey + '" placeholder="' + rrlDatePh + '" value="' + escHtml(rrlEndDisp) + '" readonly autocomplete="off">' +
                '<button class="rrl-cal-btn" type="button" onclick="openRrlDatepicker(\'rrl-end-' + rowKey + '\')" title="Pick date"><i class="fas fa-calendar-alt"></i></button>' +
                '</div></td>' +
                '<td class="rrl-col-alloc">' +
                '<span class="rrl-display-val rrl-tip-always" data-rrl-full="' + escHtml(String(r.resourcePercentage || r.ResourcePercentage || '')) + '%">' + escHtml(String(r.resourcePercentage || r.ResourcePercentage || '—')) + '%</span>' +
                '<input type="text" class="rrl-edit-input" id="rrl-alloc-' + rowKey + '" value="' + escHtml(String(r.resourcePercentage || r.ResourcePercentage || '')) + '" maxlength="6" autocomplete="Off" inputmode="numeric" oninput="rgAllocationIntegerOnly(this)" style="min-width:70px;">' +
                '</td>' +
                '<td class="rrl-col-work">' +
                '<span class="rrl-display-val rrl-tip-always"' + _rrlTruncDataAttr(workHHMM) + '>' + escHtml(workHHMM) + '</span>' +
                '<input type="text" name="txtALWorkHrs" id="rrl-work-' + rowKey + '" class="form-control rrl-edit-input" style="text-align:Left" value="' + escHtml(workHHMM) + '" autocomplete="Off" maxlength="8" oninput="workHHMMInput(this)">' +
                '</td>' +
                '<td class="rrl-col-action" style="text-align:center;vertical-align:middle;">' + rrlActionHtml + '</td>' +
                '<td class="rrl-col-check" style="text-align:center;vertical-align:middle;">' +
                '<input type="checkbox" class="rrl-row-check" id="rrl-check-' + rowKey + '" onchange="onRrlRowCheck(this, \'' + gid + '\')"' + rrlCheckDisabledAttr + '>' +
                '</td>' +
                '<td class="rrl-offcanvas-only-cell" colspan="99">' + rrlOffcanvasOnlyHtml + '</td>' +
                '</tr>';
            } else {
                rowHtml =
                '<tr class="' + (rrlInactiveRowClass ? rrlInactiveRowClass.trim() : '') + '" data-row-key="' + rowKey + '" data-project-employee-role-id="' + projectEmployeeRoleId + '" data-employee-id="' + employeeId + '"' + rrlResourceActiveAttr + rrlRowDataAttrs + '>' +
                '<td class="rrl-col-name">' + resNameCellHtml + '</td>' +
                '<td class="rrl-col-role rrl-col-readonly">' +
                '<span class="rrl-display-val"' + _rrlTruncDataAttr(roleDesc) + '>' + escHtml(roleDesc) + '</span>' +
                '<select class="rrl-edit-select rrl-edit-selectpicker" id="rrl-role-' + rowKey + '" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" data-container="body">' + roleOpts + '</select>' +
                '</td>' +
                '<td class="rrl-col-start">' +
                '<span class="rrl-display-val rrl-tip-always"' + _rrlTruncDataAttr(rrlStartDisp || '—') + '>' + escHtml(rrlStartDisp || '—') + '</span>' +
                '<div class="rrl-date-wrap">' +
                '<input type="text" class="rrl-edit-input rrl-date-input" id="rrl-start-' + rowKey + '" placeholder="' + rrlDatePh + '" value="' + escHtml(rrlStartDisp) + '" readonly autocomplete="off">' +
                '<button class="rrl-cal-btn" type="button" onclick="openRrlDatepicker(\'rrl-start-' + rowKey + '\')" title="Pick date"><i class="fas fa-calendar-alt"></i></button>' +
                '</div></td>' +
                '<td class="rrl-col-end">' +
                '<span class="rrl-display-val rrl-tip-always"' + _rrlTruncDataAttr(rrlEndDisp || '—') + '>' + escHtml(rrlEndDisp || '—') + '</span>' +
                '<div class="rrl-date-wrap">' +
                '<input type="text" class="rrl-edit-input rrl-date-input" id="rrl-end-' + rowKey + '" placeholder="' + rrlDatePh + '" value="' + escHtml(rrlEndDisp) + '" readonly autocomplete="off">' +
                '<button class="rrl-cal-btn" type="button" onclick="openRrlDatepicker(\'rrl-end-' + rowKey + '\')" title="Pick date"><i class="fas fa-calendar-alt"></i></button>' +
                '</div></td>' +
                '<td class="rrl-col-alloc">' +
                '<span class="rrl-display-val rrl-tip-always" data-rrl-full="' + escHtml(String(r.resourcePercentage || r.ResourcePercentage || '')) + '%">' + escHtml(String(r.resourcePercentage || r.ResourcePercentage || '—')) + '%</span>' +
                '<input type="text" class="rrl-edit-input" id="rrl-alloc-' + rowKey + '" value="' + escHtml(String(r.resourcePercentage || r.ResourcePercentage || '')) + '" maxlength="6" autocomplete="Off" inputmode="numeric" oninput="rgAllocationIntegerOnly(this)" style="min-width:70px;">' +
                '</td>' +
                '<td class="rrl-col-rpt">' +
                '<span class="rrl-display-val"' + _rrlTruncDataAttr(rptName) + '>' + escHtml(rptName) + '</span>' +
                '<select class="rrl-edit-select rrl-edit-selectpicker" id="rrl-rpt-' + rowKey + '" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" data-container="body" data-none-selected-text="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '" title="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '">' + rtOpts + '</select>' +
                '</td>' +
                '<td class="rrl-col-status">' +
                '<span class="rrl-display-val"' + _rrlTruncDataAttr(statusText) + '>' + escHtml(statusText) + '</span>' +
                '<select class="rrl-edit-select rrl-edit-selectpicker" id="rrl-status-' + rowKey + '" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" data-container="body">' + statusOpts + '</select>' +
                '</td>' +
                '<td class="rrl-col-work">' +
                '<span class="rrl-display-val rrl-tip-always"' + _rrlTruncDataAttr(workHHMM) + '>' + escHtml(workHHMM) + '</span>' +
                '<input type="text" name="txtALWorkHrs" id="rrl-work-' + rowKey + '" class="form-control rrl-edit-input" style="text-align:Left" value="' + escHtml(workHHMM) + '" autocomplete="Off" maxlength="8" oninput="workHHMMInput(this)">' +
                '</td>' +
                '<td class="col-rrl-resp-cell rrl-col-resp">' +
                '<span class="rrl-display-val' + _rrlRespTipClass(respText) + '"' + _rrlTruncDataAttr(respText) + '>' + escHtml(_rrlTrunc200(respText)) + '</span>' +
                '<textarea wrap="Soft" name="txtALResponsibility" id="rrl-resp-' + rowKey + '" class="form-control rrl-edit-textarea" style="text-align:Left" autocomplete="Off" maxlength="1000">' + escHtml(respText) + '</textarea>' +
                '</td>' +
                '<td class="rrl-col-bill" style="text-align:center;">' +
                '<span class="rrl-display-icon">' + (isBillable ? '<i class="fas fa-check-circle" style="color:#16a34a;" data-bs-toggle="tooltip" data-bs-placement="top" title="Billable: Yes "></i>' : '<i class="fas fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Billable: No " style="color:#dc2626;"></i>') + '</span>' +
                '<input type="checkbox" class="rrl-edit-check" id="rrl-bill-' + rowKey + '"' + (isBillable ? ' checked' : '') + ' style="margin:auto;">' +
                '</td>' +
                '<td class="rrl-col-approver" style="text-align:center;">' +
                '<span class="rrl-display-icon">' + (isDefaultApprover ? '<i class="fas fa-check-circle" style="color:#16a34a;" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Default Approver: Yes "></i>' : '<i class="fas fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Is Default Approver: No " style="color:#dc2626;"></i>') + '</span>' +
                '<input type="checkbox" class="rrl-edit-check" id="rrl-approver-' + rowKey + '"' + (isDefaultApprover ? ' checked' : '') + ' style="margin:auto;">' +
                '</td>' +
                '<td class="rrl-col-action" style="text-align:center;vertical-align:middle;">' + rrlActionHtml + '</td>' +
                '<td class="rrl-col-check" style="text-align:center;vertical-align:middle;">' +
                '<input type="checkbox" class="rrl-row-check" id="rrl-check-' + rowKey + '" onchange="onRrlRowCheck(this, \'' + gid + '\')"' + rrlCheckDisabledAttr + '>' +
                '</td></tr>';
            }
            $tbody.append(rowHtml);
            // End of Modified by Nikhil Mane on 06-May-2026
        });
        /* Added 25-May-2026 — restore row checkbox state from cross-page selection map */
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $tr = $(this);
            var perId = parseInt($tr.attr('data-project-employee-role-id'), 10) || 0;
            if (!perId) return;
            if (!_rrlInactiveByGroup[gid]) _rrlInactiveByGroup[gid] = {};
            if (!_isRrlResourceActiveFromRow($tr)) {
                _rrlInactiveByGroup[gid][perId] = true;
                if (_rrlSelectedByGroup[gid]) delete _rrlSelectedByGroup[gid][perId];
                if (_rrlUnselectedByGroup[gid]) delete _rrlUnselectedByGroup[gid][perId];
                $tr.find('.rrl-row-check').prop('checked', false).prop('disabled', true);
                return;
            }
            delete _rrlInactiveByGroup[gid][perId];
            var isChecked = !!_rrlSelectAllActiveByGroup[gid]
                ? !(_rrlUnselectedByGroup[gid] && _rrlUnselectedByGroup[gid][perId])
                : !!(_rrlSelectedByGroup[gid] && _rrlSelectedByGroup[gid][perId]);
            $tr.find('.rrl-row-check').prop('checked', isChecked);
        });
        /* End of Added 25-May-2026 */
        _refreshRrlPersistedOffcanvasOnDom(gid);
        updateRrlSelectAllState(gid);
        /* Update pagination text and prev/next button states */
        $('#rrl-total-text-' + gid).text('Total Records: ' + totalRecords);
        $('#rrl-prev-' + gid).prop('disabled', page <= 1 || totalPages === 0);
        $('#rrl-next-' + gid).prop('disabled', page >= totalPages || totalPages === 0);
        /* Modified by Nikhil Mane on 06-May-2026 — sync top mirror width after every render */
        if (String(gid) === String(_REALLOC_TAB_GID)) {
            _rrlResizeBodyScroll(gid);
        } else {
            _rrlSyncScrollTop(gid);
        }
        /* Added By Dipali V On 27th May 2026 — tooltips for truncated RRL cells (Reporting To, Role, etc.) */
        requestAnimationFrame(function () {
            requestAnimationFrame(function () { _rrlApplyTruncationTooltips(gid); });
        });
        /* End of Modified by Nikhil Mane on 06-May-2026 */
    }

    /* Added by Nikhil Mane on 06-May-2026 — Top scrollbar mirror sync.
       Called after every _rrlRenderPage so the mirror's inner span matches the real
       table scrollWidth, then wires bidirectional scroll events between the mirror
       (#rrl-scroll-top-{gid}) and the inner scroll div (#rrl-table-scroll-{gid}).
       A single boolean flag (scrolling) prevents infinite ping-pong between the two
       scroll handlers.
       ─────────────────────────────────────────────────────────────────────────────
       Why requestAnimationFrame?
       The table DOM is updated synchronously in _rrlRenderPage, but the browser may
       not have reflowed yet when we reach this function.  rAF defers the width read
       by one frame, guaranteeing scrollWidth is correct. */
    function _rrlSyncScrollTop(gid) {
        var bodyScroll = document.getElementById('rrl-table-scroll-' + gid);
        var gridDiv = document.getElementById('rrl-table-grid-' + gid);
        var hScrollEl = gridDiv || bodyScroll;
        var mirrorDiv = document.getElementById('rrl-scroll-top-' + gid);
        var mirrorInner = document.getElementById('rrl-scroll-top-inner-' + gid);
        if (!hScrollEl || !mirrorDiv || !mirrorInner) return;

        /* Defer one frame so the browser reflows before we read scrollWidth */
        requestAnimationFrame(function () {
            var headTable = gridDiv ? gridDiv.querySelector('.rrl-table-head-pane table') : null;
            var bodyTable = bodyScroll ? bodyScroll.querySelector('table') : null;
            if (headTable && bodyTable) {
                var syncW = Math.max(bodyTable.scrollWidth, headTable.scrollWidth, bodyTable.offsetWidth, headTable.offsetWidth);
                headTable.style.width = syncW + 'px';
                bodyTable.style.width = syncW + 'px';
            }
            var tableEl = bodyTable || headTable || (hScrollEl.querySelector('table.rrl-table') || hScrollEl.querySelector('table'));
            var scrollWidth = tableEl ? tableEl.scrollWidth : hScrollEl.scrollWidth;
            mirrorInner.style.width = scrollWidth + 'px';

            /* Wire scroll sync — use a flag to avoid recursive events */
            var _syncing = false;

            $(mirrorDiv).off('scroll.rrlsync').on('scroll.rrlsync', function () {
                if (_syncing) return;
                _syncing = true;
                hScrollEl.scrollLeft = mirrorDiv.scrollLeft;
                _syncing = false;
            });

            $(hScrollEl).off('scroll.rrlsync').on('scroll.rrlsync', function () {
                if (_syncing) return;
                _syncing = true;
                mirrorDiv.scrollLeft = hScrollEl.scrollLeft;
                _syncing = false;
            });
        });
    }

    /* Added By Dipali V On 5th Jun 2026 — sync horizontal scroll mirror; vertical scroll sized by CSS flex */
  /* Modified By Dipali V On 16th Jun 2026 — removed inline height sizing; CSS flex chain handles tbody scroll */
    function _rrlResizeBodyScroll(gid) {
        gid = gid || _REALLOC_TAB_GID;
        if (String(gid) !== String(_REALLOC_TAB_GID)) return;

        var wrap = document.getElementById('rrl-table-wrap-' + gid);
        var bodyScroll = document.getElementById('rrl-table-scroll-' + gid);
        var gridDiv = document.getElementById('rrl-table-grid-' + gid);
        if (!wrap || !bodyScroll) return;
        if (!$(wrap).is(':visible')) return;

        requestAnimationFrame(function () {
            bodyScroll.style.maxHeight = '';
            bodyScroll.style.height = '';
            if (gridDiv) gridDiv.style.maxHeight = '';
            _rrlSyncScrollTop(gid);
        });
    }

    function _setReallocTabScrollMode(isActive) {
        var scrollBody = document.querySelector('.bulk-alloc-scroll-body');
        var layout = document.querySelector('.bulk-alloc-layout');
        var tabContent = document.querySelector('.bulk-alloc-tab-content');
        if (scrollBody) scrollBody.classList.toggle('is-realloc-tab-active', !!isActive);
        if (layout) layout.classList.toggle('is-realloc-tab-active', !!isActive);
        if (tabContent) tabContent.classList.toggle('is-realloc-tab-active', !!isActive);
        if (isActive) {
            setTimeout(function () { _rrlResizeBodyScroll(_REALLOC_TAB_GID); }, 0);
            setTimeout(function () { _rrlResizeBodyScroll(_REALLOC_TAB_GID); }, 200);
        } else {
            var bodyScroll = document.getElementById('rrl-table-scroll-' + _REALLOC_TAB_GID);
            var gridDiv = document.getElementById('rrl-table-grid-' + _REALLOC_TAB_GID);
            if (bodyScroll) { bodyScroll.style.maxHeight = ''; bodyScroll.style.height = ''; }
            if (gridDiv) gridDiv.style.maxHeight = '';
        }
    }
    /* End of Added by Nikhil Mane on 06-May-2026 */

    /* Added by Nikhil Mane on 06-May-2026 — initialise searchable bootstrap-select controls
       for Allocated Resources row edit dropdowns (Project Role / Reporting To / Resource Status). */
    function initRrlEditSelectpickers($row) {
        if (!$row || !$row.length) return;
        $row.find('select.rrl-edit-selectpicker').each(function () {
            /* Skip read-only list columns (e.g. Project Role on reallocation tab). */
            if ($(this).closest('td').hasClass('rrl-col-readonly')) return;
            var $sel = $(this);
            try {
                if (_isReportingToSelectEl($sel)) {
                    var rptVal = $sel.val() || $row.attr('data-reporting-to') || '';
                    var rptName = $row.attr('data-reporting-to-name') || '';
                    var rptRows = window._reportingToAllRows || window._reportingToOptions || [];
                    if (rptRows.length) {
                        _fillReportingToOptions($sel, rptRows, rptVal, rptName);
                        $sel.data('rrl-selectpicker-init', true);
                    } else if (!$sel.data('selectpicker')) {
                        _initReportingToSelectpicker($sel);
                        $sel.data('rrl-selectpicker-init', true);
                    } else {
                        $sel.selectpicker('refresh');
                    }
                } else if (!$sel.data('rrl-selectpicker-init')) {
                    $sel.selectpicker();
                    $sel.data('rrl-selectpicker-init', true);
                    $sel.selectpicker('refresh');
                } else {
                    $sel.selectpicker('refresh');
                }
                var $wrap = $sel.next('.bootstrap-select');
                if ($wrap.length) { $wrap.addClass('rrl-edit-select-wrap'); }
            } catch (e) { /* no-op: keep existing non-searchable fallback if plugin fails */ }
        });
    }
    /* End of Added by Nikhil Mane on 06-May-2026 */

    function _rebuildRrlReportingToSelect($rptSel, selectedId, selectedName) {
        if (!$rptSel || !$rptSel.length) return;
        var options = window._reportingToAllRows || window._reportingToOptions || [];
        if (!options.length) return;
        _fillReportingToOptions($rptSel, options, selectedId, selectedName);
    }

    function rrlDateToApi(dateText) {
        return displayDateToISO(dateText);
    }

    function _normalizeRrlResourceName(v) {
        return (v || '').toString().trim().toLowerCase();
    }

    function _findRrlRowByResourceName(gid, resourceName) {
        var target = _normalizeRrlResourceName(resourceName);
        if (!target) return $();
        var $found = $();
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            if (_normalizeRrlResourceName($(this).find('td:first strong').text()) === target) {
                $found = $(this);
                return false;
            }
        });
        return $found;
    }

    function _isRrlWorkHoursValidationMessage(message) {
        var lower = (message || '').toString().toLowerCase();
        return lower.indexOf('work hour') >= 0 ||
            lower.indexOf('work (hh:mm)') >= 0 ||
            lower.indexOf('exceed the project work hours') >= 0 ||
            lower.indexOf('work hours of allocated') >= 0 ||
            (RES.A_WorkHHMMExceedsProject && lower.indexOf(String(RES.A_WorkHHMMExceedsProject).toLowerCase().split('{')[0]) >= 0);
    }

    function _findRrlWorkValidationFocus(gid, $sourceRow) {
        if ($sourceRow && $sourceRow.length) {
            return $sourceRow.find('input[id^="rrl-work-"]').first();
        }
        var $row = $('#rrl-tbody-' + gid + ' tr.rrl-row-editing').filter(function () {
            return $(this).find('.rrl-row-check').prop('checked') === true;
        }).first();
        if (!$row.length) {
            $row = $('#rrl-tbody-' + gid + ' tr').filter(function () {
                return $(this).find('.rrl-row-check').prop('checked') === true;
            }).first();
        }
        if (!$row.length) $row = $('#rrl-tbody-' + gid + ' tr').first();
        return $row.length ? $row.find('input[id^="rrl-work-"]').first() : $();
    }

    function _resolveRrlValidationControl(gid, message, $sourceRow) {
        var msg = (message || '').toString();
        var lower = msg.toLowerCase();
        var $row = ($sourceRow && $sourceRow.length) ? $sourceRow : $();
        var nameMatch = msg.match(/Resource\s+"([^"]+)"/i);
        if (!$row.length && nameMatch && nameMatch[1]) {
            $row = _findRrlRowByResourceName(gid, nameMatch[1]);
        }
        if (!$row.length) {
            $row = $('#rrl-tbody-' + gid + ' tr.rrl-row-editing').filter(function () {
                return $(this).find('.rrl-row-check').prop('checked') === true;
            }).first();
        }
        if (!$row.length) {
            $row = $('#rrl-tbody-' + gid + ' tr').filter(function () {
                return $(this).find('.rrl-row-check').prop('checked') === true;
            }).first();
        }
        if (!$row.length) {
            $row = $('#rrl-tbody-' + gid + ' tr').first();
        }
        if (!$row.length) return $();

        var $ctrl = $();
        if (_isRrlWorkHoursValidationMessage(msg)) {
            $ctrl = $row.find('input[id^="rrl-work-"]');
        } else if (lower.indexOf('allocation period') >= 0 || lower.indexOf('period has passed') >= 0) {
            $ctrl = $row.find('input[id^="rrl-alloc-"]');
        } else if (_isRrlAllocPctValidationMessage(msg)) {
            $ctrl = $row.find('input[id^="rrl-alloc-"]');
        } else if (lower.indexOf('planned start') >= 0) {
            $ctrl = $row.find('input[id^="rrl-start-"]');
        } else if (lower.indexOf('start date and end date') >= 0) {
            $ctrl = $row.find('input[id^="rrl-start-"]');
        } else if (lower.indexOf('planned end') >= 0 || lower.indexOf('allocation end') >= 0 ||
            lower.indexOf('end date beyond') >= 0 || lower.indexOf('project end date') >= 0) {
            $ctrl = $row.find('input[id^="rrl-end-"]');
        } else if (lower.indexOf('role') >= 0) {
            $ctrl = $row.find('select[id^="rrl-role-"]');
        } else {
            $ctrl = $row.find('input[id^="rrl-end-"]');
        }
        return $ctrl.first();
    }

    function _lookupRrlApiRowByPerId(gid, projectEmployeeRoleId) {
        var state = _rrlState[gid];
        if (!state || !state.data || !projectEmployeeRoleId) return null;
        for (var i = 0; i < state.data.length; i++) {
            var row = state.data[i];
            var perId = parseInt(row.projectEmployeeRoleID || row.ProjectEmployeeRoleID
                || row.projectEmployeeRoleId || row.ProjectEmployeeRoleId || 0, 10) || 0;
            if (perId === projectEmployeeRoleId) return row;
        }
        return null;
    }

    function _normRrlReportingName(v) {
        return (v || '')
            .toString()
            .replace(/\u2026/g, '...')
            .replace(/\.\.\.$/, '')
            .trim()
            .toLowerCase();
    }

    function _resolveReportingToFromDisplayName(displayName) {
        var target = _normRrlReportingName(displayName);
        if (!target || target === '—' || target === 'select reporting to') return 0;
        var options = window._reportingToOptions || [];
        for (var i = 0; i < options.length; i++) {
            var opt = options[i];
            var t = (opt.EmployeeName || opt.employeeName || opt.Text || '').toString().trim();
            if (_normRrlReportingName(t) === target) {
                return parseInt(opt.EmployeeID || opt.employeeID || opt.Value || 0, 10) || 0;
            }
        }
        return 0;
    }

    function _resolveReportingToFromApiRow(r) {
        if (!r) return 0;
        var rptId = parseInt(r.reportingTo || r.ReportingTo || 0, 10) || 0;
        if (rptId > 0) return rptId;
        var rptName = (r.reportingToName || r.ReportingToName || r.reportingToEmployeeName || r.ReportingToEmployeeName || '').toString().trim();
        return _resolveReportingToFromDisplayName(rptName);
    }

    function _rrlPersistedOffcanvasAttrs(roleId, reportingTo, statusText, respText, isBillable, isDefaultApprover) {
        return ' data-rrl-persisted-role-id="' + (parseInt(roleId, 10) || 0) + '"' +
            ' data-rrl-persisted-reporting-to="' + (parseInt(reportingTo, 10) || 0) + '"' +
            ' data-rrl-persisted-status="' + escHtml(statusText) + '"' +
            ' data-rrl-persisted-resp="' + escHtml(respText) + '"' +
            ' data-rrl-persisted-billable="' + (isBillable ? '1' : '0') + '"' +
            ' data-rrl-persisted-approver="' + (isDefaultApprover ? '1' : '0') + '"';
    }

    function _setRrlRowPersistedOffcanvasAttrs($row, fields) {
        fields = fields || {};
        $row.attr({
            'data-role-id': fields.roleId || 0,
            'data-reporting-to': fields.reportingTo || 0,
            'data-resource-status': fields.statusText || '',
            'data-billable': fields.isBillable ? '1' : '0',
            'data-default-approver': fields.isDefaultApprover ? '1' : '0',
            'data-product-owner': fields.isProductOwner ? '1' : '0',
            'data-rrl-persisted-role-id': fields.roleId || 0,
            'data-rrl-persisted-reporting-to': fields.reportingTo || 0,
            'data-rrl-persisted-status': fields.statusText || '',
            'data-rrl-persisted-resp': fields.respText || '',
            'data-rrl-persisted-billable': fields.isBillable ? '1' : '0',
            'data-rrl-persisted-approver': fields.isDefaultApprover ? '1' : '0',
            'data-rrl-persisted-product-owner': fields.isProductOwner ? '1' : '0'
        });
    }

    function _refreshRrlPersistedOffcanvasOnDom(gid) {
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var $row = $(this);
            var perId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
            var apiRow = _lookupRrlApiRowByPerId(gid, perId);
            var roleId = parseInt($row.attr('data-rrl-persisted-role-id') || $row.attr('data-role-id'), 10) || 0;
            if (!roleId && apiRow) roleId = parseInt(apiRow.roleID || apiRow.RoleID || 0, 10) || 0;

            var reportingTo = parseInt($row.attr('data-rrl-persisted-reporting-to') || $row.attr('data-reporting-to'), 10) || 0;
            if (!reportingTo) reportingTo = _resolveReportingToFromApiRow(apiRow);
            if (!reportingTo) {
                var rptDisplay = ($row.find('.rrl-col-rpt .rrl-display-val').first().attr('data-rrl-full')
                    || $row.find('.rrl-col-rpt .rrl-display-val').first().text() || '').toString().trim();
                reportingTo = _resolveReportingToFromDisplayName(rptDisplay);
            }

            var statusText = ($row.attr('data-rrl-persisted-status') || $row.attr('data-resource-status') || '').toString().trim();
            if (!statusText && apiRow) statusText = (apiRow.resourceStatus || apiRow.ResourceStatus || '').toString().trim();
            if (!statusText) statusText = ($row.find('.rrl-col-status .rrl-display-val').text() || '').toString().trim();

            var respText = ($row.attr('data-rrl-persisted-resp') || '').toString().trim();
            if (!respText && apiRow) respText = _cleanRrlText(apiRow.responsibility || apiRow.Responsibility || '');
            if (!respText) respText = _cleanRrlText($row.find('.rrl-col-resp .rrl-display-val').text() || '');

            var billAttr = $row.attr('data-rrl-persisted-billable');
            var apprAttr = $row.attr('data-rrl-persisted-approver');
            var isBillable = billAttr === '1';
            var isApprover = apprAttr === '1';
            if (billAttr == null) isBillable = $row.find('.rrl-col-bill .fa-check-circle').length > 0;
            if (apprAttr == null) isApprover = $row.find('.rrl-col-approver .fa-check-circle').length > 0;
            if (billAttr == null && apiRow) isBillable = !!(apiRow.billable || apiRow.Billable || apiRow.isResourceBillable || apiRow.IsResourceBillable);
            if (apprAttr == null && apiRow) isApprover = !!(apiRow.isDefaultApprover || apiRow.IsDefaultApprover);

            _setRrlRowPersistedOffcanvasAttrs($row, {
                roleId: roleId,
                reportingTo: reportingTo,
                statusText: statusText,
                respText: respText,
                isBillable: isBillable,
                isDefaultApprover: isApprover
            });
        });
    }

    function _resolveRrlReportingToId($row, gid) {
        var rowKey = _getRrlRowKey($row);
        if (rowKey) {
            var fromCtrl = parseInt($row.find('#rrl-rpt-' + rowKey).val(), 10) || 0;
            if (fromCtrl > 0) return fromCtrl;
        }

        var fromAttr = parseInt($row.attr('data-reporting-to'), 10) || 0;
        if (fromAttr > 0) return fromAttr;

        var fromPersisted = parseInt($row.attr('data-rrl-persisted-reporting-to'), 10) || 0;
        if (fromPersisted > 0) return fromPersisted;

        var perId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
        var apiRow = _lookupRrlApiRowByPerId(gid, perId);
        var fromApi = _resolveReportingToFromApiRow(apiRow);
        if (fromApi > 0) return fromApi;

        var rptDisplay = ($row.find('.rrl-col-rpt .rrl-display-val').first().attr('data-rrl-full')
            || $row.find('.rrl-col-rpt .rrl-display-val').first().text() || '').toString().trim();
        return _resolveReportingToFromDisplayName(rptDisplay);
    }

    function _resolveRrlRoleId($row, gid) {
        var fromPersisted = parseInt($row.attr('data-rrl-persisted-role-id'), 10) || 0;
        if (fromPersisted > 0) return fromPersisted;

        var fromAttr = parseInt($row.attr('data-role-id'), 10) || 0;
        if (fromAttr > 0) return fromAttr;

        var perId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
        var apiRow = _lookupRrlApiRowByPerId(gid, perId);
        if (apiRow) {
            var fromApi = parseInt(apiRow.roleID || apiRow.RoleID || 0, 10) || 0;
            if (fromApi > 0) return fromApi;
        }
        return parseInt($row.find('select[id^="rrl-role-"]').val(), 10) || 0;
    }

    /* Compact reallocation list: only Start/End/Alloc/Work are editable — preserve other fields from row snapshot */
    function _getRrlPersistedReadOnlyFields($row, gid) {
        var isCompact = $row.closest('table.rrl-compact-list').length > 0;
        var perId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
        var apiRow = _lookupRrlApiRowByPerId(gid, perId);

        if (!isCompact) {
            return {
                roleId: _resolveRrlRoleId($row, gid),
                reportingTo: _resolveRrlReportingToId($row, gid),
                resourceStatus: ($row.find('select[id^="rrl-status-"]').val() || '').toString().trim(),
                isResourceBillable: !!$row.find('input[id^="rrl-bill-"]').prop('checked'),
                responsibility: _cleanRrlText($row.find('textarea[id^="rrl-resp-"]').val() || ''),
                isDefaultApprover: !!$row.find('input[id^="rrl-approver-"]').prop('checked'),
                isProductOwner: _rrlIsProductOwnerFromRow($row)
            };
        }

        /* Offcanvas-only fields: prefer hidden row controls (updated via offcanvas), then attrs / API */
        var rowKey = _getRrlRowKey($row);
        var fromControls = (rowKey && $row.find('.rrl-offcanvas-only').length)
            ? _getRrlRowCurrentOffcanvasFields($row) : null;

        var statusText = fromControls
            ? (fromControls.resourceStatus || fromControls.resourceStatusText)
            : ($row.attr('data-rrl-persisted-status') || $row.attr('data-resource-status') || '').toString().trim();
        if (!statusText && apiRow) {
            statusText = (apiRow.resourceStatus || apiRow.ResourceStatus || '').toString().trim();
        }

        var respText = fromControls ? fromControls.responsibility
            : ($row.attr('data-rrl-persisted-resp') || '').toString().trim();
        if (!respText && apiRow) {
            respText = _cleanRrlText(apiRow.responsibility || apiRow.Responsibility || '');
        }

        var reportingTo = fromControls && fromControls.reportingTo > 0
            ? fromControls.reportingTo
            : _resolveRrlReportingToId($row, gid);

        var isBillable = fromControls ? fromControls.isResourceBillable : null;
        var isApprover = fromControls ? fromControls.isDefaultApprover : null;
        var isProductOwner = fromControls ? fromControls.isProductOwner : null;
        if (isBillable == null) {
            var billableAttr = $row.attr('data-rrl-persisted-billable');
            if (billableAttr == null) billableAttr = $row.attr('data-billable');
            isBillable = billableAttr === '1';
            if (billableAttr == null && apiRow) {
                isBillable = !!(apiRow.billable || apiRow.Billable || apiRow.isResourceBillable || apiRow.IsResourceBillable);
            }
        }
        if (isApprover == null) {
            var approverAttr = $row.attr('data-rrl-persisted-approver');
            if (approverAttr == null) approverAttr = $row.attr('data-default-approver');
            isApprover = approverAttr === '1';
            if (approverAttr == null && apiRow) {
                isApprover = !!(apiRow.isDefaultApprover || apiRow.IsDefaultApprover);
            }
        }
        if (isProductOwner == null) {
            isProductOwner = _rrlIsProductOwnerFromRow($row);
            if (!isProductOwner && apiRow) {
                isProductOwner = !!(apiRow.isProductOwner || apiRow.IsProductOwner || apiRow.intIsProductOwner || apiRow.IntIsProductOwner);
            }
        }

        return {
            roleId: _resolveRrlRoleId($row, gid),
            reportingTo: reportingTo,
            resourceStatus: statusText,
            isResourceBillable: !!isBillable,
            responsibility: respText,
            isDefaultApprover: !!isApprover,
            isProductOwner: !!isProductOwner
        };
    }

    /* Reallocation save source — "ListView" | "OffCanvas" */
    window._rrlSaveFromWhere = 'ListView';

    function _getRrlSaveFromWhere(fromWhere) {
        return fromWhere || window._rrlSaveFromWhere || 'ListView';
    }

    function _isRrlSaveFromOffcanvas(fromWhere) {
        return _getRrlSaveFromWhere(fromWhere) === 'OffCanvas';
    }

    function clearRrlOcValidation() {
        $('#rrlOcEditFields .oc-val-error').removeClass('oc-val-error');
        $('#rrlOcEditFields .bootstrap-select.oc-val-error').removeClass('oc-val-error');
        $('#rrlOcEditFields .rrl-date-wrap.oc-val-error').removeClass('oc-val-error');
    }

    function clearRrlValidation(gid) {
        var $scope = $('#rrl-tbody-' + gid);
        $scope.find('.oc-val-error').removeClass('oc-val-error');
        $scope.find('.bootstrap-select.oc-val-error').removeClass('oc-val-error');
        $scope.find('.rrl-date-wrap.oc-val-error').removeClass('oc-val-error');
    }

    function _mapRrlListControlToOffcanvas($ctrl) {
        if (!$ctrl || !$ctrl.length) return $();
        if ($ctrl.closest('#rrlOcEditFields').length) return $ctrl;
        var id = ($ctrl.attr('id') || '').toString();
        if (id.indexOf('rrl-start-') === 0) return $('#rrlOcStart');
        if (id.indexOf('rrl-end-') === 0) return $('#rrlOcEnd');
        if (id.indexOf('rrl-alloc-') === 0) return $('#rrlOcAlloc');
        if (id.indexOf('rrl-work-') === 0) return $('#rrlOcWork');
        if (id.indexOf('rrl-rpt-') === 0) return $('#rrlOcRpt');
        if (id.indexOf('rrl-status-') === 0) return $('#rrlOcStatus');
        if (id.indexOf('rrl-resp-') === 0) return $('#rrlOcResp');
        if (id.indexOf('rrl-bill-') === 0) return $('#rrlOcBill');
        if (id.indexOf('rrl-approver-') === 0) return $('#rrlOcApprover');
        if (id.indexOf('rrl-po-') === 0) return $('#rrlOcProductOwner');
        return $();
    }

    function _resolveRrlOcValidationControl(message) {
        var lower = (message || '').toString().toLowerCase();
        if (_isRrlAllocPctValidationMessage(message)) {
            return $('#rrlOcAlloc');
        }
        if (lower.indexOf('planned start') >= 0 || lower.indexOf('start date and end date') >= 0) {
            return $('#rrlOcStart');
        }
        if (lower.indexOf('planned end') >= 0 || lower.indexOf('allocation end') >= 0 ||
            lower.indexOf('end date beyond') >= 0 || lower.indexOf('project end date') >= 0) {
            return $('#rrlOcEnd');
        }
        if (_isRrlWorkHoursValidationMessage(message) || lower.indexOf('work') >= 0) return $('#rrlOcWork');
        if (lower.indexOf('reporting') >= 0) return $('#rrlOcRpt');
        if (lower.indexOf('status') >= 0) return $('#rrlOcStatus');
        if (lower.indexOf('responsibilit') >= 0) return $('#rrlOcResp');
        return $('#rrlOcStart');
    }

    function _closeRrlAllocationDetailOffcanvas() {
        if (typeof _rrlDestroyOcSelectpickers === 'function') _rrlDestroyOcSelectpickers();
        var ocEl = document.getElementById('rrlAllocationDetailOffcanvas');
        if (ocEl) {
            var inst = bootstrap.Offcanvas.getInstance(ocEl);
            if (inst) inst.hide();
        }
        window._rrlOcActiveRowKey = null;
        window._rrlOcActiveGid = null;
        window._rrlSaveFromWhere = 'ListView';
    }

    function clearRrlControlError($ctrl) {
        if (!$ctrl || !$ctrl.length) return;
        $ctrl.removeClass('oc-val-error');
        var $bs = $ctrl.next('.bootstrap-select');
        if (!$bs.length) $bs = $ctrl.closest('.bootstrap-select');
        if ($bs.length) $bs.removeClass('oc-val-error');
        var $wrap = $ctrl.closest('.rrl-date-wrap');
        if ($wrap.length) $wrap.removeClass('oc-val-error');
    }

    function markRrlControl($ctrl) {
        if (!$ctrl || !$ctrl.length) return;
        if ($ctrl.is('select')) {
            var $bs = $ctrl.next('.bootstrap-select');
            if (!$bs.length) $bs = $ctrl.closest('.bootstrap-select');
            if ($bs.length) $bs.addClass('oc-val-error');
            else $ctrl.addClass('oc-val-error');
        } else {
            $ctrl.addClass('oc-val-error');
            var $wrap = $ctrl.closest('.rrl-date-wrap');
            if ($wrap.length) $wrap.addClass('oc-val-error');
        }
    }

    /* Added By Dipali V On 5th Jun 2026 — clear red validation border when user enters a value in RRL edit fields */
    (function bindRrlLiveValidationClearers() {
        if (window._rrlValidationClearersBound) return;
        window._rrlValidationClearersBound = true;

        $(document).on('input change', '.rrl-table input[id^="rrl-start-"], .rrl-table input[id^="rrl-end-"], .rrl-table input[id^="rrl-alloc-"], .rrl-table input[id^="rrl-work-"]', function () {
            if (String(this.value || '').trim()) clearRrlControlError($(this));
        });

        $(document).on('changed.bs.select', '.rrl-table select[id^="rrl-"]', function () {
            var $sel = $(this);
            var val = ($sel.val() || '').toString();
            if (val && val !== '0') clearRrlControlError($sel);
        });

        $(document).on('input change', '#rrlOcEditFields input, #rrlOcEditFields textarea', function () {
            if (String(this.value || '').trim()) clearRrlControlError($(this));
        });

        $(document).on('changed.bs.select', '#rrlOcEditFields select', function () {
            var $sel = $(this);
            var val = ($sel.val() || '').toString();
            if (val && val !== '0') clearRrlControlError($sel);
        });
    })();

    function showRrlValidation(gid, message, $ctrl, fromWhere) {
        fromWhere = _getRrlSaveFromWhere(fromWhere);
        alertify.set('notifier', 'position', 'top-right');
        if (typeof alertify.dismissAll === 'function') alertify.dismissAll();

        if (_isRrlSaveFromOffcanvas(fromWhere)) {
            clearRrlOcValidation();
            clearRrlValidation(gid);
            var $ocCtrl = $();
            if ($ctrl && $ctrl.length) $ocCtrl = _mapRrlListControlToOffcanvas($ctrl);
            if (!$ocCtrl.length) $ocCtrl = _resolveRrlOcValidationControl(message);
            if ($ocCtrl.length) {
                markRrlControl($ocCtrl);
                _ensureValidationControlVisibleAndFocus($ocCtrl[0]);
            }
            alertify.error(message);
            return;
        }

        if ($ctrl && $ctrl.length) {
            var $row = $ctrl.closest('tr');
            if ($row.length && !_isRrlResourceActiveFromRow($row)) {
                clearRrlValidation(gid);
                clearRrlOcValidation();
                alertify.error(_rrlInactiveResourceEditMessage());
                return;
            }
            if ($row.length) {
                var rowEditing = $row.hasClass('rrl-row-editing');
                if (!rowEditing) {
                    var $chk = $row.find('.rrl-row-check');
                    if ($chk.length && !$chk.prop('checked')) {
                        $chk.prop('checked', true);
                    }
                    var $editBtn = $row.find('.btn-rrl-edit').first();
                    if ($editBtn.length) $editBtn.trigger('click');
                }
            }
        }
        clearRrlOcValidation();
        clearRrlValidation(gid);
        if (!$ctrl || !$ctrl.length) {
            $ctrl = _isRrlWorkHoursValidationMessage(message)
                ? _findRrlWorkValidationFocus(gid)
                : _resolveRrlValidationControl(gid, message);
        }
        if ($ctrl && $ctrl.length) {
            var $row = $ctrl.closest('tr');
            if ($row.length && !$row.hasClass('rrl-row-editing')) {
                var $editBtn = $row.find('.btn-rrl-edit').first();
                if ($editBtn.length) $editBtn.trigger('click');
            }
            markRrlControl($ctrl);
            _ensureValidationControlVisibleAndFocus($ctrl[0]);
        }
        alertify.error(message);
    }

    function _isValidRrlWorkValue(value) {
        return _hhmmToDecimal(value) != null;
    }

    function _buildRrlSavePayloadForRow($row, gid) {
        if (!_isRrlResourceActiveFromRow($row)) {
            return { ok: false, message: _rrlInactiveResourceEditMessage(), $focus: $row.find('.rrl-row-check') };
        }
        var projectEmployeeRoleId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
        var employeeId = parseInt($row.attr('data-employee-id'), 10) || 0;
        var $start = $row.find('input[id^="rrl-start-"]');
        var $end = $row.find('input[id^="rrl-end-"]');
        var $alloc = $row.find('input[id^="rrl-alloc-"]');
        var $work = $row.find('input[id^="rrl-work-"]');
        var persisted = _getRrlPersistedReadOnlyFields($row, gid);
        var startText = ($start.val() || '').toString().trim();
        var endText = ($end.val() || '').toString().trim();
        var allocText = ($alloc.val() || '').toString().replace('%', '').trim();
        var workText = ($work.val() || '').toString().trim();
        var startDate = rrlDateToApi(startText);
        var endDate = rrlDateToApi(endText);
        var resourcePercentage = _parseIntegerAllocation(allocText);

        if (!projectEmployeeRoleId) {
            return { ok: false, message: RES.A_ProjectEmployeeRoleIdMissing, $focus: $row.find('.rrl-row-check') };
        }
        if (!startText) {
            return { ok: false, message: RES.A_PlannedStartNotBlank, $focus: $start };
        }
        if (!startDate) {
            return { ok: false, message: RES.A_StartDateValid, $focus: $start };
        }
        if (!endText) {
            return { ok: false, message: RES.A_PlannedEndNotBlank, $focus: $end };
        }
        if (!endDate) {
            return { ok: false, message: RES.A_PlannedEndDateNotValid, $focus: $end };
        }
        if (startDate > endDate) {
            return { ok: false, message: RES.A_PlannedStartBeforeOrEqualEnd, $focus: $start };
        }
        if (!allocText || isNaN(resourcePercentage)) {
            return { ok: false, message: RES.A_AllocationPctBlank, $focus: $alloc };
        }
        if (_isAllocationDecimalInvalid(allocText)) {
            return { ok: false, message: _allocationPctNoDecimalMsg(), $focus: $alloc };
        }
        if (resourcePercentage < 1 || resourcePercentage > _maxAllocPct) {
            return { ok: false, message: _resFmt(RES.A_AllocationPctBetween, _maxAllocPct), $focus: $alloc };
        }
        if (_isAllowBackDatedAllocationRestrictEnabled()) {
            var persistedEditable = _getRrlRowPersistedEditable($row);
            if (_normRrlAllocValue(allocText) !== _normRrlAllocValue(persistedEditable.alloc) &&
                _isRrlAllocationPeriodPassed(persistedEditable.start, persistedEditable.end)) {
                return {
                    ok: false,
                    message: (RES.A_AllocationPeriodPassedNoChange || 'Allocation period has passed. You can not change').toString(),
                    $focus: $alloc
                };
            }
        }
        if (!workText) {
            return { ok: false, message: RES.A_WorkNotBlank, $focus: $work };
        }
        if (!_isValidRrlWorkValue(workText)) {
            return { ok: false, message: RES.A_WorkHHMMInvalid, $focus: $work };
        }
        var workHoursDecimal = _hhmmToDecimal(workText);
        if (_wouldExceedProjectWorkHoursCap(workHoursDecimal, {
            gid: gid,
            excludeProjectEmployeeRoleId: projectEmployeeRoleId
        })) {
            return { ok: false, message: _projectWorkHoursExceededMessage(), $focus: $work };
        }

        return {
            ok: true,
            item: {
                projectID: parseInt(SessionProjectID, 10) || 0,
                projectEmployeeRoleId: projectEmployeeRoleId,
                rate: 0,
                cost: 0,
                employeeID: employeeId,
                role: persisted.roleId,
                resourcePercentage: resourcePercentage,
                expectedStartDate: startDate,
                expectedEndDate: endDate,
                resourceStatus: persisted.resourceStatus || '',
                isResourceBillable: !!persisted.isResourceBillable,
                responsibility: persisted.responsibility || '',
                reportingTo: persisted.reportingTo,
                isDefaultApprover: !!persisted.isDefaultApprover,
                budgetedHours: workText || null,
                intIsProductOwner: !!persisted.isProductOwner
            }
        };
    }

    function _rrlCommitRowPersistedAfterSave($row, gid) {
        var persisted = _getRrlPersistedReadOnlyFields($row, gid);
        _setRrlRowPersistedOffcanvasAttrs($row, {
            roleId: persisted.roleId,
            reportingTo: persisted.reportingTo,
            statusText: persisted.resourceStatus,
            respText: persisted.responsibility,
            isBillable: persisted.isResourceBillable,
            isDefaultApprover: persisted.isDefaultApprover,
            isProductOwner: persisted.isProductOwner
        });
        _rrlUpdateRowPersistedEditableAttrs($row);
        _rrlSyncApiStateRowFromDom($row, gid);
    }

    function _saveRrlPayloadToBackend(gid, projectEmployeeRoles, options) {
        options = options || {};
        if (!projectEmployeeRoles || !projectEmployeeRoles.length) return;

        var fromWhere = _getRrlSaveFromWhere(options.fromWhere);
        window._rrlSaveFromWhere = fromWhere;

        var $btn = (options.triggerBtn && options.triggerBtn.length) ? options.triggerBtn : $('#btn-rrl-save-' + gid);
        var oldHtml = options.oldBtnHtml != null ? options.oldBtnHtml : $btn.html();
        var savingLabel = (RES.C_Saving || 'Saving...').toString();
        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i><span> ' + savingLabel + '</span>');

        AJAXCallWithResult(
            'api/PM_BulkResourceAllocation/SaveProjectEmployeeRole',
            JSON.stringify({
                userName: SessionUserName || UserName || FromuserName || '',
                projectEmployeeRoles: projectEmployeeRoles
            }),
            true,
            function (response) {
                var result = response && response.data ? response.data : response;
                var apiMessage = (result && (result.message || result.Message)) || '';
                var updatedRows = result && (result.updatedRows != null ? result.updatedRows : result.UpdatedRows);
                alertify.set('notifier', 'position', 'top-right');
                if (_isRrlSaveApiFailure(result, updatedRows)) {
                    if (options.refreshGrid !== false && !_isRrlSaveFromOffcanvas(fromWhere)) {
                        _rrlRevertAndExitUnselectedEditingRows(gid);
                    }
                    showRrlValidation(
                        gid,
                        apiMessage || RES.A_FailedToSaveAllocatedResources,
                        _resolveRrlValidationControl(gid, apiMessage, options.sourceRow),
                        fromWhere
                    );
                    return;
                }
                _rrlClearSaveFocusState(gid, fromWhere);
                if (typeof alertify.dismissAll === 'function') alertify.dismissAll();
                alertify.success(
                    _isRrlSaveSuccessApiMessage(apiMessage)
                        ? apiMessage
                        : _rrlResourceUpdatedSuccessMessage()
                );
                (projectEmployeeRoles || []).forEach(function (item) {
                    var perId = parseInt(item.projectEmployeeRoleId, 10) || 0;
                    if (!perId) return;
                    var newH = _budgetedHoursToDecimal(item.budgetedHours);
                    var oldH = 0;
                    var apiRow = _lookupRrlApiRowByPerId(gid, perId);
                    if (apiRow) oldH = _budgetedHoursToDecimal(apiRow.budgetedHours || apiRow.BudgetedHours);
                    _applyProjectAllocatedHoursDelta(newH - oldH);
                });
                if (typeof _refreshProjectDefaultApproverFromRrlGrid === 'function') {
                    _refreshProjectDefaultApproverFromRrlGrid(gid);
                }
                if (typeof options.onSuccess === 'function') {
                    options.onSuccess(response);
                } else if (options.refreshGrid !== false) {
                    _rrlRefreshGridAfterSaveSuccess(gid);
                }
            },
            function (xhr) {
                var msg = RES.A_FailedToSaveAllocatedResources;
                try {
                    var err = JSON.parse(xhr.responseText);
                    if (err && (err.message || err.Message || err.title)) msg = err.message || err.Message || err.title;
                } catch (e) { }
                if (options.refreshGrid !== false) {
                    _rrlRevertAndExitUnselectedEditingRows(gid);
                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(msg);
            },
            function () {
                $btn.prop('disabled', false).html(oldHtml);
            }
        );
    }

    /* Added By Dipali V On 5th Jun 2026 — Save routes to extend OR allocation update based on user action */
    function saveAllocatedResources(gid) {
        if (!editAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionSave);
            return;
        }
        _rrlSyncPageSelectionFromDom(gid);
        _rrlSyncPendingEditsFromDom(gid);
        if (_rrlHasResourceDetailChanges(gid)) {
            _saveAllocatedResourcesCore(gid);
            return;
        }
        if (_isRrlExtendNoteVisible(gid)) {
            saveExtendProjectResourceEndDatesFromRrlGrid(gid);
            return;
        }
        _saveAllocatedResourcesCore(gid);
    }

    function _saveRrlRowsCore(gid, $rows, options) {
        options = options || {};
        $rows = ($rows && $rows.jquery) ? $rows : $($rows);
        if (!$rows.length) return false;

        var $sourceRow = options.sourceRow && options.sourceRow.length ? options.sourceRow : ($rows.length === 1 ? $rows.first() : null);
        var projectEmployeeRoles = [];
        window._rrlSaveFromWhere = options.fromWhere || 'ListView';
        clearRrlValidation(gid);
        clearRrlOcValidation();

        $rows.each(function () {
            if (projectEmployeeRoles === null) return;
            var built = _buildRrlSavePayloadForRow($(this), gid);
            if (!built.ok) {
                showRrlValidation(gid, built.message, built.$focus, options.fromWhere);
                projectEmployeeRoles = null;
                return;
            }
            projectEmployeeRoles.push(built.item);
        });

        if (projectEmployeeRoles === null) return false;
        if (!projectEmployeeRoles.length) return false;

        var rrlWorkBudget = _validateRrlBatchWorkHoursBudget(gid, projectEmployeeRoles);
        if (!rrlWorkBudget.ok) {
            showRrlValidation(gid, rrlWorkBudget.message, _findRrlWorkValidationFocus(gid, $sourceRow), options.fromWhere);
            return false;
        }

        _rrlValidateAndSaveDefaultApproverThenSave(gid, projectEmployeeRoles, {
            fromWhere: options.fromWhere || 'ListView',
            triggerBtn: options.triggerBtn || $('#btn-rrl-save-' + gid),
            refreshGrid: options.refreshGrid !== false,
            oldBtnHtml: options.oldBtnHtml,
            sourceRow: $sourceRow,
            onSuccess: options.onSuccess
        });
        return true;
    }

    function _saveAllocatedResourcesCore(gid) {
        var $allRows = $('#rrl-tbody-' + gid + ' tr');
        if ($allRows.length === 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoAllocatedResourcesToSave);
            return;
        }

        var $rows = $allRows.filter(function () {
            return $(this).find('.rrl-row-check').prop('checked') === true;
        });

        if ($rows.length === 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_PleaseSelectAtLeastOneAllocatedResource);
            return;
        }

        _saveRrlRowsCore(gid, $rows, {
            fromWhere: 'ListView',
            triggerBtn: $('#btn-rrl-save-' + gid),
            refreshGrid: true
        });
    }

    function _rrlDestroyOcSelectpickers() {
        ['#rrlOcRpt', '#rrlOcStatus'].forEach(function (sel) {
            var $s = $(sel);
            if (!$s.length) return;
            try { if ($s.data('selectpicker')) $s.selectpicker('destroy'); } catch (e) { /* ignore */ }
        });
        $('#rrlOcStart, #rrlOcEnd').each(function () {
            var $dp = $(this);
            if ($dp.data('display-dp-init')) {
                try { $dp.datepicker('destroy'); } catch (e) { /* ignore */ }
                $dp.removeData('display-dp-init');
            }
        });
    }

    function _initRrlOcSelectpickers() {
        var $rpt = $('#rrlOcRpt');
        if ($rpt.length) {
            try {
                var selectedVal = $rpt.val() || '';
                var selectedName = ($rpt.find('option:selected').text() || '').toString().trim();
                var rptRows = window._reportingToAllRows || window._reportingToOptions || [];
                if (rptRows.length) {
                    _fillReportingToOptions($rpt, rptRows, selectedVal, selectedName);
                } else {
                    _initReportingToSelectpicker($rpt);
                }
                if (!(parseInt($rpt.val(), 10) || 0)) {
                    try { $rpt.selectpicker('val', ''); $rpt.selectpicker('refresh'); } catch (e0) { /* ignore */ }
                }
            } catch (e) {
                try { $rpt.selectpicker({ liveSearch: true, size: 6, width: '100%', dropupAuto: false, noneSelectedText: RES.C_SelectReportingTo || 'Select Reporting To' }); } catch (e2) { /* ignore */ }
            }
        }
        var $status = $('#rrlOcStatus');
        if ($status.length) {
            try {
                if ($status.data('selectpicker')) $status.selectpicker('destroy');
                $status.selectpicker({
                    liveSearch: true,
                    size: 6,
                    width: '100%',
                    dropupAuto: false
                });
            } catch (e) {
                try { $status.selectpicker(); } catch (e2) { /* ignore */ }
            }
        }
    }

    function _rrlValidateOcListFields(fields) {
        fields = fields || {};
        var startApi = rrlDateToApi(fields.start);
        var endApi = rrlDateToApi(fields.end);
        var allocText = (fields.alloc || '').toString().replace('%', '').trim();
        var alloc = _parseIntegerAllocation(allocText);
        var work = (fields.work || '').toString().trim();
        if (!fields.start) return 'Planned Start Date should not be left blank.';
        if (!startApi) return 'Planned Start Date is invalid.';
        if (!fields.end) return 'Planned End Date should not be left blank.';
        if (!endApi) return 'Planned End Date is invalid.';
        if (startApi > endApi) return 'Planned Start Date must be earlier than or equal to Planned End Date.';
        if (!allocText) return '% Allocation should not be left blank.';
        if (_isAllocationDecimalInvalid(allocText)) return _allocationPctNoDecimalMsg();
        if (isNaN(alloc) || alloc < 1 || alloc > _maxAllocPct) {
            return 'You can enter allocation between 1 and ' + _maxAllocPct + ' only. Please reset the allocation value.';
        }
        if (!work) return 'Work (HH:MM) should not be left blank.';
        if (!_isValidRrlWorkValue(work)) return 'Please enter Work (Hrs) in HH:MM format.';
        var reportingTo = parseInt(fields.reportingTo, 10) || 0;
        if (!reportingTo) return RES.A_RepToNotBlank;
        var resourceStatus = (fields.resourceStatus || '').toString().trim();
        if (!resourceStatus || resourceStatus === '0') return RES.A_ResStNotBlank;
        return '';
    }

    function _rrlBuildOcReportingToOptionsHtml(selectedId, selectedName) {
        return _buildReportingToOptionsHtml(window._reportingToAllRows || window._reportingToOptions, selectedId, selectedName);
    }

    function _rrlBuildOcStatusOptionsHtml(selectedVal, selectedText) {
        var html = '<option value="">Select Resource Status</option>';
        var selectedTextNorm = (selectedText || '').toString().trim().toLowerCase();
        $('#ocResourceStatus option').each(function () {
            var v = ($(this).val() || '').toString();
            var t = ($(this).text() || '').toString();
            if (!v) return;
            var sel = (v === selectedVal || (selectedTextNorm && t.trim().toLowerCase() === selectedTextNorm)) ? ' selected' : '';
            html += '<option value="' + escHtml(v) + '"' + sel + '>' + escHtml(t) + '</option>';
        });
        return html;
    }

    function _rrlRenderOffcanvasEditForm($row, rowKey) {
        var cur = _getRrlRowCurrentOffcanvasFields($row);
        var persisted = _getRrlRowPersistedOffcanvasFields($row);
        if (!cur.reportingTo && persisted.reportingTo > 0) cur.reportingTo = persisted.reportingTo;
        if (!cur.resourceStatus) cur.resourceStatus = persisted.resourceStatus;
        if (!cur.responsibility) cur.responsibility = persisted.responsibility;
        var rptName = cur.reportingToText || ($row.find('.rrl-col-rpt .rrl-display-val').text() || '').toString().trim();
        var statusText = cur.resourceStatusText || ($row.find('.rrl-col-status .rrl-display-val').text() || '').toString().trim();
        var listVals = _getRrlRowCurrentEditable($row);
        var rrlDatePh = escHtml(RES.C_DatePlaceholder || '01 May 2027');
        var html = '';
        html += '<div class="rrl-oc-field"><label>' + escHtml(RES.C_ProjectRole) + '</label><div class="rrl-oc-readonly">' + escHtml(_rrlGetRoleDisplayVal($row)) + '</div></div>';
        html += '<div class="rrl-oc-field"><label for="rrlOcStart">' + escHtml(RES.C_StartDateHeader) + '<span class="required">*</span></label>' +
            '<div class="rrl-date-wrap">' +
            '<input type="text" class="form-control rrl-edit-input rrl-date-input" id="rrlOcStart" placeholder="' + rrlDatePh + '" value="' + escHtml(listVals.start || '') + '" readonly autocomplete="off">' +
            '<button class="rrl-cal-btn" type="button" onclick="openRrlDatepicker(\'rrlOcStart\')" title="Pick date"><i class="fas fa-calendar-alt"></i></button>' +
            '</div></div>';
        html += '<div class="rrl-oc-field"><label for="rrlOcEnd">' + escHtml(RES.C_EndDateHeader) + '<span class="required">*</span></label>' +
            '<div class="rrl-date-wrap">' +
            '<input type="text" class="form-control rrl-edit-input rrl-date-input" id="rrlOcEnd" placeholder="' + rrlDatePh + '" value="' + escHtml(listVals.end || '') + '" readonly autocomplete="off">' +
            '<button class="rrl-cal-btn" type="button" onclick="openRrlDatepicker(\'rrlOcEnd\')" title="Pick date"><i class="fas fa-calendar-alt"></i></button>' +
            '</div></div>';
        html += '<div class="rrl-oc-field"><label for="rrlOcAlloc">' + escHtml(RES.C_PercentAllocation) + '<span class="required">*</span></label>' +
            '<input type="text" class="form-control" id="rrlOcAlloc" value="' + escHtml(listVals.alloc || '') + '" maxlength="6" autocomplete="off" inputmode="numeric" oninput="rgAllocationIntegerOnly(this)"></div>';
        html += '<div class="rrl-oc-field"><label for="rrlOcWork">' + escHtml(RES.C_WorkHHMM) + '<span class="required">*</span></label>' +
            '<input type="text" class="form-control" id="rrlOcWork" value="' + escHtml(listVals.work || '') + '" maxlength="8" autocomplete="off" oninput="workHHMMInput(this)"></div>';
        var rptOptionsHtml = _rrlBuildOcReportingToOptionsHtml(cur.reportingTo, rptName);
        if (!rptOptionsHtml || rptOptionsHtml.indexOf('value=') < 0) {
            var $srcRpt = $row.find('#rrl-rpt-' + rowKey);
            if ($srcRpt.length) rptOptionsHtml = $srcRpt.html();
        }
        var statusOptionsHtml = _rrlBuildOcStatusOptionsHtml(cur.resourceStatus, statusText);
        if (!statusOptionsHtml || statusOptionsHtml.indexOf('value=') < 0) {
            var $srcStatus = $row.find('#rrl-status-' + rowKey);
            if ($srcStatus.length) statusOptionsHtml = $srcStatus.html();
        }
        html += '<div class="rrl-oc-field"><label for="rrlOcRpt">' + escHtml(RES.C_ReportingTo) + '<span class="required">*</span></label>' +
            '<select class="selectpicker" id="rrlOcRpt" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false" ' +
            'data-none-selected-text="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '" title="' + escHtml(RES.C_SelectReportingTo || 'Select Reporting To') + '">' +
            rptOptionsHtml + '</select></div>';
        html += '<div class="rrl-oc-field"><label for="rrlOcStatus">' + escHtml(RES.C_ResourceStatus) + '<span class="required">*</span></label>' +
            '<select class="selectpicker" id="rrlOcStatus" data-live-search="true" data-size="6" data-width="100%" data-dropup-auto="false">' +
            statusOptionsHtml + '</select></div>';
        html += '<div class="rrl-oc-field"><label for="rrlOcResp">' + escHtml(RES.C_Responsibilities) + '</label>' +
            '<textarea class="form-control" id="rrlOcResp" maxlength="1000" rows="3">' + escHtml(cur.responsibility || '') + '</textarea></div>';
        html += '<div class="rrl-oc-field"><label>' + escHtml(RES.C_Billable) + '</label>' +
            '<div class="rrl-oc-check-row"><input type="checkbox" class="form-check-input" id="rrlOcBill"' + (cur.isResourceBillable ? ' checked' : '') + '></div></div>';
        html += '<div class="rrl-oc-field"><label>' + escHtml(RES.C_IsDefaultApprover) + '</label>' +
            '<div class="rrl-oc-check-row"><input type="checkbox" class="form-check-input" id="rrlOcApprover"' + (cur.isDefaultApprover ? ' checked' : '') + '></div></div>';
        if (_isAgileProjectForProductOwner()) {
            html += '<div class="rrl-oc-field"><label>' + escHtml(RES.C_IsProductOwner) + '</label>' +
                '<div class="rrl-oc-check-row"><input type="checkbox" class="form-check-input" id="rrlOcProductOwner"' + (cur.isProductOwner ? ' checked' : '') + '></div></div>';
        }
        $('#rrlOcEditFields').html(html);
        _initRrlOcSelectpickers();
        _applyDisplayDatepicker($('#rrlOcStart'));
        _applyDisplayDatepicker($('#rrlOcEnd'));
    }

    function _rrlReadOffcanvasEditForm() {
        var $rpt = $('#rrlOcRpt');
        var $status = $('#rrlOcStatus');
        var rptVal = _rrlOcSelectVal($rpt);
        var statusVal = _rrlOcSelectVal($status);
        return {
            start: ($('#rrlOcStart').val() || '').toString().trim(),
            end: ($('#rrlOcEnd').val() || '').toString().trim(),
            alloc: ($('#rrlOcAlloc').val() || '').toString().replace('%', '').trim(),
            work: ($('#rrlOcWork').val() || '').toString().trim(),
            reportingTo: parseInt(rptVal, 10) || 0,
            reportingToText: ($rpt.find('option[value="' + rptVal + '"]').text() || $rpt.find('option:selected').text() || '').toString().trim(),
            resourceStatus: statusVal,
            resourceStatusText: ($status.find('option[value="' + statusVal + '"]').text() || $status.find('option:selected').text() || '').toString().trim(),
            responsibility: _cleanRrlText($('#rrlOcResp').val() || ''),
            isResourceBillable: $('#rrlOcBill').prop('checked') === true,
            isDefaultApprover: $('#rrlOcApprover').prop('checked') === true,
            isProductOwner: $('#rrlOcProductOwner').length ? ($('#rrlOcProductOwner').prop('checked') === true) : false
        };
    }

    function _rrlApplyOffcanvasFieldsToRow($row, rowKey, fields) {
        fields = fields || {};
        var $start = $row.find('#rrl-start-' + rowKey);
        var $end = $row.find('#rrl-end-' + rowKey);
        var $alloc = $row.find('#rrl-alloc-' + rowKey);
        var $work = $row.find('#rrl-work-' + rowKey);
        var $rpt = $row.find('#rrl-rpt-' + rowKey);
        var $status = $row.find('#rrl-status-' + rowKey);
        var $resp = $row.find('#rrl-resp-' + rowKey);
        var $bill = $row.find('#rrl-bill-' + rowKey);
        var $approver = $row.find('#rrl-approver-' + rowKey);
        var $po = $row.find('#rrl-po-' + rowKey);

        if (fields.start != null && $start.length) {
            var startDisp = _fmtDisplayDate(fields.start);
            $start.val(startDisp);
            _rrlSetDisplayVal($row.find('.rrl-col-start .rrl-display-val'), startDisp, '—', true);
        }
        if (fields.end != null && $end.length) {
            var endDisp = _fmtDisplayDate(fields.end);
            $end.val(endDisp);
            _rrlSetDisplayVal($row.find('.rrl-col-end .rrl-display-val'), endDisp, '—', true);
        }
        if (fields.alloc != null && $alloc.length) {
            $alloc.val(fields.alloc);
            _rrlSetDisplayVal($row.find('.rrl-col-alloc .rrl-display-val'), fields.alloc ? fields.alloc + '%' : '', '—', true);
        }
        if (fields.work != null && $work.length) {
            $work.val(fields.work);
            _rrlSetDisplayVal($row.find('.rrl-col-work .rrl-display-val'), fields.work, '—', true);
        }

        if ($rpt.length) {
            if (fields.reportingTo > 0 && $rpt.find('option[value="' + fields.reportingTo + '"]').length) {
                $rpt.val(String(fields.reportingTo));
            } else if (fields.reportingToText) {
                var matchedRpt = false;
                $rpt.find('option').each(function () {
                    if (matchedRpt) return;
                    if (($(this).text() || '').toString().trim() === fields.reportingToText) {
                        $rpt.val($(this).val());
                        matchedRpt = true;
                    }
                });
            }
            try { if ($rpt.data('selectpicker')) $rpt.selectpicker('refresh'); } catch (e) { /* ignore */ }
        }
        if ($status.length) {
            if (fields.resourceStatus && $status.find('option[value="' + fields.resourceStatus + '"]').length) {
                $status.val(fields.resourceStatus);
            } else if (fields.resourceStatusText) {
                var matchedStatus = false;
                $status.find('option').each(function () {
                    if (matchedStatus) return;
                    if (($(this).text() || '').toString().trim() === fields.resourceStatusText) {
                        $status.val($(this).val());
                        matchedStatus = true;
                    }
                });
            }
            try { if ($status.data('selectpicker')) $status.selectpicker('refresh'); } catch (e) { /* ignore */ }
        }
        if ($resp.length) $resp.val(fields.responsibility || '');
        if ($bill.length) $bill.prop('checked', !!fields.isResourceBillable);
        if ($approver.length) $approver.prop('checked', !!fields.isDefaultApprover);
        if ($po.length) $po.prop('checked', !!fields.isProductOwner);

        var rptVal = fields.reportingToText || ($rpt.find('option:selected').text() || '').toString().trim();
        if (!rptVal || rptVal.toLowerCase() === 'select reporting to') {
            rptVal = ($row.find('.rrl-col-rpt .rrl-display-val').text() || '—').toString().trim() || '—';
        }
        _rrlSetDisplayVal($row.find('.rrl-col-rpt .rrl-display-val'), rptVal);

        var statusVal = fields.resourceStatusText || ($status.find('option:selected').text() || '').toString().trim();
        _rrlSetDisplayVal($row.find('.rrl-col-status .rrl-display-val'), statusVal);

        _rrlSetRespDisplayVal($row.find('.rrl-col-resp .rrl-display-val'), fields.responsibility || '');

        $row.find('.rrl-col-bill .rrl-display-icon').html(
            fields.isResourceBillable
                ? '<i class="fas fa-check-circle" style="color:#16a34a;"></i>'
                : '<i class="fas fa-times-circle" style="color:#dc2626;"></i>'
        );
        $row.find('.rrl-col-approver .rrl-display-icon').html(
            fields.isDefaultApprover
                ? '<i class="fas fa-check-circle" style="color:#16a34a;"></i>'
                : '<i class="fas fa-times-circle" style="color:#dc2626;"></i>'
        );
        if ($po.length) {
            $row.find('.rrl-col-product-owner .rrl-display-icon').html(
                fields.isProductOwner
                    ? '<i class="fas fa-check-circle" style="color:#16a34a;"></i>'
                    : '<i class="fas fa-times-circle" style="color:#dc2626;"></i>'
            );
        }

        var appliedRptId = parseInt($rpt.val(), 10) || fields.reportingTo || 0;
        var appliedStatus = ($status.val() || fields.resourceStatus || '').toString().trim();
        $row.attr({
            'data-reporting-to': appliedRptId,
            'data-resource-status': appliedStatus,
            'data-billable': fields.isResourceBillable ? '1' : '0',
            'data-default-approver': fields.isDefaultApprover ? '1' : '0',
            'data-product-owner': fields.isProductOwner ? '1' : '0'
        });
    }

    function updateRrlOffcanvasDetails() {
        var rowKey = window._rrlOcActiveRowKey;
        var gid = window._rrlOcActiveGid;
        if (!rowKey || !gid) return;

        window._rrlSaveFromWhere = 'OffCanvas';

        if (!editAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionSave);
            return;
        }

        var $row = $('tr[data-row-key="' + rowKey + '"]');
        if (!$row.length) return;
        if (!$row.hasClass('rrl-row-editing')) return;

        var fields = _rrlReadOffcanvasEditForm();
        var validationMsg = _rrlValidateOcListFields(fields);
        if (validationMsg) {
            showRrlValidation(gid, validationMsg, null, 'OffCanvas');
            return;
        }

        function _completeRrlOffcanvasSave() {
            _rrlApplyOffcanvasFieldsToRow($row, rowKey, fields);
            _rrlUpdateRowPersistedEditableAttrs($row);

            var $chk = $row.find('.rrl-row-check');
            if ($chk.length && !$chk.prop('checked')) $chk.prop('checked', true);

            clearRrlValidation(gid);
            clearRrlOcValidation();
            var built = _buildRrlSavePayloadForRow($row, gid);
            if (!built.ok) {
                showRrlValidation(gid, built.message, built.$focus, 'OffCanvas');
                return;
            }

            var ocWorkBudget = _validateRrlBatchWorkHoursBudget(gid, [built.item]);
            if (!ocWorkBudget.ok) {
                showRrlValidation(gid, ocWorkBudget.message, built.$focus, 'OffCanvas');
                return;
            }

            var $ocBtn = $('#btnRrlOcUpdate');
            var oldOcHtml = $ocBtn.html();
            _rrlValidateAndSaveDefaultApproverThenSave(gid, [built.item], {
                fromWhere: 'OffCanvas',
                triggerBtn: $ocBtn,
                oldBtnHtml: oldOcHtml,
                refreshGrid: false,
                onSuccess: function () {
                    _closeRrlAllocationDetailOffcanvas();
                    _rrlRefreshGridAfterSaveSuccess(gid);
                }
            });
        }

        _completeRrlOffcanvasSave();
    }

    /* Added By Dipali V On 5th Jun 2026 — Reallocation compact list: show full row details in offcanvas (read from existing row DOM) */
    function openRrlAllocationDetail(rowKey, gid) {
        var $row = $('tr[data-row-key="' + rowKey + '"]');
        if (!$row.length) $row = $('#btn-rrl-edit-' + rowKey).closest('tr');
        if (!$row.length) return;

        window._rrlOcActiveRowKey = rowKey;
        window._rrlOcActiveGid = gid;

        function _disp(sel) {
            var t = ($row.find(sel).first().text() || '').toString().trim();
            return t || '—';
        }
        function _yesNo($cell) {
            return $cell.find('.fa-check-circle').length ? 'Yes' : 'No';
        }

        var resName = ($row.attr('data-resource-name') || $row.find('.rrl-hidden-name').first().text().trim() || _disp('.rrl-col-name strong') || '—').toString().trim() || '—';
        $('#rrlOcName').text(resName);
        $('#rrlOcRole').text(_rrlGetRoleDisplayVal($row));

        var $viewWrap = $('#rrlOcViewWrap');
        var $editWrap = $('#rrlOcEditWrap');
        /* Edit offcanvas panel exists only when m_blnEditAccess — always use read-only view otherwise */
        var isRowEditing = editAccess && $row.hasClass('rrl-row-editing') && $editWrap.length;
        _rrlDestroyOcSelectpickers();

        if (isRowEditing) {
            $viewWrap.addClass('d-none');
            $editWrap.removeClass('d-none');
            _rrlRenderOffcanvasEditForm($row, rowKey);
        } else {
            if ($editWrap.length) $editWrap.addClass('d-none');
            $viewWrap.removeClass('d-none');

            var rows = [
                [RES.C_ProjectRole, _rrlGetRoleDisplayVal($row)],
                [RES.C_StartDateHeader, _rrlGetListViewFieldForOffcanvas($row, 'start')],
                [RES.C_EndDateHeader, _rrlGetListViewFieldForOffcanvas($row, 'end')],
                [RES.C_PercentAllocation, _rrlGetListViewFieldForOffcanvas($row, 'alloc')],
                [RES.C_WorkHHMM, _rrlGetListViewFieldForOffcanvas($row, 'work')],
                [RES.C_ResourceName, resName],
                [RES.C_ReportingTo, _disp('.rrl-col-rpt .rrl-display-val')],
                [RES.C_ResourceStatus, _disp('.rrl-col-status .rrl-display-val')],
                [RES.C_Responsibilities, _disp('.rrl-col-resp .rrl-display-val')],
                [RES.C_Billable, _yesNo($row.find('.rrl-col-bill .rrl-display-icon'))],
                [RES.C_IsDefaultApprover, _yesNo($row.find('.rrl-col-approver .rrl-display-icon'))]
            ];
            if (_isAgileProjectForProductOwner()) {
                rows.push([RES.C_IsProductOwner, _yesNo($row.find('.rrl-col-product-owner .rrl-display-icon'))]);
            }
            var html = '';
            rows.forEach(function (pair) {
                var valHtml = (pair[0] === RES.C_Responsibilities) ? _rrlRespOffcanvasCellHtml($row) : escHtml(pair[1]);
                html += '<tr><th scope="row">' + escHtml(pair[0]) + '</th><td>' + valHtml + '</td></tr>';
            });
            $('#rrlOcDetailBody').html(html);
        }

        /* Hide row tooltips before offcanvas opens — avoids BS5 _isWithActiveTrigger errors */
        $row.find('[data-bs-toggle="tooltip"]').each(function () { _hideBootstrapTooltip(this); });

        var ocEl = document.getElementById('rrlAllocationDetailOffcanvas');
        if (ocEl) {
            var ocInst = bootstrap.Offcanvas.getOrCreateInstance(ocEl);
            var onOcShown = function () {
                ocEl.removeEventListener('shown.bs.offcanvas', onOcShown);
                if (typeof reinitTooltips === 'function') reinitTooltips();
            };
            ocEl.addEventListener('shown.bs.offcanvas', onOcShown);
            ocInst.show();
        }
    }

    /* Added by Nikhil Mane on 06-May-2026 — Row-wise Edit toggle for Allocated Resources table.
       Clicking the pencil icon switches a row between read-only display and editable fields.
       Clicking again (Save) reverts the icon back to view mode (data is held in controls for
       any subsequent save-to-API integration). */
    function toggleRrlRowEdit(btn, rowKey) {
        if (!editAccess) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(RES.A_NoPermissionSave);
            return;
        }
        var $btn = $(btn);
        var $row = $btn.closest('tr');
        if (!_isRrlResourceActiveFromRow($row)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(_rrlInactiveResourceEditMessage());
            return;
        }
        var isEditing = $row.hasClass('rrl-row-editing');
        function _setRrlRestrictedEditMode(enable) {
            var $role = $row.find('#rrl-role-' + rowKey);
            var $start = $row.find('#rrl-start-' + rowKey);
            var $end = $row.find('#rrl-end-' + rowKey);
            var $rpt = $row.find('#rrl-rpt-' + rowKey);
            var $status = $row.find('#rrl-status-' + rowKey);
            var $work = $row.find('#rrl-work-' + rowKey);
            var $resp = $row.find('#rrl-resp-' + rowKey);
            var $bill = $row.find('#rrl-bill-' + rowKey);
            var $approver = $row.find('#rrl-approver-' + rowKey);
            var $alloc = $row.find('#rrl-alloc-' + rowKey);
            var $startWrap = $start.closest('.rrl-date-wrap');
            var $endWrap = $end.closest('.rrl-date-wrap');
            var $startCal = $startWrap.find('.rrl-cal-btn');
            var $endCal = $endWrap.find('.rrl-cal-btn');

            $start.prop('readonly', true).prop('disabled', false);
            $end.prop('readonly', true).prop('disabled', false);

            if (enable) {
                /* Reallocation list edit: Start Date, End Date, Allocation %, Work Hours only; Project Role read-only. */
                $role.prop('disabled', true).addClass('rrl-field-locked');
                try { if ($role.data('selectpicker')) $role.selectpicker('disable'); } catch (e) { /* ignore */ }
                $rpt.prop('disabled', true).addClass('rrl-field-locked');
                $status.prop('disabled', true).addClass('rrl-field-locked');
                $resp.prop('readonly', true).addClass('rrl-field-locked');
                $bill.prop('disabled', true);
                $approver.prop('disabled', true);

                $startWrap.addClass('rrl-field-editable').removeClass('rrl-field-locked');
                $startCal.prop('disabled', false);
                $endWrap.addClass('rrl-field-editable').removeClass('rrl-field-locked');
                $endCal.prop('disabled', false);

                $alloc.prop('readonly', false).prop('disabled', false)
                    .addClass('rrl-alloc-editable').removeClass('rrl-field-locked');
                $work.prop('readonly', false).prop('disabled', false)
                    .addClass('rrl-work-editable').removeClass('rrl-field-locked');
            } else {
                try { if ($role.data('selectpicker')) $role.selectpicker('enable'); } catch (e) { /* ignore */ }
                $role.prop('disabled', false).removeClass('rrl-field-locked');
                $rpt.prop('disabled', false).removeClass('rrl-field-locked');
                $status.prop('disabled', false).removeClass('rrl-field-locked');
                $work.prop('readonly', false).removeClass('rrl-field-locked');
                $resp.prop('readonly', false).removeClass('rrl-field-locked');
                $bill.prop('disabled', false);
                $approver.prop('disabled', false);

                $startWrap.removeClass('rrl-field-locked rrl-field-editable');
                $endWrap.removeClass('rrl-field-locked rrl-field-editable');
                $endCal.prop('disabled', false);

                $alloc.removeClass('rrl-alloc-editable rrl-field-locked');
                $work.removeClass('rrl-work-editable rrl-field-locked');
            }
            try {
                if ($role.data('selectpicker')) $role.selectpicker('refresh');
                if ($rpt.data('selectpicker')) $rpt.selectpicker('refresh');
                if ($status.data('selectpicker')) $status.selectpicker('refresh');
            } catch (e) { /* ignore */ }
        }

        if (!isEditing) {
            /* Added By Dipali V On 17th Jun 2026 — allow multiple rows in edit mode; do not auto-cancel first edited row when editing another row */
            /* Enter edit mode */
            _updateRrlExtendNoteVisibility();
            $row.addClass('rrl-row-editing');
            $row.closest('table.rrl-table').addClass('rrl-editing-active');
            $row.data('rrl-orig-state', {
                startVal: ($('#rrl-start-' + rowKey).val() || '').toString().trim(),
                endVal: ($('#rrl-end-' + rowKey).val() || '').toString().trim(),
                allocVal: ($('#rrl-alloc-' + rowKey).val() || '').toString().trim(),
                workVal: ($('#rrl-work-' + rowKey).val() || '').toString().trim()
            });
            var _isCompactRrl = $row.closest('table.rrl-compact-list').length > 0;
            /* Added by Nikhil Mane on 06-May-2026 — activate searchable dropdowns in edit mode */
            initRrlEditSelectpickers($row);
            /* Ensure Reporting To is preselected in edit mode (skip on compact list — offcanvas fields are not edited inline) */
            var $rptSel = $row.find('#rrl-rpt-' + rowKey);
            if (!_isCompactRrl && $rptSel.length) {
                var rptIdFromRow = parseInt($row.attr('data-reporting-to'), 10) || 0;
                var rptDisplay = ($row.find('#rrl-rpt-' + rowKey).prev('.rrl-display-val').text() || '').toString().trim();
                function _normRrlName(v) {
                    return (v || '')
                        .toString()
                        .replace(/\u2026/g, '...')
                        .replace(/\.\.\.$/, '')
                        .trim()
                        .toLowerCase();
                }
               // _rebuildRrlReportingToSelect($rptSel, rptIdFromRow, rptDisplay);
                try {
                    if ($rptSel.data('selectpicker')) $rptSel.selectpicker('refresh');
                } catch (e) { /* ignore */ }
                if (rptIdFromRow > 0 && $rptSel.find('option[value="' + rptIdFromRow + '"]').length) {
                    $rptSel.val(String(rptIdFromRow));
                } else if (rptDisplay) {
                    var matched = false;
                    $rptSel.find('option').each(function () {
                        if (matched) return;
                        var txt = ($(this).text() || '').toString().trim();
                        var valNum = parseInt($(this).val(), 10) || 0;
                        if ((rptIdFromRow > 0 && valNum === rptIdFromRow) ||
                            (_normRrlName(txt) === _normRrlName(rptDisplay))) {
                            $rptSel.val($(this).val());
                            matched = true;
                        }
                    });
                }
                try { $rptSel.selectpicker('refresh'); } catch (e) { /* ignore */ }
            }
            $btn.addClass('editing');
            _setBsTooltip(btn, 'Save changes');
            $btn.html('<i class="fas fa-check"></i>');
            /* Initialise datepickers for start/end fields when entering edit mode */
            var startId = 'rrl-start-' + rowKey;
            var endId = 'rrl-end-' + rowKey;
            initRrlDatepicker(startId);
            initRrlDatepicker(endId);
            _setRrlRestrictedEditMode(true);
            /* Re-sync scrollbar mirror — inputs widen the table, mirror must catch up */
            var _editGid = ($row.closest('tbody').attr('id') || '').replace('rrl-tbody-', '');
            if (_editGid) { setTimeout(function () { _rrlSyncScrollTop(_editGid); }, 60); }
        } else {
            var _orig = $row.data('rrl-orig-state') || {};
            var _curStart = ($('#rrl-start-' + rowKey).val() || '').toString().trim();
            var _curEnd = ($('#rrl-end-' + rowKey).val() || '').toString().trim();
            var _curAllocText = ($('#rrl-alloc-' + rowKey).val() || '').toString().replace('%', '').trim();
            var _curWork = ($('#rrl-work-' + rowKey).val() || '').toString().trim();
            var _isCompactRrlSave = $row.closest('table.rrl-compact-list').length > 0;

            /* Reallocation tab: same validation + save path as header Save (checked rows) */
            if (_isCompactRrlSave) {
                var _saveGidCompact = ($row.closest('tbody').attr('id') || '').replace('rrl-tbody-', '');
                var built = _buildRrlSavePayloadForRow($row, _saveGidCompact);
                if (!built.ok) {
                    if (built.$focus && built.$focus.length) markRrlControl(built.$focus);
                    showRrlValidation(_saveGidCompact, built.message, built.$focus, 'ListView');
                    return;
                }
                if (!_rrlInlineEditChanged(_orig, _curStart, _curEnd, _curAllocText, _curWork)) {
                    _rrlCommitRowListViewDisplay($row, _saveGidCompact, { exitEdit: true });
                    _setRrlRestrictedEditMode(false);
                    $row.removeData('rrl-orig-state');
                    return;
                }
                _saveRrlRowsCore(_saveGidCompact, $row, {
                    fromWhere: 'ListView',
                    triggerBtn: $btn,
                    oldBtnHtml: '<i class="fas fa-check"></i>',
                    refreshGrid: false,
                    sourceRow: $row,
                    onSuccess: function () {
                        _rrlRefreshGridAfterSaveSuccess(_saveGidCompact);
                    }
                });
                return;
            }

            var _curAlloc = _parseIntegerAllocation(_curAllocText);
            var _startApi = rrlDateToApi(_curStart);
            var _endApi = rrlDateToApi(_curEnd);
            var _editValidationMsg = '';
            var $editValidationFocus = null;
            if (!_curStart) {
                _editValidationMsg = RES.A_PlannedStartNotBlank;
                $editValidationFocus = $('#rrl-start-' + rowKey);
            } else if (!_startApi) {
                _editValidationMsg = RES.A_StartDateValid;
                $editValidationFocus = $('#rrl-start-' + rowKey);
            } else if (!_curEnd) {
                _editValidationMsg = RES.A_PlannedEndNotBlank;
                $editValidationFocus = $('#rrl-end-' + rowKey);
            } else if (!_endApi) {
                _editValidationMsg = RES.A_PlannedEndDateNotValid;
                $editValidationFocus = $('#rrl-end-' + rowKey);
            } else if (_startApi > _endApi) {
                _editValidationMsg = RES.A_PlannedStartBeforeOrEqualEnd;
                $editValidationFocus = $('#rrl-start-' + rowKey);
            } else if (!_curAllocText) {
                _editValidationMsg = RES.A_AllocationPctBlank;
                $editValidationFocus = $('#rrl-alloc-' + rowKey);
            } else if (_isAllocationDecimalInvalid(_curAllocText)) {
                _editValidationMsg = _allocationPctNoDecimalMsg();
                $editValidationFocus = $('#rrl-alloc-' + rowKey);
            } else if (isNaN(_curAlloc) || _curAlloc < 1 || _curAlloc > _maxAllocPct) {
                _editValidationMsg = _resFmt(RES.A_AllocationPctBetween, _maxAllocPct);
                $editValidationFocus = $('#rrl-alloc-' + rowKey);
            } else if (!_curWork) {
                _editValidationMsg = RES.A_WorkNotBlank;
                $editValidationFocus = $('#rrl-work-' + rowKey);
            } else if (!_isValidRrlWorkValue(_curWork)) {
                _editValidationMsg = RES.A_WorkHHMMInvalid;
                $editValidationFocus = $('#rrl-work-' + rowKey);
            } else {
                var _editWorkDec = _hhmmToDecimal(_curWork);
                var _editGidForWork = ($row.closest('tbody').attr('id') || '').replace('rrl-tbody-', '');
                var _editPerId = parseInt($row.attr('data-project-employee-role-id'), 10) || 0;
                if (_editWorkDec != null && _wouldExceedProjectWorkHoursCap(_editWorkDec, {
                    gid: _editGidForWork,
                    excludeProjectEmployeeRoleId: _editPerId
                })) {
                    _editValidationMsg = _projectWorkHoursExceededMessage();
                    $editValidationFocus = $('#rrl-work-' + rowKey);
                }
            }
            if (_editValidationMsg) {
                var _rrlGid = ($row.closest('tbody').attr('id') || '').replace('rrl-tbody-', '');
                var $focusCtrl = $editValidationFocus || $('#rrl-end-' + rowKey);
                if (_rrlGid) {
                    showRrlValidation(_rrlGid, _editValidationMsg, $focusCtrl);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(_editValidationMsg);
                    _ensureValidationControlVisibleAndFocus($focusCtrl[0]);
                }
                return;
            }
            /* Exit edit mode — commit values back to display spans */
            var startVal = _fmtDisplayDate($('#rrl-start-' + rowKey).val());
            _rrlSetDisplayVal($row.find('#rrl-start-' + rowKey).closest('td').find('.rrl-display-val'), startVal, '—', true);

            /* Planned End Date */
            var endVal = _fmtDisplayDate($('#rrl-end-' + rowKey).val());
            _rrlSetDisplayVal($row.find('#rrl-end-' + rowKey).closest('td').find('.rrl-display-val'), endVal, '—', true);

            /* % Allocation */
            var allocVal = $('#rrl-alloc-' + rowKey).val();
            _rrlSetDisplayVal($row.find('#rrl-alloc-' + rowKey).closest('td').find('.rrl-display-val'), allocVal ? allocVal + '%' : '', '—', true);

            /* Work (HH:MM) */
            var workVal = decimalToHHMM(($('#rrl-work-' + rowKey).val() || '').toString().trim());
            if (workVal) $('#rrl-work-' + rowKey).val(workVal);
            _rrlSetDisplayVal($row.find('#rrl-work-' + rowKey).closest('td').find('.rrl-display-val'), workVal, '—', true);

            /* Planned Start Date */
            var roleVal = $('#rrl-role-' + rowKey + ' option:selected').text().trim();
            _rrlSetDisplayVal($row.find('td.rrl-col-role > .rrl-display-val').first(), roleVal);

            /* Reporting To */
            var $rptEditSel = $('#rrl-rpt-' + rowKey);
            var priorRptId = parseInt($row.attr('data-reporting-to'), 10) || 0;
            var rptDisplayCurrent = ($row.find('[id^="rrl-rpt-' + rowKey + '"]').prev('.rrl-display-val').text() || '').toString().trim();
            var rptIdSaved = parseInt($rptEditSel.val(), 10) || 0;

            /* Fallback 1: if dropdown lost value, resolve by displayed name */
            if (!rptIdSaved && rptDisplayCurrent) {
                function _normRrlName(v) {
                    return (v || '')
                        .toString()
                        .replace(/\u2026/g, '...')
                        .replace(/\.\.\.$/, '')
                        .trim()
                        .toLowerCase();
                }
                $rptEditSel.find('option').each(function () {
                    if (rptIdSaved) return;
                    var txt = ($(this).text() || '').toString().trim();
                    var val = parseInt($(this).val(), 10) || 0;
                    if (val > 0 && _normRrlName(txt) === _normRrlName(rptDisplayCurrent)) {
                        rptIdSaved = val;
                        $rptEditSel.val(String(val));
                    }
                });
            }
            /* Fallback 2: keep previous row value instead of overwriting to 0 */
            if (!rptIdSaved && priorRptId > 0) {
                rptIdSaved = priorRptId;
                if ($rptEditSel.find('option[value="' + priorRptId + '"]').length) {
                    $rptEditSel.val(String(priorRptId));
                }
            }
            try { $rptEditSel.selectpicker('refresh'); } catch (e) { /* ignore */ }

            var rptVal = ($rptEditSel.find('option:selected').text() || '').toString().trim();
            if (!rptVal || rptVal.toLowerCase() === 'select reporting to') {
                rptVal = rptDisplayCurrent || '—';
            }
            $row.attr('data-reporting-to', rptIdSaved);
            _rrlSetDisplayVal($row.find('[id^="rrl-rpt-' + rowKey + '"]').prev('.rrl-display-val'), rptVal);

            /* Resource Status */
            var statusVal = $('#rrl-status-' + rowKey + ' option:selected').text().trim();
            _rrlSetDisplayVal($row.find('[id^="rrl-status-' + rowKey + '"]').prev('.rrl-display-val'), statusVal);

            /* Responsibilities — show blank when empty, not em-dash or mojibake */
            var respVal = _cleanRrlText($('#rrl-resp-' + rowKey).val());
            $('#rrl-resp-' + rowKey).val(respVal);
            _rrlSetRespDisplayVal($row.find('#rrl-resp-' + rowKey).closest('td').find('.rrl-display-val'), respVal);

            /* Billable icon */
            var isBill = document.getElementById('rrl-bill-' + rowKey) && document.getElementById('rrl-bill-' + rowKey).checked;
            $row.find('#rrl-bill-' + rowKey).closest('td').find('.rrl-display-icon')
                .html(isBill ? '<i class="fas fa-check-circle" style="color:#16a34a;"></i>' : '<i class="fas fa-times-circle" style="color:#dc2626;"></i>');

            /* Is Default Approver icon */
            var isApprover = document.getElementById('rrl-approver-' + rowKey) && document.getElementById('rrl-approver-' + rowKey).checked;
            $row.find('#rrl-approver-' + rowKey).closest('td').find('.rrl-display-icon')
                .html(isApprover ? '<i class="fas fa-check-circle" style="color:#16a34a;"></i>' : '<i class="fas fa-times-circle" style="color:#dc2626;"></i>');

            $row.removeClass('rrl-row-editing');
            var $table = $row.closest('table.rrl-table');
            if ($table.find('tbody tr.rrl-row-editing').length === 0) {
                $table.removeClass('rrl-editing-active');
            }
            _setRrlRestrictedEditMode(false);
            $btn.removeClass('editing');
            _setBsTooltip(btn, 'Edit this row');
            $btn.html('<i class="fas fa-pencil-alt"></i>');
            /* Re-sync scrollbar mirror — inputs collapsed, mirror must shrink back */
            var _saveGid = ($row.closest('tbody').attr('id') || '').replace('rrl-tbody-', '');
            if (_saveGid) {
                setTimeout(function () {
                    _rrlSyncScrollTop(_saveGid);
                    _rrlApplyTruncationTooltips(_saveGid);
                    reinitTooltips();
                }, 60);
                requestAnimationFrame(function () {
                    requestAnimationFrame(function () {
                        _rrlApplyTruncationTooltips(_saveGid);
                        reinitTooltips();
                    });
                });
            }
            $row.removeData('rrl-orig-state');
        }
    }
    /* End of Added by Nikhil Mane on 06-May-2026 */

    /* Added by Nikhil Mane on 06-May-2026 — Initialises a jQuery UI datepicker on an RRL date input.
       Called lazily when Edit mode is entered so datepickers are not created for every row on render. */
    function initRrlDatepicker(inputId) {
        var $el = $('#' + inputId);
        if (!$el.length) return;
        if (!$el.data('display-dp-init')) {
            _applyDisplayDatepicker($el);
        }
        _syncDateInputDisplay($el);
    }
    /* End of Added by Nikhil Mane on 06-May-2026 */
    function _rrlGetSelectableTotal(gid) {
        var totalRecords = parseInt((_rrlState[gid] && _rrlState[gid].totalRecords) || 0, 10) || 0;
        var inactiveMap = _rrlInactiveByGroup[gid] || {};
        var inactiveCount = 0;
        for (var k in inactiveMap) {
            if (inactiveMap.hasOwnProperty(k)) inactiveCount++;
        }
        var selectable = totalRecords - inactiveCount;
        return selectable > 0 ? selectable : 0;
    }

    /* Added 25-May-2026 — count selected allocated resources across all pages for a group */
    function _rrlGetSelectedCount(gid) {
        if (_rrlSelectAllActiveByGroup[gid]) {
            var total = _rrlGetSelectableTotal(gid);
            var unselectedMap = _rrlUnselectedByGroup[gid] || {};
            var unselectedCount = 0;
            for (var k in unselectedMap) {
                if (unselectedMap.hasOwnProperty(k)) unselectedCount++;
            }
            var selected = total - unselectedCount;
            return selected > 0 ? selected : 0;
        }
        var map = _rrlSelectedByGroup[gid];
        if (!map) return 0;
        var count = 0;
        for (var key in map) {
            if (map.hasOwnProperty(key)) count++;
        }
        return count;
    }

    /* Added 25-May-2026 — persist current page row checks before paginating away */
    function _rrlSyncPageSelectionFromDom(gid) {
        if (_rrlSelectAllActiveByGroup[gid]) {
            if (!_rrlUnselectedByGroup[gid]) _rrlUnselectedByGroup[gid] = {};
            $('#rrl-tbody-' + gid + ' tr').each(function () {
                var perId = parseInt($(this).attr('data-project-employee-role-id'), 10) || 0;
                if (!perId) return;
                var checked = $(this).find('.rrl-row-check').prop('checked') === true;
                if (checked) delete _rrlUnselectedByGroup[gid][perId];
                else _rrlUnselectedByGroup[gid][perId] = true;
            });
            return;
        }
        if (!_rrlSelectedByGroup[gid]) _rrlSelectedByGroup[gid] = {};
        $('#rrl-tbody-' + gid + ' tr').each(function () {
            var perId = parseInt($(this).attr('data-project-employee-role-id'), 10) || 0;
            if (!perId) return;
            if ($(this).find('.rrl-row-check').prop('checked')) {
                _rrlSelectedByGroup[gid][perId] = true;
            } else {
                delete _rrlSelectedByGroup[gid][perId];
            }
        });
    }

    /* Added 25-May-2026 — row checkbox change: track selection across pages, update header */
    function onRrlRowCheck(checkbox, gid) {
        var $tr = $(checkbox).closest('tr');
        if ($(checkbox).prop('disabled') || !_isRrlResourceActiveFromRow($tr)) {
            checkbox.checked = false;
            return;
        }
        var perId = parseInt($tr.attr('data-project-employee-role-id'), 10) || 0;
        if (!perId) return;
        if (!_rrlSelectedByGroup[gid]) _rrlSelectedByGroup[gid] = {};
        if (!_rrlUnselectedByGroup[gid]) _rrlUnselectedByGroup[gid] = {};
        if (_rrlSelectAllActiveByGroup[gid]) {
            if (checkbox.checked) delete _rrlUnselectedByGroup[gid][perId];
            else _rrlUnselectedByGroup[gid][perId] = true;
        }
        if (!_rrlSelectAllActiveByGroup[gid] && checkbox.checked) {
            _rrlSelectedByGroup[gid][perId] = true;
            var totalNow = parseInt((_rrlState[gid] && _rrlState[gid].totalRecords) || 0, 10) || 0;
            if (totalNow > 0 && _rrlGetSelectedCount(gid) >= totalNow) {
                _rrlSelectAllActiveByGroup[gid] = true;
                _rrlSelectedByGroup[gid] = {};
                _rrlUnselectedByGroup[gid] = {};
            }
        } else if (!_rrlSelectAllActiveByGroup[gid]) {
            delete _rrlSelectedByGroup[gid][perId];
            if ($tr.hasClass('rrl-row-editing')) {
                var rowKey = ($tr.attr('data-row-key') || '').toString();
                if (rowKey) {
                    var persisted = _getRrlRowPersistedEditable($tr);
                    if (persisted.start) $('#rrl-start-' + rowKey).val(persisted.start);
                    if (persisted.end) $('#rrl-end-' + rowKey).val(persisted.end);
                    if (persisted.alloc) $('#rrl-alloc-' + rowKey).val(persisted.alloc);
                    if (persisted.work) $('#rrl-work-' + rowKey).val(persisted.work);
                    _rrlCommitRowListViewDisplay($tr, gid, { exitEdit: true });
                }
            }
        }
        updateRrlSelectAllState(gid);
    }

    function toggleRrlSelectAll(gid, checkbox) {
        //debugger;
        if (checkbox && checkbox.checked) {
            _rrlSelectAllResources(gid, true);
        } else {
            _rrlSelectAllResources(gid, false);
        }
    }

    /* Added 25-May-2026 — select/deselect all allocated resources (all API pages) for header checkbox */
    function _rrlSelectAllResources(gid, selectAll) {
        if (!selectAll) {
            _rrlSelectAllActiveByGroup[gid] = false;
            _rrlSelectedByGroup[gid] = {};
            _rrlUnselectedByGroup[gid] = {};
            $('#rrl-tbody-' + gid + ' .rrl-row-check').prop('checked', false);
            updateRrlSelectAllState(gid);
            return;
        }

        var state = _rrlState[gid];
        var projectId = parseInt(SessionProjectID, 10) || 0;
        var totalRecords = (state && state.totalRecords) || 0;
        var roleId = (state && state.roleId) || 0;
        if (!projectId || totalRecords <= 0) {
            $('#rrl-check-all-' + gid).prop('checked', false);
            return;
        }

        _rrlSelectAllActiveByGroup[gid] = true;
        _rrlUnselectedByGroup[gid] = {};
        var $master = $('#rrl-check-all-' + gid);
        $master.prop('disabled', true);

        _fetchRrlFromApi(projectId, 1, totalRecords, roleId, '',
            function (rows) {
                _rrlSelectedByGroup[gid] = {};
                for (var i = 0; i < (rows || []).length; i++) {
                    if (!_isRrlResourceActiveFromApiRow(rows[i])) continue;
                    var perId = parseInt(rows[i].projectEmployeeRoleID || rows[i].ProjectEmployeeRoleID
                        || rows[i].projectEmployeeRoleId || rows[i].ProjectEmployeeRoleId || 0, 10) || 0;
                    if (perId) _rrlSelectedByGroup[gid][perId] = true;
                }
                $master.prop('disabled', false).prop('checked', true).prop('indeterminate', false);
                $('#rrl-tbody-' + gid + ' .rrl-row-check:not(:disabled)').prop('checked', true);
                updateRrlSelectAllState(gid);
            },
            function () {
                _rrlSelectAllActiveByGroup[gid] = false;
                _rrlSelectedByGroup[gid] = {};
                _rrlUnselectedByGroup[gid] = {};
                $master.prop('disabled', false).prop('checked', false).prop('indeterminate', false);
                $('#rrl-tbody-' + gid + ' .rrl-row-check').prop('checked', false);
                updateRrlSelectAllState(gid);
            }
        );
    }
    /* Header checked only when all records (all pages) are selected — never indeterminate. */
    function updateRrlSelectAllState(gid) {
        var $header = $('#rrl-check-all-' + gid);
        if (!$header.length) return;

        var totalRecords = _rrlGetSelectableTotal(gid);
        var selectedCount = _rrlGetSelectedCount(gid);
        var allSelected = totalRecords > 0 && selectedCount >= totalRecords;
        if (allSelected) _rrlSelectAllActiveByGroup[gid] = true;

        $header.prop('indeterminate', false);
        if (_rrlSelectAllActiveByGroup[gid]) {
            $header.prop('checked', allSelected);
            return;
        }

        $header.prop('checked', false);
    }

    function rrlPrevPage(gid) {
        var state = _rrlState[gid];
        if (!state || state.page <= 1) return;
        /* Added 25-May-2026 — keep selections when moving to previous page */
        _rrlSyncPageSelectionFromDom(gid);
        _rrlFetchAndRenderPage(gid, state.roleId || 0, state.roleText || null, state.page - 1);
    }
    function rrlNextPage(gid) {
        var state = _rrlState[gid];
        if (!state) return;
        var totalPages = state.totalPages || Math.ceil((state.totalRecords || state.data.length) / state.size);
        if (state.page >= totalPages) return;
        /* Added 25-May-2026 — keep selections when moving to next page */
        _rrlSyncPageSelectionFromDom(gid);
        _rrlFetchAndRenderPage(gid, state.roleId || 0, state.roleText || null, state.page + 1);
    }
    /* End of Added by Nikhil Mane on 05-May-2026 */

    function updateSelectedResourcesBadge(gid) {
        var count = $('#sel-res-body-' + gid + ' tr').length;
        updateGroupDeleteBtn(gid, count);
        _syncBaRoleUnallocatedHighlight(gid);
    }

    // No-op: expand/collapse removed; RRL stays expanded by default.
    function toggleRrlSection(gid) { /* intentionally blank */ }

    /* Reallocation tab: build section, load grid, and refresh extension note when tab is shown */
    var tabReallocBtn = document.getElementById('tab-reallocation-btn');
    if (tabReallocBtn) {
        tabReallocBtn.addEventListener('shown.bs.tab', function () {
            _setReallocTabScrollMode(true);
            ensureReallocationTabSection();
            loadReallocationTabAllocatedResources(true);
            
        });
    }
    var tabBulkBtn = document.getElementById('tab-bulk-allocation-btn');
    if (tabBulkBtn) {
        tabBulkBtn.addEventListener('shown.bs.tab', function () {
            _setReallocTabScrollMode(false);
            refreshBulkAllocationTabData();
        });
    }
    _setReallocTabScrollMode($('#tabReallocation').hasClass('active') || $('#tabReallocation').hasClass('show'));
    $(window).on('resize.rrlBodyScroll', function () {
        if ($('#tabReallocation').hasClass('active') || $('#tabReallocation').hasClass('show')) {
            _rrlResizeBodyScroll(_REALLOC_TAB_GID);
        }
    });

    /* Refresh Reallocation grid after Allocate if that tab is open */
    (function () {
        var container = document.getElementById('bulkAllocationGroupsContainer');
        if (!container) return;
        new MutationObserver(function (mutations) {
            var shouldRefresh = false;
            mutations.forEach(function (m) {
                m.addedNodes.forEach(function (node) {
                    if (node.nodeType !== 1) return;
                    if (node.closest && node.closest('[id^="sel-res-body-"]')) shouldRefresh = true;
                });
            });
            if (!shouldRefresh) return;
            _markReallocationDirty();
        }).observe(container, { childList: true, subtree: true });
    })();

    /* Layered offcanvas lifecycle (parent: select, children: details/loading) */
    (function () {
        var selectEl = document.getElementById('selectResourceOffcanvas');
        var detailsEl = document.getElementById('resourceDetailsOffcanvas');
        var loadingEl = document.getElementById('resourceLoadingOffcanvas');
        if (!selectEl || !detailsEl || !loadingEl) return;

        /* Keep parent visible while a child is opening */
        selectEl.addEventListener('hide.bs.offcanvas', function (e) {
            if (_keepSelectVisibleForChild) {
                e.preventDefault();
                return false;
            }
        });

        /* Keep details visible while loading child opens over it */
        detailsEl.addEventListener('hide.bs.offcanvas', function (e) {
            if (_keepDetailsVisibleForChild) {
                e.preventDefault();
                return false;
            }
        });

        selectEl.addEventListener('shown.bs.offcanvas', function () {
            _ensureDefaultReportingToSelection();
            if (!_isAnyChildOffcanvasOpen()) {
                setOffcanvasParentBlur('selectResourceOffcanvas', false);
                setOffcanvasParentBlur('resourceDetailsOffcanvas', false);
            }
        });

        detailsEl.addEventListener('shown.bs.offcanvas', function () {
            _keepSelectVisibleForChild = false;
            _syncParentChildBlur();
        });
        loadingEl.addEventListener('shown.bs.offcanvas', function () {
            _keepSelectVisibleForChild = false;
            _keepDetailsVisibleForChild = false;
            _syncParentChildBlur();
        });

        detailsEl.addEventListener('hidden.bs.offcanvas', function () {
            _syncParentChildBlur();
        });
        loadingEl.addEventListener('hidden.bs.offcanvas', function () {
            _syncParentChildBlur();
        });

        /* If parent is intentionally closed, also close children and cleanup blur */
        selectEl.addEventListener('hidden.bs.offcanvas', function () {
            if (_isAnyChildOffcanvasOpen()) return;
            setOffcanvasParentBlur('selectResourceOffcanvas', false);
            setOffcanvasParentBlur('resourceDetailsOffcanvas', false);
            try { bootstrap.Offcanvas.getInstance(detailsEl) && bootstrap.Offcanvas.getInstance(detailsEl).hide(); } catch (e) { /* ignore */ }
            try { bootstrap.Offcanvas.getInstance(loadingEl) && bootstrap.Offcanvas.getInstance(loadingEl).hide(); } catch (e) { /* ignore */ }
        });

        /* Click child backdrop => close top child only */
        document.addEventListener('mousedown', function (e) {
            var t = e.target;
            if (!t || !t.classList || !t.classList.contains('offcanvas-backdrop')) return;
            if (!_isAnyChildOffcanvasOpen()) return;
            e.preventDefault();
            e.stopPropagation();
            _closeTopChildOffcanvas();
        }, true);

        /* Click dimmed parent offcanvas (left/behind child) => close top child */
        selectEl.addEventListener('mousedown', _handleLayeredOffcanvasParentClick, true);
        detailsEl.addEventListener('mousedown', _handleLayeredOffcanvasParentClick, true);
    })();
</script>
<%-- End of Role Resource List JS — Added by Nikhil Mane on 22-Apr-2026 --%>
</body>
</html>
