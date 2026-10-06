Imports System.Linq
Imports System.IO
Imports System.Xml
Imports System.Runtime.InteropServices

Public Class frmSprintDetails
    Inherits WebPages.Template.WhizTemplate
    Protected Shared m_lngReportID As Integer = 20143
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport

    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected strIsPrductOwner As String
    
    Protected IterationValue As String
    Protected IterationID As String = ""
    Protected IterationName As String = ""
    Protected Description As String = ""
    Protected NoOfDays As String = ""
    Protected SprintStartDate As String = ""
    Protected SprintEndDate As String = ""
    Protected ReleaseID As String = ""
    Protected SprintVelocity As String = ""
    Protected SprintDuration As String = ""
    Protected BusinessDuration As String = ""
    Protected IterationStartDate As String = ""
    Protected IterationStatus As String = ""
    Protected IsIterationComplete As String = ""
    Protected StoryPoint As String = ""

    Protected DoListCount As String = ""
    Protected InProgressCount As String = ""
    Protected DoneCount As String = ""
    Protected TaskCount As String = ""
    Protected DiscussionCount As String = ""
    Protected IssueCount As String = ""

    Protected plannedEfforts As String = ""
    Protected actualEfforts = ""

    Protected Duration As String = ""
    Protected Velocity As String = ""
    Protected Flag As String
    Public globalUSID As String = ""
    Protected strState As String = ""
    Protected strSprintStatus As String = ""

    Protected Chk_IterationRelaseFiled_mapped As String

    'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
    Protected HMSprintVelocity As String = ""
    Protected m_RestrictByMinHours As String
    Protected m_MinHoursForDAEntry As String
    'End of adding by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

    'Added by Usha Pandit on 25-March-2019 Purpose::Whizible 2 Work field change
    Protected strInputFormat As String
    Protected strDateFormat As String
    'End of adding by Usha Pandit on 25-March-2019 Purpose::Whizible 2 Work field change

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        GetAccessRights1()
        If Request.Params("Mode") = "Upload" Then
            'If Request.Params("Flag") = "Sprint" Or Request.Params("Flag") = "Iteration" Then
            UploadData("Iteration")
            'End If
        End If

        IterationValue = Request.Params("IterationID")
        Flag = Request.Params("flagSR")

        Dim strSQL As String = ""
        Dim drReleaseDetails As IDataReader
        Dim strflag As String = ""

        If Flag = "Iteration" Then
            strflag = "Sprint"
        Else
            strflag = "Release"
        End If
        strSQL = "usp_NG2_GetSprintReleaseDetails " & IterationValue & "," & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",'" & strflag & "'"
        drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)


        If drReleaseDetails.Read Then
            If Flag = "Iteration" Then
                IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationName"), "")
                Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
                SprintStartDate = DateTime.Parse(Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), ""))).ToString("MM/dd/yyyy")
                SprintEndDate = DateTime.Parse(Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), ""))).ToString("MM/dd/yyyy")
                ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                HMSprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")

                Dim strDecimal As String = ""
                Dim strBeforeDecimal As String = ""
                strBeforeDecimal = HMSprintVelocity.Substring(0, HMSprintVelocity.IndexOf(":"))
                If strBeforeDecimal.Length = 1 Then
                    strBeforeDecimal = "0" + strBeforeDecimal
                End If
                strDecimal = HMSprintVelocity.Substring(HMSprintVelocity.IndexOf(":") + 1, 2)
                HMSprintVelocity = strBeforeDecimal + ":" + strDecimal

                'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

                BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "0")
                IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStatus"), "")
                IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsIterationComplete"), "")


                DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoListCount"), "")
                InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgressCount"), "")
                DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoneCount"), "")
                TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
                plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                'strState = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("State"), "")
            Else ''Release
                IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
                Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
                SprintStartDate = DateTime.Parse(Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), ""))).ToString("MM/dd/yyyy")
                SprintEndDate = DateTime.Parse(Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), ""))).ToString("MM/dd/yyyy")
                ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "0")
                'IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                'IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStatus"), "")
                IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsReleaseComplete"), "")
                plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")

                ' DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoListCount"), "")
                InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
                DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
                TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
            End If

        End If
        strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & IterationID & ",'Iteration'", True))

        globalUSID = IterationID
        drReleaseDetails.Dispose()
        'If IterationName = 0 Then
        '    IterationName = ""
        'End If
        Dim len As Integer = 1000
        Dim len1 As Integer
        If Description.Length <> -1 Then
            len1 = Description.Length
            len = 1000 - len1
        End If
        Chk_IterationRelaseFiled_mapped = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & IterationValue & ",'Iteration'", True))

        ''Added By Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
            m_MinHoursForDAEntry = CommonFunction.Data.CheckIsDBNull(drCompany("MinHoursForDAEntry"), "0")
        End If
        drCompany.Close()
        drCompany.Dispose()

        ''End of Added By Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

        'Added by Usha Pandit on 25-March-2019 Purpose::Whizible 2 Work field change
        Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)

        Dim DateFormat As String = "usp_sel_tbl_pm_dateformats_FormatDate " + CType(dateFormatID, String)

        strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
        strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)
        'End of Added by Usha Pandit on 25-March-2019 Purpose::Whizible 2 Work field change
    End Sub

    Public Function GetAccessRights1()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	25-June-2018
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22232, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))

    End Function

    Function CheckIsProductOwner(ByVal strUserID As String)


        Dim drGetIsProductOwner As IDataReader
            Dim strHTML As New StringBuilder
            Dim StrQuery As String = ""
            Dim strIsPrductOwner As String
            StrQuery = "usp_NG2_IsProductOwner " & Session("intProjectID") & "," & strUserID & ""
            drGetIsProductOwner = CommonFunctions.Data.GetDataReader(StrQuery, True)
            While drGetIsProductOwner.Read
                strIsPrductOwner = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")

            End While
            Return strIsPrductOwner


    End Function


    Public Function UploadData(ByVal Flag As String)
        '=====================================================================
        ' Procedure Name        :	UploadData
        ' Purpose               :	upload attachment Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	27-June-2018
        ' Revisions             :
        '=====================================================================

        If Request.Files.Count > 0 Then
            Dim MimeType As String
            Dim strUserStoryID As String = Request.Params("UserStoryID")
            Dim file As HttpPostedFile = Context.Request.Files(0)
            Dim strFileName As String
            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

            Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
            Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
            Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
            Dim CharList As String()
            CharList = ValidateFileName.Split(","c)
            For k As Integer = 0 To CharList.Length - 1
                If fileName.Contains(CharList(k).ToString) Then
                    fileName1 = fileName1.Replace(CharList(k).ToString, "")
                End If
            Next
            Dim IsValidFileName As Integer = 1
            Dim ExtensionList As String()
            ExtensionList = fileName.Split("."c)
            If ExtensionList.Length > 2 Then
                IsValidFileName = 0
            End If
            If fileName = fileName1 And IsValidFileName = 1 Then

                Dim response As String = String.Empty
                Dim buffer As Byte() = New Byte(256) {}

                file.InputStream.Read(buffer, 0, 256)
                file.InputStream.Position = 0
                Dim logpath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                'Added By Dipali V On 31st Oct 2022 For File Content Type
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
                Dim magicNumber As String = BitConverter.ToString(buffer)
                magicNumber = magicNumber.Replace("-", " ")
                Dim xmlDoc As New XmlDocument()
                Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                xmlDoc.Load(xmlPath + "MIMEType.xml")
                Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

                'Added by imran on 02-01-2023
                'Dim fileNameExtention As String = HttpContext.Current.Request.Files(0).FileName
                'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                'Dim count As Integer = ext1.Split("."c).Length - 1
                'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                'If count > 1 Then
                '    MimeType = ""
                'End If

                'If count = 1 Or count2 = 1 Then
                For Each node As XmlNode In nodes
                        xContentType = node.SelectSingleNode("ContentType").InnerText
                        If strFileType = xContentType Then
                            fileName = HttpContext.Current.Request.Files(0).FileName

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
                'End of comment by imran on 02-01-2022
            Else
                MimeType = ""
            End If

            If MimeType Is Nothing Or MimeType = "" Then
                MimeType = "unknown/unknowns"
            End If

            If strListofTypes.IndexOf(MimeType) >= 0 Then
                Dim strFullPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory) & "/Attachments/Agile/"

                If Not Directory.Exists(strFullPath) Then
                    Directory.CreateDirectory(strFullPath)
                End If

                file.SaveAs(strFullPath + strFileName + Path.GetExtension(file.FileName))
                Dim strSql As String = ""
                If Flag = "Iteration" Then
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL," & strUserStoryID & ", NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                ElseIf Flag = "UserStory" Then
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments " & strUserStoryID & ",NULL,NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                Else
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL,NULL," & strUserStoryID & "," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                End If

                CommonFunctions.Data.InsertOrUpdateData(strSql, True)
                'If Flag = "UserStory" Then
                '    Context.Response.Write(GetAttachmentList1(strUserStoryID, ""))
                'Else
                '    Context.Response.Write(GetAttachmentListSprintRelease(strUserStoryID, Flag))
                'End If
            Else
                Context.Response.Write("Invalid")
            End If
        End If
        Context.Response.End()
    End Function

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
    <System.Web.Services.WebMethod()>
    Public Shared Function ScrumIterationList() As String
        '=====================================================================
        ' Procedure Name        :	ScrumIterationList
        ' Purpose               :	Sprint Details for the Page  in drop-down menu.
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	27-June-2018
        ' Revisions             :
        '=====================================================================

        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""


            'StrSql = "usp_NG2_SEL_tbl_PM_ScrumIterationDataCurrentSprint " & HttpContext.Current.Session("IntProjectID") & ""
            StrSql = "usp_NG2_GetScrumEntitiesCurrentSprint " & HttpContext.Current.Session("IntProjectID") & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSprintReleaseDetails(ByVal IterationID As Integer, ByVal flagSR As String) As String

        '=====================================================================
        ' Procedure Name        :	GetSprintReleaseDetails
        ' Purpose               :	Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	27-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            Dim strflag As String = ""
            If flagSR = "Iteration" Then
                strflag = "Sprint"
            Else
                strflag = "Release"
            End If
            StrSql = "usp_NG2_GetSprintReleaseDetails " & IterationID & "," & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",'" & strflag & "'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    ''Added By Usha Pandit on 28-March-2019 Purpose::Whizible 2 Work field change
    <System.Web.Services.WebMethod()>
    Public Shared Function getHMHours(ByVal DecimalHours As String) As String
        Try
            Dim HMHours As String

            ' ''Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 
            'If HMHours = "0" Or HMHours = "" Then
            '    HMHours = "00:00"
            'End If

            'If HMHours.IndexOf(":") = HMHours.Length - 1 Then
            '    HMHours = HMHours + "00"
            'End If

            'Dim strDecimal As String = ""
            'Dim strBeforeDecimal As String = ""
            'strBeforeDecimal = HMHours.Substring(0, HMHours.IndexOf(":"))
            'strDecimal = HMHours.Substring(HMHours.IndexOf(":") + 1, 2)
            'HMHours = strBeforeDecimal + ":" + strDecimal
            ' ''End of Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 

            HMHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + DecimalHours + "',1)", True)

            Return HMHours

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''End of Added By Usha Pandit on 28-March-2019 Purpose::Whizible 2 Work field change

    <System.Web.Services.WebMethod()>
    Public Shared Function SprintUpdBtn(ByVal IterationID As Integer) As String
        '=====================================================================
        ' Procedure Name        :	SprintUpdBtn
        ' Purpose               :	Update btn Sprint Details for the Page.
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	27-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""

            StrSql = "Usp_Ng2_Chk_SprintStatus " & IterationID & ",'Iteration'"

            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    ''Commented and Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 
    '<System.Web.Services.WebMethod()>
    'Public Shared Function UpdateSprintReleaseRecords(ByVal IterationID As String, ByVal strIteration As String, ByVal strDescription As String, ByVal dtStartDate As String, ByVal dtEndDate As String, ByVal intDuration As Integer, ByVal fltVelocity As Decimal, ByVal intBusinessDuration As Integer, ByVal flag As String) As String
    '    '=====================================================================
    '    ' Procedure Name        :	UpdateSprintReleaseRecords
    '    ' Purpose               :	Update Sprint Details for the Page 
    '    ' Description           :	Same as above
    '    ' Parameters Passed     :	None.
    '    ' Parameters Affected   :	None.
    '    ' Returns               :	None
    '    ' Assumptions           :	None.
    '    ' Dependencies          :	None.
    '    ' Author                :	Ankush T
    '    ' Created               :	01-July-2018
    '    ' Revisions             :
    '    '=====================================================================

    '    Try
    '        Dim intIterationID As String = IterationID
    '        Dim intProjectID As Integer = HttpContext.Current.Session("intProjectID")
    '        Dim intReleaseID As String = ""
    '        Dim status As String = ""
    '        Dim strUserName As String = ""
    '        Dim dt As New DataTable()
    '        Dim strSQL As String = ""
    '        'Dim Startdate As String = ""
    '        'Dim EndDate As String = ""
    '        If intIterationID = "" Then
    '            intIterationID = "null"
    '        End If
    '        If intReleaseID = "" Then
    '            intReleaseID = "null"
    '        End If
    '        If status = "" Then
    '            status = "null"
    '        End If

    '        'Startdate = DateTime.Parse(Convert.ToDateTime(dtStartDate)).ToString("yyyy-MM-dd")
    '        'EndDate = DateTime.Parse(Convert.ToDateTime(dtEndDate)).ToString("yyyy-MM-dd")

    '        If flag = "Iteration" Then
    '            strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration "
    '            strSQL = strSQL & "" & intIterationID & ","
    '            strSQL = strSQL & "" & intProjectID & ","
    '            strSQL = strSQL & "'" & strIteration & "',"
    '            strSQL = strSQL & "" & intReleaseID & ","
    '            strSQL = strSQL & "'" & strDescription.Replace("'", "''") & "',"
    '            strSQL = strSQL & "'" & dtStartDate & "',"
    '            strSQL = strSQL & "'" & dtEndDate & "',"
    '            strSQL = strSQL & "" & intDuration & ","
    '            strSQL = strSQL & "" & fltVelocity & ","
    '            strSQL = strSQL & "'" & HttpContext.Current.Session("strUserName") & "',"
    '            strSQL = strSQL & "" & intBusinessDuration & ""

    '            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        Else
    '            strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease "
    '            strSQL = strSQL & "" & intIterationID & ","
    '            strSQL = strSQL & "" & intProjectID & ","
    '            strSQL = strSQL & "'" & strIteration & "',"
    '            strSQL = strSQL & "'" & strDescription & "',"
    '            strSQL = strSQL & "'" & dtStartDate & "',"
    '            strSQL = strSQL & "'" & dtEndDate & "',"
    '            strSQL = strSQL & "" & intDuration & ","
    '            '  strSQL = strSQL & "" & fltVelocity & ","
    '            strSQL = strSQL & "" & intBusinessDuration & ","
    '            strSQL = strSQL & "" & status & ""

    '            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        End If
    '    Catch ex As Exception

    '    End Try
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateSprintReleaseRecords(ByVal IterationID As String, ByVal strIteration As String, ByVal strDescription As String, ByVal dtStartDate As String, ByVal dtEndDate As String, ByVal intDuration As Integer, ByVal strVelocity As String, ByVal intBusinessDuration As Integer, ByVal flag As String) As String
        '=====================================================================
        ' Procedure Name        :	UpdateSprintReleaseRecords
        ' Purpose               :	Update Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	01-July-2018
        ' Revisions             :
        '=====================================================================

        Try
            Dim intIterationID As String = IterationID
            Dim intProjectID As Integer = HttpContext.Current.Session("intProjectID")
            Dim intReleaseID As String = ""
            Dim status As String = ""
            Dim strUserName As String = ""
            Dim dt As New DataTable()
            Dim strSQL As String = ""
            'Dim Startdate As String = ""
            'Dim EndDate As String = ""
            If intIterationID = "" Then
                intIterationID = "null"
            End If
            If intReleaseID = "" Then
                intReleaseID = "null"
            End If
            If status = "" Then
                status = "null"
            End If

            'Startdate = DateTime.Parse(Convert.ToDateTime(dtStartDate)).ToString("yyyy-MM-dd")
            'EndDate = DateTime.Parse(Convert.ToDateTime(dtEndDate)).ToString("yyyy-MM-dd")

            Dim fltVelocity As Decimal

            If strVelocity = "0" Or strVelocity = "" Then
                strVelocity = "00:00"
            End If

            If strVelocity.IndexOf(":") = strVelocity.Length - 1 Then
                strVelocity = strVelocity + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = strVelocity.Substring(0, strVelocity.IndexOf(":"))
            If strBeforeDecimal.Length = 1 Then
                strBeforeDecimal = "0" + strBeforeDecimal
            End If
            strDecimal = strVelocity.Substring(strVelocity.IndexOf(":") + 1, 2)
            strVelocity = strBeforeDecimal + ":" + strDecimal

            fltVelocity = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strVelocity + "',2)", True)


            If flag = "Iteration" Then
                strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration "
                strSQL = strSQL & "" & intIterationID & ","
                strSQL = strSQL & "" & intProjectID & ","
                strSQL = strSQL & "'" & strIteration.Replace("'", "''") & "',"
                strSQL = strSQL & "" & intReleaseID & ","
                strSQL = strSQL & "'" & strDescription.Replace("'", "''") & "',"
                strSQL = strSQL & "'" & dtStartDate & "',"
                strSQL = strSQL & "'" & dtEndDate & "',"
                strSQL = strSQL & "" & intDuration & ","
                strSQL = strSQL & "" & fltVelocity & ","
                strSQL = strSQL & "'" & HttpContext.Current.Session("strUserName") & "',"
                strSQL = strSQL & "" & intBusinessDuration & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Else
                strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease "
                strSQL = strSQL & "" & intIterationID & ","
                strSQL = strSQL & "" & intProjectID & ","
                strSQL = strSQL & "'" & strIteration.Replace("'", "''") & "',"
                strSQL = strSQL & "'" & strDescription.Replace("'", "''") & "',"
                strSQL = strSQL & "'" & dtStartDate & "',"
                strSQL = strSQL & "'" & dtEndDate & "',"
                strSQL = strSQL & "" & intDuration & ","
                '  strSQL = strSQL & "" & fltVelocity & ","
                strSQL = strSQL & "" & intBusinessDuration & ","
                strSQL = strSQL & "" & status & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
        Catch ex As Exception

        End Try
    End Function

    ''End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowUserStoryDetails(ByVal IterationID As String) As String
        '=====================================================================
        ' Procedure Name        :	ShowUserStoryDetails
        ' Purpose               :	Userstory Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	28-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            If IterationID = "" Then
                IterationID = "0"
            End If
            StrSql = "usp_NG2_Sel_CurrentSprintUSdetails " & IterationID & ",'Sprint'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTaskDetails(ByVal IterationID As String, ByVal flagSR As String) As String
        '=====================================================================
        ' Procedure Name        :	ShowTaskDetails
        ' Purpose               :	Sprint Task Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	28-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            If IterationID = "" Then
                IterationID = "0"
            End If
            StrSql = "usp_NG2_sel_tbl_PM_ScrumTasks " & IterationID & "," & flagSR & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowIssueDetails(ByVal IterationID As String, ByVal flagSR As String) As String
        '=====================================================================
        ' Procedure Name        :	ShowIssueDetails
        ' Purpose               :	Issue Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	28-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            If IterationID = "" Then
                IterationID = "0"
            End If

            If flagSR = "Sprint" Or flagSR = "Iteration" Then
                flagSR = "Iteration"
            Else
                flagSR = "UserStory"
            End If
            StrSql = "usp_NG2_sel_tbl_PM_ScrumIssues " & IterationID & "," & flagSR & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowReviewDetails(ByVal IterationID As String, ByVal flagSR As String) As String
        '=====================================================================
        ' Procedure Name        :	ShowReviewDetails
        ' Purpose               :	Review Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	28-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            If IterationID = "" Then
                IterationID = "0"
            End If

            StrSql = "usp_NG2_sel_tbl_PM_ScrumReviews " & IterationID & "," & flagSR & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowHistoryList(ByVal IterationID As String, ByVal flagSR As String) As String
        '=====================================================================
        ' Procedure Name        :	ShowHistoryList
        ' Purpose               :	History list Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	28-June-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            Dim PageTagID As String = ""

            If flagSR = "Iteration" Or flagSR = "Sprint" Then
                'FlagSprintRelease = "Iteration"
                PageTagID = 8084
            ElseIf flagSR = "Release" Then
                PageTagID = 8083
            Else
                PageTagID = 8087
            End If

            StrSql = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & IterationID & "," & PageTagID & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTeamsDetails(ByVal IterationID As String, ByVal flagSR As String)
        '=====================================================================
        ' Procedure Name        :	ShowTeamsDetails
        ' Purpose               :	Team Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	01-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & CStr(HttpContext.Current.Session("intProjectID")) & "," & IterationID & ",'" & flagSR & "'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowDiscussionDetails(ByVal IterationID As String, ByVal flagSR As String)
        '=====================================================================
        ' Procedure Name        :	ShowDiscussionDetails
        ' Purpose               :	Show Discussion Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	01-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & IterationID & ",'" & flagSR & "',1," & CStr(HttpContext.Current.Session("intUserID")) & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowDisscussionsReply(ByVal IterationID As String, ByVal DiscussionID As String)
        '=====================================================================
        ' Procedure Name        :	ShowDisscussionsReply
        ' Purpose               :	Discussion Reply Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	01-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & IterationID & ",'IterationReply',1," & CStr(HttpContext.Current.Session("intUserID")) & "," & DiscussionID & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
        '=====================================================================
        ' Procedure Name        :	SaveDiscussion
        ' Purpose               :	Save discussion Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	02-July-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strREsult As String
        strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

        strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
        If strREsult Then
            If HttpContext.Current.Session("intUserID") <> "0" Then
                CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
            Else
                CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
            End If
        End If

        ' Return New frmSprintPlanning().PlotDiscussionThreadBodyUS(strUserStoryID, "", Flag)
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussionSR(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
        '=====================================================================
        ' Procedure Name        :	SaveDiscussionSR
        ' Purpose               :	Discussion Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	02-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strSQL As String
            Dim strREsult As String
            Dim strflag As String
            'If Flag = "Iteration" Then
            '    strflag = "IterationReply"
            'End If
            strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                End If
            End If

            ' Return New frmSprintPlanning().PlotDiscussionThreadBodySR(strUserStoryID, "", Flag)
            Return strREsult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AttachmentDetails(ByVal IterationID As String, ByVal flagSR As String)
        '=====================================================================
        ' Procedure Name        :	AttachmentDetails
        ' Purpose               :	Attachment Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	03-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = ""
            Dim strflag As String = ""

            StrSql = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & HttpContext.Current.Session("intProjectID") & "," & IterationID & ",'" & flagSR & "'"

            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteAttachment(ByVal strAttachmentID As String, ByVal strIterationID As String, ByVal strEntity As String)
        '=====================================================================
        ' Procedure Name        :	DeleteAttachment
        ' Purpose               :	Delete attachment Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	03-July-2018
        ' Revisions             :
        '=====================================================================
        Try


            'Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

            'Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strIterationID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")
            'Dim strResult As String = CommonFunctions.Data.GetDataScalar(strSql, True)
            'Return strResult

            Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strIterationID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")

            Dim strResult As String
            Dim intFlag As Integer
            Dim drattach As IDataReader
            drattach = CommonFunctions.Data.GetDataReader(strSql, True)
            If drattach.Read() Then
                strResult = CommonFunction.Data.CheckIsDBNull(drattach("Result"), "")
                intFlag = CommonFunction.Data.CheckIsDBNull(drattach("intFlag"), "0")
            End If
            Return strResult & "||" & intFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

        'End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetGetBurnUpChartGraphDetails(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        '=====================================================================
        ' Procedure Name        :	GetGetBurnUpChartGraphDetails
        ' Purpose               :	BurnUp Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	04-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            Dim Startdate As String = ""
            Dim EndDate As String = ""
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnUpChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetBurnUpStoryPoint(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        '=====================================================================
        ' Procedure Name        :	GetBurnUpStoryPoint
        ' Purpose               :	BurnUp Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	04-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnUpChart_StoryPoint " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetailsForGraph(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        '=====================================================================
        ' Procedure Name        :	GetGraphDetailsForGraph
        ' Purpose               :	Graph Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	04-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnDownChart_StoryPoint " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetails(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        '=====================================================================
        ' Procedure Name        :	GetGraphDetails
        ' Purpose               :	Graph Sprint Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ankush T
        ' Created               :	04-July-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnDownChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetVelocityData(ByVal strGraphFilter As String, ByVal UniqueID As String)
    '    Dim strGraphSQL As String = ""
    '    Dim strUserID As String
    '    Dim strLoginType As String
    '    Dim dtGraphTable As DataTable
    '    Dim strResult As String = ""

    '    strUserID = HttpContext.Current.Session("intUserID")
    '    strLoginType = HttpContext.Current.Session("LoginType")

    '    strGraphSQL = "usp_NG2_GET_VelocityGraphAsperStory " & UniqueID & "," & HttpContext.Current.Session("IntProjectID") & ",'" & strGraphFilter & "'"


    '    dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

    '    strResult = GetSerialized(dtGraphTable)

    '    Return strResult
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal Entity As String, ByVal EntityID As String)
        '====================================================================
        ' Function  Name        : ExportToExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export Impediment Log Details to excel
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Ankush T
        ' Created               : 22-Jun-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strSQL As String
            Dim strFilePath As String
            Dim strFormat As String
            Dim strCaptions As String

            If Entity = "Iteration" Then
                m_lngReportID = 20244
                strSQL = "usp_NG2_Get_SprintDashboard_Report " & EntityID & "," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
            Else
                m_lngReportID = 20171
                strSQL = "usp_NG2_sel_tbl_PM_ScrumReleasesList_Report " & EntityID & "," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
            End If


            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Reports/"))
            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            ' add extn to file name based on format requested
            Select Case ReportFormat
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            Dim frmObjSprintDetails As New frmSprintDetails
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjSprintDetails.UseSQL
                .DefaultLCID = CType(frmObjSprintDetails.DefaultUILCID, Integer)
                .LCID = frmObjSprintDetails.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                '.UIParameters = strCaptions
                '.UIParametersDelimiter = "|"
                '.WatermarkImageFilePath = ""
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../Images/")

                ' generate the report in requested format

                Select Case ReportFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing
            Return (m_strFileName)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


        'End With
    End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function CheckIterationName(ByVal strIterationName As String, ByVal strProjectID As String, ByVal flag As String)
    '    Dim strSql As String = ""
    '    If flag = "Sprint" Then
    '        strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_IterationNameExists " & strProjectID & ",'" & strIterationName & "'", True), "0")

    '    Else
    '        strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_ReleaseNameExists " & strProjectID & ",'" & strIterationName & "'", True), "0")

    '    End If
    '    Return strSql
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateProjectDates(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String) As String
        '=====================================================================
        ' Purpose				:	ValidateProjectDates
        ' Author				:	Ankush T
        ' Created				:	24 july 2018
        '=====================================================================
        Dim strSQL As String
        Dim strResult As String
        'Dim dtStartDate As String = ""
        'Dim dtEndDate As String = ""

        'dtStartDate = DateTime.Parse(Convert.ToDateTime(StartDate)).ToString("yyyy-MM-dd")
        'dtEndDate = DateTime.Parse(Convert.ToDateTime(EndDate)).ToString("yyyy-MM-dd")
        Try
            strSQL = "Usp_NG2_Validate_ProjectDates_IterationRelease " & ProjectID & ",'" & StartDate & "','" & EndDate & "'"

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateIterationDate(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Flag As String)

        Try
            Dim strSql As String = ""
            'Dim dtStartDate As String = ""
            'Dim dtEndDate As String = ""

            'dtStartDate = DateTime.Parse(Convert.ToDateTime(StartDate)).ToString("yyyy-MM-dd")
            'dtEndDate = DateTime.Parse(Convert.ToDateTime(EndDate)).ToString("yyyy-MM-dd")

            If Flag = "Sprint" Then
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsIterationFallsBetweenPeriod " & ProjectID & ",'" & StartDate & "','" & EndDate & "'", True), "0")
            Else
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsReleaseFallsBetweenPeriod " & ProjectID & ",'" & StartDate & "','" & EndDate & "'", True), "0")
            End If
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Added by Chetan M on 12 Dec 2020 for Issue fixing
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateIterationDate_Alert(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Flag As String, IterationID As String)

        Try
            Dim strSql As String = ""
            'Dim dtStartDate As String = ""
            'Dim dtEndDate As String = ""

            'dtStartDate = DateTime.Parse(Convert.ToDateTime(StartDate)).ToString("yyyy-MM-dd")
            'dtEndDate = DateTime.Parse(Convert.ToDateTime(EndDate)).ToString("yyyy-MM-dd")

            'Commented And Added By Usha Pandit On 16.12.2020 For returning blank string if no data/validation returned from SP
            'If Flag = "Sprint" Then
            '    strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsIterationFallsBetweenPeriod_alert " & ProjectID & ",'" & StartDate & "','" & EndDate & "'," & IterationID & "", True), "0")
            'Else
            '    strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsIterationFallsBetweenPeriod_alert " & ProjectID & ",'" & StartDate & "','" & EndDate & "'," & IterationID & "", True), "0")
            'End If

            If Flag = "Sprint" Then
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsIterationFallsBetweenPeriod_alert " & ProjectID & ",'" & StartDate & "','" & EndDate & "'," & IterationID & "", True), "")
            Else
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsIterationFallsBetweenPeriod_alert " & ProjectID & ",'" & StartDate & "','" & EndDate & "'," & IterationID & "", True), "")
            End If
            'End Of Added By Usha Pandit On 16.12.2020 For returning blank string if no data/validation returned from SP
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End of Added by Chetan M on 12 Dec 2020 for Issue fixing
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckSprintEfforts(ByVal strIterationID As String, ByVal strEfforts As String)

        Try
            If (strIterationID = "") Then
                strIterationID = "Null"
            End If

            'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
            'Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_SprintEffortWithProject " & HttpContext.Current.Session("intProjectID") & "," & strEfforts & "," & strIterationID, True), "0")
            Dim fltEfforts As Decimal

            If strEfforts = "0" Or strEfforts = "" Then
                strEfforts = "00:00"
            End If

            If strEfforts.IndexOf(":") = strEfforts.Length - 1 Then
                strEfforts = strEfforts + "00"
            End If

            fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEfforts + "',2)", True)

            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_SprintEffortWithProject " & HttpContext.Current.Session("intProjectID") & "," & fltEfforts & "," & strIterationID, True), "0")

            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change


            Return strSql
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

End Class