Public Class IB_IssueEntryForReview
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

#Region " Form level variables declaration "

    Private m_LoginId As Long 'Login Id
    Private m_LoginType As String 'Login type
    Private m_RoleId As Long 'Role Id
    Private m_RoleLevel As Integer 'Role level
    Protected m_ProjectId As Long 'Project Id
    Private m_UserId As Long 'User Id
    Protected m_UserName As String 'User Name
    Private m_CultureId As Long 'Culture Id
    Protected m_FromWhere As String 'From where ?

    Private m_blnAddAccess As Boolean = False 'user has Add Access ?
    Private m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Private m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Private blnIsReview As Boolean = False
    Private blnShowTimesheetDetails As Boolean = False

    Protected intReviewStatisticsID As Integer = 0
    Protected intReviewActionID As Integer = 0

    Private strProjectPhase As String = ""
    Private strReviewer As String = ""
    Private strReviewee As String = ""
    Private intEmployeeID As Integer = 0
    Private strReviewDate As String = ""
    Private strReviewType As String = ""
    Private intModuleID As Integer = 0
    Private strModuleName As String = ""

    Private strCause As String = ""
    Private strReviewAction As String = ""

    Private intIssueID As Long = 0

    Protected strMode As String = ""
    Private strAction As String = ""

    Private blnShowDefaults As Boolean = False
    Private blnShowRecordSetContents As Boolean = False
    Private blnShowFormContents As Boolean = False

    Private ArrCtlAttr(20) As String

    Private strCurrentType As String = ""
    Private strFieldValue As String = ""

    Private blnIssuePresent As Boolean = False
    Private blnAssignToChanged As Boolean = False

    Protected strOnloadClientScript As String

    Private drIssueDetails As IDataReader

    Protected strReviewCategory As String = "R"   'Added by ShamkantD on 5 Jan 2005
#End Region

#Region " Public procedures "
    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for page

    Public Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name        : PlotPageHeadTag()	
        ' Purpose               : To plot page head tag on client side script
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================
        Call CommonFunction.General.PlotPageHeadTag("Issues")
    End Sub 'Plot Page Head tag

    Public Sub BuildPage()

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   30 June 2004
        'Requirement No:IB_PBN_ENT_01
        'Addition Made: Get the RoleID,ProjectID from Session
        m_ProjectId = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID")), Long)
        m_RoleId = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID")), Long)
        '*******End Addition********


        Dim strMenu As String = GenerateMenu()

        Call SetVariables()

        If strAction.ToUpper = "SAVE" Then
            Call SaveIssue()
        End If

        If intIssueID > 0 Then
            drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + intIssueID.ToString, MyBase.UseSQL)
            drIssueDetails.Read()
            blnIssuePresent = True
        End If

        Response.Write(strMenu)

        Call GetCurrentType()

        Response.Write("<DIV id=DivMain style='overflow:auto;width:100%;height:485px'>")

        'Generate Page Legends
        Call GeneratePageLegends()

        'Generate IssueDetails section
        Call GenerateIssueDetailsSection()

        Response.Write("</DIV>")

        Response.Write("<BR>" + strMenu)

        CommonFunction.Data.DisposeDataReader(drIssueDetails)

    End Sub

#End Region

#Region " Private Procedures "

    Private Function GetCorporateValue(ByVal strFieldName As String, ByVal strFieldValue As String) As String
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	strFieldName :- The field name.
        '							strFieldValue :- The field value.
        ' Returns				:	Returns the corporate mapped value.
        ' Parameters Affected	:	None
        ' Purpose				:	To get the corporate mapped value for the value passed.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	mar 8, 2004
        ' Revisions				:	
        '==================================================================================	

        Dim strSQLQuery As String
        Dim drCorporateValue As IDataReader

        GetCorporateValue = ""

        ' Build the query to retrieve the corporate mapped value.
        strSQLQuery = "Exec usp_Sel_IB_GetCorporateValue '" & CommonFunction.General.BuildQueryString(strFieldName) + "', '" + CommonFunction.General.BuildQueryString(strFieldValue) + "', " + m_ProjectId.ToString
        If strFieldName = "SubType" Or strFieldName = "Status" Then
            strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(strCurrentType) & "'"
        End If

        ' Retrieve the corporate mapped value from the database, and return the value.
        drCorporateValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drCorporateValue.Read Then
            GetCorporateValue = CommonFunction.Data.CheckIsDBNull(drCorporateValue("CorporateValue"), "").ToString
        End If
        CommonFunction.Data.DisposeDataReader(drCorporateValue)

    End Function

    Private Sub SaveIssue()
        '=====================================================================
        ' Procedure Name        : SaveIssue()	
        ' Purpose               : To save / import issue
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL, strDatabaseQuery, strFieldList, strValueList As String
        Dim drIssueFields As IDataReader, IssueId As Long
        Dim intUpperBound As Integer

        blnAssignToChanged = False

        ' Retrieve the list of fields in the Issue Table for ganerating Hash Table

        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT * FROM tbl_IB_Issue WHERE 1=2"
        strSQL = "usp_sel_tbl_IB_Issue_1"
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        'Generate Hash table.
        Dim ht As New System.Collections.Hashtable
        ht = CommonFunctions.Data.GetSchema(strSQL, MyBase.UseSQL)

        strDatabaseQuery = ""

        ' New Issue - Generate Insert Query 
        If intIssueID = 0 Then

            ' Generate the Insert Query.
            strDatabaseQuery = strDatabaseQuery & "INSERT INTO tbl_IB_Issue "

            strFieldList = "ProjectID, CreatorOrModifier, LoginType"
            strValueList = m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_UserName) + "', '" + m_LoginType + "'"

            Dim inti As Integer

            ' loop through each element in the form 
            'Omit first 5 controls on the form as they are static and no hash table can be created for them.
            For inti = 5 To Request.Form.AllKeys.Length - 1
                'Do nothing for "PriorityFixInDays", "txtOldAssignedTo" and "txtWorkInHours" as they are static and hidden 
                'Controls add in the form and no hash table to be crated for them as no data is available in SQL for these controls
                'Code For ignoring dummy date control added by SandipL on 3 Dec 2005 --IssueID 672 
                If Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                    inti += 1
                    'Exit loop if counter exceeds upperbound
                    If inti > Request.Form.AllKeys.Length - 1 Then Exit For
                End If

                'Generate schema for the control, containing details about, like fieldname, datatype, size etc.
                Dim objSchema As New CommonFunction.Data.Schema
                objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)

                'Check if Responsible person is changed
                If Request.Form.GetKey(inti) = "AssignTo" Then
                    blnAssignToChanged = True
                End If

                'omit IssueId from query, as it is identity key in the table. 
                If Request.Form.GetKey(inti) <> "IssueID" Then

                    ' Get the field name.
                    strFieldList = strFieldList + ", " + CommonFunction.General.BuildQueryString(Request.Form.GetKey(inti))

                    ' Get the field value.
                    If Request.Form(Request.Form.GetKey(inti)) = "" Then
                        ' If the field value is blank, then insert NULL.
                        strValueList += ", NULL"

                        ' If the field is any of the following, then their corporate values must be stored as well.
                        If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Then
                            strFieldList = strFieldList + ", Corporate" + Request.Form.GetKey(inti)
                            strValueList = strValueList + ", '" + GetCorporateValue(CommonFunction.General.BuildQueryString(Request.Form.GetKey(inti)), CommonFunction.General.BuildQueryString(Request.Form.GetKey(inti))) + "'"
                        End If
                    Else
                        ' If the field data-type is either integer/boolean/double, then...
                        If objSchema.DataType.Trim.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.Trim.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.Trim.ToUpper = "SYSTEM.DOUBLE" Then
                            If Request.Form(Request.Form.GetKey(inti)) <> "" Then
                                strValueList = strValueList + ", " + FormatNumber(Request.Form(Request.Form.GetKey(inti)), , TriState.False, TriState.False, TriState.False)
                            Else
                                strValueList = strValueList + ", NULL"
                            End If
                        Else 'For other data types
                            strValueList = strValueList + ", '" + CommonFunction.General.BuildQueryString(Request.Form(Request.Form.GetKey(inti))) + "'"

                            ' If the field is any of the following, then their corporate values must be stored as well.
                            If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Then
                                strFieldList = strFieldList + ", Corporate" + Request.Form.GetKey(inti)
                                strValueList = strValueList + ", '" & GetCorporateValue(CommonFunction.General.BuildQueryString(Request.Form.GetKey(inti)), Request.Form(Request.Form.GetKey(inti))) + "'"
                            End If
                        End If
                    End If
                End If
                objSchema = Nothing
            Next

            'generate database query to be executed, from fields list and values list
            strDatabaseQuery = strDatabaseQuery + "( " + strFieldList + " ) VALUES ( " + strValueList + " )"

            'append for getting Issue Id of newly created Issue
            strDatabaseQuery += "; Select SCOPE_IDENTITY()"

            'Get newly added IssueId by executing the query.
            intIssueID = CType(CommonFunction.Data.GetDataScalar(strDatabaseQuery, MyBase.UseSQL), Long)

            'Update review actions table with new IssueID
            CommonFunction.Data.InsertOrUpdateData("usp_upd_tbl_PM_ReviewActions_IssueID " + intReviewActionID.ToString + "," + intIssueID.ToString, MyBase.UseSQL)

            'Refresh parent 
            'Modified by ShamkantD on 5 Jan 2005
            If strReviewCategory = "F" Then     'F - Fast Track Review, R - Review
                strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=2191&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
            Else
                strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=1026&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
            End If
            'End of modification - ShamkantD on 5 Jan 2005

            'Send mail - New Issue posted
            Call SendMail(8, intIssueID)



        Else 'Update existing Issue

            'Refresh parent
            'Modified by ShamkantD on 5 Jan 2005
            If strReviewCategory = "F" Then     'F - Fast Track Review, R - Review
                strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=2191&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
            Else
                strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=1026&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
            End If
            'End of modification - ShamkantD on 5 Jan 2005

            Dim drProject, drDummy As IDataReader, strSQLQuery As String

            'Determine if History of the project is enabled.
            drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " + m_ProjectId.ToString, MyBase.UseSQL)
            If drProject.Read Then
                If CType(drProject("IBHistoryOn"), Boolean) = True Then
                    ' If the Description field has changed, then log the changes in the History table.			
                    If StrComp(MyBase.GetFormValue("txtOldDescription").Trim, MyBase.GetFormValue("Description")) <> 0 Then
                        strSQLQuery = "Exec usp_Ins_tbl_IB_History_InsertTextFields " + intIssueID.ToString + ", 'Description', '" + CommonFunction.General.BuildQueryString(m_UserName) + "', '" + MyBase.GetFormValue("txtOldDescription") + "', '" + MyBase.GetFormValue("Description") + "'"
                        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                    End If
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drProject)

            ' Generate the Update Query.
            strDatabaseQuery = strDatabaseQuery & "UPDATE tbl_IB_Issue SET CreatorOrModifier = '" & CommonFunction.General.BuildQueryString(m_UserName) & "'"

            Dim drStatus, drEmailMessage As IDataReader
            Dim inti As Integer

            'Omit first 4 controls on the form as they are static and no hash table can be created for them.
            For inti = 5 To Request.Form.AllKeys.Length - 1
                'Code For ignoring dummy date control added by SandipL on 3 Dec 2005 --IssueID 672  
                If Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                    inti += 1
                    'exit loop if counter excceds upper bound
                    If inti > Request.Form.AllKeys.Length - 1 Then Exit For
                End If

                'Generate schema for the control, containing details about, like fieldname, datatype, size etc.
                Dim objSchema As New CommonFunction.Data.Schema
                objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)


                If Request.Form.GetKey(inti).ToUpper = "ASSIGNTO" Then
                    blnAssignToChanged = True
                End If

                'omit IssueId from query, as it is identity key in the table. 
                If Request.Form.GetKey(inti) <> "IssueID" And Request.Form.GetKey(inti) <> "cboIssue" Then


                    ' Get the field name.
                    strDatabaseQuery = strDatabaseQuery + ", " + Request.Form.GetKey(inti) + " = "

                    ' If the field value is blank, then insert NULL.
                    If Request.Form(Request.Form.GetKey(inti)) = "" Then
                        strDatabaseQuery = strDatabaseQuery & "NULL"
                    Else
                        ' If the field data-type is either integer/boolean/double, then...
                        If objSchema.DataType.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.ToUpper = "SYSTEM.DOUBLE" Then
                            strDatabaseQuery = strDatabaseQuery + FormatNumber(Request.Form(Request.Form.GetKey(inti)), , TriState.False, TriState.False, TriState.False)
                        Else
                            'For other data types
                            strDatabaseQuery = strDatabaseQuery + "'" + CommonFunction.General.BuildQueryString(Request.Form(Request.Form.GetKey(inti))) + "'"
                        End If
                    End If

                    ' If the field is any of the following, then their corporate values must be stored as well.
                    If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Then
                        strDatabaseQuery = strDatabaseQuery + ", Corporate" + Request.Form.GetKey(inti) + " = '" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                    End If
                Else
                    ' If the field data-type is either integer/bit, then...
                    If objSchema.DataType.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.ToUpper = "SYSTEM.DOUBLE" Then
                        strDatabaseQuery = strDatabaseQuery + FormatNumber(Request.Form(Request.Form.GetKey(inti)))
                        ' Else, ...
                    Else
                        If InStr(Request.Form.GetKey(inti), "CustomFieldCombo") <> 0 Then
                            strDatabaseQuery = strDatabaseQuery + "'" + Left(Request.Form(Request.Form.GetKey(inti)), CType(objSchema.ColumnSize, Integer)) + "'"
                        Else
                            strDatabaseQuery = strDatabaseQuery & "'" + CommonFunction.General.BuildQueryString(Request.Form(Request.Form.GetKey(inti))) + "'"
                        End If

                        ' If the field is any of the following, then their corporate values must be stored as well.
                        If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Then
                            strDatabaseQuery = strDatabaseQuery + ", Corporate" + Request.Form.GetKey(inti) + " = '" + GetCorporateValue(CommonFunction.General.BuildQueryString(Request.Form.GetKey(inti)), Request.Form(Request.Form.GetKey(inti))) + "'"
                        End If
                    End If
                End If
                'Dispose the object schema
                objSchema = Nothing
            Next

            'Dispose hash table
            ht = Nothing

            'Add IssueId in where condition (update selected issue)
            strDatabaseQuery = strDatabaseQuery & " WHERE IssueID = " + intIssueID.ToString

            ' Execute the update query.	
            CommonFunction.Data.InsertOrUpdateData(strDatabaseQuery, MyBase.UseSQL)

            'Update review actions table with new IssueID
            CommonFunction.Data.InsertOrUpdateData("usp_upd_tbl_PM_ReviewActions_IssueID " + intReviewActionID.ToString + "," + intIssueID.ToString, MyBase.UseSQL)

        End If

        'Determine if responsible person is changed
        If blnAssignToChanged = True Then
            If MyBase.GetFormValue("txtOldAssignTo").ToString.Trim.ToUpper <> MyBase.GetFormValue("AssignTo").ToString.Trim.ToUpper Then
                ' Call the function to assign the issue to the employee.
                Call AssignIssueToEmployee(intIssueID, Trim(Request.Form("AssignTo")))
            End If
        End If

        ' Set Active List to action list.
        Session("PM_Review_ActiveList") = "A"

    End Sub 'Save / Update / Import Issue

    Sub AssignIssueToEmployee(ByVal intIssueID As Long, ByVal strNewAssignTo As String)
        '==================================================================================
        ' Procedure Name		:	AssignIssueToEmployee
        ' Parameters Passed		:	intIssueID		:- The Issue ID.
        '							strNewAssignTo	:- New Value of AssignTo.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	None.
        ' Purpose				:	If the Issue has been assigned to a resource, then a mail is sent to the concerned resource.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	30 Mar 2004
        ' Revisions				:	
        '==================================================================================

        Dim blnSendEmail, blnShowPopup As Boolean
        Dim strToEmailID, strSubject, strEmailMessage As String
        Dim strFromEmailID, strCCToEmailID As String

        Dim drEmailMessage As IDataReader
        Dim strSQLQuery As String = ""
        Dim drIssueDetails As IDataReader
        Dim intEmployeeID As Integer

        If strNewAssignTo.Trim = "" Then
            strNewAssignTo = "NULL"
            intEmployeeID = 0
        Else
            intEmployeeID = CInt(strNewAssignTo)
        End If

        strSQLQuery = ""
        ' Add a new Task in the Project Task table.
        drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " & intIssueID.ToString, MyBase.UseSQL)
        If drIssueDetails.Read Then

            ' Deactivate the tasks that had been assigned to some other resources earlier.
            strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET IsActive = 0 WHERE OtherTaskID = " & intIssueID.ToString & " AND WhichTask = 'B' "
            strSQLQuery = strSQLQuery & "AND EmployeeID <> " & intEmployeeID.ToString & ""

            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            ' Assign the Tasks to the selected resources.							
            strSQLQuery = "EXEC usp_Ins_IB_AssignIssueToEmployee " & intIssueID.ToString & ", " & m_ProjectId.ToString & ", " & intEmployeeID.ToString

            ' Store the Duration as the estimated Work.
            If drIssueDetails("Duration").ToString = "" Then
                strSQLQuery = strSQLQuery & ", NULL"
            Else
                strSQLQuery = strSQLQuery & ", " & drIssueDetails("Duration").ToString
            End If

            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            ' This query will delete all the unused and inactive tasks associated with the Issue.
            strSQLQuery = "DELETE tbl_PM_ProjectTasks FROM tbl_PM_ProjectTasks T WHERE T.OtherTaskID = " & intIssueID.ToString
            strSQLQuery = strSQLQuery & "AND T.WhichTask = 'B' AND T.IsActive = 0 AND NOT EXISTS "
            strSQLQuery = strSQLQuery & "(	SELECT TOP 1 D.DailyActivityEntryID FROM tbl_PM_DailyActivity D WHERE D.TaskID = T.TaskID )"

            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        Else
            Exit Sub
        End If
        CommonFunction.Data.DisposeDataReader(drIssueDetails)

        ' If the Issue has not been assigned to anyone, then exit the subroutine. (No mail will be sent in this case.)
        If strNewAssignTo = "NULL" Then
            Exit Sub
        End If

        ' Retrieve the details of the message to be sent to the Resource.
        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 14", MyBase.UseSQL)
        If drEmailMessage.Read Then
            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drEmailMessage)

        ' Check if the mail has to be sent.
        If blnSendEmail = True Then
            ' Check if a popup message has to be shown.
            If blnShowPopup = True Then
                strOnloadClientScript = strOnloadClientScript & "window.open(""../General/SendEmail.aspx?MessageID=14&IssueID=" + intIssueID.ToString + "&EmployeeIDList=" + strNewAssignTo + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");"
                ' Else, if the mail has to be sent silently, then...
            Else
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intIssueID, strNewAssignTo)
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
        End If

    End Sub


    Private Sub SendMail(ByVal MessageId As Integer, ByVal IssueId As Long)
        '=====================================================================
        ' Procedure Name        : SendMail()	
        ' Purpose               : To send mail for given messageId and IssueId
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : mar 8, 2004
        ' Revisions             :
        '=====================================================================

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
                If blnShowPopup Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "		window.open(""../General/SendEmail.aspx?MessageID=8&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                Else
                    'If mail is to be send silently
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_8(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If

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
                If blnShowPopup = True Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "		window.open(""../General/SendEmail.aspx?MessageID=34&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                    ' Else, if the mail has to be sent silently, then...
                Else
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If

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

                ' Check if a popup message has to be shown.
                If blnShowPopup = True Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "		window.open(""../General/SendEmail.aspx?MessageID=41&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                    ' Else, if the mail has to be sent silently, then...
                Else
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_41(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
        End Select
    End Sub

    Private Sub GetCurrentType()
        '=====================================================================
        ' Procedure Name        : GetIssueDetails()	
        ' Purpose               : to get issue details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : mar 8, 2004
        ' Revisions             :
        '=====================================================================

        ' If the default values have to shown, then retrieve the default type for the project.
        If blnShowDefaults = True Then
            ' Get the default Type for the current Project.
            Dim strSQLQuery As String = "Exec usp_Sel_tbl_IB_Project_Sub_Type_GetReviewType " + m_ProjectId.ToString
            Dim drDefaultValue As IDataReader
            drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drDefaultValue.Read Then
                strCurrentType = drDefaultValue("Type").ToString.Trim
            End If
            CommonFunction.Data.DisposeDataReader(drDefaultValue)
        End If

        ' If the recordset contents have to be shown, then...
        If blnShowRecordSetContents = True Then
            strCurrentType = drIssueDetails("Type").ToString.Trim
        End If

        ' If the form contents have to be shown, then...
        If blnShowFormContents = True Then
            If Not Request.Form("Type") Is Nothing Then
                strCurrentType = Request.Form("Type")
            Else
                strCurrentType = ""
            End If
        End If

    End Sub 'get default type for the project


    Private Sub GenerateIssueDetailsSection()
        '=====================================================================
        ' Procedure Name        : GenerateIssueDetailsSection
        ' Purpose               : To generate Issue details section
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize Resource file for IssueList
        MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

        'Information section for Issue list page
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle

        With cObjSectionTitle
            Dim strIssueId As String

            'Display IssueId - In AddNew mode show [Not Assigned] and in EditMode show IssueID 
            If intIssueID = 0 Then
                strIssueId = MyBase.GetResourceString("NOTASSIGNED")
            Else
                strIssueId = intIssueID.ToString
            End If

            'display current Issue ID
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("ISSUEDETAILSLEFTSECTIONTITLE"), "DivIssueDetails", "ShowHideIssueDetails", , GetUserFriendlyName("IssueID") + " : [" + strIssueId + "]", AllowHideShow:=False))

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With

        'Div for section title
        Response.Write("<DIV Id='DivIssueDetails' Style='Overflow:Auto'>")

        CommonFunctions.General.WriteHTML("<table width='99.9%' cellspacing='0' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")
        CommonFunctions.General.WriteHTML("<td valign='top' align='right'>")

        'Hidden conrols for mail 
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("IssueID", "IssueID", , , , intIssueID.ToString, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("ReviewActionID", "ReviewActionID", , , , intReviewActionID.ToString, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If strMode.ToUpper = "NEW" Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtOldAssignTo", "txtOldAssignTo", , , , , IsHidden:=True, EnableHTMLEncode:=True)
        Else
            CommonFunction.HTMLControls.DrawTextBox("txtOldAssignTo", "txtOldAssignTo", , , , intEmployeeID.ToString, IsHidden:=True, EnableHTMLEncode:=True)

        End If

        CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , , IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Summary 
        'Form contents to be shown ? (Preserve / persist form values ?)
        If blnShowFormContents = True Then
            If Not MyBase.GetFormValue("Summary") Is Nothing Then
                strFieldValue = MyBase.GetFormValue("Summary")
            Else
                strFieldValue = ""
            End If
        ElseIf blnShowRecordSetContents = True Then 'Show values from database (For Edit mode / refresh after add new - save) ? 
            If intIssueID > 0 Then
                strFieldValue = drIssueDetails("Summary").ToString
            End If
        End If

        Call GetControlAttributes("Summary", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td valign='top'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Description caption
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")
        CommonFunctions.General.WriteHTML("<td valign='top' align='right'>")

        'Form contents to be shown ? (Preserve / persist form values ?)
        If blnShowFormContents = True Then
            If Not MyBase.GetFormValue("Description") Is Nothing Then
                strFieldValue = MyBase.GetFormValue("Description")
            Else
                strFieldValue = ""
            End If
        ElseIf blnShowRecordSetContents = True Then 'Show values from database (For Edit mode / refresh after add new - save) ? 
            If intIssueID > 0 Then
                strFieldValue = drIssueDetails("Description").ToString
            End If
        End If

        Call GetControlAttributes("Description", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("<br>")

        'Insert Time stamp
        CommonFunctions.General.WriteHTML("<a HREF='javascript:InsertTimeStamp()'><img SRC='../../images/time.gif' border='0' alt='Insert DateTimeStamp' WIDTH='17' HEIGHT='17'></a>					")
        CommonFunctions.General.WriteHTML("</td>")

        'Description - control
        CommonFunctions.General.WriteHTML("<td valign='top'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        '<input type="hidden" id="txtOldDescription" name="txtOldDescription" value=" If Not rsIssueDetails.EOF Then Response.Write Replace(Server.HTMLEncode(Trim(rsIssueDetails("Description")&"")), """", "&quot;") End If ">						
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table ID='tblDefaultFields' width='99.9%' cellspacing='0' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")
        'Module name
        CommonFunctions.General.WriteHTML("<td  align='right' width='10%'>")
        Call GetControlAttributes("ModuleName", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left' width='15%'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Reported By
        CommonFunctions.General.WriteHTML("<td  align='right' width='10%'>")
        Call GetControlAttributes("ReportedBy", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left' width='15%'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Reported Date
        CommonFunctions.General.WriteHTML("<td  align='right' width='10%'>")
        Call GetControlAttributes("ReportedDate", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left' width='15%'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")

        'Coded By
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("CodedBy", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Assign To
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("AssignTo", strFieldValue, ArrCtlAttr)
        Response.Write("Assigned To")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Due date
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("Duedate", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")

        'Priority
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("Priority", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("PriorityFixInDays", "Exec usp_Sel_tbl_IB_Project_Priorities_FixInDays " + m_ProjectId.ToString, , , "style='display:none'"))
        'strOnloadClientScript = strOnloadClientScript & vbCrLf & "  Priority_OnChange();" & vbCrLf

        '<SCRIPT LANGUAGE=vbscript>
        '<!--
        '     Call Priority_OnChange()
        '-->
        '</SCRIPT>			
        CommonFunctions.General.WriteHTML("</td>")

        'Severity
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("Severity", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Duration
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("Duration", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")

        'Type
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("Type", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Status
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        If Request.QueryString("Action") = "TypeChange" Then
            blnShowDefaults = True
        End If
        Call GetControlAttributes("Status", strFieldValue, ArrCtlAttr)
        If Request.QueryString("Action") = "TypeChange" Then
            blnShowFormContents = True
        End If
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'SubType
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        If strAction.ToUpper = "TYPECHANGE" Then
            blnShowDefaults = True
        End If
        Call GetControlAttributes("SubType", strFieldValue, ArrCtlAttr)
        If Request.QueryString("Action") = "TypeChange" Then
            blnShowFormContents = True
        End If
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")

        'Phase
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("Phase", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'FOund In Phase
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("FoundInPhase", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        'Reported In Version
        CommonFunctions.General.WriteHTML("<td  align='right'>")
        Call GetControlAttributes("ReportedInVersion", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement No.:IB_PBN_ENT_04
        'Addition   :   Added the code to display reported time
        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")
        'Reported Time
        CommonFunctions.General.WriteHTML("<td  align='right' >")
        Call GetControlAttributes("ReportedTime", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")

        '===============================================================================
        'Added By       PadmnabhA
        'IssueID        15368
        'Description    To add Delieverables from Fast Track Review page
        '===============================================================================

        'CommonFunctions.General.WriteHTML("<td  align='left'>")
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td  align='left'>")
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td  align='left'>")
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td  align='left'>")
        'CommonFunctions.General.WriteHTML("</td>")

        'CommonFunctions.General.WriteHTML("</tr>")
        '***********End Addition

        ' CommonFunctions.General.WriteHTML("<tr class=clsTREven>")

        CommonFunctions.General.WriteHTML("<td  align='left' >")
        Call GetControlAttributes("DeliverableID", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align='left'>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        '===============================================================================
        '               Code Addition By PadmnabhA Ends
        '===============================================================================

        CommonFunctions.General.WriteHTML("</table>")

    End Sub

    Private Sub ClearAttributes(ByRef arrCtlAttr As String())
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	arrCtlAttr : This array has to be re-initialised for each control
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets reinitialised.
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Mar 8, 2004
        ' Revisions				:	
        '==================================================================================		

        Dim intCtr As Integer

        For intCtr = 0 To 14
            arrCtlAttr(intCtr) = ""
        Next

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False"

    End Sub 'Clear control Atributes

    Private Sub DrawControl(ByRef ArrCtlAttr() As String)
        '==================================================================================
        ' Procedure Name		:	DrawControl
        ' Parameters Passed		:	arrCtlAttr : This array contains the attributes of the control to be drawn.
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets modified.
        ' Purpose				:	To actually draw the control as per the specifications in the array.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Mar 8, 2004
        ' Revisions				:	
        '==================================================================================		

        Dim strToBeInserted As String = ""
        Dim strProperty As String
        Dim intCtr As Integer

        Dim strControlName As String
        Dim strControlValue As String = ""
        Dim SQLQuey As String
        Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
        Dim blnReadOnly As Boolean = False
        Dim blnIsMandatory As Boolean = False
        Dim blnIsDisabled As Boolean = False

        ' If the default values have to be shown, then... (When the page is loaded for the first time.)
        If blnShowDefaults = True Then
            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
        End If

        If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) Is Nothing Then
            strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)
        Else
            strControlValue = ""
        End If

        'Control Name
        strControlName = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)

        ' control width 
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH)) <> "" Then
            intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH), Integer)
        End If

        'Cotrol Height
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT)) <> "" Then
            intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT), Integer)
        End If

        ' Read Only
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True" Then
            blnReadOnly = True
            strToBeInserted = strToBeInserted & " disabled "
            blnIsDisabled = True
        Else
            blnReadOnly = False
            blnIsDisabled = False
        End If

        ' additional information.
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO)) <> "" Then
            strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO)) + " "
        End If

        ' maxlength 
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then
            strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) + " "
        End If

        ' mandatory 
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True" Then
            blnIsMandatory = True
        Else
            blnIsMandatory = False
        End If


        ' Depending on the control type, draw the control.
        Select Case ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)
            '==========================================================================================
            'Modified By    PadmnabhA
            'Description    To draw Deliverable text box on Page 
            'IssueId        15368
            'Date           17-Jan-2005
            '==========================================================================================
        Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.
                Dim strAlignment As String
                If strControlName.ToUpper = "DELIVERABLEID" Then
                    Dim strDeliverableName As String
                    Dim drGetDeliverable As IDataReader
                    Dim strSQL As String
                    If strControlValue <> "" Then
                        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                        'strSQL = "Select Title From tbl_PM_OtherSchedules Where Scheduleid = " + CType(strControlValue, String)
                        strSQL = "usp_sel_tbl_PM_OtherSchedules_Title_Scheduleid " + CType(strControlValue, String)
                        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

                        drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        If drGetDeliverable.Read Then
                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                    End If

                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , 20, intControlMaxLength, strControlValue, , , , , "", True, strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write("<Input  Type=Textbox  name='txtDeliverable' id='txtDeliverableID' class='clsTextBox' disabled = 'true' style='width:200px'  maxlength=100 style='' value='" + CType(strDeliverableName, String) + "' style='text-align:left' style='BACKGROUND-COLOR='>")
                    Response.Write("&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'JavaScript:SelectDeliverable()'>")
                ElseIf strControlName.ToUpper = "DURATION" Then
                    strAlignment = "Right"

                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, strAlignment, , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                Else
                    strAlignment = "Left"

                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, strAlignment, , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If
                '==========================================================================================
                'Modification By PadmnabhA Ends
                '==========================================================================================

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                SQLQuey = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY)
                Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , , blnIsMandatory))

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIBIssueEntry", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory))
                Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIBIssueEntry", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_CHECK_BOX.ToString  ' Draw the check box.

                If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)) = "True" Or Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)) = "1" Then
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "1"
                Else
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "0"
                End If
                strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)

                Response.Write(CommonFunction.HTMLControls.DrawCheckBox(strControlName, strControlName, , CType(strControlValue, Boolean), , , strToBeInserted, , blnIsMandatory, , True))

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
                If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) Is Nothing Then
                    If Not IsDate(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE).Trim) Then
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                    End If
                Else
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                If strControlValue <> "" Then
                    Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmIssueEntryForReview", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                Else
                    Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmIssueEntryForReview", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                End If

            Case Else
                Response.Write("&nbsp;")
        End Select

    End Sub 'Draw the control 

    Private Sub GetControlAttributes(ByVal strFieldName As String, ByVal strFieldValue As String, ByRef arrCtlAttr() As String)
        '==================================================================================
        ' Procedure Name		:	GetControlAttributes
        ' Parameters Passed		:	strFieldName  :- The field name.
        '							strFieldValue :- The field value.
        '							arrCtlAttr	  :- The array gets modified.
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr    : The control attributes are set in this array.
        ' Purpose				:	To set the attributes of the control.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Mar 8, 2004
        ' Revisions				:	
        '==================================================================================		
        Dim drDefaultValue As IDataReader
        Dim strSQLQuery As String

        If strFieldName.ToUpper = "CODEDBYNAME" Then strFieldName = "CodedBy"

        If blnShowFormContents = True Then
            strFieldValue = MyBase.GetFormValue(strFieldName)
        ElseIf blnShowRecordSetContents = True Then
            If blnIssuePresent = True Then
                strFieldValue = drIssueDetails(strFieldName).ToString
            Else
                strFieldValue = ""
            End If
        End If

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = GetUserFriendlyName(strFieldName)
        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = Trim(strFieldName)
        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "False"

        Dim drLayout As IDataReader

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "150"

        If strFieldValue <> "" Then
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.General.UnBuildQueryString(strFieldValue)
        Else
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strFieldValue
        End If

        Select Case UCase(Trim(strFieldName))

            Case "ASSIGNTO", "ASSIGNTONAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "150"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intEmployeeID.ToString  'strReviewee

                If strFieldValue <> "" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) & ", " & strFieldValue
                End If

                If intIssueID <> 0 And arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "150"
                End If

            Case "CHANGEREQUESTID", "CHANGEREQUESTNAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_ChangeRequest_Master " + m_ProjectId.ToString

            Case "CODEDBY", "CODEDBYNAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intEmployeeID.ToString  'strReviewee
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "CodedBy"

            Case "CORRECTEDINVERSION"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Version " + m_ProjectId.ToString

            Case "CUSTOMERISSUEID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "30"

            Case "DESCRIPTION"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "650"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT) = "60"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

                '' Modified By ParagD for IssueID : 21176 - Mascon.
                '' Changed strCause TO strReviewAction
                '' arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strCause
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strReviewAction
                '' Modification Ended By ParagD for IssueID : 21176 - Mascon.


            Case "DUEDATE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

                If Not Request.Form("PriorityFixInDays") Is Nothing Then
                    If Request.Form("PriorityFixInDays").ToString <> "" Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = DateAdd(DateInterval.Day, CType(Request.Form("PriorityFixInDays").ToString, Double), Now()).ToString
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = DateAdd(DateInterval.Day, 0, Now()).ToString
                    End If
                End If

            Case "DURATION"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "4"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "70"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = "13,"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

                strSQLQuery = "EXEC usp_Sel_tbl_PM_ReviewActions " + intReviewActionID.ToString
                Dim drAction As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drAction.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drAction("WorkInHours").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drAction)

            Case "FIXEDINPHASE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString

            Case "FOUNDINPHASE"
                ' Get the current phase of the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Phases " + m_ProjectId.ToString + ", NULL, 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Phase").ToString.Trim + ""
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strProjectPhase

            Case "HARDWARE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_ProjectHardware " + m_ProjectId.ToString

            Case "IMPORTID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "25"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = "13,"

            Case "KERNEL"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Kernels " + m_ProjectId.ToString

            Case "KEYWORDS"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Keywords " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "180"

            Case "MODULENAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_Module_ProjectGroup " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strModuleName

            Case "OS"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_OS " + m_ProjectId.ToString

            Case "PHASE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strProjectPhase
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString

            Case "PRIORITY"

                ' Get the default priority for the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Priorities " + m_ProjectId.ToString & ", 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Priority").ToString.Trim
                End If

                CommonFunction.Data.DisposeDataReader(drDefaultValue)
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange = Priority_OnChange()"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Priorities " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

                Response.Write(CommonFunction.HTMLControls.DrawComboBox("PriorityFixInDays", "Exec usp_Sel_tbl_IB_Project_Priorities_FixInDays " + m_ProjectId.ToString, displaynone:=True))

                'strOnloadClientScript = strOnloadClientScript & vbCrLf & "Call Priority_Onchange()" & vbCrLf

            Case "REPORTEDBY"

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + m_ProjectId.ToString + ", " + m_UserId.ToString + ", 1"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strReviewer

            Case "REPORTEDDATE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = CommonFunction.Dates.GetDate(Now())
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

            Case "REPORTEDINVERSION"

                ' Get the current version number of the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Version " + m_ProjectId.ToString + ", NULL, 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Versions").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Version " + m_ProjectId.ToString

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Reported Time Feature
                'Date   :   1 July 2004
                'Requirement No.:IB_PBN_ENT_04
                'Addition   :   Added the case for Reported Time
            Case "REPORTEDTIME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "50"
                If Now.Minute.ToString.Length < 2 Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = Now.Hour.ToString + ":0" + Now.Minute.ToString
                Else
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = Now.Hour.ToString + ":" + Now.Minute.ToString
                End If
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "5"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "onkeypress=""Time_OnKeyPress(event)"""
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True" 'Added By PadmnabhA IssueID 15368
                '************End Addition*************
                '=============================================
                'Added By               PadmnabhA
                'Issue ID               15368
                'Addition               Added the case for Deliverables
                '=============================================
            Case "DELIVERABLEID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'strSQLQuery = "Select DeliverableID from Tbl_pm_ReviewStatistics where ReviewStatisticsID = " & intReviewStatisticsID
                strSQLQuery = "usp_sel_Tbl_pm_ReviewStatistics_DeliverableID " & intReviewStatisticsID
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("DeliverableID").ToString.Trim
                End If

            Case "SEVERITY"

                ' Get the default severity for the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Severity " + m_ProjectId.ToString & ", 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Severity").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Severity " + m_ProjectId.ToString

            Case "STATUS"

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   30 June 2004
                'Requirement No.:IB_PBN_ENT_01
                'Addition   :   Added Code To Check Whether Security is applied for given Role and Project.

                'Check if there is any Security applied for given Role for given projectID.
                Dim drTypeAccess As IDataReader
                Dim strSQLForRole As String
                Dim blnDefaultAccessible As Boolean
                Dim blnRecordsExist As Boolean

                'Get the Types accessible for 
                strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & m_ProjectId & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

                blnDefaultAccessible = False
                blnRecordsExist = False

                '*******End Of Addition********


                ' Get the default sub-type for the current type.
                strSQLQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(strCurrentType.Trim) + "'"
                drDefaultValue = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    '**********Code Commented By DipaliS 30 June 2004**********
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Status").ToString.Trim

                    '**********Code Added*******
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   30 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition : If default status is not accessible , then set it to Blank.

                    'If any record found that means security is explicitly set for the Role for that project
                    While drTypeAccess.Read
                        blnRecordsExist = True
                        'If the default type is not present then set the flag for same.
                        If drDefaultValue("Status").ToString.Trim = CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("Status")), String) _
                         And CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("TypeName")), String).ToLower.Trim = strCurrentType.ToLower.Trim Then
                            blnDefaultAccessible = True
                            Exit While
                        End If
                    End While

                    'If Secuirity is set and access is not there then set the default value to blank.
                    If blnDefaultAccessible = False And blnRecordsExist = True Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = ""
                    Else
                        'Else set it as usual
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Status").ToString.Trim
                    End If

                    '**********End Addition By DipaliS**********

                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                '**********Code Added By DipaliS 30 June 2004
                CommonFunction.Data.DisposeDataReader(drtypeaccess)
                '**********End Addition By DipaliS**********

                If intIssueID <> 0 Then
                    'If Not drIssueDetails.EOF Then
                    If strCurrentType = drIssueDetails("Type").ToString.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drIssueDetails("Status").ToString
                    End If
                    'End If

                    '**********Code Added*******
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   30 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition :
                    'If in edit mode the status is not accessible then disable the combo for status.
                    strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                    strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & drIssueDetails("ProjectID").ToString & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf

                    drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)
                    blnDefaultAccessible = False
                    blnRecordsExist = False

                    While drTypeAccess.Read
                        blnRecordsExist = True
                        'If the default type is not present or if the selected type is not current type then set the flag for same. 
                        If drIssueDetails("Status").ToString.ToLower.Trim = CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("Status")), String).ToLower.Trim _
                                And CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("TypeName")), String).ToLower.Trim = strCurrentType.ToLower.Trim Then
                            blnDefaultAccessible = True
                            Exit While
                        End If
                    End While

                    'If the status is not accessible , then disable the combo box
                    If blnDefaultAccessible = False And blnRecordsExist = True And strCurrentType.Trim <> "" And strCurrentType.ToLower.Trim = drIssueDetails("Type").ToString.ToLower.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True"
                    End If

                    CommonFunction.Data.DisposeDataReader(drtypeaccess)
                    '**********End Addition**********
                End If

                ' Whenever the default values are to be shown, set the current value to "". 
                ' This has to be done specifically for Status and sub-type, because these values must be set to the default everytime the type changes.
                If blnShowDefaults = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

                If intIssueID <> 0 Then
                    '**********Code commented By Dipalis 30 June 2004 and added the following line
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(strCurrentType.Trim) + "'"

                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   30 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition :
                    'Changed the SQL for Combo box.
                    If strCurrentType.ToLower.Trim = CType(CommonFunction.General.CheckIsNothing(drIssueDetails("Type")), String).ToLower.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(strCurrentType.Trim) + "'" + ",Null,Null," + _
                                                    m_RoleId.ToString + ",'" + CommonFunction.General.BuildQueryString(drIssueDetails("Status").ToString) + "'"
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(strCurrentType.Trim) + "'" + ",Null,Null," + _
                                                                            m_RoleId.ToString
                    End If

                    '**********End Addition**********
                Else
                    '**********Code commented By Dipalis 30 June 2004 and added the following line
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + m_ProjectId.ToString + ", '" & CommonFunction.General.BuildQueryString(strCurrentType.Trim) & "'"

                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   30 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition :
                    'Changed the SQL for Combo box.
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + m_ProjectId.ToString + ", '" & CommonFunction.General.BuildQueryString(strCurrentType.Trim) & "'" + "," + m_RoleId.ToString
                    '**********End Addition**********
                End If

            Case "SUBTYPE"

                ' Get the default sub-type for the current type.
                strSQLQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S', " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(strCurrentType.Trim) + "'"
                drDefaultValue = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("SubType").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                If intIssueID <> 0 Then
                    'If Not drIssueDetails.EOF Then
                    If strCurrentType = drIssueDetails("Type").ToString.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drIssueDetails("SubType").ToString.Trim
                    End If
                    'End If
                End If

                ' Whenever the default values are to be shown, set the current value to "". 
                ' This has to be done specifically for Status and sub-type, because these values must be set to the default everytime the type changes.				
                If blnShowDefaults = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'S', '" + CommonFunction.General.BuildQueryString(strCurrentType.Trim) + "'"

            Case "SUMMARY"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "650"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "512"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strCause

            Case "TYPE"
                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   30 June 2004
                'Requirement No:IB_PBN_ENT_01
                'Addition Made: Code added for the condition:
                'If current Role is not having access for default type, then show the default type as blank.

                'Check if there is any Security applied for given Role for given projectID.
                Dim drTypeAccess As IDataReader
                Dim strSQLForRole As String
                Dim blnDefaultAccessible As Boolean
                Dim blnRecordsExist As Boolean
                Dim drDefault As IDataReader

                'Get the Types accessible for 
                'strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                'strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity " & m_ProjectId & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                'drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)
                strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & m_ProjectId & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                drDefault = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

                blnDefaultAccessible = False
                blnRecordsExist = False

                'If any record found that means security is explicitly set for the Role for that project
                'While drTypeAccess.Read
                '    blnRecordsExist = True
                '    'If the default type is not present then set the flag for the same.
                '    If strCurrentType.ToLower.Trim = CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("TypeName")), String).ToLower.Trim Then
                '        blnDefaultAccessible = True
                '        Exit While
                '    End If
                'End While

                While drDefault.Read
                    blnRecordsExist = True
                    If strCurrentType.ToLower.Trim = CType(CommonFunctions.General.CheckIsNothing(drDefault("TypeName")), String).ToLower.Trim Then
                        blnDefaultAccessible = True
                        Exit While
                    End If
                End While
                CommonFunctions.Data.DisposeDataReader(drDefault)

                If blnDefaultAccessible = False And blnRecordsExist = True Then
                    strCurrentType = ""
                End If

                '*******End Of Addition********

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strCurrentType
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=Type_OnChange()"

                '********Code Commented By DipaliS and added the following
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'T'"

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   30 June 2004
                'Requirement No:IB_PBN_ENT_01
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'T'" + ",Null,Null,Null,Null,Null," + m_RoleId.ToString
                '*******End Addition**********


                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"

                If blnShowTimesheetDetails = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True"
                End If

            Case Else

        End Select

        If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True" Then
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "1,"
        End If

        If Trim(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
        End If
    End Sub 'Get the control attributes

    Private Sub GeneratePageLegends()
        '=====================================================================
        ' Procedure Name        : GeneratePageLegends()	
        ' Purpose               : To generate page legends
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

    End Sub 'Generate Page Legends


    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        With objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            m_ProjectId = .ProjectID
            m_UserId = .UserID
            m_UserName = .UserName
            m_CultureId = .LCID
            m_FromWhere = .FromWhere
        End With

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        objAccess = Nothing
    End Sub 'Get all session variable values

    Private Sub SetVariables()

        'Project ID
        If Not Request.QueryString("ProjectID") Is Nothing Then
            If Request.QueryString("ProjectID") <> "" Then
                m_ProjectId = CType(Request.QueryString("ProjectID"), Integer)
            End If
        End If

        'Review statistics ID
        If Not Request.QueryString("ReviewStatisticsID") Is Nothing Then
            If Request.QueryString("ReviewStatisticsID") <> "" Then
                intReviewStatisticsID = CType(Request.QueryString("ReviewStatisticsID"), Integer)
            End If
        End If

        'Review Action ID
        If Not Request.QueryString("ReviewActionID") Is Nothing Then
            If Request.QueryString("ReviewActionID") <> "" Then
                intReviewActionID = CType(Request.QueryString("ReviewActionID"), Integer)
            End If
        End If

        'Added by ShamkantD on 5 Jan 2005
        'Review Categoty: F - Fast Track Review, R - Review
        If Not Request.QueryString("ReviewCategory") Is Nothing Then
            If Request.QueryString("ReviewCategory") <> "" Then
                strReviewCategory = Request.QueryString("ReviewCategory").ToString().ToUpper()
            End If
        End If
        'End of addition - ShamkantD on 5 Jan 2005

        If intReviewStatisticsID <> 0 Then
            blnIsReview = True
            Dim drReview As IDataReader

            drReview = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewStatistics " + intReviewStatisticsID.ToString, MyBase.UseSQL)
            If drReview.Read Then
                strProjectPhase = CommonFunction.Data.CheckIsDBNull(drReview("ProjectPhase"), "").ToString
                strReviewer = CommonFunction.Data.CheckIsDBNull(drReview("ReviewedBy"), "").ToString
                strReviewee = CommonFunction.Data.CheckIsDBNull(drReview("Reviewee"), "").ToString
                intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(drReview("EmployeeID"), "0"), Integer)
                strReviewDate = CommonFunction.Data.CheckIsDBNull(drReview("ReviewedDate"), "").ToString
                strReviewType = CommonFunction.Data.CheckIsDBNull(drReview("ReviewType"), "").ToString
                intModuleID = CType(CommonFunction.Data.CheckIsDBNull(drReview("ModuleID"), "0"), Integer)
            End If
            CommonFunction.Data.DisposeDataReader(drReview)

            'Module name
            If intModuleID <> 0 Then
                Dim drModule As IDataReader
                drModule = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_Module NULL, " + intModuleID.ToString, MyBase.UseSQL)
                If drModule.Read Then
                    strModuleName = CommonFunction.Data.CheckIsDBNull(drModule("ModuleName"), "").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drModule)
            End If

            'Review cause and review action
            If intReviewActionID <> 0 Then
                Dim drAction As IDataReader
                drAction = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewActions " + intReviewActionID.ToString, MyBase.UseSQL)
                If drAction.Read Then
                    strCause = CommonFunction.Data.CheckIsDBNull(drAction("PReviewCause"), "").ToString
                    strReviewAction = CommonFunction.Data.CheckIsDBNull(drAction("Action"), "").ToString
                End If
                CommonFunction.Data.DisposeDataReader(drAction)
            End If
        Else
            blnIsReview = False
        End If


        ' Get the current Issue ID.
        If Not MyBase.GetFormValue("IssueID") Is Nothing Then
            If MyBase.GetFormValue("IssueID") <> "" Then
                intIssueID = CType(MyBase.GetFormValue("IssueID"), Integer)
            End If
        ElseIf Not Request.QueryString("IssueID") Is Nothing Then
            If Request.QueryString("IssueID").ToString.Trim <> "" Then
                intIssueID = CType(Request.QueryString("IssueID"), Integer)
            End If
        End If

        '' Check whether the IssueID passed is a valid IssueID, and the concerned person is authorized to view the Issue.
        'Dim strSQLQuery As String = "Exec usp_Sel_tbl_IB_Issue_Project " + m_ProjectId.ToString + ", " + intIssueID.ToString + ", '" + m_LoginType + "'"
        'Dim drIssueDetails As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        '' If no record is entered, then display the message, and redirect the person to the List.
        'If Not drIssueDetails.Read Then
        '    Response.Write("<script language=javascript>")
        '    Response.Write("alert('This IssueId does not belong to this Project !!');")
        '    Response.Write("window.location.href = IB_IssueList.aspx;")
        '    Response.Write("</script>")
        'End If

        'CommonFunction.Data.DisposeDataReader(drIssueDetails)

        If intIssueID <> 0 Then
            Dim drTImeSheet As IDataReader
            drTImeSheet = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_DailyActivity_For_Issue " + intIssueID.ToString, MyBase.UseSQL)
            If drTImeSheet.Read Then
                blnShowTimesheetDetails = True
            End If
            CommonFunction.Data.DisposeDataReader(drTImeSheet)
        End If

        ' Get the current mode.
        If intIssueID > 0 Then
            strMode = "Edit"
        Else
            strMode = "New"
        End If
        'If Not Request.QueryString("Mode") Is Nothing Then
        '    If Request.QueryString("Mode").ToString.Trim <> "" Then
        '        strMode = Request.QueryString("Mode")
        '    Else
        '        If intIssueID = 0 Then
        '            strMode = "New"
        '        Else
        '            strMode = "Edit"
        '        End If
        '    End If
        'Else
        '    If intIssueID = 0 Then
        '        strMode = "New"
        '    Else
        '        strMode = "Edit"
        '    End If
        'End If

        ' Get the action to be performed.
        If Not Request.QueryString("Action") Is Nothing Then
            If Request.QueryString("Action") <> "" Then
                strAction = Request.QueryString("Action")
            End If
        End If

        ' If a new issue is being entered, and the user has accessed the page for the first time, then show the default values.
        If strMode = "New" Then 'And MyBase.GetFormValue("IssueID").Trim = "" Then
            If strAction = "TypeChange" Then
                blnShowFormContents = True
                blnShowDefaults = False
            ElseIf strAction = "Save" Then
                blnShowRecordSetContents = True
            Else
                blnShowDefaults = True
            End If

        ElseIf strMode = "Edit" Then
            If strAction = "TypeChange" Then
                blnShowFormContents = True
                blnShowDefaults = False
            Else
                blnShowRecordSetContents = True
            End If
            ' If an existing issue has to be shown, and the user has accessed the page for the first time, then show the recordset contents.
        Else
            ' If the user has made changes, and the type has been changed, then the form is submitted. So the form contents must be displayed in that case.
            blnShowFormContents = True
        End If



        ' If a new issue is being entered, and the user has accessed the page for the first time, then show the default values.
        If strMode = "New" Then 'And MyBase.GetFormValue("IssueID").Trim = "" Then
            If strAction = "TypeChange" Then
                blnShowFormContents = True
                blnShowDefaults = False
            ElseIf strAction = "Save" Then
                blnShowRecordSetContents = True
            Else
                blnShowDefaults = True
            End If
        ElseIf strMode = "Edit" Then
            If strAction = "TypeChange" Then
                blnShowFormContents = True
                blnShowDefaults = False
            Else
                blnShowRecordSetContents = True
            End If
            ' If an existing issue has to be shown, and the user has accessed the page for the first time, then show the recordset contents.
        Else
            ' If the user has made changes, and the type has been changed, then the form is submitted. So the form contents must be displayed in that case.
            blnShowFormContents = True
        End If

    End Sub

#End Region

#Region " Private Functions "

    Private Function GetUserFriendlyName(ByVal strFieldName As String) As String
        '=====================================================================
        ' Procedure Name        : GetUserFriendlyName()	
        ' Purpose               : To get user friendly field name for given field
        ' Description           : same as above
        ' Parameters Passed     : strFieldName - Actual Field name
        ' Returns               : user friendly field name (string)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        If strFieldName.ToUpper = "CODEDBY" Then strFieldName = "CodedByName"

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_CultureId Then
            strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'"
        Else
            strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary_Culture '" + Trim(strFieldName) + "'," + m_CultureId.ToString
        End If

        Dim drUserFriendlyName As IDataReader

        drUserFriendlyName = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drUserFriendlyName.Read Then
            Return drUserFriendlyName("USerFriendlyName").ToString
        Else
            Return "Not Specified"
        End If
        CommonFunctions.Data.DisposeDataReader(drUserFriendlyName)
    End Function 'Get user friendly name for field

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the Issue entry page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 8, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips


        'Show TimeSheet Details
        If blnShowTimesheetDetails = True And m_FromWhere <> "DB" Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOWTIMESHEETDETAILS"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOWTIMESHEETDETAILS_TOOLTIP"))
            ArrClientSideFunctionsList.Add("ShowTimeSheet_OnClick()")
        End If

        'Save Issue
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Save_OnClick()")

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('IB_ISSUE_DETAILS')")

        'Convert arraylist to array - Menu captions
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

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
