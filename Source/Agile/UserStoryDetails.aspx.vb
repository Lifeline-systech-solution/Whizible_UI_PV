Imports System.Xml
Imports System.IO
Imports System.Runtime.InteropServices
Public Class UserStoryDetails
    Inherits WebPages.Template.WhizTemplate

    Protected strFunctionalNumber As String = ""
    Protected strFeatureName As String = ""
    Protected strUserDesc As String = ""
    Protected strBusinesValue As String = ""
    Protected strPriority As String = ""
    Protected strState As String = ""
    Protected strComplexity As String = ""
    Protected strStoryPoint As String = ""
    Protected strCategory As String = ""
    Protected strVersion As String = ""
    Protected strIterationName As String = ""
    Protected intReleaseId As String = ""
    Protected strCreatedDate As String = ""
    Protected strCreatedBy As String = ""
    Protected strInitialRank As String = ""
    Protected strCategoryColor As String = "#DDD"
    Protected strVersionColor As String = "#DDD"
    Protected strPriorityColor As String = "#DDD"
    Protected strStatus As String = ""
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected strIsPrductOwner As String
    Protected strAcceptanceCriteria As String = ""
    Protected strFixedVersion As String = ""
    Protected strFixedVersionColor As String = "#DDD"
    Protected intUserStoryID As String
    Protected intIssueCount As String
    Protected intTCFailCount As String
    Protected intTCPassCount As String
    Protected intTCNotPlanCount As String

    'Added by Swapna
    Protected strSprintName As String
    Protected strReleaseName As String
    Protected intParentUserStoryID As String
    Protected strHasSubUS As String
    Protected len As Integer
    Protected strUserName1 As String
    'end by swapna
    Public globalUSID As String = ""
    Protected Chk_IterationRelaseFiled_mapped As String
    'Added by Ankush T on 27 Aug 2018
    Protected strSprintStatus As String = ""
    Protected Configureresponsible As String = "" 'Added By Dipali V On 21st may 2020 For Display Project Specific responsible 
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'Added by Swapna
        If Request.Params("Mode") = "Upload" Then
            UploadData()
        End If
        'End by Swapna
        GetAccessRights1()
        intUserStoryID = Request.Params("UserStoryId")
        Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory " & intUserStoryID
        Dim drGetUserStory As IDataReader
        drGetUserStory = CommonFunctions.Data.GetDataReader(strSql, True)
        drGetUserStory = CommonFunctions.Data.GetDataReader(strSql, True)
        If drGetUserStory.Read Then
            strFunctionalNumber = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FunctionalNo").ToString, "")
            strFeatureName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("UserStoryName").ToString, "")
            strUserDesc = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Description").ToString, "")
            strBusinesValue = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("BusinessValue").ToString, "")
            strPriority = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("PriorityID").ToString, "")
            strState = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("State").ToString, "")
            strComplexity = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Complexity").ToString, "")
            strCategory = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CategoryID").ToString, "")
            strVersion = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Version").ToString, "")
            'Commented & Added By Dipali V On 10th April 2018 For Access Issue
            'strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            'End of Commented & Added By Dipali V On 10th April 2018 For Access Issue
            intReleaseId = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("ReleaseID"), "")
            strCreatedDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CreatedDate").ToString, "")
            strCreatedBy = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CreatedBy").ToString, "")
            strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CategoryColor").ToString, "")
            strVersionColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("VersionColor").ToString, "")
            strPriorityColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("PriorityColor").ToString, "")
            strStoryPoint = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("InitialEstimate").ToString, "")
            strInitialRank = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("InitialRank").ToString, "") ''Added By Dipali V On 2nd March
            strStatus = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Status").ToString, "")
            strAcceptanceCriteria = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("AcceptanceCriteria").ToString, "")
            strFixedVersion = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FixedVersion").ToString, "")
            strFixedVersionColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FixedVersionColor").ToString, "")
            intParentUserStoryID = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("ParentUserStoryID"), 0)
            intIssueCount = drGetUserStory("IssueCount")
            'Added by swapna
            strSprintName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationName").ToString, "")
            strHasSubUS = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("HasSubUserStory").ToString, "")
            strReleaseName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("ReleaseName").ToString, "")
            'End by swapna
        End If
        'Added by Ankush T on 27 Aug 2018
        strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & intUserStoryID & ",'UserStory'", True))
        'Added By Dipali V On 21st may 2020 For Display Project Specific responsible 
        Configureresponsible = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_ib_TypeResponsiblePerson " & Session("intProjectID") & "", True))
        'End of Added By Dipali V On 21st may 2020 For Display Project Specific responsible 


        globalUSID = intUserStoryID
        drGetUserStory.Dispose()
        If strIterationName = 0 Then
            strIterationName = ""
        End If
        len = 200
        Dim len1 As Integer
        If strFeatureName.Length <> -1 Then
            len1 = strFeatureName.Length
            len = 200 - len1
        End If
        'Addded by Swapna
        If intParentUserStoryID = 0 Then
            intParentUserStoryID = "No"
        Else
            intParentUserStoryID = "Yes"
        End If



        Dim strSql1 As String = "usp_NG2_Get_TestCaseDetails " & Session("intProjectID") & "," & intUserStoryID & ""

        drGetUserStory = CommonFunctions.Data.GetDataReader(strSql1, True)
        If drGetUserStory.Read Then
            intTCFailCount = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Fail"), 0)
            intTCPassCount = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Pass"), 0)
            intTCNotPlanCount = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("NonTested"), 0)
        End If
        drGetUserStory.Dispose()

        'End by swapna
        strUserName1 = Session("strUserName")
        Chk_IterationRelaseFiled_mapped = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & intUserStoryID & ",'UserStory'", True))
    End Sub
    'Added by Swapna
    Public Function UploadData()
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
                Dim strSql As String = "usp_NG2_INS_tbl_NG2_ScrumAttachments " & strUserStoryID & ",NULL,NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSql, True)
                Context.Response.Write("Valid")
            Else
                Context.Response.Write("Invalid")
            End If
        End If
        Context.Response.End()
    End Function

    'Added By Dipali V On 31st Oct 2022 For File Content Type
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
    'End of Added By Dipali V On 31st Oct 2022 For File Content Type
    'End By Swapna
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowUserStoryDetails(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory " & UserStoryID & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowSubUserStory(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_SubUserStory " & UserStoryID & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowAttachemnts(ByVal ProjectID As String, ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & ProjectID & "," & UserStoryID & ",'UserStory'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTeams(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & CStr(HttpContext.Current.Session("intProjectID")) & "," & UserStoryID & ",'UserStory'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowHistory(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & UserStoryID & ",8087"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowDisscussions(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & UserStoryID & ",'UserStory',1," & CStr(HttpContext.Current.Session("intUserID")) & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowStatus()
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_sel_tbl_NG2_ScrumStages " & HttpContext.Current.Session("intprojectID") & ",0,0 "
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ChkUSMapped(ByVal UserStoryID As String)
        Try

            Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & UserStoryID & ",'UserStory'", True))
            If strAddLinkAccess = "0" Then
                Return "0"
            Else
                Return "1"
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ChkSubUS(ByVal UserStoryID As String)
        Try

            Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & UserStoryID & ",'UserStory'", True))
            Dim strIsSubUS As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsSubUserStory " & UserStoryID, True))
            If strAddLinkAccess = "1" Then
                Return "1"
            ElseIf strIsSubUS = "1" Then
                Return "2"
            Else
                Return "0"
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowDisscussionsReply(ByVal UserStoryID As String, ByVal DiscussionID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & UserStoryID & ",'UserStoryReply',1," & CStr(HttpContext.Current.Session("intUserID")) & "," & DiscussionID & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowIssuesList(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumIssues " & UserStoryID & ",'UserStory'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowReviewsList(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()
            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumReviews " & UserStoryID & ",'UserStory'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubType(ByVal TypeID As String, ByVal WhichList As String)
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & HttpContext.Current.Session("intprojectID") & ",'S','" & TypeID & "'"
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaskType()
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & HttpContext.Current.Session("intprojectID") & ""
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDefultType()
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'T'," & HttpContext.Current.Session("intprojectID") & ""
            'dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)
            'strResult = GetSerialized(dtDefectType)

            Dim Type As String = ""
            Dim SubType As String = ""
            Dim Status As String = ""


            Dim drGetUserStory As IDataReader
            drGetUserStory = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drGetUserStory.Read Then
                Type = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Type").ToString, "")
            End If


            strSQL = "usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'S'," & HttpContext.Current.Session("intprojectID") & ",'" & Type & "'"
            drGetUserStory = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drGetUserStory.Read Then
                SubType = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("SubType").ToString, "")
            End If



            strSQL = "usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'ST'," & HttpContext.Current.Session("intprojectID") & ",'" & Type & "'"
            drGetUserStory = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drGetUserStory.Read Then
                Status = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Status").ToString, "")
            End If

            Return Type & "||" & SubType & "||" & Status
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaskResources()
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_Ng2_Sel_CurrentTeamMembers " & HttpContext.Current.Session("intprojectID") & ""
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowReviewerList()
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_Sel_tbl_PM_ReviewStatistics_ReviewerList 'ReviewedBy', " & HttpContext.Current.Session("intprojectID") & ", NULL, NULL,NULL,NULL,Null,'-1',0"
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowRevieweeList()
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()



            strSQL = "usp_Ng2_Sel_CurrentTeamMembers " & HttpContext.Current.Session("intprojectID") & ""
            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDefaultValues(ByVal strResult As String)
        Try

            Dim strSQL1 As String = ""
            Dim dtDefectType1 As DataTable
            strSQL1 = "usp_Sel_IB_GetDefault_Type_Status_SubType 'S'," & HttpContext.Current.Session("intprojectID") & ", '" + CommonFunction.General.BuildQueryString(strResult.Trim) + "'"
            dtDefectType1 = CommonFunctions.Data.GetDataTable(strSQL1, True)
            If dtDefectType1.Rows.Count > 0 Then
                Return CommonFunctions.Data.CheckIsDBNull(dtDefectType1.Rows(0)("SubType"), "")
            End If
            'Return ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetStatus(ByVal Issue_Type As String)
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()


            Dim StatusIssue As String = "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'" & Issue_Type & "'," & CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Long)
            dtDefectType = CommonFunctions.Data.GetDataTable(StatusIssue, True)
            strResult = GetSerialized(dtDefectType)

            ' strPlotHtml = GetPlottingScript(ProjectID, HttpContext.Current.Session("intUserID").ToString, TypeID)
            ' strScript = strPlotHtml.Split("|")
            ' strValidation = strScript(1)
            strHTML.Append(vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUSIssue(ByVal UserStoryId As String, ByVal Summary As String, ByVal Description As String, ByVal IssueType As String, ByVal SubIssueType As String, ByVal reporter As String, ByVal Resonsible As String, ByVal Status As String) As String

        '=====================================================================
        ' Procedure  Name		:	SaveUSIssue
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save SaveUSIssue
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th April 2018
        '=====================================================================
        Dim insertSuccess As Integer = 0
        Dim strUserID As String = HttpContext.Current.Session("intUserID")
        Dim intProjectId As Integer = HttpContext.Current.Session("intProjectID")
        Dim intProjectTypeId As Integer = HttpContext.Current.Session("ProjectTypeID")
        Dim strUserName As String = HttpContext.Current.Session("strUserName")


        Dim strUniqueID As String
        'Dim strUserStoryId As String

        Try
            If strUserID IsNot Nothing Then
                If Summary = "" Then
                    Summary = "NULL"
                End If
                If Description = "" Then
                    Description = "NULL"
                End If
                If IssueType = "" Then
                    IssueType = "NULL"
                End If
                If SubIssueType = "" Then
                    SubIssueType = "NULL"
                End If
                If reporter = "" Then
                    reporter = "NULL"
                End If
                If Resonsible = "" Then
                    Resonsible = "NULL"
                End If
                If Status = "" Then
                    Status = "NULL"
                End If

                Dim strQuery As String = "usp_NG2_Ins_tbl_IB_Issue " & intProjectId & ",'" & Summary.Replace("'", "''") & "','" & Description.Replace("'", "''") & "','" & IssueType & "','" & SubIssueType & "','" & Status & "','" & reporter & "'," & Resonsible & ",'" & strUserName & "'," & UserStoryId & ""
                strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)
                insertSuccess = strUniqueID
                'If strUserStoryId = "Null" Then
                'Return New frmProductBacklog().WriteGrid("IssueList", UserStoryId, "")

                Return "1"
                'Else
                '    Return RefreshGrid(strUserStoryId)
                'End If

            Else
                Return "Session Expired"
            End If
            Return "0"
        Catch ex As Exception
            Return "Bad Request found"

        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveReviewDetails(ByVal ReviewID As String, ByVal Reviewtype As String, ByVal Reviewtitle As String, ByVal Reviewer As String, ByVal offline As String, ByVal Reviewee As String, ByVal ReviewPlanned As String, ByVal ReviewPlannedto As String, ByVal RevieweeWork As String, ByVal RevieweeActualfrom As String, ByVal RevieweeActualto As String, ByVal ReviewPhase As String, ByVal Delivariables As String, ByVal ModuleID As String, ByVal defects As String, ByVal per As String, ByVal unit As String, ByVal reviewnote As String, ByVal reviewstatus As String, ByVal billable As String, ByVal workproduct As String, ByVal workproductname As String, ByVal conculsion As String, ByVal Requestor As String, ByVal Coordinator As String, ByVal method As String, ByVal Deviation As String, ByVal Completion As String, ByVal Disposition As String, ByVal Checklist As String, ByVal MileStone As String, ByVal strEntityID As String, ByVal strEntity As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveReviewDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save Review Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   5th April 2018
        '=====================================================================
        Try

            Dim insertSuccess As Integer = 0
            Dim strReviewstatsticsProjectID As String = ""
            Dim strUserID As String = HttpContext.Current.Session("intUserID")
            Dim strReviewerName As String = ""
            Dim strRevieweeName As String = ""
            Dim arrEntity As String() = strEntity.Split("_")
            If strUserID IsNot Nothing Then
                If ReviewID = "" Then
                    ReviewID = "NULL"
                End If
                If Reviewtype = "" Then
                    Reviewtype = "Null"
                End If

                If offline = "" Then
                    offline = "NULL"
                End If

                If RevieweeWork = "" Then
                    RevieweeWork = "NULL"
                End If

                ''Commented and added by Ankush T on 29 mar 2019 work field changes
                Dim fltRevieweeWork As Decimal

                If RevieweeWork = "0" Or RevieweeWork = "" Then
                    RevieweeWork = "00:00"
                End If

                If RevieweeWork.IndexOf(":") = RevieweeWork.Length - 1 Then
                    RevieweeWork = RevieweeWork + "00"
                End If

                Dim strDecimal As String = ""
                Dim strBeforeDecimal As String = ""
                strBeforeDecimal = RevieweeWork.Substring(0, RevieweeWork.IndexOf(":"))
                strDecimal = RevieweeWork.Substring(RevieweeWork.IndexOf(":") + 1, 2)
                RevieweeWork = strBeforeDecimal + ":" + strDecimal

                fltRevieweeWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + RevieweeWork + "',2)", True)
                ''Commented and added by Ankush T on 29 mar 2019 work field changes

                If defects = "" Then
                    defects = "NULL"
                End If

                If per = "" Then
                    per = "NULL"
                End If

                If billable = "" Then
                    billable = "NULL"
                End If

                If Delivariables = "" Then
                    Delivariables = "NULL"
                End If

                If ModuleID = "" Then
                    ModuleID = "NULL"
                End If


                If method = "" Then
                    method = "NULL"
                End If

                If Requestor = "" Then
                    Requestor = "NULL"
                End If

                If Deviation = "" Then
                    Deviation = "NULL"
                End If
                If Completion = "" Then
                    Completion = "NULL"
                End If

                If Disposition = "" Then
                    Disposition = "NULL"
                End If
                If Checklist = "" Then
                    Checklist = "NULL"
                End If

                If ReviewID = "0" Then
                    ReviewID = "NULL"
                End If

                If MileStone = "" Then
                    MileStone = "NULL"
                End If

                Dim strQueryForUserName As String = "usp_Ng2_Get_UserNamesForReview '" & Reviewee & "','" & Reviewer & "'"
                Dim dtUserName As New DataTable
                dtUserName = CommonFunctions.Data.GetDataTable(strQueryForUserName, True)
                For i As Integer = 0 To dtUserName.Rows.Count - 1
                    strReviewerName = CommonFunctions.Data.CheckIsDBNull(dtUserName.Rows(i)("Reviewer"), "")
                    strRevieweeName = CommonFunctions.Data.CheckIsDBNull(dtUserName.Rows(i)("Reviewee"), "")
                Next


                ' Dim strQuery As String = " usp_APP_INS_UPD_tbl_PM_ReviewStatistics " & IIf(ReviewID.Replace("'", "''") = "0", "Null", ReviewID.Replace("'", "''")) & "," & ProjectID.Replace("'", "''") & "," & Reviewtype & ",'" & Reviewtitle.Replace("'", "''") & "','" & Reviewer.Replace("'", "''") & "'," & offline.Replace("'", "''") & ",'" & Reviewee.Replace("'", "''") & "','" & ReviewPlanned.Replace("'", "''") & "','" & ReviewPlannedto.Replace("'", "''") & "'," & RevieweeWork.Replace("'", "''") & ",'" & RevieweeActualfrom.Replace("'", "''") & "','" & RevieweeActualto.Replace("'", "''") & "','" & ReviewPhase.Replace("'", "''") & "'," & Delivariables.Replace("'", "''") & "," & ModuleID.Replace("'", "''") & "," & defects.Replace("'", "''") & "," & per.Replace("'", "''") & ",'" & unit.Replace("'", "''") & "','" & reviewnote.Replace("'", "''") & "','" & reviewstatus.Replace("'", "''") & "'," & billable.Replace("'", "''") & ",'" & workproduct.Replace("'", "''") & "','" & workproductname.Replace("'", "''") & "','" & conculsion.Replace("'", "''") & "','" & Requestor.Replace("'", "''") & "','" & Coordinator.Replace("'", "''") & "'," & method.Replace("'", "''") & "," & Deviation.Replace("'", "''") & "," & Completion.Replace("'", "''") & "," & Disposition.Replace("'", "''") & "," & Checklist.Replace("'", "''") & "," & EmployeeID.Replace("'", "''") & ""
                Dim strQuery As String = "  usp_NG2_INS_UPD_tbl_PM_ReviewStatistics " & ReviewID & "," & HttpContext.Current.Session("IntProjectID") & "," & Reviewtype & ",'" & Reviewtitle.Replace("'", "''") & "','" & strReviewerName.Replace("'", "''") & "','" & strRevieweeName.Replace("'", "''") & "','" & ReviewPlanned.Replace("'", "''") & "','" & ReviewPlannedto.Replace("'", "''") & "'," & fltRevieweeWork & ",'" & reviewstatus.Replace("'", "''") & "'," & Checklist.Replace("'", "''") & "," & strEntityID.Replace("'", "''") & ",'UserStory','" & HttpContext.Current.Session("strUserName") & "'"
                'CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                'insertSuccess = "1"

                strReviewstatsticsProjectID = CommonFunction.Data.GetDataScalar(strQuery, True)
                Dim strSQL1 As String = ""
                strSQL1 = "usp_Del_tbl_PM_ReviewStatistics_Reviewers " & strReviewstatsticsProjectID & ",'" & Reviewer & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL1, True)
                Dim strSQLReviwer As String = ""
                strSQLReviwer = "usp_Ins_tbl_PM_ReviewStatistics_Reviewers_New " & strReviewstatsticsProjectID & ",'" & Reviewer & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQLReviwer, True)
                Dim strSQLAuthors As String = ""
                strSQLAuthors = "usp_Del_tbl_PM_ReviewStatistics_Authors " & strReviewstatsticsProjectID & ",'" & Reviewee & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQLAuthors, True)

                Dim strSQLAuthors_New As String = ""
                strSQLAuthors_New = "usp_Ins_tbl_PM_ReviewStatistics_Authors_New " & strReviewstatsticsProjectID & ",'" & Reviewee & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQLAuthors_New, True)



                Dim sqlObservations As String = ""
                sqlObservations = "usp_Upd_tbl_PM_GetReviewObservations " & strReviewstatsticsProjectID & ""
                CommonFunction.Data.InsertOrUpdateData(sqlObservations, True)

                Dim sqlReviewStatistics As String = ""
                sqlReviewStatistics = "usp_Ins_tbl_PM_AssignReviewTasks_ReviewPlanning " & strReviewstatsticsProjectID & "," & HttpContext.Current.Session("intProjectID") & "," & Reviewtype & ",'" & ReviewPlanned.Replace("'", "''") & "','" & Reviewer & "','" & Reviewee & "'," & fltRevieweeWork & ",'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunction.Data.InsertOrUpdateData(sqlReviewStatistics, True)

                'Dim strSqlForReviewCount As String = "usp_APP_Get_ReviewCountForScrumEntities " & strEntityID & ",'" & arrEntity(0) & "'"
                'Dim dtReviewCount As New DataTable
                'dtReviewCount = CommonFunctions.Data.GetDataTable(strSqlForReviewCount, True)
                'Dim strCount As String = ""
                'If dtReviewCount.Rows.Count > 0 Then
                '    If arrEntity(0) = "Release" Or strEntity = "Iteration_UserStory" Then
                '        strCount = CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("OpenReviews"), 0) & " / " & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ClosedReviews"), 0)

                '    Else
                '        strCount = CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("OpenReviews"), 0) & " / " & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ClosedReviews"), 0) & "||" & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ParentID"), 0) & "||" & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ParentOpenReviews"), 0) & " / " & CommonFunctions.Data.CheckIsDBNull(dtReviewCount.Rows(0)("ParentClosedReviews"), 0)
                '    End If
                'End If
                Return 1
            Else
                Return "Session Expired"
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try


        'Return PlotResponsivePage(ProjectID, strReviewstatsticsProjectID, "true")


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
        Try

            Dim strSQL As String
            Dim strREsult As String
            strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'UserStory','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", 'UserStory'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", 'UserStory'", True)

                End If
            End If

            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
        'PlotDiscussionThreadBody(strUserStoryID, "", "UserStory")
    End Function
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
        ' Author                :	SwapnilA
        ' Created               :	3-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22232, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))

    End Function
    Public Function GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SwapnilA
        ' Created               :	3-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22232, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
        Return strIsPrductOwner
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

    <System.Web.Services.WebMethod()>
    Public Shared Function PlotUSControls()
        Dim strHTML As New StringBuilder()


        Try
            Dim drGetSelectedCheckBoxValue As IDataReader
            Dim SelectedCheckbox As String = ""
            Dim SelectedCheckboxSplit() As String
            Dim str As String = ""
            'Added by swapna
            str = "usp_NG2_GetSelectedUserStoryColumnsForUser " & HttpContext.Current.Session("intUserID") & "," & HttpContext.Current.Session("intProjectID") & ""
            'End by swapna
            drGetSelectedCheckBoxValue = CommonFunctions.Data.GetDataReader(str, True)
            While drGetSelectedCheckBoxValue.Read()
                SelectedCheckbox = CommonFunctions.Data.CheckIsDBNull(drGetSelectedCheckBoxValue("SelectedColumns").ToString, "")
            End While
            SelectedCheckboxSplit = SelectedCheckbox.Split(",")
            Return SelectedCheckbox
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    ' added by swapna 8/28/2018
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotTaskAttributeControls()
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "Usp_Ng2_Sel_tbl_PM_AssignTaskAttributeView " & CStr(HttpContext.Current.Session("intUserID")) & "," & CStr(HttpContext.Current.Session("intProjectID")) & ",null"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End by swapna 8/28/2018

    'Commented and Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveSubStories(ByVal strUserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String) As String
    '    Dim strSQL As String
    '    Try
    '        strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "'"
    '        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        Return "1"
    '    Catch ex As Exception
    '        Return "0"
    '    End Try


    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveSubStories(ByVal strUserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String, ByVal Complexity As String, ByVal Category As String) As String
        Dim strSQL As String
        Try

            If Complexity = "" Or Complexity Is Nothing Then
                Complexity = "NULL"
            End If
            If Category = "" Or Category Is Nothing Then
                Category = "NULL"
            End If

            If Complexity = "NULL" Then
                strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "', " & Complexity & ", " & Category
            Else
                strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "', '" & Complexity & "', " & Category
            End If

            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Return "1"
        Catch ex As Exception

            Return "Bad Request found"

        End Try


    End Function

    'End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntryValidation(ByVal UserStoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try


            Dim ValidationResponseText As New StringBuilder
            ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
            Dim strQuery As String
            Dim strMessage As String = ""
            strQuery = "Exec usp_ScrumEntityDeleteValidationNew 'UserStory','" + UserStoryID + "'"
            Dim drEntityValidation As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
            If (drEntityValidation.HasRows) Then
                While (drEntityValidation.Read())
                    ValidationResponseText.Append(drEntityValidation(0).ToString())
                End While
            Else
            End If
            Return ValidationResponseText.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntry(ByVal UserStoryID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try

            Dim strQuery As String = "usp_Del_ScrumEntity 'UserStory','" + UserStoryID + "'"
            Dim strDelete As String = CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            Dim objBacklog As New frmProductBacklog
            'strHTML.Append(frmReleasePlanning.PlotSubUserStoryList(UserStoryID))
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUserStoryDetails(ByVal UserStoryID As String, ByVal strUserStoryName As String, ByVal Description As String, ByVal AcceptanceCriteria As String, ByVal Priority As String, ByVal CategoryID As String, ByVal StoryPoints As String, ByVal HTMLDesc As String, ByVal HTMLAcceptance As String, ByVal BusinessVal As String, ByVal Complexity As String, ByVal StrState As String, ByVal version As String, ByVal FixedVersion As String, ByVal UniqueNo As String) As String
        Try

            Dim strUserName As String = HttpContext.Current.Session("strUserName")
            Dim insertSuccess As Integer = 0
            Dim strUniqueID As String
            If CategoryID = "" Then
                CategoryID = "NULL"
            End If
            If StoryPoints = "" Then
                StoryPoints = "NULL"
            End If
            If BusinessVal = "" Then
                BusinessVal = "NULL"
            End If
            If Complexity = "" Then
                Complexity = "NULL"
            End If
            If StrState = "" Then
                StrState = "NULL"
            End If
            If version = "" Then
                version = "NULL"
            End If
            If FixedVersion = "" Then
                FixedVersion = "NULL"
            End If
            Dim strQuery As String = "usp_NG2_upd_EnhancedUS_tbl_PM_ScrumUserStory " & UserStoryID & ",'" & strUserStoryName.Replace("'", "''") & "','" & Description.Replace("'", "''") & "','" & AcceptanceCriteria.Replace("'", "''") & "','" & Priority.Replace("'", "''") & "'," & CategoryID & "," & StoryPoints & ",'" & strUserName & "','" & HTMLDesc.Replace("'", "''") & "','" & HTMLAcceptance.Replace("'", "''") & "','" & BusinessVal & "','" & Complexity & "','" & StrState & "'," & version & "," & FixedVersion & ",'" & UniqueNo & "'"
            strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)
            insertSuccess = strUniqueID

            Return insertSuccess
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SprintStatus(ByVal UserStoryID As String)
        Try

            Dim objUSDetails As New UserStoryDetails
            objUSDetails.GetAccessRights1()
            Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & UserStoryID & ",'UserStory'", True))
            Dim m_objAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(HttpContext.Current.Session("strUserName").ToString, 22232, HttpContext.Current.Session("intPostID"), CType(HttpContext.Current.Session("intUserID"), Integer), HttpContext.Current.Session("LoginType"))
            m_objAccess.GetAccess(objGlobal)
            If strAddLinkAccess = "0" Then
                If m_objAccess.Edit = True Then
                    Return "0"
                End If
            Else
                Return "1"
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function checkUShasSprintnot(ByVal UserStoryID As String)
        Dim objUSDetails As New UserStoryDetails
        objUSDetails.GetAccessRights1()
        Dim m_objAccess = New WebPage.Templates.AccessRights
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_checkUShasSprintnot " & UserStoryID & ",'UserStory'", True))

        If objUSDetails.m_objAccess.Delete = True Then
            If strAddLinkAccess = "0" Then
                Return "0"
            Else
                Return "1"
            End If
        End If

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTestCaseList(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_NG2_UserstoryTestCaseDetailsReport " & CStr(HttpContext.Current.Session("intProjectID")) & "," & UserStoryID & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveTask(ByVal AssignTaskData As Object, ByVal UserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Create a task
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th-April-2018
        '=====================================================================
        Dim objfrmSprintPlanning As New frmSprintPlanning()
        Dim strReturnHTML As New StringBuilder("")

        Try
            ' Dim PageFlag As String = AssignTaskData(0)("PageFlag")

            If AssignTaskData(0)("PageFlag") = "1" Then
                objfrmSprintPlanning.SaveTaskDetails(AssignTaskData)
                Return "1"

            End If

        Catch ex As Exception

            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowAssignedResources(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_NG2_Sel_tbl_PM_ProjectEmployees " & HttpContext.Current.Session("intprojectID") & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTasksList(ByVal UserStoryID As String)
        Try

            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_NG2_sel_tbl_PM_ScrumTasks " & UserStoryID & ",'UserStory'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function getDateDiff(ByVal StartDate As String, ByVal EndDate As String)
        Try

            Dim strResult As String = "0"

            Dim StrSql As String = "usp_Sel_Days_Count '" & StartDate & "','" & EndDate & "'"
            strResult = CommonFunctions.Data.GetDataScalar(StrSql, True)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AfterDeleteTask(ByVal taskId As String, ByVal UserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Create a task
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th-April-2018
        '=====================================================================
        Try

            Dim frmSprintPlanning As New frmSprintPlanning()
            ' Dim strReturnHTML As New StringBuilder("")
            Dim Restult As String = ""
            Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasksDailyActivity  " & HttpContext.Current.Session("IntProjectId") & "," & taskId & ""

            Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))
            Return "1"
            'Return New frmSprintPlanning().Tasks_section(UserStoryId, "aftersave")
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ChkAccessRights()
        Try

            Dim strIsPrductOwner As String
            Dim objUSDetails As New UserStoryDetails
            strIsPrductOwner = objUSDetails.GetAccessRights()

            'Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory " & UserStoryId
            'Dim drGetUserStory As IDataReader
            'drGetUserStory = CommonFunctions.Data.GetDataReader(strSql, True)
            'If drGetUserStory.Read Then
            '    strState = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("State").ToString, "")
            'End If
            Return strIsPrductOwner
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateLogPersonAccessUserStory(ByVal UserStoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	ValidateLogPersonAccessUserStory
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Try


            Dim strQuery As String = ""
            Dim strMessage As String = ""
            Dim drGetValidation As IDataReader
            Dim strResult As String = ""

            strQuery = "usp_NG2_chk_UserAssociatedWithUserStory " & UserStoryID & ",'" & HttpContext.Current.Session("intUserID") & "'"


            drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetValidation.Read
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
            End While
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateStageID(ByVal UserStoryID As String, ByVal StageID As String, ByVal Mode As String) As String
        '=====================================================================
        ' Procedure  Name		:	UpdateStageID
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================

        Dim strQuery As String = ""
        Dim strResult As String = ""
        Dim strFlag As String = "0"

        Try


            Dim strValidationResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_IsSprintCompleted " & UserStoryID, True), "")

            If strValidationResult = "" Then
                strQuery = "usp_NG2_upd_tbl_PM_ScrumBoardUserStories " & UserStoryID & "," & StageID & ",'" & HttpContext.Current.Session("strUserName") & "'"


                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                strFlag = "1"
            Else
                strFlag = strValidationResult
            End If
            Return strFlag
        Catch ex As Exception

            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DropValidation(ByVal UserStoryID As String, ByVal StageID As String, ByVal Mode As String, ByVal IssueOpenFlag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DropInProgressValidation
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				: Yogesh Jalamkar
        ' Created				:   27-MAR-2018
        '=====================================================================
        Try


            Dim strQuery As String = ""
            Dim strMessage As String = ""
            Dim drGetValidation As IDataReader
            Dim drGetValidation1 As IDataReader
            Dim strResult As String = ""
            Dim strResult1 As String = ""


            If IssueOpenFlag = "1" Then
                strQuery = "usp_NG2_chk_IssueOpenForUserStory " & UserStoryID & ""
                drGetValidation1 = CommonFunctions.Data.GetDataReader(strQuery, True)
                While drGetValidation1.Read
                    strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation1("Result").ToString, "")
                End While

                If strResult = "" Then
                    If Mode = "InProgress" Then
                        strQuery = "usp_NG2_chk_TaskMappedToUserstory " & UserStoryID & ""
                    ElseIf Mode = "Completed" Then
                        strQuery = "usp_NG2_chk_AllowToCompleteUserStory " & UserStoryID & ",'" & HttpContext.Current.Session("intUserID") & "'"
                    End If
                    drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
                    While drGetValidation.Read
                        strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
                    End While
                    Return strResult
                Else
                    Return strResult
                End If



            End If


            If strResult = "" Then
                If Mode = "InProgress" Then
                    strQuery = "usp_NG2_chk_TaskMappedToUserstory " & UserStoryID & ""
                ElseIf Mode = "Completed" Then
                    strQuery = "usp_NG2_chk_AllowToCompleteUserStory " & UserStoryID & ",'" & HttpContext.Current.Session("intUserID") & "'"
                End If
                drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
                While drGetValidation.Read
                    strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
                End While
                Return strResult
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetExistingUniqueNumberFromDB(ByVal objComplexity As String, ByVal PriorityTemp As String, ByVal strUserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetExistingUniqueNumberFromDB
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   22-Feb-2017
        '=====================================================================
        Try

            If strUserStoryId = "" Then
                strUserStoryId = "NULL"
            End If
            ' Dim StrQuery As String = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & PriorityTemp & ", '" & objComplexity & "'," & strUserStoryId & ""
            Dim StrQuery As String = ""

            'added By Dipali V On 9th may For Sub Us Rank duplication
            If strUserStoryId = 0 Then
                StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & PriorityTemp & ", '" & objComplexity & "'," & strUserStoryId & ""
            Else
                StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & PriorityTemp & ", '" & objComplexity & "',NULL," & strUserStoryId & ""
            End If
            'end of added By Dipali V On 9th may For Sub Us Rank duplication




            Dim intUniqueNo As String = ""

            Dim drGetUniqueNo As IDataReader
            Dim strHTML As New StringBuilder
            drGetUniqueNo = CommonFunctions.Data.GetDataReader(StrQuery, True)
            While drGetUniqueNo.Read
                intUniqueNo = CommonFunctions.Data.CheckIsDBNull(drGetUniqueNo("Result").ToString, "")
            End While

            Return intUniqueNo
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