
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

Partial Public Class WhizActivityTailoringDaviation
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Private Variables"
    Private objDA As SqlDataAdapter = Nothing
    Private objDS As DataSet = Nothing
    Private objCon As SqlConnection = Nothing
    Private objCMD As SqlCommand = Nothing
    Dim objComBuid As SqlCommandBuilder
    Dim PrimaryKey(0) As DataColumn

    Private Shared strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    Private m_strProcessID As String = ""
    Private m_strActivityID As String = "0"
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016
        Try
            If Page.IsPostBack Then

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
                    'QC/WhizActivityTailoringDaviation.aspx?PKID=0|PS&FROMWHERE=PM&MODE=VIEW&ProcessID=3&ProjectID=2&ActivityID=13&singleProcesses=&SDLCID=479
                    Response.Redirect("../QC/WhizActivityTailoringDaviation.aspx?PKID=0|PS&FROMWHERE=PM&MODE=VIEW&ProcessID=" + txtProcessID.Text + "&ProjectID=" + txtProjectID.Text + "&ActivityID=" + txtActivityID.Text + "&SDLCID=" + txtSDLCID.Text)
                End If
            Else
                txtActivityID.Text = HttpContext.Current.Request.QueryString.Get("ActivityID").ToString()
                txtProcessID.Text = HttpContext.Current.Request.QueryString.Get("ProcessID").ToString()
                txtProjectID.Text = HttpContext.Current.Request.QueryString.Get("ProjectID").ToString()
                txtSDLCID.Text = HttpContext.Current.Request.QueryString.Get("SDLCID").ToString()
                FillDataSet()
                ShowDetails(GetCurrentRow(txtSDLCID.Text))

            End If



        Catch ex As Exception
            'WhizDocManagement.ShowMessage(ex.Message, True)
        End Try
    End Sub

    Protected Sub ShowDetails(ByVal dr As DataRow)
        Dim blnISRequired As Boolean = False
        Dim strReference As String = ""
        Dim strTailoring As String = ""
        Dim strDeviation As String = ""
        Dim blnISPerformed As Boolean = False
        Dim strTitle As String = ""
        Dim strScope As String = ""

        If Not (dr("Title") Is Nothing) Then
            strTitle = dr("Title").ToString()
        End If
        If Not (dr("Tailoring") Is Nothing) Then
            strTailoring = dr("Tailoring").ToString()
        End If
        If Not (dr("Deviation") Is Nothing) Then
            strDeviation = dr("Deviation").ToString()
        End If
        If Not (dr("Reference") Is Nothing) Then
            strReference = dr("Reference").ToString()
        End If
        If Not (dr("ISRequired") Is Nothing) Then
            blnISRequired = System.Convert.ToBoolean(dr("ISRequired"))
        End If
        If Not (dr("ISPerformed") Is Nothing) Then
            blnISPerformed = System.Convert.ToBoolean(dr("ISPerformed"))
        End If

        lblActivityName.Text = strTitle
        txtTailoring.Text = strTailoring
        txtDeviation.Text = strDeviation
        txtReference.Text = strReference
        ISPerformed.Checked = blnISPerformed
        ISRequired.Checked = blnISRequired

        FillListBox()
    End Sub

    Private Function GetCurrentRow(ByVal strSDLCID As String) As DataRow
        Dim dr As DataRow() = Nothing
        dr = objDS.Tables(0).Select(("SDLCID = " + strSDLCID))
        Return dr(0)
    End Function 'GetCurrentRow

    Private Sub FillDataSet()
        ''=====================================================================
        '        ' Procedure Name        : FillmetricDataSet
        '        ' Purpose               : To get the Metric details in a Dataset
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NitinVS
        '        ' Created               : Dec 1,2006
        '        ' Revisions             :
        '        '=====================================================================
        objDS = New DataSet()
        Dim strSQL As System.Text.StringBuilder = New System.Text.StringBuilder

        strSQL.Append("SELECT * FROM v_tbl_PRS_Project_SDLC WHERE ProjectID = ")
        strSQL.Append(txtProjectID.Text)
        strSQL.Append(" AND ProcessID = ")
        strSQL.Append(txtProcessID.Text)
        strSQL.Append(" and ActivityID = ")
        strSQL.Append(txtActivityID.Text)

        objDA = New SqlDataAdapter(strSQL.ToString(), strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("SDLCID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey
    End Sub 'FillDataSet

    Private Sub FillListBox()
        Dim strSQL As String = ""
        Dim strTempSQL As String = ""
        strSQL = "usp_VPM_Sel_Project_ActivityChecklist_Templates " + txtSDLCID.Text

        Dim objAvailableDS As New DataSet()
        Dim objAvailableDA As SqlDataAdapter = Nothing
        objCon = New SqlConnection(strConnectionString)
        'Get Available Checklists
        strTempSQL = strSQL + ",1,1"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDA.Fill(objAvailableDS)
        objAvailableDA = Nothing
        If Not (objAvailableDS.Tables Is Nothing) Then
            lstAvailableChecklists.DataSource = objAvailableDS
            lstAvailableChecklists.DataMember = objAvailableDS.Tables(0).TableName
            lstAvailableChecklists.DataValueField = objAvailableDS.Tables(0).Columns(0).ColumnName
            lstAvailableChecklists.DataTextField = objAvailableDS.Tables(0).Columns(1).ColumnName
            lstAvailableChecklists.DataBind()
        End If
        If Not (objAvailableDS Is Nothing) Then
            objAvailableDS = Nothing
        End If
        objAvailableDS = New DataSet()
        'Get selected Checklists
        strTempSQL = strSQL + ",1,0"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDA.Fill(objAvailableDS)
        objAvailableDA = Nothing
        If Not (objAvailableDS.Tables Is Nothing) Then
            lstSelectedChecklists.DataSource = objAvailableDS
            lstSelectedChecklists.DataMember = objAvailableDS.Tables(0).TableName
            lstSelectedChecklists.DataValueField = objAvailableDS.Tables(0).Columns(0).ColumnName
            lstSelectedChecklists.DataTextField = objAvailableDS.Tables(0).Columns(1).ColumnName
            lstSelectedChecklists.DataBind()
        End If
        If Not (objAvailableDS Is Nothing) Then
            objAvailableDS = Nothing
        End If
        objAvailableDS = New DataSet()
        ' get Available Templates
        strTempSQL = strSQL + ",2,1"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDA.Fill(objAvailableDS)
        objAvailableDA = Nothing
        If Not (objAvailableDS.Tables Is Nothing) Then
            lstAvailableTemplates.DataSource = objAvailableDS
            lstAvailableTemplates.DataMember = objAvailableDS.Tables(0).TableName
            lstAvailableTemplates.DataValueField = objAvailableDS.Tables(0).Columns(0).ColumnName
            lstAvailableTemplates.DataTextField = objAvailableDS.Tables(0).Columns(1).ColumnName
            lstAvailableTemplates.DataBind()
        End If
        If Not (objAvailableDS Is Nothing) Then
            objAvailableDS = Nothing
        End If
        objAvailableDS = New DataSet()

        ' get selected Templates
        strTempSQL = strSQL + ",2,0"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDA.Fill(objAvailableDS)
        objAvailableDA = Nothing
        If Not (objAvailableDS.Tables Is Nothing) Then
            lstSelectedTemplates.DataSource = objAvailableDS
            lstSelectedTemplates.DataMember = objAvailableDS.Tables(0).TableName
            lstSelectedTemplates.DataValueField = objAvailableDS.Tables(0).Columns(0).ColumnName
            lstSelectedTemplates.DataTextField = objAvailableDS.Tables(0).Columns(1).ColumnName
            lstSelectedTemplates.DataBind()
        End If
        If Not (objAvailableDS Is Nothing) Then
            objAvailableDS = Nothing
        End If

    End Sub

    Protected Sub synchronize_Checklists()
        ''=====================================================================
        '        ' Procedure Name        : synchronize_Checklists
        '        ' Purpose               : To synchronize Checklist in available and selected Checklist
        '                                  from client side to server control.
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NitinVS
        '        ' Created               : Nov 21,2006
        '        ' Revisions             :
        '        '=====================================================================
        Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedChecklists.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstAvailableChecklists.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'remove the ietms added to selected list from available list 
        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstAvailableChecklists.Items
            If lstSelectedChecklists.Items.IndexOf(objLSTITM) > -1 Then
                lstSelectedChecklists.Items.Remove(objLSTITM)
            End If
        Next objLSTITM


        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstAvailableChecklists.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstSelectedChecklists.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedChecklists.Items
            If lstAvailableChecklists.Items.IndexOf(objLSTITM) > -1 Then
                lstAvailableChecklists.Items.Remove(objLSTITM)
            End If
        Next objLSTITM
        lstAvailableChecklists.ClearSelection()
        lstSelectedChecklists.ClearSelection()
    End Sub 'synchronize_Checklists


    Protected Sub Synchronize_Templates()
        ''=====================================================================
        '        ' Procedure Name        : synchronize_Templates
        '        ' Purpose               : To synchronize Templates in available and selected templates 
        '                                  from client side to server control
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NitinVS
        '        ' Created               : Nov 21,2006
        '        ' Revisions             :
        '        '=====================================================================


        Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedTemplates.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstAvailableTemplates.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'remove the ietms added to selected list from available list 
        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstAvailableTemplates.Items
            If lstSelectedTemplates.Items.IndexOf(objLSTITM) > -1 Then
                lstSelectedTemplates.Items.Remove(objLSTITM)
            End If
        Next objLSTITM


        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstAvailableTemplates.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstSelectedTemplates.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedTemplates.Items
            If lstAvailableTemplates.Items.IndexOf(objLSTITM) > -1 Then
                lstAvailableTemplates.Items.Remove(objLSTITM)
            End If
        Next objLSTITM


        lstAvailableTemplates.ClearSelection()
        lstSelectedTemplates.ClearSelection()
    End Sub 'Synchronize_Templates

    Private Sub UpdateAssociatedChecklists()
        ''=====================================================================
        '        ' Procedure Name        : UpdateAssociatedChecklists
        '        ' Purpose               : To update mapped checklists to Activty 
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NiranjanK
        '        ' Created               : Nov 2,2006
        '        ' Revisions             :
        '        '=====================================================================

        Dim intRowCount As Integer = 0
        Dim strGTCSQL As System.Text.StringBuilder = New System.Text.StringBuilder
        strGTCSQL.Append("USP_VPM_INS_UPD_ProjectActivityChecklistAssociation ")
        strGTCSQL.Append(txtSDLCID.Text)
        strGTCSQL.Append(",")
        strGTCSQL.Append(txtProjectID.Text)
        strGTCSQL.Append(",")
        strGTCSQL.Append(txtProcessID.Text)
        strGTCSQL.Append(",")
        strGTCSQL.Append(txtActivityID.Text)

        Dim strAssociationID As String = ""
        Dim objCMD As New SqlCommand(strGTCSQL.ToString(), objCon)
        Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedChecklists.Items
            If intRowCount = 0 Then
                strAssociationID = System.Convert.ToString(objLSTITM.Value)
            Else
                strAssociationID = strAssociationID + "," + System.Convert.ToString(objLSTITM.Value)
            End If

            intRowCount = intRowCount + 1
        Next objLSTITM

        If strAssociationID.LastIndexOf(",") = strAssociationID.Length Then
            strAssociationID = strAssociationID.Substring(0, strAssociationID.Length - 2)
        End If

        strGTCSQL.Append(",'")
        strGTCSQL.Append(strAssociationID)
        strGTCSQL.Append("'")

        objCMD.CommandText = strGTCSQL.ToString()
        If objCon.State = ConnectionState.Closed Then
            objCon.Open()
        End If
        objCMD.ExecuteNonQuery()
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'UpdateAssociatedChecklists

    Private Sub UpdateAssociatedTemplates()
        ''=====================================================================
        '        ' Procedure Name        : UpdateAssociatedTemplates
        '        ' Purpose               : To update mapped Templates to Activty 
        '        ' Description           : 
        '        ' Parameters Passed     : 
        '        ' Returns               : NA
        '        ' Parameters Affected   : 
        '        ' Assumptions           : 
        '        ' Dependencies          : 
        '        ' Author                : NiranjanK
        '        ' Created               : Nov 2,2006
        '        ' Revisions             :
        '        '=====================================================================

        Dim intRowCount As Integer = 0
        Dim strGTCSQL As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strAssociationID As String = ""

        Dim objLSTITM As ListItem

        strGTCSQL.Append("USP_VPM_INS_UPD_ProjectActivityTemplateAssociation ")
        strGTCSQL.Append(txtSDLCID.Text)
        strGTCSQL.Append(",")
        strGTCSQL.Append(txtProjectID.Text)
        strGTCSQL.Append(",")
        strGTCSQL.Append(txtProcessID.Text)
        strGTCSQL.Append(",")
        strGTCSQL.Append(txtActivityID.Text)

        Dim objCMD As New SqlCommand(strGTCSQL.ToString(), objCon)

        For Each objLSTITM In lstSelectedTemplates.Items
            If intRowCount = 0 Then
                strAssociationID = System.Convert.ToString(objLSTITM.Value)
            Else
                strAssociationID = strAssociationID + "," + System.Convert.ToString(objLSTITM.Value)
            End If

            intRowCount = intRowCount + 1
        Next objLSTITM

        If strAssociationID.LastIndexOf(",") = strAssociationID.Length Then
            strAssociationID = strAssociationID.Substring(0, strAssociationID.Length - 2)
        End If

        strGTCSQL.Append(",'")
        strGTCSQL.Append(strAssociationID)
        strGTCSQL.Append("'")
        objCMD.CommandText = strGTCSQL.ToString()

        If objCon.State = ConnectionState.Closed Then
            objCon.Open()
        End If
        objCMD.ExecuteNonQuery()
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'UpdateAssociatedTemplates

    Private Sub UpdateTailoringDeviation()

        objDS = New DataSet()
        Dim strSQL As System.Text.StringBuilder = New System.Text.StringBuilder
        strSQL.Append("SELECT * FROM tbl_PRS_Project_SDLC WHERE ProjectID = ")
        strSQL.Append(txtProjectID.Text)
        strSQL.Append(" AND ProcessID = ")
        strSQL.Append(txtProcessID.Text)
        strSQL.Append(" and ActivityID = ")
        strSQL.Append(txtActivityID.Text)

        objDA = New SqlDataAdapter(strSQL.ToString(), strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("SDLCID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey

        Dim drUpdateRow As DataRow = objDS.Tables(0).Rows(0)
        Dim blnISRequired As Boolean = False
        Dim strReference As String = ""
        Dim strTailoring As String = ""
        Dim strDeviation As String = ""
        Dim blnISPerformed As Boolean = False
        Dim strTitle As String = ""
        Dim strScope As String = ""

        objCon = New SqlConnection(strConnectionString)

        objComBuid = New SqlCommandBuilder(objDA)
        objDS.Tables(0).Columns(0).AutoIncrement = True
        objDS.Tables(0).Columns(0).ReadOnly = True

        'set primary key
        PrimaryKey = New DataColumn(0) {}
        PrimaryKey(0) = objDS.Tables(0).Columns(0)
        objDS.Tables(0).PrimaryKey = PrimaryKey

        If (txtTailoring.Text <> "") Then
            strTailoring = txtTailoring.Text
        End If
        If (txtReference.Text <> "") Then
            strReference = txtReference.Text
        End If
        If (txtDeviation.Text <> "") Then
            strDeviation = txtDeviation.Text
        End If
        blnISRequired = ISRequired.Checked
        blnISPerformed = ISPerformed.Checked
        '
        drUpdateRow("Tailoring") = strTailoring
        drUpdateRow("Reference") = strReference
        drUpdateRow("Deviation") = strDeviation
        drUpdateRow("IsPerformed") = blnISPerformed
        drUpdateRow("IsRequired") = blnISRequired

        objDA.Update(objDS)

        'update Checklists , Templates

        UpdateAssociatedChecklists()
        UpdateAssociatedTemplates()
    End Sub

    'Protected Sub ShowAssociatedTemplates()
    '    If txtSDLCID.Text <> "0" Then
    '        Dim objSharePointDocumentLibrary As New SharePointDocumentLibrary()
    '        objSharePointDocumentLibrary.DrawDocumentGrid(2022, txtSDLCID.Text, txtProjectID.Text, "frmWhizActivityTailoring", "../QC/WhizActivityTailoringDaviation.aspx?PKID=0|PS&FROMWHERE=PM&MODE=VIEW&ProcessID=" + txtProcessID.Text + "&ActivityID=" + txtActivityID.Text + "&singleProcesses=&SDLCID=" + txtSDLCID.Text)
    '    End If
    'End Sub
#Region "Control Events"
    Protected Sub btnTopSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBottomModify.Click, btnTopSave.Click
        synchronize_Checklists()
        Synchronize_Templates()
        UpdateTailoringDeviation()

    End Sub

    Protected Sub btnBottomCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBottomCancel.Click, btnTopCancel.Click

        If Not Request.QueryString.Get("singleProcesses") <> "" Then
            Response.Redirect("../QC/WhizProcessDetails.aspx?PKID=0|PS&FromWhere=PM&MasterTagId=2132")
        Else
            Response.Redirect(("../QC/WhizProcessDetails.aspx?PKID=0|PS&FromWhere=PM&MasterTagId=2022&ProcessID=" + txtProcessID.Text))
        End If

    End Sub

#End Region
End Class