Public Class CRM_UnlockUser
    Inherits WebPages.Template.WhizTemplate
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private WithEvents objUnlockUserGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected Shared TagID As Integer = 22199
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        GetAccessRights()
    End Sub
    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	08 DEC 2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    Private Function PlotUnlockUserGrid() As String
        '=====================================================================
        ' Procedure Name        :	PlotUnlockUserGrid
        ' Purpose               :	Get the Locked User Details
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	08 DEC 2017
        ' Revisions             :
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String = {}
        Dim arrstrUserFriendlyList() As String = {}
        Dim arrstrLinkArray() As String = {}
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String = {}
        Dim arrTopMenuToolTipsList() As String = {}
        'Dim ArrTopMenuToolTipsList As New ArrayList
        Dim Flag As Integer = 0

        If m_objAccess.View Then
            intNoOfDataColumn = 5
            strDivID = "divUnlockUser"
            strSQLQuery = "USP_NG2_SEL_tbl_PM_Login_Locked"

            arrstrActualList = {"EmployeeName", "LoginName", "IsLocked", "LastAttempts", "Select"}
            arrstrUserFriendlyList = {"User Name", "Login Name", "Is Locked", "Locked Date", "Select"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=center", "align=left", "align=left"}
            arrTopMenuToolTipsList = {"", "", "", "{}Title='Locked Date And Time'", ""}
            objGrid = objUnlockUserGrid
        Else
            Flag = 1
        End If
        If Flag = 0 Then
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .TDStyleArray = arrTopMenuToolTipsList
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                '.ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                '.ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
        End If
        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetGridData(ByVal GridParam As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetGridData
        ' Parameters Passed		:	None
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Get Locked User Data
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   08 DEC 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_UnlockUser


            strGridHTML.Append(objSetting.PlotUnlockUserGrid())
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Protected Sub PlotHTML()
        '=====================================================================
        ' Procedure  Name		:	PlotHTML
        ' Parameters Passed		:	None
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To generate Unlock User Page HTML Dynamically
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   08 DEC 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
         

            strGridHTML.Append("<div class='type-top-bar top-bar' id='EmployeeFilter'>")
            strGridHTML.Append("<ul class='left'>")
            strGridHTML.Append("<li class='search-bar'>")
            strGridHTML.Append("<div class='left search-bar'>")


            '/*Changed By Yasmin on 25th july 2018*/
            strGridHTML.Append("<i id='idSearchHistory' class='fa fa-search faSettingSearch' aria-hidden='true'></i>")
            'strGridHTML.Append("<button class='search-bt'><i class='fa fa-search' aria-hidden='true'></i></button>")
            strGridHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search in table'>")
            strGridHTML.Append("</li>")
            strGridHTML.Append("</ul>")
          


            'strGridHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true' style='margin-top: 8px'></i>")
            ''strGridHTML.Append("<input type="text" id="txtSearchHistory" placeholder="Search History" title="Type in a name">")

            'strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearchHistory", "txtSearchHistory", "form-control placeholder='Search History'", 219, , , , , , , , , " class='form-control'   ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'"))
            'strGridHTML.Append("</div>")
            'strGridHTML.Append("</li>")
            'strGridHTML.Append("</ul>")
            'strGridHTML.Append("<ul class='right'>")
            'strGridHTML.Append("<li class='clearall'>")
            'strGridHTML.Append("<button type='button' class='btn btn-default' onclick='AddEmployee()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            If m_objAccess.Edit Then
                strGridHTML.Append("<ul class='right'>")
                strGridHTML.Append("<li class='clearall'><button type='button' class='btn btn-default save'  onclick='unlockUser()'>Unlock</button></li>")
                strGridHTML.Append(" </ul>")
            End If
           
            'strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDepartmentCode", "txtDepartmentCode", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")


            strGridHTML.Append("</div>")
            strGridHTML.Append("<div class='table-responsive' id='tbldivUnlockUser'>")
            strGridHTML.Append(GetGridData(""))
            strGridHTML.Append("</div>")
          

            'strGridHTML.Append("<div id='divMainBlock' style='overflow:hidden;width:100%;'>")

            'strGridHTML.Append("<div id='Department' style='overflow:auto;width:103%;' class='tabcontent1 h-form h-type clsSettingstabs'>")

            'strGridHTML.Append("<div id='divMainBlock' style='overflow:hidden;width:100%;'>")

            'strGridHTML.Append("<div id='divSubMainBlock' style='overflow:auto;width:102%;'>")

            'strGridHTML.Append("<div id='divMainBlock' style='overflow:auto;width:102%;'>")
            'strGridHTML.Append("</div>")
            'divMainblock end
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)

        Catch ex As Exception

        End Try
    End Sub
    <System.Web.Services.WebMethod> _
    Public Shared Function UnlockUser(ByVal LoginID As String) As String
        '=====================================================================
        ' Procedure  Name		:	UnlockUser
        ' Parameters Passed		:	LoginID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Unlock Selected Users
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   08 DEC 2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            'LoginID = Utilities.Security.SecurityBuilder.CheckUserInput(LoginID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            If CommonFunction.RateLimiter.CheckRateLimit(request) Then
                response.StatusCode = 429
                response.Write("Bad Request found")
                Return "Bad Request found"
            End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strPassword As String = ""
            'Dim drEmail As IDataReader
            Dim drEmailData As IDataReader
            Dim strFromEmailID As String
            Dim strToEmailID As String
            Dim strUserName As String
            Dim strSenderName As String
            Dim strEncryptedNewPassword As String
            Dim MsgFlag As String = ""


            Dim strResult As String = ""

            Dim arrLoginIds() As String

            Dim index As Integer = 0

            If LoginID = "" Or LoginID Is Nothing Then
                LoginID = "0"
            End If

            If LoginID.Contains(",") Then

                arrLoginIds = LoginID.Split(",")

                For index = 0 To arrLoginIds.Length - 1
                    Dim strSQL As String = "EXEC usp_upd_tbl_PM_Login_LockUnlock  " & arrLoginIds(index)
                    strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

                    '--------------------------------------------------------
                    Dim objCreateNewPassword As New CreateNewPassword()
                    strPassword = objCreateNewPassword.CreatePassword()

                    drEmailData = CommonFunction.Data.GetDataReader("Usp_sel_LockedUser_Details " & arrLoginIds(index) & "," & HttpContext.Current.Session("intUserID").ToString & "", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drEmailData.Read Then
                        strFromEmailID = CStr(drEmailData("FromMailID"))
                        strToEmailID = CStr(drEmailData("ToMailID"))
                        strUserName = CStr(drEmailData("Username"))
                        strSenderName = CStr(drEmailData("SenderName"))
                    End If

                    Dim objEncryptNewPassword As New Authentication.PWEncryption(strUserName, strPassword)

                    'Get the encrypted password
                    strEncryptedNewPassword = objEncryptNewPassword.Encrypt()

                    CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Login_Password " & arrLoginIds(index) & ",'" & strEncryptedNewPassword & "','" & HttpContext.Current.Session("strUserName").ToString & "'", True)


                    Dim strLoginName As String
                    Dim strUserType As String

                    Dim drEmail As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 20033", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    Dim blnSendEmail As Boolean = False
                    Dim blnShowPopup As Boolean = True

                    Dim strCCToEmailID As String
                    Dim strSubject As String
                    Dim strEmailMessage As String

                    Dim strMessage As New System.Text.StringBuilder("")

                    ' Retrieve information about the mail message.
                    If drEmail.Read Then
                        blnSendEmail = CType(drEmail("SendMail"), Boolean)
                        blnShowPopup = CType(drEmail("ShowPopup"), Boolean)

                        strSubject = CStr(drEmail("Subject"))
                        strEmailMessage = CStr(drEmail("Body"))
                    End If
                    'dispose
                    CommonFunction.Data.DisposeDataReader(drEmail)

                    strMessage.Append(strEmailMessage)

                    strMessage.Replace("<LOGIN_NAME>", strUserName)
                    strMessage.Replace("<NEW_PASSWORD>", strPassword)

                    strMessage.Replace("<SENDER_NAME>", strSenderName)

                    strEmailMessage = strMessage.ToString

                    If blnSendEmail = True Then
                        If blnShowPopup = False Then
                            'Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                        Else
                            'Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                        End If
                    End If

                    strMessage = Nothing
                    '-----------------------------------------------------------------
                Next
            Else
                Dim strSQL As String = "EXEC usp_upd_tbl_PM_Login_LockUnlock  " & LoginID
                strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

                '--------------------------------------------------------
                Dim objCreateNewPassword As New CreateNewPassword()
                strPassword = objCreateNewPassword.CreatePassword()

                drEmailData = CommonFunction.Data.GetDataReader("Usp_sel_LockedUser_Details " & LoginID & "," & HttpContext.Current.Session("intUserID").ToString & "", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailData.Read Then
                    strFromEmailID = CStr(drEmailData("FromMailID"))
                    strToEmailID = CStr(drEmailData("ToMailID"))
                    strUserName = CStr(drEmailData("Username"))
                    strSenderName = CStr(drEmailData("SenderName"))
                End If

                Dim objEncryptNewPassword As New Authentication.PWEncryption(strUserName, strPassword)

                'Get the encrypted password
                strEncryptedNewPassword = objEncryptNewPassword.Encrypt()

                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Login_Password " & LoginID & ",'" & strEncryptedNewPassword & "','" & HttpContext.Current.Session("strUserName").ToString & "'", True)


                Dim strLoginName As String
                Dim strUserType As String

                Dim drEmail As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 20033", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = True

                Dim strCCToEmailID As String
                Dim strSubject As String
                Dim strEmailMessage As String

                Dim strMessage As New System.Text.StringBuilder("")

                ' Retrieve information about the mail message.
                If drEmail.Read Then
                    blnSendEmail = CType(drEmail("SendMail"), Boolean)
                    blnShowPopup = CType(drEmail("ShowPopup"), Boolean)

                    strSubject = CStr(drEmail("Subject"))
                    strEmailMessage = CStr(drEmail("Body"))
                End If
                'dispose
                CommonFunction.Data.DisposeDataReader(drEmail)

                strMessage.Append(strEmailMessage)

                strMessage.Replace("<LOGIN_NAME>", strUserName)
                strMessage.Replace("<NEW_PASSWORD>", strPassword)

                strMessage.Replace("<SENDER_NAME>", strSenderName)

                strEmailMessage = strMessage.ToString

                If blnSendEmail = True Then
                    If blnShowPopup = False Then
                        'Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    Else
                        'Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If

                strMessage = Nothing
                '-----------------------------------------------------------------
            End If

            'Send Email

            'Call SendMail(LoginID, strPassword, strFromEmailID, strToEmailID, strUserName, strSenderName) 'To send mail to user about his password got reset.


            Return "Success" & "||" & MsgFlag & "||" & strUserName.ToString & "||" & strPassword.ToString

        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function

    Private Sub objUnlockUserGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objUnlockUserGrid.ColumnHeaderTD_BeforePrint
        Try

            If Args.DataField.ToUpper = "SELECT" Then
                Cancel = True

                Args.StringToBeInserted = "<th style='text-align:center;'><input type=checkbox name='sample'  title='Select All'  onclick='SelectMultipleUsers()' id='chkUserSelectAll' /></th>"
            End If


        Catch ex As Exception

        End Try
    End Sub
    Private Sub objUnlockUserGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objUnlockUserGrid.DataRowTD_BeforePrint
        Try

            If Args.DataField.ToUpper = "SELECT" Then
                Cancel = True

                Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id ='chkLockUserSelect'   value='" & Args.DataReader("LoginID") & "' /></td>"
            End If

            If Args.DataField.ToUpper = "LASTATTEMPTS" Then
                Args.ShowTimeWithDate = True
                Args.TDStyle = " NoWrap title='Locked Date And Time'"
            End If

            'If Args.DataField.ToUpper = "EDIT" Then
            '    Cancel = True

            '    Args.StringToBeInserted = "<td align='center' Title = 'Department'><i class='fa fa-pencil-square-o' aria-hidden='true' style='cursor:pointer;' onclick=""getEntityDetails(" & Args.DataReader("DepartmentID") & ")""></i></TD>"

            'End If

            'If Args.DataField.ToUpper = "DELETE" Then
            '    Cancel = True

            '    'Args.StringToBeInserted = "<td align='center' Title = 'DeleteDepartment'><i class='fa fa-trash-o' aria-hidden='true' onclick=""DeleteDepartment(" & Args.DataReader("DepartmentID") & ")""></i></TD>"

            'End If
        Catch ex As Exception

        End Try
    End Sub

End Class