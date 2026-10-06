
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

Partial Public Class WhizPublishProcess
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


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        If Page.IsPostBack = False Then

            Calendar1.Style.Add("display", "none")
            RevisionDate.Text = Calendar1.TodaysDate.ToShortDateString()
            Calendar1.SelectedDate = Calendar1.TodaysDate
            PopulateCombo()
            txtPKID.Text = Request.QueryString.Get("PKID")

            If Request.QueryString.Get("PKID") = "0|PS" AndAlso Not (Request.QueryString.Get("UniqueID") Is Nothing) Then

                txtUniqueID.Text = Request.QueryString.Get("UniqueID")
                LblProcessName.Text = CommonFunctions.Data.GetDataScalar("SELECT ProcessName FROM tbl_PRS_Process_Draft WHERE ProcessID = " + txtUniqueID.Text, blnUseSQL, strConnectionString).ToString()
                lblCaption.Text = "Publish Process :"
            ElseIf Request.QueryString.Get("PKID") = "0|CS" AndAlso Not (Request.QueryString.Get("UniqueID") Is Nothing) Then
                txtUniqueID.Text = Request.QueryString.Get("UniqueID").ToString()
                'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                'LblProcessName.Text = CommonFunctions.Data.GetDataScalar("SELECT QuestionnaireName FROM tbl_Q_Questionnaire WHERE QuestionnaireID= " + txtUniqueID.Text, blnUseSQL, strConnectionString).ToString()
                LblProcessName.Text = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_Q_Questionnaire_QuestionnaireName " + txtUniqueID.Text, blnUseSQL, strConnectionString).ToString()
                'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                lblCaption.Text = "Publish Checklist :"
                LblTemplateSection.Text = "Publish Checklist"
                Head1.Title = "Publish Checklist"
            Else
                txtUniqueID.Text = "0"
                txtPKID.Text = Request.QueryString.Get("PKID")
            End If
        End If
    End Sub 'Page_Load


    Protected Sub PopulateCombo()
        objDS = New DataSet()
        Dim strSQL As String = " Usp_Sel_tbl_PM_HighAndMiddleLevelAccess "
        'strConnectionString = System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString1");
        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("UserName")
        objDS.Tables(0).PrimaryKey = objPrimaryKey

        cboRevisedBy.DataSource = objDS.Tables(0)
        cboRevisedBy.DataMember = objDS.Tables(0).TableName
        cboRevisedBy.DataValueField = objDS.Tables(0).Columns("UserName").ColumnName
        cboRevisedBy.DataTextField = objDS.Tables(0).Columns("UserName").ColumnName
        cboRevisedBy.DataBind()

        cboApprovedBy.DataSource = objDS.Tables(0)
        cboApprovedBy.DataMember = objDS.Tables(0).TableName
        cboApprovedBy.DataValueField = objDS.Tables(0).Columns("UserName").ColumnName
        cboApprovedBy.DataTextField = objDS.Tables(0).Columns("UserName").ColumnName
        cboApprovedBy.DataBind()
    End Sub 'PopulateCombo 


#Region "Control Events"

    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid = True Then
            If Request.QueryString.Get("PKID") = "0|PS" AndAlso Not (Request.QueryString.Get("UniqueID") Is Nothing) Then
                Dim strApprovedBy As String = ""
                Dim strRevisedBy As String = ""
                Dim strRevisionDate As String = ""
                Dim dtRevisionDate As DateTime = System.DateTime.Now
                Dim strReason As String = ""
                Dim strRevisionNo As String = "0"
                Dim strRevisionID As String = "0"

                'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                'Dim strSQL As String = "select IsNull(RevisionNo,0) + 1 FROM Tbl_PRS_Process_draft WHERE ProcessID = " + txtUniqueID.Text
                Dim strSQL As String = "usp_sel_Tbl_PRS_Process_draft_RevisionNo " + txtUniqueID.Text
                'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

                ' Get the values in local variables. 
                dtRevisionDate = Calendar1.SelectedDate
                strRevisionNo = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString()
                strRevisionDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Dates.GetDate(dtRevisionDate), "")
                strApprovedBy = cboApprovedBy.Text
                strRevisedBy = cboRevisedBy.Text
                strReason = txtReason.Text

                ' add record in revision table 
                strSQL = "usp_Ins_tbl_PRS_Process_Revision " + txtUniqueID.Text + ", Null," + strRevisionNo + ","

                If strRevisionDate = "" Then
                    strSQL += "null,"
                Else
                    strSQL += "'" + strRevisionDate + "',"
                End If
                strSQL += "'" + strRevisedBy + "',"
                strSQL += "'" + strApprovedBy + "',"
                strSQL += "'" + strReason + "'" + Environment.NewLine

                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

                'Get the newly created RevisionID

                'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                'strSQL = "SELECT RevisionID FROM Tbl_PRS_Process_Revision WHERE RevisionNo = " + strRevisionNo + " AND ProcessID = " + txtUniqueID.Text
                strSQL = "usp_sel_Tbl_PRS_Process_Revision_RevisionID " + strRevisionNo + "," + txtUniqueID.Text
                'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                strRevisionID = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString()

                ' Update the draft process Revision No and other details
                strSQL = " usp_Upd_tbl_PRS_Process_DraftStatus " + txtUniqueID.Text + "," + strRevisionID + "," + strRevisionNo + ",'" + strRevisedBy + "','P'"

                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

                ' Update the publishd tables
                strSQL = "usp_Upd_PRS_Process_Published " + txtUniqueID.Text + ", 'P'"

                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

                'Refresh parent page and close the window.
                Response.Write(("  <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
                Response.Write(" var thislocation = window.location.href; ")
                Response.Write(" var openerlocation = window.opener; ")
                Response.Write(" if(openerlocation != null )")
                Response.Write(" {")
                'Response.Write(" window.opener.parent.frames['WhizVisualProcessGrid'].document.location.href= ""WhizProcessDetails.aspx?PKID=0|PS"";")
                Response.Write(" window.opener.location.href= ""WhizProcessDetails.aspx?PKID=0|PS"";")
                Response.Write(" window.close(); ")
                Response.Write((" }" + Environment.NewLine))
                Response.Write("else{")
                Response.Write(" window.location.href= ""WhizProcessDetails.aspx?PKID=0|PS"";")
                Response.Write("}")

                Response.Write(" </script>")
            ElseIf Request.QueryString.Get("PKID") = "0|CS" AndAlso Not (Request.QueryString.Get("UniqueID") Is Nothing) Then
                Dim strApprovedBy As String = ""
                Dim strRevisedBy As String = ""
                Dim strRevisionDate As String = ""
                Dim dtRevisionDate As DateTime = System.DateTime.Now
                Dim strReason As String = ""
                Dim strRevisionNo As String = "0"

                'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
                'Dim strSQL As String = "select IsNull(RevisionNo,0) + 1 FROM tbl_Q_Questionnaire WHERE QuestionnaireID = " + txtUniqueID.Text
                Dim strSQL As String = "usp_tbl_Q_Questionnaire_RevisionNo " + txtUniqueID.Text
                'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query

                ' Get the values in local variables. 
                dtRevisionDate = Calendar1.SelectedDate
                strRevisionNo = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString()
                strRevisionDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Dates.GetDate(dtRevisionDate), "")
                strApprovedBy = cboApprovedBy.Text
                strRevisedBy = cboRevisedBy.Text
                strReason = txtReason.Text

                ' add record in revision table 
                strSQL = "usp_Ins_tbl_Q_Questionnaire_Revision " + txtUniqueID.Text + ","

                strSQL += "'" + strRevisedBy + "',"

                If strRevisionDate = "" Then
                    strSQL += "null,"
                Else
                    strSQL += "'" + strRevisionDate + "',"
                End If

                strSQL += "'" + strApprovedBy + "',"
                strSQL += "'" + strReason + "'" + Environment.NewLine

                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

                'Refresh parent page and close the window.
                Response.Write((" <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
                Response.Write(" var thislocation = window.location.href; ")
                Response.Write(" var openerlocation = window.opener; ")
                Response.Write(" if(openerlocation != null )")
                Response.Write(" {")
                Response.Write(" window.opener.location.href= ""WhizProcessDetails.aspx?PKID=0|CS"";")
                Response.Write(" window.close(); ")
                Response.Write((" }" + Environment.NewLine))
                Response.Write("else{")
                Response.Write(" window.location.href= ""WhizProcessDetails.aspx?PKID=0|CS"";")
                Response.Write("}")

                Response.Write(" </script>")
            End If
        End If
    End Sub 'btnTopSave_Click

    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strPKID As String = Request.QueryString.Get("PKID")
        Response.Redirect(("WhizProcessDetails.aspx?PKID=" + strPKID))
    End Sub 'btnTopCancel_Click

    Protected Sub Calendar1_SelectionChanged(ByVal sender As Object, ByVal e As EventArgs)
        RevisionDate.Text = Calendar1.SelectedDate.ToShortDateString()
        Calendar1.Style.Add("display", "none")
    End Sub 'Calendar1_SelectionChanged

    Protected Sub Calendar1_VisibleMonthChanged(ByVal sender As Object, ByVal e As MonthChangedEventArgs)
        Calendar1.Style.Add("display", "inline")
    End Sub 'Calendar1_VisibleMonthChanged

    Protected Sub CustomValidator2_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim dtRevisionDate As DateTime
        System.DateTime.TryParse(RevisionDate.Text, dtRevisionDate)
        If dtRevisionDate = System.DateTime.MinValue Then
            args.IsValid = False
        End If
    End Sub 'CustomValidator2_ServerValidate
    Protected Sub PublishChecklist()
        Dim strApprovedBy As String = ""
        Dim strRevisedBy As String = ""
        Dim strRevisionDate As String = ""
        Dim dtRevisionDate As DateTime = System.DateTime.Now
        Dim strReason As String = ""
        Dim strRevisionNo As String = "0"

        'Dim strSQL As String = "select IsNull(RevisionNo,0) + 1 FROM tbl_Q_Questionnaire WHERE QuestionnaireID = " + txtUniqueID.Text
        Dim strSQL As String = ""
        '' Get the values in local variables. 
        'dtRevisionDate = Calendar1.SelectedDate
        'strRevisionNo = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString).ToString()
        'strRevisionDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Dates.GetDate(dtRevisionDate), "")
        'strApprovedBy = cboApprovedBy.Text
        'strRevisedBy = cboRevisedBy.Text
        'strReason = txtReason.Text

        ' add record in revision table 
        strSQL = "usp_Ins_tbl_Q_Questionnaire_Revision " + CommonFunction.General.CheckIsNothing(Request.QueryString.Get("UniqueID")) + ","

        strSQL += "N'" + Session("strUserName") + "'"

        'If strRevisionDate = "" Then
        '    strSQL += "null,"
        'Else
        '    strSQL += "'" + strRevisionDate + "',"
        'End If

        'strSQL += "'" + strApprovedBy + "',"
        'strSQL += "'" + strReason + "'" + Environment.NewLine

        CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)

        'Refresh parent page and close the window.
        Response.Write((" <script language = ""javascript"" type=""text/javascript"" >" + Environment.NewLine))
        Response.Write(" var thislocation = window.location.href; ")
        Response.Write(" var openerlocation = window.opener; ")
        Response.Write(" if(openerlocation != null )")
        Response.Write(" {")
        Response.Write(" window.opener.location.href= ""WhizProcessDetails.aspx?PKID=0|CS"";")
        Response.Write(" window.close(); ")
        Response.Write((" }" + Environment.NewLine))
        Response.Write("else{")
        Response.Write(" window.location.href= ""WhizProcessDetails.aspx?PKID=0|CS"";")
        Response.Write("}")

        Response.Write(" </script>")
    End Sub
#End Region
End Class 'WhizPublishProcess 

