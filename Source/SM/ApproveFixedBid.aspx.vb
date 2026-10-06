#Region "Imports"
Imports System.Text
#End Region

'=====================================================================
' Module Name       :       ApproveFixedBid

' Purpose           :       Displays the UI for Approving Fixed Bid Revision

' Description       :       Same As Above

' Dependencies      :       None

' Author            :       DipaliS

' Created           :       May 14, 2004

' Revisions         :
'=====================================================================

Public Class ApproveFixedBid
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private m_strProjectId As String
    Private m_strMode As String = ""
    Private m_strRevNo As String
    Private m_strThisValue As String
#End Region

#Region "Constructor"
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.ApproveFixedBid", "AppResources")
    End Sub
#End Region

#Region "Procedures"
    Public Sub PageInit()

        'Get the Project ID From Session
        m_strProjectId = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID")), String)

        If Not IsNothing(Request.QueryString("Action")) Then
            m_strMode = Request.QueryString("Action")
        End If

        'If the Mode is approve ,make necessary changes to Contract values
        If m_strMode.ToLower = "approve" Then
            'Update the Amount into the fixedbid table

            Dim strSQL As String
            strSQL = "Update tbl_pm_projectfixedbid set amount=" & CommonFunctions.General.BuildQueryString(MyBase.GetFormValue("txtThis")) & " where projectid=" & m_strProjectId
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            'Insert a new record into tbl_pm_projectfixedbidrevision with revid and amount
            strSQL = "usp_ins_tbl_pm_projectfixedbid_revision " & m_strProjectId & "," & CommonFunctions.General.BuildQueryString(CType(Session("strUserName"), String)) & ",'" & _
            CommonFunctions.General.BuildQueryString(MyBase.GetFormValue("txtRevNo")) & "'," & CommonFunctions.General.BuildQueryString(MyBase.GetFormValue("txtContDocNo")) & ",'" & CommonFunctions.General.BuildQueryString(MyBase.GetFormValue("txtReason")) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            'Script for closing window and refreshing the parent
            Dim strScript As String
            strScript = "<script language=" & """javascript""" & ">" & "window.close();"
            strScript += "window.opener.location=window.opener.location;" & "</script>"
            Response.Write(strScript)
            m_strMode = ""

        End If

        'Get the value for Amount
        Dim strSqlMax As String
        ''Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        ''strSqlMax = "select amount from tbl_pm_projectfixedbid where projectid=" & m_strProjectId
        strSqlMax = "usp_Sel_tbl_pm_projectfixedbid_amount " & m_strProjectId
        ''End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        m_strThisValue = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSqlMax, MyBase.UseSQL)), String)

        '######### Page Code starts here
        GetMenu()

        'Draw the Legend
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {CommonFunctions.HTMLControls.DrawMandatoryImage(, True)}
        WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)

        'Get the page caption
        WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGE_CAPTION"))

        Response.Write("<BR>")
        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        GetUI()

        Response.Write("</DIV>")

        GetMenu()

    End Sub
    '====================================================================
    ' Procedure Name        :       GetMenu
    ' Parameters Passed     :       None
    ' Returns               :       None
    ' Parameters Affected   :       None
    ' Purpose               :       Displays the Static menu for the page
    ' Description           :       Same as above
    ' Assumptions           :       None
    ' Dependencies          :       None
    ' Author                :       DipaliS
    ' Created               :       May 14, 2004
    ' Revisions :
    '=====================================================================
    Private Sub GetMenu()
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_APPROVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuClientFun() As String = {"Approve_OnClick()", "Close_OnClick()", "Help_OnClick()"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_APPROVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu
        objMenu.DrawMenu(arrMenu, arrMenuClientFun, arrMenuToolTip, False)
        objMenu = Nothing
    End Sub

    Private Sub GetUI()
        Dim strSQL As String

        'If the Mode is not approve then only get the new revision number
        If m_strMode <> "approve" Then
            strSQL = "EXEC usp_getRevisionNumber " & m_strProjectId
            m_strRevNo = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)), String)
        End If

        Dim strHTML As New StringBuilder
        'Table
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        strHTML.Append("<TABLE class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'TR for Revision Number
        strHTML.Append("<TR class=" & "'clsTREven'" & " >")
        'Label for 
        strHTML.Append("<TD align=" & "'right'" & " width=" & "'30%'>")
        strHTML.Append(MyBase.GetResourceString("REV_NO"))
        strHTML.Append("</TD>")

        'Value for Revision Number
        strHTML.Append("<TD width=" & "'70%'>")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRevNo", "txtRevNo", "clsTextBoxReadOnly", 200, , m_strRevNo, , , , True, , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")

        'TR for Contract Doc Number
        strHTML.Append("<TR class=" & "'clsTREven'" & " >")
        'Label for 
        strHTML.Append("<TD align=" & "'right'" & " width=" & "'30%'>")
        strHTML.Append(MyBase.GetResourceString("CONTRACTDOC"))
        strHTML.Append("</TD>")

        'Value for Revision Number
        strHTML.Append("<TD width=" & "'70%'>")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtContDocNo", "txtContDocNo", , 150, 10, , , , False, False, , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")

        'TR for This value
        strHTML.Append("<TR class=" & "'clsTREven'" & " >")
        'Label for 
        strHTML.Append("<TD align=" & "'right'" & " width=" & "'30%'>")
        strHTML.Append(MyBase.GetResourceString("THIS_VALUE"))
        strHTML.Append("</TD>")

        'Value for Revision Number
        strHTML.Append("<TD width=" & "'70%'>")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtThis", "txtThis", , 150, 15, m_strThisValue, "right", , False, , , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_ProjectRevision_Currency " & m_strProjectId, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString)
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")

        ''TR for Reason
        strHTML.Append("<TR class=" & "'clsTREven'" & " >")
        'Label for 
        strHTML.Append("<TD valign=top align=" & "'right'" & " width=" & "'30%'>")
        strHTML.Append(MyBase.GetResourceString("REASON"))
        strHTML.Append("</TD>")

        'Value for Revision Number
        strHTML.Append("<TD width=" & "'70%'>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReason", "txtReason", , , , , , , 300, 100, 1000, , , , , , , , , True, True, , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReason", "txtReason", , , , , , , 300, 100, 1000, , , , , , , , , True, True, , True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")

        strHTML.Append("</TABLE>")
        Response.Write(strHTML)



    End Sub
#End Region

End Class
