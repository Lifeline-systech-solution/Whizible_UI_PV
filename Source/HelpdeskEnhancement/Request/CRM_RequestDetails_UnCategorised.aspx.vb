Imports System.IO
Imports System.IO.Compression
Imports System.Xml
Imports System.Data.OleDb

Public Class CRM_RequestDetailsUncategorized
    Inherits WebPages.Template.WhizTemplate
    Private m_blnUseSQL As Boolean
    Private WithEvents m_objGridAttachment As WebPages.Template.GenericGrid
    '' Protected m_strMode As String = ""
    Private m_strAction As String = ""
    Protected m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected m_intRoleID As String = ""

    Private m_blnSLAAccess As Boolean = False
    Private arrValidationMessages(50) As String
    Protected Shared strClientSideScript As String 'Validation script for custom fields
    Private strSelectedValues As String
    Protected m_strCustomFieldList As String = ""
    Protected m_intCustomer As Integer = 0
    Protected m_strVal As String = ""
    Dim dr As IDataReader
    Protected m_StatusFlowCount As Integer
    Protected m_strMode As String = "EDIT"
    Protected blnDisableStatusCombo As Boolean = False
    Protected RequestID As String
    Protected intStatusID As Integer = 0
    Protected m_lngSubRequestTypeID As String
    Protected lngProductID As String = "0"
    Public ShowProductCombo As String = "0"
    Public blnDisableProjectCombo As Boolean = False
    Public blnDisableSeverityCombo As Boolean = False
    Public blnDisablePriorityCombo As Boolean = False
    Public blnDisableStatusChangeTime As Boolean = False
    Public blnDisableStatusChangeDate As Boolean = False
    Public blnDisableExpResolDate As Boolean = False
    Public blnDisableModuleProductCombo As Boolean = False
    Protected blnIsHRM As Integer = 0
    'Dim m_lngQueryID As String = "81085"  'DB'
    Protected m_lngQueryID As String = ""
    ''  Dim m_lngQueryID As String = "81479"  'AR'
    '' Dim m_lngQueryID As String = "81474"  'md'
    Protected strRequestor As String = ""
    Protected m_strEmailID As String = ""
    Protected m_strClienName As String = ""
    Protected m_strSubmittedDate As String = ""
    Protected m_RequeststrLoginType As String = "E"

    Protected intAssignTo As Integer
    Protected strAssignTo As String
    Protected strReportingTo As String
    Protected strAprovalStatus As String
    Protected m_strDeliverableID As String
    Protected lngFunctionID As Long = 0
    Protected blnViewAccessOrHRM As Integer = 0
    Protected dtmSubmittedDate As Date
    Protected strSubrequestType As String = ""
    Protected m_strDelProjectID As String = ""
    Protected strDelProjectName As String = ""
    Private m_intDiscussionThreadCount As Integer = 0
    Private m_lngRequestTypeId As Long
    Protected intIsTask_IssueCreated As Integer = 0
    Protected intIsAssignTo As Integer = 0
    Protected m_strSubject As String = ""
    Protected m_blnIsClient As Boolean = False

    Protected strGuidelinesColumnName As String = ""
    Protected intRequestTypeID As Long = 0
    Protected strSubject As String = ""
    Protected strDescription As String = ""

    ''Commented and Added by Usha Pandit on 29.12.2018 for HTML Email Content display issue after conversion
    Protected strTextDescription As String = ""
    ''End of Added by Usha Pandit on 29.12.2018 for HTML Email Content display issue after conversion


    Protected intPriorityID As Integer = 0
    Protected strExpectedResolvedDate As String = ""
    Protected strCRMExpectedResolvedDate As String = ""
    Protected lngAssignTo As Long = 0
    Protected lngTargetLocationID As Long = 0
    Protected intFeedbackID As Integer = 0
    Protected strFeedbackComments As String = ""
    Protected strComments As String = ""
    Protected strReasonsForRejection As String = ""
    Protected lngRequestID As Long = 0
    Protected strRequestorName As String = ""
    Protected m_blnAllowAttachmentDeletion As Boolean = True
    Protected m_intRequestedEmployeePost As Integer = 0
    Protected m_ChangedProduct As Integer = 0
    Protected m_ChangedModule As Integer = 0
    Protected m_ChangedProject As Integer = 0
    Protected m_ChangedLocation As Integer = 0
    Protected lngComponentID As Long = 0
    Protected m_strStatusChangeDateValue As String
    Protected m_strStatusChangeTimeValue As String
    Protected m_lngStatusId As Integer
    Protected intRequestStatus As Integer
    Protected intSeverityID As Integer = 0
    Dim lngRequestTypeIdOld As Long = 0
    Protected m_intShow As Integer = 0
    Protected m_strToken As String
    Protected intTemplateCount As String
    Protected blnDisableSubRequestTypeCombo As Boolean = False
    Protected blnDisableRequestTypeCombo As Boolean = False
    Protected strRequestorID As String
    Protected m_strApprover As String = "0"
    Protected blnDisabledAssignToCombo As Boolean = False
    Protected FilterFlag As String = "1"
    Dim blnDisableFunctionCombo As Boolean = False
    Dim blnDisableProductCombo As Boolean = False
    Dim blnDisableModuleCombo As Boolean = False
    Protected m_intRequestedEmployee As String = "0"
    Protected style As String = ""
    Protected styleproduct As String = ""
    Protected style1 As String = ""
    Protected Keywords As String = ""

    Protected m_intStatusID As String
    Protected m_strReuestLoginType As String = ""
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private m_blnIsAllowDeleteAtDeptLevel As Boolean 'Added By Dipali 1st Nov 2017
    Private m_strSubmittedBy As String = ""

    Protected RequestDetailID As String = ""
    Protected RequestIDNew As String = ""

    Protected strEditRequestSQL As String = ""
    Protected strHasEditAccessnew As String = ""
    Protected strHasEditAccess As String = ""
    Protected strHasHRMEditAccess As String = ""
    Protected m_strSortBy As String = "Status"
    Protected m_strSortOrder As String = "desc"
    Public drReader1 As IDataReader
    Protected lngProjectHours As Long
    Protected lngAllocatedHours As Long
    Protected lngProjectID As Long = 0
    Protected StrTitleList As String
    Protected StrCodeTemplate As String
    Protected lngTaskID As Long = 0
    Protected m_lngOldAssignTo As Long
    Protected m_lngOldTaskTypeID As Long
    Protected m_lngOldProjectID As Long
    Protected m_blnHasTimesheetDetails As Boolean = False


    Protected strHeaderDtls As String
    Protected drDtls As IDataReader
    Protected FlagTo As String
    Protected FlagDateStatus As String
    Protected FlagStatus As String
    Protected FlagImage As String
    Protected strHTML As New StringBuilder("")
    Protected drGetLoggedDetails As IDataReader
    Protected StrLoggedDetails As String = "0"
    Protected RequestSubmittedBy As String = ""
    Protected IsHRM As String = "0"
    Protected IsRequestFlagged As String = "0"
    Protected IsAssigned As String = "0"
    Protected strFlagEmployee As String = "0"
    Protected strFlagPlotProjectDetails As String = "0"
    Protected TimeZoneID As String = ""
    Protected TimeZone As String = ""

    Protected m_strRequestedEmployee As String = ""
    '  Protected m_intRequestedEmployeePost As String = ""
    Protected m_strRequestedEmployeeUN As String = ""
    Protected str_PageFlag As String = ""
    Public Property ZipFile As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngLoginID = CType(Session("intLOGINID"), Long)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
        'Code For SLA Access
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()

        objGlobal.TagID = 3821

        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.GetAccess()

        m_blnSLAAccess = objAccessRights.View
        'End of Code For SLA Access

        'Added By Bharat T on 25th-Oct-2017 for Discussion and attachmetn changes
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))



        m_lngQueryID = CommonFunctions.General.CheckIsNothing(Request.QueryString("QueryID"))
        FilterFlag = CommonFunctions.General.CheckIsNothing(Request.QueryString("QueryEditAccess"))

        'End of Added By Bharat T on 25th-Oct-2017 for Discussion and attachmetn changes
        str_PageFlag = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageFlag"), "")

        If Not Request.QueryString("RTVal") Is Nothing Then
            m_strVal = Request.QueryString("RTVal").ToString
            HttpContext.Current.Session("RTVal") = m_strVal
        Else
            m_strVal = CType(HttpContext.Current.Session("RTVal"), String)
        End If

        If Not Request.QueryString("Customer") Is Nothing And Request.QueryString("Customer") <> "" Then
            ' If found then initialize page level variable and also session 
            m_intCustomer = CType(Request.QueryString("Customer"), Integer)
            HttpContext.Current.Session("Customer") = m_intCustomer
        ElseIf Not HttpContext.Current.Session("Customer") Is Nothing Then
            ' This part is required for post back to re-initialize variables 
            m_intCustomer = CType(HttpContext.Current.Session("Customer"), Integer)
        Else
            ' If request is not by customer then remove customer ID
            m_intCustomer = 0
            HttpContext.Current.Session.Remove("m_intCustomer")
            HttpContext.Current.Session.Remove("m_strVal")
            HttpContext.Current.Session.Remove("Customer")
        End If
        If m_intShow = 0 Then
            m_intShow = 1 ' By default set request details tab 
        End If

        Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
        If Request.Params("Mode") = "FileNewAttachments" Then

            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""
            Dim intProjectDrawingID As Integer
            Dim infile As Integer
            Dim strDocType As String
            Dim strPath As String = ""

            Dim strFolderPath As String = ""
            Dim RequestID As String = ""

            Dim strDescription As String = ""
            Dim strInteranlCheck As String = ""


            Dim strProcessData() As String

            RequestID = CommonFunctions.General.CheckIsNothing(Request.Params("RequestID"), "0")
            Dim count As Integer
            count = 0
            While (Request.Files.Count) > count
                strDescription = CommonFunctions.General.CheckIsNothing(Request.Params("TxtComment_" & count), "")
                strInteranlCheck = CommonFunctions.General.CheckIsNothing(Request.Params("Internal_" & count), "")
                If strInteranlCheck = "" Then
                    strInteranlCheck = ""
                End If
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                If HttpContext.Current.Request.Files.Count > 0 Then
                    Try

                        '
                        'strPath = Server.MapPath("../../Attachments/CRM/")
                        'Dim objFile As New FileUpload.cUpload(Request.Files.Keys.Item(count), strPath, strFileName)


                        'objFile.OverwriteIfExists = True
                        'objFile.UploadFile()

                        '' the file name
                        'strOriginalFileName = objFile.OriginalFileName
                        'strFileName = objFile.UploadedFileName
                        'strFileName &= strFileExtension
                        'objFile = Nothing

                        strOriginalFileName = System.IO.Path.GetFileName(Request.Files(count).FileName)
                        'strFileName = objFile.UploadedFileName
                        strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                        strFileName &= strFileExtension

                        Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Attachments/CRM/"), strFileName)


                        Request.Files(count).SaveAs(fileSavePath)
                        ''infile = FileHandlingUtility.FileHandlingUtility.Encrypt(Request.Files(0), fileSavePath, True)
                        'strSQLQuery = "usp_App_Ins_tbl_EPC_Drawings_Attachements " & intProjectDrawingID & ",'" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & ",'" & strDocType & "','" & strRevisionNo & "'"
                        strSQLQuery = "usp_CRM_Insert_Attachment " & RequestID & ",'" & strOriginalFileName & "','" & strFileName & "','" & HttpContext.Current.Session("strUserName") & "','" & strDescription & "','" & HttpContext.Current.Session("LoginType") & "','" & strInteranlCheck & "'"

                        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)

                    Catch ex As Exception

                    End Try



                End If

                count += 1
            End While

            Response.Write(strFileName & "||" & strOriginalFileName)
            Response.End()

        Else
            'Added By Bharat T on 25th-Oct-2017 for Discussion and attachmetn changes
            Dim strSQL As String = ""

            strSQL = "usp_sel_Tbl_CRM_Query_Master_StatusID '" + m_lngQueryID.ToString + "'"

            m_intStatusID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL), "0"), "0"), Integer)

            Dim strSQLReuestLoginType As String = "usp_sel_tbl_CRM_Query_Master_LoginType '" + m_lngQueryID.ToString + "'"
            m_strReuestLoginType = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLReuestLoginType, m_blnUseSQL), ""), ""), String)

            If m_strAction = "SaveDiscussion" Then
                PerformUploadAction()
            End If
            'End of Added By Bharat T on 25th-Oct-2017 for Discussion and attachmetn changes

            'Added By Dipali 1st Nov 2017
            Dim strIsAllowDeleteAtDeptLevel As String = "usp_sel_tbl_PM_DepartmentMaster_isshowtocustomer " & m_lngQueryID.ToString()
            m_blnIsAllowDeleteAtDeptLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strIsAllowDeleteAtDeptLevel.ToString(), True), "0"), "0"), Boolean)

            RequestDetailID = CommonFunctions.General.CheckIsNothing(Request.QueryString("RequestDetailID"))

            If m_strAction = "DeleteDiscussion" Then
                DeleteDiscussion(RequestDetailID, m_lngQueryID)
            End If
            'End of Added By Dipali 1st Nov 2017




            'Added By Dipali V On 31st Oct 2017 

            strEditRequestSQL = "usp_NG_RequestDetailsSubTagAccess " & m_lngQueryID & "," & HttpContext.Current.Session("intUserID") & ""
            'strHasEditAccess = CommonFunctions.Data.GetDataScalar(strEditRequestSQL, True)
            drReader1 = CommonFunctions.Data.GetDataReader(strEditRequestSQL, True)

            If (drReader1.Read) Then
                strHasEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("Result")))
                strHasHRMEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("ResultHRM")))
            End If
            'End of Added By Dipali V On 31st Oct 2017 

            ' lngProjectID = CType(MyBase.GetFormValue("cboTaskProject"), Long)

            'Added By Dipali V On 3th Nov 2017
            Dim StrSQL1 As String = "usp_SEL_Deliverables_Details"
            Dim drDeliverables As IDataReader

            drDeliverables = CommonFunctions.Data.GetDataReader(StrSQL1, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDeliverables.Read Then
                StrTitleList = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drDeliverables(0), ""), String))
                StrCodeTemplate = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drDeliverables(1), ""), String))

            End If
            CommonFunction.Data.DisposeDataReader(drDeliverables)

            'End of Added By Dipali V On 3th Nov 2017

        End If



    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 16 Oct 2017
        ' Revisions             : None
        '=====================================================================

        'CommonFunctions.General.WriteHTML("<script>StartLoader('#fastTrackID');</script>")
        'DrawPage()
        Dim strHTML As New StringBuilder
        strHTML.Append("<input type=hidden id=hdnRequestID name=hdnRequestID value='" & m_lngQueryID & "' />")
        strHTML.Append("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value='0' />")
        strHTML.Append("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value='0' />")
        strHTML.Append("<input type=hidden id=hidstrLoginType name=hidstrLoginType value='" & m_strLoginType & "' />")

        strHTML.Append(DrawRequestDetails(ShowProductCombo, "", "", ""))
        CommonFunctions.General.WriteHTML(strHTML.ToString)

        'Added By Dipali V On 3th Nov 2017
        If Not lngTaskID.ToString Is Nothing Then
            AllowValueChanged(lngTaskID.ToString)
        End If


        If lngTaskID <> 0 Then
            Dim drTimesheet As IDataReader = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_DailyActivity_dailyActivityEntryID " & lngTaskID, m_blnUseSQL)
            If drTimesheet.Read Then
                m_blnHasTimesheetDetails = True
            Else
                m_blnHasTimesheetDetails = False
                CommonFunction.Data.DisposeDataReader(drTimesheet)
            End If
        End If
        'End of Added By Dipali V On 3th Nov 2017
    End Sub

    'Added By Bharat T on 25th-Oct-2017 for Discussion and attachmetn changes
    Private Sub PerformUploadAction()
        Dim strSQL As String
        Dim strIsShowToCustomer As String = ""
        Dim strDiscussionID As String = ""
        Dim strSQLStatus As String = ""

        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String
        Dim FeedbackID As String
        Dim FeedbackComments As String

        strIsShowToCustomer = CommonFunction.General.CheckIsNothing(Request.QueryString("IsShowToCustomer"))

        strSQL = "usp_NG2_CRM_Insert_DiscussionThread " & m_lngQueryID
        strSQL = strSQL & ",'" & Now().ToString & "'"
        strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName & "") & "'"
        strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
        strSQL = strSQL & ",'" & Request.Form("txtNewDiscussion").Replace("'", "''") & "'"


        strSQL = strSQL & ",'" & Date.Now.ToString("dd-MMM-yyyy") & "'"
        strSQL = strSQL & ",'" & DateTime.Now.ToString("hh:mm") & "'"


        'strSQL = strSQL & "," & FeedbackID & ","
        'strSQL = strSQL & "'" & FeedbackComments & "'"
        strSQL = strSQL & ",NULL,"
        strSQL = strSQL & "''"

        strSQL = strSQL & "," & strIsShowToCustomer & ""

        strDiscussionID = CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL)

        m_intStatusID = CType(Request.Form("cboDiscussionStatus"), Integer)

        ' send mail
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 47", m_blnUseSQL)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            If blnShowPopup Then
                With Response
                    .Write("<script language=javascript>")

                    Dim strTempIsShowToCustomer As String

                    If (HttpContext.Current.Session("LoginType") = "C") Then
                        strTempIsShowToCustomer = "1"
                    Else
                        If CommonFunctions.General.CheckIsNothing(Request.Form("chkIsShowToCustomer"), "").ToUpper.Equals("ON") Then
                            strTempIsShowToCustomer = "1"
                        Else
                            strTempIsShowToCustomer = "0"
                        End If
                    End If

                    If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") = "C" Then
                        strTempIsShowToCustomer = "1"
                    End If

                    Dim strToken As String = CommonFunctions.Security.Token.GetToken("1003" & m_lngQueryID & strTempIsShowToCustomer & HttpContext.Current.Session("intUserid") & "0")

                    .Write(" window.open (""../EmailSettings/CRMSendEmail.aspx?MessageID=1003&DiscussionID=" & strDiscussionID & "&QueryID=" & m_lngQueryID & "&IsShowToCustomer=" & strTempIsShowToCustomer & "&MultipleRequests=0&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & "&PkToken=" & strToken & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")

                    .Write("</script>")
                End With
            Else
                ' silent mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_47(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If
        End If


        strSQLStatus = "usp_UPD_tbl_CRM_Query_master_DT " + m_lngQueryID.ToString + "," + m_intStatusID.ToString + ",'" + CommonFunctions.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) + "'"

        strSQLStatus = strSQLStatus & ",'" & Date.Now.ToString("dd-MMM-yyyy") & "'"
        strSQLStatus = strSQLStatus & ",'" & DateTime.Now.ToString("hh:mm") & "'"

        CommonFunction.Data.InsertOrUpdateData(strSQLStatus, m_blnUseSQL)

        PerformFileOperation(strDiscussionID)


    End Sub
    Private Sub PerformFileOperation(ByVal strDiscussionID As String)
        Dim count As Integer = 0
        Dim strSQL As String
        Dim strPath As String
        Dim strFileName As String
        Dim strOriginalFileName As String
        Dim strDescription As String
        Dim arrDescription() As String
        Dim ShowToCustomer As String
        Dim intFileCount As Integer = 0
        Dim Flag As Integer = 0
        strPath = Server.MapPath("../../../Attachments/CRM/")

        If Request.Files.Count = 5 Then
            intFileCount = Request.Files.Count + 1
        Else
            intFileCount = Request.Files.Count
        End If



        While (Request.Files.Count - 1) >= count
            If Request.Files(count).FileName <> "" Then
                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

                Dim objFile As New FileUpload.cUpload(Request.Files.Keys.Item(count), strPath, strFileName)

                objFile.OverwriteIfExists = True
                objFile.UploadFile()

                ' the file name
                strOriginalFileName = objFile.OriginalFileName
                strFileName = objFile.UploadedFileName

                objFile = Nothing
                If Request.Form("txtComments") IsNot Nothing Then
                    arrDescription = Request.Form("txtComments").Split(",")
                    If count = 4 And arrDescription.Length = 4 Then
                        Flag = 1
                    Else
                        Flag = 0
                    End If
                    If Flag = 0 Then
                        strDescription = ""
                        If arrDescription.Length > count Then
                            strDescription = arrDescription(count)
                        End If
                        ShowToCustomer = Request.Form("chkIsShowToCustomer" + CType(count, String))
                        If ShowToCustomer = "on" Then
                            ShowToCustomer = "I"
                        End If

                        If (Len(strOriginalFileName) > 100) Then
                            strOriginalFileName = Right(strOriginalFileName, 100) & ""
                        End If

                        If ShowToCustomer = "I" Then
                            strSQL = "usp_NG2_CRM_Insert_Attachment '" & m_lngQueryID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','"
                            strSQL &= CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "','"
                            strSQL &= CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(Session("LoginType").ToString) & "','" & CommonFunctions.General.BuildQueryString(ShowToCustomer) & "'," & strDiscussionID
                        Else
                            strSQL = "usp_NG2_CRM_Insert_Attachment '" & m_lngQueryID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','"
                            strSQL &= CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "','"
                            strSQL &= CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(Session("LoginType").ToString) & "',''," & strDiscussionID
                        End If

                        If Trim(strSQL & "") <> "" Then
                            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                        End If
                    End If
                End If
            End If
            count += 1

        End While
    End Sub
    'End of Added By Bharat T on 25th-Oct-2017 for Discussion and attachmetn changes

    Function DrawRequestDetails(ByVal ShowProductCombo As String, ByVal DepartmentID As String, ByVal CustomerID As String, ByVal EmployeeID As String) As String

        Dim strSQL As String

        'If Not Request("DisableStatuscombo") Is Nothing Then
        '    If Trim(Request("DisableStatuscombo") & "") = "1" Then blnDisableStatusCombo = True
        'End If
        StrLoggedDetails = "usp_NG2_SEL_LoggedPerson " & m_lngQueryID & "," & Session("intUserID") & ",'" & m_strLoginType & "'"

        drGetLoggedDetails = CommonFunction.Data.GetDataReader(StrLoggedDetails, MyBase.UseSQL)
        While drGetLoggedDetails.Read()
            strFlagEmployee = drGetLoggedDetails("EmployeeFlag").ToString()
            RequestSubmittedBy = drGetLoggedDetails("SubmittedBy").ToString()
            IsHRM = CType(CommonFunctions.Data.CheckIsDBNull(drGetLoggedDetails("IsHRM"), ""), String)
            IsRequestFlagged = CType(CommonFunctions.Data.CheckIsDBNull(drGetLoggedDetails("IsRequestFlagged"), ""), String)
            IsAssigned = CType(CommonFunctions.Data.CheckIsDBNull(drGetLoggedDetails("IsAssigned"), ""), String)
        End While
        If IsHRM <> "" Then
            If IsHRM = True Then
                IsHRM = "1"
            Else
                IsHRM = "0"
            End If
        Else
            IsHRM = "0"
        End If

        If IsRequestFlagged <> "" Then
            If IsRequestFlagged = True Then
                IsRequestFlagged = "1"
            Else
                IsRequestFlagged = "0"
            End If
        Else
            IsRequestFlagged = "0"
        End If


        If IsAssigned <> "" Then
            If IsAssigned = True Then
                IsAssigned = "1"
            Else
                IsAssigned = "0"
            End If
        Else
            IsAssigned = "0"
        End If



        If m_strLoginType = "E" Then
            If RequestSubmittedBy = Session("strUserName") Then
                strFlagPlotProjectDetails = "1"
            End If
        End If

        If UCase(Trim(m_strMode & "")) = "EDIT" Then

            ' Get request details of current request from database
            'Added m_intShow by ShraddhaM to performance check for WhizibleSem9.0
            If m_intShow = 1 Then

                dr = CommonFunction.Data.GetDataReader("usp_NG2_CRM_Get_UnCategorizedRequestDetails " & m_lngQueryID, m_blnUseSQL)
                If dr.Read Then
                    strAssignTo = CommonFunctions.Data.CheckIsDBNull(dr("AssignedToEmployee"), "").ToString
                    intAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Integer)
                    'To display requested time along with date.
                    m_strSubmittedDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubmittedDate"), ""), String)
                    dtmSubmittedDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubmittedDate"), ""), Date)
                    m_intDiscussionThreadCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("DiscussionThreads"), "0"), Integer)
                    lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FunctionID"), "0"), Long)

                    'To Display requestID and Requestor in Edit Mode
                    lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestID"), "0"), Long)
                    strRequestor = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerID")), String)
                    strRequestorName = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerName")), String)
                    m_lngRequestTypeId = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0"), Long)
                    lngRequestTypeIdOld = m_lngRequestTypeId
                    m_lngSubRequestTypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0"), Long)
                    strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
                    strSubject = dr("Subject").ToString
                    ' For storing Request Subject (which is passed to Flag tracker)
                    m_strSubject = dr("Subject").ToString
                    ' Security Issue
                    m_strEmailID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Email"), "0"), String)
                    m_strSubject = m_strSubject.Replace("<", "&#60")
                    m_strSubject = m_strSubject.Replace(">", "&#62")
                    strDescription = dr("Description").ToString

                    ''Added by Usha Pandit on 29.12.2018 for HTML Email Content display issue after conversion
                    strTextDescription = dr("TextDescription").ToString
                    ''End of Added by Usha Pandit on 29.12.2018 for HTML Email Content display issue after conversion

                    intPriorityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("PriorityID"), "0"), Integer)
                    If Not IsDBNull(dr("ExpectedResolvedDate")) Then
                        strExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("ExpectedResolvedDate"), Date))
                    End If
                    If Not IsDBNull(dr("CRMExpectedResolvedDate")) Then
                        strCRMExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("CRMExpectedResolvedDate"), Date))
                    End If
                    lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
                    strComments = dr("Comments").ToString
                    strReasonsForRejection = dr("ReasonsForRejection").ToString
                    intStatusID = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusID"), "0"), Integer)
                    lngTargetLocationID = CType(CommonFunctions.Data.CheckIsDBNull(dr("TargetLocationID"), "0"), Long)
                    intFeedbackID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FeedbackID"), "0"), Integer)
                    strFeedbackComments = dr("FeedbackComments").ToString
                    m_strDeliverableID = dr("DeliverableID").ToString
                    ' lets see if we can allow attachment deletion 

                    Dim strRequestorID As String = ""
                    If CType(CommonFunctions.Data.CheckIsDBNull(dr("IsAttachmentMandatory"), "0"), Boolean) And lngAssignTo <> 0 Then
                        m_blnAllowAttachmentDeletion = False
                    End If
                    'Added by SrikanthY on 05 Jan 2007 To Get Values of Product,Components in Edit Mode
                    m_ChangedProduct = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
                    m_ChangedModule = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)
                    m_ChangedProject = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectID"), "0"), Integer)
                    m_RequeststrLoginType = CType(CommonFunctions.Data.CheckIsDBNull(dr("LoginType"), "0"), String)
                    m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(dr("ClientName"), "0"), String)
                    lngProductID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
                    If lngProductID = 0 Then
                        lngProductID = -1
                    End If
                    lngComponentID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)
                    ' Add Field for Severity 
                    intSeverityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SeverityID"), "0"), Integer)
                    m_strStatusChangeDateValue = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusChangeDate")), String)
                    m_strStatusChangeTimeValue = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusChangeTime")), String)
                    strReportingTo = CommonFunctions.Data.CheckIsDBNull(dr("ReportingToName"), "-")
                    strAprovalStatus = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ApprovalStatus"), "-"), "")
                    '' TimeZoneID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TimeZone"), ""), "")
                End If

                CommonFunctions.Data.DisposeDataReader(dr)

                dr = CommonFunction.Data.GetDataReader("usp_NG2_SEL_tbl_CRM_Query_Master_Timezone " & m_lngQueryID, m_blnUseSQL)
                If dr.Read Then
                    TimeZoneID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TimeZone"), ""), "")
                End If
                CommonFunctions.Data.DisposeDataReader(dr)


                If TimeZoneID = "" Then

                    dr = CommonFunction.Data.GetDataReader("Usp_NG2_Sel_tbl_FCI_GMTZones ", m_blnUseSQL)
                    If dr.Read Then
                        TimeZoneID = CommonFunctions.Data.CheckIsDBNull(dr("GMTID"), "").ToString
                        TimeZone = CommonFunctions.Data.CheckIsDBNull(dr("ZoneName"), "").ToString
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If

                dr = CommonFunction.Data.GetDataReader("usp_NG2_SEL_tbl_CRM_Query_Master_Keywords " & m_lngQueryID, m_blnUseSQL)
                If dr.Read Then
                    Keywords = CommonFunctions.Data.CheckIsDBNull(dr("Keywords"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(dr)



                m_lngStatusId = intStatusID

                intRequestStatus = intStatusID

                If strFlagEmployee = "1" Then
                    style = "disabled"
                    styleproduct = ""
                Else
                    styleproduct = "disabled"
                End If


                'If FilterFlag = "0" Then
                '    style = "disabled"

                'End If



                'blnDisableProductCombo = True
                'blnDisableModuleCombo = True
                'blnDisableFunctionCombo = True
                'blnDisableRequestTypeCombo = True
                'blnDisableSubRequestTypeCombo = True
                'blnDisableProjectCombo = True
                'blnDisableRequestTypeCombo = True
                m_lngStatusId = intStatusID
                intRequestStatus = intStatusID

                blnDisableProductCombo = True
                blnDisableModuleCombo = True
                blnDisableFunctionCombo = True
                blnDisableSubRequestTypeCombo = True
                blnDisableSubRequestTypeCombo = True
                blnDisableProjectCombo = True

                Select Case UCase(Trim(strFlagEmployee & ""))
                    Case "SR"
                        strGuidelinesColumnName = "GuidelinesForRequestor"
                        blnDisabledAssignToCombo = True
                    Case "AR"
                        strGuidelinesColumnName = "GuidelinesForAssignee"
                        blnDisabledAssignToCombo = True
                    Case "DB"
                        blnDisabledAssignToCombo = False
                    Case "MD"
                        blnDisabledAssignToCombo = False
                    Case "SupportDept"
                        blnDisabledAssignToCombo = False
                    Case "Approval"
                        blnDisabledAssignToCombo = False
                End Select

                If intRequestStatus = 2 Then
                    blnDisableProductCombo = True
                    blnDisableModuleCombo = True
                    blnDisableFunctionCombo = True
                    blnDisableSubRequestTypeCombo = True
                    blnDisableSubRequestTypeCombo = True
                    blnDisableProjectCombo = True
                    blnDisableSeverityCombo = True
                    blnDisablePriorityCombo = True
                    blnDisableStatusChangeTime = True
                    blnDisableStatusChangeDate = True
                    blnDisableExpResolDate = True
                End If
                If strFlagEmployee = "SupportDept" Then
                    blnDisableProductCombo = True
                    blnDisableModuleCombo = True
                    blnDisableFunctionCombo = True
                    blnDisableSubRequestTypeCombo = True
                    blnDisableSubRequestTypeCombo = True
                    blnDisableProjectCombo = True
                    blnDisableSeverityCombo = True
                    blnDisablePriorityCombo = True
                    blnDisableStatusChangeTime = True
                    blnDisableStatusChangeDate = True
                    blnDisableExpResolDate = True
                    blnDisableModuleProductCombo = True
                End If

            End If
        End If
        strHeaderDtls = "usp_NG2_Sel_RequestHeaderDetails " + m_lngQueryID.ToString + "," + Session("intUserID").ToString()

        drDtls = CommonFunction.Data.GetDataReader(strHeaderDtls, MyBase.UseSQL)
        RequestID = m_lngQueryID
        While drDtls.Read()
            strRequestor = drDtls("CustomerID").ToString()
            m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("ClientName"), "0"), String)

            m_strSubmittedDate = drDtls("SubmittedDate").ToString()
            FlagTo = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagTo"), "2"), String)
            FlagDateStatus = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagDateStatus"), "E"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drDtls)


        Dim drEmployee As IDataReader
        If m_intRequestedEmployee <> 0 Then
            Dim StrEmployee As String
            StrEmployee = "usp_sel_tbl_pm_employee_EmployeeName_PostID_UserName " & m_intRequestedEmployee

            drEmployee = CommonFunctions.Data.GetDataReader(StrEmployee, m_blnUseSQL)
            If drEmployee.Read Then
                m_strRequestedEmployee = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
                m_intRequestedEmployeePost = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("PostID"), "0"), Integer)
                m_strRequestedEmployeeUN = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("UserName"), ""), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)


        Dim strPriority As String = "usp_NG2_Sel_Request_Priority " & intPriorityID
        Dim Priority As String = ""
        Dim drPriority As IDataReader = CommonFunction.Data.GetDataReader(strPriority, True)
        While drPriority.Read()
            Priority = drPriority("Priority").ToString()
        End While
        CommonFunction.Data.DisposeDataReader(drPriority)

        If FlagTo = "1" Then
            FlagStatus = "Review"

        ElseIf FlagTo = "0" Then
            FlagStatus = "Follow Up"
        Else
            FlagStatus = "Flag To"
        End If

        If FlagDateStatus = "L" Then
            FlagImage = "../../../Images/RedFlag.gif"
        ElseIf FlagDateStatus = "G" Then
            FlagImage = "../../../Images/GreenFlag.gif"
        ElseIf FlagDateStatus = "S" Then
            FlagImage = "../../../Images/YellowFlag.gif"
        ElseIf FlagDateStatus = "B" Then
            FlagImage = "../../../Images/BlackFlag.gif"
        Else
            FlagImage = "../../../Images/GrayFlag.gif"
        End If
        blnDisableFunctionCombo = True

        'strHTML.Append("<div class='request-details-pg'>")
        'strHTML.Append("<div class='row'>")

        strHTML.Append("<input type=hidden id=hdnDepartmentID name=hdnDepartmentID value='" & lngFunctionID & "' />")
        strHTML.Append("<div class='col-lg-8'>")
        strHTML.Append("<div class='reqeust-discu'>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append("<div class='req-title'>")
        '  strHTML.Append("<div class='col-xs-
        strHTML.Append("<div class='col-xs-6'>")

        'Commented and Added by Usha Pandit on 23 JAN 2018 for large font issue
        'strHTML.Append("<h2>Reference ID: " & RequestID & "</h2>	")
        strHTML.Append("<div>Reference ID: " & RequestID & "</div>	")

        'End of Added by Usha Pandit on 23 JAN 2018 for large font issue 

        strHTML.Append("</div>")

        'strHTML.Append("<div class='col-xs-10'>")
        ''Commented By Vidya Jadhav ON 25 Oct 2017 For Request Details -Description
        'strHTML.Append("<div class='col-xs-6'>")
        'strHTML.Append(" <div class='controls pull-right hidden-xs'>")
        'strHTML.Append("<a class='left fa fa-caret-left btn' href='#carousel-example' data-slide='prev'></a><a class='right fa fa-caret-right btn' href='#carousel-example' data-slide='next'></a>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        ''End Of Commented By Vidya Jadhav ON 25 Oct 2017 For Request Details -Description
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div class='quest-info-new'>")

        strHTML.Append("<p id='idSubject' Title='Subject'>" & strSubject & "</p>")
        ''Added By Vidya Jadhav ON 25 Oct 2017 For Request Details -Description

        ''Commented and Added by Usha Pandit on 29.12.2018 for HTML Email Content display issue after conversion

        'strHTML.Append("<span id='spnDescription'  Title='Description' >" & strDescription & "</span>")

        If Not strDescription Is Nothing And Not strDescription = "" Then
            strDescription = strDescription.Replace("<USERNAME>", "&lt;USERNAME&gt;")
            strHTML.Append("<span id='spnDescription'  Title='Description' >" & strDescription & "</span>")
        Else
            If Not strTextDescription Is Nothing Then
                strTextDescription = strTextDescription.Replace("<USERNAME>", "&lt;USERNAME&gt;")
            End If
            strHTML.Append("<span id='spnDescription'  Title='Description' >" & strTextDescription & "</span>")
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for HTML Email Content display issue after conversion


        ''End Of Added By Vidya Jadhav ON 25 Oct 2017 For Request Details -Description
        Dim drProjectCount As IDataReader
        Dim blnComplete As Boolean
        Dim DueDate As String
        Dim FlagTo1 As String = ""
        Dim FlagMain As String = ""
        Dim FlagColor As String = ""
        Dim strContextType As String = ""
        Dim m_intUniqueID As Integer = 0
        drProjectCount = CommonFunctions.Data.GetDataReader("usp_NG_ShowFlagDetailswithcolor " & RequestID & ", " + CType(HttpContext.Current.Session("intUserID"), String), True)
        If drProjectCount.Read() Then
            m_intUniqueID = CType(drProjectCount("UniqueID"), Integer)
            blnComplete = CType(drProjectCount("IsComplete"), Boolean)
            DueDate = CType(drProjectCount("DueDate"), String)
            FlagTo1 = CType(drProjectCount("FlagTo"), String)
            FlagColor = CType(drProjectCount("FlagColor"), String)
        End If

        If FlagTo1 = "1" Then
            FlagMain = "Review"
        ElseIf FlagTo1 = "0" Then

            FlagMain = "Follow Up"
        Else
            FlagMain = "Flag To"
        End If
        'ADDED BY DIPALI V ON 1ST NOV 
        Dim ShowToCustFlag As Boolean
        Dim strTR As String
        Dim SubmittedDatenew As String
        Dim isValidDelete As Boolean
        Dim drDiscussionDelete As IDataReader
        drDiscussionDelete = CommonFunctions.Data.GetDataReader("usp_CRM_Discussions " & RequestID & "", True)
        If drDiscussionDelete.Read() Then
            ShowToCustFlag = CommonFunction.Data.CheckIsDBNull(drDiscussionDelete("IsShowToCustomer"), 0)
            SubmittedDatenew = CommonFunction.Data.CheckIsDBNull(drDiscussionDelete("SubmittedDate").ToShortDateString(), "")
            m_strSubmittedBy = CommonFunction.Data.CheckIsDBNull(drDiscussionDelete("SubmittedBy"), "")
        End If

        ' ShowToCustFlag = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ISSHOWTOCUSTOMER"), "0"), Boolean)
        'm_strSubmittedBy = Args.DataReader("SUBMITTEDBY").ToString
        'END OF ADDED BY DIPALI V ON 1ST NOV 

        If m_RequeststrLoginType.ToUpper = "C" Then
            If m_strClienName = "0" Then
                ''Commented and Added by Yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9507
                'strHTML.Append("<div><span class='request-date'>Requestor : " & strRequestor.ToString & "</span><span class='request-date'>Requested On</span><span>" & m_strSubmittedDate & "</span><span span data-toggle='tooltip' title='Priority'><a href='#'  id='spnPriority'>" & Priority & "</a></span>")
                strHTML.Append("<div class='quest-info'><span class='request-date'><label class='label label-info' style='font-size:12px;'>Requestor : " & strRequestor.ToString & "</label></span><span class='request-date'>Requested On</span><span class='request-date'>" & m_strSubmittedDate & "</span><span span data-toggle='tooltip' title='Priority'><a href='#'  id='spnPriority'>" & Priority & "</a></span>")
                ''End by yogesh Jalamkar

                'If CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "L" Then
                '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag'  style='color:red !important;' aria-hidden='true'></i></button></span>")
                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "G" Then
                '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:green !important;' aria-hidden='true'></i></button></span>")

                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "S" Then
                '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:orange !important;' aria-hidden='true'></i></button></span>")
                '    'To Display Black flag for Completed Flaged requests
                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "B" Then
                '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:black !important;' aria-hidden='true'></i></button></span>")
                'Else
                '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='Flag'><i class='fa fa-flag-o' style='color:#f88394 !important;' aria-hidden='true'></i></button></span>")

                'End If

                strHTML.Append("</div>")
            Else
                If m_strClienName <> "" Then
                    ''Commented and Added by Yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9507
                    'strHTML.Append("<div><span class='request-date'>Requestor : " & strRequestor.ToString + " | " + m_strClienName & "</span><span class='request-date'>Requested On</span><span>" & m_strSubmittedDate & "</span><span span data-toggle='tooltip' title='Priority'><a href='#' id='spnPriority'>" & Priority & "</a></span>")
                    strHTML.Append("<div><span class='request-date'>Requestor : " & strRequestor.ToString + " | " + m_strClienName & "</span><span class='request-date'>Requested On</span><span class='request-date'>" & m_strSubmittedDate & "</span><span span data-toggle='tooltip' title='Priority'><a href='#' id='spnPriority'>" & Priority & "</a></span>")
                    ''End by yogesh Jalamkar
                    'If CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "L" Then
                    '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag'  style='color:red !important;' aria-hidden='true'></i></button></span>")
                    'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "G" Then
                    '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:green !important;' aria-hidden='true'></i></button></span>")

                    'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "S" Then
                    '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:orange !important;' aria-hidden='true'></i></button></span>")
                    '    'To Display Black flag for Completed Flaged requests
                    'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "B" Then
                    '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:black !important;' aria-hidden='true'></i></button></span>")
                    'Else
                    '    strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='Flag To'><i class='fa fa-flag-o' style='color:#f88394 !important;' aria-hidden='true'></i></button></span>")

                    'End If
                    strHTML.Append("</div>")
                End If
            End If
        ElseIf m_RequeststrLoginType.ToUpper = "E" Then
            ''Commented and Added by Yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9507
            'strHTML.Append("<div><span class='request-date'>Requestor : " & strRequestor & "</span><span class='request-date'>Requested On</span><span>" & m_strSubmittedDate & "</span><span data-toggle='tooltip' title='Priority'><a href='#'  id='spnPriority'>" & Priority & "</a></span>")
            strHTML.Append("<div><span class='request-date'>Requestor : " & strRequestor & "</span><span class='request-date'>Requested On</span><span class='request-date'>" & m_strSubmittedDate & "</span><span data-toggle='tooltip' title='Priority'><a href='#'  id='spnPriority'>" & Priority & "</a></span>")
            ''End by yogesh Jalamkar

            If CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "L" Then
                strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag'  style='color:red !important;'  aria-hidden='true'></i></button></span>")
            ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "G" Then
                strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:green !important;' aria-hidden='true'></i></button></span>")

            ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "S" Then
                strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:orange !important;' aria-hidden='true'></i></button></span>")
                'To Display Black flag for Completed Flaged requests
            ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "B" Then
                strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:black !important;' aria-hidden='true'></i></button></span>")
            Else
                strHTML.Append("<span id='spnflag'><button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='Flag To'><i class='fa fa-flag-o' style='color:#f88394 !important;' aria-hidden='true'></i></button></span>")

            End If



            strHTML.Append("</div>")
        End If

        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(m_strSubmittedDate), , , , , , True, , EnableHTMLEncode:=True)

        ''Added by yogesh Jalamkar on 29-NOV-2017 Purpose : Issue fixing
        'If strRequestor = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName")) Then
        If strAprovalStatus <> "" Then
            If Not strAprovalStatus Is Nothing And strAprovalStatus <> "-" And strAprovalStatus.Trim() <> "" Then

                strHTML.Append("<div><span class='request-date'>")
                If strAprovalStatus.Trim() = "A" Then
                    strHTML.Append(" Request has been approved by : " + strReportingTo)
                ElseIf strAprovalStatus.Trim() = "R" Then
                    strHTML.Append("Request has been rejected by : " + strReportingTo)
                Else
                    strHTML.Append("Request has been sent for approval to : " + strReportingTo)
                    Dim strSQLApprover As String
                    Dim m_bitApproveAccess As Boolean
                    Dim dr As IDataReader
                    strSQLApprover = "Exec Usp_NG2_CheckAccess_For_ApproveReject " & Session("intUserID") & ",'" & Session("LoginType") & "'"
                    dr = CommonFunctions.Data.GetDataReader(strSQLApprover, True)
                    If dr.Read Then
                        m_bitApproveAccess = CType(CommonFunctions.Data.CheckIsDBNull(dr("ApproveRejectAccess"), 0), Boolean)
                    End If

                    If m_bitApproveAccess = True Then

                        ''Added by yogesh Jalamkar on 22-DEC-2017 Purpose: Issue Id = 10085
                        If m_lngStatusId <> 2 Then

                            ''End by yogesh Jalamkar
                            strHTML.Append("<div class=col-sm-6 style='display:inline-block;float:none' id='divAprroveReject'>")
                            strHTML.Append("<div style='position:relative;display:inline-block;'>")
                            strHTML.Append("<i class='fa fa-check'  data-toggle='dropdown' title='Accept'></i>&nbsp;&nbsp;")
                            strHTML.Append("<div class='dropdown-menu'>")
                            strHTML.Append("<form>")
                            strHTML.Append("<table class='table clstblApprove'>")
                            strHTML.Append("<tr>")
                            strHTML.Append("<td>")
                            strHTML.Append("Comment* ")
                            strHTML.Append("</td>")
                            strHTML.Append("<td>")
                            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAComments", "txtAComments", , "form-control", , , , , , , , , , , , , , , "class='form-control' ", True))
                            strHTML.Append("</td>")
                            strHTML.Append("</tr>")
                            strHTML.Append("<tr>")
                            strHTML.Append("<td>")
                            strHTML.Append("</td>")
                            strHTML.Append("<td>")
                            strHTML.Append("<button type=button class='tablinks btn btn-default save' style='float:right' onclick='ApproveRequest(" & RequestID & ")' id='btnApprove' title='Approve'>Accept</button>")
                            strHTML.Append("</td>")
                            strHTML.Append("</tr>")
                            strHTML.Append("</table>")
                            strHTML.Append("</form>")
                            strHTML.Append("</div>")
                            strHTML.Append("</div>")
                            strHTML.Append("<div style='position:relative;display:inline-block;'>")
                            strHTML.Append("<i class='fa fa-close' data-toggle='dropdown'title='Decline'></i>")
                            strHTML.Append("<div class='dropdown-menu'>")
                            strHTML.Append("<table class='table clstblApprove'>")
                            strHTML.Append("<tr>")
                            strHTML.Append("<td>")
                            strHTML.Append("Comment* ")
                            strHTML.Append("</td>")
                            strHTML.Append("<td>")
                            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRComments", "txtRComments", , "form-control", , , , , , , , , , , , , , , "class='form-control' ", True))
                            strHTML.Append("</td>")
                            strHTML.Append("</tr>")
                            strHTML.Append("<tr>")
                            strHTML.Append("<td>")
                            strHTML.Append("</td>")
                            strHTML.Append("<td>")
                            strHTML.Append("<button type=button class='tablinks btn btn-default save' style='float:right' onclick='RejectRequest(" & RequestID & ")' id='btnReject' title='Reject'>Decline</button>")
                            strHTML.Append("</td>")
                            strHTML.Append("</tr>")
                            strHTML.Append("</table>")
                            strHTML.Append("</div>")
                            strHTML.Append("</div>")
                            strHTML.Append("</div>")
                        End If
                    End If
                End If
                strHTML.Append("</span></div>")
            End If
        End If
        'End If
        ''End by Yogesh Jalamkar
        strHTML.Append("</div>")

        Dim chkSLAAccess As String
        Dim strSQLQuery1 As String
        strSQLQuery1 = "EXEC usp_NG2_AllowToSeeHelpdeskSLA " & Session("intLoginID") & "," & RequestID & ",'" & Session("LoginType") & "'"
        chkSLAAccess = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery1, True), "0")


        strHTML.Append("<div class='tab-section'>")
        strHTML.Append("<div class='tab' id='buttontabs'>")

        'strHTML.Append("<button type=button class='tablinks' onclick=""openCity(event, 'Discussion')"" id='defaultOpen' title='Discussion'>Discussion</button>")
        'strHTML.Append(" <button  type=button class='tablinks' onclick=""openCity(event, 'History')""  title='History'>History</button>")

        'If strHasEditAccess = True Then
        '    strHTML.Append(" <button  type=button class='tablinks' onclick=""openCity(event, 'Activities')"" title='Activities'>Activities</button>")
        'Else
        'End If
        ''Commented and Added by yogesh Jalamkar on 06-DEC-2017 Purpose: After delete attachment in discussion  section it should not display
        If (CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "").ToUpper() = "ATTACHMENTDELETE") Then
            strHTML.Append("<button  type=button class='tablinks active' id='btnAttachement' onclick=""openCity(event, 'Attachments')"" title='Attachments'>Attachments</button>")

        Else
            strHTML.Append("<button  type=button class='tablinks' id='btnAttachement' onclick=""openCity(event, 'Attachments')"" title='Attachments'>Attachments</button>")
        End If
        ''End by Yogesh Jalamkar

        'If (CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "").ToUpper() = "SAVEDELIVERABLEREFRESH") Then
        '    If strHasHRMEditAccess = True Then
        '        strHTML.Append("<button  type=button class='tablinks active' onclick=""openCity(event, 'Association')"" title='Association'>Association</button>")
        '    Else
        '    End If
        'Else
        '    If strHasHRMEditAccess = True Then
        '        strHTML.Append("<button  type=button class='tablinks' onclick=""openCity(event, 'Association')"" title='Association'>Association</button>")
        '    Else
        '    End If
        'End If



        'If chkSLAAccess = "1" Then
        '    strHTML.Append(" <button  type=button class='tablinks sla-tablink' onclick=""openCity(event, 'sla')"" title='SLA'>SLA</button>")
        'Else
        'End If
        strHTML.Append("</div>")


        strHTML.Append("<div id='Discussion' class='tabcontent'>")

        strHTML.Append("<div class='row divRowHeader' style='margin-top:-4%' >")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div class='btn-section'>")
        strHTML.Append("<div class='add-forwd-btn'>")

        strHTML.Append("<button onclick=""document.getElementById('id06').style.display='block'""  type='button' class='btn btn-default reply-btn'  title='Reply' style='display:none;'>Reply</button>")
        strHTML.Append("<button onclick=""document.getElementById('id08').style.display='block'"" type='button' class='btn btn-default reply-btn'  title='Forward' style='display:none;'>Forward</button>")
        strHTML.Append("<button id='idDivLblAddDis' onclick=""document.getElementById('id07').style.display='block'"" type='button' class='btn btn-default note-btn'  title='Add New Discussion'><i class='fa fa-plus' aria-hidden='true'></i> Add New Discussion</button>")


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<h3 style='margin-left:3%'>Discussion</h3>")
        strHTML.Append("</div>")




        Dim strDiscussions As String = ""
        strDiscussions = "usp_NG2_Sel_CRM_Discussions " & RequestID & ",'" & m_strLoginType & "'"
        Dim drDiscussions As New DataTable
        drDiscussions = CommonFunctions.Data.GetDataTable(strDiscussions, True)
        Dim strSQLTemp As String = "usp_sel_tbl_CRM_Query_Master_LoginType '" & m_lngQueryID.ToString() & "'"


        Dim strLoginTypeTemp As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLTemp, MyBase.UseSQL), ""), ""), String)
        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        Dim Flag As Integer = 0
        Dim Counter As Integer = 0
        Dim strNoOfAttachments As String = ""
        Dim strCRMQueryDetailID As String = ""
        Dim strSubmittedTime As String = ""
        Dim SubmittedLoginType As String = ""
        Dim CustomerPhoto As String = ""
        ''Commented and added by Yogesh Jalamkar on 28-NOV-2017 Purpose:Page Crash
        'Dim IsShowToCustomer As String
        Dim IsShowToCustomer As Boolean
        ''End of comment by YOgesh Jalamkar
        Dim strUserNameOfSubmittedDis As String = ""
        'Dim strEmployeeImage As String = ""
        'Dim strCustomerImage As String = ""
        For i As Integer = 0 To drDiscussions.Rows.Count - 1
            Flag = 1

            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SystemFileName").ToString, "")
            CustomerPhoto = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("CustomerPhoto").ToString, "")

            SubmittedDate = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SubmittedDate").ToString(), "")
            DiscussionThread = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("DiscussionThread").ToString, "")
            SubmittedBy = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SubmittedBy").ToString, "")
            strUserNameOfSubmittedDis = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("UserName").ToString, "")
            'Added By Bharat T on for no of attachment against a discussion
            strNoOfAttachments = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("NoOfAttachments").ToString, "0")
            strCRMQueryDetailID = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("CRMQueryDetailId").ToString, "0")
            strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SubmittedTime").ToString, "")
            SubmittedLoginType = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("loginType").ToString, "")
            'IsShowToCustomer = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.General.CheckIsNothing(drDiscussions.Rows(i)("IsShowToCustomer"), ""), ""), String)
            IsShowToCustomer = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("IsShowToCustomer"), False), False)
            'End of Added By Bharat T on for no of attachment against a discussion
            Dim strEmployeeImage As String = ""
            Dim strCustomerImage As String = ""
            Dim strEmployeeFilePath As String = ""
            Dim strCustomerFilePath As String = ""
            Dim k As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
            strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, k - 1)
            strEmployeeImage = strEmployeeImage.Replace("\", "/")


            Dim k1 As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
            strCustomerImage = HttpContext.Current.Request.Url.ToString.Substring(0, k1 - 1)
            strCustomerImage = strEmployeeImage.Replace("\", "/")

            If Not SystemFileName Is Nothing Then
                strEmployeeFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), SystemFileName)
                '' strEmployeeFilePath = strEmployeeImage + "/Images/Photo/" + SystemFileName
            End If

            If Not CustomerPhoto Is Nothing Then
                'strCustomerFilePath = strCustomerImage + "/Images/Photo/" + CustomerPhoto
                strCustomerFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), CustomerPhoto)
            End If


            If SubmittedLoginType = "E" Then
                If File.Exists(strEmployeeFilePath) = False Or CommonFunctions.General.CheckIsNothing(SystemFileName) = "" Then
                    strEmployeeImage = strEmployeeImage + "/Images/Photo/no-photo.png"
                Else
                    strEmployeeImage = strEmployeeImage + "/Images/Photo/" + SystemFileName
                End If
            Else
                If File.Exists(strCustomerFilePath) = False Or CommonFunctions.General.CheckIsNothing(CustomerPhoto) = "" Then
                    strCustomerImage = strCustomerImage + "/Images/Photo/no-photo.png"
                Else
                    strCustomerImage = strCustomerImage + "/Images/Photo/" + CustomerPhoto
                End If

            End If


            If SubmittedBy = HttpContext.Current.Session("strUserName") Then
                'If (IsShowToCustomer <> 1) Then

                Dim styleClass As String = ""
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-md-12'>")
                strHTML.Append("<div class='discus-part odd-discus-part'>")

                If SubmittedLoginType <> "C" And (IsShowToCustomer = False) Then
                    strHTML.Append("<div class='discus-chat odd-discus-chat internalrequest'>")
                ElseIf CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") <> "C" And IsShowToCustomer = True And strLoginTypeTemp = "C" Then
                    strHTML.Append("<div class='discus-chat odd-discus-chat'> ")
                Else
                    strHTML.Append("<div class='discus-chat odd-discus-chat'>")
                End If
                'strHTML.Append("<div class='discus-chat odd-discus-chat'>")

                strHTML.Append("<div class='row'>")
                ''style='padding-left: 0;'
                strHTML.Append("<div class='col-xs-1' >")
                ''''''''''''''''''''''''''''''''''''''''''''''
                'If SubmittedLoginType = "E" Then
                '    If SystemFileName = "" Then
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                '    Else


                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SystemFilename"), "") & "'></div>")
                '    End If

                'Else
                '    If CustomerPhoto = "" Then
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                '    ElseIf SubmittedLoginType = "C" Then
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("CustomerPhoto"), "") & "'></div>")
                '    End If
                'End If
                '''''''''''''''''''''''''''''''''''''''''''''''''''''''

                If SubmittedLoginType = "E" Then
                    strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strEmployeeImage & "'></div>")
                ElseIf SubmittedLoginType = "C" Then
                    strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strCustomerImage & "'></div>")
                End If




                'If SystemFileName = "" Or CustomerPhoto = "" Then
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                'ElseIf SubmittedLoginType = "C" Then
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("CustomerPhoto"), "") & "'></div>")
                'Else
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SystemFilename"), "") & "'></div>")
                'End If

                'strHTML.Append("<div class='avatar-name'><p>" & SubmittedBy & "</p></div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-xs-11'>")
                strHTML.Append("<div class='odd-chat'>")
                strHTML.Append("	<div class='row'>")
                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<ul class='left'>")
                strHTML.Append("<li><span>" & strUserNameOfSubmittedDis & "</span></li>")
                strHTML.Append("<li><span>" & SubmittedDate & "&nbsp;&nbsp;" & strSubmittedTime & "</span></li>")
                ''Commented By Vidya Jadhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                ' strHTML.Append("<li class='envelop-link'><button type='button' class='btn bord' style='cursor: default;'><i class='fa fa-envelope' aria-hidden='true'></i></button></li>")
                ''End Of Commented By Vidya Jadhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                strHTML.Append("</ul>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<ul class='right'>")
                'Added By Bharat T on for no of attachment against a discussion


                If m_blnIsAllowDeleteAtDeptLevel = True Then

                    If (CType(SubmittedDate, Date).ToShortDateString()) = CType(DateTime.Today, Date).ToShortDateString() Then
                        If m_strUserName = SubmittedBy Then
                            isValidDelete = True
                        Else
                            isValidDelete = False
                        End If
                    Else
                        isValidDelete = False
                    End If
                Else
                    isValidDelete = False
                End If
                If isValidDelete = False Then
                    styleClass = "margin-right:49px"
                End If

                If strNoOfAttachments.ToString = "1" Then
                    Dim strSQLQuery As String = ""
                    Dim drReader As IDataReader
                    Dim strSystemFileName As String = ""
                    Dim strOriginalFileName As String = ""

                    strSQLQuery = "EXEC usp_NG2_Sel_Documents_Attached_For_CRM_Discussion " & CommonFunctions.General.CheckIsNothing(m_lngQueryID, "") & "," & CommonFunctions.General.CheckIsNothing(strCRMQueryDetailID, "")
                    strSQLQuery += " ,NULL , '-1'"
                    strSQLQuery += ", 'DateAttached', 'DESC'"

                    drReader = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)

                    If (drReader.Read) Then
                        strSystemFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("SystemFileName")))
                        strOriginalFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("OriginalFileName")))
                    End If

                    strHTML.Append("<li class='attach-lnk' style=" & styleClass & "><a href='#' onclick=""Document_OnClick_For_CRM('" & strSystemFileName & "','" & strOriginalFileName & "');"" ><i class='fa fa-paperclip' aria-hidden='true' title='Attachment Count'></i><span>" & strNoOfAttachments & "</span></a></li>")
                ElseIf strNoOfAttachments > 1 Then
                    strHTML.Append("<li class='attach-lnk'  style=" & styleClass & "><a href='#' onclick=""DownloadAttachment(" & m_lngQueryID & "," & strCRMQueryDetailID & ");"" ><i class='fa fa-paperclip' aria-hidden='true' title='Attachments'></i><span>" & strNoOfAttachments & "</span></a></li>")
                Else
                    strHTML.Append("<li class='attach-lnk'  style=" & styleClass & "><a href='#'  ><i class='fa fa-paperclip' aria-hidden='true' title='Attachments'></i><span>" & strNoOfAttachments & "</span></a></li>")
                End If

                'End of Added By Bharat T on for no of attachment against a discussion
                'strHTML.Append("<li class='public-link'><a href='#' title='Publish to Knowledge'>Publish to Knowledge</a></li>")



                'If m_blnIsAllowDeleteAtDeptLevel = True Then

                '    If (SubmittedDate) = CType(DateTime.Today, Date).ToShortDateString() Then
                '        If m_strUserName = SubmittedBy Then
                '            isValidDelete = True
                '        Else
                '            isValidDelete = False
                '        End If
                '    Else
                '        isValidDelete = False
                '    End If
                'Else
                '    isValidDelete = False
                'End If



                'If isValidDelete = True Then
                '    strHTML.Append("<li class='trash-link'><button type='button' class='btn btn-default bord'><i class='fa fa-trash-o' aria-hidden='true' onclick=""Delete_Discussion(" & m_lngQueryID & "," & strCRMQueryDetailID & ")"" Title='Delete Record'></i></button></li>")
                'Else
                '    strHTML.Append("<li class='trash-link'><button type='button' class='btn btn-default bord'><i class='fa fa-trash-o' aria-hidden='true' Title='you do not have acess to delete this record' disabled ></i></button></li>")
                'End If

                If isValidDelete = True Then 'cmmnted By Dipali v 16th Nov
                    strHTML.Append("<li class='trash-link'><i class='fa fa-trash-o' aria-hidden='true' onclick=""Delete_Discussion(" & m_lngQueryID & "," & strCRMQueryDetailID & ")"" Title='Delete Record'></i></li>")
                Else
                    ''Commented By Vidya JAdhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                    '  strHTML.Append("<li class='trash-link'><i class='fa fa-trash-o' aria-hidden='true' Title='you do not have acess to delete this record' disabled ></i></li>")
                    ''End of Commented By Vidya JAdhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                End If 'end by dipali V


                strHTML.Append("</ul>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")

                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-sm-12'>")
                strHTML.Append("<div class='text text-l'><p style='font-weight:600;'></p><input type='checkbox' class='read-more-state' id='post-" & Counter & "' />")
                Dim DiscussionThreadless As String = ""
                Dim DiscussionThreadMore As String = ""
                If DiscussionThread.Length < 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length = 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                    ''Commented And Added By Vaijat K ON 12/12/2017
                    ''ElseIf DiscussionThread.Length > 200 Then
                ElseIf DiscussionThread.Length > 100 Then
                    ''End of Commented And Added By Vaijat K ON 12/12/2017
                    DiscussionThreadless = DiscussionThread.Substring(0, 100)
                    ''Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 101)
                    DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 100)
                    ''ENd Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadless += "..."
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "<span class='read-more-target'>" & DiscussionThreadMore & "</span></pre>")
                    strHTML.Append("<label for='post-" & Counter & "' class='read-more-trigger' style='width: 16%;background-color: #bfc5ce;'></label>")
                End If
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                'End If

            ElseIf SubmittedLoginType <> "C" And (SubmittedBy <> HttpContext.Current.Session("strUserName")) Then 'For Employee
                Dim styleClass As String = ""


                If m_blnIsAllowDeleteAtDeptLevel = True Then

                    If (CType(SubmittedDate, Date).ToShortDateString()) = CType(DateTime.Today, Date).ToShortDateString() Then
                        If m_strUserName = SubmittedBy Then
                            isValidDelete = True
                        Else
                            isValidDelete = False
                        End If
                    Else
                        isValidDelete = False
                    End If
                Else
                    isValidDelete = False
                End If
                If isValidDelete = False Then
                    styleClass = "margin-right:49px"
                End If
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-md-12'>")
                strHTML.Append("<div class='discus-part'>		")
                strHTML.Append("<div class='discus-chat classevenDiscuss'>")
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-xs-1' style='padding-left: 0;'>")
                'If SystemFileName = "" Then
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                'Else
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SystemFileName"), "") & "'></div>")
                'End If

                '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                'If SubmittedLoginType = "E" Then
                '    If SystemFileName = "" Then
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                '    Else
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SystemFilename"), "") & "'></div>")
                '    End If

                'Else
                '    If CustomerPhoto = "" Then
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                '    ElseIf SubmittedLoginType = "C" Then
                '        strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("CustomerPhoto"), "") & "'></div>")
                '    End If
                'End If
                '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


                If SubmittedLoginType = "E" Then
                    strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strEmployeeImage & "'></div>")
                ElseIf SubmittedLoginType = "C" Then
                    strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strCustomerImage & "'></div>")
                End If




                ' strHTML.Append("<div class='avatar-name'><p>" & SubmittedBy & "</p></div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-xs-11'>")
                strHTML.Append("	<div class='row'>")
                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<ul class='left'>")
                strHTML.Append("<li><span>" & strUserNameOfSubmittedDis & "</span></li>")
                strHTML.Append("<li><span>" & SubmittedDate & "&nbsp;&nbsp;" & strSubmittedTime & "</span></li>")
                ''Commented By Vidya Jadhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                ''    strHTML.Append("<li class='envelop-link'><button type='button' class='btn bord' style='cursor: default;'><i class='fa fa-envelope' aria-hidden='true'></i></button></li>")
                ''End Of Commented By Vidya Jadhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<ul class='right'>")
                'Added By Bharat T on for no of attachment against a discussion
                'strHTML.Append("<li class='attach-lnk'><a href='#' onclick='DownloadAttachment(" & m_lngQueryID & "," & strCRMQueryDetailID & ");'><i class='fa fa-paperclip' aria-hidden='true'></i><span>" & strNoOfAttachments & "</span></a></li>")

                'Added By Bharat T on for no of attachment against a discussion

                If strNoOfAttachments.ToString = "1" Then
                    Dim strSQLQuery As String = ""
                    Dim drReader As IDataReader
                    Dim strSystemFileName As String = ""
                    Dim strOriginalFileName As String = ""

                    strSQLQuery = "EXEC usp_NG2_Sel_Documents_Attached_For_CRM_Discussion " & CommonFunctions.General.CheckIsNothing(m_lngQueryID, "") & "," & CommonFunctions.General.CheckIsNothing(strCRMQueryDetailID, "")
                    strSQLQuery += " ,NULL , '-1'"
                    strSQLQuery += ", 'DateAttached', 'DESC'"

                    drReader = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)

                    If (drReader.Read) Then
                        strSystemFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("SystemFileName")))
                        strOriginalFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("OriginalFileName")))
                    End If

                    strHTML.Append("<li class='attach-lnk' style='" & styleClass & "'><a href='#' onclick=""Document_OnClick_For_CRM('" & strSystemFileName & "','" & strOriginalFileName & "');"" ><i class='fa fa-paperclip' aria-hidden='true' title='Attachment Count'></i><span>" & strNoOfAttachments & "</span></a></li>")
                ElseIf strNoOfAttachments > 1 Then
                    strHTML.Append("<li class='attach-lnk' style='" & styleClass & "'><a href='#' onclick=""DownloadAttachment(" & m_lngQueryID & "," & strCRMQueryDetailID & ");"" ><i class='fa fa-paperclip' aria-hidden='true' title='Attachments'></i><span>" & strNoOfAttachments & "</span></a></li>")
                Else
                    strHTML.Append("<li class='attach-lnk' style='" & styleClass & "'><a href='#'  ><i class='fa fa-paperclip' aria-hidden='true' title='Attachments'></i><span>" & strNoOfAttachments & "</span></a></li>")
                End If

                'End of Added By Bharat T on for no of attachment against a discussion

                'End of Added By Bharat T on for no of attachment against a discussion
                'strHTML.Append("<li class='public-link'><a href='#' title='publish'>Publish to Knowledge</a></li>")
                'If isValidDelete = True Then
                '    strHTML.Append("<li class='trash-link'><button type='button' class='btn btn-default bord'><i class='fa fa-trash-o' aria-hidden='true' onclick=""Delete_Discussion(" & m_lngQueryID & "," & strCRMQueryDetailID & ")"" Title='Delete Records'></i></button></li>")
                'Else
                '    strHTML.Append("<li class='trash-link'><button type='button' class='btn btn-default bord'><i class='fa fa-trash-o' aria-hidden='true' Title='you do not have acess to delete this record' disabled ></i></button></li>")
                'End If

                If isValidDelete = True Then 'cmmnted By Dipali v 16th Nov
                    strHTML.Append("<li class='trash-link'><i class='fa fa-trash-o' aria-hidden='true' onclick=""Delete_Discussion(" & m_lngQueryID & "," & strCRMQueryDetailID & ")"" Title='Delete Record'></i></li>")
                Else
                    ''Commented By Vidya JAdhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                    ''  strHTML.Append("<li class='trash-link'><i class='fa fa-trash-o' aria-hidden='true' Title='you do not have acess to delete this record' disabled ></i></li>")
                    ''End Of Commented By Vidya JAdhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                End If 'end by dipali V

                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-sm-12'>")
                strHTML.Append("<div class='text text-l'><p style='font-weight:600;'></p><input type='checkbox' class='read-more-state' id='post-" & Counter & "' />")
                Dim DiscussionThreadless As String = ""
                Dim DiscussionThreadMore As String = ""
                If DiscussionThread.Length < 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length = 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length > 100 Then
                    DiscussionThreadless = DiscussionThread.Substring(0, 100)
                    ''Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 101)
                    DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 100)
                    ''ENd Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    'DiscussionThreadless += "..."
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "<span class='read-more-target'>" & DiscussionThreadMore & "</span></pre>")
                    strHTML.Append("<label for='post-" & Counter & "' class='read-more-trigger' style='width: 16%;background-color: #bfc5ce;'></label>")
                End If
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                '  End If


            Else
                Dim styleClass As String = ""
                If m_blnIsAllowDeleteAtDeptLevel = True Then

                    If (CType(SubmittedDate, Date).ToShortDateString()) = CType(DateTime.Today, Date).ToShortDateString() Then
                        If m_strUserName = SubmittedBy Then
                            isValidDelete = True
                        Else
                            isValidDelete = False
                        End If
                    Else
                        isValidDelete = False
                    End If
                Else
                    isValidDelete = False
                End If

                If isValidDelete = False Then
                    styleClass = "margin-right:49px;"
                End If

                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-md-12'>")
                strHTML.Append("<div class='discus-part'>		")
                strHTML.Append("<div class='discus-chat classevenDiscuss'>")
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-xs-1' style='padding-left: 0;'>")
                '''''''''''''''''''''''''''''''''''''''''''''''''''''
                'If CustomerPhoto = "" Then
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../img/1920/no-photo.png'></div>")
                'Else
                '    strHTML.Append("<div class='avatar'><img class='img-circle'   src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("CustomerPhoto"), "") & "'></div>")
                'End If
                '''''''''''''''''''''''''''''''''''''''''''''''''''''''
                strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strCustomerImage & "'></div>")



                ' strHTML.Append("<div class='avatar-name'><p>" & SubmittedBy & "</p></div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-xs-11'>")
                strHTML.Append("	<div class='row'>")
                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<ul class='left'>")
                strHTML.Append("<li><span>" & strUserNameOfSubmittedDis & "</span></li>")
                strHTML.Append("<li><span>" & SubmittedDate & "&nbsp;&nbsp;" & strSubmittedTime & "</span></li>")
                ''Commented By Vidya Jadhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                ''  strHTML.Append("<li class='envelop-link'><button type='button' class='btn bord' style='cursor: default;'><i class='fa fa-envelope' aria-hidden='true'></i></button></li>")
                ''End Of Commented By Vidya Jadhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<ul class='right'>")
                'Added By Bharat T on for no of attachment against a discussion
                'strHTML.Append("<li class='attach-lnk'><a href='#' onclick='DownloadAttachment(" & m_lngQueryID & "," & strCRMQueryDetailID & ");'><i class='fa fa-paperclip' aria-hidden='true'></i><span>" & strNoOfAttachments & "</span></a></li>")

                'Added By Bharat T on for no of attachment against a discussion

                If strNoOfAttachments.ToString = "1" Then
                    Dim strSQLQuery As String = ""
                    Dim drReader As IDataReader
                    Dim strSystemFileName As String = ""
                    Dim strOriginalFileName As String = ""

                    strSQLQuery = "EXEC usp_NG2_Sel_Documents_Attached_For_CRM_Discussion " & CommonFunctions.General.CheckIsNothing(m_lngQueryID, "") & "," & CommonFunctions.General.CheckIsNothing(strCRMQueryDetailID, "")
                    strSQLQuery += " ,NULL , '-1'"
                    strSQLQuery += ", 'DateAttached', 'DESC'"

                    drReader = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)

                    If (drReader.Read) Then
                        strSystemFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("SystemFileName")))
                        strOriginalFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("OriginalFileName")))
                    End If

                    strHTML.Append("<li class='attach-lnk' style='" & styleClass & "'><a href='#' onclick=""Document_OnClick_For_CRM('" & strSystemFileName & "','" & strOriginalFileName & "');"" ><i class='fa fa-paperclip' aria-hidden='true' title='Attachment Count'></i><span>" & strNoOfAttachments & "</span></a></li>")
                ElseIf strNoOfAttachments > 1 Then
                    strHTML.Append("<li class='attach-lnk' style='" & styleClass & "'><a href='#' onclick=""DownloadAttachment(" & m_lngQueryID & "," & strCRMQueryDetailID & ");"" ><i class='fa fa-paperclip' aria-hidden='true' title='Attachments'></i><span>" & strNoOfAttachments & "</span></a></li>")
                Else
                    strHTML.Append("<li class='attach-lnk' style='" & styleClass & "'><a href='#'  ><i class='fa fa-paperclip' aria-hidden='true' title='Attachments'></i><span>" & strNoOfAttachments & "</span></a></li>")
                End If

                'End of Added By Bharat T on for no of attachment against a discussion

                'End of Added By Bharat T on for no of attachment against a discussion
                'strHTML.Append("<li class='public-link'><a href='#' title='publish'>Publish to Knowledge</a></li>")
                'If isValidDelete = True Then
                '    strHTML.Append("<li class='trash-link'><button type='button' class='btn btn-default bord'><i class='fa fa-trash-o' aria-hidden='true' onclick=""Delete_Discussion(" & m_lngQueryID & "," & strCRMQueryDetailID & ")"" Title='Delete Records'></i></button></li>")
                'Else
                '    strHTML.Append("<li class='trash-link'><button type='button' class='btn btn-default bord'><i class='fa fa-trash-o' aria-hidden='true' Title='you do not have acess to delete this record' disabled ></i></button></li>")
                'End If

                If isValidDelete = True Then 'cmmnted By Dipali v 16th Nov
                    strHTML.Append("<li class='trash-link'><i class='fa fa-trash-o' aria-hidden='true' onclick=""Delete_Discussion(" & m_lngQueryID & "," & strCRMQueryDetailID & ")"" Title='Delete Record'></i></li>")
                Else
                    ''Commented By Vidya JAdhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                    ''   strHTML.Append("<li class='trash-link'><i class='fa fa-trash-o' aria-hidden='true' Title='you do not have acess to delete this record' disabled ></i></li>")
                    ''End Of Commented By Vidya JAdhav ON 28 Nov 2017 For Helpdesk Issue Fixing
                End If 'end by dipali V

                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-sm-12'>")
                strHTML.Append("<div class='text text-l'><p style='font-weight:600;'></p><input type='checkbox' class='read-more-state' id='post-" & Counter & "' />")
                Dim DiscussionThreadless As String = ""
                Dim DiscussionThreadMore As String = ""
                If DiscussionThread.Length < 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length = 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length > 100 Then
                    DiscussionThreadless = DiscussionThread.Substring(0, 100)
                    ''Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 101)
                    DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 100)
                    ''ENd Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    DiscussionThreadless += "..."
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "<span class='read-more-target'>" & DiscussionThreadMore & "</span></pre>")
                    strHTML.Append("<label for='post-" & Counter & "' class='read-more-trigger' style='width: 16%;background-color: #bfc5ce;'></label>")
                End If
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

            End If



            Counter += 1
        Next
        If Flag <> 1 Then
            strHTML.Append("<label class='lblnodatadiscussion'>There are no items to show in this view.</label>")
        End If
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div class='btn-section' style='margin-bottom: 20px;'>")
        strHTML.Append("<div class='add-forwd-btn'>")
        strHTML.Append("<button onclick=""document.getElementById('id06').style.display='block'""  type='button' class='btn btn-default reply-btn'  title='Reply' style='display:none;'>Reply</button>")
        strHTML.Append("<button type='button' class='btn' style='display:none;'>Forward</button>")
        'commented By Dipali V On 31st Oct 2017 
        ' strHTML.Append("<button onclick=""document.getElementById('id07').style.display='block'""  type='button' class='btn btn-default note-btn'  title='Add Note'>Add Note</button>")
        'End of commented By Dipali V On 31st Oct 2017 
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'Added By Dipali V On 31st Oct 2017 For NexT Ver 2 HelpDesk Enhancement
        'strHTML.Append("<div id='Discussion' class='tabcontent'>")
        'strHTML.Append("</div>")
        'End of Added By Dipali V On 31st Oct 2017 For NexT Ver 2 HelpDesk Enhancement

        strHTML.Append("<div id='History' class='tabcontent'>")
        strHTML.Append("</div>")

        strHTML.Append("<div id='Activities' class='tabcontent'>")
        strHTML.Append("</div>")

        strHTML.Append("<div id='Attachments' class='tabcontent'>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='Association' class='tabcontent'>")
        strHTML.Append("</div>")

        'Added By Dipali V On 31st Oct 2017 For NexT Ver 2 HelpDesk Enhancement
        strHTML.Append("<div id='sla' class='tabcontent'>")
        strHTML.Append("</div>")
        'End of Added By Dipali V On 31st Oct 2017 For NexT Ver 2 HelpDesk Enhancement
        '''''''''''''''''''''''''''''''''''''''''

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-lg-4' id='divControls' >")
        strHTML.Append(PlotRequestControls(strFlagEmployee, IsHRM, IsAssigned))
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Private Function PlotRequestControls(ByVal PageFlag As String, ByVal IsCRMHRM As String, ByVal IsRequestAssigned As String)
        Dim strHTML As New StringBuilder

        strHTML.Append(PlotSubmittedRequestDetails())

        Return strHTML.ToString
    End Function
    Private Function PlotSupportDeptDetails()
        Dim strHTML As New StringBuilder

        strHTML.Append("<div class='request-detail'>")
        strHTML.Append("<div class='detail-inner'>")
        strHTML.Append("<h2>Request Details</h2>")

        strHTML.Append("<form  enctype='multipart/form-data' class='req-del-from' id='divrequestDetails'  method='post'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        ''Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes


        ' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' onclick=Back_OnClick() >Back</button>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Department *</label>")
        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        Dim m_lngCRMID As Long
        Dim DepartmentID As String
        Dim strSQL As String
        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)

        If DepartmentID <> "" Then
            lngFunctionID = DepartmentID
        End If
        ' Check whether logged in person in either HRM or department head 
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If
        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                    strSQL += ",NULL"
                End If
            End If

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled ", False, True, , False))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Request Type *</label>")


        Dim strSQLReqType As String = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
        End If


        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
        Dim strSQLSubReq As String = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) disabled", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
        End If

        If m_lngSubRequestTypeID <> 0 Then
            ' If Sub Request Type is selected
            ' Get Document Templates mapped to Sub Request Type (If Any)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                Select Case intTemplateCount
                    Case 0 ' no templates

                    Case Else ' multiple templates

                        strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../../Images/View.gif' id ='view' title = 'View Template'></A>")
                End Select
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Status *</label>")
        Dim RoleId As String = Session("intPostId")

        ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        'If lngRequestID <> 0 Then
        '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
        'Else
        '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
        'End If

        If lngRequestID <> 0 Then
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & lngRequestID & "'," & RoleId
        Else
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, "class='form-control' disabled", , True))

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")

        'commented By Dipali V On 14th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Date</label>")
        'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
        'strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker1' >")
        'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of commented By Dipali V On 14th Nov 2017


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        ''strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        If blnDisablePriorityCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intSeverityID, "class='form-control' disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intSeverityID, "class='form-control' ", False, True))
        End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        If blnDisableSeverityCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intPriorityID, "class='form-control' disabled", True, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intPriorityID, "class='form-control' ", True, True))
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Project</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Sub Request Type'", , , "class='form-control' ", False, True))
        'strHTML.Append("</div>")

        If CommonFunction.Application.EnableProductExecution = True Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If dr.Read Then
                ShowProductCombo = "1"
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        If ShowProductCombo = "1" Then

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Product</label>")
            If blnDisableModuleProductCombo Then
                If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) disabled", True, True, , False))
                ElseIf m_strLoginType = "C" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) disabled", True, True, , False))
                ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) disabled", True, True, , False))

                Else
                    dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                    If dr.Read Then
                        strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                    Else
                        strRequestorID = "0"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this) disabled", True, True, , False))
                End If
            Else
                If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))
                ElseIf m_strLoginType = "C" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
                ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))

                Else
                    dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                    If dr.Read Then
                        strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                    Else
                        strRequestorID = "0"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
                End If
            End If


            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Module/Component</label>")
            If blnDisableModuleProductCombo Then
                If (m_RequeststrLoginType = "E") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control' disabled", True, True, , False))
                    'Else
                    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , , "class='form-control'", True, True, , False))
                    'End If
                Else
                    dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If dr.Read Then
                        strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                    Else
                        strRequestorID = "0"
                    End If

                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control' disabled", True, True, , False))
                    'ElseIf IsRequestFlagged = "1" Or IsAssigned = "1" Then
                    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
                    'End If


                End If
            Else
                If (m_RequeststrLoginType = "E") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control' ", True, True, , False))
                    'Else
                    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , , "class='form-control'", True, True, , False))
                    'End If
                Else
                    dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If dr.Read Then
                        strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                    Else
                        strRequestorID = "0"
                    End If

                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
                    'ElseIf IsRequestFlagged = "1" Or IsAssigned = "1" Then
                    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
                    'End If


                End If
            End If

            strHTML.Append("</div>")
            ' strHTML.Append("</div>")
        End If

        If lngAssignTo <> 0 Then
            strHTML.Append("  <div class='col-sm-6'>")
            strHTML.Append(" <label for='sel1'>Assigned To</label>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True))
            '' If FilterFlag = "1" Then
            '' CommonFunctions.HTMLControls.DrawTextBox("CboAssignTo", "CboAssignTo", "form-control", , , , , , False, , , , "PlaceHolder='Assign To'", True, , , , , , True)

            ' strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString

            strSQL = " Usp_NG2_Sel_V_tbl_PM_Resource_Selection "
            If blnDisabledAssignToCombo Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' disabled", True, True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' disabled", True, True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            End If

            strHTML.Append("</div>")
        End If



        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Organization Unit*</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' disabled", True, True))

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim h As Integer
        Dim m As Integer

        Dim strHour As String
        Dim strMinute As String
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
        'If RequestSubmittedBy = Session("strUserName") Then
        If m_strLoginType <> "C" Then
            strHTML.Append("<div class='row'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Status Change Date</label>")
            strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder='' disabled>")
            strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' disabled ></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Status Change Time</label>")
            strHTML.Append("<div class='bootstrap-timepicker input-group'>")
            strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' disabled >")
            'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o' disabled></i></span>")
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Dim strCurrentHours As String
            Dim strCurrentTime As String

            strCurrentHours = Now.Hour.ToString
            If CType(Now.Hour.ToString, Integer) < 10 Then
                strCurrentHours = "0" + Now.Hour.ToString
            End If
            strCurrentTime = Now.Minute.ToString
            If CType(Now.Minute.ToString, Integer) < 10 Then
                strCurrentTime = "0" + Now.Minute.ToString
            End If
            strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
            strHTML.Append(" </div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Deliverable</label>")

        ' Deliverable
        Dim strDeliverableName As String = ""
        Dim drGetDeliverable As IDataReader


        If m_strDeliverableID <> "" Then
            'Commented and added by ShraddhaM to display Deliverable Project Name
            'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
            strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetDeliverable.Read Then
                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        End If

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", "form-control", , 200, m_strDeliverableID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "form-control", , , strDeliverableName.ToString, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Project</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", "form-control", , 200, m_strDelProjectID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", "form-control", , , strDelProjectName, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Exp. Date of Resolution*</label>")
        strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
        strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate'  placeholder='' disabled>")
        strHTML.Append("<i class='fa fa-calendar' id='idCalender'  ></i>")
        strHTML.Append("</div>")

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))

        strHTML.Append("</div>")
        'Commented By dipali V On 17th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimeZoneID, "class='form-control'", False, True))
        'strHTML.Append("</div>")
        'End of Commented By dipali V On 17th Nov 2017
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'If intRequestStatus = 2 Then
        '    strHTML.Append("<div class='row' id='divrowFeedback'>")
        '    strHTML.Append("<div class='form-group'>")
        '    strHTML.Append("<div class='col-sm-6'>")
        '    strHTML.Append("<label for='sel1'>Feedback</label>")
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFeedBack", "usp_CRM_Get_Feedback_ForCombo ", , intFeedbackID, "class='form-control' disabled", , True, , False))
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='col-sm-6'>")
        '    strHTML.Append("<label for='sel1'>Feedback Comment</label>")
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComment", "txtFeedbackComment", , "form-control", , , , , , , , strFeedbackComments, , , , , , , "class='form-control' disabled", True))
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")
        'End If
        'Commented By Dipali V On 14th Nov 2017 
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-4' for='key'>Key words</label>")
        'strHTML.Append("<div class='col-sm-8'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtKeyWords", "txtKeyWords", "form-control", , , Keywords, , "class='form-control' ", False, returnHTML:=True, EnableHTMLEncode:=True))
        ' ''strHTML.Append("<input type='text' class='form-control' id='key' placeholder='Enter Key word'>")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'End of Commented By Dipali V On 14th Nov 2017 

        ''Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field
        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<label style='text-align:center'>There is no custom fileds mapped to this sub request type</label>")
        strHTML.Append("</div>")
        ''End of Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")

        '' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")

        '' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick()>Update</button>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        Return strHTML.ToString
    End Function
    Private Function PlotAssignedRequestDetails()
        Dim strHTML As New StringBuilder
        strHTML.Append("<div class='col-lg-4'>")
        strHTML.Append("<div class='request-detail'>")
        strHTML.Append("<div class='detail-inner'>")
        strHTML.Append("<h2>Request Details</h2>")

        strHTML.Append("<form  enctype='multipart/form-data' class='req-del-from' id='divrequestDetails'  method='post'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        ''Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes

        If intRequestStatus <> 2 Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If

        strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' onclick=Back_OnClick() data-toggle='tooltip' title='Back'>Back</button>")
        ''End of Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Department *</label>")
        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        Dim m_lngCRMID As Long
        Dim DepartmentID As String
        Dim strSQL As String
        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)

        If DepartmentID <> "" Then
            lngFunctionID = DepartmentID
        End If
        ' Check whether logged in person in either HRM or department head 
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If
        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                    strSQL += ",NULL"
                End If
            End If

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled ", False, True, , False))
        Else
            If m_strLoginType <> "E" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " + m_intCustomer.ToString, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) ", False, False))
            Else
                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                End If
            End If
            ' End If
        End If

        'strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        'strSQL += "," + lngRequestID.ToString
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled", False, True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Request Type *</label>")


        Dim strSQLReqType As String = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

        'Dim m_lngCRMID As String = ""
        'strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        'dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        'If dr.Read Then
        '    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        'End If
        'CommonFunctions.Data.DisposeDataReader(dr)
        'If m_lngCRMID <> 0 Then
        '    ' If logged in person IS HRM or Department head then 
        '    ' ENABLE Request and Sub Request Type Combo
        '    blnDisableSubRequestTypeCombo = False
        'Else
        '    ' If logged in person IS NOT HRM or Department head then 
        '    ' DISABLE Request and Sub Request Type Combo
        '    blnDisabledAssignToCombo = True

        'End If
        'If m_lngCRMID <> 0 Then
        '    blnDisableSubRequestTypeCombo = False
        'Else
        '    blnDisableSubRequestTypeCombo = True
        'End If
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
        End If


        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
        Dim strSQLSubReq As String = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) disabled", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
        End If

        If m_lngSubRequestTypeID <> 0 Then
            ' If Sub Request Type is selected
            ' Get Document Templates mapped to Sub Request Type (If Any)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                Select Case intTemplateCount
                    Case 0 ' no templates

                    Case Else ' multiple templates

                        strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../../Images/View.gif' id ='view' title = 'View Template'></A>")
                End Select
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Status *</label>")
        Dim RoleId As String = Session("intPostId")

        ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        'If lngRequestID <> 0 Then
        '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
        'Else
        '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
        'End If

        If lngRequestID <> 0 Then
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & lngRequestID & "'," & RoleId
        Else
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default


        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, "class='form-control'  " & style1 & " ", , True))

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")

        'commented By Dipali V On 14th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Date</label>")
        'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
        'strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker1' >")
        'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of commented By Dipali V On 14th Nov 2017


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        'strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        If blnDisablePriorityCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' ", False, True))
        End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        If blnDisableSeverityCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' disabled", True, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' ", True, True))
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Project</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Sub Request Type'", , , "class='form-control' ", False, True))
        'strHTML.Append("</div>")

        If CommonFunction.Application.EnableProductExecution = True Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If dr.Read Then
                ShowProductCombo = "1"
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        If ShowProductCombo = "1" Then

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Product</label>")
            If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then

                ''Commented and added by yogesh Jalamkar on 30-NOv-2017 Purpose: Product is disabled for assigned person
                'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) " & styleproduct & "", True, True, , False))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
                ''End by Yogesh Jalamkar
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))

            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Module/Component</label>")
            If (m_RequeststrLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
                'Else
                '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , , "class='form-control'", True, True, , False))
                'End If
            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If

                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
                'ElseIf IsRequestFlagged = "1" Or IsAssigned = "1" Then
                '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
                'End If


            End If
            strHTML.Append("</div>")
            ' strHTML.Append("</div>")
        End If

        strHTML.Append("  <div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Assigned To</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True))
        '' If FilterFlag = "1" Then
        '' CommonFunctions.HTMLControls.DrawTextBox("CboAssignTo", "CboAssignTo", "form-control", , , , , , False, , , , "PlaceHolder='Assign To'", True, , , , , , True)

        ' strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString

        strSQL = " Usp_NG2_Sel_V_tbl_PM_Resource_Selection "
        If blnDisabledAssignToCombo Then

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' disabled", True, True))

            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))


        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' ", True, True))
            ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        End If

        'Else

        '    strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
        '    If (m_strLoginType = "C") Then
        '        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True, , , , True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '    Else
        '        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '    End If

        '    '' strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")

        '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

        '    ''  strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'", True, True))
        '    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
        '    '' strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End If


        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Organization Unit*</label>")
        If FilterFlag = "1" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & "", True, True))

        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & " ", True, True))

        End If

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim h As Integer
        Dim m As Integer

        Dim strHour As String
        Dim strMinute As String
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
        'If RequestSubmittedBy = Session("strUserName") Then
        If m_strLoginType <> "C" Then
            If m_intStatusID <> 2 Then
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder=''>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtStatusChangedate').datepicker();$('#dtStatusChangedate').datepicker('show');""></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")

                'Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803

                'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append("<div class='bootstrap-timepicker input-group' style='margin-top:2px;border-right: 1px solid #ccc;'>")

                'End of Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803


                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' >")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            Else
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder='' disabled>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' disabled ></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")

                'Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803

                'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append("<div class='bootstrap-timepicker input-group' style='margin-top:2px; border-right: 1px solid #ccc;'>")

                'End of Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803


                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime'  >")
                'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o' disabled></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

        End If
        'End If
        'If FilterFlag = "DB" Then

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Deliverable</label>")

        ' Deliverable
        Dim strDeliverableName As String = ""
        Dim drGetDeliverable As IDataReader


        If m_strDeliverableID <> "" Then
            'Commented and added by ShraddhaM to display Deliverable Project Name
            'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
            strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetDeliverable.Read Then
                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        End If

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", "form-control", , 200, m_strDeliverableID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "form-control", , , strDeliverableName.ToString, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Project</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", "form-control", , 200, m_strDelProjectID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", "form-control", , , strDelProjectName, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            strHTML.Append("<label for='sel1'>Exp. Date of Resolution*</label>")
        Else
            strHTML.Append("<label for='sel1'></label>")
        End If

        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            ' admin/requestor of course can change the date
            If m_intStatusID <> "2" Then
                If intRequestStatus = 2 Then
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder='' disabled>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                    strHTML.Append("</div>")
                Else
                    'strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    'strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
                    'strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');""></i>")
                    'strHTML.Append("</div>")
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder='' disabled>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                    strHTML.Append("</div>")
                End If

            Else
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate'  placeholder='' disabled>")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender'  ></i>")
                strHTML.Append("</div>")
            End If
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        End If
        strHTML.Append("</div>")
        'Commented By dipali V On 17th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimeZoneID, "class='form-control'", False, True))
        'strHTML.Append("</div>")
        'End of Commented By dipali V On 17th Nov 2017
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        If intRequestStatus = 2 Then
            strHTML.Append("<div class='row' id='divrowFeedback'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFeedBack", "usp_CRM_Get_Feedback_ForCombo ", , intFeedbackID, "class='form-control' disabled", , True, , False))
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback Comment</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComment", "txtFeedbackComment", , "form-control", , , , , , , , strFeedbackComments, , , , , , , "class='form-control' disabled", True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        'Commented By Dipali V On 14th Nov 2017 
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-4' for='key'>Key words</label>")
        'strHTML.Append("<div class='col-sm-8'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtKeyWords", "txtKeyWords", "form-control", , , Keywords, , "class='form-control' ", False, returnHTML:=True, EnableHTMLEncode:=True))
        ' ''strHTML.Append("<input type='text' class='form-control' id='key' placeholder='Enter Key word'>")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'End of Commented By Dipali V On 14th Nov 2017 

        ''Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<label style='text-align:center'>There is no custom fileds mapped to this sub request type</label>")
        strHTML.Append("</div>")

        ''End of Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")

        '  strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        If intRequestStatus <> 2 Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If
        ' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick()>Update</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Private Function PlotSubmittedRequestDetails()
        Dim strHTML As New StringBuilder
        strHTML.Append("<div class='col-lg-4'>")
        strHTML.Append("<div class='request-detail'>")
        strHTML.Append("<div class='detail-inner'>")
        strHTML.Append("<h2>Request Details</h2>")

        strHTML.Append("<form  enctype='multipart/form-data' class='req-del-from' id='divrequestDetails'  method='post'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'Dim strIsButtontodisplay As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsRequestApproved " & m_lngQueryID & "," & Session("intUserID"), True), "")
        'If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then

        Dim intCount As Integer = CommonFunctions.Data.GetDataTable("usp_NG2_Sel_CustomerCombo_ForUnCategorized " & RequestID, True).Rows.Count


        strHTML.Append("<button type='button' class='btn updtae-btn' style='width:140px;margin-left:11px' id='btnCustomer' data-toggle='modal' data-target='#divCustomer' >Create New Customer</button>")

        'Commented and Added by Usha Pandit on 13 Mar 2019 for duplicate Request Creation Issue
        'strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Convert Request'>Convert</button>")
        strHTML.Append("<button type='button' class='btn updtae-btn convert-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Convert Request'>Convert</button>")
        ''End of Added by Usha Pandit on 13 Mar 2019 for duplicate Request Creation Issue

        'End If
        strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' onclick=Back_OnClick()>Back</button>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Customer *</label>")
        strHTML.Append("<div id='divCustomerSelect'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_NG2_Sel_CustomerCombo_ForUnCategorized " & RequestID, , "", "class='form-control' onchange='Customer_New_Onchange(this)'", False, True, , False))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Department *</label>")
        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        Dim strSQL As String = ""
        ' to take postid of the employee at corporate level not from session

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If
        strHTML.Append("<div id='divDepartmentSelect'>")
        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                    strSQL += ",NULL"
                End If
            End If
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) ", False, True, , False))
        Else
            If m_strLoginType <> "E" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_NG2_CRM_GetFunctions_ForRole " + m_intCustomer.ToString & "," & Session("intUserID"), , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, True, False))
            Else
                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, True, False))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, True, False))
                End If
            End If
            ' End If
        End If
        strHTML.Append("</div>")
        'strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        'strSQL += "," + lngRequestID.ToString
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled", False, True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")

        If CommonFunction.Application.SplitRequestTypeSubType = True Then
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Request Type *</label>")
            If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
                strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
                strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
                strSQL += "  and RoleID =23 AND functionID = " & lngFunctionID
            Else
                If m_intRequestedEmployee <> 0 Then
                    strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                Else
                    strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                End If
            End If

            Dim strSQLReqType As String = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

            'Dim m_lngCRMID As String = ""
            'strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
            'dr = CommonFunctions.Data.GetDataReader(strSQL, True)
            'If dr.Read Then
            '    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
            'End If
            'CommonFunctions.Data.DisposeDataReader(dr)
            'If m_lngCRMID <> 0 Then
            '    ' If logged in person IS HRM or Department head then 
            '    ' ENABLE Request and Sub Request Type Combo
            '    blnDisableSubRequestTypeCombo = False
            'Else
            '    ' If logged in person IS NOT HRM or Department head then 
            '    ' DISABLE Request and Sub Request Type Combo
            '    blnDisabledAssignToCombo = True

            'End If
            'If m_lngCRMID <> 0 Then
            '    blnDisableSubRequestTypeCombo = False
            'Else
            '    blnDisableSubRequestTypeCombo = True
            'End If
            If blnDisableSubRequestTypeCombo Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
            End If

            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
            Dim strSQLSubReq As String = "usp_NG2_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
            If blnDisableSubRequestTypeCombo Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
            End If
            strHTML.Append("</div>")
        Else

            'Sub Requst Type

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Request Type *</label>")
            If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then

                Dim strSqlQuery_CustName As String
                strSqlQuery_CustName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_pm_customer_CustomerID " & HttpContext.Current.Session("Customer").ToString(), MyBase.UseSQL), String)
                strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(strSqlQuery_CustName) & "','C',0"
            Else
                If m_intRequestedEmployee <> 0 Then
                    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                Else
                    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                End If
            End If

            '' If Not Page.IsPostBack Then
            If CommonFunction.Application.SplitRequestTypeSubType = False Then
                strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
            End If
            ''End If
            '' Dim strSQLSubReq As String = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
            If blnDisableSubRequestTypeCombo Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQL, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQL, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
            End If

            strHTML.Append("</div>")
        End If


        If m_lngSubRequestTypeID <> 0 Then
            ' If Sub Request Type is selected
            ' Get Document Templates mapped to Sub Request Type (If Any)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                Select Case intTemplateCount
                    Case 0 ' no templates

                    Case Else ' multiple templates

                        strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../../Images/View.gif' id ='view' title = 'View Template'></A>")
                End Select
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Status *</label>")
        Dim RoleId As String = Session("intPostId")


        ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        'If lngRequestID <> 0 Then
        '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
        'Else
        '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
        'End If


        If lngRequestID <> 0 Then
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & lngRequestID & "'," & RoleId
        Else
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default


        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, "class='form-control' onchange=cboStatus_OnChange() " & style1 & " ", , True))

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")

        'commented By Dipali V On 14th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Date</label>")
        'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
        'strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker1' >")
        'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of commented By Dipali V On 14th Nov 2017


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        'strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        If blnDisablePriorityCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' ", False, True))
        End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        If blnDisableSeverityCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' ", True, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' ", True, True))
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Project</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Sub Request Type'", , , "class='form-control' ", False, True))
        'strHTML.Append("</div>")

        If CommonFunction.Application.EnableProductExecution = True Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If dr.Read Then
                ShowProductCombo = "1"
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If
        strHTML.Append("<div id='Product' class='col-sm-12'>")
        If ShowProductCombo = "1" Then

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Product</label>")
            If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then

                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))

            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this)", True, True, , False))
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")

            If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then
                strHTML.Append("<label for='sel1'>Module/Component</label>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append("<label for='sel1'>Module/Component</label>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append("<label for='sel1'>Module/Component</label>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
                'strHTML.Append("</div>")
            Else
                strHTML.Append("<label for='sel1'>Module/Component</label>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            End If
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")

        strHTML.Append("  <div class='col-sm-6'>")
        If (m_strLoginType <> "C") Then
            strHTML.Append(" <label for='sel1'>Assigned To</label>")
        End If
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True))
        ''  If FilterFlag = "1" Then
        '' CommonFunctions.HTMLControls.DrawTextBox("CboAssignTo", "CboAssignTo", "form-control", , , , , , False, , , , "PlaceHolder='Assign To'", True, , , , , , True)

        ' strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString


        ''  strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString



        strSQL = " Usp_NG2_Sel_V_tbl_PM_Resource_Selection "
        If blnDisabledAssignToCombo Then
            If (m_strLoginType = "C") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' style='display:none;'", True, True))

                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' disabled", True, True))

                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            End If

        Else
            If (m_strLoginType = "C") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'  style='display:none;'", True, True))
                ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            End If

        End If
        strHTML.Append("</div>")
        'Else

        '    strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
        '    If (m_strLoginType = "C") Then
        '        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' ", True, True, , , , True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '    Else
        '        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '    End If

        '    '' strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")

        '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

        '    ''  strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'", True, True))
        '    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
        '    '' strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End If


        If (m_strLoginType <> "C") Then
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append(" <label for='sel1'>Organization Unit*</label>")
            'If FilterFlag = "1" Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & "", True, True))

            'Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' ", True, True))

            strHTML.Append("</div>")
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim h As Integer
        Dim m As Integer

        Dim strHour As String
        Dim strMinute As String
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
        'If RequestSubmittedBy = Session("strUserName") Then
        If m_strLoginType <> "C" Then
            If m_intStatusID <> 2 Then
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder=''>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtStatusChangedate').datepicker();$('#dtStatusChangedate').datepicker('show');""></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")

                'Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803

                'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append("<div class='bootstrap-timepicker input-group' style='margin-top:2px;border-right: 1px solid #ccc;'>")

                'End of Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803

                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' >")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            Else
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder='' disabled>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtStatusChangedate').datepicker();$('#dtStatusChangedate').datepicker('show');"" ></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")

                'Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803

                'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append("<div class='bootstrap-timepicker input-group' style='margin-top:2px;border-right: 1px solid #ccc;'>")

                'End of Commented & Added by Sagar N on 13-March-2019 Purpose:: Issue ID=15803

                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' disabled>")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o' ></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If
        Else
            strHTML.Append("<div class='row'  style='display:none;'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1' style='display:none;'>Status Change Date</label>")
            strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder=''  style='display:none;'>")
            strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")

            strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'  style='display:none;'>Status Change Time</label>")
            strHTML.Append("<div class='bootstrap-timepicker input-group'>")
            strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime'  style='display:none;' >")
            strHTML.Append("<span class='input-group-addon add-on'  style='display:none;'><i class='fa fa-clock-o'></i></span>")
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Dim strCurrentHours As String
            Dim strCurrentTime As String

            strCurrentHours = Now.Hour.ToString
            If CType(Now.Hour.ToString, Integer) < 10 Then
                strCurrentHours = "0" + Now.Hour.ToString
            End If
            strCurrentTime = Now.Minute.ToString
            If CType(Now.Minute.ToString, Integer) < 10 Then
                strCurrentTime = "0" + Now.Minute.ToString
            End If
            strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
            strHTML.Append(" </div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If



        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        '' strHTML.Append("<label for='sel1'>Deliverable</label>")

        ' Deliverable
        Dim strDeliverableName As String = ""
        Dim drGetDeliverable As IDataReader


        If m_strDeliverableID <> "" Then
            strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetDeliverable.Read Then
                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        End If

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", "form-control", , 200, m_strDeliverableID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "form-control", , , strDeliverableName.ToString, , "class='form-control'", True, True, , True, EnableHTMLEncode:=True))

        ' strHTML.Append("</div>")

        'strHTML.Append("<div class='col-sm-6'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", "form-control", , 200, m_strDelProjectID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", "form-control", , , strDelProjectName, , "class='form-control'", True, True, , True, EnableHTMLEncode:=True))
        '  strHTML.Append("</div>")
        '  strHTML.Append("</div>")
        'strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            strHTML.Append("<label for='sel1'>Exp. Date of Resolution*</label>")
        Else
            strHTML.Append("<label for='sel1'></label>")
        End If

        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            ' admin/requestor of course can change the date
            If m_intStatusID <> "2" Then
                If intRequestStatus = 2 Then
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder='' >")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                    strHTML.Append("</div>")
                Else
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');""></i>")
                    strHTML.Append("</div>")
                End If

            Else
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate'  placeholder='' >")

                'Commented & Added By Sagar N on 13-March-2019 Purpose :: Issue ID :

                'strHTML.Append("<i class='fa fa-calendar' id='idCalender'  ></i>")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');"" ></i>")

                'Commented & Added By Sagar N on 13-March-2019 Purpose :: Issue ID :

                strHTML.Append("</div>")
            End If
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        End If
        strHTML.Append("</div>")
        '    strHTML.Append("<div class='col-sm-6'>")
        '    strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimeZoneID, "class='form-control' " & style & "", False, True))
        '    strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        If intRequestStatus = 2 Then
            strHTML.Append("<div class='row' id='divrowFeedback'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFeedBack", "usp_CRM_Get_Feedback_ForCombo ", , intFeedbackID, "class='form-control' ", , True, , False))
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback Comment</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComment", "txtFeedbackComment", , "form-control", , , , , , , , strFeedbackComments, , , , , , , "class='form-control' ", True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        'Commented By Dipali V On 14th Nov 2017 
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-4' for='key'>Key words</label>")
        'strHTML.Append("<div class='col-sm-8'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtKeyWords", "txtKeyWords", "form-control", , , Keywords, , "class='form-control' ", False, returnHTML:=True, EnableHTMLEncode:=True))
        ' ''strHTML.Append("<input type='text' class='form-control' id='key' placeholder='Enter Key word'>")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'End of Commented By Dipali V On 14th Nov 2017 

        ''Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<label style='text-align:center'>There is no custom fileds mapped to this sub request type</label>")
        strHTML.Append("</div>")

        ''End of Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        ''<button type="button" class="btn Backbutton" id="btnBack" style="color:white;background: #343660;" onclick=Back_OnClick()>Back</button>

        ''Commented and Added by Usha Pandit on 13 Mar 2019 for duplicate Request Creation Issue
        'strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Convert Request'>Convert</button>")
        strHTML.Append("<button type='button' class='btn updtae-btn convert-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Convert Request'>Convert</button>")
        ''End of Added by Usha Pandit on 13 Mar 2019 for duplicate Request Creation Issue

        ''  strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' onclick=SaveRequest_OnClick() title='Update'>Update</button>")
        ' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick()>Update</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Private Function PlotApprovalDetails()
        Dim strHTML As New StringBuilder
        strHTML.Append("<div class='col-lg-4'>")
        strHTML.Append("<div class='request-detail'>")
        strHTML.Append("<div class='detail-inner'>")
        strHTML.Append("<h2>Request Details</h2>")

        strHTML.Append("<form  enctype='multipart/form-data' class='req-del-from' id='divrequestDetails'  method='post'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        ''Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
        Dim strIsButtontodisplay As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsRequestApproved " & m_lngQueryID & "," & Session("intUserID"), True), "")
        If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If
        strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' data-toggle='tooltip' onclick=Back_OnClick() title='Back'>Back</button>")

        ''End of Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Department *</label>")
        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        Dim m_lngCRMID As Long
        Dim DepartmentID As String
        Dim strSQL As String
        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)

        If DepartmentID <> "" Then
            lngFunctionID = DepartmentID
        End If
        ' Check whether logged in person in either HRM or department head 
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If
        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                    strSQL += ",NULL"
                End If
            End If

            If m_lngCRMID <> 0 Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled ", False, True, , False))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, True, , False))
            End If
        Else
            If m_strLoginType <> "E" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " + m_intCustomer.ToString, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
            Else
                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                End If
            End If
            ' End If
        End If

        'strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        'strSQL += "," + lngRequestID.ToString
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled", False, True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Request Type *</label>")


        Dim strSQLReqType As String = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

        'Dim m_lngCRMID As String = ""
        'strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        'dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        'If dr.Read Then
        '    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        'End If
        'CommonFunctions.Data.DisposeDataReader(dr)
        'If m_lngCRMID <> 0 Then
        '    ' If logged in person IS HRM or Department head then 
        '    ' ENABLE Request and Sub Request Type Combo
        '    blnDisableSubRequestTypeCombo = False
        'Else
        '    ' If logged in person IS NOT HRM or Department head then 
        '    ' DISABLE Request and Sub Request Type Combo
        '    blnDisabledAssignToCombo = True

        'End If
        If m_lngCRMID <> 0 Then
            blnDisableSubRequestTypeCombo = False
        Else
            blnDisableSubRequestTypeCombo = True
        End If
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
        End If


        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
        Dim strSQLSubReq As String = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) disabled", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
        End If

        If m_lngSubRequestTypeID <> 0 Then
            ' If Sub Request Type is selected
            ' Get Document Templates mapped to Sub Request Type (If Any)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                Select Case intTemplateCount
                    Case 0 ' no templates

                    Case Else ' multiple templates

                        strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../../Images/View.gif' id ='view' title = 'View Template'></A>")
                End Select
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Status *</label>")
        Dim RoleId As String = Session("intPostId")

        ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default
        'If lngRequestID <> 0 Then
        '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
        'Else
        '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
        'End If

        If lngRequestID <> 0 Then
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & lngRequestID & "'," & RoleId
        Else
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, "class='form-control'  disabled ", , True))

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")

        'commented By Dipali V On 14th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Date</label>")
        'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
        'strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker1' >")
        'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of commented By Dipali V On 14th Nov 2017


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        'strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        ' If m_strApprover = "0" Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' disabled", False, True))
        '  Else
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' disabled", False, True))
        ' End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        ' If m_strApprover = "0" Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control'  disabled", True, True))
        ' Else
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' disabled", True, True))
        ' End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Project</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Sub Request Type'", , , "class='form-control' ", False, True))
        'strHTML.Append("</div>")

        If CommonFunction.Application.EnableProductExecution = True Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If dr.Read Then
                ShowProductCombo = "1"
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        If ShowProductCombo = "1" Then

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Product</label>")
            If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then

                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))

            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Module/Component</label>")
            'If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
            '    'Else
            '    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , , "class='form-control'", True, True, , False))
            '    'End If
            'ElseIf m_strLoginType = "C" Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            'ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            '    'ElseIf IsRequestFlagged = "1" Or IsAssigned = "1" Then
            '    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            '    'End If
            '    strHTML.Append("</div>")

            'End If


            If (m_RequeststrLoginType = "E") Then
                ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, 250, lngComponentID.ToString, , True, True, , False))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component '" & lngProductID.ToString & "'," & strRequestorID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            End If
            strHTML.Append("</div>")
        Else
            strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=" + lngProductID.ToString + ">")
            strHTML.Append("<INPUT type=hidden name='CboModuleComponent' id='cboModule' value=" + lngComponentID.ToString + ">")
        End If

        strHTML.Append("  <div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Assigned To</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True))
        If FilterFlag = "1" Then
            '' CommonFunctions.HTMLControls.DrawTextBox("CboAssignTo", "CboAssignTo", "form-control", , , , , , False, , , , "PlaceHolder='Assign To'", True, , , , , , True)

            ' strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString


            strSQL = " Usp_NG2_Sel_V_tbl_PM_Resource_Selection "
            If blnDisabledAssignToCombo Then
                If (m_strLoginType = "C") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' style='display:none;'" & style & "", True, True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'" & style & "", True, True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                End If

            Else
                If (m_strLoginType = "C") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'  style='display:none;'", True, True))
                    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                End If

            End If
        Else

            strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
            If (m_strLoginType = "C") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True, , , , True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            End If

            '' strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")

            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

            ''  strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'", True, True))
            ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
            '' strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        End If


        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Organization Unit*</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' disabled ", True, True))


        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim h As Integer
        Dim m As Integer

        Dim strHour As String
        Dim strMinute As String
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
        'If RequestSubmittedBy = Session("strUserName") Then
        If m_strLoginType <> "C" Then
            'If m_intStatusID <> 2 Then
            '    strHTML.Append("<div class='row'>")
            '    strHTML.Append("<div class='form-group'>")
            '    strHTML.Append("<div class='col-sm-6'>")
            '    strHTML.Append("<label for='sel1'>Status Change Date</label>")
            '    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            '    strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder=''>")
            '    strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
            '    strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtStatusChangedate').datepicker();$('#dtStatusChangedate').datepicker('show');""></i>")
            '    strHTML.Append("</div>")
            '    strHTML.Append("</div>")

            '    strHTML.Append("<div class='col-sm-6'>")
            '    strHTML.Append("<label for='sel1'>Status Change Time</label>")
            '    strHTML.Append("<div class='bootstrap-timepicker input-group'>")
            '    strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' >")
            '    strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
            '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
            '    Dim strCurrentHours As String
            '    Dim strCurrentTime As String

            '    strCurrentHours = Now.Hour.ToString
            '    If CType(Now.Hour.ToString, Integer) < 10 Then
            '        strCurrentHours = "0" + Now.Hour.ToString
            '    End If
            '    strCurrentTime = Now.Minute.ToString
            '    If CType(Now.Minute.ToString, Integer) < 10 Then
            '        strCurrentTime = "0" + Now.Minute.ToString
            '    End If
            '    strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
            '    strHTML.Append(" </div>")
            '    strHTML.Append("</div>")

            '    strHTML.Append("</div>")
            '    strHTML.Append("</div>")
            'Else
            strHTML.Append("<div class='row'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Status Change Date</label>")
            strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder='' disabled>")
            strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Status Change Time</label>")
            strHTML.Append("<div class='bootstrap-timepicker input-group'>")
            strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' disabled >")
            strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Dim strCurrentHours As String
            Dim strCurrentTime As String

            strCurrentHours = Now.Hour.ToString
            If CType(Now.Hour.ToString, Integer) < 10 Then
                strCurrentHours = "0" + Now.Hour.ToString
            End If
            strCurrentTime = Now.Minute.ToString
            If CType(Now.Minute.ToString, Integer) < 10 Then
                strCurrentTime = "0" + Now.Minute.ToString
            End If
            strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
            strHTML.Append(" </div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            ' End If

        End If
        'End If
        'If FilterFlag = "DB" Then

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Deliverable</label>")

        ' Deliverable
        Dim strDeliverableName As String = ""
        Dim drGetDeliverable As IDataReader


        If m_strDeliverableID <> "" Then
            'Commented and added by ShraddhaM to display Deliverable Project Name
            'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
            strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetDeliverable.Read Then
                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        End If

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", "form-control", , 200, m_strDeliverableID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "form-control", , , strDeliverableName.ToString, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Project</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", "form-control", , 200, m_strDelProjectID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", "form-control", , , strDelProjectName, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            strHTML.Append("<label for='sel1'>Exp. Date of Resolution*</label>")
        Else
            strHTML.Append("<label for='sel1'></label>")
        End If

        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            ' admin/requestor of course can change the date
            ' If m_intStatusID <> "2" Then
            ' If intRequestStatus = 2 Then
            strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder='' disabled>")
            strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
            strHTML.Append("</div>")
            '   Else
            'strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            'strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
            'strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');""></i>")
            'strHTML.Append("</div>")
            ' End If

            'Else
            '    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
            '    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate'  placeholder=''>")
            '    strHTML.Append("<i class='fa fa-calendar' id='idCalender'  ></i>")
            '    strHTML.Append("</div>")
            'End If
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        End If
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimeZoneID, "class='form-control' " & style & "", False, True))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        If intRequestStatus = 2 Then
            strHTML.Append("<div class='row' id='divrowFeedback'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFeedBack", "usp_CRM_Get_Feedback_ForCombo ", , intFeedbackID, "class='form-control' disabled", , True, , False))
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback Comment</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComment", "txtFeedbackComment", , "form-control", , , , , , , , strFeedbackComments, , , , , , , "class='form-control' disabled", True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        'Commented By Dipali V On 14th Nov 2017 
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-4' for='key'>Key words</label>")
        'strHTML.Append("<div class='col-sm-8'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtKeyWords", "txtKeyWords", "form-control", , , Keywords, , "class='form-control' ", False, returnHTML:=True, EnableHTMLEncode:=True))
        ' ''strHTML.Append("<input type='text' class='form-control' id='key' placeholder='Enter Key word'>")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'End of Commented By Dipali V On 14th Nov 2017 


        ''Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<label style='text-align:center'>There is no custom fileds mapped to this sub request type</label>")
        strHTML.Append("</div>")

        ''End of Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")

        If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If

        ' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick()>Update</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Private Function PlotEDashboardRequestDetails()
        Dim strHTML As New StringBuilder
        strHTML.Append("<div class='col-lg-4'>")
        strHTML.Append("<div class='request-detail'>")
        strHTML.Append("<div class='detail-inner'>")
        strHTML.Append("<h2>Request Details</h2>")

        strHTML.Append("<form  enctype='multipart/form-data' class='req-del-from' id='divrequestDetails'  method='post'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        ''Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes

        Dim strIsButtontodisplay As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsRequestApproved " & m_lngQueryID & "," & Session("intUserID"), True), "")
        If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If
        strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' data-toggle='tooltip' onclick=Back_OnClick() title='Back'>Back</button>")

        ''End of Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Department *</label>")
        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        Dim m_lngCRMID As Long
        Dim DepartmentID As String
        Dim strSQL As String
        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)

        If DepartmentID <> "" Then
            lngFunctionID = DepartmentID
        End If
        ' Check whether logged in person in either HRM or department head 
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If
        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                    strSQL += ",NULL"
                End If
            End If

            If m_lngCRMID <> 0 Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled ", False, True, , False))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, True, , False))
            End If
        Else
            If m_strLoginType <> "E" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " + m_intCustomer.ToString, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
            Else
                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                End If
            End If
            ' End If
        End If

        'strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        'strSQL += "," + lngRequestID.ToString
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled", False, True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Request Type *</label>")


        Dim strSQLReqType As String = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

        'Dim m_lngCRMID As String = ""
        'strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        'dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        'If dr.Read Then
        '    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        'End If
        'CommonFunctions.Data.DisposeDataReader(dr)
        'If m_lngCRMID <> 0 Then
        '    ' If logged in person IS HRM or Department head then 
        '    ' ENABLE Request and Sub Request Type Combo
        '    blnDisableSubRequestTypeCombo = False
        'Else
        '    ' If logged in person IS NOT HRM or Department head then 
        '    ' DISABLE Request and Sub Request Type Combo
        '    blnDisabledAssignToCombo = True

        'End If
        If m_lngCRMID <> 0 Then
            blnDisableSubRequestTypeCombo = False
        Else
            blnDisableSubRequestTypeCombo = True
        End If
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
        End If


        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
        Dim strSQLSubReq As String = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) disabled", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
        End If

        If m_lngSubRequestTypeID <> 0 Then
            ' If Sub Request Type is selected
            ' Get Document Templates mapped to Sub Request Type (If Any)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                Select Case intTemplateCount
                    Case 0 ' no templates

                    Case Else ' multiple templates

                        strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../../Images/View.gif' id ='view' title = 'View Template'></A>")
                End Select
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Status *</label>")
        Dim RoleId As String = Session("intPostId")


        ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        'If lngRequestID <> 0 Then
        '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
        'Else
        '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
        'End If

        If lngRequestID <> 0 Then
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & lngRequestID & "'," & RoleId
        Else
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, "class='form-control' onchange=cboStatus_OnChange() " & style1 & " ", , True))

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")

        'commented By Dipali V On 14th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Date</label>")
        'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
        'strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker1' >")
        'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of commented By Dipali V On 14th Nov 2017


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        'strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        ' If m_strApprover = "0" Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' ", False, True))
        '  Else
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' disabled", False, True))
        ' End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        ' If m_strApprover = "0" Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' ", True, True))
        ' Else
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' disabled", True, True))
        ' End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Project</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Sub Request Type'", , , "class='form-control' ", False, True))
        'strHTML.Append("</div>")

        If CommonFunction.Application.EnableProductExecution = True Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If dr.Read Then
                ShowProductCombo = "1"
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        If ShowProductCombo = "1" Then

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Product</label>")
            If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then

                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))

            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this) ", True, True, , False))
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Module/Component</label>")
            'If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
            '    'Else
            '    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , , "class='form-control'", True, True, , False))
            '    'End If
            'ElseIf m_strLoginType = "C" Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            'ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            '    'ElseIf IsRequestFlagged = "1" Or IsAssigned = "1" Then
            '    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            '    'End If
            '    strHTML.Append("</div>")

            'End If


            If (m_RequeststrLoginType = "E") Then
                ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, 250, lngComponentID.ToString, , True, True, , False))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component '" & lngProductID.ToString & "'," & strRequestorID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            End If
            strHTML.Append("</div>")
        Else
            strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=" + lngProductID.ToString + ">")
            strHTML.Append("<INPUT type=hidden name='CboModuleComponent' id='cboModule' value=" + lngComponentID.ToString + ">")
        End If

        strHTML.Append("  <div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Assigned To</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True))
        If FilterFlag = "1" Then
            '' CommonFunctions.HTMLControls.DrawTextBox("CboAssignTo", "CboAssignTo", "form-control", , , , , , False, , , , "PlaceHolder='Assign To'", True, , , , , , True)

            ' strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString


            strSQL = " Usp_NG2_Sel_V_tbl_PM_Resource_Selection "
            If blnDisabledAssignToCombo Then
                If (m_strLoginType = "C") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' style='display:none;'" & style & "", True, True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'" & style & "", True, True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                End If

            Else
                If (m_strLoginType = "C") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'  style='display:none;'", True, True))
                    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                End If

            End If
        Else

            strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
            If (m_strLoginType = "C") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True, , , , True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            End If

            '' strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")

            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

            ''  strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'", True, True))
            ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
            '' strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        End If


        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Organization Unit*</label>")
        If FilterFlag = "1" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & "", True, True))

        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & " ", True, True))

        End If

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim h As Integer
        Dim m As Integer

        Dim strHour As String
        Dim strMinute As String
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
        'If RequestSubmittedBy = Session("strUserName") Then
        If m_strLoginType <> "C" Then
            If m_intStatusID <> 2 Then
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder=''>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtStatusChangedate').datepicker();$('#dtStatusChangedate').datepicker('show');""></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")
                strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' >")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            Else
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder='' disabled>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")
                strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' disabled >")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

        End If
        'End If
        'If FilterFlag = "DB" Then

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Deliverable</label>")

        ' Deliverable
        Dim strDeliverableName As String = ""
        Dim drGetDeliverable As IDataReader


        If m_strDeliverableID <> "" Then
            'Commented and added by ShraddhaM to display Deliverable Project Name
            'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
            strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetDeliverable.Read Then
                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        End If

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", "form-control", , 200, m_strDeliverableID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "form-control", , , strDeliverableName.ToString, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Project</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", "form-control", , 200, m_strDelProjectID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", "form-control", , , strDelProjectName, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            strHTML.Append("<label for='sel1'>Exp. Date of Resolution*</label>")
        Else
            strHTML.Append("<label for='sel1'></label>")
        End If

        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            ' admin/requestor of course can change the date
            If m_intStatusID <> "2" Then
                If intRequestStatus = 2 Then
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder='' disabled>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                    strHTML.Append("</div>")
                Else
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');""></i>")
                    strHTML.Append("</div>")
                End If

            Else
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate'  placeholder='' disabled>")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender'  ></i>")
                strHTML.Append("</div>")
            End If
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        End If
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimeZoneID, "class='form-control' " & style & "", False, True))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        If intRequestStatus = 2 Then
            strHTML.Append("<div class='row' id='divrowFeedback'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFeedBack", "usp_CRM_Get_Feedback_ForCombo ", , intFeedbackID, "class='form-control' disabled", , True, , False))
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback Comment</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComment", "txtFeedbackComment", , "form-control", , , , , , , , strFeedbackComments, , , , , , , "class='form-control' disabled", True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        'Commented By Dipali V On 14th Nov 2017 
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-4' for='key'>Key words</label>")
        'strHTML.Append("<div class='col-sm-8'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtKeyWords", "txtKeyWords", "form-control", , , Keywords, , "class='form-control' ", False, returnHTML:=True, EnableHTMLEncode:=True))
        ' ''strHTML.Append("<input type='text' class='form-control' id='key' placeholder='Enter Key word'>")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'End of Commented By Dipali V On 14th Nov 2017 

        ''Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<label style='text-align:center'>There is no custom fileds mapped to this sub request type</label>")
        strHTML.Append("</div>")

        ''End of Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")

        If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If

        ' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick()>Update</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Private Function PlotMyEDashboardRequestDetails()
        Dim strHTML As New StringBuilder
        strHTML.Append("<div class='col-lg-4'>")
        strHTML.Append("<div class='request-detail'>")
        strHTML.Append("<div class='detail-inner'>")
        strHTML.Append("<h2>Request Details</h2>")

        strHTML.Append("<form  enctype='multipart/form-data' class='req-del-from' id='divrequestDetails'  method='post'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        ''Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes


        Dim strIsButtontodisplay As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsRequestApproved " & m_lngQueryID & "," & Session("intUserID"), True), "")
        If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If
        strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' onclick=Back_OnClick() data-toggle='tooltip' title='Back'>Back</button>")
        ''End of Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Department *</label>")
        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        Dim m_lngCRMID As Long
        Dim DepartmentID As String
        Dim strSQL As String
        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)

        If DepartmentID <> "" Then
            lngFunctionID = DepartmentID
        End If
        ' Check whether logged in person in either HRM or department head 
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If
        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                    strSQL += ",NULL"
                End If
            End If

            If m_lngCRMID <> 0 Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled ", False, True, , False))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, True, , False))
            End If
        Else
            If m_strLoginType <> "E" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " + m_intCustomer.ToString, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
            Else
                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID.ToString, "class='form-control' onchange=Department_OnChange(this) " & style & "", False, False))
                End If
            End If
            ' End If
        End If

        'strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        'strSQL += "," + lngRequestID.ToString
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , lngFunctionID, "class='form-control' onchange=Department_OnChange(this) disabled", False, True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Request Type *</label>")


        Dim strSQLReqType As String = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

        'Dim m_lngCRMID As String = ""
        'strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
        'dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        'If dr.Read Then
        '    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        'End If
        'CommonFunctions.Data.DisposeDataReader(dr)
        'If m_lngCRMID <> 0 Then
        '    ' If logged in person IS HRM or Department head then 
        '    ' ENABLE Request and Sub Request Type Combo
        '    blnDisableSubRequestTypeCombo = False
        'Else
        '    ' If logged in person IS NOT HRM or Department head then 
        '    ' DISABLE Request and Sub Request Type Combo
        '    blnDisabledAssignToCombo = True

        'End If
        If m_lngCRMID <> 0 Then
            blnDisableSubRequestTypeCombo = False
        Else
            blnDisableSubRequestTypeCombo = True
        End If
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") disabled ", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", strSQLReqType, , m_lngRequestTypeId, "class='form-control' onchange=RequestType_OnChange(this," & lngFunctionID & ") ", False, True))
        End If


        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
        Dim strSQLSubReq As String = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        If blnDisableSubRequestTypeCombo Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) disabled", False, True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", strSQLSubReq, , m_lngSubRequestTypeID, "class='form-control' onchange=SubRequestType_OnChange(this) ", False, True))
        End If

        If m_lngSubRequestTypeID <> 0 Then
            ' If Sub Request Type is selected
            ' Get Document Templates mapped to Sub Request Type (If Any)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                Select Case intTemplateCount
                    Case 0 ' no templates

                    Case Else ' multiple templates

                        strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../../Images/View.gif' id ='view' title = 'View Template'></A>")
                End Select
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>	")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Status *</label>")
        Dim RoleId As String = Session("intPostId")

        ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        'If lngRequestID <> 0 Then
        '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
        'Else
        '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
        'End If

        If lngRequestID <> 0 Then
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & lngRequestID & "'," & RoleId
        Else
            strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
        End If

        ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, "class='form-control' onchange=cboStatus_OnChange() " & style1 & " ", , True))

        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")

        'commented By Dipali V On 14th Nov 2017
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Date</label>")
        'strHTML.Append("<div class='bootstrap-timepicker input-group'>")
        'strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker1' >")
        'strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of commented By Dipali V On 14th Nov 2017


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        'strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        ' If m_strApprover = "0" Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' ", False, True))
        '  Else
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , intPriorityID, "class='form-control' disabled", False, True))
        ' End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        ' If m_strApprover = "0" Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' " & style1 & "", True, True))
        ' Else
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , intSeverityID, "class='form-control' disabled", True, True))
        ' End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Project</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Sub Request Type'", , , "class='form-control' ", False, True))
        'strHTML.Append("</div>")

        If CommonFunction.Application.EnableProductExecution = True Then

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If dr.Read Then
                ShowProductCombo = "1"
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        If ShowProductCombo = "1" Then

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Product</label>")
            If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then

                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , lngProductID, "class='form-control'  onchange=Product_OnChange(this) " & styleproduct & "", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) " & styleproduct & "", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, "class='form-control'  onchange=Product_OnChange(this) " & styleproduct & "", True, True, , False))

            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", True)

                If dr.Read Then
                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                Else
                    strRequestorID = "0"
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, , lngProductID.ToString, " class='form-control'  onchange=Product_OnChange(this) " & styleproduct & "", True, True, , False))
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Module/Component</label>")
            If (m_RequeststrLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID.ToString, , True, True, "form-control", False))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , lngComponentID.ToString, , True, True, "form-control", False))
            End If


            'If (m_intCustomer = 0 And m_RequeststrLoginType = "E") Then
            '    strHTML.Append("<label for='sel1'>Module/Component</label>")
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, , lngComponentID, "class='form-control'", True, True, , False))
            '    'Else
            '    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, , , "class='form-control'", True, True, , False))
            '    'End If
            'ElseIf m_strLoginType = "C" Then
            '    strHTML.Append("<label for='sel1'>Module/Component</label>")
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            'ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
            '    strHTML.Append("<label for='sel1'>Module/Component</label>")
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            '    'ElseIf IsRequestFlagged = "1" Or IsAssigned = "1" Then
            '    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, , lngComponentID.ToString, "class='form-control'", True, True, , False))
            '    'End If
            '    strHTML.Append("</div>")

            'End If
            strHTML.Append("</div>")
        End If

        strHTML.Append("  <div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Assigned To</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True))
        If FilterFlag = "1" Then
            '' CommonFunctions.HTMLControls.DrawTextBox("CboAssignTo", "CboAssignTo", "form-control", , , , , , False, , , , "PlaceHolder='Assign To'", True, , , , , , True)

            ' strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString


            strSQL = " Usp_NG2_Sel_V_tbl_PM_Resource_Selection "
            If blnDisabledAssignToCombo Then
                If (m_strLoginType = "C") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' style='display:none;'" & style & "", True, True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'" & style & "", True, True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                End If

            Else
                If (m_strLoginType = "C") Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'  style='display:none;'", True, True))
                    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                    ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                End If

            End If
        Else

            strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
            If (m_strLoginType = "C") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True, , , , True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control' " & style & "", True, True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            End If

            '' strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")

            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

            ''  strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", strSQL, , lngAssignTo.ToString, "class='form-control'", True, True))
            ''strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
            '' strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        End If


        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append(" <label for='sel1'>Organization Unit*</label>")
        If FilterFlag = "1" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & "", True, True))

        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units " & lngTargetLocationID & "", , lngTargetLocationID, "class='form-control' " & style & " ", True, True))

        End If

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim h As Integer
        Dim m As Integer

        Dim strHour As String
        Dim strMinute As String
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
        'If RequestSubmittedBy = Session("strUserName") Then
        If m_strLoginType <> "C" Then
            If m_intStatusID <> 2 Then
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder=''>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtStatusChangedate').datepicker();$('#dtStatusChangedate').datepicker('show');""></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")
                strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' >")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            Else
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Date</label>")
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' class='form-control' id='dtStatusChangedate' value='" & m_strStatusChangeDateValue & "' placeholder='' disabled>")
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-6'>")
                strHTML.Append("<label for='sel1'>Status Change Time</label>")
                strHTML.Append("<div class='bootstrap-timepicker input-group'>")
                strHTML.Append(" <input type='text' class='form-control time-picker' value='" & m_strStatusChangeTimeValue & "' id='StatusChangeTime' disabled >")
                strHTML.Append("<span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                strHTML.Append("<input type=hidden name='hdnCurrentTime' id='hdnCurrentTime' value='" & strCurrentHours + ":" + strCurrentTime & "'>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

        End If
        'End If
        'If FilterFlag = "DB" Then

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Deliverable</label>")

        ' Deliverable
        Dim strDeliverableName As String = ""
        Dim drGetDeliverable As IDataReader


        If m_strDeliverableID <> "" Then
            'Commented and added by ShraddhaM to display Deliverable Project Name
            'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
            strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetDeliverable.Read Then
                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
            End If

            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        End If

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", "form-control", , 200, m_strDeliverableID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "form-control", , , strDeliverableName.ToString, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Project</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", "form-control", , 200, m_strDelProjectID, , , False, , , True, "class='form-control' " & style & "", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", "form-control", , , strDelProjectName, , "class='form-control'", True, returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='col-sm-6'>")
        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            strHTML.Append("<label for='sel1'>Exp. Date of Resolution*</label>")
        Else
            strHTML.Append("<label for='sel1'></label>")
        End If

        If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            ' admin/requestor of course can change the date
            If m_intStatusID <> "2" Then
                If intRequestStatus = 2 Then
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder='' disabled>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' ></i>")
                    strHTML.Append("</div>")
                Else
                    strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                    strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
                    strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');""></i>")
                    strHTML.Append("</div>")
                End If

            Else
                strHTML.Append("<div class='col-xs-8 clsStatusBox' style='padding-right:0px;'>")
                strHTML.Append("<input type='text' value='" & strExpectedResolvedDate & "'  class='form-control' id='dtExpResdate'  placeholder='' disabled>")

                'Commented & Added By Sagar N on 13-March-2019 Purpose :: Issue ID :

                'strHTML.Append("<i class='fa fa-calendar' id='idCalender'  ></i>")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker();$('#dtExpResdate').datepicker('show');"" ></i>")

                'Commented & Added By Sagar N on 13-March-2019 Purpose :: Issue ID :
                strHTML.Append("</div>")
            End If
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        End If
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-6'>")
        'strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimeZoneID, "class='form-control' " & style & "", False, True))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        If intRequestStatus = 2 Then
            strHTML.Append("<div class='row' id='divrowFeedback'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFeedBack", "usp_CRM_Get_Feedback_ForCombo ", , intFeedbackID, "class='form-control' disabled", , True, , False))
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Feedback Comment</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComment", "txtFeedbackComment", , "form-control", , , , , , , , strFeedbackComments, , , , , , , "class='form-control' disabled", True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        'Commented By Dipali V On 14th Nov 2017 
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-4' for='key'>Key words</label>")
        'strHTML.Append("<div class='col-sm-8'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtKeyWords", "txtKeyWords", "form-control", , , Keywords, , "class='form-control' ", False, returnHTML:=True, EnableHTMLEncode:=True))
        ' ''strHTML.Append("<input type='text' class='form-control' id='key' placeholder='Enter Key word'>")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'strHTML.Append(" </div>	")
        'End of Commented By Dipali V On 14th Nov 2017 

        ''Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field
        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<label style='text-align:center'>There is no custom fileds mapped to this sub request type</label>")
        strHTML.Append("</div>")

        ''End of Commented by Usha Pandit on 15 Jan 2019 for hiding Custom field

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        If intRequestStatus <> 2 And strIsButtontodisplay = "1" Then
            strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick() data-toggle='tooltip' title='Update'>Update</button>")
        End If

        ' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave1' onclick=SaveRequest_OnClick()>Update</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function RequestDetailsTabs(ByVal RequestID As String, ByVal Flag As String, ByVal FieldName As String, ByVal ModifiedBy As String, ByVal filterflag As String)
        '=====================================================================
        ' Procedure  Name		:	RequestDetailsTabs
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Request Details Tabs
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   17 Oct 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
            If Flag = "Activities" Then

                strHTML.Append(objCRMRequestDetails.GetActivities(RequestID))
            ElseIf Flag = "History" Then
                strHTML.Append(objCRMRequestDetails.HistoryDetails(RequestID, FieldName, ModifiedBy, filterflag))
            ElseIf Flag = "Attachments" Then
                strHTML.Append(objCRMRequestDetails.AttachmentDetails(RequestID))
            ElseIf Flag = "Association" Then
                strHTML.Append(objCRMRequestDetails.AssociationDetails(RequestID))
                'Added By Dipali V On 31st Oct 2017 For NexT Ver 2 HelpDesk Enhancement
            ElseIf Flag = "sla" Then
                strHTML.Append(objCRMRequestDetails.SLADetails(RequestID))
            End If
            'End of Added By Dipali V On 31st Oct 2017 For NexT Ver 2 HelpDesk Enhancement

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function

    Public Function GetActivities(ByVal RequestID As String)
        Dim strResult As String = ""
        Dim strSQL As String = ""
        Dim dtDefectType As DataTable
        Dim strValidation As String = ""
        Dim Counter As Integer = 0
        Dim strHTML As New StringBuilder()
        Dim strScript As String()
        Dim dtActivities As New DataTable
        Dim EmployeeName As String = ""
        Dim Activity As String = ""
        Dim TimeSpent As String = ""
        Dim CreatedDate As String = ""
        Dim Time As String = ""
        strSQL = "Exec usp_NG2_Sel_EmployeeActivity " & RequestID & ""
        dtActivities = CommonFunctions.Data.GetDataTable(strSQL, True)

        Dim drReader1 As IDataReader
        strEditRequestSQL = "usp_NG_RequestDetailsSubTagAccess " & RequestID & "," & HttpContext.Current.Session("intUserID") & ""
        drReader1 = CommonFunctions.Data.GetDataReader(strEditRequestSQL, True)

        If (drReader1.Read) Then
            strHasEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("Result")))
            strHasHRMEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("ResultHRM")))
        End If



        strHTML.Append("<h3>Activities</h3>")
        If strHasHRMEditAccess = True Then
            strHTML.Append("<div class='activ-top-bar'>")
            strHTML.Append("<ul>")
            strHTML.Append("<li>")
            ''Added by Yogesh Jalamkar on 1-DEC-2017 Purpose: Issue fixing issue id = 9626
            Dim strTodaysTotalTimeSpent As String = ""
            strTodaysTotalTimeSpent = CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_NG2_GetTotalTimeSpentOnRequest " + RequestID, True))
            ''End by Yogesh Jalamkar on 1-DEC-2017
            Dim RoleId As String = HttpContext.Current.Session("intPostId")

            ''Commented and Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

            'If lngRequestID <> 0 Then
            '    strSQL = "usp_CRM_Get_RequestStatus '" & RequestID & "'," & RoleId
            'Else
            '    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
            'End If

            If lngRequestID <> 0 Then
                strSQL = "usp_CRM_Get_UncategorisedRequestStatus '" & RequestID & "'," & RoleId
            Else
                strSQL = "usp_CRM_Get_UncategorisedRequestStatus NULL," & RoleId
            End If

            ''End of Added by Usha Pandit on 29.12.2018 for Uncategorised request issue as Closed status getting selected by default

            strHTML.Append("<label style='padding-right: 9px;'>Change Status</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboActivityStatus", strSQL, , , "class='form-control' ", False, True))
            strHTML.Append(" </li>")
            strHTML.Append("<li><label style='padding-right: 9px;'>Time Spent(min)</label><input type='text' name='timespen' id='txtTime'><span><i class='fa fa-hourglass-end' aria-hidden='true'></i></span></li>")
            strHTML.Append("<li>")
            strHTML.Append("<label style='padding-right: 9px;'>Activity</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboActivity", "usp_NG2_Sel_tbl_CRM_Activity_Master", , , "class='form-control' ", False, True))
            ''Added by Yogesh Jalamkar on 1-DEC-2017 Purpose: Issue fixing issue id = 9626
            strHTML.Append("<input type=hidden id=hdnTodaysTotalTimeSpent name=hdnTodaysTotalTimeSpent value='" & strTodaysTotalTimeSpent & "' />")
            ''End by Yogesh Jalamkar on 1-DEC-2017
            strHTML.Append(" </li>")
            strHTML.Append("<li><button type='button' class='btn updtae-btn' style='margin-top:6px' onclick=SaveActivity()>Save</button></li>")

            strHTML.Append(" </ul>")
            strHTML.Append(" </div>")


            strHTML.Append("<div class='table-responsive' >  ")
            strHTML.Append(" <table class='table'>")
            strHTML.Append("<thead>")
            strHTML.Append(" <tr>")
            strHTML.Append("<th>Date and Time</th>")
            strHTML.Append("<th >Employee Name</th>")
            strHTML.Append("<th >Activity</th>")
            strHTML.Append("<th>Time Spent</th>")
            strHTML.Append(" </tr>")
            strHTML.Append("</thead>")
            strHTML.Append("<tbody>")

            For i As Integer = 0 To dtActivities.Rows.Count - 1
                ''Flag = 1
                strHTML.Append("<tr>")
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("EmployeeName").ToString, "")
                Activity = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("Activity").ToString, "")
                TimeSpent = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("TimeSpent").ToString, "")
                CreatedDate = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("CreatedDate").ToString, "")
                ''Commented and added by Yogesh Jalamkar on 28-11-2017 Purpose : Time format should proper
                'Time = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("Time").ToString, "")
                'strHTML.Append("<td><span class='date'>" & CreatedDate & "</span><span class='time'>" & Time & "</span></td>")
                ''End of comment by Yogesh Jalamkar
                strHTML.Append("<td><span class='date'>" & CreatedDate & "</span></td>")
                strHTML.Append("<td>" & EmployeeName & "</td>")
                strHTML.Append("<td>" & Activity & "</td>")
                strHTML.Append("<td><i class='fa fa-hourglass-end' aria-hidden='true'></i>" & TimeSpent & "</td>")
                strHTML.Append("</tr>")

                Counter += 1
            Next
            strHTML.Append("</tbody>")
            strHTML.Append("</table>")
            strHTML.Append("</div>")
        Else


            strHTML.Append("<div class='table-responsive'>  ")
            strHTML.Append(" <table class='table'>")
            strHTML.Append("<thead>")
            strHTML.Append(" <tr>")
            strHTML.Append("<th>Date and Time</th>")
            strHTML.Append("<th>Employee Name</th>")
            strHTML.Append("<th>Activity</th>")
            strHTML.Append("<th>Time Spent</th>")
            strHTML.Append(" </tr>")
            strHTML.Append("</thead>")
            strHTML.Append("<tbody>")

            For i As Integer = 0 To dtActivities.Rows.Count - 1
                ''Flag = 1
                strHTML.Append("<tr>")
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("EmployeeName").ToString, "")
                Activity = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("Activity").ToString, "")
                TimeSpent = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("TimeSpent").ToString, "")
                CreatedDate = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("CreatedDate").ToString, "")
                ''Commented and added by Yogesh Jalamkar on 28-11-2017 Purpose : Time format should proper
                'Time = CommonFunctions.Data.CheckIsDBNull(dtActivities.Rows(i)("Time").ToString, "")
                'strHTML.Append("<td><span class='date'>" & CreatedDate & "</span><span class='time'>" & Time & "</span></td>")
                strHTML.Append("<td><span class='date'>" & CreatedDate & "</span></td>")
                ''End of comment by Yogesh Jalamkar
                strHTML.Append("<td>" & EmployeeName & "</td>")
                strHTML.Append("<td>" & Activity & "</td>")
                strHTML.Append("<td><i class='fa fa-hourglass-end' aria-hidden='true'></i>" & TimeSpent & "</td>")
                strHTML.Append("</tr>")

                Counter += 1
            Next
            strHTML.Append("</tbody>")
            strHTML.Append("</table>")
            strHTML.Append("</div>")
        End If



        Return strHTML.ToString

    End Function

    Public Function HistoryDetails(ByVal RequestID As String, ByVal FieldName As String, ByVal ModifiedBy As String, ByVal filterflag As String)
        Dim strResult As String = ""
        Dim strSQL As String = ""
        Dim dtDefectType As DataTable
        Dim strValidation As String = ""
        Dim strPlotHtml As String = ""
        Dim strHTML As New StringBuilder()
        Dim strScript As String()
        Dim dtHistory As New DataTable
        Dim strSQLModifiedBy As String = ""
        Dim strSQLField As String = ""
        Dim strSQLQuery As String = ""
        Dim FieldNameTable As String = ""
        Dim ModifiedByTable As String = ""


        If FieldName = "Select Field" Then
            FieldName = ""
        End If

        If ModifiedBy = "Select Modified By" Then
            ModifiedBy = ""
        End If
        If filterflag.ToUpper = "FILTER" Then
            strSQLField = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & HttpContext.Current.Session("LoginType") & "', " & HttpContext.Current.Session("intUserID") & ", 3100, 29578, 'FieldName', 'Modified Field' , 'F','" & FieldName & "', '" & FieldName & "',null,null, 0"
            CommonFunction.Data.InsertOrUpdateData(strSQLField, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            strSQLModifiedBy = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & HttpContext.Current.Session("LoginType") & "', " & HttpContext.Current.Session("intUserID") & ", 3100, 29581, 'ModifiedBy', 'Modified By', 'F', '" & ModifiedBy & "', '" & ModifiedBy & "', NULL, NULL,0"
            CommonFunction.Data.InsertOrUpdateData(strSQLModifiedBy, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Else

        End If

        strSQLQuery = "USP_NG2_SEL_TBL_UI_EMPLOYEEFILTERSETTINGS_Employee  3100, " & HttpContext.Current.Session("intUserID") & ",'FieldName','" & HttpContext.Current.Session("LoginType") & "'"
        FieldNameTable = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        strSQLQuery = "USP_NG2_SEL_TBL_UI_EMPLOYEEFILTERSETTINGS_Employee  3100, " & HttpContext.Current.Session("intUserID") & ",'ModifiedBy','" & HttpContext.Current.Session("LoginType") & "'"
        ModifiedByTable = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "")

        If FieldNameTable = "" Then
            FieldName = FieldName
        End If


        If ModifiedByTable = "" Then
            ModifiedBy = ModifiedBy
        End If

        If FieldName = "" Then
            FieldName = "NULL"
        End If
        If ModifiedBy = "" Then
            ModifiedBy = "NULL"
        End If


        strSQL = "Exec usp_NG2_Sel_CRM_RequestDetails_History " & RequestID & ",'" & FieldName & "','" & ModifiedBy & "'"
        dtHistory = CommonFunctions.Data.GetDataTable(strSQL, True)


        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        'Dim Flag As Integer = 0
        Dim Counter As Integer = 0

        Dim ModifiedDate As String = ""
        Dim ModifiedBy1 As String = ""
        Dim FieldName1 As String = ""
        Dim OldValue As String = ""
        Dim NewValue As String = ""
        Dim ModifiedTime As String = ""


        strHTML.Append("<h3>History</h3>")
        strHTML.Append("<div class='histry-src' id='History'>")
        strHTML.Append("<div class='left'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboFieldName", "usp_NG2_Sel_FieldName_History " & RequestID, , FieldName, "class='form-control' onchange=FilterOnchange(this)", , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModifiedBy", "usp_NG2_Sel_ModifiedBy_CRMHistory " & RequestID, , ModifiedBy, "class='form-control' onchange=FilterOnchange(this)", , True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='right search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        ' strHTML.Append("<input type='text' id='myInput' onkeyup='myFunction()' placeholder='Search History' title='Type in a name'>")
        strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search History' title='Type in a name'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div id='divHistory' class='table-responsive'>  ")
        strHTML.Append(" <table class='table'>")
        strHTML.Append("<thead>")
        strHTML.Append(" <tr>")
        '' strHTML.Append("<th style='font-style: italic;'>Date and Time</th>")
        strHTML.Append("<th>Date and Time</th>")
        strHTML.Append("<th>Modified By</th>")
        strHTML.Append("<th>Field</th>")
        strHTML.Append("<th>Old Value</th>")
        strHTML.Append("<th>New Value</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody>")

        For i As Integer = 0 To dtHistory.Rows.Count - 1
            ''Flag = 1
            strHTML.Append("<tr>")
            ModifiedDate = CommonFunctions.Data.CheckIsDBNull(dtHistory.Rows(i)("ModifiedDate").ToString, "")

            ModifiedBy1 = CommonFunctions.Data.CheckIsDBNull(dtHistory.Rows(i)("ModifiedBy").ToString, "")
            FieldName1 = CommonFunctions.Data.CheckIsDBNull(dtHistory.Rows(i)("FieldName").ToString, "")
            OldValue = CommonFunctions.Data.CheckIsDBNull(dtHistory.Rows(i)("OldValue").ToString, "")
            NewValue = CommonFunctions.Data.CheckIsDBNull(dtHistory.Rows(i)("NewValue").ToString, "")
            ModifiedTime = CommonFunctions.Data.CheckIsDBNull(dtHistory.Rows(i)("ModifiedTime").ToString, "")

            strHTML.Append("<td><span class='date'>" & ModifiedDate & "</span><span class='time'>" & ModifiedTime & "</span></td>")
            strHTML.Append("<td>" & ModifiedBy1 & "</td>")
            strHTML.Append("<td>" & FieldName1 & "</td>")
            strHTML.Append("<td class='old-value'>" & OldValue & "</td>")
            strHTML.Append("<td class='new-value'>" & NewValue & "</td>")
            strHTML.Append("</tr>")

            Counter += 1
        Next
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function


    Public Function AttachmentDetails(ByVal RequestID As String)
        Dim strResult As String = ""
        Dim strSQL As String = ""
        Dim dtDefectType As DataTable
        Dim strValidation As String = ""
        Dim strPlotHtml As String = ""
        Dim strHTML As New StringBuilder()
        Dim strScript As String()
        Dim dtAttachment As New DataTable
        strSQL = "Exec usp_NG2_sel_tbl_NG2_UnCategorizedTickets_Attachments " & RequestID & ""
        dtAttachment = CommonFunctions.Data.GetDataTable(strSQL, True)


        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        'Dim Flag As Integer = 0
        Dim Counter As Integer = 0
        Dim DateAttached As String = ""
        Dim DateAttachedTime As String = ""
        Dim OriginalFileName As String = ""
        Dim AttachedBy As String = ""
        Dim Description As String = ""
        Dim AttachmentId As String = ""
        Dim FileType As String = ""
        Dim strDiscussionID As String = ""
        Dim Flag As Integer = 0

        strHTML.Append("<div class='divRowHeader' style='margin-top:-4%' >")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div class='btn-section'>")
        strHTML.Append("<div class='add-forwd-btn'>")


        'strHTML.Append("<button  onclick='SelectAddnewFile()'  type='button' class='btn btn-default note-btn'  title='Add New Attachment' style='margin-left:10%' id='btnNewAttachmentFile' filecount='0'><i class='fa fa-plus' aria-hidden='true'></i> Add New Attachment</button>")


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<h3>Attachments</h3>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='attch-top-bar' style='float:right!important;margin-right:18%!important;'>")
        If dtAttachment.Rows.Count > 0 Then
            strHTML.Append("<ul>")

            ''Added By Dipali V On 24th Nov 2017 For Adding Attachment
            'strHTML.Append("<li>")
            ''strHTML.Append("<button class='browse btn btn-primary input-lg' id='btnSelectFile' filecount='0' onclick='SelectFile();' type='button' style='width:106px!important;height:30px!important' title='Add Attachments'><i class='fa fa-paperclip' aria-hidden='true' title='Add Attachments'></i> Attachment</button>")
            '' strHTML.Append("<button type='button' class='btn updtae-btn' id='btnBack' onclick=AddAttachment_OnClick() data-toggle='tooltip' title='Back'><i class='fa fa-paperclip' aria-hidden='true' title='Add Attachments'></i> Add</button>")
            'strHTML.Append("</li>")
            ''End of Added By Dipali V On 24th Nov 2017 For Adding Attachment
            strHTML.Append("<li>")
            strHTML.Append("<button type='button' class='btn btn-default download'  onclick=DownloadZipFromAttachmentTab('" & RequestID & "')><i class='fa fa-download' aria-hidden='true' style='padding-right: 7px;' title='Download All'></i>Download All (Zip)</button>")
            strHTML.Append("</li>")

            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-trash-o' aria-hidden='true' onclick=DeleteAttachment() title='Delete Attachment' data-toggle='tooltip' data-placement='bottom' data-container='body' style='color:red;font-size:16px;line-height:1.9'></i>")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")
        End If
        strHTML.Append("</div>")

        strHTML.Append("<div class='table-responsive' id='divAttachments'>")
        strHTML.Append(" <table class='table'>")
        strHTML.Append("<thead>")
        strHTML.Append(" <tr>")
        strHTML.Append("<th><input type='checkbox' name='checkall' id='checkall' onclick='SelectDeleteAllAttachment(this)' title='Select All' data-toggle='tooltip' data-placement='top' data-container='body'></th>")
        '' strHTML.Append("<th style='font-style: italic;'>Date and Time</th>")
        strHTML.Append("<th>Date and Time</th>")
        strHTML.Append("<th>File Name</th>")
        strHTML.Append("<th>Attached By</th>")
        ' strHTML.Append("<th class='italic'>Description</th>")
        strHTML.Append("<th>Description</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody>")

        For i As Integer = 0 To dtAttachment.Rows.Count - 1
            Flag = 1
            strHTML.Append("<tr>")
            DateAttached = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("DateAttached").ToString, "")
            ''Commented by Yogesh Jalamkar on 28-NOV-2017 Purpose: attachement time should be short
            'DateAttachedTime = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("DateAttachedTime").ToString, "")
            ''End by Yogesh Jalamkar
            OriginalFileName = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName").ToString, "")
            AttachedBy = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy").ToString, "")
            Description = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Description").ToString, "")
            AttachmentId = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentId").ToString, "")
            'Added by Dipali V On 17 nov 2017 Download Functionality
            SystemFileName = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("SystemFileName").ToString, "")
            'Added by Dipali V On 17 nov 2017 Download Functionality

            ''Commented by Yogesh Jalamkar on 28-NOV-2017 Purpose: attachement time should be short
            'strHTML.Append("<td><span class='date'>" & DateAttached & "</span><span class='time'>" & DateAttachedTime & "</span></td>")
            strHTML.Append("<td><input type='checkbox' name='CheckAttachment' id='CheckAttachment' ' value=" & AttachmentId & " title='Select' data-toggle='tooltip' data-placement='bottom'></td>")

            strHTML.Append("<td><span class='date'>" & DateAttached & "</span></td>")
            ''End by yogesh Jalamkar
            strHTML.Append("<td><a href=""JavaScript:Document_OnClick_For_CRM('" & SystemFileName & "','" & OriginalFileName & "')"">" & OriginalFileName & "<i class='fa fa-download' aria-hidden='true' title='Download Attachment' data-toggle='tooltip' data-placement='bottom' data-container='body'></i></a></td>")
            strHTML.Append("<td>" & AttachedBy & "</td>")
            ' strHTML.Append("<td class='italic'>" & Description & "</td>")
            strHTML.Append("<td >" & Description & "</td>")
            strHTML.Append("</tr>")

            Counter += 1
        Next
        If Flag = 0 Then
            strHTML.Append("<tr>")
            strHTML.Append("<td colspan='7' style='text-align:center;'>There are no items to show in this view.</td></tr>")
        End If
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function

    Public Function AssociationDetails(ByVal RequestID As String)
        Dim strResult As String = ""
        Dim strSQL As String = ""
        Dim dtDefectType As DataTable
        Dim strValidation As String = ""
        Dim strPlotHtml As String = ""
        Dim strHTML As New StringBuilder()
        Dim strScript As String()
        Dim dtAttachment As New DataTable
        strSQL = "Exec usp_NG2_Sel_tbl_CRM_Attachments " & RequestID & "," & HttpContext.Current.Session("LoginType") & ""
        dtAttachment = CommonFunctions.Data.GetDataTable(strSQL, True)


        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        'Dim Flag As Integer = 0
        Dim Counter As Integer = 0
        Dim DateAttached As String = ""
        Dim DateAttachedTime As String = ""
        Dim OriginalFileName As String = ""
        Dim AttachedBy As String = ""
        Dim Description As String = ""
        Dim AttachmentId As String = ""
        Dim FileType As String = ""

        strHTML.Append("<h3>Association</h3>")
        strHTML.Append("<div class='inner-tab-section'>")
        strHTML.Append("<div class='tab'>")
        strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Issue')"" id='defaultOpen1'>Assign Issue</button>")
        strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Task')"">Assign Task</button>")
        strHTML.Append("<button class='tablinks1 active' onclick=""openCity1(event, 'Deliverable')"" id='defaultOpenDeliverable'>Convert to Deliverable</button>")


        'strHTML.Append(" <button class='tablinks1' onclick=""openCity1(event, 'Linked')"">Linked Requests</button>")
        strHTML.Append("</div>")

        strHTML.Append("<div id='Issue' class='tabcontent1'>")
        strHTML.Append(AssignIssueDetailsTabs(RequestID))
        strHTML.Append("</div>")


        strHTML.Append("<div id='Task' class='tabcontent1'>")
        'strHTML.Append(AssignTaskDetailsTabs(RequestID))
        strHTML.Append("</div>")

        strHTML.Append("<div id='Deliverable' class='tabcontent1'>")

        strHTML.Append("</div>")


        Return strHTML.ToString
    End Function



    Public Function SLADetails(ByVal RequestID As String)
        Dim intCntSLADetails As Integer = 1
        Dim blnRecordPresent As Boolean = False
        Dim strTRstyleSLADetails As String
        Dim drSLADetails As IDataReader
        Dim strQueryID As String = ""
        Dim strDate As String = ""
        Dim m_intQueries As Integer = 0
        Dim m_intTotalRecords As Integer = 0
        Dim strSQL As String = ""
        Dim strHTML As New StringBuilder()
        strSQL = "usp_PM_CalculateSLAForHelpDesk_Query_Details " & RequestID.ToString
        drSLADetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        strHTML.Append("<h3>SLA Status</h3>")
        strHTML.Append("<div class='table-responsive'>")
        strHTML.Append("<table class='table'>")
        strHTML.Append("<thead>")
        strHTML.Append("<tr>")
        strHTML.Append("<th>SLA</th>")
        strHTML.Append("<th>Norm</th>")
        strHTML.Append("<th>Actual</th>")
        strHTML.Append("<th>Remaining</th>")
        strHTML.Append("<th>Met/Not Met</th>")
        strHTML.Append("</tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody")
        While drSLADetails.Read()
            m_intTotalRecords = m_intTotalRecords + 1
            blnRecordPresent = True


            If (intCntSLADetails Mod 2) = 0 Then
                strTRstyleSLADetails = "clsTREvenRow"
            Else
                strTRstyleSLADetails = "clsTROdd"
            End If
            strHTML.Append("<TR class>")

            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SLAName"), "").ToString <> "" Then
                strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SLAName"), "").ToString & " </TD>")
            Else
                strHTML.Append("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("strNorm"), "").ToString <> "" Then
                strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("strNorm"), "").ToString & " </TD>")
            Else
                strHTML.Append("<TD>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("strActualDuration"), "").ToString <> "" Then

                strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("strActualDuration"), "").ToString & " </TD>")

            Else
                strHTML.Append("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("RemainingHrsMin"), "").ToString <> "" Then
                strHTML.Append("<TD> <FONT color='red'>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RemainingHrsMin"), "").ToString & "</FONT> </TD>")
            Else
                strHTML.Append("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("MetApplicable"), "").ToString <> "" Then
                strHTML.Append("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("MetApplicable"), "").ToString & "</FONT> </TD>")
            Else
                strHTML.Append("<TD>&nbsp;</TD>")
            End If
            strHTML.Append("</TR>")
        End While
        strHTML.Append("</tbody>")
        If blnRecordPresent = False Then
            strHTML.Append("<tbody>")
            strHTML.Append("<TR class=clsTREvenRow><TD align='center' colspan=11 Width=10%>There are no items to show in this view.</TD></TR>")
            strHTML.Append("</tbody>")
        End If
        strHTML.Append("</TABLE>")
        strHTML.Append("</div>")





        Return strHTML.ToString
    End Function
    Function AssignIssueDetailsTabs(ByVal RequestID As String)
        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim strRequestorSLoginType As String = ""
        Dim strRequestorSUserName As String = ""
        Dim drMultipleRequests As IDataReader
        Dim strSummary As String = ""
        Dim DepartmentID As String = ""
        drMultipleRequests = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & RequestID, True)
        If drMultipleRequests.Read Then
            DepartmentID = CType(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests("FunctionID"), "0"), Long) ' assigned to
            strRequestorSLoginType = drMultipleRequests("LoginType").ToString
            strRequestorSUserName = drMultipleRequests("CustomerID").ToString

            If Trim(strSummary & "") = "" Then
                strSummary = "Request ID->" & RequestID & "-->" & drMultipleRequests("Subject").ToString & ""

                If Trim(drMultipleRequests("Description").ToString & "") = "" Then
                    strDescription = drMultipleRequests("Subject").ToString & ""
                Else
                    strDescription = drMultipleRequests("Description").ToString & ""
                End If

            End If
            CommonFunction.Data.DisposeDataReader(drMultipleRequests)
        End If


        Dim drRole As IDataReader
        Dim lngPostID As Long = 0

        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, True)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)
        'Dim dtAttachment As New DataTable

        'strSQL = "Exec usp_NG2_CRM_Get_Request_Issue_Details " & RequestID & ",NULL,NULL"
        'dtAttachment = CommonFunctions.Data.GetDataTable(strSQL, True)


        'Dim SystemFileName As String = ""
        'Dim SubmittedDate As String = ""
        'Dim DiscussionThread As String = ""
        'Dim SubmittedBy As String = ""
        ''Dim Flag As Integer = 0
        'Dim Counter As Integer = 0
        'Dim DateAttached As String = ""
        'Dim DateAttachedTime As String = ""




        'Added By Dipali V On 31st Oct 2017 
        Dim strEditRequestSQL As String = ""
        Dim strHasEditAccessnew As String = ""
        Dim strHasEditAccess As String = ""
        Dim strHasHRMEditAccess As String = ""


        Dim drReader1 As IDataReader
        strEditRequestSQL = "usp_NG_RequestDetailsSubTagAccess " & RequestID & "," & HttpContext.Current.Session("intUserID") & ""
        'strHasEditAccess = CommonFunctions.Data.GetDataScalar(strEditRequestSQL, True)
        drReader1 = CommonFunctions.Data.GetDataReader(strEditRequestSQL, True)

        If (drReader1.Read) Then
            strHasEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("Result")))
            strHasHRMEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("ResultHRM")))
        End If
        'End of Added By Dipali V On 31st Oct 2017 


        If strHasHRMEditAccess = True Then
            strHTML.Append("<div class='reqeustor'>")
            strHTML.Append("<div class='editor'>")
            strHTML.Append("<form action='/action_page.php' class='form-horizontal' id='AssignIssue'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <label for='Summary' class='col-sm-2'>Summary*</label>")
            strHTML.Append(" <div class='col-sm-10'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("summary", "summary", "form-control", , , strSummary, , , False, , , , , True, , , , , , True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label for='desc' class='col-sm-2'>Description*</label>")
            strHTML.Append(" <div class='col-sm-10'>")
            'added & commented by dipali v on 26th April 2019 for Remove HTML tag
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("desc", "desc", , "form-control", , , , , , , , strDescription, , , , , , , "", True))
            If Not strDescription Is Nothing And Not strDescription = "" Then
                strDescription = strDescription.Replace("<USERNAME>", "&lt;USERNAME&gt;")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("desc", "desc", , "form-control", , , , , , , , strDescription, , , , , , , "", True))
            Else
                If Not strTextDescription Is Nothing Then
                    strTextDescription = strTextDescription.Replace("<USERNAME>", "&lt;USERNAME&gt;")
                End If
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("desc", "desc", , "form-control", , , , , , , , strTextDescription, , , , , , , "", True))
                'strHTML.Append("<span id='spnDescription'  Title='Description' >" & strTextDescription & "</span>")
            End If
            'End of added & commented by dipali v on 26th April 2019 for Remove HTML tag
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div id='divIssueDetails'>")
            strHTML.Append("<div class='form-group' style='margin-bottom: 0;'>")
            strHTML.Append("<div class='assign-drop-grp'>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(" <label for='sel1'>Project*</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueProject", "usp_CRM_ProjectList_ForFunction_ForAssignIssueHelpDesk " & DepartmentID & "," & RequestID & ",'" & strRequestorSLoginType & "','" & strRequestorSUserName & "'", , , "class='form-control' onchange=Project_Onchnge(this)", True, True))
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<label for='sel1'>Issue Type*</label>")
            ''Commented and Added by Yogesh Jalamkar on 28-NOV-2017 Purpose:Issue status should be depend on Issue type
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo 0", , , "class='form-control' ", False, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo 0", , , "class='form-control' onchange=IssueType_Onchnge(this) ", False, True))
            ''End by Yogesh Jalamkar
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(" <label for='sel1'>Assigned To*</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("objcboAssignTo", "usp_CRM_Get_ProjectEmployees 0,0,0", , , "class='form-control' ", False, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append(" <div class='form-group' >")
            strHTML.Append("<div class='assign-drop-grp'>")
            strHTML.Append(" <div class='col-sm-4'>")
            strHTML.Append(" <label for='sel1'>Issus Status*</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus 0,0,0", , , "class='form-control' ", False, True))
            strHTML.Append(" </div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<label for='sel1'>Priority</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssuePriority", "usp_Sel_tbl_IB_Project_Priorities 0,0", , , "class='form-control' ", False, True))
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<label for='sel1'>Severity</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueSeverity", "usp_Sel_tbl_IB_Project_Severity 0,0", , , "class='form-control' ", False, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='Clear_AssignIssue()'>Clear</button>")
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='Save_AssignIssue(" & RequestID & ")'>Submit</button>")
            strHTML.Append("</form>	")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<h3>Previous Issues</h3>")
            strHTML.Append("<div class='table-responsive'>  ")
            strHTML.Append(" <table class='table'>")
            strHTML.Append("<thead>")
            strHTML.Append(" <tr>")

            'Commented by yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9627.
            'strHTML.Append("<th>ID</th>")
            strHTML.Append("<th>Issue ID</th>")
            ''End by yogesh Jalamkar

            ' strHTML.Append("<th style='font-style: italic;'>Reported Date</th>")
            strHTML.Append("<th >Reported Date</th>")
            strHTML.Append("<th>Summary</th>")
            strHTML.Append("<th>Type</th>")

            'Commented by yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9627.
            'strHTML.Append("<th>Project By</th>")
            strHTML.Append("<th>Project Name</th>")
            ''End by yogesh Jalamkar

            strHTML.Append("<th >Reported By</th>")

            'Commented by yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9627.
            'strHTML.Append("<th >R.Person</th>")
            strHTML.Append("<th >Responsible Person</th>")
            ''End by yogesh Jalamkar

            '  strHTML.Append("<th class='italic'>Due Date</th>")
            strHTML.Append("<th>Due Date</th>")
            strHTML.Append("<th>Status</th>")
            strHTML.Append(" </tr>")
            strHTML.Append("</thead>")
            strHTML.Append("<tbody>")

            Dim intIssueDetails As Integer = 1
            Dim blnRecordPresent As Boolean = False

            Dim drIssueDetails As IDataReader
            Dim strQueryID As String = ""
            Dim strDate As String = ""
            Dim m_intQueries As Integer = 0
            Dim m_intTotalRecords As Integer = 0
            Dim strSQL1 As String = ""

            strSQL1 = "usp_CRM_Get_Request_Issue_Details " & RequestID.ToString
            strSQL1 += ",'" & m_strSortBy & "','" & m_strSortOrder & "'"
            drIssueDetails = CommonFunctions.Data.GetDataReader(strSQL1, MyBase.UseSQL)
            While drIssueDetails.Read()
                m_intTotalRecords = m_intTotalRecords + 1
                blnRecordPresent = True

                strHTML.Append("<tr>")

                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("IssueID"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("IssueID"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedDate"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedDate"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Summary"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Summary"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If

                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Type"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Type"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ProjectName"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ProjectName"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedBy"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedBy"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("AssignTo"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("AssignTo"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If

                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("DueDate"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("DueDate"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp; <Not Specified> </TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Status"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Status"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If
                strHTML.Append("</tr>")



            End While


            strHTML.Append("</table>")
            strHTML.Append("</div>")
        Else
            strHTML.Append("<h3>Previous Issues</h3>")
            strHTML.Append("<div class='table-responsive'>  ")
            strHTML.Append(" <table class='table'>")
            strHTML.Append("<thead>")
            strHTML.Append(" <tr>")
            strHTML.Append("<th>ID</th>")
            '  strHTML.Append("<th style='font-style: italic;'>Reported Date</th>")
            strHTML.Append("<th>Reported Date</th>")
            strHTML.Append("<th>Summary</th>")
            strHTML.Append("<th>Type</th>")
            strHTML.Append("<th>Project By</th>")
            strHTML.Append("<th >Reported By</th>")
            strHTML.Append("<th >Person</th>")
            '  strHTML.Append("<th class='italic'>Due Date</th>")
            strHTML.Append("<th>Due Date</th>")
            strHTML.Append("<th>Status</th>")
            strHTML.Append(" </tr>")
            strHTML.Append("</thead>")
            strHTML.Append("<tbody>")
            Dim intIssueDetails As Integer = 1
            Dim blnRecordPresent As Boolean = False

            Dim drIssueDetails As IDataReader
            Dim strQueryID As String = ""
            Dim strDate As String = ""
            Dim m_intQueries As Integer = 0
            Dim m_intTotalRecords As Integer = 0
            Dim strSQL1 As String = ""

            strSQL1 = "usp_CRM_Get_Request_Issue_Details " & RequestID.ToString
            strSQL1 += ",'" & m_strSortBy & "','" & m_strSortOrder & "'"
            drIssueDetails = CommonFunctions.Data.GetDataReader(strSQL1, MyBase.UseSQL)
            While drIssueDetails.Read()
                m_intTotalRecords = m_intTotalRecords + 1
                blnRecordPresent = True

                strHTML.Append("<tr>")

                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("IssueID"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("IssueID"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedDate"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedDate"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Summary"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Summary"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If

                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Type"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Type"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ProjectName"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ProjectName"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedBy"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("ReportedBy"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("AssignTo"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("AssignTo"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If

                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("DueDate"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("DueDate"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Status"), "").ToString <> "" Then
                    strHTML.Append("<TD> " & CommonFunctions.Data.CheckIsDBNull(drIssueDetails("Status"), "").ToString & " </TD>")
                Else
                    strHTML.Append("<TD>&nbsp;</TD>")
                End If
                strHTML.Append("</tr>")



            End While
            strHTML.Append("</tbody>")
            strHTML.Append("</table>")
            strHTML.Append("</div>")
        End If



        Return strHTML.ToString
    End Function


    Function AssignTaskDetailsTabs(ByVal RequestID As String, ByVal DepartmentID As String)
        Dim strHTML As New StringBuilder()
        Dim strRequestorSLoginType As String = ""
        Dim strRequestorSUserName As String = ""
        Dim dtTasks As DataTable
        Dim strSummary As String = ""
        Dim strSQLGrid As String = ""


        strSQLGrid = "Exec usp_sel_tbl_PM_helpdesk_Tasks " & RequestID
        dtTasks = CommonFunctions.Data.GetDataTable(strSQLGrid, True)


        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        'Dim Flag As Integer = 0
        Dim Counter As Integer = 0
        Dim DateAttached As String = ""
        Dim DateAttachedTime As String = ""
        Dim intCntDepts As Integer = 0

        Dim strSQL As String
        strSQL = "select functionid ,count (functionid)as Cnt from tbl_CRM_Query_Master where queryID IN "
        strSQL += "(" & RequestID & ")"
        strSQL += " group by functionid"
        Dim dr As IDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

        While dr.Read
            intCntDepts = intCntDepts + 1
        End While
        CommonFunctions.Data.DisposeDataReader(dr)

        'Added By Dipali V On 31st Oct 2017 
        Dim strEditRequestSQL As String = ""
        Dim strHasEditAccessnew As String = ""
        Dim strHasEditAccess As String = ""
        Dim strHasHRMEditAccess As String = ""


        Dim drReader1 As IDataReader
        strEditRequestSQL = "usp_NG_RequestDetailsSubTagAccess " & RequestID & "," & HttpContext.Current.Session("intUserID") & ""
        'strHasEditAccess = CommonFunctions.Data.GetDataScalar(strEditRequestSQL, m_blnUseSQL)
        drReader1 = CommonFunctions.Data.GetDataReader(strEditRequestSQL, True)

        If (drReader1.Read) Then
            strHasEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("Result")))
            strHasHRMEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("ResultHRM")))
        End If
        'End of Added By Dipali V On 31st Oct 2017 




        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Request_IssueTask_Details " & "'" & RequestID & "'", True)
        If dr.Read Then
            lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FunctionID"), "0"), Long)
            ' assigned to
            lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("TaskEmployeeID"), "0"), Long)
            If lngAssignTo = 0 Then
                lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        'dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Request_Task_Details  " & "'" & RequestID & "'", True)
        'If dr.Read Then
        '    lngProjectID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectID"), "0"), Long)
        'End If
        'CommonFunction.Data.DisposeDataReader(dr)


        ' get the department 
        If lngFunctionID = 0 Then
            lngFunctionID = GetEmployeeDepartment(m_lngEmployeeID)
        End If

        If lngProjectID = 0 Then
            lngProjectID = GetDefaultProject(lngFunctionID)
        End If


        Dim strSelSQL As String
        Dim lngsubRequesttypeID As String
        Dim lngTaskType As String
        Dim strSQLTaskType As String
        strSQLTaskType = "Exec usp_Sel_TaskTypeMappedToProject " & lngProjectID.ToString
        strSelSQL = "usp_sel_tbl_crm_query_master_QueryIdWiseSubRequestTypeID '" & RequestID & "'"
        Dim drWorkHrs As IDataReader
        Dim m_WorkHrs As String
        Dim strSelSQL1 As String
        Dim dr1 As IDataReader
        Dim strStartDate As String

        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, True)
        If dr1.Read Then
            lngsubRequesttypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr1("SubRequestTypeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr1)


        strSelSQL = "usp_sel_tbl_PM_TaskTypes_TaskTypeID_TaskType " & lngsubRequesttypeID


        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, True)
        If dr1.Read Then
            lngTaskType = CType(CommonFunctions.Data.CheckIsDBNull(dr1("TaskTypeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr1)


        strSelSQL1 = "usp_sel_tbl_CRM_SubRequestType_SubRequestTypeID_DefaultWork " & lngsubRequesttypeID
        drWorkHrs = CommonFunctions.Data.GetDataReader(strSelSQL1, True)
        If drWorkHrs.Read Then
            m_WorkHrs = CType(CommonFunctions.Data.CheckIsDBNull(drWorkHrs("DefaultWork"), "0"), Double)
        End If

        CommonFunctions.Data.DisposeDataReader(drWorkHrs)

        strSelSQL = "usp_sel_tbl_CRM_Query_Master_QueryID_SubmittedDate '" & RequestID & "'"
        dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, True)
        If dr1.Read Then

            strStartDate = CType(CommonFunction.Data.CheckIsDBNull(dr1("Submitteddate").ToShortDateString()), String)
        End If
        CommonFunctions.Data.DisposeDataReader(dr1)

        If strHasHRMEditAccess = True Then
            strHTML.Append("<div class='editor'>")
            strHTML.Append("<form action='/action_page.php' class='form-horizontal'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <div class='assign-drop-grp'>")
            strHTML.Append("<div class='col-sm-4' style='margin-top:-1%'>")
            strHTML.Append(" <label for='sel1'>Project*</label>")

            If intCntDepts > 1 Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskProject", "usp_CRM_ProjectList_ForFunction 0", 0, , "class='form-control'  onchange=TaskProject_Onchange(this)", True, True, , True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskProject", "usp_CRM_ProjectList_ForFunction " & lngFunctionID, 0, lngProjectID.ToString, "class='form-control' onchange=TaskProject_Onchange(this) ", True, True, , False))
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4' style='margin-top:-1%'>")
            strHTML.Append("<label for='sel1'>Task Type*</label>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "select 'Task Type'", 0, , "class='form-control' ", True, True, , False))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strSQLTaskType, 0, lngTaskType.ToString, "class='form-control'", False, True, , False, , False))
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4' style='margin-top:-1%'>")
            Dim strSQLAssignTo As String = "usp_CRM_Get_ProjectEmployees " & lngProjectID & ",0"
            strHTML.Append("<label for='sel1'>Assigned To*</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTaskAssignTo", strSQLAssignTo.ToString, 0, lngAssignTo.ToString, "class='form-control' onchange=Project_Onchnge(this)", False, True, , False))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<div class='assign-drop-grp'>")
            strHTML.Append("<div class='col-sm-4' style='margin-top:-1%'>")
            strHTML.Append("<label for='workhours' style='float:left;padding-right:5px;'>Work Hours*</label>")
            ''Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
            '  strHTML.Append("<div class='bootstrap-timepicker input-group' style='width: 100px;float:left;'>")
            '  strHTML.Append(" <input type='text' class='form-control time-picker' id='timepicker2'  Style='font-size: 8px;width: 61px;'>")
            '  strHTML.Append(" <span class='input-group-addon add-on'><i class='fa fa-clock-o'></i></span>")
            strHTML.Append("<input type='text' class='form-control' id='idWorkHours' placeholder='Work Hours' value=" & m_WorkHrs & "> ")
            ''End Of Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4' style='margin-top:4%!important'>")
            strHTML.Append("<label for='startdate' class='sdate'>Start Date*<i class='fa fa-calendar' onclick='$('#datepicker1').datepicker();$('#datepicker1').datepicker('show');' style='padding-left:16px;'></i></label>	")
            strHTML.Append("<input type='text' class='form-control inp-date' id='datepicker1' style='width:38%;Margin-top:-3%' placeholder='Start Date' value=" & strStartDate & "> ")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4' style='margin-top:4%!important'>")
            strHTML.Append(" <label for='enddate' class='sdate'>End Date*<i class='fa fa-calendar' onclick='$('#datepicker2').datepicker();$('#datepicker2').datepicker('show');' style='padding-left:16px;'></i></label>")
            strHTML.Append("<input type='text' class='form-control inp-date' id='datepicker2' style='width:47%;Margin-top:-3%' placeholder='End Date'>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='assign-drop-grp' style='Margin-left:11%'>")
            strHTML.Append("<button type='button' class='btn btn-default save' onclick=Clear_AssignTask()>Clear</button>")
            strHTML.Append("<button type='button' class='btn btn-default save' onclick=AssignTasks(" & RequestID & "," & DepartmentID & ")>Submit</button>	")
            strHTML.Append("</div>")

            strHTML.Append("</form>")
            strHTML.Append("</div>")


            strHTML.Append("<h3>Assigned Tasks For this Requests</h3>")


            strHTML.Append("<div class='table-responsive'>  ")
            strHTML.Append(" <table class='table'>")
            strHTML.Append("<thead>")
            strHTML.Append(" <tr>")
            strHTML.Append("<th>Employee Name</th>")
            '  strHTML.Append("<th class='italic'>Start Date</th>")
            strHTML.Append("<th>Start Date</th>")
            ' strHTML.Append("<th  class='italic'>End Date</th>")
            strHTML.Append("<th>End Date</th>")
            strHTML.Append("<th>Work Hours</th>")
            strHTML.Append("<th>Actual Hours</th>")
            strHTML.Append("<th >Is Task Active?</th>")
            strHTML.Append(" </tr>")
            strHTML.Append("</thead>")
            strHTML.Append("<tbody>")
            Dim Employeename As String = ""
            Dim StartDate As String = ""
            Dim EndDate As String = ""
            Dim IsActive As String = ""
            Dim Work As String = ""
            Dim Duration As String = ""
            For i As Integer = 0 To dtTasks.Rows.Count - 1
                ''Flag = 1
                strHTML.Append("<tr>")
                Employeename = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("EmployeeName").ToString, "")
                ''Commented and addd by Yogesh Jalamkar on 1-DEC-2017 Purpose: Date format issue
                'StartDate = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("StartDate").ToString, "")
                'EndDate = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("EndDate").ToString, "")
                StartDate = CommonFunctions.Data.CheckIsDBNull(Convert.ToDateTime(dtTasks.Rows(i)("StartDate")).ToString("dd-MMM-yyyy"), "")
                EndDate = CommonFunctions.Data.CheckIsDBNull(Convert.ToDateTime(dtTasks.Rows(i)("EndDate")).ToString("dd-MMM-yyyy"), "")
                ''End by Yogesh Jalamkar
                Work = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("Work"), "")
                IsActive = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("IsActive").ToString, "")
                Duration = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("Duration").ToString, "")

                If IsActive.ToUpper = "TRUE" Then
                    IsActive = "Yes"
                ElseIf IsActive.ToUpper = "FALSE" Then
                    IsActive = "No"
                End If

                strHTML.Append("<td>" & Employeename & "</td>")
                strHTML.Append("<td><span class='date'>" & StartDate & "</span></td>")
                strHTML.Append("<td><span class='date'>" & EndDate & "</span></td>")
                strHTML.Append("<td>" & Work & "</td>")
                strHTML.Append("<td>" & Duration & "</td>")
                strHTML.Append("<td class='yes'>" & IsActive & "</td>")
                strHTML.Append("</tr>")

                Counter += 1
            Next
            strHTML.Append("</tbody>")
            strHTML.Append("</table>")
            strHTML.Append("</div>")

        Else
            strHTML.Append("<h3>Assigned Tasks For this Requests</h3>")


            strHTML.Append("<div class='table-responsive'>  ")
            strHTML.Append(" <table class='table'>")
            strHTML.Append("<thead>")
            strHTML.Append(" <tr>")
            strHTML.Append("<th>Employee Name</th>")
            'strHTML.Append("<th class='italic'>Start Date</th>")
            'strHTML.Append("<th  class='italic'>End Date</th>")
            strHTML.Append("<th>Start Date</th>")
            strHTML.Append("<th>End Date</th>")
            strHTML.Append("<th>Work Hours</th>")
            strHTML.Append("<th>Actual Hours</th>")
            strHTML.Append("<th >Is Task Active?</th>")
            strHTML.Append(" </tr>")
            strHTML.Append("</thead>")
            strHTML.Append("<tbody>")
            Dim Employeename As String = ""
            Dim StartDate As String = ""
            Dim EndDate As String = ""
            Dim IsActive As String = ""
            Dim Work As String = ""
            Dim Duration As String = ""
            For i As Integer = 0 To dtTasks.Rows.Count - 1
                ''Flag = 1
                strHTML.Append("<tr>")
                Employeename = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("EmployeeName").ToString, "")
                ''Commented and addd by Yogesh Jalamkar on 1-DEC-2017 Purpose: Date format issue
                'StartDate = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("StartDate").ToString, "")
                'EndDate = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("EndDate").ToString, "")
                StartDate = CommonFunctions.Data.CheckIsDBNull(Convert.ToDateTime(dtTasks.Rows(i)("StartDate")).ToString("dd-MMM-yyyy"), "")
                EndDate = CommonFunctions.Data.CheckIsDBNull(Convert.ToDateTime(dtTasks.Rows(i)("EndDate")).ToString("dd-MMM-yyyy"), "")
                ''End by yogesh Jalamkar
                Work = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("Work").ToString, "")
                IsActive = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("IsActive").ToString, "")
                Duration = CommonFunctions.Data.CheckIsDBNull(dtTasks.Rows(i)("Duration").ToString, "")

                If IsActive.ToUpper = "TRUE" Then
                    IsActive = "Yes"
                ElseIf IsActive.ToUpper = "FALSE" Then
                    IsActive = "No"
                End If

                strHTML.Append("<td>" & Employeename & "</td>")
                strHTML.Append("<td><span class='date'>" & StartDate & "</span></td>")
                strHTML.Append("<td><span class='date'>" & EndDate & "</span></td>")
                strHTML.Append("<td>" & Work & "</td>")
                strHTML.Append("<td>" & Duration & "</td>")
                strHTML.Append("<td class='yes'>" & IsActive & "</td>")
                strHTML.Append("</tr>")

                Counter += 1
            Next
            strHTML.Append("</tbody>")
            strHTML.Append("</table>")
            strHTML.Append("</div>")

        End If



        Return strHTML.ToString
    End Function

    Private Function GetDefaultProject(ByVal FunctionID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultProject " & FunctionID, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then
            GetDefaultProject = CType(CommonFunctions.General.CheckIsNothing(dr("ProjectID"), "0"), Long)
        Else
            GetDefaultProject = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
    Private Function WriteAttachmentGrid(ByVal QueryID As String, ByVal QueryDetailID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteAttachmentGrid()	
        ' Purpose               : Plot Grid for request attachments
        ' Author                : Bharat T.
        ' Created               : Oct 13, 2017
        '=====================================================================

        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer
        Dim strSortBy, strSortOrder As String

        Dim strGridHTML As New StringBuilder("")

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"", "align=left style='width:60%;'", "align=left style='width:20%;'", "align=left style='width:20%;'"}

        'Purpose : To have the Original file name for attachment
        Dim arrstrRowLinkField() As String = {"", "Document_OnClick_For_CRM(SystemFileName,OriginalFileName)", "", ""}

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add("File Icon")
        arrColHeadingsList.Add("File Name")
        arrColHeadingsList.Add("Uploaded By")
        arrColHeadingsList.Add("Upload Date")
        'arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("")
        arrColNamesList.Add("OriginalFileName")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("DateAttached")
        'arrColNamesList.Add("Description")

        'If Not Request.QueryString("sortby") Is Nothing Then
        '    strSortBy = Request.QueryString("sortby")
        'Else
        '    strSortBy = "DateAttached"
        'End If

        'If Not Request.QueryString("sortorder") Is Nothing Then
        '    strSortOrder = Request.QueryString("sortorder")
        'Else
        '    strSortOrder = "DESC"
        'End If

        ''--- Display the Page Caption 
        'CommonFunctions.General.WriteHTML("<br>")
        'WebPages.Template.PageCaption.GetPageCaptions(, "")
        'CommonFunctions.General.WriteHTML("<br>")

        '--- Display the list of records for the selected Employee
        strSQLQuery = "EXEC usp_NG2_Sel_Documents_Attached_For_CRM_Discussion " & CommonFunctions.General.CheckIsNothing(QueryID, "") & "," & CommonFunctions.General.CheckIsNothing(QueryDetailID, "")
        strSQLQuery += " ,NULL , '-1'"
        strSQLQuery += ", 'DateAttached', 'DESC'"

        m_objGridAttachment = New WebPages.Template.GenericGrid
        With m_objGridAttachment
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 4
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto;height:225px !important;"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = "divAttachment"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
            '.SortBy = strSortBy
            '.SortOrder = strSortOrder
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        intRecordCount = m_objGridAttachment.NoOfRows

        m_objGridAttachment = Nothing

        strGridHTML.Append("<BR><TABLE class=clsGridTable cellpadding=0 cellspacing=0 width='99.9%' style='background-color:transparent !important; border:0px !important;'>")

        strGridHTML.Append("<TR ><TD width='100%' align='right'>")
        strGridHTML.Append("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

        Return strGridHTML.ToString

    End Function
    Private Sub m_objGridAttachment_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridAttachment.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = "FILE ICON" Then
            Cancel = True
            Args.StringToBeInserted = "<th></th>"
        End If
    End Sub

    Private Sub m_objGridAttachment_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridAttachment.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "FILE ICON" Then
            Cancel = True
            Args.StringToBeInserted = "<td><i class='fa fa-file-pdf-o' aria-hidden='true'></i></td>"
        End If
        If Args.DataField.ToUpper = "ORIGINALFILENAME" Then
            Cancel = True

            Args.StringToBeInserted = "<td valign=top align=left style='width:60%;' title='File Name'>"
            Args.StringToBeInserted += "<a href=""JavaScript:Document_OnClick_For_CRM('" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SystemFileName")) & "','" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OriginalFileName")) & "')"">" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OriginalFileName")) & ""
            Args.StringToBeInserted += "<i class='fa fa-download' aria-hidden='true'></i>"
            Args.StringToBeInserted += "</a></td>"
        End If
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	        
        ' Author                : Bharat T.
        ' Created               : Oct 13, 2017
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Function ConvertToDeliverableDetails(ByVal RequestID As String, ByVal DepartmentID As String)
        Dim strHTML As New StringBuilder()
        Dim strRequestorSLoginType As String = ""
        Dim strRequestorSUserName As String = ""
        Dim drMultipleRequests As IDataReader
        Dim strSummary As String = ""
        Dim strDescription As String = ""
        Dim strSubject As String = ""
        drMultipleRequests = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & RequestID, True)
        If drMultipleRequests.Read Then
            DepartmentID = CType(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests("FunctionID"), "0"), Long) ' assigned to
            If Trim(strSummary & "") = "" Then
                If Trim(drMultipleRequests("Description").ToString & "") = "" Then
                    strSubject = drMultipleRequests("Subject").ToString & ""
                Else
                    strDescription = drMultipleRequests("Description").ToString & ""
                    strSubject = drMultipleRequests("Subject").ToString & ""
                End If

            End If
            CommonFunction.Data.DisposeDataReader(drMultipleRequests)
        End If

        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        'Dim Flag As Integer = 0
        Dim Counter As Integer = 0
        Dim DateAttached As String = ""
        Dim DateAttachedTime As String = ""
        Dim strProjectID As String = 0
        strHTML.Append("<div class='reqeustor'>")
        strHTML.Append("<div class='editor'>")
        strHTML.Append("<form action='/action_page.php' class='form-horizontal'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label for='title' class='col-sm-3'>Title*</label>")
        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append("<input type='text' class='form-control' id='title' style='width:398px!important' placeholder='Enter Title' name='title' value='" & strDescription & "'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        'strHTML.Append(" <div class='form-group'>")
        'strHTML.Append("<div class='assign-drop-grp'>")
        'strHTML.Append(" <div class='col-sm-4'>")
        'strHTML.Append("  <label for='sel1'>Project</label>")

        'If strProjectID = "0" Then
        '    strProjectID = CType(GetDefaultProject(DepartmentID), String)
        'End If

        'Dim strFunction As String = "EXEC usp_CRM_ProjectList_ForFunction " & DepartmentID & ", " & strProjectID.ToString
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableProject", strFunction, 0, , "class='form-control'  onchange=DeliverableProject_Onchange(this)", True, True, , True))
        'strHTML.Append("</div>")

        'strHTML.Append(" <div class='col-sm-4'>")
        'strHTML.Append("  <label for='sel1'>Deliverable</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", "select 'Deliverable type'", 0, , "class='form-control' ", True, True, , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label for='Deliverable' class='col-sm-3'>Project*</label>")
        strHTML.Append("<div class='col-sm-9'>")
        If strProjectID = "0" Then
            strProjectID = CType(GetDefaultProject(DepartmentID), String)
        End If

        Dim strFunction As String = "EXEC usp_CRM_ProjectList_ForFunction " & DepartmentID & ", " & strProjectID.ToString
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableProject", strFunction, 0, strProjectID.ToString, "class='form-control'  onchange=DeliverableProject_Onchange(this)", True, True, , False))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label for='Project' class='col-sm-3' style='white-space:nowrap'> Deliverable Type*</label>")
        strHTML.Append("<div class='col-sm-9'>")
        ''Commented and added by Yogesh Jalamkar Purpose: Issue fixing IssueID:9571
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", "select 'Deliverable type'", 0, , "class='form-control'  onchange=DeliverableType_Onchange(this)", False, True, , False))
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", "usp_sel_tbl_PM_ProjectSchedules_ScheduleID_LabelSchedule null", 0, , "class='form-control'  onchange=DeliverableType_Onchange(this)", False, True, , False))
        '''End by Yogesh Jalamkar
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")





        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label for='title' class='col-sm-3'>Code Template</label>")
        'strHTML.Append("<div class='col-sm-9'>")
        'strHTML.Append("<input type='text' class='form-control' id='Codetemplate' placeholder='Enter Code Template' name='Code template'>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        strHTML.Append("<div class='form-group' id='divDeliverableDate' style='display:none;'>")
        strHTML.Append("<label for='startdate' class='sdate'>Start Date*<i class='fa fa-calendar' onclick='$('#datepicker').datepicker();$('#datepicker').datepicker('show');' style='padding-left:16px;'></i></label>")
        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append("<input type='text' class='form-control inp-date' id='datepicker'> ")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label for='desc' class='col-sm-3'>Description</label>")
        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("desc1", "desc1", , "form-control", , , , , , , , strDescription, , , , , , , "PlaceHolder='Enter Description'", True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div id='divCustomFields'>")
        strHTML.Append("</div>")
        Dim drReader1 As IDataReader
        strEditRequestSQL = "usp_NG_RequestDetailsSubTagAccess " & RequestID & "," & HttpContext.Current.Session("intUserID") & ""
        drReader1 = CommonFunctions.Data.GetDataReader(strEditRequestSQL, True)

        If (drReader1.Read) Then
            strHasEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("Result")))
            strHasHRMEditAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader1("ResultHRM")))
        End If

        If strHasHRMEditAccess = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' style='margin-right:3%' onclick=ClearDeliverables()>Clear</button>")
            strHTML.Append("<button type='button' class='btn btn-default save' onclick=SaveDeliverables()>Save</button>")
        Else
            strHTML.Append("<button type='button' class='btn btn-default cancle'>Cancel</button>")
        End If

        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return strHTML.ToString
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function PlotIssueDetails(ByVal ProjectID As String, ByVal RequestID As String, ByVal IssueType As String)
        Try
            Dim strHTML As New StringBuilder("")
            Dim drMultipleRequests As IDataReader
            Dim strSummary As String = ""
            Dim DepartmentID As String = ""
            Dim strRequestorSLoginType As String = ""
            Dim strRequestorSUserName As String = ""
            Dim strDescription As String = ""
            Dim CustomerID As String = "NULL"
            Dim strComboSQL As String = ""

            drMultipleRequests = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & RequestID, True)
            If drMultipleRequests.Read Then
                DepartmentID = CType(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests("FunctionID"), "0"), Long) ' assigned to
                strRequestorSLoginType = drMultipleRequests("LoginType").ToString
                strRequestorSUserName = drMultipleRequests("CustomerID").ToString

                If Trim(strSummary & "") = "" Then
                    strSummary = "Request ID->" & RequestID & "-->" & drMultipleRequests("Subject").ToString & ""

                    If Trim(drMultipleRequests("Description").ToString & "") = "" Then
                        strDescription = drMultipleRequests("Subject").ToString & ""
                    Else
                        strDescription = drMultipleRequests("Description").ToString & ""
                    End If

                End If
                CommonFunction.Data.DisposeDataReader(drMultipleRequests)
            End If


            Dim drRole As IDataReader
            Dim lngPostID As Long = 0

            drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & HttpContext.Current.Session("intUserID").ToString, True)

            If drRole.Read Then
                lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
            End If
            CommonFunctions.Data.DisposeDataReader(drRole)

            strHTML.Append("<div class='form-group' style='background: #f4f6f9;margin-bottom: 0;'>")
            strHTML.Append("<div class='assign-drop-grp'>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(" <label for='sel1'>Project*</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueProject", "usp_NG2_CRM_ProjectList_ForFunction_ForAssignIssueHelpDesk " & DepartmentID & "," & RequestID & ",'" & strRequestorSLoginType & "','" & strRequestorSUserName & "'", , ProjectID, "class='form-control' onchange=Project_Onchnge(this) ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<label for='sel1'>Issue Type*</label>")

            If ProjectID = "" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo 0", , , "class='form-control' onchange=IssueType_Onchnge(this) ", True, True))
            Else
                ''Commented and Added by Yogesh Jalamkar on 28-NOV-2017 Purpose:Issue status should be depend on Issue type
                'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo " & ProjectID, , IssueType, "class='form-control' ", True, True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo " & ProjectID, , IssueType, "class='form-control' onchange=IssueType_Onchnge(this) ", True, True))
                ''End by Yogesh Jalamkar
            End If

            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(" <label for='sel1'>Assigned To*</label>")
            If ProjectID = "" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEmployee", "usp_CRM_Get_ProjectEmployees NULL ,0,0", , , "class='form-control' ", False, True))
                'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueType", "usp_CRM_Project_IssueTypes_ForCombo 0", , , "class='form-control' ", False, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEmployee", "usp_CRM_Get_ProjectEmployees " & ProjectID & ",0,0", , , "class='form-control' ", False, True))
            End If


            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append(" <div class='form-group' style='background: #f4f6f9;'>")
            strHTML.Append("<div class='assign-drop-grp'>")
            strHTML.Append(" <div class='col-sm-4'>")
            strHTML.Append(" <label for='sel1'>Issus Status*</label>")


            '' Commented and Added by Yogesh Jalamkar on 28-NOV-2017 Purpose:Issue status should be depend on Issue type
            'If IssueType = "" Then
            '    IssueType = "NULL"
            'End If
            If ProjectID <> "" Then
                If Trim(IssueType & "") = "" Then
                    IssueType = GetDefaultType(ProjectID)
                End If
            End If
            ''End by Yogesh Jalamkar
            If ProjectID = "" Then
                ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEmployee", "usp_CRM_Get_ProjectEmployees NULL ,0,0", , , "class='form-control' ", False, True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus 0,0,0", , , "class='form-control' ", True, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & ProjectID & ",'" & CommonFunctions.General.BuildQueryString(IssueType & "") & "'," & lngPostID & "", , , "class='form-control' ", True, True))
            End If

            strHTML.Append(" </div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<label for='sel1'>Priority</label>")
            If ProjectID = "" Then
                ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEmployee", "usp_CRM_Get_ProjectEmployees NULL ,0,0", , , "class='form-control' ", False, True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssuePriority", "usp_Sel_tbl_IB_Project_Priorities 0,0", , , "class='form-control' ", True, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssuePriority", "usp_Sel_tbl_IB_Project_Priorities " & ProjectID & ",0", , , "class='form-control' ", True, True))
            End If


            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<label for='sel1'>Severity</label>")
            If ProjectID = "" Then
                ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEmployee", "usp_CRM_Get_ProjectEmployees NULL ,0,0", , , "class='form-control' ", False, True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueSeverity", "usp_Sel_tbl_IB_Project_Severity 0,0", , , "class='form-control' ", True, True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueSeverity", "usp_Sel_tbl_IB_Project_Severity " & ProjectID & ",0", , , "class='form-control' ", True, True))
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            ''Product Component
            Dim m_EnableProductExecution As String = ""
            Dim drProduct As IDataReader
            If ProjectID <> "0" And ProjectID <> "" And ProjectID <> "00" Then
                m_EnableProductExecution = CommonFunction.Application.EnableProductExecution
                If m_EnableProductExecution Then

                    ''''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''drProduct = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
                    drProduct = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + DepartmentID.ToString, True)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If drProduct.Read Then
                        m_EnableProductExecution = True
                    Else
                        m_EnableProductExecution = False
                    End If
                    CommonFunction.Data.DisposeDataReader(drProduct)
                End If
                If m_EnableProductExecution = True Then


                    drProduct = CommonFunction.Data.GetDataReader("usp_Sel_tbl_CRM_Query_Master_ProductAssociation " + RequestID + "," + ProjectID, True)
                    drProduct.Read()

                    Dim m_ProductVersion As String = ""
                    Dim m_Component As String = ""
                    Dim m_LoginID As String = ""
                    If strRequestorSLoginType.ToUpper = "C" Then
                        If m_ProductVersion = "0" Then
                            If Not IsDBNull(drProduct("ProductID")) Then
                                m_ProductVersion = drProduct("ProductID").ToString
                                If Not IsDBNull(drProduct("ComponentID")) Then
                                    m_Component = drProduct("ComponentID").ToString
                                End If
                            End If
                        End If
                        m_LoginID = drProduct("LoginID").ToString
                    End If



                    strHTML.Append(" <div class='form-group' style='background: #f4f6f9;'>")
                    strHTML.Append("<div class='assign-drop-grp'>")
                    If strRequestorSLoginType <> "C" Then
                        strHTML.Append(" <div class='col-sm-4'>")
                        strHTML.Append(" <label for='sel1'>Customer*</label>")
                        If m_LoginID = "" Then
                            m_LoginID = "0"
                        End If
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_Sel_tbl_PM_Customer_ProductExecution", , , "class='form-control' onchange=Customer_Onchange(this," & m_LoginID & "," & ProjectID & ")", True, True))
                        strHTML.Append(" </div>")
                    End If
                    strHTML.Append("<div class='col-sm-4'>")
                    strHTML.Append("<label for='sel1'>Product*</label>")
                    ''  strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueProduct", "select ''", , , "class='form-control'  onchange=IssueProduct_Onchange(this)", True, True))


                    Dim drCustomerID As IDataReader
                    Dim RequestCustomerID As String = ""



                    If strRequestorSLoginType = "C" Then
                        drCustomerID = CommonFunction.Data.GetDataReader("usp_NG2_Sel_CustomerID_tbl_PM_Customer '" & strRequestorSUserName & "'", True)

                        If drCustomerID.Read Then
                            RequestCustomerID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.General.CheckIsNothing(drCustomerID("customer"), "0"), "0"), String)
                        End If
                        strComboSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + RequestCustomerID + " , 'C' ," + m_LoginID + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null , " + CustomerID + " , " + ProjectID
                    Else
                        ' If RequestCustomerID = "" Then
                        strComboSQL = "if (1=2) SELECT '',''"
                        'Else
                        '    strComboSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + CustomerID + " , 'C' ,NULL" + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null , " + CustomerID + " , " + ProjectID
                        'End If
                        'End If
                    End If


                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueProduct", strComboSQL, , , "class='form-control'  onchange=IssueProduct_Onchange(this)", True, True))

                    strHTML.Append("</div>")
                    strHTML.Append("<div class='col-sm-4'>")
                    strHTML.Append("<label for='sel1'>Component</label>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboIssueComponent", "Select ''", , , "class='form-control' ", True, True))
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                End If
            End If
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetProductCombo(ByVal CustomerID As String, ByVal RequestID As String, ByVal ProjectID As String, ByVal LoginID As String)
        '=====================================================================
        ' Procedure  Name		:	GetModuleOrComponent
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Module/Component
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Oct 2017
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            Dim drMultipleRequests As IDataReader
            Dim strSummary As String = ""
            Dim DepartmentID As String = ""
            Dim strRequestorSUserName As String
            Dim strRequestorSLoginType As String
            Dim strComboSQL As String = ""
            drMultipleRequests = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & RequestID, True)
            If drMultipleRequests.Read Then
                DepartmentID = CType(CommonFunctions.Data.CheckIsDBNull(drMultipleRequests("FunctionID"), "0"), Long) ' assigned to
                strRequestorSLoginType = drMultipleRequests("LoginType").ToString
                strRequestorSUserName = drMultipleRequests("CustomerID").ToString
            End If
            CommonFunction.Data.DisposeDataReader(drMultipleRequests)

            If strRequestorSLoginType = "C" Then
                strComboSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + CustomerID + " , 'C' ," + LoginID + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null , " + CustomerID + " , " + ProjectID
            Else
                If CustomerID = "" Then
                    strComboSQL = "if (1=2) SELECT '',''"
                Else
                    strComboSQL = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + CustomerID + " , 'C' ,NULL" + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null , " + CustomerID + " , " + ProjectID
                End If
            End If

            dtDefectType = CommonFunctions.Data.GetDataTable(strComboSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")
            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestType(ByVal TypeID As String, ByVal WhichList As String, ByVal RequestTypeID As String, ByVal CustomerID As String, ByVal EmployeeID As String, ByVal QueryID As String)
        '=====================================================================
        ' Procedure  Name		:	GetRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get RequestType
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Oct 2017
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()
            Dim dr As IDataReader
            Dim objCRM_AddNewRequest As New CRM_RequestDetailsUncategorized
            Dim strReturnHtml1 As New StringBuilder("")
            Dim ShowProductCombo As String = "0"
            Dim m_strRequestedEmployee As String = ""
            Dim m_intRequestedEmployeePost As String = ""
            Dim m_strRequestedEmployeeUN As String = ""
            ' Dim m_strUserID As String
            If TypeID = "" Then
                TypeID = 0
            End If
            objCRM_AddNewRequest.m_lngQueryID = QueryID
            objCRM_AddNewRequest.m_blnUseSQL = True
            objCRM_AddNewRequest.m_lngEmployeeID = HttpContext.Current.Session("intUserID")
            objCRM_AddNewRequest.m_strUserName = HttpContext.Current.Session("strUserName")
            objCRM_AddNewRequest.m_lngSubRequestTypeID = 0
            objCRM_AddNewRequest.lngFunctionID = TypeID
            If RequestTypeID = "" Then
                RequestTypeID = 0
            End If
            Dim drEmployee As IDataReader
            If EmployeeID <> 0 Then
                Dim StrEmployee As String
                StrEmployee = "usp_sel_tbl_pm_employee_EmployeeName_PostID_UserName " & EmployeeID

                drEmployee = CommonFunctions.Data.GetDataReader(StrEmployee, True)
                If drEmployee.Read Then
                    m_strRequestedEmployee = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
                    m_intRequestedEmployeePost = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("PostID"), "0"), Integer)
                    m_strRequestedEmployeeUN = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("UserName"), ""), String)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drEmployee)
            If WhichList.ToUpper = "REQUESTTYPE" Then


                If CustomerID <> 0 Then
                    strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
                    strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
                    strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
                    strSQL += "  and RoleID =23 AND functionID = " & TypeID
                Else
                    If EmployeeID <> 0 Then
                        strSQL = "usp_CRM_RequestTypes " & TypeID & ",'" & m_strRequestedEmployeeUN & "','" & HttpContext.Current.Session("LoginType").ToString & "',0,0"
                    Else
                        strSQL = "usp_CRM_RequestTypes " & TypeID & ",'" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0,0"
                    End If
                End If


                ''strSQL = "Exec usp_CRM_RequestTypes  " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0,0"

                If CommonFunction.Application.EnableProductExecution = True Then
                    dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + TypeID.ToString, True)

                    If dr.Read Then
                        ShowProductCombo = "1"
                    Else
                        ShowProductCombo = "0"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                End If


            Else
                If CustomerID <> "0" Then
                    Dim strSqlQuery_CustName As String
                    strSqlQuery_CustName = "usp_sel_tbl_pm_customer_CustomerID " & CustomerID
                    Dim m_strUserName As String = CType(CommonFunctions.Data.GetDataScalar(strSqlQuery_CustName, True), String)

                    strSQL = "usp_NG2_CRM_RequestSubTypes " & TypeID & ",'" & m_strUserName & "','C',0," & RequestTypeID.ToString & ",0"
                Else

                    strSQL = "usp_NG2_CRM_RequestSubTypes " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0," & RequestTypeID & ""

                End If

                '' strSQL = "usp_CRM_RequestSubTypes " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0," & RequestTypeID & ""

            End If

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")
            'strValidation = strScript(1)
            strHTML.Append(strScript(0) + vbCrLf)


            If ShowProductCombo = "1" Then

                strReturnHtml1.Append("<div class='col-sm-6'>")
                strReturnHtml1.Append("<label for='sel1'>Product</label>")
                strReturnHtml1.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CustomerID.ToString & "',NULL" + "," + QueryID.ToString, , , " class='form-control'  onchange=Product_OnChange(this)", True, True, , False))
                strReturnHtml1.Append("</div>")

                strReturnHtml1.Append("<div class='col-sm-6'>")

                strReturnHtml1.Append("<label for='sel1'>Module/Component</label>")
                strReturnHtml1.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID ", , , "class='form-control'", True, True, , False))

                strReturnHtml1.Append("</div>")
            End If


            'Commented by yogesh Jalamkar on 29-NOV-2017 purpose: Issue fixing
            '' strReturnHtml1.Append(objCRM_AddNewRequest.PlotRequestControls("", "", ""))
            'End of comment by Yogesh Jalamkar
            Return strResult & "|" & strHTML.ToString & "|" & strReturnHtml1.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetModuleOrComponent(ByVal ProductID As String)
        '=====================================================================
        ' Procedure  Name		:	GetModuleOrComponent
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Module/Component
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Oct 2017
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            strSQL = "Exec usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " & ProductID & ""

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            Return strResult & "|" & strHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDeliverableType(ByVal ProjectID As String)
        '=====================================================================
        ' Procedure  Name		:	GetModuleOrComponent
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Module/Component
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Oct 2017
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            If ProjectID = "" Then
                ProjectID = "0"
            End If
            strSQL = "Exec usp_sel_tbl_PM_ProjectSchedules_ScheduleID_LabelSchedule " & ProjectID & ""

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            Return strResult & "|" & strHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaskType(ByVal ProjectID As String, ByVal RequestID As String)
        '=====================================================================
        ' Procedure  Name		:	GetTaskType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Task Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Oct 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()
            Dim dtDefectType1 As DataTable
            Dim strResult1 As String = ""
            If ProjectID = "" Then
                ProjectID = "0"
            End If
            strSQL = "Exec usp_Sel_TaskTypeMappedToProject " & ProjectID & ""

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)


            Dim strSQLAssignTo As String = "usp_CRM_Get_ProjectEmployees " & ProjectID & ",0"
            dtDefectType1 = CommonFunctions.Data.GetDataTable(strSQLAssignTo, True)

            strResult1 = GetSerialized(dtDefectType1)


            strScript = strResult.Split("|")
            strHTML.Append(strScript(0) + vbCrLf)

            'Added by Dipali V On 3th Nov 2017 For Getting Start date & Work Hrs
            Dim dr1 As IDataReader
            Dim strStartDate As String = ""
            Dim strSelSQL As String = ""
            strSelSQL = "usp_sel_tbl_CRM_Query_Master_QueryID_SubmittedDate '" & RequestID & "'"
            dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, True)
            If dr1.Read Then
                strStartDate = CommonFunction.Data.CheckIsDBNull(dr1("SubmittedDate"), "").ToString()
                strStartDate = CType(CommonFunction.Data.CheckIsDBNull(dr1("Submitteddate").ToShortDateString()), String)
            End If
            CommonFunctions.Data.DisposeDataReader(dr1)



            Dim drsubRequesttypeID As IDataReader
            Dim lngsubRequesttypeID As String = ""
            strSelSQL = "usp_sel_tbl_crm_query_master_QueryIdWiseSubRequestTypeID '" & RequestID & "'"
            drsubRequesttypeID = CommonFunctions.Data.GetDataReader(strSelSQL, True)
            If drsubRequesttypeID.Read Then
                lngsubRequesttypeID = CType(CommonFunctions.Data.CheckIsDBNull(drsubRequesttypeID("SubRequestTypeID"), "0"), Long)
            End If
            CommonFunctions.Data.DisposeDataReader(drsubRequesttypeID)

            ' ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ' ''strSelSQL = "SELECT tbl_PM_TaskTypes.TaskTypeID,tbl_CRM_SubRequestType.TaskType FROM tbl_PM_TaskTypes,tbl_CRM_SubRequestType WHERE tbl_PM_TaskTypes.TaskType=tbl_CRM_SubRequestType.TaskType and tbl_CRM_SubRequestType.SubRequestTypeID=" & lngsubRequesttypeID
            'strSelSQL = "usp_sel_tbl_PM_TaskTypes_TaskTypeID_TaskType " & lngsubRequesttypeID
            ' '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'dr1 = CommonFunctions.Data.GetDataReader(strSelSQL, MyBase.UseSQL)
            'If dr1.Read Then
            '    lngTaskType = CType(CommonFunctions.Data.CheckIsDBNull(dr1("TaskTypeID"), "0"), Long)
            'End If
            'CommonFunctions.Data.DisposeDataReader(dr1)

            'CommonFunctions.HTMLControls.DrawComboBox("cboTaskType ", strSQLTaskType, 0, lngTaskType.ToString, , True, , , True)
            '.Write("</td></tr>" & vbCrLf)

            ''Work hrs

            '.Write("<tr class=clsTREven><td  width='30%' align=right>" & MyBase.GetResourceString("CAPTION_WORK") & "</td>" & vbCrLf)
            '.Write("<td  width='70%'>" & vbCrLf)


            Dim drWorkHrs As IDataReader
            Dim m_WorkHrs As String = ""
            strSelSQL = "usp_sel_tbl_CRM_SubRequestType_SubRequestTypeID_DefaultWork " & lngsubRequesttypeID
            drWorkHrs = CommonFunctions.Data.GetDataReader(strSelSQL, True)
            If drWorkHrs.Read Then
                m_WorkHrs = CType(CommonFunctions.Data.CheckIsDBNull(drWorkHrs("DefaultWork"), "0"), Double)
            End If

            CommonFunctions.Data.DisposeDataReader(drWorkHrs)
            'End of Added by Dipali V On 3th Nov 2017
            Return strResult & "|" & strResult1 & "|" & strStartDate & "|" & m_WorkHrs

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetAssociationTabs(ByVal RequestID As String, ByVal Flag As String, ByVal DepartmentID As String)
        '=====================================================================
        ' Procedure  Name		:	GetAssociationTabs
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	GetAssociationTabs
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   18 Oct 2017
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder("")

            'Dim strEditRequestSQL As String = ""
            'Dim strHasEditAccessnew As String = ""
            'Dim strHasEditAccess As String = ""
            'Dim strHasHRMEditAccess As String = ""
            'Dim strHasEditAccess1() As String



            Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
            If Flag = "Issue" Then
                strHTML.Append(objCRMRequestDetails.AssignIssueDetailsTabs(RequestID))
            ElseIf Flag = "Task" Then
                strHTML.Append(objCRMRequestDetails.AssignTaskDetailsTabs(RequestID, DepartmentID))
            ElseIf Flag = "Deliverable" Then
                strHTML.Append(objCRMRequestDetails.ConvertToDeliverableDetails(RequestID, DepartmentID))
            ElseIf Flag = "Linked" Then
                strHTML.Append(objCRMRequestDetails.AssociationDetails(RequestID))
            End If

            Return strHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAssignTask(ByVal DepartmentID As String, ByVal cboTaskProject As String, ByVal cboTaskType As String, ByVal CboTaskAssignTo As String, ByVal datepicker1 As String, ByVal datepicker2 As String, ByVal RequestID As String, ByVal Work As String)
        '=====================================================================
        ' Procedure  Name		:	SaveAssignTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Assign Tasks
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   18 Oct 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
            Dim strSQL As String = ""

            Dim WorkArray() As String
            WorkArray = Work.Split(":")
            strSQL = "exec usp_CRM_Assign_Task  '" & cboTaskProject & "','" & CboTaskAssignTo & "'," & RequestID & "," & cboTaskType & "," & WorkArray(0) & ",'" & datepicker1 & "','" & datepicker2 & "',0"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function SaveActivity(ByVal RequestID As String, ByVal TimeSpent As String, ByVal ActivityStatus As String, ByVal Activity As String)
        '=====================================================================
        ' Procedure  Name		:	SaveActivity
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Activity
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   18 Oct 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
            Dim strSQL As String = ""
            If TimeSpent = "" Then
                TimeSpent = "NULL"
            End If
            strSQL = "exec usp_INS_tbl_CRM_Query_Activity  " & RequestID & "," & HttpContext.Current.Session("intUserID") & "," & Activity & "," & TimeSpent & "," & ActivityStatus & ",NULL,NULL"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            ''  strHTML.Append(objCRMRequestDetails.GetActivities(RequestID))

            '' Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteAttachment(ByVal AttachmentID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteAttachment
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Attchments
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   23 Oct 2017
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
        arrDelete = AttachmentID.Split(",")
        Try

            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Delete_Attachment  " & arrDelete(index) & ""

                Dim strResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "")

                If (System.IO.File.Exists(HttpContext.Current.Server.MapPath("..\..\..\") & "ATTACHMENTS\CRM\" & strResult)) Then
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("..\..\..\") & "ATTACHMENTS\CRM\" & strResult)
                End If
            Next


        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function
    ''Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes-Plotting Custom Field
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotCustomFields(ByVal DepartmentID As String, ByVal RequestTypeID As String, ByVal SubRequestTypeID As String, ByVal CustomerID As String, ByVal RequestID As String)
        Try
            'Dim strUserGivenCaption As String
            'Dim m_strTypeInaccessibleCustomFieldList As String
            'Dim strSQLQuery As String
            'Dim strSQLQueryStatus As String
            'Dim drCustomField As IDataReader
            'Dim objNewRequest As New CRM_RequestDetailsUncategorized()
            'Dim drStatus As IDataReader
            'Dim strStyleDisabled = ""
            'If SubRequestTypeID = "" Then
            '    SubRequestTypeID = 0
            'End If

            'If RequestTypeID = "" Then
            '    RequestTypeID = 0
            'End If
            'Dim strStatus As String = ""
            'drStatus = CommonFunction.Data.GetDataReader("usp_NG2_SEL_Status_tbl_CRM_Query_Master " & RequestID, True)
            'While drStatus.Read
            '    strStatus = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drStatus("StatusID"), ""), ""), String)

            'End While
            'CommonFunction.Data.DisposeDataReader(drStatus)
            'If strStatus = "2" Then
            '    strStyleDisabled = "disabled"
            'End If


            'Dim m_strPrimaryTable As String = "Tbl_CRM_Query_Master"
            'Dim m_strPrimaryKey As String = "QueryID"
            'Dim strFieldValue As String = ""
            'Dim strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted As String
            'Dim blnIsMandatory As Boolean
            'Dim intControlMaxLength As Integer
            'Dim intControlMinValue As Integer
            'Dim intControlMaxValue As Integer
            'Dim intControlHeight As Integer
            'Dim strControlCaption As String
            'Dim strControlValidationRules As String

            'Dim strDataType As String
            'Dim declarevariables As String
            'Dim m_strCustomFieldList As String

            ''Dim strCustomFieldTD As System.Text.StringBuilder
            'Dim strCustomFieldTD As StringBuilder = New StringBuilder()
            'Dim strControlValidations As New StringBuilder("")
            'Dim arrtemp(50) As String
            'Dim objRequestDetails As New CRM_RequestDetailsUncategorized()




            'Dim intCorporateRoleLevel As Integer
            'Dim strFieldAccess As String = ""
            'Dim dsRoleAccess As System.Data.DataSet
            'Dim dsCustomField As System.Data.DataSet
            'Dim m_lngProjectId As Integer = 0
            'Dim Flag As Boolean = False
            'Dim m_lngRoleId As Integer = 0
            ' '' Dim strClientSideScript As String = ""
            'strClientSideScript = ""
            'If Not m_lngRoleId > 0 Then
            '    m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
            'End If

            'Dim loginType As String = ""
            'If CustomerID <> 0 Then
            '    loginType = "C"
            'Else
            '    loginType = HttpContext.Current.Session("LoginType").ToString
            'End If
            'Dim drCustomAccess As IDataReader


            'strSQLQuery = "usp_sel_tbl_PM_RoleCustomFieldSecurity 0," & m_lngRoleId & "," & CType(HttpContext.Current.Session("intUserID"), Long) & ",'Help-Desk','" & loginType & "'"
            ''drRoleAccess = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            '' dsRoleAccess = CommonFunction.Data.GetDataSet(strSQLQuery, "CustomRoleAccess", , , True)

            'Dim strCustomFieldIDs() As String
            'Dim intCount As Integer = 0
            'drCustomAccess = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            'While drCustomAccess.Read
            '    ReDim Preserve strCustomFieldIDs(intCount)
            '    strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            '    intCount += 1
            'End While
            'CommonFunction.Data.DisposeDataReader(drCustomAccess)


            'Dim drLayout As IDataReader

            'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master 0,NULL,1,'" & SubRequestTypeID & "','Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & loginType & "'"
            ''drCustomField1 = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            'dsCustomField = CommonFunction.Data.GetDataSet(strSQLQuery, "CustomField", , , True)

            ''If strFieldAccess <> "" Then
            ''    strFieldAccess = strFieldAccess.Substring(0, strFieldAccess.Length - 1)
            ''End If




            'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master  0,NULL,1," & SubRequestTypeID & ",'Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & loginType & "'"
            'drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)


            'objRequestDetails.GetValidationRules()
            'objRequestDetails.arrValidationMessages.CopyTo(arrtemp, 0)

            'While drCustomField.Read
            '    strControlName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            '    intControlWidth = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlWidth"), ""), "")
            '    strControlCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("UserGivenCaption"), ""), "")
            '    strControlValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DefaultValue"), ""), "")
            '    'strToBeInserted = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            '    'blnIsMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            '    intControlMaxLength = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxLength"), "0"), "0")
            '    intControlHeight = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlHeight"), "0"), "0")

            '    intControlMinValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MinValue"), "0"), "0")
            '    intControlMaxValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxValue"), "0"), "0")
            '    strDataType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DataType"), "0"), "0")

            '    strControlValidationRules = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ValidationRules"), ""), "")
            '    strToBeInserted = "disabled"
            '    SQLQuey = "Exec usp_Sel_tbl_PM_CustomFields_Details  " & strControlName & ",0,1,'Help-Desk'"
            '    blnIsMandatory = False

            '    If InStr("," + strControlValidationRules.ToString.Trim, ",1,") <> 0 Then
            '        blnIsMandatory = True
            '    End If

            '    If Not IsNumeric(intControlMaxLength) Or intControlMaxLength = "0" Then
            '        intControlMaxLength = "100"
            '    ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
            '        If (intControlMaxLength > "3800") Then
            '            intControlMaxLength = "3800"
            '        End If
            '    Else
            '        If (intControlMaxLength > "100") Then
            '            intControlMaxLength = "100"
            '        End If
            '    End If


            '    If intControlWidth = "" Then
            '        intControlWidth = "130"
            '    End If

            '    'For Each drCustomField1 As DataRow In dsCustomField.Tables(0).Rows
            '    '    Flag = False

            '    '    For Each drRoleAccess As DataRow In dsRoleAccess.Tables(0).Rows
            '    '        If CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") = CommonFunction.Data.CheckIsDBNull(drRoleAccess("DatabaseFieldName"), "") Then
            '    '            strFieldAccess += CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") & "#" & CommonFunction.Data.CheckIsDBNull(drCustomField1("IsCustomFieldAssigned"), "0") & "#1" & ","
            '    '            Flag = True
            '    '        End If
            '    '    Next
            '    '    If Flag = False Then
            '    '        strFieldAccess += CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") & "#" & CommonFunction.Data.CheckIsDBNull(drCustomField1("IsCustomFieldAssigned"), "0") & "#0" & ","
            '    '    End If
            '    'Next

            '    Dim blnShowControl As Boolean = False
            '    Dim intCounter As Integer

            '    intCounter = 0
            '    'If length of array is greater than 0 that means security is explicitly set
            '    'In that case check if it is accessible ,if yes then show the control, 
            '    'otherwise show it as not applicable
            '    If intCount > 0 Then

            '        While intCounter < intCount
            '            'Check if the current Custom Field ID is in the array
            '            If strCustomFieldIDs(intCounter).ToLower.Trim = _
            '                        CType(CommonFunction.General.CheckIsNothing(drCustomField("UniqueId")), String).ToLower.Trim Then
            '                blnShowControl = True
            '                Exit While
            '            End If

            '            intCounter = intCounter + 1

            '        End While

            '    Else
            '    End If
            '    m_strCustomFieldList = m_strCustomFieldList + strControlName + ","

            '    If RequestID > 0 Then
            '        'If Not rsIssueDetails.EOF Then
            '        If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "") <> "" Then
            '            Dim strSQL As String = " Select " & drCustomField("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & RequestID
            '            strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
            '        Else
            '            strFieldValue = ""
            '        End If

            '        'End If
            '    Else
            '        strFieldValue = ""
            '    End If
            '    strControlValue = strFieldValue
            '    If drCustomField("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
            '        strCustomFieldTD.Append("<div class='row'>")
            '        strCustomFieldTD.Append("<div class='form-group'>")


            '        strCustomFieldTD.Append("<label class='col-sm-4' for='usr' style='margin-left:1%'>" + strControlCaption + "</label>")

            '        If InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then
            '            strCustomFieldTD.Append("  ")
            '            strCustomFieldTD.Append("<div class=''>" + CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, "class='form-control' " & strStyleDisabled & "", True, True) + "</div>")

            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf



            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
            '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "frmQuickTask", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , "false", "", , "disabled", False, blnIsMandatory, Wrap:="Soft") + "</td>")

            '            strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "form-control", , "frmAddNewRequest", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , , , , strStyleDisabled, True, , Wrap:="Soft", EnableHTMLEncode:=True) + "</div>")


            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf


            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then
            '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , strToBeInserted, True, blnIsMandatory) + "</td>")
            '            strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "form-control", intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , "class='form-control' " & strStyleDisabled & "", True, , EnableHTMLEncode:=True) + "</div>")
            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf


            '            '   ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
            '            'If strControlValue <> "" And strControlValue <> "0" Then
            '            '    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '            '    strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "' value='" & CommonFunctions.Dates.GetDate(CType(strControlValue, Date)) & "'  class='form-control clsdate' id='" & strControlName & "' placeholder=''>")
            '            '    strCustomFieldTD.Append("<i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")
            '            'Else
            '            '    ''strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '            '    strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "' value=''  class='form-control clsdate' id='" & strControlName & "' placeholder=''>")
            '            '    strCustomFieldTD.Append("<i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")
            '            'End If
            '            'declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf



            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
            '            If strControlValue <> "" And strControlValue <> "0" Then
            '                If strStatus = "2" Then
            '                    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                    'strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "'   class='form-control clsdate " & strStyleDisabled & " ' id='" & strControlName & "' placeholder=''>")
            '                    'strCustomFieldTD.Append("<i class='fa fa-calendar clsDateControl' id='" & strControlName & "' ></i></div>")
            '                    strCustomFieldTD.Append("<div class='col-sm-8' style='display:inline-flex'><div><input type='text' name='" & strControlName & "'   class='form-control clsdate " & strStyleDisabled & " ' id='" & strControlName & "' placeholder=''></div>")
            '                    strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' ></i></div>")
            '                Else
            '                    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                    strCustomFieldTD.Append("<div class='col-sm-8' style='display:inline-flex'><div><input type='text' name='" & strControlName & "' value='" & CommonFunctions.Dates.GetDate(CType(strControlValue, Date)) & "'  class='form-control clsdate' id='" & strControlName & "' placeholder=''></div>")
            '                    strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div></div>")
            '                End If
            '            Else
            '                ''strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                'If strStatus = "2" Then
            '                '    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                '    strCustomFieldTD.Append("<div class='col-sm-8' style='display:inline-flex'><input type='text' name='" & strControlName & "' value='" & CommonFunctions.Dates.GetDate(CType(strControlValue, Date)) & "'  class='form-control clsdate " & strStyleDisabled & " ' id='" & strControlName & "' placeholder=''></div>")
            '                '    strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' ></i></div>")
            '                'Else
            '                strCustomFieldTD.Append("<div class='col-sm-8' style='display:inline-flex'><input type='text' name='" & strControlName & "' value=''  class='form-control clsdate' id='" & strControlName & "' placeholder=''><div>")
            '                strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")
            '                'End If
            '                declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf

            '            End If
            '        End If

            '        If (strDataType = "1") Then
            '            If InStr(1, "," + strControlValidationRules, ",3,") = 0 Then
            '                strControlValidationRules = strControlValidationRules + "3,"
            '            End If
            '        End If
            '        strCustomFieldTD.Append("</div>")
            '        strCustomFieldTD.Append("</div>")
            '        objRequestDetails.GenerateValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrtemp)
            '    End If

            'End While

            'If m_strCustomFieldList <> "" Then
            '    m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
            'End If

            'strCustomFieldTD.Append(CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
            'strCustomFieldTD.Append(CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, , , , , True, True, , True, , , , , , EnableHTMLEncode:=True))


            'Dim StrHTMLGuidelines As New StringBuilder("")
            'Dim m_intCustomer As Integer = 0
            'Dim m_intRequestedEmployee As Integer = 0
            'Dim m_strMode As String = "NEW"
            'Dim dr As IDataReader
            'Dim strGuidelinesColumnName As String = ""
            'If UCase(Trim(m_strMode & "")) = "NEW" And Trim(SubRequestTypeID & "") <> "" And ((m_intCustomer = 0) Or (m_intRequestedEmployee <> 0)) And HttpContext.Current.Session("LoginType").ToString = "E" Then
            '    Dim IsApproval As String
            '    IsApproval = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_CRM_Function_RequestTypes_Approval " & DepartmentID & "," & RequestTypeID & "," & SubRequestTypeID, True), String)
            '    If IsApproval = "1" Then
            '        StrHTMLGuidelines.Append("<div >")
            '        StrHTMLGuidelines.Append("<label for='sel1' id='lblApprovalStatus'><font color=red>")
            '        StrHTMLGuidelines.Append("This request will require Approval Of Reporting To.")
            '        StrHTMLGuidelines.Append("</label>")
            '        StrHTMLGuidelines.Append("</div>")
            '    End If
            '    CommonFunction.Data.DisposeDataReader(dr)
            'End If


            'If Trim(SubRequestTypeID & "") <> "" Then
            '    dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & SubRequestTypeID, True)
            '    If dr.Read Then
            '        If Trim(dr("GuidelinesForRequestor").ToString & "") <> "" Then
            '            StrHTMLGuidelines.Append("<div class='row'>")
            '            StrHTMLGuidelines.Append("<div >")
            '            StrHTMLGuidelines.Append("<div class='col-sm-12'>")
            '            StrHTMLGuidelines.Append("<label for='sel1'>")
            '            StrHTMLGuidelines.Append(objRequestDetails.GetCaption(919, "GuidelinesForRequestor") & ":")
            '            StrHTMLGuidelines.Append("</label>")
            '            StrHTMLGuidelines.Append("<label for='sel1'>")
            '            StrHTMLGuidelines.Append(dr("GuidelinesForRequestor").ToString & "")
            '            StrHTMLGuidelines.Append("</label></div>")
            '            StrHTMLGuidelines.Append("</div>")
            '            StrHTMLGuidelines.Append("</div>")
            '        End If
            '    End If
            '    CommonFunction.Data.DisposeDataReader(dr)
            'End If




            ' ''Response.Write(strFieldAccess)

            ''Commented and Added by Usha Pandit on 15.01.2019 for Custom field selection 
            Dim strCustomFieldTD As String = ""
            Dim declarevariables As String = ""
            Dim strClientSideScript As String = ""
            Dim StrHTMLGuidelines As String = ""
            Return strCustomFieldTD.ToString + vbCrLf + " #### " + vbCrLf + declarevariables + vbCrLf + strClientSideScript + "####" + StrHTMLGuidelines.ToString

            'Dim strUserGivenCaption As String
            'Dim m_strTypeInaccessibleCustomFieldList As String
            'Dim strSQLQuery As String
            'Dim strSQLQueryStatus As String
            'Dim drCustomField As IDataReader
            'Dim objNewRequest As New CRM_RequestDetailsUncategorized()
            'Dim drStatus As IDataReader
            'Dim strStyleDisabled = ""
            'If SubRequestTypeID = "" Then
            '    SubRequestTypeID = 0
            'End If

            'If RequestTypeID = "" Then
            '    RequestTypeID = 0
            'End If
            'Dim strStatus As String = ""
            'drStatus = CommonFunction.Data.GetDataReader("usp_NG2_SEL_Status_tbl_CRM_Query_Master " & RequestID, True)
            'While drStatus.Read
            '    strStatus = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drStatus("StatusID"), ""), ""), String)

            'End While
            'CommonFunction.Data.DisposeDataReader(drStatus)
            'If strStatus = "2" Then
            '    strStyleDisabled = "disabled"
            'End If


            'Dim m_strPrimaryTable As String = "Tbl_CRM_Query_Master"
            'Dim m_strPrimaryKey As String = "QueryID"
            'Dim strFieldValue As String = ""
            'Dim strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted As String
            'Dim blnIsMandatory As Boolean
            'Dim intControlMaxLength As Integer
            'Dim intControlMinValue As Integer
            'Dim intControlMaxValue As Integer
            'Dim intControlHeight As Integer
            'Dim strControlCaption As String
            'Dim strControlValidationRules As String

            'Dim strDataType As String
            'Dim declarevariables As String
            'Dim m_strCustomFieldList As String

            ''Dim strCustomFieldTD As System.Text.StringBuilder
            'Dim strCustomFieldTD As StringBuilder = New StringBuilder()
            'Dim strControlValidations As New StringBuilder("")
            'Dim arrtemp(50) As String
            'Dim objRequestDetails As New CRM_RequestDetailsUncategorized()




            'Dim intCorporateRoleLevel As Integer
            'Dim strFieldAccess As String = ""
            'Dim dsRoleAccess As System.Data.DataSet
            'Dim dsCustomField As System.Data.DataSet
            'Dim m_lngProjectId As Integer = 0
            'Dim Flag As Boolean = False
            'Dim m_lngRoleId As Integer = 0
            ' '' Dim strClientSideScript As String = ""
            'strClientSideScript = ""
            'If Not m_lngRoleId > 0 Then
            '    m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
            'End If

            'Dim loginType As String = ""
            'If CustomerID <> 0 Then
            '    loginType = "C"
            'Else
            '    loginType = HttpContext.Current.Session("LoginType").ToString
            'End If
            'Dim drCustomAccess As IDataReader


            'strSQLQuery = "usp_sel_tbl_PM_RoleCustomFieldSecurity 0," & m_lngRoleId & "," & CType(HttpContext.Current.Session("intUserID"), Long) & ",'Help-Desk','" & loginType & "'"
            ''drRoleAccess = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            '' dsRoleAccess = CommonFunction.Data.GetDataSet(strSQLQuery, "CustomRoleAccess", , , True)

            'Dim strCustomFieldIDs() As String
            'Dim intCount As Integer = 0
            'drCustomAccess = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            'While drCustomAccess.Read
            '    ReDim Preserve strCustomFieldIDs(intCount)
            '    strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            '    intCount += 1
            'End While
            'CommonFunction.Data.DisposeDataReader(drCustomAccess)


            'Dim drLayout As IDataReader

            'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master 0,NULL,1,'" & SubRequestTypeID & "','Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & loginType & "'"
            ''drCustomField1 = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            'dsCustomField = CommonFunction.Data.GetDataSet(strSQLQuery, "CustomField", , , True)

            ''If strFieldAccess <> "" Then
            ''    strFieldAccess = strFieldAccess.Substring(0, strFieldAccess.Length - 1)
            ''End If




            'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master  0,NULL,1," & SubRequestTypeID & ",'Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & loginType & "'"
            'drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)


            'objRequestDetails.GetValidationRules()
            'objRequestDetails.arrValidationMessages.CopyTo(arrtemp, 0)

            'While drCustomField.Read
            '    strControlName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            '    intControlWidth = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlWidth"), ""), "")
            '    strControlCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("UserGivenCaption"), ""), "")
            '    strControlValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DefaultValue"), ""), "")
            '    'strToBeInserted = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            '    'blnIsMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            '    intControlMaxLength = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxLength"), "0"), "0")
            '    intControlHeight = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlHeight"), "0"), "0")

            '    intControlMinValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MinValue"), "0"), "0")
            '    intControlMaxValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxValue"), "0"), "0")
            '    strDataType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DataType"), "0"), "0")

            '    strControlValidationRules = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ValidationRules"), ""), "")
            '    strToBeInserted = "disabled"
            '    SQLQuey = "Exec usp_Sel_tbl_PM_CustomFields_Details  " & strControlName & ",0,1,'Help-Desk'"
            '    blnIsMandatory = False

            '    If InStr("," + strControlValidationRules.ToString.Trim, ",1,") <> 0 Then
            '        blnIsMandatory = True
            '    End If

            '    If Not IsNumeric(intControlMaxLength) Or intControlMaxLength = "0" Then
            '        intControlMaxLength = "100"
            '    ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
            '        If (intControlMaxLength > "3800") Then
            '            intControlMaxLength = "3800"
            '        End If
            '    Else
            '        If (intControlMaxLength > "100") Then
            '            intControlMaxLength = "100"
            '        End If
            '    End If


            '    If intControlWidth = "" Then
            '        intControlWidth = "130"
            '    End If

            '    'For Each drCustomField1 As DataRow In dsCustomField.Tables(0).Rows
            '    '    Flag = False

            '    '    For Each drRoleAccess As DataRow In dsRoleAccess.Tables(0).Rows
            '    '        If CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") = CommonFunction.Data.CheckIsDBNull(drRoleAccess("DatabaseFieldName"), "") Then
            '    '            strFieldAccess += CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") & "#" & CommonFunction.Data.CheckIsDBNull(drCustomField1("IsCustomFieldAssigned"), "0") & "#1" & ","
            '    '            Flag = True
            '    '        End If
            '    '    Next
            '    '    If Flag = False Then
            '    '        strFieldAccess += CommonFunction.Data.CheckIsDBNull(drCustomField1("DatabaseFieldName"), "") & "#" & CommonFunction.Data.CheckIsDBNull(drCustomField1("IsCustomFieldAssigned"), "0") & "#0" & ","
            '    '    End If
            '    'Next

            '    Dim blnShowControl As Boolean = False
            '    Dim intCounter As Integer

            '    intCounter = 0
            '    'If length of array is greater than 0 that means security is explicitly set
            '    'In that case check if it is accessible ,if yes then show the control, 
            '    'otherwise show it as not applicable
            '    If intCount > 0 Then

            '        While intCounter < intCount
            '            'Check if the current Custom Field ID is in the array
            '            If strCustomFieldIDs(intCounter).ToLower.Trim = _
            '                        CType(CommonFunction.General.CheckIsNothing(drCustomField("UniqueId")), String).ToLower.Trim Then
            '                blnShowControl = True
            '                Exit While
            '            End If

            '            intCounter = intCounter + 1

            '        End While

            '    Else
            '    End If
            '    m_strCustomFieldList = m_strCustomFieldList + strControlName + ","

            '    If RequestID > 0 Then
            '        'If Not rsIssueDetails.EOF Then
            '        If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "") <> "" Then
            '            Dim strSQL As String = " Select " & drCustomField("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & RequestID
            '            strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
            '        Else
            '            strFieldValue = ""
            '        End If


            '        'End If
            '    Else
            '        strFieldValue = ""
            '    End If

            '    'Added by Usha Pandit on 30 July 2018 for Custom Field Default value display
            '    If strFieldValue <> "" Then
            '        'End of Added by Usha Pandit on 30 July 2018 for Custom Field Default value display
            '        strControlValue = strFieldValue

            '        'Added by Usha Pandit on 30 July 2018 for Custom Field Default value display
            '    End If
            '    'End of Added by Usha Pandit on 30 July 2018 for Custom Field Default value display

            '    If drCustomField("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then

            '        strCustomFieldTD.Append("</div>")           'Added by Usha Pandit on 29 JAN 2018 for Custom Field UI Alignment

            '        strCustomFieldTD.Append("<div class=''>")

            '        'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
            '        'strCustomFieldTD.Append("<div class='col-sm-6'>")
            '        If InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
            '            strCustomFieldTD.Append("<div class='col-sm-8'>")
            '        Else
            '            If CInt(intControlWidth) < 150 Then
            '                strCustomFieldTD.Append("<div class='col-sm-6'>")
            '            Else
            '                strCustomFieldTD.Append("<div class='col-sm-8'>")
            '            End If
            '        End If


            '        'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue

            '        'Added by Usha Pandit on 29 JAN 2018 for Custom Field UI Alignment
            '        'strCustomFieldTD.Append("<label class='col-sm-4' for='usr' style='margin-left:1%'>" + strControlCaption + "</label>")

            '        'Commented and Added by Usha Pandit on 30 July 2018 for Long text Custom Field wrap
            '        'strCustomFieldTD.Append("<label class='control-label' for='usr' style='margin-left:1%'>" + strControlCaption + "</label>")
            '        If blnIsMandatory = True Then
            '            'Commented and Added by Usha Pandit on 08 Jan 2019 for Custom Field alignment issue
            '            'strCustomFieldTD.Append("<label class='control-label' for='usr' style='margin-left:1%;word-break: break-all;'>" + strControlCaption + " * </label>")
            '            strCustomFieldTD.Append("<label class='control-label' for='usr' style='word-break: break-all;'>" + strControlCaption + " * </label>")
            '            'End of Added by Usha Pandit on 08 Jan 2019 for Custom Field alignment issue
            '        Else
            '            'Commented and Added by Usha Pandit on 08 Jan 2019 for Custom Field alignment issue
            '            'strCustomFieldTD.Append("<label class='control-label' for='usr' style='margin-left:1%;word-break: break-all;'>" + strControlCaption + "</label>")
            '            strCustomFieldTD.Append("<label class='control-label' for='usr' style='word-break: break-all;'>" + strControlCaption + "</label>")
            '            'End of Added by Usha Pandit on 08 Jan 2019 for Custom Field alignment issue
            '        End If

            '        'End of Added by Usha Pandit on 30 July 2018 for Long text Custom Field wrap

            '        'End of Added by Usha Pandit on 29 JAN 2018 for Custom Field UI Alignment


            '        If InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then
            '            strCustomFieldTD.Append("  ")

            '            'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
            '            'strCustomFieldTD.Append("<div class='col-sm-12'>" + CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, "class='form-control' " & strStyleDisabled & "", True, True) + "</div>")
            '            strCustomFieldTD.Append(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, "class='form-control' " & strStyleDisabled & " height = '" & intControlHeight & "'", True, True))
            '            'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue


            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf



            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
            '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "frmQuickTask", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , "false", "", , "disabled", False, blnIsMandatory, Wrap:="Soft") + "</td>")

            '            'Commented and Added By Usha Pandit on 26 july 2018 for correct path of zoomin image and form name passed was wrong because current form name is divrequestDetails
            '            'strCustomFieldTD.Append("<div class='col-sm-12'>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "form-control", "opentextdialog", "frmAddNewRequest", "../../Images/zoomin.gif", , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , , , , strStyleDisabled, True, , Wrap:="Soft", EnableHTMLEncode:=True) + "</div>")
            '            strCustomFieldTD.Append("<div class='col-sm-12'>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "form-control", "opentextdialog", "divrequestDetails", "../../../Images/zoomin.gif", , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , , , , strStyleDisabled & " " & " maxlength = " & CStr(intControlMaxLength), True, , Wrap:="Soft", EnableHTMLEncode:=True) + "</div>")
            '            'End of Added By Usha Pandit on 26 july 2018 for correct path of zoomin image

            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf


            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then
            '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , strToBeInserted, True, blnIsMandatory) + "</td>")

            '            'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
            '            'strCustomFieldTD.Append("<div class='col-sm-12'>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "form-control", intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , "class='form-control' " & strStyleDisabled & "", True, , EnableHTMLEncode:=True) + "</div>")
            '            strCustomFieldTD.Append(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "clsCustomField", intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , "class='clsCustomField' " & strStyleDisabled & "", True, , EnableHTMLEncode:=True))
            '            'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue


            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf


            '            '   ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
            '            'If strControlValue <> "" And strControlValue <> "0" Then
            '            '    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '            '    strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "' value='" & CommonFunctions.Dates.GetDate(CType(strControlValue, Date)) & "'  class='form-control clsdate' id='" & strControlName & "' placeholder=''>")
            '            '    strCustomFieldTD.Append("<i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")
            '            'Else
            '            '    ''strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '            '    strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "' value=''  class='form-control clsdate' id='" & strControlName & "' placeholder=''>")
            '            '    strCustomFieldTD.Append("<i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")
            '            'End If
            '            'declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf

            '            'Added by Usha Pandit on 27 July 2018 for getting CustomfieldNumeric details
            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then
            '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , strToBeInserted, True, blnIsMandatory) + "</td>")
            '            If strControlValue = "0" Then
            '                strCustomFieldTD.Append("<div class='col-sm-12'>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "form-control", intControlWidth, intControlMaxLength, "", , , , False, "", , "class='form-control' " & strStyleDisabled & "", True, , EnableHTMLEncode:=True) + "</div>")
            '            Else
            '                strCustomFieldTD.Append("<div class='col-sm-12'>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "form-control", intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , "class='form-control' " & strStyleDisabled & "", True, , EnableHTMLEncode:=True) + "</div>")
            '            End If


            '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf
            '            'End of Added by Usha Pandit on 27 July 2018 for getting CustomfieldNumeric details

            '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
            '            If strControlValue <> "" And strControlValue <> "0" Then
            '                If strStatus = "2" Then
            '                    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                    'strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "'   class='form-control clsdate " & strStyleDisabled & " ' id='" & strControlName & "' placeholder=''>")
            '                    'strCustomFieldTD.Append("<i class='fa fa-calendar clsDateControl' id='" & strControlName & "' ></i></div>")
            '                    strCustomFieldTD.Append("<div class='col-sm-12' style='display:inline-flex'><div><input type='text' name='" & strControlName & "'   class='form-control clsdate " & strStyleDisabled & " ' id='" & strControlName & "' placeholder=''></div>")
            '                    strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' ></i></div>")
            '                Else
            '                    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                    strCustomFieldTD.Append("<div class='col-sm-12' style='display:inline-flex'><div><input type='text' name='" & strControlName & "' value='" & CType(strControlValue, Date) & "'  class='form-control clsdate' id='" & strControlName & "' placeholder=''></div>")
            '                    strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div></div>")
            '                End If
            '            Else
            '                ''strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                'If strStatus = "2" Then
            '                '    ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
            '                '    strCustomFieldTD.Append("<div class='col-sm-8' style='display:inline-flex'><input type='text' name='" & strControlName & "' value='" & CommonFunctions.Dates.GetDate(CType(strControlValue, Date)) & "'  class='form-control clsdate " & strStyleDisabled & " ' id='" & strControlName & "' placeholder=''></div>")
            '                '    strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' ></i></div>")
            '                'Else


            '                strCustomFieldTD.Append("<div class='col-sm-12' style='display:inline-flex'><input type='text' name='" & strControlName & "' value=''  class='form-control clsdate' id='" & strControlName & "' placeholder=''><div>")
            '                strCustomFieldTD.Append("<div><i class='fa fa-calendar clsDateControl' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")

            '                'End If
            '                declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf

            '            End If
            '        End If

            '        If (strDataType = "1") Then
            '            If InStr(1, "," + strControlValidationRules, ",3,") = 0 Then
            '                strControlValidationRules = strControlValidationRules + "3,"
            '            End If
            '        End If
            '        strCustomFieldTD.Append("</div>")
            '        strCustomFieldTD.Append("</div>")
            '        objRequestDetails.GenerateValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrtemp)
            '    End If

            'End While

            'If m_strCustomFieldList <> "" Then
            '    m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
            'End If

            'strCustomFieldTD.Append(CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
            'strCustomFieldTD.Append(CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, , , , , True, True, , True, , , , , , EnableHTMLEncode:=True))


            'Dim StrHTMLGuidelines As New StringBuilder("")
            'Dim m_intCustomer As Integer = 0
            'Dim m_intRequestedEmployee As Integer = 0
            'Dim m_strMode As String = "NEW"
            'Dim dr As IDataReader
            'Dim strGuidelinesColumnName As String = ""
            'If UCase(Trim(m_strMode & "")) = "NEW" And Trim(SubRequestTypeID & "") <> "" And ((m_intCustomer = 0) Or (m_intRequestedEmployee <> 0)) And HttpContext.Current.Session("LoginType").ToString = "E" Then
            '    Dim IsApproval As String
            '    IsApproval = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_CRM_Function_RequestTypes_Approval " & DepartmentID & "," & RequestTypeID & "," & SubRequestTypeID, True), String)
            '    If IsApproval = "1" Then
            '        StrHTMLGuidelines.Append("<div >")
            '        StrHTMLGuidelines.Append("<label for='sel1' id='lblApprovalStatus'><font color=red>")
            '        StrHTMLGuidelines.Append("This request will require Approval Of Reporting To.")
            '        StrHTMLGuidelines.Append("</label>")
            '        StrHTMLGuidelines.Append("</div>")
            '    End If
            '    CommonFunction.Data.DisposeDataReader(dr)
            'End If


            'If Trim(SubRequestTypeID & "") <> "" Then
            '    dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & SubRequestTypeID, True)
            '    If dr.Read Then
            '        If Trim(dr("GuidelinesForRequestor").ToString & "") <> "" Then
            '            StrHTMLGuidelines.Append("<div class='row'>")
            '            StrHTMLGuidelines.Append("<div >")
            '            StrHTMLGuidelines.Append("<div class='col-sm-12'>")
            '            StrHTMLGuidelines.Append("<label for='sel1'>")
            '            StrHTMLGuidelines.Append(objRequestDetails.GetCaption(919, "GuidelinesForRequestor") & ":")
            '            StrHTMLGuidelines.Append("</label>")
            '            StrHTMLGuidelines.Append("<label for='sel1'>")
            '            StrHTMLGuidelines.Append(dr("GuidelinesForRequestor").ToString & "")
            '            StrHTMLGuidelines.Append("</label></div>")
            '            StrHTMLGuidelines.Append("</div>")
            '            StrHTMLGuidelines.Append("</div>")
            '        End If
            '    End If
            '    CommonFunction.Data.DisposeDataReader(dr)
            'End If




            ' ''Response.Write(strFieldAccess)

            ''Commented and Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically
            ''Return strCustomFieldTD.ToString + vbCrLf + " #### " + vbCrLf + declarevariables + vbCrLf + strClientSideScript + "####" + StrHTMLGuidelines.ToString
            'Return strCustomFieldTD.ToString + vbCrLf + " #### " + vbCrLf + "<script type='text/javascript'> function ValidateCustomFields(){ " + declarevariables + vbCrLf + strClientSideScript + " return true;  } </script>" + "####" + StrHTMLGuidelines.ToString
            ''End of Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically

            ''End of Added by Usha Pandit on 15.01.2019 for Custom field selection 
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Private Function GetCaption(ByVal TagID As Long, ByVal ControlName As String) As String
        '=====================================================================
        ' Procedure Name        : GetCaption
        ' Description           : gets the caption for the control & tagid
        ' Purpose               : same as above
        ' Parameters Passed     : control name
        ' Returns               : the caption for the control name
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : usp_CRM_Get_Tag_Attribute_Caption
        ' Author                : Rajanikant
        ' Created               : Feb 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Tag_Attribute_Caption  " & TagID & ",'" & CommonFunctions.General.BuildQueryString(ControlName) & "'", True)
        If dr.Read Then
            ' the caption returned by the sp
            GetCaption = dr("ControlCaption").ToString
        Else
            ' send the same name back
            GetCaption = ControlName
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
    Public Sub GenerateValidationScript(ByVal strControlValidationRules As String, ByVal strControlName1 As String, ByVal strControlCaption As String, ByVal intControlMinValue As String, ByVal intControlMaxValue As String, ByVal intControlMaxLength As Integer, ByRef strControlValidations As StringBuilder, ByVal arrValidations() As String)
        '==================================================================================
        ' Procedure Name		:	GenerateValidationScript
        ' Parameters Passed		:	arrCtlAttr : This array contains all the attributes of the control to be drawn.
        '							arrValidationMessages : The array containing the validation messages.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	arrCtlAttr [if the Not blank validation rule is set, then the Show As Mandatofy flag is set.]
        ' Purpose				:	To generate the client side validation script depending on the validation rules set for that control.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================

        Dim strValidation As String = ""
        Dim intCtr As Integer = 0
        Dim arrRules As String()
        Dim intValidationID As Integer
        Dim strCaption As String
        '   Dim strClientSideScript As String
        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(strControlValidationRules, ",")
        strCaption = strControlCaption
        If InStr(strControlName1, "Keywords") <> 0 Then
            Exit Sub
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = arrValidationMessages(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
                'End If
            Else
                intValidationID = 0
            End If

            Dim blnLoopcheck As Boolean = False
            Dim strControlName As String = strControlName1
            Dim strMinValue As String = intControlMinValue
            Dim strMaxValue As String = intControlMaxValue
            If (CType(intValidationID, String) <> "" And CType(intValidationID, String) <> "0") Then
                strValidation = strValidation + "if(obj" + strControlName + " != null) " + vbCrLf
                strValidation = strValidation + "{ " + vbCrLf
            End If

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ")== true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(1), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " return;" + vbCrLf
                    'arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    If InStr(strControlCaption, "'") > 0 Then
                        ''  strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                        strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf
                        strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + " ', 'error');" + vbCrLf
                        strValidation = strValidation + "       return;" + vbCrLf
                    Else
                        ' strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                        strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf
                        strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + "', 'error');" + vbCrLf
                        strValidation = strValidation + "       return;" + vbCrLf
                    End If

                    strValidation = strValidation + "       if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    '  'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    'End If

                    strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    strValidation = strValidation + "   }}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(3), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(9), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(intControlMaxLength) <> "" And Trim(intControlMaxLength) <> "0" Then
                        '  strValidation = strValidation + "   if(disallowMaxlengthViolation(obj" + strControlName + "," + CType(intControlMaxLength, String) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", intControlMaxLength), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "       if(disallowMaxlengthViolation(obj" + strControlName + ")==true){" + vbCrLf
                        strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(12), False) + "', 'error');" + vbCrLf
                        strValidation = strValidation + "       return;" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + CType(intControlMaxLength, String) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.	
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNegativeNumeric(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(13), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    '     strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(15), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + "))==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(16), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    '  strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + "))==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(17), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + "))==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(18), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                'End If
                strValidation = strValidation + "	        setFocus(obj" + strControlName + ");" + vbCrLf
                strValidation = strValidation + "           return false;" + vbCrLf
                strValidation = strValidation + "       }" + vbCrLf
                strValidation = strValidation + "   } " + vbCrLf
                strValidation = strValidation + "} " + vbCrLf
            End If
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
        '    strClientSideScript = strClientSideScript + strValidation
        'Else
        If UCase(strControlName1) = "SUMMARY" Or UCase(strControlName1) = "REPORTEDBY" Or UCase(strControlName1) = "DESCRIPTION" Then
            strClientSideScript = strClientSideScript + strValidation
        Else
            strClientSideScript = strClientSideScript + strValidation
        End If

    End Sub
    'Public Sub GenerateValidationScript(ByVal strControlValidationRules As String, ByVal strControlName1 As String, ByVal strControlCaption As String, ByVal intControlMinValue As String, ByVal intControlMaxValue As String, ByVal intControlMaxLength As Integer, ByRef strControlValidations As StringBuilder, ByVal arrValidations() As String)
    '    '==================================================================================
    '    ' Procedure Name		:	GenerateValidationScript
    '    ' Parameters Passed		:	arrCtlAttr : This array contains all the attributes of the control to be drawn.
    '    '							arrValidationMessages : The array containing the validation messages.
    '    ' Returns				:	No Return Value
    '    ' Parameters Affected	:	arrCtlAttr [if the Not blank validation rule is set, then the Show As Mandatofy flag is set.]
    '    ' Purpose				:	To generate the client side validation script depending on the validation rules set for that control.
    '    ' Description			:	Same as above.
    '    ' Assumptions			:	
    '    ' Dependencies			:	None
    '    ' Author				:	SandipL
    '    ' Created				:	20 Jan 2006
    '    ' Revisions				:	
    '    '==================================================================================

    '    Dim strValidation As String = ""
    '    Dim intCtr As Integer = 0
    '    Dim arrRules As String()
    '    Dim intValidationID As Integer
    '    Dim strCaption As String
    '    '   Dim strClientSideScript As String
    '    ' Get the validation rule IDs in an array.
    '    strValidation = ""

    '    arrRules = Split(strControlValidationRules, ",")
    '    strCaption = strControlCaption
    '    If InStr(strControlName1, "Keywords") <> 0 Then
    '        Exit Sub
    '    End If

    '    ' For each validation rule to be applied, generate the client side validation script.
    '    For intCtr = LBound(arrRules) To UBound(arrRules)
    '        If arrRules(intCtr) <> "" Then
    '            intValidationID = CType(arrRules(intCtr), Integer)
    '            'If IsNumeric(intValidationID) Then
    '            intValidationID = CInt(intValidationID)
    '            arrValidations(intValidationID) = arrValidationMessages(intValidationID)
    '            arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
    '            'End If
    '        Else
    '            intValidationID = 0
    '        End If

    '        Dim blnLoopcheck As Boolean = False
    '        Dim strControlName As String = strControlName1
    '        Dim strMinValue As String = intControlMinValue
    '        Dim strMaxValue As String = intControlMaxValue
    '        If (CType(intValidationID, String) <> "" And CType(intValidationID, String) <> "0") Then
    '            strValidation = strValidation + "if(obj" + strControlName + " != null) " + vbCrLf
    '            strValidation = strValidation + "{ " + vbCrLf
    '        End If

    '        Select Case intValidationID.ToString

    '            Case "1" ' Not Blank.														
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                ' strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
    '                strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ")==true){" + vbCrLf
    '                strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
    '                strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(1), False) + " should not be left blank', 'error');" + vbCrLf
    '                '  strValidation = strValidation + " return;" + vbCrLf
    '                'arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
    '                blnLoopcheck = True
    '            Case "2" ' Valid Date.				
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                If InStr(strControlCaption, "'") > 0 Then
    '                    strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
    '                Else
    '                    strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
    '                End If

    '                strValidation = strValidation + "       if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
    '                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
    '                '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
    '                'End If
    '                strValidation = strValidation + "       return;" + vbCrLf
    '                strValidation = strValidation + "   }}}" + vbCrLf

    '            Case "3" ' Numeric Data.
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True
    '            Case "9" ' Only Alphabets.
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True
    '            Case "12" ' Max Length
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
    '                If Trim(intControlMaxLength) <> "" And Trim(intControlMaxLength) <> "0" Then
    '                    strValidation = strValidation + "   if(disallowMaxlengthViolation(obj" + strControlName + "," + CType(intControlMaxLength, String) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", intControlMaxLength), False) + "',false)){" + vbCrLf
    '                    strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + CType(intControlMaxLength, String) + ");" + vbCrLf
    '                    blnLoopcheck = True
    '                End If

    '                'End If

    '            Case "13" ' Positive Numeric Data.	
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True
    '            Case "14" ' Check Duplication.
    '                ' Not Processed !!

    '            Case "15" ' Restrict Special characters.
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True

    '            Case "16" ' Minimum Value Check.
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True

    '            Case "17" ' Maximum Value Check.
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True
    '            Case "18" ' Value Range.
    '                strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
    '                strValidation = strValidation + "   { " + vbCrLf
    '                strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
    '                blnLoopcheck = True

    '            Case Else
    '        End Select
    '        If blnLoopcheck = True Then

    '            'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
    '            '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
    '            'End If
    '            strValidation = strValidation + "	        setFocus(obj" + strControlName + ");" + vbCrLf
    '            strValidation = strValidation + "           return false;" + vbCrLf
    '            strValidation = strValidation + "       }" + vbCrLf
    '            strValidation = strValidation + "   } " + vbCrLf
    '            strValidation = strValidation + "} " + vbCrLf
    '        End If
    '    Next

    '    ' if the control is editable, only then apply the validation rules.
    '    If Right(strValidation, 2) = ";;" Then
    '        strValidation = Left(strValidation, Len(strValidation) - 1)
    '    End If
    '    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
    '    '    strClientSideScript = strClientSideScript + strValidation
    '    'Else
    '    If UCase(strControlName1) = "SUMMARY" Or UCase(strControlName1) = "REPORTEDBY" Or UCase(strControlName1) = "DESCRIPTION" Then
    '        strClientSideScript = strClientSideScript + strValidation
    '    Else
    '        strClientSideScript = strClientSideScript + strValidation
    '    End If

    'End Sub
    Private Sub GetValidationRules()
        '==================================================================================
        ' Procedure Name		:	GetValidationRules
        ' Parameters Passed		:	To get all the validation messages in an array
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim drValidationRules As IDataReader

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        ' Retrieve all the validation messages.
        '  drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
        drValidationRules = CommonFunction.Data.GetDataReader("usp_SEL_tbl_UI_Validation ", MyBase.UseSQL)

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'Save all these validation messages in array
        Do While drValidationRules.Read
            arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
        Loop

        'Dispose data reader
        CommonFunction.Data.DisposeDataReader(drValidationRules)
    End Sub 'Get all validation rules and generate array

    ''End Of Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes-Plotting Custom Field

    'Function SaveRequestDetails()
    '    Dim ApprovalStatusForEmail As String
    '    Dim strSQL As String = ""
    '    Dim blnShowPopup As Boolean
    '    Dim blnSendMail As Boolean
    '    Dim strFromEmailID As String
    '    Dim strToMailID As String
    '    Dim strCCToMailID As String
    '    Dim strSubject, strMessage As String

    '    Dim lngPrevAssignTo As Long
    '    Dim strPrevStatus As String
    '    Dim dtmPrevDate As Date
    '    Dim lngCurrAssignTo As Long
    '    Dim strCurrStatus As String
    '    Dim dtmCurrDate As Date
    '    Dim strTargetLoc As String = ""
    '    dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
    '    If dr.Read Then
    '        ApprovalStatusForEmail = dr("ApprovalStatus").ToString()
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(dr)

    '    Dim strPrevDate As String = ""
    '    Dim strPrevTargetLoc As String = ""
    '    lngPrevAssignTo = CType(Request.Form("cboAssignToOld"), Long)


    '    'modified by SachinR    on 15 Dec 2005
    '    If Request.Form("txtResolutionDateOld") <> "" Then
    '        strPrevDate = Request.Form("txtResolutionDateOld") + ""
    '        dtmPrevDate = CType(Request.Form("txtResolutionDateOld"), Date)
    '    End If
    '    dtmCurrDate = dtmPrevDate


    '    If Request.Form("CboLocation") <> "" Then
    '        strTargetLoc = Request.Form("CboLocation") + ""
    '    End If


    '    strPrevStatus = Request.Form("cboStatusOld")


    '    ' update
    '    strSQL = " Exec usp_CRM_Update_RequestDetails "
    '    strSQL += m_lngQueryID & ","
    '    strSQL += Request.Form("CboDepartment") & ","


    '    If CommonFunction.Application.SplitRequestTypeSubType = True Then
    '        strSQL += "'" & Request.Form("CboSubRequestType") & "|" & Request.Form("CboRequestType") & "',"
    '    Else
    '        strSQL += "'" & Request.Form("CboSubRequestType") & "',"
    '    End If

    '    strSQL += "'" & Request.Form("txtSubject") & "',"
    '    strSQL += "'" & Request.Form("txtDescription") & "',"
    '    If Trim(Request.Form("cboPriority") & "") = "" Then
    '        strSQL += "NULL,"
    '    Else
    '        strSQL += Request.Form("cboPriority") & ","
    '    End If

    '    If m_strLoginType <> "E" Then
    '        If strPrevDate <> "" Then
    '            strSQL += "'" + strPrevDate + "',"
    '        Else
    '            strSQL += "NULL,"

    '        End If
    '    Else
    '        If Trim(Request.Form("txtResolutionDate") & "") <> "" Then
    '            strSQL += "'" & Request.Form("txtResolutionDate") & "',"
    '        Else
    '            strSQL += "Null,"
    '        End If
    '    End If

    '    If Trim(Request.Form("hidtxtAssignTo") & "") = "" Then
    '        strSQL += "NULL,"
    '    Else
    '        strSQL += Request.Form("hidtxtAssignTo") & ","
    '    End If

    '    strSQL += Request.Form("cboStatus") & ","


    '    If m_strLoginType <> "E" Then
    '        If strPrevTargetLoc = "" Then

    '            If Trim(Request.Form("cboTargetLocation") & "") <> "" Then
    '                strSQL += Request.Form("cboTargetLocation") & ","
    '            Else
    '                strSQL += "Null,"
    '            End If

    '        Else
    '            strSQL += strPrevTargetLoc + ","
    '        End If
    '    Else
    '        If Trim(Request.Form("cboTargetLocation") & "") <> "" Then
    '            strSQL += Request.Form("cboTargetLocation") & ","
    '        Else
    '            strSQL += "Null,"
    '        End If
    '    End If


    '    If Trim(Request.Form("txtCRMResolutionDate") & "") <> "" Then
    '        strSQL += "'" & Request.Form("txtCRMResolutionDate") & "'"
    '    Else
    '        strSQL += "Null"
    '    End If
    '    If Trim(Request.Form("txtComments") & "") <> "" Then
    '        strSQL += ",'" & Request.Form("txtComments") & "'"
    '    Else
    '        strSQL += ",Null"
    '    End If

    '    If Trim(Request.Form("cboFeedback") & "") <> "" Then
    '        strSQL += "," & Request.Form("cboFeedback")
    '    Else
    '        strSQL += ",Null"
    '    End If
    '    If Trim(Request.Form("txtFeedbackComments") & "") <> "" Then
    '        strSQL += ",'" & Request.Form("txtFeedbackComments") & "'"
    '    Else
    '        strSQL += ",Null"
    '    End If

    '    strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"

    '    If Trim(Request.Form("DeliverableID") & "") <> "" Then
    '        strSQL += "," & Request.Form("DeliverableID")
    '    Else
    '        strSQL += ",Null"
    '    End If

    '    If Trim(Request.Form("txtchangedDate") & "") = "" Then
    '        strSQL += ",NULL"
    '    Else
    '        strSQL += ",'" & Request.Form("txtchangedDate") & "'"
    '    End If
    '    If Trim(Request.Form("txtchangedTime") & "") = "" Then
    '        strSQL += ",NULL"
    '    Else
    '        strSQL += ",'" & Request.Form("txtchangedTime") & "'"
    '    End If
    '    'to pass Project,product,component details to updation sp..
    '    If Trim(Request.Form("cboProject") & "") <> "" Then
    '        strSQL += "," & Request.Form("cboProject")
    '    Else
    '        strSQL += ",Null"
    '    End If
    '    If Trim(Request.Form("cboProduct") & "") <> "" Then
    '        strSQL += "," & Request.Form("cboProduct")
    '    Else
    '        strSQL += ",Null"
    '    End If
    '    If Trim(Request.Form("cboModule") & "") <> "" Then
    '        strSQL += "," & Request.Form("cboModule")
    '    Else
    '        strSQL += ",Null"
    '    End If

    '    If Trim(Request.Form("cboSeverity") & "") <> "" Then
    '        strSQL += "," + Request.Form("cboSeverity").ToString
    '    Else
    '        strSQL += ",NULL"
    '    End If

    '    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)


    '    If CommonFunction.General.CheckIsNothing(Request.Form("hidtxtAssignTo"), "") <> "" Then
    '        lngCurrAssignTo = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidtxtAssignTo"), "0"), Long)
    '    Else
    '        lngCurrAssignTo = 0
    '    End If


    '    If m_strLoginType = "E" Then
    '        If Request.Form("txtResolutionDate") <> "" Then
    '            dtmCurrDate = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtResolutionDate"), Date.Now.ToString), Date)
    '        End If
    '    End If

    '    strCurrStatus = CommonFunction.General.CheckIsNothing(Request.Form("cboStatus"), "")


    '    ' Assign To change mail
    '    If lngCurrAssignTo <> 0 And lngCurrAssignTo <> lngPrevAssignTo Then
    '        blnSendMail = False : blnShowPopup = False
    '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", m_blnUseSQL)
    '        If dr.Read Then
    '            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(dr)

    '        If blnSendMail Then
    '            If blnShowPopup Then
    '                With Response
    '                    .Write("<script language=javascript>")
    '                    .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=0&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
    '                    .Write("</script>")
    '                End With
    '            Else
    '                ' silent mail
    '                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID.ToString, False)
    '                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
    '            End If
    '        End If
    '    End If

    '    ' Status change mail
    '    If Trim(strCurrStatus & "") <> "" And Trim(strPrevStatus & "") <> Trim(strCurrStatus & "") Then
    '        blnSendMail = False : blnShowPopup = False
    '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 44", m_blnUseSQL)
    '        If dr.Read Then
    '            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(dr)

    '        If blnSendMail Then
    '            If blnShowPopup Then
    '                With Response
    '                    .Write("<script language=javascript>")
    '                    .Write("window.open (""../General/SendEmail.aspx?MessageID=44&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
    '                    .Write("</script>")
    '                End With
    '            Else
    '                ' silent mail
    '                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
    '                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
    '            End If
    '        End If
    '    End If

    '    ' Expected Resolved date change mail
    '    If dtmCurrDate <> dtmPrevDate Then
    '        blnSendMail = False : blnShowPopup = False
    '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 45", m_blnUseSQL)
    '        If dr.Read Then
    '            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(dr)

    '        If blnSendMail Then
    '            If blnShowPopup Then
    '                With Response
    '                    .Write("<script language=javascript>")
    '                    .Write("window.open (""../General/SendEmail.aspx?MessageID=45&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" +(window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
    '                    .Write("</script>")
    '                End With
    '            Else
    '                ' silent mail
    '                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID, "")
    '                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
    '            End If
    '        End If

    '    End If


    '    'Purpose : When the request is been rejected then again the mail should be fired.

    '    blnSendMail = False : blnShowPopup = False
    '    If strCurrStatus <> "2" Then


    '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", m_blnUseSQL)

    '        If dr.Read Then
    '            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
    '            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(dr)
    '        If RTrim(LTrim(ApprovalStatusForEmail)) = "R" Then
    '            If blnSendMail Then
    '                If blnShowPopup Then
    '                    With Response
    '                        .Write("<script language=javascript>")
    '                        .Write("window.open (""../General/SendEmail.aspx?MessageID=544&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
    '                        .Write("</script>")
    '                    End With
    '                Else
    '                    ' silent mail
    '                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_544(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID, "")
    '                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
    '                End If
    '            End If
    '        End If
    '    End If
    'End Function

    <System.Web.Services.WebMethod>
    Public Shared Function SaveRequestDetails(ByVal SaveRequestDetialsData As Object) As String
        Try
            Dim RequestID As String = SaveRequestDetialsData(0)("RequestID")
            Dim blnShowPopup As Boolean
            Dim blnSendMail As Boolean
            Dim strFromEmailID As String
            Dim strToMailID As String
            Dim strCCToMailID As String
            Dim strSubject, strMessage As String
            Dim objCRM_AddNewRequest As New CRM_RequestDetailsUncategorized
            Dim strHTML As New StringBuilder
            Dim drProductCombo As IDataReader
            Dim ShowProductCombo As String
            Dim Subject As String
            Dim Description As String
            Dim Department As String
            Dim RequestType As String
            Dim SubRequestType As String
            Dim Priority As String
            Dim Product As String
            Dim ModuleComponent As String
            Dim Location As String
            Dim TimeZone As String
            Dim ExpResoulDate As String

            Dim CustomerID As String
            Dim EmployeeID As String
            Dim Status As String
            Dim cboStatusOld As String
            Dim Project As String
            Dim AssignTo As String
            Dim objCustomField As String
            Dim CustomFieldValue As String
            Dim cboAssignToOld As String
            Dim txtResolutionDateOld As String
            Dim hidtxtAssignTo As String
            Dim DeliverableID As String
            Dim StatusChangedate As String
            Dim StatusChangeTime As String
            Dim Keywords As String
            Dim CboSeverity As String
            Dim FeedbackComment As String
            Dim globalRating As String
            Dim strCustomerID As String
            Subject = SaveRequestDetialsData(0)("Subject")
            Description = SaveRequestDetialsData(0)("Description")
            Department = SaveRequestDetialsData(0)("Department")
            RequestType = SaveRequestDetialsData(0)("RequestType")
            SubRequestType = SaveRequestDetialsData(0)("SubRequestType")
            Priority = SaveRequestDetialsData(0)("Priority")
            Product = SaveRequestDetialsData(0)("Product")
            ModuleComponent = SaveRequestDetialsData(0)("ModuleComponent")
            Location = SaveRequestDetialsData(0)("Location")
            TimeZone = SaveRequestDetialsData(0)("TimeZone")
            ExpResoulDate = SaveRequestDetialsData(0)("ExpResoulDate")
            CustomerID = SaveRequestDetialsData(0)("CustomerID")
            EmployeeID = SaveRequestDetialsData(0)("EmployeeID")
            Status = SaveRequestDetialsData(0)("Status")
            cboStatusOld = SaveRequestDetialsData(0)("cboStatusOld")
            Project = SaveRequestDetialsData(0)("Project")
            AssignTo = SaveRequestDetialsData(0)("AssignTo")
            'objCustomField = SaveRequestDetialsData(0)("objCustomField")
            'CustomFieldValue = SaveRequestDetialsData(0)("CustomFieldValue")
            cboAssignToOld = SaveRequestDetialsData(0)("cboAssignToOld")
            txtResolutionDateOld = SaveRequestDetialsData(0)("txtResolutionDateOld")
            hidtxtAssignTo = SaveRequestDetialsData(0)("hidtxtAssignTo")
            DeliverableID = SaveRequestDetialsData(0)("DeliverableID")
            StatusChangedate = SaveRequestDetialsData(0)("StatusChangedate")
            StatusChangeTime = SaveRequestDetialsData(0)("StatusChangeTime")
            Keywords = SaveRequestDetialsData(0)("Keywords")
            CboSeverity = SaveRequestDetialsData(0)("CboSeverity")
            FeedbackComment = SaveRequestDetialsData(0)("FeedbackComment")
            globalRating = SaveRequestDetialsData(0)("globalRating")
            strCustomerID = SaveRequestDetialsData(0)("strCustomerID")

            Dim m_strUserName As String = HttpContext.Current.Session("strUserName").ToString
            Dim m_strLoginType As String = HttpContext.Current.Session("LoginType").ToString
            Dim m_lngLoginID As String = HttpContext.Current.Session("intLOGINID")
            Dim m_intCustomer As Integer
            Dim strUserName As String = ""
            Dim strSQL As String
            Dim IsloginCreated As String = "1"
            Dim dtmPrevDate As String = ""
            Dim dtmCurrDate As String = ""
            Dim ApprovalStatusForEmail As String
            Dim strPrevStatus As String = ""
            Dim dr As IDataReader
            dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & RequestID, True)
            If dr.Read Then
                ApprovalStatusForEmail = dr("ApprovalStatus").ToString()
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            Dim strPrevDate As String = ""
            Dim lngPrevAssignTo As String = ""
            lngPrevAssignTo = cboAssignToOld


            If txtResolutionDateOld <> "" Then
                strPrevDate = txtResolutionDateOld + ""
                dtmPrevDate = CType(txtResolutionDateOld, Date)
            End If
            dtmCurrDate = dtmPrevDate

            strPrevStatus = cboStatusOld

            strSQL = " Exec usp_NG2_ConvertUnCategorizedTickets "
            strSQL += RequestID & ","
            strSQL += strCustomerID & ","
            strSQL += Department & ","
            strSQL += "'" & RequestType & "','" & SubRequestType & "',"
            'Added By SantoshK on 30th Nov 2004
            'If CommonFunction.Application.SplitRequestTypeSubType = True Then
            '    strSQL += "'" & SubRequestType & "|" & RequestType & "',"
            'Else
            '    strSQL += "'" & SubRequestType & "',"
            'End If
            'Addition Ends

            'strSQL += "'" & Replace(Subject, "'", "''") & "',"
            'strSQL += "'" & Replace(Description, "'", "''") & "',"



            If Trim(Priority) = "" Then
                strSQL += "NULL"
            Else
                strSQL += Priority & ""
            End If

            If CboSeverity <> "" Then
                strSQL += "," + CboSeverity
            Else
                strSQL += ",NULL"
            End If

            strSQL += "," & Status & ","

            If Trim(hidtxtAssignTo) = "" Then
                strSQL += "NULL,"
            Else
                strSQL += hidtxtAssignTo & ","
            End If

            If m_strLoginType <> "E" Then
                ' If strPrevTargetLoc = "" Then
                'Commented and added By ShraddhaM on 17,Sep 2007
                'strSQL += "NULL,"
                If Location <> "" Then
                    strSQL += Location & ""
                Else
                    strSQL += "Null"
                End If

            Else
                If Location <> "" Then
                    strSQL += Location & ""
                Else
                    strSQL += "Null"
                End If
            End If

            If StatusChangedate = "" Then
                strSQL += ",NULL"
            Else
                strSQL += ",'" & StatusChangedate & "'"
            End If
            If StatusChangeTime = "" Then
                strSQL += ",NULL,"
            Else
                strSQL += ",'" & StatusChangeTime & "',"
            End If

            If m_strLoginType <> "E" Then
                If strPrevDate <> "" Then
                    strSQL += "'" + strPrevDate + "',"
                Else
                    'Modified By NitinVS on 10 Mar 2007 for WhizibleSEM SP8 IssueID 11482 
                    'Added , after Null 
                    strSQL += "NULL,"
                    'Modified By NitinVS on 10 Mar 2007 for WhizibleSEM SP8 IssueID 11482 
                End If
            Else
                If Trim(ExpResoulDate) <> "" Then
                    strSQL += "'" & ExpResoulDate & "'"
                Else
                    strSQL += "Null"
                End If
            End If
            strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"

            RequestID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "")


            GetEmailMessage_20044(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID.ToString, False)
            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)


            Dim strKeywordsSQL As String = ""
            strKeywordsSQL = "usp_NG2_Ins_tbl_CRM_Query_Master_Keywords " & RequestID & ",'" & Keywords & "'"
            CommonFunctions.Data.InsertOrUpdateData(strKeywordsSQL, True)
            Dim lngCurrAssignTo As String = ""
            Dim strCurrStatus As String = ""
            If CommonFunction.General.CheckIsNothing(hidtxtAssignTo, "") <> "" Then
                lngCurrAssignTo = CType(CommonFunction.General.CheckIsNothing(hidtxtAssignTo, "0"), Long)
            Else
                lngCurrAssignTo = 0
            End If

            If m_strLoginType = "E" Then
                If ExpResoulDate <> "" Then
                    dtmCurrDate = CType(CommonFunction.General.CheckIsNothing(ExpResoulDate, Date.Now.ToString), Date)
                End If
            End If

            strCurrStatus = CommonFunction.General.CheckIsNothing(Status, "")

            Dim MsgFlag As String = ""


            ' Assign To change mail
            If lngCurrAssignTo <> 0 And lngCurrAssignTo <> lngPrevAssignTo Then
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                If blnSendMail Then
                    If blnShowPopup Then
                        'With Response
                        '    .Write("<script language=javascript>")
                        '    .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=0&QueryID=" & RequestID & "&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        '    .Write("</script>")
                        'End With
                        MsgFlag += "43" + ","
                    Else
                        ' silent mail
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID.ToString, False)
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
            End If

            ' Status change mail
            If Trim(strCurrStatus & "") <> "" And Trim(strPrevStatus & "") <> Trim(strCurrStatus & "") Then
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 44", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                If blnSendMail Then
                    If blnShowPopup Then
                        'With Response
                        '    .Write("<script language=javascript>")
                        '    .Write("window.open (""../General/SendEmail.aspx?MessageID=44&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        '    .Write("</script>")
                        'End With
                        MsgFlag += "44" + ","
                    Else
                        ' silent mail
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID)
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
            End If

            ' Expected Resolved date change mail
            If dtmCurrDate <> dtmPrevDate Then
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 45", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                If blnSendMail Then
                    If blnShowPopup Then
                        'With Response
                        '    .Write("<script language=javascript>")
                        '    .Write("window.open (""../General/SendEmail.aspx?MessageID=45&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" +(window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        '    .Write("</script>")
                        'End With
                        MsgFlag += "45" + ","
                    Else
                        ' silent mail
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID, "")
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If

            End If
            'Purpose : When the request is been rejected then again the mail should be fired.

            blnSendMail = False : blnShowPopup = False
            If strCurrStatus <> "2" Then


                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", True)

                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                If RTrim(LTrim(ApprovalStatusForEmail)) = "R" Then
                    If blnSendMail Then
                        If blnShowPopup Then
                            'With Response
                            '    .Write("<script language=javascript>")
                            '    'Code Modified by Vidyak on 04 Jun 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
                            '    '.Write("window.open (""../General/SendEmail.aspx?MessageID=46&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                            '    .Write("window.open (""../General/SendEmail.aspx?MessageID=544&QueryID=" & RequestID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                            '    'End Code Modified by Vidyak on 04 Jun 2010
                            '    .Write("</script>")
                            'End With
                            MsgFlag += "544" + ","
                        Else
                            ' silent mail
                            CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_544(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID, "")
                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)

                        End If
                    End If
                End If
            End If











            'If CustomerID <> 0 And CustomerID <> "" Then

            '    strSQL = "usp_sel_tbl_PM_Login_IsCreatedByCustomer " + CustomerID.ToString
            '    IsloginCreated = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Integer)
            'End If

            'If IsloginCreated = 1 Then

            '    If Status = "" Then
            '        Status = "1"
            '    End If

            '    If Project = "" Then
            '        Project = "NULL"
            '    End If
            '    If AssignTo = "" Then
            '        AssignTo = "NULL"
            '    End If

            '    If m_strLoginType <> "E" Then
            '        Location = "NULL"
            '    End If

            '    If Location = "" Then
            '        Location = "NULL"
            '    End If

            '    If Priority = "" Then
            '        Priority = "NULL"
            '    End If

            '    If Product = "" Then
            '        Product = "null"
            '    End If
            '    If ModuleComponent = "" Then
            '        ModuleComponent = "null"
            '    End If
            '    'Dim drEmployee As IDataReader
            '    'If m_intRequestedEmployee <> 0 Then
            '    '    Dim StrEmployee As String

            '    '    StrEmployee = "usp_sel_tbl_pm_employee_EmployeeName_PostID_UserName " & m_intRequestedEmployee

            '    '    drEmployee = CommonFunctions.Data.GetDataReader(StrEmployee, m_blnUseSQL)
            '    '    If drEmployee.Read Then
            '    '        m_strRequestedEmployee = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
            '    '        m_intRequestedEmployeePost = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("PostID"), "0"), Integer)
            '    '        m_strRequestedEmployeeUN = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("UserName"), ""), String)
            '    '    End If
            '    'End If
            '    'CommonFunctions.Data.DisposeDataReader(drEmployee)


            '    Dim drCustomer As IDataReader
            '    Dim strCustomerShortName As String
            '    Dim strCust As String
            '    Dim strRequestType As String
            '    Dim strClientID As String
            '    Dim EmployeeName As String
            '    Dim ClientName As String = ""
            '    Dim m_OnBehalfOfCustomer As String


            '    Dim blnShowPopup As Boolean
            '    Dim blnSendMail As Boolean
            '    Dim strFromEmailID As String
            '    Dim strToMailID As String
            '    Dim strCCToMailID As String
            '    Dim strSubject, strMessage As String
            '    Dim dr As IDataReader

            '    'drCustomer = CommonFunctions.Data.GetDataReader("select CustomerID from tbl_pm_customer where Customer =" & m_intCustomer & "", m_blnUseSQL)
            '    m_intCustomer = CustomerID
            '    strClientID = CType(HttpContext.Current.Session("intLoginID"), String)


            '    strCust = "usp_sel_tbl_pm_customer_CustomerID " & m_intCustomer

            '    drCustomer = CommonFunctions.Data.GetDataReader(strCust, True)

            '    If drCustomer.Read Then
            '        strCustomerShortName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomer("CustomerID"), "0"), String)
            '    End If
            '    CommonFunctions.Data.DisposeDataReader(drCustomer)

            '    '' strRequestType = m_strVal 'CType(HttpContext.Current.Session("RTVal"), String)

            '    If (m_intCustomer <> 0) Then ' And strRequestType = "C"
            '        strUserName = CommonFunctions.General.BuildQueryString(strCustomerShortName)
            '        m_strLoginType = "C"
            '    Else
            '        'If m_intRequestedEmployee <> 0 Then
            '        '    strSQL += "'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "',"
            '        'Else
            '        strUserName = CommonFunctions.General.BuildQueryString(m_strUserName)
            '        'End If
            '        m_strLoginType = HttpContext.Current.Session("LoginType").ToString
            '    End If


            '    If ((m_intCustomer <> 0) Or (EmployeeID <> 0)) And HttpContext.Current.Session("LoginType").ToString = "E" Then
            '        m_OnBehalfOfCustomer = CType(HttpContext.Current.Session("intUserID"), Long)
            '    Else
            '        m_OnBehalfOfCustomer = "Null"
            '    End If


            '    If ((m_intCustomer <> 0) Or (EmployeeID <> 0)) And m_strLoginType = "E" Then
            '        strSQL += "," & CType(HttpContext.Current.Session("intUserID"), Long)
            '    Else
            '        strSQL += ", Null"
            '    End If


            '    Dim m_strLoginName As String
            '    Dim m_blnIsClient As String
            '    Dim drClient As IDataReader
            '    strSQL = "USP_SEL_TBL_PM_LOGIN_CLIENTDETAILS " & CType(m_lngLoginID, String)
            '    drClient = CommonFunctions.Data.GetDataReader(strSQL, True)
            '    If drClient.Read Then
            '        m_strLoginName = CType(CommonFunctions.Data.CheckIsDBNull(drClient("LOGINNAME"), ""), String)
            '        m_blnIsClient = CType(CommonFunctions.Data.CheckIsDBNull(drClient("ISCREATEDBYCUSTOMER"), "0"), Boolean)
            '    End If
            '    CommonFunctions.Data.DisposeDataReader(drClient)

            '    If m_blnIsClient = True Then
            '        ClientName = CommonFunctions.General.BuildQueryString(m_strLoginName)
            '    Else
            '        ClientName = "Null "
            '    End If

            '    Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
            '    Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, True).ToString
            '    Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
            '    Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, True).ToString

            '    strSQL = "exec usp_NG2_INS_RequestDetails  '" & Subject & "','" & Description & "','" & Department & "','" & RequestType & "','" & SubRequestType & "'," & Priority & "," & Product & "," & ModuleComponent & "," & Location & "," & Status & "," & Project & "," & AssignTo & ",'" & strUserName & "','" & m_strLoginType & "'," & m_OnBehalfOfCustomer & ",'" & ClientName & "','" & HttpContext.Current.Session("strUserName") & "','" & ExpResoulDate & "','" & strGetServerTime1 & "','" & strGetServerDate1 & "','" & TimeZone & "'"
            '    '' RequestID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            '    ' RequestID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            '    Dim drApprovalStatus As IDataReader
            '    Dim ApprovalStatusForEmail As String
            '    drApprovalStatus = CommonFunction.Data.GetDataReader(strSQL, True)
            '    If drApprovalStatus.Read() Then
            '        RequestID = drApprovalStatus("RequestID").ToString()
            '        ApprovalStatusForEmail = drApprovalStatus("ApprovalStatus").ToString()
            '    End If

            '    CommonFunctions.Data.DisposeDataReader(drApprovalStatus)

            '    Dim strSQLCC As String = "exec usp_NG2_INS_tbl_NG2_Request_CC  " & RequestID & ",'" & CC & "'"
            '    CommonFunctions.Data.InsertOrUpdateData(strSQLCC, True)

            '    '    m_intShowMandatoryAttachmentMsg = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_CRM_get_MandatoryAttachment " + m_lngQueryID.ToString, m_blnUseSQL), "0"), "0"), Integer)

            '    blnSendMail = False : blnShowPopup = False
            '    'Modified by Vidyak for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications) --added mailid=545 for ApprovalStatusForEmail = "S"
            '    If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
            '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 545", True)
            '    Else
            '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", True)
            '    End If
            '    'dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", m_blnUseSQL)

            '    If dr.Read Then
            '        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            '        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
            '    End If
            '    CommonFunctions.Data.DisposeDataReader(dr)
            '    blnShowPopup = True
            '    If blnSendMail Then
            '        If blnShowPopup Then
            '            'With Response
            '            '    .Write("<script language=javascript>")
            '            '    If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
            '            '        .Write("window.open (""../General/SendEmail.aspx?MessageID=545&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
            '            '    Else
            '            '        .Write("window.open (""../General/SendEmail.aspx?MessageID=46&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
            '            '    End If
            '            '    .Write("</script>")
            '            'End With
            '        Else
            '            ' silent mail
            '            If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
            '                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_545(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID, "")
            '            Else
            '                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID, "")
            '            End If
            '            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)

            '        End If
            '    End If


            ''strTypeInaccessibleCustomFieldList = HttpContext.Current.Request.Form("TypeInaccessibleCustomFieldList")
            'If objCustomField <> "" Then
            '    Dim arrCustomFields() As String = Split(objCustomField, ",")
            '    Dim arrCustomFieldVal() As String = Split(CustomFieldValue, ",")

            '    Dim intCount As Integer

            '    If RequestID > 0 Then
            '        strSQL = " Update Tbl_CRM_Query_Master set "
            '        For intCount = 0 To arrCustomFields.Length - 1
            '            If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
            '                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 Then
            '                    strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
            '                Else
            '                    strSQL = strSQL & arrCustomFields(intCount) & "='" & arrCustomFieldVal(intCount) & "',"
            '                End If
            '            Else
            '                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 Then
            '                    strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
            '                Else
            '                    strSQL = strSQL & arrCustomFields(intCount) & "='" & arrCustomFieldVal(intCount) & "',"
            '                End If
            '            End If
            '        Next

            '        strSQL = strSQL.Substring(0, strSQL.Length - 1)

            '        strSQL = strSQL + " where QueryID = " & RequestID
            '        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            '    End If
            'End If
            ' End If

            'If CommonFunction.Application.EnableProductExecution = True Then

            '    drProductCombo = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + Department.ToString, True)

            '    If drProductCombo.Read Then
            '        ShowProductCombo = "1"
            '    End If
            '    CommonFunction.Data.DisposeDataReader(drProductCombo)
            'End If

            strClientSideScript = ""
            '     strHTML.Append(objCRM_AddNewRequest.DrawRequestDetails(ShowProductCombo, Department, CustomerID, EmployeeID))

            Return RequestID.ToString & "||" & MsgFlag & "||" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function GetAttachmentGrid(ByVal QueryID As String, ByVal QueryDetailID As String) As String
        '=====================================================================
        ' Procedure Name        : GetAttachmentGrid
        ' Description           : To  get list of attachments againsts requests
        ' Created Date           : 13th-Oct-2017
        '=====================================================================
        Try

            Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized
            Dim strHTML As New StringBuilder("")

            strHTML.Append(objCRM_RequestDetailsUncategorized.WriteAttachmentGrid(QueryID, QueryDetailID))

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function GetFlagDetails(ByVal RequestID As String) As String
        '=====================================================================
        ' Procedure Name        : GetFlagDetails
        ' Description           : To Get Flag details when clicked
        ' Created Date           : Dipali V On 31th-OCT-2017
        '=====================================================================
        Try
            Dim drProjectCount As IDataReader
            Dim blnComplete As Boolean
            Dim DueDate As String
            Dim FlagTo As String = ""
            Dim strContextType As String = ""
            Dim m_intUniqueID As Integer = 0


            drProjectCount = CommonFunctions.Data.GetDataReader("usp_sel_TrackingDtls_Edit " & RequestID & ",'HelpDeskRequest', " + CType(HttpContext.Current.Session("intUserID"), String), True)
            Dim ContextValue As String = CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_MyeDashboard_ContextName " & RequestID.ToString & ",'HelpDeskRequest'", True), "")

            If drProjectCount.Read Then
                m_intUniqueID = CType(drProjectCount("UniqueID"), Integer)
                blnComplete = CType(drProjectCount("IsComplete"), Boolean)
                DueDate = CType(drProjectCount("DueDate"), String)
                FlagTo = CType(drProjectCount("FlagTo"), String)
            Else
                m_intUniqueID = 0

                blnComplete = False
                DueDate = ""
                FlagTo = ""
            End If

            Return m_intUniqueID.ToString & "#$#" & blnComplete.ToString & "#$#" & DueDate.ToString & "#$#" & FlagTo & "#$#" & ContextValue.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function ClearRequestFlag(FlagUniqueID As String, RequestID As String)
        '=====================================================================
        ' Procedure Name        : ClearRequestFlag
        ' Description           : To clear  request flagged details
        ' Created Date           : Dipali V On 31th-OCT-2017
        '=====================================================================
        Try

            Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objCRM_RequestDetailsUncategorized.ClearTrackingDtls(FlagUniqueID, RequestID))
            Return "1" & "||" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Protected Function ClearTrackingDtls(ByVal strUniqueID As String, ByVal RequestID As String)
        '=====================================================================
        ' Procedure Name        : ClearTrackingDtls
        ' Description           : To clear existing request flagged details
        ' Created Date           : Dipali V On 31th-OCT-2017
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strHTML As New StringBuilder("")
            strSQL = "exec usp_del_TrackingDtls '" & strUniqueID & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            strHTML.Append("<button onclick=""javascript:Flag_OnClick(" & RequestID & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='Flag On'><i class='fa fa-flag-o' aria-hidden='true' style='color:#f88394 !important'></i></button>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveRequestFlag(ByVal FlagParameters As Object)
        '=====================================================================
        ' Procedure Name        : SaveRequestFlag
        ' Description           : To save request flag details
        ' Created Date           :  Dipali V On 31th-OCT-2017
        '=====================================================================
        Try

            Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objCRM_RequestDetailsUncategorized.GenerateTrackingDtls(FlagParameters))

            Return "1" & "||" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function WorkHrsValidationwithProjectHr(ByVal Project As Object, ByVal RequestID As String)
        '=====================================================================
        ' Procedure Name        : SaveRequestFlag
        ' Description           : To save request flag details
        ' Created Date           :  Dipali V On 2th-nov-2017
        '=====================================================================
        Try


            Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized
            Dim strHTML As New StringBuilder("")
            Dim dr As IDataReader
            Dim dr1 As IDataReader
            Dim lngProjectHours As String = ""
            Dim lngAllocatedHours As String = ""
            Dim startdate As String = ""
            Dim Enddate As String = ""
            dr = CommonFunction.Data.GetDataReader("usp_Sel_PM_DepartmentBalanceLCE " + Project.ToString, True)
            If dr.Read Then
                lngProjectHours = CType(CommonFunctions.Data.CheckIsDBNull(dr("LCETotal"), "0"), Long)
                lngAllocatedHours = CType(CommonFunctions.Data.CheckIsDBNull(dr("AllocatedLCETotal"), "0"), Long)
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
            strHTML.Append("<input type=hidden id=hdnlngProjectHours name=hdnlngProjectHours value='" & lngProjectHours & "' />")
            strHTML.Append("<input type=hidden id=hdnlngAllocatedHours name=hdnlngAllocatedHours value='" & lngAllocatedHours & "' />")



            dr1 = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_ExpectedStartDate_ExpectedEndDate " + Project.ToString, True)


            If dr1.Read Then
                If Not IsDBNull(dr1("ExpectedStartDate")) Then
                    'Response.Write("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value=" + CDate(dr("ExpectedStartDate")).ToString("dd-MMM-yyyy") + " />")
                    strHTML.Append("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value='" + CDate(dr1("ExpectedStartDate")).ToString("MM-dd-yyyy") + "' />")
                Else
                    'Response.Write("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value=0 />")
                    strHTML.Append("<input type=hidden id=hidProjectStartDate name=hidProjectStartDate value='0' />")
                End If
                If Not IsDBNull(dr1("ExpectedEndDate")) Then
                    ' Response.Write("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value=" + CDate(dr("ExpectedEndDate")).ToString("dd-MMM-yyyy") + " />")
                    strHTML.Append("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value='" + CDate(dr1("ExpectedEndDate")).ToString("MM-dd-yyyy") + "' />")
                Else
                    'Response.Write("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value=0 />")
                    strHTML.Append("<input type=hidden id=hidProjectEndDate name=hidProjectEndDate value='0' />")
                End If

                startdate = CDate(dr1("ExpectedStartDate")).ToString("dd-MMM-yyyy")
                Enddate = CDate(dr1("ExpectedEndDate")).ToString("dd-MMM-yyyy")
            End If
            CommonFunction.Data.DisposeDataReader(dr1)
            'Dim m_ActualHours As Double

            ' m_ActualHours = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ActualWorkHours " + lngTaskID.ToString + "," + Project.ToString, True), "0"), "0")
            Dim m_bitResourceValidation As Integer
            m_bitResourceValidation = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_Tbl_PM_Project_ResourceValidation " + Project.ToString, True), "0"))

            Dim m_strPrevAssignTo As String
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails_AssignTo	" & "'" & RequestID & "'", True)
            If dr.Read Then
                'm_intPrevAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
                m_strPrevAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeList"), "0"), String)
            End If



            Return lngProjectHours & "||" & lngAllocatedHours & "||" & startdate & "||" & Enddate & "||" & m_bitResourceValidation & "||" & m_strPrevAssignTo
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Private Function GetEmployeeDepartment(ByVal EmployeeID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetEmployeeDepartment
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Dipali V 
        ' Created               : 3rd Nov 2017
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeDepartment " & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            GetEmployeeDepartment = CType(CommonFunctions.General.CheckIsNothing(dr("DepartmentID"), "0"), Long)
        Else
            GetEmployeeDepartment = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Protected Function GenerateTrackingDtls(ByVal FlagParameters As Object)
        '=====================================================================
        ' Procedure Name        : GenerateTrackingDtls
        ' Description           : to flagged existing request.
        ' Created Date           :  Dipali V On 31th-OCT-2017
        '=====================================================================

        Dim strSQL As String
        Dim strHTML As New StringBuilder("")
        Dim Requestid As String = FlagParameters("RequestID")
        strSQL = "exec usp_ins_TrackingDtls '" & CType(Session("intUserID"), String) & "','HelpDeskRequest','" & FlagParameters("RequestID") & "','" & FlagParameters("ProjectID") & "','" & FlagParameters("FlagTo") & "','" & CDate(FlagParameters("DueDate")).ToString & "','" & FlagParameters("IsComplete") & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)


        Dim drProjectCount1 As IDataReader
        Dim blnComplete As Boolean
        Dim DueDate As String
        Dim FlagTo1 As String = ""
        Dim FlagMain As String = ""
        Dim FlagColor As String = ""
        Dim strContextType As String = ""
        Dim m_intUniqueID As Integer = 0
        drProjectCount1 = CommonFunctions.Data.GetDataReader("usp_NG_ShowFlagDetailswithcolor " & Requestid & ", " + CType(HttpContext.Current.Session("intUserID"), String), True)
        If drProjectCount1.Read() Then
            m_intUniqueID = CType(drProjectCount1("UniqueID"), Integer)
            blnComplete = CType(drProjectCount1("IsComplete"), Boolean)
            DueDate = CType(drProjectCount1("DueDate"), String)
            FlagTo1 = CType(drProjectCount1("FlagTo"), String)
            FlagColor = CType(drProjectCount1("FlagColor"), String)
        End If

        If FlagTo1 = "1" Then
            FlagMain = "Review"
        ElseIf FlagTo1 = "0" Then

            FlagMain = "Follow Up"
        Else
            FlagMain = "Flag To"
        End If


        If CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "L" Then
            strHTML.Append("<button onclick=""javascript:Flag_OnClick(" & Requestid & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag'  style='color:red !important;' aria-hidden='true'></i></button>")
        ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "G" Then
            strHTML.Append("<button onclick=""javascript:Flag_OnClick(" & Requestid & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:green !important;' aria-hidden='true'></i></button>")

        ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "S" Then
            strHTML.Append("<button onclick=""javascript:Flag_OnClick(" & Requestid & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:orange !important;' aria-hidden='true'></i></button>")
            'To Display Black flag for Completed Flaged requests
        ElseIf CType(CommonFunctions.Data.CheckIsDBNull(FlagColor), String) = "B" Then
            strHTML.Append("<button onclick=""javascript:Flag_OnClick(" & Requestid & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='" & FlagMain & " on " & DueDate & "'><i class='fa fa-flag' style='color:black !important;' aria-hidden='true'></i></button>")
        Else
            strHTML.Append("<button onclick=""javascript:Flag_OnClick(" & Requestid & ")"" type=button class='btn btn-default newclass' data-toggle='tooltip' title='Flag'><i class='fa fa-flag-o' style='color:#f88394 !important;' aria-hidden='true'></i></button>")

        End If


        Return strHTML.ToString


        'CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Saved Successfully');</SCRIPT>")
    End Function

    Public Shared Function DeleteDiscussion(ByVal RequestDetailID As String, ByVal RequestID As String) As String
        '=====================================================================
        ' Procedure  Name		:   MultipleDiscussions
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Delete  Discussions
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   1 Nov 2017
        '=====================================================================
        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim dtList As DataTable
        Dim strResult As String = ""
        Dim Msg As String = ""
        ' Dim strReturnHtml As New StringBuilder("")

        ' Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized()

        Try
            strSQL = "Usp_NG2_Del_tbl_CRM_Query_Details " & RequestDetailID & "," & RequestID & ""
            strResult = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "")
            Return "1"

        Catch ex As Exception

        End Try
        ''  Return strResult

    End Function
    '<System.Web.Services.WebMethod()>
    'Public Shared Function DeleteDiscussions(ByVal RequestDetailID As String, ByVal RequestID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:   MultipleDiscussions
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To Delete  Discussions
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:   1 Nov 2017
    '    '=====================================================================
    '    Dim strSQL As String = ""
    '    Dim arrDelete() As String
    '    Dim dtList As DataTable
    '    Dim strResult As String = ""
    '    Dim Msg As String = ""
    '    Dim strReturnHtml As New StringBuilder("")

    '    Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized()

    '    Try
    '        strSQL = "Usp_NG2_Del_tbl_CRM_Query_Details " & RequestDetailID & "," & RequestID & ""
    '        strResult = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "")
    '        Return "1"
    '        'strReturnHtml.Append(objCRM_RequestDetailsUncategorized.PerformFileOperation(RequestID))
    '        ' Return strReturnHtml.ToString
    '        'PerformFileOperation(RequestID)DeleteDiscussion
    '    Catch ex As Exception

    '    End Try
    '    ''  Return strResult

    'End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAssignIssue(ByVal summary As String, ByVal desc As String, ByVal CboIssueProject As String, ByVal objcboAssignTo As String, ByVal CboIssueStatus As String, ByVal CboIssueType As String, ByVal CboIssuePriority As String, ByVal CboIssueSeverity As String, ByVal CboCustomer As String, ByVal CboIssueProduct As String, ByVal CboIssueComponent As String, ByVal RequestID As String)
        '=====================================================================
        ' Procedure  Name		:	SaveAssignIssue
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Assign Issue
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   1 Nov 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim m_strIssueId As String = ""
            Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
            Dim strSQL As String = ""
            If summary = "" Then
                summary = "NULL"
            End If
            If desc = "" Then
                desc = "NULL"
            End If
            If CboIssueProject = "" Then
                CboIssueProject = "NULL"
            End If
            If objcboAssignTo = "" Then
                objcboAssignTo = "NULL"
            End If
            If CboIssueStatus = "" Then
                CboIssueStatus = "NULL"
            End If

            If CboIssuePriority = "" Then
                CboIssuePriority = "NULL"
            End If
            If CboIssueSeverity = "" Then
                CboIssueSeverity = "NULL"
            End If
            If CboIssueProduct = "" Then
                CboIssueProduct = "NULL"
            End If

            If CboIssueComponent = "" Then
                CboIssueComponent = "NULL"
            End If

            If CboCustomer = "" Then
                CboCustomer = "NULL"
            End If

            strSQL = "exec usp_CRM_Assign_Issue  " & CboIssueProject & "," & objcboAssignTo & ",'" & CboIssueType & "','" & CboIssueStatus & "','" & HttpContext.Current.Session("strUserName").ToString & "','E'," & RequestID & ",'" & summary & "','" & desc & "','" & CboIssuePriority & "','" & CboIssueSeverity & "'," & CboCustomer & "," & CboIssueProduct & "," & CboIssueComponent & ""
            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            m_strIssueId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            ''  strHTML.Append(objCRMRequestDetails.GetActivities(RequestID))

            Return m_strIssueId
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function




    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDeliveriable(ByVal cbotitle As String, ByVal cboDeliverableProject As String, ByVal cboDeliverableType As String, ByVal desc1 As String, ByVal StartDate As String, ByVal GridParameter As Object)
        '=====================================================================
        ' Procedure  Name		:	SaveDeliveriable
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Assign Issue
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   2 Nov 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim m_strDeliveriableId As String = ""
            Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
            Dim strSQL As String = ""
            If cbotitle = "" Then
                cbotitle = "NULL"
            End If
            'If Codetemplate = "" Then
            '    Codetemplate = "NULL"
            'End If
            If cboDeliverableProject = "" Then
                cboDeliverableProject = "NULL"
            End If
            If cboDeliverableType = "" Then
                cboDeliverableType = "NULL"
            End If
            If desc1 = "" Then
                desc1 = "NULL"
            End If
            If StartDate = "" Then
                StartDate = "NULL"
            End If
            Dim txtScheduledStartDate = "NULL"
            Dim txtEarliestCompletionDate = "NULL"
            Dim txtLatestCompletionDate = "NULL"
            Dim txtEfforts = "NULL"
            Dim cboPriority = "NULL"
            Dim cboComplexity = "NULL"
            Dim cboDeliverableSizeUnit = "NULL"
            Dim cboStatus = "NULL"
            Dim cboProjectSites = "NULL"
            Dim cboWorkPackage = "NULL"
            Dim cboDepartment = "NULL"
            Dim chkIncludeInMeasurement = "NULL"
            Dim cboRequestedBy = "NULL"
            Dim cboResponsiblePerson = "NULL"
            Dim chkAcceptanceTestingRequired = "NULL"
            Dim txtCustomFieldText1 = "NULL"
            Dim txtCustomFieldText2 = "NULL"
            Dim txtCustomFieldText3 = "NULL"
            Dim txtCustomFieldText4 = "NULL"
            Dim txtCustomFieldText5 = "NULL"
            Dim txtCustomFieldDate1 = "NULL"
            Dim txtCustomFieldDate2 = "NULL"
            Dim txtCustomFieldDate3 = "NULL"
            Dim txtCustomFieldDate4 = "NULL"
            Dim txtCustomFieldDate5 = "NULL"
            Dim txtCustomFieldNumeric1 = "NULL"
            Dim txtCustomFieldNumeric2 = "NULL"
            Dim txtCustomFieldNumeric3 = "NULL"
            Dim txtCustomFieldNumeric4 = "NULL"
            Dim txtCustomFieldNumeric5 = "NULL"
            Dim txtDeliverableSize = "NULL"
            Dim txtClientRefNo = "NULL"
            Dim txtDocumentNo = "NULL"
            If GridParameter IsNot Nothing Then
                Dim ArrayList1 As New Dictionary(Of String, Object)
                ArrayList1 = DirectCast(GridParameter, Dictionary(Of String, Object))
                If ArrayList1.Count > 0 Then
                    For Each item As String In ArrayList1.Keys
                        If item = "txtScheduledStartDate" Then
                            StartDate = "'" & ArrayList1.Item("txtScheduledStartDate") & "'"
                        ElseIf item = "txtEarliestCompletionDate" Then
                            txtEarliestCompletionDate = "'" & ArrayList1.Item("txtEarliestCompletionDate") & "'"
                        ElseIf item = "txtLatestCompletionDate" Then
                            txtLatestCompletionDate = "'" & ArrayList1.Item("txtLatestCompletionDate") & "'"
                        ElseIf item = "txtEfforts" Then
                            txtEfforts = "'" & ArrayList1.Item("txtEfforts") & "'"
                        ElseIf item = "cboPriority" Then
                            cboPriority = "'" & ArrayList1.Item("cboPriority") & "'"
                        ElseIf item = "cboComplexity" Then
                            cboComplexity = "'" & ArrayList1.Item("cboComplexity") & "'"
                        ElseIf item = "cboDeliverableSizeUnit" Then
                            cboDeliverableSizeUnit = "'" & ArrayList1.Item("cboDeliverableSizeUnit") & "'"
                        ElseIf item = "cboStatus" Then
                            cboStatus = "'" & ArrayList1.Item("cboStatus") & "'"
                        ElseIf item = "cboProjectSites" Then
                            cboProjectSites = "'" & ArrayList1.Item("cboProjectSites") & "'"
                        ElseIf item = "cboWorkPackage" Then
                            cboWorkPackage = "'" & ArrayList1.Item("cboWorkPackage") & "'"
                        ElseIf item = "cboDepartment" Then
                            cboDepartment = "'" & ArrayList1.Item("cboDepartment") & "'"
                        ElseIf item = "chkIncludeInMeasurement" Then
                            chkIncludeInMeasurement = "'" & ArrayList1.Item("chkIncludeInMeasurement") & "'"
                        ElseIf item = "cboRequestedBy" Then
                            cboRequestedBy = "'" & ArrayList1.Item("cboRequestedBy") & "'"
                        ElseIf item = "cboResponsiblePerson" Then
                            cboResponsiblePerson = "'" & ArrayList1.Item("cboResponsiblePerson") & "'"
                        ElseIf item = "chkAcceptanceTestingRequired" Then
                            chkAcceptanceTestingRequired = "'" & ArrayList1.Item("chkAcceptanceTestingRequired") & "'"
                        ElseIf item = "txtCustomFieldText1" Then
                            txtCustomFieldText1 = "'" & ArrayList1.Item("txtCustomFieldText1") & "'"
                        ElseIf item = "txtCustomFieldText2" Then
                            txtCustomFieldText2 = "'" & ArrayList1.Item("txtCustomFieldText2") & "'"
                        ElseIf item = "txtCustomFieldText3" Then
                            txtCustomFieldText3 = "'" & ArrayList1.Item("txtCustomFieldText3") & "'"
                        ElseIf item = "txtCustomFieldText4" Then
                            txtCustomFieldText4 = "'" & ArrayList1.Item("txtCustomFieldText4") & "'"
                        ElseIf item = "txtCustomFieldText5" Then
                            txtCustomFieldText5 = "'" & ArrayList1.Item("txtCustomFieldText5") & "'"
                        ElseIf item = "txtCustomFieldDate1" Then
                            txtCustomFieldDate1 = "'" & ArrayList1.Item("txtCustomFieldDate1") & "'"
                        ElseIf item = "txtCustomFieldDate2" Then
                            txtCustomFieldDate2 = "'" & ArrayList1.Item("txtCustomFieldDate2") & "'"
                        ElseIf item = "txtCustomFieldDate3" Then
                            txtCustomFieldDate3 = "'" & ArrayList1.Item("txtCustomFieldDate3") & "'"
                        ElseIf item = "txtCustomFieldDate4" Then
                            txtCustomFieldDate4 = "'" & ArrayList1.Item("txtCustomFieldDate4") & "'"
                        ElseIf item = "txtCustomFieldDate5" Then
                            txtCustomFieldDate5 = "'" & ArrayList1.Item("txtCustomFieldDate5") & "'"
                        ElseIf item = "txtCustomFieldNumeric1" Then
                            txtCustomFieldNumeric1 = "'" & ArrayList1.Item("txtCustomFieldNumeric1") & "'"
                        ElseIf item = "txtCustomFieldNumeric2" Then
                            txtCustomFieldNumeric2 = "'" & ArrayList1.Item("txtCustomFieldNumeric2") & "'"
                        ElseIf item = "txtCustomFieldNumeric3" Then
                            txtCustomFieldNumeric3 = "'" & ArrayList1.Item("txtCustomFieldNumeric3") & "'"
                        ElseIf item = "txtCustomFieldNumeric4" Then
                            txtCustomFieldNumeric4 = "'" & ArrayList1.Item("txtCustomFieldNumeric4") & "'"
                        ElseIf item = "txtCustomFieldNumeric5" Then
                            txtCustomFieldNumeric5 = "'" & ArrayList1.Item("txtCustomFieldNumeric5") & "'"
                        ElseIf item = "txtDeliverableSize" Then
                            txtDeliverableSize = "'" & ArrayList1.Item("txtDeliverableSize") & "'"
                        ElseIf item = "txtClientRefNo" Then
                            txtClientRefNo = "'" & ArrayList1.Item("txtClientRefNo") & "'"
                        ElseIf item = "txtDocumentNo" Then
                            txtDocumentNo = "'" & ArrayList1.Item("txtDocumentNo") & "'"
                        End If
                    Next
                End If
            End If



            strSQL = "exec usp_NG2_INS_CRMDeliveriableDetails  " & cboDeliverableType & "," & cboDeliverableProject & ",'" & cbotitle & "'," & StartDate & ",'" & desc1 & "'," & cboDepartment & "," & txtDocumentNo & "," & txtClientRefNo & "," & txtEfforts & "," & txtEarliestCompletionDate & "," & txtLatestCompletionDate & "," & cboProjectSites & "," & cboPriority & "," & txtDeliverableSize & "," & cboDeliverableSizeUnit & "," & cboComplexity & "," & chkIncludeInMeasurement & "," & cboRequestedBy & "," & cboResponsiblePerson & "," & cboStatus & "," & chkAcceptanceTestingRequired & "," & cboWorkPackage & "," & txtCustomFieldText1 & "," & txtCustomFieldText2 & "," & txtCustomFieldText3 & "," & txtCustomFieldText4 & "," & txtCustomFieldText5 & "," & txtCustomFieldNumeric1 & "," & txtCustomFieldNumeric2 & "," & txtCustomFieldNumeric3 & "," & txtCustomFieldNumeric4 & "," & txtCustomFieldNumeric5 & "," & txtCustomFieldDate1 & "," & txtCustomFieldDate2 & "," & txtCustomFieldDate3 & "," & txtCustomFieldDate4 & "," & txtCustomFieldDate5


            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            m_strDeliveriableId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            ''  strHTML.Append(objCRMRequestDetails.GetActivities(RequestID))

            ''Added by Usha Pandit on 03.01.2019 for Deliverable Code Template Mandatopry disabled field blank issue
            CommonFunctions.Data.InsertOrUpdateData("usp_upd_tbl_PM_OtherSchedule_CodeTemplate " & m_strDeliveriableId, True)
            ''End of Added by Usha Pandit on 03.01.2019 for Deliverable Code Template Mandatopry disabled field blank issue

            Dim strSQLCRM As String
            'Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
            'strSQLCRM = " UPDATE tbl_CRM_Query_Master SET DeliverableID =" & intScheduleID
            'strSQLCRM += " where QueryID =" & m_intQueryID
            Dim strSessionUserName As String
            strSessionUserName = CType(HttpContext.Current.Session("strUserName"), String).Replace("'", "''")
            strSQLCRM = " UPDATE tbl_CRM_Query_Master SET DeliverableID =" & m_strDeliveriableId
            strSQLCRM += ",ModifiedBy='" & strSessionUserName & "'"
            strSQLCRM += ",ModifiedDate=GETDATE() "
            strSQLCRM += " where QueryID =" & GridParameter("QueryID")
            CommonFunction.Data.InsertOrUpdateData(strSQLCRM, True)
            'End of Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
            Return m_strDeliveriableId
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDateValidation(ByVal Project As String, ByVal ObjTaskStartDate As String, ByVal ObjTaskEndDate As String)
        '==================================================================================
        ' Procedure Name	:	CheckDateValidation
        ' Purpose			:	To check is date validation
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Dipali v
        ' Created			:	29-Sept-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            'If ObjTaskStartDate = "" Then
            '    ObjTaskStartDate = "NULL"
            'End If
            'If ObjTaskEndDate = "" Then
            '    ObjTaskEndDate = "NULL"
            'End If
            'If RequestSubmitedDate = "" Then
            '    RequestSubmitedDate = "NULL"
            'End If
            'If ObjTaskEndDate = "" Then
            '    strSQL = "Usp_Sel_NG2_AssignTaskDateValidation " & Project & ",'" & ObjTaskStartDate & "',NULL,'" & RequestSubmitedDate & "'"
            'Else
            strSQL = "Usp_Sel_NG2_AssignTaskDateValidation " & Project & ",'" & ObjTaskStartDate & "','" & ObjTaskEndDate & "'"

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Private Function AllowValueChanged(ByVal TaskID As String) As Boolean
        '=====================================================================
        ' Procedure Name        : AllowValueChanged
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Dipali Vekhande
        ' Created               : 3th nov 2017
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader

        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_ProjectTasks_ProjectID_EmployeeID_TaskTypeID " & TaskID, m_blnUseSQL)
        If dr.Read Then
            m_lngOldProjectID = CType(CommonFunctions.General.CheckIsNothing(dr("ProjectID"), "0"), Long)
            m_lngOldTaskTypeID = CType(CommonFunctions.General.CheckIsNothing(dr("TaskTypeID"), "0"), Long)
            m_lngOldAssignTo = CType(CommonFunctions.General.CheckIsNothing(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function Plotfeedback()
        '=====================================================================
        ' Procedure Name        : Plotfeedback
        ' Description           : To save request flag details
        ' Created Date           :  Dipali V On 14th Nov 2017
        '=====================================================================

        Try

            Dim strHTML As New StringBuilder("")
            Dim FeedbackID As String
            Dim ParameterName As String
            Dim Rating As String
            Dim dr As IDataReader

            dr = CommonFunction.Data.GetDataReader("usp_NG2_SEL_tbl_CRM_Feedback ", True)


            strHTML.Append("<div class='divfeedback'>")
            strHTML.Append("<table class='tblfeedback'>")
            strHTML.Append("<tbody>")
            strHTML.Append("<tr>")

            While dr.Read
                FeedbackID = CType(CommonFunctions.General.CheckIsNothing(dr("FeedbackID"), ""), String)
                ParameterName = CType(CommonFunctions.General.CheckIsNothing(dr("ParameterName"), ""), String)
                Rating = CType(CommonFunctions.General.CheckIsNothing(dr("Rating"), ""), String)
                '/strHTML.Append("<td>")
                If Rating = "1" Then
                    strHTML.Append("<td><label class='clslabel'>Satisfactory</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Satisfactory'></i></span></label>")
                    'strHTML.Append("<td><span><i class='fa fa-star-o' aria-hidden='true' title='Satisfactory'></i></span>")
                    strHTML.Append("<input type=hidden id=Ratingone name=Ratingone value='" & FeedbackID & "' /></td>")
                ElseIf Rating = "5" Then
                    strHTML.Append("<td><label class='clslabel'>Fair</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Fair'></i><i class='fa fa-star checked1' aria-hidden='true' title='Fair'></i></span></label>")
                    strHTML.Append("<input type=hidden id=Ratingtwo name=Ratingtwo value='" & FeedbackID & "' /></td>")
                ElseIf Rating = "8" Then
                    strHTML.Append("<td><label class='clslabel'>Good</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Good'></i><i class='fa fa-star checked1' aria-hidden='true' title='Good'></i><i class='fa fa-star checked1' aria-hidden='true' title='Good'></i></span></label>")
                    strHTML.Append("<input type=hidden id=Ratingthree name=Ratingthree value='" & FeedbackID & "' /></td>")
                ElseIf Rating = "10" Then
                    strHTML.Append("<td><label class='clslabel'>Excellent</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i></span></label>")
                    strHTML.Append("<input type=hidden id=RatingFour name=RatingFour value='" & FeedbackID & "' /></td>")

                End If

            End While



            '      <div class="row">
            '  <div class="col-lg-12">
            '    <div class="star-rating">
            '      <span class="fa fa-star-o" data-rating="1"></span>
            '      <span class="fa fa-star-o" data-rating="2"></span>
            '      <span class="fa fa-star-o" data-rating="3"></span>
            '      <span class="fa fa-star-o" data-rating="4"></span>
            '      <span class="fa fa-star-o" data-rating="5"></span>
            '      <input type="hidden" name="whatever1" class="rating-value" value="2.56">
            '    </div>
            '  </div>
            '</div>
            CommonFunctions.Data.DisposeDataReader(dr)


            strHTML.Append("</tr>")

            strHTML.Append("<tr>")

            strHTML.Append("<td><label class='clslabel'>Rate us :-</label>&nbsp;&nbsp;<label>")
            strHTML.Append("</td>")
            strHTML.Append("<td colspan='3'>")
            strHTML.Append("<span class='fa fa-star' onclick='Putrating(1)' id='firstrating' data-rating='1' title='Satisfactory'></span>&nbsp;")
            strHTML.Append("<span class='fa fa-star' onclick='Putrating(5)' id='Secondrating' data-rating='5' title='Fair'></span>&nbsp;")
            strHTML.Append("<span class='fa fa-star' onclick='Putrating(8)' id='Thirdrating' data-rating='8' title='Good'></span>&nbsp;")
            strHTML.Append("<span class='fa fa-star' onclick='Putrating(10)' id='Foruthrating' data-rating='10' title='Excellent'></span>&nbsp;")
            'strHTML.Append("<span class='fa fa-star'></span>&nbsp;")

            ' strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<span id='SpnRatingMsg'></span>")
            strHTML.Append("</td>")
            'strHTML.Append("<td><span><i class='fa fa-star-o' aria-hidden='true' title='Satisfactory' onclick='Putrating(1)' id='firstrating' data-rating='1'></i></span></td><td><span><i class='fa fa-star-o' aria-hidden='true' title='Fair' onclick='Putrating(5)'  id='Secondrating' data-rating='5'></i></span></td><td><span><i class='fa fa-star-o' aria-hidden='true' title='Good' onclick='Putrating(8)' id='Thirdrating' data-rating='8'></i></span></td><td><span><i class='fa fa-star-o' aria-hidden='true' title='Excellent' onclick='Putrating(10)' id='Foruthrating' data-rating='10'></i></span></td>")
            strHTML.Append("</tr>")

            strHTML.Append("<tr>")
            strHTML.Append("<td colspan='3'>")
            strHTML.Append("<div style='text-align:center'>")
            strHTML.Append("<span id='SpnRatingMsg'></span>")
            strHTML.Append("</div>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")


            strHTML.Append("<tr>")
            strHTML.Append("<td colspan='3'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-5' for='Feedback' style='font-weight:normal!important' id='lblfeedback'>Feedback Comment *</label>")
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cbFeekback", "usp_CRM_Get_Feedback_ForCombo", 188, , "class='form-control' onblur=""javascript:GetRating()"" ", True, True, , , , , ))
            strHTML.Append(" <div class='col-sm-10'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("cbFeekback", "cbFeekback", , "form-control", , , , , 330, , , , , , , , , , "", True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")

            strHTML.Append("</tbody>")
            strHTML.Append("</table>")



            strHTML.Append("</div>")
            'strHTML.Append("</div>")

            'strHTML.Append("<div class='row'>")
            'strHTML.Append("<div class='col-md-12'>")
            'strHTML.Append("<div class="" style='width:37% ; background-color:white'>")
            'strHTML.Append("<p class='help'></p>")

            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")


            strHTML.Append("<div class='row' id='btngroupcnlsave'>")
            strHTML.Append("<div class='col-xs-12' id='btngroupcnlsave1'>")

            strHTML.Append("<button type='button' class='btn btn-default' onclick='SaveFeedback()' title='Submit FeedBack'>Submit</button>")
            strHTML.Append("<button type='button' class='btn btn-default' onclick='CancelFeedback()' style='margin-left:4px'  title='Cancel'>Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")


            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveFeedback(ByVal globalFeedbackID As String, ByVal RequestID As String, ByVal FeedbackComment As String)
        '=====================================================================
        ' Procedure  Name		:	SaveFeedback
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Assign Issue
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   15 Nov 2017
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim m_strFeedBack As String = ""
        Dim objCRMRequestDetails As New CRM_RequestDetailsUncategorized
        Dim strSQL As String = ""
        Dim UniqueID As Integer = 0
        If globalFeedbackID = "" Then
            globalFeedbackID = "NULL"
        End If

        Try

            strSQL = "exec usp_NG2_INS_Feedback  " & globalFeedbackID & "," & RequestID & " ,'" & FeedbackComment & "','" & HttpContext.Current.Session("strUserName") & "'"
            m_strFeedBack = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            UniqueID = 1
            Return UniqueID
        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function GenerateZipFile(ByVal QueryID As String, ByVal QueryDetailID As String) As String
        '=====================================================================
        ' Procedure Name        : GenerateZipFile
        ' Description           : Generate Zip file
        ' Created Date           : 17th-NOV-2017
        '=====================================================================
        Try

            Dim objCRM_RequestDetailsUncategorized As New CRM_RequestDetailsUncategorized
            Dim strArchiveFileName As String = ""

            strArchiveFileName = objCRM_RequestDetailsUncategorized.GenerateZipFileStructure(QueryID, QueryDetailID)

            Return strArchiveFileName
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Private Function GenerateZipFileStructure(QueryID As String, QueryDetailID As String)
        Dim drAttachment As IDataReader
        Dim strSystemfileName As String
        Dim strFilePath_Old As String = ""
        Dim strFilePath_New As String = ""
        Dim sourceFile As String = ""
        Dim destFile As String = ""
        Dim strArchiveFileName As String
        Dim strSQLQuery As String = ""

        'If QueryDetailID = "" Then
        strSQLQuery = "EXEC usp_Sel_Documents_Attached_For_CRM_Uncategorized " & QueryID & " ,NULL , '-1', 'DateAttached', 'DESC'"
        'Else
        'strSQLQuery = "EXEC usp_NG2_Sel_Documents_Attached_For_CRM_Discussion " & CommonFunctions.General.CheckIsNothing(QueryID, "") & "," & CommonFunctions.General.CheckIsNothing(QueryDetailID, "")
        'strSQLQuery += " ,NULL , '-1'"
        'strSQLQuery += ", 'DateAttached', 'DESC'"
        'End If


        drAttachment = CommonFunctions.Data.GetDataReader(strSQLQuery, True)

        strFilePath_Old = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/CRM"))
        strFilePath_New = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/CRM/ZIPFile/Request_" & QueryID & ""))

        While drAttachment.Read
            strSystemfileName = CommonFunctions.Data.CheckIsDBNull(drAttachment("SystemFileName"))

            If (strSystemfileName <> "") Then

                Try
                    'Added By Bharat T on 10th-Aug-2017 to create folder structre if not exists
                    Dim strDirectoryPath As String = System.IO.Path.GetDirectoryName(strFilePath_New)
                    If (Not System.IO.Directory.Exists(strDirectoryPath)) Then
                        System.IO.Directory.CreateDirectory(strDirectoryPath)
                    End If
                    'End of Added By Bharat T on 10th-Aug-2017 to create folder structre if not exists

                    sourceFile = System.IO.Path.Combine(strFilePath_Old, strSystemfileName)
                    destFile = System.IO.Path.Combine(strFilePath_New, strSystemfileName)

                    System.IO.File.Copy(sourceFile, destFile, True)

                Catch ex As Exception

                End Try
            End If
        End While

        'Path of zip file to be created with file name
        strArchiveFileName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/CRM/ZIPFile")) & "Request_" & QueryID & ".zip"

        'Check if already zip file exists if exists the delete and create new 
        Try
            If (File.Exists(strArchiveFileName)) Then
                File.Delete(strArchiveFileName)
            End If

            ZipFile.CreateFromDirectory(strFilePath_New, strArchiveFileName)
        Catch ex As Exception

        End Try

        Return strArchiveFileName
    End Function
    Public Shared Function GetDefaultType(ByVal ProjectID As String) As String
        '=====================================================================
        ' Procedure Name        : GetDefaultType
        ' Description           : to get the default type for the proj.
        ' Purpose               : 
        ' Parameters Passed     : intProjectID
        ' Returns               : the default type
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : YOgesh Jalamkar
        ' Created               : 28-11-2017 
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strType As String = ""

        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Default_IssueType " & ProjectID, True)
        If dr.Read Then
            If Trim(dr("Type").ToString & "") <> "" Then
                strType = Trim(dr("Type").ToString & "")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        GetDefaultType = ""
        If Trim(strType & "") = "" Then
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Project_IssueTypes_ForCombo " & ProjectID, True)
            If dr.Read Then
                GetDefaultType = dr("type").ToString & ""
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        Else
            GetDefaultType = strType & ""
        End If

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CheckDateFormat(ByVal TaskStartDate As String, ByVal SubmittedDate As String) As String
        '=====================================================================
        ' Procedure Name        : CheckDateFormat
        ' Description           :CheckDateFormat
        ' Created Date          : 12-DEC-2017
        ' Author                : Yogesh Jalamkar
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            strSQL = "usp_NG2_CompaireDates '" + TaskStartDate + "','" + SubmittedDate + "'"
            strResult = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function writeMandatoryFields(ByVal strScheduleID As String, ByVal strProjectID As String)
        Try
            Dim strSql_DeliverableType As String
            Dim strSql_MandatoryFields As String
            Dim strSql_Status As String
            Dim strSql_ProjectSites As String
            Dim strSql_WorkPackage As String
            Dim strsql As String
            Dim m_strObjArray As String
            Dim strHTML As New StringBuilder()
            Dim m_lngEstimatedEfforts As Long = 0


            strSql_MandatoryFields = "usp_sel_tbl_CNF_ScheduleFieldConfig_MandatoryCustomfield " + strScheduleID + ""
            Dim drGetMandatoryFields As IDataReader
            drGetMandatoryFields = CommonFunctions.Data.GetDataReader(strSql_MandatoryFields, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            With strHTML


                Dim intResult As Integer
                Dim blnUseSQL As Boolean
                Dim strLabel_Title As String = "Title"
                Dim drGetDefaultFields As IDataReader
                Dim strSql_captions As String = "select * from tbl_CNF_ScheduleFieldConfig  where mandatory = 1 and applicable = 1 and fieldname IN "
                strSql_captions += "( 'Title','Client Reference Number','Document No') and ScheduleTypeID =" + strScheduleID + " order by fieldname"

                If strScheduleID <> "0" Then
                    Dim strSQLQuery_DocumentNo As String
                    Dim intResult_DocumentNo As Integer
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQLQuery_DocumentNo = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1) Else Select 0"
                    strSQLQuery_DocumentNo = "usp_sel_tbl_PM_CompanySchedules_IsCodeTemplateEditable " & strScheduleID
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    intResult_DocumentNo = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery_DocumentNo, True), "0"), Integer)
                    'if intResult is 1 -Show 'CodeTemplate' in Editable Mode with Mandatory, Else dont show the control
                    If intResult_DocumentNo = 1 Then
                        .Append("<div class=form-group>")
                        .Append("<label class=col-sm-3>Code Template *</label><div class=col-sm-9>")

                        .Append(CommonFunctions.HTMLControls.DrawTextBox("txtDocumentNo", "txtDocumentNo", "form-control", 300, 500, , , , False, , , , , True, , , EnableHTMLEncode:=True))
                        .Append("</div></div>")
                    End If
                    blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                    drGetDefaultFields = CommonFunctions.Data.GetDataReader(strSql_captions, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drGetDefaultFields.Read
                        Dim strFieldName As String = CType(CommonFunction.Data.CheckIsDBNull(drGetDefaultFields("FieldName"), "0"), String)
                        Dim strLabel As String = CType(CommonFunction.Data.CheckIsDBNull(drGetDefaultFields("Label"), "0"), String)
                        Select Case strFieldName
                            Case "Client Reference Number"
                                .Append("<div class=form-group>")
                                .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                                .Append(CommonFunctions.HTMLControls.DrawTextBox("txtClientRefNo", "txtClientRefNo", "form-control", 300, 500, , , , False, , , , , True, , EnableHTMLEncode:=True))
                                .Append("</div></div>")
                        End Select
                    End While
                End If


                Dim dtmExpectedStartDate As Date
                Dim dtmExpectedEndDate As Date

                Dim drProjectDates As IDataReader

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQL = "SELECT ExpectedStartDate , ExpectedEndDate,EstimatedEfforts FROM tbl_PM_Project where ProjectID = " & strProjectID
                strsql = "usp_sel_tbl_PM_Project_ExpectedStartDate_ExpectedEndDate_EstimatedEfforts " & strProjectID
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


                drProjectDates = CommonFunctions.Data.GetDataReader(strsql, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drProjectDates.Read Then
                    dtmExpectedStartDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDates("ExpectedStartDate"), ""), Date)
                    dtmExpectedEndDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDates("ExpectedEndDate"), ""), Date)
                    m_lngEstimatedEfforts = CType(CommonFunction.Data.CheckIsDBNull(drProjectDates("EstimatedEfforts"), ""), Long)


                    .Append(CommonFunctions.HTMLControls.DrawTextBox("txtEstimatedEfforts", "txtEstimatedEfforts", , 300, 500, m_lngEstimatedEfforts, , , False, , , True, , True, EnableHTMLEncode:=True))

                    .Append(CommonFunctions.HTMLControls.DrawTextBox("txtProjectStartDate", "txtProjectStartDate", , 300, 500, dtmExpectedStartDate, , , False, , , True, , True, EnableHTMLEncode:=True))

                    .Append(CommonFunctions.HTMLControls.DrawTextBox("txtProjectEndDate", "txtProjectEndDate", , 300, 500, dtmExpectedEndDate, , , False, , , True, , True, False, EnableHTMLEncode:=True))

                End If
                CommonFunctions.Data.DisposeDataReader(drProjectDates)


                While drGetMandatoryFields.Read
                    Dim strFieldName As String = CType(CommonFunction.Data.CheckIsDBNull(drGetMandatoryFields("FieldName"), "0"), String)
                    Dim strLabel As String = CType(CommonFunction.Data.CheckIsDBNull(drGetMandatoryFields("Label"), "0"), String)

                    Select Case strFieldName
                        Case "Scheduled Start Date"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtScheduledStartDate As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtScheduledStartDate", "txtScheduledStartDate", "dtPicker form-control", , dmtScheduledStartDate, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtScheduledStartDate').datepicker('show');></i>")
                        Case "Earliest Completion Date"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtEarliestCompletionDate As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtEarliestCompletionDate", "txtEarliestCompletionDate", "dtPicker form-control", , dmtEarliestCompletionDate, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtEarliestCompletionDate').datepicker('show'); ></i>")
                        Case "Latest Completion Date"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtLatestCompletionDate As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtLatestCompletionDate", "txtLatestCompletionDate", "dtPicker form-control", , dmtLatestCompletionDate, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender'  onclick=$('#txtLatestCompletionDate').datepicker('show'); ></i>")
                        Case "Efforts"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strEfforts As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", 100, 100, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "Priority"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strPriority As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Sel_tbl_CRM_Priority_ForDeliverable", , strPriority, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Complexity"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strComplexity As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_Sel_tbl_PM_ComplexityMaster_ForDeliverable", , strComplexity, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Deliverable Size"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strDeliverableSize As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableSize", "txtDeliverableSize", "form-control", 100, 9, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                            Dim strDeliverableSizeUnit As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableSizeUnit", "usp_sel_tbp_PM_SizeUnits", , strDeliverableSizeUnit, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Deliverable Size Unit"

                        Case "Status"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            strSql_Status = "usp_Sel_tbl_IB_Project_Type_Status_Deliverables " + strScheduleID.Trim + ", " + strProjectID
                            Dim strStatus As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSql_Status, , strStatus, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Project Site"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            strSql_ProjectSites = "usp_Sel_tbl_PM_ProjectSites_ForDeliverable " + strProjectID
                            Dim strProjectSites As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectSites", strSql_ProjectSites, , strProjectSites, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Work Package"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            strSql_WorkPackage = "usp_Sel_tbl_PM_ProjectPackages " + strProjectID
                            Dim strWorkPackage As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboWorkPackage", strSql_WorkPackage, , strWorkPackage, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Department"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strDepartment As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_tbl_PM_DepartmentMaster_ForDeliverable", , strDepartment, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Include In Measurement"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strIncludeInMeasurement As String
                            .Append(CommonFunctions.HTMLControls.DrawCheckBox("chkIncludeInMeasurement", "chkIncludeInMeasurement", "form-control", False, "0", , " Caption='" & strLabel & "'", True, ))
                        Case "Requested By"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strRequestedBy As String
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestedBy", strsql, , strRequestedBy, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Responsible Person"
                            strsql = ""
                            strsql += "Select Distinct E.EmployeeID, E.UserName "
                            strsql += "From	tbl_PM_ProjectEmployeeRole P, tbl_PM_Employee E"
                            strsql += " Where	P.ProjectID = " + strProjectID + " And P.EmployeeID = "
                            strsql += " E.EmployeeID and IsNull(P.ActualEndDate,'') = ''"
                            strsql += "Order By E.UserName"
                            Dim strResponsiblePerson As String
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawComboBox("cboResponsiblePerson", strsql, , strResponsiblePerson, " Caption='" & strLabel & "'", True, True, "form-control", ))
                        Case "Acceptance Testing Required"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim strAcceptanceTestingRequired As String
                            .Append(CommonFunctions.HTMLControls.DrawCheckBox("chkAcceptanceTestingRequired", "chkAcceptanceTestingRequired", "form-control", False, "0", , " Caption='" & strLabel & "'", True))
                    End Select
                    .Append("</div></div>")
                End While
                CommonFunction.Data.DisposeDataReader(drGetMandatoryFields)
                strHTML.Append(WriteCustomfields(strScheduleID))
                'strHTML.Append("</table>")
            End With
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function WriteCustomfields(ByVal strScheduleID As String)
        Try
            Dim strSQL_Customfields As String
            Dim strHTML As New StringBuilder()
            strSQL_Customfields = "usp_sel_tbl_CNF_ScheduleFieldConfig_MandatoryCustomfield_fieldname " + strScheduleID
            Dim drGetCustomFields As IDataReader
            With strHTML
                drGetCustomFields = CommonFunctions.Data.GetDataReader(strSQL_Customfields, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drGetCustomFields.Read
                    Dim strFieldName As String = CType(CommonFunction.Data.CheckIsDBNull(drGetCustomFields("FieldName"), "0"), String)
                    Dim strLabel As String = CType(CommonFunction.Data.CheckIsDBNull(drGetCustomFields("Label"), "0"), String)

                    Select Case strFieldName
                        Case "CustomFieldText1"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText1", "txtCustomFieldText1", "form-control", 300, 100, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldText2"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText2", "txtCustomFieldText2", "form-control", 300, 100, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldText3"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText3", "txtCustomFieldText3", "form-control", 300, 100, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldText4"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText4", "txtCustomFieldText4", "form-control", 300, 100, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldText5"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText5", "txtCustomFieldText5", "form-control", 300, 100, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldDate1"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtCustomFieldDate1 As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldDate1", "txtCustomFieldDate1", "dtPicker form-control", , dmtCustomFieldDate1, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtCustomFieldDate1').datepicker('show'); ></i>")
                        Case "CustomFieldDate2"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtCustomFieldDate2 As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldDate2", "txtCustomFieldDate2", "dtPicker form-control", , dmtCustomFieldDate2, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtCustomFieldDate2').datepicker('show'); ></i>")
                        Case "CustomFieldDate3"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtCustomFieldDate3 As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldDate3", "txtCustomFieldDate3", "dtPicker form-control", , dmtCustomFieldDate3, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtCustomFieldDate3').datepicker('show'); ></i>")
                        Case "CustomFieldDate4"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtCustomFieldDate4 As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldDate4", "txtCustomFieldDate4", "dtPicker form-control", , dmtCustomFieldDate4, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtCustomFieldDate4').datepicker('show'); ></i>")
                        Case "CustomFieldDate5"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            Dim dmtCustomFieldDate5 As String
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldDate5", "txtCustomFieldDate5", "dtPicker form-control", , dmtCustomFieldDate5, , "", , , , , , " Caption='" & strLabel & "'", True, ))
                            strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=$('#txtCustomFieldDate5').datepicker('show'); ></i>")
                        Case "CustomFieldNumeric1"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric1", "txtCustomFieldNumeric1", "form-control", 300, 500, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldNumeric2"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric2", "txtCustomFieldNumeric2", "form-control", 300, 500, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldNumeric3"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric3", "txtCustomFieldNumeric3", "form-control", 300, 500, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldNumeric4"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric4", "txtCustomFieldNumeric4", "form-control", 300, 500, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))
                        Case "CustomFieldNumeric5"
                            .Append("<div class=form-group>")
                            .Append("<label class=col-sm-3>" & strLabel & "*</label><div class=col-sm-9>")
                            '.Append("<TD >")                                                                                  
                            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric5", "txtCustomFieldNumeric5", "form-control", 300, 500, , , , False, , , , " Caption='" & strLabel & "'", True, , EnableHTMLEncode:=True))

                            '.Append("</td>")

                            '.Append("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                    End Select
                    .Append("</div></div>")
                End While
                CommonFunction.Data.DisposeDataReader(drGetCustomFields)
            End With
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ApproveOrReject(ByVal strAction As String, ByVal strComments As String, ByVal queryID As String)
        Try
            Dim strQuery As String
        strQuery = "usp_UPD_Request_ApprovalStatus " + queryID + ",'" + strAction + "','" + strComments + "'," + HttpContext.Current.Session("intUserID").ToString()
        CommonFunction.Data.InsertOrUpdateData(strQuery, True)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDueDate(ByVal DueDate As String)
        '==================================================================================
        ' Procedure Name	:	CheckDueDate
        ' Purpose			:	To check is date validation
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Aniruddh Gujar
        ' Created			:	21-Dec-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String

            strSQL = "usp_Ng2_Validate_DueDate '" & DueDate & "'"
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveCustomer(ByVal strCustomerName As String, ByVal strAbbrName As String, ByVal strEmail As String, ByVal strDeptID As String, ByVal RequestID As String)
        Try
            Dim strSql As String = "usp_NG2_CreateNewCustomers '" & strCustomerName & "','" & strAbbrName & "','" & strEmail & "','" & strDeptID & "'"
            Dim strResult As String = CommonFunctions.Data.GetDataScalar(strSql, True)
            Return CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_NG2_Sel_CustomerCombo_ForUnCategorized " & RequestID, , strResult, "class='form-control' onchange='Customer_New_Onchange(this)'", False, True, , False)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDepartmentCustomerWise(ByVal CustomerID As String)
        Try
            Return CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_NG2_CRM_GetFunctions_ForRole " + CustomerID.ToString & "," & HttpContext.Current.Session("intUserID"), , , "class='form-control' onchange=Department_OnChange(this) ", False, True)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Public Shared Sub GetEmailMessage_20044(ByRef FromEmailID As String, ByRef ToEmailID As String, ByRef CCToEmailID As String, ByRef Subject As String, ByRef EmailMessage As String, ByVal RequestID As String, ByVal blnMultipleRequests As Boolean)
        '=====================================================================
        ' Procedure Name		:	GetEmailMessage_43 (HELP REQUEST ASSIGNED)
        ' Parameters Passed     :	ToEmailID	:- The EmailID of the person to whom the message will be returned.
        '							strSubject		:- The Subject of the Email Message.
        '							EmailMessage	:- The Body of the Email Message.
        '							intIssueID		:- The ID of the Issue entered by the customer.
        ' Returns               :	No return values.
        ' Parameters Affected   :	ToEmailID, strSubject, EmailMessage :- These values are returned by the subroutine by reference.
        ' Description           :	Generate the email message as defined in the System Email Messages table in the database.
        ' Purpose               :	Generate the email message as defined in the System Email Messages table in the database.
        ' Assumptions           :	The message ID exists in the database.
        '							The message does not contain any other parameters besides the following :
        '								1.	<NAME>
        '								2.	<SENDER_NAME>
        '								3.	<PROJECT_NAME> 
        '								4.	<SUMMARY>
        '								5.	<DESCRIPTION>	
        '								6.	<REQUEST_ID> ->string of request ids
        ' Dependencies          :	None.
        ' Author                :	Rajanikant
        ' Created               :	Mar 02,2004
        ' Revisions             :
        '=====================================================================		

        Dim strUserName As String
        Dim strProjectName As String
        Dim dr As IDataReader
        Dim intMessageID As Integer
        Dim intCount As Integer
        Dim intID As Integer
        Dim arr() As String = {}
        Dim strRequests As String
        Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        '1. Code for String Builder Changes - IssueID - 6052 
        Dim strMessage As System.Text.StringBuilder
        Dim strEmailSubject As System.Text.StringBuilder

        intMessageID = 20044

        ' Get the message body, and subject.
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " & intMessageID, blnUseSQL)
        If dr.Read Then
            Subject = dr("Subject").ToString
            EmailMessage = dr("Body").ToString & ""
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        '2. Code for String Builder Changes - IssueID - 6052 
        strMessage = New System.Text.StringBuilder("")
        strEmailSubject = New System.Text.StringBuilder("")
        strMessage.Append(EmailMessage)
        strEmailSubject.Append(Subject)

        strUserName = HttpContext.Current.Session("strUserName").ToString

        ' Retrieve information about the Sender.
        FromEmailID = CommonFunction.EmailMessages.funcGetCompanyMailID()
        strMessage.Replace("<SENDER_NAME>", strUserName)

        ' If the request IDs is not specified, then exit the subroutine.
        If Trim(RequestID & "") = "" Then Exit Sub

        If blnMultipleRequests = True Then
            arr = Split(RequestID, ",")
            intID = CType(arr(0), Integer)
        Else
            intID = CType(RequestID, Integer)
        End If
        'Integrated by SandipL SP8 to SP9

        'Modified By NitinVS on 1 Mar 2007 for WhizibleSEM SP9 
        ' Added Parameter for EmailID 
        ' For Change Expected Resolution Date , Responsible Person Mail should not go to customer 
        'as it is an internal activity 

        'Intigrated by HarshK on 01/09/05 for sp4 issueid 139
        'Modified By PradeepD for Issue ID 20368 on 02-Aug-2005 ' Added RequestID insted of IntID
        dr = CommonFunctions.Data.GetDataReader("usp_NG2_sel_RequestMailDetails '" & RequestID & "'", blnUseSQL)
        'dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_MailTo_list " & intID, blnUseSQL)
        'end intigration
        'End Modification By NitinVS on 1 Mar 2007 for WhizibleSEM SP9 

        'End Integration by SandipL SP8 to SP9
        Do While dr.Read
            If Trim(dr("EMail").ToString & "") <> "" Then
                ToEmailID = dr("EMail").ToString & ""
            End If
            strMessage.Replace("<Request_ID>", RequestID)
            strMessage.Replace("<Subject>", dr("Subject"))

            ''Added by Usha Pandit on 29.12.2018 for Acknowledgement Mail issue Regards Replace with Admin
            strMessage.Replace("<USERNAME>", "Admin")

            ''End of Added by Usha Pandit on 29.12.2018 for Acknowledgement Mail issue Regards Replace with Admin
            'Added By Usha Pandit On 29.01.2020 For extracting Request Id from subject as per new signature
            strEmailSubject = strEmailSubject.Replace("<REQUEST_ID>", RequestID)
            'End Of Added By Usha Pandit On 29.01.2020 For extracting Request Id from subject as per new signature

        Loop
        CommonFunctions.Data.DisposeDataReader(dr)

        '4. Code for String Builder Changes - IssueID - 6052 
        EmailMessage = strMessage.ToString
        Subject = strEmailSubject.ToString

        '5. Code for String Builder Changes - IssueID - 6052 
        strMessage = Nothing
        strEmailSubject = Nothing
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckCustomerAbbName(ByVal Flag As String, ByVal AbbName As String, ByVal CustomerID As String)
        '==================================================================================
        ' Procedure Name	:	CheckCustomerAbbName
        ' Purpose			:	To check is duplicate Role Description
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Dipali V
        ' Created			:	13-Dec-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            If Flag = "Customer" Then
                strSQL = "usp_NG2_Sel_All_CustomerIDExistOrNot '" & AbbName & "'," & CustomerID & ""
            Else

                strSQL = "usp_NG2_Sel_All_CheckExistCustomerCilent '" & AbbName & "'," & CustomerID & ""
            End If
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
End Class