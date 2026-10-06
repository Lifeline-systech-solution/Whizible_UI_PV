Public Partial Class DB_CustomerFieldLock
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

#Region "Gloabal Variables"
    Protected m_intCustomerID As Integer
    Private m_strAction As String = ""
    Protected m_intRowCount As Integer = 1
    Protected m_CurrentDate As Date
    Protected m_strNoteBy As String
    Protected m_strTagID As String
    Protected m_strUser As String
    Protected m_isActive As Integer = 0



#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

    End Sub
    Protected Sub initialize()
        m_intCustomerID = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "0").ToString)
        If m_intCustomerID = 0 Then
            m_intCustomerID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtEmployeeID"), "0")
        End If
        ''CommonFunction.HTMLControls.DrawTextBox("txtEmployeeID", "txtEmployeeID", value:=m_intCustomerID, IsHidden:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtEmployeeID", "txtEmployeeID", value:=m_intCustomerID, IsHidden:=True, EnableHTMLEncode:=True)

        m_strTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MasterTagID"), "0")
        If m_strTagID = 0 Then
            m_strTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTagID"), "0")
        End If
        ''CommonFunction.HTMLControls.DrawTextBox("txtTagID", "txtTagID", value:=m_strTagID, IsHidden:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtTagID", "txtTagID", value:=m_strTagID, IsHidden:=True, EnableHTMLEncode:=True)

        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If m_strAction = "" Then
            m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtAction"), "0")
        End If
        ''CommonFunction.HTMLControls.DrawTextBox("txtAction", "txtAction", value:=m_strAction, IsHidden:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtAction", "txtAction", value:=m_strAction, IsHidden:=True, EnableHTMLEncode:=True)
        m_strUser = HttpContext.Current.Session("strUserName").ToString()
    End Sub
    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""
        Dim objMenu As WebPage.Templates.StaticMenu

        'ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>Close")
        ArrMenuCaptionsList.Add("<Img src='../../Images/cssImages/Link images/close.gif'>Close")
        ArrMenuToolTipsList.Add("Close")
        ArrClientSideFunctionsList.Add("Close_click()")


        'ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        'ArrMenuToolTipsList.Add("Help")
        'ArrClientSideFunctionsList.Add("Help_OnClick('Grievances')")

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        objMenu = New WebPage.Templates.StaticMenu
        strMenu = objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        objMenu = Nothing
        Return strMenu
    End Function

    Protected Sub WritePage()
        Dim strMenu As String = ""
        initialize()
        'CommonFunctions.General.WriteHTML(InitializeMenu())
        m_CurrentDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select GetDate()", True), "")
        m_strNoteBy = HttpContext.Current.Session("intUserID").ToString()
        GetEmpDetails()
        'If Request.Params("FromXML") = "1" Then
        '    Response.Clear()
        '    'Response.Write(PerformActions)
        '    Response.End()
        'End If
        PerformActions()
        'CommonFunctions.General.WriteHTML("<DIV Id=divList Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        CommonFunctions.General.WriteHTML("<DIV Id=divList style='overflow:auto;width:100%;height:99.99'>")
        PlotList()
        CommonFunctions.General.WriteHTML("</DIV>")
    End Sub
    Protected Sub GetEmpDetails()
        Dim drRead As IDataReader
        Dim strSQL As String = ""
        Dim strBG As String = ""
        Dim strOU As String = ""
        Dim strRole As String = ""
        Dim sbHTML As New StringBuilder
        Dim strCustomerName As String = ""
        Dim strManager As String = ""

        'strQuery = "SELECT MAX(alertID) from tbl_pm_AlertLevel"

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "select customername from tbl_pm_customer where customer= " & m_intCustomerID
        strSQL = "usp_sel_tbl_PM_Customer_CustomerName '" & m_intCustomerID.ToString() & "'"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'drRead = CommonFunction.Data.GetDataReader(strSQL, True)
        'While drRead.Read
        'strBG = CommonFunction.Data.CheckIsDBNull(drRead("BusinessGroup"), "")
        'strOU = CommonFunction.Data.CheckIsDBNull(drRead("Location"), "")
        'strRole = CommonFunction.Data.CheckIsDBNull(drRead("RoleDescription"), "")
        strCustomerName = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "")
        'strManager = CommonFunction.Data.CheckIsDBNull(drRead("Manager"), "")
        'End While

        sbHTML.Append("")

        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<table width='100%' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRMenu'>")
        CommonFunctions.General.WriteHTML("<TD align=Right> | ")
        CommonFunctions.General.WriteHTML("<A HREF='Javascript:Close_click()' Title='close' >Close</A> |")
        CommonFunctions.General.WriteHTML("</td></tr></table>")


        Dim strCaption As String
        'If m_strTagID = 2690 Then
        strCaption = "Customer Field Logs"
        'Else
        'strCaption = "HR Corner"
        'End If
        sbHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, strCaption, "Customer: " & strCustomerName, , True))
        'sbHTML.Append("<br>")

        'sbHTML.Append("<table id='tblDtls' Style='overflow:auto;width:99.9%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")

        'sbHTML.Append("<tr class='clsTREven'>")
        'sbHTML.Append("<td align=right width=25%><b> Business Group : </b>")
        ''sbHTML.Append("<td align=left width=25%>" & strBG)
        'sbHTML.Append("<td align=right width=25%><b> Organization Unit : </b>")
        ''sbHTML.Append("<td align=left width=25%>" & strOU)
        'sbHTML.Append("</tr><tr class='clsTREven'>")
        'sbHTML.Append("<td align=right width=25%><b> Role : </b>")
        ''sbHTML.Append("<td align=left width=25%>" & strRole)
        'sbHTML.Append("<td align=right width=25%> <b>Manager : </b>")
        ''sbHTML.Append("<td align=left width=25%>" & strManager)
        'sbHTML.Append("</TR>")
        'sbHTML.Append("</Table><br>")

        CommonFunction.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing

    End Sub
    Protected Sub PlotList()
        Dim drRead As IDataReader
        Dim sbHTML As New StringBuilder
        Dim strManager As String
        Dim strNote As String
        Dim dtAdditionDate As DateTime
        Dim intGrievanceID As Integer
        Dim strDateobject As String
        Dim intExistscnt As Integer = 0
        Dim strSQL As String
        strSQL = "Usp_Sel_tbl_pm_FieldLogs  " & m_intCustomerID & "," & CType(CommonFunctions.General.CheckIsNothing(Session("intUserID"), "0"), String)
        drRead = CommonFunction.Data.GetDataReader(strSQL, True)

        intExistscnt = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select count(1) From tbl_pm_fieldLogS Where CustomerID = " & m_intCustomerID, True), 0)
        'm_isActive = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("If exists (Select 1 From tbl_PM_Employee Where status = 0 AND EmployeeID = " & m_intCustomerID & ") select 0 else select 1", True), 0)


        strDateobject = CommonFunctions.HTMLControls.DrawDateControl("AdditionDate" & m_intRowCount, "AdditionDate" & m_intRowCount, , , m_CurrentDate, , "frmGrievances", , , "readOnly", True, returnHTML:=True)
        sbHTML.Append("<table id='tblGrid' Style='overflow:auto;width:99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
        sbHTML.Append("<tr class='clsTROdd'>")
        sbHTML.Append("<td align=Left colspan=2><b>Note</b></td>")
        'sbHTML.Append("<td align=Left><b>Note</b></td>")
        sbHTML.Append("<td align=Right><b>Save</b></td>")
        sbHTML.Append("</tr>")

        If intExistscnt = 0 Then
            sbHTML.Append("<tr class='clsTROdd'>")
            sbHTML.Append("<td align=Left width=23%><br><b> By : </b>" & HttpContext.Current.Session("strUserName").ToString() & "<br><b> On : </b>" & strDateobject & "</td>")

            sbHTML.Append("<td align=left width=75%>")
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtNote" & m_intRowCount, "txtNote" & m_intRowCount, , "clsTextArea", , "frmGrievances", "", "", 600, 50, , , style:="  overflow-x: hidden;overflow-y:hidden;white-space: normal ", returnHTML:=True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtNote" & m_intRowCount, "txtNote" & m_intRowCount, , "clsTextArea", , "frmGrievances", "", "", 600, 50, , , style:="  overflow-x: hidden;overflow-y:hidden;white-space: normal ", returnHTML:=True, EnableHTMLEncode:=True))
            sbHTML.Append("</td>")
            'If m_isActive = 0 Then
            sbHTML.Append("<td width=3% valign=center align=center style='cursor:hand;'><A HREF=""Javascript:Save_OnClick(" & m_intRowCount & ")"" Title='Save'><Img Border=0 src='../../Images/cssImages/Link images/save.gif'></A></td>")
            'sbHTML.Append("<td width=3% valign=center align=center style='cursor:hand;'><A HREF=""Javascript:Delete_onClick()"" Title='Delete'><Img Border=0 src='../../Images/cssImages/Link images/delete.gif'></A></td>")
            'sbHTML.Append("<td width=3% valign=center align=center ></td>")
            'End If
        End If

        While drRead.Read
            m_intRowCount += 1
            intGrievanceID = CommonFunction.Data.CheckIsDBNull(drRead("FieldLogID"), 0)
            strManager = CommonFunction.Data.CheckIsDBNull(drRead("AddedBy"), "")
            strNote = CommonFunction.Data.CheckIsDBNull(drRead("Note"), "")
            dtAdditionDate = CommonFunction.Data.CheckIsDBNull(drRead("AddedON"), "")

            sbHTML.Append("<tr class='clsTREven' valign=center>")
            sbHTML.Append("<td align=Left> <b> By : </b>" & strManager & "<br><b> On : </b>" & dtAdditionDate & "</td>")
            'sbHTML.Append("<td align=left colspan=2>")
            sbHTML.Append("<td align=left>")
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPrimaryKey" + CStr(m_intRowCount), "txtPrimaryKey" + CStr(m_intRowCount), , , , intGrievanceID, "right", , , , , True, , True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPrimaryKey" + CStr(m_intRowCount), "txtPrimaryKey" + CStr(m_intRowCount), , , , intGrievanceID, "right", , , , , True, , True, EnableHTMLEncode:=True))
            If strManager = HttpContext.Current.Session("strUserName") Then
                '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtNote" & m_intRowCount, "txtNote" & m_intRowCount, , "clsTextArea", , "frmGrievances", "", "", 600, 50, , strNote, style:="  overflow-x: hidden;overflow-y:hidden;white-space: normal ", returnHTML:=True))
                'Else
                '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtNote" & m_intRowCount, "txtNote" & m_intRowCount, , "clsTextArea", , "frmGrievances", "", "", 600, 50, , strNote, style:="  overflow-x: hidden;overflow-y:hidden;white-space: normal", IsDisabled:=True, returnHTML:=True, ToBeInserted:="readOnly"))
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtNote" & m_intRowCount, "txtNote" & m_intRowCount, , "clsTextArea", , "frmGrievances", "", "", 600, 50, , strNote, style:="  overflow-x: hidden;overflow-y:hidden;white-space: normal ", returnHTML:=True, EnableHTMLEncode:=True))
            Else
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtNote" & m_intRowCount, "txtNote" & m_intRowCount, , "clsTextArea", , "frmGrievances", "", "", 600, 50, , strNote, style:="  overflow-x: hidden;overflow-y:hidden;white-space: normal", IsDisabled:=True, returnHTML:=True, ToBeInserted:="readOnly", EnableHTMLEncode:=True))

            End If
            sbHTML.Append("</td>")
            sbHTML.Append("<td>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

        End While
        CommonFunction.Data.DisposeDataReader(drRead)
        'If m_isActive = 0 Then

        sbHTML.Append("<tr class=clsTREven valign=top style='CURSOR:hand' onClick=""Javascript:AddNewRec_OnClick(this)"">")

        sbHTML.Append("<TD align=left colspan=5>")
        'sbHTML.Append("<TD align=left colspan=3>")
        'sbHTML.Append("<IMG BORDER=0 src='../../images/right.gif'>")
        sbHTML.Append("<IMG src='../../images/right.gif'>")
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        'End If
        sbHTML.Append("</Table>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing

    End Sub

    Protected Sub PerformActions()
        Dim strNote As String
        Dim intRowCnt As Integer = 1
        Dim intPKValue As Integer

        If m_strAction.ToUpper = "SAVE" Then
            intRowCnt = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("intRowCount"), 0)
            strNote = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtNote" + intRowCnt.ToString), "0"), String)
            intPKValue = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtPrimaryKey" + intRowCnt.ToString), "0"), String)

            SaveNoteDetails(intPKValue, strNote)
        End If

        'If m_strAction.ToUpper = "DELETE" Then
        '    DeleteRec()
        'End If

    End Sub

    Protected Sub SaveNoteDetails(ByVal intPKValue As Integer, ByVal strNote As String)
        Dim strSQL As String
        If m_intCustomerID <> 0 Then
            strSQL = "Usp_ins_tbl_pm_fieldLog " & intPKValue & "," & m_intCustomerID & "," & CommonFunction.General.BuildQueryString(m_strNoteBy) & ",N'" & CommonFunction.General.BuildQueryString(strNote) & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            CommonFunction.General.WriteHTML("<script>")
            CommonFunction.General.WriteHTML("refreshParent('frmBrickRedCustomerDB','CustomerDashboard.aspx','../CustomerPortal/CustomerDashboard.aspx?DashboardID=0&CustomerId=" + m_intCustomerID.ToString + "');")
            CommonFunction.General.WriteHTML("</script>")
        End If

    End Sub
    'Private Function SaveNoteDetails(ByVal intPKValue As Integer, ByVal strNote As String) As String

    'End Function


    'Private Sub DeleteRec()
    '    Dim intGrievanceID As String = "0"
    '    Dim arrIDs() As String
    '    Dim lenArray As Integer
    '    intGrievanceID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("GrievanceID"), "0")
    '    If intGrievanceID <> "0" Then
    '        CommonFunctions.Data.InsertOrUpdateData("DELETE FROM tbl_HR_Grievances WHERE GrievancesID = " & intGrievanceID, True)
    '    End If
    'End Sub
End Class
