Public Class PM_ResourcesAttachment
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_strFileName As String = ""
    Protected m_strPKToken As String = ""


    Protected m_strAction As String = ""

    Protected m_strMode As String = ""

    Private m_blnUseSQL As Boolean
    Protected m_lngMaxLength As Long = 100
    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
    Protected m_intTagID As Integer
    Protected APP_TAG_REPOSITORY As Integer = 800
    'Protected APP_TAG_EMPLOYEE As Integer = 23
    'Protected APP_TAG_JOININGPOOL As Integer = 3873
    '' Added By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 
    'Protected APP_TAG_EMPLOYEE_PAYROLL As Long = 3949
    '' End Addition By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 

    ''Added By VarunA on 23-Mar-2009 IssueID-28582
    ''Purpose : To upload Approved Employee Leave through Excel Upload.
    'Protected APP_TAG_EmployeeLeaves As Integer = 1207

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Initrole(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        'Call Initialize()
        'If Page.IsPostBack Then
        '    Call PerformActions()
        'End If

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        Call Initialize()

    End Sub
    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : ArchanaN
        ' Created               : 17 Dec 2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strPath As String
        Dim strFileName As String
        Dim strOriginalFileName As String

        Dim strTemplateID As String
        Dim strRequestID As String
        Dim strTemplateSQL As String

        If UCase(Trim(m_strAction & "")) = "ATTACH" Then
            ' The path 

            strPath = Server.MapPath("../../Attachments/DXU/Requests")

            ' the system file name
            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

            ' upload the file
            Dim objFile As New FileUpload.cUpload("txtFileName", strPath, strFileName)
            objFile.OverwriteIfExists = True
            objFile.UploadFile()

            ' the file name
            strOriginalFileName = objFile.OriginalFileName
            strFileName = objFile.UploadedFileName
            objFile = Nothing


            'Create an Request Entry
            strTemplateSQL = " usp_PM_GetTemplateName " & m_intTagID
            strTemplateID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strTemplateSQL, MyBase.UseSQL), "0"), "0")
            strSQL = " usp_Ins_ResourcePoolDXURequest " & Session("intUserID").ToString '& "," & CStr(Session("intProjectID"))
            strSQL &= ", " & strTemplateID '& "," & m_strID
            strSQL &= ", " & m_intTagID

            strRequestID = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString()


            strSQL = "Exec usp_Ins_tbl_HR_ResourceAttachments " & strRequestID & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
            strSQL &= ", '" & CommonFunctions.General.BuildQueryString(strFileName) & "', '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "'"     '" & CommonFunctions.General.BuildQueryString(strDescription) & "'"

            If Trim(strSQL & "") <> "" Then
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
            End If



            Dim objRequest As New DataExchangeLib.Request
            With objRequest
                .ConnectionString = CommonFunction.General.GetConnectionString
                .LogFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Logs")
                .RejectedRecordsFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/RejectedFiles")
                .UploadedFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Requests")
                .SpecialRequestTemplateFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU")
                .RequestID = CInt(strRequestID)
                .Post()
            End With
            objRequest = Nothing

            ' To add the record in Resource Joining Pool 
            Dim strReqSQL As String
            Dim strinsSQL As String

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strReqSQL = " IF Exists(Select 1 from tbl_DXU_UploadRequestsQueue where RequestID = " + strRequestID + " And Status='I') Exec usp_DXU_TransferRequestData " + strRequestID
            strReqSQL = "usp_tbl_DXU_UploadRequestsQueue_RequestID " + strRequestID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If Trim(strReqSQL & "") <> "" Then
                CommonFunctions.Data.InsertOrUpdateData(strReqSQL, True)
            End If

            Dim strScript As String
            strScript = vbCrLf + "<Script language=javascript>"
            'strScript += vbCrLf + "    refreshParent('frmHR_Attachment','HR_Attachment.aspx','HR_Attachment.aspx');"
            If m_intTagID = 3949 Then
                strScript += vbCrLf + "    refreshParent('frmCommonList','EmployeePayroll_CommonList.aspx','../PRJPROFIT/EmployeePayroll_CommonList.aspx?MasterTagID=3949&FromWhere=RM');"
            Else
                strScript += vbCrLf + "    refreshParent('frmCommonList','PM_ResourcesAttachment.aspx','PM_ResourcesAttachment.aspx?MasterTagID=800&FromWhere=RM');"
            End If

            strScript += vbCrLf + "</Script>"
            CommonFunction.General.WriteHTML(strScript)
        End If
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the variables
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 17 Dec 2007
        ' Revisions             :
        '=====================================================================
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        If Not Request.Form("txtPkToken") Is Nothing Then
            m_strPKToken = Request.Form("txtPkToken").ToString
        End If

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_intTagID = CType(Request.QueryString("MasterTagID"), Integer)
        If m_intTagID <> 0 Then
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '' CommonFunction.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , CType(m_intTagID, String), , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , CType(m_intTagID, String), , , , , , True, EnableHTMLEncode:=True)
        End If

        If m_intTagID = 0 Then
            m_intTagID = CType(Request.Form("txtTagID"), Integer)
        Else
            m_intTagID = CType(Request.QueryString("MasterTagID"), Integer)
        End If

    End Sub

    Protected Sub WritePage()

        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 17 Dec 2007
        ' Revisions             :
        '=====================================================================

        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If

        If Request.QueryString("Action") = "DELETEDETAILS" Then
            DeleteDetails()
        End If

        Dim arrMenu() As String = {"Upload", "Download Template", "Select All", "Clear All", "Delete", "Close"}
        Dim arrMenuToolTip() As String = {"Upload", "Download Template", "Select All", "Clear All", "Delete", "Close"}
        Dim arrCSFunction() As String = {"Attach_OnClick()", "Download_onclick()", "SelectAll_Onclick()", "ClearAll_Onclick()", "DeleteDetails_OnClick()", "Close_OnClick()"}

        Dim strSQL As String
        Dim dr As IDataReader
        ' Dim strTemplateSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write("<DIV ID='divList' Style='Height:620px;WIDTH:100%;OVERFLOW:auto;'>")
            .Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            .Write("<TR class=clsTRPageCaption><TD align=Left>Upload Excel </TD></TR></TABLE>")
            .Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            .Write("<TR class=clsTREven><TD align=Left> Please upload only Excel files. (.xls extension files) </TD></TR></TABLE>")
            .Write("<BR>")
            .Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("" + "Select File" + "")
            .Write("</TD>")

            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'", , , 1)
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken, , , , , , , , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            ' Message Table
            .Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='5%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            .Write("<TR>")
            .Write("<TD height='20'>")
            .Write("&nbsp;</TD></TR>")
            .Write("<TR><TD align=center class=clsTDEven>")
            .Write("<LABEL id=lblFileUploadStatus><B>Uploading file...Please wait !!</B></LABEL>")
            .Write("</TD></TR>")
            .Write("</TABLE>")
            .Write("<BR>")
            drawGrid()
            .Write("</DIV>")
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub
    Private Sub drawGrid()
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strSQLQuery As String
        Dim drGetLevel As IDataReader
        Dim intUserID As String
        Dim strWhere As String

        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
            If CType(HttpContext.Current.Session("LoginType"), String) = "E" Then
                strWhere = " Where EmployeeID = " & CType(Session("intUserID"), String)
            Else
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        Else
            strWhere = " "
        End If


        'If m_intTagID = APP_TAG_EMPLOYEE Then
        '    strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
        '                             & " from v_tbl_PM_Employee_Attachment  " & strWhere & " order by AttachedBy  ,dateAttached desc"


        'ElseIf m_intTagID = APP_TAG_JOININGPOOL Then
        '    strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
        '                     & " from v_tbl_PM_Employee_OfferedAttachment " & strWhere & " order by AttachedBy  ,dateAttached desc"
        '    'Added By VarunA on 23-Mar-2009 IssueID-28582
        '    'Purpose : To upload Approved Employee Leave through Excel Upload.
        'ElseIf m_intTagID = APP_TAG_EmployeeLeaves Then
        '    strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
        '                     & " from v_tbl_PM_Employee_LeaveAttachment " & strWhere & " order by AttachedBy  ,dateAttached desc"
        '    'End by VarunA on 23-Mar-2009 IssueID-28582
        'End If

        If m_intTagID = APP_TAG_REPOSITORY Then
            strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
                                     & " from v_tbl_PM_CorporateRisks_RepositoryAttachment  " & strWhere & " order by AttachedBy  ,dateAttached desc"
        End If

        ' Added By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 
        'If m_intTagID = APP_TAG_EMPLOYEE_PAYROLL Then
        '    strSQL = " usp_SEL_tbl_PM_Employee_Payroll_Attachment " + CType(Session("intUserID"), String) + "," + CType(HttpContext.Current.Session("intPostID"), String)
        'End If
        'End Added By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 

        Dim arrColumnHeadingList() As String = {"Attached By", "Original File Name", "Attached Date", "View Rejected File", "Delete"}
        Dim arrActualColumnNames() As String = {"AttachedBy", "OriginalFileName", "DateAttached", "ViewRejectedFile", ""}
        Dim arrTDStyle() As String = {"align=left style='width=15%'", "align=left width=25%", "align=left width=15%", "align=center width=25%", "align=center width=5%"}
        Dim arrGroupColName() As String = {"Attached By"}

        'CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width=100%'>")
        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 3
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivGrid"
            .DIVHeight = 100%
            .SQL = strSQL
            .UseSQL = True
            .GroupOnColumn = arrGroupColName
            .PrimaryKey = "AttachmentID"
            '.SortBy = "AttachedBy,DateAttached"
            '.SortOrder = "Desc"
            .DrawGrid()

        End With
        m_objGrid = Nothing
        'CommonFunctions.General.WriteHTML("</DIV>")
        '
    End Sub
    Private Sub DeleteDetails()
        Dim m_strRequestID As String
        Dim arrIDs() As String
        Dim lenArray As Integer

        If CType(Request.Form("chkDelete"), String) <> "" Then
            m_strRequestID = CType(Request.Form("chkDelete"), String)

            arrIDs = m_strRequestID.Split(CType(",", Char))
            'Now Insert Into Table
            For lenArray = 0 To arrIDs.Length - 1
                If (arrIDs(lenArray) <> "") Then
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''CommonFunctions.Data.InsertOrUpdateData("DELETE FROM tbl_DXU_UploadRequestsQueue WHERE RequestID = " + arrIDs(lenArray), MyBase.UseSQL)
                    CommonFunctions.Data.InsertOrUpdateData("usp_del_tbl_DXU_UploadRequestsQueue_RequestID " + arrIDs(lenArray), MyBase.UseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                End If
            Next
        End If
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "VIEWREJECTEDFILE" Then
            If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "T" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) <> "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center Title=""View Rejected File""><A href=javascript:ViewRejectedFile(""" & CStr(Args.DataReader("RequestID")) & ".xls" & """) >" & "View Rejected File" & "</A></TD>"

            ElseIf CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "T" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) = "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center>Below Acceptable Threshold</TD>"

            Else
                If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "E" Then
                    Cancel = True
                    Dim strErrmsg As String
                    If Not Args.DataReader("Errmsg") Is DBNull.Value Then
                        strErrmsg = CStr(Args.DataReader("Errmsg"))
                    Else
                        strErrmsg = "Invalid template Used"
                    End If
                    Args.StringToBeInserted = "<TD align=center>Invalid Template</TD>"
                    'Args.StringToBeInserted += "<SPAN onmouseover=""DisplayTooltipCL('<iframe height=325px width=425px scrolling=no src=../DXU/DXU_Popup.aspx?RequestID=" & CStr(Args.DataReader("RequestID")) & "></iframe>')"" onmouseout=""DisplayTooltipCL('')""><U>Invalid Template</U></SPAN></TD>"

                Else
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=center>-</TD>"
                End If

            End If

        End If

        If Args.DataField.ToUpper = "ORIGINALFILENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("SystemFileName")) & """,'DXU') >" & CStr(Args.DataReader("OriginalFileName")) & "</A></TD>"

        End If

        If Args.ColumnName = "Delete" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , CType(Args.DataReader("RequestID"), String), , , True) + "</td>"
        End If

    End Sub


End Class
