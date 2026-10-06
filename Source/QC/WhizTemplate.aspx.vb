
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient



Partial Public Class WhizTemplates
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Private Variables"
    Private strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    'System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
    Private objCon As SqlConnection = Nothing
    Private objDA As SqlDataAdapter = Nothing
    Private objCMD As SqlCommand = Nothing
    Private objDS As DataSet = Nothing
#End Region

#Region "Variables"
    Private m_Template_PK As Integer
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        ''=====================================================================
        '        ' Procedure Name        : Page_Load
        '        ' Purpose               : To draw the controls on the page in add and edit mode.
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NitinVS
        '        ' Created               : Nov 22,2006
        '        ' Revisions             :
        '        '=====================================================================

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        Try


            FillTemplateDataSet()
            ' SetDataGrid()

            If Page.IsPostBack = False Then
                Calendar1.Style.Add("display", "none")
                If Request.QueryString.Get("ACTION") = "ADD_NEW" Then
                    txtTemplateID.Text = "0"
                    m_Template_PK = System.Convert.ToInt32(txtTemplateID.Text)
                    LblTemplateSection.Text = "New Template"
                    RevisionDate.Visible = False
                    LblRevisionDate.Visible = False
                    imgCalander.Visible = False
                End If
                If Request.QueryString.Get("ACTION") = "MODIFY" Then
                    txtTemplateID.Text = Request.QueryString.Get("TemplateID_PK")
                    m_Template_PK = System.Convert.ToInt32(txtTemplateID.Text)
                    LblTemplateSection.Text = "Modify Template"
                    ShowRecord(GetCurrentRow(m_Template_PK))
                End If

            Else
                m_Template_PK = System.Convert.ToInt32(txtTemplateID.Text)
            End If

            ' If view Document is called 
            If Not IsNothing(Request.QueryString.Get("DocumentMode")) Then
                Dim MasterTagID As String = Request.QueryString.Get("MasterTagID").ToString()
                Dim RecordID As String = Request.QueryString.Get("RecordID").ToString()
                Dim ProjectID As String = Request.QueryString.Get("ProjectID").ToString()
                Dim DocumentMode As String = Request.QueryString.Get("DocumentMode").ToString()
                Dim strProjectServerURL As String

                'Dim objSharePointDocumentLibrary As New SharePointDocumentLibrary

                'If DocumentMode.ToUpper() = "DOWNLOAD" Then


                '    Dim UploadedFilesID As String = Request.QueryString.Get("UploadedFilesID").ToString()
                '    Dim UploadedFileGUID As String = Request.QueryString.Get("UploadedFileGUID").ToString()
                '    Dim DocumentLibraryGUID As String = Request.QueryString.Get("DocumentLibraryGUID").ToString()
                '    Dim StrFileName As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT FileName FROM tbl_SP_UploadedFiles WHERE UploadedFilesID= " + UploadedFilesID, blnUseSQL, strConnectionString), "")
                '    strProjectServerURL = WhizDocManagement.ProjectServerURL(MasterTagID, RecordID, ProjectID)
                '    WhizDocManagement.DownloadFile(DocumentLibraryGUID, UploadedFileGUID, StrFileName, strProjectServerURL)

                'ElseIf DocumentMode.ToUpper() = "DELETE" Then

                '    Dim UploadedFilesID As String = ""
                '    strProjectServerURL = WhizDocManagement.ProjectServerURL(MasterTagID, RecordID, ProjectID)

                '    If Not IsNothing(Request.Form("chkDocumentDelete")) Then
                '        UploadedFilesID = Request.Form("chkDocumentDelete").ToString
                '    End If

                '    If (UploadedFilesID <> "") Then
                '        WhizDocManagement.DeleteSharePointDocument(MasterTagID, RecordID, UploadedFilesID, strProjectServerURL)
                '    End If

                'End If
                'WhizTemplate.aspx?ACTION=MODIFY&PKID=0|TS&TemplateID_PK=1
                Response.Redirect("../QC/WhizTemplate.aspx?ACTION=MODIFY&PKID=0|TS&TemplateID_PK=" + txtTemplateID.Text)

            End If
        Catch ex As Exception
            'WhizDocManagement.ShowMessage(ex.Message + " " + ex.StackTrace, True)
        End Try
    End Sub 'Page_Load

    'Protected Sub DrawDocumentGrid()
    '    If txtTemplateID.Text <> "0" Then
    '        Dim objSharePointDocumentLibrary As New SharePointDocumentLibrary()
    '        objSharePointDocumentLibrary.DrawDocumentGrid(1041, txtTemplateID.Text, 0, "frmWhizTemplate", "../QC/WhizTemplate.aspx?ACTION=MODIFY&PKID=0|TS&TemplateID_PK=" + txtTemplateID.Text)
    '    End If
    'End Sub

    Protected Sub FillTemplateDataSet()
        ''=====================================================================
        '        ' Procedure Name        : FillTemplateDataSet
        '        ' Purpose               : To get the template details in a Dataset
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NitinVS
        '        ' Created               : Nov 22,2006
        '        ' Revisions             :
        '        '=====================================================================
        objDS = New DataSet()
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        ' Dim strSQL As String = "SELECT * FROM tbl_PRS_Templates "
        Dim strSQL As String = "usp_tbl_PRS_Templates "
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("TemplateID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey
    End Sub 'FillTemplateDataSet


    Protected Function GetCurrentRow(ByVal intTemplateID As Integer) As DataRow
        Dim dr As DataRow = Nothing

        Dim objDR1 As DataRow
        For Each objDR1 In objDS.Tables(0).Rows
            If System.Convert.ToInt32(objDR1("TemplateID")) = intTemplateID Then
                dr = objDR1
                Exit For
            End If
        Next objDR1
        Return dr
    End Function 'GetCurrentRow


    Protected Sub ShowRecord(ByVal dr As DataRow)

        'Set default values
        Dim strTitle As String = ""
        Dim strDescription As String = ""
        Dim strRevisionDate As DateTime = System.DateTime.Now
        'Get values
        If Not (dr("Name") Is Nothing) Then
            strTitle = System.Convert.ToString(dr("Name"))
        End If
        If Not (dr("Description") Is Nothing) Then
            strDescription = System.Convert.ToString(dr("Description"))
        End If
        If Not (dr("RevisionDate") Is Nothing) AndAlso CommonFunctions.Data.CheckIsDBNull(dr("RevisionDate"), "").ToString() <> "" Then
            strRevisionDate = System.Convert.ToDateTime(dr("RevisionDate"))
            RevisionDate.Text = strRevisionDate.ToShortDateString()
        End If

        txtTitle.Text = Server.HtmlDecode(System.Convert.ToString(strTitle))
        txtDescription.Text = Server.HtmlDecode(strDescription)
    End Sub 'ShowRecord



    Protected Sub UpdateRow(ByVal dr As DataRow)
        'Set default values
        Dim strTitle As String = ""
        Dim strDescription As String = ""
        Dim strRevisionDate As String = ""
        'Get values
        If Not (txtTitle.Text Is Nothing) AndAlso txtTitle.Text <> "" Then
            strTitle = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtTitle.Text.Trim(), ""))
        End If
        If Not (txtDescription.Text Is Nothing) AndAlso txtDescription.Text <> "" Then
            strDescription = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtDescription.Text.Trim(), ""))
        End If
        If Not (RevisionDate.Text Is Nothing) AndAlso RevisionDate.Text <> "" Then
            strRevisionDate = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(RevisionDate.Text.Trim(), ""))
        End If

        dr("Name") = Server.HtmlEncode(strTitle)
        dr("Description") = Server.HtmlEncode(strDescription)
        If strRevisionDate <> "" Then

            dr("RevisionDate") = strRevisionDate
        Else
            dr("RevisionDate") = DBNull.Value
        End If
    End Sub 'UpdateRow


    Protected Sub DuplicateOrdernumberValidation(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim strOrderNumber As String = System.Convert.ToString(args.Value)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "IF EXISTS( SELECT OrderNumber FROM tbl_PRS_Process_Draft WHERE OrderNumber = '" + strOrderNumber + "' and ProcessID <> '" + txtTemplateID.Text + "' ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_tbl_PRS_Process_Draft_OrderNumber '" + strOrderNumber + "','" + txtTemplateID.Text + "'"
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        Dim valueExists As Integer
        valueExists = System.Convert.ToInt64(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))

        If valueExists = 1 Then
            args.IsValid = False
            Response.Write("<script language=javascript>")
            Response.Write("alert(""'Order Number' already exists."")")
            Response.Write("</script>")
        End If

    End Sub 'DuplicateOrdernumberValidation

    'Int64 ValueExists;
    '        string strOrderNumber = System.Convert.ToString(args.Value);
    '        string strSQL = "IF EXISTS( SELECT OrderNumber FROM tbl_PRS_Process_Draft WHERE OrderNumber = '" + strOrderNumber + "' and ProcessID <> '" + txtProcessID.Text + "' ) SELECT 1 ELSE SELECT 0 ";
    '        //string strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
    '        ValueExists = System.Convert.ToInt64(CommonFunctions.Data.GetDataScalar(strSQL, true, strConnectionString));
    '        if (ValueExists == 1)
    '        {
    '            args.IsValid = false;
    '            Response.Write("<script language=javascript>");
    '            Response.Write("alert(\"'Order Number' already exists.\")");
    '            Response.Write("</script>");
    '        }

    Private Function GetTemplateID() As Integer
        Dim intReturnVal As Integer = 0
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "SELECT MAX(TemplateID) FROM tbl_PRS_Templates"
        Dim strSQL As String = "usp_tbl_PRS_Templates_TemplateID_Max"
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        objCon = New SqlConnection(strConnectionString)
        objCMD = New SqlCommand(strSQL, objCon)
        If objCon.State = ConnectionState.Closed Then
            objCon.Open()
        End If
        intReturnVal = System.Convert.ToInt32(objCMD.ExecuteScalar())
        If Not (objCMD Is Nothing) Then
            objCMD = Nothing
        End If
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
        If Not (objCon Is Nothing) Then
            objCon = Nothing
        End If
        Return intReturnVal
    End Function 'GetTemplateID

#Region "Control Events"


    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strPKID As String = Request.QueryString.Get("PKID")
        Response.Redirect(("WhizProcessDetails.aspx?PKID=" + strPKID))
    End Sub 'btnTopCancel_Click


    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid Then
            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'Dim strSQL As String = "SELECT * FROM Tbl_PRS_Templates "
            Dim strSQL As String = "usp_tbl_PRS_Templates "
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

            Dim oldTemplateName As String = ""
            Dim newTemplateName As String = ""

            Dim objCon As New SqlConnection(strConnectionString)
            objDA = New SqlDataAdapter(strSQL, objCon)
            Dim dr As DataRow = Nothing
            Dim objCmdBuilder As New SqlCommandBuilder(objDA)
            objCon = New SqlConnection(strConnectionString)
            Dim objPrimaryKey(0) As DataColumn
            objPrimaryKey(0) = objDS.Tables(0).Columns("TemplateID")
            objDS.Tables(0).PrimaryKey = objPrimaryKey
            objDS.Tables(0).Columns("TemplateID").AutoIncrement = True

            ' if new record add a row in dataset
            If txtTemplateID.Text = "0" Then
                dr = objDS.Tables(0).NewRow()
            Else
                dr = GetCurrentRow(m_Template_PK)
            End If

            oldTemplateName = dr("Name").ToString()

            UpdateRow(dr)

            newTemplateName = dr("Name").ToString()

            If txtTemplateID.Text = "0" Then
                objDS.Tables(0).Rows.Add(dr)
            End If

            objDA.Update(objDS)

            If txtTemplateID.Text = "0" Then
                m_Template_PK = GetTemplateID()

                Response.Write("<script type=""text/javascript"" language='javascript''>")
                'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|TS"";")
                Response.Write("</script>")
            End If
            txtTemplateID.Text = System.Convert.ToString(m_Template_PK)
            'ShowRecord(GetCorrectRow(m_Process_PK));
            If oldTemplateName <> newTemplateName Then
                Response.Write("<script type=""text/javascript"" language='javascript''>")
                'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|TS"";")
                Response.Write("</script>")
            End If

            If Not (objDA Is Nothing) Then
                objDA = Nothing
            End If
            If Not (dr Is Nothing) Then
                dr = Nothing
            End If
            If objCon.State = ConnectionState.Open Then
                objCon.Close()
            End If
        Else
        End If
    End Sub 'btnTopSave_Click

    Protected Sub Calendar1_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs)
        RevisionDate.Text = Calendar1.SelectedDate.ToShortDateString()
        Calendar1.Style.Add("display", "none")
    End Sub 'Calendar1_SelectionChanged

    Protected Sub Calendar1_VisibleMonthChanged(ByVal sender As Object, ByVal e As MonthChangedEventArgs)
        Calendar1.Style.Add("display", "inline")
    End Sub 'Calendar1_VisibleMonthChanged
#End Region




    Protected Sub CustomValidator2_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim dtRevisionDate As DateTime
        System.DateTime.TryParse(RevisionDate.Text, dtRevisionDate)
        If dtRevisionDate = System.DateTime.MinValue Then
            args.IsValid = False
        End If
    End Sub 'CustomValidator2_ServerValidate

    Protected Sub CustomValidator3_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "if Exists( SELECT Top 1 [Name] FROM Tbl_PRS_Templates WHERE [Name]= '" + CommonFunctions.General.BuildQueryString(args.Value) + "' and TemplateID <> " + txtTemplateID.Text + " ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_Tbl_PRS_Templates_Name '" + CommonFunctions.General.BuildQueryString(args.Value) + "'," + txtTemplateID.Text
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        Dim strTitle As String = ""
        strTitle = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString(), "").ToString()
        If strTitle <> "0" Then
            args.IsValid = False
        End If
    End Sub 'CustomValidator3_ServerValidate

End Class 'WhizTemplate