
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



Partial Public Class WhizGuidelines
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
    Private m_GuidelineID_PK As Integer
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        FillTemplateDataSet()

        If Page.IsPostBack = False Then

            If Request.QueryString.Get("ACTION") = "ADD_NEW" Then
                TxtGuidelineID.Text = "0"
                m_GuidelineID_PK = System.Convert.ToInt32(TxtGuidelineID.Text)
                LblGuidelineSection.Text = "New Guideline"
                LblRevisionNumber.Visible = False
                txtRevisionNumber.Visible = False
                imgRevisionNumber.Visible = False
                RequiredFieldValidator1.Visible = False
                RangeValidator1.Visible = False
            End If
            If Request.QueryString.Get("ACTION") = "MODIFY" Then
                TxtGuidelineID.Text = Request.QueryString.Get("GuidelineID_PK")
                m_GuidelineID_PK = System.Convert.ToInt32(TxtGuidelineID.Text)
                LblGuidelineSection.Text = "Modify Guideline"
                ShowRecord(GetCurrentRow(m_GuidelineID_PK))
            End If
        Else
            m_GuidelineID_PK = System.Convert.ToInt32(TxtGuidelineID.Text)
        End If
    End Sub 'Page_Load




    Protected Sub FillTemplateDataSet()
        ''=====================================================================
        '        ' Procedure Name        : FillTemplateDataSet
        '        ' Purpose               : To get the Guideline details in a Dataset
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
        Dim strSQL As String = "SELECT * FROM tbl_PRS_Guidelines "

        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("GuidelineID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey
    End Sub 'FillTemplateDataSet


    Protected Function GetCurrentRow(ByVal intGuidelineID As Integer) As DataRow
        Dim dr As DataRow = Nothing

        Dim objDR1 As DataRow()

        objDR1 = objDS.Tables(0).Select("GuidelineID = " + intGuidelineID.ToString())
        'For Each objDR1 In objDS.Tables(0).Rows
        '    If System.Convert.ToInt32(objDR1("GuidelineID")) = intGuidelineID Then
        '        dr = objDR1
        '        Exit For
        '    End If
        'Next objDR1
        dr = objDR1(0)
        Return dr
    End Function 'GetCurrentRow


    Protected Sub ShowRecord(ByVal dr As DataRow)

        'Set default values
        Dim strTitle As String = ""
        Dim strObjective As String = ""
        Dim strScope As String = ""
        Dim strRevisionNumber As String = ""
        Dim strGuidelineDetails As String = ""

        'Get values
        If Not (dr("Title") Is Nothing) Then
            strTitle = System.Convert.ToString(dr("Title"))
        End If
        If Not (dr("Objective") Is Nothing) Then
            strObjective = System.Convert.ToString(dr("Objective"))
        End If
        If Not (dr("Scope") Is Nothing) Then
            strScope = System.Convert.ToString(dr("Scope"))
        End If
        If Not (dr("RevisionNumber") Is Nothing) Then
            strRevisionNumber = System.Convert.ToString(dr("RevisionNumber"))
        End If
        If Not (dr("GuidelineDetails") Is Nothing) Then
            strGuidelineDetails = System.Convert.ToString(dr("GuidelineDetails"))
        End If

        txtTitle.Text = strTitle
        TxtObjective.Text = strObjective
        txtRevisionNumber.Text = strRevisionNumber
        txtScope.Text = strScope
        TxtGuidelineDetails.Text = strGuidelineDetails
    End Sub 'ShowRecord


    Protected Sub UpdateRow(ByVal dr As DataRow)

        'Set default values
        Dim strTitle As String = ""
        Dim strObjective As String = ""
        Dim strScope As String = ""
        Dim strRevisionNumber As String = ""
        Dim strGuidelineDetails As String = ""

        'Get values
        If Not (txtTitle.Text Is Nothing) AndAlso txtTitle.Text <> "" Then
            strTitle = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtTitle.Text.Trim(), ""))
        End If
        If Not (TxtObjective.Text Is Nothing) AndAlso TxtObjective.Text <> "" Then
            strObjective = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TxtObjective.Text.Trim(), ""))
        End If
        If Not (txtRevisionNumber.Text Is Nothing) AndAlso txtRevisionNumber.Text <> "" Then
            strRevisionNumber = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtRevisionNumber.Text.Trim(), ""))
        Else
            strRevisionNumber = "1"
        End If
        If Not (txtScope.Text Is Nothing) AndAlso txtScope.Text <> "" Then
            strScope = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtScope.Text.Trim(), ""))
        End If
        If Not (TxtGuidelineDetails.Text Is Nothing) AndAlso TxtGuidelineDetails.Text <> "" Then
            strGuidelineDetails = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TxtGuidelineDetails.Text.Trim(), ""))
        End If
        dr("Title") = strTitle
        dr("Objective") = strObjective
        dr("Scope") = strScope
        dr("RevisionNumber") = strRevisionNumber
        dr("GuidelineDetails") = strGuidelineDetails
    End Sub 'UpdateRow



    Private Function GetGuidelineID() As Integer
        Dim intReturnVal As Integer = 0
        Dim strSQL As String = "SELECT MAX(GuidelineID) FROM tbl_PRS_Guidelines"
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
    End Function 'GetGuidelineID
#Region "Control Events"

    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid Then
            Dim strSQL As String = "SELECT * FROM Tbl_PRS_Guidelines "
            'strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
            Dim objCon As New SqlConnection(strConnectionString)
            objDA = New SqlDataAdapter(strSQL, objCon)
            Dim dr As DataRow = Nothing
            Dim objCmdBuilder As New SqlCommandBuilder(objDA)
            objCon = New SqlConnection(strConnectionString)
            Dim objPrimaryKey(0) As DataColumn
            objPrimaryKey(0) = objDS.Tables(0).Columns("GuidelineID")
            objDS.Tables(0).PrimaryKey = objPrimaryKey
            objDS.Tables(0).Columns("GuidelineID").AutoIncrement = True

            ' if new record add a row in dataset
            If TxtGuidelineID.Text = "0" Then
                dr = objDS.Tables(0).NewRow()
            Else
                dr = GetCurrentRow(m_GuidelineID_PK)
            End If

            UpdateRow(dr)
            If TxtGuidelineID.Text = "0" Then
                objDS.Tables(0).Rows.Add(dr)
            End If

            objDA.Update(objDS)

            If TxtGuidelineID.Text = "0" Then
                m_GuidelineID_PK = GetGuidelineID()

                Response.Write("<script type=""text/javascript"" language='javascript''>")
                'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|GS"";")
                Response.Write("</script>")
            Else
                'Added By PrasadP For IssueID : 9935
                Response.Write("<script type=""text/javascript"" language='javascript''>")
                'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|GS"";")
                Response.Write("</script>")
                'End of Changes by PrasadP

            End If
            TxtGuidelineID.Text = System.Convert.ToString(m_GuidelineID_PK)
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


    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strPKID As String = Request.QueryString.Get("PKID")
        Response.Redirect(("WhizProcessDetails.aspx?PKID=" + strPKID))
    End Sub 'btnTopCancel_Click


    Protected Sub CustomValidator2_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim strSQL As String = "If Exists ( SELECT Top 1 [Title] FROM Tbl_PRS_Guidelines WHERE [Title]= '" + CommonFunctions.General.BuildQueryString(args.Value) + "' and GuidelineID <> " + TxtGuidelineID.Text + " ) SELECT 1 ELSE SELECT 0 "
        Dim strTitle As String = ""
        strTitle = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString), ""))
        If strTitle <> "0" Then
            args.IsValid = False
        End If
    End Sub 'CustomValidator2_ServerValidate

#End Region
End Class 'WhizGuidelines 