
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


Partial Public Class WhizEditQuestion
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
    
#Region "Variables"
    Private strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016


        If Page.IsPostBack = False Then
            TxtQuestionnaireQuestionID.Text = Request.QueryString.Get("QuestionnaireQuestionID_PK")
            txtQuetionnaireID.Text = Request.QueryString.Get("QuestionnaireID")

            If Request.QueryString.Get("MODE").ToString() = "MODIFY" Then
                ShowRecord()
            End If
        Else
        End If
    End Sub 'Page_Load


    Protected Sub ShowRecord()
        Dim objDR As IDataReader
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        Dim strSQL As String = "usp_VPM_Sel_Questionnaire_Questions " + txtQuetionnaireID.Text + ", Null , " + TxtQuestionnaireQuestionID.Text
        WAF_objDR.ConnectionString = strConnectionString

        objDR = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, WAF_objDR)
        If objDR.Read() Then
            txtQuestionDescription.Text = objDR("QuestionDescription").ToString()
            txtOrderNo.Text = objDR("OrderNo").ToString()
            txtNote.Text = objDR("Note").ToString()
            If System.Convert.ToBoolean(objDR("Compulsory")) = True Then
                chkCompulsory.Checked = True
            End If
            FillCauseCombo(objDR("CReviewCauseID").ToString())
        End If
        CommonFunction.Data.DisposeDataReader(objDR)
    End Sub 'ShowRecord


    Protected Sub FillCauseCombo(ByVal CReviewCauseID As String)

        Dim objDA As SqlDataAdapter = Nothing
        Dim objDS As New DataSet()
        Dim strSQL As String = "SELECT CReviewCauseID ,CReviewCause FROM   tbl_PM_CorporateReviewCauses Order by CReviewCause"

        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("CReviewCauseID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey

        cboCReviewCauseID.DataSource = objDS.Tables(0)
        cboCReviewCauseID.DataMember = objDS.Tables(0).TableName
        cboCReviewCauseID.DataValueField = objDS.Tables(0).Columns("CReviewCauseID").ColumnName
        cboCReviewCauseID.DataTextField = objDS.Tables(0).Columns("CReviewCause").ColumnName
        If CReviewCauseID <> "0" AndAlso Not (CReviewCauseID Is Nothing) Then
            cboCReviewCauseID.SelectedValue = CReviewCauseID
        End If
        cboCReviewCauseID.DataBind()

        objDA = Nothing
        objDS.Dispose()
    End Sub 'FillCauseCombo


    Protected Sub SaveData()
        Dim sbSQL As New System.Text.StringBuilder()
        sbSQL.Append("usp_VPM_UPD_Tbl_Q_QuestionnaireQuestion ")
        sbSQL.Append(TxtQuestionnaireQuestionID.Text)
        sbSQL.Append(",N'")
        sbSQL.Append(CommonFunction.General.BuildQueryString(txtQuestionDescription.Text))
        sbSQL.Append("',")

        If chkCompulsory.Checked = True Then
            sbSQL.Append("1,'")
        Else
            sbSQL.Append("0,'")
        End If
        sbSQL.Append(txtOrderNo.Text)
        sbSQL.Append("',")

        If cboCReviewCauseID.Text <> "" Then
            sbSQL.Append(cboCReviewCauseID.SelectedValue)
        Else
            sbSQL.Append("0")
        End If
        sbSQL.Append(",N'")
        If txtNote.Text.Length > 4000 Then
            txtNote.Text = txtNote.Text.Substring(0, 4000)
        End If
        sbSQL.Append(CommonFunction.General.BuildQueryString(txtNote.Text))
        sbSQL.Append("' ")

        CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString(), blnUseSQL, strConnectionString)

        sbSQL = Nothing
    End Sub 'SaveData 
#Region "control Events"


    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid = True Then
            SaveData()
        End If
    End Sub 'btnTopSave_Click

    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strPKID As String = Request.QueryString.Get("QuestionnaireID")
        Response.Redirect(("WhizCheckList.aspx?ACTION=MODIFY&PKID=0|CS&QuestionnaireID_PK=" + strPKID))
    End Sub 'btnTopCancel_Click


    Protected Sub DuplicateOrdernumber_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)

        'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "if Exists( SELECT Top 1 [OrderNo] FROM tbl_Q_QuestionnaireQuestion WHERE [OrderNo]= '" + CommonFunctions.General.BuildQueryString(args.Value) + "' and QuestionnaireQuestionID <> " + TxtQuestionnaireQuestionID.Text + "  AND QuestionnaireID = " + txtQuetionnaireID.Text + " ) SELECT 1 ELSE SELECT 0 "
        Dim strSQL As String = "usp_sel_tbl_Q_QuestionnaireQuestion_OrderNo '" + CommonFunctions.General.BuildQueryString(args.Value) + "'," + TxtQuestionnaireQuestionID.Text + "," + txtQuetionnaireID.Text
        'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
        Dim strExists As String = ""
        strExists = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString(), "").ToString()
        If strExists <> "0" Then
            args.IsValid = False
            Response.Write("<script type=""text/javascript""  language=""javascript"">")
            Response.Write("alert(""Order Number already Exists."");")
            Response.Write("</script>")
        End If
    End Sub 'DuplicateOrdernumber_ServerValidate
#End Region
End Class 'WhizEditQuestion 
