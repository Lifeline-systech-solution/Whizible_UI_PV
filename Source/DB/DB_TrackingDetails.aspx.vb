'Imports System.Globalization

Public Class DB_TrackingDetails
    Inherits WebPages.Template.WhizTemplate

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


    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    'Private m_objDTFI As New DateTimeFormatInfo       'Requires to parse the date.
    Private m_blnUseSQL As Boolean
    ''added by nilesh g on 11/8/2016 for PKtoken
    Private m_blnValidate As Boolean = True
    Private m_strFromWhere As String = ""
    'Added by Yogesh J on 18-Jan-2016
    Protected m_lngQueryID As String
    Protected m_TokenKEY As String
    'End od addition by Yogesh J on 18-Jan-2016
    Dim m_blnComplete As String = ""
    Dim m_dtDueDate As String = ""
    Dim m_strFlagTo As String = ""
    Dim m_strContextType As String = ""
    Dim m_intContextID As Integer = 0
    Dim m_intProjectID As Integer = 0
    Dim m_intUniqueID As Integer = 0
 'Added by SrikanthY on 15 Jan 2007
    Public m_ParentQueryID As Long = 0
    Public m_ParentQueryToken As String = ""
    Protected m_QueryProjectID As Integer = 0
    Protected m_QueryContextID As Integer = 0
    Protected m_QueryEmployeeID As Integer = 0
    Protected m_Queryfromwhere As String = ""
    Protected m_QueryFromWhich As String = ""




    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        'Put user code to initialize the page here
        m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        m_intUniqueID = CType(Request.Form("txtUniqueID"), Integer)
        m_dtDueDate = Request.Form("dtDueDate")
        m_strFlagTo = Request.Form("cbFlagTo")
        m_intContextID = CType(Request.Form("txtContextID"), Integer)
        m_intProjectID = CType(Request.Form("txtProjectID"), Integer)
        m_strContextType = Request.Form("txtContextType")
        m_blnComplete = Request.Form("chkComplete")

        'Added by SrikanthY on 15 Jan 2007 for issues 9426,9443
        If Not Request.QueryString("ParentQueryID") Is Nothing And Request.QueryString("ParentQueryID") <> "" Then
            m_ParentQueryID = CType(Request.QueryString("ParentQueryID"), Long)
        End If
        If Not Request.QueryString("ParentQueryToken") Is Nothing And Request.QueryString("ParentQueryToken") <> "" Then
            m_ParentQueryToken = CType(Request.QueryString("ParentQueryToken"), String)
        End If
        'End of addition by SrikanthY
        If Request.QueryString("Action") = "Generate" Then
            GenerateTrackingDtls()
        ElseIf Request.QueryString("Action") = "Clear" Then
            ClearTrackingDtls()
        End If

        'Added by Yogesh J on 18-Jan-2016 to Generate and Validate Token
        If Not Request.QueryString("ContextID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("ContextID"), String)
        Else
            m_lngQueryID = 0
        End If


        If Not Request.QueryString("ProjectID") Is Nothing Then
            m_QueryProjectID = CType(Request.QueryString("ProjectID"), Integer)
        End If
        If Not Request.QueryString("ContextID") Is Nothing Then
            m_QueryContextID = CType(Request.QueryString("ContextID"), Integer)
        End If
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_QueryEmployeeID = CType(Request.QueryString("EmployeeID"), Integer)
        End If



        If Not Request.QueryString("PKToken") Is Nothing Then
            m_TokenKEY = CType(Request.QueryString("PKToken"), String)
        End If

        If Not Request.QueryString("fromwhere") Is Nothing Then
            m_Queryfromwhere = CType(Request.QueryString("fromwhere"), String)
        End If


        If Not Request.QueryString("FromWhich") Is Nothing Then
            m_QueryFromWhich = CType(Request.QueryString("FromWhich"), String)
        End If

        'Else
        '    m_TokenKEY = (CommonFunctions.Security.Token.GetToken(CType(0, String) + CType(0, String)))
        ''Added by Nilesh g on 11/8/2016 Purpose: PKToken Generation
        If (m_TokenKEY = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            m_blnValidate = False
        ElseIf (m_QueryEmployeeID <> 0 And m_lngQueryID <> 0) Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryProjectID, String) + CType(m_QueryEmployeeID, String) + "0" + "0" + CType(m_lngQueryID, String), m_TokenKEY) = False) Then
                m_blnValidate = False
            End If
        ElseIf (m_QueryProjectID <> 0 And m_lngQueryID <> 0) Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryProjectID, String) + CType(Session("intUserID"), String) + "0" + "0" + CType(m_lngQueryID, String), m_TokenKEY) = False) Then
                m_blnValidate = False
            End If
            ''Added by Sanyogeeta R on 11/8/2016 Purpose: PKToken Generation
        ElseIf m_QueryContextID <> 0 Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryContextID, String) + CType(Session("intUserID"), String) + "0" + "0", m_TokenKEY) = False) Then
                m_blnValidate = False
            End If
        End If

        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ''End of Added by Nilesh g on 11/8/2016 Purpose: PKToken Generation
        ''Added by Nilesh g on 2/2/2016 for url issue
        'If m_Queryfromwhere = "Issue" Then
        '    If (Request.QueryString("ContextName") = "" And m_TokenKEY <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryProjectID, String) + CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_TokenKEY) = False)) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    ElseIf (Request.QueryString("ContextName") <> "" And m_TokenKEY <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_TokenKEY) = False)) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

        '    End If
        'End If

        'If m_QueryFromWhich = "FlagTrack" Then
        '    If (m_TokenKEY <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryContextID, String) + CType(m_QueryProjectID, String) + CType(m_QueryEmployeeID, String) + "0" + "0", m_TokenKEY) = False)) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If

        'If m_Queryfromwhere = "DB" Then
        '    If (m_TokenKEY <> "" And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_TokenKEY) = False)) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If

        'End If

        ' ''endded by Nilesh g on 2/2/2016 for url issue
        ''End of addition by Yogesh J on 18-Jan-2016 to Generate and Validate Token
        ' ''Added by Chakshuta H on 2nd-Aug-2016
        'If Request.QueryString("FromWhere") = "DB" Then
        '    If (Request.QueryString("PkFlagToken_RequestList") <> "" And Request.QueryString("ProjectID") <> "" And Request.QueryString("ContextID") <> "") Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("ContextID"), String) + "0" + "0", Request.QueryString("PkFlagToken_RequestList")) = False) Then

        '            'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If
        'End If
        ''End Of Added by Chakshuta H on 2nd-Aug-2016
    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MonikaI
        ' Created               : July 20 ,2006
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String
        Dim drProjectCount As IDataReader
        Dim blnComplete As Boolean
        Dim DueDate As Date
        Dim FlagTo As String = ""
        Dim strContextType As String = ""
        Dim lngContextID As Long
        Dim ConId As Long
        Dim ConType As String

        ConId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ContextID"), "0"), Long)
        ConType = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ContextType"), "NULL"), String)

        drProjectCount = CommonFunctions.Data.GetDataReader("usp_sel_TrackingDtls_Edit " & ConId & ", " & ConType & ", " + CType(Session("intUserID"), String), m_blnUseSQL)
        If drProjectCount.Read Then
            Dim arrMenu() As String = {"Clear Flag", "Save", "Close", "?"}
            Dim arrMenuToolTip() As String = {"Clear Tracking Details", "Save Tracking Details", "Close", "Help"}
            Dim arrCSFunction() As String = {"Clear_OnClick()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick()"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

            m_intUniqueID = CType(drProjectCount("UniqueID"), Integer)
            blnComplete = CType(drProjectCount("IsComplete"), Boolean)
            DueDate = CType(drProjectCount("DueDate"), Date)
            FlagTo = CType(drProjectCount("FlagTo"), String)

        Else
            Dim arrMenu() As String = {"Save", "Close", "?"}
            Dim arrMenuToolTip() As String = {"Save Tracking Details", "Close", "Help"}
            Dim arrCSFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick()"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

            m_intUniqueID = 0
        End If

        strContextType = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ContextType"), ""), String)
        lngContextID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ContextID"), "0"), Long)
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Tracking Details"))
            .Write("<BR>")
            .Write("<div id=divList style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)

            .Write("<TR class=clsTREven>")
            'Alignment Updated By JyotiG (29-Aug-2006)[Instead of center alignment Left alignment]
            'Issue ID : 5816
            .Write("<TD align=Left>Flagging marks an item to remind you that it needs to be followed up.")
            .Write(" After it has been followed up, you can mark it complete.</TD>")
            .Write("</TR>")

            .Write("<TR><TD></TD></TR>")

            CommonFunctions.HTMLControls.DrawDateControl("dtCurrentDate", "dtCurrentDate", , , CommonFunction.Dates.GetDate(Date.Today), , , , , , , , , , , , , True, 0)

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtUniqueID", "txtUniqueID", , , , CType(m_intUniqueID, String), , , False, , , True, , , False, , , EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtContextType", "txtContextType", , , , Request.QueryString("ContextType"), , , False, , , True, , , False, , , EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtContextID", "txtContextID", , , , CType(Request.QueryString("ContextID"), String), , , False, , , True, , , False, , , EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , CType(Request.QueryString("ProjectID"), String), , , False, , , True, , , False, , , EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtFromWhich", "txtFromWhich", , , , Request.QueryString("FromWhich"), , , False, , , True, , , False, , , EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtFromWhere", "txtFromWhere", , , , CType(CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), ""), String), , , False, , , True, , , False, , , EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

            .Write("<TR class=clsTREven>")
            If Request.QueryString("ContextType") & "" = "IB" Or Request.QueryString("ContextType") & "" = "ISSUE" Then
                .Write("<TD align=left><b>Issue ID : " & lngContextID.ToString & " </b>")
            ElseIf Request.QueryString("ContextType") & "" = "HelpDeskRequest" Then
                .Write("<TD align=left ><b>Request ID : " & lngContextID.ToString & "</b>")
            End If
            .Write("</TD></TR>")
            .Write("<TR class=clsTREven><TD align=left>")
            'Modified By NitinVS on 20 March 2007 for WhizibleSEM SP 8 Regression ISsue 11864 
            'Passing Context Name from Querystring is to be replaced as it creates errors if contextname has ;'"#$% etc

            ' display the entity Name 
            Select Case strContextType.ToUpper
                Case "IB"
                    .Write("<B> Issue : </B>")
                Case "ISSUE"
                    .Write("<B> Issue </B>")
                Case "RISK"
                    .Write("<B> Risk : </B>")
                Case "REVIEW"
                    .Write("<B> Review : </B>")
                Case "MILESTONE"
                    .Write("<B> Milestone : </B>")
                Case "TASK"
                    .Write("<B> Task : </B>")
                Case "HELPDESKREQUEST"
                    .Write("<B> Help Request : </B>")
                Case "DELIVERABLE"
                    .Write("<B> Deliverable : </B>")
                Case Else

            End Select

            'If strContextType.ToUpper & "" = "IB" Or strContextType.ToUpper & "" = "HELPDESKREQUEST" Then
            If CommonFunction.General.CheckIsNothing(Request.QueryString("ContextName"), "") = "" Then
                Dim ContextValue As String = CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_MyeDashboard_ContextName " & lngContextID.ToString & ",'" & strContextType & "'", m_blnUseSQL), "")
                .Write(Server.HtmlEncode(ContextValue) + "</TD>")
            Else
                .Write(Request.QueryString("ContextName") & "</TD>")
            End If

            'End Modification By NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11864 

            .Write("</TR>")

            .Write("</TABLE>")

            .Write("<BR>")
            .Write("<BR>")

            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>Flag to </TD>")
            .Write("<TD>")
            'Mofified By JyotiG
            'Start
            'Purpose : On Blur Event Added to set Focus
            'Issue ID : 5825
            CommonFunctions.HTMLControls.DrawComboBox("cbFlagTo", "usp_FlagTo_ComboFill", 120, FlagTo, "onblur=""javascript:cbFlagTo_OnBlur()""", True, , , , , , 1)
            'CommonFunctions.HTMLControls.DrawComboBox("cbFlagTo", "usp_FlagTo_ComboFill", 120, FlagTo, , True, , , , , , 1)
            'End
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>Due by </TD>")
            .Write("<TD>")

            If DueDate = Nothing Then
                CommonFunctions.HTMLControls.DrawDateControl("dtDueDate", "dtDueDate", , , , , "FrmTrackingDetails", , , , , False, , , True, , , , )
            Else
                CommonFunctions.HTMLControls.DrawDateControl("dtDueDate", "dtDueDate", , , CommonFunction.Dates.GetDate(DueDate), , "FrmTrackingDetails", , , , , False, , , True, , , , )
            End If

            .Write("</TD>")

            .Write("</TR>")
            'Modified By JyotiG
            'Issue ID : 5810
            'Start

            '.Write("<TR class=clsTREven>")
            '.Write("<TD></TD>")
            '.Write("<TD></TD>")
            '.Write("</TR>")

            '.Write("<TR class=clsTREven>")
            '.Write("<TD align=center>")
            'If blnComplete = True Then
            '    CommonFunctions.HTMLControls.DrawCheckBox("chkComplete", "chkComplete", , True, , , , , , , True, , 2)
            'Else
            '    CommonFunctions.HTMLControls.DrawCheckBox("chkComplete", "chkComplete", , False, , , , , , , True, , 2)
            'End If
            '.Write("Complete")
            '.Write("</TD>")

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>Complete </TD><TD>")
            If blnComplete = True Then
                CommonFunctions.HTMLControls.DrawCheckBox("chkComplete", "chkComplete", , True, , , , , , , True, , )
            Else
                CommonFunctions.HTMLControls.DrawCheckBox("chkComplete", "chkComplete", , False, , , , , , , True, , )
            End If
            '.Write("Complete")

            .Write("</TD>")

            '.Write("<TD align=right>")
            '.Write("Clear Flag")
            '.Write("</TD>")
            .Write("</TR>")
            'End

            .Write("</TABLE>")
            .Write("</div>")

            .Write("<BR>")
            .Write(strMenu)
            ' menu
        End With

        CommonFunctions.Data.DisposeDataReader(drProjectCount)

    End Sub

    Protected Sub GenerateTrackingDtls()

        Dim strSQL As String

        strSQL = "exec usp_ins_TrackingDtls '" & CType(Session("intUserID"), String) & "','" & m_strContextType & "','" & m_intContextID & "','" & m_intProjectID & "','" & m_strFlagTo & "','" & CDate(m_dtDueDate) & "','" & Request.QueryString("IsCheck") & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        ''Commented and Added by Usha Pandit on 07.06.2019 for Save Refresh issue
        'CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Saved Successfully');</SCRIPT>")
        CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Saved Successfully');window.close();</SCRIPT>")
        ''End of Added by Usha Pandit on 07.06.2019 for Save Refresh issue
    End Sub

    Protected Sub ClearTrackingDtls()

        Dim strSQL As String

        strSQL = "exec usp_del_TrackingDtls '" & m_intUniqueID & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        ''Commented and Added by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
        'CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Cleared Successfully');</SCRIPT>")
        CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Cleared Successfully');window.close();</SCRIPT>")
        ''End of Added by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue

    End Sub
End Class
