Imports CommonEngines.General.cEventHandlers
Imports System.Text
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports System.IO
Public Class IssueCopying_CommonList
    Inherits CommonList

    ''ADDED BY AMIT MAHADIK ON 08 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
    'CType(HttpContext.Current.Session("intProjectID"), String)
    Public Shared mstrCurrentProjectID As String
    Shared mstrCurrentProjectGroupID As String
    Shared mstrCurrentPractiseID As String
    Private mstrIssuesIDS As String
    Private msbAssignToIDS As New StringBuilder()

    Public Shared m_lngEmployeeID As Long
    Public Shared m_strUserName As String
    Public Shared m_strLoginType As String
    Private m_blnUseSQL As Boolean
    ''End ADDED BY AMIT MAHADIK ON 08 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING  

    ''ADDED BY AMIT MAHADIK ON 04th OCTOBER 2011 WHIZIBLESEM 10.0 BULK ISSUE COPYING
    Shared m_strCurrentType As String
    Public Shared m_intRoleId As Integer

    'Server Date Time Related Variables
    Dim h As Integer = 0
    Dim m As Integer = 0
    Dim strHour As String = ""
    Dim strMinute As String = ""
    Dim strGetServerTimeSQL1 As String = ""
    Dim strGetServerTime1 As String = ""
    Dim strGetServerDateSQL1 As String = ""
    Dim strGetServerDate1 As String = ""
    ''END ADDED BY AMIT MAHADIK ON 04th OCTOBER 2011 WHIZIBLESEM 10.0 BULK ISSUE COPYING

    ''Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)
    Public Shared m_intFlag As String = "0"
    Public Shared m_intProjectID As String = "0"
    ''End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)

    ''Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0 (Issue Fix: 57897)
    Public Shared m_blnShareIBWithinProjectGroup As Boolean = False 'Share Issue in project group ?
    Public Shared m_blnAssignIssueToResponsiblePerson As Boolean = False 'Assign issue to responsible person ?
    Public Shared m_blnIsProjectOver As Boolean = False 'Is Project Over ? 
    Public Shared m_blnSendResponsiblePersonMail As Boolean = False 'Send mail to responsible person ?
    ''End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0 (Issue Fix: 57897)


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)

        Call Initialize()

        MyBase.strListPage = "IssueCopying_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        ''ADDED BY AMIT MAHADIK ON 10 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ''Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)
        If CheckIsNothing(Request.QueryString("ProjectID"), "") <> "" Then
            mstrCurrentProjectID = Request.QueryString("ProjectID").ToString
        End If
        ''End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)

        If Request.QueryString("MODE") <> "" Then
            If Request.QueryString("MODE").ToUpper().Trim() = "COPYISSUES" Then
                mstrIssuesIDS = Request.Form("chkDelete") ''Issue IDs to copy
                If mstrIssuesIDS <> "" Then
                    Dim arrIssuesIDS() As String
                    arrIssuesIDS = mstrIssuesIDS.Split(",")
                    ' Iterate through a collection
                    For Each IssueID As String In arrIssuesIDS
                        msbAssignToIDS.Append(Request.Form("cboAssignedResource_" + IssueID) + ",") ''Responsible person IDs 
                    Next
                    msbAssignToIDS.Remove(msbAssignToIDS.Length - 1, 1)
                    CopyBulkIssues(mstrCurrentProjectID, mstrIssuesIDS, msbAssignToIDS, m_lngEmployeeID)
                End If
            End If
        End If
        ''END ADDED BY AMIT MAHADIK ON 10 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING



        MyBase.Page_Load(sender, e)

        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        ' strGetServerTimeSQL1 = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        strGetServerTimeSQL1 = "usp_sel_GetDate"
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        strGetServerTime1 = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'strGetServerDateSQL1 = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        strGetServerDateSQL1 = "usp_sel_SMALLDATETIME"
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        strGetServerDate1 = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        h = CType(Left(strGetServerTime1, 2), Integer)
        m = CType(Right(strGetServerTime1, 2), Integer)

        If h < 10 Then
            strHour = "0" + h.ToString
        Else
            strHour = h.ToString

        End If
        If m < 10 Then
            strMinute = "0" + m.ToString
        Else
            strMinute = m.ToString
        End If

        Response.Write(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, DisplayNone:=True))
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:07/10/15

    End Sub
    ''ADDED BY AMIT MAHADIK ON 13 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
    Private Sub Initialize()
        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub
    ''END ADDED BY AMIT MAHADIK ON 13 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING

    Private Function CopyBulkIssues(ByVal CurrentProjectID As String, ByVal IssuesIDS As String, ByVal AssignToIDS As StringBuilder, ByVal CreatorID As Long) As String
        '============================================================================
        'Procedure Name		: CopyBulkIssues
        'Description		: following sp and parameters are used:
        '					 
        '                                   usp_Ins_tbl_IB_Issue_CopyBulkIssues 62,'511,512','543,543',61
        '                                   usp_Ins_tbl_IB_Issue_CopyBulkIssues @ProjectID,@IssuesIDS,@AssignToIDS,@CreatorID
        '	
        'Purpose		    :Bulk Issue copy
        '					 
        '		
        'Return Values		: 
        'Author				: Amit Mahadik
        'Created			: 10 June 2011
        '============================================================================
        Dim strSQLCopyBulkIssues As String
        Dim Type As String = Request.Form("CmbType")
        Dim SubType As String = Request.Form("CmbSubType")
        Dim Status As String = Request.Form("CmbStatus")
        Dim ReportedBy As String = Request.Form("CmbReportedBy")
        Dim ReportedDate As String = Request.Form("dtReportedDate")
        Dim ReportedTime As String = Request.Form("txtReportedTime")
        Dim LoginID As String = CType(HttpContext.Current.Session("intUserID"), String)


        ''Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)
        Dim ReleaseID As String
        Dim IterationID As String
        Dim UserStoryID As String
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " & CurrentProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        If m_intFlag = "1" Then
            ReleaseID = Request.Form("CmbRelease")
            IterationID = Request.Form("CmbIteration")
            UserStoryID = Request.Form("CmbUserStory")
        End If
        ''End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)

        '


        '**********************************'**********************************
        '''SP(NEEDS):

        ''''''''''''@ProjectID INT,  
        ''''''''''''@IssuesIDS VARCHAR(100),  
        ''''''''''''@AssignToIDS VARCHAR(100),  
        ''''''''''''@Type VARCHAR(100),  
        ''''''''''''@SubType VARCHAR(100),  
        ''''''''''''@Status VARCHAR (100),  
        ''''''''''''@ReportedBy VARCHAR(100),  
        ''''''''''''@ReportedDate DATETIME ,
        ''''''''''''@ReportedTime NVARCHAR(100),
        ''''''''''''@LoginID INT
        '**********************************'**********************************

        ''Commented and Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)
        'strSQLCopyBulkIssues = "usp_Ins_tbl_IB_Issue_CopyBulkIssues " & CurrentProjectID.ToString() & ",'" & IssuesIDS & "','" & AssignToIDS.ToString() & "','" & Type & "','" & SubType & "','" & Status & "','" & ReportedBy & "','" & ReportedDate & "','" & ReportedTime & "','" & LoginID & "'"

        If m_intFlag = "1" Then
            strSQLCopyBulkIssues = "usp_Ins_tbl_IB_Issue_CopyBulkIssues " & CurrentProjectID.ToString() & ",'" & IssuesIDS & "','" & AssignToIDS.ToString() & "','" & Type & "','" & SubType & "','" & Status & "','" & ReportedBy & "','" & ReportedDate & "','" & ReportedTime & "','" & LoginID & "'," & ReleaseID & "," & IterationID & "," & UserStoryID
        Else
            strSQLCopyBulkIssues = "usp_Ins_tbl_IB_Issue_CopyBulkIssues " & CurrentProjectID.ToString() & ",'" & IssuesIDS & "','" & AssignToIDS.ToString() & "','" & Type & "','" & SubType & "','" & Status & "','" & ReportedBy & "','" & ReportedDate & "','" & ReportedTime & "','" & LoginID & "'"
        End If
        ''End of Commented and Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)

        CommonFunctions.Data.InsertOrUpdateData(strSQLCopyBulkIssues, m_blnUseSQL)

        Dim arrIssueIDs() As String
        Dim strNewSql As String
        arrIssueIDs = IssuesIDS.Split(",")

        ''Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0 (Issue Fix: 57897)

        Dim drProject As IDataReader

        drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " + CurrentProjectID.ToString(), MyBase.UseSQL)
        If drProject.Read Then
            'Share Issue within Project Group ?
            m_blnShareIBWithinProjectGroup = CType(drProject("ShareIBWithinProjectGroup"), Boolean)

            'Is Project Over ?
            m_blnIsProjectOver = CType(drProject("Over"), Boolean)

            'Send mail to responsible person ?
            m_blnSendResponsiblePersonMail = CType(drProject("SendResponsiblePersonMail"), Boolean)

            'Assign Issue To responsible person ?
            If CommonFunction.Application.AssignIssueToResponsiblePerson = True Then
                m_blnAssignIssueToResponsiblePerson = CType(drProject("AssignIssueToResponsiblePerson"), Boolean)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drProject)

        If m_blnIsProjectOver = False Then
            'Assign Issue to responsible person, if project has this setting
            If m_blnAssignIssueToResponsiblePerson = True Then
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strNewSql = "SELECT TOP " + CType(arrIssueIDs.Length, String) + " IssueID FROM tbl_ib_issue ORDER BY 1 DESC"
                strNewSql = "usp_sel_tbl_ib_issue_CountTop " + CType(arrIssueIDs.Length, String)
                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                Dim drNewIssueIDs As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strNewSql)
                Dim strOldAssignTo As String = ""
                If (drNewIssueIDs.HasRows) Then
                    While (drNewIssueIDs.Read())
                        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                        'strNewSql = "SELECT AssignTo FROM tbl_ib_Issue WHERE IssueId = " + drNewIssueIDs(0).ToString()
                        strNewSql = "usp_sel_AssignTo_tbl_ib_Issue " + drNewIssueIDs(0).ToString()
                        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                        Dim strAssignTo As String = CType(CommonFunctions.Data.GetDataScalar(strNewSql, MyBase.UseSQL), String)
                        Call AssignIssueToEmployee(drNewIssueIDs(0).ToString(), strOldAssignTo, strAssignTo)
                    End While
                End If
            End If

            ''Send mail to responsible person, if project has this setting
            'If m_blnSendResponsiblePersonMail = True Then
            '    'Integrated by SandipL SP8 to SP9
            '    Call FreshParent()
            '    'End Integration by SandipL SP8 to SP9
            '    Call SendMail(41, m_lngIssueId) 'Assigned as responsible person
            'End If
        End If
        ''End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0 (Issue Fix: 57897)


        

        ' Iterate through a collection
        For Each IssueID As String In arrIssueIDs
            Call SendMail(8, CType(IssueID, Long))
        Next


    End Function
    ''Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0 (Issue Fix: 57897)

    Private Sub AssignIssueToEmployee(ByVal intIssueID As Long, ByVal strOldAssignTo As String, ByVal strNewAssignTo As String)
        '==================================================================================
        ' Procedure Name		:	AssignIssueToEmployee
        ' Parameters Passed		:	strOldAssignTo :- Old value of AssignTo.
        '							strNewAssignTo :- New Value of AssignTo.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	None.
        ' Purpose				:	If the Issue has been assigned to a resource, then a mail is sent to the concerned resource.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 17, 2004
        ' Revisions				:	
        '==================================================================================
        'Added by PrashantD on 17 March 2007 for IssueID 11616
        Dim blnIssueTaskCreated As Boolean = False
        'End of addition by PrashantD on 17 March 2007

        Dim blnSendEmail, blnShowPopup As Boolean
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim drEmailMessage As IDataReader

        Dim strSQLQuery As String = ""
        Dim drIssueDetails As IDataReader

        Dim dblWorkInHours As Double
        Dim dtmStartDate As String = ""
        Dim dtmEndDate As String = ""

        Dim blnIssueAssigned As Boolean = False

        If strNewAssignTo.Trim = "" Then
            strNewAssignTo = "NULL"
        End If

        ' Check if a task is already assigned to the resource. If yes, do not proceed with the assignment. 
        ' The previous assignment details should not be overwritten.
        ' Get the Start date, End Date and the Work (hrs) of the task assigned.
        strSQLQuery = "EXEC usp_Sel_tbl_PM_ProjectTasks_IssueTasks " & intIssueID & ", " & strNewAssignTo
        drIssueDetails = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drIssueDetails.Read Then
            blnIssueAssigned = True
        End If

        CommonFunction.Data.DisposeDataReader(drIssueDetails)

        'If Issue already assigned to employee, exit 
        If blnIssueAssigned = True Then
            Exit Sub
        End If

        '' If the Work had been taken from the user, then that value must be stored as Default Work (hrs).
        'If MyBase.GetFormValue("txtWorkInHours") <> "" Then
        '    dblWorkInHours = CType(MyBase.GetFormValue("txtWorkInHours").ToString.Trim, Double)
        'End If

        ''Update worklHours value in tbl_IB_Project_Sub_Type table.
        'If dblWorkInHours <> 0 Then
        '    strSQLQuery = "Exec usp_Upd_tbl_IB_Project_Sub_Type_UpdateDefaultWork " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(MyBase.GetFormValue("Type")) + "', " + FormatNumber(dblWorkInHours)
        '    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        'End If

        strSQLQuery = ""
        ' Add a new Task in the Project Task table.
        drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + intIssueID.ToString, MyBase.UseSQL)
        If drIssueDetails.Read Then
            strSQLQuery = strSQLQuery + "EXEC usp_Ins_IB_AssignIssueToEmployee " + intIssueID.ToString + ", " + mstrCurrentProjectID.ToString() + ", " + strNewAssignTo

            ' Store the Duration as the estimated Work.
            If dblWorkInHours = 0 Then
                strSQLQuery = strSQLQuery + ", NULL"
            Else
                strSQLQuery = strSQLQuery + ", " + dblWorkInHours.ToString
            End If

            ' Store the Start Date.
            If dtmStartDate = "" Then
                strSQLQuery = strSQLQuery + ", NULL"
            Else
                strSQLQuery = strSQLQuery + ", '" + CommonFunction.Dates.CGetDate(CType(dtmStartDate, Date)) + "'"
            End If

            ' Store the End Date.
            If dtmEndDate = "" Then
                strSQLQuery = strSQLQuery + ", NULL"
            Else
                strSQLQuery = strSQLQuery + ", '" + CommonFunction.Dates.CGetDate(CType(dtmEndDate, Date)) + "'"
            End If
            'Added and commented by PrashantD on 17 March 2007 for IssueID 11616
            ' Execute the insert query.
            'CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            Dim drIssueAssign As IDataReader
            drIssueAssign = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drIssueAssign.Read Then
                If CType(drIssueAssign(0), Boolean) = True Then
                    blnIssueTaskCreated = True
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drIssueAssign)
            'End of addition by PrashantD on 17 March 2007


        Else
            CommonFunction.Data.DisposeDataReader(drIssueDetails)
            Exit Sub
        End If
        CommonFunction.Data.DisposeDataReader(drIssueDetails)

        ' If the Issue has not been assigned to anyone, then exit the subroutine. (No mail will be sent in this case.)
        If strNewAssignTo = "NULL" Then
            Exit Sub
        End If
        'Added and commented by PrashantD on 17 March 2007 for IssueID 11616
        If blnIssueTaskCreated = False Then
            Exit Sub
        End If
        ''End of addition by PrashantD on 17 March 2007
        '' Retrieve the details of the message to be sent to the Resource.
        'drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 14", MyBase.UseSQL)
        'If drEmailMessage.Read Then
        '    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
        '    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        'End If
        'CommonFunction.Data.DisposeDataReader(drEmailMessage)

        '' Check if the mail has to be sent. (exit if no email is to be send)
        'If blnSendEmail = False Then Exit Sub

        '' Check if a popup message has to be shown.
        'If blnShowPopup = True Then
        '    'Integrated by SandipL SP8 to SP9
        '    Call FreshParent()
        '    'End Integration by SandipL SP8 to SP9
        '    strOnloadClientScript = strOnloadClientScript + "window.open(""../General/SendEmail.aspx?MessageID=14&IssueID=" + intIssueID.ToString + "&EmployeeIDList=," + strNewAssignTo + ","", """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
        '    ' Else, if the mail has to be sent silently, then...
        'Else
        '    'Get email actual message by replacing placeholders
        '    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intIssueID, "," & strNewAssignTo & ",")

        '    'Send mail
        '    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
        'End If
    End Sub
    ''End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0 (Issue Fix: 57897)

    ''ADDED BY AMIT MAHADIK ON 08 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING

    Private Sub SendMail(ByVal MessageId As Integer, ByVal IssueId As Long)
        '===========================================================================================
        ' Procedure Name        : SendMail()	
        ' Purpose               : To send silent mail for given messageId and IssueId
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 16, 2004
        ' Revisions             :
        ''Integration           : Integrated with modification by Amit Mahadik, in this Page....
        ''                                      on 14 June 2011 for whizibleSEM 10.0
        '===========================================================================================

        Dim drEmailMessage As IDataReader
        Dim blnSendEmail, blnShowPopup As Boolean
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String

        Select Case MessageId
            Case 8 'NEW ISSUE POSTED
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 8", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                'Destroy data reader
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                'Exit procedure if no mail is to be send
                If Not blnSendEmail Then Exit Sub

                'If popup window to be shown before sending mail
                '''If blnShowPopup Then
                '''    'parameters "EntityID" and "PKValue" added by Anirudha for jump to record for email functionality
                '''    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=8&EntityID=1&PKValue=" + IssueId.ToString + "&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                '''Else
                'If mail is to be send silently
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_8(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                'Added By Chakshuta H on 11th-Nov-2016 Purpose :Page crash on Copy Issue(s)-the specified string is not in the form required for a subject
                strSubject = strSubject.Replace(vbCr, " ").Replace(vbLf, " ")
                'End Of Added By Chakshuta H on 11th-Nov-2016 Purpose :Page crash on Copy Issue(s)-the specified string is not in the form required for a subject
                Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                '''End If

            Case 34 'ISSUE STATUS CHANGED
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 34", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent (exit if not to send)
                If blnSendEmail = False Then Exit Sub

                ' Check if a popup message has to be shown.
                '''If blnShowPopup = True Then
                '''    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=34&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                '''    ' Else, if the mail has to be sent silently, then...
                '''Else
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                '''End If

            Case 41 'ASSIGNED AS RESPONSIBLE PERSON FOR ISSUE
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 41", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent.(exit if not to send  mail)
                If blnSendEmail = False Then Exit Sub

                '''' Check if a popup message has to be shown.
                '''If blnShowPopup = True Then
                '''    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=41&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                '''    ' Else, if the mail has to be sent silently, then...
                '''Else
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_41(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                '''End If

        End Select
    End Sub


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid

        Return New IssueCopying_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        'mstrCurrentProjectID = CType(HttpContext.Current.Session("intProjectID"), String)
        'Added ProjectID quarystring in url by NitinC on 01 Dec 2011 for WhizibleSEM 10.0 (Issue 56385)
        'If mstrCurrentProjectID Is Nothing Then
        '    mstrCurrentProjectID = m_intProjectID
        'End If
        'End of Added ProjectID quarystring in url by NitinC on 01 Dec 2011 for WhizibleSEM 10.0 (Issue 56385)
        Dim drFilters As IDataReader
        'Commented and added by NitinC on 17 April 2012 For WhizibleSEM 11.0 (Issue Fix)
        'drFilters = CommonFunctions.Data.GetDataReader("SELECT ProjectGroupID,ProjectTypeID [PractiseID] FROM tbl_pm_project WHERE ProjectID = " + mstrCurrentProjectID, MyBase.UseSQL)

        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'drFilters = CommonFunctions.Data.GetDataReader("SELECT ProjectGroupID,ProjectTypeID [PractiseID] FROM tbl_pm_projectRevision WHERE ProjectID = " + mstrCurrentProjectID + " order by revisionnumber desc", MyBase.UseSQL)
        drFilters = CommonFunctions.Data.GetDataReader("usp_sel_tbl_pm_projectRevision_ProjectGroup " + mstrCurrentProjectID, MyBase.UseSQL)
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        'End of Commented and added by NitinC on 17 April 2012 For WhizibleSEM 11.0 (Issue Fix)
        If CommonFunctions.General.CheckIsNothing(drFilters) <> "" Then
            If drFilters.Read() Then
                mstrCurrentProjectGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drFilters.Item("ProjectGroupID"), "0"), String)
                mstrCurrentPractiseID = CType(CommonFunctions.Data.CheckIsDBNull(drFilters.Item("PractiseID"), "0"), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drFilters)


    End Sub
    ''END ADDED BY AMIT MAHADIK ON 08 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    ''ADDED BY AMIT MAHADIK ON 08 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
    Public Class IssueCopying_CommonListPlotGrid
        Inherits CommonEngine.CommonList.cPlotGrid
        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim ProjectGroupID As String
            Dim PractiseID As String
            Dim IssueID As String = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IssueID"), "0"), String)

            'Commented and added by NitinC on 17 April 2012 For WhizibleSEM 11.0 (Issue Fix)
            'ProjectGroupID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectGroupID FROM tbl_pm_project WHERE ProjectID = (Select ProjectID FROM tbl_IB_Issue WHERE  IssueID = " + IssueID + ")", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            'PractiseID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectTypeID FROM tbl_pm_project WHERE ProjectID = (Select ProjectID FROM tbl_IB_Issue WHERE  IssueID = " + IssueID + ")", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            'ProjectGroupID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectGroupID FROM tbl_pm_projectRevision WHERE ProjectID = (Select ProjectID FROM tbl_IB_Issue WHERE  IssueID = " + IssueID + ") order by revisionnumber desc", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            ProjectGroupID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_rojectGroup_tbl_pm_projectRevision " + IssueID, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            'PractiseID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectTypeID FROM tbl_pm_projectRevision WHERE ProjectID = (Select ProjectID FROM tbl_IB_Issue WHERE  IssueID = " + IssueID + ") order by revisionnumber desc", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            PractiseID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_ProjectType_tbl_pm_projectRevision " + IssueID, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))

            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


            
            'End of Commented and added by NitinC on 17 April 2012 For WhizibleSEM 11.0 (Issue Fix)

            If Args.ColumnName.ToUpper = "SELECT" Then
                If mstrCurrentProjectGroupID <> ProjectGroupID Or mstrCurrentPractiseID <> PractiseID Then
                    Args.IsCheckBoxDisabled = True
                End If
            End If
            'If Args.ColumnName.ToUpper = "ISSUE ID" Then
            '    Cancel = True

            '    Args.StringToBeInserted = "<TD><A href=""JavaScript:Copy_OnClick('" + IssueID + "')"">" + IssueID + "</A></TD>"
            'End If
            If Args.ColumnName.ToUpper = "RESPONSIBLE PERSON" Then
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunctions.HTMLControls.DrawComboBox("cboAssignedResource_" + IssueID, "SELECT EmployeeID,EmployeeName FROM d_tbl_PM_ProjectEmployeeRole WITH (NOLOCK) WHERE ProjectID= " & mstrCurrentProjectID, 150, , , True, True) + "</TD>"
            End If
        End Sub

        Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            '''If Args.ColumnName.ToUpper = "SELECT" Then
            '''    Cancel = True
            '''End If
        End Sub
        Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
            '''''Dim ProjectGroupID As String
            '''''Dim PractiseID As String
            '''''Dim IssueID As String = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IssueID"), "0"), String)

            '''''ProjectGroupID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectGroupID FROM tbl_pm_project WHERE ProjectID = (Select ProjectID FROM tbl_IB_Issue WHERE  IssueID = " + IssueID + ")", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
            '''''PractiseID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ProjectTypeID FROM tbl_pm_project WHERE ProjectID = (Select ProjectID FROM tbl_IB_Issue WHERE  IssueID = " + IssueID + ")", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))

            '''''If mstrCurrentProjectGroupID <> ProjectGroupID Or mstrCurrentPractiseID <> PractiseID Then
            '''''    Cancel = True
            '''''End If
        End Sub

        Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim sbInputControls As New StringBuilder()

            '''CommonFunctions.HTMLControls.DrawComboBox("cbo_Test", "SELECT EmployeeID,EmployeeName FROM d_tbl_PM_ProjectEmployeeRole WITH (NOLOCK) WHERE ProjectID= " & mstrCurrentProjectID, 150, , , True, True))
            '''sbInputControls.Append("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' >")
            '''sbInputControls.Append("<TR>")
            '''sbInputControls.Append("<TD>")
            '''sbInputControls.Append(" ")
            '''sbInputControls.Append("</TD>")
            '''sbInputControls.Append("<TD>")
            '''sbInputControls.Append(" ")
            '''sbInputControls.Append("</TD>")
            '''sbInputControls.Append("<TD>")
            '''m_strCurrentType = 601
            '''sbInputControls.Append(CommonFunction.HTMLControls.DrawComboBox("CmbType", "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup 90, 'T',Null,Null,Null,Null,Null,7", 160, "", "OnChange = Type_OnChange()", , , , True))
            '''sbInputControls.Append("</TD>")
            '''sbInputControls.Append("</TR>")
            '''sbInputControls.Append("<TR>")
            '''sbInputControls.Append("<TD>")
            '''sbInputControls.Append(" ")
            '''sbInputControls.Append("</TD>")
            '''sbInputControls.Append("<TD>")
            '''sbInputControls.Append(CommonFunction.HTMLControls.DrawDateControl("dcReportedDate ", "dcReportedDate", , , , DisplayNone:=False))
            '''sbInputControls.Append("</TD>")
            '''sbInputControls.Append("<TD>")
            '''sbInputControls.Append(CommonFunction.HTMLControls.DrawTextBox("txtReportedTime", "txtReportedTime", , , , , ))
            '''sbInputControls.Append("</TD>")
            '''sbInputControls.Append("</TR>")
            '''sbInputControls.Append("</Table>")


            m_intRoleId = HttpContext.Current.Session("intPostID")

            CommonFunctions.General.WriteHTML("</br>")

            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 cellspacing=1 >")
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align=right>")

            CommonFunction.General.WriteHTML("Type")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunction.HTMLControls.DrawComboBox("CmbType", "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & mstrCurrentProjectID.ToString() & ", 'T',Null,Null,Null,Null,Null," & m_intRoleId.ToString(), 160, "", "OnChange = Type_OnChange()", True, , , True)
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("hidtxtDestProjectID", "hidtxtDestProjectID", , 20, 5, mstrCurrentProjectID.ToString(), , , , , , True, , , EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=right>")

            CommonFunction.General.WriteHTML("Sub Type")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunction.HTMLControls.DrawComboBox("CmbSubType", "select 0,''", 160, "", , True, , , True)

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=right>")

            CommonFunction.General.WriteHTML("Status")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "select 0,''", 160, "", , True, , , True)

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align=right>")

            CommonFunction.General.WriteHTML("Reported By")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunction.HTMLControls.DrawComboBox("CmbReportedBy", "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " & mstrCurrentProjectID.ToString() & ", " & m_lngEmployeeID.ToString() & ", 1, NULL, NULL , '" & m_strLoginType.ToString() & "','New',0", 160, , , True, , , True)

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=right>")

            CommonFunction.General.WriteHTML("Reported Date")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunctions.HTMLControls.DrawDateControl("dtReportedDate", "dtReportedDate", , , , , "frmCommonList", "..\..\images\Calendar.gif' id='imgReportedDate", , , , , , , True, , )

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=right>")

            CommonFunction.General.WriteHTML("Reported Time")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left>")

            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtReportedTime", "txtReportedTime", , 50, 5, , , , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            'Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)
            m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " & mstrCurrentProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            If m_intFlag = "1" Then
                CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                CommonFunctions.General.WriteHTML("<TD align=right>")

                CommonFunction.General.WriteHTML("Release")

                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left>")
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'CommonFunction.HTMLControls.DrawComboBox("CmbRelease", "SELECT ReleaseID,ReleaseName FROM tbl_PM_ScrumRelease WITH(NOLOCK) WHERE ProjectID = " & mstrCurrentProjectID.ToString(), 160, , "OnChange=GetIterations(this)", True, , , True)
                CommonFunction.HTMLControls.DrawComboBox("CmbRelease", "usp_sel_tbl_PM_ScrumRelease_ReleaseName " & mstrCurrentProjectID.ToString(), 160, , "OnChange=GetIterations(this)", True, , , True)
                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=right>")

                CommonFunction.General.WriteHTML("Iteration")

                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left>")

                CommonFunction.HTMLControls.DrawComboBox("CmbIteration", "SELECT ''", 160, , "OnChange = GetUserStories(this)", True, , , True)

                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=right>")

                CommonFunction.General.WriteHTML("User Story")

                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left>")

                CommonFunction.HTMLControls.DrawComboBox("CmbUserStory", "SELECT ''", 160, , , True, , , True)

                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57837)

            CommonFunctions.General.WriteHTML("</Table>")

            CommonFunctions.General.WriteHTML(sbInputControls.ToString())

        End Sub

        ''END ADDED BY AMIT MAHADIK ON 08 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
    End Class
End Class


