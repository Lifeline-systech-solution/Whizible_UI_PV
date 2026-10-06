
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



Partial Public Class WhizProcesses
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
    Private m_Process_PK As Integer
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        'Get records in Processs
        FillProcessDataSet()

        If Not (Request.QueryString("PROCESS_PK") Is Nothing) Then
            txtProcessID.Text = System.Convert.ToString(Request.QueryString("PROCESS_PK"))
        End If
        If txtProcessID.Text <> "0" Then
            m_Process_PK = System.Convert.ToInt32(txtProcessID.Text)
            LblProcessSection.Text = "Modify Process"
            If Page.IsPostBack = False Then
                ShowRecord(GetCorrectRow(m_Process_PK))
                FillDepartmentCombo()

                FillExistingOrderNumbers()
            End If
        Else
            If Page.IsPostBack = False Then
                txtRevisionNumber.Visible = False
                LblRevisionNumber.Visible = False
                LblProcessSection.Text = "New Process"
                FillDepartmentCombo()
            End If
        End If
    End Sub 'Page_Load


    Protected Sub FillProcessDataSet()
        objDS = New DataSet()
        Dim strSQL As String = "SELECT * FROM tbl_PRS_Process_Draft SELECT * FROM tbl_PM_DepartmentMaster"
        'strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("ProcessID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey
    End Sub 'FillProcessDataSet


    Protected Sub FillDepartmentCombo()
        cboDepartment.DataSource = objDS.Tables(1)
        cboDepartment.DataMember = objDS.Tables(1).TableName
        cboDepartment.DataValueField = objDS.Tables(1).Columns("DepartmentID").ColumnName
        cboDepartment.DataTextField = objDS.Tables(1).Columns("Department").ColumnName
        cboDepartment.DataBind()
    End Sub 'FillDepartmentCombo


    Protected Sub FillExistingOrderNumbers()
        Dim Dr As IDataReader

        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "SELECT OrderNumber FROM tbl_PRS_Process_Draft WHERE ProcessID <> '" + txtProcessID.Text + "' "
        Dim strSQL As String = "usp_sel_tbl_PRS_Process_Draft_OrderNumberNew '" + txtProcessID.Text + "' "
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
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




    Private Function GetProcessID() As Integer
        Dim intReturnVal As Integer = 0
        Dim strSQL As String = "SELECT MAX(ProcessID) FROM tbl_PRS_Process_Draft"
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
    End Function 'GetProcessID


    Protected Sub UpdateRow(ByVal dr As DataRow)
        'Set default values
        Dim intRevisionNo As Integer = 0
        Dim intOrderNo As Integer = 0
        Dim strProcessName As String = ""
        Dim strSEICMMKPA As String = ""
        Dim strISO9001CLAUSENO As String = ""
        Dim strDescription As String = ""
        Dim strEntryCriteria As String = ""
        Dim strExitCriteria As String = ""
        Dim strMeasurements As String = ""
        Dim intDepartmentID As Integer = 0
        Dim blnIsActive As Boolean = False
        Dim blnSDLCProcess As Boolean = False

        'Get values
        If Not (txtRevisionNumber.Text Is Nothing) AndAlso txtRevisionNumber.Text <> "" Then
            intRevisionNo = System.Convert.ToInt32(txtRevisionNumber.Text)
        End If
        If txtOrderNumber.Text <> "" Then
            intOrderNo = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(txtOrderNumber.Text, "0"))
        End If
        If Not (txtProcessName.Text Is Nothing) Then
            strProcessName = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtProcessName.Text.Trim(), ""))
        End If
        If Not (txtSEICMMKPA.Text Is Nothing) Then
            strSEICMMKPA = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtSEICMMKPA.Text.Trim(), ""))
        End If
        If Not (txtISO9001ClassNo.Text Is Nothing) Then
            strISO9001CLAUSENO = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtISO9001ClassNo.Text.Trim(), ""))
        End If
        If Not (txtDescription.Text Is Nothing) Then
            strDescription = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtDescription.Text.Trim(), ""))
        End If
        If Not (txtEntryCriteria.Text Is Nothing) Then
            strEntryCriteria = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtEntryCriteria.Text.Trim(), ""))
        End If
        If Not (txtExitCriteria.Text Is Nothing) Then
            strExitCriteria = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtExitCriteria.Text.Trim(), ""))
        End If
        If Not (txtMeasurementCriteria.Text Is Nothing) Then
            strMeasurements = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtMeasurementCriteria.Text.Trim(), ""))
        End If
        If Not (cboDepartment.SelectedValue Is Nothing) AndAlso cboDepartment.SelectedValue <> "" Then
            intDepartmentID = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(cboDepartment.SelectedValue, "0"))
        End If
        blnIsActive = System.Convert.ToBoolean(chkIsProcessActive.Checked)
        blnSDLCProcess = System.Convert.ToBoolean(chkIsSDLCProcess.Checked)


        dr("RevisionNo") = intRevisionNo
        dr("OrderNumber") = intOrderNo
        dr("ProcessName") = strProcessName
        dr("SEICMMKPA") = strSEICMMKPA
        dr("ISO9001ClauseNo") = strISO9001CLAUSENO
        dr("Description") = strDescription
        dr("EntryCriteria") = strEntryCriteria
        dr("ExitCriteria") = strExitCriteria
        dr("Measurements") = strMeasurements
        dr("DepartmentID") = intDepartmentID
        dr("IsActive") = blnIsActive
        dr("SDLCProcess") = blnSDLCProcess
    End Sub 'UpdateRow


    Protected Function GetCorrectRow(ByVal intProcessID As Integer) As DataRow
        Dim dr As DataRow = Nothing
        Dim objDR1 As DataRow
        For Each objDR1 In objDS.Tables(0).Rows
            If System.Convert.ToInt32(objDR1("ProcessID")) = intProcessID Then
                dr = objDR1
                Exit For
            End If
        Next objDR1
        Return dr
    End Function 'GetCorrectRow


    Protected Sub ShowRecord(ByVal dr As DataRow)

        'Set default values
        Dim intRevisionNo As Integer = 0
        Dim intOrderNo As Integer = 0
        Dim strProcessName As String = ""
        Dim strSEICMMKPA As String = ""
        Dim strISO9001CLAUSENO As String = ""
        Dim strDescription As String = ""
        Dim strEntryCriteria As String = ""
        Dim strExitCriteria As String = ""
        Dim strMeasurements As String = ""
        Dim intDepartmentID As Integer = 0
        Dim blnIsActive As Boolean = False
        Dim blnSDLCProcess As Boolean = False

        'Get values
        If Not (dr("RevisionNo") Is Nothing) Then
            intRevisionNo = System.Convert.ToInt32(dr("RevisionNo"))
        End If
        If Not (dr("OrderNumber") Is Nothing) Then
            intOrderNo = System.Convert.ToInt32(dr("OrderNumber"))
        End If
        If Not (dr("ProcessName") Is Nothing) Then
            strProcessName = System.Convert.ToString(dr("ProcessName"))
        End If
        If Not (dr("SEICMMKPA") Is Nothing) Then
            strSEICMMKPA = System.Convert.ToString(dr("SEICMMKPA"))
        End If
        If Not (dr("ISO9001ClauseNo") Is Nothing) Then
            strISO9001CLAUSENO = System.Convert.ToString(dr("ISO9001ClauseNo"))
        End If
        If Not (dr("Description") Is Nothing) Then
            strDescription = System.Convert.ToString(dr("Description"))
        End If
        If Not (dr("EntryCriteria") Is Nothing) Then
            strEntryCriteria = System.Convert.ToString(dr("EntryCriteria"))
        End If
        If Not (dr("ExitCriteria") Is Nothing) Then
            strExitCriteria = System.Convert.ToString(dr("ExitCriteria"))
        End If
        If Not (dr("Measurements") Is Nothing) Then
            strMeasurements = System.Convert.ToString(dr("Measurements"))
        End If
        If Not (dr("DepartmentID") Is Nothing) Then
            intDepartmentID = System.Convert.ToInt32(dr("DepartmentID"))
        End If
        If Not (dr("IsActive") Is Nothing) Then
            blnIsActive = System.Convert.ToBoolean(dr("IsActive"))
        End If
        If Not (dr("SDLCProcess") Is Nothing) Then
            blnSDLCProcess = System.Convert.ToBoolean(dr("SDLCProcess"))
        End If

        txtRevisionNumber.Text = System.Convert.ToString(intRevisionNo)
        txtOrderNumber.Text = System.Convert.ToString(intOrderNo)
        txtProcessName.Text = System.Convert.ToString(strProcessName)
        txtSEICMMKPA.Text = strSEICMMKPA
        txtISO9001ClassNo.Text = strISO9001CLAUSENO
        txtDescription.Text = strDescription
        txtEntryCriteria.Text = strEntryCriteria
        txtExitCriteria.Text = strExitCriteria
        txtMeasurementCriteria.Text = strMeasurements
        cboDepartment.SelectedValue = System.Convert.ToString(intDepartmentID)
        chkIsProcessActive.Checked = blnSDLCProcess
        chkIsSDLCProcess.Checked = blnSDLCProcess
    End Sub 'ShowRecord

#Region "Control Events"


    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("WhizProcessDetails.aspx?PKID=0|PS")
    End Sub 'btnTopCancel_Click


    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid Then

            Dim intProcessID As Integer = 0
            Dim strSQL As String = "SELECT * FROM tbl_PRS_Process_Draft"

            Dim oldProcessName As String = ""
            Dim newProcessName As String = ""


            Dim objCon As New SqlConnection(strConnectionString)
            objDA = New SqlDataAdapter(strSQL, objCon)
            Dim dr As DataRow = Nothing
            Dim objCmdBuilder As New SqlCommandBuilder(objDA)
            objCon = New SqlConnection(strConnectionString)
            Dim objPrimaryKey(0) As DataColumn
            objPrimaryKey(0) = objDS.Tables(0).Columns("ProcessID")
            objDS.Tables(0).PrimaryKey = objPrimaryKey
            objDS.Tables(0).Columns("ProcessID").AutoIncrement = True

            ' if new record add a row in dataset
            If txtProcessID.Text = "0" Then
                dr = objDS.Tables(0).NewRow()
            Else
                dr = GetCorrectRow(m_Process_PK)
            End If
            oldProcessName = dr("ProcessName").ToString()

            UpdateRow(dr)

            newProcessName = dr("ProcessName").ToString()

            If txtProcessID.Text = "0" Then
                objDS.Tables(0).Rows.Add(dr)
            End If

            objDA.Update(objDS)

            If txtProcessID.Text = "0" Then
                m_Process_PK = GetProcessID()
            End If
            txtProcessID.Text = System.Convert.ToString(m_Process_PK)

            If oldProcessName <> newProcessName Then
                Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
                'Response.Write((" window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;" + Environment.NewLine))
                Response.Write((" window.location.href = '../QC/WhizProcessDetails.aspx?PKID=0|PS';" + Environment.NewLine))
                Response.Write(" </script>")
            End If

            'Update the process status to draft 
            WhizProcessFunctions.SetProcessstatus(System.Convert.ToInt32(txtProcessID.Text), "D")

            'ShowRecord(GetCorrectRow(m_Process_PK));
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




    Protected Sub DuplicateOrdernumberValidation(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim ValueExists As Int64
        Dim strOrderNumber As String = System.Convert.ToString(args.Value)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "IF EXISTS( SELECT OrderNumber FROM tbl_PRS_Process_Draft WHERE OrderNumber = '" + strOrderNumber + "' and ProcessID <> '" + txtProcessID.Text + "' ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_sel_tbl_PRS_Process_Draft_OrderNumber '" + strOrderNumber + "','" + txtProcessID.Text + "'"
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'string strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        ValueExists = System.Convert.ToInt64(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))
        If ValueExists = 1 Then
            args.IsValid = False
            Response.Write("<script language=javascript>")
            Response.Write("alert(""'Order Number' already exists."")")
            Response.Write("</script>")
        End If
    End Sub 'DuplicateOrdernumberValidation


    Protected Sub ProcessName_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim strProcessName As String = System.Convert.ToString(args.Value)
        Dim ValueExists As Integer = 0

        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "IF EXISTS( SELECT ProcessName FROM tbl_PRS_Process_Draft WHERE ProcessName = '" + strProcessName + "' and ProcessID <> '" + txtProcessID.Text + "' ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_sel_tbl_PRS_Process_Draft_ProcessName '" + strProcessName + "','" + txtProcessID.Text + "'"
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'string strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        ValueExists = System.Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))
        If ValueExists = 1 Then
            args.IsValid = False
            Response.Write("<script language=javascript>")
            Response.Write("alert(""'Process Name' already exists."")")
            Response.Write("</script>")
        End If
    End Sub 'ProcessName_ServerValidate 
#End Region
End Class 'WhizProcesses 