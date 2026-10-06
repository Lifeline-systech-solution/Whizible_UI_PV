
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



Partial Public Class WhizActivityTasks

    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Private variables"
    Private Shared strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    Private Const ACTION_SAVE As String = "SAVE"
    Private Const MODE_ADD As String = "ADD_NEW"
    Private Const MODE_MODIFY As String = "MODIFY"
    Protected m_strAction As String = ""
    Protected m_strActivityID As String = ""
    Protected m_strMode As String = ""
    Protected m_strActivityTaskID As String = "0"
    Protected m_strProcessID As String = "0"
    Protected m_strFromCL As String = ""

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        'add client side script to close link
        m_strMode = System.Convert.ToString(Request.QueryString("Mode"))
        If Not Request.QueryString("FromCL") Is Nothing Then
            m_strFromCL = Convert.ToString(Request.QueryString("FromCL"))
        Else
            m_strFromCL = Convert.ToString(Request.Form("txtFromCL"))
        End If

        m_strActivityID = System.Convert.ToString(Request.QueryString("ActivityID"))
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'm_strProcessID = CommonFunctions.Data.GetDataScalar("SELECT ProcessId FROM tbl_PRS_Activity_Draft WHERE ActivityID = " + m_strActivityID, blnUseSQL, strConnectionString).ToString()
        m_strProcessID = CommonFunctions.Data.GetDataScalar("usp_sel_Activity_tbl_PRS_Activity_Draft " + m_strActivityID, blnUseSQL, strConnectionString).ToString()
        ' txtMinHrs.Text = System.Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT Isnull(MinHoursForDAEntry ,0.25) FROM tbl_PM_companyInformation", blnUseSQL, strConnectionString))
        txtMinHrs.Text = System.Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_PM_tbl_PM_companyInformation", blnUseSQL, strConnectionString))

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        If Not (Request.QueryString("Action") Is Nothing) Then
            m_strAction = System.Convert.ToString(Request.QueryString("Action"))
        End If
        If Not (Request.QueryString("ActivityTaskID_PK") Is Nothing) Then
            m_strActivityTaskID = System.Convert.ToString(Request.QueryString("ActivityTaskID_PK"))
        End If
        If Page.IsPostBack = False AndAlso m_strActivityTaskID <> "0" Then
            ShowRecord()
        End If
        If m_strMode = MODE_MODIFY Then
            If m_strAction = ACTION_SAVE Then
                If IsDuplicateTaskName() = False Then
                    ModifyTask()
                End If
            End If
        Else
            If m_strAction = ACTION_SAVE Then
                If IsDuplicateTaskName() = False Then
                    SaveRecord()
                End If
            End If
        End If
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtFromCL", "txtFromCL", , , , m_strFromCL, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtFromCL", "txtFromCL", , , , m_strFromCL, , , , , , True, , True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
    End Sub 'Page_Load


    Protected Sub SaveRecord()
        If m_strMode = MODE_ADD Then
            AddNewTask()
        End If
    End Sub 'SaveRecord


    Private Sub ShowRecord()
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "SELECT * FROM tbl_PRS_Activity_Tasks_Draft WHERE ActivityTaskID = " + m_strActivityTaskID
        Dim strSQL As String = "usp_sel_tbl_PRS_Activity_Tasks_Draft_PRS " + m_strActivityTaskID

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


        'string strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        Dim objCon As New SqlConnection(strConnectionString)
        Dim objDS As New DataSet()
        Dim objDR As DataRow = Nothing
        Dim objSQLDA As New SqlDataAdapter(strSQL, objCon)
        Dim objSQLCBD As New SqlCommandBuilder(objSQLDA)
        objSQLDA.Fill(objDS)
        Dim objPrimaryKeys(0) As DataColumn
        objPrimaryKeys(0) = objDS.Tables(0).Columns("ActivityTaskID")
        'set primary key
        objDS.Tables(0).PrimaryKey = objPrimaryKeys
        'set auto increament
        objDS.Tables(0).Columns("ActivityTaskID").AutoIncrement = True
        objDR = objDS.Tables(0).Rows(0)
        If Not (objDR("TaskName") Is Nothing) Then
            txtTaskName.Text = System.Convert.ToString(objDR("TaskName"))
        End If
        If Not (objDR("Work") Is Nothing) Then
            txtDuration.Text = System.Convert.ToString(objDR("Work"))
        End If
        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'ShowRecord


    Protected Function IsDuplicateTaskName() As [Boolean]
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "if Exists( SELECT Top 1 [TaskName] FROM Tbl_PRS_Activity_Tasks_Draft WHERE [TaskName]= '" + CommonFunctions.General.BuildQueryString(txtTaskName.Text) + "' and ActivityTaskID <> " + m_strActivityTaskID + " ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_sel_Tbl_PRS_Activity_Tasks_Draft_TaskName '" + CommonFunctions.General.BuildQueryString(txtTaskName.Text) + "'," + m_strActivityTaskID

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


        Dim strResult As String = ""
        strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString(), "").ToString()
        If strResult = "1" Then
            CommonFunctions.General.WriteHTML("<script language='javascript' type='text/javascript'>")
            CommonFunctions.General.WriteHTML((" alert(""Task '" + CommonFunctions.General.BuildQueryString(txtTaskName.Text) + "' already exists."");"))
            CommonFunctions.General.WriteHTML("</script>")
            Return True
        End If
        Return False
    End Function 'IsDuplicateTaskName

    Private Sub ModifyTask()
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        ' Dim strSQL As String = "SELECT * FROM tbl_PRS_Activity_Tasks_Draft WHERE ActivityTaskID = " + m_strActivityTaskID
        Dim strSQL As String = "usp_sel_tbl_PRS_Activity_Tasks_Draft " + m_strActivityTaskID
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        'string strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        Dim objCon As New SqlConnection(strConnectionString)
        Dim objDS As New DataSet()
        Dim objDR As DataRow = Nothing
        Dim objSQLDA As New SqlDataAdapter(strSQL, objCon)
        Dim objSQLCBD As New SqlCommandBuilder(objSQLDA)
        objSQLDA.Fill(objDS)
        Dim objPrimaryKeys(0) As DataColumn
        objPrimaryKeys(0) = objDS.Tables(0).Columns("ActivityTaskID")
        'set primary key
        objDS.Tables(0).PrimaryKey = objPrimaryKeys
        'set auto increament
        objDS.Tables(0).Columns("ActivityTaskID").AutoIncrement = True
        objDR = objDS.Tables(0).Rows(0)
        UpdateRow(objDR)
        'set insert command 
        objSQLDA.UpdateCommand = objSQLCBD.GetUpdateCommand()
        objSQLDA.Update(objDS)


        ' as Discussed with Amit L Task edition will not trigger process revision 
        'WhizProcessFunctions.SetProcessActivityStatus(System.Convert.ToInt32(m_strActivityID), "D");
        'WhizProcessFunctions.SetProcessActivityStatus(System.Convert.ToInt32(m_strProcessID), "D");
        ' refresh parent page and tree node
        Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
        'Response.Write((" window.opener.parent.frames['infragisticsTree'].document.location.href = window.opener.parent.frames['infragisticsTree'].document.location.href;" + Environment.NewLine))
        'Response.Write((" window.opener.parent.frames['WhizVisualProcessGrid'].document.location.href = window.opener.parent.frames['WhizVisualProcessGrid'].document.location.href;" + Environment.NewLine))
        Response.Write("if(window.opener!=null) {" + Environment.NewLine)
        Response.Write((" window.opener.location.href=window.opener.location.href;" + Environment.NewLine))
        Response.Write("window.close(); }")
        Response.Write(" </script>")

        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'ModifyTask

    Private Sub AddNewTask()
        Dim strSQL As String = "SELECT * FROM tbl_PRS_Activity_Tasks_Draft WHERE ActivityID = " + m_strActivityID
        'string strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        Dim objCon As New SqlConnection(strConnectionString)
        Dim objDS As New DataSet()
        Dim objDR As DataRow = Nothing
        Dim objSQLDA As New SqlDataAdapter(strSQL, objCon)
        Dim objSQLCBD As New SqlCommandBuilder(objSQLDA)
        objSQLDA.Fill(objDS)
        Dim objPrimaryKeys As DataColumn()

        objDS.Tables(0).Columns("ActivityTaskID").AutoIncrement = True
        objDS.Tables(0).Columns("ActivityTaskID").ReadOnly = True
        'objDS.Tables(0).Columns("ActivityTaskID").AutoIncrementStep = 1
        'objDS.Tables(0).Columns("ActivityTaskID").AutoIncrementSeed = 1
        objPrimaryKeys = New DataColumn(0) {}
        objPrimaryKeys(0) = objDS.Tables(0).Columns("ActivityTaskID")

        'set primary key
        objDS.Tables(0).PrimaryKey = objPrimaryKeys
        'set auto increament
        'objDS.Tables(0).Columns("ActivityTaskID").AutoIncrement = True
        'objDS.Tables(0).Columns("ActivityTaskID").AutoIncrementStep = 1
        'objDS.Tables(0).Columns("ActivityTaskID").AutoIncrementSeed = 1
        objDR = objDS.Tables(0).NewRow()
        UpdateRow(objDR)
        objDS.Tables(0).Rows.Add(objDR)
        'set insert command 
        objSQLDA.InsertCommand = objSQLCBD.GetInsertCommand()
        objSQLDA.Update(objDS)

        ' Update the status of activity and process to draft 
        WhizProcessFunctions.SetProcessActivityStatus(System.Convert.ToInt32(m_strActivityID), "D")
        WhizProcessFunctions.SetProcessstatus(System.Convert.ToInt32(m_strProcessID), "D")

        ' refresh parent page and tree node
        Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
        'Response.Write((" window.opener.parent.frames['infragisticsTree'].document.location.href = window.opener.parent.frames['infragisticsTree'].document.location.href;" + Environment.NewLine))
        'Response.Write((" window.opener.parent.frames['WhizVisualProcessGrid'].document.location.href = window.opener.parent.frames['WhizVisualProcessGrid'].document.location.href;" + Environment.NewLine))
        Response.Write("if(window.opener!=null) {" + Environment.NewLine)
        Response.Write((" window.opener.location.href=window.opener.location.href;" + Environment.NewLine))
        Response.Write("window.close();}")
        Response.Write(" </script>")

        If objCon.State = ConnectionState.Open Then
            objCon.Close()
        End If
    End Sub 'AddNewTask

    Private Sub UpdateRow(ByVal dr As DataRow)
        Dim strTaskName As String = ""
        Dim dblDuration As Double = 0.0

        If Not (txtTaskName.Text Is Nothing) Then
            strTaskName = txtTaskName.Text.Trim()
        End If
        If Not (txtDuration.Text Is Nothing) Then
            dblDuration = System.Convert.ToDouble(txtDuration.Text)
        End If
        dr("TaskName") = strTaskName
        dr("Work") = dblDuration
        dr("ActivityID") = System.Convert.ToInt32(m_strActivityID)
        dr("ProcessID") = System.Convert.ToInt32(m_strProcessID)

    End Sub 'UpdateRow 
End Class 'WhizActivityTasks