Imports System
Imports System.IO
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Xml
Imports System.Runtime.InteropServices

Public Class CRM_AddNewRequest
    Inherits WebPages.Template.WhizTemplate
    Private m_blnUseSQL As Boolean

    '' Protected m_strMode As String = ""
    Private m_strAction As String = ""
    Protected m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Protected m_strUserName As String = ""
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected m_intRoleID As String = ""
    Public GlobalDepartment As String = ""
    Protected m_blnSLAAccess As Boolean = False
    Private arrValidationMessages(50) As String
    'Validation script for custom fields
    Private strSelectedValues As String
    Protected m_strCustomFieldList As String = ""
    Protected m_intCustomer As Integer = 0
    Protected m_strVal As String = ""
    Dim dr As IDataReader
    Protected m_StatusFlowCount As Integer
    Protected m_strMode As String = "New"
    Protected blnDisableStatusCombo As Boolean = False
    Protected RequestID As String = "0"
    Protected intStatusID As Integer = 0
    Protected m_lngSubRequestTypeID As String
    Protected lngProductID As String = "0"
    Public ShowProductCombo As String = "0"
    Public blnDisableProjectCombo As Boolean = False
    Protected Shared blnIsHRM As Integer = 0
    Protected m_blnIsAllowDeleteAtDeptLevel As String = ""
    Protected blnSendMail As String = ""
    Protected blnShowPopup As String = ""
    Protected m_intRequestedEmployee As Integer = 0
    Protected m_strRequestedEmployee As String = ""
    Protected m_strRequestedEmployeeUN As String = ""
    Protected m_intRequestedEmployeePost As Integer = 0
    Dim blnDisableFunctionCombo As Boolean = False
    Protected EmployeeID As String = "0"
    Protected RequestedEmployee As String = "0"
    Protected Shared strClientSideScript As String = ""
    'Added by Amol Changle for Custom Field Functionality on 21 Jul 2009
    Protected strDefaultScript As String 'Script to store values of custom fields from another Controls
    ' Protected strClientSideScript As String 'Validation script for custom fields
    Protected declarevariables As String = "" 'Custom Fields objects Declaration script
    Private m_strCurrentType As String = ""
    Protected m_blnShowDefaults As Boolean = False 'Show defaults in add new mode only? 
    'Protected m_strCustomFieldList As String = ""
    Protected m_strEnableControlScript As String = ""
    Private UserIDForCustomFields As Integer = 0
    Private m_strLoginTypeForCustomField As String = ""
    'End addition by Amol Changle on 21 Jul 2009


    Private m_strFormName As String        'FormName on which CustomFields are to be plotted
    Public m_lngProjectId As Long
    Public m_lngRoleId As Long
    Public m_lngUserId As Long
    Private m_strTypeInaccessibleCustomFieldList As String
    Private m_strEntityName As String = "Task" 'can be Delivarble,Review etc
    Private m_intMaxRows As Integer
    Private m_intMaxCols As Integer

    Private ArrCtlAttr(20) As String            'array to store Properties of Custom Fields such as name,caption,ht etc
    Private arrEventHandlers(30, 3) As String
    Private strFieldValue As String = ""
    Private strDummyFieldValue As String = ""
    Private m_strPrimaryKey As String           'can have value TaskID,ScheduleID,ReviewID etc
    Private m_strPrimaryTable As String         'Table From which Custom field Values  to be retrived
    Private m_strPrimaryKeyID As Long
    Private strEventHandlers As String

    Public IsAddNewMode As Boolean
    Public QueryStringForTypeChange As String 'Query string Passed to URL for Type change e.g "TaskTypeID"


    Protected m_strInputDateFormatVB As String

    'Commented and Added By Bharat T on 9th-Oct-2015
    'Private arrValidationMessages(30) As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        'If CommonFunction.Application.EnableProductExecution = True Then
        '    dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + HttpContext.Current.Request.Form("CboDepartment").ToString, True)

        '    If dr.Read Then
        '        ShowProductCombo = "1"
        '    End If
        '    CommonFunction.Data.DisposeDataReader(dr)
        'End If

        If Request.QueryString("Mode") = "CustomField" Then 'DepartmentID
            PlotCustomFieldsDetails(Request.QueryString("SubRequestTypeID"), Request.QueryString("RequestTypeID"), Request.QueryString("DepartmentID"), 0, HttpContext.Current.Session("intUserID"), HttpContext.Current.Session("LoginType"), Request.QueryString("CustomerID"))
        End If

        Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
        If Request.Params("Mode") = "FileAttachment" Then

            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""
            Dim intProjectDrawingID As Integer
            Dim infile As Integer
            Dim strDocType As String
            Dim strPath As String = ""
            'Added By Bharat T on 10th-Aug-2017 for drawing upload folder structre change
            Dim strFolderPath As String = ""
            Dim RequestID As String = ""
            'End of Added By Bharat T on 10th-Aug-2017 for drawing upload folder structre change
            Dim strDescription As String = ""
            Dim strInteranlCheck As String = ""

            'Added By Bharat T on 10th-Aug-2017 for drawing upload folder structre change
            '' strFolderPath = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Sel_Drawing_FolderPath " & intProjectDrawingID, True))
            'End of Added By Bharat T on 10th-Aug-2017 for drawing upload folder structre change

            'StageID = Request.Params("StageID")
            Dim strProcessData() As String

            RequestID = CommonFunctions.General.CheckIsNothing(Request.Params("RequestID"), "0")
            Dim count As Integer
            Dim intCheckValid As Integer = 0
            Dim strResult As String = ""
            count = 0
            'While (Request.Files.Count) > count
            '    Dim response As String = String.Empty
            '    Dim file As HttpPostedFile = Context.Request.Files(count)
            '    Dim buffer As Byte() = New Byte(256) {}
            '    Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            '    Dim MimeType As String
            '    file.InputStream.Read(buffer, 0, 256)
            '    file.InputStream.Position = 0

            '    Dim magicNumber As String = BitConverter.ToString(buffer)
            '    magicNumber = magicNumber.Replace("-", " ")
            '    Dim xmlDoc As New XmlDocument()
            '    Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
            '    xmlDoc.Load(xmlPath + "MIMEType.xml")
            '    Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
            '    Dim xMagicNumber As String = "", xContentType As String = ""
            '    For Each node As XmlNode In nodes
            '        xMagicNumber = node.SelectSingleNode("MagicNumber").InnerText

            '        Dim xsubstring As String = magicNumber.Substring(0, Convert.ToInt32(xMagicNumber.Length))
            '        'If Convert.ToInt32(xMagicNumber.Length) > 25 Then
            '        '    xMagicNumber.Substring(0, 25)
            '        'End If
            '        If xsubstring = xMagicNumber Then
            '            MimeType = node.SelectSingleNode("ContentType").InnerText
            '            Exit For
            '        Else
            '            Dim fileName As String = file.FileName
            '            Dim ext As String = Path.GetExtension(fileName)
            '            ext = ext.Substring(1, ext.Length - 1)
            '            If ext = xMagicNumber Then
            '                MimeType = node.SelectSingleNode("ContentType").InnerText
            '            End If
            '        End If


            '    Next

            '    If MimeType Is Nothing Then
            '        MimeType = "unknown/unknowns"
            '    End If




            '    If strListofTypes.IndexOf(MimeType) >= 0 Then
            '    Else
            '        intCheckValid = 1
            '    End If
            '    count += 1
            'End While

            If intCheckValid = 1 Then
                Response.Write("1")
                Response.End()
            End If
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

                        ''Added 

                        ' strOriginalFileName = Request.Files(0).FileName
                        'strPath = Server.MapPath("../../Attachments/CRM/")
                        'Dim objFile As New FileUpload.cUpload(Request.Files.Keys.Item(count), strPath, strFileName)
                        ''strOriginalFileName = objFile.OriginalFileName



                        'objFile.OverwriteIfExists = True
                        'objFile.UploadFile()

                        '' the file name
                        'strOriginalFileName = objFile.OriginalFileName
                        'strFileName = objFile.UploadedFileName
                        'strFileName &= strFileExtension
                        'objFile = Nothing

                        Dim buffer As Byte() = New Byte(256) {}
                        Dim MimeType As String = ""

                        Dim fileName As String = HttpContext.Current.Request.Files(count).FileName
                        Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
                        Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
                        Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
                        Dim CharList As String()
                        Dim IsFileNameValid As Integer = 1
                        Dim ExtensionList As String()
                        CharList = ValidateFileName.Split(","c)
                        For k As Integer = 0 To CharList.Length - 1
                            If fileName.Contains(CharList(k).ToString) Then
                                fileName1 = fileName1.Replace(CharList(k).ToString, "")
                            End If
                        Next
                        ExtensionList = fileName.Split("."c)
                        If ExtensionList.Length > 2 Then
                            IsFileNameValid = 0
                        End If
                        If fileName = fileName1 And IsFileNameValid = 1 Then
                            Dim file As HttpPostedFile = Context.Request.Files(count)
                            Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(count))
                            file.InputStream.Read(buffer, 0, 256)
                            file.InputStream.Position = 0
                            Dim magicNumber As String = BitConverter.ToString(buffer)
                            magicNumber = magicNumber.Replace("-", " ")
                            Dim xmlDoc As New XmlDocument()
                            Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                            xmlDoc.Load(xmlPath + "MIMEType.xml")
                            Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                            Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

                            'Added by imran on 02-01-2023
                            'Dim fileNameExtention As String = HttpContext.Current.Request.Files(count).FileName
                            'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                            'Dim tcount As Integer = ext1.Split("."c).Length - 1
                            'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                            'If tcount > 1 Then
                            '    MimeType = ""
                            'End If
                            'End of comment by imran on 02-01-2022

                            'If count = 1 Or count2 = 1 Then
                            For Each node As XmlNode In nodes
                                    xContentType = node.SelectSingleNode("ContentType").InnerText
                                    If strFileType = xContentType Then
                                        fileName = HttpContext.Current.Request.Files(count).FileName
                                        Dim ext As String = Path.GetExtension(fileName)
                                        ext = ext.Substring(1, ext.Length - 1).ToLower()
                                        extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
                                        If extfromContentType.IndexOf(ext) > -1 Then
                                            MimeType = strFileType
                                            Exit For
                                        End If
                                    End If
                                Next
                                'End If
                            Else
                            MimeType = ""
                        End If

                        If MimeType Is Nothing Or MimeType = "" Then
                            MimeType = "unknown/unknowns"
                        End If

                        If strListofTypes.IndexOf(MimeType) >= 0 Then
                            '  strFolderPathToSave = strFolderPath
                            'End of Commented and Added By Bharat T on 10th-Aug-2017 for drawing upload folder structre change
                            strOriginalFileName = System.IO.Path.GetFileName(Request.Files(count).FileName)
                            'strFileName = objFile.UploadedFileName
                            strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                            strFileName &= strFileExtension
                            ' Save the uploaded file to "UploadedFiles" folder
                            Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Attachments/CRM/"), strFileName)
                            Request.Files(count).SaveAs(fileSavePath)
                            ''infile = FileHandlingUtility.FileHandlingUtility.Encrypt(Request.Files(0), fileSavePath, True)
                            'strSQLQuery = "usp_App_Ins_tbl_EPC_Drawings_Attachements " & intProjectDrawingID & ",'" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & ",'" & strDocType & "','" & strRevisionNo & "'"
                            strSQLQuery = "usp_CRM_Insert_Attachment " & RequestID & ",'" & strOriginalFileName & "','" & strFileName & "','" & HttpContext.Current.Session("strUserName") & "','" & strDescription & "','" & HttpContext.Current.Session("LoginType") & "','" & strInteranlCheck & "'"

                            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                        Else
                            strResult = "Invalid"
                        End If


                    Catch ex As Exception

                    End Try



                End If

                count += 1
            End While
            If strResult = "Invalid" Then
                Response.Write(strResult)
            Else
                Response.Write(strFileName & "||" & strOriginalFileName)
            End If


            Response.Write(strFileName & "||" & strOriginalFileName)
            Response.End()

        End If
    End Sub
    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function
    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr
        Dim MaxContent As Integer = CInt(file.ContentLength)
        If MaxContent > 200 Then MaxContent = 200
        Dim buf As Byte() = New Byte(MaxContent - 1) {}
        file.InputStream.Read(buf, 0, MaxContent)
        Dim result As Integer = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, Nothing, 0, mimeout, 0)

        If result <> 0 Then
            Marshal.FreeCoTaskMem(mimeout)
            Return ""
        End If

        Dim mime As String = Marshal.PtrToStringUni(mimeout)
        Marshal.FreeCoTaskMem(mimeout)
        Return mime.ToLower()
    End Function

    Public Function PageInit(ByVal Flag As String, ByVal CustomerID As String, ByVal EmployeeID As String, ByVal strVal As String)
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
        ' Created               : 3 May 2017
        ' Revisions             : None
        '=====================================================================

        'CommonFunctions.General.WriteHTML("<script>StartLoader('#fastTrackID');</script>")
        'DrawPage()
        Dim strHTML As New StringBuilder

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


        If Not strVal Is Nothing Then
            m_strVal = strVal
        Else
            m_strVal = strVal
        End If

        If Not CustomerID Is Nothing And CustomerID <> "" And CustomerID <> "0" Then
            ' If found then initialize page level variable and also session 
            m_intCustomer = CustomerID

        ElseIf Not CustomerID Is Nothing Then
            ' This part is required for post back to re-initialize variables 
            m_intCustomer = CustomerID
        Else
            ' If request is not by customer then remove customer ID
            m_intCustomer = 0
            'HttpContext.Current.Session.Remove("m_intCustomer")
            'HttpContext.Current.Session.Remove("m_strVal")
            'HttpContext.Current.Session.Remove("Customer")
        End If

        If EmployeeID Is Nothing And EmployeeID <> "" Then
            m_intRequestedEmployee = EmployeeID
            ' If Employee ID passed through "On Behalf of" page is same as one in session then request is being posted by logged in person
            If m_intRequestedEmployee = CType(m_lngEmployeeID, Integer) Then
                m_intRequestedEmployee = 0
            Else
                ' Otherwise request is being posted on behalf of other employee.
                ' So set that Employee ID in another session variable
                m_intRequestedEmployee = m_intRequestedEmployee
            End If

        End If

        ' Once you know Employee ID - Get his name, Role and User Name
        Dim drEmployee As IDataReader
        If m_intRequestedEmployee <> 0 Then
            Dim StrEmployee As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'StrEmployee = "Select EmployeeName,PostID,UserName From tbl_pm_employee where employeeid = " & m_intRequestedEmployee
            StrEmployee = "usp_sel_tbl_pm_employee_EmployeeName_PostID_UserName " & m_intRequestedEmployee
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drEmployee = CommonFunctions.Data.GetDataReader(StrEmployee, True)
            If drEmployee.Read Then
                m_strRequestedEmployee = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
                m_intRequestedEmployeePost = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("PostID"), "0"), Integer)
                m_strRequestedEmployeeUN = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("UserName"), ""), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)

        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)


        strHTML.Append(DrawRequestDetails(ShowProductCombo, "", m_intCustomer, EmployeeID))

        strHTML.Append("<INPUT type=hidden name='hdnUserName' id='hdnUserName' value=''>")
        strHTML.Append("<INPUT type=hidden name='hdnLoginType' id='hdnLoginType' value=''>")
        strHTML.Append("<INPUT type=hidden name='hdnCEmployeeID' id='hdnCEmployeeID' value=''>")

        If Flag.ToUpper = "LOAD" Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If

    End Function

    Function DrawRequestDetails(ByVal ShowProductCombo As String, ByVal DepartmentID As String, ByVal m_intCustomer As String, ByVal EmployeeID As String) As String
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        GlobalDepartment = DepartmentID
        m_intRequestedEmployee = EmployeeID


        If m_intRequestedEmployee = CType(HttpContext.Current.Session("intUserID"), Integer) Then
            m_intRequestedEmployee = 0
        Else
            m_intRequestedEmployee = m_intRequestedEmployee
        End If


        Dim drEmployee As IDataReader
        If m_intRequestedEmployee <> 0 Then
            Dim StrEmployee As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'StrEmployee = "Select EmployeeName,PostID,UserName From tbl_pm_employee where employeeid = " & m_intRequestedEmployee
            StrEmployee = "usp_sel_tbl_pm_employee_EmployeeName_PostID_UserName " & m_intRequestedEmployee
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drEmployee = CommonFunctions.Data.GetDataReader(StrEmployee, True)
            If drEmployee.Read Then
                m_strRequestedEmployee = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
                m_intRequestedEmployeePost = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("PostID"), "0"), Integer)
                m_strRequestedEmployeeUN = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("UserName"), ""), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<div class='col-sm-6'>")


        Dim strSQLRole As String
        Dim drRole As IDataReader
        Dim lngPostID As Long = 0
        ' to take postid of the employee at corporate level not from session


        drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & CType(HttpContext.Current.Session("intUserID"), Integer), True)

        If drRole.Read Then
            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drRole)
        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & DepartmentID.ToString
        ElseIf m_intRequestedEmployee <> 0 Then
            strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
        Else
            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        End If

        strHTML.Append("<label>Department *</label>")

        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_CRM_GetFunctions_ForRole " & Session("intPostID") & ", null ", , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", False, True))

        If blnDisableFunctionCombo Then
            If m_strLoginType <> "C" Then
                If m_intCustomer = 0 Then
                    strSQL += "," + RequestID.ToString
                End If
            End If
            'Commented And Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , DepartmentID, "class='form-control' onchange=Department_OnChange(this) disabled", False, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , DepartmentID, "class='form-control' onchange=Department_OnChange(this) disabled", True, True))
            'End Of Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
        Else
            If m_strLoginType <> "E" Then
                'Commented And Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
                'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " & Session("intPostID") & "", , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", False, True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " & Session("intPostID") & "", , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", True, True))
                'End Of Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
            Else
                If m_intCustomer <> 0 Then
                    'Commented And Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " & m_intCustomer.ToString & "", , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", False, True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_Sel_Department_ForCustomer " & m_intCustomer.ToString & "", , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", False, True))
                    'End Of Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
                Else
                    'Commented And Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", False, True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", strSQL, , DepartmentID, "class='form-control' onchange=Department_OnChange(this)", True, True))
                    'End Of Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
                End If
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")

        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Request Type *</label>")
        'Commented And Added By Usha Pandit On 16.10.2020 For removing unnecessary placeholder
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "Select 'Request Type'", , , "class='form-control' onchange=RequestType_OnChange(this)", False, True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "Select ''", , , "class='form-control' onchange=RequestType_OnChange(this)", False, True))
        'End Of Added By Usha Pandit On 16.10.2020 For removing unnecessary placeholder
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label for='sel1'>Sub Request Type *</label>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", "Select ''", , , "class='form-control' onchange=SubRequestType_OnChange(this)", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group'>")
        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            ' Status
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Status</label>")

            Dim RoleId As String = Session("intPostId")
            strSQL = "usp_CRM_Get_RequestStatus '" & RequestID.ToString & "'," & RoleId


            If blnDisableStatusCombo Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , , "class='form-control disabled ", , True, , True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", strSQL, , intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , True, , True))
                ' For HelpDesk StatusFlow Configuration
                m_StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(RequestID, String) + "", MyBase.UseSQL), "0"), Integer)

                ''  Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True))

                Dim strOldStatus As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(intStatusID, String), MyBase.UseSQL), "0"), String)

                'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))

                'Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True
                'Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "'," + "1", DisplayNone:=True)) ', displaynone:=True

            End If

            strHTML.Append("<b><a href='javascript:ChangeHistory_OnClick()'>Status History</a><b>")

            CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()

            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

            strHTML.Append("</div>")
        End If

        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<label for='sel1'>Assigned To</label>")
            ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAssignTo", "Select 'Sub Request Type'", , , "class='form-control' onchange=SubRequestType_OnChange(this)", False, True))
            strHTML.Append("<select class='form-control' id='Select3'>")
            strHTML.Append("<option>1</option>")
            strHTML.Append("<option>2</option>")
            strHTML.Append("<option>3</option>")
            strHTML.Append("<option>4</option>")
            strHTML.Append("</select>")
            strHTML.Append("</div>")
        End If

        strHTML.Append("<div class='col-sm-6'>")
        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Priority *</label>")
        'strHTML.Append("<label for='sel1'>Severity *</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority ", , , "class='form-control'", True, True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")

        ''Commented and Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append("<label for='sel1'>Severity</label>")
        'strHTML.Append("<label for='sel1'>Priority</label>")
        ''End of Added by Usha Pandit on 02.04.2019 for Priority/Severity display issue
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSeverity", "usp_CRM_Get_RequestSeverity", , , "class='form-control'", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        If m_strLoginType = "E" And m_intCustomer = 0 Then
            'strHTML.Append("<div class='row'>")
            'strHTML.Append("<div class='form-group'>")
            'strHTML.Append("<div class='col-sm-6'>")
            'strHTML.Append("<label for='sel1'>Project</label>")
            blnIsHRM = 0
            Dim strHRM As String = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID.ToString
            Dim drHRM As IDataReader = CommonFunctions.Data.GetDataReader(strHRM, True)

            If drHRM.Read Then
                blnIsHRM = 1
            End If
            'Dim strProject As String = "SELECT 0,'' UNION Select ProjectID,ProjectName FROM tbl_PM_Project"
            'Dim StrInsert As String = ""
            'If blnDisableProjectCombo = True And blnIsHRM = 0 Then
            '    StrInsert = "disabled"
            'End If
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboProject", strProject, , , "class='form-control' '" & StrInsert & "'", False, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
        End If


        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='form-group' style='display:contents;'>")
        If ShowProductCombo = "1" Then
            strHTML.Append("<div class='col-sm-6' style='padding-left:25px;'>")

            strHTML.Append("<label for='sel1'>Product</label>")
            If (m_intCustomer = 0 And m_strLoginType = "E") Then  ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , , "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + RequestID.ToString, , , "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + RequestID.ToString, , , "class='form-control'  onchange=Product_OnChange(this)", True, True, , False))
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-6' style='padding-right:25px;'>")
            strHTML.Append("<label for='sel1'>Module/Component</label>")
            If (m_intCustomer = 0 And m_strLoginType = "E") Then
                ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Select ''", , , "class='form-control'", True, True, , False))
            ElseIf m_strLoginType = "C" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Select ''", , , "class='form-control'", True, True, , False))
            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Select ''", , , "class='form-control'", True, True, True, , False))
            End If

            strHTML.Append("</div>")


            'Purpose : Product and Module/Component value does not persist when ExposeTo Product Execution flag of related Dept. becomes off
        Else 'If (m_intCustomer <> 0 And m_strLoginType = "E") Or m_strLoginType = "C" Or m_RequeststrLoginType.ToUpper = "C" Then
            strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=''>")
            strHTML.Append("<INPUT type=hidden name='cboModule' id='cboModule' value=''>")
        End If

        If m_intCustomer = "" Or m_intCustomer = "0" Then
            strHTML.Append("<div class='col-sm-6' style='padding-left:25px;'>")
            strHTML.Append("<label for='sel1'>Organization Unit *</label>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units 0", , , "class='form-control' ", True, True))
            strHTML.Append("</div>")
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        'Commented By Dipali V On 16th Nov
        'strHTML.Append("<label for='sel1'>Time Zone</label>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , , "class='form-control' ", False, True))
        'End of Commented By Dipali V On 16th Nov
        'strHTML.Append("</div>")


        If UCase(Trim(m_strMode & "")) = "NEW" Then
            strHTML.Append("<div class='col-sm-6' style='margin-left:4%'>")
            If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
                strHTML.Append("<label for='sel1'>Exp. Date of Resolution *</label>")
            Else
                strHTML.Append("<label for='sel1'></label>")
            End If

            'Commented And Added By Usha Pandit On 25.02.2021 For Current Date plotting issue
            'If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
            '    ' admin/requestor of course can change the date
            '    strHTML.Append("<div class='' style='padding-right:0px;'>")

            '    'Commented and Added by Usha Pandit on 16 JAN 2018 fodivCustomFieldr Get Input Date Format
            '    'strHTML.Append("<input type='text' value='" & Date.Now.ToString & "'  class='form-control' id='dtExpResdate' placeholder=''>")

            '    Dim strInputDateFormat As String = GetInputDateFormat()
            '    strInputDateFormat = strInputDateFormat.Replace("D", "d")
            '    strInputDateFormat = strInputDateFormat.Replace("Y", "y")
            '    m_strInputDateFormatVB = strInputDateFormat
            '    Dim strDate As String = Date.Now.ToString(strInputDateFormat, System.Globalization.CultureInfo.InvariantCulture)
            '    strInputDateFormat = strInputDateFormat.Replace("M", "m")
            '    strInputDateFormat = strInputDateFormat.Replace("yyyy", "yy")
            '    ''Commented and Added by Usha Pandit on 23.05.2019 for making date textbox readonly
            '    'strHTML.Append("<input type='text' value='" & strDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
            '    strHTML.Append("<input type='text' value='" & strDate & "' readonly style = 'background-color: white!important;' class='form-control' id='dtExpResdate' placeholder=''>")
            '    ''End of Added by Usha Pandit on 23.05.2019 for making date textbox readonly

            '    'End of Added by Usha Pandit on 16 JAN 2018 for Get Input Date Format

            '    ''Commented and Added by Usha Pandit on 24.05.2019 for not allowing date before today
            '    'strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker({dateFormat:'" & strInputDateFormat & "'});$('#dtExpResdate').datepicker('show');""></i>")
            '    strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker({minDate: 0, dateFormat:'" & strInputDateFormat & "'});$('#dtExpResdate').datepicker('show');""></i>")

            '    Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
            '    Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
            '    Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
            '    Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


            '    strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString(m_strInputDateFormatVB) + ">")
            '    ''End of Added by Usha Pandit on 24.05.2019 for not allowing date before today
            '    strHTML.Append("</div>")
            'End If

            If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
                ' admin/requestor of course can change the date
                strHTML.Append("<div class='' style='padding-right:0px;'>")

                'Commented and Added by Usha Pandit on 16 JAN 2018 fodivCustomFieldr Get Input Date Format
                'strHTML.Append("<input type='text' value='" & Date.Now.ToString & "'  class='form-control' id='dtExpResdate' placeholder=''>")

                Dim strInputDateFormat As String = GetInputDateFormat()
                strInputDateFormat = strInputDateFormat.Replace("D", "d")
                strInputDateFormat = strInputDateFormat.Replace("Y", "y")
                m_strInputDateFormatVB = strInputDateFormat
                Dim strDate As String = Date.Now.ToString(strInputDateFormat, System.Globalization.CultureInfo.InvariantCulture)
                strInputDateFormat = strInputDateFormat.Replace("M", "m")
                strInputDateFormat = strInputDateFormat.Replace("yyyy", "yy")
                ''Commented and Added by Usha Pandit on 23.05.2019 for making date textbox readonly
                'strHTML.Append("<input type='text' value='" & strDate & "'  class='form-control' id='dtExpResdate' placeholder=''>")
                strHTML.Append("<input type='text' value='" & strDate & "' readonly style = 'background-color: white!important;' class='form-control' id='dtExpResdate' placeholder=''>")
                ''End of Added by Usha Pandit on 23.05.2019 for making date textbox readonly

                'End of Added by Usha Pandit on 16 JAN 2018 for Get Input Date Format

                ''Commented and Added by Usha Pandit on 24.05.2019 for not allowing date before today
                'strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker({dateFormat:'" & strInputDateFormat & "'});$('#dtExpResdate').datepicker('show');""></i>")
                strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtExpResdate').datepicker({minDate: 0, dateFormat:'" & strInputDateFormat & "'});$('#dtExpResdate').datepicker('show');""></i>")

                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString(m_strInputDateFormatVB) + ">")
                ''End of Added by Usha Pandit on 24.05.2019 for not allowing date before today
                strHTML.Append("</div>")
            Else
                strHTML.Append("<div class='' style='padding-right:0px;'>")
                Dim strInputDateFormat As String = GetInputDateFormat()
                strInputDateFormat = strInputDateFormat.Replace("D", "d")
                strInputDateFormat = strInputDateFormat.Replace("Y", "y")
                m_strInputDateFormatVB = strInputDateFormat
                Dim strDate As String = Date.Now.ToString(strInputDateFormat, System.Globalization.CultureInfo.InvariantCulture)
                strInputDateFormat = strInputDateFormat.Replace("M", "m")
                strInputDateFormat = strInputDateFormat.Replace("yyyy", "yy")
                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString(m_strInputDateFormatVB) + ">")
                strHTML.Append("</div>")
            End If
            strHTML.Append("</div>")

        End If

        'strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append("<div class='cust-file'><h5>Custom Field</h5></div>")
        strHTML.Append("<label id='lblnodata'></label>")
        strHTML.Append("<div class='cust-file' id='divCustomField'>")
        'strHTML.Append("<h5>No custom fields have been defined</h5>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    'Added by Usha Pandit on 16 JAN 2018 for Get Input Date Format
    '<System.Web.Services.WebMethod()>
    Public Function GetInputDateFormat() As String
        '=====================================================================
        ' Procedure  Name		:	GetInputDateFormat
        ' Parameters Passed		:	ID
        ' Returns				:	Input Date Format
        ' Parameters Affected	:	None
        ' Purpose				:	Get Input Date Format
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   16 JAN 2018
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String

            strSQL = "usp_NG2_sel_tbl_PM_CompanyInformation"

            Dim drReader As IDataReader

            drReader = CommonFunctions.Data.GetDataReader(strSQL, True)

            If (drReader.Read) Then
                strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("InputDateFormat")))
            End If

            'strResult = CommonFunctions.Data.GetDataReader(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    'End of Added by Usha Pandit on 16 JAN 2018 for Get Input Date Format

    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestType(ByVal TypeID As String, ByVal WhichList As String, ByVal RequestTypeID As String, ByVal CustomerID As String, ByVal EmployeeID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        TypeID = Utilities.Security.SecurityBuilder.CheckUserInput(TypeID, 2, True, False, False)
        WhichList = Utilities.Security.SecurityBuilder.CheckUserInput(WhichList, 2, True, False, False)
        RequestTypeID = Utilities.Security.SecurityBuilder.CheckUserInput(RequestTypeID, 2, True, False, False)
        CustomerID = Utilities.Security.SecurityBuilder.CheckUserInput(CustomerID, 2, True, False, False)
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        'Dim request = HttpContext.Current.Request
        'Dim response = HttpContext.Current.Response
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
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
            Dim objCRM_AddNewRequest As New CRM_AddNewRequest
            Dim strReturnHtml1 As New StringBuilder("")
            Dim ShowProductCombo As String = "0"
            Dim m_strRequestedEmployee As String = ""
            Dim m_intRequestedEmployeePost As String = ""
            Dim m_strRequestedEmployeeUN As String = ""
            ' Dim m_strUserID As String
            If TypeID = "" Then
                TypeID = 0
            End If

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

                    strSQL = "usp_CRM_RequestSubTypes " & TypeID & ",'" & m_strUserName & "','C',0," & RequestTypeID.ToString & ",0"
                Else
                    If EmployeeID <> 0 Then
                        strSQL = "usp_CRM_RequestSubTypes " & TypeID & ",'" & m_strRequestedEmployeeUN & "','E',0," & RequestTypeID.ToString & ",0"
                    Else
                        strSQL = "usp_CRM_RequestSubTypes " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0," & RequestTypeID & ""
                    End If
                End If

                '' strSQL = "usp_CRM_RequestSubTypes " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0," & RequestTypeID & ""

            End If

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")
            'strValidation = strScript(1)
            strHTML.Append(strScript(0) + vbCrLf)


            strReturnHtml1.Append(objCRM_AddNewRequest.DrawRequestDetails(ShowProductCombo, TypeID, CustomerID, EmployeeID))

            Return strResult & "|" & strHTML.ToString & "|" & strReturnHtml1.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetModuleOrComponent(ByVal ProductID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        ProductID = Utilities.Security.SecurityBuilder.CheckUserInput(ProductID, 2, True, False, False)
        'Dim request = HttpContext.Current.Request
        'Dim response = HttpContext.Current.Response
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
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
            If ProductID = "" Then
                ProductID = "NULL"
            End If
            strSQL = "Exec usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " & ProductID & ""

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")
            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
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
    '<System.Web.Services.WebMethod()>
    'Public Shared Function PlotCustomFields(ByVal SubRequestTypeID As String)
    '    '=====================================================================
    '    ' Proceduere  Name	    :	PlotCustomFields
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To draw custom fields section
    '    ' Description			:	
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	Amol Changle
    '    ' Created				:	21 Jul 2009
    '    ' Revisions				:	
    '    '=====================================================================

    '    Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
    '    Dim strHTML As New StringBuilder()
    '    Dim m_lngQueryID As Integer
    '    Dim UserID As String = HttpContext.Current.Session("intUserID").ToString
    '    Dim LoginType As String = HttpContext.Current.Session("LoginType").ToString
    '    Dim strDefaultScript As String 'Script to store values of custom fields from another Controls
    '    Dim strClientSideScript As String 'Validation script for custom fields
    '    Dim declarevariables As String = "" 'Custom Fields objects Declaration script
    '    Dim m_strCurrentType As String = ""
    '    Dim m_blnShowDefaults As Boolean = False 'Show defaults in add new mode only? 
    '    Dim m_strCustomFieldList As String = ""
    '    Dim m_strEnableControlScript As String = ""
    '    Dim UserIDForCustomFields As Integer = 0
    '    Dim m_strLoginTypeForCustomField As String = ""

    '    'With ObjCustomFieldsSection

    '    '    'Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
    '    '    strHTML.Append(.GetSectionTitle("Custom Fields", "DivCustomFieldsSection", "HideShowCustomFieldsSection"))

    '    '    'Write ClientsideScript in order to show hide the section
    '    '    strHTML.Append("<SCRIPT Language=javascript>")
    '    '    strHTML.Append(.ClientsideScript)
    '    '    strHTML.Append("</SCRIPT>")
    '    'End With
    '    strHTML.Append("<DIV id=DivCustomFieldsSection width='99.9%' style='overflow:auto'>")

    '    ''Dim strTaskID As String
    '    'Dim strDummyTask As String
    '    'Dim blnDummyDefaultValue As Boolean
    '    ''strTaskID = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "")
    '    'If m_lngQueryID <> 0 Then
    '    '    strDummyTask = strTaskID
    '    '    blnDummyDefaultValue = False
    '    'Else
    '    '    strDummyTask = m_lngTaskId.ToString()
    '    '    blnDummyDefaultValue = m_blnShowDefaults
    '    'End If

    '    Dim objCustomFields As New CRM_PlotCustomFields()

    '    '  With objCustomFields

    '    '.EntityName = "Help-Desk"
    '    '.FormName = "frmRequestDetails"
    '    '.PrimaryKey = "QueryID"
    '    '.PrimaryTable = "Tbl_CRM_Query_Master"
    '    '.TypeID = SubRequestTypeID
    '    '.IsAddNewMode = IIf(m_lngQueryID = 0, True, False)
    '    '.PrimaryKeyValue = m_lngQueryID
    '    '.QueryStringForTypeChange = "SubRequestTypeID"
    '    '.m_lngProjectId = 0
    '    strHTML.Append(objCustomFields.PlotCustomFields(UserID, LoginType, "Help-Desk", m_lngQueryID, SubRequestTypeID))
    '    'declarevariables = .VariableDeclarationScript
    '    'strClientSideScript = .ValidationScript
    '    'strDefaultScript = .DefaultValueScript
    '    'm_strCustomFieldList = .AccesibleCustomFields
    '    ' End With

    '    strHTML.Append("</DIV>")

    '    'Added By Amol Changle On: 22 Jul 2009
    '    'Purpose: To render Custom Field validations
    '    ''CommonFunctions.General.WriteHTML(vbCrLf)
    '    'strHTML.Append("<script language=javascript>")
    '    'strHTML.Append(vbCrLf)
    '    'strHTML.Append("function ValidateCustomFields(){")
    '    'If Not declarevariables Is Nothing Then
    '    '    strHTML.Append(vbCrLf)
    '    '    strHTML.Append(declarevariables)
    '    'End If
    '    'If Not strClientSideScript Is Nothing Then
    '    '    strHTML.Append(vbCrLf)
    '    '    strHTML.Append(strClientSideScript)
    '    'End If
    '    'If Not strDefaultScript Is Nothing Then
    '    '    strHTML.Append(vbCrLf)
    '    '    strHTML.Append(strDefaultScript)
    '    'End If
    '    'strHTML.Append(vbCrLf)
    '    'strHTML.Append("return true;}")
    '    'strHTML.Append(vbCrLf)
    '    'strHTML.Append("</script>")
    '    'End Addition
    '    Return strHTML.ToString

    'End Function
    '' <System.Web.Services.WebMethod()>
    'Public Shared Function PlotCustomFields(ByVal DepartmentID As String, ByVal RequestTypeID As String, ByVal SubRequestTypeID As String, ByVal CustomerID As String)
    'Dim strUserGivenCaption As String
    'Dim m_strTypeInaccessibleCustomFieldList As String
    'Dim strSQLQuery As String
    'Dim drCustomField As IDataReader
    'Dim objNewRequest As New CRM_AddNewRequest()

    'If SubRequestTypeID = "" Then
    '    SubRequestTypeID = 0
    'End If

    'If RequestTypeID = "" Then
    '    RequestTypeID = 0
    'End If

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
    'Dim objAddNewRequest As New CRM_AddNewRequest()




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
    'Dim Flag1 As String = "0"
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


    'objAddNewRequest.GetValidationRules()
    'objAddNewRequest.arrValidationMessages.CopyTo(arrtemp, 0)

    'While drCustomField.Read
    '    Flag1 = "1"
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
    '        intControlWidth = "200"
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

    '    If drCustomField("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
    '        strCustomFieldTD.Append("<div class='row' style='margin-top:-5%'>")
    '        strCustomFieldTD.Append("<div class='form-group'>")


    '        strCustomFieldTD.Append("<label class='col-sm-6' for='usr'>" + strControlCaption + "</label>")

    '        If InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then
    '            strCustomFieldTD.Append("  ")
    '            strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, "class='form-control'", True, True) + "</div>")

    '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf



    '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
    '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "frmQuickTask", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , "false", "", , "disabled", False, blnIsMandatory, Wrap:="Soft") + "</td>")

    '            strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "form-control", , "frmAddNewRequest", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , , , , , True, , Wrap:="Soft", EnableHTMLEncode:=True) + "</div>")


    '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf


    '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then
    '            ''strCustomFieldTD.Append("<td>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , strToBeInserted, True, blnIsMandatory) + "</td>")
    '            strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "form-control", intControlWidth, intControlMaxLength, strControlValue, , , , False, "", , "class='form-control'", True, , EnableHTMLEncode:=True) + "</div>")
    '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf

    '        ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
    '            If strControlValue <> "" And strControlValue <> "0" Then
    '                ' strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
    '                strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "' value='" & CommonFunctions.Dates.GetDate(CType(strControlValue, Date)) & "'  class='form-control' id='" & strControlName & "' placeholder=''>")
    '                strCustomFieldTD.Append("<i class='fa fa-calendar' id='" & strControlName & "' onclick=""$('#id" & strControlName & "').datepicker();$('#id" & strControlName & "').datepicker('show');""></i></div>")
    '            Else
    '                ''strCustomFieldTD.Append("<div class='col-sm-8'>" + CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmAddNewRequest", , , , False, False, "", True, , , ) + "</div>")
    '                strCustomFieldTD.Append("<div class='col-sm-8'><input type='text' name='" & strControlName & "' value=''  class='form-control' id='" & strControlName & "' placeholder=''>")
    '                strCustomFieldTD.Append("<i class='fa fa-calendar' id='" & strControlName & "' onclick=""$('#" & strControlName & "').datepicker();$('#" & strControlName & "').datepicker('show');""></i></div>")
    '            End If
    '            declarevariables = declarevariables + "var obj" + strControlName.ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + strControlName.ToString.Trim + "');" + vbCrLf

    '        End If

    '        If (strDataType = "1") Then
    '            If InStr(1, "," + strControlValidationRules, ",3,") = 0 Then
    '                strControlValidationRules = strControlValidationRules + "3,"
    '            End If
    '        End If
    '        strCustomFieldTD.Append("</div>")
    '        strCustomFieldTD.Append("</div>")
    '        objAddNewRequest.GenerateValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrtemp)
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
    ' ''Commented and added by Yogesh Jalamkar on 29-NOv-2017 Purpose: Request approval msg should not display to customer
    ''If UCase(Trim(m_strMode & "")) = "NEW" And Trim(SubRequestTypeID & "") <> "" And ((m_intCustomer = 0) Or (m_intRequestedEmployee <> 0)) And HttpContext.Current.Session("LoginType").ToString = "E" Then
    'If UCase(Trim(m_strMode & "")) = "NEW" And Trim(SubRequestTypeID & "") <> "" And ((m_intCustomer = 0) Or (m_intRequestedEmployee <> 0)) And loginType = "E" Then
    '    'End by Yogesh Jalamkar
    '    Dim IsApproval As String
    '    IsApproval = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_CRM_Function_RequestTypes_Approval " & DepartmentID & "," & RequestTypeID & "," & SubRequestTypeID, True), String)
    '    If IsApproval = "1" Then
    '        StrHTMLGuidelines.Append("<div >")
    '        StrHTMLGuidelines.Append("<label for='sel1' id='lblApprovalStatus'>")
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
    '            StrHTMLGuidelines.Append(objNewRequest.GetCaption(919, "GuidelinesForRequestor") & ":")
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




    ''Response.Write(strFieldAccess)


    'Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
    'Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
    'Dim intDestinationIndex, intSourceIndex As Integer
    'Dim drLayout As IDataReader
    'Dim drCustomAccess As IDataReader
    'Dim strSQLForCustom As String
    'Dim strCustomFieldIDs() As String
    'Dim intCount As Integer
    'Dim intCorporateRoleLevel As Integer
    'Dim m_lngRoleId As String = ""
    'Dim m_lngProjectId As Integer = 0
    'Dim m_strEntityName As String = "help-desk"
    'Dim LoginType As String = ""
    'Dim m_lngUserId As String = ""
    'Dim UserID As Integer = 0
    'Dim m_strCurrentType As String = ""
    'Dim m_strTypeInaccessibleCustomFieldList As String
    'Dim m_strCustomFieldList As String
    'Dim m_intMaxRows As Integer
    'Dim m_intMaxCols As Integer
    'Dim ArrCtlAttr(20) As String
    'Dim arrEventHandlers(30, 3) As String
    'Dim strFieldValue As String = ""
    'Dim strDummyFieldValue As String = ""
    'Dim m_strPrimaryKey As String = "QueryID"         'can have value TaskID,ScheduleID,ReviewID etc
    'Dim m_strPrimaryTable As String = "Tbl_CRM_Query_Master"        'Table From which Custom field Values  to be retrived
    'Dim m_strPrimaryKeyID As Long = 0
    'Dim strEventHandlers As String
    'Dim strDefaultScript As String
    'Dim strClientSideScript As String
    'Dim m_blnShowDefaults As Boolean = False
    'Dim declarevariables As String = ""
    'Dim IsAddNewMode As Boolean = True
    'm_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
    'Dim strCustomFieldTD As StringBuilder = New StringBuilder()
    ''If Not m_lngProjectId > 0 Then
    ''    m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
    ''Else
    ' '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
    ' ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
    'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_EmployeeID " & CType(HttpContext.Current.Session("intUserID"), String), True), Integer)
    ' '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
    'If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
    '    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
    '    'm_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
    '    m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(HttpContext.Current.Session("intUserID"), String), True), "0"), Long)
    '    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
    'End If
    ''End If
    'If Not m_lngRoleId > 0 Then
    '    m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
    'End If


    'm_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)

    'If UserID = 0 Then
    '    UserID = CType(HttpContext.Current.Session("intUserID"), Integer)
    'End If
    'If LoginType = "" Then
    '    LoginType = HttpContext.Current.Session("LoginType").ToString()
    'End If

    ''Added By Amol Changle On: 22 Jul 2009
    ''Purpose: For Entity "Help-Desk" ProjectID is considered to be 0.
    ''Modified By Syamantak Chavan on 21 Sept 2011 For Custom Field addition in whizible 10.0
    'If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Modified by NitinC on 14 April 2011 for WhizibleSEM 10.0
    '    m_lngProjectId = 0
    'End If
    ''End Addition

    'm_strCustomFieldList = ""
    'm_strTypeInaccessibleCustomFieldList = ""


    ''Get Accesible CustomFieldIDs List
    'strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleId.ToString + "," + UserID.ToString
    'If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
    '    strSQLForCustom = strSQLForCustom + ",'" + m_strEntityName + "'"
    'End If

    ''Added By Amol Changle On: 19 Aug 2009
    ''Purpose: To handle Login Type specific issues
    'strSQLForCustom += ",'" + LoginType + "'"
    ''End Addition

    'drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, True)
    'While drCustomAccess.Read
    '    ReDim Preserve strCustomFieldIDs(intCount)
    '    strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
    '    intCount += 1
    'End While
    'CommonFunction.Data.DisposeDataReader(drCustomAccess)


    '' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
    ''strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_PM_CustomFields_Master WHERE ProjectID = " + m_lngProjectId.ToString + " AND Active = 1"

    'If m_strCurrentType Is Nothing OrElse m_strCurrentType = "" Then
    '    m_strCurrentType = "NULL"
    'End If

    'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + m_lngProjectId.ToString + "," + SubRequestTypeID

    'If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
    '    'strSQLQuery = strSQLQuery + " And EntityName = '" & m_strEntityName & "'"
    '    strSQLQuery = strSQLQuery + " ,'" & m_strEntityName & "'"
    'Else
    '    'strSQLQuery = strSQLQuery + " And EntityName = 'Task'"
    '    strSQLQuery = strSQLQuery + ",'help-desk'"
    'End If
    'strSQLQuery = strSQLQuery + ",1," + UserID.ToString()


    ''Added By Amol Changle On: 19 Aug 2009
    ''Purpose: To handle Login Type specific issues
    'strSQLQuery += ",'" + LoginType + "'"
    ''End Addition

    ''usp_Sel_tbl_PM_CustomFields_Master_MaxRows

    'drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    'If drLayout.Read Then
    '    m_intMaxRows = CType(drLayout("MaxRows"), Integer)
    '    m_intMaxCols = CType(drLayout("MaxCols"), Integer)
    'End If
    'CommonFunction.Data.DisposeDataReader(drLayout)

    ''Start Plotting of Custom Fields
    ''Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
    'strCustomFieldTD.Append("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
    'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString + ", NULL, 1"


    'If IsNothing(m_strCurrentType) = True Then m_strCurrentType = ""

    'If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + "," + m_strCurrentType + ""
    'If m_strEntityName.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strEntityName + "'"

    ''Added by ShraddhaM
    'strSQLQuery = strSQLQuery + "," + UserID.ToString()
    ''Ended by ShraddhaM

    ''Added By Amol Changle On: 19 Aug 2009
    ''Purpose: To handle Login Type specific issues
    'strSQLQuery += ",'" + LoginType + "'"
    ''End Addition


    'drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, True)
    ''Call GetValidationRules()

    'If drLayout.Read Then
    '    For intRow = 1 To m_intMaxRows
    '        'declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf

    '        'Added By Amol Changle On: 22 Jul 2009
    '        'Purpose: Not to render blank rows
    '        If CommonFunctions.Data.CheckIsDBNull(drLayout("RowNumber")) = intRow.ToString() Then
    '            'End Addition
    '            strCustomFieldTD.Append("<TR class=clsTREven >")
    '            For intCol = 1 To m_intMaxCols
    '                intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
    '                intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

    '                If intCurrentCellNumber < intNextCellNumber Then
    '                    strCustomFieldTD.Append("<td valign=top align=right colspan=2 >&nbsp;</td>")
    '                ElseIf intCurrentCellNumber >= intNextCellNumber Then
    '                    declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('frmAddNewRequest','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
    '                    'HttpContext.Current.Response.Write("<td valign=top align=right style='width:10%'>")
    '                    strCustomFieldTD.Append("<td valign=top align=right width='5%'>")
    '                    'get value form form
    '                    'If m_blnShowFormContents = True Then


    '                    If Not HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
    '                        strFieldValue = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)

    '                        'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
    '                        ' Added checkisdbNull to get strDummyFieldValue and strFieldValue
    '                        'Save Database value also

    '                        If m_strPrimaryKeyID > 0 Then
    '                            'If Not rsIssueDetails.EOF Then
    '                            Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
    '                            strDummyFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    '                            'End If
    '                        Else
    '                            strDummyFieldValue = ""
    '                        End If

    '                    Else
    '                        If m_strPrimaryKeyID > 0 Then
    '                            'If Not rsIssueDetails.EOF Then
    '                            Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
    '                            strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    '                            'End If
    '                        Else
    '                            strFieldValue = ""
    '                        End If
    '                        strDummyFieldValue = strFieldValue
    '                    End If

    '                    'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes  

    '                    ' Retrieve the attributes of the control to be displayed.
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
    '                    'Modified By VarunA on 27-Sep-2008
    '                    'Purpose : Security Issue
    '                    'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull((drLayout("UserGivenCaption")), "").ToString
    '                    'End By VarunA on 27-Sep-2008
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = strFieldValue
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "0").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"
    '                    If (drLayout("DataType").ToString = "1") Then
    '                        If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",3,") = 0 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "3,"
    '                        End If
    '                    End If

    '                    ' Set the control type depending on the name of the custom field to be displayed.
    '                    ' For Text Area custom fields...

    '                    If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then

    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

    '                        ' Set the maxlengths of the textareas.
    '                        'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

    '                        If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
    '                        ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 3800 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
    '                        End If

    '                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                        End If
    '                        'End If

    '                        intDestinationIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
    '                        arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                        arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    '                        ' For Text Box custom fields...
    '                    ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then

    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

    '                        ' Set the maxlengths of the textboxes.
    '                        If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                        ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                        End If

    '                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                        End If

    '                        ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
    '                        If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"
    '                        End If

    '                        intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
    '                        arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                        arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    '                        ' For Combo Box custom fields...									
    '                    ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
    '                        ''Added By Amol Changle On: 21 Jul 2009
    '                        ''Purpose: To select field details Entity Specific
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) += ",1,'" + m_strEntityName + "'"
    '                        ''End Addition

    '                        ' Set the maxlengths of the combobox.
    '                        'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
    '                        'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                        'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
    '                        '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
    '                        'End If
    '                        'If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    '                        '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                        'End If

    '                        intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
    '                        arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                        arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    '                        ' For Date Control custom fields...								
    '                    ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then

    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"

    '                        intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
    '                        arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                        arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)



    '                    End If

    '                    ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
    '                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "False"
    '                    If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
    '                    End If

    '                    ' If the default value is to be retrieved from one of the common fields or custom fields, then...
    '                    If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

    '                        ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
    '                        If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) Then

    '                            ' Get the index of the custom fields.
    '                            If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
    '                                ' Text Area Range	: 26 - 28.
    '                                intSourceIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
    '                            ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
    '                                ' Text box Range	: 1 - 10.
    '                                intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
    '                            ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
    '                                ' Combo box Range	: 11 - 20.
    '                                intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
    '                            ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
    '                                ' Date control Range: 21 - 25.
    '                                intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
    '                            End If

    '                            strEventHandlers = ""
    '                            strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('frmAddNewRequest','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
    '                            strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('frmAddNewRequest','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
    '                            strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

    '                            If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    '                                strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
    '                            Else
    '                                strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
    '                            End If

    '                            strEventHandlers = strEventHandlers + "}" + vbCrLf

    '                            arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

    '                        End If

    '                        strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('frmAddNewRequest','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
    '                        strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('frmAddNewRequest','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
    '                        strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
    '                        strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

    '                        'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    '                        strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
    '                        'Else
    '                        '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
    '                        'End If

    '                        strDefaultScript = strDefaultScript + "}" + vbCrLf
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = ""

    '                        ' For Numweric custom fields...
    '                    ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then

    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

    '                        ' Set the maxlengths of the textboxes.
    '                        If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                        ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                        End If

    '                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "3,") = 0 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                        End If


    '                        'intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(Customer.CCommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
    '                        intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldNumeric") + 1, 2))
    '                        arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                        arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)


    '                    End If

    '                    strCustomFieldTD.Append(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))

    '                    strCustomFieldTD.Append("</td>")
    '                    strCustomFieldTD.Append("<td valign=top style='width:15%'>")


    '                    'HttpContext.Current.Response.Write("<td valign=top bgcolor=green >")
    '                    Dim blnShowControl As Boolean = False
    '                    Dim intCounter As Integer

    '                    intCounter = 0
    '                    'If length of array is greater than 0 that means security is explicitly set
    '                    'In that case check if it is accessible ,if yes then show the control, 
    '                    'otherwise show it as not applicable
    '                    If intCount > 0 Then

    '                        While intCounter < intCount
    '                            'Check if the current Custom Field ID is in the array
    '                            If strCustomFieldIDs(intCounter).ToLower.Trim = _
    '                                        CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
    '                                blnShowControl = True
    '                                Exit While
    '                            End If

    '                            intCounter = intCounter + 1

    '                        End While

    '                    Else
    '                    End If

    '                    If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
    '                        m_strCustomFieldList = m_strCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","
    '                        strCustomFieldTD.Append(DrawControl(ArrCtlAttr))
    '                        ' Call ClearAttributes(ArrCtlAttr)
    '                    Else

    '                        If IsAddNewMode = True Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
    '                        End If

    '                        'The Custom Field is not defied for the Current Type
    '                        strCustomFieldTD.Append("( NA )")

    '                        'Do not save value if the Custom Field is not applicable
    '                        If drLayout("IsCustomFieldAssigned").ToString <> "1" And blnShowControl = True Then
    '                            m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","

    '                            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    '                            CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , strDummyFieldValue, , , , , , True, , True, , EnableHTMLEncode:=True)
    '                        Else
    '                            CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , , , , , , , True, , True, , EnableHTMLEncode:=True)
    '                        End If
    '                        CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)
    '                        '''End of Modification by Dhanashri S on 7 Oct 2015 

    '                        ' reset value of inactive custom fields before saving.
    '                        strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
    '                    End If
    '                    strCustomFieldTD.Append("</TD>")
    '                    If Not drLayout.Read() Then
    '                        Dim i As Integer
    '                        For i = intCol To m_intMaxCols - 1
    '                            strCustomFieldTD.Append("<td valign=top align=right colspan=2>&nbsp;</td>")
    '                        Next
    '                        Exit For
    '                    End If
    '                Else
    '                    strCustomFieldTD.Append("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
    '                    'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
    '                    If Not drLayout.Read() Then
    '                        Dim i As Integer
    '                        For i = intCol To m_intMaxCols - 1
    '                            strCustomFieldTD.Append("<td valign=top align=right colspan=2>&nbsp;</td>")
    '                        Next
    '                        Exit For
    '                    End If
    '                End If
    '            Next
    '            strCustomFieldTD.Append("</TR>")
    '        End If
    '    Next
    '    If m_strCustomFieldList <> "" Then
    '        m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
    '    End If
    '    If m_strTypeInaccessibleCustomFieldList <> "" Then
    '        m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList.Substring(0, m_strTypeInaccessibleCustomFieldList.Length - 1)
    '    End If
    '    strCustomFieldTD.Append("<SCRIPT language=javaScript>" + vbCrLf)
    '    CommonFunction.Data.DisposeDataReader(drLayout)

    '    Dim intCtr As Integer
    '    ' Loop through the array to check if any event handlers need to be printed.
    '    For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

    '        ' If the control name is present and the event handler is present, then print it.
    '        ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
    '        ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
    '        ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
    '        If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
    '            If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    '                strCustomFieldTD.Append("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
    '            Else
    '                strCustomFieldTD.Append("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
    '            End If
    '            strCustomFieldTD.Append(arrEventHandlers(intCtr, 2))
    '            strCustomFieldTD.Append("}" + vbCrLf)
    '        End If
    '    Next
    '    strCustomFieldTD.Append("</SCRIPT>" + vbCrLf)
    'Else
    '    strCustomFieldTD.Append("<tr class=clsTREven>")
    '    strCustomFieldTD.Append("<td align=center valign=center>")
    '    strCustomFieldTD.Append("<b>No Custom Field</b>")

    '    strCustomFieldTD.Append("</td>")
    '    strCustomFieldTD.Append("</tr>")
    'End If
    'CommonFunction.Data.DisposeDataReader(drLayout)
    ' '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    'CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
    'CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
    ' '''End of Modification by Dhanashri S on 7 Oct 2015 
    'strCustomFieldTD.Append("</TABLE>")

    'Return strCustomFieldTD.ToString + vbCrLf
    ''+ " #### " + vbCrLf + declarevariables + vbCrLf + strClientSideScript + "####" + StrHTMLGuidelines.ToString + "####" + Flag1


    ' End Function

    Private Sub PlotCustomFieldsDetails(ByVal strSubRequestID As String, ByVal RequestTypeID As String, ByVal DepartmentID As String, ByVal QueryID As String, Optional ByVal UserID As Integer = 0, Optional ByVal LoginType As String = "", Optional CustomerID As Integer = 0)
        '==================================================================================
        ' Procedure Name		:	PlotCustomFieldsDetails
        ' Parameters Passed		:	To plot custom fields for Tasks
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	17th Jan 2018
        ' Revisions				:	
        '==================================================================================
        Dim m_lngQueryID As String
        Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        With ObjCustomFieldsSection
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
            'Response.Write(.GetSectionTitle("Custom Fields", "DivCustomFieldsSection", "HideShowCustomFieldsSection"))

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With
        Response.Write("<DIV id=DivCustomFieldsSection width='99.9%' >")

        ''Dim strTaskID As String
        'Dim strDummyTask As String
        'Dim blnDummyDefaultValue As Boolean
        ''strTaskID = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "")
        'If m_lngQueryID <> 0 Then
        '    strDummyTask = strTaskID
        '    blnDummyDefaultValue = False
        'Else
        '    strDummyTask = m_lngTaskId.ToString()
        '    blnDummyDefaultValue = m_blnShowDefaults
        'End If

        Dim objCustomFields As New CRM_AddNewRequest()

        With objCustomFields

            .EntityName = "Help-Desk"
            .FormName = "frmRequestDetails"
            .PrimaryKey = "QueryID"
            .PrimaryTable = "Tbl_CRM_Query_Master"
            .TypeID = strSubRequestID
            .IsAddNewMode = IIf(QueryID = 0, True, False)
            .PrimaryKeyValue = QueryID
            .QueryStringForTypeChange = "SubRequestTypeID"
            .m_lngProjectId = 0
            .PlotCustomFields(UserID, LoginType, strSubRequestID, RequestTypeID, DepartmentID, CustomerID)
            declarevariables = .VariableDeclarationScript
            strClientSideScript = .ValidationScript
            strDefaultScript = .DefaultValueScript
            m_strCustomFieldList = .AccesibleCustomFields
        End With

        Response.Write("</DIV>")

        'Added By Amol Changle On: 22 Jul 2009
        HttpContext.Current.Response.Write("####")
        'Purpose: To render Custom Field validations
        CommonFunctions.General.WriteHTML(vbCrLf)

        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("function ValidateCustomFields(){")
        If Not declarevariables Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(declarevariables)
        End If


        If Not strClientSideScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strClientSideScript)
        End If
        If Not strDefaultScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strDefaultScript)
        End If
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("return true;}")
        CommonFunctions.General.WriteHTML(vbCrLf)
        'CommonFunctions.General.WriteHTML("</script>")
        'End Addition
        Response.End()
    End Sub

    Public Sub PlotCustomFields(Optional ByVal UserID As Integer = 0, Optional ByVal LoginType As String = "", Optional strSubRequestID As String = "", Optional RequestTypeID As String = "", Optional DepartmentID As String = "", Optional CustomerID As Integer = 0)
        '==================================================================================
        ' Procedure Name		:	PlotCustomFields
        ' Parameters Passed		:	To plot custom fields for Tasks
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	17th Jan 2018
        ' Revisions				:	
        '==================================================================================

        Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
        Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
        Dim intDestinationIndex, intSourceIndex As Integer
        Dim drLayout As IDataReader
        Dim drCustomAccess As IDataReader
        Dim strSQLForCustom As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer
        Dim intCorporateRoleLevel As Integer

        Dim m_lngRoleId As String = ""
        Dim m_lngProjectId As Integer = 0
        Dim m_strEntityName As String = "help-desk"

        Dim m_lngUserId As String = ""
        'Dim strSQLQuery As String = ""
        Dim m_strCurrentType As String = ""
        Dim m_strTypeInaccessibleCustomFieldList As String
        Dim m_strCustomFieldList As String
        Dim m_intMaxRows As Integer
        Dim m_intMaxCols As Integer
        Dim ArrCtlAttr(20) As String
        Dim arrEventHandlers(30, 3) As String
        Dim strFieldValue As String = ""
        Dim strDummyFieldValue As String = ""
        Dim m_strPrimaryKey As String = "QueryID"         'can have value TaskID,ScheduleID,ReviewID etc
        Dim m_strPrimaryTable As String = "Tbl_CRM_Query_Master"        'Table From which Custom field Values  to be retrived
        Dim m_strPrimaryKeyID As Long = 0
        Dim strEventHandlers As String
        Dim strDefaultScript As String
        Dim strClientSideScript As String
        Dim m_blnShowDefaults As Boolean = False
        Dim declarevariables As String = ""
        Dim IsAddNewMode As Boolean = True
        Dim m_strFormName As String = "frmAddNewRequest"
        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        m_strCurrentType = strSubRequestID
        If Not m_lngProjectId > 0 Then
            m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
        Else
            '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
            intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_EmployeeID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'm_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            End If
        End If
        If Not m_lngRoleId > 0 Then
            m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        End If


        m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)

        If UserID = 0 Then
            UserID = CType(HttpContext.Current.Session("intUserID"), Integer)
        End If
        If LoginType = "" Then
            LoginType = Session("LoginType").ToString()
        End If

        'Added By Amol Changle On: 22 Jul 2009
        'Purpose: For Entity "Help-Desk" ProjectID is considered to be 0.
        'Modified By Syamantak Chavan on 21 Sept 2011 For Custom Field addition in whizible 10.0
        If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Modified by NitinC on 14 April 2011 for WhizibleSEM 10.0
            m_lngProjectId = 0
        End If
        'End Addition

        m_strCustomFieldList = ""
        m_strTypeInaccessibleCustomFieldList = ""

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        'Get Accesible CustomFieldIDs List
        strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleId.ToString + "," + UserID.ToString
        If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
            strSQLForCustom = strSQLForCustom + ",'" + m_strEntityName + "'"
        End If

        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Login Type specific issues
        strSQLForCustom += ",'" + LoginType + "'"
        'End Addition

        drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)
        While drCustomAccess.Read
            ReDim Preserve strCustomFieldIDs(intCount)
            strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            intCount += 1
        End While
        CommonFunction.Data.DisposeDataReader(drCustomAccess)


        ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
        'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_PM_CustomFields_Master WHERE ProjectID = " + m_lngProjectId.ToString + " AND Active = 1"

        If m_strCurrentType Is Nothing OrElse m_strCurrentType = "" Then
            m_strCurrentType = "NULL"
        End If

        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + m_lngProjectId.ToString + "," + m_strCurrentType

        If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
            'strSQLQuery = strSQLQuery + " And EntityName = '" & m_strEntityName & "'"
            strSQLQuery = strSQLQuery + " ,'" & m_strEntityName & "'"
        Else
            'strSQLQuery = strSQLQuery + " And EntityName = 'Task'"
            strSQLQuery = strSQLQuery + ",'Task'"
        End If
        strSQLQuery = strSQLQuery + ",1," + UserID.ToString()


        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Login Type specific issues
        strSQLQuery += ",'" + LoginType + "'"
        'End Addition

        'usp_Sel_tbl_PM_CustomFields_Master_MaxRows

        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drLayout.Read Then
            m_intMaxRows = CType(drLayout("MaxRows"), Integer)
            m_intMaxCols = CType(drLayout("MaxCols"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        'Start Plotting of Custom Fields
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168



        'HttpContext.Current.Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString + ", NULL, 1"


        If IsNothing(m_strCurrentType) = True Then m_strCurrentType = ""

        'Commented and Added by Usha Pandit on 01 Aug 2018 for SP error if pass NULL CurrentType
        'If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
        If m_strCurrentType = "NULL" Then
            If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",''"
        Else
            If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
        End If

        'End of Added by Usha Pandit on 01 Aug 2018 for SP error if pass NULL CurrentType

        If m_strEntityName.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strEntityName + "'"

        'Added by ShraddhaM
        strSQLQuery = strSQLQuery + "," + UserID.ToString()
        'Ended by ShraddhaM

        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Login Type specific issues
        strSQLQuery += ",'" + LoginType + "'"
        'End Addition


        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        'Call GetValidationRules()
        Dim strClientSideScriptNew As String = ""


        If drLayout.Read() Then
            For intRow = 1 To m_intMaxRows



                'Commented and Added by Usha Pandit on 31 July 2018 for custom field validation function creation
                'declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                If Not declarevariables.Contains("var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf) Then
                    declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                End If
                'End of Added by Usha Pandit on 31 July 2018 for custom field validation function creation

                'Added By Amol Changle On: 22 Jul 2009
                'Purpose: Not to render blank rows
                If CommonFunctions.Data.CheckIsDBNull(drLayout("RowNumber")) = intRow.ToString() Then
                    'End Addition


                    ' HttpContext.Current.Response.Write("<TR class=clsTREven >")

                    For intCol = 1 To m_intMaxCols
                        intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
                        intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

                        If intCurrentCellNumber < intNextCellNumber Then
                            ' HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")

                        ElseIf intCurrentCellNumber >= intNextCellNumber Then


                            'Commented and Added by Usha Pandit on 31 July 2018 for custom field validation function creation
                            'declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                            If Not declarevariables.Contains("var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf) Then
                                declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                            End If
                            'End of Added by Usha Pandit on 31 July 2018 for custom field validation function creation

                            'HttpContext.Current.Response.Write("<td valign=top align=right style='width:10%'>")
                            'HttpContext.Current.Response.Write("<td valign=top align=right width='5%'>")

                            'HttpContext.Current.Response.Write("<div class='row'>")
                            'HttpContext.Current.Response.Write("<div class='form-group'>")
                            HttpContext.Current.Response.Write("<div class=''>")
                            HttpContext.Current.Response.Write("<div class=''>")


                            'If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                            '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                            'End If



                            'get value form form
                            'If m_blnShowFormContents = True Then

                            Dim strCustomFieldName As String = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)
                            If Not HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
                                strFieldValue = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)

                                'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
                                ' Added checkisdbNull to get strDummyFieldValue and strFieldValue
                                'Save Database value also

                                If m_strPrimaryKeyID > 0 Then
                                    'If Not rsIssueDetails.EOF Then
                                    Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
                                    strDummyFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
                                    'End If
                                Else
                                    strDummyFieldValue = ""
                                End If

                            Else
                                If m_strPrimaryKeyID > 0 Then
                                    'If Not rsIssueDetails.EOF Then
                                    Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
                                    strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
                                    'End If
                                Else
                                    strFieldValue = ""
                                End If
                                strDummyFieldValue = strFieldValue
                            End If

                            'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes  

                            ' Retrieve the attributes of the control to be displayed.
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
                            'Modified By VarunA on 27-Sep-2008
                            'Purpose : Security Issue
                            'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
                            'End By VarunA on 27-Sep-2008
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = strFieldValue
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"
                            If (drLayout("DataType").ToString = "1") Then
                                If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",3,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "3,"
                                End If
                            End If

                            ' Set the control type depending on the name of the custom field to be displayed.
                            ' For Text Area custom fields...

                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then
                                'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue

                                ''HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                'HttpContext.Current.Response.Write("<div class='col-sm-6'>")

                                Dim strControlWidth As String = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                                If strControlWidth = "" Or strControlWidth = "0" Or strControlWidth Is Nothing Then
                                    strControlWidth = "200"
                                End If

                                If CInt(strControlWidth) < 150 Then
                                    HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                Else
                                    HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                End If

                                'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue


                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

                                ' Set the maxlengths of the textareas.
                                'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 3800 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If
                                'End If

                                intDestinationIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Text Box custom fields...
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then


                                'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
                                ''HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                'HttpContext.Current.Response.Write("<div class='col-sm-6'>")

                                Dim strControlWidth As String = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                                If strControlWidth = "" Or strControlWidth = "0" Or strControlWidth Is Nothing Then
                                    strControlWidth = "200"
                                End If

                                If CInt(strControlWidth) < 150 Then
                                    HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                Else
                                    HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                End If
                                'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue



                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                                ' Set the maxlengths of the textboxes.
                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If

                                ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
                                If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"
                                End If

                                intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Combo Box custom fields...									
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

                                'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
                                ''HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                'HttpContext.Current.Response.Write("<div class='col-sm-6'>")

                                Dim strControlWidth As String = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                                If strControlWidth = "" Or strControlWidth = "0" Or strControlWidth Is Nothing Then
                                    strControlWidth = "200"
                                End If

                                If CInt(strControlWidth) < 150 Then
                                    HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                Else
                                    HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                End If
                                'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue





                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                                Dim strCombodetails As String = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
                                ''Added By Amol Changle On: 21 Jul 2009
                                ''Purpose: To select field details Entity Specific
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) += ",1,'" + m_strEntityName + "'"
                                ''End Addition

                                ' Set the maxlengths of the combobox.
                                'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
                                'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
                                '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
                                'End If
                                'If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                'End If

                                intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Date Control custom fields...								
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
                                'HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"

                                intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)



                            End If

                            ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "False"
                            If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                            End If



                            ' If the default value is to be retrieved from one of the common fields or custom fields, then...
                            If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

                                ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
                                If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) Then

                                    ' Get the index of the custom fields.
                                    If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
                                        ' Text Area Range	: 26 - 28.
                                        intSourceIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
                                    ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
                                        ' Text box Range	: 1 - 10.
                                        intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
                                    ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
                                        ' Combo box Range	: 11 - 20.
                                        intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
                                    ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
                                        ' Date control Range: 21 - 25.
                                        intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
                                    End If

                                    strEventHandlers = ""
                                    strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                    strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                    strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

                                    If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                        strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
                                    Else
                                        strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                    End If

                                    strEventHandlers = strEventHandlers + "}" + vbCrLf

                                    arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

                                End If

                                strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
                                strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

                                'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
                                'Else
                                '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                'End If

                                strDefaultScript = strDefaultScript + "}" + vbCrLf
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = ""

                                ' For Numweric custom fields...
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then

                                'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
                                ''HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                'HttpContext.Current.Response.Write("<div class='col-sm-6'>")

                                Dim strControlWidth As String = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                                If strControlWidth = "" Or strControlWidth = "0" Or strControlWidth Is Nothing Then
                                    strControlWidth = "200"
                                End If

                                If CInt(strControlWidth) < 150 Then
                                    HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                Else
                                    HttpContext.Current.Response.Write("<div class='col-sm-8'>")
                                End If
                                'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue


                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                                ' Set the maxlengths of the textboxes.
                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "3,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If


                                'intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(Customer.CCommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                                intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldNumeric") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)


                            End If

                            'HttpContext.Current.Response.Write(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))

                            If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True" Then
                                'Commented and Added by Usha Pandit on 30 July 2018 for long text wrap issue
                                'HttpContext.Current.Response.Write("<label for='sel1'>" + drLayout("UserGivenCaption").ToString.Trim + " * </label>")
                                HttpContext.Current.Response.Write("<label for='sel1' style='word-break: break-all;line-height: 15px;margin-top: 5px;'>" + drLayout("UserGivenCaption").ToString.Trim + " * </label>")
                                'End of Added by Usha Pandit on 30 July 2018 for long text wrap issue
                            Else
                                'Commented and Added by Usha Pandit on 30 July 2018 for long text wrap issue
                                'HttpContext.Current.Response.Write("<label for='sel1'>" + drLayout("UserGivenCaption").ToString.Trim + " </label>")
                                HttpContext.Current.Response.Write("<label for='sel1' style='word-break: break-all;line-height: 15px;margin-top: 5px;'>" + drLayout("UserGivenCaption").ToString.Trim + " </label>")
                                'End of Added by Usha Pandit on 30 July 2018 for long text wrap issue
                            End If
                            'HttpContext.Current.Response.Write("</td>")
                            'HttpContext.Current.Response.Write("<td valign=top style='width:15%'>")


                            'HttpContext.Current.Response.Write("<td valign=top bgcolor=green >")
                            Dim blnShowControl As Boolean = False
                            Dim intCounter As Integer

                            intCounter = 0
                            'If length of array is greater than 0 that means security is explicitly set
                            'In that case check if it is accessible ,if yes then show the control, 
                            'otherwise show it as not applicable
                            If intCount > 0 Then

                                While intCounter < intCount
                                    'Check if the current Custom Field ID is in the array
                                    If strCustomFieldIDs(intCounter).ToLower.Trim =
                                                CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
                                        blnShowControl = True
                                        Exit While
                                    End If

                                    intCounter = intCounter + 1

                                End While

                            Else
                            End If

                            If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
                                m_strCustomFieldList = m_strCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","
                                Call DrawControl(ArrCtlAttr)
                                Call ClearAttributes(ArrCtlAttr)
                            Else

                                If IsAddNewMode = True Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
                                End If

                                'The Custom Field is not defied for the Current Type
                                HttpContext.Current.Response.Write("( " + MyBase.GetResourceString("NbyA") + " )")

                                'Do not save value if the Custom Field is not applicable
                                If drLayout("IsCustomFieldAssigned").ToString <> "1" And blnShowControl = True Then
                                    m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","

                                    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                                    CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , strDummyFieldValue, IsHidden:=True, EnableHTMLEncode:=True)
                                Else
                                    CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , , IsHidden:=True, EnableHTMLEncode:=True)
                                End If
                                CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)
                                '''End of Modification by Dhanashri S on 7 Oct 2015 

                                ' reset value of inactive custom fields before saving.
                                strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
                            End If
                            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "Select 'Request Type'", , , "class='form-control' onchange=RequestType_OnChange(this)", False, True))
                            HttpContext.Current.Response.Write("</div>")


                            If Not drLayout.Read() Then
                                Dim i As Integer
                                For i = intCol To m_intMaxCols - 1
                                    'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        Else
                            ' HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
                            'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
                            If Not drLayout.Read() Then
                                Dim i As Integer
                                For i = intCol To m_intMaxCols - 1
                                    '  HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        End If
                    Next
                    HttpContext.Current.Response.Write("</div>")
                    HttpContext.Current.Response.Write("</div>")
                    ' HttpContext.Current.Response.Write("</TR>")
                End If

            Next
            If m_strCustomFieldList <> "" Then
                m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
            End If
            If m_strTypeInaccessibleCustomFieldList <> "" Then
                m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList.Substring(0, m_strTypeInaccessibleCustomFieldList.Length - 1)
            End If
            HttpContext.Current.Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
            CommonFunction.Data.DisposeDataReader(drLayout)

            Dim intCtr As Integer
            ' Loop through the array to check if any event handlers need to be printed.
            For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

                ' If the control name is present and the event handler is present, then print it.
                ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
                ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
                ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
                If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
                    If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                        HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
                    Else
                        HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
                    End If
                    HttpContext.Current.Response.Write(arrEventHandlers(intCtr, 2))
                    HttpContext.Current.Response.Write("}" + vbCrLf)
                End If
            Next



            HttpContext.Current.Response.Write("</SCRIPT>" + vbCrLf)
        Else
            HttpContext.Current.Response.Write("<tr class=clsTREven>")
            HttpContext.Current.Response.Write("<td align=center valign=center>")
            HttpContext.Current.Response.Write("<p style='padding: 14px 8px;font-size: 11px;'>No Custom fields has been defined</p>")

            HttpContext.Current.Response.Write("</td>")
            HttpContext.Current.Response.Write("</tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)

        HttpContext.Current.Response.Write("</TABLE>")


        HttpContext.Current.Response.Write("####")

        Dim objNewRequest As New CRM_AddNewRequest()
        'Dim m_intCustomer As Integer = 0
        Dim m_intRequestedEmployee As Integer = 0
        Dim m_strMode As String = "NEW"
        Dim dr As IDataReader
        Dim strGuidelinesColumnName As String = ""

        If UCase(Trim(m_strMode & "")) = "NEW" And Trim(strSubRequestID & "") <> "" And ((m_intCustomer = 0) Or (m_intRequestedEmployee <> 0)) And LoginType = "E" Then
            'End by Yogesh Jalamkar
            Dim IsApproval As String
            IsApproval = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_CRM_Function_RequestTypes_Approval " & DepartmentID & "," & RequestTypeID & "," & strSubRequestID, True), String)
            If IsApproval = "1" Then
                HttpContext.Current.Response.Write("<div >")
                HttpContext.Current.Response.Write("<label for='sel1' id='lblApprovalStatus'>")
                HttpContext.Current.Response.Write("This request will require Approval Of Reporting To.")
                HttpContext.Current.Response.Write("</label>")
                HttpContext.Current.Response.Write("</div>")
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If


        If Trim(strSubRequestID & "") <> "" Then
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & strSubRequestID, True)
            If dr.Read Then
                If Trim(dr("GuidelinesForRequestor").ToString & "") <> "" Then
                    HttpContext.Current.Response.Write("<div class='row'>")
                    HttpContext.Current.Response.Write("<div >")
                    HttpContext.Current.Response.Write("<div class='col-sm-12'>")
                    HttpContext.Current.Response.Write("<label for='sel1'>")
                    HttpContext.Current.Response.Write(objNewRequest.GetCaption(919, "GuidelinesForRequestor") & ":")
                    HttpContext.Current.Response.Write("</label>")
                    HttpContext.Current.Response.Write("<label for='sel1'>")
                    HttpContext.Current.Response.Write(dr("GuidelinesForRequestor").ToString & "")
                    HttpContext.Current.Response.Write("</label></div>")
                    HttpContext.Current.Response.Write("</div>")
                    HttpContext.Current.Response.Write("</div>")
                End If
            End If
            CommonFunction.Data.DisposeDataReader(dr)
        End If

        'HttpContext.Current.Response.Write("####")
        Dim objAddNewRequest1 As New CRM_AddNewRequest
        Dim arrtemp(50) As String
        arrValidationMessages.CopyTo(arrtemp, 0)
        Dim drCustomField As IDataReader
        ' HttpContext.Current.Response.Write(objNewRequest.GenerateValidationScript1(ArrCtlAttr, arrtemp))
        'Commented and Added by Usha Pandit on 01 Aug 2018 for SP error if pass NULL CurrentType
        'strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master  0,NULL,1," & strSubRequestID & ",'Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & LoginType & "'"
        If strSubRequestID = "" Or strSubRequestID = "NULL" Or strSubRequestID Is Nothing Then
            strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master  0,NULL,1,'" & strSubRequestID & "','Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & LoginType & "'"
        Else
            strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master  0,NULL,1," & strSubRequestID & ",'Help-Desk'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & LoginType & "'"
        End If

        'End of Added by Usha Pandit on 01 Aug 2018 for SP error if pass NULL CurrentType

        drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)


        objAddNewRequest1.GetValidationRules()
        objAddNewRequest1.arrValidationMessages.CopyTo(arrtemp, 0)
        Dim strControlName As String
        Dim intControlWidth As String
        Dim strControlCaption As String
        Dim strControlValue As String
        Dim intControlMaxLength As String
        Dim intControlHeight As String
        Dim strDataType As String
        Dim strControlValidationRules As String
        Dim intControlMinValue As String
        Dim intControlMaxValue As String
        Dim strToBeInserted As String
        Dim SQLQuey As String
        Dim blnIsMandatory As String
        Dim strControlValidations As New StringBuilder("")
        'Added by Usha Pandit on 31 July 2018 for custom field validation
        Dim strClientSideScriptForCustomField As String = " var blnResult = true;   var strmsg = """";  var errorMsg =  ""<ul>"";"
        'End of Added by Usha Pandit on 31 July 2018 for custom field validation
        While drCustomField.Read

            strControlName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            intControlWidth = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlWidth"), ""), "")
            strControlCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("UserGivenCaption"), ""), "")
            strControlValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DefaultValue"), ""), "")
            'strToBeInserted = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            'blnIsMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            intControlMaxLength = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxLength"), "0"), "0")
            intControlHeight = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlHeight"), "0"), "0")

            intControlMinValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MinValue"), "0"), "0")
            intControlMaxValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxValue"), "0"), "0")
            strDataType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DataType"), "0"), "0")

            strControlValidationRules = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ValidationRules"), ""), "")
            strToBeInserted = "disabled"
            SQLQuey = "Exec usp_Sel_tbl_PM_CustomFields_Details  " & strControlName & ",0,1,'Help-Desk'"
            blnIsMandatory = False

            If InStr("," + strControlValidationRules.ToString.Trim, ",1,") <> 0 Then
                blnIsMandatory = True
            End If

            If Not IsNumeric(intControlMaxLength) Or intControlMaxLength = "0" Then
                intControlMaxLength = "100"
            ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
                If (intControlMaxLength > "3800") Then
                    intControlMaxLength = "3800"
                End If
            Else
                If (intControlMaxLength > "100") Then
                    intControlMaxLength = "100"
                End If
            End If


            If intControlWidth = "" Then
                intControlWidth = "200"
            End If


            Dim blnShowControl As Boolean = False
            Dim intCounter As Integer

            intCounter = 0
            'If length of array is greater than 0 that means security is explicitly set
            'In that case check if it is accessible ,if yes then show the control, 
            'otherwise show it as not applicable
            If intCount > 0 Then

                While intCounter < intCount
                    'Check if the current Custom Field ID is in the array
                    If strCustomFieldIDs(intCounter).ToLower.Trim =
                                CType(CommonFunction.General.CheckIsNothing(drCustomField("UniqueId")), String).ToLower.Trim Then
                        blnShowControl = True
                        Exit While
                    End If

                    intCounter = intCounter + 1

                End While

            Else
            End If





            'Commented and Added by Usha Pandit on 31 July 2018 for custom field validation
            'HttpContext.Current.Response.Write(GenerateValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrtemp))

            If (strDataType = "1") Then
                If InStr(1, "," + strControlValidationRules, ",3,") = 0 Then
                    strControlValidationRules = strControlValidationRules + "3,"
                End If
            End If
            Dim arrCurrenctFiledValidationMsg(50) As String
            arrValidationMessages.CopyTo(arrCurrenctFiledValidationMsg, 0)
            objAddNewRequest1.GetValidationRules()
            objAddNewRequest1.arrValidationMessages.CopyTo(arrCurrenctFiledValidationMsg, 0)

            Dim strCurrentClientSideScriptForCustomField As String = ""
            HttpContext.Current.Response.Write(GenerateCustomFieldValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrCurrenctFiledValidationMsg, strCurrentClientSideScriptForCustomField))
            strClientSideScriptForCustomField = strClientSideScriptForCustomField + vbCrLf + strCurrentClientSideScriptForCustomField
            'End of Added by Usha Pandit on 31 July 2018 for custom field validation
        End While

        'Added by Usha Pandit on 30 July 2018 for custom field validation

        CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
        CommonFunctions.General.WriteHTML("function ValidateCustomFields() {")
        If Not declarevariables Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(declarevariables)
        End If
        If Not strClientSideScriptForCustomField Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strClientSideScriptForCustomField)
        End If
        If Not strDefaultScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strDefaultScript)
        End If
        CommonFunctions.General.WriteHTML(vbCrLf)

        CommonFunctions.General.WriteHTML(" if (strmsg != """") {")
        CommonFunctions.General.WriteHTML("  alertify.dismissAll();")
        CommonFunctions.General.WriteHTML("   alertify.set('notifier', 'position', 'top-right');")
        CommonFunctions.General.WriteHTML("    alertify.notify(errorMsg, 'error', 5);")
        CommonFunctions.General.WriteHTML("   checkvalue = 1;")
        CommonFunctions.General.WriteHTML("}")

        CommonFunctions.General.WriteHTML("return blnResult;}")
        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)



        'End of Added by Usha Pandit on 30 July 2018 for custom field validation


    End Sub 'Plot all custom fields for Issue
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
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim strToBeInserted As String = ""
        Dim strProperty As String
        Dim intCtr As Integer
        Dim strControlCaption As String
        Dim strControlName As String
        Dim strControlValue As String = ""
        Dim SQLQuey As String
        Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
        Dim blnReadOnly As Boolean = False
        Dim blnIsMandatory As Boolean = False
        Dim blnIsDisabled As Boolean = False
        Dim IsAddNewMode As Boolean
        'UnCommented by Usha Pandit on 01 Aug 2018 for plotting magnifier for textarea
        strControlCaption = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
        'End of UnCommented by Usha Pandit on 01 Aug 2018 for plotting magnifier for textarea

        ' If the default values have to be shown, then... (When the page is loaded for the first time.)
        '        If (IsAddNewMode = True And HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing) Then
        If (IsAddNewMode = True) Then
            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
        End If

        If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
            strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE)

            'Uncommented by Usha Pandit on 30 July 2018 for showing default values for Custom fields
            If strControlValue = "" And Not HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing Then
                If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) Is Nothing Then
                    strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
                End If
            End If
            'End of Uncommented by Usha Pandit on 30 July 2018 for showing default values for Custom fields
        Else
            strControlValue = ""
        End If

        ' Control Name
        strControlName = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)

        ' control width 
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH)) <> "" Then
            ' intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH), Integer)
            intControlWidth = "200"
        End If

        'Cotrol Height
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT)) <> "" Then
            intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT), Integer)
        End If

        ' Read Only
        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
            blnReadOnly = True
            strToBeInserted = strToBeInserted & " disabled "
            blnIsDisabled = True
        Else
            blnReadOnly = False
            blnIsDisabled = False
        End If

        ' additional information.
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) <> "" Then
            strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) + " "
        End If

        ' maxlength 
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" Then
            intControlMaxLength = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH), Integer)
            'strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) + " "
        End If

        ' mandatory 
        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True" Then
            blnIsMandatory = True
        Else
            blnIsMandatory = False
        End If


        ' Depending on the control type, draw the control.
        Select Case ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.

                'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , False))

                Dim strTextboxSetWidth As String = ArrCtlAttr(5)
                If strTextboxSetWidth = "" Or strTextboxSetWidth = "0" Or strTextboxSetWidth Is Nothing Then
                    strTextboxSetWidth = "200"
                End If

                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, "form-control clsCustomField", strTextboxSetWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , False))
                'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue


            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                SQLQuey = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY)

                'Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , "form-control", False))

                Dim strComboSetWidth As String = ArrCtlAttr(5)
                If strComboSetWidth = "" Or strComboSetWidth = "0" Or strComboSetWidth Is Nothing Then
                    strComboSetWidth = "200"
                End If
                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, strComboSetWidth, strControlValue, strToBeInserted, True, , "form-control", False))

                'End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.

                'Modified By ShraddhaM on 27 July 2006
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , m_strFormName, , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft"))


                'Commented and Added by Usha Pandit on 01 Aug 2018 for plotting magnifier for textarea
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , False, Wrap:="Soft", EnableHTMLEncode:=True))

                Dim strComboSetWidth As String = ArrCtlAttr(5)
                If strComboSetWidth = "" Or strComboSetWidth = "0" Or strComboSetWidth Is Nothing Then
                    strComboSetWidth = "200"
                End If

                'Commented and Added by Usha Pandit on 19 Apr 2019  for removing magnifier for textarea
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "form-control clsCustomField", "opentextdialog", "frmRequest", "../../../Images/zoomin.gif", , strComboSetWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted & " " & " maxlength = " & CStr(intControlMaxLength), True, False, Wrap:="Soft", EnableHTMLEncode:=True))
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "form-control clsCustomField", , "frmRequest", , , strComboSetWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted & " " & " maxlength = " & CStr(intControlMaxLength), True, False, Wrap:="Soft", EnableHTMLEncode:=True))
                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, "clsCustomField", , "", , , strComboSetWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, True, False, Wrap:="Soft", EnableHTMLEncode:=True))
                'End of Added by Usha Pandit on 19 Apr 2019 for removing magnifier for textarea


                'End of Added by Usha Pandit on 01 Aug 2018 for plotting magnifier for textarea

                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
                If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
                    If Not IsDate(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE).Trim) Then
                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
                    End If
                Else
                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
                End If

                If strControlValue <> "" And strControlValue <> "0" Then
                    ' HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))

                    'Commented and Added by Usha Pandit on 04 aug 2018 for setting default value for date custom field
                    'HttpContext.Current.Response.Write("<input type='text' value='' class='form-control inp clsDateControl' id=" + strControlName + ">")
                    HttpContext.Current.Response.Write("<input type='text' value='" & strControlValue & "' class='form-control inp clsDateControl' id=" + strControlName + ">")
                    'End of Added by Usha Pandit on 04 aug 2018 for setting default value for date custom field

                    HttpContext.Current.Response.Write(" <div class='col-sm-4'>")
                    HttpContext.Current.Response.Write("<i class='fa fa-calendar fcalcustom' id='ContractDate1' style='font-size: 14px;' onclick=""$('#" + strControlName + "').datepicker();$('#" + strControlName + "').datepicker('show');""></i>")
                    HttpContext.Current.Response.Write("</div>")

                  
                Else
                    'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    HttpContext.Current.Response.Write("<input type='text' value='' class='form-control inp clsDateControl' id=" + strControlName + ">")
                    HttpContext.Current.Response.Write(" <div class='col-sm-4'>")
                    HttpContext.Current.Response.Write("<i class='fa fa-calendar fcalcustom' id=" + strControlName + " style='font-size: 14px;' onclick=""$('#" + strControlName + "').datepicker();$('#" + strControlName + "').datepicker('show');""></i>")
                    HttpContext.Current.Response.Write("</div>")
                End If

            Case Else
                HttpContext.Current.Response.Write("&nbsp;")

        End Select
        'Commented and added by Bharat T on 13th-Oct-2015
        'Dim arrtemp(30) As String
        Dim arrtemp(50) As String
        'End of Commented and added by Bharat T on 13th-Oct-2015
        arrValidationMessages.CopyTo(arrtemp, 0)

        'Generate the client side validation scripts for the control.		
        'Call GenerateValidationScript1(ArrCtlAttr, arrtemp)
        'HttpContext.Current.Response.Write(ArrCtlAttr(ATTR_CONTROL_NAME) + ArrCtlAttr(ATTR_READ_ONLY))

        ' If the control is disabled, then enable it before submitting.
        'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
        '    If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME).ToString.Trim, "Keywords") <> 0 Then
        '        strEnableControlsScript = "var obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "= GetObjectReference('frmTaskAssignment','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "',1);" + vbCrLf
        '        For intCtr = 0 To 4
        '            strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "(" + intCtr.ToString + ").disabled = false;" + vbCrLf
        '        Next
        '    Else
        '        strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".disabled = false;" + vbCrLf
        '    End If
        'End If

    End Sub 'Draw the control 

    Public Function GenerateValidationScript1(ByRef arrCtlAttr() As String, ByVal arrValidations() As String)
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
        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).Trim, ",")
        strCaption = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
        If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "Keywords") <> 0 Then
            Exit Function
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
                'End If
            End If

            Dim blnLoopcheck As Boolean = False
            Dim strControlName As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
            Dim strMinValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE)
            Dim strMaxValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE)

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														

                    strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
                    arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				

                    If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION), "'") > 0 Then
                        strValidation = strValidation + "if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                    Else
                        strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                    End If

                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" And Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "0" Then
                        strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.				
                    strValidation = strValidation + "if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.

                    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                End If
                strValidation = strValidation + "return false;" + vbCrLf
                strValidation = strValidation + "}" + vbCrLf
            End If
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
            strClientSideScript = strClientSideScript + strValidation
        ElseIf UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "SUMMARY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "REPORTEDBY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "DESCRIPTION" Then
            strClientSideScript = strClientSideScript + strValidation
        End If

    End Function
    'Private Sub GetValidationRules()
    '    '==================================================================================
    '    ' Procedure Name		:	GetValidationRules
    '    ' Parameters Passed		:	To get all the validation messages in an array
    '    ' Returns				:	none
    '    ' Parameters Affected	:	none
    '    ' Purpose				:	
    '    ' Description			:	Same as above.
    '    ' Assumptions			:	
    '    ' Dependencies			:	None
    '    ' Author				:	SandipL
    '    ' Created				:	20 Jan 2006
    '    ' Revisions				:	
    '    '==================================================================================		

    '    Dim drValidationRules As IDataReader

    '    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    '    ' Retrieve all the validation messages.
    '    '  drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
    '    drValidationRules = CommonFunction.Data.GetDataReader("usp_SEL_tbl_UI_Validation ", MyBase.UseSQL)

    '    ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    '    'Save all these validation messages in array
    '    Do While drValidationRules.Read
    '        arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
    '    Loop

    '    'Dispose data reader
    '    CommonFunction.Data.DisposeDataReader(drValidationRules)
    'End Sub 'Get all validation rules and generate array
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
        ' Author				:	SandipL
        ' Created				:	19 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim intCtr As Integer

        For intCtr = 0 To 14
            arrCtlAttr(intCtr) = ""
        Next

        arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"

    End Sub 'Clear control Atributes
    Public Function GenerateValidationScript(ByVal strControlValidationRules As String, ByVal strControlName1 As String, ByVal strControlCaption As String, ByVal intControlMinValue As String, ByVal intControlMaxValue As String, ByVal intControlMaxLength As Integer, ByRef strControlValidations As StringBuilder, ByVal arrValidations() As String)
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
            Exit Function
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

    End Function

    'Added by Usha Pandit on 31 July 2018 for Custom Field Validation
    Public Function GenerateCustomFieldValidationScript(ByVal strControlValidationRules As String, ByVal strControlName1 As String, ByVal strControlCaption As String, ByVal intControlMinValue As String, ByVal intControlMaxValue As String, ByVal intControlMaxLength As Integer, ByRef strControlValidations As StringBuilder, ByVal arrValidations() As String, ByRef strControlValidationsScript As String)
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
            Exit Function
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                'arrValidations(intValidationID) = arrValidationMessages(intValidationID)
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

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(1), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(1), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf
                    'strValidation = strValidation + " return;" + vbCrLf

                    'arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    If InStr(strControlCaption, "'") > 0 Then
                        ''  strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                        strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf

                        'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + " ', 'error');" + vbCrLf
                        strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(2), False) + "'" + vbCrLf
                        strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf

                        'strValidation = strValidation + "       return;" + vbCrLf
                    Else
                        ' strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                        strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf

                        'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + "', 'error');" + vbCrLf
                        strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(2), False) + "'" + vbCrLf
                        strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                        'strValidation = strValidation + "       return;" + vbCrLf
                    End If

                    strValidation = strValidation + "       if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    '  'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    'End If

                    strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(2), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                    'strValidation = strValidation + "       return;" + vbCrLf
                    strValidation = strValidation + "   }}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ")==true){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(3), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(3), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ")==true){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(9), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(9), False) + "'" + vbCrLf

                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(intControlMaxLength) <> "" And Trim(intControlMaxLength) <> "0" Then
                        '  strValidation = strValidation + "   if(disallowMaxlengthViolation(obj" + strControlName + "," + CType(intControlMaxLength, String) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", intControlMaxLength), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "       if(disallowMaxlengthViolation(obj" + strControlName + ")==true){" + vbCrLf

                        'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(12), False) + "', 'error');" + vbCrLf
                        strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(12), False) + "'" + vbCrLf
                        strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                        'strValidation = strValidation + "       return;" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + CType(intControlMaxLength, String) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.	
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNegativeNumeric(obj" + strControlName + ")==true){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(13), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(13), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf

                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    '     strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ")==true){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(15), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(arrValidations(15), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf

                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(16), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    '  strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(17), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf

                    strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    'strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + ")==true){" + vbCrLf

                    'strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    'strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(18), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " strmsg = '- " + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "'" + vbCrLf
                    strValidation = strValidation + " errorMsg += '<li>' + strmsg + '</li>';" + vbCrLf


                    'strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                'End If
                strValidation = strValidation + "	        setFocus(obj" + strControlName + ");" + vbCrLf

                'strValidation = strValidation + "           return false;" + vbCrLf
                strValidation = strValidation + "          blnResult = false;" + vbCrLf

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
            strControlValidationsScript = strControlValidationsScript + strValidation
        Else
            strControlValidationsScript = strControlValidationsScript + strValidation
        End If

    End Function
    'End of Added by Usha Pandit on 31 July 2018 for Custom Field Validation
    Protected Sub GetValidationRules()
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

    ''Public Shared Function SaveRequestDetails(ByVal Subject As String, ByVal Description As String, ByVal Department As String, ByVal RequestType As String, ByVal SubRequestType As String, ByVal Priority As String, ByVal Product As String, ByVal ModuleComponent As String, ByVal Location As String, ByVal TimeZone As String, ByVal Status As String, ByVal Project As String, ByVal AssignTo As String, ByVal m_strCustomFieldList As String, ByVal strTypeInaccessibleCustomFieldList As String, ByVal objCustomField As String)
    <System.Web.Services.WebMethod>
    Public Shared Function SaveRequestDetails(ByVal Subject As String, ByVal Description As String, ByVal Department As String, ByVal RequestType As String, ByVal SubRequestType As String, ByVal Priority As String, ByVal Product As String, ByVal ModuleComponent As String, ByVal Location As String, ByVal TimeZone As String, ByVal Status As String, ByVal Project As String, ByVal AssignTo As String, ByVal objCustomField As String, ByVal CustomFieldValue As String, ByVal ExpResoulDate As String, ByVal CC As String, ByVal CustomerID As String, ByVal EmployeeID As String, ByVal Severity As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Subject = Utilities.Security.SecurityBuilder.CheckUserInput(Subject, 2, True, False, False)
        Description = Utilities.Security.SecurityBuilder.CheckUserInput(Description, 2, True, False, False)
        Department = Utilities.Security.SecurityBuilder.CheckUserInput(Department, 2, True, False, False)
        RequestType = Utilities.Security.SecurityBuilder.CheckUserInput(RequestType, 2, True, False, False)
        SubRequestType = Utilities.Security.SecurityBuilder.CheckUserInput(SubRequestType, 2, True, False, False)
        Priority = Utilities.Security.SecurityBuilder.CheckUserInput(Priority, 2, True, False, False)
        Product = Utilities.Security.SecurityBuilder.CheckUserInput(Product, 2, True, False, False)
        ModuleComponent = Utilities.Security.SecurityBuilder.CheckUserInput(ModuleComponent, 2, True, False, False)
        Location = Utilities.Security.SecurityBuilder.CheckUserInput(Location, 2, True, False, False)
        TimeZone = Utilities.Security.SecurityBuilder.CheckUserInput(TimeZone, 2, True, False, False)
        Status = Utilities.Security.SecurityBuilder.CheckUserInput(Status, 2, True, False, False)
        Project = Utilities.Security.SecurityBuilder.CheckUserInput(Project, 2, True, False, False)
        AssignTo = Utilities.Security.SecurityBuilder.CheckUserInput(AssignTo, 2, True, False, False)
        objCustomField = Utilities.Security.SecurityBuilder.CheckUserInput(objCustomField, 2, True, False, False)
        CustomFieldValue = Utilities.Security.SecurityBuilder.CheckUserInput(CustomFieldValue, 2, True, False, False)
        ExpResoulDate = Utilities.Security.SecurityBuilder.CheckUserInput(ExpResoulDate, 2, True, False, False)
        CC = Utilities.Security.SecurityBuilder.CheckUserInput(CC, 2, True, False, False)
        CustomerID = Utilities.Security.SecurityBuilder.CheckUserInput(CustomerID, 2, True, False, False)
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Severity = Utilities.Security.SecurityBuilder.CheckUserInput(Severity, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            'response.Write("Bad Request found")
            response.Write("Too many attempts for this request")
            Return "Too many attempts for this request"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim m_strUserName As String = HttpContext.Current.Session("strUserName").ToString
            Dim m_strLoginType As String = HttpContext.Current.Session("LoginType").ToString
            Dim m_lngLoginID As String = HttpContext.Current.Session("intLOGINID")
            Dim m_intCustomer As Integer
            Dim strUserName As String = ""
            Dim strSQL As String
            Dim RequestID As String = "0"
            Dim IsloginCreated As String = "1"
            If CustomerID <> 0 And CustomerID <> "" Then

                strSQL = "usp_sel_tbl_PM_Login_IsCreatedByCustomer " + CustomerID.ToString
                IsloginCreated = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Integer)
            End If

            If IsloginCreated = 1 Then

                If Status = "" Then
                    Status = "1"
                End If

                If Project = "" Then
                    Project = "NULL"
                End If
                If AssignTo = "" Then
                    AssignTo = "NULL"
                End If

                If m_strLoginType <> "E" Then
                    Location = "NULL"
                End If

                If Location = "" Then
                    Location = "NULL"
                End If

                If Priority = "" Then
                    Priority = "NULL"
                End If

                If Product = "" Then
                    Product = "null"
                End If
                If ModuleComponent = "" Then
                    ModuleComponent = "null"
                End If
                If Severity = "" Then
                    Severity = "NULL"
                End If

                Dim m_strRequestedEmployee As String = ""
                Dim m_intRequestedEmployeePost As String = ""
                Dim m_strRequestedEmployeeUN As String = ""
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


                Dim drCustomer As IDataReader
                Dim strCustomerShortName As String
                Dim strCust As String
                Dim strRequestType As String
                Dim strClientID As String
                Dim EmployeeName As String
                Dim ClientName As String = ""
                Dim m_OnBehalfOfCustomer As String


                Dim blnShowPopup As Boolean
                Dim blnSendMail As Boolean
                Dim strFromEmailID As String
                Dim strToMailID As String
                Dim strCCToMailID As String
                Dim strSubject, strMessage As String
                Dim dr As IDataReader

                'drCustomer = CommonFunctions.Data.GetDataReader("select CustomerID from tbl_pm_customer where Customer =" & m_intCustomer & "", m_blnUseSQL)
                m_intCustomer = CustomerID
                strClientID = CType(HttpContext.Current.Session("intLoginID"), String)


                strCust = "usp_sel_tbl_pm_customer_CustomerID " & m_intCustomer

                drCustomer = CommonFunctions.Data.GetDataReader(strCust, True)

                If drCustomer.Read Then
                    strCustomerShortName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomer("CustomerID"), "0"), String)
                End If
                CommonFunctions.Data.DisposeDataReader(drCustomer)

                '' strRequestType = m_strVal 'CType(HttpContext.Current.Session("RTVal"), String)

                If (m_intCustomer <> 0) Then ' And strRequestType = "C"
                    strUserName = CommonFunctions.General.BuildQueryString(strCustomerShortName)
                    m_strLoginType = "C"
                Else
                    If EmployeeID <> 0 Then
                        strUserName = CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN)
                    Else
                        strUserName = CommonFunctions.General.BuildQueryString(m_strUserName)
                    End If
                    m_strLoginType = HttpContext.Current.Session("LoginType").ToString
                End If


                If ((m_intCustomer <> 0) Or (EmployeeID <> 0)) And HttpContext.Current.Session("LoginType").ToString = "E" Then
                    m_OnBehalfOfCustomer = CType(HttpContext.Current.Session("intUserID"), Long)
                Else
                    m_OnBehalfOfCustomer = "Null"
                End If


                If ((m_intCustomer <> 0) Or (EmployeeID <> 0)) And m_strLoginType = "E" Then
                    strSQL += "," & CType(HttpContext.Current.Session("intUserID"), Long)
                Else
                    strSQL += ", Null"
                End If


                Dim m_strLoginName As String
                Dim m_blnIsClient As String
                Dim drClient As IDataReader
                strSQL = "USP_SEL_TBL_PM_LOGIN_CLIENTDETAILS " & CType(m_lngLoginID, String)
                drClient = CommonFunctions.Data.GetDataReader(strSQL, True)
                If drClient.Read Then
                    m_strLoginName = CType(CommonFunctions.Data.CheckIsDBNull(drClient("LOGINNAME"), ""), String)
                    m_blnIsClient = CType(CommonFunctions.Data.CheckIsDBNull(drClient("ISCREATEDBYCUSTOMER"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(drClient)

                If m_blnIsClient = True Then
                    ClientName = CommonFunctions.General.BuildQueryString(m_strLoginName)
                Else
                    ClientName = "Null "
                End If

                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, True).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, True).ToString

                'Commented and Added by nilam rawool on 12/12/2018
                'ExpResoulDate = CommonFunction.Data.GetDataScalar("select REPLACE((convert(varchar(50),ExpectedResolvedDate,106)) ,' ','-') from tbl_CRM_Query_Master", True).ToString

                'Commented and Added by Usha Pandit on 14.03.2019 for saving corrected expected resolution date
                ExpResoulDate = CommonFunction.Data.GetDataScalar("SELECT replace(convert(NVARCHAR, '" & ExpResoulDate & "', 106), ' ', '-')", True).ToString
                'End ofAdded by Usha Pandit on 14.03.2019 for saving corrected expected resolution date

                'ended by nilam rawool on 12/12/2018

                'Added by Dipali V On 13th March 2019 Priority & Severity Issue
                strSQL = "exec usp_NG2_INS_RequestDetails  '" & Replace(Subject, "'", "''") & "','" & Replace(Description, "'", "''") & "','" & Department & "','" & RequestType & "','" & SubRequestType & "'," & Priority & "," & Product & "," & ModuleComponent & "," & Location & "," & Status & "," & Project & "," & AssignTo & ",'" & strUserName & "','" & m_strLoginType & "'," & m_OnBehalfOfCustomer & ",'" & ClientName & "','" & HttpContext.Current.Session("strUserName") & "','" & ExpResoulDate & "','" & strGetServerTime1 & "','" & strGetServerDate1 & "','" & TimeZone & "'," & Severity & ""
                'strSQL = "exec usp_NG2_INS_RequestDetails  '" & Replace(Subject, "'", "''") & "','" & Replace(Description, "'", "''") & "','" & Department & "','" & RequestType & "','" & SubRequestType & "'," & Severity & "," & Product & "," & ModuleComponent & "," & Location & "," & Status & "," & Project & "," & AssignTo & ",'" & strUserName & "','" & m_strLoginType & "'," & m_OnBehalfOfCustomer & ",'" & ClientName & "','" & HttpContext.Current.Session("strUserName") & "','" & ExpResoulDate & "','" & strGetServerTime1 & "','" & strGetServerDate1 & "','" & TimeZone & "'," & Priority & ""
                '' RequestID = CommonFunctions.Data.GetDataScalar(strSQL, True)
                'End of Added by Dipali V On 13th March 2019 Priority & Severity Issue
                ' RequestID = CommonFunctions.Data.GetDataScalar(strSQL, True)




                '' RequestID = CommonFunctions.Data.GetDataScalar(strSQL, True)

                ' RequestID = CommonFunctions.Data.GetDataScalar(strSQL, True)

                Dim drApprovalStatus As IDataReader
                Dim ApprovalStatusForEmail As String
                drApprovalStatus = CommonFunction.Data.GetDataReader(strSQL, True)
                If drApprovalStatus.Read() Then
                    RequestID = drApprovalStatus("RequestID").ToString()
                    ApprovalStatusForEmail = drApprovalStatus("ApprovalStatus").ToString()
                End If

                CommonFunctions.Data.DisposeDataReader(drApprovalStatus)

                Dim strSQLCC As String = "exec usp_NG2_INS_tbl_NG2_Request_CC  " & RequestID & ",'" & CC & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLCC, True)

                '    m_intShowMandatoryAttachmentMsg = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_CRM_get_MandatoryAttachment " + m_lngQueryID.ToString, m_blnUseSQL), "0"), "0"), Integer)

                blnSendMail = False : blnShowPopup = False
                'Modified by Vidyak for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications) --added mailid=545 for ApprovalStatusForEmail = "S"
                If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
                    dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 545", True)
                Else
                    dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", True)
                End If
                'dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", m_blnUseSQL)

                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                blnShowPopup = True
                If blnSendMail Then
                    If blnShowPopup Then
                        'With Response
                        '    .Write("<script language=javascript>")
                        '    If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
                        '        .Write("window.open (""../General/SendEmail.aspx?MessageID=545&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        '    Else
                        '        .Write("window.open (""../General/SendEmail.aspx?MessageID=46&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        '    End If
                        '    .Write("</script>")
                        'End With
                    Else
                        ' silent mail
                        If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
                            CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_545(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID, "")
                        Else
                            CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, RequestID, "")
                        End If
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)

                    End If
                End If


                ''strTypeInaccessibleCustomFieldList = HttpContext.Current.Request.Form("TypeInaccessibleCustomFieldList")
                If objCustomField <> "" Then
                    Dim arrCustomFields() As String = Split(objCustomField, ",")
                    Dim arrCustomFieldVal() As String = Split(CustomFieldValue, ",")

                    Dim intCount As Integer

                    If RequestID > 0 Then
                        strSQL = " Update Tbl_CRM_Query_Master set "
                        For intCount = 0 To arrCustomFields.Length - 1
                            'If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
                            '    If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 Then
                            '        strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                            '    Else
                            '        strSQL = strSQL & arrCustomFields(intCount) & "='" & arrCustomFieldVal(intCount) & "',"
                            '    End If
                            'Else
                            '    If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 Then
                            '        strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                            '    Else
                            '        strSQL = strSQL & arrCustomFields(intCount) & "='" & arrCustomFieldVal(intCount) & "',"
                            '    End If
                            'End If

                            If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
                                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And arrCustomFieldVal(intCount) = "" Then
                                    strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                                Else
                                    strSQL = strSQL & arrCustomFields(intCount) & "='" & arrCustomFieldVal(intCount) & "',"
                                End If
                            Else
                                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) = "" Then
                                    strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                                Else
                                    strSQL = strSQL & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount))) + "',"
                                End If
                            End If
                        Next


                        'If objCustomField <> "" Then
                        '    Dim arrInaccessibleCustomFields() As String = Split(objCustomField, ",")
                        '    For intCount = 0 To arrInaccessibleCustomFields.Length - 1
                        '        strSQL = strSQL & arrInaccessibleCustomFields(intCount) & "=NULL,"
                        '    Next
                        'End If


                        strSQL = strSQL.Substring(0, strSQL.Length - 1)

                        strSQL = strSQL + " where QueryID = " & RequestID
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    End If
                End If
            End If
            strClientSideScript = ""
            Return RequestID.ToString & "||" & IsloginCreated
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Added by Usha Pandit on 01 aug for numric field text allow issue
    'Function CheckForAlphaCharacters(ByVal StringToCheck As String)
    '    For i = 0 To StringToCheck.Length - 1
    '        If Not Char.IsLetter(StringToCheck.Chars(i)) Then
    '            Return False
    '        End If
    '    Next

    '    Return True 'Return true if all elements are characters
    'End Function
    'Added by Usha Pandit on 01 aug for numric field text allow issue
    Public Sub GetCustomerList()
        '==================================================================================
        ' Procedure Name		:	GetCustomerList
        ' Parameters Passed		:	To get all the Customer List
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:	23 Oct 2017
        ' Revisions				:	
        '==================================================================================		
        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim drCustomer As New DataTable
        Dim Counter As Integer = 0
        Dim CustomerName As String = ""
        strSQL = "usp_NG2_Sel_CustomerCombo"
        drCustomer = CommonFunctions.Data.GetDataTable(strSQL, True)
        For i As Integer = 0 To drCustomer.Rows.Count - 1
            'Added by Dipali V On 3rd Jan 2018 For Customer Name Alignment
            If CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("CustomerName").ToString, "").Length < 30 Then
                strHTML.Append("<li title='" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("CustomerName").ToString, "") & "' id='" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("Customer").ToString, "") & "' data-value='" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("Customer").ToString, "") & "' onclick=""CustomerSelection(" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("Customer").ToString, "") & ")"" >" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("CustomerName").ToString, "") & "</li>")
            Else
                CustomerName = CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("CustomerName").ToString, "").Substring(0, 30)
                strHTML.Append("<li title='" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("CustomerName").ToString, "") & "' id='" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("Customer").ToString, "") & "' data-value='" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("Customer").ToString, "") & "' onclick=""CustomerSelection(" & CommonFunctions.Data.CheckIsDBNull(drCustomer.Rows(i)("Customer").ToString, "") & ")"" >" & CustomerName & "...</li>")
            End If
            'End of Added by Dipali V On 3rd Jan 2018 For Customer Name Alignment
            Counter += 1
        Next
        CommonFunctions.General.WriteHTML(strHTML.ToString)
    End Sub

    Public Sub GetEmployeeList()
        '==================================================================================
        ' Procedure Name		:	GetEmployeeList
        ' Parameters Passed		:	To get all the Employee List
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:	23 Oct 2017
        ' Revisions				:	
        '==================================================================================		
        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim drEmployee As New DataTable
        Dim Counter As Integer = 0
        Dim EmployeeName As String = ""
        strSQL = "usp_NG2_Sel_EmployeeCombo"
        drEmployee = CommonFunctions.Data.GetDataTable(strSQL, True)
        For i As Integer = 0 To drEmployee.Rows.Count - 1

            'Added by Dipali V On 3rd Jan 2018 For Customer Name Alignment
            If CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeName").ToString, "").Length < 30 Then
                strHTML.Append("<li id='" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeID").ToString, "") & "' data-value='" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeID").ToString, "") & "' onclick=""EmployeeSelection(" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeID").ToString, "") & ")"" value='" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeName").ToString, "") & "'>" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeName").ToString, "") & "</li>")
            Else
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeName").ToString, "").Substring(0, 30)
                strHTML.Append("<li title='" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeName").ToString, "") & "' id='" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeID").ToString, "") & "' data-value='" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeID").ToString, "") & "' onclick=""CustomerSelection(" & CommonFunctions.Data.CheckIsDBNull(drEmployee.Rows(i)("EmployeeName").ToString, "") & ")"" >" & EmployeeName & "...</li>")
            End If
            'End of Added by Dipali V On 3rd Jan 2018 For Customer Name Alignment


            Counter += 1
        Next
        CommonFunctions.General.WriteHTML(strHTML.ToString)
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function PlotRequestDetails(ByVal Flag As String, ByVal CustomerID As String, ByVal EmployeeID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Flag = Utilities.Security.SecurityBuilder.CheckUserInput(Flag, 2, True, False, False)
        CustomerID = Utilities.Security.SecurityBuilder.CheckUserInput(CustomerID, 2, True, False, False)
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        'Dim request = HttpContext.Current.Request
        'Dim response = HttpContext.Current.Response
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure  Name		:	PlotRequestDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Customer/Employee/Self Request Controls
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   18 Oct 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim objCRM_AddNewRequest As New CRM_AddNewRequest
            Dim strSQL As String = ""
            Dim IsloginCreated As String = ""
            Dim RTVal As String = "E"
            If Flag = "CustomerDetails" Then
                strSQL = "usp_sel_tbl_PM_Login_IsCreatedByCustomer " + CustomerID.ToString
                IsloginCreated = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Integer)
                'HttpContext.Current.Session("Customer") = CustomerID
                'HttpContext.Current.Session("RTVal") = "C"
                EmployeeID = 0
                RTVal = "C"


            ElseIf Flag = "EmployeeDetails" Then
                'HttpContext.Current.Session("Customer") = 0
                'HttpContext.Current.Session("RTVal") = "E"
                CustomerID = 0
                RTVal = "E"
            ElseIf Flag = "Load" Then
                CustomerID = 0
                EmployeeID = 0
                RTVal = "E"
            End If

            strHTML.Append(objCRM_AddNewRequest.PageInit(Flag, CustomerID, EmployeeID, RTVal))
            Return strHTML.ToString & "|" & IsloginCreated
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateRequestAttachment(ByVal RequestID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        RequestID = Utilities.Security.SecurityBuilder.CheckUserInput(RequestID, 2, True, False, False)
        'Dim request = HttpContext.Current.Request
        'Dim response = HttpContext.Current.Response
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '==================================================================================
        ' Procedure Name	:	ValidateRequestAttachment
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

            strSQL = "usp_NG2_CRM_get_MandatoryAttachment " & RequestID & ""
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    Public Property EntityName() As String
        Get
            Return m_strEntityName
        End Get
        Set(ByVal Value As String)
            m_strEntityName = Value
        End Set
    End Property
    Public Property PrimaryKey() As String
        Get
            Return m_strPrimaryKey
        End Get
        Set(ByVal Value As String)
            m_strPrimaryKey = Value
        End Set
    End Property
    Public Property PrimaryKeyValue() As Long
        Get
            Return m_strPrimaryKeyID
        End Get
        Set(ByVal Value As Long)
            m_strPrimaryKeyID = Value
        End Set
    End Property
    Public Property TypeID() As String
        Get
            Return m_strCurrentType
        End Get
        Set(ByVal Value As String)
            m_strCurrentType = Value
        End Set
    End Property
    Public Property PrimaryTable() As String
        Get
            Return m_strPrimaryTable
        End Get
        Set(ByVal Value As String)
            m_strPrimaryTable = Value
        End Set
    End Property
    Public ReadOnly Property VariableDeclarationScript() As String
        Get
            Return declarevariables
        End Get
    End Property
    Public ReadOnly Property ValidationScript() As String
        Get
            Return strClientSideScript
        End Get
    End Property
    Public ReadOnly Property AccesibleCustomFields() As String
        Get
            Return m_strCustomFieldList
        End Get
    End Property
    Public ReadOnly Property DefaultValueScript() As String
        Get
            Return strDefaultScript
        End Get
    End Property
    Public Property FormName() As String
        Get
            Return m_strFormName
        End Get
        Set(ByVal Value As String)
            m_strFormName = Value
        End Set
    End Property
End Class