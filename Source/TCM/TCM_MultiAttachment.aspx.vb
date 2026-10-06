Public Class TCM_MultiAttachment
    Inherits WebPages.Template.WhizTemplate


    Protected m_strAction As String = ""
    Private m_strTestSessionID As String
    Private m_strProjectTestCaseID As String
    Private blnIsTestSessionClosed As Boolean

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()
        'If Page.IsPostBack Then
        If (Request.QueryString("Action") & "").ToUpper = "ATTACH" Then
            Call PerformAttachment()
        ElseIf (Request.QueryString("Action") & "").ToUpper = "DELETE" Then
            Call PerformDeleteAttachment()
        End If

    End Sub

    Private Sub PerformDeleteAttachment()
        Dim arrStrAttachmentIDs() As String = Request.Form("chkDelete").Split(CChar(","))
        Dim counter As Integer = 0
        Dim strSQL As String

        While counter < arrStrAttachmentIDs.Length
            strSQL = "usp_InsDel_tbl_TCM_TestCaseResponsesAttachments " + arrStrAttachmentIDs(counter)
            Dim dr As IDataReader
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''dr = CommonFunction.Data.GetDataReader("Select SystemFileName from tbl_TCM_TestCaseResponsesAttachments WHERE AttachmentID = " + arrStrAttachmentIDs(counter), MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_TCM_TestCaseResponsesAttachments_SystemFileName " + arrStrAttachmentIDs(counter), MyBase.UseSQL)
            If dr.Read Then
                Try
                    System.IO.File.Delete(Server.MapPath("../../Attachments/TCM/TestCaseResponses/" + dr(0).ToString))
                Catch ex As Exception

                End Try



            End If

            CommonFunction.Data.DisposeDataReader(dr)
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            counter += 1

        End While

    End Sub
    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True, 2)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        If Not Request.QueryString("TestSessionID") Is Nothing Then
            m_strTestSessionID = Request.QueryString("TestSessionID").ToString
        ElseIf Not Request.Form("TestSessionID") Is Nothing Then
            m_strTestSessionID = Request.Form("TestSessionID").ToString
        Else
            m_strTestSessionID = "0"
        End If

        If Not Request.QueryString("ProjectTestCaseID") Is Nothing Then
            m_strProjectTestCaseID = Request.QueryString("ProjectTestCaseID").ToString
        ElseIf Not Request.Form("ProjectTestCaseID") Is Nothing Then
            m_strProjectTestCaseID = Request.Form("ProjectTestCaseID").ToString
        Else
            m_strProjectTestCaseID = "0"
        End If

        If Request.Form("hidIsTestSessionClosed") <> "" Then
            blnIsTestSessionClosed = CType(Request.Form("hidIsTestSessionClosed"), Boolean)
        ElseIf Request.QueryString("IsTestSessionClosed") <> "" Then
            blnIsTestSessionClosed = CType(Request.QueryString("IsTestSessionClosed"), Boolean)
        End If




    End Sub

    Private Sub PerformAttachment()
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
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strResponsePath As String
        Dim strIBPath As String
        Dim strFileName As String
        Dim strIBFileName As String
        Dim strOriginalFileName As String
        Dim strDescription As String

        If UCase(Trim(m_strAction & "")) = "ATTACH" Then

            strResponsePath = Server.MapPath("../../Attachments/TCM/TestCaseResponses")
            strIBPath = Server.MapPath("../../Attachments/BTS")

            'Added while loop by PrashantD 
            Dim count As Integer
            count = 0
            While Request.Files.Count > count

                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

                ' upload the file for Test Case 
                Dim objFile As New FileUpload.cUpload(Request.Files.Keys.Item(count), strResponsePath, strFileName)
                objFile.OverwriteIfExists = True
                objFile.UploadFile()

                ' the file name
                strOriginalFileName = objFile.OriginalFileName
                strOriginalFileName = CommonFunction.General.BuildQueryString(strOriginalFileName)
                strFileName = objFile.UploadedFileName
                objFile = Nothing

                ' database updates!!!
                strSQL = "usp_InsDel_tbl_TCM_TestCaseResponsesAttachments NULL," + m_strTestSessionID + "," + m_strProjectTestCaseID + ",'" + strOriginalFileName + "','" + strFileName + "'," + Session("intUserID").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                If Request.Form("hidIssueID") <> "" And Request.QueryString("Mode") = "ATTACHIB" Then


                    If Not System.IO.File.Exists(strIBPath + "\" + strFileName) Then
                        strIBFileName = strFileName
                    Else
                        strIBFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                        strIBFileName += strFileName.Substring(strFileName.IndexOf("."))

                    End If

                    System.IO.File.Copy(strResponsePath + "\" + strFileName, strIBPath + "\" + strIBFileName)


                    ' database updates!!!
                    strSQL = "usp_Ins_tbl_IB_Attachments " + Request.Form("hidIssueID") + "," + Session("intProjectID").ToString + "," + Session("intUserID").ToString + ",'E','" + strFileName + "','" + strOriginalFileName + "','Attachment by TCM',0"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                End If


                count += 1
            End While
        End If
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
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
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        ''Dim arrMenu() As String = {"Upload", "Delete", MyBase.GetResourceString("MENU_CLOSE")}
        ''Dim arrMenuToolTip() As String = {"Upload", "Delete Attachments", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        ''Dim arrCSFunction() As String = {"Attach_OnClick()", "DeleteAttachment()", "Close_OnClick()"}
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList



        If blnIsTestSessionClosed = False Then
            arrMenu.Add("Upload")
            arrMenu.Add("Delete")

            arrMenuToolTip.Add("Upload")
            arrMenuToolTip.Add("Delete")


            arrCSFunction.Add("Attach_OnClick()")
            arrCSFunction.Add("DeleteAttachment()")

        End If

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrCSFunction.Add("Close_OnClick()")

        Dim m_intTotalAttachedFiles As Integer = 0
        Dim strCss As String = "clsTROdd"

        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Plotting info in hidden form
        CommonFunction.General.WriteHTML("<INPUT type=HIDDEN name=TestSessionID id=TestSessionID value=" + m_strTestSessionID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=HIDDEN name=ProjectTestCaseID id=ProjectTestCaseID value=" + m_strProjectTestCaseID + ">")
        CommonFunction.General.WriteHTML("<input type=hidden name=hidIsTestSessionClosed id=hidIsTestSessionClosed value='" + blnIsTestSessionClosed.ToString.ToUpper + "'> ")
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''dr = CommonFunction.Data.GetDataReader("Select IssueID FROM tbl_TCM_TestCaseResponses WHERE TestSessionID = " + m_strTestSessionID + " AND TestCaseID = " + m_strProjectTestCaseID, MyBase.UseSQL)
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_TCM_TestCaseResponses_IssueID " + m_strTestSessionID + "," + m_strProjectTestCaseID, MyBase.UseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("IssueID")) Then
                CommonFunction.General.WriteHTML("<INPUT Type=hidden name=hidIssueID id=hidIssueID value=" + dr("IssueID").ToString + " >")
            Else
                CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidIssueID value='' >")
            End If
        Else
            CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidIssueID value='' >")
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        'End of plotting info in hidden form


        strMenu = WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip))
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")

            .Write("<TABLE id='tblFileAttachment' cellspacing=0 class=clsTable style='Width:99.9%;visibility:visible;DISPLAY: inline'>")

            'Added By KapilGK For WhizibleSEM SP 8 On 10 Nov 2006
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("<B>Note : </B> User can attach maximum three files at a time.")
            .Write("</TD>")
            .Write("</TR>")
            'End of Addition By KapilGk

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("<B>" + "Select File" + "</B>")
            .Write("</TD>")
            .Write("</TR>")

            ' the file control
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            'CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()' onchange='addFileinGrid()'")
            .Write("</TD>")
            .Write("</TR>")

            ''added by PrashantD

            CommonFunctions.General.WriteHTML("<tr class=clsTREven id=AttFileHead style='display:none' ><td><B>Attached Files</B></td></tr><TR class=clsTREven ><TD><table id=tblFiles style='display:none;width=97.8%;' class=clsGridTable><thead class=clsTRColumnHeader align='left'><th>Files</th><th width=100></th></thead></table></TD></TR>")


            '''' comments
            '''.Write("<TR class=clsTREven>")
            '''.Write("<TD>")
            '''CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmAttachment", , , 450, 100, 2000)
            '''.Write("</TD>")
            '''.Write("</TR>")

            'Attached Files
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Attached Files</TD></TR></TABLE>")
            .Write("</TD>")
            .Write("</TR>")




            CommonFunction.General.WriteHTML("<TR class=clsTREven><TD>")
            CommonFunction.General.WriteHTML("<TABLE cellspacing=1 cellpadding=0 Width='99.9%' class='clsGridTable'>")
            CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
            CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left'  >")
            CommonFunction.General.WriteHTML("File")
            CommonFunction.General.WriteHTML("</TH>")
            CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left' width=10px >")
            CommonFunction.General.WriteHTML("Delete")
            CommonFunction.General.WriteHTML("</TH>")
            CommonFunction.General.WriteHTML("</Thead>")

            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''dr = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_TCM_TestCaseResponsesAttachments WHERE TestSessionID = " + m_strTestSessionID + " AND ProjectTestCaseID = " + m_strProjectTestCaseID, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_TCM_TestCaseResponsesAttachments_TestSessionID " + m_strTestSessionID + "," + m_strProjectTestCaseID, MyBase.UseSQL)

            While dr.Read
                CommonFunction.General.WriteHTML("<TR class=" + strCss + ">")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML("<A href='JavaScript:showAttachment(""" + dr("SystemFileName").ToString + """)'>" + dr("OriginalFileName").ToString + "</A>")
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , dr("AttachmentID").ToString)
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                If strCss = "clsTREven" Then
                    strCss = "clsTROdd"
                Else
                    strCss = "clsTREven"
                End If
                m_intTotalAttachedFiles += 1
            End While
            CommonFunction.Data.DisposeDataReader(dr)

            CommonFunction.General.WriteHTML("</TABLE>")
            CommonFunction.General.WriteHTML("<input type=hidden id=hidTotalAttachedFiles value=" + m_intTotalAttachedFiles.ToString + ">")

            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            .Write("</TABLE>")

            ' Message Table
            .Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='90%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            .Write("<TR>")
            .Write("<TD height='20'>")
            .Write("&nbsp;</TD></TR>")
            .Write("<TR><TD align=center class=clsTDEven>")
            .Write("<LABEL id=lblFileUploadStatus><B>Uploading file...Please wait !!</B></LABEL>")
            .Write("</TD></TR>")
            .Write("</TABLE>")

            .Write("</DIV>")
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub

End Class
