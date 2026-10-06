Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web
Imports Microsoft.VisualBasic
Imports System.IO
Imports ProjectByNet.Connection
Imports System.Resources
Imports System.Web.Mail
Imports System.Data.OleDb
Imports CommonFunctions
Imports CommonFunctions.Data
Imports System.Collections
Imports System.Threading

'=====================================================================
' Class	Name	        :	CommonFunction
' Purpose				:	This class is specially build all common functions used in the application
'                           All memebers of this class is shared one.
' Description			:	
' Assumptions			:	None
' Dependencies			:	None
' Author				:	AshishR
' Created				:	9 Aug 2003
' Revisions				:	
'=====================================================================

Namespace RM_CommonFunction

    Public Delegate Function dlgGetQuerySrtingValues() As String

    Public Class Emails
        Inherits CommonFunctions.Emails
        Public Shared Sub AppSendEmail(ByVal strToEmailID As String, ByVal strFromEmailID As String, ByVal strSubject As String, ByVal strEmailBody As String)
            '============================================================================
            'Procedure Name		: AppSendEmail
            'Description		: This is wrapper on the framework Routine to send email to the address specified
            '					  Address of the sender is compulsory.
            '					  Other paramters passed are Sub and Body text of the email
            'Return Values		: None
            'Author				: UmeshJ
            'Created			: 19 mar 2004
            '============================================================================
            Try
                Call CommonFunctions.Emails.SendEmail(strToEmailID, strFromEmailID, strSubject, strEmailBody)
            Catch ex As Exception
            End Try
        End Sub

        Public Shared Sub AppSendEmailWithCC(ByVal strToEmailID As String, ByVal strCCToEmailID As String, ByVal strFromEmailID As String, ByVal strSubject As String, ByVal strEmailMessage As String)
            '============================================================================
            'Procedure Name		: AppSendEmailWithCC
            'Description		: This is wrapper on the framework Routine to send email to the address specified.
            '					  Address of the sender is compulsory.
            '					  Other paramters passed are Sub and Body text of the email
            'Return Values		: None
            'Author				: UmeshJ
            'Created			: 19 mar 2004
            '============================================================================
            Try
                Call CommonFunctions.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                'Code added by MrugajaB on 12th Dec 2005
                'Purpose: Implementation of communication feature
                strToEmailID = CommonFunctions.General.BuildQueryString(strToEmailID)
                strCCToEmailID = CommonFunctions.General.BuildQueryString(strCCToEmailID)
                strFromEmailID = CommonFunctions.General.BuildQueryString(strFromEmailID)
                strSubject = CommonFunctions.General.BuildQueryString(strSubject)
                strEmailMessage = CommonFunctions.General.BuildQueryString(strEmailMessage)
                CommonFunction.Data.InsertOrUpdateData("Exec usp_Ins_tbl_CDB_Communication '" & strToEmailID & "','" & strCCToEmailID & "','" & strFromEmailID & "','" & strSubject & "','" & strEmailMessage & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'End Addition
            Catch ex As Exception
            End Try

        End Sub

    End Class
    '=====================================================================
    ' Class	Name	        :	EmailMessages
    ' Purpose				:	This class is specially build all common functions used in the application
    '                           All memebers of this class is shared one.
    ' Description			:	
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	AshishR
    ' Created				:	9 Aug 2003
    ' Revisions				:	
    '=====================================================================

    Public Class EmailMessages
        Inherits CommonFunctions.EmailMessages
        
        Public Class RMMessages
            Public Shared Sub GetEmailMessage_475(ByRef strFromEmailID As String, ByRef strToEmailID As String, ByRef strCCToEmailID As String, ByRef strSubject As String, ByRef strEmailMessage As String, ByVal strApproverName As String)
                '=====================================================================
                ' Procedure Name        :   GetEmailMessage_475
                ' Parameters Passed     :   strToEmailID    :- The EmailID of the person to whom the message will be returned.
                '                           strSubject      :- The Subject of the Email Message.
                '                           strEmailMessage :- The body of the Email Message.
                '                           
                ' Returns               :
                ' Parameters Affected   :   strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
                ' Description           :   Generate the email message as defined in the System Email Messages table in the database.
                ' Purpose               :   Generate the email message as defined in the System Email Messages table in the database.
                ' Assumptions           :   The message ID exists in the database.
                '                           
                ' Dependencies          :   None.
                ' Author                :   RajeshJ
                ' Created               :   03 Jan 2007
                ' Revisions             :	
                '=====================================================================

                Dim strProjectName As String
                Dim strListOfReceivers As String
                Dim intMessageID As Integer
                Dim StrProjectInfo As String
                Dim StrOwner As String
                Dim StrOwnerEmailId As String
                Dim StrSql As String
                Dim intProjectRequirementId As Integer
                Dim drRequirement As IDataReader
                Dim StrApproverEmailId As String
                Dim strUserName As String
                Dim strUserNameEmailId As String
                Dim strTittle As String
                Dim EstimatedCost As String
                Dim PlannedStartDate As String
                Dim PlannedEndDate As String
                Dim Risk As String
                Dim strPriority As String
                Dim intRevisionReasonID As Integer
                Dim StrComments As String
                Dim strProjectCurrency As String

                Dim strMessage As System.Text.StringBuilder
                Dim strEmailSubject As System.Text.StringBuilder

                intMessageID = 475

                '1.Logged In User
                strUserName = CType(HttpContext.Current.Session("strUsername"), String)
                If strUserName <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    ' StrSql = "SELECT EmailId FROM tbl_PM_Employee WHERE username='" + strUserName + "'"
                    StrSql = "usp_sel_tbl_PM_Employee_EmailId '" + strUserName + "'"
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strUserNameEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunction.Data.DisposeDataReader(drRequirement)
                End If
                '2. Project Name
                strProjectName = CType(HttpContext.Current.Session("StrProjectName"), String)

                '3. Getting the message body, and subject.
                strEmailMessage = funcGetEmailMessageForRequirement(CType(HttpContext.Current.Session("intProjectID"), Long), intMessageID, strSubject)

                strMessage = New System.Text.StringBuilder("")
                strEmailSubject = New System.Text.StringBuilder("")
                strMessage.Append(strEmailMessage)
                strEmailSubject.Append(strSubject)

                '4.ProjectRequirementId From Parent Page
                intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)

                '5.Details of Requiement
                If intProjectRequirementId <> 0 Then
                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "SELECT ReqApprovedBy,ResponsiblePersonId,ReqTitle,Risk,PlannedStartDate,PlannedEndDate,EstimatedCost,PriorityId   FROM tbl_RM_ProjectRequirements WHERE ProjectRequirementId =" + CStr(intProjectRequirementId)
                    StrSql = "usp_sel_tbl_RM_ProjectRequirements_ReqApprovedBy " + CStr(intProjectRequirementId)
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)

                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strApproverName = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ReqApprovedBy"), ""))
                            StrOwner = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ResponsiblePersonId"), ""))
                            strTittle = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ReqTitle"), ""))
                            EstimatedCost = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EstimatedCost"), ""))
                            PlannedStartDate = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PlannedStartDate"), ""))
                            PlannedEndDate = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PlannedEndDate"), ""))
                            Risk = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("Risk"), ""))
                            strPriority = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PriorityId"), ""))
                        End If
                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)

                End If

                '6. Corresponding Prioriry against PriorityId
                ''added by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes
                If strPriority <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "Select Priority from tbl_IB_Priorities where PriorityId=" + strPriority
                    StrSql = "usp_sel_tbl_IB_Priorities_Priority " + strPriority
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strPriority = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("Priority"), ""))
                        End If
                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)
                End If
                ''end of addition by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes

                '7. Corresponding Name and EmailId of Approver to whom the mail is Sent
                If strApproverName <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "Select EmployeeName,EmailId from tbl_PM_Employee where EmployeeId=" + strApproverName
                    StrSql = "usp_sel_tbl_PM_Employee_EmployeeNameEmailID " + strApproverName
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strApproverName = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmployeeName"), ""))
                            StrApproverEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)
                End If

                '8. Owner of Requirement Raised
                If StrOwner <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    ' StrSql = "Select EmployeeName,EmailId from tbl_PM_Employee where EmployeeId=" + StrOwner
                    StrSql = "usp_sel_tbl_PM_Employee_EmployeeNameEmailID " + StrOwner
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            StrOwner = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmployeeName"), ""))
                            StrOwnerEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)
                End If

                '9. Getting the Comment Entered by the Sender.
                intRevisionReasonID = CType(HttpContext.Current.Request.QueryString("RevisionReasonID"), Integer)
                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'StrSql = "Select ReasonForRevision From tbl_RM_ReqRevisionReason where RevisionReasonID=" + CStr(intRevisionReasonID)
                StrSql = "usp_sel_tbl_RM_ReqRevisionReason_ReasonForRevision " + CStr(intRevisionReasonID)
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                    If drRequirement.Read() Then
                        StrComments = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ReasonForRevision"), ""))
                    End If

                End If
                CommonFunctions.Data.DisposeDataReader(drRequirement)
                If StrOwnerEmailId <> strUserNameEmailId Then
                    strCCToEmailID = StrOwnerEmailId + ","
                Else
                    strCCToEmailID = StrOwnerEmailId
                End If

                '9. Project Currency:

                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'StrSql = "select distinct currencycode FROM tbl_PM_Project P,tbl_PM_CurrencyMaster c Where c.CurrencyID=P.BaseCurrency and P.BaseCurrency=(select basecurrency from tbl_Pm_Project Where ProjectID=" + CType(HttpContext.Current.Session("intProjectId"), String) + ")"
                StrSql = "usp_sel_tbl_PM_CurrencyMaster_currencycode " + CType(HttpContext.Current.Request.QueryString("ProjectID"), String)
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                    If drRequirement.Read() Then
                        strProjectCurrency = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("currencycode"), ""))
                    End If

                End If
                CommonFunctions.Data.DisposeDataReader(drRequirement)
                '10. Message Buiding and Populating Fields
                strFromEmailID = strUserNameEmailId
                If StrOwnerEmailId <> strUserNameEmailId Then
                    strCCToEmailID = strCCToEmailID + strUserNameEmailId
                End If
                strToEmailID = StrApproverEmailId
                strMessage.Replace("<PROJECT_NAME>", strProjectName)
                strMessage.Replace("<NAME>,", strApproverName + ",")
                strMessage.Replace("<ReqTitle>", strTittle)
                strMessage.Replace("< EstimatedCost>", strProjectCurrency + EstimatedCost)

                ''commented and added by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes
                'strMessage.Replace("<PlannedStartDate>", CommonFunctions.Dates.CGetDate(CType(PlannedStartDate, Date)))
                'strMessage.Replace("<PlannedEndDate>", CommonFunctions.Dates.CGetDate(CType(PlannedEndDate, Date)))
                ' strMessage.Replace("<PlannedEndDate>", PlannedEndDate)
                If CStr(CommonFunctions.General.CheckIsNothing(PlannedStartDate)) = "" Then
                    strMessage.Replace("<PlannedStartDate>", "")
                Else
                    strMessage.Replace("<PlannedStartDate>", CommonFunctions.Dates.CGetDate(CType(PlannedStartDate, Date)))
                End If
                If CStr(CommonFunctions.General.CheckIsNothing(PlannedEndDate)) = "" Then
                    strMessage.Replace("<PlannedEndDate>", "")
                Else
                    strMessage.Replace("<PlannedEndDate>", CommonFunctions.Dates.CGetDate(CType(PlannedEndDate, Date)))
                End If
                ''end of comment and addition by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes


                strMessage.Replace("<Priority>", strPriority)
                strMessage.Replace("<Risk>", Risk)
                strMessage.Replace("Regards,", "Regards,")
                strMessage.Replace("<SENDER>", CType(HttpContext.Current.Session("StrUserName"), String))
                strMessage.Replace("<Comments>", StrComments)
                strMessage.Replace("<BR>", vbCrLf)
                strEmailSubject.Replace("<ReqTitle>", strTittle)



                strEmailMessage = strMessage.ToString
                strSubject = strEmailSubject.ToString
                strMessage = Nothing
                strEmailSubject = Nothing
            End Sub

            Public Shared Sub GetEmailMessage_477(ByRef strFromEmailID As String, ByRef strToEmailID As String, _
                                                            ByRef strCCToEmailID As String, ByRef strSubject As String, _
                                                            ByRef strEmailMessage As String, ByVal ProjectDocumentRefTypeID As Long)
                '=====================================================================
                ' Procedure Name		:	GetEmailMessage_477 (Review Comments)
                ' Parameters Passed     :	strToEmailID	:- The EmailID of the person to whom the message will be returned.
                '							strSubject		:- The Subject of the Email Message.
                '							strEmailMessage	:- The body of the Email Message.
                '							ProjectDocumentRefTypeID	:-Project Document ID.
                ' Returns               :	
                ' Parameters Affected   :	strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
                ' Description           :	Generate the email message as defined in the System Email Messages table in the database.
                ' Purpose               :	Generate the email message as defined in the System Email Messages table in the database.
                ' Assumptions           :	The message ID exists in the database.
                '							The message does not contain any other parameters besides the following :
                '						        1.	<PROJECT_NAME> 
                '								2.	<NAME>
                '								3.	<SENDER>
                '                               4.  <Reqtitle>
                '                               5.  <Comments>
                '                               6.  <ReviewDate>
                '                               7.  <FileName>
                ' Dependencies          :	None.
                ' Author                :	ChristinaT
                ' Created               :	8-JAN-2007
                ' Revisions             :
                '=====================================================================

                Dim strQuery As String = ""
                Dim drPRojectDocument As IDataReader
                Dim strUserName As String = ""
                Dim strProjectName As String = ""
                Dim strListOfReceivers As String = ""
                Dim intMessageID As Integer = 0
                Dim lngProjectID As Long = 0
                Dim strTemp As String = ""
                Dim strEmailID As String = ""
                Dim strEmailAddress As String = ""
                Dim strTitle As String
                Dim lngEmployeeID As Long
                Dim strOwner As String
                Dim strSQL As String
                Dim drOwner As IDataReader
                Dim strLoginType As String
                Dim strProjectReqId As String
                Dim strComments As String
                Dim strReviewDate As String
                Dim strFileName As String
                Dim intReviewID As Integer

                '1. Code for String Builder Changes - IssueID - 6052 
                Dim strMessage As System.Text.StringBuilder
                Dim strEmailSubject As System.Text.StringBuilder

                intMessageID = 477

                lngProjectID = CType(HttpContext.Current.Session("intProjectID"), Long)

                'Get the senderName based on LoginType
                'strLoginType = CStr(HttpContext.Current.Session("LoginType"))
                'If strLoginType = "C" Then

                'End If

                'Get the latest reviewId for the document
                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'strSQL = "Select max(ReviewDocumentID) as 'ReviewDocId' from tbl_RM_DocumentReview Where ProjectDocumentRefTypeID =" + ProjectDocumentRefTypeID.ToString
                strSQL = "usp_sel_tbl_RM_DocumentReview_ReviewDocumentID " + ProjectDocumentRefTypeID.ToString
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                drPRojectDocument = CommonFunctions.Data.GetDataReader(strSQL, True)
                If drPRojectDocument.Read Then
                    intReviewID = CInt(drPRojectDocument.Item("ReviewDocId"))
                End If
                CommonFunction.Data.DisposeDataReader(drPRojectDocument)
                strUserName = CStr(HttpContext.Current.Session("strUserName"))

                ' Get the message body, and subject.
                strEmailMessage = funcGetEmailMessageForProject(lngProjectID, intMessageID, strSubject)

                '2. Code for String Builder Changes - IssueID - 6052 
                strMessage = New System.Text.StringBuilder("")
                strEmailSubject = New System.Text.StringBuilder("")
                strMessage.Append(strEmailMessage)
                strEmailSubject.Append(strSubject)

                'Replace the comments  place 
                ''Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'strComments = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT Comments from TBL_RM_DOCUMENTREVIEW where  ReviewDocumentID= " + intReviewID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                strComments = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TBL_RM_DOCUMENTREVIEW_Comments " + intReviewID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                strMessage.Replace("<Coments>", strComments)
                strEmailSubject.Replace("<Coments>", strComments)

                'Formatting 
                strMessage.Replace("Following are the Review comments for :", "Following are the Review comments for :" + vbCrLf + vbCrLf)
                strMessage.Replace("4)Please review the same.", "Please review the same." + vbCrLf + vbCrLf)
                strMessage.Replace("Regards,", "Regards,")

                'Replace the ReviewDate place holder
                ''Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'strReviewDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ReviewDate from TBL_RM_DOCUMENTREVIEW where  ReviewDocumentID= " + intReviewID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                strReviewDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TBL_RM_DOCUMENTREVIEW_ReviewDate " + intReviewID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                strMessage.Replace("<ReviewDate>", strReviewDate)
                strEmailSubject.Replace("<ReviewDate>", strReviewDate)


                'Replace the FileName place holder

                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'strFileName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT FileName from TBL_RM_PROJECTREQDOCUMENT where  ProjectDocumentRefTypeID= " + ProjectDocumentRefTypeID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                strFileName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TBL_RM_PROJECTREQDOCUMENT_FileName " + ProjectDocumentRefTypeID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                strMessage.Replace("<Filename>", strFileName)
                strEmailSubject.Replace("<Filename>", strFileName)

                'Replace the RequirementTitle place holder
                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                'strTitle = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT Reqtitle from tbl_RM_ProjectRequirements where ProjectRequirementID in(Select ProjectRequirementID From tbl_RM_ProjectReqDocument Where ProjectDocumentRefTypeID= " + ProjectDocumentRefTypeID.ToString + ")", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                strTitle = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_RM_ProjectRequirements_Reqtitle_SubQuery " + ProjectDocumentRefTypeID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                strMessage.Replace("<ReqTile>", strTitle)
                strEmailSubject.Replace("<ReqTile>", strTitle)

                'Get the ProjectRequirementID 
                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'strProjectReqId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ProjectRequirementID from tbl_RM_ProjectRequirements where ProjectRequirementID in(Select ProjectRequirementID From tbl_RM_ProjectReqDocument Where ProjectDocumentRefTypeID= " + ProjectDocumentRefTypeID.ToString + ")", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                strProjectReqId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_RM_ProjectRequirements_ProjectRequirementID " + ProjectDocumentRefTypeID.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                ' Retrieve information about the Sender.
                Call GetSenderInfo(strUserName, strFromEmailID)

                'Code Here To find out EmailID of Employee for CC
                'tbl_EWF_ExpenseSheet_Comments
                'strCCToEmailID = strCCToEmailID & ";vishalK@compulink.co.in"

                strMessage.Replace("<SENDER>", strUserName)
                If strProjectReqId <> "" Then
                    ' Get the email id name of Recipient
                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'strSQL = "select ResponsiblePersonId from tbl_RM_ProjectRequirements Where ProjectRequirementID=" + strProjectReqId
                    strSQL = "usp_sel_tbl_RM_ProjectRequirements_ResponsiblePersonId " + strProjectReqId
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drOwner = CommonFunctions.Data.GetDataReader(strSQL, True)
                    If drOwner.Read Then
                        strOwner = CStr(drOwner.Item("ResponsiblePersonID"))
                    End If
                    CommonFunction.Data.DisposeDataReader(drOwner)
                    ' strQuery = "SELECT DISTINCT  E.EmployeeID FROM tbl_PM_ProjectEmployeeRole P, tbl_PM_Employee E WHERE P.ProjectID = " + lngProjectID.ToString + " AND P.EmployeeID = E.EmployeeID AND ISNULL(P.ActualEndDate,'') = '' aNd E.EmployeeID=  " & strOwner

                    ' lngEmployeeID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), Long)
                    lngEmployeeID = CType(strOwner, Long)
                    Call GetEmployeeInfo(lngEmployeeID, strUserName, strEmailID)
                    strToEmailID = strEmailID
                    'Added by PurvaJ on 18 April 2006 for whiziblesem 6 issue ID 2318 for expenses workflow
                    ' Dim strCClist As String
                    ' strCClist = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_EWF_Get_EmployeeCCList_FinanceApproval " + ExpenseSheetID.ToString(), True))), String)
                    ' strCCToEmailID = strCClist
                    'End Addition PurvaJ

                    If Trim(strEmailAddress) = "" Then
                        strEmailAddress = "All"
                    End If

                    'Construct real message by replacing the real data.
                    strMessage.Replace("<NAME>", strUserName)
                    strMessage.Replace("<BR>", vbCrLf)
                    '4. Code for String Builder Changes - IssueID - 6052 
                    strEmailMessage = strMessage.ToString
                    strSubject = strEmailSubject.ToString
                End If
                '5. Code for String Builder Changes - IssueID - 6052 
                strMessage = Nothing
                strEmailSubject = Nothing
            End Sub

            Public Shared Sub GetEmailMessage_3002(ByRef strFromEmailID As String, ByRef strToEmailID As String, _
                                                ByRef strCCToEmailID As String, ByRef strSubject As String, _
                                                ByRef strEmailMessage As String, ByVal ProjectReqTRDocumentID As Long)
                '=====================================================================
                ' Procedure Name		:	GetEmailMessage_3002 (Review Comments for traceability document)
                ' Parameters Passed     :	strToEmailID	:- The EmailID of the person to whom the message will be returned.
                '							strSubject		:- The Subject of the Email Message.
                '							strEmailMessage	:- The body of the Email Message.
                '							ProjectDocumentRefTypeID	:-Project Document ID.
                ' Returns               :	
                ' Parameters Affected   :	strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
                ' Description           :	Generate the email message as defined in the System Email Messages table in the database.
                ' Purpose               :	Generate the email message as defined in the System Email Messages table in the database.
                ' Assumptions           :	The message ID exists in the database.
                '							The message does not contain any other parameters besides the following :
                '						        1.	<PROJECT_NAME> 
                '								2.	<NAME>
                '								3.	<SENDER>
                '                               4.  <Reqtitle>
                '                               5.  <Comments>
                '                               6.  <ReviewDate>
                '                               7.  <FileName>
                ' Dependencies          :	None.
                ' Author                :	
                ' Created               :	
                ' Revisions             :
                '=====================================================================

                Const intMessageID As Integer = 3002

                Dim strSQL As String = ""
                Dim drPRojectDocument As IDataReader
                Dim lngProjectID As Long = 0
                Dim strUserName As String = ""
                Dim strEmailID As String = ""
                Dim strEmailAddress As String = ""
                Dim lngEmployeeID As Long
                Dim strOwner As String
                Dim strComments As String
                Dim strReviewDate As String
                Dim strFileName As String
                Dim intReviewID As Integer
                Dim strTitle As String
                Dim strTraceRef As String

                '1. Code for String Builder Changes - IssueID - 6052 
                Dim strMessage As System.Text.StringBuilder
                Dim strEmailSubject As System.Text.StringBuilder

                lngProjectID = CType(HttpContext.Current.Session("intProjectID"), Long)
                strUserName = CStr(HttpContext.Current.Session("strUserName"))

                'Get the latest reviewId for the 
                strSQL = "Select max(TRReviewDocumentID) as 'TRReviewDocumentID' from tbl_RTM_DocumentReview Where ProjectReqTRDocumentID= " + ProjectReqTRDocumentID.ToString

                'Comment BY VarunA on 5-Sep-2007
                'intReviewID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")
                intReviewID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                'End by VarunA on 5-Sep-2007


                ' Get the message body, and subject.
                strEmailMessage = funcGetEmailMessageForProject(lngProjectID, intMessageID, strSubject)

                '2. Code for String Builder Changes - IssueID - 6052 
                strMessage = New System.Text.StringBuilder("")
                strEmailSubject = New System.Text.StringBuilder("")
                strMessage.Append(strEmailMessage)
                strEmailSubject.Append(strSubject)

                'Formatting 
                strMessage.Replace("Following are the Review comments for :", "Following are the Review comments for :" + vbCrLf + vbCrLf)
                strMessage.Replace("4)Please review the same.", "Please review the same." + vbCrLf + vbCrLf)
                'strMessage.Replace("Regards,", "Regards,")

                strSQL = "Exec usp_Sel_RTM_DocumentEmailMsgValues " & intReviewID
                drPRojectDocument = CommonFunction.Data.GetDataReader(strSQL, True)

                If drPRojectDocument.Read Then
                    'Comment BY VarunA on 5-Sep-2007
                    'strReviewDate = CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("ReviewDate"))
                    'strFileName = CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("FileName"))
                    'strTitle = CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("ReqTitle"))
                    'strOwner = CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("ResponsiblePersonId"))
                    'strComments = CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("Comments"))
                    'strTraceRef = CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("TRPhaseName"))

                    strReviewDate = CType(CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("ReviewDate")), String)
                    strFileName = CType(CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("FileName")), String)
                    strTitle = CType(CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("ReqTitle")), String)
                    strOwner = CType(CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("ResponsiblePersonId")), String)
                    strComments = CType(CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("Comments")), String)
                    strTraceRef = CType(CommonFunction.Data.CheckIsDBNull(drPRojectDocument.Item("TRPhaseName")), String)
                    'End by VarunA on 5-Sep-2007
                End If

                CommonFunction.Data.DisposeDataReader(drPRojectDocument)

                'Replace the ReviewDate place holder
                strMessage.Replace("<ReviewDate>", strReviewDate)
                strEmailSubject.Replace("<ReviewDate>", strReviewDate)

                'Replace the FileName place holder
                strMessage.Replace("<Filename>", strFileName)
                strEmailSubject.Replace("<Filename>", strFileName)

                'Replace the RequirementTitle place holder
                strMessage.Replace("<ReqTile>", strTitle)
                strEmailSubject.Replace("<ReqTile>", strTitle)

                'Replace the Traceability Reference place holder
                strMessage.Replace("<TraceRef>", strTraceRef)
                strEmailSubject.Replace("<TraceRef>", strTraceRef)

                'Replace the comments  place holder
                strMessage.Replace("<Coments>", strComments)
                strEmailSubject.Replace("<Coments>", strComments)

                If strOwner <> "" Then
                    lngEmployeeID = CType(strOwner, Long)
                    Call GetEmployeeInfo(lngEmployeeID, strUserName, strEmailID)
                    strToEmailID = strEmailID

                    If Trim(strEmailAddress) = "" Then
                        strEmailAddress = "All"
                    End If

                    'Construct real message by replacing the real data.
                    strMessage.Replace("<NAME>", strUserName)
                    strMessage.Replace("<BR>", vbCrLf)
                    strMessage.Replace("<SENDER>", strUserName)

                    ' Retrieve information about the Sender.
                    Call GetSenderInfo(strUserName, strFromEmailID)

                    '4. Code for String Builder Changes - IssueID - 6052 
                    strEmailMessage = strMessage.ToString
                    strSubject = strEmailSubject.ToString
                End If

                '5. Code for String Builder Changes - IssueID - 6052 
                strMessage = Nothing
                strEmailSubject = Nothing
            End Sub

            Public Shared Sub GetEmailMessage_479(ByRef strFromEmailID As String, ByRef strToEmailID As String, ByRef strCCToEmailID As String, ByRef strSubject As String, ByRef strEmailMessage As String)
                '=====================================================================
                ' Procedure Name        :   GetEmailMessage_479
                ' Parameters Passed     :   strToEmailID    :- The EmailID of the person to whom the message will be returned.
                '                           strSubject      :- The Subject of the Email Message.
                '                           strEmailMessage :- The body of the Email Message.
                '                           
                ' Returns               :
                ' Parameters Affected   :   strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
                ' Description           :   Generate the email message as defined in the System Email Messages table in the database.
                ' Purpose               :   Generate the email message as defined in the System Email Messages table in the database.
                ' Assumptions           :   The message ID exists in the database.
                '                           
                ' Dependencies          :   None.
                ' Author                :   ChristinaT
                ' Created               :   11 Jan 2007
                ' Revisions             :	
                '=====================================================================

                Dim strProjectName As String
                Dim strListOfReceivers As String
                Dim intMessageID As Integer
                Dim StrSql As String
                Dim intProjectRequirementId As Integer
                Dim intRevisionReasonID As Integer
                Dim strOwner As String
                Dim StrOwnerEmailId As String
                Dim drRequirement As IDataReader
                Dim objdr As IDataReader
                Dim StrApproverEmailId As String
                Dim strUserName As String
                Dim strSender As String
                Dim strSenderEmailId As String
                Dim strUserNameEmailId As String
                Dim strTitle As String
                Dim PlannedStartDate As String
                Dim PlannedEndDate As String
                Dim StrComments As String
                Dim strMessage As System.Text.StringBuilder
                Dim strEmailSubject As System.Text.StringBuilder

                intMessageID = 479

                intRevisionReasonID = CType(HttpContext.Current.Request.QueryString("RevisionReasonID"), Integer)
                '1.Logged In User
                strUserName = CType(HttpContext.Current.Session("strUsername"), String)
                If strUserName <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "SELECT EmailId FROM tbl_PM_Employee WHERE username='" + strUserName + "'"
                    StrSql = "usp_sel_tbl_PM_Employee_EmailId '" + strUserName + "'"
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strUserNameEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunction.Data.DisposeDataReader(drRequirement)
                End If
                '2. Project Name
                strProjectName = CType(HttpContext.Current.Session("StrProjectName"), String)

                '3. Getting the message body, and subject.
                strEmailMessage = funcGetEmailMessageForRequirement(CType(HttpContext.Current.Session("intProjectID"), Long), intMessageID, strSubject)

                strMessage = New System.Text.StringBuilder("")
                strEmailSubject = New System.Text.StringBuilder("")
                strMessage.Append(strEmailMessage)
                strEmailSubject.Append(strSubject)

                '4.ProjectRequirementId From Parent Page
                intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)



                '5.Details of Requirement
                If intProjectRequirementId <> 0 Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "SELECT ResponsiblePersonId,ReqTitle,PlannedStartDate,PlannedEndDate  FROM tbl_RM_ProjectRequirements WHERE ProjectRequirementId =" + CStr(intProjectRequirementId)
                    StrSql = "usp_sel_tbl_RM_ProjectRequirements_ResponsiblePersonIdTitle " + CStr(intProjectRequirementId)
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)

                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then

                            strOwner = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ResponsiblePersonId"), ""))
                            strTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ReqTitle"), ""))

                            PlannedStartDate = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PlannedStartDate"), ""))
                            PlannedEndDate = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PlannedEndDate"), ""))

                        End If
                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)

                End If



                ''7. Corresponding Name and EmailId of recipient of the  mail 
                'If strRequestedBy <> "" Then
                '    StrSql = "Select EmployeeName,EmailId from tbl_PM_Employee where EmployeeId=" + strOwner
                '    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                '    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                '        If drRequirement.Read() Then
                '            strApproverName = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmployeeName"), ""))
                '            StrApproverEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                '        End If

                '    End If
                '    CommonFunctions.Data.DisposeDataReader(drRequirement)
                'End If

                '8. Owner of Requirement Raised
                If strOwner <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    ' StrSql = "Select EmployeeName,EmailId from tbl_PM_Employee where EmployeeId=" + strOwner
                    StrSql = "usp_sel_tbl_PM_Employee_EmployeeNameEmailID " + strOwner
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strOwner = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmployeeName"), ""))
                            StrOwnerEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)
                End If

                '9 Get the sender's details
                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'StrSql = "Select SentBy From tbl_RM_ReqRevisionReason Where RevisionReasonID= " + intRevisionReasonID.ToString
                StrSql = "usp_sel_tbl_RM_ReqRevisionReason_SentBy " + intRevisionReasonID.ToString
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                If drRequirement.Read Then
                    strSender = CStr(drRequirement.Item("SentBy"))
                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "Select EmailId from tbl_PM_Employee where UserName='" + strSender + "'"
                    StrSql = "usp_sel_tbl_PM_Employee_EmailId '" + strSender + "'"
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    objdr = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If objdr.Read Then
                        strSenderEmailId = CStr(objdr.Item("EmailID"))
                    End If
                    CommonFunctions.Data.DisposeDataReader(objdr)
                End If
                CommonFunctions.Data.DisposeDataReader(drRequirement)

                '10. Getting  Approver's comments.
                'intRevisionReasonID = CType(HttpContext.Current.Request.QueryString("RevisionReasonID"), Integer)

                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                ' StrSql = "Select ApproverComment From tbl_RM_ReqRevisionReason where RevisionReasonID=" + CStr(intRevisionReasonID)
                StrSql = "usp_sel_tbl_RM_ReqRevisionReason_ApproverComment " + CStr(intRevisionReasonID)
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                    If drRequirement.Read() Then
                        StrComments = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ApproverComment"), ""))
                    End If

                End If
                CommonFunctions.Data.DisposeDataReader(drRequirement)

                '11. Message Building and Populating Fields
                strFromEmailID = strUserNameEmailId

                If strOwner <> strSender Then
                    strToEmailID = StrOwnerEmailId + "," + strSenderEmailId 'strUserNameEmailId
                Else
                    strToEmailID = StrOwnerEmailId
                End If
                strMessage.Replace("<ProjectName>", strProjectName)
                ' strMessage.Replace("Approval:", "Approval:" + vbCrLf + vbCrLf)
                strMessage.Replace("<NAME>", strOwner)
                'strMessage.Replace("Requirement :-", vbCrLf + "Requirement :- ")
                strMessage.Replace("<ReqTitle>", strTitle)

                'strMessage.Replace("<PlannedStartDate>", PlannedStartDate)

                ''commented and added by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes
                'strMessage.Replace("<PlannedStartDate>", CommonFunctions.Dates.CGetDate(CType(PlannedStartDate, Date)))
                'strMessage.Replace("<PlannedEndDate>", CommonFunctions.Dates.CGetDate(CType(PlannedEndDate, Date)))
                ''strMessage.Replace("<PlannedEndDate>", PlannedEndDate)
                'strMessage.Replace("<PlannedEndDate>", PlannedEndDate)

                If CStr(CommonFunctions.General.CheckIsNothing(PlannedStartDate)) = "" Then
                    strMessage.Replace("<PlannedStartDate>", "")
                Else
                    strMessage.Replace("<PlannedStartDate>", CommonFunctions.Dates.CGetDate(CType(PlannedStartDate, Date)))
                End If

                If CStr(CommonFunctions.General.CheckIsNothing(PlannedEndDate)) = "" Then
                    strMessage.Replace("<PlannedEndDate>", "")
                Else
                    strMessage.Replace("<PlannedEndDate>", CommonFunctions.Dates.CGetDate(CType(PlannedEndDate, Date)))
                End If
                ''end of comment and addition by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes


                'strMessage.Replace("Regards,", vbCrLf + "Regards,")
                strMessage.Replace("<BR>", vbCrLf)
                strMessage.Replace("<SENDER_NAME>", strUserName)
                strMessage.Replace("<COMMENTS>", StrComments)
                strEmailSubject.Replace("<ReqTitle>", strTitle)



                strEmailMessage = strMessage.ToString
                strSubject = strEmailSubject.ToString
                strMessage = Nothing
                strEmailSubject = Nothing
            End Sub

            Public Shared Sub GetEmailMessage_480(ByRef strFromEmailID As String, ByRef strToEmailID As String, ByRef strCCToEmailID As String, ByRef strSubject As String, ByRef strEmailMessage As String)
                '=====================================================================
                ' Procedure Name        :   GetEmailMessage_480
                ' Parameters Passed     :   strToEmailID    :- The EmailID of the person to whom the message will be returned.
                '                           strSubject      :- The Subject of the Email Message.
                '                           strEmailMessage :- The body of the Email Message.
                '                           
                ' Returns               :
                ' Parameters Affected   :   strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
                ' Description           :   Generate the email message as defined in the System Email Messages table in the database.
                ' Purpose               :   Generate the email message as defined in the System Email Messages table in the database.
                ' Assumptions           :   The message ID exists in the database.
                '                           
                ' Dependencies          :   None.
                ' Author                :   ChristinaT
                ' Created               :   11 Jan 2007
                ' Revisions             :	
                '=====================================================================

                Dim strProjectName As String
                Dim strListOfReceivers As String
                Dim intMessageID As Integer
                Dim StrSql As String
                Dim intProjectRequirementId As Integer
                Dim intRevisionReasonID As Integer
                Dim strOwner As String
                Dim StrOwnerEmailId As String
                Dim strSender As String
                Dim strSenderEmailID As String
                Dim objDr As IDataReader
                Dim drRequirement As IDataReader
                Dim StrApproverEmailId As String
                Dim strUserName As String
                Dim strUserNameEmailId As String
                Dim strTitle As String
                Dim PlannedStartDate As String
                Dim PlannedEndDate As String
                Dim StrComments As String
                Dim strMessage As System.Text.StringBuilder
                Dim strEmailSubject As System.Text.StringBuilder

                intMessageID = 480

                intRevisionReasonID = CType(HttpContext.Current.Request.QueryString("RevisionReasonID"), Integer)

                '1.Logged In User
                strUserName = CType(HttpContext.Current.Session("strUsername"), String)
                If strUserName <> "" Then

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "SELECT EmailId FROM tbl_PM_Employee WHERE username='" + strUserName + "'"
                    StrSql = "usp_sel_tbl_PM_Employee_EmailId '" + strUserName + "'"
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strUserNameEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunction.Data.DisposeDataReader(drRequirement)
                End If
                '2. Project Name
                strProjectName = CType(HttpContext.Current.Session("StrProjectName"), String)

                '3. Getting the message body, and subject.
                strEmailMessage = funcGetEmailMessageForRequirement(CType(HttpContext.Current.Session("intProjectID"), Long), intMessageID, strSubject)

                strMessage = New System.Text.StringBuilder("")
                strEmailSubject = New System.Text.StringBuilder("")
                strMessage.Append(strEmailMessage)
                strEmailSubject.Append(strSubject)

                '4.ProjectRequirementId From Parent Page
                intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)



                '5.Details of Requirement
                If intProjectRequirementId <> 0 Then
                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "SELECT ResponsiblePersonId,ReqTitle,PlannedStartDate,PlannedEndDate  FROM tbl_RM_ProjectRequirements WHERE ProjectRequirementId =" + CStr(intProjectRequirementId)
                    StrSql = "usp_sel_tbl_RM_ProjectRequirements_ResponsiblePersonIdTitle " + CStr(intProjectRequirementId)
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)

                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then

                            strOwner = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ResponsiblePersonId"), ""))
                            strTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ReqTitle"), ""))

                            PlannedStartDate = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PlannedStartDate"), ""))
                            PlannedEndDate = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("PlannedEndDate"), ""))

                        End If
                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)

                End If

                '8. Owner of Requirement Raised
                If strOwner <> "" Then
                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    'StrSql = "Select EmployeeName, EmailId from tbl_PM_Employee where EmployeeId=" + strOwner
                    StrSql = "usp_sel_tbl_PM_Employee_EmployeeNameEmailID " + strOwner
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                        If drRequirement.Read() Then
                            strOwner = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmployeeName"), ""))
                            StrOwnerEmailId = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("EmailId"), ""))
                        End If

                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequirement)
                End If

                '9 Get the sender's details

                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                ' StrSql = "Select SentBy From tbl_RM_ReqRevisionReason Where RevisionReasonID= " + intRevisionReasonID.ToString
                StrSql = "usp_sel_tbl_RM_ReqRevisionReason_SentBy " + intRevisionReasonID.ToString
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                If drRequirement.Read Then
                    strSender = CStr(drRequirement.Item("SentBy"))

                    'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                    ' StrSql = "Select EmailId from tbl_PM_Employee where UserName='" + strSender + "'"
                    StrSql = "usp_sel_tbl_PM_Employee_EmailId '" + strUserName + "'"
                    'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

                    objDr = CommonFunctions.Data.GetDataReader(StrSql, True)
                    If objDr.Read Then
                        strSenderEmailID = CStr(objDr.Item("EmailID"))
                    End If
                    CommonFunctions.Data.DisposeDataReader(objDr)
                End If
                CommonFunctions.Data.DisposeDataReader(drRequirement)

                '10. Getting  Approver's comments.
                'intRevisionReasonID = CType(HttpContext.Current.Request.QueryString("RevisionReasonID"), Integer)
                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'StrSql = "Select ApproverComment From tbl_RM_ReqRevisionReason where RevisionReasonID=" + CStr(intRevisionReasonID)
                StrSql = "usp_sel_tbl_RM_ReqRevisionReason_ApproverComment " + CStr(intRevisionReasonID)
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                drRequirement = CommonFunctions.Data.GetDataReader(StrSql, True)
                If CommonFunctions.General.CheckIsNothing(drRequirement) <> "" Then
                    If drRequirement.Read() Then
                        StrComments = CStr(CommonFunctions.Data.CheckIsDBNull(drRequirement("ApproverComment"), ""))
                    End If

                End If
                CommonFunctions.Data.DisposeDataReader(drRequirement)

                '11. Message Building and Populating Fields
                strFromEmailID = strUserNameEmailId
                If strOwner <> strSender Then
                    strToEmailID = StrOwnerEmailId + "," + strSenderEmailID 'strUserNameEmailId
                Else
                    strToEmailID = StrOwnerEmailId
                End If
                strMessage.Replace("<ProjectName>", strProjectName)
                ' strMessage.Replace("Approval:", "Approval:" + vbCrLf + vbCrLf)
                strMessage.Replace("<NAME>", strOwner)
                'strMessage.Replace("Requirement :-", vbCrLf + "Requirement :- ")
                strMessage.Replace("<ReqTitle>", strTitle)

                'strMessage.Replace("<PlannedStartDate>", PlannedStartDate)

                ''commented and added by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes
                'strMessage.Replace("<PlannedStartDate>", CommonFunctions.Dates.CGetDate(CType(PlannedStartDate, Date)))
                'strMessage.Replace("<PlannedEndDate>", CommonFunctions.Dates.CGetDate(CType(PlannedEndDate, Date)))
                ''strMessage.Replace("<PlannedEndDate>", PlannedEndDate)
                'strMessage.Replace("<PlannedEndDate>", PlannedEndDate)

                If CStr(CommonFunctions.General.CheckIsNothing(PlannedStartDate)) = "" Then
                    strMessage.Replace("<PlannedStartDate>", "")
                Else
                    strMessage.Replace("<PlannedStartDate>", CommonFunctions.Dates.CGetDate(CType(PlannedStartDate, Date)))
                End If
                If CStr(CommonFunctions.General.CheckIsNothing(PlannedEndDate)) = "" Then
                    strMessage.Replace("<PlannedEndDate>", "")
                Else
                    strMessage.Replace("<PlannedEndDate>", CommonFunctions.Dates.CGetDate(CType(PlannedEndDate, Date)))
                End If
                ''end of comment and addition by RohiniK on 17 Aug 07 for WeServ RTM Phase II changes

               

                'strMessage.Replace("Regards,", vbCrLf + "Regards," + vbCrLf)
                strMessage.Replace("<BR>", vbCrLf)
                strMessage.Replace("<SENDER_NAME>", strUserName)

                strMessage.Replace("<COMMENTS>", StrComments)
                strEmailSubject.Replace("<ReqTitle>", strTitle)


                strEmailMessage = strMessage.ToString
                strSubject = strEmailSubject.ToString
                strMessage = Nothing
                strEmailSubject = Nothing
            End Sub

        End Class


        Private Shared Function GetResourceAllocationLevel() As String
            '=============================================
            ' Procedure Name		: GetResourceAllocationLevel
            ' Description           : This function is fetches the Resource Allocation Level from the Company Information table.
            ' Purpose               : 
            ' Parameters Passed     : None
            ' Returns               : The Resource Allocation level.
            ' Parameters Affected   : None
            ' Assumptions           :
            ' Dependencies          :
            ' Author                : JayavantK
            ' Created               : Aug 25 2004.
            ' Revisions             :
            '=====================================================================
            Dim strQuery As String = ""
            Dim strReturn As String = ""

            'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT ResourceAllocationLevel FROM tbl_PM_CompanyInformation"
            strQuery = " usp_sel_tbl_PM_CompanyInformation_ResourceAllocationLevel"
            'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

            strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(General.GetApplicationKeySetting("UseSQL"), Boolean)), "")

            Return strReturn
        End Function

        '=============================================
        ' Procedure Name		: funcGetEmailMessageForProject
        ' Description           : This function is made private as this is used in the public methods of this class only.
        ' Purpose               : Get Email Message From tbl_PM_EmailMEssages for given id, and project.
        ' Parameters Passed     : None
        ' Returns               : email Message
        ' Parameters Affected   : strSubject parameter is return paramter
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SachinR
        ' Created               : Feb 09 2004.
        ' Revisions             :
        '=====================================================================
        Private Shared Function funcGetEmailMessageForProject(ByVal lngProjectID As Long, ByVal lngMsgID As Long, ByRef strSubject As String) As String
            Dim strSQL As String
            Dim objDr As IDataReader
            Dim blnUseSQL As Boolean
            Dim strBody As String

            strBody = ""
            blnUseSQL = CType(General.GetApplicationKeySetting("UseSQL"), Boolean)

            strSQL = "usp_Sel_tbl_PM_EmailMessages " + lngMsgID.ToString
            If lngProjectID > 0 Then
                strSQL += "," + lngProjectID.ToString
            End If

            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strBody = objDr("Body").ToString + ""
                strSubject = objDr("subject").ToString + ""
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)

            funcGetEmailMessageForProject = strBody
        End Function
        Private Shared Function funcGetEmailMessageForRequirement(ByVal lngProjectID As Long, ByVal lngMsgID As Long, ByRef strSubject As String) As String
            'Function for use in Send Mail of Project Requirement Page 

            Dim strSQL As String
            Dim objDr As IDataReader
            Dim blnUseSQL As Boolean
            Dim strBody As String

            strBody = ""
            blnUseSQL = CType(General.GetApplicationKeySetting("UseSQL"), Boolean)

            strSQL = "usp_Sel_tbl_RM_EmailMessages " + lngMsgID.ToString
            If lngProjectID > 0 Then
                strSQL += "," + lngProjectID.ToString
            End If

            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strBody = objDr("Body").ToString + ""
                strSubject = objDr("subject").ToString + ""
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)

            funcGetEmailMessageForRequirement = strBody
        End Function

        '=====================================================================
        ' Procedure Name		:	GetProjectInfo
        ' Purpose				:	To retrieve information about the project, and get the configured CC List for that project.
        ' Description			:	Same as above.
        ' Parameters Passed		:	intProjectID :- The Project ID.
        '							strProjectName :- The Project Name will be returned in this variable.
        '							intMessageID :- The Message ID.
        '							strCCToEmailID :- The configured CC List will be returned in this variable
        ' Parameters Affected	:	strProjectName, strCCToEmailID
        ' Returns				:
        ' Assumptions			:
        ' Dependencies			:
        ' Author				:	SachinR
        ' Created				:	Feb 09 2004
        ' Revisions				:
        '=====================================================================
        Private Shared Sub GetProjectInfo(ByVal lngProjectID As Long, ByRef strProjectName As String, ByVal lngMessageID As Long, ByRef strCCToEmailID As String)
            Dim strEmployeeList As String
            Dim strTempArray() As String
            Dim intCtr As Integer
            Dim strEmailID As String
            Dim objDr As IDataReader
            Dim strSQL As String
            Dim blnUseSQL As Boolean
            Dim strLoginType As String
            Dim lngUserID As Long

            blnUseSQL = CType(General.GetApplicationKeySetting("UseSQL"), Boolean)

            'retrieve info about the project
            strSQL = "usp_Sel_tbl_PM_Project " + lngProjectID.ToString
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strProjectName = objDr("ProjectName").ToString + ""
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)

            'get the CC email ID list
            strSQL = "usp_Sel_tbl_PM_ProjectEmails " + lngProjectID.ToString + ", " + lngMessageID.ToString
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strEmployeeList = objDr("CCToUsersList").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)

            If strEmployeeList <> "" Then
                strTempArray = Split(strEmployeeList, ",")
                For intCtr = 0 To strTempArray.Length - 1
                    If strTempArray(intCtr).Trim <> "" Then
                        Call GetEmployeeInfo(CType(strTempArray(intCtr), Long), "", strEmailID)
                        If strEmailID <> "" Then
                            strCCToEmailID += strEmailID + ";"
                        End If
                        strEmailID = ""
                    End If
                Next
            End If

            strLoginType = HttpContext.Current.Session("LoginType").ToString
            lngUserID = CType(HttpContext.Current.Session("intUserID"), Long)
            If strLoginType.Trim.ToUpper = "C" Then
                Call GetCustomerInfo(lngUserID, "", strEmailID)
                strCCToEmailID += strEmailID
            Else
                If InStr(1, "," + strEmployeeList, "," + lngUserID.ToString + ",") = 0 Then
                    Call GetSenderInfo("", strEmailID)
                    strCCToEmailID += strEmailID
                End If
            End If

        End Sub

        '=============================================
        ' Procedure Name		: GetCustomerInfo
        ' Description           : 
        ' Purpose               : Get customer Name and EmailID
        ' Parameters Passed     :   lngCustomerID - Long - CustomerID whose info is required
        '                           strUserName - String - reference parameter to return employee Name
        '                           strEmailID - string - reference parameter to return emailid 
        ' Returns               : None
        ' Parameters Affected   :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SachinR
        ' Created               : Feb 09 2004
        ' Revisions             :
        '=====================================================================
        Private Shared Sub GetCustomerInfo(ByVal lngCustomerID As Long, ByRef strCustomerName As String, ByRef strEmailid As String)
            Dim strSQL As String
            Dim objDr As IDataReader
            Dim strLoginType As String
            Dim blnUseSQL As Boolean

            blnUseSQL = CType(General.GetApplicationKeySetting("UseSQL"), Boolean)

            strSQL = "usp_Sel_tbl_PM_Customer " + lngCustomerID.ToString
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strCustomerName = objDr("CustomerID").ToString + ""
                strEmailid = objDr("Emailid").ToString + ""
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)

        End Sub

        '=============================================
        ' Procedure Name		: GetSenderInfo
        ' Description           : 
        ' Purpose               : Get Employee or customer Name and EmailID
        ' Parameters Passed     :   strUserName - String - reference parameter to return employee Name
        '                           strEmailID - string - reference parameter to return emailid 
        ' Returns               : None
        ' Parameters Affected   :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SachinR
        ' Created               : Feb 09 2004
        ' Revisions             :
        '=====================================================================
        Private Shared Sub GetSenderInfo(ByRef strUserName As String, ByRef strEmailID As String)
            Dim strLoginType As String
            Dim lngUserid As Long

            strLoginType = HttpContext.Current.Session("LoginType").ToString
            lngUserid = CType(HttpContext.Current.Session("intUserID"), Long)

            If strLoginType = "C" Then
                Call GetCustomerInfo(lngUserid, strUserName, strEmailID)
            ElseIf strLoginType = "E" Then
                Call GetEmployeeInfo(lngUserid, strUserName, strEmailID)
            End If
            If strEmailID = "" Then
                strEmailID = funcGetCompanyMailID()
            End If
        End Sub

        '=============================================
        ' Procedure Name		: GetEmployeeInfo
        ' Description           : 
        ' Purpose               : Get Employee Name and EmailID
        ' Parameters Passed     : lngUserID - Long - Employee ID whose infor is required
        '                           strUserName - String - reference parameter to return employee Name
        '                           strEmailID - string - reference parameter to return emailid 
        ' Returns               : None
        ' Parameters Affected   :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SachinR
        ' Created               : Feb 09 2004
        ' Revisions             :
        '=====================================================================
        Public Shared Sub GetEmployeeInfo(ByVal lngUserID As Long, ByRef strUserName As String, ByRef strEmailid As String)
            Dim strSQL As String
            Dim objDr As IDataReader
            Dim blnUseSQL As Boolean

            blnUseSQL = CType(General.GetApplicationKeySetting("UseSQL"), Boolean)

            strSQL = "usp_tbl_Sel_EmployeeInfo " + lngUserID.ToString
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strUserName = objDr("UserName").ToString + ""
                strEmailid = objDr("EmailID").ToString + ""
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)
        End Sub

        '=============================================
        ' Procedure Name		: funcGetCompanyMailID
        ' Description           : 
        ' Purpose               : Get Company Email ID
        ' Parameters Passed     : None
        ' Returns               : Company Email ID
        ' Parameters Affected   :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SachinR
        ' Created               : Feb 09 2004
        ' Revisions             :
        '=====================================================================
        Public Shared Function funcGetCompanyMailID() As String
            Dim strSQL As String
            Dim objDr As IDataReader
            Dim blnUseSQL As Boolean
            Dim strEmailID As String

            blnUseSQL = CType(General.GetApplicationKeySetting("UseSQL"), Boolean)

            strSQL = "Select * From tbl_PM_CompanyInformation"
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
            If objDr.Read Then
                strEmailID = objDr("Email").ToString + ""
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)

            funcGetCompanyMailID = strEmailID.Trim
        End Function

        Public Shared Function funcGetEmailMessage(ByVal intMsgID As Integer, ByRef strSubject As String) As String
            '=============================================
            ' Procedure Name		: funcGetEmailMessage
            ' Description           : 
            ' Purpose               : Returns the body of the mail message according to the message id.
            ' Parameters Passed     : intMsgID, strSubject 
            ' Returns               : Body of the message
            ' Parameters Affected   :
            ' Assumptions           :
            ' Dependencies          :
            ' Author                : PrasannaP
            ' Created               : March 18 2004
            ' Revisions             :
            '=====================================================================

            Dim drEmailMessages As IDataReader

            drEmailMessages = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_PM_EmailMessages " + CStr(intMsgID), CType(General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drEmailMessages.Read Then
                strSubject = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessages("Subject"), ""), String)
                funcGetEmailMessage = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessages("BODY"), ""), String)
            End If
            CommonFunction.Data.DisposeDataReader(drEmailMessages)
        End Function

    End Class
    Public Class Connection
        Inherits CommonFunctions.Connection
    End Class
    Public Class Application
        Inherits CommonFunctions.Application
        Private Shared blnAllowResourceAllocation As Boolean

        'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
        'Property to get or set the blnAllowResourceAllocation
        Public Shared Property AllowResourceAllocation() As Boolean
            Get
                Return blnAllowResourceAllocation
            End Get
            Set(ByVal Value As Boolean)
                blnAllowResourceAllocation = Value
            End Set
        End Property
        'End Addition

    End Class
    Public Class Genereal
        Public Shared Sub DrawRequirementHeaderNavigation(ByVal strSelectedLink As String, ByVal strProjectRequirementID As String, ByVal strProjectID As String, Optional ByVal strImpactID As String = "")
            If strProjectRequirementID.Trim = "" Then
                Exit Sub
            End If
            If strImpactID = "" Then
                strImpactID = CStr(CommonFunction.Data.GetDataScalar("SELECT ProjectRequirement_ImpactId FROM Tbl_RM_ProjectReqImpactAnalysis WHERE ProjectRequirementID = " + strProjectRequirementID, True))
            End If

            strSelectedLink = strSelectedLink.ToUpper

            CommonFunction.General.WriteHTML("<table class=clsTableNavLinks width=100%  cellpadding=0 cellspacing=0 >")
            CommonFunction.General.WriteHTML("<tr class=clsTRNavLinks valign=middle>")
            CommonFunction.General.WriteHTML("<td align=center>")
            If strSelectedLink = "REQUIREMENT" Then
                CommonFunction.General.WriteHTML("<a class='clsSelected' id=LnkReq href=""javascript:Link_onClick('LnkReq')"" >Requirement</a> ")
            Else
                CommonFunction.General.WriteHTML("<a class='clsNavTab' id=LnkReq href=""javascript:Link_onClick('LnkReq')"" >Requirement</a> ")
            End If

            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td align=center>")
            If strSelectedLink = "DETAILS" Then
                CommonFunction.General.WriteHTML("<a class='clsSelected'  id=LnkDet href=""javascript:Link_onClick('LnkDet')"" >Details</a> ")
            Else
                CommonFunction.General.WriteHTML("<a class='clsNavTab'  id=LnkDet href=""javascript:Link_onClick('LnkDet')"" >Details</a> ")
            End If
            CommonFunction.General.WriteHTML("</td>")

            ''commented by RohiniK on 29 Jun 07 --For WeServe
            ''Purpose: Hide the "IMPACT" Tab on Projecr Requirement detail page
            'CommonFunction.General.WriteHTML("<td align=center>")
            'If strSelectedLink = "IMPACT" Then
            '    CommonFunction.General.WriteHTML("<a class='clsSelected'  id=LnkImp href=""javascript:Link_onClick('LnkImp')"" >Impact</a> ")
            'Else
            '    CommonFunction.General.WriteHTML("<a class='clsNavTab'  id=LnkImp href=""javascript:Link_onClick('LnkImp')"" >Impact</a> ")
            'End If
            'CommonFunction.General.WriteHTML("</td>")
            ''commented by RohiniK on 29 Jun 07 --For WeServe

            CommonFunction.General.WriteHTML("<td align=center>")
            If strSelectedLink = "DOCUMENTS" Then
                CommonFunction.General.WriteHTML("<a class='clsSelected'  id=LnkDoc href=""javascript:Link_onClick('LnkDoc')"" >Documents</a> ")
            Else
                CommonFunction.General.WriteHTML("<a class='clsNavTab'  id=LnkDoc href=""javascript:Link_onClick('LnkDoc')"" >Documents</a> ")
            End If
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("</table>")
            CommonFunction.General.WriteHTML("<BR>")

            CommonFunction.General.WriteHTML("<script>")
            CommonFunction.General.WriteHTML("function Link_onClick(src)")
            CommonFunction.General.WriteHTML("{")
            CommonFunction.General.WriteHTML("var iProjectID = " + strProjectID + ";")
            CommonFunction.General.WriteHTML("var iProjectRequirementID = " + strProjectRequirementID + ";")
            CommonFunction.General.WriteHTML("var iImpactID = " + strImpactID + ";")
            CommonFunction.General.WriteHTML("var strPrjReqPKToken = '" + CommonFunctions.Security.Token.GetToken(strProjectRequirementID + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "0") + "';")
            CommonFunction.General.WriteHTML("var strImpactPKToken = '" + CommonFunctions.Security.Token.GetToken(strImpactID + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "0") + "';")
            CommonFunction.General.WriteHTML("if (src == 'LnkReq')")
            CommonFunction.General.WriteHTML("window.location.href=""../RM/ProjectRequirements_CommonPage.aspx?ProjectID=""+iProjectID+""&ProjectRequirementID_PK=""+iProjectRequirementID+""&PKToken=""+strPrjReqPKToken+""&MasterTagID=3714&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"";")
            CommonFunction.General.WriteHTML("else if (src == 'LnkImp')")
            CommonFunction.General.WriteHTML("window.location.href=""../RM/ImpactAnalysis_CommonPage.aspx?ProjectID=""+iProjectID+""&FromWhere=DB&MasterTagID=3718&ProjectRequirementID=""+iProjectRequirementID+""&ProjectRequirement_ImpactID_PK=""+iImpactID+""&PKToken=""+strImpactPKToken+""&PagingAlphabet=&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"";")
            CommonFunction.General.WriteHTML("else if (src == 'LnkDoc')")
            CommonFunction.General.WriteHTML("window.location.href=""../RM/DocumentReview_CommonList.aspx?ProjectID=""+iProjectID+""&FromWhere=DB&MasterTagId=3721&ProjectRequirementId=""+iProjectRequirementID;")
            CommonFunction.General.WriteHTML("else if (src== 'LnkDet')")
            CommonFunction.General.WriteHTML("window.location.href=""../RM/ProjectRequirementDetails.aspx?ProjectID=""+iProjectID+""&ProjectRequirementID=""+iProjectRequirementID;")
            CommonFunction.General.WriteHTML("}")
            CommonFunction.General.WriteHTML("</script>")


        End Sub
    End Class
End Namespace

