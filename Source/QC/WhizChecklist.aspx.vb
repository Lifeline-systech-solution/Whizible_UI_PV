
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



Partial Public Class WhizChecklist
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

#Region "constants"
    Private Const CAP_CHECKLIST_ITEM As String = "Checklist Item"
    Private Const CAP_ADD_CHECKLIST_ITEM As String = "Add Item"
    Private Const CAP_DELETE_CHECKLIST_ITEM As String = "Delete Item"
    Private Const CAP_NO_RECORD As String = "There are no items to show in this view."
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        FillChecklistDataSet()
        PopulateGroupCombo()
        If Page.IsPostBack = False Then

            If Request.QueryString.Get("ACTION") = "ADD_NEW" Then
                LblChecklistSection.Text = "New Checklist"
                lblReviNoCaption.Visible = False
                lblRevisionNo.Visible = False
            ElseIf Request.QueryString.Get("ACTION") = "MODIFY" Then
                LblChecklistSection.Text = "Modify Checklist"
                TxtQuestionnaireID.Text = Request.QueryString.Get("QuestionnaireID_PK")

                ShowRecord(GetCurrentRow(System.Convert.ToInt32(TxtQuestionnaireID.Text)))
            End If
        Else
            If Request.QueryString.Get("MODE") = "DELETEQUESTION" Then
                DeleteQuestions()
            End If
        End If
    End Sub 'Page_Load


    Protected Sub PopulateGroupCombo()
        cboGroupID.DataSource = objDS.Tables(1)
        cboGroupID.DataMember = objDS.Tables(1).TableName
        cboGroupID.DataValueField = objDS.Tables(1).Columns("GroupID").ColumnName
        cboGroupID.DataTextField = objDS.Tables(1).Columns("GroupName").ColumnName
        cboGroupID.DataBind()
    End Sub 'PopulateGroupCombo


    Protected Sub FillChecklistDataSet()
        ''=====================================================================
        '        ' Procedure Name        : FillChecklistDataSet
        '        ' Purpose               : To get the Checklist details in a Dataset
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
        'Added and Commented By Dipali V On 8th Aug 2016 For Remove Inline Query
        ' Dim strSQL As String = "SELECT * FROM tbl_Q_Questionnaire SELECT GroupID , GroupName FROM tbl_CNF_CheckListGroup Order By GroupName "
        Dim strSQL As String = "usp_sel_tbl_CNF_CheckListGroup_GroupID_GroupName"
        'End Of Addition and Commented By Dipali V On 8th Aug 2016 For Remove Inline Query
        objDA = New SqlDataAdapter(strSQL, strConnectionString)
        objDA.Fill(objDS)
        Dim objPrimaryKey(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(0).Columns("QuestionnaireID")
        objDS.Tables(0).PrimaryKey = objPrimaryKey

        Dim objPrimaryKey1(0) As DataColumn
        objPrimaryKey(0) = objDS.Tables(1).Columns("GroupID")
        objDS.Tables(1).PrimaryKey = objPrimaryKey1
    End Sub 'FillChecklistDataSet


    Protected Function GetCurrentRow(ByVal intQuestionnaireID As Integer) As DataRow
        Dim dr As DataRow = Nothing

        Dim objDR1 As DataRow()
        objDR1 = objDS.Tables(0).Select("QuestionnaireID = " + intQuestionnaireID.ToString())

        ''For Each objDR1 In objDS.Tables(0).Rows
        ''    If System.Convert.ToInt32(objDR1("QuestionnaireID")) = intQuestionnaireID Then
        ''        dr = objDR1
        ''        Exit For
        ''    End If
        ''Next objDR1
        dr = objDR1(0)
        Return dr
    End Function 'GetCurrentRow


    Protected Sub ShowRecord(ByVal dr As DataRow)

        'Set default values
        Dim strQuestionnaireName As String = ""
        Dim strDescription As String = ""
        Dim strGroupID As String = ""
        Dim strRevisionNo As String = "0"

        'Get values
        If Not (dr("QuestionnaireName") Is Nothing) Then
            strQuestionnaireName = System.Convert.ToString(dr("QuestionnaireName"))
        End If
        If Not (dr("Description") Is Nothing) Then
            strDescription = System.Convert.ToString(dr("Description"))
        End If
        If Not (dr("GroupID") Is Nothing) Then
            strGroupID = System.Convert.ToString(dr("GroupID"))
        End If
        If Not (dr("RevisionNo") Is Nothing) Then
            strRevisionNo = System.Convert.ToString(dr("RevisionNo"))
        End If
        txtQuestionnaireName.Text = strQuestionnaireName
        txtDescription.Text = strDescription
        If Not (strGroupID Is Nothing) AndAlso strGroupID <> "" Then
            cboGroupID.SelectedValue = strGroupID
        End If
        lblRevisionNo.Text = strRevisionNo
    End Sub 'ShowRecord


    Protected Sub ShowChecklistSections()
        Dim sbHTML As New System.Text.StringBuilder()
        Dim drCategory As IDataReader
        Dim WAF_drCategory As New CommonFunctions.Data.WAF_DataReader()
        Dim intCounter As Integer = 0
        If TxtQuestionnaireID.Text = "0" Then
            Return
        End If
        sbHTML.Append("<table id=""TABLE2"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:95%"" >")
        sbHTML.Append("<tr class=""ms-WPHeader"">")
        sbHTML.Append("<td style="" height: 34px"">")
        sbHTML.Append("<div class=""ms-WPTitle"">")
        sbHTML.Append(CAP_CHECKLIST_ITEM)
        sbHTML.Append("</div></td>")
        sbHTML.Append("<td style=""text-align:right"">")
        sbHTML.Append(("<input type=""button"" name=""btnAddItem"" value=""" + CAP_ADD_CHECKLIST_ITEM + """ id=""btnAddItem"" class=""ButtonHeightWidth2"" style=""height:25px;width:80px;"" onclick=""addItem_OnClick(" + TxtQuestionnaireID.Text + ")"" /> &nbsp;&nbsp;"))
        sbHTML.Append(("<input type=""button"" name=""btnDeleteItem"" value=""" + CAP_DELETE_CHECKLIST_ITEM + """ id=""btnDeleteItem"" class=""ButtonHeightWidth2"" style=""height:25px;width:85px;"" onclick=""DeleteItem_OnClick(" + TxtQuestionnaireID.Text + ")"" />"))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr>")
        sbHTML.Append("<td colspan=""2"">")

        WAF_drCategory.ConnectionString = strConnectionString
        drCategory = CommonFunctions.Data.GetDataReader("usp_VPM_Sel_Questionnaire_Category " + TxtQuestionnaireID.Text, blnUseSQL, WAF_drCategory)


        While drCategory.Read()
            intCounter += 1
            sbHTML.Append("<table border=""0"" cellpadding=""2"" cellspacing=""0"" width=""99.9%"">")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td class=""ms-sectionheader"">")
            sbHTML.Append(("<a  onclick=""javascript:ShowHideSection('IMGChecklistSection" + drCategory("CaytegoryId").ToString() + "','ChecklistSection" + drCategory("CaytegoryId").ToString() + "')"" style=""cursor: hand"">"))
            sbHTML.Append(("<img id=""IMGChecklistSection" + drCategory("CaytegoryId").ToString() + """ alt=""Hide/Show"" border=""0"" src=""../../Images/minus.gif"" "))
            sbHTML.Append("style=""border-top-width: 0px;border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px"" />")
            sbHTML.Append(("&nbsp;" + drCategory("Description")))
            sbHTML.Append("</a>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td>")
            sbHTML.Append(("<div id=""ChecklistSection" + drCategory("CaytegoryId").ToString() + """ style=""display: inline"">"))
            ShowChecklistSectionQuestions(sbHTML, TxtQuestionnaireID.Text, drCategory("CaytegoryId").ToString())
            sbHTML.Append("</div>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td class=""ms-sectionline"">")
            sbHTML.Append("</td></tr>")
            sbHTML.Append("</table>")
        End While

        If intCounter = 0 Then
            sbHTML.Append("<table border=""0"" cellpadding=""2"" cellspacing=""0"" width=""99.9%"">")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td class=""ms-sectionheader"" style=""text-align:center"">")
            sbHTML.Append(CAP_NO_RECORD)
            sbHTML.Append("</TD></TR></TABLE>")
        End If
        sbHTML.Append("</td></tr></table>")

        Response.Write(sbHTML.ToString())
        CommonFunctions.Data.DisposeDataReader(drCategory)
        WAF_drCategory = Nothing
        sbHTML = Nothing
    End Sub 'ShowChecklistSections


    Protected Sub ShowChecklistSectionQuestions(ByRef sbQuestion As System.Text.StringBuilder, ByVal strQuestionnaireID As String, ByVal strCategoryID As String)
        Dim drQuestion As IDataReader
        Dim intCounter As Integer = 0
        Dim WAF_drQuestion As New CommonFunctions.Data.WAF_DataReader()

        WAF_drQuestion.ConnectionString = strConnectionString

        drQuestion = CommonFunctions.Data.GetDataReader("usp_VPM_Sel_Questionnaire_Questions " + strQuestionnaireID + "," + strCategoryID, blnUseSQL, WAF_drQuestion)

        sbQuestion.Append("<table class='ms-authoringcontrols' border=""0"" cellpadding=""2"" cellspacing=""1"" width=""99.9%"">")
        sbQuestion.Append("<tr  >")
        sbQuestion.Append("<td style=""width:10%;text-align:right;vertical-align:top"">")
        sbQuestion.Append("Sr. No.")
        sbQuestion.Append("</td>")
        sbQuestion.Append("<td style=""width:50%;white-space:pre;vertical-align:top"">")
        sbQuestion.Append("Checklist Item")
        sbQuestion.Append("</td>")
        sbQuestion.Append("<td style=""width:30%;vertical-align:top"">")
        sbQuestion.Append("Answer Options")
        sbQuestion.Append("</td>")

        sbQuestion.Append("<td style=""width:5%;vertical-align:top;text-align:center"">")
        sbQuestion.Append("Delete")
        sbQuestion.Append("</td>")

        sbQuestion.Append("</tr>")

        While drQuestion.Read()
            intCounter += 1
            sbQuestion.Append("<tr>")
            sbQuestion.Append("<td style=""text-align:right;vertical-align:top"">")
            If drQuestion("Compulsory").ToString().ToUpper() = "TRUE" Then
                sbQuestion.Append("<span style=""color: #ff0000"">* </span>")
            End If
            sbQuestion.Append(intCounter.ToString())
            sbQuestion.Append("</td>")

            sbQuestion.Append("<td style=""vertical-align:top"">")
            sbQuestion.Append(("<a  href='javascript:EditQuestion(" + drQuestion("QuestionnaireQuestionID").ToString() + "," + strQuestionnaireID + ")'>"))
            sbQuestion.Append(drQuestion("QuestionDescription"))
            sbQuestion.Append("</a>")
            sbQuestion.Append("</td>")

            sbQuestion.Append("<td style="";vertical-align:top"">")
            ShowChecklistAnswerOptions(sbQuestion, strQuestionnaireID, drQuestion("QuestionnaireQuestionID").ToString(), drQuestion("AnswerSetID").ToString(), System.Convert.ToBoolean(drQuestion("SingleSelection")))
            sbQuestion.Append("</td>")

            sbQuestion.Append("<td style=""width:10%;vertical-align:top;text-align:center"">")
            sbQuestion.Append(("<input type='checkbox' id='chkDelete' value='" + drQuestion("QuestionnaireQuestionID").ToString() + "'>"))
            sbQuestion.Append("</td>")
            sbQuestion.Append("</tr>")
        End While

        If intCounter = 0 Then
            sbQuestion.Append("<tr>")
            sbQuestion.Append("<td colspan=""4"">")
            sbQuestion.Append(CAP_NO_RECORD)
            sbQuestion.Append("</td>")
            sbQuestion.Append("</tr>")
        End If
        sbQuestion.Append("</table>")

        CommonFunctions.Data.DisposeDataReader(drQuestion)
        WAF_drQuestion = Nothing
    End Sub 'ShowChecklistSectionQuestions


    Protected Sub ShowChecklistAnswerOptions(ByRef sbAnswerOption As System.Text.StringBuilder, ByVal strQuestionnaireID As String, ByVal QuestionnaireQuestionID As String, ByVal strAnswerSetID As String, ByVal blnSingleSelection As [Boolean])
        Dim drAnswerOption As IDataReader
        Dim strSQL As String = "usp_VPM_sel_QuestionnaireOptions " + strAnswerSetID
        Dim WAF_drAnswerOption As New CommonFunctions.Data.WAF_DataReader()
        WAF_drAnswerOption.ConnectionString = strConnectionString
        drAnswerOption = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, WAF_drAnswerOption)

        While drAnswerOption.Read()
            If blnSingleSelection = False Then

                sbAnswerOption.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkOption" + QuestionnaireQuestionID, "chkOption" + QuestionnaireQuestionID, "", False, drAnswerOption("AnswerID").ToString(), False, "", True, False, "", True, False, 0))
            Else
                sbAnswerOption.Append(CommonFunctions.HTMLControls.DrawOptionButton("optOption" + QuestionnaireQuestionID, "optOption" + QuestionnaireQuestionID, "", False, drAnswerOption("AnswerID").ToString(), False, "", True, False, 0))
            End If
            sbAnswerOption.Append((" " + drAnswerOption("AnswerDescription").ToString() + " "))
        End While

        CommonFunctions.Data.DisposeDataReader(drAnswerOption)
    End Sub 'ShowChecklistAnswerOptions

#Region "Control Events"

    Protected Sub btnTopSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Page.IsValid Then
            'Added And Commented By Dipali V On 8th Aug 2016 for Remove InLine Query
            ' Dim strSQL As String = "SELECT * FROM tbl_Q_Questionnaire "
            Dim strSQL As String = "usp_sel_tbl_Q_Questionnaire_all "
            'Added And Commented By Dipali V On 8th Aug 2016 for Remove InLine Query

            Dim oldQuestionnaireName As String = ""
            Dim newQuestionnaireName As String = ""

            Dim objCon As New SqlConnection(strConnectionString)
            objDA = New SqlDataAdapter(strSQL, objCon)
            Dim dr As DataRow = Nothing
            Dim objCmdBuilder As New SqlCommandBuilder(objDA)
            objCon = New SqlConnection(strConnectionString)
            Dim objPrimaryKey(0) As DataColumn
            objPrimaryKey(0) = objDS.Tables(0).Columns("QuestionnaireID")
            objDS.Tables(0).PrimaryKey = objPrimaryKey
            objDS.Tables(0).Columns("QuestionnaireID").AutoIncrement = True

            ' if new record add a row in dataset
            If TxtQuestionnaireID.Text = "0" Then
                dr = objDS.Tables(0).NewRow()
            Else
                dr = GetCurrentRow(System.Convert.ToInt32(TxtQuestionnaireID.Text))
            End If

            oldQuestionnaireName = System.Convert.ToString(dr.ItemArray(1))
            UpdateRow(dr)
            newQuestionnaireName = System.Convert.ToString(dr.ItemArray(1))

            If TxtQuestionnaireID.Text = "0" Then
                objDS.Tables(0).Rows.Add(dr)
            End If

            objDA.Update(objDS)

            If TxtQuestionnaireID.Text = "0" Then
                TxtQuestionnaireID.Text = System.Convert.ToString(GetQuestionnaireID())
                Response.Write("<script type=""text/javascript"" language='javascript''>")
                ' Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|CS"";")
                Response.Write("</script>")
            End If

            If oldQuestionnaireName <> newQuestionnaireName Then
                Response.Write("<script type=""text/javascript"" language='javascript''>")
                'Response.Write("window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;")
                Response.Write("window.location.href=""WhizProcessDetails.aspx?PKID=0|CS"";")
                Response.Write("</script>")
            End If
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


    Protected Sub UpdateRow(ByVal dr As DataRow)
        'Set default values
        Dim strQuestionnaireName As String = ""
        Dim strDescription As String = ""
        Dim strGroupID As String = ""
        'Get values
        If Not (txtQuestionnaireName.Text Is Nothing) AndAlso txtQuestionnaireName.Text <> "" Then
            strQuestionnaireName = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtQuestionnaireName.Text.Trim(), ""))
        End If
        If Not (txtDescription.Text Is Nothing) AndAlso txtDescription.Text <> "" Then
            strDescription = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(txtDescription.Text.Trim(), ""))
        End If
        If Not (cboGroupID.Text Is Nothing) AndAlso cboGroupID.Text <> "" Then
            strGroupID = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cboGroupID.Text.Trim(), ""))
        End If

        If TxtQuestionnaireID.Text = "0" Then
            dr("PublishStatus") = "True"
            dr("RevisionStatus") = "D"
        End If

        dr("QuestionnaireName") = strQuestionnaireName
        dr("Description") = strDescription
        dr("GroupID") = strGroupID
    End Sub 'UpdateRow


    Private Function GetQuestionnaireID() As Integer
        Dim intReturnVal As Integer = 0
        Dim strSQL As String = "SELECT MAX(QuestionnaireID) FROM tbl_Q_Questionnaire"
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
    End Function 'GetQuestionnaireID


    Protected Sub btnTopCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strPKID As String = Request.QueryString.Get("PKID")
        Response.Redirect(("WhizProcessDetails.aspx?PKID=" + strPKID))
    End Sub 'btnTopCancel_Click


    Protected Sub CustomValidator2_ServerValidate(ByVal [source] As Object, ByVal args As ServerValidateEventArgs)
        Dim strSQL As String = "If Exists ( SELECT Top 1 [QuestionnaireName] FROM tbl_Q_Questionnaire WHERE [QuestionnaireName]= '" + CommonFunctions.General.BuildQueryString(args.Value) + "' and QuestionnaireID <> " + TxtQuestionnaireID.Text + " ) SELECT 1 ELSE SELECT 0 "
        Dim strTitle As String = ""
        strTitle = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL, strConnectionString), ""))
        If strTitle <> "0" Then
            args.IsValid = False
        End If
    End Sub 'CustomValidator2_ServerValidate


    Protected Sub DeleteQuestions()
        Dim sbSQL As New System.Text.StringBuilder()
        Dim seperator As Char = System.Convert.ToChar(","c)
        Dim selectedQuestions As String() = {""}
        If txtQuestions.Text <> "" Then
            selectedQuestions = txtQuestions.Text.Split(seperator)
        End If
        Dim intCounter As Integer = 0

        Try

            While intCounter < selectedQuestions.Length
                sbSQL.Append("usp_VPM_Del_Tbl_Q_QuestionnaireQuestion ")
                sbSQL.Append(selectedQuestions(intCounter))

                CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString(), blnUseSQL, strConnectionString)
                intCounter += 1
                sbSQL.Length = 0
            End While

        Catch
        Finally
        End Try
        sbSQL = Nothing
        selectedQuestions = Nothing
    End Sub 'DeleteQuestions 
#End Region
End Class 'WhizChecklist