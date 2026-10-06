Public Partial Class PM_CreateEmployeeWiseAlerts
    Inherits WebPages.Template.WhizTemplate
    Protected strHTML As New System.Text.StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Protected m_strflag As Boolean
    Protected m_strEntityIDs As String = ""
    Private EmployeeAlertID As String
    Private EntityDetailIDs As String
    Private SendMailIDs As String
    Private SendSMSIDs As String
    Private EntityDetailValues As String
    Private arrEntityDetailIDs() As String
    Private strAlertName As String
    Private strDescription As String
    Private Active As Integer
    Protected m_strcboIssueType1 As String
    Protected m_strcboIssueType2 As String
    Protected m_strcboIssueType3 As String
    Private m_strcboReviewType As String
    Private IsRecPresent As Boolean
    Private EmployeeAlertIDForSP As String
    Private strFrequency As String
    Dim FirstIssueType As String = ""
    Dim SecondIssueType As String = ""
    Dim ThirdIssueType As String = ""
    'Addition by SuchitraP on 5-Nov-2008
    Private AlertEntityIDs As String
    'End by SuchitraP

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Call InitVariables()

        If Request.QueryString("action") = "SAVE" Then
            Call SaveData()
        ElseIf Request.QueryString("action") = "SAVEADD" Then
            Call SaveData()
            EmployeeAlertID = ""
        End If

    End Sub
    Private Sub InitVariables()
        Dim cnt As Integer
        Dim strEntityList As String
        Dim arrSelEntity() As String
        Dim Iterator As Integer
        'Addition by SuchitraP on 5-Nov-2008
        Dim arrSelAlertEntity() As String
        Dim counter As Integer
        'End by SuchitraP

        m_strEntityIDs = ""

        EmployeeAlertID = CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeAlertID"), "").ToString()

        If EmployeeAlertID Is Nothing OrElse EmployeeAlertID = "" Then
            EmployeeAlertID = CommonFunction.General.CheckIsNothing(Request.Form("hidEmployeeAlertID"), "")
        End If



        If EmployeeAlertID = "" OrElse EmployeeAlertID Is Nothing Then
            EmployeeAlertIDForSP = "NULL"
        Else
            EmployeeAlertIDForSP = EmployeeAlertID
        End If

        If CommonFunctions.General.CheckIsNothing(Request.Form("hidEntityDetailIDs"), "") <> "" Then
            strEntityList = Request.Form("hidEntityDetailIDs")
            arrSelEntity = strEntityList.Split(",c")
            For Iterator = 0 To arrSelEntity.Length - 1
                'comment and Addition by SuchitraP on 5-Nov-2008
                arrSelAlertEntity = arrSelEntity(Iterator).Split("|,c")
                For counter = 0 To arrSelAlertEntity.Length - 2

                    'If CommonFunctions.General.CheckIsNothing(Request.Form("chkEntityDetailID" + arrSelEntity(Iterator)), "") <> "" Then
                    '    EntityDetailIDs = EntityDetailIDs + Request.Form("chkEntityDetailID" + arrSelEntity(Iterator)) + ","

                    '    If CommonFunctions.General.CheckIsNothing(Request.Form("chkSendMail" + arrSelEntity(Iterator)), "") <> "" Then
                    '        SendMailIDs = SendMailIDs + "1,"
                    '    Else
                    '        SendMailIDs = SendMailIDs + "0,"
                    '    End If

                    '    If CommonFunctions.General.CheckIsNothing(Request.Form("chkSMS" + arrSelEntity(Iterator)), "") <> "" Then
                    '        SendSMSIDs = SendSMSIDs + "1,"
                    '    Else
                    SendSMSIDs = SendSMSIDs + "0,"
                    '    End If

                    'End If

                    'If CommonFunctions.General.CheckIsNothing(Request.Form("cboFrequency" + arrSelEntity(Iterator)), "") <> "" Then
                    '    strFrequency = strFrequency + Request.Form("cboFrequency" + arrSelEntity(Iterator)) + ","
                    'End If
                    If CommonFunctions.General.CheckIsNothing(Request.Form("chkEntityDetailID" + arrSelAlertEntity(0)), "") <> "" Then
                        EntityDetailIDs = EntityDetailIDs + arrSelAlertEntity(0) + ","

                        AlertEntityIDs = AlertEntityIDs + arrSelAlertEntity(1) + ","

                        If CommonFunctions.General.CheckIsNothing(Request.Form("chkSendMail" + arrSelAlertEntity(0)), "") <> "" Then
                            SendMailIDs = SendMailIDs + "1,"
                        Else
                            SendMailIDs = SendMailIDs + "0,"
                        End If

                        'If CommonFunctions.General.CheckIsNothing(Request.Form("chkSMS" + arrSelAlertEntity(0)), "") <> "" Then
                        '    SendSMSIDs = SendSMSIDs + "1,"
                        'Else
                        '    SendSMSIDs = SendSMSIDs + "0,"
                        'End If

                    End If

                    If CommonFunctions.General.CheckIsNothing(Request.Form("cboFrequency" + arrSelAlertEntity(0)), "") <> "" Then
                        strFrequency = strFrequency + Request.Form("cboFrequency" + arrSelAlertEntity(0)) + ","
                    End If

                Next
                'End by SuchitraP
            Next
        End If


        If EntityDetailIDs <> "" Then
            arrEntityDetailIDs = EntityDetailIDs.Split(","c)
            For cnt = 0 To arrEntityDetailIDs.Length - 2
                EntityDetailValues = EntityDetailValues + Request.Form("txt" + arrEntityDetailIDs(cnt)) + ","
            Next
        End If

        strAlertName = CommonFunction.General.CheckIsNothing(Request.Form("txtAlertName"), "").ToString()
        'Addition by SuchitraP on 2-Oct-2008 for IssueID 23204 
        'Purpose:To avoid page crash when single quote is entered
        strAlertName = CommonFunctions.General.BuildQueryString(strAlertName)
        'End by SuchitraP
        strDescription = CommonFunction.General.CheckIsNothing(Request.Form("txtDescription"), "").ToString()
        'Addition by SuchitraP on 2-Oct-2008 for IssueID 23209 
        'Purpose:To avoid page crash when single quote is entered
        strDescription = CommonFunctions.General.BuildQueryString(strDescription)
        'End by SuchitraP
        Active = CType(CommonFunction.General.CheckIsNothing(Request.Form("chkActive"), 0), Integer)

        'FirstIssueType = CommonFunction.General.CheckIsNothing(Request.Form("cboIssueType1"), "")
        'SecondIssueType = CommonFunction.General.CheckIsNothing(Request.Form("cboIssueType2"), "")
        'ThirdIssueType = CommonFunction.General.CheckIsNothing(Request.Form("cboIssueType3"), "")

        If CommonFunctions.General.CheckIsNothing(Request.Form("cboIssueType1"), "") <> "" Then
            m_strcboIssueType1 = "'" + Request.Form("cboIssueType1") + "'"
        Else
            m_strcboIssueType1 = "NULL"
        End If

        If CommonFunctions.General.CheckIsNothing(Request.Form("cboIssueType2"), "") <> "" Then
            m_strcboIssueType2 = "'" + Request.Form("cboIssueType2") + "'"
        Else
            m_strcboIssueType2 = "NULL"
        End If

        If CommonFunctions.General.CheckIsNothing(Request.Form("cboIssueType3"), "") <> "" Then
            m_strcboIssueType3 = "'" + Request.Form("cboIssueType3") + "'"
        Else
            m_strcboIssueType3 = "NULL"
        End If

        If CommonFunctions.General.CheckIsNothing(Request.Form("cboReviewType"), "") <> "" Then
            m_strcboReviewType = "'" + Request.Form("cboReviewType") + "'"
        Else
            m_strcboReviewType = "NULL"
        End If


    End Sub
    '' added by Nilesh g on 29-Jan-2016 to generate token	
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RequestShow_TaskType(AlertEntityID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(AlertEntityID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of  added by Nilesh g on 29-Jan-2016 to generate token
    Protected Sub WritePage()
        Dim strMenu As String

        strMenu = GenerateMenu()
        strHTML.Append(strMenu)

        ''Commented by SuchitraP on 5-Nov-2008
        'Call DrawHeaderControls()
        ''End of comment by SuchitarP

        Call DrawControls()
        Call drawHiddenControls()

        strHTML.Append(GenerateMenu())

        Response.Write(strHTML.ToString())
    End Sub
    Private Sub DrawHeaderControls()
        Dim dr As IDataReader
        Dim strQuery As String
        Dim AlertName As String = ""
        Dim Description As String = ""
        Dim Active As Boolean = True
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim strProject_FieldList As String
        Dim strSelectedProjects As String
        Dim m_strOldProjectIDs As String

        strQuery = "usp_sel_tbl_EmployeeAlerts " & EmployeeAlertID
        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If dr.Read() Then
            AlertName = dr("AlertName").ToString()
            Description = dr("AlertDescription").ToString()
            Active = CType(dr("Active"), Boolean)
        End If

        'Mandatory Image
        strHTML.Append("<TABLE CellSpacing=0 width='100%' class=clsTable>" + vbCrLf)
        strHTML.Append("<TR class=clsTRBlank>" + vbCrLf)
        strHTML.Append("<TD align='Right'><B>(<IMG src='../../Images/Star.gif' border=0> Mandatory)</B>" + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)
        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)
        'Page Caption
        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHTML.Append("<TR class=clsTRPageCaption><TD align=Left>Alert</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)
        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)
        'Controls

        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable align=center>" + vbCrLf)
        strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        strHTML.Append("<TD align='Right'>Alert Name" + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtAlertName", "txtAlertName", , 450, 200, AlertName, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + vbCrLf)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        'modified by sonalD on 16th Sept 2008
        'Purpose: To show Project Selection link only in Edit mode
        'strHTML.Append("&nbsp;&nbsp;&nbsp;<A id='ProjSelection' HREF=""Javascript:ProjectSelection_OnClick()"" Title=""Project Selection"" >Project Selection</A>" + vbCrLf)
        If EmployeeAlertID <> "" Then
            strHTML.Append("&nbsp;&nbsp;&nbsp;<A id='ProjSelection' HREF=""Javascript:ProjectSelection_OnClick()"" Title=""Project Selection"" >Project Selection</A>" + vbCrLf)
        End If
        'end of modification
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)

        strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        strHTML.Append("<TD align='Right'>Description" + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", value:=Description, widthInPixel:=450, heightInPixel:=70, returnHTML:=True) + vbCrLf)
        strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", value:=Description, widthInPixel:=450, heightInPixel:=70, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)

        strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        strHTML.Append("<TD align='Right'>Active" + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
        strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkActive", "chkActive", , Active, 1, , , True) + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)

        strHTML.Append("</TABLE>" + vbCrLf)

        CommonFunction.Data.DisposeDataReader(dr)

    End Sub

    Private Sub DrawControls()
        Dim dr As IDataReader
        Dim strQuery As String
        Dim AlertEntityID As String
        Dim AlertEntityDetailID As String
        Dim EntityName As String
        Dim EmpAlertEntityDetailID As String
        Dim EntityDetialDescription As String
        Dim IsSelect As Boolean = False
        Dim strFrequency As String
        Dim oldEntityName As String = ""
        Dim Duration As String
        Dim OtherTypes As String
        Dim oldAlertEntityID As String = ""
        Dim oldAlertEntityDetailID As String = ""
        Dim strSQL As String
        Dim drEntityReader As IDataReader
        Dim cnt As Integer = 1
        Dim intRowSpan As Integer = 0
        Dim intHeadingCNT As Integer = 1
        Dim arrEntityDetialDescription() As String
        Dim SendMail As Boolean
        'Dim SendSMS As Boolean
        Dim drEntity As IDataReader
        Dim IsProjectSelected As String

        If EmployeeAlertID = "" Then
            strQuery = "usp_Sel_AlertEntityDetails " & Session("intUserID").ToString() + ",NULL"
        Else
            strQuery = "usp_Sel_AlertEntityDetails " & Session("intUserID").ToString() + "," + EmployeeAlertID
        End If

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        'Page Caption
        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHTML.Append("<TR class=clsTRPageCaption><TD align=Left>Select Alerts</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)
        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)
        'Controls
        strHTML.Append("<DIV Id=PageDiv Style='OVERFLOW:auto;WIDTH:99.9%;'>" + vbCrLf)

        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)

        While dr.Read()

            AlertEntityID = dr("AlertEntityID").ToString()
            AlertEntityDetailID = dr("AlertEntityDetailID").ToString()
            EntityName = dr("EntityName").ToString()
            EntityDetialDescription = dr("EntityDetialDescription").ToString()
            IsSelect = CType(dr("IsSelected"), Boolean)
            Duration = CommonFunction.Data.CheckIsDBNull(dr("Duration"), "")
            OtherTypes = CommonFunction.Data.CheckIsDBNull(dr("OtherType").ToString, "")
            EmpAlertEntityDetailID = CommonFunction.Data.CheckIsDBNull(dr("EmpAlertEntityDetailID"), "")
            strFrequency = dr("Frequency").ToString
            SendMail = CType(CommonFunction.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            'SendSMS = CType(CommonFunction.Data.CheckIsDBNull(dr("SendSMS"), "0"), Boolean)

            IsProjectSelected = ""

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''IsProjectSelected = CommonFunction.Data.GetDataScalar("SELECT 1 FROM tbl_PM_AlertWiseProjects WHERE AlertEntityID=" + AlertEntityID.ToString + " AND EmployeeID=" + Session("intUserID").ToString(), MyBase.UseSQL)
            IsProjectSelected = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_AlertWiseProjects_AlertEntityID_EmployeeID " + AlertEntityID.ToString + "," + Session("intUserID").ToString(), MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If oldEntityName <> EntityName Then

                If intHeadingCNT = 1 Then
                    strHTML.Append("<TR class=clsTRSectionHeader >" + vbCrLf)
                    strHTML.Append("<TD align='left' colspan=3 valign=top>&nbsp;<B>" + vbCrLf)
                    strHTML.Append(EntityName + vbCrLf)
                    'Comment and modification by SuchitraP on 5-Nov-2008
                    'strHTML.Append("</B></TD><TD></TD>" + vbCrLf)
                    strHTML.Append("</B></TD>" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    If IsProjectSelected = "1" Then
                        strHTML.Append("&nbsp;&nbsp;&nbsp;<A id='ProjSelected' HREF=""Javascript:ProjectSelection_OnClick(" + AlertEntityID + ")"" Title=""Project Selected"" >Project Selected</A>" + vbCrLf)
                    Else
                        strHTML.Append("&nbsp;&nbsp;&nbsp;<A id='ProjSelection' HREF=""Javascript:ProjectSelection_OnClick(" + AlertEntityID + ")"" Title=""Project Selection"" ><font color=blue>Project Selection</font></A>" + vbCrLf)
                    End If
                    strHTML.Append("</TD>" + vbCrLf)
                    'End by SuchitraP
                    strHTML.Append("<TD align='center' ><B>Frequency</B></TD>" + vbCrLf)
                    strHTML.Append("<TD align='center' ><B>Send Mail</B></TD>" + vbCrLf)
                    'strHTML.Append("<TD align='center' ><B>Send Text Message</B></TD>" + vbCrLf)
                    intHeadingCNT = 2
                Else
                    strHTML.Append("<TR class=clsTRSectionHeader >" + vbCrLf)
                    strHTML.Append("<TD align='left' colspan=3>&nbsp;<B>" + vbCrLf)
                    strHTML.Append(EntityName + vbCrLf)
                    'Comment and modification by SuchitraP on 5-Nov-2008
                    'strHTML.Append("</B></TD><TD></TD>" + vbCrLf)
                    strHTML.Append("</B></TD>" + vbCrLf)
                    strHTML.Append("<TD align='left' colspan=4>" + vbCrLf)
                    If IsProjectSelected = "1" Then
                        strHTML.Append("&nbsp;&nbsp;&nbsp;<A id='ProjSelected' HREF=""Javascript:ProjectSelection_OnClick(" + AlertEntityID + ")"" Title=""Project Selected"" >Project Selected</A>" + vbCrLf)
                    Else
                        strHTML.Append("&nbsp;&nbsp;&nbsp;<A id='ProjSelection' HREF=""Javascript:ProjectSelection_OnClick(" + AlertEntityID + ")"" Title=""Project Selection"" ><font color=blue>Project Selection</font></A>" + vbCrLf)
                    End If
                    strHTML.Append("</TD>" + vbCrLf)
                    'End by SuchitraP
                End If

                strHTML.Append("</TR>" + vbCrLf)
                strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                strHTML.Append("<TD align='left'></TD>" + vbCrLf)
                strHTML.Append("<TD align='left' valign=top>" + vbCrLf)
                strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkEntityDetailID" + AlertEntityDetailID, "chkEntityDetailID" + AlertEntityDetailID, , IsSelect, AlertEntityDetailID + "|" + AlertEntityID, , "onclick=Javascript:EntityDetail_OnClick(this)", True) + vbCrLf)
                strHTML.Append("</TD>" + vbCrLf)
                strHTML.Append("<TD align='left' valign=top>&nbsp;" + vbCrLf)

                arrEntityDetialDescription = EntityDetialDescription.Split("|")

                strHTML.Append(arrEntityDetialDescription(0) + vbCrLf)
                If IsSelect = True Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Else
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                End If
                strHTML.Append(arrEntityDetialDescription(1) + vbCrLf)

                'strHTML.Append(EntityDetialDescription + vbCrLf)
                strHTML.Append("</TD>" + vbCrLf)


                If AlertEntityDetailID = "17" Then

                    Dim IssueTypes As String = ""
                    Dim arrIssueTypes() As String
                    Dim iterator As Integer = 0
                    Dim counter As Integer = 0

                    drEntity = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_AlertOtherAttributes 17," + HttpContext.Current.Session("intUserID").ToString, MyBase.UseSQL)
                    arrIssueTypes = "null,null,null".Split(",")

                    While drEntity.Read()
                        arrIssueTypes(iterator) = drEntity("OtherType").ToString()
                        iterator = iterator + 1
                    End While
                    CommonFunction.Data.DisposeDataReader(drEntity)
                    If m_strcboIssueType1 = "NULL" And m_strcboIssueType2 = "NULL" And m_strcboIssueType3 = "NULL" Then
                        m_strflag = True
                    Else
                        m_strflag = False
                    End If

                    For counter = 0 To arrIssueTypes.Length - 1
                        If arrIssueTypes(counter) = "null" Then
                            m_strflag = True
                        Else
                            m_strflag = False
                            Exit For
                        End If
                    Next

                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append("<TABLE cellspacing=0 cellpadding=0  class=clsTable>" + vbCrLf)
                    strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType1", "usp_Sel_IssueTypes_ForAlerts " + m_strcboIssueType1, 150, arrIssueTypes(0), IIf(m_strflag, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType2", "usp_Sel_IssueTypes_ForAlerts " + m_strcboIssueType2, 150, arrIssueTypes(1), IIf(m_strflag, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType3", "usp_Sel_IssueTypes_ForAlerts " + m_strcboIssueType3, 150, arrIssueTypes(2), IIf(m_strflag, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    strHTML.Append("</TABLE>" + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)


                    'strHTML.Append("<TD align='left' valign=top>&nbsp;" + vbCrLf)
                    'If IsSelect = True Then
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True) + vbCrLf)
                    'Else
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True) + vbCrLf)
                    'End If

                    'strHTML.Append("</TD>" + vbCrLf)

                ElseIf AlertEntityDetailID = "25" Then

                    Dim ReviewTypes As String = ""
                    Dim arrReviewTypes() As String
                    Dim iterator As Integer = 0
                    Dim counter As Integer = 0

                    arrReviewTypes = "null".Split(",")

                    drEntity = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_AlertOtherAttributes 25," + HttpContext.Current.Session("intUserID").ToString, MyBase.UseSQL)
                    If drEntity.Read() Then
                        arrReviewTypes(0) = drEntity("OtherType").ToString()
                    End If
                    CommonFunction.Data.DisposeDataReader(drEntity)
                    If m_strcboReviewType = "NULL" Then
                        IsRecPresent = True
                    Else
                        IsRecPresent = False
                    End If

                    For counter = 0 To counter < 1
                        If arrReviewTypes(counter) = "null" Then
                            IsRecPresent = True
                        Else
                            IsRecPresent = False
                        End If
                    Next

                    strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewType", "usp_Sel_ReviewTypes_ForAlerts " + m_strcboReviewType, 150, arrReviewTypes(0), IIf(IsRecPresent, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    'strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
                    'If IsSelect = True Then
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True) + vbCrLf)
                    'Else
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True) + vbCrLf)
                    'End If
                    'strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                Else
                    strHTML.Append("<TD></TD>" + vbCrLf)
                    'strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
                    'If IsSelect = True Then
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True) + vbCrLf)
                    'Else
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True) + vbCrLf)
                    'End If
                    'strHTML.Append("</TD>" + vbCrLf)

                End If


            ElseIf oldAlertEntityID = AlertEntityID And oldAlertEntityDetailID <> AlertEntityDetailID Then
                strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                'strHTML.Append("<TD align='left'></TD>" + vbCrLf)
                strHTML.Append("<TD align='left'></TD>" + vbCrLf)
                strHTML.Append("<TD align='left' valign=top>" + vbCrLf)
                strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkEntityDetailID" + AlertEntityDetailID, "chkEntityDetailID" + AlertEntityDetailID, , IsSelect, AlertEntityDetailID + "|" + AlertEntityID, , "onclick=Javascript:EntityDetail_OnClick(this)", True) + vbCrLf)
                strHTML.Append("</TD>" + vbCrLf)
                strHTML.Append("<TD align='left' valign=top>&nbsp;" + vbCrLf)

                arrEntityDetialDescription = EntityDetialDescription.Split("|")

                strHTML.Append(arrEntityDetialDescription(0) + vbCrLf)
                If IsSelect = True Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Else
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                End If
                strHTML.Append(arrEntityDetialDescription(1) + vbCrLf)


                'strHTML.Append(EntityDetialDescription + vbCrLf)
                strHTML.Append("</TD>" + vbCrLf)

                If AlertEntityDetailID = "17" Then

                    Dim IssueTypes As String = ""
                    Dim arrIssueTypes() As String
                    Dim iterator As Integer = 0
                    Dim counter As Integer = 0

                    drEntity = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_AlertOtherAttributes 17," + HttpContext.Current.Session("intUserID").ToString, MyBase.UseSQL)
                    arrIssueTypes = "null,null,null".Split(",")

                    While drEntity.Read()
                        arrIssueTypes(iterator) = drEntity("OtherType").ToString()
                        iterator = iterator + 1
                    End While
                    CommonFunction.Data.DisposeDataReader(drEntity)
                    If m_strcboIssueType1 = "NULL" And m_strcboIssueType2 = "NULL" And m_strcboIssueType3 = "NULL" Then
                        m_strflag = True
                    Else
                        m_strflag = False
                    End If

                    For counter = 0 To arrIssueTypes.Length - 1
                        If arrIssueTypes(counter) = "null" Then
                            m_strflag = True
                        Else
                            m_strflag = False
                            Exit For
                        End If
                    Next

                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append("<TABLE cellspacing=0 cellpadding=0 class=clsTable>" + vbCrLf)
                    strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType1", "usp_Sel_IssueTypes_ForAlerts " + m_strcboIssueType1, 150, arrIssueTypes(0), IIf(m_strflag, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType2", "usp_Sel_IssueTypes_ForAlerts " + m_strcboIssueType2, 150, arrIssueTypes(1), IIf(m_strflag, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                    strHTML.Append("<TD align='left'>" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType3", "usp_Sel_IssueTypes_ForAlerts " + m_strcboIssueType3, 150, arrIssueTypes(2), IIf(m_strflag, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    strHTML.Append("</TR>" + vbCrLf)
                    strHTML.Append("</TABLE>" + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)

                    'strHTML.Append("<TD align='left' valign=top>&nbsp;" + vbCrLf)
                    'If IsSelect = True Then
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True) + vbCrLf)
                    'Else
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True) + vbCrLf)
                    'End If

                    'strHTML.Append("</TD>" + vbCrLf)


                ElseIf AlertEntityDetailID = "25" Then

                    Dim ReviewTypes As String = ""
                    Dim arrReviewTypes() As String
                    Dim iterator As Integer = 0
                    Dim counter As Integer = 0

                    arrReviewTypes = "null".Split(",")

                    drEntity = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_AlertOtherAttributes 25," + HttpContext.Current.Session("intUserID").ToString, MyBase.UseSQL)
                    If drEntity.Read() Then
                        arrReviewTypes(0) = drEntity("OtherType").ToString()
                    End If
                    CommonFunction.Data.DisposeDataReader(drEntity)
                    If m_strcboReviewType = "NULL" Then
                        IsRecPresent = True
                    Else
                        IsRecPresent = False

                    End If

                    For counter = 0 To counter < 1
                        If arrReviewTypes(counter) = "null" Then
                            IsRecPresent = True
                        Else
                            IsRecPresent = False
                        End If
                    Next

                    strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
                    strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboReviewType", "usp_Sel_ReviewTypes_ForAlerts " + m_strcboReviewType, 150, arrReviewTypes(0), IIf(IsRecPresent, " disabled ", ""), True, True) + vbCrLf)
                    strHTML.Append("</TD>" + vbCrLf)
                    'strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
                    'If IsSelect = True Then
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True) + vbCrLf)
                    'Else
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True) + vbCrLf)
                    'End If

                    'strHTML.Append("</TD>" + vbCrLf)

                Else
                    strHTML.Append("<TD></TD>" + vbCrLf)
                    'strHTML.Append("<TD align='left' valign=top>&nbsp;" + vbCrLf)
                    'If IsSelect = True Then
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True) + vbCrLf)
                    'Else
                    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txt" + AlertEntityDetailID, "txt" + AlertEntityDetailID, , 50, 7, Duration, "right", returnHTML:=True, IsDisabled:=True) + vbCrLf)
                    'End If
                    'strHTML.Append("</TD>" + vbCrLf)

                End If

            End If

            'Frequency 

            strHTML.Append("<TD align='center' valign=top>&nbsp;" + vbCrLf)
            strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboFrequency" + AlertEntityDetailID, "usp_Sel_AlertFrequency", 100, strFrequency, IIf(IsSelect = False, " disabled ", ""), True, True))
            strHTML.Append("</TD>" + vbCrLf)

            strHTML.Append("<TD align='center' valign=top>&nbsp;" + vbCrLf)
            strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSendMail" + AlertEntityDetailID, "chkSendMail" + AlertEntityDetailID, , SendMail, AlertEntityDetailID, , IIf(IsSelect = False, " disabled ", ""), True) + vbCrLf)
            strHTML.Append("</TD>" + vbCrLf)
            'strHTML.Append("<TD align='center' valign=top>&nbsp;" + vbCrLf)
            'strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSMS" + AlertEntityDetailID, "chkSMS" + AlertEntityDetailID, , SendSMS, AlertEntityDetailID, , IIf(IsSelect = False, " disabled ", ""), True) + vbCrLf)
            'strHTML.Append("</TD>" + vbCrLf)
            strHTML.Append("</TR>" + vbCrLf)

            If AlertEntityDetailID = "3" Then
                strHTML.Append("<TR class=clsTREven >" + vbCrLf)
                strHTML.Append("<TD align='Left' colspan=6 valign=top> [Note: Issue tasks and Review Tasks not displayed for Exceeded baseline efforts alert.]" + vbCrLf)
                strHTML.Append("</TD>" + vbCrLf)
                strHTML.Append("</TR>" + vbCrLf)
            End If

            oldEntityName = EntityName
            oldAlertEntityID = AlertEntityID
            oldAlertEntityDetailID = AlertEntityDetailID

            'Comment and modification by SuchitraP on 5-Nov-2008
            'm_strEntityIDs = m_strEntityIDs + AlertEntityDetailID + ","
            m_strEntityIDs = m_strEntityIDs + AlertEntityDetailID + "|" + AlertEntityID + ","
            'End by SuchitraP

        End While

        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("</DIV>" + vbCrLf)

        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.Data.DisposeDataReader(drEntityReader)
        CommonFunction.Data.DisposeDataReader(drEntity)

    End Sub

    Private Function GenerateMenu()

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionsList As New ArrayList

        'arrMenuList.Add("Project Selection")
        'arrMenuToolTipList.Add("Project Selection")
        'arrClientSideFunctionsList.Add("ProjectSelection_OnClick()")

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\save.gif'>Save")
        arrMenuToolTipList.Add("Save")
        arrClientSideFunctionsList.Add("Save_OnClick()")

        ''Commented by SuchitraP on 5-Nov-2008
        'arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\saveadd.gif'> Save and Add")
        'arrMenuToolTipList.Add("Save and Add")
        'arrClientSideFunctionsList.Add("SaveandAdd_OnClick()")

        'arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/back.gif'>Back")
        'arrMenuToolTipList.Add("Back")
        'arrClientSideFunctionsList.Add("Back_OnClick()")
        ''End of Comment by SuchitraP

        'arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>Close")
        'arrMenuToolTipList.Add("Close")
        'arrClientSideFunctionsList.Add("Close_OnClick()")

        arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionsList.Add("Help_OnClick('3939')")

        Dim arrMenu() As String = GetArray(arrMenuList)
        Dim arrMenuToolTip() As String = GetArray(arrMenuToolTipList)
        Dim arrClientSideFunctions() As String = GetArray(arrClientSideFunctionsList)

        m_objMenu = New WebPage.Templates.StaticMenu
        GenerateMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
    End Function

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub SaveData()
        Dim strquery As String

        'Comment and modification by SuchitraP on 5-Nov-2008
        'strquery = "usp_INS_tbl_PM_EmployeeAlertDetails " + EmployeeAlertIDForSP + ",'" + EntityDetailIDs + "','" + EntityDetailValues + "','" & strAlertName & "','" & strDescription & "'," & Session("intUserID").ToString() & "," & Active
        'strquery = strquery + "," + m_strcboIssueType1 + "," + m_strcboIssueType2 + "," + m_strcboIssueType3 + ",'" + SendMailIDs + "','" + SendSMSIDs + "','" + strFrequency + "'"

        strquery = "usp_INS_tbl_PM_EmployeeAlertDetails " + EmployeeAlertIDForSP + ",'" + EntityDetailIDs + "','" + EntityDetailValues + "'," + Session("intUserID").ToString()
        strquery = strquery + "," + m_strcboIssueType1 + "," + m_strcboIssueType2 + "," + m_strcboIssueType3 + ",'" + SendMailIDs + "','" + SendSMSIDs + "','" + strFrequency + "','" + AlertEntityIDs + "'"

        'EmployeeAlertID = CType(CommonFunction.Data.GetDataScalar(strquery, MyBase.UseSQL), String)
        CommonFunction.Data.InsertOrUpdateData(strquery, MyBase.UseSQL)
        'End by SuchitarP



    End Sub
    Private Sub drawHiddenControls()

        strHTML.Append("<input type=hidden name=hidEmployeeAlertID id=hidEmployeeAlertID value=" + EmployeeAlertID + ">" + vbCrLf)
        strHTML.Append("<input type=hidden name=hidEntityDetailIDs id=hidEntityDetailIDs value=" + m_strEntityIDs + ">" + vbCrLf)


    End Sub
End Class