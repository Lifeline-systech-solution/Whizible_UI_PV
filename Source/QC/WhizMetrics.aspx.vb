
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


Partial Public Class WhizMetrics
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
    
#Region "Private Variables"
    Private strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    'System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
    Private objDA As SqlDataAdapter = Nothing
    Private objDS As DataSet = Nothing
    Private objCon As SqlConnection = Nothing

    Private objCMD As SqlCommand = Nothing


#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        FillmetricDataSet()
        FillCombo()
        If Page.IsPostBack = False Then
            If Request.QueryString.Get("ACTION") = "ADD_NEW" Then
                txtMetricID.Text = "0"
                LblMetricSection.Text = "New Metric"
            ElseIf Request.QueryString.Get("ACTION") = "MODIFY" Then
                txtMetricID.Text = Request.QueryString.Get("MetricID_PK")
                LblMetricSection.Text = "Modify Metric"
                ShowRecord(GetCurrentRow(txtMetricID.Text.Trim()))
            End If
        Else
        End If
    End Sub 'Page_Load


    Private Function GetCurrentRow(ByVal strMetricID As String) As DataRow
        Dim dr As DataRow() = Nothing
        dr = objDS.Tables(0).Select(("MetricID = " + strMetricID))
        Return dr(0)
    End Function 'GetCurrentRow


    Protected Sub ShowRecord(ByVal dr As DataRow)

        'Set default values
        Dim strName As String = ""
        Dim strShortName As String = ""
        Dim strCategoryID As String = "0"
        Dim strAbove As String = ""
        Dim strBelow As String = ""
        Dim strUnitID As String = "0"
        Dim strDescription As String = ""
        Dim strGuidelines As String = ""
        Dim blnActive As [Boolean] = True
        Dim blnIsUpperGood As [Boolean] = True

        'Get values
        If Not (dr("Name") Is Nothing) Then
            strName = System.Convert.ToString(dr("Name"))
        End If
        If Not (dr("ShortName") Is Nothing) Then
            strShortName = System.Convert.ToString(dr("ShortName"))
        End If
        If Not (dr("CategoryID") Is Nothing) Then
            strCategoryID = System.Convert.ToString(dr("CategoryID"))
        End If
        If Not (dr("Above") Is Nothing) Then
            strAbove = System.Convert.ToString(dr("Above"))
        End If
        If Not (dr("Below") Is Nothing) Then
            strBelow = System.Convert.ToString(dr("Below"))
        End If
        If Not (dr("UnitID") Is Nothing) Then
            strUnitID = System.Convert.ToString(dr("UnitID"))
        End If
        If Not (dr("Description") Is Nothing) Then
            strDescription = System.Convert.ToString(dr("Description"))
        End If
        If Not (dr("Guidelines") Is Nothing) Then
            strGuidelines = System.Convert.ToString(dr("Guidelines"))
        End If
        If Not (dr("Active") Is Nothing) Then
            blnActive = System.Convert.ToBoolean(dr("Active"))
        End If
        If Not (dr("IsUpperGood") Is Nothing) Then
            blnIsUpperGood = System.Convert.ToBoolean(dr("IsUpperGood"))
        End If
        txtName.Text = strName
        txtShortName.Text = strShortName
        cboCategoryID.Text = strCategoryID
        txtAbove.Text = strAbove
        txtBelow.Text = strBelow
        cboUnitID.Text = strUnitID
        txtDescription.Text = strDescription
        txtGuidelines.Text = strGuidelines
        chkActive.Checked = blnActive
        chkIsUpperGood.Checked = blnIsUpperGood
    End Sub 'ShowRecord


    Private Sub FillmetricDataSet()
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
        Dim strSQL As String = "SELECT * FROM tbl_PRS_MetricMaster ORDER By [Name] SELECT * FROM tbl_PRS_MetricCategory  ORDER By [CategoryName] SELECT * FROM tbl_PRS_Units  ORDER By [UnitName]"

        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("MetricID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey
    End Sub 'FillmetricDataSet


    Private Sub FillCombo()
        cboCategoryID.DataSource = objDS.Tables(1)
        cboCategoryID.DataMember = objDS.Tables(1).TableName
        cboCategoryID.DataValueField = objDS.Tables(1).Columns("CategoryID").ColumnName
        cboCategoryID.DataTextField = objDS.Tables(1).Columns("CategoryName").ColumnName
        cboCategoryID.DataBind()

        cboUnitID.DataSource = objDS.Tables(2)
        cboUnitID.DataMember = objDS.Tables(2).TableName
        cboUnitID.DataValueField = objDS.Tables(2).Columns("UnitID").ColumnName
        cboUnitID.DataTextField = objDS.Tables(2).Columns("UnitName").ColumnName
        cboUnitID.DataBind()
    End Sub 'FillCombo



    Protected Sub UpdateRow(ByVal dr As DataRow)
        'Set default values
        Dim strName As String = ""
        Dim strShortName As String = ""
        Dim strCategoryID As String = "0"
        Dim strAbove As String = ""
        Dim strBelow As String = ""
        Dim strUnitID As String = "0"
        Dim strDescription As String = ""
        Dim strGuidelines As String = ""
        Dim blnActive As [Boolean] = True
        Dim blnIsUpperGood As [Boolean] = True
        'Get values
        If Not (txtName.Text Is Nothing) AndAlso txtName.Text <> "" Then
            strName = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtName.Text.Trim(), ""))
        End If
        If Not (txtShortName.Text Is Nothing) AndAlso txtShortName.Text <> "" Then
            strShortName = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtShortName.Text.Trim(), ""))
        End If
        If Not (cboCategoryID.Text Is Nothing) AndAlso cboCategoryID.Text <> "" Then
            strCategoryID = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cboCategoryID.Text.Trim(), ""))
        End If
        If Not (txtAbove.Text Is Nothing) AndAlso txtAbove.Text <> "" Then
            strAbove = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtAbove.Text.Trim(), ""))
        End If
        If Not (txtBelow.Text Is Nothing) AndAlso txtBelow.Text <> "" Then
            strBelow = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtBelow.Text.Trim(), ""))
        End If
        If Not (cboUnitID.Text Is Nothing) AndAlso cboUnitID.Text <> "" Then
            strUnitID = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cboUnitID.Text.Trim(), ""))
        End If
        If Not (txtDescription.Text Is Nothing) AndAlso txtDescription.Text <> "" Then
            strDescription = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtDescription.Text.Trim(), ""))
        End If
        If Not (txtGuidelines.Text Is Nothing) AndAlso txtGuidelines.Text <> "" Then
            strGuidelines = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtGuidelines.Text.Trim(), ""))
        End If

        blnActive = System.Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(chkActive.Checked, ""))


        blnIsUpperGood = System.Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(chkIsUpperGood.Checked, ""))


        dr("Name") = strName
        dr("ShortName") = strShortName
        dr("CategoryID") = strCategoryID
        dr("Above") = strAbove
        dr("Below") = strBelow
        dr("UnitID") = strUnitID
        dr("Guidelines") = strGuidelines
        dr("Description") = strDescription
        dr("Active") = blnActive
        dr("IsUpperGood") = blnIsUpperGood
    End Sub 'UpdateRow


    Private Function GetMetricID() As Integer
        Dim intReturnVal As Integer = 0
        Dim strSQL As String = "SELECT MAX(MetricID) FROM tbl_PRS_MetricMaster"

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
    End Function 'GetMetricID

#Region "Control Validations"

    Protected Sub MetricName_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "if Exists( SELECT Top 1 [Name] FROM tbl_PRS_MetricMaster WHERE [Name]= '" + CommonFunctions.General.BuildQueryString(args.Value) + "' and MetricID <> " + txtMetricID.Text + " ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_sel_tbl_PRS_MetricMaster_Name '" + CommonFunctions.General.BuildQueryString(args.Value) + "'," + txtMetricID.Text
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        Dim strTitle As String = ""
        strTitle = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString(), "").ToString()
        If strTitle <> "0" Then
            args.IsValid = False
            Response.Write("<script type=""text/javascript""  language=""javascript"">")
            Response.Write("alert(""Metric Name already Exists."");")
            Response.Write("</script>")
        End If
    End Sub 'MetricName_ServerValidate

    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBottomModify.Click
        If Page.IsValid Then

            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'Dim strSQL As String = "SELECT * FROM Tbl_PRS_MetricMaster "
            Dim strSQL As String = "usp_sel_Tbl_PRS_MetricMaster_New "
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
            Dim objCon As New SqlConnection(strConnectionString)
            objDA = New SqlDataAdapter(strSQL, objCon)
            Dim dr As DataRow = Nothing
            Dim objCmdBuilder As New SqlCommandBuilder(objDA)
            objCon = New SqlConnection(strConnectionString)
            Dim objPrimaryKey(0) As DataColumn
            objPrimaryKey(0) = objDS.Tables(0).Columns("MetricID")
            objDS.Tables(0).PrimaryKey = objPrimaryKey
            objDS.Tables(0).Columns("MetricID").AutoIncrement = True
            Dim oldMetricName As String = ""
            Dim NewMetricName As String = ""

            ' if new record add a row in dataset
            If txtMetricID.Text = "0" Then
                dr = objDS.Tables(0).NewRow()
            Else
                dr = GetCurrentRow(txtMetricID.Text)
            End If

            oldMetricName = dr("Name").ToString()

            UpdateRow(dr)

            NewMetricName = dr("Name").ToString()

            If txtMetricID.Text = "0" Then
                objDS.Tables(0).Rows.Add(dr)
            End If

            objDA.Update(objDS)

            If txtMetricID.Text = "0" Then
                txtMetricID.Text = GetMetricID().ToString()
                Response.Write("<script type=""text/javascript"" language='javascript''>")
                '  Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|MS"";")
                Response.Write("</script>")
            ElseIf oldMetricName.Equals(NewMetricName) = False Then
                Response.Write("<script type=""text/javascript"" language='javascript''>")
                'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|MS"";")
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




    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strPKID As String = Request.QueryString.Get("PKID")
        Response.Redirect(("WhizProcessDetails.aspx?PKID=" + strPKID))
    End Sub 'btnTopCancel_Click


    Protected Sub MetricShortName_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim strSQL As String = "if Exists( SELECT Top 1 [ShortName] FROM tbl_PRS_MetricMaster WHERE [ShortName]= '" + CommonFunctions.General.BuildQueryString(args.Value) + "' and MetricID <> " + txtMetricID.Text + " ) SELECT 1 ELSE SELECT 0 "
        Dim strTitle As String = ""
        strTitle = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString(), "").ToString()
        If strTitle <> "0" Then
            args.IsValid = False
            Response.Write("<script type=""text/javascript""  language=""javascript"">")
            Response.Write("alert(""Short Name already Exists."");")
            Response.Write("</script>")
        End If
    End Sub 'MetricShortName_ServerValidate 
#End Region
End Class 'WhizMetrics 