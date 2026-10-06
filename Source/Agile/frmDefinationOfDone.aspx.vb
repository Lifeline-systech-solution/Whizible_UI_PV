Public Class frmDefinationOfDone
    ' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    Public ProjectID As String = ""

    Public Description As String = ""
    Public US_TaskFlag As String = ""
    Public US_IssueFlag As String = ""
    Public US_ReviewFlag As String = ""
    Public US_CustomStageFlag As String = ""
    Public US_ChecklistReviewFlag As String = ""
    Public UserStoryDoneFlag As String = ""
    Public Sprint_IssueFlag As String = ""
    Public Sprint_ReviewFlag As String = ""
    Public Sprint_ChecklistReviewFlag As String = ""
    Public Add_UserStory As String = ""
    Public Cancel_UserStory As String = ""
    Public SprintDoneFlag As String = ""
    Public Release_IssueFlag As String = ""
    Public Release_ReviewFlag As String = ""
    Public Release_ChecklistReviewFlag As String = ""
    Public Add_Sprint As String = ""
    Public Terminate_Sprint As String = ""
    ' Private WithEvents objGrid As WebPages.Template.GenericGrid
    Private WithEvents objGrid As New WebPages.Template.GenericGrid
    Private Shared WithEvents m_objSprint As New WebPages.Template.GenericGrid
    Private Shared WithEvents m_objRelease As New WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected strIsPrductOwner As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        ProjectID = Session("intProjectID")
    End Sub

    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get  the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	26th-March-2018
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22233, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
    End Sub

    Function CheckIsProductOwner(ByVal strUserID As String)
        '=====================================================================
        ' Procedure Name        :	CheckIsProductOwner
        ' Purpose               :	CheckIsProductOwner
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	26th-March-2018
        ' Revisions             :
        '=====================================================================

        Dim drGetIsProductOwner As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""
        Dim strIsPrductOwner As String
        StrQuery = "usp_NG2_IsProductOwner " & Session("intProjectID") & "," & strUserID & ""
        drGetIsProductOwner = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetIsProductOwner.Read
            strIsPrductOwner = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")

        End While
        Return strIsPrductOwner

    End Function
    Public Function DefinitionOfDone(ByVal Mode As String) As String
        '*******************************************************************************'
        ' Function Name	        :	DefinitionOfDone                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   22nd Feb 2018
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()
        Dim drTabData As IDataReader
        Dim strSQL As String = ""
        strSQL = "usp_sel_tbl_NG2_DefinitionOfDone " & Session("intProjectID") & ""

        drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

        If drTabData.Read Then
            Description = CommonFunctions.Data.CheckIsDBNull(drTabData("Description"), "")
            US_TaskFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("US_TaskFlag"), "")
            US_IssueFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("US_IssueFlag"), "")
            US_ReviewFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("US_ReviewFlag"), "")
            US_CustomStageFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("US_CustomStageFlag"), "")
            US_ChecklistReviewFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("US_ChecklistReviewFlag"), "")
            UserStoryDoneFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("UserStoryDoneFlag"), "")
            Sprint_IssueFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("Sprint_IssueFlag"), "")
            Sprint_ReviewFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("Sprint_ReviewFlag"), "")
            Sprint_ChecklistReviewFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("Sprint_ChecklistReviewFlag"), "")
            Add_UserStory = CommonFunctions.Data.CheckIsDBNull(drTabData("Add_UserStory"), "")
            Cancel_UserStory = CommonFunctions.Data.CheckIsDBNull(drTabData("Cancel_UserStory"), "")
            SprintDoneFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("SprintDoneFlag"), "")
            Release_IssueFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("Release_IssueFlag"), "")
            Release_ReviewFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("Release_ReviewFlag"), "")
            Release_ChecklistReviewFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("Release_ChecklistReviewFlag"), "")
            Add_Sprint = CommonFunctions.Data.CheckIsDBNull(drTabData("Add_Sprint"), "")
            Terminate_Sprint = CommonFunctions.Data.CheckIsDBNull(drTabData("Terminate_Sprint"), "")

        End If
        If Mode <> "AfterSaveRefresh" Then
            strHTML.Append("<div id='DivWholedata'>")
        End If
        'strHTML.Append("<div class='container'>" & vbCrLf) 'container-fluid
        strHTML.Append("<div class='container-fluid'>" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-12 fixed-top'>" & vbCrLf)
        strHTML.Append("<p class='ClsPageheader'>Definition Of Done</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-lg-6 setheight'style='margin-top:90px;' >" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)


        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-8'>" & vbCrLf)
        strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;'>Project Level (OverAll)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4'>" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<p  class='col-sm-2'style='font-size: 13px; font-weight: 500; color: red;margin-right:3px;'>Note:</p><p class='col-sm-6' style='font-size: 13px; font-weight: 500; color: grey;'>Default All will NA</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div><hr><br>")
        'Commentedd & Added By Dipali V On 20th Nov 2020 For GES Issues
        strHTML.Append("<div class='row'>" & vbCrLf)
        'strHTML.Append("<div class='col-sm-7'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-5'>" & vbCrLf)
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='margin-top:0.5%'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-7' style='margin-top:0.5%'>" & vbCrLf)
        'End of Commentedd & Added By Dipali V On 20th Nov 2020 For GES Issues
        GetAccessRights()
        If m_objAccess.Edit Then
            If strIsPrductOwner = 1 Then
                strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick='Save_OnClick()' Id='btnSave' title='Save'><i class='fa fa-floppy-o' aria-hidden='true'></i>  Save</button>" & vbCrLf)
            Else

            End If
        End If

        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick='showhistory_OnClick()' Id='btnHistory' title='Show History'><i class='fa fa-history' aria-hidden='true'></i>   Show History</button>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-2' id='lblDescri'>" & vbCrLf)
        strHTML.Append("<p style='font-weight: 500;color: grey;'>Description</p>" & vbCrLf)
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='row' id='DivDescri'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-2' >" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-10'>" & vbCrLf)
        If Description = "" Then
            strHTML.Append("<textarea id='txtDescription' type='text' style='  outline: none;   border-bottom: 1px solid #ddd;border-top-color: transparent;  border-left-color: transparent; border-right-color: transparent;width: 440px!important;border-radius: 0px;' onkeyup='javascript:validateData(this,ShowCount,1000)' data-autoresize></textarea><br><p id='ShowErrorMSG'></p><p id='ShowCount'>" & (1000 - Description.Length) & "</p>" & vbCrLf)
        Else
            strHTML.Append("<textarea id='txtDescription' type='text' style='  outline: none;   border-bottom: 1px solid #ddd;border-top-color: transparent;  border-left-color: transparent; border-right-color: transparent;width: 440px!important;border-radius: 0px;' onkeyup='javascript:validateData(this,ShowCount,1000)'  value=" & Description & "  data-autoresize>" & Description & "</textarea><br><p id='ShowErrorMSG'></p><p id='ShowCount'> " & (1000 - Description.Length) & " </p>" & vbCrLf)
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'For User Stories Section
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<p  class='col-sm-2'style='font-weight: 500;color: grey;white-space: nowrap;text-overflow: ellipsis;'>User Stories</p><p class='col-sm-6' style='white-space: nowrap; text-overflow: ellipsis; font-size: 12px;font-weight: 500;color: grey;margin-left: -5px;margin-top: 3px;'>(Validated while completing User Stories)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='post-title-line'>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append(WriteUserStories())
        'End of  User Stories Section

        'For Sprint Section
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<p  class='col-sm-1'style='font-weight: 500;color: grey;white-space: nowrap;text-overflow: ellipsis;'>Sprint</p><p class='col-sm-10' style='white-space: nowrap; text-overflow: ellipsis; font-size: 12px;font-weight: 500;color: grey;margin-left: -5px;margin-top: 3px;'>(Validated while completing Sprint)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='post-title-line'>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append(WriteSprint())
        'End of Sprint Section

        'For Release Section
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<p  class='col-sm-6'style='font-weight: 500;color: grey;white-space: nowrap;text-overflow: ellipsis;'>Release</p><p class='col-sm-6' style='white-space: nowrap; text-overflow: ellipsis; font-size: 12px;font-weight: 500;color: grey;margin-left: -5px;margin-top: 3px;'>(Validated while completing Release)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='post-title-line'>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append(WriteRelease())
        'End of Release Section
        strHTML.Append("<div class='vl'>" & vbCrLf)
        strHTML.Append("</div>")

        'For Tab Section
        strHTML.Append("<div class='col-lg-6 setheight'style='margin-top: 75px;'>" & vbCrLf)
        strHTML.Append("<ul class='nav nav-tabs'>" & vbCrLf)

        'added by ashwini on 21-3-2023 data-bs-toggle
        strHTML.Append("<li id='Idfirstli' ><a href='#' class='active' onclick='Tab_Onclick(event, ""Sprint"")' id='Sprint'   data-bs-toggle='tab' >Sprint</a></li>" & vbCrLf)
        strHTML.Append("<li id='Idsecli'><a href='#' onclick='Tab_Onclick(event, ""Release"")' id='Release'   data-bs-toggle='tab' >Release</a></li>" & vbCrLf)
        'End Of added by ashwini On 21-3-2023 data-bs-toggle

        strHTML.Append("</ul><br>")
        'End of  Tab Section

        strHTML.Append("<div id='divRightSection'>" & vbCrLf)
        strHTML.Append(RightSection("Sprint", ""))
        strHTML.Append("</div>")

        ' strHTML.Append("<button type='button' onclick='Save_OnClick()' class='btn' style='font-size:12px;margin-left:2px;BACKGROUND-COLOR: WHITE;font-weight:bold;'>Save</button>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<input type='hidden' value='" & ProjectID & "' id='hdnProjectID' />")
        strHTML.Append("<input type=hidden id=hdnstrProjectTypeID value=''>")

        If Mode <> "AfterSaveRefresh" Then
            strHTML.Append("</div>")
            Response.Write(strHTML.ToString())
        Else
            Return strHTML.ToString
        End If

    End Function
    Public Function WriteUserStories()
        '*******************************************************************************'
        ' Function Name	        :	WriteUserStories                                            '
        ' Purpose				:   Plotting User Stories Section                             '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande   
        'Date                   :   22nd Feb 2018'
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Task</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_TaskFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineTaskRadioOptions' id='inlineTask' value='1'  data-toggle='tooltip' data-placement='top'  title='If Checked All Tasks should be closed before completing User Story.' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineTaskRadioOptions' id='inlineTask' value='1' data-toggle='tooltip' data-placement='top'  title='If Checked All Tasks should be closed before completing User Story.'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_TaskFlag <> "" Then
            If US_TaskFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineTaskRadioOptions' id='inlineTaskNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineTaskRadioOptions' id='inlineTaskNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineTaskRadioOptions' id='inlineTaskNA' value='3' > NA </label>" & vbCrLf)
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Issues</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_IssueFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before completing User Story.' name='inlineIssueRadioOptions' id='inlineIssueClosed' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio'data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before completing User Story.'  name='inlineIssueRadioOptions' id='inlineIssueClosed' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_IssueFlag = "2" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Issues will be forwarded to Sprint.' name='inlineIssueRadioOptions' id='inlineIssueFWD' value='2' checked> Forward </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Issues will be forwarded to Sprint.' name='inlineIssueRadioOptions' id='inlineIssueFWD' value='2'> Forward </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_IssueFlag <> "" Then
            If US_IssueFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineIssueRadioOptions' id='inlineIssueNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineIssueRadioOptions' id='inlineIssueNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineIssueRadioOptions' id='inlineIssueNA' value='3' > NA </label>" & vbCrLf)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Review</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_ReviewFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio'  data-toggle='tooltip' data-placement='top' title='If Checked All Reviews should be closed before completing User Story.' name='inlineReviewRadioOptions' id='inlineReviewClosed' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio'  data-toggle='tooltip' data-placement='top' title='If Checked All Reviews should be closed before completing User Story.' name='inlineReviewRadioOptions' id='inlineReviewClosed' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_ReviewFlag = "2" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Reviews will be forwarded to Sprint.' name='inlineReviewRadioOptions' id='inlineReviewFWD' value='2' checked> Forward </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Reviews will be forwarded to Sprint.' name='inlineReviewRadioOptions' id='inlineReviewFWD' value='2'> Forward </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_ReviewFlag <> "" Then
            If US_ReviewFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReviewRadioOptions' id='inlineReviewNA' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReviewRadioOptions' id='inlineReviewNA' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' value='3'> NA </label>" & vbCrLf)
            End If

        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReviewRadioOptions' id='inlineReviewNA' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' value='3' checked> NA </label>" & vbCrLf)
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD
        'strHTML.Append("<div class='row'>" & vbCrLf)
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append("<p>Checklist Review</p>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If US_ChecklistReviewFlag = "1" Then
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Reviews should be closed before completing User Story.' name='inlineChecklistRadioOptions' id='inlineCheckListClosed' value='1' checked> Closed </label>" & vbCrLf)
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Reviews should be closed before completing User Story.'  name='inlineChecklistRadioOptions' id='inlineCheckListClosed' value='1'> Closed </label>" & vbCrLf)
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If US_ChecklistReviewFlag = "2" Then
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Open Reviews will be forwarded to Sprint.' name='inlineChecklistRadioOptions' id='inlineCheckListFWD' value='2' checked> Forward </label>" & vbCrLf)
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Open Reviews will be forwarded to Sprint.' name='inlineChecklistRadioOptions' id='inlineCheckListFWD' value='2'> Forward </label>" & vbCrLf)
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If US_ChecklistReviewFlag <> "" Then
        '    If US_ChecklistReviewFlag = "3" Then
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineChecklistRadioOptions' id='inlineCheckListNA' value='3' checked> NA </label>" & vbCrLf)
        '    Else
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineChecklistRadioOptions' id='inlineCheckListNA' value='3'> NA </label>" & vbCrLf)
        '    End If
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineChecklistRadioOptions' id='inlineCheckListNA' value='3' > NA </label>" & vbCrLf)
        'End If


        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'End of commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Custom Stage</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_CustomStageFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineCustomRadioOptions' title='If Checked User story should go through Custom Stage' data-toggle='tooltip' data-placement='top' id='inlineCustomApplicable' value='1' checked> Applicable </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineCustomRadioOptions' id='inlineCustomApplicable'  title='If Checked User story should go through Custom Stage' data-toggle='tooltip' data-placement='top' value='1'> Applicable </label>" & vbCrLf)
        End If

        strHTML.Append("</div>")

        'strHTML.Append("<div id='DivCustomStage1' class='modal'>")
        'strHTML.Append("<div class='modal-dialog'>")

        'strHTML.Append("<div class='modal-content'>")
        'strHTML.Append("<div class='modal-header'>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div id='DivCustomStage'  class='modal'>")
        'strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If US_ChecklistReviewFlag <> "" Then
            If US_CustomStageFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineCustomRadioOptions' id='inlineCustomNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineCustomRadioOptions' id='inlineCustomNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to User Story.' name='inlineCustomRadioOptions' id='inlineCustomNA' value='3'> NA </label>" & vbCrLf)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div><br>")
        Return strHTML.ToString

    End Function
    Public Function WriteSprint()
        '*******************************************************************************'
        ' Function Name	        :	WriteSprint                                            '
        ' Purpose				:   Plotting Sprint Section                             '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande 
        'Date                   :   22nd Feb 2018'
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()



        Dim NewSprint_IssueFlag As String = Sprint_IssueFlag
        Dim NewSprint_ReviewFlag As String = Sprint_ReviewFlag
        Dim NewSprint_ChecklistReviewFlag As String = Sprint_ChecklistReviewFlag

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>User Story(Done)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If UserStoryDoneFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All User Stories should be completed.' name='inlineUSRadioOptions1' id='inlineUSDone' value='1'  checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All User Stories should be completed.' name='inlineUSRadioOptions1' id='inlineUSDone' value='1' > Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If UserStoryDoneFlag <> "" Then
        '    If UserStoryDoneFlag = "3" Then
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineUSRadioOptions1' id='inlineUSDoneNA' value='3' checked> NA </label>" & vbCrLf)
        '    Else
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineUSRadioOptions1' id='inlineUSDoneNA' value='3'> NA </label>" & vbCrLf)
        '    End If
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineUSRadioOptions1' id='inlineUSDoneNA' value='3' Checked> NA </label>" & vbCrLf)
        'End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Issues</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If NewSprint_IssueFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineSprintIssueRadioOptions' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before completing Sprint.'  id='inlineSprintIssueClose' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineSprintIssueRadioOptions' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before completing Sprint.'  id='inlineSprintIssueClose' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If NewSprint_IssueFlag = "2" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineSprintIssueRadioOptions' data-toggle='tooltip' data-placement='top' title='If Checked All Open Issues will be forwarded to Release.' id='inlineSprintIssueFWD' value='2' checked> Forward </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineSprintIssueRadioOptions' data-toggle='tooltip' data-placement='top' title='If Checked All Open Issues will be forwarded to Release.' id='inlineSprintIssueFWD' value='2'> Forward </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If NewSprint_IssueFlag <> "" Then
            If NewSprint_IssueFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.'name='inlineSprintIssueRadioOptions' id='inlineSprintIssueNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineSprintIssueRadioOptions' id='inlineSprintIssueNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineSprintIssueRadioOptions' id='inlineSprintIssueNA' value='3' Checked> NA </label>" & vbCrLf)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Review</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If NewSprint_ReviewFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Reviews should be closed before completing Sprint.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewClosed' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Reviews should be closed before completing Sprint.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewClosed' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If NewSprint_ReviewFlag = "2" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Reviews will be forwarded to Release.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewFWD' value='2' checked> Forward </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Reviews will be forwarded to Release.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewFWD' value='2'> Forward </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If NewSprint_IssueFlag <> "" Then
            If NewSprint_ReviewFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineSprintReviewRadioOptions' id='inlineSprintReviewNA' value='3' checked> NA </label>" & vbCrLf)
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'strHTML.Append("<div class='row'>" & vbCrLf)
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append("<p>Checklist Review</p>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If Sprint_ChecklistReviewFlag = "1" Then
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Checklist Review should be closed before completing Sprint.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistClosed' value='1' checked> Closed </label>" & vbCrLf)
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Checklist Review should be closed before completing Sprint.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistClosed' value='1'> Closed </label>" & vbCrLf)
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If Sprint_ChecklistReviewFlag = "2" Then
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Open Checklist Reviews will be forwarded to Release.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistFWD' value='2' checked> Forward </label>" & vbCrLf)
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Open Checklist Reviews will be forwarded to Release.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistFWD' value='2'> Forward </label>" & vbCrLf)
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If Sprint_ChecklistReviewFlag = "3" Then
        '    If Sprint_ChecklistReviewFlag <> "" Then
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom'  title='validation is not applicable to Sprint.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistNA' value='3' checked> NA </label>" & vbCrLf)
        '    Else
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom'  title='validation is not applicable to Sprint.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistNA' value='3'> NA </label>" & vbCrLf)
        '    End If
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom'  title='validation is not applicable to Sprint.' name='inlineSprintChecklistRadioOptions' id='inlineSprintChecklistNA' value='3' > NA </label>" & vbCrLf)
        'End If

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Add(User Story)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
        If Add_UserStory = "True" Then
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body'  title='If Checked You can add User Stories  before Sprint completion.' id='inlineSprintADDUS' value='1' checked></label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add User Stories  before Sprint completion.' id='inlineSprintADDUS' value='0'></label>" & vbCrLf)
        End If

        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p style='white-space: nowrap;text-overflow: ellipsis;'>Cancel(User Story)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
        If Cancel_UserStory = "True" Then
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked it will allow to unmap User Stories when Sprint status is ready to Complete.' id='inlineSprintCancelUS' value='1' checked></label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked it will allow to unmap User Stories when Sprint status is ready to Complete.' id='inlineSprintCancelUS' value='0'></label>" & vbCrLf)
        End If
        strHTML.Append("</div>")

        strHTML.Append("</div><br>")
        Return strHTML.ToString

    End Function
    Public Function WriteRelease()
        '*******************************************************************************'
        ' Function Name	        :	WriteRelease                                            '
        ' Purpose				:   Plotting Release Section                             '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande  
        'Date                   :   22nd Feb 2018'
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()

        'strHTML.Append("<div class='row'>" & vbCrLf)
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append("<p>Task</p>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If Cancel_UserStory = "1" Then
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReleaseTaskRadioOptions' id='inlineReleaseTaskClosed' value='1' checked> Closed </label>" & vbCrLf)
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReleaseTaskRadioOptions' id='inlineReleaseTaskClosed' value='1'> Closed </label>" & vbCrLf)
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append("" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReleaseTaskRadioOptions' id='inlineReleaseTaskNA' value='3'> NA </label>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Sprint(Done)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If SprintDoneFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked All Sprints should be completed.' name='inlineReleaseSprintDoneRadioOptions' id='inlineRleaseSprintDone' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked All Sprints should be completed.' name='inlineReleaseSprintDoneRadioOptions' id='inlineRleaseSprintDone' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'Commented By Dipali V On 20th Nov 2020 For GES Issues Fixing
        'If SprintDoneFlag <> "" Then
        '    If SprintDoneFlag = "3" Then
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body'  title='validation is not applicable to Release.' name='inlineReleaseSprintDoneRadioOptions' id='inlineSprintNA' value='3' checked> NA </label>" & vbCrLf)
        '    Else
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body'  title='validation is not applicable to Release.' name='inlineReleaseSprintDoneRadioOptions' id='inlineSprintNA' value='3'> NA </label>" & vbCrLf)
        '    End If
        'Elsen
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='validation is not applicable to Release.' name='inlineReleaseSprintDoneRadioOptions' id='inlineSprintNA' value='3' checked> NA </label>" & vbCrLf)
        'End If
        'End of Commented By Dipali V On 20th Nov 2020 For GES Issues Fixing

        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Issues</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If Release_IssueFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReleaseIssueRadioOptions' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked All Issues should be closed before Release.'  id='inlineReleaseIssuesClosed' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' name='inlineReleaseIssueRadioOptions' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked All Issues should be closed before Release.'  id='inlineReleaseIssuesClosed' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If Release_IssueFlag <> "" Then
            If Release_IssueFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body'  title='validation is not applicable to Release.' name='inlineReleaseIssueRadioOptions' id='inlineReleaseIssuesNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='validation is not applicable to Release.' name='inlineReleaseIssueRadioOptions' id='inlineReleaseIssuesNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body'  title='validation is not applicable to Release.' name='inlineReleaseIssueRadioOptions' id='inlineReleaseIssuesNA' value='3' checked> NA </label>" & vbCrLf)
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Review</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If Release_ReviewFlag = "1" Then
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked All Review should be closed before Release.' name='inlineReleaseReviewRadioOptions' id='inlineReleaseReviewclose' value='1' checked> Closed </label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked All Review should be closed before Release.' name='inlineReleaseReviewRadioOptions' id='inlineReleaseReviewclose' value='1'> Closed </label>" & vbCrLf)
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        If Release_ReviewFlag <> "" Then
            If Release_ReviewFlag = "3" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='validation is not applicable to Release.' name='inlineReleaseReviewRadioOptions' id='inlineReleaseReviewNA' value='3' checked> NA </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='validation is not applicable to Release.' name='inlineReleaseReviewRadioOptions' id='inlineReleaseReviewNA' value='3'> NA </label>" & vbCrLf)
            End If
        Else
            strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' data-container='body' title='validation is not applicable to Release.' name='inlineReleaseReviewRadioOptions' id='inlineReleaseReviewNA' value='3' checked> NA </label>" & vbCrLf)
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'strHTML.Append("<div class='row'>" & vbCrLf)
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append("<p>Checklist Review</p>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If Release_ChecklistReviewFlag = "1" Then
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Review should be closed before Release.' name='inlineReleaseChecklistRadioOptions' id='inlineReleaseChecklistClose' value='1' checked> Closed </label>" & vbCrLf)
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Review should be closed before Release.' name='inlineReleaseChecklistRadioOptions' id='inlineReleaseChecklistClose' value='1'> Closed </label>" & vbCrLf)
        'End If
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'strHTML.Append("" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        'If Release_ChecklistReviewFlag <> "" Then
        '    If Release_ChecklistReviewFlag = "3" Then
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked Review with Checklist is not Mandatory.' name='inlineReleaseChecklistRadioOptions' id='inlineReleaseChecklistNA' value='3' checked> NA </label>" & vbCrLf)
        '    Else
        '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked Review with Checklist is not Mandatory.' name='inlineReleaseChecklistRadioOptions' id='inlineReleaseChecklistNA' value='3'> NA </label>" & vbCrLf)
        '    End If
        'Else
        '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked Review with Checklist is not Mandatory.' name='inlineReleaseChecklistRadioOptions' id='inlineReleaseChecklistNA' value='3' checked> NA </label>" & vbCrLf)
        'End If

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p>Add(Sprint)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
        If Add_Sprint = "True" Then
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body'  title='If Checked Sprints can be mapped to Release even after release is started'  id='inlineRelaseAddUS' value='1' checked></label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body'  title='If Checked  Sprints can be mapped to Release even after release is started'  id='inlineRelaseAddUS' value='0'></label>" & vbCrLf)
        End If
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
        strHTML.Append("<p style='white-space:nowrap'>Terminate(Sprint)</p>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
        If Terminate_Sprint = "True" Then
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox'  data-toggle='tooltip' data-placement='top' data-container='body' title='If Release is Ready to Release , you can cancel Sprint' id='inlineRelaseTerminateUS' value='1' checked></label>" & vbCrLf)
        Else
            strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox'  data-toggle='tooltip' data-placement='top' data-container='body' title='If Release is Ready to Release , you can cancel Sprint' id='inlineRelaseTerminateUS' value='0'></label>" & vbCrLf)
        End If
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function WriteRightSprint(ByVal Flag As String, ByVal IterationID As String, ByVal UserStoryDone As String, ByVal IssuesFlag As String, ByVal ReviewsFlag As String, ByVal ChecklistReviewsFlag As String, ByVal Add_UserStory As String, ByVal Cancel_UserStory As String) ' strHTML.Append(WriteRightSprint(Flag, IterationID, UserStoryDone, IssuesFlag, ReviewsFlag, ChecklistReviewsFlag, Add_UserStory, Cancel_UserStory))
        '*******************************************************************************'
        ' Function Name	        :	WriteSprint                                            '
        ' Purpose				:   Plotting Sprint Section                             '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande 
        'Date                   :   22nd Feb 2018'
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()
        'Dim NewSprint_IssueFlag As String = Sprint_IssueFlag
        'Dim NewSprint_ReviewFlag As String = Sprint_ReviewFlag
        'Dim NewSprint_ChecklistReviewFlag As String = Sprint_ChecklistReviewFlag
        If Flag = "Sprint" Then
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>User Story(Done)</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)

            If UserStoryDone = "1" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All User Stories should be completed.' name='inlineRightUSRadioOptions_" & IterationID & "' id='inlineRightUSDone_" & IterationID & "' value='1'  checked> Closed </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All User Stories should be completed.' name='inlineRightUSRadioOptions_" & IterationID & "' id='inlineRightUSDone_" & IterationID & "' value='1' > Closed </label>" & vbCrLf)

            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'Commented By Dipali V On 20th Nov 2020 For GES Issue Fixing
            'If UserStoryDone <> "" Then
            '    If UserStoryDone = "3" Then
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightUSRadioOptions_" & IterationID & "' id='inlineRightUSDoneNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            '    Else
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightUSRadioOptions_" & IterationID & "'  id='inlineRightUSDoneNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
            '    End If
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightUSRadioOptions_" & IterationID & "'  id='inlineRightUSDoneNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            'End If
            'End of Commented By Dipali V On 20th Nov 2020 For GES Issue Fixing
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Issues</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If IssuesFlag = "1" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before completing Sprint.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueClose_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before completing Sprint.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueClose_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If IssuesFlag = "2" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Issues will be forwarded to Release.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueFWD_" & IterationID & "' value='2' checked> Forward </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Issues will be forwarded to Release.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueFWD_" & IterationID & "' value='2'> Forward </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If IssuesFlag <> "" Then
                If IssuesFlag = "3" Then
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightSprintIssueRadioOptions_" & IterationID & "' id='inlineRightSprintIssueNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Review</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If ReviewsFlag = "1" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Reviews should be closed before completing Sprint.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewClosed_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Reviews should be closed before completing Sprint.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewClosed_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If ReviewsFlag = "2" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Reviews will be forwarded to Release.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewFWD_" & IterationID & "' value='2' checked> Forward </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Open Reviews will be forwarded to Release.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewFWD_" & IterationID & "' value='2'> Forward </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If ReviewsFlag <> "" Then
                If ReviewsFlag = "3" Then
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Sprint.' name='inlineRightSprintReviewRadioOptions_" & IterationID & "' id='inlineRightSprintReviewNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            'commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD
            'strHTML.Append("<div class='row'>" & vbCrLf)
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'strHTML.Append("<p>Checklist Review</p>" & vbCrLf)
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'If ChecklistReviewsFlag = "1" Then
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Checklist Review should be closed before completing Sprint.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "' id='inlineRightSprintChecklistClosed_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Checklist Review should be closed before completing Sprint.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "' id='inlineRightSprintChecklistClosed_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            'End If
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'If ChecklistReviewsFlag = "2" Then
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Open Checklist Reviews will be forwarded to Release.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "' id='inlineRightSprintChecklistFWD_" & IterationID & "' value='2' checked> Forward </label>" & vbCrLf)
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Open Checklist Reviews will be forwarded to Release.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "' id='inlineRightSprintChecklistFWD_" & IterationID & "' value='2'> Forward </label>" & vbCrLf)
            'End If
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'If ChecklistReviewsFlag <> "" Then
            '    If ChecklistReviewsFlag = "3" Then
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom'  title='validation is not applicable to Sprint.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "'  id='inlineRightSprintChecklistNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            '    Else
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom'  title='validation is not applicable to Sprint.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "'  id='inlineRightSprintChecklistNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
            '    End If
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom'  title='validation is not applicable to Sprint.' name='inlineRightSprintChecklistRadioOptions_" & IterationID & "'  id='inlineRightSprintChecklistNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            'End If

            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'End of commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD

            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Add(User Story)</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-6'>" & vbCrLf)
            If Add_UserStory <> "" Then
                If Add_UserStory = "True" Then
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add User Stories  before Sprint completion.' id='inlineRightSprintADDUS_" & IterationID & "' value='1' checked></label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add User Stories  before Sprint completion.' id='inlineRightSprintADDUS_" & IterationID & "' value='0'></label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add User Stories  before Sprint completion.' id='inlineRightSprintADDUS_" & IterationID & "' value='0'></label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p style='white-space: nowrap;text-overflow: ellipsis;'>Cancel(User Story)</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
            If Cancel_UserStory <> "" Then
                If Cancel_UserStory = "True" Then
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked it will allow to unmap User Stories when Sprint status is ready to Complete.' id='inlineRightSprintCancelUS_" & IterationID & "' value='1' checked></label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked it will allow to unmap User Stories when Sprint status is ready to Complete.' id='inlineRightSprintCancelUS_" & IterationID & "' value='0'></label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked it will allow to unmap User Stories when Sprint status is ready to Complete.' id='inlineRightSprintCancelUS_" & IterationID & "' value='0'></label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div><br>")
        Else
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Sprint(Done)</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If UserStoryDone = "1" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Sprints should be completed.' name='RightReleaseSprintDoneRadioOptions_" & IterationID & "' id='inlineRightRleaseSprintDone_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Sprints should be completed.' name='RightReleaseSprintDoneRadioOptions_" & IterationID & "' id='inlineRightRleaseSprintDone_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'Commented & Added By Dipali V On 20th Nov 2020 For GES ISsues Fixing
            'If UserStoryDone <> "" Then
            '    If UserStoryDone = "3" Then
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='RightReleaseSprintDoneRadioOptions_" & IterationID & "' id='inlineRightSprintNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            '    Else
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='RightReleaseSprintDoneRadioOptions_" & IterationID & "' id='inlineRightSprintNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
            '    End If
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='RightReleaseSprintDoneRadioOptions_" & IterationID & "' id='inlineRightSprintNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            'End If
            'End of Commented & Added By Dipali V On 20th Nov 2020 For GES ISsues Fixing
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Issues</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If IssuesFlag = "1" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before Release.' name='inlineRightReleaseIssueRadioOptions_" & IterationID & "' id='inlineRightReleaseIssuesClosed_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Issues should be closed before Release.' name='inlineRightReleaseIssueRadioOptions_" & IterationID & "' id='inlineRightReleaseIssuesClosed_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If IssuesFlag <> "" Then
                If IssuesFlag = "3" Then
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='inlineRightReleaseIssueRadioOptions_" & IterationID & "' id='inlineRightReleaseIssuesNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='inlineRightReleaseIssueRadioOptions_" & IterationID & "' id='inlineRightReleaseIssuesNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='inlineRightReleaseIssueRadioOptions_" & IterationID & "' id='inlineRightReleaseIssuesNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Review</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If ReviewsFlag = "1" Then
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Review should be closed before Release.' name='inlineRightReleaseReviewRadioOptions_" & IterationID & "' id='inlineRightReleaseReviewclose_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top' title='If Checked All Review should be closed before Release.' name='inlineRightReleaseReviewRadioOptions_" & IterationID & "' id='inlineRightReleaseReviewclose_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            If ReviewsFlag <> "" Then
                If ReviewsFlag = "3" Then
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='inlineRightReleaseReviewRadioOptions_" & IterationID & "' id='inlineRightReleaseReviewNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='inlineRightReleaseReviewRadioOptions_" & IterationID & "' id='inlineRightReleaseReviewNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='top'  title='validation is not applicable to Release.' name='inlineRightReleaseReviewRadioOptions_" & IterationID & "' id='inlineRightReleaseReviewNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            'commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD
            'strHTML.Append("<div class='row'>" & vbCrLf)
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'strHTML.Append("<p>Checklist Review</p>" & vbCrLf)
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'If ChecklistReviewsFlag = "1" Then
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Review should be closed before Release.' name='inlineRightReleaseChecklistRadioOptions_" & IterationID & "' id='inlineRightReleaseChecklistClose_" & IterationID & "' value='1' checked> Closed </label>" & vbCrLf)
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked All Review should be closed before Release.' name='inlineRightReleaseChecklistRadioOptions_" & IterationID & "' id='inlineRightReleaseChecklistClose_" & IterationID & "' value='1'> Closed </label>" & vbCrLf)
            'End If
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'strHTML.Append("" & vbCrLf)
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            'If ChecklistReviewsFlag <> "" Then
            '    If ChecklistReviewsFlag = "3" Then
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked Review with Checklist is not Mandatory.' name='inlineRightReleaseChecklistRadioOptions_" & IterationID & "' id='inlineRightReleaseChecklistNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            '    Else
            '        strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked Review with Checklist is not Mandatory.' name='inlineRightReleaseChecklistRadioOptions_" & IterationID & "' id='inlineRightReleaseChecklistNA_" & IterationID & "' value='3'> NA </label>" & vbCrLf)
            '    End If
            'Else
            '    strHTML.Append(" <label class='radio-inline'> <input type='radio' data-toggle='tooltip' data-placement='bottom' title='If Checked Review with Checklist is not Mandatory.' name='inlineRightReleaseChecklistRadioOptions_" & IterationID & "' id='inlineRightReleaseChecklistNA_" & IterationID & "' value='3' checked> NA </label>" & vbCrLf)
            'End If


            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'End of commented By Dipali V On 26th April 2018 Hide Checklist Review of all sections in DOD

            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p>Add(Sprint)</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
            If Add_UserStory <> "" Then
                If Add_UserStory = "True" Then
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add Sprints before Release' id='inlineRightRelaseAddUS_" & IterationID & "' value='1' checked></label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add Sprints before Release' id='inlineRightRelaseAddUS_" & IterationID & "' value='0'></label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body' title='If Checked You can add Sprints before Release' id='inlineRightRelaseAddUS_" & IterationID & "' value='0'></label>" & vbCrLf)
            End If

            strHTML.Append("</div>")

            strHTML.Append("</div>")

            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
            strHTML.Append("<p style='white-space:nowrap'>Terminate(Sprint)</p>" & vbCrLf)
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-9'>" & vbCrLf)
            If Cancel_UserStory <> "" Then
                If Cancel_UserStory = "True" Then
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-container='body' data-placement='top' title='If Release is Ready to Release , you can cancel Sprint' id='inlineRightRelaseTerminateUS_" & IterationID & "' value='1' checked></label>" & vbCrLf)
                Else
                    strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-container='body' data-placement='top' title='If Release is Ready to Release , you can cancel Sprint' id='inlineRightRelaseTerminateUS_" & IterationID & "' value='0'></label>" & vbCrLf)
                End If
            Else
                strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' data-toggle='tooltip' data-placement='top' data-container='body'  title='If Release is Ready to Release , you can cancel Sprint' id='inlineRightRelaseTerminateUS_" & IterationID & "' value='0'></label>" & vbCrLf)
            End If



            strHTML.Append("</div>")

            strHTML.Append("</div>")

        End If

        Return strHTML.ToString

    End Function
    Public Function RightSection(ByVal Flag As String, ByVal Mode As String)
        '*******************************************************************************'
        ' Function Name	        :	DefinitionOfDone                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   22nd Feb 2018
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()
        Dim IterationID As String
        Dim IterationName As String
        Dim Duration As String
        Dim CreatedBy As String
        Dim StoryPoint As String
        Dim UserStoryDone As String
        Dim IssuesFlag As String
        Dim ReviewsFlag As String
        Dim ChecklistReviewsFlag As String
        Dim Add_UserStory As String
        Dim Cancel_UserStory As String
        Dim Terminate_Sprint As String
        Dim ISData As String = "0"
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-8'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        GetAccessRights()
        strHTML.Append("<div class='col-sm-4'>" & vbCrLf)
        If Mode <> "AfterSaveSubtabRefresh" Then
            If Flag = "Sprint" Then
                If m_objAccess.Add Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick=AddSprintRelease('Sprint') title='Add'><i class='fa fa-plus'></i>  Add</button>" & vbCrLf)
                    Else

                    End If
                End If

                If m_objAccess.Edit Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick=SaveSprintRelease('Sprint') title='Save'><i class='fa fa-floppy-o' aria-hidden='true'></i>  Save</button>" & vbCrLf)
                    Else

                    End If
                End If

            Else
                If m_objAccess.Add Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick=AddSprintRelease('Release') title='Add'><i class='fa fa-plus'></i>  Add</button>" & vbCrLf)
                    Else

                    End If
                End If
                If m_objAccess.Edit Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick=SaveSprintRelease('Release') title='Save'><i class='fa fa-floppy-o' aria-hidden='true'></i>  Save</button>" & vbCrLf)
                    Else

                    End If
                End If

            End If
        Else
            If Flag = "Release" Then
                If m_objAccess.Add Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick=AddSprintRelease('Release') title='Add'><i class='fa fa-plus'></i>  Add</button>" & vbCrLf)
                    Else

                    End If
                End If
                If m_objAccess.Edit Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-primary' data-toggle='tooltip' data-placement='top' onclick=SaveSprintRelease('Release') title='Save'><i class='fa fa-floppy-o' aria-hidden='true'></i>  Save</button>" & vbCrLf)
                    Else

                    End If
                End If
                ' strHTML.Append("<button type='button' class='btn btn-primary' onclick=AddSprintRelease('Release') title='Add'><i class='fa fa-plus'></i>  Add</button>" & vbCrLf)
                'strHTML.Append("<button type='button' class='btn btn-primary' onclick=SaveSprintRelease('Release') title='Save'><i class='fa fa-floppy-o' aria-hidden='true'></i>  Save</button>" & vbCrLf)
            End If
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div><br>")
        If Mode <> "AfterSaveSubtabRefresh" Then
            strHTML.Append("<div id='DivSubtabWholedata'>")
        End If

        Dim dt1 As New DataTable
        Dim strSQL As String = ""
        strSQL = "usp_sel_tbl_NG2_EntityWise_DOD " & Session("intProjectID") & ",'" & Flag & "',1"
        'dt1 = CommonFunctions.Data.GetDataTable(Strsql, True)
        ' Dim CountOfRows As Integer = dt1.Rows.Count

        'strHTML.Append("<input type='hidden' value='" & CountOfRows & "' id='hdnIterationID' />")
        If Flag = "Sprint" Then
            Dim drTabData As IDataReader

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
            While drTabData.Read
                ISData = "1"
                IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationName"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drTabData("Duration"), "")
                CreatedBy = CommonFunctions.Data.CheckIsDBNull(drTabData("CreatedBy"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drTabData("StoryPoint"), "")
                UserStoryDone = CommonFunctions.Data.CheckIsDBNull(drTabData("UserStoryDone"), "")
                IssuesFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("IssuesFlag"), "")
                ReviewsFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("ReviewsFlag"), "")
                ChecklistReviewsFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("ChecklistReviewsFlag"), "")
                Add_UserStory = CommonFunctions.Data.CheckIsDBNull(drTabData("Add_UserStory"), "")
                'Add_UserStory = CommonFunctions.Data.CheckIsDBNull(drTabData("Add_UserStory"), "")
                Cancel_UserStory = CommonFunctions.Data.CheckIsDBNull(drTabData("Cancel_UserStory"), "")

                strHTML.Append("<div class='card' id='Card_" & IterationID & "'>" & vbCrLf)
                strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' />")
                strHTML.Append("<div class='card-header'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
                strHTML.Append("<p style=' color:#428cf4!important;  font-size: 13px;font-weight: 700;' ><span data-toggle='tooltip' title='Sprint Name'>" & IterationName & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='card-block'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-2' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
                strHTML.Append("<p title='Created By'><span data-toggle='tooltip' title='Created By'><i class='fa fa-user' aria-hidden='true'></i>&nbsp " & CreatedBy & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
                strHTML.Append("<p title='Duration' style='white-space: nowrap;'><span data-toggle='tooltip' title='Duration'><i class='fa fa-calendar' aria-hidden='true'></i>&nbsp;" & Duration & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-2'>" & vbCrLf)
                If StoryPoint <> "" Then
                    strHTML.Append("<p title='Story Point'><span data-toggle='tooltip' title='Story Point'><i class='fa fa-database' aria-hidden='true'></i>&nbsp;" & StoryPoint & "Pts<span></p>" & vbCrLf)
                Else

                    strHTML.Append("<p title='Story Point'><span data-toggle='tooltip' title='Story Point'><i class='fa fa-database' aria-hidden='true'></i>&nbsp; Not Specified <span></p>" & vbCrLf)

                End If
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-6'style='color: #428cf4!important;'>" & vbCrLf)
                'added by ashwini on 21-3-2023 for data-bs-toggle
                strHTML.Append("<i title='Details' class='fa fa-chevron-down' aria-hidden='true' data-bs-toggle='collapse' href='#collapseExample_" & IterationID & "' aria-expanded='false' aria-controls='collapseExample' onclick=ShowArrow('" & IterationID & "') id='IdArrow_" & IterationID & "'></i>" & vbCrLf) '<i class='fa fa-cog' aria-hidden='true'></i> 
                'End Of added by ashwini On 21-3-2023 for data-bs-toggle
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='card-block collapse' id='collapseExample_" & IterationID & "'>" & vbCrLf)
                strHTML.Append(WriteRightSprint(Flag, IterationID, UserStoryDone, IssuesFlag, ReviewsFlag, ChecklistReviewsFlag, Add_UserStory, Cancel_UserStory))
                strHTML.Append("</div>")
                strHTML.Append("</div><br>")
            End While
            If ISData = "1" Then

            Else
                strHTML.Append("<table class='clstable' style='text-align:center'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                strHTML.Append("There are no Sprints to show in this view.")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
            End If

        Else

            Dim drTabData As IDataReader
            'Dim strSQL As String = ""
            strSQL = "usp_sel_tbl_NG2_EntityWise_DOD " & Session("intProjectID") & "," & Flag & ",1"
            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
            While drTabData.Read
                ISData = "1"
                IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseName"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drTabData("Duration"), "")
                CreatedBy = CommonFunctions.Data.CheckIsDBNull(drTabData("CreatedBy"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drTabData("StoryPoint"), "")
                UserStoryDone = CommonFunctions.Data.CheckIsDBNull(drTabData("SprintDone"), "")
                IssuesFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("IssuesFlag"), "")
                ReviewsFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("ReviewsFlag"), "")
                ChecklistReviewsFlag = CommonFunctions.Data.CheckIsDBNull(drTabData("ChecklistReviewsFlag"), "")
                Add_UserStory = CommonFunctions.Data.CheckIsDBNull(drTabData("Add_Sprint"), "")
                Terminate_Sprint = CommonFunctions.Data.CheckIsDBNull(drTabData("Terminate_Sprint"), "")
                strHTML.Append("<div class='card' id='Card_" & IterationID & "'>" & vbCrLf)
                strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnReleaseID' />")
                strHTML.Append("<div class='card-header'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
                strHTML.Append("<p style=' color:#428cf4!important;  font-size: 13px;font-weight: 700;' ><span data-toggle='tooltip' title='Release Name' data-placement='bottom' data-container='body'>" & IterationName & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='card-block'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-2' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
                strHTML.Append("<p title='Created By' data-toggle='tooltip'  data-placement='bottom' data-container='body'><span ><i class='fa fa-user' aria-hidden='true'></i>&nbsp " & CreatedBy & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-3'>" & vbCrLf)
                strHTML.Append("<p title='Duration' style='white-space: nowrap;' data-toggle='tooltip'  data-placement='bottom' data-container='body'><span><i class='fa fa-calendar' aria-hidden='true'></i>&nbsp;" & Duration & " </span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-2'>" & vbCrLf)
                If StoryPoint <> "" Then
                    strHTML.Append("<p title='Story Point' data-toggle='tooltip'  data-placement='bottom' data-container='body'><span><i class='fa fa-database' aria-hidden='true'></i>&nbsp;" & StoryPoint & "Pts</span></p>" & vbCrLf)
                Else

                    strHTML.Append("<p title='Story Point' data-toggle='tooltip'  data-placement='bottom' data-container='body'><span><i class='fa fa-database' aria-hidden='true'></i>&nbsp; Not Specified <span></p>" & vbCrLf)


                End If
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-6'style='color: #428cf4!important;'>" & vbCrLf)
                'added by ashwini on 21-3-2023 for data-bs-toggle
                strHTML.Append("<i title='Details' class='fa fa-chevron-down' aria-hidden='true' data-bs-toggle='collapse' href='#collapseExample_" & IterationID & "' value='" & IterationID & "' aria-expanded='false' aria-controls='collapseExample' onclick=ShowArrow('" & IterationID & "') id='IdArrow_" & IterationID & "' ></i>" & vbCrLf) '<i class='fa fa-cog' aria-hidden='true'></i> 
                'End Of added by ashwini On 21-3-2023 for data-bs-toggle
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='card-block collapse' id='collapseExample_" & IterationID & "'>" & vbCrLf)
                strHTML.Append(WriteRightSprint(Flag, IterationID, UserStoryDone, IssuesFlag, ReviewsFlag, ChecklistReviewsFlag, Add_UserStory, Terminate_Sprint))
                strHTML.Append("</div>")
                strHTML.Append("</div><br>")
            End While
            If ISData = "1" Then

            Else
                strHTML.Append("<table class='clstable' style='text-align:center'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                strHTML.Append("There are no Release to show in this view.")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
            End If
        End If
        If Mode <> "AfterSaveSubtabRefresh" Then
            strHTML.Append("</div>")
        End If
        Return strHTML.ToString()

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function PlotSubtab(ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubtab
        ' Purpose               : 
        ' Description           : To Plot SubTab Section Like Release & Sprint
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :22nd Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmDefinationOfDone As New frmDefinationOfDone()
            strGridHTML.Append(objfrmDefinationOfDone.RightSection(Flag, ""))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function SaveUSSprintReleaseData(ByVal ProjectID As String, ByVal txtDescription As String, ByVal USTask As String, ByVal USIssue As String, ByVal USReview As String, ByVal USCheckReview As String, ByVal USCustom As String, ByVal sprintIssue As String, ByVal SprintReview As String, ByVal SprintChecklist As String, ByVal SprintADDUS As String, ByVal SprintCancelUS As String, ByVal ReleaseIssues As String, ByVal ReleaseReview As String, ByVal ReleaseChecklist As String, ByVal RelaseAddUS As String, ByVal RelaseTerminateUS As String, ByVal USDONE As String, ByVal sprintDone As String, ByVal Mode As String) As String 'USDONE: USDONE, sprintDone: sprintDone
        '=====================================================================
        ' Procedure Name        : SaveData
        ' Purpose               : 
        ' Description           : To Save DAta
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :22nd Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim insertSuccess As Integer = 0
            Dim strUniqueID As Integer = 0
            'If txtDescription = "" Then
            '    txtDescription = "NULL"
            'End If
            Try
                Dim strQuery As String = "usp_INS_tbl_NG2_DefinitionOfDone " & HttpContext.Current.Session("intProjectID") & ",'UserStory','" & Trim(Replace(txtDescription, "'", "''")) & "'," & USTask & "," & USIssue & "," & USReview & "," & USCheckReview & "," & USCustom & ",NULL ,NULL ,NULL ,NULL,NULL,NULL,'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                Dim strQuerySprint As String = "usp_INS_tbl_NG2_DefinitionOfDone " & HttpContext.Current.Session("intProjectID") & ",'Sprint','" & Trim(Replace(txtDescription, "'", "''")) & "',NULL," & sprintIssue & "," & SprintReview & "," & SprintChecklist & ",NULL," & USDONE & "," & SprintADDUS & "," & SprintCancelUS & ",NULL ,NULL ,NULL ,'" & HttpContext.Current.Session("strUserName") & "'"

                CommonFunctions.Data.InsertOrUpdateData(strQuerySprint, True)


                Dim strQueryRelease As String = "usp_INS_tbl_NG2_DefinitionOfDone " & HttpContext.Current.Session("intProjectID") & ",'Release','" & Trim(Replace(txtDescription, "'", "''")) & "',NULL," & ReleaseIssues & "," & ReleaseReview & "," & ReleaseChecklist & ",NULL ,NULL ,NULL ,NULL," & sprintDone & "," & RelaseAddUS & "," & RelaseTerminateUS & ",'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQueryRelease, True)

            Catch ex As Exception

            End Try


            Dim objfrmDefinationOfDone As New frmDefinationOfDone()
            strGridHTML.Append(objfrmDefinationOfDone.DefinitionOfDone(Mode))

            'strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)

            Return 1 & "|" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function SaveTabData(ByVal UniqueID As String, ByVal ProjectID As String, ByVal RightUSDOne As String, ByVal RightSprintIssue As String, ByVal RightSprintReview As String, ByVal RightSprintChecklist As String, ByVal RightSprintAdd As String, ByVal RightSprintCancel As String, ByVal Mode As String, ByVal Flag As String) As String 'USDONE: USDONE, sprintDone: sprintDone
        '=====================================================================
        ' Procedure Name        : SaveTabData
        ' Purpose               : 
        ' Description           : To SubTab Data
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :23rd Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim insertSuccess As Integer = 0
            Dim strUniqueID As Integer = 0

            If Flag = "Sprint" Then
                Dim strQuery As String = "usp_INS_tbl_NG2_EntityWise_DOD " & HttpContext.Current.Session("intProjectID") & "," & UniqueID & ",'" & Flag & "'," & RightUSDOne & "," & RightSprintIssue & "," & RightSprintReview & "," & RightSprintChecklist & "," & RightSprintAdd & "," & RightSprintCancel & ",Null,null,null,'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            Else
                Dim strQuery As String = "usp_INS_tbl_NG2_EntityWise_DOD " & HttpContext.Current.Session("intProjectID") & "," & UniqueID & ",'" & Flag & "',Null," & RightSprintIssue & "," & RightSprintReview & "," & RightSprintChecklist & ",null,null," & RightUSDOne & "," & RightSprintAdd & "," & RightSprintCancel & ",'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            End If

            Return 1
        Catch ex As Exception
            Return "Bad Request found"
        End Try

        'strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)


    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function AddReleaseSprint(ByVal Flag As String, ByVal ProjectID As String) As String
        '=====================================================================
        ' Procedure Name        : AddReleaseSprint
        ' Purpose               : 
        ' Description           : To Plot Add Release/Sprint 
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :26th Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmDefinationOfDone As New frmDefinationOfDone()
            'strGridHTML.Append(objfrmDefinationOfDone.WriteGrid(Flag))
            strGridHTML.Append(objfrmDefinationOfDone.AddReleaseSprint(Flag))
            Return strGridHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Function AddReleaseSprint(ByVal Flag As String)
        '*******************************************************************************'
        ' Function Name	        :	DefinitionOfDone                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   22nd Feb 2018
        '*******************************************************************************'

        Dim strHTML As New StringBuilder()
        Dim IterationID As String
        Dim IterationName As String
        Dim Duration As String
        Dim CreatedBy As String
        Dim StoryPoint As String
        Dim UserStoryDone As String
        Dim IssuesFlag As String
        Dim ReviewsFlag As String
        Dim ChecklistReviewsFlag As String
        Dim Add_UserStory As String
        Dim Cancel_UserStory As String
        Dim Terminate_Sprint As String
        Dim IsData As Integer = 0
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-8'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4'>" & vbCrLf)


        strHTML.Append("</div>")
        strHTML.Append("</div><br>")


        Dim dt1 As New DataTable
        Dim strSQL As String = ""
        strSQL = "usp_sel_tbl_NG2_EntityWise_DOD " & HttpContext.Current.Session("intProjectID") & "," & Flag & ",2"
        dt1 = CommonFunctions.Data.GetDataTable(strSQL, True)
        Dim CountOfRows As Integer = dt1.Rows.Count

        'strHTML.Append("<input type='hidden' value='" & CountOfRows & "' id='hdnIterationID' />")

        If Flag = "Sprint" Then
            Dim drTabData As IDataReader

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
            While drTabData.Read
                IsData = 1
                IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationName"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drTabData("Duration"), "")
                CreatedBy = CommonFunctions.Data.CheckIsDBNull(drTabData("CreatedBy"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drTabData("StoryPoint"), "")

                strHTML.Append("<table class='clstable'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td style='width:5%'>")
                strHTML.Append("<div class='NewCard' >" & vbCrLf)
                strHTML.Append(" <label class='checkbox-inline'><input  type='checkbox' id='NewAddSprint_" & IterationID & "'  name ='chkAddSprintSelectList' value=" & IterationID & " title='Select' data-toggle='tooltip'></label>" & vbCrLf)
                strHTML.Append("</div><br>")

                strHTML.Append("</td>")
                strHTML.Append("<td style='width:95%'>")
                strHTML.Append("<div class='card' id='Card_" & IterationID & "'>" & vbCrLf)
                'strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' />")
                strHTML.Append("<div class='card-header'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
                strHTML.Append("<p style=' color:#428cf4!important;  font-size: 13px;font-weight: 700;' ><span data-toggle='tooltip' title='Sprint Name'>" & IterationName & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='card-block'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-4' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
                strHTML.Append("<p title='Created By'><span data-toggle='tooltip' title='Created By'><i class='fa fa-user' aria-hidden='true'></i>&nbsp " & CreatedBy & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>" & vbCrLf)
                strHTML.Append("<p title='Duration' style='white-space: nowrap;'><span data-toggle='tooltip' title='Duration'><i class='fa fa-calendar' aria-hidden='true'></i>&nbsp;" & Duration & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>" & vbCrLf)
                If StoryPoint = "" Then

                    strHTML.Append("<p title='Story Point'><span data-toggle='tooltip' title='Story Point'><i class='fa fa-database' aria-hidden='true'></i>&nbsp;Not Specified</span></p>" & vbCrLf)
                Else

                    strHTML.Append("<p ><span data-toggle='tooltip' title='Story Point'><i class='fa fa-database' aria-hidden='true'></i>&nbsp;" & StoryPoint & " Pts</span></p>" & vbCrLf)
                End If
                strHTML.Append("</div>")
                'strHTML.Append("<div class='col-sm-6'style='color: #428cf4!important;'>" & vbCrLf)
                'strHTML.Append(" <i class='fa fa-cog' aria-hidden='true'></i> <i class='fa fa-chevron-down' aria-hidden='true' data-bs-toggle='collapse' href='#collapseExample_" & IterationID & "' aria-expanded='false' aria-controls='collapseExample'></i>" & vbCrLf)
                'strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                'strHTML.Append("<div class='card-block collapse' id='collapseExample_" & IterationID & "'>" & vbCrLf)
                'strHTML.Append(WriteRightSprint(Flag, IterationID, UserStoryDone, IssuesFlag, ReviewsFlag, ChecklistReviewsFlag, Add_UserStory, Cancel_UserStory))
                'strHTML.Append("</div>")
                strHTML.Append("</div><br>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")


            End While
            If IsData = 1 Then

            Else
                strHTML.Append("<table class='clstable' style='text-align:center'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                strHTML.Append("There are no Sprints to show in this view.")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
            End If

        Else



            Dim drTabData As IDataReader
            'Dim strSQL As String = ""
            strSQL = "usp_sel_tbl_NG2_EntityWise_DOD " & HttpContext.Current.Session("intProjectID") & "," & Flag & ",2"
            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
            While drTabData.Read
                IsData = 1
                IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseName"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drTabData("Duration"), "")
                CreatedBy = CommonFunctions.Data.CheckIsDBNull(drTabData("CreatedBy"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drTabData("StoryPoint"), "")

                strHTML.Append("<table class='clstable'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td style='width:5%'>")
                strHTML.Append("<div class='NewCard' >" & vbCrLf)
                strHTML.Append(" <label class='checkbox-inline'> <input  type='checkbox' id='NewAddRelease_" & IterationID & "' name ='chkAddSelectReleaseList' value=" & IterationID & " title='Select' data-toggle='tooltip' ></label>" & vbCrLf)
                strHTML.Append("</div><br>")
                strHTML.Append("</td>")

                strHTML.Append("<td style='width:95%'>")
                strHTML.Append("<div class='card' id='Card_" & IterationID & "'>" & vbCrLf)
                'strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnReleaseID' />")
                strHTML.Append("<div class='card-header'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
                strHTML.Append("<p style=' color:#428cf4!important;  font-size: 13px;font-weight: 700;' ><span data-toggle='tooltip' title='Release Name'>" & IterationName & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='card-block'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-4' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
                strHTML.Append("<p ><span data-toggle='tooltip' title='Created By'><i class='fa fa-user' aria-hidden='true'></i>&nbsp " & CreatedBy & "</span></p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>" & vbCrLf)
                strHTML.Append("<p title='' style='white-space: nowrap;'><span data-toggle='tooltip' title='Duration'><i class='fa fa-calendar' aria-hidden='true'></i>&nbsp;" & Duration & "</span> </p>" & vbCrLf)
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>" & vbCrLf)
                If StoryPoint = "" Then

                    strHTML.Append("<p title='Story Point'><span data-toggle='tooltip' title='Story Point'><i class='fa fa-database' aria-hidden='true'></i>&nbsp;Not Specified</span></p>" & vbCrLf)
                Else

                    strHTML.Append("<p ><span data-toggle='tooltip' title='Story Point'><i class='fa fa-database' aria-hidden='true'></i>&nbsp;" & StoryPoint & "Pts</span></p>" & vbCrLf)
                End If

                strHTML.Append("</div>")
                'strHTML.Append("<div class='col-sm-6'style='color: #428cf4!important;'>" & vbCrLf)
                ' strHTML.Append(" <i class='fa fa-cog' aria-hidden='true'></i> <i class='fa fa-chevron-down' aria-hidden='true' data-bs-toggle='collapse' href='#collapseExample_" & IterationID & "' value='" & IterationID & "' aria-expanded='false' aria-controls='collapseExample' onclick='getdata('" & IterationID & "')' ></i>" & vbCrLf)
                'strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                'strHTML.Append("<div class='card-block collapse' id='collapseExample_" & IterationID & "'>" & vbCrLf)
                'strHTML.Append(WriteRightSprint(Flag, IterationID, UserStoryDone, IssuesFlag, ReviewsFlag, ChecklistReviewsFlag, Add_UserStory, Terminate_Sprint))
                'strHTML.Append("</div>")
                strHTML.Append("</div><br>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")

            End While
            If IsData = 1 Then

            Else
                strHTML.Append("<table class='clstable' style='text-align:center'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td >")
                strHTML.Append("There are no Releases to show in this view.")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
            End If
        End If

        Return IsData & "||" & strHTML.ToString()


    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function ShowHistoryDetails(ByVal UniqueID As String) As String
        '=====================================================================
        ' Procedure Name        : ShowHistoryDetails
        ' Purpose               : 
        ' Description           : To Plot ShowHistory Details
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :23rd Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmDefinationOfDone As New frmDefinationOfDone()
            strGridHTML.Append(objfrmDefinationOfDone.WriteGrid(UniqueID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Private Function WriteGrid(ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : WriteMasterGrid()	
        ' Purpose               : To Plot the Grids
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 23rd Feb -2018
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        intNoOfDataColumn = 7
        strDivID = "DivGridShowHistory"
        strSQLQuery = "usp_sel_tbl_NG2_DefinitionOfDone_History " & HttpContext.Current.Session("intProjectID") & ""
        arrstrActualList = {"EntityType", "EntityName", "FieldName", "OldValue", "NewValue", "ModifiedBy", "ModifiedDate"}
        arrstrUserFriendlyList = {"Entity Type", "Entity Name", "Modified Field", "Old Value", "New Value", "Modified By", "Modified Date"}
        arrstrLinkArray = {"", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With
        objGrid = Nothing
        'End If
        Return strGridHTML.ToString


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetData()
        '=====================================================================
        ' Procedure Name        : WebMethod()	
        ' Purpose               : To Plot the Custom Stages
        ' Description           : To Get Custom Stages
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 26th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Try
            Dim ProjectID As String = HttpContext.Current.Session("intProjectID")
            ' ProjectID = 91
            Dim strSql As String = "usp_sel_tbl_NG2_ScrumStages " & HttpContext.Current.Session("intProjectID") & ""
            Dim dt As New DataTable
            dt = CommonFunctions.Data.GetDataTable(strSql, True)
            Dim strResult As String
            For i As Integer = 0 To dt.Rows.Count - 1
                strResult = dt.Rows(i)("StageID") & "||" & dt.Rows(i)("StageName") & "||" & dt.Rows(i)("OrderNo") & "||" & dt.Rows(i)("IsCustom") & "||" & dt.Rows(i)("CustomStageCount") & "||" & dt.Rows(i)("Color")
            Next
            Return strResult & "||" & GetStages(ProjectID)

        Catch ex As Exception
            Return "Bad Request found"
        End Try
        '& "||" & GetStages(strWorkflowID)
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetStages(ByVal strWorkFlowID As String)
        '=====================================================================
        ' Procedure Name        : WebMethod()	
        ' Purpose               : To Plot the Custom Stages
        ' Description           : To Get Custom Stages
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 26th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Try
            Dim ProjectID As String = HttpContext.Current.Session("intProjectID")
            ' ProjectID = 91
            Dim strSql As String = "usp_sel_tbl_NG2_ScrumStages " & HttpContext.Current.Session("intProjectID")
            Dim dt As New DataTable
            dt = CommonFunctions.Data.GetDataTable(strSql, True)
            Dim strResult As String = GetSerialized(dt)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String

        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveData(ByVal StageID As String, ByVal OrderNumber As String, ByVal StageName As String)
        '=====================================================================
        ' Procedure Name        : WebMethod()	
        ' Purpose               : To Save Custom Stages
        ' Description           : To Save Custom Stages
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 26th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Try


            Dim ProjectID As String = HttpContext.Current.Session("intProjectID")
            ' ProjectID = 91
            Dim strSql As String = "usp_INS_tbl_NG2_ScrumStages " & HttpContext.Current.Session("intProjectID") & ",'" & StageName.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & OrderNumber.Replace("'", "''") & "',null"
            CommonFunctions.Data.InsertOrUpdateData(strSql, True)

            Dim dt As New DataTable
            dt = CommonFunctions.Data.GetDataTable("usp_sel_tbl_NG2_ScrumStages " & HttpContext.Current.Session("intProjectID"), True)

            Dim strResult As String = GetSerialized(dt)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDuplicate(ByVal ProjectID As String, ByVal OrderNo As String, ByVal strStageName As String)
        '=====================================================================
        ' Procedure Name        : CheckDuplicate
        ' Purpose               : To  CheckDuplicate
        ' Description           : To CheckDuplicate
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 26th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Try
            Dim strSql As String = "usp_Sel_tbl_NG2_Chk_tbl_ProjectStagename_StageOrderno " & ProjectID & ",'" & OrderNo.Replace("'", "''") & "','" & strStageName.Replace("'", "''") & "'"
            Dim strResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, True), "")
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckOrderNo(ByVal ProjectID As String, ByVal OrderNo As String)
        '=====================================================================
        ' Procedure Name        : WebMethod()	
        ' Purpose               : To check OrderNo
        ' Description           : To check OrderNo
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 26th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Try
            Dim strSql As String = "usp_Sel_tbl_NG2_chk_CustomStageOrderNo " & ProjectID & "," & OrderNo & ""
            Dim strResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, True), "")
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddExitingSprintRelease(ByVal StrselectedIDs As String, ByVal selectedFlag As String, ByVal ProjectID As String)
        '=====================================================================
        ' Procedure Name        : AddExitingSprintRelease()	
        ' Purpose               : To Add Exiting Sprint / Release
        ' Description           : To Add Exiting Sprint / Release
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 27th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Dim strSQL As String = ""
        Dim strGridHTML As New StringBuilder("")
        Dim arrStrselectedIDs() As String
        Dim index As Integer = 0
        Dim Flag As String = "0"
        arrStrselectedIDs = StrselectedIDs.Split(",")
        Try

            For index = 0 To arrStrselectedIDs.Length - 1
                If selectedFlag = "Sprint" Then
                    Dim strQuery As String = "usp_INS_tbl_NG2_EntityWise_DOD " & ProjectID & "," & arrStrselectedIDs(index) & ",'" & selectedFlag & "',3,3,3,3,0,0,NULL,NULL,NULL,'" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                Else
                    Dim strQuery As String = "usp_INS_tbl_NG2_EntityWise_DOD " & ProjectID & "," & arrStrselectedIDs(index) & ",'" & selectedFlag & "',NULL,3,3,3,NULL,NULL,3,0,0,'" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                End If
                Flag = 1
            Next

            Dim objfrmDefinationOfDone As New frmDefinationOfDone()
            strGridHTML.Append(objfrmDefinationOfDone.RightSection(selectedFlag, "AfterSaveSubtabRefresh"))

            Return Flag & "|" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCustomStages(ByVal stagID As String, ByVal ProjectID As String)
        '=====================================================================
        ' Procedure Name        : DeleteCustomStages()	
        ' Purpose               : To Deleted UnMapped CustomStages
        ' Description           : To Deleted UnMapped CustomStages
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 27th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Dim strSQL As String = ""
        Dim strGridHTML As New StringBuilder("")
        Dim Flag As String = "0"

        Try
            Dim strQuery As String = "USP_NG2_Del_UnmappedCustomStages " & stagID & ""
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            Flag = 1
            Return Flag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
        ' Dim objfrmDefinationOfDone As New frmDefinationOfDone()
        'strGridHTML.Append(objfrmDefinationOfDone.RightSection(selectedFlag, "AfterSaveSubtabRefresh"))


    End Function
End Class
