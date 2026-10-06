
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



Partial Public Class WhizActivity
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Private Variables"
    Private objCon As SqlConnection = Nothing
    Private objComBuid As SqlCommandBuilder = Nothing
    Private objSqlDA As SqlDataAdapter = Nothing
    Private objDS As DataSet = Nothing
    Private primaryKey As DataColumn() = Nothing

    Private Shared strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    Private m_strProcessID As String = ""
    Private m_strActivityID As String = "0"
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        'lstAvailableGuidelines.Attributes.Add("onclick", "javascript:ShowCurrent('G','lstAvailableGuidelines')");
        'lstAvailableChecklists.Attributes.Add("onclick", "javascript:ShowCurrent('C','lstAvailableChecklists')");
        'lstAvailableTemplates.Attributes.Add("onclick", "javascript:ShowCurrent('T','lstAvailableTemplates')");
        Dim strSQL As String = "SELECT * FROM tbl_PRS_Activity_Draft WHERE "
        'strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        'process id is foreign key
        m_strProcessID = System.Convert.ToString(Request.QueryString("PROCESSID"))
        strSQL = strSQL + "ProcessID = " + m_strProcessID

        If Not (Request.QueryString("ACTIVITY_PK") Is Nothing) Then
            m_strActivityID = System.Convert.ToString(Request.QueryString("ACTIVITY_PK"))
            'set activity id
            txtActivityID.Text = m_strActivityID
            strSQL = strSQL + " AND ActivityID = " + m_strActivityID
        End If

        'fill dataset
        objDS = New DataSet()
        objCon = New SqlConnection(strConnectionString)
        objSqlDA = New SqlDataAdapter(strSQL, objCon)
        objSqlDA.Fill(objDS)
        objComBuid = New SqlCommandBuilder(objSqlDA)
        objDS.Tables(0).Columns(0).AutoIncrement = True
        objDS.Tables(0).Columns(0).ReadOnly = True

        'set primary key
        primaryKey = New DataColumn(0) {}
        primaryKey(0) = objDS.Tables(0).Columns(0)
        objDS.Tables(0).PrimaryKey = primaryKey

        If Page.IsPostBack = False Then
            If txtActivityID.Text <> "0" Then
                ShowActivityDetails()
            Else
                lblActivitySection.Text = "Add Activity"
            End If
            SubFillAvailable()
            FillExistingOrderNumbers()
        End If
    End Sub 'Page_Load


    Private Sub ShowActivityDetails()
        Dim drActivity As DataRow = objDS.Tables(0).Rows(0)
        Dim strActivityStageID As String = "0"
        Dim intActivityOrderNuber As Integer = 0
        Dim strActivityName As String = ""
        Dim strObjective As String = ""
        Dim strScope As String = ""
        Dim strInputCriteria As String = ""
        Dim strInputs As String = ""
        Dim strActivityDetails As String = ""
        Dim strExitCriteria As String = ""
        Dim blnFrequency As Boolean = False
        Dim blnIsActivity As Boolean = False

        '
        If Not (drActivity("ActivityStageID") Is Nothing) Then
            strActivityStageID = System.Convert.ToString(drActivity("ActivityStageID"))
        End If
        If Not (drActivity("Title") Is Nothing) Then
            strActivityName = System.Convert.ToString(drActivity("Title"))
        End If
        If Not (drActivity("Scope") Is Nothing) Then
            strScope = System.Convert.ToString(drActivity("Scope"))
        End If
        If Not (drActivity("Objective") Is Nothing) Then
            strObjective = System.Convert.ToString(drActivity("Objective"))
        End If
        If Not (drActivity("Description") Is Nothing) Then
            strActivityDetails = System.Convert.ToString(drActivity("Description"))
        End If
        If Not (drActivity("Inputs") Is Nothing) Then
            strInputs = System.Convert.ToString(drActivity("Inputs"))
        End If
        If Not (drActivity("Inputcriteria") Is Nothing) Then
            strInputCriteria = System.Convert.ToString(drActivity("Inputcriteria"))
        End If
        If Not (drActivity("ExitCriteria") Is Nothing) Then
            strExitCriteria = System.Convert.ToString(drActivity("ExitCriteria"))
        End If
        If Not (drActivity("ReviewActivity") Is Nothing) Then
            blnFrequency = System.Convert.ToBoolean(drActivity("ReviewActivity"))
        End If 'if (drActivity["Status"] != null)= System.Convert.ToString(drActivity["Status"]);
        'if (drActivity["RevisionId"] != null)= System.Convert.ToInt32(drActivity["RevisionId"]);
        'if (drActivity["RevisionNo"] != null)= System.Convert.ToInt32 (drActivity["RevisionNo"]);
        If Not (drActivity("IsActive") Is Nothing) Then
            blnIsActivity = System.Convert.ToBoolean(drActivity("IsActive"))
        End If
        If Not (drActivity("ActivityOrderNumber") Is Nothing) Then
            intActivityOrderNuber = System.Convert.ToInt32(drActivity("ActivityOrderNumber"))
        End If
        txtActivityStageID.Text = System.Convert.ToString(strActivityStageID)
        txtOrderNumber.Text = System.Convert.ToString(intActivityOrderNuber)
        txtActivityName.Text = strActivityName
        txtObjective.Text = strObjective
        txtScope.Text = strScope
        txtInputCriteria.Text = strInputCriteria
        txtInputs.Text = strInputs
        txtActivityDetails.Text = strActivityDetails
        txtExitCriteria.Text = strExitCriteria
        chkDoesThisActivityGetReviewedFrequently.Checked = blnFrequency
        chkIsActive.Checked = blnIsActivity
    End Sub 'ShowActivityDetails


    Protected Sub FillExistingOrderNumbers()
        Dim Dr As IDataReader
        'Added And Commented By Dipali Vekhande On 8th Aug 2016 For Removing InLine Query
        ' Dim strSQL As String = "SELECT ActivityOrderNumber FROM tbl_PRS_Activity_Draft WHERE ActivityID <> '" + txtActivityID.Text + "'  and ProcessID = (SELECT ProcessID FROM Tbl_PRS_Activity_Draft WHERE ActivityID = " + txtActivityID.Text + ")"
        Dim strSQL As String = "usp_sel_tbl_PRS_Activity_Draft_ActivityOrderNumber '" + txtActivityID.Text + "'"
        'End of Addition And Commented By Dipali Vekhande On 8th Aug 2016 For Removing InLine Query
        Dim objDr As New CommonFunctions.Data.WAF_DataReader()
        objDr.ConnectionString = strConnectionString

        Dr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, objDr)
        txtExistingOrderNumbers.Text = ","
        While Dr.Read() = True
            txtExistingOrderNumbers.Text += System.Convert.ToString(Dr.GetValue(0)) + ","
        End While

        CommonFunctions.Data.DisposeDataReader(Dr)
        objDr = Nothing
    End Sub 'FillExistingOrderNumbers


    Private Sub SubFillAvailable()
        Dim strSQL As String = ""
        Dim strTempSQL As String = ""
        strSQL = "USP_VPM_SEL_Activity_GuideLines " + m_strActivityID

        Dim objAvailableDS As New DataSet()
        Dim objAvailableDA As SqlDataAdapter = Nothing
        'Get Associated Guidelines
        strTempSQL = strSQL + ",0,1"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDA.Fill(objAvailableDS)
        objAvailableDA = Nothing
        If Not (objAvailableDS.Tables Is Nothing) Then
            lstAvailableGuidelines.DataSource = objAvailableDS
            lstAvailableGuidelines.DataMember = objAvailableDS.Tables(0).TableName
            lstAvailableGuidelines.DataValueField = objAvailableDS.Tables(0).Columns(0).ColumnName
            lstAvailableGuidelines.DataTextField = objAvailableDS.Tables(0).Columns(1).ColumnName
            lstAvailableGuidelines.DataBind()
        End If
        If Not (objAvailableDS Is Nothing) Then
            objAvailableDS = Nothing
        End If
        objAvailableDS = New DataSet()
        'Get unassociated Guidelines
        strTempSQL = strSQL + ",1,1"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDS = New DataSet()
        objAvailableDA.Fill(objAvailableDS)
        objAvailableDA = Nothing
        If Not (objAvailableDS.Tables Is Nothing) Then
            lstSelectedGuidelines.DataSource = objAvailableDS
            lstSelectedGuidelines.DataMember = objAvailableDS.Tables(0).TableName
            lstSelectedGuidelines.DataValueField = objAvailableDS.Tables(0).Columns(0).ColumnName
            lstSelectedGuidelines.DataTextField = objAvailableDS.Tables(0).Columns(1).ColumnName
            lstSelectedGuidelines.DataBind()
        End If
        If Not (objAvailableDS Is Nothing) Then
            objAvailableDS = Nothing
        End If
        objAvailableDS = New DataSet()
        'Get Associated Checklists
        strTempSQL = strSQL + ",0,2"
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
        'Get unassociated Checklists
        strTempSQL = strSQL + ",1,2"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDS = New DataSet()
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
        'Get Associated Templates
        strTempSQL = strSQL + ",0,3"
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
        'Get unassociated Templates
        strTempSQL = strSQL + ",1,3"
        objAvailableDA = New SqlDataAdapter(strTempSQL, objCon)
        objAvailableDS = New DataSet()
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
        objAvailableDS = New DataSet()
    End Sub 'SubFillAvailable



    Private Function GetActivityDataRow() As DataRow
        Dim returnDR As DataRow
        Dim strFilterQuery As String = "ActivityID = " + System.Convert.ToString(txtActivityID.Text)
        returnDR = objDS.Tables(0).Rows.Find(strFilterQuery)
        Return returnDR
    End Function 'GetActivityDataRow




    Private Sub AddActivityRow()
        Dim drAddRow As DataRow = objDS.Tables(0).NewRow()
        Dim intActivityStageID As String = "0"
        Dim intActivityOrderNuber As Integer = 0
        Dim strActivityName As String = ""
        Dim strObjective As String = ""
        Dim strScope As String = ""
        Dim strInputCriteria As String = ""
        Dim strInputs As String = ""
        Dim strActivityDetails As String = ""
        Dim strExitCriteria As String = ""
        Dim blnFrequency As Boolean = False
        Dim blnIsActivity As Boolean = False

        If Not (txtActivityStageID.Text Is Nothing) Then
            intActivityStageID = System.Convert.ToString(txtActivityStageID.Text)
        End If
        If Not (txtOrderNumber.Text Is Nothing) Then
            intActivityOrderNuber = System.Convert.ToInt32(txtOrderNumber.Text)
        End If
        If Not (txtActivityName.Text Is Nothing) Then
            strActivityName = System.Convert.ToString(txtActivityName.Text)
        End If
        If Not (txtObjective.Text Is Nothing) Then
            strObjective = System.Convert.ToString(txtObjective.Text)
        End If
        If Not (txtScope.Text Is Nothing) Then
            strScope = System.Convert.ToString(txtScope.Text)
        End If
        If Not (txtInputCriteria.Text Is Nothing) Then
            strInputCriteria = System.Convert.ToString(txtInputCriteria.Text)
        End If
        If Not (txtInputs.Text Is Nothing) Then
            strInputs = System.Convert.ToString(txtInputs.Text)
        End If
        If Not (txtActivityDetails.Text Is Nothing) Then
            strActivityDetails = System.Convert.ToString(txtActivityDetails.Text)
        End If
        If Not (txtExitCriteria.Text Is Nothing) Then
            strExitCriteria = System.Convert.ToString(txtExitCriteria.Text)
        End If
        blnFrequency = chkDoesThisActivityGetReviewedFrequently.Checked
        blnIsActivity = chkIsActive.Checked

        '
        drAddRow("ActivityStageID") = intActivityStageID
        drAddRow("Title") = strActivityName
        drAddRow("Scope") = strScope
        drAddRow("ProcessID") = System.Convert.ToUInt32(m_strProcessID)
        drAddRow("Objective") = strObjective
        drAddRow("Description") = strActivityDetails
        drAddRow("Inputs") = strInputs
        drAddRow("Inputcriteria") = strInputCriteria
        drAddRow("ExitCriteria") = strExitCriteria
        drAddRow("ReviewActivity") = blnFrequency
        drAddRow("IsActive") = blnIsActivity
        drAddRow("ActivityOrderNumber") = intActivityOrderNuber

        objDS.Tables(0).Rows.Add(drAddRow)
    End Sub 'AddActivityRow


    Private Sub SetNewID()
        'Added And Commented By Dipali V On 8th Aug 2016 For Remove InLine Query
        'Dim objTempCMD As New SqlCommand("SELECT MAX(ActivityID) FROM tbl_PRS_Activity_Draft WHERE ProcessID=" + m_strProcessID, objCon)
        Dim objTempCMD As New SqlCommand("usp_sel_tbl_PRS_Activity_Draft " + m_strProcessID, objCon)
        'End Of Addition And Commented By Dipali V On 8th Aug 2016 For Remove InLine Query
        If objCon.State = ConnectionState.Closed Then
            objCon.Open()
        End If
        txtActivityID.Text = System.Convert.ToString(objTempCMD.ExecuteScalar())
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'SetNewID

    Private Sub UpdateActivityRow()
        Dim drUpdateRow As DataRow = objDS.Tables(0).Rows(0)
        Dim strActivityStageID As String = "0"
        Dim intActivityOrderNuber As Integer = 0
        Dim strActivityName As String = ""
        Dim strObjective As String = ""
        Dim strScope As String = ""
        Dim strInputCriteria As String = ""
        Dim strInputs As String = ""
        Dim strActivityDetails As String = ""
        Dim strExitCriteria As String = ""
        Dim blnFrequency As Boolean = False
        Dim blnIsActivity As Boolean = False

        If Not (txtActivityStageID.Text Is Nothing) Then
            strActivityStageID = System.Convert.ToString(txtActivityStageID.Text)
        End If
        If Not (txtOrderNumber.Text Is Nothing) Then
            intActivityOrderNuber = System.Convert.ToInt32(txtOrderNumber.Text)
        End If
        If Not (txtActivityName.Text Is Nothing) Then
            strActivityName = System.Convert.ToString(txtActivityName.Text)
        End If
        If Not (txtObjective.Text Is Nothing) Then
            strObjective = System.Convert.ToString(txtObjective.Text)
        End If
        If Not (txtScope.Text Is Nothing) Then
            strScope = System.Convert.ToString(txtScope.Text)
        End If
        If Not (txtInputCriteria.Text Is Nothing) Then
            strInputCriteria = System.Convert.ToString(txtInputCriteria.Text)
        End If
        If Not (txtInputs.Text Is Nothing) Then
            strInputs = System.Convert.ToString(txtInputs.Text)
        End If
        If Not (txtActivityDetails.Text Is Nothing) Then
            strActivityDetails = System.Convert.ToString(txtActivityDetails.Text)
        End If
        If Not (txtExitCriteria.Text Is Nothing) Then
            strExitCriteria = System.Convert.ToString(txtExitCriteria.Text)
        End If
        blnFrequency = chkDoesThisActivityGetReviewedFrequently.Checked
        blnIsActivity = chkIsActive.Checked

        '
        drUpdateRow("ActivityStageID") = strActivityStageID
        drUpdateRow("Title") = strActivityName
        drUpdateRow("Scope") = strScope
        drUpdateRow("Objective") = strObjective
        drUpdateRow("Description") = strActivityDetails
        drUpdateRow("Inputs") = strInputs
        drUpdateRow("Inputcriteria") = strInputCriteria
        drUpdateRow("ExitCriteria") = strExitCriteria
        drUpdateRow("ReviewActivity") = blnFrequency
        drUpdateRow("IsActive") = blnIsActivity
        drUpdateRow("ActivityOrderNumber") = intActivityOrderNuber

        'update Guide lines , Checklists , Templates
        UpdateAssociatedGuidelines()
        UpdateAssociatedChecklists()
        UpdateAssociatedTemplates()
    End Sub 'UpdateActivityRow


    Private Sub UpdateAssociatedGuidelines()
        ''=====================================================================
        '        ' Procedure Name        : UpdateAssociatedGuidelines
        '        ' Purpose               : To update mapped guidelines to Activity
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
        Dim strGTCSQL As String = "USP_VPM_INS_UPD_ActivityAssociation " + m_strActivityID + "," + m_strProcessID + ", 1 "
        Dim strAssociationID As String = ""
        Dim objCMD As New SqlCommand(strGTCSQL, objCon)

        Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedGuidelines.Items
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

        strGTCSQL = strGTCSQL + ",'" + strAssociationID + "'"
        objCMD.CommandText = strGTCSQL
        If objCon.State = ConnectionState.Closed Then
            objCon.Open()
        End If
        objCMD.ExecuteNonQuery()
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'UpdateAssociatedGuidelines


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
        Dim strGTCSQL As String = "USP_VPM_INS_UPD_ActivityAssociation " + m_strActivityID + "," + m_strProcessID + ", 2 "
        Dim strAssociationID As String = ""
        Dim objCMD As New SqlCommand(strGTCSQL, objCon)
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

        strGTCSQL = strGTCSQL + ",'" + strAssociationID + "'"
        objCMD.CommandText = strGTCSQL
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
        Dim strGTCSQL As String = "USP_VPM_INS_UPD_ActivityAssociation " + m_strActivityID + "," + m_strProcessID + ", 3 "
        Dim strAssociationID As String = ""
        Dim objCMD As New SqlCommand(strGTCSQL, objCon)
        Dim objLSTITM As ListItem
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

        strGTCSQL = strGTCSQL + ",'" + strAssociationID + "'"
        objCMD.CommandText = strGTCSQL
        If objCon.State = ConnectionState.Closed Then
            objCon.Open()
        End If
        objCMD.ExecuteNonQuery()
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'UpdateAssociatedTemplates

    Protected Sub Synchronize_Guidelines()
        ''=====================================================================
        '        ' Procedure Name        : Synchronize_Guidelines
        '        ' Purpose               : To synchronize Guidelines in available and selected Guidelines
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
        For Each objLSTITM In lstSelectedGuidelines.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstAvailableGuidelines.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'remove the ietms added to selected list from available list 
        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstAvailableGuidelines.Items
            If lstSelectedGuidelines.Items.IndexOf(objLSTITM) > -1 Then
                lstSelectedGuidelines.Items.Remove(objLSTITM)
            End If
        Next objLSTITM


        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstAvailableGuidelines.Items
            If objLSTITM.Selected = False Then
                objLSTITM.Selected = True
                lstSelectedGuidelines.Items.Add(objLSTITM)
            End If
        Next objLSTITM

        'Dim objLSTITM As ListItem
        For Each objLSTITM In lstSelectedGuidelines.Items
            If lstAvailableGuidelines.Items.IndexOf(objLSTITM) > -1 Then
                lstAvailableGuidelines.Items.Remove(objLSTITM)
            End If
        Next objLSTITM

        lstAvailableGuidelines.ClearSelection()
        lstSelectedGuidelines.ClearSelection()
    End Sub 'Synchronize_Guidelines


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


#Region "control Events"

    Protected Sub btnBottomCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect(("WhizProcessDetails.aspx?PKID=1|P|" + m_strProcessID))
    End Sub 'btnBottomCancel_Click

    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        'addd mode
        'Synchronize Guidelines 
        Synchronize_Guidelines()
        synchronize_Checklists()
        Synchronize_Templates()

        If txtActivityID.Text = "0" Then
            AddActivityRow()
            objSqlDA.Update(objDS)
            SetNewID()
            'update Guide lines 
            UpdateAssociatedGuidelines()
            UpdateAssociatedChecklists()
            UpdateAssociatedTemplates()
            WhizProcessFunctions.SetProcessActivityStatus(System.Convert.ToInt32(txtActivityID.Text), "D")
            WhizProcessFunctions.SetProcessstatus(System.Convert.ToInt32(m_strProcessID), "D")
            Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
            Response.Write(" var openerlocation = window.location.href; ")
            Response.Write(" if(openerlocation != null )")
            Response.Write((" {" + Environment.NewLine))
            'Response.Write((" window.parent.frames['WhizVisualProcessGrid'].document.location.href =""WhizProcessDetails.aspx?PKID=1|P|" + m_strProcessID + """" + Environment.NewLine))
            Response.Write((" window.location.href =""WhizProcessDetails.aspx?PKID=1|P|" + m_strProcessID + """" + Environment.NewLine))
            ' Response.Write((" window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;" + Environment.NewLine))
            Response.Write(" }")
            Response.Write(" </script>")
        Else
            Dim oldActivityName As String = ""
            Dim newActivityName As String = ""

            oldActivityName = objDS.Tables(0).Rows(0)("Title").ToString()

            UpdateActivityRow()

            newActivityName = objDS.Tables(0).Rows(0)("Title").ToString()

            'If oldActivityName <> newActivityName Then
            '    Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
            '    Response.Write((" window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;" + Environment.NewLine))
            '    Response.Write(" </script>")
            'End If

            objSqlDA.Update(objDS)
            WhizProcessFunctions.SetProcessActivityStatus(System.Convert.ToInt32(txtActivityID.Text), "D")
            WhizProcessFunctions.SetProcessstatus(System.Convert.ToInt32(m_strProcessID), "D")
        End If
    End Sub 'btnTopSave_Click

#End Region
End Class 'WhizActivity 
