Public Class PM_MSPUpload
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class Name            :	PM_MSPUpload
    ' Purpose               :	Upload MPP Files to server
    ' Description           :	Same as above
    ' Assumptions           :	None.
    ' Dependencies          :	None.
    ' Author                :	SuryabirD
    ' Created               :	Feb 19, 2004
    ' Revisions             :
    '=====================================================================
    Protected m_strPageTitle As String
    Protected m_blnUseSQL As Boolean
    Protected m_blnFileNotBaselined As Boolean

    Private Const CONST_MSP_CONN_STRING_2000 As String = "Provider=Microsoft.Project.OLEDB.9.0;PROJECT NAME="
    Private Const CONST_MSP_CONN_STRING_2002 As String = "Provider=Microsoft.Project.OLEDB.10.0;PROJECT NAME="
    Private Const CONST_MSP_CONN_STRING_2003 As String = "Provider=Microsoft.Project.OLEDB.11.0;PROJECT NAME="

    Private Const MPPFILE_FOLDER As String = "../../Projects/"
    Private m_MSPConnectionString As String

    ' Added By NitinVS on 4 Feb 2005 for Sierra Atlantic 
    Private intDateValidations As Integer
    Private projectStartDate As Date
    Private projectFinishDate As Date
    Dim mppMinStartDate As Date
    Dim mppMaxFinishDate As Date
    Dim mppTotalHours As Double
    Dim projectTotalBalancedHours As Double
    ' End Addition By NitinVS on 4 Feb 2005 for Sierra Atlantic 


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
        'Put user code to initialize the page here

        Dim strHTML, strSQL, strUploadPath As String
        Dim intTotal As Integer
        Dim strAttachmentFolderPath As String = Server.MapPath(MPPFILE_FOLDER)
        Dim strQuery As String
        Dim strFileName, strOldName As String
        Dim strReviewNote As String
        'Added by PrajaktaR on 15 Sept 2005 for IssueID 404 of WSEMSP4
        Dim strMessage As String
        'END Of Addtion by PrajaktaR on 15 Sept 2005 for IssueID 404 of WSEMSP4
        '-- initialize variable 
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        '-- Page Title 
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

        '============== CODE TO UPLOAD Posted File =========================
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToString.ToUpper = "UPLOAD" Then
            Dim strSystemFileName As String = CommonFunction.FileDirectory.GetUniqueFileName()
            Dim objFile As New FileUpload.cUpload("txtFileName", strAttachmentFolderPath, strSystemFileName)

            objFile.UploadFile()
            objFile.OverwriteIfExists = True

            'Added by Prajakta for Sierra  - Integrated for IssueID 404 of WSEMSP4
            Dim strOLDMSProjectFileName As String
            Dim strOLDOriginalFileName As String
            Dim strSelectQuery As String
            Dim drSelect As IDataReader

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSelectQuery = "SELECT MSProjectFileName , OriginalFileName FROM tbl_PM_Project Where ProjectID= " + Session("intProjectID").ToString
            strSelectQuery = "usp_sel_tbl_PM_Project_MSProjectFileName_OriginalFileName " + Session("intProjectID").ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drSelect = CommonFunctions.Data.GetDataReader(strSelectQuery, m_blnUseSQL)
            If drSelect.Read Then
                strOLDMSProjectFileName = CType(CommonFunctions.Data.CheckIsDBNull(drSelect("MSProjectFileName"), ""), String)
                strOLDOriginalFileName = CType(CommonFunctions.Data.CheckIsDBNull(drSelect("OriginalFileName"), ""), String)
            End If
            CommonFunction.Data.DisposeDataReader(drSelect)
            drSelect = Nothing
            'End of Addition by Prajakta for Sierra - Integrated for IssueID 404 of WSEMSP4

            strOldName = objFile.OriginalFileName
            strFileName = objFile.UploadedFileName

            '-- Update the MSP File Name in tbl_PM_Project
            strQuery = "Update tbl_PM_Project Set MSProjectFileName= '" + CommonFunctions.General.BuildQueryString(strFileName) + "', originalfilename = '" + CommonFunctions.General.BuildQueryString(strOldName) + "' Where ProjectID=" + Session("intProjectID").ToString
            CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)

            '-- Entry into CheckINCheckOUT table
            strQuery = "usp_Ins_Upd_tbl_PM_CheckINCheckOUT " + Session("intProjectID").ToString + "," + Session("intUserID").ToString + ",0"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)

            objFile = Nothing

            '============================== CHECK IF Project File is BASELINED ======================================

            'Here I will call one function which will check for whether the uploaded file is marked as basline or not
            intTotal = funcCheckWheteherBaseline()

            If (intTotal <= 0) Then

                strHTML = strHTML & "<TABLE cellspacing='0' Width='99.9%' class=clsTable>"

                If (intTotal = 0) Then
                    strHTML = strHTML & "<TR><TD class=clsTDEven align=Center Height='100'>" + MyBase.GetResourceString("MSG_NOT_BASELINE") + "</TD></TR></TABLE>"
                Else
                    strHTML = strHTML & "<TR><TD class=clsTDEven align=Center Height='100'>" + MyBase.GetResourceString("MSG_NOT_LINKED") + "</TD></TR></TABLE>"
                End If

                Response.Write(strHTML)
                strSQL = "EXEC usp_Reset_MSprojectStatus " + Session("intUserID").ToString + "," + Session("intProjectId").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                m_blnFileNotBaselined = True

                'Added by Prajakta for Sierra - Integrated for IssueID 404 of WSEMSP4
                'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                If strOLDMSProjectFileName <> "" And strOLDOriginalFileName <> "" Then
                    'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                    strQuery = "Update tbl_PM_Project Set MSProjectFileName= '" + CommonFunctions.General.BuildQueryString(strOLDMSProjectFileName) + "', originalfilename = '" + CommonFunctions.General.BuildQueryString(strOLDOriginalFileName) + "' Where ProjectID=" + Session("intProjectID").ToString
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)
                    'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                End If
                'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                'End of Addition by Prajakta for Sierra 
                'End Integrated for IssueID 404 of WSEMSP4
                'Else
                ' -- - Integrated for IssueID 404 of WSEMSP4
                ' Added By NitinVS on 4 Feb 2005 for Sierra Atlantic 
                ' For Validating MSP Task Min Start Date and Max End Date With Project Start Date and End Date Respectively 
                ' If not valid then give appropriate message to the user.
                'if Start Date out of range		

            ElseIf (intDateValidations = -1) Then
                strMessage = MyBase.GetResourceString("MSG_INVALID_STARTDATE")
                'Replace Place Holders 
                strMessage = Replace(strMessage, "<PROJECTSTARTDATE>", CType(CommonFunction.Dates.GetDate(projectStartDate), String))
                strMessage = Replace(strMessage, "<MPPMINSTARTDATE> ", CType(CommonFunction.Dates.GetDate(mppMinStartDate), String))
                strHTML = strHTML & "<TABLE cellspacing='0' Width='99.9%' class=clsTable>"
                strHTML = strHTML + "<TR><TD class=clsTDEven align=Center Height='100'> " + strMessage + "</TD></TR></TABLE>"
                Response.Write(strHTML)
                strSQL = "EXEC usp_Reset_MSprojectStatus " + Session("intUserID").ToString + "," + Session("intProjectId").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                m_blnFileNotBaselined = True
                'if End Date out of range				

                'Added by Prajakta for Sierra 
                'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                If strOLDMSProjectFileName.Trim <> "" Or strOLDOriginalFileName.Trim <> "" Then
                    'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                    strQuery = "Update tbl_PM_Project Set MSProjectFileName= '" + CommonFunctions.General.BuildQueryString(strOLDMSProjectFileName) + "', originalfilename = '" + CommonFunctions.General.BuildQueryString(strOLDOriginalFileName) + "' Where ProjectID=" + Session("intProjectID").ToString
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)
                    'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                End If
                'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                'End of Addition by Prajakta for Sierra 

            ElseIf (intDateValidations = -2) Then
                strMessage = MyBase.GetResourceString("MSG_INVALID_ENDDATE")
                'Replace Place Holders 
                strMessage = Replace(strMessage, "<PROJECTFINISHDATE>", CType(CommonFunction.Dates.GetDate(projectFinishDate), String))
                strMessage = Replace(strMessage, "<MPPMAXFINISHDATE>", CType(CommonFunction.Dates.GetDate(mppMaxFinishDate), String))
                strHTML = strHTML & "<TABLE cellspacing='0' Width='99.9%' class=clsTable>"
                strHTML = strHTML + "<TR><TD class=clsTDEven align=Center Height='100'>" + strMessage + "</TD></TR></TABLE>"
                Response.Write(strHTML)
                strSQL = "EXEC usp_Reset_MSprojectStatus " + Session("intUserID").ToString + "," + Session("intProjectId").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                m_blnFileNotBaselined = True
                'if Work Hours exceding balanced hours				

                'Added by Prajakta for Sierra 
                'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                If strOLDMSProjectFileName.Trim <> "" Or strOLDOriginalFileName.Trim <> "" Then
                    'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                    strQuery = "Update tbl_PM_Project Set MSProjectFileName= '" + CommonFunctions.General.BuildQueryString(strOLDMSProjectFileName) + "', originalfilename = '" + CommonFunctions.General.BuildQueryString(strOLDOriginalFileName) + "' Where ProjectID=" + Session("intProjectID").ToString
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)
                    'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                End If
                'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                'End of Addition by Prajakta for Sierra 


            ElseIf (intDateValidations = -3) Then
                strMessage = MyBase.GetResourceString("MSG_INVALID_WORKHOURS")
                'Replace Place Holders 
                strMessage = Replace(strMessage, "<PROJECTBALANCEHOURS>", CType(projectTotalBalancedHours, String))
                strMessage = Replace(strMessage, "<MPPTOTALHOURS>", CType(mppTotalHours, String))
                strHTML = strHTML & "<TABLE cellspacing='0' Width='99.9%' class=clsTable>"
                strHTML = strHTML + "<TR><TD class=clsTDEven align=Center Height='100'>" + strMessage + "</TD></TR></TABLE>"
                Response.Write(strHTML)
                strSQL = "EXEC usp_Reset_MSprojectStatus " + Session("intUserID").ToString + "," + Session("intProjectId").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                m_blnFileNotBaselined = True
                'End If

                ' End Addition By NitinVS on 4 Feb 2005 For Sierra Atlantic 

                'Added by Prajakta for Sierra 
                'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                If strOLDMSProjectFileName.Trim <> "" Or strOLDOriginalFileName.Trim <> "" Then
                    'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                    strQuery = "Update tbl_PM_Project Set MSProjectFileName= '" + CommonFunctions.General.BuildQueryString(strOLDMSProjectFileName) + "', originalfilename = '" + CommonFunctions.General.BuildQueryString(strOLDOriginalFileName) + "' Where ProjectID=" + Session("intProjectID").ToString
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)
                    'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                End If
                'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                'End of Addition by Prajakta for Sierra 
            ElseIf (intTotal = 2) Then
                strHTML = strHTML & "<TABLE cellspacing='0' Width='99.9%' class=clsTable>"
                strHTML = strHTML & "<TR><TD class=clsTDEven align=Center Height='100'>MSP Version on the WebServer & the MSP Version in the Corporate Settings are not matching. Please Check!!!</TD></TR></TABLE>"
                'Added by PrajaktaR on 14 Sept 2005 for changing the Error Message from the Page Crash due to 
                'Solution Provider not found'
                Response.Write(strHTML)
                strSQL = "EXEC usp_Reset_MSprojectStatus " + Session("intUserID").ToString + "," + Session("intProjectId").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                m_blnFileNotBaselined = True
                'Added by Prajakta for Sierra 
                'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                If strOLDMSProjectFileName <> "" And strOLDOriginalFileName <> "" Then
                    'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                    strQuery = "Update tbl_PM_Project Set MSProjectFileName= '" + CommonFunctions.General.BuildQueryString(strOLDMSProjectFileName) + "', originalfilename = '" + CommonFunctions.General.BuildQueryString(strOLDOriginalFileName) + "' Where ProjectID=" + Session("intProjectID").ToString
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, m_blnUseSQL)
                    'Added by PrajaktaR on 29 June for Sierra IssueID 19544
                End If
                'End of Addition by PrajaktaR on 29 June for Sierra IssueID 19544
                'End of Addition by Prajakta for Sierra 

                'END - Integration for IssueID 404 of WSEMSP4

            Else
                '-- If File is Baselined and NOT Linked then we refreesh Parnt Page to Process the MPP
                '--Also insert the Comments into database

                strReviewNote = MyBase.FixString(MyBase.GetFormValue("txtComments"), 2000, False, False)

                strSQL = "INSERT INTO tbl_PM_MSPReview (ProjectId, EmployeeID, ReviewNote, Reviewtype) " + _
                        " VALUES " + "(" + Session("intProjectID").ToString + "," + Session("intUserID").ToString + ",'" + strReviewNote + "',1" + ")"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                '-- Refresh Parent Page
                Response.Write("<script language=javascript>" + vbCrLf)
                Response.Write("window.opener.document.forms['Uploadutility'].action = 'PM_MSPProject.aspx?Mode=SAVE&MasterTagID=29'" + vbCrLf)
                Response.Write("" + vbCrLf)
                Response.Write("window.opener.document.forms['Uploadutility'].submit()" + vbCrLf)
                Response.Write("</script>")

            End If

        End If



    End Sub


    Public Sub Plothead()
        '-- Plots html page head
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)

    End Sub
    Public Sub DrawPage()
        '-- function draws the controls on the page
        Dim strMenu As String = DrawMenu()


        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToString.ToUpper = "UPLOAD" Then
            '-- Message Table
            If Not m_blnFileNotBaselined Then
                Response.Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")

                Response.Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='90%' Width='99.9%' class=clsTable >")
                Response.Write("<TR class=clsTROdd>")
                Response.Write("<TD height='20'>")
                Response.Write("&nbsp;</TD></TR>")
                Response.Write("<TR class=clsTROdd><TD align=center >")
                Response.Write("<LABEL id=lblFileUploadStatus><B>" + MyBase.GetResourceString("MSG_SUCCESS") + "</B></LABEL>")
                Response.Write("</TD></TR>")
                Response.Write("</TABLE>")

                Response.Write("</DIV>")
                Response.Write("<BR>")
            End If
        Else
            Response.Write(strMenu)
            Response.Write("<BR>")
            Response.Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")

            Response.Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            Response.Write("<TR class=clsTREven>")
            Response.Write("<TD>")
            Response.Write("<B>" + MyBase.GetResourceString("SEL_FILE") + "</B>")
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR class=clsTREven>")
            Response.Write("<TD>")
            'Response.Write("<INPUT TYPE=FILE SIZE=74 CLASS=clsTextBox NAME='txtFileName' LANGUAGE=javascript onkeydown=""return txtFileName_onkeydown()"" style='BACKGROUND-COLOR=#d3d3d3' onbeforepaste=""return txtFileName_onbeforepaste()"" onpaste=""return txtFileName_onpaste()"">")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", "clsFileControl", 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'")
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR class=clsTREven>")
            Response.Write("<TD>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COMMENTS"), , , "frmFileAttachment", , , 450, 100, 2000)
            CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", MyBase.GetResourceString("COMMENTS"), , , "frmFileAttachment", , , 450, 100, 2000, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("</TABLE>")

            '-- Message Table
            Response.Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='90%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            Response.Write("<TR>")
            Response.Write("<TD height='20'>")
            Response.Write("&nbsp;</TD></TR>")
            Response.Write("<TR><TD align=center class=clsTDEven>")
            Response.Write("<LABEL id=lblFileUploadStatus><B>Uploading file...Please wait !!</B></LABEL>")
            Response.Write("</TD></TR>")
            Response.Write("</TABLE>")

            Response.Write("</DIV>")
            Response.Write("<BR>")
            Response.Write(strMenu)
        End If


    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.PM_MSPUpload", "AppResources")

        Dim objMenu As New WebPage.Templates.StaticMenu
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrClientSideFunctions() As String = {"Attach_OnClick(" + CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0").ToString + ")", "Close_OnClick()"}

        Dim strMenu As String = objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu

    End Function

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PM_MSPUpload", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name        :  funcCheckWheteherBaseline
    ' Description           :
    ' Purpose               :   This function will check whether the the currently uploaded file is marked as a baseline or not.
    '                           
    ' Parameters Passed     :  None
    ' Returns               :  Total no of hours/efforts on this project.
    ' Parameters Affected   :  None
    ' Assumptions           :  
    ' Dependencies          :   

    ' Author                :  AmitL 
    ' Created               :  10-10-2001 
    ' Revisions             :
    '=====================================================================	

    Function funcCheckWheteherBaseline() As Integer
        Dim drAssigns As IDataReader
        Dim strSelect, strFileName, strSQL As String
        Dim intTotal As Integer = 0
        Dim objconnection As New ADODB.Connection
        Dim rsAssigns As New ADODB.Recordset
        ' - Integrated for IssueID 404 of WSEMSP4
        'Added by Prajakta on 15 Sept 2005
        Dim rsTest As New ADODB.Recordset
        Dim mppHours As Double
        Dim dtmMinStartDate As Date
        Dim dtmMaxFinishDate As Date
        Dim dtmStartDate As Date
        Dim dtmFinishDate As Date
        Dim rsMPPValidations As IDataReader
        'END Of Addition by Prajakta on 15 Sept 2005

        'Added By RajashriK on 04-May-2005 -- Added by PrajaktaR for IssueID 404 of WSEM
        'To resolve the following problem:
        'When we upload the same resource pool mpp 2 time, second time it does not recognize it as resorcepool mpp
        'So we need to upload dummay non existing file. 
        Select Case CommonFunctions.Application.MSPVersion.ToString

            Case "2000"
                'OLEDB Componant of the MSProject 2000
                m_MSPConnectionString = CONST_MSP_CONN_STRING_2000 + Server.MapPath(MPPFILE_FOLDER) + "NoFile.mpp"

            Case "2002"
                'OLEDB Componant of the MSProject 2002
                m_MSPConnectionString = CONST_MSP_CONN_STRING_2002 + Server.MapPath(MPPFILE_FOLDER) + "NoFile.mpp"

                '-- Code Added : 22nd July: SurybairD: For supporting Project 2003 ---
            Case "2003"
                'OLEDB Componant of the MSProject 2002
                m_MSPConnectionString = CONST_MSP_CONN_STRING_2003 + Server.MapPath(MPPFILE_FOLDER) + "NoFile.mpp"
                '-- End of code addition ---

            Case Else
                'OLEDB Componant of the MSProject 2000 (By default it will be MS Project 2000)
                m_MSPConnectionString = CONST_MSP_CONN_STRING_2000 + Server.MapPath(MPPFILE_FOLDER) + "NoFile.mpp"

        End Select
        Try
            '-- Open Connection to MSP File
            objconnection.Open(m_MSPConnectionString)
        Catch ex As Exception

        End Try

        objconnection = Nothing

        'End addition By RajashriK on 04-May-200 -- End of Addition by PrajaktaR for IssueID 404 of WSEM

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT MsProjectFileName FROM tbl_PM_Project WHERE ProjectId =" + Session("intProjectID").ToString
        strSQL = "SELECT MsProjectFileName FROM tbl_PM_Project WHERE ProjectId =" + Session("intProjectID").ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strFileName = CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL).ToString

        strFileName = Server.MapPath(MPPFILE_FOLDER) + strFileName
        ' - Integrated for IssueID 404 of WSEMSP4
        'Added by PrajaktaR on 15 Sept 2005 for the Crash caused when the MSP Version in the Corporate Settings 
        '& the MSP Version on the WEB Server do not match.
        intTotal = 2
        Try
            'End of Addition by PrajaktaR on 15 Sept 2005 for the Crash caused when the MSP Version in the Corporate Settings 
            '& the MSP Version on the WEB Server do not match.

            'OLEDB Componant of the MSProject 2000		
            'Purpose: to give support to the MSP 2000 and MSP 2002
            Select Case CommonFunctions.Application.MSPVersion.ToString

                Case "2000"
                    'OLEDB Componant of the MSProject 2000
                    m_MSPConnectionString = CONST_MSP_CONN_STRING_2000 + strFileName

                Case "2002"
                    'OLEDB Componant of the MSProject 2002
                    m_MSPConnectionString = CONST_MSP_CONN_STRING_2002 + strFileName

                    '-- Code Changed : Suryabir D: 21 July 04
                Case "2003"
                    'OLEDB Componant of the MSProject 2003
                    m_MSPConnectionString = CONST_MSP_CONN_STRING_2003 + strFileName
                    '-- Code change ends

                Case Else
                    'OLEDB Componant of the MSProject 2000 (By default it will be MS Project 2000)
                    m_MSPConnectionString = CONST_MSP_CONN_STRING_2000 + strFileName

            End Select

            '-- Open Connection to MSP File
            '-- Added by PrajaktaR for IssueID 404 of WSEM
            objconnection = New ADODB.Connection
            '-- End of Addition by PrajaktaR for IssueID 404 of WSEM
            objconnection.Open(m_MSPConnectionString)


            strSelect = "SELECT TaskBaselineFinish,TaskSubprojectFile FROM Tasks WHERE TaskUniqueID=0 AND TaskBaselineFinish IS NULL AND TaskBaselineStart IS NULL"
            'rsAssigns = CommonFunctions.Data.GetDataReader(strSelect, False, m_MSPConnectionString)
            rsAssigns = objconnection.Execute(strSelect)

            If Not rsAssigns.EOF Then
                If Len(CStr(rsAssigns("TaskBaselineFinish").Value)) < 12 Then
                    If (InStr(1, CStr(rsAssigns("TaskBaselineFinish").Value), "AM") <> 0) Or (InStr(1, CStr(rsAssigns("TaskBaselineFinish").Value), "PM") <> 0) Then
                        intTotal = 0
                    Else
                        intTotal = 1
                    End If
                Else
                    intTotal = 1
                End If
            Else
                intTotal = 1
            End If

            'CommonFunctions.Data.DisposeDataReader(drAssigns)
            rsAssigns = Nothing

            strSelect = "SELECT TaskSubprojectFile FROM Tasks"
            rsAssigns = objconnection.Execute(strSelect)

            'drAssigns = CommonFunctions.Data.GetDataReader(strSelect, False, m_MSPConnectionString)

            Dim strTemp As String = ""
            Dim intLen As Integer
            Do While Not rsAssigns.EOF
                strTemp = CStr(CommonFunctions.General.CheckIsNothing(rsAssigns("TaskSubprojectFile").Value))
                If String.Compare(strTemp, "") <> 0 Then
                    intTotal = -1
                    Exit Do
                End If
                strTemp = ""
                rsAssigns.MoveNext()
            Loop

            rsAssigns = Nothing
            'CommonFunctions.Data.DisposeDataReader(drAssigns)

            'Integrated by PrajaktaR on 15 Sept 2005 
            ' Modified By NitinVS on 4 Feb 2005 for 2005 for Sierra Atlantic 
            ' Added Validation for Project Start Date , End Date and Task Hours as done for PCFC 3.2 by SantoshK 


            '*************************************************************************
            '*************************************************************************
            '=====================================================================
            'Code Added :   SantoshK                Thursday, August 19, 2004 16:12
            '=====================================================================
            strSelect = "Select Tasks.TaskName,Tasks.TaskStart, Tasks.TaskFinish, Tasks.TaskWork FROM Tasks WHERE Tasks.TaskUniqueID = 0 "
            ' WHERE TaskSummary = 0
            rsTest = objconnection.Execute(strSelect)

            mppHours = 0
            dtmMinStartDate = CType(rsTest("TaskStart").Value, Date)
            dtmMaxFinishDate = CType(rsTest("TaskFinish").Value, Date)


            Do While (Not rsTest.EOF)
                If (CType(rsTest("TaskName").Value, String) <> "") Then
                    'start
                    dtmStartDate = CType(rsTest("TaskStart").Value, Date)

                    'finish
                    dtmFinishDate = CType(rsTest("TaskFinish").Value, Date)

                    If DateDiff("d", dtmStartDate, dtmMinStartDate) > 0 Then
                        dtmMinStartDate = dtmStartDate
                    End If

                    If DateDiff("d", dtmFinishDate, dtmMaxFinishDate) < 0 Then
                        dtmMaxFinishDate = dtmFinishDate
                    End If
                    mppHours = mppHours + (CType(rsTest("TaskWork").Value, Double) / 60000)
                End If

                rsTest.MoveNext()
            Loop

            rsTest.Close()
            rsTest = Nothing

            strSQL = "EXEC usp_sel_PM_MPPValidations " + CType(HttpContext.Current.Session("intProjectID"), String)
            rsMPPValidations = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)

            'Response.Write dtmMinStartDate
            'Response.Write "<BR>"
            'Response.Write rsMPPValidations("StartDate")
            'Response.Write "<BR>"
            'Response.Write dtmMaxFinishDate
            'Response.Write "<BR>"
            'Response.Write rsMPPValidations("EndDate")
            'Response.Write "<BR>"
            'Response.Write mppHours		
            'Response.Write "<BR>"
            'Response.Write rsMPPValidations("BalancedHours")

            'check validations
            ''
            If rsMPPValidations.Read Then

                projectStartDate = CType(CommonFunction.Data.CheckIsDBNull(rsMPPValidations("StartDate"), ""), Date)
                projectFinishDate = CType(CommonFunction.Data.CheckIsDBNull(rsMPPValidations("EndDate"), ""), Date)
                projectTotalBalancedHours = CType(CommonFunction.Data.CheckIsDBNull(rsMPPValidations("BalancedHours"), ""), Double)

                mppMinStartDate = dtmMinStartDate
                mppMaxFinishDate = dtmMaxFinishDate
                mppTotalHours = mppHours
            End If


            'for Start Date
            If (DateDiff("d", dtmMinStartDate, rsMPPValidations("StartDate")) > 0) Then
                intDateValidations = -1
            End If

            'End Date
            If (DateDiff("d", dtmMaxFinishDate, rsMPPValidations("EndDate")) < 0) Then
                intDateValidations = -2
            End If

            'Balanced hours
            If (projectTotalBalancedHours < mppHours) Then
                intDateValidations = -3
            End If

            rsMPPValidations.Close()

            CommonFunction.Data.DisposeDataReader(rsMPPValidations)

            rsMPPValidations = Nothing


            '=====================================================================
            'End Of Addition    :   SantoshK               Thursday, August 19, 2004 16:11
            '=====================================================================
            '*************************************************************************
            '*************************************************************************

            ' End Addition By NitinVS on 4 Feb 2005 for Sierra Atlantic 
            'END Of Integration by PrajaktaR on 15 Sept 2005 ' - Integrated for IssueID 404 of WSEMSP4

            'Delete functionality is not working now so right now we are not deleting the rejected file
            Return intTotal
            'Integration by PrajaktaR on 15 Sept 2005 for IssueID 404 of WSEMSP4
        Catch ex As Exception
            'Response.Write("Error : " & ex.Message)
            ex.Source = "PM_MSPUpload.aspx-> Page_Load"
            'Delete functionality is not working now so right now we are not deleting the rejected file
            'END Of Integration by PrajaktaR on 15 Sept 2005 for IssueID 404 of WSEMSP4
            Return intTotal
        End Try
    End Function

    
End Class
