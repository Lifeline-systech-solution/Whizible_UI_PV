
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



Partial Public Class WhizChecklistQuestion
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Variables"
    Private strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Private blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    Private strMode As String = ""
#End Region

#Region "Constants"
    Private Const CAP_CHECKLIST As String = "Checklist"
    Private Const CAP_CHECKLIST_QUESTION As String = "Checklist Item"
    Private Const CAP_CHECKLIST_NAME As String = " Checklist"
    Private Const CAP_CHECKLIST_DESCRIPTION As String = "Description"
    Private Const CAP_NO_RECORD As String = "There are no records to show in this view."
    Private Const CAP_ADD_CHECKLIST_ITEM As String = "Save"

#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        If Page.IsPostBack = False Then
            txtQuestionnaireID.Text = Request.QueryString.Get("QuestionnaireID_PK").ToString()
        Else
            strMode = Request.QueryString.Get("MODE").ToString()
            If strMode = "SAVE" Then
                SaveQuestions()
            End If
        End If
    End Sub 'Page_Load



    Protected Sub DrawPage()

        Dim sbHTML As New System.Text.StringBuilder()
        Dim strSQL As String = ""
        Dim intCounter As Integer = 0
        Dim drCategory As IDataReader
        Dim WAF_ObjDR As New CommonFunctions.Data.WAF_DataReader()

        WAF_ObjDR.ConnectionString = strConnectionString

        strSQL = "usp_VPM_Sel_AvailableSection_forChecklist " + txtQuestionnaireID.Text
        drCategory = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, WAF_ObjDR)

        sbHTML.Append("<table id=""TABLE2"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:95%"" >")
        sbHTML.Append("<tr class=""ms-WPHeader"">")
        sbHTML.Append("<td style="" height: 34px"">")
        sbHTML.Append("<div class=""ms-WPTitle"">")
        sbHTML.Append(CAP_CHECKLIST_QUESTION)
        sbHTML.Append("</div></td>")
        sbHTML.Append("<td style=""text-align:right"">")
        sbHTML.Append(("<input type=""button"" name=""btnAddItem"" value=""" + CAP_ADD_CHECKLIST_ITEM + """ id=""btnAddItem"" class=""ButtonHeightWidth2"" style=""height:25px;width:80px;"" onclick=""addItem_OnClick(" + txtQuestionnaireID.Text + ")"" /> &nbsp;&nbsp;"))
        sbHTML.Append(("<input type=""button"" name=""btnCancel"" value=""Cancel"" id=""btnCancel"" class=""ButtonHeightWidth2"" style=""height:25px;width:80px;"" onclick=""cancel_OnClick(" + txtQuestionnaireID.Text + ")"" />"))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        ' Loop Through all the section for the questions not already mapped to the selected Checklist
        While drCategory.Read()
            intCounter += 1
            sbHTML.Append("<table border=""0"" cellpadding=""2"" cellspacing=""0"" width=""95%"">")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td class=""ms-sectionheader"">")
            sbHTML.Append(("<a onclick=""javascript:ShowHideSection('IMGChecklistSection" + drCategory("CaytegoryId").ToString() + "','ChecklistSection" + drCategory("CaytegoryId").ToString() + "')"" style=""cursor: hand"">"))
            sbHTML.Append(("<img id=""IMGChecklistSection" + drCategory("CaytegoryId").ToString() + """ alt=""Hide/Show"" border=""0"" src=""../../Images/minus.gif"" "))
            sbHTML.Append("style=""border-top-width: 0px;border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px"" />")
            sbHTML.Append(("&nbsp;" + drCategory("Description")))
            sbHTML.Append("</a>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td>")
            sbHTML.Append(("<div id=""ChecklistSection" + drCategory("CaytegoryId").ToString() + """ style=""display: inline"">"))

            ShowAvailableSectionQuestions(sbHTML, txtQuestionnaireID.Text, drCategory("CaytegoryId").ToString())

            sbHTML.Append("</div>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td class=""ms-sectionline"">")
            sbHTML.Append("</td></tr>")
            sbHTML.Append("</table>")
        End While

        CommonFunctions.Data.DisposeDataReader(drCategory)


        If intCounter = 0 Then
            sbHTML.Append("<table border=""0"" cellpadding=""2"" cellspacing=""0"" width=""99.9%"">")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td class=""ms-sectionheader"" style=""text-align:center"">")
            sbHTML.Append(CAP_NO_RECORD)
            sbHTML.Append("</TD></TR></TABLE>")
        End If
        'sbHTML.Append("</td></tr></table>");
        sbHTML.Append("<table id=""TABLE2"" border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width:95%"" >")
        sbHTML.Append("<tr>")
        sbHTML.Append("<td style=""text-align:right"">")
        sbHTML.Append(("<input type=""button"" name=""btnAddItem"" value=""" + CAP_ADD_CHECKLIST_ITEM + """ id=""btnAddItem"" class=""ButtonHeightWidth2"" style=""height:25px;width:80px;"" onclick=""addItem_OnClick(" + txtQuestionnaireID.Text + ")"" /> &nbsp;&nbsp;"))
        sbHTML.Append(("<input type=""button"" name=""btnCancel"" value=""Cancel"" id=""btnCancel"" class=""ButtonHeightWidth2"" style=""height:25px;width:80px;"" onclick=""cancel_OnClick(" + txtQuestionnaireID.Text + ")"" />"))
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class=""ms-WPHeader"">")
        sbHTML.Append("<td >")
        sbHTML.Append("</td></tr>")
        sbHTML.Append("</table><br>")
        Response.Write(sbHTML.ToString())
        sbHTML = Nothing
    End Sub 'DrawPage



    'for each section plot the question details 



    Protected Sub DrawHeaderSection()
        Dim objSTBuilder As New System.Text.StringBuilder()

        Dim objDR As IDataReader
        Dim WAF_objDR As New CommonFunctions.Data.WAF_DataReader()
        Dim strSQL As String = "usp_VPM_Sel_tbl_Q_Questionnaire " + txtQuestionnaireID.Text

        WAF_objDR.ConnectionString = strConnectionString
        objDR = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, WAF_objDR)

        If objDR.Read() Then

            objSTBuilder.Append("<table border=""0"" cellpadding=""2"" cellspacing=""0"" width=""95%""><tr>")
            objSTBuilder.Append("<td class=ms-sectionheader style='PADDING-TOP: 4px;width:25%' vAlign=top>")
            'objSTBuilder.Append("<h3 class=ms-standardheader");
            objSTBuilder.Append("<a style='cursor:hand' onclick=javascript:ShowHideSection('objImgChecklistSection','objChecklistSection')>")
            objSTBuilder.Append("<IMG id='objImgChecklistSection' style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt='Hide/Show'")
            objSTBuilder.Append(" src='../../Images/minus.gif' border=0>&nbsp;")
            objSTBuilder.Append(objDR("QuestionnaireName").ToString())
            objSTBuilder.Append("</a></td>")
            objSTBuilder.Append("<td>")
            objSTBuilder.Append("<table id='objChecklistSection' style='display:inline'  class='ms-authoringcontrols' width='99.99%' border=0")

            objSTBuilder.Append("<tr>")

            objSTBuilder.Append("<td>")
            objSTBuilder.Append(objDR("Description").ToString())
            objSTBuilder.Append("</td>")

            objSTBuilder.Append("</tr>")

            objSTBuilder.Append("</table>")

            objSTBuilder.Append("</td>")
            objSTBuilder.Append("</tr>")
            objSTBuilder.Append("<tr class=""ms-WPHeader"">")
            objSTBuilder.Append("<td colspan=""2"">&nbsp;</TD></tr>")

            objSTBuilder.Append("</table> <br>")

            Response.Write(objSTBuilder.ToString())
        End If

        CommonFunctions.Data.DisposeDataReader(objDR)
        WAF_objDR = Nothing
        objSTBuilder = Nothing
        strSQL = Nothing
    End Sub 'DrawHeaderSection


    Protected Sub ShowAvailableSectionQuestions(ByRef sbQuestion As System.Text.StringBuilder, ByVal strQuestionnaireID As String, ByVal strCategoryID As String)
        Dim drQuestion As IDataReader
        Dim intCounter As Integer = 0
        Dim WAF_drQuestion As New CommonFunctions.Data.WAF_DataReader()

        WAF_drQuestion.ConnectionString = strConnectionString

        drQuestion = CommonFunctions.Data.GetDataReader("usp_VPM_Sel_Questionnaire_Questions_Available " + strQuestionnaireID + "," + strCategoryID, blnUseSQL, WAF_drQuestion)

        sbQuestion.Append("<table class='ms-authoringcontrols' border=""0"" cellpadding=""2"" cellspacing=""1"" width=""99.9%"">")
        sbQuestion.Append("<tr  >")
        sbQuestion.Append("<td style=""width:5%;text-align:right;vertical-align:top"">")
        sbQuestion.Append("Sr. No.")
        sbQuestion.Append("</td>")
        sbQuestion.Append("<td style=""width:50%;white-space:pre;vertical-align:top"">")
        sbQuestion.Append("Checklist Item")
        sbQuestion.Append("</td>")
        sbQuestion.Append("<td style=""width:30%;vertical-align:top"">")
        sbQuestion.Append("Answer Options")
        sbQuestion.Append("</td>")
        sbQuestion.Append("<td style=""width:5%;vertical-align:top;text-align:center"">")
        sbQuestion.Append("Mandatory")
        sbQuestion.Append("<td style=""width:5%;vertical-align:top;text-align:center"">")
        sbQuestion.Append("Select")
        sbQuestion.Append("</td>")

        sbQuestion.Append("</tr>")

        While drQuestion.Read()
            intCounter += 1
            sbQuestion.Append("<tr>")
            sbQuestion.Append("<td style=""text-align:right;vertical-align:top"">")
            sbQuestion.Append(intCounter.ToString())
            sbQuestion.Append("</td>")

            sbQuestion.Append("<td style=""vertical-align:top"">")
            sbQuestion.Append(drQuestion("Description"))
            sbQuestion.Append("</td>")

            sbQuestion.Append("<td style="";vertical-align:top"">")
            ShowChecklistAnswerOptions(sbQuestion, strQuestionnaireID, drQuestion("QuestionID").ToString(), drQuestion("AnswerSetID").ToString(), System.Convert.ToBoolean(drQuestion("SingleSelection")))
            sbQuestion.Append("</td>")
            sbQuestion.Append("<td style=""vertical-align:top;text-align:center"">")
            sbQuestion.Append(("<input type='checkbox' id='chkMandatory" + drQuestion("QuestionID").ToString() + "' value='" + drQuestion("QuestionID").ToString() + "' disabled >"))
            sbQuestion.Append("</td>")
            sbQuestion.Append("<td style=""vertical-align:top;text-align:center"">")
            sbQuestion.Append(("<input type='checkbox' id='chkSelect' value='" + drQuestion("QuestionID").ToString() + "' onclick=""chkSelect_OnClick(this," + drQuestion("QuestionID").ToString() + ")"">"))
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
    End Sub 'ShowAvailableSectionQuestions


    Protected Sub ShowChecklistAnswerOptions(ByRef sbAnswerOption As System.Text.StringBuilder, ByVal strQuestionnaireID As String, ByVal QuestionID As String, ByVal strAnswerSetID As String, ByVal blnSingleSelection As [Boolean])
        Dim drAnswerOption As IDataReader
        Dim strSQL As String = "usp_VPM_sel_QuestionnaireOptions " + strAnswerSetID
        Dim WAF_drAnswerOption As New CommonFunctions.Data.WAF_DataReader()
        WAF_drAnswerOption.ConnectionString = strConnectionString
        drAnswerOption = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, WAF_drAnswerOption)

        While drAnswerOption.Read()
            If blnSingleSelection = False Then

                sbAnswerOption.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkOption" + QuestionID, "chkOption" + QuestionID, "", False, drAnswerOption("AnswerID").ToString(), False, "", True, False, "", True, False, 0))
            Else
                sbAnswerOption.Append(CommonFunctions.HTMLControls.DrawOptionButton("optOption" + QuestionID, "optOption" + QuestionID, "", False, drAnswerOption("AnswerID").ToString(), False, "", True, False, 0))
            End If
            sbAnswerOption.Append((" " + drAnswerOption("AnswerDescription").ToString() + " "))
        End While

        CommonFunctions.Data.DisposeDataReader(drAnswerOption)
    End Sub 'ShowChecklistAnswerOptions


    Protected Sub SaveQuestions()
        Dim sbSQL As New System.Text.StringBuilder()
        Dim seperator As Char = System.Convert.ToChar(","c)
        Dim selectedQuestions As String() = {""}
        If txtQuestions.Text <> "" Then
            selectedQuestions = txtQuestions.Text.Split(seperator)
        End If
        Dim selectedMandatory As String() = {""}
        If txtMandatory.Text <> "" Then
            selectedMandatory = txtMandatory.Text.Split(seperator)
        End If
        Dim intCounter As Integer = 0

        While intCounter < selectedQuestions.Length
            sbSQL.Append("usp_Q_Save_AddQuestionToQuestionnaire ")
            sbSQL.Append(txtQuestionnaireID.Text)
            sbSQL.Append(",")
            sbSQL.Append(selectedQuestions(intCounter))
            sbSQL.Append(",")
            sbSQL.Append(selectedMandatory(intCounter))

            CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString(), blnUseSQL, strConnectionString)
            intCounter += 1
            sbSQL.Length = 0
        End While
    End Sub 'SaveQuestions
End Class 'WhizChecklistQuestion