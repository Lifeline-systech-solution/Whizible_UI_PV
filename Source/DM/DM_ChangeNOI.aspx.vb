Imports CommonFunctions
Public Class DM_ChangeNOI
    Inherits WebPages.Template.WhizTemplate
    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected strComments As String = ""
    Protected strEmployeeID As String = ""
    Protected strActionID As String = ""
    Protected strInstanceID As String = ""
    Protected lngTagID As Long
    Protected intUniqueID As Integer
    Protected m_strMessage As String
    Protected m_strMode As String = ""
    Protected strNewNOIID As String = ""
    Protected NatureofDemand As String = ""
    Protected NewNatureofDemand As String = ""
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        MyBase.InitializeResources("AppResources.DM_ChangeNOI", "AppResources")

    End Sub

    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : Calls the private class ReportUI to generate the
        '                         UI for the report
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : June 22,2008
        ' Revisions             :
        '=====================================================================

        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

        MyBase.InitializeResources("AppResources.DM_ChangeNOI", "AppResources")

        Dim strSQL As String = ""
        'Dim strScript As String
        Dim dr As IDataReader
        Dim strPageName As String = ""
        Dim strPrimaryKeyName As String = ""
        Dim m_objGlobalObject As WebPages.Template.IGlobal

        InitializeVariables()

        CommonFunction.General.WriteHTML("<input Type=hidden id='txtUniqueID' name='txtUniqueID' value =" + intUniqueID.ToString + ">")
        CommonFunction.General.WriteHTML("<input Type=hidden id='txtTagID' name='txtTagID' value ='" + lngTagID.ToString + "'>")
        CommonFunction.General.WriteHTML("<input Type=hidden id='txtComments_hidden' name='txtComments_hidden' value ='" + NatureofDemand.ToString + "'>")

        Draw_Page()

        If m_strMode.ToUpper = "SAVE" Then

            strSQL = "usp_get_WorkflowDetails " + lngTagID.ToString + "," + intUniqueID.ToString + ",'SYS_SUBMIT'"
            dr = CommonFunction.Data.GetDataReader(strSQL, True)
            If (dr.Read) Then
                strInstanceID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("InstanceID"), ""), "").ToString()
                strActionID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ActionID"), ""), "").ToString()
                'strPageName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PageName"), ""), "").ToString()
            End If

            CommonFunction.Data.DisposeDataReader(dr)

            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_IM_attributedetails " + lngTagID.ToString, True)
            If (dr.Read) Then
                strPrimaryKeyName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PrimaryKeyName"), ""), "").ToString()
                strPageName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PageName"), ""), "").ToString()
            End If
            CommonFunction.Data.DisposeDataReader(dr)


            strSQL = "usp_upd_Change_Workflow " + lngTagID.ToString + "," + intUniqueID.ToString + " ,"
            strSQL = strSQL + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString + " ,'"
            strSQL = strSQL + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(Request.Form("txtComments"), "")) + "'"
            strSQL = strSQL + "," + strNewNOIID
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)

            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
            m_objGlobalObject = MyBase.GlobalObject

            CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, intUniqueID, "SYS_SUBMIT", lngTagID.ToString)
            CommonFunction.General.WriteHTML("<script language=javascript>" + vbCrLf)
            CommonFunction.General.WriteHTML(" window.close();" + vbCrLf)
            CommonFunction.General.WriteHTML("    refreshParent('frmCommonPage','CommonPage.aspx','" + strPageName + "&From=ChangeNOI&ParentTagID=0&" + strPrimaryKeyName + "_PK=" + intUniqueID.ToString + "');" + vbCrLf)
            CommonFunction.General.WriteHTML("</script>" + vbCrLf)

        End If

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : Jun 22 2008
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {"<Img Border=0 src='../../Images/cssImages/Link images/save.gif'>" + MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}  '+ MyBase.GetResourceString("MENU_HELP")
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()", "OpenHelpPage('" + MyBase.GetResourceString("WINDOW_TITLE") + "')", "cboNOI_onChange()"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu

    End Function
    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : Calls the private class ReportUI to generate the
        '                         UI for the report
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : Jun 22,2008
        ' Revisions             :
        '=====================================================================

        Dim strHtml As New System.Text.StringBuilder
        Dim strMenu As String = ""
        Dim drStage As IDataReader
        Dim strSQL As String = ""
        Dim strOrganizationUnit As String = ""
        Dim strProjectType As String = ""
        Dim strProjectName As String = ""
        Dim strTitle As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim strDeliverableType As String = ""
        Dim strChangeCategory As String = ""
        Dim strChangePriority As String = ""
        Dim strClass As String = ""
        Dim drEntityDetails As IDataReader
        Dim strcaption As String = ""

        Dim strSource As String = ""

        strSource = "usp_sel_tbl_IM_ProjectNatureOfDemand " + lngTagID.ToString + "," + intUniqueID.ToString + "," + CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0").ToString
        strSource = strSource + "," + CStr(HttpContext.Current.Session("intProjectID"))

        strMenu = DrawMenu()
        Response.Write(strMenu)
        strHtml.Append("<div ID=PageDiv style='overflow:auto;width:99.99%;height=99.9%'>") 'height:700px
        strHtml.Append("<div ID=DivUpper style='overflow:auto;width:99.99%;height:40%'>")
        strHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=2 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("WINDOW_TITLE").ToString + "</TD></TR></TABLE>" + vbCrLf)
        strHtml.Append("<TABLE CellSpacing=0 cellpadding=0 class='clsTable' width='99.9%' >" + vbCrLf)

        drEntityDetails = CommonFunction.Data.GetDataReader("usp_sel_EntityDetails_GenericWorkflowStatus NULL," + intUniqueID.ToString + "," + lngTagID.ToString, True)
        If drEntityDetails.Read() Then

            Select Case lngTagID.ToString
                Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING

                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ExpectedStartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ExpectedEndDate"), "")
                    strOrganizationUnit = CommonFunction.Data.CheckIsDBNull(drEntityDetails("Location"), "")
                    strProjectType = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectType"), "")
                    strcaption = "Project "

                Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("Milestone"), "")
                    strcaption = "Milestone "

                Case CommonFunction.Constants.APP_TAG_MODULES

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ModuleName"), "")
                    strcaption = "Module "

                Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangeRequestDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangeRequestSummary"), "")
                    strChangeCategory = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangeCategory"), "")
                    strChangePriority = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangePriority"), "")
                    strcaption = "Change Request "

                Case CommonFunction.Constants.APP_TAG_DELIVERABLES

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("Title"), "")
                    strDeliverableType = CommonFunction.Data.CheckIsDBNull(drEntityDetails("DeliverableType"), "")
                    strcaption = "Deliverable "

                Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("SubProjectName"), "")
                    strcaption = "Sub Project "

            End Select
        End If

        CommonFunction.Data.DisposeDataReader(drEntityDetails)

        ' Entity name
        strHtml.Append("<TR align=Left class='clsTREven'>")
        strHtml.Append("<td align=right><b>" + strcaption + "</b></td>")
        strHtml.Append(" <td align=left> &nbsp;" + vbCrLf)
        strHtml.Append(strTitle)
        strHtml.Append("</td>")
        strHtml.Append("</tr>")

        strHtml.Append("<TR align=Left class='clsTREven'>")
        strHtml.Append("<td align=right><b>" + MyBase.GetResourceString("CURRENT_NOI") + "</b></td>")
        strHtml.Append(" <td align=left> &nbsp;" + vbCrLf)
        'strHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtNatureofInitiative", "txtNatureofInitiative", , 200, , NatureofDemand, , , True, , , , , True))
        strHtml.Append(NatureofDemand)
        strHtml.Append("</td>")
        strHtml.Append("</tr>")

        ' R2
        strHtml.Append("<TR align=Left class='clsTREven'>")
        strHtml.Append("<td align=right><b>" + MyBase.GetResourceString("CHANGETO") + " </b></td>")
        strHtml.Append(" <td align=left> &nbsp;" + vbCrLf)
        strHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboProjectWorkflow", strSource, 300, strNewNOIID, "onchange='cboNOI_onChange()'", True, True, , True) + vbCrLf)
        strHtml.Append("</td>")
        strHtml.Append("</tr>")
        ' R3
        strHtml.Append("<tr align=Left class='clsTREven'>")
        strHtml.Append("<td align=right valign='top' > <b>" + MyBase.GetResourceString("RATIONALE") + " </b></td>")
        strHtml.Append(" <td align=left> &nbsp;" + vbCrLf)
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'strHtml.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Rationale", , , "frm_DM_ChangeNOI", , , 400, 80, 1000, strComments, returnHTML:=True, IsMandatory:=True))
        strHtml.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Rationale", , , "frm_DM_ChangeNOI", , , 400, 80, 1000, strComments, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        strHtml.Append("</td>")
        strHtml.Append("</tr>")

        strHtml.Append("</TABLE>")
        strHtml.Append("</DIV>")
        strHtml.Append("<DIV ID=DivLower style='overflow:auto;width:99.9%;height:59.99%;'>")

        If (m_strMode.ToUpper = "ONCHANGE" And strNewNOIID.ToString <> "") Then

            If strNewNOIID <> "" Then
                strSQL = "usp_sel_Workflow_stage_details " + lngTagID.ToString + "," + intUniqueID.ToString + "," + strNewNOIID.ToString
            End If

            drStage = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=2 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
            strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>'" + NewNatureofDemand + "' workflow Details </TD></TR></TABLE>" + vbCrLf)

            strHtml.Append("<Table id='tblGrid02182' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable' ><TR class='clsTRColumnHeader'>" + vbCrLf)
            strHtml.Append("<TD align='Left' width=5%>" + MyBase.GetResourceString("ORDER") + "</TD>" + vbCrLf)
            strHtml.Append("<TD align='Left' width=20%>" + MyBase.GetResourceString("STAGE") + "</TD>" + vbCrLf)
            strHtml.Append("<TD align='Left' width=75%>" + MyBase.GetResourceString("APPROVERS") + "</TD>" + vbCrLf)
            While drStage.Read
                strHtml.Append("<tr align=Left class='clsTREven'>")
                strHtml.Append("<td align='Left'>")
                strHtml.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStage("OrderNo"))))
                strHtml.Append("</td>")
                strHtml.Append("<td align='Left'>")
                strHtml.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStage("RequestStage"))))
                strHtml.Append("</td>")
                strHtml.Append("<td align='Left'>")
                strHtml.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStage("StakeHolderNames"))))
                strHtml.Append("</td>")
                strHtml.Append("</tr>")
            End While
            CommonFunction.Data.DisposeDataReader(drStage)

            strHtml.Append("</table>")
        End If

        strHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=1 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + MyBase.GetResourceString("CUREENTNOI_DETAILS") + "</TD></TR></TABLE>" + vbCrLf) '<BR>

        strHtml.Append("<Table id='tblGrid02182'  width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable' ><TR class='clsTRColumnHeader'>" + vbCrLf)
        strHtml.Append("<TD align='Left' width=5%>" + MyBase.GetResourceString("ORDER") + "</TD>" + vbCrLf)
        strHtml.Append("<TD align='Left' width=20% >" + MyBase.GetResourceString("STAGE") + "</TD>" + vbCrLf)
        strHtml.Append("<TD align='Left' width=75%>" + MyBase.GetResourceString("APPROVERS") + "</TD>" + vbCrLf)

        strSQL = "usp_sel_Workflow_stage_details " + lngTagID.ToString + "," + intUniqueID.ToString
        drStage = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        While drStage.Read
            strHtml.Append("<tr align=Left class='clsTREven'>")
            strHtml.Append("<td align='Left'>")
            strHtml.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStage("OrderNo"))))
            strHtml.Append("</td>")
            strHtml.Append("<td align='Left'>")
            strHtml.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStage("RequestStage"))))
            strHtml.Append("</td>")
            strHtml.Append("<td align='Left'>")
            strHtml.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStage("StakeHolderNames"))))
            strHtml.Append("</td>")
            strHtml.Append("</tr>")

        End While
        CommonFunction.Data.DisposeDataReader(drStage)

        strHtml.Append("</table>")


        ' strHtml.Append("</div>")
        strHtml.Append("</div>")
        strHtml.Append("</div>")
        CommonFunction.General.WriteHTML(strHtml.ToString)
        Response.Write("<br>" + strMenu)
        strHtml = Nothing
    End Sub
    Private Sub InitializeVariables()
        Dim strSQL As String = ""
        intUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "0")
        If intUniqueID = "0" Then
            intUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtUniqueID"), "0")
        End If
        strEmployeeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
        strInstanceID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intInstanceID"), "")
        lngTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagID"), "0")
        If lngTagID = "0" Then
            lngTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTagID"), "0")
        End If
        m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Mode"), " ")
        strNewNOIID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboProjectWorkflow"), ""), String)

        strSQL = "usp_sel_tbl_IM_ProjectNatureOfDemand " + lngTagID.ToString + "," + intUniqueID.ToString + "," + CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0").ToString + ",1"
        NatureofDemand = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)

        NewNatureofDemand = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NewNOI"), "0")


    End Sub
    Protected Overrides Sub Finalize()

        Try
            If IsNothing(m_objMenu) = False Then
                m_objMenu = Nothing
            End If

            If IsNothing(strComments) = False Then
                strComments = Nothing
            End If

            If IsNothing(strEmployeeID) = False Then
                strEmployeeID = Nothing
            End If

            If IsNothing(strActionID) = False Then
                strActionID = Nothing
            End If

            If IsNothing(strInstanceID) = False Then
                strInstanceID = Nothing
            End If

        Finally
            MyBase.Finalize()
        End Try
    End Sub

End Class
